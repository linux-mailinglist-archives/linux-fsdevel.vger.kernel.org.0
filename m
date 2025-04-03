Return-Path: <linux-fsdevel+bounces-45640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 196BAA7A350
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 15:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DF23AB978
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 13:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D981A24C068;
	Thu,  3 Apr 2025 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="sAJiiHJF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDEE24E001
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743685528; cv=fail; b=pZQ8mbJVipClChfNjcwqOrOP7ms3vR5rQBtsU2kz9tdWU0hvM2JJJvUVzgKwS9F9WXwCC4Ukz5Mwz2v4/mKmHaCy1gEZrKBAZMF6Keon9T8uyaYRKTJVWLesN4j6146B6svKJZZLqLLp/wNiv9iUu+ivtnnxF+k5NcB4Z2kY0NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743685528; c=relaxed/simple;
	bh=Dua8+hES0iXumoTTq1YQ89zt7sXm6RE3yEjmy3Dxfg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cphPSDMbFrQNBV633yLdrWSLdJwTzr7SMAbzM/yb0jlzZQwR8L4Fo7s4OjNB+RvrutapAo+u9eLDGDxRL0nOjRnh31CDPeATR4kSLG23m272cUwedbI94pnbQBGGkxd+VZ0iNpgviiGSIfViuWQtOJX8AnCF4Na6Hhi384p23kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=sAJiiHJF; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169]) by mx-outbound42-120.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 03 Apr 2025 13:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ic3udTghpdm2ztZaWgVCRjezXyVHlFSB8gxChw8VJo+It3WW08pZ1DWamDSV/1+xoPukv3IDBKGma96PDd4grfVYfInpC6MckDGY0NNecLMibMeIG4RhI7d4hgVIXmeq+ExjwdhsXn0dnIzwWNY93z2zSf/D9mn+Png+/2w9a2GhbHQtAICbBA6gEJgD8lrF3uHC1sbjCfF8lFNGtaONQA0QZmoLBv/tGyg3SPKHAyO1zdALRVtefL99dCTP75J5gRpfZmvAXZtNquRKOJu9GFD5+cv/TRvKkHKhWudCzigC8Vx3gx0oe9aggEwAcwjCFtXUwbVWX84EwoWbnvHBcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=906l0uz2nUjyJTIeUeXoSrOz5nvaEGy28z0fUxDyJ0M=;
 b=ZwwnQRaIVpdewaS59xzRi2Pmhhm1gedCD4LcdpZwadIDKnHgIvHZCx7Ezkoc3vjIq/EWar2rQ0YvMyeWp5Cd2q3G/ORaDcRFLRe1zmrRSBKu+X7soBL+C8IDOxEXZdDMmj6TCH8koiUZDI9hrqfOpEmLILmwCHBlZEh9x7GSrhUTK97Hamwwiww0becSrCwJ4FpH7DLZJGR/Z9JA1qjRwU0S9OEogsUMp1NzoK5mgW6Tm3N+KEIou1oDIvDckSW0nF0Y+MX6PDlIc4FOsaTbe3byrRh3rWcSnnhpKchW5yAIluB8DYIapIw0BzTvDIp8ubadbBvhwyjek6/tyWj6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=906l0uz2nUjyJTIeUeXoSrOz5nvaEGy28z0fUxDyJ0M=;
 b=sAJiiHJFj0VIIy/OpgQEaSgFunKdsOpTQWFzqr3HXUN3Sc9dH2mzLoPir+N/qAd0bxm11gQ/yIVAcTHOJjQGaJYAqpmhoy9mlvBzbUlvMNeCyiIJ1gI8FZABhhB+eR0/pwAmuUDRtxv0chRwZwJy96r9cpqo744OcAydYfYV11E=
Received: from BL0PR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:91::31)
 by MW6PR19MB8084.namprd19.prod.outlook.com (2603:10b6:303:246::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 13:05:17 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::12) by BL0PR05CA0021.outlook.office365.com
 (2603:10b6:208:91::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.25 via Frontend Transport; Thu,
 3 Apr 2025 13:05:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Thu, 3 Apr 2025 13:05:15 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 3A2954A;
	Thu,  3 Apr 2025 13:05:14 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Thu, 03 Apr 2025 15:05:09 +0200
Subject: [PATCH v2 4/4] fuse: fine-grained request ftraces
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-fuse-io-uring-trace-points-v2-4-bd04f2b22f91@ddn.com>
References: <20250403-fuse-io-uring-trace-points-v2-0-bd04f2b22f91@ddn.com>
In-Reply-To: <20250403-fuse-io-uring-trace-points-v2-0-bd04f2b22f91@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743685510; l=4634;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=Dua8+hES0iXumoTTq1YQ89zt7sXm6RE3yEjmy3Dxfg8=;
 b=JriWI+fPEFMOuKu0fjXj1yX+DRxu82y+JMciMRHOFaqseb/LKM9pEyohYvOdTa9HOMtBOgx4S
 gakp7VWxlzBBdWJXwcqqMFKBCp+sjC6K4HMCIq2jfopOmy3lNYtFn3M
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|MW6PR19MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 506bbbe5-ac63-4036-621a-08dd72b02d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkhKbGxxTWluMjI2MzlPQkx0L2pLVktIV1AyckdKblMwSHhlZk9KMzMrUENL?=
 =?utf-8?B?TlJjMWVlVkVjOUkzWTZ2LzkyV2VYdlBUb3c3bHlha3JKM3d5UjlESk1uRHhH?=
 =?utf-8?B?dW9qSSs5eE9TYVFLVU9XUWluSzN4KzVNQlNwQ2RFY05JUmV3bTViaG1iTWdn?=
 =?utf-8?B?WXh2L0ExWjcvV3VFaDJCZU5IK3c2a0oyMS9EU21mWTVLRHFIRWtXYmdwVTNh?=
 =?utf-8?B?eFFFbUFFQTE4TGkyY003VXU0RldQVmx2aytQTkpKdHp2Wkd5a21Ud1lJQkF4?=
 =?utf-8?B?T0xobi9uZEZYdXJERXhhTWNDRWR1V2xmeTdMd2VUSHRkaUsyUi9zQkxaTXd5?=
 =?utf-8?B?SUViOVQrN2gzekpySnMwODFRZC9WMGxMbHFCcXlubjc3L25pM3o0Vm9sWHda?=
 =?utf-8?B?YStkNzBGbHZQWSt3ZG9hNWRqc25oaGc4Mno5Ti9sdlY5RWJlMExMRjBrV3Rt?=
 =?utf-8?B?VVpJU1RMMWtEaFhQRExpeUxDQ0VpZUVNREY0aC81dnlzQlZ2UFRFdTVkbTZ6?=
 =?utf-8?B?RTVrQi96dFkzVGM4T3NZS2xzd3kzb0tXd1NrNHRCUWxtd0NIQk1mdHJGbE9B?=
 =?utf-8?B?VWxpUDhQN29ZQVVSdVVaS0Z5bzBwNzRacHJzclNHdEx6ODBLVC93TGZMYjNa?=
 =?utf-8?B?WkhMWW8rNU1TdUdhWFUxL0xmMzBGeDV5RWdNSGswUm83Tk5DOHFGU1BkUVNh?=
 =?utf-8?B?TStqU2U5UGRIQjhEZ2xvNkZOV2JQK25nNEtuS1YwVTBSLzZrd3pHdTUzN0h2?=
 =?utf-8?B?dkY3UnlSQzBCYURxWVVoN3l4d3NZMkFPVXl5bnp0TFJHejltSDlyN0wrUVlW?=
 =?utf-8?B?QytpOC9PNFBpYWhiY0p1dHJmdFRONjFrSW1mVkhxbkh4MHpPNklKM29ENWpr?=
 =?utf-8?B?c3V0aFE1dGZNOUpaY09Xbi9yanUzcHZYWWYvc2t1bzVSY2RjQXZqUTUzOGRF?=
 =?utf-8?B?VXRPUXNBa3F6MDdmU3pUUVRzV1VLT1lEM0NGSmk0Z0E2a2JYNDNUcnk0N25z?=
 =?utf-8?B?M2NCaW1xVTFITzNEWVBRM0hDdk53b2RMdkJReWlxQjVhakVPQXkvbHBYckxC?=
 =?utf-8?B?NFJCTG5jSmRQeFpMcXFqUmU0K2owYVNWdVpZd2hqLzNvVE5Caml6NVhmcGxt?=
 =?utf-8?B?dFJ6U1VYb1JMUFl5VmxLaUdHWUU2V0pyckpJTFgrZnArbUZCb3Y2eGlUb1VY?=
 =?utf-8?B?Yk9mbVpQc2UzUWVxdCt5VnlFMWdWR0U4RkhhWG5kZ1VSdlpiMUk4SWRkNDF3?=
 =?utf-8?B?UDNrWW5lZDl6OEt4NUVrbzlrOVNFVS84THMxaURwM0VMRWZtMkFhcng0WWFh?=
 =?utf-8?B?NlN4bzNNM21KR1p1Sk9wU0Y1MGZWV2JzdGZoNHZlM0VUN1E0YTFoTlhudVFY?=
 =?utf-8?B?MlVtaFk5SXgvM3RTcytMR2dMYWpMeU9MV3RmSEFYeElQUlN6K0UrcERsQlBG?=
 =?utf-8?B?OWF3S1VZdzFFcFRLQnFSaitrVldKMjMxNy9FblBUWDdtMitwaFBESlJ6VE1k?=
 =?utf-8?B?MUtwWHE0NXgrNFNNaHJUeUdndU0zZ2MwNExqV2N3Y3AvR2NwT1A0UFlwY1FN?=
 =?utf-8?B?MmYzRDllWEhkVlVxZnRoaUlaRlhmN08yV24xL2trNWdzMm9yK1UzNDdqQWtz?=
 =?utf-8?B?aUgwNG9CMnAwNU44MC92MVBGUE9tK0R2OEZEaE5veVF5Q2NFY0pGM3hTTHov?=
 =?utf-8?B?TVc0OTNSOWEvUTFEbi90eGpLejUrbnFydG9Ic3VMZEZ0RnNZbTdUbW92N0cv?=
 =?utf-8?B?bWhQMkIzSHlYSFVYT05URmhjc3JnbVhuRGt1aGlIekZaUG9UZFkzOGpLUWZX?=
 =?utf-8?B?bjV6Ymc0QTdOcG5odGxZSFpya0RBZkVoNGxpRTIvWkRvR0JhRVZwWjZvNS8r?=
 =?utf-8?B?OGFkOWVqTWdCVDFjYjl3QmRJWVlUeXFyamNNYkhaLy9FYmdGNys1T2FIVlpx?=
 =?utf-8?B?cXdDeHh2cHZ6MkZtdHowUDRoSTIrTGg4YTNFSFBLZlhpd2N0K1IzMG01Rjdi?=
 =?utf-8?Q?qoCMv/bhnDZbXXvdzK+Zpww9Ck4EC4=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LemZRmT5IUGQWfpAsxYKVW6LAzRMaCTjSRXd7h/wyQnd7sbwL2ROHcTJNLC4REpu94C4VF740NYlA6iCq/htanl+rmfOFK8UjPgLRt1kpSgbS5Sb3u32ND2I7UkoxSfXLXNtXzDX9jIlL5lbc2P26/0nJJs9O9UMBR5RLEtW6WA2WHauiVpErqkLqhKXKIACnWY7uM7h24WGpmc1xlaVkrUVSiPk/0picgWfaSXs8GPd/ik3D+bmjU+LO6MzQMxjApzKgJ7+qSpA+u1NpLEssSjqC5e234MLt7f86H3euwOwEIeo7ml3FYnNHEe+zX6s7q6U02dDTHca/Lqvdzz2bRso2sBZI2sUjeZqPeBSClTfyXEzFfwCZ7p6KO6tD+xF1J9DORsxpuh4vrEcbMFS3C/3uiUo+mAaNGUrL+Ohta32X3wYXhzpUkWvGeAOoCBaEBi/RbBkdQExRXzzkUyAvjVGOqctFhNlw5xwneJtKJX1gUJekDV9GvWJU3zq7kZ/3aKNB0u7K5iQB73cffAo90YZklms0dvmPqtqb1c5AJgxbl8b1EIzMBbvHE4CeIhSXdr2LOHFlhw6pTE88cfMr9ZB9YhvgZmsG1meLMQijWFsQrwLcCmS0XPlKs/Rh7y+zoscxqbtxnFhfzV5FyVmyQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 13:05:15.4621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 506bbbe5-ac63-4036-621a-08dd72b02d59
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR19MB8084
X-BESS-ID: 1743685518-110872-10170-13523-1
X-BESS-VER: 2019.1_20250402.1544
X-BESS-Apparent-Source-IP: 104.47.59.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYmFpZAVgZQMMUoLdnczDAxJd
	EiydDA0MjcNMUo0Tw52cDYOMnAOClZqTYWAAQQG+xBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263622 [from 
	cloudscan19-234.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Rename trace_fuse_request_send to trace_fuse_request_enqueue
Add trace_fuse_request_send
Add trace_fuse_request_bg_enqueue
Add trace_fuse_request_enqueue

This helps to track entire request time and time in different
queues.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c        |  7 ++++++-
 fs/fuse/dev_uring.c  |  2 ++
 fs/fuse/fuse_trace.h | 57 +++++++++++++++++++++++++++++++++++++---------------
 3 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1ccf5a9c61ae2b11bc1d0b799c08e6da908a9782..8e1a95f80e5454d1351ecb90beacbb35779731bb 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -281,7 +281,9 @@ static void fuse_send_one(struct fuse_iqueue *fiq, struct fuse_req *req)
 	req->in.h.len = sizeof(struct fuse_in_header) +
 		fuse_len_args(req->args->in_numargs,
 			      (struct fuse_arg *) req->args->in_args);
-	trace_fuse_request_send(req);
+
+	/* enqueue, as it is send to "fiq->ops queue" */
+	trace_fuse_request_enqueue(req);
 	fiq->ops->send_req(fiq, req);
 }
 
@@ -580,6 +582,8 @@ static int fuse_request_queue_background(struct fuse_req *req)
 	}
 	__set_bit(FR_ISREPLY, &req->flags);
 
+	trace_fuse_request_bg_enqueue(req);
+
 #ifdef CONFIG_FUSE_IO_URING
 	if (fuse_uring_ready(fc))
 		return fuse_request_queue_background_uring(fc, req);
@@ -1314,6 +1318,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	clear_bit(FR_PENDING, &req->flags);
 	list_del_init(&req->list);
 	spin_unlock(&fiq->lock);
+	trace_fuse_request_send(req);
 
 	args = req->args;
 	reqsize = req->in.h.len;
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index c5cb2aea75af523e22f539c8e18cfd0d6e771ffc..e5ed146b990e12c6cc2a18aaa9b527c276870aba 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -7,6 +7,7 @@
 #include "fuse_i.h"
 #include "dev_uring_i.h"
 #include "fuse_dev_i.h"
+#include "fuse_trace.h"
 
 #include <linux/fs.h>
 #include <linux/io_uring/cmd.h>
@@ -678,6 +679,7 @@ static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
 	ent->cmd = NULL;
 	spin_unlock(&queue->lock);
 
+	trace_fuse_request_send(ent->fuse_req);
 	io_uring_cmd_done(cmd, ret, 0, issue_flags);
 }
 
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index bbe9ddd8c71696ddcbca055f6c4c451661bb4444..393c630e7726356da16add7da4b5913b9f725b25 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -77,30 +77,55 @@ OPCODES
 #define EM(a, b)	{a, b},
 #define EMe(a, b)	{a, b}
 
-TRACE_EVENT(fuse_request_send,
+#define FUSE_REQ_TRACE_FIELDS				\
+	__field(dev_t,			connection)	\
+	__field(uint64_t,		unique)		\
+	__field(enum fuse_opcode,	opcode)		\
+	__field(uint32_t,		len)		\
+
+#define FUSE_REQ_TRACE_ASSIGN(req)				\
+	do {							\
+		__entry->connection	= req->fm->fc->dev;	\
+		__entry->unique		= req->in.h.unique;	\
+		__entry->opcode		= req->in.h.opcode;	\
+		__entry->len		= req->in.h.len;	\
+	} while (0)
+
+
+TRACE_EVENT(fuse_request_enqueue,
 	TP_PROTO(const struct fuse_req *req),
-
 	TP_ARGS(req),
-
-	TP_STRUCT__entry(
-		__field(dev_t,			connection)
-		__field(uint64_t,		unique)
-		__field(enum fuse_opcode,	opcode)
-		__field(uint32_t,		len)
-	),
-
-	TP_fast_assign(
-		__entry->connection	=	req->fm->fc->dev;
-		__entry->unique		=	req->in.h.unique;
-		__entry->opcode		=	req->in.h.opcode;
-		__entry->len		=	req->in.h.len;
-	),
+	TP_STRUCT__entry(FUSE_REQ_TRACE_FIELDS),
+	TP_fast_assign(FUSE_REQ_TRACE_ASSIGN(req)),
 
 	TP_printk("connection %u req %llu opcode %u (%s) len %u ",
 		  __entry->connection, __entry->unique, __entry->opcode,
 		  __print_symbolic(__entry->opcode, OPCODES), __entry->len)
 );
 
+TRACE_EVENT(fuse_request_bg_enqueue,
+	TP_PROTO(const struct fuse_req *req),
+	TP_ARGS(req),
+	TP_STRUCT__entry(FUSE_REQ_TRACE_FIELDS),
+	TP_fast_assign(FUSE_REQ_TRACE_ASSIGN(req)),
+
+	TP_printk("connection %u req %llu opcode %u (%s) len %u ",
+		  __entry->connection, __entry->unique, __entry->opcode,
+		  __print_symbolic(__entry->opcode, OPCODES), __entry->len)
+);
+
+TRACE_EVENT(fuse_request_send,
+	TP_PROTO(const struct fuse_req *req),
+	TP_ARGS(req),
+	TP_STRUCT__entry(FUSE_REQ_TRACE_FIELDS),
+	TP_fast_assign(FUSE_REQ_TRACE_ASSIGN(req)),
+
+	TP_printk("connection %u req %llu opcode %u (%s) len %u ",
+		  __entry->connection, __entry->unique, __entry->opcode,
+		  __print_symbolic(__entry->opcode, OPCODES), __entry->len)
+);
+
+
 TRACE_EVENT(fuse_request_end,
 	TP_PROTO(const struct fuse_req *req),
 

-- 
2.43.0


