Return-Path: <linux-fsdevel+bounces-59154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 859D7B3523C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 05:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AAAD1A8617B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 03:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346422D3225;
	Tue, 26 Aug 2025 03:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="C/GJJNfu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012042.outbound.protection.outlook.com [52.101.126.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EB98488;
	Tue, 26 Aug 2025 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756179376; cv=fail; b=SIHAsRIa3OhZJeXKPqH8HB6mNuEE5hyOf3WE8Xx5q5PmIAjwZ5qI8QrlvwZZlNB2jSNosdw6SKChUGdrk24SC2Ny7rZbMeGAO66EZrER6c8aCwdRzDNeAi7Dvz41dOO4/Z59m7UTvdprFK06yVR8CANGgYplBOqdbCYsDAA4r2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756179376; c=relaxed/simple;
	bh=EzyZDst5m2Rp+mHQhhH50ybmkpyIks8/itm/SK9OW2s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sACcQ6ykKGVEgNNQCCbi+mWyX07dmpAaSJxZXn0g+WLr7eVfuN7DMvsAsrUaMNetQohjzK324R/BmWYkf5u3KgHHf20Z9wYEP8MHvXK1crT4P1EsyhFpIeFdoRKFJE/3+KSRpzRUO5dSjHlAauWky71VLTZV6iwWAKv2AtP38JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=C/GJJNfu; arc=fail smtp.client-ip=52.101.126.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEC2kLcyzWIlvNarj3/NQYC3M3dyBJvBTAciFufUYm+8R8xUd/niIgCup57w7zYepF//5UorhLDWn19qJrNo1CYJTfce39c1JYm1NUXKaFzBi2fTt9yrW/EP+Ulzqeq/5fAJWFCQkssLwIqH3UsbxK06pEzoD6tMop4d8iXQBg427o2iMEIPRPG25YC71jM/WBVI5Vhi2QiNCYdeSqk0TJySFQmIKkDHbQWrJFu7ZPB8+nsRjFoQShNaNLA2pgvgXE0Duri4cwKvKbiH/utvHtLlffFPasr5kOVQAiiZZ7LAxYO1aEZNVUrIZLPqrhFDPSeQg07W+5xEYW/RTpjA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiRqFaP15JSQKofv5uuf2ihubgckcCrIly9RQs6+kik=;
 b=NU07Ka4Cdhvw8oUG2dwM+i2ym1E5UHcR6OsnByv1fzwWNJeUlJPLzoRgfTo97z7cTXR6+l/KCexjXl6Fd8tbWUkNGcak3R6TPNTn0cP85G5gzBlOHl5Wcth+eBhSdVcGWtVa3MTWRE8GObZ4WWDOei6OZSb3NG3rfIpynb2e1K/me/Jot92WxRqzyiw/x4ZHELGaOXS4Yok+51e+RZOG0U/AvR49FzcngJGrdEALJH+qKlC4OOP5Wk+06cK3GE8Sq1rd7HlFq7fdLSvTvJf8g1K5ur/02syD6sbs4gNumZr+EkmlpqI00H0AH/+YXJW/q9/rKzrfsr8K5UcRAvLjug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiRqFaP15JSQKofv5uuf2ihubgckcCrIly9RQs6+kik=;
 b=C/GJJNfuJCJ8UpjN3ZHwq4Un7Za/kcfkn4T7+lqvmYWHE5AlgKZxda1hopK19rA/sRPyh2iXy+VGAqfMMR8nH6bmPRCBNDya6twF8c4sfk1tt7sLm0gKQ+jwUWKbrfB9r/aP2VpmVqhgavdlOB5kE7VFSruVLpdkVLJ9kYwULYOVbA5XiMfDyPMTniDi4t2Op56MlO/rOMoIwNXyuSHZGhPpb3q2JOUmZpqym5UFmjvs8r4C51ft9T9n/SRNiOPME6VVJ87nU4vdqxXZcEZL2le3geK7UPjJWcHJL3+3iwy1pNeiVyZfF5NHj10TvlzRCs+sXNXlHW7ZRwY7Z1LJZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PPF5421A6930.apcprd06.prod.outlook.com (2603:1096:408::78f)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 03:36:11 +0000
Received: from TY2PPF5421A6930.apcprd06.prod.outlook.com
 ([fe80::6370:9e0a:c891:a1a9]) by TY2PPF5421A6930.apcprd06.prod.outlook.com
 ([fe80::6370:9e0a:c891:a1a9%8]) with mapi id 15.20.9052.014; Tue, 26 Aug 2025
 03:36:10 +0000
From: Chenzhi Yang <yang.chenzhi@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Chenzhi <yang.chenzhi@vivo.com>
Subject: [PATCH RFC 0/4] Discuss to add return value in hfs_bnode_read* and hfs_brec_lenoff
Date: Tue, 26 Aug 2025 11:35:53 +0800
Message-Id: <20250826033557.127367-1-yang.chenzhi@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:3:18::18) To TY2PPF5421A6930.apcprd06.prod.outlook.com
 (2603:1096:408::78f)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PPF5421A6930:EE_|TYUPR06MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 4358db09-a351-45ed-77bf-08dde451b301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uaqZnqx3sbiXge1dMnCQjK5VHkU4rE++5RJDcEWyMX7BDnzLqij/AjxmFjcb?=
 =?us-ascii?Q?AwhS8DgX6XfafA5Z8dzrFbzyujxLF3sDXAHBO/8nmEA0iJH5GKKafEc7PMsF?=
 =?us-ascii?Q?J2eBPGfoacvAWAu3aVzDZRBAgRoz4zcUEmGtts8CVdjQXDmMjHtWG8NjJZzf?=
 =?us-ascii?Q?UFmobOTSHhm6ZBiqBq8jmtE7JETIyJV6OZVxVgWY0qOj5MuBfhIS5TWZXkWB?=
 =?us-ascii?Q?3E3fPrgmFCkfVPFa9/pSmvNK3WdV774Y0Es0JF9icQ8qLUpBwswO6qTWi1jx?=
 =?us-ascii?Q?7PvI5gvJwbd0E7WoStyR39lcSKCjFP8+xLnegya2eqTV9/0VJ0yYSLgm5JR+?=
 =?us-ascii?Q?zgeG0sSc6bMvcclCRZ+8e6GkQhatoovp3lJFoFyMjAEKvc0m1QX1XqHfDvbY?=
 =?us-ascii?Q?cu4/lKvDECLqtCdOkuOaH4L1hsRPfCTFImc7Msacl/bsveWC4USDx3F6skQ7?=
 =?us-ascii?Q?6ohzTpIGivPZ3suSPq0MktgWOqOIvBAp1J2uTV3NqrFMKlLMex3ntSYP52rg?=
 =?us-ascii?Q?X/nj7VKpeWB3TyjTMAMy5H9hEqJuHy/v0Or9bx1OvlsCHe25l9eVCTLujOKd?=
 =?us-ascii?Q?TpVUay3b9y/6EyCm1+5duvCBXXojag0NIwUTl0gITCb5K8qFyFy2IThz6JNO?=
 =?us-ascii?Q?WMpFDSsBKjhGo/i1xZDIO3FaDKxG3IsnAiNryz/XHbukMJvuDychqUHP45kC?=
 =?us-ascii?Q?h+DcptCoBmcgIKz7oqSN5x0PXLmPojy3t2Lp5lKKYNxnbHqU+pgnsEtP5K3H?=
 =?us-ascii?Q?rm0XMYeuRDdNTKbsg9AneyPapazrWCV/1gy5XQaolmyl3TAVWop1CC33h18u?=
 =?us-ascii?Q?+P6Bq5LSZTV3KMxXkPGzHxudkS7Azwz0wxQBNVsBrLaUmaqgnaP11K8doDbv?=
 =?us-ascii?Q?i0RVuIDctM++xiznoFYr1rjJ6mcXPFBDKJ1uWvS4plHbTaA9fqeo0kFReR2S?=
 =?us-ascii?Q?dMT9xMp4Os+zQxtaL0r8pEqWZ98sYz450q5RowBSxV2TvcZT20oHMEWaYLSG?=
 =?us-ascii?Q?2GlVav9ZM/B3ZUIM36DDrs6/xrNsyaZadFyjOWBwG+UDq1zerMS56nC6Mr8H?=
 =?us-ascii?Q?9pOTCxOh+2PDEQA6Mfdo499g88K7oke4dJSP5yN9HMBIrtWJMM9YPNzSQTKi?=
 =?us-ascii?Q?NA2nLiosGrmj3r5iucjEGY03kMOE1KmNPA2YzfDukBCjsdmj/w9apiz4RdgA?=
 =?us-ascii?Q?F2/ybCOS9QsT2+qWcxr11d6zR9UHnT+DAQaKJ3Kb4wcjAzd91HoEM837z9om?=
 =?us-ascii?Q?/oHxJQBF/OndLC3TfldSSBp49MPCJgVnbEn4HfJPtyG2vdQW2XF+065/d6nh?=
 =?us-ascii?Q?k1YtUytOjd27i/g8SlNSkTSBOdMMfDjwB1gMQbkbG71jF9J9z9CZ0ygZRHAx?=
 =?us-ascii?Q?c+fFZeyTcZ98y8VIzZKLyd16gyPQsJdLV5b3s+n/1vJfIMAP/UUPy9CAtaur?=
 =?us-ascii?Q?JJ0B2yyZPUQOsN0W7Wb+jtpLBJEkbx9b+PyMFr7/tDPnQ/5PkIauAQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5421A6930.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/rtjROq/gFsc33CU7gOCdOcJMNWNnfeu15DwjBsySQ0yk3j0cblBRZRhMdJp?=
 =?us-ascii?Q?gRFo0qLSA49c6HMKhHbXUmlVH/M7oI8smnllg/Zob7BB6H/DHdcXllY4tEcx?=
 =?us-ascii?Q?TRh1R9dcTpPs1gxsnJs2fYFL6af7ge0Rt4q6RPT3tvy40lImZHXEfYNDxvSe?=
 =?us-ascii?Q?zsoQFgAoU+24rqS3NgQ0pny+mpuYhTjKjNn4ESqdLSLtB1nWr9EVJefEXGkP?=
 =?us-ascii?Q?ftThJH3Hn65dr54hYwH8ARM4FOWkNu2ljNGG8MH8vLjq/pptwPRtBfRNDVRC?=
 =?us-ascii?Q?pTRKT+nwBdaWphXobcPHH9WKQBRyGP3Yx57xSOrpekpQSzaVvN6yfHE97AIk?=
 =?us-ascii?Q?v94IFsej+M9u2lk0QNW4WXWWnUTDD+UAe034UJ+IzUV/w03fu07akqF26F6x?=
 =?us-ascii?Q?4M551Ts+ePQQjDFGdJib2NliQEa60pX4G+qQSV1lg94eukCA73BiODH9iGb2?=
 =?us-ascii?Q?bbvg6h0tuyJ72UEoow+WCP1G+igyczjGizvP5SuE7IdHhx1gXzviyne6gD+t?=
 =?us-ascii?Q?B2e3S09+87PE5SbjnhiFqJK9HZgBiSfCKjPWD6gWJE8acGMKmfriJJA/Wobx?=
 =?us-ascii?Q?tMpY/wq5t/xN99NhLyoxcLsXigX81HnbrCHElvBlTJx78t9jpNcAzlJy7VKP?=
 =?us-ascii?Q?ejjowCcNSnIMjTKIN3BKZJcwqKM+pGxVLx8zWjo2q/c6Oh6/vcy6S1g10Vgi?=
 =?us-ascii?Q?dgwm+oVCnRLuFdsKpPllPsO14jRsgsq9GaBhZToEqPntulJYdNRHc4GjmQzu?=
 =?us-ascii?Q?J6hKWrpsnFHdvHXjBTIxoMR/3ZeUq6h3U8L/q4IDOB0Nqf4tfAjNh2LkTX7i?=
 =?us-ascii?Q?1U22uTJhE6bA6nSpObye+EYw87xoUSy4i/dCnrAKIoJ6EKgq3RXXJ6Qr4oFo?=
 =?us-ascii?Q?VStdwYqmnGvF8VV9CRXiPcXG6lsnXNU5f1Ph+EcA0yNeW2b+Tc+hEJ+k1h2R?=
 =?us-ascii?Q?qyU8V+7Y0Ln9A07OopHNkyiLEzDexcewbxsfNGTh78euCiFOaNVU1zhrwSrG?=
 =?us-ascii?Q?GFrHT0gRyVCPFdpB/Hh0gC0HELgvdJqE29z0Qm1zc+d2kuoo/wt/bHuWnkho?=
 =?us-ascii?Q?9WuumhqyqlpVoR5L1nfKCs1AcJnEcX9DjWkVYGta/S4owJqY/jGPYNbCJ1Dk?=
 =?us-ascii?Q?EHaK1HCJLlB/M1JOoI9/UPk8T+CpLcVK61qHUonbY8fAkp40xu9QyKJqgsaK?=
 =?us-ascii?Q?FSTXQhKIvSG95ObJ/uQTdXoSNPndOljbYGge0HK/CluwoSkxl/ln7AlvQI3s?=
 =?us-ascii?Q?WRRC57dtkgSiXISJchlGFHR3kpfRXq5aDMAWWbQjEii6S4gbb64xSJnwlDkq?=
 =?us-ascii?Q?ftXQ1lRAffoVMkm/kc17WpSAqb3G0aXZjlc4IyWjNrlrCJ+7VFjhoNUABJ+W?=
 =?us-ascii?Q?fiFSxz5ggNpgdmXZqSDZcrRcgQtpOYYhqIx5KWoi41agM3IgB7Fn8JbRuR2q?=
 =?us-ascii?Q?J32sHqPez4j/YwA2gxx8+eUYRWSe2whfji47D3kyEr0/JXRytMicnR+PWkvp?=
 =?us-ascii?Q?WDWBsHxPRcmyDBXjD34nVy4206BHdqKl6dhaEHw1P3pzYF+ahmjSCrvZtdz2?=
 =?us-ascii?Q?Dy2wlAN2dRAykB1eqla00f84igdJh7U96H0SS5dq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4358db09-a351-45ed-77bf-08dde451b301
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5421A6930.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 03:36:10.7231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3cz14Jvk54aKW1S//80d2Qepf0UuQpdO5raliunsbl+FKpoD05GPQwyiGWn6jqvhy8L3M/B0NgKyCbPRiSmJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027

From: Yang Chenzhi <yang.chenzhi@vivo.com>

Hello,

This patchset addresses two issues:

1. Unchecked offset/length leading to out-of-bounds memory access. 
   syzbot has reported such a bug in hfs_bmap_alloc, and hfs_bmap_free
   has a similar potential problem.  

   To mitigate this, I added offset/length validation in `hfs_brec_lenoff`.

   This ensures callers always receive valid parameters, and in case of
   invalid values, an error code will be returned instead of risking
   memory corruption.

2. Use of uninitialized memory due to early return in hfs_bnode_read.

   Recent commits have introduced offset/length validation in hfs_bnode_read. 
   However, when an invalid offset is detected, the function currently 
   returns early without initializing the provided buffer.

   This leads to a scenario where hfs_bnode_read_u16 may call be16_to_cpu
   on uninitialized data.

While there could be multiple ways to fix these issues, adding proper
error return values to the affected functions seems the safest solution.

However, this approach would require substantial changes across the
codebase. In this patch, I only modified a small example function to
illustrate the idea and seek feedback from the community: 
Should we move forward with this direction and extend it more broadly?

In addition, this patch allows xfstests generic/113 to pass, which
previously failed.

Yang Chenzhi (4):
  hfs: add hfs_off_and_len_is_valid helper
  hfs: introduce __hfs_bnode_read* to fix KMSAN uninit-value
  hfs: restruct hfs_bnode_read
  hfs: restructure hfs_brec_lenoff into a returned-value version

 fs/hfs/bfind.c | 12 +++----
 fs/hfs/bnode.c | 87 +++++++++++++++++++++++++++++++++++---------------
 fs/hfs/brec.c  | 12 +++++--
 fs/hfs/btree.c | 21 +++++++++---
 fs/hfs/btree.h | 22 ++++++++++++-
 5 files changed, 115 insertions(+), 39 deletions(-)

-- 
2.43.0


