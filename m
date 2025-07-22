Return-Path: <linux-fsdevel+bounces-55754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C59B0E5D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 23:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BBD3B3310
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1467728C029;
	Tue, 22 Jul 2025 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="p68WIskK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C2E28C016
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221498; cv=fail; b=NWRFsx5YKoQVKj6kctThFy9s1RsbO98kMWZjUgco/vowEKAbY2Yw1MZfgrN7MZjfaPOEcOIWOPKAgdUKR2+BHi853Ij+KnKfvSi6sa8JnporfdigMtCOrwTM1oaVP+JJ/Riupbr0OLlc0qwuUggN0AS2W1iwDsOeSf1Y7y0a0cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221498; c=relaxed/simple;
	bh=IS56mjWd2YjZPWe+UxRHnq8+WUMsMZw4bdm79s3ixgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OHEpEyRjXIT61TrQq+nuNp4jxm2tePYoK77vxMYqzdcvs1YkiE3g17Lg2eN9r5l+AlTJv/zFX1s4N7R9ovVHFLxcfDN6yd/2So26egCPA6nOR3YTbCmgaeoETQQ9nirm0VC1A+epErzbZVRUVHCqcwAkuR79bgpB0BMDrfY+Mew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=p68WIskK; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2121.outbound.protection.outlook.com [40.107.212.121]) by mx-outbound-ea18-75.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 22 Jul 2025 21:58:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meS0p89KepCk51vqkz7HuiHXjEh4QlhQtCzDp7SHRTRfHcOKyT37GJt2xv9EQZkyssmfuvQHHUOKbs+160TwnqN/uIQrcweVJ5N9mx95ESbfbyACUQPcQC+bE7YTyfdhgQrTke+x5JLcWg57V2kdGvq+JZgP6o5pzoXerCSqyXRNZBhnawEU0tSqDXSsALF8r8DTENp69513X5t+U/iI1oTj+kI0IVrf4dwqhjcVB3UvubpH/q9L4IBajEEEUCuXdWNPQcVcwrabXJ28W2s/Fh35RFT7MZHj7MQZTO9WBgARTAQ+DV5CGjEpDw423ecQeO8n3slQXZGWLy+PBRPM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ny0UbhnF/NLOcdqjr2txdRXo68ezImHUlkk/GdGmSJw=;
 b=pE3gsXRx9RGeaOTqok/YxBSyte1WP4jei6bG2aU7gWkfAua6EaqbjRvi6BGkrRfkCasFk7ouuPih0EJ2pkd09vWZSJqRa+Du0G7r+UJ2Ce100bTCm4y80k8l1aN1bKOZ8MZ+vurZg8d/Slw/XLONT8qnPBDCn2JEs5bQRBAABc+FwIZ0+kyUfQnHzzn5R4BJPoK+HFtLsP1n0gItfPe7RTUuo6eEambeaYTaQR9WYde/JUPqzEKq+zgNNEYt6Uqpyc5vgioQEjmhKVQayr6Q/A9DsSKa1mMFdSJOPJGQUcxyU1zizPVjf9kPFfbm+a7saLZLVJ2LYlh7MEx8iDfG2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny0UbhnF/NLOcdqjr2txdRXo68ezImHUlkk/GdGmSJw=;
 b=p68WIskKLH9/x2u1gi16u/TnnFEUhvR03wMVGskh+dbrQi3ggKMuVAdNIyF9ZYo+ikjf+TwrGyaxPuc/JPDaJfoBUHn/58SGzyahdeajkpa0cSc0oPdCIRipnf+xzkGtsiukEBc/zcQ/vITIiXMFeY6gjFLQpftXBcYsFv7GWLM=
Received: from SJ0PR03CA0163.namprd03.prod.outlook.com (2603:10b6:a03:338::18)
 by DS0PR19MB7812.namprd19.prod.outlook.com (2603:10b6:8:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 21:58:04 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::20) by SJ0PR03CA0163.outlook.office365.com
 (2603:10b6:a03:338::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 21:58:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 21:58:03 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id D77CBB0;
	Tue, 22 Jul 2025 21:58:02 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Tue, 22 Jul 2025 23:58:01 +0200
Subject: [PATCH 4/5] fuse: {io-uring} Distribute load among queues
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-reduced-nr-ring-queues_3-v1-4-aa8e37ae97e6@ddn.com>
References: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com>
In-Reply-To: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753221478; l=5537;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=IS56mjWd2YjZPWe+UxRHnq8+WUMsMZw4bdm79s3ixgA=;
 b=HRL8lA79/9J/L1cOUR8VidQwAqZ7eJtPGxYAoTH2A2/CDpuCaTvHJJXxewSzkfq6rbl/QDeIN
 yW3pV9YaAAEBthuXkrYSY+ZtlPQmC3wE9rEI7QtZUxh7gRNXecFFe1M
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DS0PR19MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 31686447-0ebc-4c75-1e30-08ddc96ad530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzlDalZxeHc2UDFacWg3czFKRFZPTmtJcWc4UmtUd1FpSEkrTCtGa2lpT2Y4?=
 =?utf-8?B?WjNrSTZJcC9RWDZTSitJNy9vSHpBdkhwQWFUaHFub1pLYkJTNCttTEJMcy9o?=
 =?utf-8?B?T1QwN1Q2b3g4R0hjZmcxRkNVZzgybVJBWXFma0JJcUhKWW5CWUszZ29VNzhB?=
 =?utf-8?B?amF5RU9LTW83SHc4cnVzTnFreHUxc2hSSG01RW9XellCNGdNWkF5Z2FJUm1D?=
 =?utf-8?B?emJOaW9UZkZyejhXSDFzZGtJSWRRdHhNQ01kSmUxWlR6Zng4MTBiN3hqcG5U?=
 =?utf-8?B?Smp3RXp1OHJFMS81cDVuTGxXbm93WXJTa2E1VVFmZ1FDRnJrQWc1T2NyVlNN?=
 =?utf-8?B?cWhyYmVZcVNFVnpwa1JGcHo1K1BYOEtDTTVRM3V3SHpIQ2IyY05SR2hJU2d2?=
 =?utf-8?B?TUFKVWU3SktSd3BsbG1LUXVVVEZtZFRqRDNLVXhjazErQldSODNHcWlzOTRJ?=
 =?utf-8?B?WVZWdWZqUmZOL0lPNjA0c25MakcxNHZzOWpQeHRTaEdWNVlDd1d6YW1zOXFM?=
 =?utf-8?B?c3M0Z2xuOWVOLzNLZkEyOHE3L3dmR253RzY2elZONHJrTEZsVU1zUG4yWVN2?=
 =?utf-8?B?S0h1TGZHUkJFR1A1Z2NhcWoxUVd4WUJ4QVJ3MEhrbU5qeUN5djgvYjJYTTdC?=
 =?utf-8?B?ODc1ci9zb05Ga3ExRDZTYld5U0FaZnNkM2dyVVAycDlGVk94MXNZenpQY3Vx?=
 =?utf-8?B?YkM5dWV0ZDZEbXRCak1WYTlqMm9wVnZjVGhSUHFCUW5JR24zYk5zSm9ONHY1?=
 =?utf-8?B?Y1h6SG1RWTlKZi84T0JZc1N6dWNVNElhL3E0S2FPcXE2WGIzbWh0MzFGNVlL?=
 =?utf-8?B?S3YvdXlpbzJ4cmtMU25nRTdsNHRWUVcwVXRsWHdzTFZSajJQczNGbFRiQmxR?=
 =?utf-8?B?ZHRpaFA4SkJaVDVOTkg2WTltUm51YUZLblQwck45MUlhMlZkcmFnNUY5eEtR?=
 =?utf-8?B?Qit6OFQxbVY1YUhDdkRKK3BvRTVFSVBwVEZ3dTdaaGVCV0hSNDhtZGVqL3Nw?=
 =?utf-8?B?M0orR0JkQjMzQzVGVHpiNkJEZ0lEYnlENUdLOEkzNG5PYkcwblU2T1BMTE5a?=
 =?utf-8?B?TXIyYWdoZnJxNlBnNkVoOVR4aW1MWlE3Z2Vnako2ZFhIVFYvVHJFa0JwZEpU?=
 =?utf-8?B?M2IvemZkMnpvd05RYVZId3RZd0dBZlpaRDA1TjBzMWhtMFBVc09MQnBxV1dJ?=
 =?utf-8?B?cmxNZnNqSTFETlA1VHltbWNJUGh2a1RFbHlIdGtxc3RZRnM4WlMrUnZ4bXY5?=
 =?utf-8?B?WmdxaWxIZjhmVmlSY3hNNFQxTTZuRDlRdm9YSFBhWkRkVWdRdXJMVzdubklZ?=
 =?utf-8?B?V01oOUk1ajYwWGN4a1JtOE5BYlJsclV0ZkdmUiszNjZQeC9wRDFiRzVjTW1q?=
 =?utf-8?B?WXZxS2NCUFZMaWhSTjVxckZSd3BTZzl2UkJMWHZuKy80MW9lU1l6b28zczRJ?=
 =?utf-8?B?UHFnMkpSck4yV3pDOEx5TmZGRWFXZFUvKzBOSEtXMDVLaGhiRG5NY0J4TGg3?=
 =?utf-8?B?QnM2bVdUL2cwektmdHJraXIzV0tLTmZiblNFY1JlclozQ2RidHVwb1crV2Zr?=
 =?utf-8?B?U0hKVGdaUVZvUU5iUUduUVovLzZOdjdmYVpqUDkwd3RRTlpuMlRwSTN2aFQr?=
 =?utf-8?B?WnJwUkZSYTM5ZVl1ZS9FRklsRDZDN3JEMzFZalFvT2FZaVA3d0plSWtWSkgw?=
 =?utf-8?B?TTgxdExwTkVvK1VycHlxSVo3T3NvY2RMcXhreFF2eDJqeUZja3JJTHEzSk9p?=
 =?utf-8?B?YmNoUjRBWVdYK3dKZHBMYy8ySmpzRHMvUkxUSmhiangxREY2V2cwWkszV3Ji?=
 =?utf-8?B?VWJET3V3T0ZPcHJhWTZCcHJKZVhzQ2pIajA2OUNzU2IzRVBLcDdFaW1CK3Ex?=
 =?utf-8?B?dWtZSUoyLzlIc1pPQ01uNndEWG1nS1VsUS81aURDSStPUUhLdFBFbUpZUUY3?=
 =?utf-8?B?bzFXd1l4VW5lcEEyb0I3WHJweHozaCtsZDd6MFZnSURmTlk3NWw4bVlHQmxs?=
 =?utf-8?B?V2VJN2lYSU1pQWpvNGJFUzJGcmhndFUwMEpNSWsvYmpwWHBnRFExcUIyaE0w?=
 =?utf-8?Q?hZlJfd?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(19092799006)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5CROh+ThfI03AhD7qK3wYZVW2qAxzrHHr3LU+Ig+aAJlNBcjoblCd5aaSsVKf39eW1nriv5/idrQe6s+i0ZcQvdO6qAZhSZ0tyRhub5QkpceO/6MPnCeUGIKa9ddEtgoOSUqTDdBUUzJxZJb6yy0GASbON5QLniNY3LZCW8NZtKTqD9znGIzBVoPNYVqLnDvL/SsOABhgbV+XusAJy7x0SqqCPWl4YB09govJkAXB/zmqs3pot6JtPorx1YL04q4QUyU3+2M/oCsIMPqs/KfQJBV8dWcNRKcexYojXynEaczZXnfT0gmQXEbqWOOPgEXsXehtscohDsUSTqI4KPBamxWNbdISvGf8l3I/m9rIgmKHiG4YcQfQSMyZZVQ0O505acOR446svFJfcGl7DKAvP1lpokQY7BVqFdKHq4GwafVRtvFMtgniHt8fnDM5NMutdsokAcwifIaC2WEeSQ77A1xTAySwYeRGWXr2QI6+bnVOqUTad/hT/MGsIDpmmuyTiN6cYr/4CTicMXGlw9t9FxUSxzltbYDL4fjJ1Gfmjo5sWBbSq5/mz+W/wjeHkD/GnIzWqA3dtwB5PvtRDWE74NlQRki4G1h/sOrfZRSWowY6Lb2+UuTF4BLFu7uW20x4in0qR0BqwkWEDSFdL1VRw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 21:58:03.5593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31686447-0ebc-4c75-1e30-08ddc96ad530
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7812
X-BESS-ID: 1753221486-104683-24654-9805-1
X-BESS-VER: 2019.3_20250709.1637
X-BESS-Apparent-Source-IP: 40.107.212.121
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqbGpuZAVgZQ0NTQPDHVItXAPN
	EwzdQiKTkxycjAwMTcIjE1zTgxycBcqTYWALynw1BBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.266236 [from 
	cloudscan14-138.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

So far queue selection was only for the queue corresponding
to the current core.
A previous commit introduced bitmaps that track which queues
are available - queue selection can make use of these bitmaps
and try to find another queue if the current one is loaded.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 88 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index c2bc20848bc54541ede9286562177994e7ca5879..624f856388e0867f3c3caed6771e61babd076645 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -825,8 +825,7 @@ static void fuse_uring_ent_avail(struct fuse_ring_ent *ent,
 	list_move(&ent->list, &queue->ent_avail_queue);
 	ent->state = FRRS_AVAILABLE;
 
-	if (list_is_singular(&queue->ent_avail_queue) &&
-	    queue->nr_reqs <= FUSE_URING_QUEUE_THRESHOLD) {
+	if (queue->nr_reqs <= FUSE_URING_QUEUE_THRESHOLD) {
 		cpumask_set_cpu(queue->qid, ring->avail_q_mask);
 		cpumask_set_cpu(queue->qid, ring->per_numa_avail_q_mask[node]);
 	}
@@ -1066,6 +1065,23 @@ static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
 	return ready;
 }
 
+static int fuse_uring_map_qid(int qid, const struct cpumask *mask)
+{
+	int nr_queues = cpumask_weight(mask);
+	int nth, cpu;
+
+	if (nr_queues == 0)
+		return -1;
+
+	nth = qid % nr_queues;
+	for_each_cpu(cpu, mask) {
+		if (nth-- == 0)
+			return cpu;
+	}
+
+	return -1;
+}
+
 /*
  * fuse_uring_req_fetch command handling
  */
@@ -1328,22 +1344,57 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
 	fuse_uring_send(ent, cmd, err, issue_flags);
 }
 
-static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
+static struct fuse_ring_queue *
+fuse_uring_get_first_queue(struct fuse_ring *ring, const struct cpumask *mask)
+{
+	int qid;
+
+	/* Find the first available CPU in this mask */
+	qid = cpumask_first(mask);
+
+	/* Check if we found a valid CPU */
+	if (qid >= ring->max_nr_queues)
+		return NULL; /* No available queues */
+
+	/* This is the global mask, cpu is already the global qid */
+	return ring->queues[qid];
+}
+
+/*
+ * Get the best queue for the current CPU
+ */
+static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ring)
 {
 	unsigned int qid;
-	struct fuse_ring_queue *queue;
+	struct fuse_ring_queue *queue, *local_queue;
+	int local_node;
+	struct cpumask *mask;
 
 	qid = task_cpu(current);
-
 	if (WARN_ONCE(qid >= ring->max_nr_queues,
 		      "Core number (%u) exceeds nr queues (%zu)\n", qid,
 		      ring->max_nr_queues))
 		qid = 0;
+	local_node = cpu_to_node(qid);
 
-	queue = ring->queues[qid];
-	WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
+	local_queue = queue = ring->queues[qid];
+	if (WARN_ONCE(!queue, "Missing queue for qid %d\n", qid))
+		return NULL;
 
-	return queue;
+	if (queue->nr_reqs <= FUSE_URING_QUEUE_THRESHOLD)
+		return queue;
+
+	mask = ring->per_numa_avail_q_mask[local_node];
+	queue = fuse_uring_get_first_queue(ring, mask);
+	if (queue)
+		return queue;
+
+	/* Third check if there are any available queues on any node */
+	queue = fuse_uring_get_first_queue(ring, ring->avail_q_mask);
+	if (queue)
+		return queue;
+
+	return local_queue;
 }
 
 static void fuse_uring_dispatch_ent(struct fuse_ring_ent *ent)
@@ -1364,7 +1415,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	int err;
 
 	err = -EINVAL;
-	queue = fuse_uring_task_to_queue(ring);
+	queue = fuse_uring_get_queue(ring);
 	if (!queue)
 		goto err;
 
@@ -1382,6 +1433,19 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 				       struct fuse_ring_ent, list);
 	queue->nr_reqs++;
 
+	/*
+	 * Update queue availability based on number of requests
+	 * A queue is considered busy if it has more than
+	 * FUSE_URING_QUEUE_THRESHOLD requests
+	 */
+	if (queue->nr_reqs == FUSE_URING_QUEUE_THRESHOLD + 1) {
+		/* Queue just became busy */
+		cpumask_clear_cpu(queue->qid, ring->avail_q_mask);
+		cpumask_clear_cpu(
+			queue->qid,
+			ring->per_numa_avail_q_mask[queue->numa_node]);
+	}
+
 	if (ent)
 		fuse_uring_add_req_to_ring_ent(ent, req);
 	else
@@ -1409,7 +1473,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 	struct fuse_ring_queue *queue;
 	struct fuse_ring_ent *ent = NULL;
 
-	queue = fuse_uring_task_to_queue(ring);
+	queue = fuse_uring_get_queue(ring);
 	if (!queue)
 		return false;
 
@@ -1455,12 +1519,26 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 bool fuse_uring_remove_pending_req(struct fuse_req *req)
 {
 	struct fuse_ring_queue *queue = req->ring_queue;
+	struct fuse_ring *ring = queue->ring;
+	int node = queue->numa_node;
 	bool removed = fuse_remove_pending_req(req, &queue->lock);
 
 	if (removed) {
 		/* Update counters after successful removal */
 		spin_lock(&queue->lock);
 		queue->nr_reqs--;
+
+		/*
+		 * Update queue availability based on number of requests
+		 * A queue is considered available if it has
+		 * FUSE_URING_QUEUE_THRESHOLD or fewer requests
+		 */
+		if (queue->nr_reqs == FUSE_URING_QUEUE_THRESHOLD) {
+			/* Queue just became available */
+			cpumask_set_cpu(queue->qid, ring->avail_q_mask);
+			cpumask_set_cpu(queue->qid,
+					ring->per_numa_avail_q_mask[node]);
+		}
 		spin_unlock(&queue->lock);
 	}
 

-- 
2.43.0


