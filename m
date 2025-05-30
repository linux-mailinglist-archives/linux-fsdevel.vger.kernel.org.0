Return-Path: <linux-fsdevel+bounces-50154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FE9AC8992
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8AF4A0E42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 07:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BCE219A81;
	Fri, 30 May 2025 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hole45yL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011058.outbound.protection.outlook.com [52.101.129.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15142217648;
	Fri, 30 May 2025 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748591815; cv=fail; b=TWqCWbd6C7dE8XlszQLIPXJVhagU0f8UpGCuo48uOrUb6Ul0GnvagpDI75QE15SyD6sVsMx1f7EOJ5i1TyHNZBe7j5ECyLwauV0T6b7ZqChPmUslHQaoGJQFWZXqsDKVKZ2fraY1rcsG4TonesFquSGhuf4/tIowUo/hC+J3giw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748591815; c=relaxed/simple;
	bh=i42GsSuNuvP1aLmp3TW5ib5M08Qb7s+6i5htW1ywy7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pHNQQssroAHZoMQ8hP9kDf3mk70rzXK7imkKTDvSZRpxQgLGr9ZYY4Px5UG4Scu5WhlH86ipRTkNLYWDI9Q4J3ny7SWs7oPWew2RVJF9aII8mqTftXT2qGSieHzWPQ1sCHJtGNqOn30wV7qC6lpxqLy5fRWoSxudYurLuQbsFOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hole45yL; arc=fail smtp.client-ip=52.101.129.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oe8iyyiF776J40+WiI72FIdF/kx49xGgG6vYLnWArdn+MXFxhqhhxRfiGG1rAvkZOcpyKK7a1s6nQH9V9aSjUPSpX3DlykiTe4yMJudRLz3lkYWVk9ctBlPN9uqT/P9biTIJ2S1sbx3uyaV4HGTNZx8OjCwi3ewc55mBSsy18KDakFfCNPzK3Prxeqeb6lzzosQWb3OeVvmwrAHZwRhe0PccFR38giJ/8AfueJRKog7lqvr5KsSRmo1q3J5E3uD52gL35JGYOYlL9TsEQm7hLuLPjAosDt5xY1SQHLXHODg6g9u6yv5wQfBoKG1eATlaffVQ431waGpDdxRFfcBQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4DxMMmWQnVc5zzchMYl8+vtCkz3OstMDvL44sl5MjY=;
 b=fcdPqsqWFe2eDBmEvarDz62e0nDO8g53YVaU6pwDfiOr2rxHnp8Dyl513T8pyWG4LSG6VMNY01pvYXvxJQsNsbhSyrQkFCJMNoGRbn1Ji8t9kIyZA8xKYEdgXngP2T2lcZN2VzqfFjdAuDoAc8ft13Hloo6v0ZhmqFM7M6fPXdUX38ngqVSWvIGVRCy6KI3cYPAjakg13U/QZ6XXkqbTWmxLi/dsWeTofZ3aDcW9y1JW2rIin4zDkQUZUOhu6dG4grl1wnECH58SmbpGZzg73XEAiS1uT38xcD/Mo5GcwtwLzDW84ihs9po6xcpN1NugzGWNanDHk609rf0rkt+rrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4DxMMmWQnVc5zzchMYl8+vtCkz3OstMDvL44sl5MjY=;
 b=hole45yLT7tv90BkztjWWl0EtqcON8mLW6ZqiRaINEPsbi0sb0gx52xpC+YeYsiAiODcCRh3RPDPE3wWO9VjJnBqdbDYnORB3oxPTeNpB8EoFWrGmxqGmrs0aOB4YNtar8OKIgiieo9/r0acBjC30bSWS0QzgmaE1S/xmXtG5Lgr+zG1pmGY7rhSoJRMWDiErDbOuSN5g7SuiQ8UKIf1NF+0DgOXLxXmREFXsctuf4NFWS6Cmbmu9NpMk5iXcGJJ+LtX7Q78wiD+JMIN0mXVpgx8KyDqQ8QCgnhnfcYzQ2BrlakMrRIgqWC5ftqGqcVNrcV3L7FbHMt/P1LkISXBDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by JH0PR06MB6415.apcprd06.prod.outlook.com (2603:1096:990:14::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 07:56:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8769.022; Fri, 30 May 2025
 07:56:50 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] hfs: fix to update ctime after rename
Date: Fri, 30 May 2025 02:17:18 -0600
Message-Id: <20250530081719.2430291-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250530081719.2430291-1-frank.li@vivo.com>
References: <20250530081719.2430291-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|JH0PR06MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: aaab46d2-8431-4643-545b-08dd9f4f887b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z5jeJWD7Ko5bOolRUkYYaftXf+TqgpMtCDmWeZ9M/VAb0o8vPlD3p0PyaT/D?=
 =?us-ascii?Q?IDPOzLbCZKyrDcUODbusjjyTOYVvcWgDzMAr+hqGu6NBptU+GwVSWgMNLpgP?=
 =?us-ascii?Q?OeqB3RRzmPkCqakruC+x/zEPcMhoSnrPoJSfV9Y8u7zS8Czq35WZbSi6ViyR?=
 =?us-ascii?Q?TRfaOQ9qaYFT4qBMyPXtTibDLrhS2CL4RMevvykVYVUCyOyX7CotvEu276+s?=
 =?us-ascii?Q?fuOzeEhUyp9/Prj3hCumHVTIJYTPsbRb278TRbnjOdq3f8pvAwQSjZjG50C7?=
 =?us-ascii?Q?yK/qTD4dhLsA6sNlVy+AU0bpGV/nFrs51aSa4ijgU8EJUAKxT5ofScnxoLWq?=
 =?us-ascii?Q?Lu7wRmIVU1mXPE9kaIWdRSXudDL5QCfu/DMbQzdyVFWVyjMNwFJ2W0G5/CJD?=
 =?us-ascii?Q?CQQ2TOf1o4+NCDrPgZhjjOSGxFQTxOrv7dJdrA6XrRDeRjoPgBtOzB+IOnts?=
 =?us-ascii?Q?zSAhPNbPeiZtKswU3XtZ8eUsvVPesck8M0uic3y/LvHgCObjbJbd16QriaBX?=
 =?us-ascii?Q?JeZsz4TTn3zAM6sNy75+w2WvIoQ23srk6pB/SbLqOi80NWSaCkNLBmLrSjLV?=
 =?us-ascii?Q?yaLr2w4XZx6aptBuGQpKEjpd8I/MewX30w/8n6gBBxe65mMcbgOzAoQYY0On?=
 =?us-ascii?Q?FnmWI1ahM2Ueos93wUPDZq8JHugdkotR12WRp0S6rHT4EBtWA9e1+IM1Rm1i?=
 =?us-ascii?Q?pCPs5v9QCwS66/wxCM5MyY/3o7Os8aMlbUpTdh2zXYiBKwGxwC5up0E354/C?=
 =?us-ascii?Q?Tby+BRmquJ3rPi8njhhtA47kGtJQAG9FfZR8c4rVNZk0jD5mVCCuJgzkQNK8?=
 =?us-ascii?Q?dHmYY2/ljy3MCuMXMwF4efEwSXKd/zIoRYx2nzQS6LY1UM22JszBAi+A7lWA?=
 =?us-ascii?Q?ohOQuGyT4yEb1Q0agQKPB2Cxnd4TNghhyvXl4CyP7G9DDF5zmjJhZP64JmYw?=
 =?us-ascii?Q?yxXpbhUcraKPRMgXtL6vaMfVPeEJW/HKgYp196a+ya1iVxWpit8w92TE7Wh5?=
 =?us-ascii?Q?S1F9SmFr1L4GIcyegCyZRuMibPpHYSvxfVIYf1pWNFh/4Jgf/2tGWymlAb4K?=
 =?us-ascii?Q?z+7BQJkW9NpCZGWQigC74aR4x3y4BKcUInz7wjReQgI9zLxDk+vufSodgWjG?=
 =?us-ascii?Q?hZzCRK1XfZOAybM4uakKIBQZ1efqIFTFDcG0xUHga+7wMA/q7rmLSCjrMVzv?=
 =?us-ascii?Q?FLOw4oCjV0POLjOtUiAizoyWPgISWgPKAkjd3/zKGDpkMfTks/Tqk4qJ30m5?=
 =?us-ascii?Q?oVuhvtUebT2FtJKy5mnPpma/+ArpL16TKTj9ZugFWYP/3nI265DLiHh5RKD1?=
 =?us-ascii?Q?T8wK4kPxEdssHgDDhexPO5Y3BEM5bgfVx6gbQOJbLu/c9d2EZoLH3hBqnNOE?=
 =?us-ascii?Q?4W9NOdlPBfziZP42H9DMOf8kfDik81APGBmo1XUagE7nGj2mwAupJtR7MA8z?=
 =?us-ascii?Q?zR7VTNlDc8B9GadQRP0p81wbRzsSpJvOiqm2gthYkGkXU4FXIL4fkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xdMYOjFxoZczgMFAWrryQiO+i8NnTs+hc6fhGqC9hf+c0GgO4+VNR3k7exBe?=
 =?us-ascii?Q?X1rmpkcQwJxMBqffBjIjJQsRVoBIkpvI0lMoCRWjjGVUrVii72dvMmaC7KOZ?=
 =?us-ascii?Q?htIlXv4qDkshTx1grxcwWQgSx7Sh+1Scwal7mKFMFSCXxxQZsub6JAKbziYT?=
 =?us-ascii?Q?VK9JggEXgLNHCePMxG3bbeNff49IOXlyQCIf76oy7QF/LKzfQO2D9U8FksNp?=
 =?us-ascii?Q?pDJGfEFGN0/c5uTHhfnIrADQaWtw32yfPo/zJ4yaEYBxeID33iUa6aoug2iH?=
 =?us-ascii?Q?urDo5yNVQgxGoaccXJa1RHe8qmpXgFXGOGaDi5kE082Bdf6itBbacsF1f4rR?=
 =?us-ascii?Q?0pbm/f1wVkFkUYuAwraNKaEfgDoZDjtTAXQw5QnK5LMYlNTkZnu53OqFJj5X?=
 =?us-ascii?Q?VvNghQRkg71247mBbxY8c5dNL4E2XbfA+2n4TwpxNYhw+BxzWIWnZNNXsPNv?=
 =?us-ascii?Q?cVCI9AqXNWMR5yPcPBbnj7qyb8PnBsWeJpAWStTHUnXcsID4mvnYU7939aV3?=
 =?us-ascii?Q?1fTVWGfg78wp5IPoADgavsG7Dy1W4UAlenBo8kdn5Y0r5uR3cGpkuotf+2/G?=
 =?us-ascii?Q?mSKNLY+XWorMFyclxsqJ0x50hdywel/DYSyHo/WSzJRd/DhrymUPIqpbmUJE?=
 =?us-ascii?Q?UDkrHyeCIhwLLJhDREabaKdlXpLPoQKoMD39ZUVj6SZZzKXfEL/2m7/+qvgt?=
 =?us-ascii?Q?2vAlIYl5MwtPZZB59IfNwjyx+7lXI7rz5chYNJr0R+MrCaqpfkNEIYcYrwDD?=
 =?us-ascii?Q?NDn4ECUX7PH6vbwgp2woV2/ZO5r0I8cx54Dvz8j1MCRQWnD2ojf0B/HxgUya?=
 =?us-ascii?Q?gbEXrSO2UY8bKixqjLlPn6X9mWg2eZiFqEMGGjN97FPKYQvbZOQjtWPBS8Pn?=
 =?us-ascii?Q?9XDQXlC1sZU/QegZsHK9ZiEHqu1lz4kGEMOIhJel/2flkqD8SFL9uiry5EOj?=
 =?us-ascii?Q?zhNNHFEQwPYzNhPnO3U7dHenDSd9+UgoqADWUzti2z1dN2SY0bG/XOzvz888?=
 =?us-ascii?Q?SKuxbx9HF/oXVlAJqrDk5YE2El46CJx/i1zw0wvZnKRSmPX4mweajgUC5MtG?=
 =?us-ascii?Q?tRl1ik9OR/eUhnvG46iBfNnjzhXDTwJOFlq3NOb1msnpYJTxnR7rZKWnUa8g?=
 =?us-ascii?Q?2N/FgKGVFgOeeaOAM+aKbzo5LkqqtaLHut/Y8dmIA2CdoB868fcdgMPHImGR?=
 =?us-ascii?Q?5i6KrX9r+nprCnqXwWz5v/3iMLY8P43YeAEUKoCEaIYY0kqXpN98QGAR5n1t?=
 =?us-ascii?Q?eTnGuraHiOWN4n+x8oYzYURbfwq5EPZAgK/CsQpLMXkznefpxxxg/uj7UZX/?=
 =?us-ascii?Q?sk6C3qZlAK4OvUGQYhaTVFiwRAY5E4QV/ANo+48R9F8OVLZZBlyyEG/ZocYZ?=
 =?us-ascii?Q?X1nCWWgzwzDoHkbh2mNw838prXGx8M6Gcm4KoTg1SAF60WvxEwiFjCoXpxoB?=
 =?us-ascii?Q?l2h1J64pkcTmac9w+WitTs1A850Vmpkw0oTW5Jy1hHSwrLIj1K4Kl19/M/YQ?=
 =?us-ascii?Q?SFSAa5wAxaJDc2E95oDDuj4mmyHA5PAQbtSywbNTUqU6EJJFdUM4JJy74BcT?=
 =?us-ascii?Q?8koW+lXIODh/onaLzhj/2l9HarHgepa/hWpeizvk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaab46d2-8431-4643-545b-08dd9f4f887b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:56:49.9468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RT1K22Tbq1l4/66MCzAY7ySyltg9+OLncUyfQpZq1kAv8Z+mZqt7K6XBhTYiYz1xUvI5uS8KxcUxKTxG2/3JTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6415

Similar to hfsplus, let's update file ctime after the rename operation
in hfs_rename().

W/O patch(xfstest generic/003):

 +ERROR: access time has not been updated after accessing file1 first time
 +ERROR: access time has not been updated after accessing file2
 +ERROR: access time has changed after modifying file1
 +ERROR: change time has not been updated after changing file1
 +ERROR: access time has not been updated after accessing file3 second time
 +ERROR: access time has not been updated after accessing file3 third time

W/ patch(xfstest generic/003):

 +ERROR: access time has not been updated after accessing file1 first time
 +ERROR: access time has not been updated after accessing file2
 +ERROR: access time has changed after modifying file1
 +ERROR: access time has not been updated after accessing file3 second time
 +ERROR: access time has not been updated after accessing file3 third time

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
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


