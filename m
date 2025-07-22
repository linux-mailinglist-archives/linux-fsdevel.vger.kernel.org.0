Return-Path: <linux-fsdevel+bounces-55644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B82E1B0D21B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 08:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39B51C22059
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 06:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129EA2C08C8;
	Tue, 22 Jul 2025 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pYNehB+6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013023.outbound.protection.outlook.com [52.101.127.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833DA2C08BB;
	Tue, 22 Jul 2025 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167132; cv=fail; b=lALzRY5fbxhnyLtRDju0ujoTk3UnJZx0WXYtZhw02TYp8ltK0H6w3Hw4s+41hs1+BRMsy8hFjjV5q62MyOeCo27GHHzzgSI6WLPE0OEUFIKI8pk1yoA4MbTv1oGwr61cu9AHz/q7DXmTCWadQXz0h7Q+VYE80YXyMjXJzV8L1oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167132; c=relaxed/simple;
	bh=bthku6qkbaphaEdaujsTq5fHD2gMxnALkHWW8SZfQ6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ok7vt0KtIX4H1swgAu9nIFimaA/ozKqeLMXMRC8mESoK/e3rmlHNmhJGVeJ5R6OK9hr741B5m6HzdoRKzDQ280KgCT4/TTHNkDLSp8asclMImxvdLmXFURKA2TmXaJVU/Z55DQ/SPUztCSUq3I4DsL1KKveTtCFjX6GpP/8LFRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pYNehB+6; arc=fail smtp.client-ip=52.101.127.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y11sgSqmenq1jTKHBEd7u2O1Xtnm+XG/lYPtNeeQ9MxQjte2jHNWwuUeTT7K5AEr164HcR4DlQDiYX08n8E7ARsDAPtSGcu37KhXDa/XryCRZu5s92eOXyN57CGARiaPMWRvMuZDb8s5uBUmFUPWrkgxgi2dcJqabgY3uUhxKXW76UotlaXePFUQVKOqoIkCdRCor6NkweUni4FU9pbwNBmtweGuzLRmBPl8b06XGGNIfezHx3y0wLyY6NAHBYjhWQp/v8KX80k2R/yMYE0YbcGx6HMrh0TQeP9Rofg57/RawsHgWfjqjYzGL7tuypjlta1F2ZFAaHQ258RHg74PbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciGkRpwz/RkjC25MmIwEoNTujAD9vaT5R59OTLJ8FQ0=;
 b=IJfIQnLOjTbICNlwn+zPEwNxi1dm/SFMXBS0BkIlPZlx+sG7U2C/BJUL8kmM39SezfW1fwBYeAmlA8Fk6pDXKCnBHh0sMR1REFkA8kvbW4g71relBnb9H1KGGWULAXnV2vi2Gz4ZDTXniBLp+1bxUV4wXBHmQQR5DC8z861pmA/K/eVjeea/oq3wV87x37zfDSiG2k6RRS7XalFanKK+d6vkmP5OYGRqumAyBeET9CxqqWFc2/OB7elmBrpLay63nSom4n3plvFet5gB8El5QU+0QLU9TYsb/SoWFJVszBReMw5fS4gZzDRRJx6mDrqCMus1RsBLllHssEYj9f/KFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciGkRpwz/RkjC25MmIwEoNTujAD9vaT5R59OTLJ8FQ0=;
 b=pYNehB+6+075gMCvaIQxyd33XuGToOoeJ6LRLziwy5d8wsRnhe2xh6StrWNRxAXN9QuUgucSUzXJj7BwDV8S/W9sKUeRCd/esP2U9TiwkjW+AmiOACYD0X7YWbj1p1FrASk3Q7QzeVLRkTRK1Y6raOLveRKs4dVQGJz+Shan4FJ9X3A3nFO2CBbRBqGwroeMLLbOZgL6FOmS3/nVRFC4Vocq3WGExHSDtmnfsoazOKfTYw2DTSPf1cLFEygdHLFHr1kEq++ZeWtR4kKHqnSKNImuHSjNW+6oV1yrfOagAUwpBATkiYNAoM9uwYCTmDZ4HncG0dphzs1WzSHrE3lqsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5293.apcprd06.prod.outlook.com (2603:1096:101:79::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 06:52:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 06:52:05 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] hfs: correct superblock flags
Date: Tue, 22 Jul 2025 01:13:46 -0600
Message-Id: <20250722071347.1076367-2-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6f4eacbe-9d6a-42d9-79b6-08ddc8ec450c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gE/Ped5MSWNtr3p8tOG5jcYt6acJ/0S9NNwLg8k4r/0z+Gz3iQuR6NH7CW4O?=
 =?us-ascii?Q?TmFErFGGc4uXiL3hx1GYphSZCIcQw/L8aKM8HcUl+ciY6X0dVXy1bcOO60TV?=
 =?us-ascii?Q?12HYarSAAiXGsDlQPCG2lin9El2KAkX+vE3o1IJdDOQi1I+Cp/mC3/mLD+cH?=
 =?us-ascii?Q?d0Arxm/RUKMyyn86bB5xThPRa+6FLokg7AXFwgVIrwbW/O19S7C0fCct0Ns6?=
 =?us-ascii?Q?CyE0n4SODorTlIbGdAG7P/z/7hTHbpdWwJ5DiDvB/GMUl0rGFKeG5KTjYV4b?=
 =?us-ascii?Q?/BSuRdLY30E/LYxSvkvy7koIavdJ/z2sLtHGq7Rlv+Vlxp1Lj62usZZyPkoR?=
 =?us-ascii?Q?Q1dwH6R0ajS0EblzIJWRWhc52nStZ4EXxTPn9AOW5A3RPjU3fz9ZksdRtIVi?=
 =?us-ascii?Q?fkS6CDgF1WBWF5BRYEn0aY4l6DlWinmeQP0rABjkJlQmZ2dFzCXovjo+OXip?=
 =?us-ascii?Q?VbzzjFpeXHE1aZRzua/XliuGCKix3CKAecjkZuY71WhgGpv5rAPnIZBTvbns?=
 =?us-ascii?Q?oM5RBUzNDH0nzAzMiTNWXY4UHmv/jmJDULq8ABcmu7drLKmxCIe67RS+lyYw?=
 =?us-ascii?Q?gre6rZD2fXocSRxXyPSsYzs92MmIot20zhi38VH95hWytq0GwJJ4S4mu71jF?=
 =?us-ascii?Q?8WD5v/CN6pLoUxcubwNw2UInkusTAqLWfpOpBLujamKqFEPA8ZgqHVKqV7GH?=
 =?us-ascii?Q?P8nElrAI3S61lyE4XhXO85m2YKwzRk2wETovz5GslubLygJpMxc4AP4/vi7U?=
 =?us-ascii?Q?zdrlpp/FaTEclqlpCb0naWOlyVIyA1TZ0SFY2fkdwf6QEiKvaC5ny+UFRTwB?=
 =?us-ascii?Q?D0/ssE6YQX7Cx4PVQMyLrfFNdetuSBHEb7zwNVMDlkLbYc9HuN2tB9RYdwx3?=
 =?us-ascii?Q?K/Rl+pdKaxGsoKDdv2dgU8TkdWUopvT24EqTrTU+IFfNRBmSJJiEPTnhoTOV?=
 =?us-ascii?Q?D+B63O7ynW04QR1z9FIv0GNQfIHV+s4ILnuVqKEcI36ZWgOCBcDBxyCFQ74/?=
 =?us-ascii?Q?EbPSxPm34SqTgfFPnH2eIk0ptVF6jW6JRjyiC5g632YPHbwP5ehqCFgJXclL?=
 =?us-ascii?Q?ovf+d1PIuzim68JIEucc/p12t6YtFYbxNymnu4dJ4hbYWArV5yqOOm4BkiEk?=
 =?us-ascii?Q?CmOc3hgcXpVcR+hupV7n1cssnH6AnhXggeQEaE8PeDM99FsehYgbAIwYGn2l?=
 =?us-ascii?Q?Vgqhz+8SS8zkIzSp59HoJgm5jT5kmmFO/jqRcJuLSNQywkMMfGQtJwDYDrv7?=
 =?us-ascii?Q?xuQMVCnFJCLNG/Naq8+FZM5RVwcyuG7CAVssUa5phNj4CW/jCW6P99VNZYfE?=
 =?us-ascii?Q?uHUMlIEgraohbLuCokSNYVSvYAN2ysFmEd9ao0NQiLynZGKi34E7KbymepN4?=
 =?us-ascii?Q?aKvsmQ4M/5ij7pTOSv4s8HkSwFeIi7vg1mpY3v/PtHdEDOxwxyNPcSsDlwmx?=
 =?us-ascii?Q?ojHiuqOZIZV68ZaywY0JtBgMv6PenbUKgNJnO/hb2pjLazlIRg72Uw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nwf9rf9ZEQ6qhbOWJvJHS4y3Sm3bd8XFFOgjk6YOoQUKnnfcWLWVNMoavT9b?=
 =?us-ascii?Q?QKPV12QZmP0FL9MpK+bsqQZARNZmqO94SHPJeHnLxdl2imZ8aCz4WfwrtW96?=
 =?us-ascii?Q?PuFUQrl/+HDppy2N1gXKizQHjnvRP1tG0hY/vSJqoCf6snK8qa570K0Q6sb/?=
 =?us-ascii?Q?hrTPNRsuEM6QYSzdU03FeBlNAzMKrUEYTer98vacxARsUcdgcSSXScDzGrlN?=
 =?us-ascii?Q?1NPzGNx4F34Ba+6yjzaD5TYFYO86rqkuVUQgx9BM6dMFxx7Y3Ku7wurcRoqE?=
 =?us-ascii?Q?gOn+JZV0Q5nlcZhX3gTjC/f9tbztvyF2gaDe5q5Dbn5dvIAeWIQVtdVcK1wa?=
 =?us-ascii?Q?y/0Msjdx+uR9FaiAPxksKFxrp8bQzy+4oW5WEyQj144rBvJFdKHgU63BHQct?=
 =?us-ascii?Q?iy337rE22sCj8Pw8cwJULg/4uB7DrLMcj471VpYL2ITN+XN7xZeIhA9HM6HN?=
 =?us-ascii?Q?/YHX4tKYnJEZGYm9DqQKI8kUZiWNLkJNQ4mqBsSU91cwhFkRnVdNHZEWeMkk?=
 =?us-ascii?Q?LsQJ/DSQkkEX3KIKBJqeLgzH35A73Z4L5LVvMCnJ8mCvxD712baQhJu981lg?=
 =?us-ascii?Q?XDX16n5kTVM5r6QlNyCJ8TvoHtoobSAZ7CjnlUGjVspID6fpek/ZaHVLk449?=
 =?us-ascii?Q?m3+hb9tS+c0S4mgNawg8O0+6xnQpJsakFijcAwlMfX3XerrtrnansEnXXyUH?=
 =?us-ascii?Q?HnoI5gZ/+YoDNvZRECDANXhtVmMzO3dmjE1oGxq/2121l0LaaiCisolE08MW?=
 =?us-ascii?Q?PVhMpH/K77/Hq25Ldg2vF0JYdin2+b/uss5N8/7U11JE+dt0jpbTeP4MLyrc?=
 =?us-ascii?Q?qNuPqTZhCbVGWNh6R87gM0v1tat5EnqGPYTCdjy5abdNiiJY+OIz2wfk2hy+?=
 =?us-ascii?Q?m+CcgoNOWqxnF7tz6c8OcQuMgbqmAMeUeasywfnJoP3h2SSvwZV2fT7xFWm6?=
 =?us-ascii?Q?82hFDi4afUQLqrm3gnacPajHINRXCDVI7b4hb5eHtaNbmMfs/Tugv5XyKAnI?=
 =?us-ascii?Q?lcySGXWoINHem6RLR0MrVhq2lC8iEs46cP+rLlXP2eYgPqvHzULRzE0/ywCQ?=
 =?us-ascii?Q?k6KNo1x2z3XU/lkRu5X3q1nbwpvk3fX3n93Act4ye0KCuBZTSh50gzxxppn0?=
 =?us-ascii?Q?C0YxxzGqD6PU2F6avaZTPBPdnNp0cPUDWvlJ7AbA4koe8u3SnZUvzU7t5j2d?=
 =?us-ascii?Q?2UFFSfp7dr0mrNTM1NfnbGObv4rA5tDdmxzpGE7MJ+pjeUwORU//5xouNXcb?=
 =?us-ascii?Q?j/uAZWV7T2h7Favndi6FhNCoiGu5x2mtmzpu4lkCxkwY9BQh+IhS48AI0rVJ?=
 =?us-ascii?Q?uqPA3XaAQdCDgQ5Uk6NprjtdjPiJNzvJIfQWN3sM+A3a77vdpef/2cnFxEPk?=
 =?us-ascii?Q?0L4yVDAV4JP+jypwv/svsOhr2sNYTMsr8XGRIW0IDZNx3iurcyAHK5IajrMc?=
 =?us-ascii?Q?yaTXe5pw7s60wrZopn3FA0p86WgLW9ZvgZ7IJx+zGYL7/0xWsavFBPeRtO5p?=
 =?us-ascii?Q?Np1+etpdpUiaruGeTIalS3qegzsspmFlWidpOQJUoNrbzvemX0bCW3LDGDrt?=
 =?us-ascii?Q?jN+Az3XIhgkasmrI9WaXuPlZVoLGXFqWn0P0itOX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4eacbe-9d6a-42d9-79b6-08ddc8ec450c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 06:52:05.5801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueDw5n6dUguafamOhzOnboiqqtPrVDv9ZRzIP102wZ6il37TKcOPPJm6cOZOiWz2sxO2EUUdyXGHQj6Iq/X7rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5293

We don't support atime updates of any kind,
because hfs actually does not have atime.

   dirCrDat:      LongInt;    {date and time of creation}
   dirMdDat:      LongInt;    {date and time of last modification}
   dirBkDat:      LongInt;    {date and time of last backup}

   filCrDat:      LongInt;    {date and time of creation}
   filMdDat:      LongInt;    {date and time of last modification}
   filBkDat:      LongInt;    {date and time of last backup}

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v4:
-add both SB_NODIRATIME and SB_NOATIME flags
 fs/hfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index fe09c2093a93..417950d388b4 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -331,7 +331,7 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->sb = sb;
 	sb->s_op = &hfs_super_operations;
 	sb->s_xattr = hfs_xattr_handlers;
-	sb->s_flags |= SB_NODIRATIME;
+	sb->s_flags |= SB_NODIRATIME | SB_NOATIME;
 	mutex_init(&sbi->bitmap_lock);
 
 	res = hfs_mdb_get(sb);
-- 
2.48.1


