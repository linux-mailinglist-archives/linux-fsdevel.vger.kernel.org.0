Return-Path: <linux-fsdevel+bounces-65222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16662BFE66C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2321A04D77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 22:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC94304BDB;
	Wed, 22 Oct 2025 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="QOAkH+QO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA352F12B2
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761171702; cv=fail; b=GMaUM8Ed7ApNfheBokI01UNdtL5hYARgA56u2lbtu5XAADLqivZg7RDe9EommFS6id5eNGGp0Ecmx4vBtvVUiYkL5aPLIPdcyGGIHhoon4wKRGqHVL/JS9eobWbRB0Zauf5EImSozOv8dhqWqGyqKqGNv9rfK4H52PGP0UHc1Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761171702; c=relaxed/simple;
	bh=5t6OJBUZ8J688hszfvtDpuCrK+9g7BTgunb/mO7f3+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AtlrpNYB2WbPcQbs8zOeLoYeyy59La6MpeZHYH9QcPi7MLu1kgQCSbkf6ghdH14zlAgiDs2wimJo++yQkQvNCzZ0QbldQ9eqGwUlli32sGTcvCycJux2wI8RT/717XC63v54eh+uEH/fX1pJDW5Fwsv2HIB/4HdDiupHhrCI4KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=QOAkH+QO; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020125.outbound.protection.outlook.com [52.101.46.125]) by mx-outbound11-172.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 22 Oct 2025 22:21:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZJArhbrSqLSCX5SiCsOXl3MNkoj78qbGK7e+Tpz/One0WiSayrkrRrR6ePoOiWZUzTdU/Ix8pgC/ySeKQS+m58hR3fcwYagbkQuSc5VdM6vmWM8yleG3SYzhXGCjC7ZUaHBQX1AMJyjyvfmFO7VYN9Nw0Dy6CKl7URu3idt2pQwQ71nssmp1YKd1c9o1rqH3ugJ+ipzk4cXFrCA/xrQFdeT3OyVDj7nKMKb84ZHd2mBed77M/TQK+NDrZNkYZNF0eIv1kkPQeBHI6WjhD773lshaoW00/BCDC75DcAbzS9RNMgbjiSp3+mLiz0oX+18rsHpizuFCbsEqLxOo+03cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIavt7bCtbXz8vDD58ck5bEklJ7/n00hCRIOZBXwbPs=;
 b=Xpg/PxjXnPOX6eJoMb2M7v5eEHoDrqx+QSshhdmVtO+8yymaNobAVYTciGGDn0f1o0960jynsQxntdzI+Cx5y3oSV0vRQPMjJjFponDrzXDmFBPhJkVGtxMIcTryF122i5tv+n07NFHxuUJtqwVE3R+vNHF20VXifxhCLSeybKKlM4jZo0fqVHQLQHl6t8pq6t+9Qdvj0Z8b+37s++Nugzi64+SsxE3F2xpBcULzKaPzuBzv1zuw1ThJ/orif+tf8g3+vnj/deqQT0yRwMUe0soMjASGyldKE4EErF1D2NH6W9WSYfmOSfG7E6U1Isvfm7/UzNrO2nQ9ovT9CtQryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=bytedance.com smtp.mailfrom=ddn.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ddn.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIavt7bCtbXz8vDD58ck5bEklJ7/n00hCRIOZBXwbPs=;
 b=QOAkH+QOxGD1sWwZ+crSylnZ9xJYHYCXkGidoQ41VxgbC+4wJbTkNPjWOelt/GtO41xQgy7LgKD8S/yrIpDug4oZvr+CcAAOt+CTXBT5njPfBgKMf/gXqZ7jXadUzv1JU6m8oHtwfRYxUhODeqWaXsC3TL+hljY8z7kD+FYR3uE=
Received: from CH3P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::14)
 by DS7PR19MB4421.namprd19.prod.outlook.com (2603:10b6:5:2c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 22:21:22 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::fe) by CH3P221CA0003.outlook.office365.com
 (2603:10b6:610:1e7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 22:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Wed, 22 Oct 2025 22:21:21 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id C4A4B63;
	Wed, 22 Oct 2025 22:21:20 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Thu, 23 Oct 2025 00:21:17 +0200
Subject: [PATCH 1/2] fuse: Invalidate the page cache after FOPEN_DIRECT_IO
 write
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-fix-fopen-direct-io-post-invalidation-v1-1-3f93a411cd00@ddn.com>
References: <20251023-fix-fopen-direct-io-post-invalidation-v1-0-3f93a411cd00@ddn.com>
In-Reply-To: <20251023-fix-fopen-direct-io-post-invalidation-v1-0-3f93a411cd00@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Hao Xu <howeyxu@tencent.com>, 
 Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761171679; l=1002;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=5t6OJBUZ8J688hszfvtDpuCrK+9g7BTgunb/mO7f3+Q=;
 b=n3FmGXsc/ONUEGv0p9hgXq3OAf0EIOqgbX6+ouHMjase2NJZY9GB0Y/Lw7T49+0A+5QQcIQ6u
 j4Y0L3C+KHgCK5yWlabr+gaRA1KNNzfACBP9udqhBqfaExqx/rwwpsx
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|DS7PR19MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b53754-b276-4ab0-d46d-08de11b9546f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|19092799006|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUdhWjhacGhwbktHcFBIYXN3bmZYcXI1MDU3RkZoNG1MTmV6cHJ4OHFmMUN5?=
 =?utf-8?B?b1d3YjNuaDRrQmhzSkF4VG1WL3FUaWFWdHRNa0tKQ2JaZE4ybWJMdjQ2aGN6?=
 =?utf-8?B?N3E2K0ZtdVlabDlrVEI5c2lwbnNpcjVoOVEyeEdsMVlvL0FuRGwxbHNJQ2Iw?=
 =?utf-8?B?TTZsQXVSMHZuaUI5WmVSNHBSSTMrWWlBSzI1VXg0amZpckcyMStkWW53eW1T?=
 =?utf-8?B?UEwxeGtMYWp1ZjRqUEw1RCtPTkFuRmlXeXdyamN6TlhNUzUrb1BMbEMwZXNu?=
 =?utf-8?B?OVlwQUFaTUoyTTI5anNxdkJqSi95SzYrNDcxcEVPUmNJODBEejQweXdIZWow?=
 =?utf-8?B?bUJZSGV6azBSb2VSMjVQR0VIVEVDUExFaUY1VlJGeWFnbVZsTmJ3L3dwQkhT?=
 =?utf-8?B?NjBPeSt2WkRkdXQzbjkyQUwrTTU1K3grWmJTcEdOWHd5Zzkwd0VMYTBXZkZB?=
 =?utf-8?B?NHh0VzhncS9LTW02MVhSN1M4YnJMZFNlMmZpTElBd2JtNlB4VW5lK29PZjVY?=
 =?utf-8?B?WWxTUDZwRzZtakcxY3RpVFlaNlhYZkZvMmN6bnN5VUkvRW5xRjZNK25oemZ6?=
 =?utf-8?B?cDU5TFpNYlRSUEREbk92ekpoRk1yNnNaWjF0TDc0SUJwWkl6cUg3VS9sbk9E?=
 =?utf-8?B?U0JRN2dLTG9yNWRsSDAzM2g5NnhlK0h1RVNaTSs1a21FcldrUFl6NUpaUEdJ?=
 =?utf-8?B?anI4YURMa0VtMkRmT3Nja3RTdzNqdDhIVkFnU3BhNmRoeCtiVGtraEdXajBq?=
 =?utf-8?B?NDM2ZDRKQ0Y0ckhXRjd1VUxRVnRmb3o3UC93Tkp3cFBPVnBoTW9PdEhGa0hL?=
 =?utf-8?B?RUtaQWQxMlJScW5yL08vOWkzMlRpK29rczVpY1RPNnMwemdaYU9LR01tbUYz?=
 =?utf-8?B?ZE1xU2wzdWRLNVk3VlFJQ0wreG0wZjgvWVdLV3hmMUlQZW5NOSs1RWpJcnpQ?=
 =?utf-8?B?aFFoUVh1cW0vajAxYy8rSzVHb0M1K01pSk0xZkFDWTY1MlZ5NjNYd3BRWVJS?=
 =?utf-8?B?Z2VYeVNSMW1NcEV4eUVickhSaTlNdFNOb3RUQTc0ZzJSQ2FXZFozNzRyZ0xF?=
 =?utf-8?B?UDlaa3JYS0p4VFFwWFQrVnowM1VSZ24rcWE1NnN6dlBmaGp5MlB1bC80ME5m?=
 =?utf-8?B?UHp1RDZaR1RlSHpaNjNReWtOaXhQejZHVGlOSXpkOGdLN1c0VGVhM2w4YlJV?=
 =?utf-8?B?enpXZVhIcU1RYXV2U240T2FOZ3FoNWZhV0JWSFJGNERLcnAyQlZqY1hpUXM4?=
 =?utf-8?B?U1UvZCtMRmw0TE1sTjFxR2xnN2ErTU9BNUtOdUlZMkhITnJ0Vk5LeU9lV0Vu?=
 =?utf-8?B?RjdXWUx3M1MxanJrZEZLOVpnT0IrOGJNbjJvZGRxeDVhOVMweVFyQnE0T1Qx?=
 =?utf-8?B?R3hicFB5bWFMWHNuUkVDM3VnakZBc0ZUblhyaVBIMWJheVp5NW5uR1ZSRVhB?=
 =?utf-8?B?Tkt1Mm9odDMyWkZJcmVNWlljNjFFcTlVckpsTWpZcXU3QnZOL3hqVDNhc2M5?=
 =?utf-8?B?RzRVaGxQa1J2M1dmSFA0b1VCaE9zN1VxdUpzbE5LYlE1VXA1SVF4WjIwc1pC?=
 =?utf-8?B?d2wremNybjBKa243V1FOVHVhMnJLR1BEREVpQ2ptNk9XcURtRWRuWHk2eFdu?=
 =?utf-8?B?Y3FhL1VsVktzRG1IUFFXZmZqbmxpYmdObVRxcWpyeUdqaEUxVjcxM3orWUZq?=
 =?utf-8?B?Y29IckNSWnQ3NE41bTBxN3pZMWoyck1qWEdRNFZSbzJMSTYvazJMSGVPZ2Uw?=
 =?utf-8?B?ZFFyMDV4Vm9QZWdyZnFJeTVuSkg0d2lGVzduWlQreW9MckpKbytMSmdCVkhB?=
 =?utf-8?B?eW9HSGVPcXMxT1lLbS95M3BpMDFNV3RrWE45U3ZwR1RSbjNNa0VWT1d0TFhD?=
 =?utf-8?B?ZUd6KzFjbFZ3OEZuMnJ2czQrMXN1aW9NWnRtcVN4QmxKTHlYak9WL3ZhQWRw?=
 =?utf-8?B?Ym9vZjI5L3F1dDhRMHpHUWl2d3piaW1zejloZ0Q0TGRqLzBDRXJmbVh0SXp1?=
 =?utf-8?B?bld3WVNCUUx3QThvanhMeHoxRG84WVB3a2Z0Vm9sbWdyVXlaNGRLSmJ3Y3cy?=
 =?utf-8?B?K0I0MHdkVDRLdjhqcHowbGRUaFdYc21icDJvQXZmRHU5SndTWVo2M0toeTdk?=
 =?utf-8?Q?fGX4=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(19092799006)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1q9loBT8ELcrq3gwXNgAxQ8m+2wXUWGcFYRJibiJzvSYUO/GyWWn7nr0x1GzsQ3qbAy+hohPzjT89D9Wy9bKzBEX5mdhLJrre/RE+p5ZstMA0NgJReLHRCh0nXMuUCNn+CiMEo+G8HHdzKnhbVCIL/VrWG4bBwu91Cnl8ewGjAEu+dyn/BsnwAoTSEkmixe5uZagA8VVKlfNk24mgoPJJwZtrt+FgOo5aKkLVSXseWIEAYUaS07iZIHNVigvthFkvlgwPKR61WGAZSDPD86DfAaLzVX8/U2t4qNFVqzOF94MOMiSdSRxYUITQE7Yw8nhRZM0Kutpy0hX563+uB9u+kB8u4iWRSJobR6JcWlKjoQ7aK1A+btQKcta8wMuOzR3BZpqioulsrw4ToRMI64/e9PHGsk83ihsl7q6jrcqfgyNskGTXDjfVk0MDa8tqQX59xIG7I3gEBgeMWNj9LXfJQR0hymlX+FZ6zf5MRZXSXl83fjQlFveuHgSeuy8IXqOA6/HWwZtVz0c08h1vqqnWvu/80zvCZ3K8eQDTsmf/EtWbOohROTfBrq8e6e8oFp9R4vc2vy70bmrtJWcvshpVEvnYtj7BStvczN/Gn2IH7Ck2c8AVMube1MlcmbCBKRvdSbx7xhsKcS+7A1HuJihNA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 22:21:21.5094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b53754-b276-4ab0-d46d-08de11b9546f
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4421
X-BESS-ID: 1761171684-102988-9016-2071-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.46.125
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpZmlkBGBlAszcDUJMnEMtk8Ld
	k4ySjV3Ngw2Twl2cggOdUiydAk1UCpNhYA6dlvfkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268402 [from 
	cloudscan8-86.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

generic_file_direct_write() also does this and has a large
comment about.

Reproducer here is xfstest's generic/209, which is exactly to
have competing DIO write and cached IO read.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f1ef77a0be05bbee8991a0b1bdf61644e58b6c50..746c9113107e8f8b7e848c338a925025ddfd961c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1681,6 +1681,15 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	if (res > 0)
 		*ppos = pos;
 
+	if (res > 0 && write && fopen_direct_io) {
+		/*
+		 * As in generic_file_direct_write(), invalidate after the
+		 * write, to invalidate read-ahead cache that may have competed
+		 * with the write.
+		 */
+		invalidate_inode_pages2_range(mapping, idx_from, idx_to);
+	}
+
 	return res > 0 ? res : err;
 }
 EXPORT_SYMBOL_GPL(fuse_direct_io);

-- 
2.43.0


