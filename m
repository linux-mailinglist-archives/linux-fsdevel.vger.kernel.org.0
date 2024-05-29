Return-Path: <linux-fsdevel+bounces-20469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDD58D3E66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 20:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDD32893E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 18:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643BF1A38F4;
	Wed, 29 May 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="M04LijKX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4580C15CD55
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007643; cv=fail; b=dTQjCBVWzRGG1jiWjpZ2y5AiKcaLwi8KijjhTeB+xKrsjh2F8XU0gMiK/tSjBlXM+kWP/4mcVBGMn/VnwRPCd5GKNChhFnGbbingZmOsjrMb1pL7uga3dkVf5MsFaKmtHOWU9F0lxoodWEvVkNTk1uW08tsUIj0en92PDh88A7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007643; c=relaxed/simple;
	bh=6Xg0iKKnVzbp5OdLGjtMLFQQe/7/r0SaUxJHcWiqYN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=OLKIJX4m9fHvf5J4jSigPBCacCbOGqghgHW57KY0deVefLlUDSa2opWGwSuiM6fUFTXlYXRWkS6pothA8IAJXXF83A/Zf3jEQBchubrTM/aJRWWznq6PJppNbKrDg9CdE2UqPh8x2m2PGk1zUlPH2m0x2iPQQYzF/wbFqw7XVaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=M04LijKX; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168]) by mx-outbound19-65.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 May 2024 18:34:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cgwy7otzh6R2NUcGQUdptef7oTu1EjUse3iqd11YzoTGhLqwPlHpP8dcLA9tOz1nkMEN0mtYlfA6JDCcBTD09iSc//0SiTma8DwemyW/VdDB2hoNhtoiVErF58Tl68SQosVvxu+CUTJRvhVG3X9w3fN03qXrO2g6qiN9Xk9rG4H7whSjij8FoCKbhri6wLsBGAHl9C2QDXyGiJAuXeGCiN7QghbE9PMomANvkqronLg1VDSFWlVIIVb4p+1lrjLuzxKKVkSaq3mhJRBDMBpTopY8MewHnSdFbWz40Qkw9R7/Pmdz5dwBTBjJKw/Wkj5bAW71C2rgYyL2emW096rpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BG640MqD/Os/tHDKOApjDxHCLIyhhaZPAgmuiLKGdsg=;
 b=C416VSR1rJK3a2BTWhL+oIza3nBn7XT59QHL85DS8dFPAjSrP0Zw3FFc1UfEmlS2anCCKJ2mMTbV4UW5xgm5MK8noS+W53Da5ElxOsc/h5AhikOAJ+FcS8AYHwqML7l7P8F+P6VPCz2ShwqUfbatWrUTYC2GdqKiPlBat/jx1muw/QxpDg+ZKjTvXhsFQdoBmsUtQhNon4QnnIdkUP4qRCeez56PFHfNAjbRxXwpPPzbt8aCkplrn2rMC8xv92rw9iNh/1wyrl5DX4uRg/g1hn7lC6IGL16l5VQdfGN4BFroo03xQIuJze07W5dtjB2/FaY+lA/25zrjr6BWI6n9dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG640MqD/Os/tHDKOApjDxHCLIyhhaZPAgmuiLKGdsg=;
 b=M04LijKXtVREeODP8XgZmfener6imOkJsmF1BqmoG+gCGPrTfQnHbWzAbHW0SAdv1FgcUBa4bog5bVP1LIreqhVV/nJl24DqGcmb5J2HvXSjWDERiDekqMXvnG9NjbUlPhB2HvN5lcDhpuP4Zo7PuQPGua7cqEtlPPPlD9u1CYs=
Received: from BL0PR1501CA0012.namprd15.prod.outlook.com
 (2603:10b6:207:17::25) by MN6PR19MB7889.namprd19.prod.outlook.com
 (2603:10b6:208:47a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 18:01:01 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::9f) by BL0PR1501CA0012.outlook.office365.com
 (2603:10b6:207:17::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 18:01:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 18:01:00 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id F178727;
	Wed, 29 May 2024 18:00:59 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 29 May 2024 20:00:46 +0200
Subject: [PATCH RFC v2 11/19] fuse: Add support to copy from/to the ring
 buffer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-fuse-uring-for-6-9-rfc2-out-v1-11-d149476b1d65@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
 bernd.schubert@fastmail.fm
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717005648; l=5641;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=6Xg0iKKnVzbp5OdLGjtMLFQQe/7/r0SaUxJHcWiqYN8=;
 b=jHb2eDZCHYFD+W4vYqtAB7IqDYKSS9JmPo8tKdx6ZfkxS/z/5WaiOtvMLYKSgVH9Ds3p10qqF
 47KBs6TM4flAtuIej5e3DA0u9Qlxf9K48EGLPYnx4YKzE5MknYg8pHC
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|MN6PR19MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 0649a581-73e0-4536-f077-08dc80094cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckxvWWRCcXZXd05sc0pURUxwQVJ3TE8rUEhOa2ZWMVdNdnB0YVZ3UFlRMjhr?=
 =?utf-8?B?YW5uajF1djQrZXNXZ1hiOG9FOS92aXdmMzJ6T2l4WFJtaWkzZnRTT1E4Nk1T?=
 =?utf-8?B?aUZRWEVsNkJ1YVZFcXRwekVpWU9Jb3FhdE9QS1FuTXVtV3plMjdaZjc0c2JB?=
 =?utf-8?B?T2h5VStiQ2tEMkVXdG1xYnZvanFaMnROdUM5NW5wY0gxSGZXZUw2bStiaGlW?=
 =?utf-8?B?TG9xS21wSTUxM00vYzR6NytMSU5qcUpKS2dOWE9oSTZWdTN0aDNwdGFUTjN2?=
 =?utf-8?B?SVVCZjBMNng3RjZoWmZmdXZkTS9adjFzaW5BL01CWlBmRkpoeHRNdytyaGRr?=
 =?utf-8?B?N1gvbHFsNTIvWWpFa0JqQzdoa1Z3aU1SbTZuU2VLZzA5aG9WUnRvREhUNHJL?=
 =?utf-8?B?YmJoM1ZqYzhqVFFWcUs2cDVjVjhJU2ZOa01kM2VtQTRodXptREY1R2pubHAv?=
 =?utf-8?B?M0lnN2wvNVE5a1RMQlJVMWttcDBvOHZETWQ1eW1TOHFPb2ZFZUlyMXpGREVm?=
 =?utf-8?B?NnNFajJaNnRmVVdOYzdLZ0FpUEhFZmFlRDNVUk1yWDdROEZGNVV1VXlQOG9M?=
 =?utf-8?B?RmhxaHVRZDJUZHQ5THJHbjRqWUo5dk5STm1pOE9NWUdsVGIrTm45UzgrZW1z?=
 =?utf-8?B?YzU1ZHE1TFVOZ1dUaU9Jb2dUZ3ZHSWYwdzBNY1NGTmFBUTVicThUZEdwQUZ3?=
 =?utf-8?B?UEV6enVSb2ZWb3NOOUZEWmFpSXFJVjhTTDhKYUtYZ1Vkb1JnWGgzWFJjYWVT?=
 =?utf-8?B?STlTN2FlNWYyV0IyY0FYQkV1S2MySGd1a0tDNThQUExlMk5qVEdYRjdLRzll?=
 =?utf-8?B?REgzNDRLRzF3V3VsbzBBMERZcXZpNnUyTkUvYjkvemRQYU84Um80ME9PcGFX?=
 =?utf-8?B?RGVRTnZEQWFNTi9QYU4vRkpscnBPWitySGtxNWhWRUoxc2FzK1djM0x3VXRV?=
 =?utf-8?B?QTRGcWNsaURXeHRkYkF0YndNZ3VMa1ZHZE5kWlI1YVpxTUxhanp6dGJMZlRH?=
 =?utf-8?B?OEp5ekVTSkV1V1M4bXluQlhBcFU1c3RwZjdwV3hKTkFkUkRNZ2ltMEY1Rkgz?=
 =?utf-8?B?N1JsdjFPUUlCUkhXQW1JYkQrZEY3ZlM5R0VFYm1jNXIrZmJxOCtMam1ZdG1p?=
 =?utf-8?B?OEVKNm5QOTl4YW5lbEFTR3Brc1k4ekdKN2greW9QcHpMRXBVSm54R3VJa3Jn?=
 =?utf-8?B?NDBKOHF5dEFKSkY5TS94VHFUdTgvRGNsMmErV1JIaFNJRk9SMUpJM1NqUk9W?=
 =?utf-8?B?ejErV0xGbFhvSTJYdEZYVnlwZUZuYVl4RlhLSnlwdzhJYVJzbUJrWHpkNXdS?=
 =?utf-8?B?dk9DQVljek8wcVR0RmN5MEpDN3lEMFBFUkwrOXVhYWs0V0FyNEFDR1dhc0U3?=
 =?utf-8?B?ZlY1R05zVzlGM3lXcVk2NFBJM3RDaGZBd2hJZG00eEx6aVZxL3BLQ3lqR1BS?=
 =?utf-8?B?SnRIM0xkU0xJdFBTUmZZb2thbnZ1aTRVaXFYNEFKa29yK1E2WkNLZHBoN3lq?=
 =?utf-8?B?emJaZ2Rpd2FlRWxOWjV0M204RXMrZHJ1NFhXN2tPYTRyNjloMy8rZm1UWmFE?=
 =?utf-8?B?amVZb2h3WGk3QXJZb3IzVGVOUTRJWDZnejNMMUY3dEdHRG1Oci9haWpQVnc0?=
 =?utf-8?B?N21nVWt3SnBxNkhNWmVreGpvQlI1WmpmNERBaXlJeDd2MjJnVm5FbGZXVDBa?=
 =?utf-8?B?cVVWTlZHbzBuVXFkbGZVUmZ6OVFzUDhQelBNVTlRMWs2b2ZlSzNYZE1BSWNm?=
 =?utf-8?B?eGNRdEpRMWVxamVNYVRFaWNwTDA2VG11a25sMlB3TjBRU2l2NDE0dGo3Y2xV?=
 =?utf-8?B?WjBOWmRmUUxucXp6S3J1WFNoNzk1T1dqVHQ1TFlkUUsrRnhDOUsrSGoyQTI5?=
 =?utf-8?Q?yxb7d+dOw2m+h?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L/lNAE0VhxDPxbtAOTQiuBaHdD9LKNWNP3Tp8nFNYDibj4BzCCPXOjTkf2z7K8LBlYm+4YnuxL38wli8Gtpa7EleoiC5o+rAG7YBBLgpVC+YtmKZiozjjm/q0W6mbpTO7aiRHNUmqMJyM+6khwcvTuLuZ4XJWKRQ5snV2vkOETVBHB6PO3p4N/nlwraGEBaKHiHlC8XQMcP5v7mN2ddufKdLNnX+jwaQ9d1FENvJxaPG0niX7RJoS9WCthohpk6qLkn0DxI5n4oTbBBCgX9WSOFiQVHDaT/dX9oKSJcfdu2MnfcKt+t9wM9SRGJPTUZYp9e4IEIvxmIyNwWDE8FWXKxsv87HOZMBKDANRLZrvLSBon0nWdnqNgHBgLapDuJs8K8BhVmrdCyZ9RmveJXRh/wEVtvdhFdJuQD3vBpIP/A86BKz2sFYK6d6lk5bDNYxJ1h0ZaiFkYX8adKV1THjuy/cbS5n9vH1jjyCpW0aEukRz+El0G9UhVaRzm5mqboQTFgS51nwHqbci9Ppn+l9S5GtEYKBE6XYNQQGFx/IN7b6/PnL16fMudAOwbRKzB5W6G/rHqINrwSL7BqQiusTW43rlt4NVN72l3GO1t10cjXhcEYkH0Q+gOqFF4YQcvUHuVt9xpFEiopBK9xRKimxSA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:01:00.9659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0649a581-73e0-4536-f077-08dc80094cc8
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR19MB7889
X-OriginatorOrg: ddn.com
X-BESS-ID: 1717007640-104929-12620-55610-1
X-BESS-VER: 2019.1_20240429.2309
X-BESS-Apparent-Source-IP: 104.47.55.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqYmJqZAVgZQMC01zcTELM3QKM
	k0xdzM3CjV0tLS3NwwJc3YPM3U0iBZqTYWAPAlOPhBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256584 [from 
	cloudscan17-187.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This adds support to existing fuse copy code to copy
from/to the ring buffer. The ring buffer is here mmaped
shared between kernel and userspace.

This also fuse_ prefixes the copy_out_args function

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c        | 60 ++++++++++++++++++++++++++++++----------------------
 fs/fuse/fuse_dev_i.h | 38 +++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 25 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 05a87731b5c3..a7d26440de39 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -637,21 +637,7 @@ static int unlock_request(struct fuse_req *req)
 	return err;
 }
 
-struct fuse_copy_state {
-	int write;
-	struct fuse_req *req;
-	struct iov_iter *iter;
-	struct pipe_buffer *pipebufs;
-	struct pipe_buffer *currbuf;
-	struct pipe_inode_info *pipe;
-	unsigned long nr_segs;
-	struct page *pg;
-	unsigned len;
-	unsigned offset;
-	unsigned move_pages:1;
-};
-
-static void fuse_copy_init(struct fuse_copy_state *cs, int write,
+void fuse_copy_init(struct fuse_copy_state *cs, int write,
 			   struct iov_iter *iter)
 {
 	memset(cs, 0, sizeof(*cs));
@@ -662,6 +648,7 @@ static void fuse_copy_init(struct fuse_copy_state *cs, int write,
 /* Unmap and put previous page of userspace buffer */
 static void fuse_copy_finish(struct fuse_copy_state *cs)
 {
+
 	if (cs->currbuf) {
 		struct pipe_buffer *buf = cs->currbuf;
 
@@ -726,6 +713,10 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 			cs->pipebufs++;
 			cs->nr_segs++;
 		}
+	} else if (cs->is_uring) {
+		if (cs->ring.offset > cs->ring.buf_sz)
+			return -ERANGE;
+		cs->len = cs->ring.buf_sz - cs->ring.offset;
 	} else {
 		size_t off;
 		err = iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1, &off);
@@ -744,21 +735,35 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
 {
 	unsigned ncpy = min(*size, cs->len);
+
 	if (val) {
-		void *pgaddr = kmap_local_page(cs->pg);
-		void *buf = pgaddr + cs->offset;
+
+		void *pgaddr = NULL;
+		void *buf;
+
+		if (cs->is_uring) {
+			buf = cs->ring.buf + cs->ring.offset;
+			cs->ring.offset += ncpy;
+
+		} else {
+			pgaddr = kmap_local_page(cs->pg);
+			buf = pgaddr + cs->offset;
+		}
 
 		if (cs->write)
 			memcpy(buf, *val, ncpy);
 		else
 			memcpy(*val, buf, ncpy);
 
-		kunmap_local(pgaddr);
+		if (pgaddr)
+			kunmap_local(pgaddr);
+
 		*val += ncpy;
 	}
 	*size -= ncpy;
 	cs->len -= ncpy;
 	cs->offset += ncpy;
+
 	return ncpy;
 }
 
@@ -1006,9 +1011,9 @@ static int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsigned size)
 }
 
 /* Copy request arguments to/from userspace buffer */
-static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
-			  unsigned argpages, struct fuse_arg *args,
-			  int zeroing)
+int fuse_copy_args(struct fuse_copy_state *cs, unsigned int numargs,
+		   unsigned int argpages, struct fuse_arg *args,
+		   int zeroing)
 {
 	int err = 0;
 	unsigned i;
@@ -1873,10 +1878,15 @@ static struct fuse_req *request_find(struct fuse_pqueue *fpq, u64 unique)
 	return NULL;
 }
 
-static int copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
-			 unsigned nbytes)
+int fuse_copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
+		       unsigned int nbytes)
 {
-	unsigned reqsize = sizeof(struct fuse_out_header);
+
+	unsigned int reqsize = 0;
+
+	/* Uring has the out header outside of args */
+	if (!cs->is_uring)
+		reqsize = sizeof(struct fuse_out_header);
 
 	reqsize += fuse_len_args(args->out_numargs, args->out_args);
 
@@ -1976,7 +1986,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	if (oh.error)
 		err = nbytes != sizeof(oh) ? -EINVAL : 0;
 	else
-		err = copy_out_args(cs, req->args, nbytes);
+		err = fuse_copy_out_args(cs, req->args, nbytes);
 	fuse_copy_finish(cs);
 
 	spin_lock(&fpq->lock);
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index e6289bafb788..f3e69ab4c2be 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -13,6 +13,36 @@
 #define FUSE_INT_REQ_BIT (1ULL << 0)
 #define FUSE_REQ_ID_STEP (1ULL << 1)
 
+struct fuse_arg;
+struct fuse_args;
+
+struct fuse_copy_state {
+	int write;
+	struct fuse_req *req;
+	struct iov_iter *iter;
+	struct pipe_buffer *pipebufs;
+	struct pipe_buffer *currbuf;
+	struct pipe_inode_info *pipe;
+	unsigned long nr_segs;
+	struct page *pg;
+	unsigned int len;
+	unsigned int offset;
+	unsigned int move_pages:1, is_uring:1;
+	struct {
+		/* pointer into the ring buffer */
+		char *buf;
+
+		/* for copy to the ring request buffer, the buffer size - must
+		 * not be exceeded, for copy from the ring request buffer,
+		 * the size filled in by user space
+		 */
+		unsigned int buf_sz;
+
+		/* offset within buf while it is copying from/to the buf */
+		unsigned int offset;
+	} ring;
+};
+
 static inline struct fuse_dev *fuse_get_dev(struct file *file)
 {
 	/*
@@ -24,6 +54,14 @@ static inline struct fuse_dev *fuse_get_dev(struct file *file)
 
 void fuse_dev_end_requests(struct list_head *head);
 
+void fuse_copy_init(struct fuse_copy_state *cs, int write,
+			   struct iov_iter *iter);
+int fuse_copy_args(struct fuse_copy_state *cs, unsigned int numargs,
+		   unsigned int argpages, struct fuse_arg *args,
+		   int zeroing);
+int fuse_copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
+		       unsigned int nbytes);
+
 #endif
 
 

-- 
2.40.1


