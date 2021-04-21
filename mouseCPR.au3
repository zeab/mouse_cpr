#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=ico\mouseCPR.ico
#AutoIt3Wrapper_Res_Fileversion=0.0.1.1
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <GuiComboBox.au3>

$progStarted = 0

Local $intervalTimeInt

Local $startTime
Local $remainingTime
Local $a = 1
;make a GUI here to actually start stuff

interface()


Func interface()

	Local $msg
	;Local $buttonStop = 456

	;create the GUI window itself
	$GUI = GUICreate("Mouse CPR", 250, 140)

	;this sets the icon in the corner to the teavana icon NEED TO CHANGE THIS AFTER THE I INSTALL THE FILES!! or just copy and paste as well as the one below
	;GUISetIcon("C:\My folder\Autoit Stuff\Tools\Mouse CPR\ico\mouseCPR.ico")
	GUISetIcon(@ScriptDir &  "\ico\mouseCPR.ico")
	;this creates the picutre at the top of GUI
	;GUICtrlCreatePic("C:\autoitScripts\TeavanaGlobalInstaller\Include\logo\teavanaLogo.jpg", 50, 0)
	;GUICtrlCreatePic(@ScriptDir & "\Logo\teavanaLogo.jpg", 50, 0)


	;creates the welcome to teavana's installer lable
	GUISetFont(8.5, 800, 4) ;sets the font to bold and underlined
	$welcomeLable = GUICtrlCreateLabel("Mouse CPR", 10, 10)

	;creates the total time lable (this is the total time the program will run)
	GUISetFont(8.5, 400, 0) ;sets the font to bold and underlined
	$totalTimeStartLable = GUICtrlCreateLabel("Total Time: ", 10, 35)

    GUISetFont(8.5, 400, 0) ; keeps the font normal and removed the underline
	$comboBoxTotalTime = GUICtrlCreateCombo("60 min", 80,32, 80, 100, $CBS_DROPDOWNLIST )
    GUICtrlSetData(-1, "50 min|40 min|30 min|Unlimited", "60 min")


	;creates the total time lable (this is the total time the program will run)
	GUISetFont(8.5, 400, 0) ;sets the font to bold and underlined
	$intervalTimeStartLable = GUICtrlCreateLabel("Interval Time: ", 10, 65)

    GUISetFont(8.5, 400, 0) ; keeps the font normal and removed the underline
	$comboBoxIntervalTime = GUICtrlCreateCombo("2 min", 80,62, 80, 100, $CBS_DROPDOWNLIST )
    GUICtrlSetData(-1, "5 min|10 min|15 min|20 min|25 min", "2 min")

	;Create the start button
	GUISetFont(8.5, 400, 0)
    $buttonStart = GUICtrlCreateButton("Start", 120, 100, 100)


	;set the version number in the bottom cornor
	GUISetFont(6, 400, 0)
	GUICtrlCreateLabel(@ScriptName, 10, 125)




   ;HIDDEN BUTTONS


			   GUISetFont(8.5, 400, 0) ;sets the font to bold and underlined
			   $totalTimeRemainingLable = GUICtrlCreateLabel("Time Remaining:" , 10, 35)
			   GUICtrlSetState(-1, $GUI_HIDE)

			   GUISetFont(8.5, 400, 0) ;sets the font to bold and underlined
			   $totalTimeLable = GUICtrlCreateLabel("Started" , 110, 35, 80)
			   GUICtrlSetState(-1, $GUI_HIDE)

			   GUISetFont(8.5, 400, 0) ;sets the font to bold and underlined
			   $intervalTimeRemainingLable = GUICtrlCreateLabel("Interval Remaining:" , 10, 55)
			   GUICtrlSetState(-1, $GUI_HIDE)

			   GUISetFont(8.5, 400, 0) ;sets the font to bold and underlined
			   $intervalTimeLable = GUICtrlCreateLabel("Started" , 110, 55, 80)
			   GUICtrlSetState(-1, $GUI_HIDE)

			   	;Create the reset button
			   ;GUISetFont(8.5, 400, 0)
			   ;$buttonStop = GUICtrlCreateButton("Stop", 20, 90, 100)
			   ;GUICtrlSetState(-1, $GUI_HIDE)

			   	;Create the reset button
			   GUISetFont(8.5, 400, 0)
			   $buttonReset = GUICtrlCreateButton("Reset", 125, 90, 100)
			   GUICtrlSetState(-1, $GUI_HIDE)



	;this actually set the GUI window as visiable so this should be the last thing after createing all the GUI componets
    GUISetState()

   	while 1

		Local $msg = GUIGetMsg()



		select

			Case ($msg = $GUI_EVENT_CLOSE) ; on event that the GUI window is closed everything stops

			   ;Exits out of the GUI
				Exit


			Case ($msg = $buttonStart)

			   ;this just starts the inital timers to track the total time of how long the program has been running
			  $startTime = TimerInit()
			  $intervalTime = TimerInit()
			  ;this also signals the program has been started
			  $progStarted = 1

			   ;read the dropdowns into the variables for the Total and interval TimerDiff
			  ;REMEMBER TO READ THE FIELDS BEFORE YOU DELETE THEM!
			  Local $totalTime = (GUICtrlRead($comboBoxTotalTime))
			  Local $intervalTime = (GUICtrlRead($comboBoxIntervalTime))


			   ;CHANGE THE DROPDOWNS TO A GUI REP OF THE TIMER ITSELF
			   GUICtrlSetState($totalTimeStartLable, $GUI_HIDE)
			   GUICtrlSetState($comboBoxTotalTime, $GUI_HIDE)
			   GUICtrlSetState($intervalTimeStartLable, $GUI_HIDE)
			   GUICtrlSetState($comboBoxIntervalTime, $GUI_HIDE)
			   GUICtrlSetState($buttonStart, $GUI_HIDE)

			   ;Show the hidden buttons
			   GUICtrlSetState($totalTimeRemainingLable, $GUI_SHOW)
			   GUICtrlSetState($totalTimeLable, $GUI_SHOW)
			   GUICtrlSetState($intervalTimeRemainingLable, $GUI_SHOW)
			   GUICtrlSetState($intervalTimeLable, $GUI_SHOW)
			   ;GUICtrlSetState($buttonStop, $GUI_SHOW)
			   GUICtrlSetState($buttonReset, $GUI_SHOW)



			   Select
				  Case $totalTime = "Unlimited"
					 $totalTimeInt = 0
				  Case $totalTime = "60 min"
					 $totalTimeInt = 3600000
					 ;$totalTimeInt = 15000
				  Case $totalTime = "50 min"
					 $totalTimeInt = 3000000
				  Case $totalTime = "40 min"
					 $totalTimeInt = 2400000
				  Case $totalTime = "30 min"
					 $totalTimeInt = 1800000
			   EndSelect

			   Select
				  Case	$intervalTime = "2 min"
					 $intervalTimeInt = 120000
				  Case	$intervalTime = "5 min"
					 $intervalTimeInt = 300000
					 ;$intervalTimeInt = 5000
				  Case	$intervalTime = "10 min"
					 $intervalTimeInt = 600000
					 ;$intervalTimeInt = 10000
				  Case	$intervalTime = "15 min"
					 $intervalTimeInt = 900000
				  Case	$intervalTime = "20 min"
					 $intervalTimeInt = 1200000
				  Case	$intervalTime = "25 min"
					 $intervalTimeInt = 1500000
			   EndSelect

			Case ($msg = $buttonReset)
					 ;MsgBox(0,"", "Stop button")
					 $progStarted = 0

					 GUICtrlSetState($totalTimeRemainingLable, $GUI_HIDE)
					 GUICtrlSetState($totalTimeLable, $GUI_HIDE)
					 GUICtrlSetState($intervalTimeRemainingLable, $GUI_HIDE)
					 GUICtrlSetState($intervalTimeLable, $GUI_HIDE)
					 ;GUICtrlSetState($buttonStop, $GUI_HIDE)
					 GUICtrlSetState($buttonReset, $GUI_HIDE)

					 GUICtrlSetState($totalTimeStartLable, $GUI_SHOW)
					 GUICtrlSetState($comboBoxTotalTime, $GUI_SHOW)
					 GUICtrlSetState($intervalTimeStartLable, $GUI_SHOW)
					 GUICtrlSetState($comboBoxIntervalTime, $GUI_SHOW)
					 GUICtrlSetState($buttonStart, $GUI_SHOW)




		 EndSelect

	  if $progStarted = 1 Then

		 $remainingTotalTime = TimerDiff($startTime)
		 GUICtrlSetData($totalTimeLable, $remainingTotalTime)

		 $remainingIntervalTime = TimerDiff($intervalTime)
		 GUICtrlSetData($intervalTimeLable, $remainingIntervalTime)

		 $mouseMoveStrength = 10

		 ;if its hit the iteration loop then move the mouse
		 if $remainingIntervalTime > $intervalTimeInt Then

			;Move MOUSE
			$currantMousePOS = MouseGetPos()

			;move the mouse just slightly and then move the mouse back to the orignal Position
			MouseMove( $currantMousePOS[0] - $mouseMoveStrength, $currantMousePOS[1] - $mouseMoveStrength, 1)
			MouseMove( $currantMousePOS[0], $currantMousePOS[1], 0)

			;this restarts the interval timer
			$intervalTime = TimerInit()

		 EndIf


		 ;if weve reached the end of the program then stop it or if its unlimited just keep it going
		 if $totalTime == "Unlimited" Then

			;Never Stop

		 ElseIf $remainingTotalTime > $totalTimeInt Then

				$progStarted = 0

		 EndIf



		 ;If $remainingTotalTime > $totalTimeInt Then
			;quit the program
			;Exit
			;$progStarted = 0

		 ;EndIf

	  EndIf


	WEnd

EndFunc ;<== end of the interface GUI

