Return-Path: <linux-fsdevel+bounces-40120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8264DA1C4B9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 18:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E5618856C2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 17:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064770803;
	Sat, 25 Jan 2025 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="G5C5lLFb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A280A2AE86
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737827144; cv=fail; b=WZP6i+XIUuAGmV4uwkZ4R7Fcho9YWmPs6BqPMJLgfhAZL78LyPQsJspV6u4YP7IVWpqdFXVgg7uKW+e0BbXV5Ef+suuKSQGKnLkoGu4hFzrNyr7MQ9tOTiwf6ZT/5cvZ+vgJmwOp9neWFim2ofYcNqcJGoHPuPtT+tc3YeAy2cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737827144; c=relaxed/simple;
	bh=ctbR5MK2s+2sDgFg5uCpeyiveee91aPO1daL47kkIt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJDsVoLbl6nRGL1EKmMKmeNX1/nKDZw3ov4JxK+KNCBHhATgHVjVBlCVrGLLlLdLL8NsSSn8ciQoBbTpksjtLCQwD2j/cJYuyqXJhsZGlCWWaDjtvcS42SDKGQ/wG7CSoRFAh6J4A5XEeQcPI6zeGvl691U5+xy6zfBeSr3aUgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=G5C5lLFb; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171]) by mx-outbound42-127.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sat, 25 Jan 2025 17:44:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jH3o/7CFcz7W6SHYCRSiIJCF+gKX4aicg9a8fgBeKImm9l6RVRN5R+CSZC5jElXM9UUGRXuOXPUsNVtqfGVM75FJ5JPU9cGzun3u+J+BnL4QLoycB4j/iQChzkvkkVEtxPJy81oK8+r0kDBX6BXVNovbON8QRDhjj7kzMa0/nN/n8wWbDUae9NM1Q9h6ocMtSBBeUvhs+9P8pQJfKWcmb+BsV6IkTknUCew0cI2FTsrHwq+A0Jim6GWmtT4rOfG5t5md6TY7kBSt5/gPoHA6H80m5kRcfv+8je5Pnl6sghGXmwXv1Dx3ecaLLy20wka/PO6XFiu3SrcFrIHGjAqy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrDggoueKzxiTosXg4AJ+xH8WtnrlP5FRNkwnazvUfY=;
 b=rkoNPgFwUNpbmlgVq4Y1xKG2gZjHCOBHKd9dGmuW/dy/13Bkq5zn3r+5FnGL4KJuVwg6AzaS2d/C4o0ANCLqHOqHc5trXCUDtGwXCJjqUl9zCx5kt8RkxTzj39maknd6T0fdDN/EuFAKqVgQK1nOw+VmN6btK+qIduTun5yY3t2gbH/wZp7URnZSahM5dT0uG2M55zuupf/u+zpoxLaG+F9U3NXFbY4MsNGTUIqfv6ShiBv0Yh1jf8QNnjeLSuuq0gmTglKRk+aYs8I7HfknKQ3AIYWEzwdbAVdJuhYtBP5pgpUjIRCmlNMx/FQVgZBUBfjQ5ju1P5W244J0BP8LZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrDggoueKzxiTosXg4AJ+xH8WtnrlP5FRNkwnazvUfY=;
 b=G5C5lLFb2E5YvCHDcL8ep1y98Ahk5Mq1fpu4+AtRod2WMaD5Hq7J4PcRScRCWPLGNrs3/Kw+2Uil0p+BadPOfNKjt0KucvX4yRFaz+Yxm27ymiV23bWadatoC3nwAAlrFmc25kMKPH+OFlqAPtDFtz8O/zEBXYZZM8hMcb4gRls=
Received: from BL0PR1501CA0013.namprd15.prod.outlook.com
 (2603:10b6:207:17::26) by PH7PR19MB6806.namprd19.prod.outlook.com
 (2603:10b6:510:1b8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Sat, 25 Jan
 2025 17:44:05 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::74) by BL0PR1501CA0013.outlook.office365.com
 (2603:10b6:207:17::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Sat,
 25 Jan 2025 17:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.8
 via Frontend Transport; Sat, 25 Jan 2025 17:44:05 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 2076358;
	Sat, 25 Jan 2025 17:44:04 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Sat, 25 Jan 2025 18:43:59 +0100
Subject: [PATCH v2 4/7] fuse: Use READ_ONCE in fuse_uring_send_in_task
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250125-optimize-fuse-uring-req-timeouts-v2-4-7771a2300343@ddn.com>
References: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
In-Reply-To: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737827039; l=1123;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=ctbR5MK2s+2sDgFg5uCpeyiveee91aPO1daL47kkIt0=;
 b=fYLTGDCK9YQTj0USubejzgs1Ifb0v/ekZMXNipAMzTV8fwot317ny5gac64KUsknspPAFsfKH
 Pj6iv0i1vD7BSA5MxAaSBierZLaBB14C+7FBPHieV+dTVr8HNBXTFZY
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH7PR19MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9da2ad-c4da-4972-4408-08dd3d67dcd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnFuS2t4WW9LTm5IYkFucXBHNUk3eEtubjZtSkZNWnBrdnBUb3JGRUhDd3Nn?=
 =?utf-8?B?TXZCOE1henpSbndEMm9BZWJ0ODlmSUlCcFVPNExFRnRXcmpsbStoR1dPdUtm?=
 =?utf-8?B?c2RtZmhDd25CZFB0eElYZWo2enZVeVJJZzJhbktNRnYwdkRMUlZIVGQ5a1VE?=
 =?utf-8?B?UTRuNjRmTFRtRS8xVGVVcFErdWlQdXVFeEwwd0lmTFlLMWFkM1Z0RVpKc2ZT?=
 =?utf-8?B?QjdNcm1DcGV2MWw3OHlGOGhadkZUN1N3bExFNWlZMkdrdElXRUZQNUhqZ2Nu?=
 =?utf-8?B?dGhKWDdtT2k4Z08ramNpUk9NdEFDVmdYREdKMFlraE5xaDVWM3oxVlQrL3R5?=
 =?utf-8?B?MGJsc2lyNzFzZGZ1Z1ZoSmpvUzdKNnQvQjAraU1CMXhwY05FK2xnR1JVNWxr?=
 =?utf-8?B?bjg2UlRaUWE3TEZOaVhpSEtpekk1anRGaGI1QUI4ejRkZG5oQWM1ZGllOXFC?=
 =?utf-8?B?WktCOWJJR1d4eFluQjgzeUNJdkV5dThtOGtrakJqWG5hMUxZb2d0SmhDd2Vh?=
 =?utf-8?B?ZkVsS091aGJKTFBTaFVJd0FsUU9NeUh3OG4wWjFpQ2RDNE0rZWVQa3Q0dnhs?=
 =?utf-8?B?azhoTWZuYms1WnFXOWg4R0pZRHk0U1gxVHVwaFVtRW5rTXpPc3N3T080cHRE?=
 =?utf-8?B?a2ZaNWNabTljMVk4bVFFZFVLTmVsY1FGbU5IZnhDWkNRNzFDblcycDJlOGIy?=
 =?utf-8?B?K3lGc3UwVTViMytlSm8rKzZGK1ltakRlYkZ5bExYMzhHZkFGbjVuQmRrU2h6?=
 =?utf-8?B?bDF5SWVTR2Vhd3ZpTlkxNDFwN2FnRzhTU1FYK21TR1Y3bmQ4VnF0MXB4czVX?=
 =?utf-8?B?cnVWWHNsdGxNd295QVZuVU5mS0kxMmZiOURlMWt0U0JFS3JreXFsbVltK2o0?=
 =?utf-8?B?UzRyREFpbXl5akxXL013dHNOdzBjODdiVTcrYmhCQllDUjRhWkZmRjJzVU1I?=
 =?utf-8?B?MHZEaVgxODlrVlNuaHA3SExXTjhadytvRlZ2WUdkZzc5c1VaY2JGZTlUOWht?=
 =?utf-8?B?RTRrTHlYTWllK3c5RHRSb0VRTVhqNU5hblFpWTdrWWhCT2hrZEJhTDNtYnZn?=
 =?utf-8?B?eVVuRVJRK1F4QkhvSkVwUGNnS2xUK000L205cjZOY2Yxek9OSE84YzdvRzRm?=
 =?utf-8?B?UVpDaUJMWVNPUnZXMERhaHZja3crSkkrZm1ZMmpWZ1g2dHpBQVR3SzBtYVlv?=
 =?utf-8?B?SHdja0VRTFgrL0F5ZXlJZG5qUUcrbDlyVkNTUUVjcUp6eHlsbHJFdzRhTi9Q?=
 =?utf-8?B?TFpHbU1ueG8vd1BudldYZ2M1bGNsUVN2b1ZhNE1WZTd4bENCV2E3RGh1UWV3?=
 =?utf-8?B?aG1DVUxxeHowTkVtQ2ZSQXVhSjhKMnhuMUROdXZvcmZ2RlJlUmFXNEduTWFJ?=
 =?utf-8?B?MTBjMGRRRHZ3N3dpUXhOVWFZVGs0elNRVDhJSWtycWRTN0xxVFdudDlNb3RZ?=
 =?utf-8?B?eWdrU0NySUpVZWlxSFJJRFBGdHRBNk5hNndXL1JtNHAxRVUrWGtZdjlsQVBi?=
 =?utf-8?B?RTREUVJzaVRXWk9sMHFKQlNjSWNGWkdYWnpKUFlBS253RGQvcnErdUFPUkR6?=
 =?utf-8?B?WENVS0dzeHNGN1NvTjI3aEtaRVNlVHlva2FPOUJYdks5Mzd0RXI0K0t5Qlh3?=
 =?utf-8?B?QVlaRWNqeG84T3pobktia1ltak1xQk92V2xEMHJHT1BNSlBJL2RVeW5vcGkx?=
 =?utf-8?B?WXlCUm5FTU9EaEVLM0RIYUFyS3lwMHVGekRmZTBaeTBlcnlOeTlWR2VMSkM5?=
 =?utf-8?B?cGxJV3R1MjJzOTVkckp4ZDQ3S1dmQ2dKbm5wbFdmVy9BelNGUi9memMvR0NQ?=
 =?utf-8?B?VDRpQWFEUTYvQ0xSUUovV1JYdk1adU85Lzl3ZUppNU9IMkhpQ0pVOCtJbHdM?=
 =?utf-8?B?c3hCNTg0MTVUSTFHTlE1OUpLbVNmSFQ5S3lhVExFWmRXUU9vZXE4eVVsRHBU?=
 =?utf-8?B?eERrbWFIMFRtd2lQUjJyZVA3MTBxdmlwSUF5d2Vray9teUc3ZFZSSGRSLzd3?=
 =?utf-8?Q?+kuQdfCXUrEaF6ldfCnHskIP9JY0wo=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yzeWjRVyka+BKb97LQuexGG67ITwXTAXOQOdicNuANnowC2uVHEsM/KZjArVg6vlwp6PkYd7hJtaJekg2hwjSeg2GklEoXt4qUHjMa4m4aRaOt/A5h8czLX5zY/CooQHcoqSGmuacLsu2jxM3abMfKRI6ZP/8q1PrFwKkXwy4MiWquYn0RMUcHgFvQ/WcU6coUkHzw0KrjA/+tbOiwTQSgr6zOEPhMK30+/CNwde7DEW7my4F/lDZOOGRG5yNkP4bPdhm8ilIese/jsL5LbtmtqyQEjjnUUTivin/7Mhu3qoOpuDDWusY8+FQFCQn5H/JbxjaM3hm3NrByWgMvw0IT4cHJKzXmDBVwPGVULQk/9gSZxgE9lVDtTY8beBVaOEyc6tIQVKxDg2Dt+oMDskFqeIUdhfGXQrem4JF5AzwTNJN8Zo68yYxFhZiwqS2xtGDbU78Gm5BFt99B32BMx8ZieDpmtvdxyfeMJ0dpbxgmjyH/8XjQOW6jZaf2L1hjtg5qwMdFX1CNNE4rgQx61klBE29d+IhU4LoUwG5SiVic5DvQSMfj0PZsWuxkkJQl9KDnEeQQknNS53XbhubOmBZ8TaMKQuuYgSPGJUCFHdO2MyIxt6niyKwGXsw7PqOdPtpHIa+Qnig6IpCaXS9izzpQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 17:44:05.1027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9da2ad-c4da-4972-4408-08dd3d67dcd6
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6806
X-BESS-ID: 1737827053-110879-13387-489-1
X-BESS-VER: 2019.1_20250123.1616
X-BESS-Apparent-Source-IP: 104.47.59.171
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGlsZAVgZQ0Nwg1dIyxdI0zc
	Tc0jjV3DLNyNzcNMUw2djCzDgpLc1QqTYWAKVaOgZBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262052 [from 
	cloudscan17-107.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

The value is read from another task without, while the task that
had set the value was holding queue->lock. Better use READ_ONCE
to ensure the compiler cannot optimize the read.

Fixes: 284985711dc5 ("fuse: Allow to queue fg requests through io-uring")
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 62a063fda3951d29c27f95c1941a06f38f7b8248..80bb7396a8410022bbef1efa0522974bda77c81a 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1204,10 +1204,12 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
 {
 	struct fuse_ring_ent *ent = uring_cmd_to_ring_ent(cmd);
 	struct fuse_ring_queue *queue = ent->queue;
+	struct fuse_req *req;
 	int err;
 
 	if (!(issue_flags & IO_URING_F_TASK_DEAD)) {
-		err = fuse_uring_prepare_send(ent, ent->fuse_req);
+		req = READ_ONCE(ent->fuse_req);
+		err = fuse_uring_prepare_send(ent, req);
 		if (err) {
 			fuse_uring_next_fuse_req(ent, queue, issue_flags);
 			return;

-- 
2.43.0


