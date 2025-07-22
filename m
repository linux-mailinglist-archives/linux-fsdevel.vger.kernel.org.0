Return-Path: <linux-fsdevel+bounces-55645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C97B0D221
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 08:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337306C6F15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 06:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80452C3263;
	Tue, 22 Jul 2025 06:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="eFp2XRqo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013023.outbound.protection.outlook.com [52.101.127.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8769128A1ED;
	Tue, 22 Jul 2025 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167134; cv=fail; b=oj7Wo9qGpxlxx8niAJ53CL8lfWJXdbxgyjT+OERvcuuMmS+sCMF7IHIOHvexhUst2lFbbGzN/ye997XSpKmb0WzU5gzl4z9Br3LcWniRFd0LE3R6XuDTG1KnD48Y7ITtRuTUJhYGCA2w2URVhmeTj1KKzLtyVFKh2EKvgYT3SUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167134; c=relaxed/simple;
	bh=2Nhyi/mDo9NRSUNw1NQyhIEkgfoEm55Je2lCWsQX5Ak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UvoKBWLiGxBm5+mVZ+QtmG7WLRrngW6y9DP3sHWCizkMcWWroDZ1rwytqQ3G4vgO+TboFBvbo1U0ehNJImNezkInAy3dYRO6hktpl9eHxhDKwuxghdyzoXrkoEPpJ62HOPzCBxRVD9kWgyE33moaIXzRpqVqkD76yVyhrg5m2kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=eFp2XRqo; arc=fail smtp.client-ip=52.101.127.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCtrhz+EPlResX6sBGMsN+1Q7GO+huJ1TrB46AUSDqjnsWMcXoSFulbn1aGwNozvM4R7Fcg9CVgSXNjW60HshPgskl/ZMrNlKmXkZ+BzlEaagJRV8mCcBj65O9DYGPPYCZ51FOub7unHSxt7ZV6UIgVh1lkYXDkGy+Za24rqcTmdC7+HiuYD3P/BtyGsh+BxVScItQIb65B3A0ZOvWik3PbnH+bKrWf14YdjyXk2F+RiXGNH1Ap98AbBJ0EgPmuT1QKAool3GYeWem2vHa3E6fubiGg1+XUE+5zH/jimQYaWXsW/n+375Mugnfu3ayNjHy0W2i+ggEtiWZNwiz0lyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UYm2eetk0p/jjNCqI3SrNfFqNZieIvrmM56WuN3gUQ=;
 b=d3GWSlgYSQATZAGc8nwni1lkiT8u8/8CH0bfVSKdGcnQ3aztWP8jvDELlYWHNlUgdiov8BL/czyaBbmI3q55h3mWJTCDovfd3ZmUd9F6JyvVpKaa5bpUBDGa5uZTxbvfnE+PkNktlLprd6DsXRND2JouTvi0fokcrrNAO2LYvVaWJYXuRMdzI5uu2mW4HitJZwGPsK5BLZfy/wn7dzgaX9V48WrJKR0PqgPLwCmMOO3O0xx8kBp8U+fzgpVWR/3EzXm7xMIIriasjTfWeEIU/UDuEnFmLf2x60zsbG+PcSGvnzcArPGR7y4J24K9GhDJh3aHSWqm42IxVQTl5Xwj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UYm2eetk0p/jjNCqI3SrNfFqNZieIvrmM56WuN3gUQ=;
 b=eFp2XRqoXZoSDf6zJz/U5RTYokP3/iomQ8a3xpLnJI38qyUz0LBF6v5Civ+wocckHA3noe/lfxnyHIT5oSAMiuzDKifpiehsQ69JLJs+o0Cu2HhkONVOMutNgbONRFK/Mm1GVDtdb31zYlH0aTvexEyMo9ypMpEH39x08cJ0j2A719CgTHHjfO3VB0MrTRQ/H9RgzsSPuxZtXJ4+rUoCrYTNgO9VdQv9EkLEVxOLTCeA0loGepJ0S6S6BT0eJV8FkkkDpdOA538pFkLV1RLv9HnxFR8m9jadulE/FQQPJrZo3kym5B0EKg1YkLwx0MxnsFENgvWStMJKIB9yEY598w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5293.apcprd06.prod.outlook.com (2603:1096:101:79::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 06:52:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 06:52:07 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] hfs: fix to update ctime after rename
Date: Tue, 22 Jul 2025 01:13:47 -0600
Message-Id: <20250722071347.1076367-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722071347.1076367-1-frank.li@vivo.com>
References: <20250722071347.1076367-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f02e92-4072-4ab0-43dd-08ddc8ec465b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ig4TDkGcB0YrnQboEBVGlFL8qswDdwG95FWmsNiK+kSFN3zqhq8I+taWOK5X?=
 =?us-ascii?Q?JdJ53hoiyFBwfgxO7CzOhP58+KUY+TkDK1IIANZdVYJj7SQXEz7VNtfv/Afz?=
 =?us-ascii?Q?mCvqQwOAHkb84IWkxx7OlzUEnBKby8Yxw2JI5HY9QKCcFBmOZs0i9Lt/eyam?=
 =?us-ascii?Q?Z943V12aM8JE+xHCECF9rmiqEFBqQJLZMbyHiA6AUVwOk/eBW31aJo9/0VfD?=
 =?us-ascii?Q?5XwU26E/M8q0ngdVQDzwMR+KvgG4bhBD0nBa5BBn/Jg5hgLp7+mbIUCd8ev3?=
 =?us-ascii?Q?rTEX5WOa5wOWigZSqa0OLyXkcvhT+uGygGUVD/4Alxa4UX5XAIFcDb76kCXV?=
 =?us-ascii?Q?3WeyFF0sOpatPlshjfRr9W/lcOW3Tr98qbvIkAPKhFgbYeV3YAsIgTsQTr7k?=
 =?us-ascii?Q?nQOFEd3R88sNVJumYaBoTdxRaAzYUHSRE1UYNXWR0hdf9vzq2tuDQ2MorJYF?=
 =?us-ascii?Q?bmxcoQHO18K6W3wT8iC9d6CeaewcNt7o9IO523H251AMPyyiI9Y17YfzLn9I?=
 =?us-ascii?Q?7gbt4aFI7qgHtQqIMZJqQOPrTURe8QxhuaIJFJPyV7t08d55eJT+e5HgT1Mp?=
 =?us-ascii?Q?M+1Gn6lH8NOYGZ/3rPy5i/IIyLpPHfaR/QnR+WnHiRHqAxO49IqH3W0H2PE5?=
 =?us-ascii?Q?4BQyEcM2/MOGrY9EWWTK3c8Znlw1woeTz/he5uz6oT2DKZ39j7ikvvkA0f9h?=
 =?us-ascii?Q?h+t6GZRIgOtDRcqSNiGDlfH8mvT2+4JgTRJ1cPMemdbjFZbaZ4lpI5ptoE4/?=
 =?us-ascii?Q?v8CWQvn90yabyJS1vAzS6ySTs6LG44f9ShrXIhlYCr0zwM4Tv3VqTiV4Itgu?=
 =?us-ascii?Q?7wASVgkiznS9H+vpmVVIfQ8G8n4C6KQfPt7W3KcbqtlMCJ3GUpX1QKo2tQhl?=
 =?us-ascii?Q?YwjC4MiwM6wI8J7budXNj0VkCGb51ggiBC1Rm34JeJclk605PRFHQcpa2H4s?=
 =?us-ascii?Q?L4A9DgXECn25Ct8YM2YLkTNIQzELj+dvhS/CK6MNo36dsPdCtUALCi9+XuX8?=
 =?us-ascii?Q?oHWJeYb2NpLTmGduBEcWuc1C+sX2dnbrkFnIxe0NPV0iBsh1JR3B7ABfjnqi?=
 =?us-ascii?Q?cyelmXL/PWLHs8EAFlALkRKx0hSLsVgJ0HWq0dROtrt//3Cd9Gx6/K4JfCWt?=
 =?us-ascii?Q?WnWIcLBjyJVwgSr2e0BLwyz44qWmDHgFmEn83moRLV3Xq3yZnSHe27WyuaUv?=
 =?us-ascii?Q?qsNLlB6YTyZKZwid6Tvy88jZQWLpNX8R+c4ppvfe0W5V9cV8/cmycBnhw1WW?=
 =?us-ascii?Q?5lZ7WIFBTvDjc7A/L4rZBDD9MOsjFq2j8dgGcuLuOJo/d7sRxBqarGoHw4v+?=
 =?us-ascii?Q?0kTt0ELYNwQXJQAqrjVXnvxFIyiD54WQJFRpGrinbBrEmte6oP8D5iok4qsv?=
 =?us-ascii?Q?3mfPTu65KMX39u8Yz4gTBOSmK/UuU8giGfz3XKbV8VT0jjAV94zDtjCzd6AV?=
 =?us-ascii?Q?gKTF7NGaDb5Fnn91RDg3MAcsh6bxzDF68UKrHf73cg7yEV3vTRjTKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sTW/PYPknTo4TgwMlNSeK1JPL0yl2PWBOqrCZmJGEjXMbNxiiQuZTbPsexqM?=
 =?us-ascii?Q?flsvHmJ4uAoknAVaGfT1AM+iJdlIGsIAvprIrg41HyV4fw59SrLOgU3wj3As?=
 =?us-ascii?Q?+Ad9N+81+8bzxHT8k3wRdMf4/L6Zqy+8DZ5GLEvr5apyigXY2UR429PsftEM?=
 =?us-ascii?Q?BSpNAzZkJJ1G5VWdYCwhyc4JO6lx3atwCLfgbLie+Zjhzq9mAaiQ/b/k3+Kh?=
 =?us-ascii?Q?5A0/ehbcegN9FMIOPo+NqPPLScAyxZRa5jwEep3j95mw2R96c9dVRicD9QFQ?=
 =?us-ascii?Q?ygnvXUG5eeBKxAFI+zrbUIf+VwfoCs2mEYpM0OtHtCFESFWUMddwVYMifljq?=
 =?us-ascii?Q?89tRzglKO0eS8iGr2W+1T3Rt8wqP9IrQTbpBA9xCatVSIbt5uuEEC0v3Wo3T?=
 =?us-ascii?Q?pXdP5C1T94hJ7DvMxqYpfS2yiPYWHkLvJFwGkRJXhEwBXQdlJPdLO4Ecjet2?=
 =?us-ascii?Q?4n26DdIkTBx+L+/7u+6cLHQtKpekGdNKCPSbLdWOHQm+xss4HqfdXSBLPJ7K?=
 =?us-ascii?Q?BGUydPja75/ijltG//6SA75KC+4SNRBjH8HlnY+YF3vIMs1POoALXkW5h3RV?=
 =?us-ascii?Q?2IPKbMeM1x9sH0DRv9rV8W2r4Dj/uDS4GshxjjF6CDufLBdHv2MSIWLh3MEm?=
 =?us-ascii?Q?2a0my2WGGATjcUhN9MsIE+QESIAvuqPOrZkYQuKSTx6NXOY16oRYp5HQMikm?=
 =?us-ascii?Q?tFl1XIEVaMV4g6HA6U0K60S/kdebcXHheoYJTYrDA2O4XL4uFhnS1l8OgKNO?=
 =?us-ascii?Q?owBgwPZu3mMj56MzbKY293Yv2D22Oc6cLC7OlexBipUg9UtUlrEKkyiN2Tgq?=
 =?us-ascii?Q?pDaDkGCkHjKCzyhbZaTYQzl/axlRnaEIVwXVVURkK6nKM1em3ibIjgbpbFPa?=
 =?us-ascii?Q?lOYHeEGKqj6MZcp8jYGublz4An3MJCwxJkhtPxu2zlYxDieQtftoW45XJNjz?=
 =?us-ascii?Q?E0UCLM9z2zRaXwc+RS6NRyb5rE7Hsdd+24e4PqkULPc+KdtT/+oTsKRf+W6L?=
 =?us-ascii?Q?Q63MvUcuXFpKPrpb6hAWg7TvHTrKVj4+njf/V0Mrv3Wpy8PAPY8Ct92s+uM9?=
 =?us-ascii?Q?Vy8F2DWaRS4zpR4XP0LNtVDzpoAWO1GPGqXxdOEa0elzYBhhjY1vnyiei8Zz?=
 =?us-ascii?Q?MahjXM7g+HMkFk/ooUZjSgANA4QbwXsSerSnhYhC1zdho0QZx+g238pNxzOK?=
 =?us-ascii?Q?i/F5VohT/6J/L0VR+nU87vF/xD2FYU+AWXYkjrPZ2JfmCofatUDBAv865BTL?=
 =?us-ascii?Q?/vdhyhm+FKxXQhfIGo3FUofeqZSaGFcQGd8HsXqXWh/EHGxt597pyUUIAhd8?=
 =?us-ascii?Q?hps9p5+bJ6b/QeIX9a36zMqzmXL8FArUV/cDI0ZLAtec3UY1i1EeuAHjUhwY?=
 =?us-ascii?Q?kwnSUO+8UoZcsNYRVhLFT1P7f3N2kjUDmz7Qta0IsEniabnwNbwSEIVQX8jg?=
 =?us-ascii?Q?wnirxqb0rX5wWD0TADx25Xp2MRQvGg979ZN1bkCQKQhBZTKAoOBMoVKZGmZ3?=
 =?us-ascii?Q?4ikhid1LeP7qZDtjWLlklfScbD2dbxpxbU4l6JzyEBxF7hYTlaSxAwKj7FFa?=
 =?us-ascii?Q?VeAzmwq74QXqZWsKfkx9coF0EeC2QIIASEBsDiE/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f02e92-4072-4ab0-43dd-08ddc8ec465b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 06:52:07.7203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZvzE6/KSbvXXBZg/F0Z2SAWXtzhnWS3imh0/+s5+QIMKf1QrPCQYpV9f0aGnAC99x1wuTvHvuTICgnvlFnyew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5293

Similar to hfsplus, let's update file ctime after the rename operation
in hfs_rename().

W/ patch, the following error in xfstest generic/003 disappears:

 +ERROR: change time has not been updated after changing file1

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v4:
-update commit msg
 fs/hfs/dir.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 86a6b317b474..756ea7b895e2 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -284,6 +284,7 @@ static int hfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		      struct dentry *old_dentry, struct inode *new_dir,
 		      struct dentry *new_dentry, unsigned int flags)
 {
+	struct inode *inode = d_inode(old_dentry);
 	int res;
 
 	if (flags & ~RENAME_NOREPLACE)
@@ -296,14 +297,16 @@ static int hfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			return res;
 	}
 
-	res = hfs_cat_move(d_inode(old_dentry)->i_ino,
-			   old_dir, &old_dentry->d_name,
+	res = hfs_cat_move(inode->i_ino, old_dir, &old_dentry->d_name,
 			   new_dir, &new_dentry->d_name);
-	if (!res)
-		hfs_cat_build_key(old_dir->i_sb,
-				  (btree_key *)&HFS_I(d_inode(old_dentry))->cat_key,
-				  new_dir->i_ino, &new_dentry->d_name);
-	return res;
+	if (res)
+		return res;
+
+	hfs_cat_build_key(old_dir->i_sb, (btree_key *)&HFS_I(inode)->cat_key,
+			  new_dir->i_ino, &new_dentry->d_name);
+	inode_set_ctime_current(inode);
+	mark_inode_dirty(inode);
+	return 0;
 }
 
 const struct file_operations hfs_dir_operations = {
-- 
2.48.1


