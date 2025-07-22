Return-Path: <linux-fsdevel+bounces-55646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 915D1B0D21F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 08:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F2A5443DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 06:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A32B2D29D0;
	Tue, 22 Jul 2025 06:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Abh8M3lf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013023.outbound.protection.outlook.com [52.101.127.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F712C159F;
	Tue, 22 Jul 2025 06:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167136; cv=fail; b=IGV+eWQixIfGg1NVpyuhYlMsOoCjO3Uh9RZy+J+PuhILCUJLUlzqVuSqDHL812ROtruel67O0by8qfVKbYEueAd22z+AztVOqRTMCOByKezclm0kSStwaKW0lUZ6wFT+tA/g7sHHwBnw9gC1mzH1jzj0wmUxijA+oBmatkBgtyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167136; c=relaxed/simple;
	bh=Dcy0qV28QZEqcFbQvhM82XlsukOU+D2uXqTidTCT1i0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XQyQa2ugKbIRYDONE5NQ/AD8Dlkp9LsgYPFZ46CDh9A2Ci8r/wA1WOXeFFb0tuSWYEqnErZuYb5+z7zu6tdEAiBtTTud58LGC9DrJWKyrQd/TXURK/Kiq3Cc+ANcTzTGZjWHmryIUSrNOGleB9QfUeLO848GtA6tRlhku8SGhqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Abh8M3lf; arc=fail smtp.client-ip=52.101.127.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xk/xRx22ogUOL4itu5iswN5OFAMPR0sC+B0aP5CndQ5eAcVBgP3b7zgmS69zBQQJP3TmgnHCCRhLTr4BIaD2oHsAJvk5l2V6o6GvEzAG+tqIFmaYjzQKxYDhyC6QSlFNvG7s8jT6+1w02CFRArB0/pmsXV4sAvl9Znsz5zYi5O1t6Bb6BbEUc8zT9DgobGIoWkuj7MxHx0IX8RgqNr3TdAyMT65pL2BYNltRSjtVWTRFX7V56wq18+RoqWmuNZ5SCf43+A0hWXZFHJPCOwhYSrhhnzZoOkndYBeh/fuxZG1QwYrRohFvGbJWLTquMo2YY3dLv9+nOoCDvBwyxzeM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEC/kv7196r3w8cXpLgqlQ9TjsfHw0mjuV+aiXLIryk=;
 b=uFmh5E1MHToYLVaam2pq77qU0mwWoth5Hw5wz1ZhTdQam+T3O3Fe26c1dn6bE69lBIiXC5JjvTZihIqd9E+8rTI9FfN0Uco76kh7PIIP28yKgYGQ7jVUYgm8UtrXiBonCEwNtdOko/swMMWewWQTiUNhHY6nF53Q1keUpMuM5MGx/61lXvBmt2mx/htSTpOguQBmCHd9bre8Ay86BFdJlAzhYPz295NTwlPLQSwupl0BT51iICiw5bCGN+LolLODMcMNhX3+s4T/LvRFnR90QpovGoJEbQYKL8WaTuwMx8kZB6ZD0M/Xxb7IASttRBLyQuCt+pT6I2Uc/GDtMh473g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEC/kv7196r3w8cXpLgqlQ9TjsfHw0mjuV+aiXLIryk=;
 b=Abh8M3lf0LRjS6vHlea6OGWQfoK6rsVxDnsPSbBxDACGnxIRAn4XZS04zvyRcLcbSddp1wTmZkCRDqPF0RYqph9qULQLgEw3ThuOG8mFZMeKBjBWKCbAOr/iHDnI7lTcAN2WGn+wGyB1FW9Kxvd74QJkDI2v75Y4mBqe2mABDX++nqgWILNiX2r2HEj1XG1rbYue4xQ4Ur6DWT5s9urT64M7g8Z1ReRrWi3JP5omnEvqzgAGk2zWpJCKePpTdR4q+j0MiVn0VfCYS3AOkbuvFl5GUc/R0Ay7oRMQYkPDfMmVDW7IvV4wLqZ3BiELJu3CQuIBXcpa8YenbPyTDgI8yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5293.apcprd06.prod.outlook.com (2603:1096:101:79::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 06:52:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 06:52:03 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] hfsplus: fix to update ctime after rename
Date: Tue, 22 Jul 2025 01:13:45 -0600
Message-Id: <20250722071347.1076367-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 23af7cca-736d-46ca-3094-08ddc8ec43f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AtSEa0Ni7yheGO06f2SsAhSjkon7G1WFjAPLgEWYwRfDAeANhQ6T54xeteiD?=
 =?us-ascii?Q?39abZK6pMem8lr80NfuFPGUyzEw8RcJbxA+CZpy4kuSwoZd4BHkYtCOUAMfB?=
 =?us-ascii?Q?P4EWbbf+XdgkbMyj+xKTw8eAs6zTQW/zzNGgAUX2tyHxKecDvVU5LNHBblpp?=
 =?us-ascii?Q?yfM4AXJEct1qzCZ7ZjsJeCVp2qTbD8foMatcRKPGcbFX2lIm89dC7HiKPMcM?=
 =?us-ascii?Q?b6l5JYxOufPv7YOcMmTArO22XwbBBqsWPa8eetCF7x0bJQevNteJQF7A5STe?=
 =?us-ascii?Q?RsyJ8JLMfQmQD+z3nMFw4CNHXR9aCRXDLpKC4SOQ6S8G8SbPRPX7/qsmt9M7?=
 =?us-ascii?Q?EpAMHOwwlyw/vGaD6zfCNOil4cu2ve+A7j6HfESISQVMuBtKlmzbRydmDZOF?=
 =?us-ascii?Q?E9u8Zi7xC2aV8F2qEIA45+VKg5AeXJqU8AQSYvc71XRXnwD8rg4hiEbC6US3?=
 =?us-ascii?Q?HW/sIT2B/sUJs/odaYS8Xf0jzSukZiV+6zjwHAXrP5d2wvJ85sG9iNgCLTtd?=
 =?us-ascii?Q?Ueh8Fm0WeqFMm8QV+QGel33qD+hMVuoSgL+OrGKI3C7LK1n1wKIxeEmR2xPr?=
 =?us-ascii?Q?GwrIIFhssFd0DrGGCgYjYTTFweloTAVOIKaVOKPVdeHEocGKVmMwkkMkAEH0?=
 =?us-ascii?Q?zGK0kzNli+v7VlpMrOkQNEhEosIjSWYDbPqondAQDP580KNdDEHWfnnx47L6?=
 =?us-ascii?Q?3kA8fkvzs9kWUz7ktZBSXMmy1eeYx1kWxBILZV2U7gtT5TAH6ck2DWmNAgY3?=
 =?us-ascii?Q?LP+g/2gp/E5oOQaJ7IXwrYwQWBD4Qly5h/pARgdbLu0x9ikN8aaWi7Xsg5TA?=
 =?us-ascii?Q?t0bFsRj8Cc2/ASwmkvwMI/xKOL2/x2PtbIcvqRaC5OgRvy0MkTe+HZ+gpnZq?=
 =?us-ascii?Q?mhXd+Gy5Y4RXn8kFVa11DLe1T+IrF5VqO04ex0zR8L+dy3JKr1Ne3H9Kx/O0?=
 =?us-ascii?Q?JmjiqcadohEHU2H67KxnIJi47wt2/WEcWmhyZRh0tKh29+evXovVcQmes3ED?=
 =?us-ascii?Q?IWaav3GdUR6+tOeNJID1H8jnm/QSgOVrAAxNVi6XKuXnkUWMJKewMChDH+3v?=
 =?us-ascii?Q?xgio3VpJuHZ5xbJ/G1io/deW13mFuriZGajKa7mlRxZk/V/9U4GLFQCjPy3B?=
 =?us-ascii?Q?p7XBcB5w/wZP8Aod8ManmowGBboJ2H+T4g2jZtniW+jcNIC9gzW6dcGSpY6e?=
 =?us-ascii?Q?IKq8SoqZynUxMo+XkSd+6suZnmJI2J0vA1/tfKfPo10z1zJMcj4GBB6Jr7rT?=
 =?us-ascii?Q?kwtiX4p6K+9bPnYRdholDaMjuyZOTIfOMsivCiWJiw6sdbCM3lZZfs4UeGo8?=
 =?us-ascii?Q?ga08afa3lWjvmEa9ylRD8ztpqsT3MEkvSvB+CjADYGAuFd7ETM9kxgnbbJAN?=
 =?us-ascii?Q?O7zx+fYpB6/X0bpIxa+XGmWI55+qwmK+BRtHFWeFZ/i9M64e9vcNTdbcHDK6?=
 =?us-ascii?Q?Lm/9x/Z+1eWpcTxuPCSPcHSeTKMpM/m5nhDgOsAB/Iw5NXjeu5WX6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iQETK+O6cWwW4dUDFQ6mhbEbteQYRYRkl2hOtdUEfpERKyw7BPsFWhJbvNBN?=
 =?us-ascii?Q?uVvkxhklHCA5CXwz+7kPbLifocBkk1q80GNKPW9UlEUnXeIIeteLExP6qLxU?=
 =?us-ascii?Q?VnyffUIwT9irYMPHQrs1elIMd4V9oWT0w/y2xeQAZ3Gv3SJgPVw998idaZji?=
 =?us-ascii?Q?ZCAW2x+IPeruJoR9dScO1wFlpI6Nc2aMDHbNEacavekMmSS4QelJDiEA6WGb?=
 =?us-ascii?Q?tOshN8s+tOh0A4uicRq2enhGQLSfwgmo/OB8avtaHqD35sdb06dg5NKgJaLB?=
 =?us-ascii?Q?UfL28rFO2k1wtVNSj/ueRwtR/0lqI2gFy5ZQzF5WLY/OHrupA60U8bXaigj4?=
 =?us-ascii?Q?3lzJcoT3xdAYyA0EPW9ankL7aty/cOMsx08L/daIdzJB2F18LcODF59eXB7x?=
 =?us-ascii?Q?5QQjSTyQH9cgSupRA3SYJCYOESke2DjMAd/v7PD/AV7J+KtT82r/+ohM+Hdx?=
 =?us-ascii?Q?emza1QqSzPJl8bO2Ke06b33mwvDYn9H8gYvYDE+EWmp7FTFgQxU1WcRsHDCd?=
 =?us-ascii?Q?rnoWnQZcKssUFqAwpTqdQyKmqs9Q4mlgNQJaxtzAE+jRW6k/LWpq/jc8TdAn?=
 =?us-ascii?Q?D7jCN0uIvWXKou3pfMbIrSVkpY0ywD4OGd/HBieAmm31NKdLB2MVw+EgePF3?=
 =?us-ascii?Q?qTiAzzCu2seVs3Yl2rVfySgXU4JfM2YOvrbMu2U5/FTxJgjHVx2CaWvyaI8p?=
 =?us-ascii?Q?y3WXIfq4i2KRuf2oEKdMNSAVoq7FELHAca1Q2ajVI4jcVDRTVDuofU61EOln?=
 =?us-ascii?Q?TNqqOqKsRWLoeiUFANjueX/T8UEmv/37jXgefWeeQh4LEUtWebl2gDgq3NhW?=
 =?us-ascii?Q?kPi17rE46oP3rysFkYjLqZvZpqhAW1ET3S6QPt9uqqoB+7mkQth/3ZVIHTV4?=
 =?us-ascii?Q?59dQ+/ClQP2TNG31iNGGoI2myeW05MRmWozciiNHrH14qDuUuAObl6+ATtsa?=
 =?us-ascii?Q?5DL80Rzl61KNvKZ0zdIwXEBdv8PLq6KEhWdOpfYOThDZuwv9eGhqPZqM9m7U?=
 =?us-ascii?Q?bHd+5Mjp7q89Iqvq5qlgHoj1QsIk9KXS6Gb9slZexKaTJhcZ+ZvUSaZdw2a6?=
 =?us-ascii?Q?jBMK/Tc2BQE7A9Vhr/K19rGTu9hXqG3rsw22VmGNWPfuF7ULPzQg0ykqhotP?=
 =?us-ascii?Q?pmRs/7mpGNeuoD6/OmMuh+QfP8hfT73QRgyXlmJe5zgZ0M4mPiBsr1+fpv16?=
 =?us-ascii?Q?CZInCZqPHxllx/gVnc/nnzY5VmQRzKbDlFOwQi43W6QepHJCys7WJsWa8A18?=
 =?us-ascii?Q?r2jlu0siIuOb/CHksS31SbD45MVVAy3swZoxojQz9uKhiI5jBIsbqHBRSV7S?=
 =?us-ascii?Q?nxYqaGt+cY8j7EzgJSr6tfwtj/rCfHzFZb7H60V1u3zVe9QqPDedf9m3vIrd?=
 =?us-ascii?Q?kVBQkcv6So658hjtP6IOYsnsmEFx6lSRd9BPiyospZy7yLIxRPpmy2x6wCDm?=
 =?us-ascii?Q?Tu2/YlkOwLRJnAPDy8YhT3Q03YR6VAvdjcInoFvhlfbyO4wFUFW3WGSsmzjJ?=
 =?us-ascii?Q?H9jOajh/aG9N3lggE2d/TSHQ2wnPU24txHU0+YgpNwlFG7BapZhxeOKFzNRf?=
 =?us-ascii?Q?Mq1+RTF1x3jmf6D5KelVAgH4maYLNamSukycWt18?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23af7cca-736d-46ca-3094-08ddc8ec43f3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 06:52:03.6572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YcD6cUz21YxNyL+WlLDcN15MXETx4TWGMX9efkc5SOroec0e1flXLN7SVW8mR64iYH3rbCj5+IxLQFA/c4pkzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5293

[BUG]
$ sudo ./check generic/003
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 graphic 6.8.0-58-generic #60~22.04.1-Ubuntu
MKFS_OPTIONS  -- /dev/loop29
MOUNT_OPTIONS -- /dev/loop29 /mnt/scratch

generic/003       - output mismatch
    --- tests/generic/003.out   2025-04-27 08:49:39.876945323 -0600
    +++ /home/graphic/fs/xfstests-dev/results//generic/003.out.bad

     QA output created by 003
    +ERROR: change time has not been updated after changing file1
     Silence is golden
    ...

Ran: generic/003
Failures: generic/003
Failed 1 of 1 tests

[CAUSE]
change time has not been updated after changing file1

[FIX]
Update file ctime after rename in hfsplus_rename().

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Tested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfsplus/dir.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 876bbb80fb4d..e77942440240 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -534,6 +534,7 @@ static int hfsplus_rename(struct mnt_idmap *idmap,
 			  struct inode *new_dir, struct dentry *new_dentry,
 			  unsigned int flags)
 {
+	struct inode *inode = d_inode(old_dentry);
 	int res;
 
 	if (flags & ~RENAME_NOREPLACE)
@@ -552,9 +553,13 @@ static int hfsplus_rename(struct mnt_idmap *idmap,
 	res = hfsplus_rename_cat((u32)(unsigned long)old_dentry->d_fsdata,
 				 old_dir, &old_dentry->d_name,
 				 new_dir, &new_dentry->d_name);
-	if (!res)
-		new_dentry->d_fsdata = old_dentry->d_fsdata;
-	return res;
+	if (res)
+		return res;
+
+	new_dentry->d_fsdata = old_dentry->d_fsdata;
+	inode_set_ctime_current(inode);
+	mark_inode_dirty(inode);
+	return 0;
 }
 
 const struct inode_operations hfsplus_dir_inode_operations = {
-- 
2.48.1


