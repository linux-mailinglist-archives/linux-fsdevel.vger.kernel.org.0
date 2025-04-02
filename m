Return-Path: <linux-fsdevel+bounces-45545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4FBA794E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 20:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2611F7A4ABF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 18:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50161DBB2E;
	Wed,  2 Apr 2025 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="n1HAIPBt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFBC198E7B
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617778; cv=fail; b=k0L45ygVhInd6PfZ39l0Vo0TuMu5ED2ne3Kvjyb6wbYKh7ClUWqgTSyjio94jcZH1Ac1weHwoW2Ic14acbnH1pdV0Tf50Z8VQA1n/eJZpZyXDmJnVrl9+/zAKsPCwrDXgFgLZ6Jzpwy6i+833HKBKkjhuhbSmLjWKB6H0H6zRLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617778; c=relaxed/simple;
	bh=Dua8+hES0iXumoTTq1YQ89zt7sXm6RE3yEjmy3Dxfg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HN70v4t67CzjyI87gD6MIuYwMer4v6LcyHOkqgE8oE70vO6vJsMpv7WyKzUIjfi5kIKK9o6q5AjrnEc9WtNvN9pkDpJfHjHEMOuqtoFDGs5l8wdkTBGzgnBdIYWEQ8GNnlzCDfXXTahMBJZpheKJ63adrMZ8OInGV/nOiirrn+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=n1HAIPBt; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171]) by mx-outbound15-245.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 02 Apr 2025 18:16:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeRgNYALLKxzaEdVZ8uaPUB2+L/AMdGRzxRUSdiKsp626Zd0BVdIxYpr/UnE2J4Pso8hgIrnzwa/7Kbp2StQynSbdJwnUgI7e3sSbfKP5CiugjaRB+7wste9KfdZsTTYN/+IxbvcHisU+Knh4W53RoZR2G83/y5HZ8fu5XnmOkQqu+HIQaZiQLaw0i026vtB7UMTAcv5W2XehoOQjYPIrUhhk+/6fZQii+cgn1cR15XUTwLgI0sGeZzcodsHtJz9xZtigClacQx6SLf78tayTHRZ/gDJ1pcLnzaTO7/qxDym0D4C9FwxCbvMzIl5gAPspLXHMhQQpsTVXY4yBYLPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=906l0uz2nUjyJTIeUeXoSrOz5nvaEGy28z0fUxDyJ0M=;
 b=TDS4TQtl5nJ/RSDffkcz+pn+v+Q4OmwXTu6U7JjsEP3xxYgmEzTPdwsk/pC5YeCuJ8JJsxXvwBEvBygQEp2Yy2fRu4oqyEeztb7rk/wyvStl0ZyWEt36OU8FoGI5BlKAELOp+KtaJQz9LJbI7THDqPI2iFVBcTJ/yJLYOfQHgoVsaLRS+ZMybhaL/wXvr5UydvB/6qyOf+sIkHTdX6YBl5uuFxYXBDDqu3+yyOWMZgLcKtPAFgWOvDCSbpFZqqRhyO0q7o8Lqv2GI/3WoAC0+e3QuWN1upfhzLYxalYjjthVzUeKbMZ9rq/J3eF4eN4sZ0BkVDcLW5AD8ng+zCLAjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=906l0uz2nUjyJTIeUeXoSrOz5nvaEGy28z0fUxDyJ0M=;
 b=n1HAIPBtP5vpcHknj99HMFNDv87hh9ZvGfTwIZmE/esH6uyJiUOJ0KyBX6I5bkEI+lPxQVSovU90r+N+XE2BRN1hmXnQYfGheB6m3SuOFvel2zgDScxdi9tyTte1TvvBLlMxrZJCzfBjsI2DZe5o1G8xFcnJo6/roXsm/4etTo8=
Received: from CH0PR03CA0450.namprd03.prod.outlook.com (2603:10b6:610:10e::28)
 by DM4PR19MB6320.namprd19.prod.outlook.com (2603:10b6:8:a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 17:41:06 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::8) by CH0PR03CA0450.outlook.office365.com
 (2603:10b6:610:10e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.41 via Frontend Transport; Wed,
 2 Apr 2025 17:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Wed, 2 Apr 2025 17:41:03 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id C84254A;
	Wed,  2 Apr 2025 17:41:02 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 02 Apr 2025 19:40:54 +0200
Subject: [PATCH 4/4] fuse: fine-grained request ftraces
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-fuse-io-uring-trace-points-v1-4-11b0211fa658@ddn.com>
References: <20250402-fuse-io-uring-trace-points-v1-0-11b0211fa658@ddn.com>
In-Reply-To: <20250402-fuse-io-uring-trace-points-v1-0-11b0211fa658@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743615658; l=4634;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=Dua8+hES0iXumoTTq1YQ89zt7sXm6RE3yEjmy3Dxfg8=;
 b=K0FIP+dKqnrXK5Xv+mSHwcqdRc/iUuB8CwhzFDKFFcZDrl76EzTXRH+aUjQMXql79neqwmcTg
 abfDpfc8y5RCFBRt9+0iwzFr0XJ0a330Um9XdR8p8OtHeWYi19Y3KPV
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|DM4PR19MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 80bf673e-023f-4b9f-fcad-08dd720d8a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?elF1U3hnWDdOOHBlQzczaFpQd1NhTDAxKzRHZkxNcjBOQUpvNVo3VGZCZC9r?=
 =?utf-8?B?STdoajFMR2VjbUxvY0lmdTFNZjl6U2cvRkpDanMwN2l1Zkp5MjVRVk00SkFj?=
 =?utf-8?B?UTdTYWZyMzVkRGJuK1M1aGRtazE1WEJVQkJiOWJGSFZHKyt2NnRVclZGMkNQ?=
 =?utf-8?B?MEsxdyt1VkNNNjUyZFpqL2daNU1NTWI0aENkbnBQUkdnSnhxTkFSU2NxU3Bm?=
 =?utf-8?B?ZWYzWTIvc1JGMHhadFZBNnRYZzVhcVpCSHcxSWFkKzVIMzZ1SDBqd0dkdGlj?=
 =?utf-8?B?VHR4UHpzdW5iTG5ERjd2RVNqQUNoZE5JeGY2eHZHbjFKTDlXbkNBQnRUSnB1?=
 =?utf-8?B?MDVwQmc4YlJHVDMyVXFQUnlZaTAzcUxpNkhOM2lVMW55YmROcjMxNURjM2ZP?=
 =?utf-8?B?VG9ueVpGVSt5ODFtZ3R4enpxUGdRQjVFSS8rNW1DdXZ1N3YyaVFJRUltR281?=
 =?utf-8?B?LzFkV3NvdzQ2bWlQSDhHQjgwSU9tNVRZcVFsZ01SSFJaUGVkU2g0WWtJTFFQ?=
 =?utf-8?B?VmRtaGFHQTRiU1NKSmpBZ01oRUN1bUp1VlMyYVY4amd6N3VaeTFlaFhveUo5?=
 =?utf-8?B?dWh3dWpWUy91M2xHaXkrdE9SV2ZSUTQxbXdHVS9lS09jdHVSTkpKSEpVR2cw?=
 =?utf-8?B?UU9ZSmJTejZkNFJDTlZPbVUxYWlVRlhkY3NZbkdpUUtFOUU3bDYzZE52UC9Q?=
 =?utf-8?B?U3FpMlRaK1NPbmRrdGtReVpmbEVzbGpYaDQwYk9yL3VEUjNGaDdnR3orN3Jr?=
 =?utf-8?B?RUxJUG5ZT3piclk5UFJCRzVHNldhSGlqRFM5SUtKOWdDblBDMGZpTXNEM0gr?=
 =?utf-8?B?NGZpaWFoU3U2eWV6T3dpbm1LR2p3WThQekRYb1RidmpCSTRaZ3ljWm1VRUxo?=
 =?utf-8?B?VDFrRitHbGthN3Y0OTFUWVg0SmdYQzA3SVprckFibzNKSDc4cDZlZ2hvTk9N?=
 =?utf-8?B?YVUvOFUvOWNMaWxpb3RuWEpPekNad0F3WUpORWNqdVQ4aVVMVGNVWHdKeGJU?=
 =?utf-8?B?Q21FcXZjV213YzBKQlNlaFBENFA3NUNRYnd3UitxNC9TWGNNNHJqYm85L2Mw?=
 =?utf-8?B?bHYveUx2c1YvMTBlYm1YbWFKb1dORnlTcndUM29tNzZLSUxrM1U4VEdrT0pm?=
 =?utf-8?B?eHJNMkRNZTBqeGFKK0tPb1lENEhGdXNOR2MrS1pwc1p2MVdWMTJIeU5LaGJ1?=
 =?utf-8?B?Wmdrai9odUxkT0N2SnRYdFZxRXVDY21wR1cyb2puRklsTzBITktGZ2pPc05O?=
 =?utf-8?B?c3FYOXliK1VxaWNaRUdGUllDc0duKzVKeFYyZ2E4NWJYUFQ4REZYS2x6NFEw?=
 =?utf-8?B?YUc0N0lycEFReG5EWU91eTNQSkxIWVRzWE9qZktoZ3ovSFczSWRxalQvWExU?=
 =?utf-8?B?Nm44bXpFMGcwVWJFUXJhWnN0OTdZTTUzNlErV3JlUFIyTkxCcTg2T1B0c01o?=
 =?utf-8?B?U2ZuTEFHKzJ3c1duVExaRWdlSExpN1R5ejJVbmVKdjZLcW5TLzVyaDMwVDVX?=
 =?utf-8?B?Q1QrQjhWaHB2TzFCY3YyM3p6dU1vZGJJV0lGV0tqQnQ4TVM4U0RWTGRsUytt?=
 =?utf-8?B?MFdvRlpoUFBMbWx3NGEyOXFzdlFpeC9iUmdUMGpKd1Z0WUNYUmV0RVhmNTlk?=
 =?utf-8?B?Wnkyem50OTJxeFFNeWU1OUJQWEowWG1laFlxRHZSc0JWc29NdHV0SzA1QnNh?=
 =?utf-8?B?NW1kMXNiUnJHdVppMFpIWUZxenF2V0g3NktqYzY4K0ZhVjUyeWt3SEtydldp?=
 =?utf-8?B?dzFvYW4ydis5R1QwREtOTGJ4K1g1ZWZMUEI5Yy9oWjU1ZENCQzFRZnF2T2M3?=
 =?utf-8?B?S01xNmtvbDRUbkdoYTdwQlkyK1lUYUVjdTBCV3dyaGRqbmlkYjZydld0KzNv?=
 =?utf-8?B?NEh1VUVSWVh2OElnalUvcFBTYTN6R2Qya3cxNnkvMnJlZCtCam1LeHF4MFhW?=
 =?utf-8?B?bm9vTzhXQXJIWDdDMDA4Q3F5RXBWZTdka3dHZWxORDdOa0M2eWNWRmhYZFhP?=
 =?utf-8?Q?QXS6mkhlNZ0hYhsGr8cuSafMjoW7cU=3D?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 B3w6+oS+vE2l/QrVTzSDUvnZGoHT+qsPeuX2xw+Ck8Xsynhc45O5bD3JqVv5NmJqDtA2p8MKJfQKbGyivkeVC7mx07QpXmztQrJs6Po/0fJEuEebkDZllvWhzvvBK3xdUin28/ng2XxiEpHO4e6d9CU4tqA4UQO+x434AcKrmXRDaClDZh3SVdY6VGSEa8zf6/3cz/kMxyybgdpK6tDnswzEEOrtX+kkA6qqlF9fGOqOe95o+zOnh6G2QtI0IlMQvnnMvvux1+YN+wk5+xlF9ydDDaRnLUNyMa9wSjFJrqiBM2scLzcRM+09tSnkof+MWAhHv09/hSzHbTCUojfUaA/Z9zad4p26mLb6XP8uSRf5nmG6OVVj0CGcEARdF8c/MI7ZfqU7GC8ZgwoviSJT/umtKs1mS4f1ZI4gHjGHUQc/3AfFjO/UKNN8FrD5pDb0XS1kW0K3JW+vOja5knHM6DN70l42uigDAihuKbnf582mMuBvu/lmEvTZJmEtl4uExUdwjXHOONGQg0fAkSxxTlBfkq9LLDH/dVcdxS6RV7jwTIQbAE6zpezZ5Fr4Iuh8j2gxFKT8WIG7FWNtxnWnRN+/Hc/JfkhdjfZy4tiiF0awlVjood0NvVgHdHavY/rWTtLUdnktT88IigeWwk1UwA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 17:41:03.7596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bf673e-023f-4b9f-fcad-08dd720d8a67
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6320
X-OriginatorOrg: ddn.com
X-BESS-ID: 1743617771-104085-620-11849-1
X-BESS-VER: 2019.1_20250401.1649
X-BESS-Apparent-Source-IP: 104.47.55.171
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYmFpZAVgZQMMUoLdnczDAxJd
	EiydDA0MjcNMUo0Tw52cDYOMnAOClZqTYWAAQQG+xBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263603 [from 
	cloudscan19-104.us-east-2b.ess.aws.cudaops.com]
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


