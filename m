Return-Path: <linux-fsdevel+bounces-42835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFFDA495AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 10:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D743B09EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 09:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B74E24BC0F;
	Fri, 28 Feb 2025 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b="jJrS9eON"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11022138.outbound.protection.outlook.com [52.101.71.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332181FDA8B;
	Fri, 28 Feb 2025 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735804; cv=fail; b=pL3qZ2VO/JpAtikuP+vaEWm5eSlTjWXGWITL8vuOPudEyERuzqA8WFo1+HAS5UrvoRXiD3JXnFhH6LMb3cKRn0vGU+mbovnpUg2jeRsbZYeY+kIvA5Z+raEaBIaT7QOr5c8rDdaBHoYSt12jK2AXvNEJYwaRE6HppDhW7rJvvIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735804; c=relaxed/simple;
	bh=FwOiP0OvhHuDVEcyA/poFIbk7LCQjN6wPfXTkqBOVoc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IYlcwVoolk7ZrXxyFf76btCqI/A+v+6IsWe6XLR3PxLNIsOfgk7zbpN4vjeAb0T65Eah3lyY082MgvCXymrzmf6WiB0QATDyLUPvirz1MjJvlACdMb4uA3cWp6rYBWJs7Eqj8KuaYNb33BM7N2Vvid5ECVIlIo5VtKKYC9q/lJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com; spf=pass smtp.mailfrom=tuxera.com; dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b=jJrS9eON; arc=fail smtp.client-ip=52.101.71.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hs+Galjy16/sFBqwkIvV6+wecktWg/BlQjqcZ6I1NxV7+UyD5dusrEcfaab0uh0meWhcFuya6XXJgWffzNiMjmInOURj3/VIlEaWfYvYbYi3MSwP+7SGkyYPILjNL304J+mvCzADmobZCndJe+cNxn5oec/AAdNs2QQFKuRV0aPnCPd7P0+TaYzTD6TY0SrNOATkah7akAVdhadF5/pYPJhUwDINQVaSBbk6eRvphUaQFtlmQ7D7FXZiVNaYd3H6K+3kJRSw7duawsm+SkQLDKiR0oL+XMrJKs4ipLBUlDkfPHB8Kk9lOYu3ZOwp1TCOQHwFprVGM6q8fH0cwWhHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WT7PrC0x2uGx5KzH9n8I5aHcm7KqSEmVwfSZAAg+PPE=;
 b=v2Mmus+BP5y/GnZVoliFw5FZNiSOlWwdNKjLoyw2WK99jxqaeyAD1S+p7oZCxHhR7crT+Gw9C8MUVbkq7C76WEKB45ufD40tRDpSdsCU3baNjjMKF8pIk0Ibhp8FoOVyKW+x7+ckrl+4NdccvsUtgl/We8hBhD+CjN92ETJYQihA9ohF/NxcI8kjM96P7DSevBC1fkF21Qa9353iM+g4cVPdXgxHwT4QZkngdLEaRT3L7wG259LAjsYiw4aMXGRH7kBvauRpd7jjVhJJe8Nm2OCE0W4YfQ2xXZPqJAyWWPhdYqLRAejpYWK3EEzdL1zP2zqRm+1Aus6blBZsVnU4KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT7PrC0x2uGx5KzH9n8I5aHcm7KqSEmVwfSZAAg+PPE=;
 b=jJrS9eONpSBFfbYzFg/OEH3UkttFTRb9SpB75ihzJZPcQ1j9e/D1JV2zpS427/YvMtcHYYpqdt5/93kehUHJOvQul5CRBMf3Wr54GSPRO5oz7jhnDLWPz/RmyHd2mTZ9gRpQbajLoNqwWKCb3SpS9RtbB1cYARSN+LFdMKFaDqlORCjq4irppf2DNWOUKDKRNGRV2tp6L53yI9WymZnRk6IaeFRwWLOq2XJy9LoM3b+9cLqeOLgRxGoqV0T3UgvHpLIsH3v7BoihStjj4lJWW2lp9L59yu+uE2OznyQz5q73WbiLecdSH6GrPFJpbfh5g1y2ka7D9Q1DgY7FgqI9Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
Received: from DUZPR06MB8963.eurprd06.prod.outlook.com (2603:10a6:10:4d3::7)
 by PR3PR06MB6652.eurprd06.prod.outlook.com (2603:10a6:102:6c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Fri, 28 Feb
 2025 09:43:18 +0000
Received: from DUZPR06MB8963.eurprd06.prod.outlook.com
 ([fe80::3cf7:3656:c165:844b]) by DUZPR06MB8963.eurprd06.prod.outlook.com
 ([fe80::3cf7:3656:c165:844b%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 09:43:18 +0000
From: Mikael Heino <mikael@tuxera.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org
Cc: Anton Altaparmakov <anton@tuxera.com>,
	linux-fsdevel@vger.kernel.org,
	Mikael Heino <mikael@tuxera.com>
Subject: [PATCH] hfsplus: fix 32-bit integer overflow in statfs()
Date: Fri, 28 Feb 2025 11:41:33 +0200
Message-Id: <20250228094133.4755-1-mikael@tuxera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00003854.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:a) To DUZPR06MB8963.eurprd06.prod.outlook.com
 (2603:10a6:10:4d3::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DUZPR06MB8963:EE_|PR3PR06MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b6516d-9019-4e3e-5cae-08dd57dc54bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F2dlUWVUr70DWFFNRarRH+gZyOrYSEefjsEBiyRxPkqQL7eG4gN5wV8Ip5pz?=
 =?us-ascii?Q?7ZBvbxpaNeRTRZp902lXGqWa5TR0wyyGYogZRmmC90/Jbzw7mjgpVvr+qURZ?=
 =?us-ascii?Q?zH/1vTUJgPRxIteCGuHLpaSvJoAb8B2pwWoK1kbQ0hAP9psuqvSRxetCWBsy?=
 =?us-ascii?Q?/zSbq88CqifZNV2VowESCqJSjRZcYtYWC8Sd1vOqMHykyWfjy2hhAHixY3AW?=
 =?us-ascii?Q?GufsFFDnGP4njwaMxGh9d/BUQ4G1qGMddAvotyNnxdAML0xW/L5RxP+j5Xuv?=
 =?us-ascii?Q?HQfxe5WeepHdkumrBjF4NYvBHbMmUEh5kjmSg89ryJaVHWz1DcMNAcCN7l9a?=
 =?us-ascii?Q?vHiqFIjplMUiO8AHVQIeMsCh43FMrxhr286r6EfGua1mMDs56bp7n7+st4Ss?=
 =?us-ascii?Q?55lZl89qYxXPBARuGSIxYG3DYiuZ5RsoqJh7Ii7UGdeSLKcXHRoSdD0bn2eC?=
 =?us-ascii?Q?8oQfLTaKBM/Q1u8p+DCdQGtaF9beXbmT3l2VxanddmZe3lQlDFmDAxl0QKgV?=
 =?us-ascii?Q?pc5lWZSI2/Xm8yWYMFrvlkcWEccnDKS9vY3sB2swG29tZCDv1p6lAfxulv6M?=
 =?us-ascii?Q?MHB14t+iFcuFvgEZnpddAh3OKgIY+0CJL8gQPQvmz1iWujFanhlhmisrOtAe?=
 =?us-ascii?Q?zPe+UwhE8vp23wUjKe55a+MnTvKqCS094W+6Ps8kwqWBE/I3nHRGOGvHjzKd?=
 =?us-ascii?Q?ov0IY6MgDtS7bOhIVXci+J7Fe/7TH4Hvy4OVfd529gwYcteuU3ofbrT9l99r?=
 =?us-ascii?Q?GyCHSQkmx76TMui3CJA/kltV3Wcu35Jy/gRMpXO04yDd9mXQAR7GvWHatrte?=
 =?us-ascii?Q?Lccb64ZHKWFPmHk7uYBmdAAVtRNe6YZZCMUYTcT19aaooaQ/ZWNyVSw2EdUx?=
 =?us-ascii?Q?VXqk4hviAEf2YNSYRY9+Wxua8rA/m+/7APMzSA/TkcHygHVJlCLaV+DJy0Yj?=
 =?us-ascii?Q?/mn8Mup4lcxZhazLLhFCAJWy1nFFcA9Tys9d5jHUR4mXv3y2n/OU68ym6LO5?=
 =?us-ascii?Q?YgkTITBFIIjhJe43aFlFNUDcKZmFHDn9TEve7efb3mDFVTNfH4Q0MoyqqKsC?=
 =?us-ascii?Q?tH8QBJCbDbEVbIWM/uaImBnWjI3cs5k858Th6rozNzmdsSZsg2OrLYGxOYe3?=
 =?us-ascii?Q?y4/0zCAiO2TMOvLb3SoJcQj0PPYXmOv9G+PaDLKLZaz5PrsmmpXLqSGw9f1N?=
 =?us-ascii?Q?EU3py9Ogc5yT6gEOtbJh/nf+ll2ZLeRw0Fx49542tQlvElNLJnDU6myQQ+7D?=
 =?us-ascii?Q?GdifiPJrVbcU6WwZU20+xyDxwxPVHgwdSZQCJS/0E+V8FukEx65bvPZLxY2b?=
 =?us-ascii?Q?RoYlj1XC/LrNrjqji91A/8EHnLfTuA3LCugRz1Gzn73G20k7ntS3u7/K4L+u?=
 =?us-ascii?Q?AwWdT+Y8m1sEaeedSeY/+PS4qHVfEU3vWYWFoqW40fmAmJI6j1pEIK+Z9v8a?=
 =?us-ascii?Q?yUPpLuG7GD04ZG61ixmSoqI1e5DpIpo3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DUZPR06MB8963.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ri0WP7G+vh2vMhyEr1hUsMGHF5Jeraxn7KUFGEwcPT02qW8mulybOP7jMzP?=
 =?us-ascii?Q?iOViZRJd0AmF9A9W7N+rsPgqenVrb52whqZD254G6k/WbdjTQrD+cApmvy2g?=
 =?us-ascii?Q?ziguB7fp3eQFwYn++dp/q8uhujcXhPwxFsHAbrtf4C57WpbTbPRaT56SmiwN?=
 =?us-ascii?Q?/373+HK6IchCJo9ceq5O9AGbrtxgitSYtPZqnrlAdDO+H7BBd2O/M++FK0xQ?=
 =?us-ascii?Q?oh5SJlluOKl2MS8sSJALM9z9NtyYiDExljk+w8hHZnu6p/aVzD9fQsLA79HL?=
 =?us-ascii?Q?kPqHybbvaEwv3djky2bkILFa1K0GeC1+RvLTR3H8amY9vmprp+H8g2CsaQ/J?=
 =?us-ascii?Q?h8YBxZTcjxdYp3POkH+/c4L/VJcf5V3Kl71MBk33sLtBDDj/Ql163mQYCZK6?=
 =?us-ascii?Q?seAmD7BHISdhjq95A7M3U/xmgkcxGmKOH8UsjKhm6XVGH74kY3+VAty0agVh?=
 =?us-ascii?Q?b19xxzICWVTTG2jROPjn6wHaSwGczho/frNeFbXyByQLQzRY17cM644jpael?=
 =?us-ascii?Q?epCdUi7dNMlCT5RwLbm08uEPHFyRDV7C7rSUZJZOAbH4pLkZJ+Krqqj5aogh?=
 =?us-ascii?Q?KXVu/RO0poQOjLA+CdYHnu430w705MgY9sbk55y4WC2iFPSLWcLksP66mNTX?=
 =?us-ascii?Q?p0Z/dvOq6P8KHXzwiaUzPFBI9Fm3dnIztpIdEMsagkkECKKmmFwoExA0eE6k?=
 =?us-ascii?Q?eS3P4Mcqj4Yyz5oHKI5eawLMb9C+Ubqz/ksuQBJE0QOdaIGySOYlxzSQ5pDm?=
 =?us-ascii?Q?UUhDTJtrMO/tclu9fWsmNBY2MmOmS1PTb0sfvAvegaeCu1Q4frxYjh+/rpNn?=
 =?us-ascii?Q?VB9pHxKtLd5Y1owwsH9IN3Ad1KOMB2eJZfRaXpZdMcVxqGZuBczipZzU8WmH?=
 =?us-ascii?Q?XHc2Wef9uh4B7i1f3C4dqbSjQzSX2FjzHEFqGzZFivCdHYgtGzLXcySlsagJ?=
 =?us-ascii?Q?SAsqg0HoruX7zmjLDTUEcumb9YgTnpx4sOP2X9vlmKld9a8Zin8N9Duweul+?=
 =?us-ascii?Q?FrMyeCbr+SHq2nSvJCJFIsi2+LNu/WqMhPkNVf8B/44WS1K4gaTj+3MCgcu8?=
 =?us-ascii?Q?zoawGuzzs4+J4zbcZ7265fWoZO3Swn0BV7dt0/koGpaqADcHHp/WuYeHBitF?=
 =?us-ascii?Q?fQY4+TpM1MUH6uLTM8GTjdpJpSq9HCnF68+ZK7Y2ATKs2M9QJMoy8kzjicXM?=
 =?us-ascii?Q?e983mltLTgxeGRDQs16tMrA6M0Ff31n7Ye2FCZNAspHrmj0TVF6irzcU0vX/?=
 =?us-ascii?Q?day//0llxaYK+lQGd0Wx2GfM0LCV34QLjeILgIH1Ce6XQZ5IYruD/DOrQ9UU?=
 =?us-ascii?Q?efAIyaf8nOPSmuZ+sXSlRIgJd4gOLoDNj+dFYmaoQuwkLwLy7XkB4hN1WXt+?=
 =?us-ascii?Q?Vcui4g+RFltBKeGniAgxLVFcgvw3m+HdR/lQjapFfYbIGwTcXozqBriurT2N?=
 =?us-ascii?Q?wFCMYyyYbwjELWbYjxWzxs5Y7SUrn10E6a9tnl54dy8DZ0ZRHLaG4E3ljO9P?=
 =?us-ascii?Q?ybSQwSWeX1teiScezS3Lok1K6ngsO4zqKqX5j6Oks74rqekl7DdfxW7xgc7N?=
 =?us-ascii?Q?PaVoGXz3ss/1X692mbHq4JJYILMMNn3pj44m+X4x?=
X-OriginatorOrg: tuxera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b6516d-9019-4e3e-5cae-08dd57dc54bd
X-MS-Exchange-CrossTenant-AuthSource: DUZPR06MB8963.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:43:18.4233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTSafY46ZyrNz5WbXP1N0DJHYUPdZc0yUGbLvdAoAtIebZO5JrPdbtowpOe7ycgo1H7BQw+PLSBlMYSxvTdZZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6652

Very large volumes (20TB) would cause an integer overflow in statfs()
and display incorrect block counts.

Statfs structure's f_blocks, f_bfree and f_bavail are stored as a u64,
but the promotion to 64-bit happens after the shift has been done.
Fix this issue by promoting the value before shifting.

The problem can be reproduced by creating a 20TB volume for HFS+,
mounting and running statfs() on the mounted volume.

Cc: stable@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Anton Altaparmakov <anton@tuxera.com>
Signed-off-by: Mikael Heino <mikael@tuxera.com>
---
 fs/hfsplus/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 948b8aaee33e..00bb23b0ff7d 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -322,8 +322,8 @@ static int hfsplus_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	buf->f_type = HFSPLUS_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
-	buf->f_blocks = sbi->total_blocks << sbi->fs_shift;
-	buf->f_bfree = sbi->free_blocks << sbi->fs_shift;
+	buf->f_blocks = (u64)sbi->total_blocks << sbi->fs_shift;
+	buf->f_bfree = (u64)sbi->free_blocks << sbi->fs_shift;
 	buf->f_bavail = buf->f_bfree;
 	buf->f_files = 0xFFFFFFFF;
 	buf->f_ffree = 0xFFFFFFFF - sbi->next_cnid;
-- 
2.25.1


