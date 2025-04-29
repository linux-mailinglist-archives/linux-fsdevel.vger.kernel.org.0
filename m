Return-Path: <linux-fsdevel+bounces-47640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0CAAA1BAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 21:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F6D3AA63D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 19:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D8125FA10;
	Tue, 29 Apr 2025 19:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="h1hohuqA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013003.outbound.protection.outlook.com [52.101.127.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7656518F2FC;
	Tue, 29 Apr 2025 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956529; cv=fail; b=otJq+m9MfnX1jXxfyW2UjZrXHZ1OrXiR6D3yD17+hOoaWdS6lKyLKbDP4minbAXoHZjzmTkwDPtG0mxJ3aeaZvR9yPM+3+84qKi1YjeyXhA34q4162/oPxnxkUGK16tWzpGt4uBjdSwKj0YiQeR87Z/WP0y1K10w/DRUMMCOBB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956529; c=relaxed/simple;
	bh=71XIwIj/uyzNsHcFzZW+ursAHPZ5+EI8a4IS/LGQ9vw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=k90zUF7PU2ylWIPR0lZPps7k3Y51k32nmjxkZddgsbqWUH5OYqTYxtj53ywaUoQLmf4O/mNkRgKyauuhj+Q6b+CSjWJZeISlSTmgr3c6uIFZrT+VxBgd4hcGnSIYNEq+CYujo+L8EV7Ujnkr/Y57T3cjxEP+BloZekUGLn9KT8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=h1hohuqA; arc=fail smtp.client-ip=52.101.127.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IR+jUSQn10PCtouKc3032XEL7tCoJW59qbg+ltNhgqR51fDRKm4sBYyAV9G03JqKpCzr9lFw1hWOj3dcJMvpQrpB11eS9sONtaCYzQ4icFw9SdyVYfvx01ZpmKQTarg4b47Kdrjr+GHo5vtaI1ZNaUFK4FWQu6wFmFAhFXV0u1S/B2nBiqr65mzE8y4W/CF8WzxkE3r/XoXQkCtKxeMU2PyO4eqFncxI6vGzdvaxnsLDmy4OkheNfLWpFo8mrfpf9x+umWhB3MsLlmwUHIsu01CiQC2ILlWTgAmo+HqbB2wTQPA1hJ0/1TW1sfksiSEkCFJT9pKk+Cv/kuMXKob5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUfy6AN+EbkmEVhxPMnoKxNDL/eqEFUtXpgKuj9CFes=;
 b=TbhUTFp1hbEGuujWESPp+3sdSiK4yrBlIX2gdv69DoSA/z8L+b/3uGW1mSu9goRrHooq1DcyzAAXecmHXj35PJrbQYwU9lIS8B37lR3d1NnKOilC/vIfXDCJlp9uT7aD6u4F5XSg6HVLGdqJSeAtUXyPwWFbtZTgjMISbpaD08ylwvxmBlgD2ZdsZyp8qY1B4Z94j7GMbIvbAc829r6LSKf0+01b5XknLeirDvy75pHROkedGnaCo31M98obTzbPP2/bxHTiRjxtZRSwJvaTziawELOnHn2EA+Pm62Dhqy5qCCieet5X5flaezSRBiogawl6ZiIg9/6sEopD+BJ7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUfy6AN+EbkmEVhxPMnoKxNDL/eqEFUtXpgKuj9CFes=;
 b=h1hohuqABrvhdvAz7hjZjlAcG7vv75/PXkXgyTx2J61MFcBKjr8ah0LBcrp33qCmwEfnyAvuyQepA/Huw5zK/le9PuqymbnOoU+ILtRA8e9tMN5j1tSV7Si9T0XgcPeUIta0RQ5UIAGtiEiTQsKIP9YPxafloG67hzYU+rfa4M2bz7gOVwnTtjKm0tkBXORIh7BKBA/omOuH7VmrrVyz0rz/azThY+eReYx1N9V4SgToYOw6NfgcNvDlvB22ySoAu0jg6IpFln/x246iucXxElUrKgje3/ElkqvMj1GBNXsIztuLJer7Mx1dC3telPt8cUWBo1mIb9pzbAecvSMqNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB4983.apcprd06.prod.outlook.com (2603:1096:400:1ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 19:55:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 19:55:22 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 1/2] hfsplus: fix to update ctime after rename
Date: Tue, 29 Apr 2025 14:15:15 -0600
Message-Id: <20250429201517.101323-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: aa0e28f9-52ff-4e0b-a737-08dd8757c692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z9GuQFihoL2W3Eby6xlNWuuF5hUrAPOYJ5ZCW3oQXB7MRxcCrsWLXo5apkoa?=
 =?us-ascii?Q?wUaRxNu++saV82VNTJUOm1Z9xp19CcmVqWrG2Aitv+a/vCjMB30tuDfpeJfJ?=
 =?us-ascii?Q?1Cdw/hWcdkVSZ8E+yTiUDoW0o83clZ1lf7lxgZsfJrNoxZZg2ug6hhC1kQMe?=
 =?us-ascii?Q?n88VgPDb0sjj5b7k5/qlxkIOuCAyLNQIeRfzE5ruciAYf0mNXPgqngd3TGjx?=
 =?us-ascii?Q?02uxD+HOX55DBSBE9pg6OH4EBEWriMvDBn91rzrjFyiebCmFjK+ikBh5XZ+f?=
 =?us-ascii?Q?3NZ+yUt8onhxWIruUYiFtov9G5+zkQfsrTaf2RCKpM7dVCR3VJ6JQHJ3TGnM?=
 =?us-ascii?Q?6OK+SiJMHx8123iCHzibfT+TGIYeXad8EmbNZgYjL+QEdIxB7sj4qNpVTV59?=
 =?us-ascii?Q?yYvriAaFN1sJtNkeMzE8+VNvaA9VtF8E3X0q83lpHymWzPBMU2u8WT4E9rvi?=
 =?us-ascii?Q?jlAcBx+SDk+41qtVKxgDvvEPI63rKI2i/sdAUmZr3aGQd1qpZ+iv2MfPqZjL?=
 =?us-ascii?Q?tH5r1ejKn23mzevoRXWkx2AK4TIrGQ0tQLzQ7WKOHFDK8evMSE3scVh2OHsz?=
 =?us-ascii?Q?9Gw0H9xddhKQF6exrGiBNH/oNh2cA/lipfol0AET/tYm+OvTAnGSc1sO5Sgk?=
 =?us-ascii?Q?LLx+l6u69TFaqDOy7bKK3boYVBGLeDFInFpbgfRE+P0I0xbqUnDe9HC/hx9S?=
 =?us-ascii?Q?i/qFT/a+a2q4CVT+RfOIaTFaeboxjt65cX3XUzoLmOfgML1zeI3vTuWb2QQX?=
 =?us-ascii?Q?4OfNNB2RoejRNN3DOOhKWoxTWkM384mD5+Y/wsZranS03y3fmWrxDqBnVzhC?=
 =?us-ascii?Q?qLM/pfT08nvZ+AyfzVoYIJ/4OV5ASbSFkJ1HgJ4oqq3z6Xan6tBq6w61QGg7?=
 =?us-ascii?Q?mFRnVlhYfl7kNjGG4auWYBRffWiYNqPtu7DOWVcQcEs7td4i5lsF9S15dAvs?=
 =?us-ascii?Q?BdsrJ30yXnwiQdEgFT1jyZ1r7TXfgR3yZBB19JwtWVABD+NlpbrZ1hQepsK4?=
 =?us-ascii?Q?+LsThaQIax+BaAafjBgc3+AoCtkFjrffsEe4mDA1AxcsZy9QzYA3GnUt0ZH3?=
 =?us-ascii?Q?p70Dv8VL/EQ9lGG7tDXtHDTbjb3esMRSNM9WMum0g/QyS+5okf+G7Daagk1P?=
 =?us-ascii?Q?ll1lZiywITtpEWA4h62ju+jg4spgdbsLxU6IVBkiZZ7DtEa6zz0kT3Hzew3e?=
 =?us-ascii?Q?mEKNHM0eDypgujkITZ+NkbRPGz+K0omHOK9M3o7Z+jdbe1p3lRB71oXXLfXO?=
 =?us-ascii?Q?7kqBOO8HTFeNqPQym6adfPZhBfUb5PGDlsUcRqblQOuP6S3iX8mBdDt2kQ55?=
 =?us-ascii?Q?kIJwNbhSpjajUuLHV+MaxuJy8cvyBa/7UvqF4AS5WOOs1o2XbHdGbLedhskd?=
 =?us-ascii?Q?PuqohVg3zUXYYHslCyzja5V/puIfLuAWgtsL0cBua18MaPFQRSfbMwDMx3hv?=
 =?us-ascii?Q?Lj4r5/Nqrx155o57vczrjwlBnsUKbHiUVgx3NcybRKY49hscZOLbdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WM8UebvOvoxDLcWQ+vQj6OcuIcI5mwUqO7cf5+B6FEuWHCXMubMdC0KcADZ6?=
 =?us-ascii?Q?a+PaA60b5/gOm0tp0PyE9VjcSQKLPHfuMYiyZ3tVjFWXN91/Vt7c02+20Tb0?=
 =?us-ascii?Q?74yB6SRg2n4jmiUdufnFLFCSO51EmSDtM7kvHywaIRx6ZwF+95fS2SNxDtVz?=
 =?us-ascii?Q?bPOPdPwc/0oU/193P3QkF8GUi56ecPE41GPkYGfpapOq6EAlaD5P1qM1NmIn?=
 =?us-ascii?Q?Bn3RjSVEkjyI4ayvPmelaCnEYMhEaEgKhs9eEYRi539owLqkAoNl/c4Slu26?=
 =?us-ascii?Q?z1TvPkxgc8kSAwtixgypYL3qUC4tH3SAm1zLqCBNGDQzBjfAbDlc0/IrSI8R?=
 =?us-ascii?Q?VqAqPRTw1FQG152ZCnkxpOmmuKwHSnbbBTfgssfdnuw31AaC1E9c1yUF1fUN?=
 =?us-ascii?Q?AhbbgR9Cw7Wn44n9QXAWoehfse5vA+Sk9uCQjXqeeJVR0jxIEx1BVMUN6Q2D?=
 =?us-ascii?Q?FLhabtpIeQQv2AqsNkuddpkrfyOJViV9n5Pp7fS09fx/DDbyz2d015ItXelR?=
 =?us-ascii?Q?m8ot9hrBljfv45+Dt+hHFgV9scilDFQJyD5YrfCd8Qy3P//xVV6+QujQZ/nt?=
 =?us-ascii?Q?Zs7ynf++GFyfdECNzvv46WMWpJOJ3fzP7YJETBH/nEXs4GzqVhTbsen3hyk4?=
 =?us-ascii?Q?yJtPppyDRtkO6rie/UEfIka81D527TYxGXoPsoL2XSNFSut9hm9F1lvkR+vE?=
 =?us-ascii?Q?DrSpqN/aTIoySyXETKidZ8P7CgasParE7kOdeHqM2Pkl5IfQiJ22veh0OfSp?=
 =?us-ascii?Q?kt3ycc0xOy2OsdnUP+kTuTLrYBrCnr/mWSq20VWp0/y1c7KUMhYbnSbg8fmZ?=
 =?us-ascii?Q?oba+dieSiE38PdckrWfBUIxVKPGF4GA+BtNy/T2mFi3n46Vm+2i2ZIoL7ljn?=
 =?us-ascii?Q?r9B9fEah9Sq6zc+4dgnTvjqHe7bE0oaaESb2WWtTTcm1gLC0Wn/Dl+l3Vmc6?=
 =?us-ascii?Q?PsScaXdEA6B48relErYAYo6wIgGk0v2G76GNfA9okKLPPwzODPAm1DXbYaaM?=
 =?us-ascii?Q?hsl3cg7zypr2Qfvio4Ci/YYTbs8QgxQ9NSpMVl2ntbxo8Mo912tpZ3ly92yy?=
 =?us-ascii?Q?rUVj+/Wy0aF02I5ykSCR9ZWywGuIItWSJLU5jtrIJCK/Gy77/KnCj6Re6D7l?=
 =?us-ascii?Q?wCuPLwpmG68uNvvSD8yljGBPEkeLypsYbCSu6ku1Zqx4lZnhTGLzwaEXw+59?=
 =?us-ascii?Q?PCyBZRdGOA25EgC+V9lAuFZVXBFCdqO7wHTBPNliz/HnqTM52ouaZ983T8i6?=
 =?us-ascii?Q?iHY3k+MeWoq58sz9k0V5C0hkRWYKGGRLa2r7DUHAYqgd/y8pKEyrv3hIq/Iu?=
 =?us-ascii?Q?jd4xntPn+wMVt2jVH3YBouUGXUHo1Gtn+YvU2ibY5OiT6b6H3a0H4vIVJsT2?=
 =?us-ascii?Q?6nxeyI1IuGSzhPGJRczuqG8nXoYu6qiMBomUqbvZ9JKE0yvDsxGl58mH34Vi?=
 =?us-ascii?Q?3dTDTlOoT7mVk/UHexsqQfAaqDtJ2psLtjODAP9FUhdT7baSoP3oaLKIy1Mn?=
 =?us-ascii?Q?XlTRwOQiXFlJJtEzSaLrGFm31MBPs8Dlg5fdd61avz/gSu9i9+Hh2w8OmIyX?=
 =?us-ascii?Q?Mkv2OHVukOC5yv2CIEb7VS2DNc44nqDOAxv3bnRj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0e28f9-52ff-4e0b-a737-08dd8757c692
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 19:55:22.2927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbW+XjMSXpXIc0gNyzisT+OMXlKDI1Cx9LcN4epiRUe8DLgo9UK5enp3pYn8EcUf7G7Ww6XtzPNcGWYLv0WaqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB4983

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
2.39.0


