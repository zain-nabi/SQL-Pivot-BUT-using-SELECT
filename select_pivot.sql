USE [CRM]
GO
/****** Object:  StoredProcedure [dbo].[proc_RepTargetsNewBizGrid]    Script Date: 2021/07/23 3:06:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================\

-- exec sp_RepTargetsNewBizGrid 2012

ALTER PROCEDURE [dbo].[proc_RepTargetsNewBizGrid]
	-- Add the parameters for the stored procedure here
	@FinancialYear int,@UserID int=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

declare @Where varchar(100)
declare @FinancialYearString varchar(4)
set @FinancialYearString=Convert(varchar(4),@FinancialYear)
	
if @UserID is not null
	set @Where=' where TritonSecurity..Users.UserID='+Convert(varchar(10),@UserID)+' '
else set @Where=''

    -- Insert statements for procedure here
execute ('SELECT     RevisedReps.RevRepCode, ISNULL(TritonSecurity.dbo.Branches.BranchName,RepCodes.AlternateBranchCode) as BranchName, ISNULL(SUBSTRING(TritonSecurity.dbo.Users.Name, 1, CHARINDEX('' '', 
                      TritonSecurity.dbo.Users.Name)), RepCodes.AlternateName) AS Name, ISNULL(Jul.Target, 0) AS Jul, ISNULL(Aug.Target, 0) AS Aug, ISNULL(Sep.Target, 0) AS Sep, 
                      ISNULL(Oct.Target, 0) AS Oct, ISNULL(Nov.Target, 0) AS Nov, ISNULL(Dec.Target, 0) AS Dec, ISNULL(Jan.Target, 0) AS Jan, ISNULL(Feb.Target, 0) AS Feb, 
                      ISNULL(Mar.Target, 0) AS Mar, ISNULL(Apr.Target, 0) AS Apr, ISNULL(May.Target, 0) AS May, ISNULL(Jun.Target, 0) AS Jun, ISNULL(Total.Target, 0) AS Total, 
                      TritonSecurity.dbo.Users.Name AS Expr1, ISNULL(TritonSecurity.dbo.Branches.RepSalesOrder, case when RevisedReps.RevRepCode like ''%other%'' then 20 else 5 end) AS RepSalesOrder, FWRepMaps.FWCode,TritonSecurity.dbo.Users.UserID
                      
FROM         (SELECT     UserRoleBranchDepartmentID, UserID, RoleID, BranchID, DepartmentID, SignatoryTitle
                       FROM          UserRoleBranchDepartmentMap AS UserRoleBranchDepartmentMap_1
                       WHERE       RoleID in (2,15,20)) AS UserRoleBranchDepartmentMap RIGHT OUTER JOIN
                      TritonSecurity.dbo.Users ON UserRoleBranchDepartmentMap.UserID = TritonSecurity.dbo.Users.UserID RIGHT OUTER JOIN
                          (SELECT     RevRepCode, SUM(ISNULL(Target, 0)) AS Target
                            FROM          RepTargetsNewBiz AS RepTargetsNewBiz_10
                            WHERE      (FinancialYear = ' + @FinancialYearString + ')
                            GROUP BY RevRepCode) AS Total RIGHT OUTER JOIN
                          (SELECT DISTINCT RevRepCode
                            FROM          RepTargetsNewBiz
                            WHERE      (FinancialYear = ' + @FinancialYearString + ')) AS RevisedReps LEFT OUTER JOIN
                      RepCodes INNER JOIN
                      FWRepMaps ON RepCodes.RepCodeID = FWRepMaps.RepCodeID ON RevisedReps.RevRepCode = FWRepMaps.FWCode LEFT OUTER JOIN
                          (SELECT     RevRepCode, Target
                            FROM          RepTargetsNewBiz AS RepTargetsNewBiz_12
                            WHERE      (FinancialMonth = 1) AND (FinancialYear = ' + @FinancialYearString + ')) AS Jul ON RevisedReps.RevRepCode = Jul.RevRepCode LEFT OUTER JOIN
                          (SELECT     RevRepCode, Target
                            FROM          RepTargetsNewBiz AS RepTargetsNewBiz_5
                            WHERE      (FinancialMonth = 4) AND (FinancialYear = ' + @FinancialYearString + ')) AS Oct ON RevisedReps.RevRepCode = Oct.RevRepCode LEFT OUTER JOIN
                          (SELECT     RevRepCode, Target
                            FROM          RepTargetsNewBiz AS RepTargetsNewBiz_4
                            WHERE      (FinancialMonth = 3) AND (FinancialYear = ' + @FinancialYearString + ')) AS Sep ON RevisedReps.RevRepCode = Sep.RevRepCode LEFT OUTER JOIN
                          (SELECT     RevRepCode, Target
                            FROM          RepTargetsNewBiz AS RepTargetsNewBiz_3
                            WHERE      (FinancialMonth = 2) AND (FinancialYear = ' + @FinancialYearString + ')) AS Aug ON RevisedReps.RevRepCode = Aug.RevRepCode LEFT OUTER JOIN
                          (SELECT     RevRepCode, Target
                            FROM          RepTargetsNewBiz AS RepTargetsNewBiz_2
                            WHERE      (FinancialMonth = 6) AND (FinancialYear = ' + @FinancialYearString + ')) AS Dec ON RevisedReps.RevRepCode = Dec.RevRepCode LEFT OUTER JOIN
                          (SELECT     RevRepCode, Target
                            FROM          RepTargetsNewBiz AS RepTargetsNewBiz_6
                            WHERE      (FinancialMonth = 5) AND (FinancialYear = ' + @FinancialYearString + ')) AS Nov ON RevisedReps.RevRepCode = Nov.RevRepCode LEFT OUTER JOIN
                          (SELECT     RevRepCode, Target
                            FROM          RepTargetsNewBiz AS RepTargetsNewBiz_11
                            WHERE      (FinancialMonth = 7) AND (FinancialYear = ' + @FinancialYearString + ')) AS Jan ON RevisedReps.RevRepCode = Jan.RevRepCode LEFT OUTER JOIN
                          (SELECT     RevRepCode, Target
                            FROM          RepTargetsNewBiz AS RepTargetsNewBiz_1
                            WHERE      (FinancialMonth = 8) AND (FinancialYear = ' + @FinancialYearString + ')) AS Feb ON RevisedReps.RevRepCode = Feb.RevRepCode LEFT OUTER JOIN
                          (SELECT     RevRepCode, Target
                            FROM          RepTargetsNewBiz AS RepTargetsNewBiz_7
                            WHERE      (FinancialMonth = 9) AND (FinancialYear = ' + @FinancialYearString + ')) AS Mar ON RevisedReps.RevRepCode = Mar.RevRepCode LEFT OUTER JOIN
                          (SELECT     RevRepCode, Target
                            FROM          RepTargetsNewBiz AS RepTargetsNewBiz_8
                            WHERE      (FinancialMonth = 10) AND (FinancialYear = ' + @FinancialYearString + ')) AS Apr ON RevisedReps.RevRepCode = Apr.RevRepCode LEFT OUTER JOIN
                          (SELECT     RevRepCode, Target
                            FROM          RepTargetsNewBiz AS RepTargetsNewBiz_9
                            WHERE      (FinancialMonth = 11) AND (FinancialYear = ' + @FinancialYearString + ')) AS May ON RevisedReps.RevRepCode = May.RevRepCode LEFT OUTER JOIN
                          (SELECT     RevRepCode, Target
                            FROM          RepTargetsNewBiz AS RepTargetsNewBiz_10
                            WHERE      (FinancialMonth = 12) AND (FinancialYear = ' + @FinancialYearString + ')) AS Jun ON RevisedReps.RevRepCode = Jun.RevRepCode ON 
                      Total.RevRepCode = RevisedReps.RevRepCode ON TritonSecurity.dbo.Users.UserID = RepCodes.UserID LEFT OUTER JOIN
                      TritonSecurity.dbo.Branches ON UserRoleBranchDepartmentMap.BranchID = TritonSecurity.dbo.Branches.BranchID '+@Where+'
                      
                                     
                      
                      
ORDER BY RepSalesOrder, RevisedReps.RevRepCode')                      
                      
--ORDER BY ISNULL(TritonSecurity.dbo.Branches.RepSalesOrder, (CASE WHEN CHARINDEX(''other'', RevisedReps.RevRepCode, 1) = 5 THEN 10 ELSE
--                          (SELECT     repsalesorder
--                            FROM          TritonSecurity..Branches
--                            WHERE      BranchName = SUBSTRING(RevisedReps.RevRepCode, 1, 3)) END)), RevisedReps.RevRepCode')
                            
          
END


