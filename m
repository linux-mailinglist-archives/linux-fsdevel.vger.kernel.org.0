Return-Path: <linux-fsdevel+bounces-56781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12C7B1B8A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 18:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1EB17C1D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CC0292908;
	Tue,  5 Aug 2025 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="S8ZCo4iE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013050.outbound.protection.outlook.com [52.101.127.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C717A2FC;
	Tue,  5 Aug 2025 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754411833; cv=fail; b=hKEATjk/sBfCvW3JX+HWpoJsaq6MtyEjlmBpB6wLC1K7YIwPvAKtBPVZrI8tPU5BDJRxuapkKsE9Eb3CbJQR50YnYT0A+mYVd6UkuavCKOz2wrAtNIxZNTlnK15XYCAqBBziy0DwWAwy/iK6/Gofq0mnniG/a4hxR2EM+dlFmMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754411833; c=relaxed/simple;
	bh=awV37WL8yCftZEBEtq/XNBMp7Yi/2urVoSrRazY4Nqk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FQsZh9eF2hWfd72P9FurSMLEINDIT7uV6COsSRbS/0WlA+x6x76ksiFigdzdJ8OMhDuug0Fri1eglNs2kX62SxiRz57CBBE7PbBl3BHDYvBcAufg+lrMzvGUI532IEV+QjNbxeGDqFEvzuq6T+wKrjZ/5/3xCPSBtuIqGXGZv+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=S8ZCo4iE; arc=fail smtp.client-ip=52.101.127.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpNUe6E6qtcoy5C8gJOV0EExZPUik9bJAD0wvb4ksQdypkP9Ui/JqCJDSaufVp+dRdVwG5cXVEGNsZvoxh9yqbO+I0+8KHrOWtRJbH8pgjUI4/d8O0WJLZTQVV4Wz9oTPy5TUrO5iL92CMp2n08gN7eJZpF17Ji0dAVl78EnEmiy3i6ZxXuCUvlh9zFBu0JdsdEYSlPqgM7nYaJJCNuJAOF/mVWAkD7Mb3fRkiMGVSEhdMROGI5sHPVUp+tFExDf+VUGFe4vL28Pbd7qdYXZX4VogbBN4/xMf247NxFXXbPvWPyujXBIRyX2FmH4hR8kS70A5x7AXWva5wJnWJtINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6FpGl3S5HEEaSaLieJEYs7fKBBpofzgmjuxLUrHXX8=;
 b=BumSyvnofaKWg6KGMZJuanChotoTQulXebkSQeiZCEA7aNf+kgHhwsusOzNm3ddmNTPcMrsBC7nZYoHSKV3lAIeJTF8ganztysT6Zh+HrudaAmpT9CVz3/jTgF3a0Wy4sUF2onw40k/h9OZE2ZTZw+lCwbJu9bITVbVDgepiLWzZE2BnTIfGD6+6Fi1wCIFWAV0Y5+7HE/79Y3XTy77KyVX3YQlnXvtwsaMaa04rtrWtjKmYCUqiX0nfP5RyXhxkeuPZEuw26H8lKxJaRTuTRsL1IEPvonvotgmBikxNns6Q4cvzbJPVVp0OBO61ua0edIYH2UQugq5RYGDI/scMnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6FpGl3S5HEEaSaLieJEYs7fKBBpofzgmjuxLUrHXX8=;
 b=S8ZCo4iELSB1kv0pPGodMneGHs32qFG5I0agyJTY6bs0eRgMbbJIQ+Tmu7e4mbISDzNFjvCTVRH+9wKTw5OTecBqaTZPnCqKMWSGxz75yTPwfnZHzQB8v2z/qZuTzShIqc7MYgoMhULz/raJW3nT0aeyix4+9Efq0rdCAyQINxF1Hs/uhyDthTiPAj//1mHK8albeP1mBgo64FXcuMn9loRTpefdBKC68L2xb56/A8g3P1nxEvRoKkvj4cikgBUPlS6AvZSbeNJuXyUXyqcaPYWWJHpkfu82UJRDWvb4+cSg0zl0MGhvH/ErCrmG6GlYeFSflXoF3b+AnCRHrZJCOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6616.apcprd06.prod.outlook.com (2603:1096:101:168::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 5 Aug
 2025 16:37:09 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 16:37:09 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hfsplus: return EIO when type of hidden directory mismatch in hfsplus_fill_super()
Date: Tue,  5 Aug 2025 10:58:59 -0600
Message-Id: <20250805165905.3390154-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: dc82ecf3-fc89-4fab-a719-08ddd43e5210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZD8nspQ0kA7s7WDUi18mwVpd2woJxlOJMvfWIB0YNKAXVhWpVnCbivpBVQrO?=
 =?us-ascii?Q?21wlHml28qPvD8yNMXPZzuppiljHUuo8sP8TCusTFJ7UdWeLmSLXtvjCEuJ1?=
 =?us-ascii?Q?Ms1mAfBL9jY1ycxFvUBPez2XqB9gWZi8FUxBF8sKRBq+XwwIPvxdcH69e9qI?=
 =?us-ascii?Q?DcQKAw5upnxSAdJCsdnIh6ysV6/duaP9pOCFpk9onwcdMF4dEke2UN1C25V2?=
 =?us-ascii?Q?DVI/YtQ5/HuVxuAUofnJcGneTvUuHFTvHu4zBBLZfBKcexXdA9Pe5LwwVMKH?=
 =?us-ascii?Q?MbtL8H1P0ln0h6OwhfyV3nsAbzWnpG9TxWqWbKSU8Sk8EXUN/0MVbvAH966g?=
 =?us-ascii?Q?ITM16DL69X0IO2vYDgOZKpJGVh3edugwizu3rBgKqSdr64uj1hd6AcWBz2Nb?=
 =?us-ascii?Q?eQ+PnGqnBm0RJFg+SAFeuHyslOVvRr5HXQ7B9YnHenqiQtkR4mBS21oGp+ef?=
 =?us-ascii?Q?gOvZ2pZcBSYTeskEzVKCYwuNAdf1QjkraPmtXhICtnQzr4TPh3XBL+kOoTvu?=
 =?us-ascii?Q?lDjiAX00psa4BQ7QaMgHV0uS4EzcGmmuDgD7ZWA4aAfSSnZO3pgPs5dREIQ0?=
 =?us-ascii?Q?yHFNspBGFfPoclqzhp9SWg4cQXtnG2PVDLsEJIAKXIkU6LXUkF4N2olIMQQ0?=
 =?us-ascii?Q?2YzlInHK3rJdkF1hcubEjAuxLpYzu+ce0eg0vg606ja95gsg4MBMycJVthTg?=
 =?us-ascii?Q?qZUc5lvpt/uhiFa+29xWRJcuYd+ZPpASGtOKp9c2S1ksWON2sS346MIkGqHY?=
 =?us-ascii?Q?xe6/wQ4V+FWd+pkXqAVPLsA1UU366Nui8GsupVeQ2hSMwxL3UuAf0h7RBsKd?=
 =?us-ascii?Q?qTLiwSTy0qtE9Ru4qslFRx6u+oxzM6/E6snwC+PkTVBzgVc/PYpgBIDxC50A?=
 =?us-ascii?Q?MwpytlwFYvJEh3ITAIpEpepOngFMCVvnOajq7x+H/Gv/pzULLOgS9SNRU98o?=
 =?us-ascii?Q?W7WkJa5XktZwa8vg6TdpZSpk4iQ2B6DxvWthEasCDXVU3VsNWk3cgxc5yuq3?=
 =?us-ascii?Q?j256d7265JToFz8LxJw+5sDNCs0KRa2FlnIbkCpcqMKjWerSknhOdQRGUKnU?=
 =?us-ascii?Q?6HfvQmt7dwMdEPktfgppIgKXWMJ/hD0s5pqpOZoyYhFetirrIw2D0wvprx/6?=
 =?us-ascii?Q?G78vrP7gcenV7ByoEv4qdQC1oNBqG5B8bNj5godod/aLFjRzpRlH4xRhBLfD?=
 =?us-ascii?Q?CyhfTCfnzu8DwqI5kkWPArjf7VzCUMZEO84gve8S+8rmaSZnnaRa7mVfvoPe?=
 =?us-ascii?Q?bpWa8K4NgMEMJedKJy+FIpmumMAidDlvsO13jz8wlL3M80yVj0rYBXnkc1Vm?=
 =?us-ascii?Q?PoqvZLyHM6Ez2jwipm3PJGpxa7Qg8DcGmNwRIPJQfiKXAxf5zW8wygJXRHyu?=
 =?us-ascii?Q?LTzakQx9US0duZH1AA0qSQPYaUwv7vQwDkPMPJDNz9SdqcQYjYoUiDtdKDc1?=
 =?us-ascii?Q?yV/xlletREn1diEORbWCAB2h+qZyWs+4fQ6qwXl+dzJHIGtdZtu8xQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ffoNbdughPrQaWvhvt1DCAdDN6sN/+SfUJEIRPINPBlQnG3DF1Z+XDOuCCU/?=
 =?us-ascii?Q?s1eIud0bGd8BLdLk5IPRihGCzyD+i85TGtkK9jDYAmF5vNMa0ekJgE/7dMKj?=
 =?us-ascii?Q?uezLGj2kYj5+Zc5LVVbmDK+msoCpWwkXI3LEZb3HIGUCL8ewlkii5uchQZnI?=
 =?us-ascii?Q?fazUFE0dOfTGXinsciJj4zqeAhAVae9Uly5uuLrBSTMJMpLXHjR0i4lux8yh?=
 =?us-ascii?Q?+UvRpfIjCRUG5kCkbpj8WSSC/+jdIbE5Q3s1CO5nUmBDHnr5fgIJstTeE/lO?=
 =?us-ascii?Q?HYweFt+IErJJw8PGZnpuDYZ40HpvrczjlGTRoPDoovoJqD0a/jlxKjN0pCHh?=
 =?us-ascii?Q?p0eXOzYjB9vIHrusIfnLPfMVZr7qlc+TDaZW7g6gsA4wRROLlJo0futAiZz1?=
 =?us-ascii?Q?hAQVg9xeijbAnYbhIKNO15GNVyZ5M3eM38mP/uKA0jHyjUtnj8DjEUCTn1os?=
 =?us-ascii?Q?Djp5iVuPdHBF+zccr48MiUs9iWm4EwgHTR6qS3oO7ACYOJ1VwTdHi0VIALpl?=
 =?us-ascii?Q?Mcihok6sPOFxYu9sF1j9T6Ac/oXfPEtg4euJA0Xb0C3zoOY7yVDR29xYp5OB?=
 =?us-ascii?Q?U8yNWhkIdY6k3FfIRyH4NNDOLeeN+CBuVZKvwvNB/wbvXhQlHf4gdRbd3fJw?=
 =?us-ascii?Q?2V2Ev7WONWBQidaMF1aA21fU+wnW4JO4zM1BmWtMhIUbEc0e5FY1bJXy8Tgh?=
 =?us-ascii?Q?0NDQMpK3EB5vfefoZmlM/g4xIqKeUBvV/E1RQr4XOzBGtOP/SLROYAtzEwaJ?=
 =?us-ascii?Q?PMfeDnSkfKfO40Y1jyGHvgbA9U/B+kiFG2vEeJzseNj6y0L5UKtmdje6o2Wq?=
 =?us-ascii?Q?4KHWKMRSk04GKbIFLKyOANQk1m0qb2H+r9BP/2Csp4sTfWnb7AmHkAMcOspm?=
 =?us-ascii?Q?0Gl6McgpgDzZz7tWWrmoKoht2uXW5sxQai/Lb1+L1U+yc+cWRcBUHCPh5gi3?=
 =?us-ascii?Q?LHdLgpNSR+XwEG0JkzaI4ZNRnDpYV6FwXz5wsWuGXd5PBoOzNOEwwxz1RezT?=
 =?us-ascii?Q?F5tia3Dt52s3uueE/IXK68/peTM1MuIfi9hh/30rtsrR3Lw1zD6TDgnJ61rG?=
 =?us-ascii?Q?vhwMkdnFoFS/0YzkfqDgwEk1fUqPcyKyEJ+dncGk5qnRYkb6ap/kYIAWKcX9?=
 =?us-ascii?Q?pfxJpf1xw4Dgj62HXLdRvru9nhOVgLkeHlB2VX6HkbKmoiDmNkRW3rvShaUD?=
 =?us-ascii?Q?ZKUIpl0486URJxvqHM1b0Y+qCMP1XO3O07ti8+FB1bWbt+03FE7g/lwNH3Zj?=
 =?us-ascii?Q?PLcBr5XG0sgnYDuQuJU611srLFssSBckeN8Da73UXpY5lC/PuLl8xfd2aepD?=
 =?us-ascii?Q?t+TkUEV56IV7LRJI7seOJuKF4B4ztHbIeI2oI9Ue1xg6kulJEV3qxdIher0S?=
 =?us-ascii?Q?DqFPnJ1bkbR1Vi2MBgHq5OTfRTmSX5p8NtHxJHu3Du+1jOyroHYxqmJmgjVw?=
 =?us-ascii?Q?Nd7FXblEHZzlSsry1uhvrU2YyJ1xPmreL0ixbBkXUsrG8+Y3PhQLfVku4sVt?=
 =?us-ascii?Q?dKucftU0x8Nn5feThNMzZ83dp0x4GfnkSoqAvqrk30QWfW/X4S1lHigRZcLp?=
 =?us-ascii?Q?rjyHs5/u1SfR2jzc6l72m4HH45sDVuLVrjZ36Dq4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc82ecf3-fc89-4fab-a719-08ddd43e5210
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 16:37:08.9010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVslpIJ2TsjoyIDUfacpYHRxYITvocGT95iUoXFJUM8dc3qmm+wt0ibPM2qoeP/g00WEXJZZMJkc5zomByh0Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6616

If Catalog File contains corrupted record for the case of
hidden directory's type, regard it as I/O error instead of
Invalid argument.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/hfsplus/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 86351bdc8985..55f42b349a5e 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -524,7 +524,7 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
 		hfs_find_exit(&fd);
 		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
-			err = -EINVAL;
+			err = -EIO;
 			goto out_put_root;
 		}
 		inode = hfsplus_iget(sb, be32_to_cpu(entry.folder.id));
-- 
2.48.1


