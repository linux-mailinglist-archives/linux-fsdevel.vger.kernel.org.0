Return-Path: <linux-fsdevel+bounces-50152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41524AC8991
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E783118971F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 07:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8F5213E65;
	Fri, 30 May 2025 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Ld0oaUXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011058.outbound.protection.outlook.com [52.101.129.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BC220D506;
	Fri, 30 May 2025 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748591811; cv=fail; b=aGKp3oykDKPszowQ86W7zChPt4vDj9GXmCJa044z0mMqa2xsLbiZfCIa66rmB0AxnpA4AUc3aSvyA1W2hggewTzrxhL+sPOB0OmdgrD/C/yj708Lkey7KZb+pcgt97m2EqWLVobRFolDyy4vIpG9hDQd+sFnEU1xM/50RaUZluk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748591811; c=relaxed/simple;
	bh=Dcy0qV28QZEqcFbQvhM82XlsukOU+D2uXqTidTCT1i0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UC7uitG7n5BeS7N2SIKSILT/X6LWIawYk4O7O0viIb0DhTYzXnE771phrDhm4EMCw9UQNw382PJFGIMSnlYQ3qk2TnrlSshNgorQfN6UfHWp5abkK5nfC3II4nZ+OXkWOmCSfnOSIR/aJZpafncYBlXkAOh7hFdDrUceLSl/vKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Ld0oaUXp; arc=fail smtp.client-ip=52.101.129.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqooCeOZwuvKHor7sJBQ//JbkIkEnlJdIFQkj5k1JC0vTgwMgXnlfBQ6u1fyUO5sbNF6OdoxcYWR6XR2H//IAv+qeQPWHrAT3TAAPFyJrZK0tDvrb5Dc2xLJ3koKvWQeqN/mMYoFMlrjcyx4EW6w5y2GzIYhDy4tmK9AlkHwxzHMoPHDnE0K11oqT/U+YlSdakiXul67W87MB1DZzHCIaOXK+HOyHbYwMq+IrFz4TZC98VUAxew/hWt0dijYzjFkV3HNK0psT+hFR8myv7GbUgGYTd3ODMVLDk5+Jmu0dYUQfNIenQA21xKhfJSgMyTLZXVkrFPgU0AlgvDtOFCZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEC/kv7196r3w8cXpLgqlQ9TjsfHw0mjuV+aiXLIryk=;
 b=MIOEvxpUsCMgwN3Q1VkxSdirbxAbbdxYnJbS15W9LtazpIfK8TlWGI+tdZWTAhaxtyH9BZPSVk2X0dg5L/xFAsjmBBHeVPCBreF3sWfcZnimEhFjziWYrjPXfXcjmpdVvpyqFqBRH/HaZ5kykADmeVSXAOaV4NPSu0v1lyR066uNmtJOcvxiqCxL1GWnEjaqiOZ1fnjeIh9vtmBGENv+y2CdrSoEKu80u2uPNoQVtWj1U2/pGdwd4Oc/68G9lgHY2bmei4u4PUmHz9e77iGwh2g5/j9baye8r2rlVDU7ElrYtsZXeVzov2tEcRTi+QrTvfkcJPyq7qHui6ZBvWHj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEC/kv7196r3w8cXpLgqlQ9TjsfHw0mjuV+aiXLIryk=;
 b=Ld0oaUXp9kvpveb5pb5DQemRZFbA1GbnZ72KTt7/PhEn9ReO6zI1aMbFJnHjipf64dP9gmYqr9AT1FXdrFD6B41e83Ky2nHp8E8YveKUpbe4XuVkhVwK9qyDdxlszGT3LnQGq4dqjEo0k+hR9FmIVev8qohf5e7bgX3WgqlFANxJw4+idIpgmFGFbdV6CZtkq+txsIa0so6Zap0X1BxQDgUZmHozs/u2I1foA2NfHbf9DVv8bLwRJoorcUSz4c4OGxam1P/21R/OO3yz7hMkLlodbRB8xqQFqv5qrviXwCoWl4pHGODr57TE3OPxgZqmAE9dL7l8xs9NyK3KD3UBVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by JH0PR06MB6415.apcprd06.prod.outlook.com (2603:1096:990:14::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 07:56:46 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8769.022; Fri, 30 May 2025
 07:56:46 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] hfsplus: fix to update ctime after rename
Date: Fri, 30 May 2025 02:17:16 -0600
Message-Id: <20250530081719.2430291-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 352ae813-ceb8-4092-9565-08dd9f4f866c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q2VJN1eBT2sHnqEwsXf3r2GE+CFLm/sy02uawQzlYbUTazjLIHVeM9+bCUPO?=
 =?us-ascii?Q?Plx7esY2iSMGQOjvvZJZGgwSX8bVBpxhsAWIH2y0cSFZLXvaVX4UNWe5INwJ?=
 =?us-ascii?Q?BUICuRA2JofacUtS16n8A1wQZszo1aNXFQGI776ey3Sn4vtGVPsENbB1tc8v?=
 =?us-ascii?Q?ngRvMce/5WJEnVobrsbg16iVPv/Lh+xGxztH1ic5J36RxiiD9/3nJrsYDMPb?=
 =?us-ascii?Q?EnAUJ55ifRTkhOKGOVI8w4plPl7weQD+29ML8H4vbVg3uhLWqrqCThkymSAD?=
 =?us-ascii?Q?7xxJBYqCLqH0KHxoOpfrm2gSjESwpsI1QQLkrwkBp2goDb4EJKjFHvSLxh/X?=
 =?us-ascii?Q?JLqnR6h7kBg0cRXGUpcVNMK4ZOhdrLJsUStblYtjXsmLDF8we6cCMcJb5nLD?=
 =?us-ascii?Q?L2cBVpa0b9CxHEYjBxXzhAb8mvdT4JZIYkR8JtBpMdS5GmviSQBlA2wOu5M1?=
 =?us-ascii?Q?H5aczlrh4Q0EDyZdM8RwwfeXZrGttqeH/0Unp6o9qanqskh7WLXIc/wZziLl?=
 =?us-ascii?Q?idO2STkDPSegg2SluXKOnFcBMEJtHpFkWs5fHoX1E0KxV3OCn5BdNSaqLuTT?=
 =?us-ascii?Q?t3o3BCVht/vHafOww95dgXsYpPIQo1Sw1h9o1uu2E69l3EB8RUQL4oxmDlSS?=
 =?us-ascii?Q?TzbdzQMNE0xfZdqJaynTWHL/rMljApzoiE9mCt+5XdHFVWKN5yydXVSUjJfi?=
 =?us-ascii?Q?cj84TVEwsa93n6hNp6149WjfUdgdq/nM2nA8JYktXHSwJFllPM84NXLlgfsM?=
 =?us-ascii?Q?95w9uP9mQqQvgDrY/YlUpbRMSKqF3bdChvoVxLxigKX5sc17UKTgPHYBcJ4b?=
 =?us-ascii?Q?siSoaZCg3nto1lEzDWkrU1/mJm1wQqZHALUgIaRof2aiZzdrTaU0GGdpaVxh?=
 =?us-ascii?Q?kc1nyJIBj1LbFK75+Qv6EQVJDZF4sNp5ygSdBibziH0Hir9Jfyku5YhlvDr+?=
 =?us-ascii?Q?G9sd1LdoATalt8eoHMuA7CIVx/nLKkZ/uIiOUIKiDnz1GNTueQ+pLDfekb/e?=
 =?us-ascii?Q?Ay9gUJUjX43EpmeZjgch23yL8JdmlbcKVXgmrxEs17HUw7yV/5gsuEKbCH1u?=
 =?us-ascii?Q?d2ymzv/czktqWQ2j1388V57OTCqW4snTkKOLcze/6BQnUy73YJGwCBzU3iZy?=
 =?us-ascii?Q?Xvtam8pKNVWNHJ50tJ3aznz9u3nqNCaW9ZYlItwE0Q5xPvVhI6h+6jD3DhBy?=
 =?us-ascii?Q?/ZeOakEOpdZ5NbgZ1gFT1bRpzvKZazOo62Wv9sRVVrci3XfJ/5oMEfKfMnYd?=
 =?us-ascii?Q?2A5yw798sGxTiza+Kv9xciIaV8sHn3OLCRUA1fKxt6ctm8meO/nmnsFaqNOh?=
 =?us-ascii?Q?E50cnrktaObQ3REU9p0aypV+SYLZGBkquwySWBUl+cjCVVYoV09+5WEUAey2?=
 =?us-ascii?Q?/Q5f58/Cf2NWbbdXHEUMaU1ZV0duOS7borS11yiLxUkEIckr2nespeakiyo2?=
 =?us-ascii?Q?KL3o3aSJI0MjEHgVWDbcQvTPwzqZSdjt3NNolijxs9P9rQZKFDl/Sw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7fPNZz1kWi8ZTBqktJf2mN+fynd8cUQHMfBFLv9EHHS9nZ8+4Ufzeg0LfjTd?=
 =?us-ascii?Q?SDYRC6F0gGdGRGMiY92X+Xiu5B0VCoYtzl97VKnn09izBzewbWjQjADnh4fv?=
 =?us-ascii?Q?lljxFZnHnXd7yVKRlaf4VwY2VXhCQeEX0F5QXe+MJEhxecQXqfwr+qWJrYo6?=
 =?us-ascii?Q?8/9GfnuHiMpuE5fupffAU3E2YloCEBoaDFNLdgYbWVxEGfhzUY6oUbuYZBf/?=
 =?us-ascii?Q?G1uiipAJeBh5TkCLOqky9W12q+GyDPvo7tXIW9lgJpqizASaIGIS7gZ4l2PL?=
 =?us-ascii?Q?qB2SZsnZq2OsRvukHPuxjNCk0LMuuWwRO2CJ8/Y5STISbjjNegSGTDOcx53u?=
 =?us-ascii?Q?KvP7G54x8OZXdIw9T3TBBayyjwYMtlNTHmjpj1eWHAyHqunDqk+tlkVaZDdg?=
 =?us-ascii?Q?HcoRKbe7zBiuPvSPZr2zYqP9d8CsIFDqB1q1a3HsnOeZdgEWft+ny5H+v64s?=
 =?us-ascii?Q?RkPX/o/xcbRySv1wvSRdyeSXrewUC+ZGkNs0m6u8oAhBaHj9iky1GOE4hXKk?=
 =?us-ascii?Q?uvRF34yF+MSMqCSHescpO0FV+BfI9YPWKKlK7rM/xZell2OWqIu3iFv/V8dp?=
 =?us-ascii?Q?rIOqlA+WMFJDxYJ9XsRxXE7NyHIMxTJKBLoO/PfhT464eb2ah7rrwbCJnhsJ?=
 =?us-ascii?Q?JSD1aMvPr31kmVeq8KucHmOggUhgOz2ifjZ4yWUJU2A4cMp/tARQFWPL3Phy?=
 =?us-ascii?Q?QEnw5o/2Yj0kTakyUjaU8Cln6zZd9NCAGnvzX+tNzVNdyyCG69JIWRrBhfzB?=
 =?us-ascii?Q?tggV2lTCyXCtOyAyN9ctX1HtvNzIchE7Nkebfl85IV4d6kj3ipiF1FjmC5eH?=
 =?us-ascii?Q?WZHVV1Xnzn61cP4QwIgtQ+vU+EmUcTxe3impT04X0Ej3rSbQ+3dkDpQ1qdRl?=
 =?us-ascii?Q?gI98jnfqYUa5IVV81cAn2fD1g4kTTw4Ph1KNf/dhjDNdzoNAgg0cjRWqV+JI?=
 =?us-ascii?Q?QhNnYpg6lPZNYcFuCmG+7HTZVEHTFN7/W+sj1T4vVTvxG/zvZ+s1H5chxOYa?=
 =?us-ascii?Q?AlLRUdUHOUKzPWH3/4JUlA30iotg7wqhO9Rc02XZPGW50yoAZKg3kCiTDOip?=
 =?us-ascii?Q?Hp1Lv+E2p0C46QTDfQydVC/FOxaAYx/xwUYysWIH1RAQlXs2sOmWYEWvzuaX?=
 =?us-ascii?Q?Yz6nVQCoSideQzLjjYHbTQjXdTpu+/z6FORDAolMjRpPyCC/nA4ftWqGHUEE?=
 =?us-ascii?Q?/cfCVakbl9t13xusKGEODjQ113E3RE7L0SpIWSXeA2p6Sdi+KhEAfiM/naJ2?=
 =?us-ascii?Q?8Hz58Bb0sdCTbfS2uO9wQ+yn2F1xr08KtpYu3fUgTA6q6ouipT822YPaQu3G?=
 =?us-ascii?Q?26mQOwapgXPkt5Q9Bfw7gPk1RRzV8N/RYahTAxIcuEcox79pHwfq+MFiL5+r?=
 =?us-ascii?Q?RZDIztm0ZMySVycuSMokeG6o1FPIdSYzzVMZGehEFwlxD0SpHM/hC9mKNgJl?=
 =?us-ascii?Q?WO17IS0raXFuCvdtar5KUkHGgYAWq0pIhWl4ZLLVL8c12sIUM7ykm2Tqw7j0?=
 =?us-ascii?Q?jUCbulC4b0kN2VzX3aen+LdoKiXbVEiNgQyfNz1Q5SoOwQx0f827xvnw/snT?=
 =?us-ascii?Q?HGxjM0RYH2a4E7h1q37fjcMlN9/uYZ4Eg/6BnkiO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352ae813-ceb8-4092-9565-08dd9f4f866c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:56:46.5043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xxvekoLpqY9x9gMcAUE8/7aYbUlPXOqp9b3vwTg9BwCJt1ywNgYuTEe7dQk0AHVNhejrL/KqfyP7a0cHAL58g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6415

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


