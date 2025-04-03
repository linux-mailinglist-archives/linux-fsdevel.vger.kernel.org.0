Return-Path: <linux-fsdevel+bounces-45699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A93A7B040
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 23:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FFB189A333
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 21:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C92A1F0E52;
	Thu,  3 Apr 2025 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="VBPhzBzi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C371EF0AB
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 20:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743711787; cv=fail; b=b/5k3u9QtoNhIY7Zt10rXPICr8iUkO3Cx2YE3mqdSMkgjTHBHjeuHkq3DTKZynmXH7IAVKiFi5o4apOMwTrsTeelS2mRMdPz1CLoVyOoV3mDzoHLqL+eyLZs3em9KcIijBDmqvRYemCWBopxZQEAVEq3ofxRe2TcD8cF6fGo120=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743711787; c=relaxed/simple;
	bh=ziYZV/W/d52W8kKfIYz5/3su24KBpyjnMK0qQasJq7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ICzZxAhMWpG5aYH6TRg4FlFCc2hkdKrVaBFmAJYSWUN3MtlBBikikRkW+CuFPYW3EC2TzTOqhjorW1ypSIsDmIw0dewnFECz5OJXWSkHqIK71mdwB5E7inTuzo0xJCk0LRlXvR8iGpCLXl1CArYUit3yGeknfdV4uF7BTCssKuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=VBPhzBzi; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169]) by mx-outbound47-169.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 03 Apr 2025 20:22:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Er5LxKlIujh8GroCAuavXKb5Cm1oweUqcQU99pAbsf9qAGUr8iRSK1c7wc5E7tK+xrRgKtHirZ1J51zDq5Z4X8H6mtYP7YAqtvESBT5ronlX4mXicyfBEpMb1RVacAJT9D3gH/lXdrqElGyMUKAwlCL9UiLB9NfyToJhv9eoVNWWl5e0IrxMEPQvPe4fWQdxca2xIJyTe1vpPkNmYewTxyWjiogATFlstmNT4l8WfXKMZ5Any0jc4wlqB+QDQqTCMTN5ddZUgrn7/F6ojlGTFxbqd1mtC7AWmPzguGbapnGTYsjklN4k3btuy7Eqeza5nL7eqgIBHXMj68fAiJhByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/tm93HuADKuq/51kxy83RJV/L4xXQ5WraSoBE7nzxg=;
 b=E22nIIdD8uoBF6O7zRAkq1t/xgoYh94oozA1bGc5odZ+xw6ACinxJyrPiUaXYDPIe7DPPqOM8rMCsQOrFdKYudhXdiO3DsutnTBYh4OoAX6GILUjytn/lX9yVuu00ojT0RWRBQYjuNP8Bfj/pd5d8kmyrJfWUVZ1CMAtonHAjYmsNQ9hMaU3uNA7zsdb25pv1/ztsBB64lJjt3M94JK1pN4l4ipZ8SHUNeN5H5/5cwDCoF4Hfu4eXYFPtehW6TOT0N3HsxLX/hLWIdO0sE7Tqw02CZP2MtNxPZL5/aAZQT2ChrbMTjXt+qXxvZMVYPxSJwFmZ8aVfK4w8ToSebASEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/tm93HuADKuq/51kxy83RJV/L4xXQ5WraSoBE7nzxg=;
 b=VBPhzBziJPD1Q9WqLmd6+FL92YAtomuwuvPTT7U/xCNJzvcQUqfSLtcR9sctFNsAq7xDkLhr10QPqzUBCTHCdwQHe+l8XGtpHniqcwDMcsTnmS8Q5ORnA9zFUEfTaEq9DpP+yZLPl/xiMxIHWffs9HN/AT+vpu6jbjYE+mF37I4=
Received: from CH2PR08CA0005.namprd08.prod.outlook.com (2603:10b6:610:5a::15)
 by DM4PR19MB5980.namprd19.prod.outlook.com (2603:10b6:8:6c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Thu, 3 Apr
 2025 20:22:51 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::88) by CH2PR08CA0005.outlook.office365.com
 (2603:10b6:610:5a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.26 via Frontend Transport; Thu,
 3 Apr 2025 20:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Thu, 3 Apr 2025 20:22:51 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 735544E;
	Thu,  3 Apr 2025 20:22:50 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Thu, 03 Apr 2025 22:22:46 +0200
Subject: [PATCH v3 2/4] fuse: Set request unique on allocation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-fuse-io-uring-trace-points-v3-2-35340aa31d9c@ddn.com>
References: <20250403-fuse-io-uring-trace-points-v3-0-35340aa31d9c@ddn.com>
In-Reply-To: <20250403-fuse-io-uring-trace-points-v3-0-35340aa31d9c@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743711768; l=2914;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=ziYZV/W/d52W8kKfIYz5/3su24KBpyjnMK0qQasJq7c=;
 b=MP072FjBgG1kwmxQ4GsItwMN2iw3Vi2Zbo/5I1mqCZ/Oc+lmape1SoQnumg6VJrVfvOn+7nOc
 qrUiISVDHsECbmgOVkSGdr9DsXtsFmhabBf4ftppnW2BgS0n7yWI/0u
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DM4PR19MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f5dc71-53f1-452f-3be0-08dd72ed4eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmNrM3VHd0xNWldIUHpZV0t2ano2NWprTVM2d0VRL3I0dUMwRjkyTXhzM0Vy?=
 =?utf-8?B?NE02RkdGTWlaVzcvYkpyRTh1L0hXMlFVNVB1NGE5cTAwVGJIcjJ5a0ZGZHFK?=
 =?utf-8?B?Ymx4RkppeGlZdVJnVXVFMTdQVlJzRVJLNFhXcFFvbDNrVDg1RFdDREhlYXhP?=
 =?utf-8?B?dUdCTTFiK3F5VXdnYnJ3T3h3b2lqYUFzNTlic2R6VExNYU1jMHRSRUhLVjlB?=
 =?utf-8?B?QTJuK3RCY2dIcEFoZXFTVjIySDJUQ0Z6NnZYc25LNnNXc2pUS1RFL0txM0h4?=
 =?utf-8?B?OS9GUzcyRUJZQzVvYjh6aUdONnAvRVpnZlpCUVM2WUkyZTRhTDZOUC9jbS8v?=
 =?utf-8?B?QVE5M25lNXBZRk9hYUQ3MUlES2JGdiszR2dKdGtuem5nYmlXQzV2RHhBa0FK?=
 =?utf-8?B?ZzFXN1UvTk1mSEdNQUk3a2pKNHNYK3F1bm1DUWV3OXBlZys1NWx5dEVKOGMy?=
 =?utf-8?B?bGVrRmFEakJWT00wb0dHa09iay9TTXpGbkh0TDFhMFZ4NVZvbXd2c1k2T1BB?=
 =?utf-8?B?MGpld05OU0xtL1JYWERpVFZoc3huUUxhZmIyMWwzdHNtTWRZTytOU0p5Slo0?=
 =?utf-8?B?Z2VIZk1LT0xPRmV6citwTUFnRkZhcEViZGhZclZYRmJPMTNhbUtFZlJVYmNF?=
 =?utf-8?B?VFIwUFU0YkQ3Y1VMU2F1R2tHcmtlTG10ZVpORStzeDZ0NlhsaTVhLy83RUlo?=
 =?utf-8?B?WkJxZHNZVlMrZ1RZdHJUQk5GZCtjNFp6ZVB6T21RVmM1eTBWZzB6L21DTHM1?=
 =?utf-8?B?NjdRc0xZSGRMNWxlTkt4NENCcjRiSjkzT21ZZE1DZ3NFYW5iSktwcXRwNlM3?=
 =?utf-8?B?S1VSMFhPL05WNm1vQTJmL3lHUmZSQlYySUpqYm9TVUxuVW5mUVJoYy9TdnNL?=
 =?utf-8?B?OCtHbDdMOWdCUzc1eVk1em5rWU5NU2VOamVjSHY1RklGUElYQTFxa1R5L1lt?=
 =?utf-8?B?TjM1Q0xtalhvT0NGZmxXTlFPVzd5RjBjbUw1RlBvWlI2TnlwL2VpeWNSRWJY?=
 =?utf-8?B?c0RRNnFiWGdCTHRlK3lFNGRZY2ZSTEdNZlQ0RkQ5bitKTHFYVTBMMFZBYXpn?=
 =?utf-8?B?SzF3Z29vSUkzcTJKeE5KY3NmbUNuN0o3RHV0SEY2M09ZUzFOTk1FWG93U0kz?=
 =?utf-8?B?ZWx6NFZveHdtWUdsT1hJQlRpclNUUGt2b2dHZjljQ3UzSmVkWnRuQ3h3bVlB?=
 =?utf-8?B?MnA4WjBYTXF4aW9xSmZFVk9lZ3N5Q3VBV0x4YjBMdW4yNWM4UUhMREl0R1Zy?=
 =?utf-8?B?b0lybUY5d0xMSGpTcmFoZmhiUllZalYwM3VBVE1nalNlOHl4dmJXb3ArUVU1?=
 =?utf-8?B?aFdSSExJdWpmRnl4bWU0QSt5VWNMYncrWUdObndoNk05UFlFcHFVRTVQWFFX?=
 =?utf-8?B?c2NRZ2NMTUcxLzlhbXY0cmVtOU5Ra2pWeEZFeE1nR3FyRWNYaHYwbHVXQklU?=
 =?utf-8?B?RSthcGJBbkVXOTlPRHdJQks5YmUyYkRWZ3JCNS9KQmpOT3Q3MEpKbzRsOURT?=
 =?utf-8?B?ZEh1cnViaWRTVERMQmU0bTdlTDBGL2hJdUcxQkRnb01ybFA1bStNd0ZkbW9S?=
 =?utf-8?B?cGlDVGRnUmVjWUNSOGRVVHVUVWQ0MjFUeWJ6QmoybHMwaFhJRFVvakttSmMx?=
 =?utf-8?B?REFMdnVEdXV1NTdPd1ZaRmhYWmJVMkZxbkFBYU05WTNWUU1BSkE5OWQ0VTZp?=
 =?utf-8?B?SEJBbkRIY0MxSUVFajRCSHRDSmFvZzBaaGs2NEFRUTRlNkRzS2toa01mYUVw?=
 =?utf-8?B?NmEvbVJMZi9OZjVnNkl4Y0hwWmhkWTZRMGM1ODg2ZGZubmlsNElaMUgzaTQz?=
 =?utf-8?B?ZzlvSDFWUnFXV25UNFFRWkc3Mks5ZUQ4UDRPYjhRbXZIc2kzbEhEVW0yd1Ba?=
 =?utf-8?B?MWFlWmEwUDFHQ1JkSmVKZW1JODA1Q1NueXpSckVIV0hHQnFMRVltd01TMGVX?=
 =?utf-8?B?czM4VzFERVNPS0lGcngySDlSUnZYQVl1S2xkeVhmd0I2NVdvWEpmVmQxTFdK?=
 =?utf-8?Q?4eH989oDrj9hEOGcHoHgFZSI/qVy+E=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hskrT5yS6gwaW4eK+b+o+6s5FszDvx1u/e/V6ir5+axntzZnITXYzsDXdJQ2xWZQdbKHp66ItK33EAs1ATKx+RQAgIstaSzz0UzCIxTzrAIoJPirS79/Bg82OBXXouf3nkDSt0ej2VXUHl6/FhxGKu9Aa+ZsLewT5RJUot6lH10DRIpZeSfq1WWuAYo6EXL9i3Kcsiifiu50rKZ9GW+rdW61qoch9pXR1eK8mpkYgO3MZveV8nmXOv4sQgv7S/rMZN1BA61HM+n5NMg7hx0xJAOUTFdhRAS2iRVPhV9gtGc8SV09/ul+qAabSYWtvnghgEfQIb/QUp3R0fytvdkp8QOV9eSykJj3ZBc1G/YV5K7mmDVFxxyS9ACeEiQdWLpjiVyUGj6TO8oIqZoK/Kwr27GbUqjn30mtXYicsqkCWUXD+PjVzVOvml82nOX4YHrznvC9FdppAC5JJnT7hFg39VkOINBPyiZqyV8QRLNqdk3rma1kesZZGnxefR/diFJG4lMxupo36TxXfXzm3/iVpKbtwbo0qLEIsW7b1o/a4G0hDJJI+z1W1EdShdXejgy4uBtKCWYJx5aavJrF8f+9SUIKUgC7wXV4t3GjpPlpwfMdrK6w2IWupZYBsY1yb7Zjf+FkaFdE21zktuV74+g+yQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 20:22:51.1836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f5dc71-53f1-452f-3be0-08dd72ed4eec
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB5980
X-BESS-ID: 1743711774-112201-7669-21115-1
X-BESS-VER: 2019.1_20250402.1544
X-BESS-Apparent-Source-IP: 104.47.59.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYWxmZAVgZQMNUiMc0g2dA0Mc
	3S2MQ8zSzZKM00Oc08KdHIwMIi0SxNqTYWAEQDCDNBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263629 [from 
	cloudscan19-170.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This is especially needed for better ftrace analysis,
for example to build histograms. So far the request unique
was missing, because it was added after the first trace message.

IDs/req-unique now might not come up perfectly sequentially
anymore, but especially  with cloned device or io-uring this
did not work perfectly anyway.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c       | 8 +++-----
 fs/fuse/dev_uring.c | 3 ---
 fs/fuse/virtio_fs.c | 3 ---
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e9592ab092b948bacb5034018bd1f32c917d5c9f..1ccf5a9c61ae2b11bc1d0b799c08e6da908a9782 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -259,8 +259,6 @@ static void fuse_dev_queue_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	spin_lock(&fiq->lock);
 	if (fiq->connected) {
-		if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
-			req->in.h.unique = fuse_get_unique(fiq);
 		list_add_tail(&req->list, &fiq->pending);
 		fuse_dev_wake_and_unlock(fiq);
 	} else {
@@ -508,6 +506,9 @@ static void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
 		req->in.h.total_extlen = args->in_args[args->ext_idx].size / 8;
 	if (args->end)
 		__set_bit(FR_ASYNC, &req->flags);
+
+	if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
+		req->in.h.unique = fuse_get_unique(&req->fm->fc->iq);
 }
 
 ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
@@ -555,9 +556,6 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
 static bool fuse_request_queue_background_uring(struct fuse_conn *fc,
 					       struct fuse_req *req)
 {
-	struct fuse_iqueue *fiq = &fc->iq;
-
-	req->in.h.unique = fuse_get_unique(fiq);
 	req->in.h.len = sizeof(struct fuse_in_header) +
 		fuse_len_args(req->args->in_numargs,
 			      (struct fuse_arg *) req->args->in_args);
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 82bf458fa9db5b2357ae2d1cf5621ed4db978892..5a05b76249d6fe6214e948955f23eed1e40bb751 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1230,9 +1230,6 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	if (!queue)
 		goto err;
 
-	if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
-		req->in.h.unique = fuse_get_unique(fiq);
-
 	spin_lock(&queue->lock);
 	err = -ENOTCONN;
 	if (unlikely(queue->stopped))
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 82afe78ec542358e2db6f4d955d521652ae363ec..ea13d57133c335554acae33b22e1604424886ac9 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1482,9 +1482,6 @@ static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	struct virtio_fs_vq *fsvq;
 	int ret;
 
-	if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
-		req->in.h.unique = fuse_get_unique(fiq);
-
 	clear_bit(FR_PENDING, &req->flags);
 
 	fs = fiq->priv;

-- 
2.43.0


