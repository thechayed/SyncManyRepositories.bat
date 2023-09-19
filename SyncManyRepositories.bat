@echo off
setlocal EnableDelayedExpansion

REM Define the directories you want to process
set directories="D:/Workspace/Unity Projects/UDT-2/UDT-Tests" "D:\Workspace\Unity Projects\UDT-2\UDT-Tests\Assets\UDT" "D:\Workspace\JS Projects\Phaser-ECS\Phaser-ECS"

REM Loop through the directories and perform the Git operations
for %%i in (%directories%) do ( 
    REM Check if the directory exists
    if exist "%%i" (
        echo Processing %%i

        REM Change directory to the specified directory
        pushd "%%i"

        REM Check if Git is installed in the current directory
        git --version >nul 2>&1
        if %errorlevel% neq 0 (
            echo Git not found in this directory. Skipping.
        ) else (
            REM Fetch and pull changes from the remote repository
            git fetch
            git pull

            REM Add all changes
            git add .

            REM Prompt for a commit message
            call set commitMessage=""
            call set /P commitMessage=Enter a commit message:
            call echo Committing with message: %%commitMessage%%

            REM Commit with the input message
            call git commit -m %%commitMessage%%

            REM Push to the remote repository
            git push

            echo Successfully pushed changes to the repository.
		pause
		cls
        )

        REM Return to the original directory
        popd
    ) else (
        echo Directory does not exist: %%i
    )
)

echo All directories processed.
pause
