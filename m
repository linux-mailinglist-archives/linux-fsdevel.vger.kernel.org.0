Return-Path: <linux-fsdevel+bounces-56557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0669CB1936F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CB13B99BC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 10:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE22D288C8D;
	Sun,  3 Aug 2025 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oLBCIxtx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012042.outbound.protection.outlook.com [52.101.126.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3519288C32;
	Sun,  3 Aug 2025 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754216593; cv=fail; b=NLLPE6ZxqSiXKaQ1pyhi0ZWyhKSyrn97IoKi4ZHZnumc+L/OiCIl3p22Ym9UPB9RNbF4InaxIc04YVEhh3O2bTp+Wxn5d+CD22OCVInJhxAJSKhf28OccVAEmkDB410DQigD0goeZB+Ueq7NDuW8x8GNTgi4nhMoz5EZLiAvVcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754216593; c=relaxed/simple;
	bh=7m5Jwyac13z+ymRygKex8zawFwnb4OeAtWi8d1FR70I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G4Mmae/i1FlH0f2qwNLf7BzrsTdOL5TjLk1Jr6k8v0aErUUuT2n+z7wVjAzrBRED04H+Vc4NMPBI7uBAIxI97lRR1qDBgLu31Sf9Bh91eHYnoPgMPGPsoUJ5YS2KLdaKa8nDke4wv1JicPQ0fEtjq5mKAWyoHJwV8TczbckQn7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oLBCIxtx; arc=fail smtp.client-ip=52.101.126.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFM/zH4RadazCIy1QgZb2TL3houTx+UXQ8chGiXJvrNKIDBJ4xxv6M2U9hRL0mYJLyJOgF/pJhUnhMbOMQZic97niBMJ/jepiF++xHlK93XtFSrgKqAjHO+eH2HCok87ukcVQFG9Qn22seX9d3LymQ86gIuKGWCrKe6ORQJdZGlObWSFxxgdVNPWUZ7uDUOY0lmiwMmQnt04x9qdMdMG1o8njYdu+yKCqs6wHRsllb3eQb903Y7KA/DW/6Na4LhLsrPXhEWjJ23hkBgsrqXf5Ns9yuxYYKxFbVAYH4JqcxCaiHeRToGgpPUQ1jLcUCfbncM2VtWDmBGoIz15dWUd6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRmtpfhZxEt7jETmoPu2jOkxTPf9KQ1G+10neGHinZ4=;
 b=Dp3YE2GrvUXtMG4yyFSj4QpXnjswlufng654FrdSn10XIQwkwgMHGi9WrwT9y1EQdpLHFh2/Emvk8m8250y8EBDRhq4j2C18XJ9fw/K5avt9cM4y65Tqcp23MM/25PZOsRSrtpifITh+mWSfOIQu5eCSOJCZagbOQPCyYH/QgnxVQqpVuaKfkLll1bZYVNq4p8VSLEY6AauJTEM62slv9u4bDjNaO09dFuPpiIxbrHDrCiis/FMNmuEdxwa13b08zE+LU6o4v1v0Nk2FTawB4e8AD1TKNznPpgKMCmhi78ymh/ciYSuxbhn+o5snJdPnZybT/sj9MLH52kDyaDrQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRmtpfhZxEt7jETmoPu2jOkxTPf9KQ1G+10neGHinZ4=;
 b=oLBCIxtxR1BYZGy/yMajLQ/NV7O6XvPb4nqC+5nyXiJ4rTKBRAoAwnJBDvjMUgCDpaQIXNl2yjHKSIKTI34CvFlGcx+uTxcwdm8iR0WowTVIMLA2Zqt56iSBxS6QvW30UffcNf3A9+TmS8PQOeBEKLkF8wkxqlgj/AlpQWFM42kAZ2Dld7j1LKYcdGVwZwDKSGCasq8cx2pD2UPHawFEvfcS1GzFt9N9aXBHVQgskHOjnGBGn2hPxd79vBMbkva0iKAfU3IauKnQZBqEiTtQzl1SF/rmlZxhx6M4tWHbNarhjqSjADVqvpthAxErEsVQYbVM6XvrtMcjtDEIxI0Mmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5128.apcprd06.prod.outlook.com (2603:1096:400:1b3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.18; Sun, 3 Aug 2025 10:23:09 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8989.017; Sun, 3 Aug 2025
 10:23:09 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Cc: willy@infradead.org,
	Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 4/4] fs-writeback: Remove redundant __GFP_NOWARN
Date: Sun,  3 Aug 2025 18:22:42 +0800
Message-Id: <20250803102243.623705-5-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250803102243.623705-1-rongqianfeng@vivo.com>
References: <20250803102243.623705-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::14) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: abfdfb9a-fc5f-4be5-ed38-08ddd277be37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bt0jBMwAtE9hwOspaN7YAdutHH2hPqUZgDcxuVqMAGiwqNXnWCZ+Xtk8vAUw?=
 =?us-ascii?Q?68dYqM5jtqw3VHdesEuhHIZydO7iLAGEEZ/Y5EZboc0MR7p7nVbSu9o1vkL3?=
 =?us-ascii?Q?u9sJGj/IPJ8h/s40q3zVr6uAeVP+720bRUGJzeJq8ErL2xMaCu3a0SAQ+31A?=
 =?us-ascii?Q?MOzLqrh0uFZ0Xkoy1ON7tdelAPO9WcrodnFDRjtOky0dPXv8aKJoI32nRcl8?=
 =?us-ascii?Q?HkD+VUdnBIorZZp9rMug1dgnWhDRA2eD/MgzdZrCNiA6Xs8y+h/a387ytGz5?=
 =?us-ascii?Q?vXAAaxnpCQYNeLmoJ9VW01UTMKk+vLgCRcSFKs6gG2hkAH0bvjbvO6PFhWE1?=
 =?us-ascii?Q?agiaiZ4x2oDXJF9ud0Htt8CN63y8TdFi2IfbV/LWItRusqztAvwuraKkizS2?=
 =?us-ascii?Q?Lo5VDhA2x/rL4M7u4m5Cs3braeaPtG6pHUH9Vg4f8htUQXXAWQDdS30SzfVO?=
 =?us-ascii?Q?vZeo3QCz0MkqPfVHxCvMEKpc+Ja76ljcS6zRCRauM9ZbddBcn7CjtmLs3OpJ?=
 =?us-ascii?Q?4DKId4xhd2x0agzjr7HenPSNNW/kiib+P175vWKWjnXri78da9dJbnzaxm7I?=
 =?us-ascii?Q?uEqL8OfdQI4KTb4u5/xXpwnhFn/8XDKj5q0AnmCMQUy140G2kkopgwVHtzZV?=
 =?us-ascii?Q?mHtfnLqjQ0znIYsUPtmUekvwN+yvBMGiVRpqzfMuBe4E0jZT/ui56UWoQCaU?=
 =?us-ascii?Q?VBceoBDoYoiW+kknnGoWCxUMqjpC+7AMnPq+tovPguRyM8wUXtKPYWUk0H7v?=
 =?us-ascii?Q?oly4zGTvSmRitojNzI7YJ1MZmlLDkotHJCylnVp+SEy5EG/HvqZ3uhRrsB7I?=
 =?us-ascii?Q?NAaQaUE/vIcE5brdvmxanxWMR4Pjd4ef02iu99mUHAik0YTqAkSTSJLjLSjl?=
 =?us-ascii?Q?opK1YoyWFFFJs0u3qYZUncd7WuKDz1xPLoD6ypNnqsl0s5fTJl64USG6PPu7?=
 =?us-ascii?Q?xiBvaK7reIZyuEgLMKRcpqZR8rtEKAqZWo7X+dOS2DJi8qkwttcA5IrSAyY6?=
 =?us-ascii?Q?yfmHvJFes9B23dB2TsiJFhnG0/9o7HWcqSf79zJAnmhCGS184TBrSxauuq7e?=
 =?us-ascii?Q?IzetuZTwIOac8Lhgkriomg4ySK/Jo/B0SRoX1a0NLm+A9l2I1zifuBfSuOGo?=
 =?us-ascii?Q?ekoxe6IBgjThbwvR2I/QYihInPNxKw/xhK0mTsWZSjcEl2+nFK94Qa/2jmz9?=
 =?us-ascii?Q?M6SuZvUepDU2wf84O/TNxEw9jgY3fm6958Lf3bgzJ6bhGlTtx1pDmxsaxtym?=
 =?us-ascii?Q?e/Ap3mCq/5xgeQah4VkrSW3SA+5+kRIGqJHKleFRmdrrHjkuIFOxQTkUXwub?=
 =?us-ascii?Q?NTXAKaiCHKzgm/R8WmKfv5Bqzh2WOIBsepokYFncto5NiQOzoOhYn3qa318m?=
 =?us-ascii?Q?s7vt52ftJbGkxpJYaJOL/F/YoIPiQQOLgmoEtDBKBUGAo25SANDKU5teD8JG?=
 =?us-ascii?Q?j7J2OBbx2vLDDSAboDPPvXMLiGDs3v7n4jAaTBbq3/eUDArG32ub4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Whg6aEOk/vKv0/l8px7LArIcvW8kX1QLpH+eGIWmg4ZzVRUt2ycRohPFRAz9?=
 =?us-ascii?Q?nXoAGMaQKcmS4r0CCiZkRV37v+KNkMAbHUrO6Bf3Fl5PKpk+s+/Riqk+0W0V?=
 =?us-ascii?Q?ityTLic0o3itbaUfE2ysGxSCTalcfnceq9OtrqB1luVlEMTThnTFFfzyDTdN?=
 =?us-ascii?Q?Wf6c2h3G1F7FHg0VVW6Dre1mdVwg36jXY6YbfPb8B88WiuMhAkeFEyK3g+eL?=
 =?us-ascii?Q?cD23LktfArR8RRDO4gsAx1qgmJuKvqPwI3zngocxpYt+ymAUm0M8xrhSG5vZ?=
 =?us-ascii?Q?XS2EzKSkNhBnDwf0ilCEsiSRBPUuRfcQyPHhR6r+p8ygNpipV4SfgnKhFxLr?=
 =?us-ascii?Q?ypSDgd82DskfMDTsfSJZpwc8F+OfR2W0H+kcZ9L4D7IXljLv1ZJIw0goMJmr?=
 =?us-ascii?Q?wT5EvRBzvV8eHX/wTmVcVZ07ALipM2r8v9JGRDlUCbsUcxGkRAz5ExlwfyUP?=
 =?us-ascii?Q?AmswOnBoZgHdXTuMgRe19UtdqeWsfdY4Xt88r+WaVLIHG9hwgg7H0SdSVSoO?=
 =?us-ascii?Q?ZkXh6BeJKiRrJ5nG4bRdAHyi+e9bkV3xf7U1VoP5hlvD3N+HQ/0p1fr6Fvgv?=
 =?us-ascii?Q?T0KzYTjovnGkDwPyYR3nAM1xiFQpnCiDDcsGyS6iJl0bAFLT9tBsbc2XfjAF?=
 =?us-ascii?Q?Y/Fkk2WW68xlhJ3YjFCShNFUx4srt7OzLgH/9igF9wMSMM7J9Z8kfPFZsUnE?=
 =?us-ascii?Q?ZBcU2x7Y68LxgYi3JX2VUwtd8cgEAMnqymAkluCmDpOw89E4YhYuUu8TOzpZ?=
 =?us-ascii?Q?acv1YxVOcHn/ruEKKCNkgKnfx9/IzDci1bWMT4uz0hhweMGLEWYlPltz0Cmt?=
 =?us-ascii?Q?RT2CkKr8gGS8Fd33qyvNaEOuBMomtJvLSQMbcgPtK7abQJCcECNk5pUSGPFw?=
 =?us-ascii?Q?zcNorTygzrPvWpqtlf47VrNipKBMDdL1kPvwxYD24sRLQBEahWapbbC2Z+4h?=
 =?us-ascii?Q?O23IcPHCZZqz8syrldpcyCe+jW1gdHFVZrWwMePI8cWRIyhtuHlhC9YtBPc3?=
 =?us-ascii?Q?rhjk5T1h5oJEmyM959Hy93yIY2sFnqK1xj7aXfUJ7ZLm1Nu6qlJP3cXCc+6d?=
 =?us-ascii?Q?pBU8JFWWD1J8Z7am2yPRB0NYWVEe3t19f1AeTJQoKg0pnmYBPusLETGnB22w?=
 =?us-ascii?Q?rw9V2SC2kxY6iR4ikTFiw/ocMcNIKo6pQANZkB5YLMXOAwXyOn0bDaCC0qOc?=
 =?us-ascii?Q?9RKr1Ejk9Dy7EejQIFK95WbTTO2ewAkfcmnPfLrfoJg1JQsh5BOtGb94UoV0?=
 =?us-ascii?Q?+RzdLAZ1okdvhFbV+lPwbsnWd6I3wS6V8YOy7jFYrcWHqWzQD8w/aRAI3KD0?=
 =?us-ascii?Q?+NcMPWX4h/qCcpyXpK/xhOhYLl97Uvtw5oh1Qc7Dqg5fuWucfEcGQG18isaC?=
 =?us-ascii?Q?O/qWMe1Gdmrj5COn5LDhFi3fchp6+okJ0yJw3UnZXkR2r68/WqL0B/oi1YJS?=
 =?us-ascii?Q?zhyWdxsujU5L09i8bgOnhnoo8qwVzMiB69eCj36pv7MZ2qwDyz3nwatudHbZ?=
 =?us-ascii?Q?USOyukPW9JD5v4NRk2QHHF59716+WoTCuPIhOJpX8kIIY+vYNEoH+mpVLLCo?=
 =?us-ascii?Q?JXGnKruCCwZmZLjcquorBDR8gUOYzCitfZOzBWOm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abfdfb9a-fc5f-4be5-ed38-08ddd277be37
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2025 10:23:09.3163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1rTfv561rRGvbqfv9NdyObPpfCTEfOwoLH7b/w1cjGc7BG5Uv2efInB1t4SNF8KzbHaYtjZF3Y2Tx2dFtvjZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5128

GFP_NOWAIT already includes __GFP_NOWARN, so let's remove
the redundant __GFP_NOWARN.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 fs/fs-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index cc57367fb641..a3ee79bfb2a4 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1123,7 +1123,7 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 	dirty = dirty * 10 / 8;
 
 	/* issue the writeback work */
-	work = kzalloc(sizeof(*work), GFP_NOWAIT | __GFP_NOWARN);
+	work = kzalloc(sizeof(*work), GFP_NOWAIT);
 	if (work) {
 		work->nr_pages = dirty;
 		work->sync_mode = WB_SYNC_NONE;
-- 
2.34.1


