Return-Path: <linux-fsdevel+bounces-45702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA084A7B042
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 23:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF20189C86E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 21:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1235B1EF0AB;
	Thu,  3 Apr 2025 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Lhvi5KEX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7001F0E22
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743711790; cv=fail; b=VfWZv1DZAYR49K/KFVn+EbsF7s2jjRLKpfmbYXihBEBm9dyfqkL1oMSjVxEQH7tzxDW6JfZoj2qQ9rQrsXF2OYilXEfd6edAxAu/9E6qs6Zy0GzIf/TSD+f1yxv7sKS1TRH3tRgcNLc5e0a9M+nC1lEhhUKkWeMAv08yYMRVDSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743711790; c=relaxed/simple;
	bh=Dua8+hES0iXumoTTq1YQ89zt7sXm6RE3yEjmy3Dxfg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o3ZabqqTqLlsbZXe/v/nAhVkQfQMlpLria3m0AwzHj1JPTKeIWfyjSLyEWs2bwjQKEqMEW1Pym4a3u2bE2Zx/UauaVoAHeihg/1LVtotaOrTYYj4t3UQcKpipHAwF3yb4CUJpnaMkjG5nP1R9F98NezorOQpEqe5IXW2uqCUxOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=Lhvi5KEX; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44]) by mx-outbound41-40.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 03 Apr 2025 20:22:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCKomlPea5Ou0ETA7TGq/2/ARYdckQ+34TQ4WyuGgNGP0Pvu8qUo9yN4jEcW0g9z7XLBigeADqjktyMqGOE0zEeqJ3UB4sN6FoaujbT7uL56cWVsZcjW453yOkXp9656TLYtHLgk3D2E9IWFdUESaSTiMeU68j2nah8jlWujDdXEYv8lPk9ZMY3j1w2Nio5AFtn9ZutBTxAp9Vba/7UFc1b8l/CNJw02PGKVmgdu2M5CPMWWdxgTE8G+bMKsW+UOGvACv+sC3jz0cO4HstEvAwqUJC65d3cAJDuWewE93yDa3hLFSY7npnPm5oGUZev/+0IINFbPirHXrgogFZkBfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=906l0uz2nUjyJTIeUeXoSrOz5nvaEGy28z0fUxDyJ0M=;
 b=eB1Qf3afdUac4QFn/azx9fz0KYgZpf43q5UWlpy1PcGQCj8EwutRArT1WT3ONcfwfjr8SRLr+zNuqcgtgDAZVu4k4ww1thrmh6n+il1BdVws4PtH9XIcotopYV+V/pArFOFxC29ZpAOF4aBqW/ZsP9Aarx87v2F/P460HYAErZyj9xB/3HV0JyozioXtkFsvT6vyDTj/LmA0VrFWyoMSyEv+PKwrVUKzZJ44it8xXEfVe0T1D3S5Jrn+Xn1pLUd7CtjuGmTZ8zxYI2le3FRYwkZTnPo6YZH5vURF7RcOUCAe6uMuKYgPjcUibST77FRGYhQ7mzOCJOsmxEqH+w3A0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=906l0uz2nUjyJTIeUeXoSrOz5nvaEGy28z0fUxDyJ0M=;
 b=Lhvi5KEXEbo1mfnJJmBSFKiCiGgdeeWKm4XzBdaYIS+JzUwgbLJR8Wg4J6pgfZtOYGVp5XBaqmOCcaaDHC6Mw3lDmD2egcbW5IxeYp/p5ZHlaD07jJC+4D4YYnU253+6Ppt16/5FYeTBxgifhV74OGe5EVmxcxg1whSVgvp0VXY=
Received: from BN9PR03CA0534.namprd03.prod.outlook.com (2603:10b6:408:131::29)
 by BL1PR19MB5819.namprd19.prod.outlook.com (2603:10b6:208:396::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Thu, 3 Apr
 2025 20:22:53 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::13) by BN9PR03CA0534.outlook.office365.com
 (2603:10b6:408:131::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Thu,
 3 Apr 2025 20:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Thu, 3 Apr 2025 20:22:53 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 64D1F4D;
	Thu,  3 Apr 2025 20:22:52 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Thu, 03 Apr 2025 22:22:48 +0200
Subject: [PATCH v3 4/4] fuse: fine-grained request ftraces
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-fuse-io-uring-trace-points-v3-4-35340aa31d9c@ddn.com>
References: <20250403-fuse-io-uring-trace-points-v3-0-35340aa31d9c@ddn.com>
In-Reply-To: <20250403-fuse-io-uring-trace-points-v3-0-35340aa31d9c@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743711768; l=4634;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=Dua8+hES0iXumoTTq1YQ89zt7sXm6RE3yEjmy3Dxfg8=;
 b=9yNXXM3ghd3WHXNVD0dF299AHOtmPGYKiPu6oL+5gJ+4+q+yVO2EnuIo8/5zP6n27q9R9MgLi
 wsb2/YiF41BBKV3R8BDQzJ5H7PDSsZwXFECUOXPZywig67CcNza+M8d
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|BL1PR19MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7d1f2e-94ba-42b8-2cc4-08dd72ed5024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0RLUkZ6emwwUUtuamYxVXNZbFpXU1ptVkZHMWhWODBORzkveW9Edko0a0hR?=
 =?utf-8?B?ZkdPTWNnSEZCKzhyQWY1Wm5wQUhucGM1TmFLOUtQY0hUQmk0bldScFd0dnFW?=
 =?utf-8?B?aEVrd3diRy9LK3BJT0JEdjJrdVBCMzVpNFlZZEFrWlpFWHhBUDBkZFl4MElP?=
 =?utf-8?B?Y0NuNmRIVUJra00wcGNOZzltOEQ1RW9KbDlzSjlvRFkxeFpDSGFXcEF3UjA5?=
 =?utf-8?B?WUp0NWx6VldVeVFvbWIvUXFZSkZ5bFZIQysrbDBVOCs1VkhJUXBjZGgrVmhl?=
 =?utf-8?B?VGhDNmpkUC9YV2dEKzBUMHdJbGJtdXllV1ZGWnBNTGtqNEliRGJKMmVqc2Zm?=
 =?utf-8?B?TE1BOG8yKzBkZWxFSjJxTFM4UW9jNVd5djY3d1p5dmxuZnpndEJkZGgybGI1?=
 =?utf-8?B?TVgrWE9ZVmRUSFJwbHNHQktMTTVpYi9EN2FoK1lwK2RCelk1NFlNa05PRUVO?=
 =?utf-8?B?VzQ5Tk5ONE5NSUNuenVjeDJCd0k3cTRqeU1jVUhvRGxFWktuaVRPdGVhalF6?=
 =?utf-8?B?YzFIOUZURTRoZjhOQ08wMVR5UVZlWkRNd1lKcmhqUzRjOFNKNU54ckVwVHFV?=
 =?utf-8?B?REdDc250SVlXN0g4dnlRMStxMEk5NkE5SlFtWHRUZDQ1cnphUTJzTm9NV1ds?=
 =?utf-8?B?bVROeVErUnJRNzNXb0RBOWJVcHpNYjRISzFLMlA1K291QXFFZmExRkJlNEdM?=
 =?utf-8?B?S0hjOWNUbC95RDZmMjVweW5FdWkxeU5WWDdzaGRqWnZScXRTSnRCbXJVVDVh?=
 =?utf-8?B?MkxUSkdPS0tBN3c3ZGxjVC9HNnppblZkMzJBQWhwc0I4WGViODFvczBjeDFJ?=
 =?utf-8?B?dFRqNENBZUR4N3JDdUNyaE1SNFRITVN5cTJua1ByOUxxTkZjWTE4RWdLV3Rr?=
 =?utf-8?B?SGV2MjBUQUJXblRLOHZIT0kvL0c3UDR2VVBwVkgvbzNzLzRqQnMxU3dxcEl4?=
 =?utf-8?B?QkxBbkdITkp5ekJtR0g4TzNFakZsL1kycjB6QmdDbk9aWUNMcXRiZFJKSHFI?=
 =?utf-8?B?dkMzRDg5L1RCTVh6RUFwNisxQmxVMnF2cXhhOWltRVRnZythMzJYdERMYnJJ?=
 =?utf-8?B?UXIwNURSOVNDNkUydG1UMU84K01xb2doRmxRbmk5em56OVFaU1dYNWRwTmdr?=
 =?utf-8?B?S3I3VmxFV0hrcWRUVkVuMnVyNHl4NXV1QnQ4UURmVEI3QlhPSWEzMTZIN2VO?=
 =?utf-8?B?eWE1ZlVpMmlPK3dkT0ptclJqM0FoQ3phYmU0SU1LTXR2Y3pZSFZtV05ZVVlT?=
 =?utf-8?B?Q2pud1JDbzVMK04zMm5nSko5QThXS21WSEk0LytGS1Q5NjdNaG9vZkh3V0Qy?=
 =?utf-8?B?VWVDM0hkTDVVZjA4MUdTc3dPdEpteHhoS1Jvd2QxcSsrMEd6Mjd2YjBJS3VM?=
 =?utf-8?B?a0hXQ0VBYnFCZHBoUittQTlEWUNkdHRIeW9HaXZ2KzYvRzVvUGJKZkNRdjBi?=
 =?utf-8?B?RTJtbklBOFFER3pGYzBDZnJ3UjZ1TUVNaXNrK0lBa2lsTXpNNVJUZUZ0WDUw?=
 =?utf-8?B?YTF4OWk5b2xXajdBbnFZb1Y5eFZINFViRVlOTm4rQ2hrRWJxY2dyWEx4Mk8v?=
 =?utf-8?B?TklHeEIxMVZVK3Y0MFFQZGVYTzAvVEs3T3VqN2ZDTU1tUzlUL0lKdFhhbTdh?=
 =?utf-8?B?QUh2bmRTYnBBY0VSVkw2UVdYdXdMNnlpUXZTcW9JdFFVRitnckV5b1FGOS9r?=
 =?utf-8?B?aDFJcDZUb1ZrR3Q4WVdvUDJpMTNvLzlJWm5FVVA0NkZKZStkOFZrRjA0TFhv?=
 =?utf-8?B?cEQzN2Z4LzU1UGJYdUNnb1MxZ05JdFdjQmwzNFh1TE1lMFJsaXVHWXplcDRM?=
 =?utf-8?B?QWlZSEF6SWRtU1BYb29JaExDQXJmdVlreHR0aFZPYy92OHh6YVUzWjUyRTlr?=
 =?utf-8?B?aGl5T2luSy9KbWdBcEtxRDM3bTRBYSszVE8vekpjL1U5d0dpbHBmZyt5QTFn?=
 =?utf-8?B?d2dQaGVBb1BkMHdPcjNNd0FjMXdWTGhncHRBYUs3MGl1WUtpM1J5dllMUFl4?=
 =?utf-8?Q?AE91K6vZaurUk67Zn65TIxwYKAqIxI=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/Xcc2CJsH1WEt605WbPSsRQg8PZF0Z0LxC+NddWkFpYjG05VLrppQhaETnJZETVufS2Q/s4ShQjy3X655219h1/j9qHFKQ7GLFcITS5WkIPGe8L1UIJo99/rydJTkKz7fsPODhG8EByAm24WBC78q5BVA+WcQru+W9W/hHMYSbhOSwPPlltNQl724HPf+A4PLUDazsw4r5jPjdCFuECrrFDPcn+BydU95D0IO3W0KNQf/kzDcqN43n8LCu/KAEmIb8x6BMvGuEEx+ZA2z7bQFY0RbVIU9lZTe4Hn6fmKSCc0WH7jyD+KT4y1kDju8ISTbf2egmiN3uQopocRPR32fIM3n/2pRAqRRQV4Ba9n9PZve81Y+5NPJcQ3ueQB2PfGv80jAFXtKf6K0vDQaY8f6N8h1DuhqAu5Zct7/qUhZwPPGg8gBxmn0Yz2dgzEBTfQ2dcqVzBhpIerBnVfEKNPqesyG158aH+m/dvQgycOqcHIihPDMryN6mAs0Qz8iQaaSalaMHlSCoLJRkFzhRpHJWxgM58f0FpjVCf2M3Hms9FedQFOSxxWTMzGNjdlsVW0/DZSPBORPizeTvm5Z2iQGsM1ptG5xTzIidDwetN6bv1PgpXN2ELcslg4nnb32gBe0QbMITIMKDaXJcCxOJ4+JA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 20:22:53.2279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7d1f2e-94ba-42b8-2cc4-08dd72ed5024
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB5819
X-BESS-ID: 1743711777-110536-32296-1809-1
X-BESS-VER: 2019.1_20250402.1544
X-BESS-Apparent-Source-IP: 104.47.66.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYmFpZAVgZQMMUoLdnczDAxJd
	EiydDA0MjcNMUo0Tw52cDYOMnAOClZqTYWAAQQG+xBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263629 [from 
	cloudscan23-11.us-east-2b.ess.aws.cudaops.com]
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


