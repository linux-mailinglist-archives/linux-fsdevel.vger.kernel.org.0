Return-Path: <linux-fsdevel+bounces-45701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F92EA7B041
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 23:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A399F189C812
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 21:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B901F17E9;
	Thu,  3 Apr 2025 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="UFw5EabJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE8B1EEA42
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743711789; cv=fail; b=p/vUU0MrxcnGTrj0uq5SLTwLBFatS7Bzy7TTFRUjwiw8V0sXYQyWt30Ix+q4gKO87UYM98/sX/P/MU5qVu6QzODI7j5vV/ajHWRtFgS3A1VzvQ88EM4hxuvBofzzBvUImEBQYC5ZKBceYb/c2evewq3riqjd/r5ILJPn+JRnjA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743711789; c=relaxed/simple;
	bh=t/qWU7S8DFwFw1ltRPZymLwhxW9CiMD3+kpjL0lZZRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VOr0ytcrlJXuwFBDd8Yw8Ev4BEe6Uyc8lvJC3n7ozNMnNp6E2allN3xwhc7xO3FAFg4lwYkQbhvhJEpduKQiZkaVwFFKmtNIuMRSnl45qj0rvg1Hyqtmlj81HsHijKk/BZF9HSb8xjbFW3uU/uVCg0YbS08VWPjo1yRrnuY3wPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=UFw5EabJ; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168]) by mx-outbound-ea41-28.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 03 Apr 2025 20:22:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAq+Di/srMTgY3BTjjGyE+L0j6oijLzSW6+RtLIM66CiCMZgtWBsi+1BLHpUtj0GI4Lj1T7jbgIYt7qm12kFc1iUP/aWQxVKJXsf+E+8/kwJaBm0zYdlIjlSjhz5NOLi5DmmsnCfgc7Jt3VePKpEaNQb/oAokY7/P4z/kUhAI6qFJD4JkEjp+DIiUGAYOeoUS4miazHujCEkNacDvWZef9/GkKHVVgBWONgT8/q36hkpBvs66wLh/De6ovhHhQAYQtR/MNK3xV9lj/KLmNDT0X5BzZA60CKmoAMzVKzVOS2lvKq67d0xfK1rIXxDPHtjCpSy694QuCUkmRq+V62UZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9c4thro/65LNTQvw9TViG04eyuC/g4rHehyEfqiU64=;
 b=Uj02+7C/Fm2Az+rxA6jmptyn7woA4zcFbjdrKlJPDIxPtpJSRWKiZiJqr9zP6D5zLU3EiHRPPlp1WPC/JKbCF34be8f/aeEwyqn0u+vWuaI6+1/Sr6RHYHSfiy8lSJ7BIT09DJG4xVpqyxPMJLMEGqXFRclUMgSbrxYfUGNxStWHisI6V83tglgjUZ2V8tLRuJBBpf1p1/hKYgWFTGQ9SL2RbBcV+Z7XL2BzSZ5eOGteeZ8y0trnc+nh4Iipwj1uj2EpXSfVP+07E3XH7+WElCLWkzpGqI5axvB4DkxjFW25ccbPraLEzOAITOsXF657mGBUZVZJCIWBK8jFDNDMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9c4thro/65LNTQvw9TViG04eyuC/g4rHehyEfqiU64=;
 b=UFw5EabJmN6Iy7nq7QvcYfC89u8e3wRZjcqxec0Lyfz8js7mHWOi8LZnKQhmVlvzZWcDouEAXp1Dh8gf1fT1YWWVRf+GVo5c8FnEQk8dMVjtJnt93vguJWyFReTize9gaBoCxn62Y339eAk8mRAKHRr2b0JU/cmgodDZRmDt5jM=
Received: from CH2PR05CA0001.namprd05.prod.outlook.com (2603:10b6:610::14) by
 DS7PR19MB7700.namprd19.prod.outlook.com (2603:10b6:8:ed::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Thu, 3 Apr 2025 20:22:53 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::14) by CH2PR05CA0001.outlook.office365.com
 (2603:10b6:610::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22 via Frontend Transport; Thu,
 3 Apr 2025 20:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Thu, 3 Apr 2025 20:22:52 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 6BE5D4A;
	Thu,  3 Apr 2025 20:22:51 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Thu, 03 Apr 2025 22:22:47 +0200
Subject: [PATCH v3 3/4] fuse: {io-uring} Avoid _send code dup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-fuse-io-uring-trace-points-v3-3-35340aa31d9c@ddn.com>
References: <20250403-fuse-io-uring-trace-points-v3-0-35340aa31d9c@ddn.com>
In-Reply-To: <20250403-fuse-io-uring-trace-points-v3-0-35340aa31d9c@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743711768; l=2416;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=t/qWU7S8DFwFw1ltRPZymLwhxW9CiMD3+kpjL0lZZRE=;
 b=Ur6Fs/0aGfQzjLuqRCfAz0BGAas2qgmgXsvNVyrOlP5i/xeKadLOcIIICg4GrjFKSww0LLW2S
 L3ZnxF2u9GQALSDhX7MJfOAl8MjDXFJvdJmp65KJ6aZ8/2DlSe8HpLa
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|DS7PR19MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1a7910-dff4-4c28-b409-08dd72ed4f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0JXZTI0TE1oNHVzZ2psdzZsTnhZbTVsMzNVanFJSUx1VnhKRXljaVhwT3Nm?=
 =?utf-8?B?eU16VmFRMDZOZTFacG9ZV0R4aTRRREFrZWtOZmRDR1EybHJIeko3SnBZRTl5?=
 =?utf-8?B?MjM4WExRVGVTbVRNUFBjZFZCM0lwQnhEU2g4SnltS3FCUVUwQS9LYnBkSmpn?=
 =?utf-8?B?eUJoWG1SK1RER01rSXBRM3FRVUVlY1JqZkJCd1NtQXhuc1lvamtWd2JPMkpQ?=
 =?utf-8?B?cVo4UmsyQ0RocVlIZUxON1hZaEtWMUtNVVV2cStTYkpTMTdKRmtjMWJ3cTk5?=
 =?utf-8?B?M2Y3MzFaWFl6Njh0bUV4ZEl0RnBkRzduVStoOU91RmpQYmczYXNZaWJvblRG?=
 =?utf-8?B?YzBQMStybzRodHVtaWxOM0lCT3UzbXprNk5DdldLN0tVWndzUVZzcDFEN3Zq?=
 =?utf-8?B?NW00d1BJZUNUVkpWTGdTVWVjeUZBU210SitZMm1kb1lQVk5CT2JBVk42M2FD?=
 =?utf-8?B?aDU3T21QWE5YYnViK1BRekpUQlhTVGZSTERHUWZPamRzY24wdnlOU2ZZblNw?=
 =?utf-8?B?aG1FZnpoRURTdEZQZ1hWeEpVRGRFUHZ1bktnaG5lYlZIdnhYa0w2NC9sT1g0?=
 =?utf-8?B?Z2FJWWpTY1BkV1JBM3Nya241OFFCMXBvSi9wdlBxOWRja0pTSW1DVCtKbG1H?=
 =?utf-8?B?OUQ0SGtCNUdTYnQwc0xYOG5wMzJMaHRtV1JXcG9FczFlV3FDZEYreWlSTk5i?=
 =?utf-8?B?enBQd3RNMzdjaHJGQk1GaDRQSjFHb3VCN29hSXI1K2pYZXFjRmhsZDN4eXhh?=
 =?utf-8?B?V1g4Y0JCdWVZb3Y3cjlQK2xKU0xMSUc4Q2d2ZDU5T2V1Tm1NRmUva3JYbGtm?=
 =?utf-8?B?OVRZV3IxMW5DYVJoMHRhRWFJeU5LaElYcTVSaGhiVFB6OEZYelhrY0I4alpz?=
 =?utf-8?B?VStMT1Bscm5BdVIvRUFxSU1LMzJpcUlHNy9yWjBidUpCcmxZV0lHN0ZGd3RY?=
 =?utf-8?B?dTJYRWpKVThZVlJzUmFITXl3WHIwV3pna2FDMnU2Vnp2V2pTVHY4K2t0UDIr?=
 =?utf-8?B?ZTNUUzA0c0w5eVNIaUNtWXNDcCtuNkxzWEFadVZtRi9pc2xiWldHY1lWbkc0?=
 =?utf-8?B?MlhTT3QxUnhRdXpMdDhHQ1o3NWpHclVzTGtWdFlrWWZvK3FUbXovSTByR3Jy?=
 =?utf-8?B?aUUwTFVKWlcvZHZUUy8yU3l4d1I4OWU4d2VjZEZoWFF6cXBESW9KcWVkNUdU?=
 =?utf-8?B?b2NhMThwMVNHSmdVSDY4YjluSDJYeG82QzZYZkEvZW9wRk9oV0NlWHp0cFJM?=
 =?utf-8?B?ci81cnBabTl0MjJXTFpqQ05PSzhnT2oyQjBzVXVEUGNJWlZRd3JKZHV2VllC?=
 =?utf-8?B?NHp5NkNIb3R4eG1wek13ekFzd3g0b3hXU0M1SUpqY29LRXMxK2R6OW1IUmFS?=
 =?utf-8?B?SzVvSm83enpqN2xWYkozZUl0ZzBlRklKRWM5Vys1RkorN0x2VFpyV0d6MjJE?=
 =?utf-8?B?b0lzZzJjUElJR3RtNk8veFBGOS9HM1o3L3h5V3JwMER5TDQ0NUl6QXZOMlRU?=
 =?utf-8?B?MWpkMEwyaUZ2Rjd4d2wwNHlWL05tYVdWZS8vMXFQbUx1ZFh6OU5wbytsNU5u?=
 =?utf-8?B?bDd0cDdjaTM3aVV3bzlWRTJtOVBMMnFia2dEOFJsMEhiSEVaREFibERiYkZp?=
 =?utf-8?B?RDJGV20ra1NWSVZaUXZYZmhkdFlNaWtVUnFZSFRYRHpLMUlIT1BJR2IxaGpE?=
 =?utf-8?B?Z2xicmZ1Y2pIQytuRzNpSW5VeDZPQytlc0lMTXBzNHIrWk54Wkl3Qk5ENm8z?=
 =?utf-8?B?U1N5Z3oyZkJzSkdrNHRrSWJoRko5RVBNNTNvVndVU01PYmt4RTZ2UHo2ZXh6?=
 =?utf-8?B?c0NUTjZHZS9uYzhKOXNYWVlpbjNCb1VDUUxwWW1yZHZjRU1UM2I3KzFwQ0V5?=
 =?utf-8?B?RHVqLzNEUCtwTDh5VHMrWXpEbGhSZUxtM0VWQjlVeW5PNUpGbWIwMHFxWGtu?=
 =?utf-8?B?VGV3UUovMjlFdU9xSGdGbGx6ZGptV2Q2WWVybTdFQ1VDb0FzWXhLdFkwQ3lG?=
 =?utf-8?Q?QNQlJB2mWTAD63+hkzFtT67rjD9Nag=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4+QbJzoANcAVfhh/vOQm3tiBUFQ4DPt9sx4vW6i2UJB397wv6CaQ/gjZy1PmLGHbK3+XS0Jecv2BhauQxkxQrTLnde51fQpmzZqb2YRzLNaFKONZzd+pcRWRCo6QFrZOzlKR6K2BZnma46NtWcLHb1BzYBcWzWpWT0MzkvH44fqVFm8Of1j6fYbxVZ8aOzkiX5dJS2SS+guQVRdofSXLDxWElyOgazZRdovlfiqH+jiWNJUTcu+TOA/wi66KV45zzyU+XXzyRJYqEa4ZGj3TswQkP1lKaaSt7z/TFtvgiM1KzHl3s+QLK5jlvkrJei+/Mo4LfV5qXJzIPP9Id20x5ook7sxslGOifJB8VdM0uBVG/AhdYEcqVwquAtSfMOrE0HLMWMM4ioBFtFLfCkmA2szEmc6sYw1cnHW27NrP3FpTAPur3ZQkF33vmxoEkW+M6TJw2ikssYe/0zWc0KZI1ZYoX5jnWSTbYI2BQEbREQIGGgDPmxPffsf9uQ9h05TYdn9RdNY8xjTH8GZMRVqWzvYUzkYerjAHaUt+qLzPROuF9C6YqMrk5XZ+Tz4dORv50ngHbWN738IkjY02ASA9urj4UFcEX+We+fzZjQzm2CGRvUUr2nZGCmHOs0z58mxt9fztHkP0xcLCUneUXMecxw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 20:22:52.0946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1a7910-dff4-4c28-b409-08dd72ed4f6d
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB7700
X-BESS-ID: 1743711776-110524-1328-16626-1
X-BESS-VER: 2019.3_20250402.1543
X-BESS-Apparent-Source-IP: 104.47.56.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGxmZAVgZQ0CDZyMLE2MDUwC
	TR1DIxNc0gLTHVJNkyzcQ8ydQiycxSqTYWAKVqchFBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263629 [from 
	cloudscan20-57.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

fuse_uring_send_next_to_ring() can just call into fuse_uring_send
and avoid code dup.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 5a05b76249d6fe6214e948955f23eed1e40bb751..c5cb2aea75af523e22f539c8e18cfd0d6e771ffc 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -667,6 +667,20 @@ static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
 	return err;
 }
 
+static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
+			    ssize_t ret, unsigned int issue_flags)
+{
+	struct fuse_ring_queue *queue = ent->queue;
+
+	spin_lock(&queue->lock);
+	ent->state = FRRS_USERSPACE;
+	list_move(&ent->list, &queue->ent_in_userspace);
+	ent->cmd = NULL;
+	spin_unlock(&queue->lock);
+
+	io_uring_cmd_done(cmd, ret, 0, issue_flags);
+}
+
 /*
  * Write data to the ring buffer and send the request to userspace,
  * userspace will read it
@@ -676,22 +690,13 @@ static int fuse_uring_send_next_to_ring(struct fuse_ring_ent *ent,
 					struct fuse_req *req,
 					unsigned int issue_flags)
 {
-	struct fuse_ring_queue *queue = ent->queue;
 	int err;
-	struct io_uring_cmd *cmd;
 
 	err = fuse_uring_prepare_send(ent, req);
 	if (err)
 		return err;
 
-	spin_lock(&queue->lock);
-	cmd = ent->cmd;
-	ent->cmd = NULL;
-	ent->state = FRRS_USERSPACE;
-	list_move(&ent->list, &queue->ent_in_userspace);
-	spin_unlock(&queue->lock);
-
-	io_uring_cmd_done(cmd, 0, 0, issue_flags);
+	fuse_uring_send(ent, ent->cmd, 0, issue_flags);
 	return 0;
 }
 
@@ -1151,20 +1156,6 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	return -EIOCBQUEUED;
 }
 
-static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
-			    ssize_t ret, unsigned int issue_flags)
-{
-	struct fuse_ring_queue *queue = ent->queue;
-
-	spin_lock(&queue->lock);
-	ent->state = FRRS_USERSPACE;
-	list_move(&ent->list, &queue->ent_in_userspace);
-	ent->cmd = NULL;
-	spin_unlock(&queue->lock);
-
-	io_uring_cmd_done(cmd, ret, 0, issue_flags);
-}
-
 /*
  * This prepares and sends the ring request in fuse-uring task context.
  * User buffers are not mapped yet - the application does not have permission

-- 
2.43.0


