Return-Path: <linux-fsdevel+bounces-55755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EA6B0E5D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 23:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E9B3B612F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A33728C030;
	Tue, 22 Jul 2025 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="0T893CDX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA931286890
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221499; cv=fail; b=abnWmsl6FMmM4CI9Kw+tAXdjyYfO+DpxY03sQDFGG1djD+R5e+dhNLiS07r2DKlYV9yBT9VjX/flO9llP09XIY0UptyoSyC2rdcYH5wVgL6rmBXriwkdXgxkN26au+y9WQ7+nUWBHDD0lGMcPdqEl3/Kf5/Q0nBMvMU24KbFaF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221499; c=relaxed/simple;
	bh=vSTQceXnZp/h+R7iq1i/jvM2d4NK/TLTUvap8pvT0Sg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f0z05Qr1QF9Kg2QIYKOu1eJnKhbbjP6kbq8D0GQj7cPyiiPxf0ZmFOnEDSFgGBKt6xLSH8LRn4Jbyk/FacIOjdY697GDh4F3HAxQUTzONTZrA1fV+IKAr0f/4CuEeJt7RDhwHXdSFErOh6HE+ylLblgxLrB+QJ73TQfYahuZIEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=0T893CDX; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2123.outbound.protection.outlook.com [40.107.94.123]) by mx-outbound19-245.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 22 Jul 2025 21:58:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyHfFDLoUy8bJb9tp/Ifdao19Pvr+wIRXs9O7Skl/50P51klzA44DCxfUdUNFW+4jK8amm94T74XZctQKHW5d4n2Rx/bYqRgTG7zDth+3NjhbFG7XYVcD9ZWXFelMixPDLhuixH6PbfBIPc9Q+TKR1IDF2RQWYpCxacA300IUgRGdiBFTnNntCEU4n565MKB0rrR33oMlumn5qj3ryLxktz3RfI+2FRFADL3y1t1xhkIHPOcoGhKtE1IBy+O+uA9svRCMHuiNikWGDpVkwrdlXqXYBHGT88UzM4vuCAebEZJ9jqexqm6RXUCFd3gbYL5Tp7bFG9am/5bzIvSLhTEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tv4yxyK6SQKr2abyvaTcmwMzM0aIeC5WZXXKomSKmqo=;
 b=pA8dm+99OgqZtqEAuEPcTjcLEs9vKakFR643SIkTQeJGpJuwbC1Bis5Jq+jigEfzlbRKGNVfhhOX0BjPr466jlb8lQXEj2/tYlPG5bLL0pPGbLo5KH0NbnhPyCKP8wsJmAQGcBfLSF4rzjYSB6BrODcpEAOgTRoeJAwCaPGAc4kYY9dVDU41aDEmZwfJwtKmBHlLHuWOM0S/XwXV9dJk1b1HWrLsTKYdL38Fu+6IHcFYtNhZPo6CTSn9HX1T9dHue2Bu46xqxVTrjDeJlC1CkzuBeYIkOpJ47b5Z2pqWqCitDHpwC3Vz3zgYOTMoBoNOm1KFDqphY8GppqcFJVxvKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv4yxyK6SQKr2abyvaTcmwMzM0aIeC5WZXXKomSKmqo=;
 b=0T893CDXqL3bA0i058Ysks1AKYqEx9msu8zJ5punQSmFtSl9o/+HvsnGHLl4rLo5LS44EtnqOiFZUKrzVoXbkATMtQB/dyla/VRxm8khyFMUXbG71f9xV1+Gd3LPNN7//t5OjWyI9bFRduOrfTQUwB4YHdfMXsGyZUu/VNHrx0s=
Received: from DM6PR06CA0094.namprd06.prod.outlook.com (2603:10b6:5:336::27)
 by PH7PR19MB6954.namprd19.prod.outlook.com (2603:10b6:510:1ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.18; Tue, 22 Jul
 2025 21:58:02 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::6f) by DM6PR06CA0094.outlook.office365.com
 (2603:10b6:5:336::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 21:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 21:58:02 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id E0B77B2;
	Tue, 22 Jul 2025 21:58:01 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Tue, 22 Jul 2025 23:58:00 +0200
Subject: [PATCH 3/5] fuse: {io-uring} Use bitmaps to track queue
 availability
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-reduced-nr-ring-queues_3-v1-3-aa8e37ae97e6@ddn.com>
References: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com>
In-Reply-To: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753221478; l=9094;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=vSTQceXnZp/h+R7iq1i/jvM2d4NK/TLTUvap8pvT0Sg=;
 b=J3e7FIYYu7yoPvFBJeSrKVgHbbJwX09I3DOGLU43mB0pbX9lPm0+9fI96hJaFtPGwDgtp01gr
 /TypCuo1MIuD4QUj2AYYcJrduzRW/DuMgOzGIFcgswOLndCrRRPv9JC
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH7PR19MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 208d41f7-c6ec-48fd-f9ff-08ddc96ad488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|19092799006|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVR6N0VSMVV4VVZPdmkxbTcyVzJxVlcybFU1Y3QzUzFndnQ4bFB0a0U2Ymlj?=
 =?utf-8?B?WEphNmpydGxHYUFTeXdDYmNtSm1YREJYNEZiK2hna1FVR29xdXI2WFBLb2Vo?=
 =?utf-8?B?eFFPTTRzdkhzSTd3RDJGY204Vm5LTWdBR3greE55M2NGQnhJeGZJQWZpV1Rz?=
 =?utf-8?B?YUR6b0hnM096MndWbytNVityY2lYQmJ3R2tYT25zbW9DRExHVUVVbkJ5TUZU?=
 =?utf-8?B?bVFQTTYyNnpTNzI1SVdDengzemxwZEU3M2F2cFF0a0EyOVdKT1U1ejl1dVBX?=
 =?utf-8?B?b0tsNk1KLzMyVEJBK3NkUFlKaFhYR2pjenpTdUV1ZWhDalhncUNmQlptNTQ1?=
 =?utf-8?B?aHR1VmJiaE5YdC8rREtKdHZQRStRQUxLcWhDaUZSckRoSkp1WTRpZVhqUldr?=
 =?utf-8?B?bDdkcFRSdi9iYkRMR0h1SWxxRWJ0K2NhSG9vdHc0OUN6bDFENTB2WVhIaXJC?=
 =?utf-8?B?QXBMczZkZWxjbjlQeHk5RlZyc0RYb2RUY0U4N0ltTHAzWWIvaU8rdzRuUmd2?=
 =?utf-8?B?dUx6M1NBOExvaTFRWEpHQ1ZDWldXZGxTMGE3K21nME8rM2dURVNZYUpPSW01?=
 =?utf-8?B?dlRBSDBKU1c5dGZvaUxCVTBKSDhrcCsvemNGVjFYTU9sblVqTyszZ2N4eERQ?=
 =?utf-8?B?Y0lFbUl6d25GYVZMMFZ4alluVXAyWnNOdSsyU2hlUC9CRkNhckpZdFJidFl6?=
 =?utf-8?B?elp5RGFaMzdXeThlU21CM2tmRnlNeHhYYmErazYyT3BBR1ZFQTFLTkRiVWVr?=
 =?utf-8?B?dk5tNlo4eThkV2RCZExEQ3RJckkzcE5jZkc4NGVudFphUkF3NHYyNm1MZ0ZV?=
 =?utf-8?B?Ukd6aHkraXg3MTJYbTBvQ2RNOTJiZWd2MWtGajdvOVpqZ3BONzVLQUhQakl6?=
 =?utf-8?B?Y1JwUWIyaHo2VmhNMUltek5jV2JsdHFHWVRoZjdUUGdmeXdTQ3NTRW5wWmtD?=
 =?utf-8?B?NHRyN2NFajVpclBmV1AwZHNFdmlTNEppYy9tUkh5d01ZNWNzY1NXakc2eFMv?=
 =?utf-8?B?eDcyMFZpODZxTFdIZ2FINFJkL1RvVzJ2aGMyKzhKRmpSU0FkeEVYWnM5RVFu?=
 =?utf-8?B?d1hLdnA4SmZYVTBHbTBaSFcrVXIzVUN1L2gwejNjdWNDTGkzbDJBVjdHZnoy?=
 =?utf-8?B?alNVTW52ckV6VEFiT0JhUTJySVBoSTlLWDQ1ZGNkY3JZS241RXlnMjFBbFJ2?=
 =?utf-8?B?YTVzd3MxbVZnY00xbnZybW9jeFovNVJJZ1BPVE9BV1JUSXVacFRjK0c1NTNN?=
 =?utf-8?B?RFlnRDdoWDhvWFc3YysySXJhK0JkalhPZlJSNnlFUUtMMHRFTlgyY0t0SEZn?=
 =?utf-8?B?SU9NKytBRGQ2cEdQS01WQUlnR3ZOL1M4cUpuRkhnYjc2em9rajVER2I2THAv?=
 =?utf-8?B?SkNNUjhiemkxbFRaaFY4ckxoQTJhMFhtc25USUQrR1NkdHRyQi9sOS9tb2JE?=
 =?utf-8?B?OXpTRzR1Ui84TVptVGJTMXNVMkRtNVI2Ump1UytwUXBrcWNkSlk0MlY0TWs2?=
 =?utf-8?B?YUdsVjFrSC9rMVE1cFJtNk1iTlBTNlA1UG9vVUgveGtsZWJ4Y1VCSFBhYTJy?=
 =?utf-8?B?WlFjMUdTempqOTkzL0Q5aFVSaVZ1QmlIRzA2ZlBrVEN3d1ZBVVhSam16dzJM?=
 =?utf-8?B?cjd1WWNVOGZCYkIyWm5LVlVrZVVsMkJ1OU9xRWp1MXRXUzBXc0JvdGp1Zjdx?=
 =?utf-8?B?Mmp5N1FSMndERERoOTIxVXRxbHd2SThPenN5QmtFVGo1VXp1RHVrUXB6amV3?=
 =?utf-8?B?TFU1TXRzWk9BMUpjTlduakJSeEZ3WlNEZVR2dkJSNDVXNUpMcHRnMzVDRHc2?=
 =?utf-8?B?VnBkL2ZVdVBLUjBXdzdMR2o3eVp6QllBMnYrU2hkQVo3c2JhY3dWaHFGNTRn?=
 =?utf-8?B?QXZZSXA0eXVaUUdwK0NPeGdQQ0tjRnJweStHMDF1aXJObWdDWlNRc25NUy92?=
 =?utf-8?B?dmU1TEVLZ3R6QURZSGlZdWxlYU91b0dyajFxcU9TUjhpYm1YbFE3SU5QNmdp?=
 =?utf-8?B?Y1FlcXZhRThuaUh2YkhSeXpqak56bStxQ1ZJVUd4eEIyWi9jUnRNdUdTNVMw?=
 =?utf-8?Q?Wj3nQx?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(19092799006)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z8nRczvrh1hN4ZvFiJje4ucmGKDOwiJt1lVSvIk4LbvRr5jBZ8RPvfPjMBbtBgNHhqzDhGHymt55qlTr4Kf6H52jKuzq3Q0ALsOtBRFloRjfklz/P1rFR/8+p5XAlVprOcYk9d3bqArgijhFK1skeOMj+K3v51NQHmRxjhBWqhaAQ7V2VlMlBCJglUi8U/kj+vO3Bo2ZDtgCfxpbBipbskbwk71qClPKwCk1oCqdHCcodsjHUA/kOOkfzYw9cW5dq5rPfjHUxyl58ZVh63mx4A6q+MP6kZ3jWF+YYHzZmVjZ+ix+moBHd1G32/FxVFwAZt33Oh4i1isFYrwjuzaoD9KvrlLVbXOyBrlxTeXvoDF+Of9c5y/cULZDVNiqPd8KkyMohA3SaMpDtyJZO0U2Muba66Vg9/g0OvYdYGpmTbYhkmFhR6vcfriXFvujDxDwaUWkMa6G704Z3dtsqkO7OeT5hWddwQ2emKY6spizdHuWrlGPdF7qWBojxfE7xmR7MbH43ptiYhreGNMekVYEiJgiIsBQOnuKieSgu0tW8ow4qVyY7M+TVFT0c3jwA0tpB+Bt7xK3JRQfqaSqn1zHlDJoZxauOvIAEa3fSMKrPpckOLqd6Lq9VhV9KDrCaoLu82g090GdiGmTde0Slx9v0Q==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 21:58:02.5154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 208d41f7-c6ec-48fd-f9ff-08ddc96ad488
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6954
X-BESS-ID: 1753221488-105109-8495-14544-1
X-BESS-VER: 2019.1_20250709.1638
X-BESS-Apparent-Source-IP: 40.107.94.123
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhYWhoZAVgZQ0DLZyDw1JdU41d
	DSxNLcItEg1dLA3NLAMikx2TI5KSlNqTYWADAWXydBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.266236 [from 
	cloudscan16-135.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Add per-CPU and per-NUMA node bitmasks to track which
io-uring queues are available for new requests.

- Global queue availability (avail_q_mask)
- Per-NUMA node queue availability (per_numa_avail_q_mask)
- Global queue registration (registered_q_mask)
- Per-NUMA node queue registration (numa_registered_q_mask)

Note that these bitmasks are not lock protected, accessing them
will not be absolutely accurate. Goal is to determine which
queues are aproximately idle and might be better suited for
a request.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c   | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev_uring_i.h | 18 ++++++++++
 2 files changed, 117 insertions(+)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 0f5ab27dacb66c9f5f10eac2713d9bd3eb4c26da..c2bc20848bc54541ede9286562177994e7ca5879 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -18,6 +18,8 @@ MODULE_PARM_DESC(enable_uring,
 
 #define FUSE_URING_IOV_SEGS 2 /* header and payload */
 
+/* Number of queued fuse requests until a queue is considered full */
+#define FUSE_URING_QUEUE_THRESHOLD 5
 
 bool fuse_uring_enabled(void)
 {
@@ -184,6 +186,25 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
 	return false;
 }
 
+static void fuse_ring_destruct_q_masks(struct fuse_ring *ring)
+{
+	int node;
+
+	free_cpumask_var(ring->avail_q_mask);
+	if (ring->per_numa_avail_q_mask) {
+		for (node = 0; node < ring->nr_numa_nodes; node++)
+			free_cpumask_var(ring->per_numa_avail_q_mask[node]);
+		kfree(ring->per_numa_avail_q_mask);
+	}
+
+	free_cpumask_var(ring->registered_q_mask);
+	if (ring->numa_registered_q_mask) {
+		for (node = 0; node < ring->nr_numa_nodes; node++)
+			free_cpumask_var(ring->numa_registered_q_mask[node]);
+		kfree(ring->numa_registered_q_mask);
+	}
+}
+
 void fuse_uring_destruct(struct fuse_conn *fc)
 {
 	struct fuse_ring *ring = fc->ring;
@@ -215,11 +236,44 @@ void fuse_uring_destruct(struct fuse_conn *fc)
 		ring->queues[qid] = NULL;
 	}
 
+	fuse_ring_destruct_q_masks(ring);
 	kfree(ring->queues);
 	kfree(ring);
 	fc->ring = NULL;
 }
 
+static int fuse_ring_create_q_masks(struct fuse_ring *ring)
+{
+	if (!zalloc_cpumask_var(&ring->avail_q_mask, GFP_KERNEL_ACCOUNT))
+		return -ENOMEM;
+
+	if (!zalloc_cpumask_var(&ring->registered_q_mask, GFP_KERNEL_ACCOUNT))
+		return -ENOMEM;
+
+	ring->per_numa_avail_q_mask = kcalloc(ring->nr_numa_nodes,
+					      sizeof(struct cpumask *),
+					      GFP_KERNEL_ACCOUNT);
+	if (!ring->per_numa_avail_q_mask)
+		return -ENOMEM;
+	for (int node = 0; node < ring->nr_numa_nodes; node++)
+		if (!zalloc_cpumask_var(&ring->per_numa_avail_q_mask[node],
+					GFP_KERNEL_ACCOUNT))
+			return -ENOMEM;
+
+	ring->numa_registered_q_mask = kcalloc(ring->nr_numa_nodes,
+					       sizeof(struct cpumask *),
+					       GFP_KERNEL_ACCOUNT);
+	if (!ring->numa_registered_q_mask)
+		return -ENOMEM;
+	for (int node = 0; node < ring->nr_numa_nodes; node++) {
+		if (!zalloc_cpumask_var(&ring->numa_registered_q_mask[node],
+					GFP_KERNEL_ACCOUNT))
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
 /*
  * Basic ring setup for this connection based on the provided configuration
  */
@@ -229,11 +283,14 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	size_t nr_queues = num_possible_cpus();
 	struct fuse_ring *res = NULL;
 	size_t max_payload_size;
+	int err;
 
 	ring = kzalloc(sizeof(*fc->ring), GFP_KERNEL_ACCOUNT);
 	if (!ring)
 		return NULL;
 
+	ring->nr_numa_nodes = num_online_nodes();
+
 	ring->queues = kcalloc(nr_queues, sizeof(struct fuse_ring_queue *),
 			       GFP_KERNEL_ACCOUNT);
 	if (!ring->queues)
@@ -242,6 +299,10 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	max_payload_size = max(FUSE_MIN_READ_BUFFER, fc->max_write);
 	max_payload_size = max(max_payload_size, fc->max_pages * PAGE_SIZE);
 
+	err = fuse_ring_create_q_masks(ring);
+	if (err)
+		goto out_err;
+
 	spin_lock(&fc->lock);
 	if (fc->ring) {
 		/* race, another thread created the ring in the meantime */
@@ -261,6 +322,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	return ring;
 
 out_err:
+	fuse_ring_destruct_q_masks(ring);
 	kfree(ring->queues);
 	kfree(ring);
 	return res;
@@ -284,6 +346,10 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 
 	queue->qid = qid;
 	queue->ring = ring;
+	queue->numa_node = cpu_to_node(qid);
+	if (unlikely(queue->numa_node < 0 ||
+		     queue->numa_node >= ring->nr_numa_nodes))
+		queue->numa_node = 0;
 	spin_lock_init(&queue->lock);
 
 	INIT_LIST_HEAD(&queue->ent_avail_queue);
@@ -423,6 +489,7 @@ static void fuse_uring_log_ent_state(struct fuse_ring *ring)
 			pr_info(" ent-commit-queue ring=%p qid=%d ent=%p state=%d\n",
 				ring, qid, ent, ent->state);
 		}
+
 		spin_unlock(&queue->lock);
 	}
 	ring->stop_debug_log = 1;
@@ -472,11 +539,18 @@ void fuse_uring_stop_queues(struct fuse_ring *ring)
 
 	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
+		int node;
 
 		if (!queue)
 			continue;
 
 		fuse_uring_teardown_entries(queue);
+
+		node = queue->numa_node;
+		cpumask_clear_cpu(qid, ring->registered_q_mask);
+		cpumask_clear_cpu(qid, ring->avail_q_mask);
+		cpumask_clear_cpu(qid, ring->numa_registered_q_mask[node]);
+		cpumask_clear_cpu(qid, ring->per_numa_avail_q_mask[node]);
 	}
 
 	if (atomic_read(&ring->queue_refs) > 0) {
@@ -744,9 +818,18 @@ static int fuse_uring_send_next_to_ring(struct fuse_ring_ent *ent,
 static void fuse_uring_ent_avail(struct fuse_ring_ent *ent,
 				 struct fuse_ring_queue *queue)
 {
+	struct fuse_ring *ring = queue->ring;
+	int node = queue->numa_node;
+
 	WARN_ON_ONCE(!ent->cmd);
 	list_move(&ent->list, &queue->ent_avail_queue);
 	ent->state = FRRS_AVAILABLE;
+
+	if (list_is_singular(&queue->ent_avail_queue) &&
+	    queue->nr_reqs <= FUSE_URING_QUEUE_THRESHOLD) {
+		cpumask_set_cpu(queue->qid, ring->avail_q_mask);
+		cpumask_set_cpu(queue->qid, ring->per_numa_avail_q_mask[node]);
+	}
 }
 
 /* Used to find the request on SQE commit */
@@ -769,6 +852,8 @@ static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ent,
 					   struct fuse_req *req)
 {
 	struct fuse_ring_queue *queue = ent->queue;
+	struct fuse_ring *ring = queue->ring;
+	int node = queue->numa_node;
 
 	lockdep_assert_held(&queue->lock);
 
@@ -783,6 +868,16 @@ static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ent,
 	ent->state = FRRS_FUSE_REQ;
 	list_move_tail(&ent->list, &queue->ent_w_req_queue);
 	fuse_uring_add_to_pq(ent, req);
+
+	/*
+	 * If there are no more available entries, mark the queue as unavailable
+	 * in both global and per-NUMA node masks
+	 */
+	if (list_empty(&queue->ent_avail_queue)) {
+		cpumask_clear_cpu(queue->qid, ring->avail_q_mask);
+		cpumask_clear_cpu(queue->qid,
+				  ring->per_numa_avail_q_mask[node]);
+	}
 }
 
 /* Fetch the next fuse request if available */
@@ -982,6 +1077,7 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 	struct fuse_ring *ring = queue->ring;
 	struct fuse_conn *fc = ring->fc;
 	struct fuse_iqueue *fiq = &fc->iq;
+	int node = queue->numa_node;
 
 	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
 
@@ -990,6 +1086,9 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 	fuse_uring_ent_avail(ent, queue);
 	spin_unlock(&queue->lock);
 
+	cpumask_set_cpu(queue->qid, ring->registered_q_mask);
+	cpumask_set_cpu(queue->qid, ring->numa_registered_q_mask[node]);
+
 	if (!ring->ready) {
 		bool ready = is_ring_ready(ring, queue->qid);
 
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 708412294982566919122a1a0d7f741217c763ce..0457dbc6737c8876dd7a7d4c9c724da05e553e6a 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -66,6 +66,9 @@ struct fuse_ring_queue {
 	/* queue id, corresponds to the cpu core */
 	unsigned int qid;
 
+	/* NUMA node this queue belongs to */
+	int numa_node;
+
 	/*
 	 * queue lock, taken when any value in the queue changes _and_ also
 	 * a ring entry state changes.
@@ -115,6 +118,9 @@ struct fuse_ring {
 	/* number of ring queues */
 	size_t max_nr_queues;
 
+	/* number of numa nodes */
+	int nr_numa_nodes;
+
 	/* maximum payload/arg size */
 	size_t max_payload_sz;
 
@@ -125,6 +131,18 @@ struct fuse_ring {
 	 */
 	unsigned int stop_debug_log : 1;
 
+	/* Tracks which queues are available (empty) globally */
+	cpumask_var_t avail_q_mask;
+
+	/* Tracks which queues are available per NUMA node */
+	cpumask_var_t *per_numa_avail_q_mask;
+
+	/* Tracks which queues are registered */
+	cpumask_var_t registered_q_mask;
+
+	/* Tracks which queues are registered per NUMA node */
+	cpumask_var_t *numa_registered_q_mask;
+
 	wait_queue_head_t stop_waitq;
 
 	/* async tear down */

-- 
2.43.0


