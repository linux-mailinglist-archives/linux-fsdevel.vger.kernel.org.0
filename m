Return-Path: <linux-fsdevel+bounces-65221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8AABFE66B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A29F1A04DD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 22:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED252BE65E;
	Wed, 22 Oct 2025 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Befk78fN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45772F6184
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761171701; cv=fail; b=FZLxKC7dEY4K/qQrvd8+WOaG0vEjKsYOq7CBCF5C8uX6fxA/gLaiLSA90QUUCozDyfFOhlNb0vLlNCPDK1JLstkols25jZla8SiB9vKAutrrXKItcsnoYc5qw+n05/8/6MO9W+EezM6rhuYCVI4MwRbeCgjdh7TY/tWP4LiIPCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761171701; c=relaxed/simple;
	bh=M1S8bDvjKRI1qIrDxo/bkLMtcwkNQ0rw6kdmEzoNJBg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OPebena4Zr4IgoGbQpDS4VZZzvqvAORPe5MY5Y5iOb1Pd5eLiOE/xyvWkh5VfF1wlqWi0t0X6d5a9PwCw87XjQaUhSVbf1wZplnLs7ctzSRhz3HQfRlKcdzFB1o6j6yxQdBrNUi4fjpy4rrXv20OyQDSrDbzJXBjr8GUvUOJRcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=Befk78fN; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020077.outbound.protection.outlook.com [52.101.56.77]) by mx-outbound44-98.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 22 Oct 2025 22:21:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyFpJOXx7Aac4cSheY2wdQIJQ2PwnC33DZaCNDGetjpA8XH6TlgqLcFtdYQO/wErJjrd0oz2vGDx+2GiOIqlOjhE8cbTOjc+57a9M4fgWOPYljgnetueGp6+vlp+ecyYKULCCJtJktJFC1PSyjy3sD7w7n5PIF7ufMuGbmN5BhJvAPyDi0XmGsTbu/9ncE49o5x8F7JbZuGjWU81UmszL9Iw7Rb3qHr53zslsdnwbQzkCmsYstFrFqf3jqOeqvwGJVSLdwHUzIxMWW8LZbmQm7Y6ZWCSmz7IfyFNy7empwsa9Ma+NPnka/9ht+pLj0hc5yLXGeXlst+Wb25c4wJ56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43zHvWpcfDI59oXjbGGr6ct6qUx3OGPkhD4ne1TXtSY=;
 b=dxEibKjWCgFU8rWM0hNIqCj5WK9rh1VW1wDJKle4GiaBbmXlR56fhAs9jNzm5EzHgH44yJvrhRL29dC6jXaA0Ko4fZNc1uBDfDTVDfRUg+jCZ94ajcg9xPz+A/bI4xslVA0XCzhVWhi3r30bWrIndmAkEWDczOCCZGe7z7R/QdOwpOgNnVvwXPpFlrhXzjFFT5BRBh1C+a2HU7v7IiKFN9aK9XGKDSJ2+SwlkOcm5WjxS10PSNmdPO3vzxDnEtlM7aL75erfasDZBZRrfFNx26+B9hFZTcQwaKVs4HjFkgbi2BZqoVRSc4YLpA9BNyE7d2mX3bnwgYix3eIyBMwjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bytedance.com smtp.mailfrom=ddn.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ddn.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43zHvWpcfDI59oXjbGGr6ct6qUx3OGPkhD4ne1TXtSY=;
 b=Befk78fNNn2FFgrmXXeVY0WBGqtALZMRNWDNOdvy4T0AvdETklbq6qH9MvaGZBqrpLY01OWki5/BI4vuDcIw+GmmBsFnmaxY6ysRSWLP7sl9GxvaJp80Z/BI2j13eekvTRu4wHr81X1PWIA7vFFnJmh75tX56H5bQIDEx3kd9Vo=
Received: from BY5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:1e0::30)
 by DM6PR19MB4344.namprd19.prod.outlook.com (2603:10b6:5:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 22 Oct
 2025 22:21:21 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::fb) by BY5PR03CA0020.outlook.office365.com
 (2603:10b6:a03:1e0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 22:21:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Wed, 22 Oct 2025 22:21:20 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id C72384C;
	Wed, 22 Oct 2025 22:21:19 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH 0/2] fuse: Avoid reading stale page cache after competing
 DIO write
Date: Thu, 23 Oct 2025 00:21:16 +0200
Message-Id: <20251023-fix-fopen-direct-io-post-invalidation-v1-0-3f93a411cd00@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANxY+WgC/x2NQQqEMAxFryJZT6CNiuBVhlkUk2pA2tKKDIh3N
 7j6vMV/74ImVaXB3F1Q5dSmORn4TwfLFtIqqGwM5Gj0jnqM+seYiyRkrbIcqBlLbrbpDLtyOMy
 AjnmiOAVPgwNzlSp2fDvf330/ibDf2HcAAAA=
X-Change-ID: 20251023-fix-fopen-direct-io-post-invalidation-0dd72f7a1240
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Hao Xu <howeyxu@tencent.com>, 
 Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761171679; l=794;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=M1S8bDvjKRI1qIrDxo/bkLMtcwkNQ0rw6kdmEzoNJBg=;
 b=223aIN/tYiYM9Nn527fxNkQAxY5BbeEs5GgaSUQUl78ESBCLMcNNbAxqS7SbzgQyJbph96V61
 Plf17t+U8y/DIziti+Mi5p1ERk2C1l1hfL9ePC9c6t9a/DL8NaGeTGa
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|DM6PR19MB4344:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ebe45e-e4fa-4a9f-3bbe-08de11b953e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QndLKy9xRFVlZnNSVkdOQWlaUkluRkpYeVMyS3Y2d2c1MGdiODFMcGRlbUJ0?=
 =?utf-8?B?Z0tjLzVZMzhnVjFxNUo3K0FweDJQVnJHazVqdDBSaTQ0UVB5UE1KV1RwV3o2?=
 =?utf-8?B?YkFqWUFxNHNMRUFueUg5SVJaQ2VoSlJodzdOdmpTUzhaODlyb3FYSnNIQytG?=
 =?utf-8?B?eXRYWXlvK0VIc2doK0pPeVNjNGs3cXZTWlR1QVJLRW9lTjQraG1DT2wxWUVs?=
 =?utf-8?B?K3VCWTBTQ2tGYm9RZHF4V3pKYVMvWW5XOHI3UUcvZnI3UDZaQ2xIUFd2T0hC?=
 =?utf-8?B?TytNL2MrUUJYUVZVaWFqaDByZjNCK051WnJVcmdNN0hPZzRIZkFxTDlHbkdI?=
 =?utf-8?B?dEk0YUI4dHhnZXVwNG9qVFBVZnE5Q3ZUTWlPenFHUHNmOWZKeFJTSVMvNzJ6?=
 =?utf-8?B?eEFpOE1hM3BHd2dTVThjYjg3V3lmNWUyajdsQVptVXJlTGhXYnRpeUdLa2ZF?=
 =?utf-8?B?TDFQb2piL0lZbXhHMHJENHJrOE12Q2M3c29IZHNYaHM3bkJrUjBZbDMzSlRl?=
 =?utf-8?B?MlRFcks4Rmc5Skh2Wit3WlpSL1VXcERlN0pRRXU3aEk1UzI2Q1ZxazRleHVo?=
 =?utf-8?B?R0xJRUxXcXdYQlZhd0RRY0hhbUUrU3RQd3hhWCtReWs0Zys5SVFHSlRNeWZV?=
 =?utf-8?B?VHVoN2Qrd0EwelRpNjVIMTBTVHkySFJ1K0FBZ01XekJnc1ZBS1JtWHd5WFhH?=
 =?utf-8?B?KzJQcmNIcERzd0l0NE1JQ0hoeWxaQ2hGOUVIMy8wWEIxOVJ1RHc5d3JDU3Fq?=
 =?utf-8?B?NW9lNjY5dHNlbzY5dVJGYzd2azhTeno0dG5YcW11YzFXbTIvcWlZMXMva25t?=
 =?utf-8?B?K0Z3b08vYXBPc1NLTE1JRkp5SHdnVkhjZTFnM1dVQU15ZXZ2ZUg5RjlIR1Fv?=
 =?utf-8?B?ZGt0Y2xsZm5vL2NmbGQrVXV5V055anBhTXJ1a0JwYmRaaDVuMFJ1ZXJqaHFU?=
 =?utf-8?B?MVQ0RTNVVHhLMXVTbDVJSG1YdStoUWlCZzRTU21WUmxPNHpnMU8vbkRZNVBv?=
 =?utf-8?B?c3B4SHZheEMxUXdPSnc4dnJlTFRmVUYzWi9LNHhFRExNM210anNuL20wUEow?=
 =?utf-8?B?OENRRDAxN3llYkhLTkNON0dZSWtiVGVtS1NVdGJwUVkveHFBTDJZajd0TFhi?=
 =?utf-8?B?UlY2SVhsTkJ3UHFpejh5SituTXJ3bUpLekMzRDYzbHZwZ0tiS3ErZXJ1Tldv?=
 =?utf-8?B?V2syVWQxcy9xRGhESzNEQUIzcFpnWUxabjR1M29lT3BTNTBOdm1uOUVQRE9u?=
 =?utf-8?B?TVJTUms1Z2d4VUg5U093UHlRYURodVpTT0lSWjhzdVgzU0h6amhuNE42SGFU?=
 =?utf-8?B?RzM1czYvajl6dVlDZVlTNUNXSnZtVzR1dS8zbkROY3NyQ0JBaldieHNzbVR5?=
 =?utf-8?B?M1NKQXNZb1MrN0QrKzlweEZWLzF4dFpwL01CNTFxbFJVSGJQN3YxRWZDZzdm?=
 =?utf-8?B?TjNCRVAzNmduMUtVYjFHa1FhZDQvU09IQ015QWx1U3pWUjd4TDhJOGN2aXJx?=
 =?utf-8?B?MnB6VHJOZ1d1dlJyeFg0UzVHcTRPdVVLcmF4UUptTWRLdHE0NThoRGlqajBn?=
 =?utf-8?B?UGxvSWZHbHdaemg2SE1ZWWMrZkJUcURNckVQdkpzRVN2aktMc3BJY29Rai90?=
 =?utf-8?B?M3RCWXVKdUtHbVhxM3V3MTFpekhtUXc4WWpqRHZQUThaU0tIY2s5cHl2WGU3?=
 =?utf-8?B?QXhHQm9DRnlwWGZFSEN5YUhqRkZ0cHJ6elF1VS9uZ1IwVGtUSm4xdTRQU3Bz?=
 =?utf-8?B?ZE5YVk5mMytyRzB2eXZiVmkwWkF4MkozcmZFdVNyeEJWR3dTQXRRaHNtK1dp?=
 =?utf-8?B?Y2FRVEtsMUNCZ2ZkN2hGU1NwNkl2emVUek1QNXhMenBVRXc0TlZ4eDQreHo0?=
 =?utf-8?B?N3hPVnVFWUkvWGpnL3R4dWpCRHlQRlZkTXNnRVJNZEg0M2VYL3dSc3g3byty?=
 =?utf-8?B?bi8rUVFCcFcyVTdPQU00M2xYNklIQ2REYkhVZ2lYR3JtZng4cjNaVW5Pb0p0?=
 =?utf-8?B?eUdxZ2xOSVhjaXc1Rng2T0FCQjJ4TVFhWWtGbzRubkE0QWR2azFuWlVQNGZo?=
 =?utf-8?B?MGc3WGg3N2d6SWJTUk9NNEZMdWJQRXNRMW1MRUEzRHFzUk1CUktwbVllZWtW?=
 =?utf-8?Q?fwUo=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(19092799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oebevoInGsuxUwdQl0b59fTyBKFErPNjeYzR3OF1ydUoc2vctJPmAdPP88b72cwk8sSXTM8l2lv6KTmauj6P8FJoG12OS/SAu79DtLtArKv5kDfvyZ2RCBQFFtW2jFyTBdjiD957qGYDfs5YS610r4VUVQlDNRLvKLWRWxV9KWWuLqgQiBu4OYDMn4+ti12D4/6SXiMiLNFs+bQ9TTF108JV4x5mM84prDTysmClYSDtREF1LJ+LX0eFSJnJsE2KFIcu7bl5+HlEGTEEU16smqwrrr2w8JqeeYNikdeOc+g7E3D7D7IcoLfhJrRcBFwLd6QHOTgNovhlcXwSU3yz+PEXNytQx+34I3YfeJPcZXbmTTT/RrtZkVphBHhsgH8dpFCdSKGa/RPshweqKhiM150FPu0pdazHau83Zt7h2LGkyQCdGZ3mi7XkWz/oh1cvqY/n5yfBy6u2wtgj5cka+SBsIrMCUNjbq0rkDqrhCfZuwviucKaTkSF3uqPgDd06/uyccrAnXOFwjr20ZieSvP7+6VTrJZIUT5L/HWGQPwCkZqbwLsTNvEoAsJ/aeT/z0khD+yZghm+6kk3MA7hMhqbND6awkwNjz8G2g85u2l6t+zND9fjewTg98zkBa2nyOeRNhOTUukzFcjXCAB/1rw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 22:21:20.6245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ebe45e-e4fa-4a9f-3bbe-08de11b953e3
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4344
X-BESS-ID: 1761171684-111362-7216-21625-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.56.77
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVubmxkBGBlDM1NwoLcnU2MjUyM
	LcMs3M1NIi0dTMKMXc2NQoKc3QxEKpNhYAuqxNPEAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268402 [from 
	cloudscan13-103.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This is for FOPEN_DIRECT_IO only and and fixes xfstests generic/209,
which tests direct-io and competing read-ahead.

Also modified is the page cache invalidation before the write, the
condition on allow_mmap is removed, as file might be opened multiple
times - with and without FOPEN_DIRECT_IO.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
Bernd Schubert (2):
      fuse: Invalidate the page cache after FOPEN_DIRECT_IO write
      fuse: Always flush the page cache before FOPEN_DIRECT_IO write

 fs/fuse/file.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)
---
base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
change-id: 20251023-fix-fopen-direct-io-post-invalidation-0dd72f7a1240

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


