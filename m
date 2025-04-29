Return-Path: <linux-fsdevel+bounces-47641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3762AA1BAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 21:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D203C16F99F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 19:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAB1262FC7;
	Tue, 29 Apr 2025 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="E6EdkWc+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013003.outbound.protection.outlook.com [52.101.127.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8319259CAF;
	Tue, 29 Apr 2025 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956531; cv=fail; b=DTu0p9cGyAKD4Zo7Rt6Rwna3Vnofk6TWizxEMfsYhdTquwEmNUV5A6CG6eaL0TWpBVOiOXcEaMPcbsIxMrw4Nw1mzPugrxVqQ3RgpJx3xhGLX+yNhfA0SoH4xZfEd2WZH921FZh/T+CnjIS9okqjHSVZpZJUIUoiUW6BK9bSQdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956531; c=relaxed/simple;
	bh=iOXlGB9tYSC2PmpD/mK3lYdGUNnUdxMo+ajMvlS9eCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kqfJBo/O3BRlqCjRBaWG1yZRUlEkbdi9pieGl/QVc2b7ZORg0Uz6X9XbTVn8guL8fvCdtChCJGlHOLfmyi8BzaEX3emi9g9rvUxWCgy3FkKiS2QxI2kFlU7B2XS6mfLfnBzy1QTKrhRXXLETTAq5GZW2XZECN2p+VRFkImiTTwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=E6EdkWc+; arc=fail smtp.client-ip=52.101.127.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2aG52KTgsF/yqutRAF8LF3YqBBQIN71WzQievxjWG8MQsvzJ191MOXTO66vf0Chg4IsKXc5oNoaviQ4sM9QB3VwhBPgtVOLPIfvVwtmGXvZCWdUCYHErg4hW1mb8Bfn6Bjl9G17g/LG7K7rafk2z6VObmPD7ggdStpyv+HPiBUmb5UWndcAbgs00Fss55ztxYqwO7yDcm3kbcc/VQrExtyXGvyvhymPB0tFNjLqJ+EDILukHOEdQx7s6qUC4StKJVpKW2qEixPvsHG9avj5tGBGrdpZi63cx/pCSYfZKJtNDsvsBHaSN9vUmkekbwKtvBFx0JOUHNAK9M0OgJkWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXR6tgFZJE5gJWJBNnq3JXG5k5YIXmzqfi/KAJDhsP4=;
 b=VkLOdz95a6Y2rYc5FkxQX8s3EESuHFnL6MbmJiN1fS2NTVYswGpTpRpdu2xZeZV5X0Ybvy2gb3BQAN21vqUtQHVQLeHSWrpWVU7K0XS3bq05VT6r638UjZ0oZjg0xgjAlXmTED2QH/bjwl8pkXjP2JQj6qG3zPxXr8sSgrGRZLgnWHnaXC6oTgJbLP5mHV//0aWDdWImq4KKaI8m89yzXzeehUEmjBEyTmU6dBBojQdoqDimZS3O7Ih85VGRE1sEUTWQOQsNQ8NiDSTGeXXT2v4r43hs4w9pGWLT2YLK9jmTrtIFeEXAUcvWJJq3WYBWnNVYMUB628WvbnNWcQSOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXR6tgFZJE5gJWJBNnq3JXG5k5YIXmzqfi/KAJDhsP4=;
 b=E6EdkWc+QWh0NiCAoBqhPUGdNymVSGPv5J4BaAz8eEe3Mb3fQ81mWMqGwmlYc0cYUqtkFMBA71xFelVfkC9WrmGNSFGzfkBNFc4OwzDo93QFJ5mSytcbc3FJICcF1mDa+JhlzdGrhHYzHebbOx29mgIaYfS2Y9UJ2E2g/3g6PMOFKJqUEMdA8wHVURri7ABFck3fCQb3hB4H0GNBgvDWHxP3poGAGBZMcVy8jI7qq37R6DvENTk1t8Jp6QgMLh4fijXUBuhcUay807g1ZzS8K6MymImdf55anaPBjYr7M5OUl8NZ6z9DLwj8avgYSk7P6ar0Kn4waAJu2OidbzS8Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB4983.apcprd06.prod.outlook.com (2603:1096:400:1ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 19:55:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 19:55:24 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 2/2] hfs: fix to update ctime after rename
Date: Tue, 29 Apr 2025 14:15:16 -0600
Message-Id: <20250429201517.101323-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250429201517.101323-1-frank.li@vivo.com>
References: <20250429201517.101323-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::26) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: c6cf3f34-37bd-4390-e9c8-08dd8757c800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GdgHoLYg6mQk7u1ByVJ31iIJtf8m+MWiLdRDhcqL5eul/yWLEpfhVddfFegm?=
 =?us-ascii?Q?YJwf0WitRjpaJXlWLd9y9KLhPVv3TESAG0MA0qr1GYRV8+CCyWS10zIuArTs?=
 =?us-ascii?Q?P/U6iIWLguDphUC7mcMtbUpXwC6BS3FxtyFC3yo1TaQQnoOslRLBDlHeOWtl?=
 =?us-ascii?Q?PaEq/kHHZOBtgWrStf38jR2R2M7CsigAJLMWBM4scjDAaWlwW/M+0uG2rJTY?=
 =?us-ascii?Q?1EGZ9bM8T9bArgAOP5V5hcfbFNP5MHQDhVmKrOEvJIUQHuCvqX+Ox9tg3Jou?=
 =?us-ascii?Q?JuRfTYgOiPAqeRTLyE86r4uruzD3ih6rBD+73ft+VRtVAzgRzlmg4F7U05Bh?=
 =?us-ascii?Q?MOB9l4M2mtDjatetj2kkRwUnEwmCN+Jgodfv5gfQstMKRuteQXIZFcGlq7RQ?=
 =?us-ascii?Q?nIbnOIbMJDMhMSLb6ehBOm1T6JTW/CUH/6pJMEHFcpK18OXjUB0htL1rJFRa?=
 =?us-ascii?Q?0tCNsxYLlgIqaTYAvyvQQMivOltHkBUMn5N0OOEuAA3UKWAGv7BkQYtKKfQn?=
 =?us-ascii?Q?bWQd8lTN8JEYzKLGidVMuh/4Ek9fFigV5i13jO8jj3UwPi46LYh3cCP6s4G6?=
 =?us-ascii?Q?iKMFVoY4VJYWnjvw5ncnJQlTRYf5zJk2bDMtvqYUI178477UyvmjPELnQfta?=
 =?us-ascii?Q?JH6B6p2d01NZpoCQdbZVRgfx+aA88Mx7kQDDvxYt5hb9Z2zwOK05N8+vvVrq?=
 =?us-ascii?Q?AEEguEoiTDHH17iZvcg3lycmGFfOL12WjCMhub1y4DyugudWWi8a6qu460KY?=
 =?us-ascii?Q?Pe3aRBdD5DyhjHH2Gx1CD5Uya4sdVITthk+PabbtfPIPqbmjg8XG9GzImsED?=
 =?us-ascii?Q?NVcjGHtZHB49ROwAuPtxaOrs6mW0Bl096fFjOmU7O34H3Ca7oqxw2e5OJXXa?=
 =?us-ascii?Q?LQxPyOUxftdWWI4hJLNd1PpvXy+qIj/KBkw05106fLUwMejUPJM7aPfdbXAv?=
 =?us-ascii?Q?7Ok8e36cntIl7NqkpUpPO3lKi0KTm95E+fWdhNZKTWZmsSGDoynV1O/f5NiJ?=
 =?us-ascii?Q?wmYFXOPuib4bn2N+L6n8Xp5L5e3TIqlxLOVA2DtDNzfY846Jw7+51nX+wO+2?=
 =?us-ascii?Q?RqbTw4KMhbUU59BKjgBLViKMhNVKWEpl+fI48cK+XeKE/08bmnl4FMA9n08L?=
 =?us-ascii?Q?6WdyCC7UDDGPgzInteaS3Bt3y3M/gJnrgdrpZmuUQSNSH/eNGM0haxttE5EP?=
 =?us-ascii?Q?stkAYqC4NXdX7NmCLtONsZCAs0Ryuh8hoqZgkJYrP3QMjGTq5hZEd2vvtB9K?=
 =?us-ascii?Q?wfp4QAxbpaeJRYm3BC8NZZGs1p0wLzAFWASlt6Ee1xACKbtyNep8RjpEov03?=
 =?us-ascii?Q?B4KQjk9gmBW8kz7Jpc24K5oZ75+l4W4oKWr7abXtbDUR+rxcXg1+lBBStiCc?=
 =?us-ascii?Q?qUxcpmj1CdTvOvY5WaUFFZj9hWzq+JcCZY8h8ht6Gw+qsDiIpKGnDAAELz6l?=
 =?us-ascii?Q?yv0eWJcqmXAcx8ONCRuGcEu6/aH3ejwrrID4rzpn/HyqYXtMybXFXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nr+UywbYROZC/MhsdTTZgwLMsxqbVRc3s219EhUveeEhhoyZIJimsfBJaYWa?=
 =?us-ascii?Q?IVd7OJ4J7pPMggoB1CXYr+7334ezUllSo5lB7UkuSZDbFh2VDTKb+ynoz3/3?=
 =?us-ascii?Q?XmRuwMYT3X2IMulmCIAskI4BQ3z1ua74hyIMBnXeNWEse6l5IdcJ5iQaSnFa?=
 =?us-ascii?Q?H7J7eF9NzogLFVQOWnhKnacxWVAnh44GE4xEoSg6vkMuR9ML9QC12GThHV4h?=
 =?us-ascii?Q?UNzRB/zfsrCkX+f6sUZeG/JiNmdsyHPRZ54beG8yIbqn8vs+Fx7omFDsHb0h?=
 =?us-ascii?Q?sMpOwDjE2ljLAqcvOOjeWa392s90QMY0pKZfOM0U+nlJAvy4GBgqKWlnzKs8?=
 =?us-ascii?Q?3QC27UxAzIh2cGoSxtj+Su6y1ZlI6M1DFliULy5fYpgLvltYucYjdoNWoF0B?=
 =?us-ascii?Q?gJ8mTQEvpJ8vtwczAgs7bVPT1mvGBFl8c0CAGIORbghWWcr6U9XtvtrsZbQn?=
 =?us-ascii?Q?EuTkVtuQInAenQNk4dQ/tB3L9zFdou6034Zb4piUJn7q/pwUZ5d4md9Yue1+?=
 =?us-ascii?Q?5sHEaP+NfTGnZQ6aq8NHSqDeWimeFVL+OToqo3dtZJAkzyaizbWg3zeIqadQ?=
 =?us-ascii?Q?mrC29MbiEnd6tx0VtyCSgkrEIs58A65PxEL4Gnc0iBzQ5zoo8+FvV5Lw+SZw?=
 =?us-ascii?Q?cUl09L2ZUE2hA0CTTHQE1fRZRioU7hBu59yqDLKJG+hx2/hVXpMgP9a+9u7J?=
 =?us-ascii?Q?R2xzLKiY8FlESJ45iKjzfYpRzrLZJahrYKRc8+yDMD55U284DErXSqrTHz8b?=
 =?us-ascii?Q?8SN58R581P3OAZsbXNj1lGuN5dg7uln1ntfNhrYt3qun/eqJWV+1dB7YS3Ny?=
 =?us-ascii?Q?BBArZxN3iCwq96lFLGQlcCpz8/8XgPycO2Ur0AtYXbflpxO3iA9hQLI4yakO?=
 =?us-ascii?Q?J5Zbwmu4SsMvkeTLMxXrqDJGQoDEsehrB8RSsmaJ+S/9sX9s+lM1Cd+7ojbZ?=
 =?us-ascii?Q?zoDA8nCQne5OVFcsOZqUCSsnJmJxsRBscrJjJTwoJrtdWiRRR1c5jVP011Zm?=
 =?us-ascii?Q?LPmG3WAyv9mdUWPLnSJltbLZPyFenLB4sWGk2a8oG90MBhZVDmzFKdn2r9m8?=
 =?us-ascii?Q?fMUGH+djR+oePWXctoDC3percJQXagt/W2Dd2N40T3HHN0ly+vPPr9gcEQPm?=
 =?us-ascii?Q?c8srFUcqWhVAMiNm4Tr+HNmopHAJk1kmh3Zx/Z4FqFGhvJZPuIuMRJVcvuZF?=
 =?us-ascii?Q?+WRtWe8j3i+N5ITY6hq2SJ3oOhH+a5VzTgEwAOr0kTxdi55CW/DNJSytADG0?=
 =?us-ascii?Q?HE5aXaubdug5layDcrdTgcngCYri/3C2BUNDcr+GZKRNv9doZjD1Ad7gmcAo?=
 =?us-ascii?Q?TIo7+gxX2Ey2uofNufk0qCCUJS6ULoyi28/zmizBipZ7nSr6V4k7aio1p8wm?=
 =?us-ascii?Q?gaP/qtacDxI55FUUp/8qYtYZ/bhcg1qgk9fyzI6hC3IHlTDEqHxVpnGDOS5x?=
 =?us-ascii?Q?O0KmZhswpufcWO+9dP8VjzQgbNlLdskPae23J4mzQwP3j8ZAohYrTBg5hU0O?=
 =?us-ascii?Q?fwyUB9qPvkOUKtbQG66nvUj+x4A01/mVy8zTKU36TjU8NaKuewlGD8LvIuzW?=
 =?us-ascii?Q?n19JJB8rZKfeUtZNkSu2TNOX9d2oYEZeMFdyYIhA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6cf3f34-37bd-4390-e9c8-08dd8757c800
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 19:55:24.6407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcMbUxEHA8HNHMMfmq2smQkDVBUPXB2T+65dJHkrZTUjBAlPaIO1ePUIQ0RzuCVd2NycOFvy6WURiDGjaZYYEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB4983

Similar to hfsplus, let's update file ctime after the rename operation
in hfs_rename().

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/hfs/dir.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 86a6b317b474..3b95bafb3f04 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -284,6 +284,7 @@ static int hfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		      struct dentry *old_dentry, struct inode *new_dir,
 		      struct dentry *new_dentry, unsigned int flags)
 {
+	struct inode *inode = d_inode(old_dentry);
 	int res;
 
 	if (flags & ~RENAME_NOREPLACE)
@@ -299,11 +300,15 @@ static int hfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	res = hfs_cat_move(d_inode(old_dentry)->i_ino,
 			   old_dir, &old_dentry->d_name,
 			   new_dir, &new_dentry->d_name);
-	if (!res)
-		hfs_cat_build_key(old_dir->i_sb,
-				  (btree_key *)&HFS_I(d_inode(old_dentry))->cat_key,
-				  new_dir->i_ino, &new_dentry->d_name);
-	return res;
+	if (res)
+		return res;
+
+	hfs_cat_build_key(old_dir->i_sb,
+			  (btree_key *)&HFS_I(d_inode(old_dentry))->cat_key,
+			  new_dir->i_ino, &new_dentry->d_name);
+	inode_set_ctime_current(inode);
+	mark_inode_dirty(inode);
+	return 0;
 }
 
 const struct file_operations hfs_dir_operations = {
-- 
2.39.0


