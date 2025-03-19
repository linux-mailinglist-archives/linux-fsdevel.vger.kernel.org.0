Return-Path: <linux-fsdevel+bounces-44448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA551A68E9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 15:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3F93BBEDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 14:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B187B33985;
	Wed, 19 Mar 2025 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="UzDvzA2B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748DD487BE
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393327; cv=fail; b=T+XL1g8QmU4B98h1uJWcSK7a8pulzHplcuyinNDCEVe0j13Drd1IZ9ZQuc5o9XOJUreYn5gnF/H0p2/ln6z9QCBmw8MQu+qMHOI0PP9ggH7KcS5OXNLlfcA1oK01/+4edNwsN2PfUqCF4pybTty8JraBVKfRxqUpFQgO2o2njek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393327; c=relaxed/simple;
	bh=JuIlPbgOMtj+ihNV/mfi7kH5/3BnouRUrFzAfDU6mRg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c4f0oX9Px6JI8Cmv3ImL2oYrWaS0fSnjk2kEz2PcatzrAVzTZfVp3aNEngNeuhXbBeOZKra7ZpoOJEMMfQRMXZTmmj1vKO2PWSNZdh2dykcOJzcqiO77waqFYSai74bL1k8dyBr0NO47wYYeeclg5ZlplduYxvgcgTXQD5EVy4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=UzDvzA2B; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49]) by mx-outbound46-141.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 19 Mar 2025 14:08:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dG6yVYlxkFwl6XNk+7LAxMNQYPsrn0iSnADNVloiwQ8qDy2XsTDyTmAmF63+UUmrTCx6BRxDoaAil+SEMglQD1awar2nem51XlAxnUwa4qM1MDapzLqcyrwFTLGzXGwBD+p+JWgksysG+2uEhPGzgdmy3i2770+tCETQPaeH8YbQT89Rk09hTlnAHbjGleiV9R/vWXEvhYrNvKCpLvnZ4r6amdPvTuFoTMdq7RL5p/3rhgduZ0Xr1HljxSO8p0W2/TJf8Vm4jlgbwj/p6XIIxc1pbS+6HbK1VC8GlyPOWvmuOxgCPJaTZHj89u9XUuSSC6xOAPG/Qy2wy1hYI1OhLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2o3tML6CT9dKe/w65ahxFnEo1WOCSLd1w0Tr6Mo9/ks=;
 b=fSMXronSbM+/5RPTSrXelfXFOE1yWepRf5A9wRJt03jZK/iQhhW6LryoykIjnGCRwApmyz+eKp/FY2UbLzquK20miMfUYhC/DwSWw7au1rjMBqqWGCtRohKnX22E2eSoo3OVZJm7/4OBL1TpRoPiGM4oNJnW1hYiWRTbC6kw54Z8dhOSNenzEJ0FbhVybD0PCFDEqEVj7jdA6MKDl4aVtESRqMq3pBXfWstAarKs/+qxSPZISqtfhvbpGa04/8IF8v1MIoOdEv/DxfQiGia0JTwd6LFjU90vGGR6uNGqWjX9BHWZBnPPUWRO9HLqQfXuZQWsAB31IHup2J5j9WPllA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o3tML6CT9dKe/w65ahxFnEo1WOCSLd1w0Tr6Mo9/ks=;
 b=UzDvzA2BvqUzAbNUtgoJs4SIGkEhy0b/Gl8xsEsMG0j8WMQI2UTL1catHtzcYYVpIKk9BglTXnSUBD1SKWmGpZTHM1PyXI8fI/LUe60HC9tlhrC6pqgmoDD6s38+E3ARxKAJf/nwRe+afyTsymATzxvQLd42bbwKcn9CxLEN0jI=
Received: from SN1PR12CA0086.namprd12.prod.outlook.com (2603:10b6:802:21::21)
 by MN2PR19MB4110.namprd19.prod.outlook.com (2603:10b6:208:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 12:36:50 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:802:21:cafe::be) by SN1PR12CA0086.outlook.office365.com
 (2603:10b6:802:21::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 12:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Wed, 19 Mar 2025 12:36:50 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 005834A;
	Wed, 19 Mar 2025 12:36:48 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH 0/2] fuse: {io-uring} Avoid possible FR_PENDING related
 list corruption
Date: Wed, 19 Mar 2025 13:36:33 +0100
Message-Id: <20250319-fr_pending-race-v1-0-1f832af2f51e@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFG62mcC/x3MMQqAMAxA0atIZgNtiqJeRURKTTVLlRREKN7d4
 viG/wtkVuEMU1NA+ZYsZ6qwbQPh8GlnlK0ayFBnyA4Ydb04bZJ2VB8YHbueIlF0doRaXcpRnv8
 4L+/7AY6w0AFhAAAA
X-Change-ID: 20250218-fr_pending-race-3e362f22f319
To: Miklos Szeredi <miklos@szeredi.hu>, Luis Henriques <luis@igalia.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742387808; l=906;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=JuIlPbgOMtj+ihNV/mfi7kH5/3BnouRUrFzAfDU6mRg=;
 b=sjNdMCpox5iInVqxugoR8D6rORMW0QJmLXuxy0I7W9iJaD+v9d0wmqxCN2TOOu7sRdFbSxIVg
 jzh6UprG2fUAk5/IMvOkJUSKnvABSXocwy2objQFL6Xwr+94MpJqdnB
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|MN2PR19MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b3ec83-6ae6-49c4-2aec-08dd66e2b885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YytvVVNBcmxzd0hBSTJZazlUbUlyNThaeTF2bkFVZ1N4M0JaTTdoODdMQ000?=
 =?utf-8?B?ckJtaER6T2M3SGhOdEZPQVNQSTlkOWU0eW1aK1J3ZHRtbWJ0OWluWEZFT3gw?=
 =?utf-8?B?M0I3YWlPSlJ6YnZRWUJzOXhXN0MwakdsV29GU3JaTXBPT09jd3pCVmpPWElo?=
 =?utf-8?B?OTNIRTJQS1VEUnZqRGNQQjJjRHhJTFhRbEdRRTdWZ3RFOTZueVZYeG5ENk1Y?=
 =?utf-8?B?bzEraE5BekhoRE5KYlUwenFPUitibm1hbmxIRExjZHNFSlFLcHAvcGZib2VY?=
 =?utf-8?B?VnVRZG14cG91ellwc29WWHNwTzc3ZVk5aDgydnZJdnZObnV2UENLNkVJd0tW?=
 =?utf-8?B?MGR3V2xXc2phemRTaUZZSzBucGliaFJ1M0czV0tldnlGTGFBb0NrVFBqYlRn?=
 =?utf-8?B?MEVOUUVyV2VFT29PYktMSndHNk93cDlibTg0WmE3Zk9MUVZXV1psMWovMzBl?=
 =?utf-8?B?OFBCQ3I1b09ucVN2QXp1OEpPckFVQlBmOVFVQ0UrTk8wSnQyTlF2djBtczI1?=
 =?utf-8?B?NmlQdm05dndJNnczT0FyOGJVa3liay9qOGM5VThoOHNLVDVkN2FXWVdsNkVF?=
 =?utf-8?B?LzNEOTJaYjZlUEtkR1pBMGhjMVZxOE10QlVrRm51Y3NGK2srWmhMaWxzazBF?=
 =?utf-8?B?UG9rZmdUTXNHVXdGVG1kK1AvaVdzUllPSUU5UjRvYWFPejdRdkJYakJRQTVm?=
 =?utf-8?B?dEc0djBiWlRBV0svamJ2L0NzUTdjUUxIUWxqZkJva0swdldZZzV4U1JTeVpE?=
 =?utf-8?B?WEhXTWFMbWJJMDU2a0ZtdUpzK1ZpSHAxNkNrcitRdHUva0RiQ0FqWThOR0lh?=
 =?utf-8?B?YkRsbzdZeTFlN0IwRmZQb29ET3NYUmk1cVkyc0k5Ykd4c2RRNWVqTGoxNG9s?=
 =?utf-8?B?eUZVY2RNVGZmWmk2Ym9XYjlwMy81a2xRb1NKYmJYWE5Kc0FGc2hHKzlsZURq?=
 =?utf-8?B?cVB0L2xCU20wYU5peEdqOXJiRzB3MGFHbnFXdVVyWDU2ZzRXMG5zcU9lRk1x?=
 =?utf-8?B?aW1DTnhETlFsZ0JNcWdPWkxQc2FJbjZLS244VVU4YSsyaHNOdDc5eDhUTytF?=
 =?utf-8?B?MDJ3ckhLVWdtelo4Q3hNMnZIcHZ6OWZZUjlSTjBXUi82WWN1c2VuOURDSVhm?=
 =?utf-8?B?dDNRN2NKTkJIR0d6ZGdaUHcxNGtLTis5Vk8wSnNuYU96dTVFb1YrVGRZRW1m?=
 =?utf-8?B?MzJjcERvc3pXZXBzZzcvdWpBV25Zcy9oV3BvMUVINExpUTdQWHdZQUI5Ulgv?=
 =?utf-8?B?ZDFScFgxdzJRbW5vYUZjZTlSdktueHFpM0k0R0RYVERXOWZwUkFyMHM4VU9O?=
 =?utf-8?B?NkIwRnhPVXJFZG96STBZT29udG9zSUlzMk1Fb0YwbUdGWEZuSVBrNm5YbUdO?=
 =?utf-8?B?SngxcjBYeTF3RndCUGhDQ3doSndkbXpoTGVQd2J0Ym9Ga3FZZTE2M2w2Sm1W?=
 =?utf-8?B?L0s3NHhjWGpDNmxwejhZak9MT1VFMEp6Qkx0TkhtNlRBcDBiTVEzaXB0L0xI?=
 =?utf-8?B?bFVRVzR1djJVVTFtNC9sVlVJbVE3SnRPUk13SUttcDlnR0hDZ0dmeklPNUVJ?=
 =?utf-8?B?OFdnbGZOdzJSNmpyaVN4dWM4RDhpWW9rOUdIeElFUks1UVJDS1prL2hPQ3RN?=
 =?utf-8?B?Q0lYNU5LTDU2VHQ5RnJBeC85OVUzOHdMTzM3bEQxS3MySGdmSTBhcFlRNk9V?=
 =?utf-8?B?ckNmcmtxOXlKRHpsS3FQemx1eEw1WFlYSUhSWVlOQjFxeGY1QkdwWVNHR0VB?=
 =?utf-8?B?eVVYZm9OTW5pWDZoS2djcDlVMTZQZitwVlJ4Z3hpRnp6TE5tdWkxVEd1R2wz?=
 =?utf-8?B?QXMzWS9PWUx1Tjd6VXZ0SkRlQ3NJakF6NFloSDdLU1ozZnJVS243dXRnLzN2?=
 =?utf-8?B?TVBQczRFeTVPVmxqRDU2MWhoZzZ0SEs2SGM5MjlCRmpwNVZkeEJGL3o3cEJs?=
 =?utf-8?B?aXVWTzVmNkI1Z2JjcUVRSlJGcTQ0cDNsUnhxbG8zaW40ZkZjWVg4RkV6cEZj?=
 =?utf-8?Q?28pNuTGM9HXuFi311Y4wW+scjT1E9M=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QoZvELfDs0/oOS8yQuYg7XINdo2MZ5F2pkELzJEPZiv3d0AcvIo6XRWmRQIc6P5iwOCwkpUrtRzk8V1VqwL1g+1iR3nWmMrfRWQhoaLsTVoosIAPKYwNUtvQKR4PBwrgRGnJJydoM3ot43hjuFUnQ82KvBpWXRt6ts5kaGQzcIWoxXY3Cc7kNaITMDgWNgbZ4tMvxPKDgX1uW3m6OoK5z1vLPG2rKShlAdMnmlveQPMFhawUQxnYcVHSKS66ZODXMXnYaroIReR9rwFKKhGW1lir4ZTKqrGEuTNHy+HWfD6uG4e9HY1A97ATT5wq8yN/ZzIaeUgnAtTc2AX8e+fHQR7fFLGIEEKCwx9qqxsFaxuRU8sLjatR5onSwZam6TQ/QbYQdZdFGYJOZBB/LFFzIQcn3mQTKHCVEoNcaNq79BrnCmOyRCtylvHfBJp3BqBCv7eJfyy+rD4Q50s9OTub1jVUphnAgAs2EKh1z1COvJeafYKsYGIjSAWyCIC1Q3n2mhTrYQkiI8ewZ1szj31i8VDhzsmusF3P5E5Ls/RafF6bZ5NhWhQ06+rWTed8tnEpw82k6t9komdEqqBhEbrBUyjdkkyn/Z+0U5IHevcaeeMzAow7OLlDOgCsQLEHDdNxfpuAMHgz+lbuyYcON+FqJw==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:36:50.0074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b3ec83-6ae6-49c4-2aec-08dd66e2b885
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4110
X-OriginatorOrg: ddn.com
X-BESS-ID: 1742393322-111917-7599-3899-1
X-BESS-VER: 2019.1_20250317.2316
X-BESS-Apparent-Source-IP: 104.47.55.49
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhYWRkBGBlAszdggNc3QNDkpLT
	EpyTTVxDwtNTnNIs3AMC0RKG5goFQbCwD/fiYnQAAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263268 [from 
	cloudscan11-53.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

The issue was actually found by Joanne
https://lore.kernel.org/all/CAJnrk1ZgHNb78dz-yfNTpxmW7wtT88A=m-zF0ZoLXKLUHRjNTw@mail.gmail.com/

I had tried to test it by by writing from many processes at the same
time, but all my attempts to trigger an issue didn't succeed. Even
KCSAN never reported anything.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
Bernd Schubert (2):
      fuse: Clear FR_PENDING in request_wait_answer
      fuse: {io-uring} Fix a possible req cancellation race

 fs/fuse/dev.c         | 32 +++++++++++++++++++++++---------
 fs/fuse/dev_uring.c   | 17 +++++++++++++----
 fs/fuse/dev_uring_i.h | 10 ++++++++++
 fs/fuse/fuse_i.h      |  2 ++
 4 files changed, 48 insertions(+), 13 deletions(-)
---
base-commit: 81e4f8d68c66da301bb881862735bd74c6241a19
change-id: 20250218-fr_pending-race-3e362f22f319

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


