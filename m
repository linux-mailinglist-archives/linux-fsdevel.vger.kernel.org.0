Return-Path: <linux-fsdevel+bounces-20468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BBA8D3E65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 20:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55933B2253F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 18:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133A61C0DC7;
	Wed, 29 May 2024 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="nwYjA5cZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BEE181CE2
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007633; cv=fail; b=JZkse7e9ozbYn02HALUjZy+B9T/fE1Qd8uf9MDbsWw1E/6uqTMEAWyCnMWteVthywG7dys2kjjSZT5e2Q0/90pummf7v1o+gcC3W8lmOfm/mqOot4maIUPpumNCSXzKVT4wpc6St7GQ5Rv0Pe13rhAxTxYL1qjtfk/esOyENdd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007633; c=relaxed/simple;
	bh=UiR/dNZ7dNJHF37AOJKOZ37hrNUD3UcUslqH4BM6T3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=U8XZZfIo+hDj0GLmffcWO2ZGY+wvWcTkuThCt1EHhqM5WXudeOnWZXPVAWEZZSTTzmuvVlqnckD0pDZb40OchKwAEdcLtshaEIYcv5/K7De7/fRDucwQTiC6NSOPtYb4Ph1gTF2dTq4WuKNk4KlBEWOTh80SE5UGYlQ7QKjMDNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=nwYjA5cZ; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169]) by mx-outbound41-156.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 May 2024 18:33:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IY+ucr4HPA/PVnQQTVDsJsZlpZT/s3Q8CY75ICGFjpkNiWQg+k/ITDfoRBUVyRPKpS1EVJxveOOUsANw0O4WN8aa3TzJM6uyiLV5pkwfofPPXW0oHfHR9dQ0snw3x8Aeag/q/RmudGs1AIcT43YydnMymtTQE/VUM6tTtqiMBFUngP9yp7Qo/TK+V3EDK1Agaem0IsNi9Elr86AbtXy0VEmHaDy+I4N1tAl23yas47WGqTP7UhgU0iwUqJYkYTBvwdwmQR09J2IqNRHTTeAf+s1sRxSynr70Di/Cmsv0ScoM/0tO9W9bs0qrTqFoYZ2sLRw/8zAgV4rbTXnMQ1N3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vr/NW9/YhGdBIcMKJqXrTkdg0mxjcMZw+2iyxtlJgSk=;
 b=lkAB4O8wxrd0irYPkxg5wufWGIa+unBXA9NEm55Ayvi675T7SKb+lWX5h3T97Wn5xwfClScLNvG75fUeZiFW11ruyyvbO0q9w5fGRGTIDzvcyTp5L/sAZrxBDIsJ1DawiTBHiZbytuih3Eg2Fw+q8fdP2x2IDOJ6k2JtoqzFIpkqehhZM+C5Fl7N6n0AlPONcldEVcggRUpKgMNl3/oJB47Et3m0IeXW1fvunjuvY4sSjQqyJ+JcrnQhY9SblS1whzPNILYQCNPZwLLOvtSwEjXNLW6DiyK08SU8FVeb5SMD7k6LHSHRnXTaCJ+OXhCmqeugP/KtmBMpNIc4klSawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vr/NW9/YhGdBIcMKJqXrTkdg0mxjcMZw+2iyxtlJgSk=;
 b=nwYjA5cZwQjpAR+VJrgMS+wbckSCBPgxe6pD28NzszCrIDAIQkQ5BWquQNjkh7RPGKSrp3h1TjPhrCuOUeJxZctl+m4b+icU7pKqMKk+t7kCyY4NS2s+lSlNGITNcxjMrXsUtR7KJEod+hFHOxJdRKaxwlXtNV+8Od/XfwX4d1M=
Received: from BYAPR03CA0025.namprd03.prod.outlook.com (2603:10b6:a02:a8::38)
 by IA1PR19MB6348.namprd19.prod.outlook.com (2603:10b6:208:3e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 18:01:08 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::ce) by BYAPR03CA0025.outlook.office365.com
 (2603:10b6:a02:a8::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Wed, 29 May 2024 18:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 18:01:07 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id BD54927;
	Wed, 29 May 2024 18:01:06 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 29 May 2024 20:00:53 +0200
Subject: [PATCH RFC v2 18/19] fuse: {uring} Set a min cpu offset io-size
 for reads/writes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-fuse-uring-for-6-9-rfc2-out-v1-18-d149476b1d65@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
 bernd.schubert@fastmail.fm
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717005648; l=5938;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=UiR/dNZ7dNJHF37AOJKOZ37hrNUD3UcUslqH4BM6T3s=;
 b=jwH1NNkTB9pgVCT+hqR5xt8DCT3lIlxqLWvGXzIiX9QJ0pUcnW/141MPj6iTve56legg9KqjK
 TicFkZX8PwfCu9N+qYLyUVQBqnukk749rGmCUuGLc87fi5ttk9cyR9y
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|IA1PR19MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: a40eaefa-da25-4f7e-9d59-08dc800950ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVNxZ2dSMlNORFFzR3RtQ0pvMmVqOU9IeXV3VUF0d0NNb1VZNm5jRHBzdGww?=
 =?utf-8?B?R205a1dqek1IbnlqWk40a2ZEL0pjZ2ZicGU1dytnMGE3TjIrZDNUL2U3SDZJ?=
 =?utf-8?B?dHhUKzl1WkxXaERzclkxeFBCRWlPVkk4MndscjBwd2hIeFNrMXNhT2R6UnEz?=
 =?utf-8?B?ekRXaTVvNFlnWlZpd2RUc0pIMzZ2TW9kcjgySkNYakVvN3Y4MjdvdEhuVWpX?=
 =?utf-8?B?QlphMjdFMzhCbjA5TEVXdTRUQ1lpMFZYTS90QVQ0UWh2Sm5sRXVSVTdSdWg2?=
 =?utf-8?B?T042clN5M0NVTXJLajVXLzlpaHI2bnlBRnJ4VEF5ZzhSSStyQzFuSXoxb3py?=
 =?utf-8?B?TkpOejg0aTZqRlFqcmtHaXpDbVp1QmFOZ2hQMmhneDJ6RU11V3RFWG9JcW40?=
 =?utf-8?B?L2pNK3VZVC9qWThXSGMweWpMTkVBOTRQRHhONTZNQWU4d2FvdThVQ1Jieisz?=
 =?utf-8?B?Z1NWT2Q1WVo2ZmVJbzJkeWhZdE1GNmlQeStRL2VJMTh6ZmlYMzRGNDZ3cGd1?=
 =?utf-8?B?OWdyamhTV1Z0ODViL08yYzZJczFvYy9GU2JqWXlnOGV4dFRXSFlLT25KS0Vk?=
 =?utf-8?B?U2tiQnc5NnNvQmRRMjBQMTJxdS9ueTNPSXp4OVc4N3BVUHZ6RzA0L2lFVDhW?=
 =?utf-8?B?Ti9GdllLT3pNM1l4YTJLbW9VcGp1Y1VUUHZOaVFUY1lIalhGUURoQU92NWY0?=
 =?utf-8?B?dHV2VkttV0FDZnV2S2ZqSEpvZ0tNSldRKzFoQzhiRzFzcVdVU2VmOCtYbnV3?=
 =?utf-8?B?YjVqM2ZlSTdNR0NCZllmOE0yYWEyNlRGNkVFQytPUXlpdmU0ZmZscmxGbzFZ?=
 =?utf-8?B?WUJGUk4xeWZXNjhJYjc2ekNRdERFUjZueVpDYTRaekRrbmtvNVA3ZW9nb3dn?=
 =?utf-8?B?QS9TeVVOY0tSZDBjY25NZGlJcmNtTnJPZXV0VUFNT3FXSk52SmZXb3o1RjIy?=
 =?utf-8?B?M1ZrTUdqUy9NVHV3QWRzRXZoYnNsM2lKK2NZckRkV1hrZGc5YTErVjJlbHhH?=
 =?utf-8?B?RVFBdEg0enNHcnpqZEdyOXpJTmFRL3BRVVE2VXVKdlBWb2ViNERQZ0VoMzl0?=
 =?utf-8?B?WHp1R0xwZ284ajR3RWlTQmhCaHRjUkZMd2cweGRpMWR5Yk4zQmwwTXpsTG1P?=
 =?utf-8?B?TUl1NVNtZE02amZ2ejQ0OG5XNExxUDdQRmttVzUzdWZ1SWdHcFYvZnpFZ1hD?=
 =?utf-8?B?M2p3UU1hSnh5eFBiTnpPMGxzUFNnY2hpTmFjallXYXY3MHQ3a2JEclpqcFU1?=
 =?utf-8?B?QTg2cHMwcUh6dTJtMkJFV0JyOVBqTkcvc1JQOUZGeGN3YXVMbGYzWXFQaWti?=
 =?utf-8?B?ajVQK0ZiWEVJcG5Bb296ZzZVOHg1NWREVUhRcFdXNDhMT1hCTVByMGhxTnNU?=
 =?utf-8?B?cXVHWHU3UFNEeFlTQlFtcDJoa0ZhUyt1REhMZk9OUi9NeE53MEFJaFVBWW8z?=
 =?utf-8?B?NkFQbmZkS2dRcThCc3hzU3VOTXVlbDRiU2xkWUNGaG01ejE4T09ha0Jld3R5?=
 =?utf-8?B?bkREU2JkSnRTZDBMeThyYnZQTGZ0SCtwd0E5Y2VKU2N5a21MdXFlNjI3WTRp?=
 =?utf-8?B?R2V6Q2tRa1U0RnlpVzFsaVRPbGF5Z0IyOW42dUQ4eGxOa2YySjV4NDg0cWFE?=
 =?utf-8?B?c2Q4K2FZMEdWVE5uMXI5RXF4VHl2cXRVV2M5bGhJcDBZVHRHeVk4cUdIR1Fk?=
 =?utf-8?B?K1ZEMVFIUXUrM1JRMmtDaUhkMlBPRVBBRVdIQUZ3YzZtRUpkNHNoSnY3Skpo?=
 =?utf-8?B?VmdDeHMrbWxseG9BdHJtSU1TSTZJeFNvdjFEakhTRUdKczh5eFRtS2tlTXJn?=
 =?utf-8?Q?W/5P5cK35j+xhD0WGW0ZN2NGPnSWFioBwI3wA=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AZiis/IZ7zm9bNLJt0Y+FCVRFNK2aWOY+mqfavrrfQZW3Vfhn4dI/7DaRR+i/1bKXhmFY9A1Qu1sunvo/A+qICdD8defzA2aq6v/NJKAtGcdgKPjJ/kGajOt8HC7gCvRQR9Td5cy00K5wHAnCVFzyw3X3J1mgPfzvpdvy61PUBiJWONvuoS0s2wxwZww4YBU7Txv5tLYJU08JqEpFjYc6O6g1Spmn/GXp+LZHacWExZWeFVfSrCvbK/H7Co2+mJxxIw3a8vQU9XPUC3HwTma41Liu30mIFKK9VrNk/er3VzuM38pNFflBUFf/HqWB4rn2Vb0+wMpVQtuZS8bYCGVBvRt5jKVytfOHYuBdcke+n6RQDhggJfOj4cka76ZtM5mEyXt93TK0CsCCzOfMZ8VE7hafN5miNvJ7U6lBArZMF3MLd+8kz1UQH231pILniyyUBtGTCeFbQ7/ph40uIBXtJ9WWVBL42HfRVM7mwela4MfIoqsF8qpryIdqcLWPLLQ4GsClbFZMu55xyv5RKl4o9ZwfS/EpYouNhjZLsJc1BDb9zGdzVFOIU6Mz/PMKi+/QBNnI16FWZlcvPqSm/1L66455XzHx6cbG0yxWVmx57swlkoOePzZKyDhvzAynCmZVdbb54JSS2/NGLCtWyJW7A==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:01:07.4574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a40eaefa-da25-4f7e-9d59-08dc800950ae
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6348
X-OriginatorOrg: ddn.com
X-BESS-ID: 1717007630-110652-12823-23279-1
X-BESS-VER: 2019.1_20240429.2309
X-BESS-Apparent-Source-IP: 104.47.59.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqbmpqZAVgZQ0MzQKDnFzDDVyN
	zM1DzJ2Mw8zdwgLS0x2SQpxcQ4JdVUqTYWAOD2TRlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256584 [from 
	cloudscan13-24.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This is another optimization - async switches between cores
(as of now uses core + 1) to send IO, but using another
core also means overhead - set a minimal IO size for that.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>

---
I didn't annotate exact benchmark data, but can extract it
(but needs verification)

jobs	/dev/fuse	   uring      uring           uring
                    (same core)  (core + 1) (conditional core + 1)
1         127598      313944      261641         330445
2         254806      593925      576516         551392
4         626144     1074837     1022533        1065389
8         1535953    1892787     2038420        2087627
16        2259253    2959607     3521665        3602580
24        2606776    2769790     4636297        4670717
32        2287126    2636150     5389404        5763385

I.e. this is mostly to compensate for slight degradation
with core + 1 for small requests with few cores.
---
 fs/fuse/dev_uring.c   | 69 +++++++++++++++++++++++++++++++++++++--------------
 fs/fuse/dev_uring_i.h |  7 ++++++
 fs/fuse/file.c        | 14 ++++++++++-
 3 files changed, 70 insertions(+), 20 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index dff210658172..cdc5836edb6e 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1095,18 +1095,33 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	goto out;
 }
 
-int fuse_uring_queue_fuse_req(struct fuse_conn *fc, struct fuse_req *req)
+static int fuse_uring_get_req_qid(struct fuse_req *req, struct fuse_ring *ring,
+				  bool async)
 {
-	struct fuse_ring *ring = fc->ring;
-	struct fuse_ring_queue *queue;
-	int qid = 0;
-	struct fuse_ring_ent *ring_ent = NULL;
-	int res;
-	bool async = test_bit(FR_BACKGROUND, &req->flags);
-	struct list_head *req_queue, *ent_queue;
+	int cpu_off = 0;
+	size_t req_size = 0;
+	int qid;
 
-	if (ring->per_core_queue) {
-		int cpu_off;
+	if (!ring->per_core_queue)
+		return 0;
+
+	/*
+	 * async has on a different core (see below) introduces context
+	 * switching - should be avoided for small requests
+	 */
+	if (async) {
+		switch (req->args->opcode) {
+		case FUSE_READ:
+			req_size = req->args->out_args[0].size;
+			break;
+		case FUSE_WRITE:
+			req_size = req->args->in_args[1].size;
+			break;
+		default:
+			/* anything else, <= 4K */
+			req_size = 0;
+			break;
+		}
 
 		/*
 		 * async requests are best handled on another core, the current
@@ -1120,17 +1135,33 @@ int fuse_uring_queue_fuse_req(struct fuse_conn *fc, struct fuse_req *req)
 		 * It should also not persistently switch between cores - makes
 		 * it hard for the scheduler.
 		 */
-		cpu_off = async ? 1 : 0;
-		qid = (task_cpu(current) + cpu_off) % ring->nr_queues;
-
-		if (unlikely(qid >= ring->nr_queues)) {
-			WARN_ONCE(1,
-				  "Core number (%u) exceeds nr ueues (%zu)\n",
-				  qid, ring->nr_queues);
-			qid = 0;
-		}
+		if (req_size > FUSE_URING_MIN_ASYNC_SIZE)
+			cpu_off = 1;
 	}
 
+	qid = (task_cpu(current) + cpu_off) % ring->nr_queues;
+
+	if (unlikely(qid >= ring->nr_queues)) {
+		WARN_ONCE(1, "Core number (%u) exceeds nr queues (%zu)\n",
+			  qid, ring->nr_queues);
+		qid = 0;
+	}
+
+	return qid;
+}
+
+int fuse_uring_queue_fuse_req(struct fuse_conn *fc, struct fuse_req *req)
+{
+	struct fuse_ring *ring = fc->ring;
+	struct fuse_ring_queue *queue;
+	struct fuse_ring_ent *ring_ent = NULL;
+	int res;
+	int async = test_bit(FR_BACKGROUND, &req->flags) &&
+		    !req->args->async_blocking;
+	struct list_head *ent_queue, *req_queue;
+	int qid;
+
+	qid = fuse_uring_get_req_qid(req, ring, async);
 	queue = fuse_uring_get_queue(ring, qid);
 	req_queue = async ? &queue->async_fuse_req_queue :
 			    &queue->sync_fuse_req_queue;
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 5d7e1e6e7a82..0b201becdf5a 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -11,6 +11,13 @@
 #include "linux/compiler_types.h"
 #include "linux/rbtree_types.h"
 
+/**
+ * Minimal async size with uring communication. Async is handled on a different
+ * core and that has overhead, so the async queue is only used beginning
+ * with a certain size - XXX should this be a tunable parameter?
+ */
+#define FUSE_URING_MIN_ASYNC_SIZE (16384)
+
 #if IS_ENABLED(CONFIG_FUSE_IO_URING)
 
 /* IORING_MAX_ENTRIES */
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6fda1e7bd7f4..4fc742bf0588 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -7,6 +7,7 @@
 */
 
 #include "fuse_i.h"
+#include "dev_uring_i.h"
 
 #include <linux/pagemap.h>
 #include <linux/slab.h>
@@ -955,11 +956,22 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_mount *fm = ff->fm;
+	struct fuse_conn *fc = fm->fc;
 	struct fuse_args_pages *ap = &ia->ap;
 	loff_t pos = page_offset(ap->pages[0]);
 	size_t count = ap->num_pages << PAGE_SHIFT;
 	ssize_t res;
 	int err;
+	unsigned int async = fc->async_read;
+
+	/*
+	 * sync request stay longer on the same core - important with uring
+	 * Check here and not only in dev_uring.c as we have control in
+	 * fuse_simple_request if it should wake up on the same core,
+	 * avoids application core switching
+	 */
+	if (async && fuse_uring_ready(fc) && count <= FUSE_URING_MIN_ASYNC_SIZE)
+		async = 0;
 
 	ap->args.out_pages = true;
 	ap->args.page_zeroing = true;
@@ -974,7 +986,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
 
 	fuse_read_args_fill(ia, file, pos, count, FUSE_READ);
 	ia->read.attr_ver = fuse_get_attr_version(fm->fc);
-	if (fm->fc->async_read) {
+	if (async) {
 		ia->ff = fuse_file_get(ff);
 		ap->args.end = fuse_readpages_end;
 		err = fuse_simple_background(fm, &ap->args, GFP_KERNEL);

-- 
2.40.1


