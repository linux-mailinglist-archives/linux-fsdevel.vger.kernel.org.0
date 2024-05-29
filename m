Return-Path: <linux-fsdevel+bounces-20460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B93D8D3DD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 20:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C4728232F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 18:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5C31A38C5;
	Wed, 29 May 2024 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="R/XxNEC0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4C3FC18
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717005671; cv=fail; b=gxlJFAe3ZNvpsTKj4WALN3Fw4TRy8amNwVY3vdb6oTSSXUdOrIqyav0MvKqXXyPoJt0+5+38Dz95uwU3iUNP2vdcSMaM4ZPgVsEwBE3mZeJdOaMMcfhfwBwpXJYyOOdj9oklytRVXlgUUS+O9BsA8VLbB/TP2677APlBohksAZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717005671; c=relaxed/simple;
	bh=C1p2PtJLJE1c+rZEkuPKHJCB+Zf7TFnOk5YPoSiXGLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=QFCxqNsBgVlFYQOM9Fm4OZ8nfMZwHZZ4Cf46mTStxhtvMoDZD+8htruw2xxqDLGq7siQ0B8uTrqlJaNCSRmbzLaCrV4kqeJIkNIi9ie7RU4JVSJZCViaz7Hht3BWGYM1nc3uOQFZsTUx/XtCCoHULPwW+/sB2PGte1slo9yfkQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=R/XxNEC0; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168]) by mx-outbound10-102.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 May 2024 18:01:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1qy6YqpuCRisnMwyiRtNfiBiUuwPloNS09IlyppHLL+F6UuuFeptPlTa/ERvGUhqVbEohRmJn93050GSaPnbNixoaAzvWMep8/2cr+h3knZplAhWZoa30KD3Ceqd/JnXP59Ti7V0m33yK/OGszO5Uq86/wgt6uVLA/W3aPQBbJ2aghLH0/N+s0jAyqjmNatFXfRo0RGj7sMEE2k2VII8/7oyOPcr/KcHGu5SoMNNJSUgRhJqR4vEJEAuH+yvbkMc6ZPXhCYcr3H8AJGe1EUhs2kFRhOCvmoGWJLcwWzE2qZDIYHSJf3B8RZCn06U0xhY9OLDyKsjfFBBTH963aEhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d58Fb7eWCfXXD2AjOmf7GeNgOnaeXX7gLzBgZxJ2iKU=;
 b=O3aTmpxnmVknaBilCeNWI7J4u8cr3wigVmWjpNJnvDB/qeY1v+BIT0/5WuqcY08rdD3lvT67gb++s/EuKJbQz/VChYPLAskYTh2N1BVX6Dh28dviV7ZvpwBAcDDipPz6cvbkB8BRR9kHo4yJLNTV561R66WK/qtOIbvZPraqUPjVXrFFnatZtgi2P1rWYvT1Z3OfERaxU6ve+AKRygT8yTUSbGcUfqYYvw0V9xz4qzY+botA2g43aqvbWI1/Vrq10ps/w7E0UPL7Z/aGSTTVwvHLDfyTmcbXC5ITRm0jKzJkWsk7vgi4bUuBBynaIDHefiSKjjRg/Ocx+HdAfZG6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d58Fb7eWCfXXD2AjOmf7GeNgOnaeXX7gLzBgZxJ2iKU=;
 b=R/XxNEC03E2H534ofm06LvTrYtOnnQTZPlWSgMmsR2pR3jPcR+55rERKCEctQA7PeQj5C2eWJidDJ0bDfHOXzwxzzGAHL8ypAt0UIhNFJ7Rao4AfxnNXXREEX9tq04X01jKprghmk3s6moijSfOss9AoimQ8IBMuvS/j05YFjls=
Received: from BN9PR03CA0663.namprd03.prod.outlook.com (2603:10b6:408:10e::8)
 by CY8PR19MB7084.namprd19.prod.outlook.com (2603:10b6:930:54::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 18:01:00 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::9d) by BN9PR03CA0663.outlook.office365.com
 (2603:10b6:408:10e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Wed, 29 May 2024 18:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 18:00:59 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 04E7E25;
	Wed, 29 May 2024 18:00:58 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 29 May 2024 20:00:45 +0200
Subject: [PATCH RFC v2 10/19] fuse: {uring} Handle SQEs - register commands
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-fuse-uring-for-6-9-rfc2-out-v1-10-d149476b1d65@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
 bernd.schubert@fastmail.fm
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717005648; l=10938;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=C1p2PtJLJE1c+rZEkuPKHJCB+Zf7TFnOk5YPoSiXGLk=;
 b=jnZ18oUVfocVPjF2zKJ8qvxeTNoz52gMrySqj5BkrSr6IYJKfrXumKMZtQJsPPfwoEcCsbX9r
 PHNvCoWcZmYCgCNUD7ExlyacgVeH15AsJVfdwDKBdsTApEBfjagSL2G
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|CY8PR19MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: 70772f62-19c7-446d-5ad7-08dc80094c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzdiNVFDSE5ER3ovN0ZtWXRNZjdIRElvYnpwVk04Sm4rWTVtMGpkR01LOFMv?=
 =?utf-8?B?V2lkekt2MHRrZGxKWTJnRjRDK2ZkL3cvOW5PdjZuRzNuajh4ZklKSXZqTGpR?=
 =?utf-8?B?SC9ZNjdZVVJwWmF0bk96dFhNZndTbnZ4Mm5iaWttbkIxUUdQWlRCbmRoNWFI?=
 =?utf-8?B?ZTdUdi9KencyZ3FvVDNsSFBFakRSbkRPQjhzY2FhRGQwNzhRWTRVM0g0OVJt?=
 =?utf-8?B?aFlTUGVEZ3RLNWg0aDE3YThzNHpNRjA0VGZtVjNnQjFFN0hiYWZsYzYxZVpM?=
 =?utf-8?B?ZE02MU1HZzZXOVpUdnpWaFpneE4zcjdhUS82L3U0MjNzRGd6VkI1VjU1SVgy?=
 =?utf-8?B?ZVFzRDgveDZWQzNlME4yYXNVd3FldG02MExaT1EwTllCWGFTUnNZRkNoQjNJ?=
 =?utf-8?B?QXdLa1JUd0ZaTHA4WHdIdlUzQkhjcHZNa3c5cGkrdjdYbjNTZDhsQk1NRlJu?=
 =?utf-8?B?NzA1ZzRmYnlIZkJLZ1FwSkhURUJyYU1Xb2lzdFR4bjNkb2NWd1NqQkFRZngr?=
 =?utf-8?B?ZkNvWHlLL2VpZEVoc2VIcyt3TFRlc0dqQ2pKUzUxWWhNL2dmVFc1cGF1V2Zq?=
 =?utf-8?B?OHE2YWdTS1h1R1dnbGtLenM2NVQxdUZnWE41V1I0TCtFV2lTVDVYWFJXT05a?=
 =?utf-8?B?dFhZTVRjeCthMVk2ZDRydUNJL3F3a1VOMVdFUVZwNG40ZDN4WXlIMUhUMUNG?=
 =?utf-8?B?ZDJhVGI5ZFhFMythRUNTLzQxaWdSY3BpaGV4bUxyLzlFWVZvMGpRV1ZLcVJD?=
 =?utf-8?B?bCtRNUJWeHhOdWhvOE8wZTZvellzVmV2WFpGK3I5TlhCZmpmSHJZYy9iNTls?=
 =?utf-8?B?eHg4di9jbml5b0lzMy9pZy8ybkNjK3o4T3V5aFZneGF5cFVERkFzNkdLZ1cy?=
 =?utf-8?B?aXo5YmNFU2F5Ylp5dy9EN1V1OStLZGhFRGVNeVNUd2xFRWNrekorSUF6Vk9q?=
 =?utf-8?B?dkptUHpJRG51VGdzVW1NOVhhdUszUG5DZVdxTi9IeU11RW5ZbXE3WmdHdXFF?=
 =?utf-8?B?bDd4NSt5SEI2Vis5bS9TeUhNTEh4NlpZT3N1bGorek9LalQ5VnJmbWJ6Q1pt?=
 =?utf-8?B?dEF5eDA5UEJUVlNjTkszZEpiTmg2YW5tdlArdlJCNGdvZWZhZGtudmludTZv?=
 =?utf-8?B?Q2NESVRybm5iOEdobjVZWmRrcEZvYVRXaWxLTGV2ck9DQlhCNXlUVjdCMDF1?=
 =?utf-8?B?dFlnZENmZEt2UmFRT0ZEczVSemJvV3RjV1U1WklHNVBzS2pBN2RzMG45cjhx?=
 =?utf-8?B?ZjRlS1BEdkJWcG1KcTJTSS8wc21aSXB3bXpLR1RQYnJ5TGt0bDRETVErZXBq?=
 =?utf-8?B?Sk81TkxFZnZ1cE5BQU14U3ZjSUovQ2NiV29VVTNNNW5HQ3lzam5ZSjkyL2ND?=
 =?utf-8?B?aklqRU00dTgydWtieGk3L2F0aEIyZnA0WU4xQkdWTUtUWndTaDNQdlFraVli?=
 =?utf-8?B?cDByS1lqVktnNTNGZnEwU2JFNzBwN3NKS2t6YUdSNVljV0xCZE82d3FPT0lk?=
 =?utf-8?B?Rlk0NzNQMkhXRmt0R09kdVcrYUIzY0dxUVU0Ty9JN0QvRG9DSS9odUFvNGw4?=
 =?utf-8?B?aDZsRkdIdHBtZWY3Ty9meUhDR2VYZ0dTVVBVcWpxRE5rcWxSWDRGVm9JVTgx?=
 =?utf-8?B?M2RKWHY0aGJxTTg2SWlqcEp2T2YrdGpjWlNTd3FWWnhqWlh0cUl6QlFjODNF?=
 =?utf-8?B?SVR2YzZZVmIxajl4V0hOY3M3K2k5RDN2QnhVbUxCeDQ0Q3QxQjlDblZrYmpE?=
 =?utf-8?B?cGJ4eHJsZkhXbnRoRGlMZmFTL3Q4SGhZSnNUaGJ4NDFsN0tPbTNLS3laZDVM?=
 =?utf-8?B?ZDhIRXV2ZFl4VWJ2OEd0dFB6Z1NuK1ZLcUhvNWFaamI2aXA3TGl3QXpiZlFk?=
 =?utf-8?Q?1dy1xj1+awq+U?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iQZkm4UMGJ5K2yCP1OMpWFCgHVkVDAMaAtVhE3OQrQbXMCZ8LwiqwklHW5G9Vdt/ObTRzZgY9aLeY/bwDSPPfC98Urq1PvLuH7NUPyzaKVLBKehu63WNEvAIT0QCXoILM8+YXguZxLUqZQYktYAZN9roZnttDL+BdkTLKrntVYlJI6cABFs1AoB9FDerycRkEezOVMznCegne6LeV6TTya5Aqzkuh4o3i//e5DQEP6ZA97eW8IFF5kQdtU0SmBwyLJUeyAQ7zjakzeYQ03O08Q9LnRHaGCRr7MwgUtFjuiHKWd2gz6d5AJoiC6rwEV7aHjhbAC3bdzf/XNLJi1nxtdEkxVU/qRzSzvyd48m4IsdLbOGQhZf/9Z8H/wQNIHQOylhW1bd0nVDqzHoL7wjUfZUEXh/CBt1NRVFvHdwg8z/cLCJoKwV4tNZagCGZU+asaH9pUxr5CBH4fmW3jlZD8kpVepymy4TQ+/H1soQRg+7WTWTWAqmVoUeY4x9E8rH7YqPJKwZ3thGmCyQ25GC4oak1bRQo58dWkPwemb91DB8E00fl3vbjghP8+UhLEUlkfkwx6UGU2m8bBJAh6HaVClVqS3lA5S9iPZNk8ueZDM1OEndR5zsi7X0RZCLOVK+T2IZO1MjAYL6uG9HMtz8ejw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:00:59.8848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70772f62-19c7-446d-5ad7-08dc80094c26
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7084
X-BESS-ID: 1717005663-102662-12708-16973-1
X-BESS-VER: 2019.1_20240429.2309
X-BESS-Apparent-Source-IP: 104.47.56.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGpiamQGYGUDTJwCgpKc3cxD
	LZ0tLQItnIwsjSINHAyDgpOcXAzDQ1Tak2FgBvodBkQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256584 [from 
	cloudscan20-244.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This adds basic support for ring SQEs (with opcode=IORING_OP_URING_CMD).
For now only FUSE_URING_REQ_FETCH is handled to register queue entries.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c             |   1 +
 fs/fuse/dev_uring.c       | 267 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev_uring_i.h     |  12 +++
 include/uapi/linux/fuse.h |  33 ++++++
 4 files changed, 313 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index cd5dc6ae9272..05a87731b5c3 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2510,6 +2510,7 @@ const struct file_operations fuse_dev_operations = {
 	.compat_ioctl   = compat_ptr_ioctl,
 #if IS_ENABLED(CONFIG_FUSE_IO_URING)
 	.mmap		= fuse_uring_mmap,
+	.uring_cmd	= fuse_uring_cmd,
 #endif
 };
 EXPORT_SYMBOL_GPL(fuse_dev_operations);
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 2c0ccb378908..48b1118b64f4 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -31,6 +31,27 @@
 #include <linux/topology.h>
 #include <linux/io_uring/cmd.h>
 
+static void fuse_ring_ring_ent_unset_userspace(struct fuse_ring_ent *ent)
+{
+	clear_bit(FRRS_USERSPACE, &ent->state);
+	list_del_init(&ent->list);
+}
+
+/* Update conn limits according to ring values */
+static void fuse_uring_conn_cfg_limits(struct fuse_ring *ring)
+{
+	struct fuse_conn *fc = ring->fc;
+
+	WRITE_ONCE(fc->max_pages, min_t(unsigned int, fc->max_pages,
+					ring->req_arg_len / PAGE_SIZE));
+
+	/* This not ideal, as multiplication with nr_queue assumes the limit
+	 * gets reached when all queues are used, but a single threaded
+	 * application might already do that.
+	 */
+	WRITE_ONCE(fc->max_background, ring->nr_queues * ring->max_nr_async);
+}
+
 /*
  * Basic ring setup for this connection based on the provided configuration
  */
@@ -329,3 +350,249 @@ int fuse_uring_queue_cfg(struct fuse_ring *ring,
 	return 0;
 }
 
+/*
+ * Put a ring request onto hold, it is no longer used for now.
+ */
+static void fuse_uring_ent_avail(struct fuse_ring_ent *ring_ent,
+				 struct fuse_ring_queue *queue)
+	__must_hold(&queue->lock)
+{
+	struct fuse_ring *ring = queue->ring;
+
+	/* unsets all previous flags - basically resets */
+	pr_devel("%s ring=%p qid=%d tag=%d state=%lu async=%d\n", __func__,
+		 ring, ring_ent->queue->qid, ring_ent->tag, ring_ent->state,
+		 ring_ent->async);
+
+	if (WARN_ON(test_bit(FRRS_USERSPACE, &ring_ent->state))) {
+		pr_warn("%s qid=%d tag=%d state=%lu async=%d\n", __func__,
+			ring_ent->queue->qid, ring_ent->tag, ring_ent->state,
+			ring_ent->async);
+		return;
+	}
+
+	WARN_ON_ONCE(!list_empty(&ring_ent->list));
+
+	if (ring_ent->async)
+		list_add(&ring_ent->list, &queue->async_ent_avail_queue);
+	else
+		list_add(&ring_ent->list, &queue->sync_ent_avail_queue);
+
+	set_bit(FRRS_WAIT, &ring_ent->state);
+}
+
+/*
+ * fuse_uring_req_fetch command handling
+ */
+static int fuse_uring_fetch(struct fuse_ring_ent *ring_ent,
+			    struct io_uring_cmd *cmd, unsigned int issue_flags)
+__must_hold(ring_ent->queue->lock)
+{
+	struct fuse_ring_queue *queue = ring_ent->queue;
+	struct fuse_ring *ring = queue->ring;
+	int ret = 0;
+	int nr_ring_sqe;
+
+	/* register requests for foreground requests first, then backgrounds */
+	if (queue->nr_req_sync >= ring->max_nr_sync) {
+		queue->nr_req_async++;
+		ring_ent->async = 1;
+	} else
+		queue->nr_req_sync++;
+
+	fuse_uring_ent_avail(ring_ent, queue);
+
+	if (queue->nr_req_sync + queue->nr_req_async > ring->queue_depth) {
+		/* should be caught by ring state before and queue depth
+		 * check before
+		 */
+		WARN_ON(1);
+		pr_info("qid=%d tag=%d req cnt (fg=%d async=%d exceeds depth=%zu",
+			queue->qid, ring_ent->tag, queue->nr_req_sync,
+			queue->nr_req_async, ring->queue_depth);
+		ret = -ERANGE;
+	}
+
+	if (ret)
+		goto out; /* erange */
+
+	WRITE_ONCE(ring_ent->cmd, cmd);
+
+	nr_ring_sqe = ring->queue_depth * ring->nr_queues;
+	if (atomic_inc_return(&ring->nr_sqe_init) == nr_ring_sqe) {
+		fuse_uring_conn_cfg_limits(ring);
+		ring->ready = 1;
+	}
+
+out:
+	return ret;
+}
+
+static struct fuse_ring_queue *
+fuse_uring_get_verify_queue(struct fuse_ring *ring,
+			    const struct fuse_uring_cmd_req *cmd_req,
+			    unsigned int issue_flags)
+{
+	struct fuse_conn *fc = ring->fc;
+	struct fuse_ring_queue *queue;
+	int ret;
+
+	if (!(issue_flags & IO_URING_F_SQE128)) {
+		pr_info("qid=%d tag=%d SQE128 not set\n", cmd_req->qid,
+			cmd_req->tag);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (unlikely(!fc->connected)) {
+		ret = -ENOTCONN;
+		goto err;
+	}
+
+	if (unlikely(!ring->configured)) {
+		pr_info("command for a connection that is not ring configured\n");
+		ret = -ENODEV;
+		goto err;
+	}
+
+	if (unlikely(cmd_req->qid >= ring->nr_queues)) {
+		pr_devel("qid=%u >= nr-queues=%zu\n", cmd_req->qid,
+			 ring->nr_queues);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	queue = fuse_uring_get_queue(ring, cmd_req->qid);
+	if (unlikely(queue == NULL)) {
+		pr_info("Got NULL queue for qid=%d\n", cmd_req->qid);
+		ret = -EIO;
+		goto err;
+	}
+
+	if (unlikely(!queue->configured || queue->stopped)) {
+		pr_info("Ring or queue (qid=%u) not ready.\n", cmd_req->qid);
+		ret = -ENOTCONN;
+		goto err;
+	}
+
+	if (cmd_req->tag > ring->queue_depth) {
+		pr_info("tag=%u > queue-depth=%zu\n", cmd_req->tag,
+			ring->queue_depth);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	return queue;
+
+err:
+	return ERR_PTR(ret);
+}
+
+/**
+ * Entry function from io_uring to handle the given passthrough command
+ * (op cocde IORING_OP_URING_CMD)
+ */
+int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
+{
+	const struct fuse_uring_cmd_req *cmd_req = io_uring_sqe_cmd(cmd->sqe);
+	struct fuse_dev *fud = fuse_get_dev(cmd->file);
+	struct fuse_conn *fc = fud->fc;
+	struct fuse_ring *ring = fc->ring;
+	struct fuse_ring_queue *queue;
+	struct fuse_ring_ent *ring_ent = NULL;
+	u32 cmd_op = cmd->cmd_op;
+	int ret = 0;
+
+	if (!ring) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	queue = fuse_uring_get_verify_queue(ring, cmd_req, issue_flags);
+	if (IS_ERR(queue)) {
+		ret = PTR_ERR(queue);
+		goto out;
+	}
+
+	ring_ent = &queue->ring_ent[cmd_req->tag];
+
+	pr_devel("%s:%d received: cmd op %d qid %d (%p) tag %d  (%p)\n",
+		 __func__, __LINE__, cmd_op, cmd_req->qid, queue, cmd_req->tag,
+		 ring_ent);
+
+	spin_lock(&queue->lock);
+	if (unlikely(queue->stopped)) {
+		/* XXX how to ensure queue still exists? Add
+		 * an rw ring->stop lock? And take that at the beginning
+		 * of this function? Better would be to advise uring
+		 * not to call this function at all? Or free the queue memory
+		 * only, on daemon PF_EXITING?
+		 */
+		ret = -ENOTCONN;
+		goto err_unlock;
+	}
+
+	if (current == queue->server_task)
+		queue->uring_cmd_issue_flags = issue_flags;
+
+	switch (cmd_op) {
+	case FUSE_URING_REQ_FETCH:
+		if (queue->server_task == NULL) {
+			queue->server_task = current;
+			queue->uring_cmd_issue_flags = issue_flags;
+		}
+
+		/* No other bit must be set here */
+		if (ring_ent->state != BIT(FRRS_INIT)) {
+			pr_info_ratelimited(
+				"qid=%d tag=%d register req state %lu expected %lu",
+				cmd_req->qid, cmd_req->tag, ring_ent->state,
+				BIT(FRRS_INIT));
+			ret = -EINVAL;
+			goto err_unlock;
+		}
+
+		fuse_ring_ring_ent_unset_userspace(ring_ent);
+
+		ret = fuse_uring_fetch(ring_ent, cmd, issue_flags);
+		if (ret)
+			goto err_unlock;
+
+		/*
+		 * The ring entry is registered now and needs to be handled
+		 * for shutdown.
+		 */
+		atomic_inc(&ring->queue_refs);
+
+		spin_unlock(&queue->lock);
+		break;
+	default:
+		ret = -EINVAL;
+		pr_devel("Unknown uring command %d", cmd_op);
+		goto err_unlock;
+	}
+out:
+	pr_devel("uring cmd op=%d, qid=%d tag=%d ret=%d\n", cmd_op,
+		 cmd_req->qid, cmd_req->tag, ret);
+
+	if (ret < 0) {
+		if (ring_ent != NULL) {
+			pr_info_ratelimited("error: uring cmd op=%d, qid=%d tag=%d ret=%d\n",
+					    cmd_op, cmd_req->qid, cmd_req->tag,
+					    ret);
+
+			/* must not change the entry state, as userspace
+			 * might have sent random data, but valid requests
+			 * might be registered already - don't confuse those.
+			 */
+		}
+		io_uring_cmd_done(cmd, ret, 0, issue_flags);
+	}
+
+	return -EIOCBQUEUED;
+
+err_unlock:
+	spin_unlock(&queue->lock);
+	goto out;
+}
+
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 114e9c008013..b2be67bb2fa7 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -203,6 +203,7 @@ int fuse_uring_mmap(struct file *filp, struct vm_area_struct *vma);
 int fuse_uring_queue_cfg(struct fuse_ring *ring,
 			 struct fuse_ring_queue_config *qcfg);
 void fuse_uring_ring_destruct(struct fuse_ring *ring);
+int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
 
 static inline void fuse_uring_conn_init(struct fuse_ring *ring,
 					struct fuse_conn *fc)
@@ -269,6 +270,11 @@ static inline bool fuse_uring_configured(struct fuse_conn *fc)
 	return false;
 }
 
+static inline bool fuse_per_core_queue(struct fuse_conn *fc)
+{
+	return fc->ring && fc->ring->per_core_queue;
+}
+
 #else /* CONFIG_FUSE_IO_URING */
 
 struct fuse_ring;
@@ -287,6 +293,12 @@ static inline bool fuse_uring_configured(struct fuse_conn *fc)
 	return false;
 }
 
+static inline bool fuse_per_core_queue(struct fuse_conn *fc)
+{
+	return false;
+}
+
+
 #endif /* CONFIG_FUSE_IO_URING */
 
 #endif /* _FS_FUSE_DEV_URING_I_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 88d4078c4171..379388c964a7 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1262,6 +1262,12 @@ struct fuse_supp_groups {
 /* The offset parameter is used to identify the request type */
 #define FUSE_URING_MMAP_OFF 0xf8000000ULL
 
+/*
+ * Request is background type. Daemon side is free to use this information
+ * to handle foreground/background CQEs with different priorities.
+ */
+#define FUSE_RING_REQ_FLAG_ASYNC (1ull << 0)
+
 /**
  * This structure mapped onto the
  */
@@ -1288,4 +1294,31 @@ struct fuse_ring_req {
 	char in_out_arg[];
 };
 
+/**
+ * sqe commands to the kernel
+ */
+enum fuse_uring_cmd {
+	FUSE_URING_REQ_INVALID = 0,
+
+	/* submit sqe to kernel to get a request */
+	FUSE_URING_REQ_FETCH = 1,
+
+	/* commit result and fetch next request */
+	FUSE_URING_REQ_COMMIT_AND_FETCH = 2,
+};
+
+/**
+ * In the 80B command area of the SQE.
+ */
+struct fuse_uring_cmd_req {
+	/* queue the command is for (queue index) */
+	uint16_t qid;
+
+	/* queue entry (array index) */
+	uint16_t tag;
+
+	/* pointer to struct fuse_uring_buf_req */
+	uint32_t flags;
+};
+
 #endif /* _LINUX_FUSE_H */

-- 
2.40.1


