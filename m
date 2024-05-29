Return-Path: <linux-fsdevel+bounces-20466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C838D3E60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 20:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E61BCB224D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 18:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052871C0DC4;
	Wed, 29 May 2024 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="hNQBDhW3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B024A15B990
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007581; cv=fail; b=TA486xAn54uQ+GMqlo78hLYGQCDKeCiqLCPT0hhGGjXvP/vdyCsxdjVVOLDbje9hu2i95RpsBFvXI9R+jnvvihEh5hJl1vZ5HHzC02z6T1CijKA9YpCKiyrN8P6uOPrs6JFEvUoH0MFsGRIFnMkB/psBwD4HsjJkzqx5rGwTlZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007581; c=relaxed/simple;
	bh=2oRBpghdIVzUmIomRZOx7rijf9klETRUjTUcOQyERag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=BoAhx63WaEZsyyQf7ubYUNUfxz88DbjV6Mvb9t+0HuNpkzuyNcw5amtlKLjR7B8qXm07JNSYBW0jAjms57BxZ80wV3EC/1OOFlQiTsos+BLXIrffuYvFminYFKorTl2P7ORF/Zb04mQvvO3rWhMeyaibtsC73lsUHiZYeryhwi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=hNQBDhW3; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168]) by mx-outbound41-156.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 May 2024 18:32:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMoJjpp/J+7JnKEpYP26GY4xTcQrQIIIm3JqPxm2TlVwH6/49+3xE3q3peaYJsoRqRDgw7xtvta+9zap8wQBBicY+AWFTfYusTXeur+KbUb0k8jr8gv7LyZN2c9eueI0aW0/2T5cG5lZ4Twn581ZS5VMgA34YvG6NZZvkLUxwEKCx11LUWJV4KBUbZDDfQ1VEzULvMPvWhDTNN6JFl49uaH08kvI2nTslIzN2jgDKSd2X544iGLT/tNcKVp91nmxfwdeO+9FJc0xouBWnXhFe6CmhJOVjD3sQmbbde7IlFCVHJPgMW9MCXuTKyYbm6s1BeGSU//JkzbuaYXY3LD2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVzBvKl+FMCpgqb1qLNeCiaW0jRxWaQYCrVD+BGV2nQ=;
 b=KWVumjVMY7jtgNWn2PUIHZjRXNC92+258HktujTztWAFYtZ5ylle+MdgEfh95FG+5agt2cZbT50RL9ssnbSrq0Xxx7TYZUT13GY+iVCMBR8JLerdUhvQUgna6trdNMwBkpzd5wRr8WPpIu4sH+/B/y9zjz8q/C23bbB6m9FtZYRz4TCh/WUteC/sNfG/JtrqDRSu7BsPkmxAZi9r+FCU34JLlXGf7LzujdnMaW2E8sBTYzuIS2aiy7OnYUbjpfm3w71/1C0FJGZd2AMtwsIKcvsTDjT+kuGi5ZGSn0PrlwcneoDryxA6MrYeceah41DZf5JhpxLqs6u2DFMyyZX+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVzBvKl+FMCpgqb1qLNeCiaW0jRxWaQYCrVD+BGV2nQ=;
 b=hNQBDhW3ONsK/t5LqtbcPFml/ehDDyhmOaP8raCq/yO2pWMVW/CrH+wntne1sps8DAUhlm69XlLx4Dg/uKgOb26BjRj20oRBhna6b+/JxHmlpmB9V535/tjV4hhOSwLSw6cI8dePbqyxzRUGI7PTdqnKDxZ6Sxebs2/g1A85DQk=
Received: from SA9PR13CA0147.namprd13.prod.outlook.com (2603:10b6:806:27::32)
 by CO1PR19MB5221.namprd19.prod.outlook.com (2603:10b6:303:f1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 18:00:54 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::e8) by SA9PR13CA0147.outlook.office365.com
 (2603:10b6:806:27::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16 via Frontend
 Transport; Wed, 29 May 2024 18:00:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 18:00:53 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 2D79627;
	Wed, 29 May 2024 18:00:53 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 29 May 2024 20:00:39 +0200
Subject: [PATCH RFC v2 04/19] fuse: Add fuse-io-uring design documentation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-fuse-uring-for-6-9-rfc2-out-v1-4-d149476b1d65@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>, 
 bernd.schubert@fastmail.fm
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717005648; l=6989;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=2oRBpghdIVzUmIomRZOx7rijf9klETRUjTUcOQyERag=;
 b=Yfj94flXUxOiHkrpgmCnqepkj00eMggRc0IBC7d4VDZZlyXgtD94CKYZDUmeUKX4j3b3i10yV
 rycp9/EvLxgCfmHLctTCNcM2wTN6g3YO3/H7f1Q+KohT9peVJdxKdnu
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CO1PR19MB5221:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c2b771-85cd-498e-6541-08dc80094896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Njd2U01CRDRtZS84QW40UVJRMnVYdWltK3RQNURuUkJaYkhXUHpNdVVFUGhq?=
 =?utf-8?B?OHZTUTNSZzE5UzZmK3o4SkI5czVhZUk0TGExZk95WmlHT1V5dWFYR1p4R0g5?=
 =?utf-8?B?b1NNbmlqWnNRMDZGOHYxTEt5QjI0TFpxN2w5WWR6TE5XSTNHeGNXWVJSQTFo?=
 =?utf-8?B?d20vYSt2K0JaU0xZZS9xbzJ2RUh1N0pRL1dtRXZueGdlSGNVdGpENUI3ZWxa?=
 =?utf-8?B?Sk8zalUzdkNYUFZBT1ZpKytPRy9NbVBkd3k0QVVYLzhTcGVFTm40VDJRZXJQ?=
 =?utf-8?B?NWVTR054UHR5eFRtQ1F1V0loRDd1MGxsTzR3ampscVVVU2wzb3M5YUs1amlB?=
 =?utf-8?B?WFl4WkRXVUFBbU1hNjNla0JFUWp6dnBEUDhTZE41QXlxL3QrWnBWeC95OU83?=
 =?utf-8?B?RnlVeHdmUXBRbmxyc0RmMEZFbGtueXdJcW1VT3NWZ3JtbTJkMTBmSitwZjBQ?=
 =?utf-8?B?UXpOMmZ4eVRCMGdBeW5DVUZ2L2MxNHNHTmtRbUhQVzBoUFBVd0N5MEt3YXh3?=
 =?utf-8?B?WFdkYlpFWjJscDNwSytsaEEzY1Iya3pHU1NJSHVmOEsrMVpPbElPYit3QVVl?=
 =?utf-8?B?ei9SNXBiblFXWWh1VUtmOUZwSXRscU9TaW9iZ1laVnhQMGJmZlMwOEErR2hu?=
 =?utf-8?B?R2JtTFR6cnRDMEZqZU9ZcGY5VURzbE5mckR3MkExa2llbHBYcEQ2aW5oL0tT?=
 =?utf-8?B?NmhsRW1yU3pLOVRIR2N5QVJRaE1WUEV0ZmdWUUp1d0hVNkZMWXBqNHRtcmoz?=
 =?utf-8?B?WTJvZFNVTEt4bmRhMFVyeEs4c0NsVGFLSE1XdVd3dU5vWVM1MVVOWWorQVdl?=
 =?utf-8?B?VTNwUEFYc0lxamxLTVFyQTRrQk9LYlo0WUk3VnFpa2lTSnVNRElLTTdKL25Q?=
 =?utf-8?B?QnRXVjRmOTZIMEl5cVQ3NjUvNHNiVGpsWWpTMC93OEMvNzhlZWN1M1FtbXJN?=
 =?utf-8?B?NDRxSEhDOUZjMUtsUHZmT2dyOWNVek5rOENpUVgvYm91RmV6TWNiMlRWRnZq?=
 =?utf-8?B?eGx0cW1DbmtvMURHNXVZWFYrakt6S3NxOFYvdStOTUU4MmZpeFRCMk1QUXhw?=
 =?utf-8?B?bjZYQjhhbTZPaWlVbEthdkowVkovMEsxVnNKWmo3NFVWcDlZRWc5eHJkSGcy?=
 =?utf-8?B?djUrd3k0WU9GT2kvcnRvbXlkdUpMaXVwMG02UDhRYnMxSUo1UVpFQ0ZyQ3hT?=
 =?utf-8?B?d0ZYVXA4TnhvU05rODNpK3Q1OFBQV3VybEkvQW9FS0lmendmOFFwRHZWZ0Nw?=
 =?utf-8?B?bFlzZ3pFUC9yYU9ya3Z1S2ZnWEU3N2Vzb2ZtRktGSkdFOVlZQ2VPMlk4TEZk?=
 =?utf-8?B?RzZweDRZY0xyd3l4YjFQR1JSRDAvMzFibjB6TkZOd3lrNkdrQ094R2VBbGFH?=
 =?utf-8?B?Ky9RS0VTeVNOSE5BZzdOUmpPRk16Sm1tSnFaSkhNL0ttZytSK3FVUkswSjk2?=
 =?utf-8?B?QWJWL2c3QXhhYkhMdlNJU3VCMFdVMEhTa1ZrKzJvMDBxMzJ6K3hCbmxjT1Vw?=
 =?utf-8?B?ZzJmYlVTQTc5K1FoODNkQVJUZEloM2NKNDNldWMrLy9jZjZlM0Z1eklTdmww?=
 =?utf-8?B?WTlFMmszb1ZBRHd1Z2daeVNtYW1UREQwN0s5bHRsbU9sRktZcVNTVDJWbnUw?=
 =?utf-8?B?bGpTMDZQTWVCQnUxeERZUFRIeUt4TFFyWXM1emkrSExxNXh0YnRkVVhpL0lT?=
 =?utf-8?B?c1lPbGxFVm1LdnN2cy9lN0lYQ2xBaER5SGw5ZVZrM1d2WVl6Wm5yZlhPejJ4?=
 =?utf-8?B?amtIV3gveXI1M3g5ZkIzMWpveWhKNEpuU3hqaUt4emZ4ZFJNR3JNU2l0YnFx?=
 =?utf-8?B?Y1Y3VFhJZlZXTkJtWkV5V2R0ZkhMS0l1eE1vUnpZYjl0d0I1aVdpNHQzOVhv?=
 =?utf-8?Q?OwP/GGzJ5deem?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pXkyx3z958LzrmGxmBjK2HToP+0c+QN/8uF3Nybvw4AMm5knUwXidtYUk9XKKjBaiCaQmyi77TC/GA8CS8AA5uUIG7qFq65FaWkW4JBR5yWo7VVdReG3q1CogAB87DluACpJ7aO8GXkGlIEuN/UD8olTIAJJT4HmgzTbzfK/jUML1aTruuRuRtc/SCdiMB2SWc83DVfFd6EiCz3TnOy02z5J5p2raKWLhYv04mJqcOMLiryZtS3X2sm/T+nJGnULp0ot+2RSz4zvFpAla6ZkxLa8B6ygQ75+ADz6ycB7BkaW35zSqAKyfp9mtVmEEctMLNMblDH5FtTrQvoocObJHGUMHdByhvZjpAjQdxLFD9YwSWyz5cS+GVG4ib7cjDKbP2bwDq2xpbO4mxohNlcYdlM5O34Gn3f+emoQ5Ot7WsvceLzBcQreR2J84I7ATvdJjukweHsbu7CqxqqdtHSdfcgWl3SYSwvFtkLLT1z5XEjyltboL56u7y53TK7ZedUNWobv2r0g5wPkLLpX6BMrXQaycZTj9pPjOxcpylALwkwqfuPw9FkiDvdXw062GH0nvUCPUHJeAwOMjfpjD+ZBSnXYogmQMiAuZln674mndJRBAG6R4kUZVxyPrXISHbMz7JltCdFHJVUyCcB7PNApgQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 18:00:53.8300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c2b771-85cd-498e-6541-08dc80094896
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB5221
X-OriginatorOrg: ddn.com
X-BESS-ID: 1717007578-110652-12831-23228-1
X-BESS-VER: 2019.1_20240429.2309
X-BESS-Apparent-Source-IP: 104.47.59.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmYWBpZAVgZQ0DzN0NQkNcXcwC
	jVINXU3DwpzcIkxcQg2dDS3Ng4xdBIqTYWAGWnJZNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256584 [from 
	cloudscan10-167.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 Documentation/filesystems/fuse-io-uring.rst | 167 ++++++++++++++++++++++++++++
 1 file changed, 167 insertions(+)

diff --git a/Documentation/filesystems/fuse-io-uring.rst b/Documentation/filesystems/fuse-io-uring.rst
new file mode 100644
index 000000000000..4aa168e3b229
--- /dev/null
+++ b/Documentation/filesystems/fuse-io-uring.rst
@@ -0,0 +1,167 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================
+FUSE Uring design documentation
+==============================
+
+This documentation covers basic details how the fuse
+kernel/userspace communication through uring is configured
+and works. For generic details about FUSE see fuse.rst.
+
+This document also covers the current interface, which is
+still in development and might change.
+
+Limitations
+===========
+As of now not all requests types are supported through uring, userspace
+side is required to also handle requests through /dev/fuse after
+uring setup is complete. These are especially notifications (initiated
+from daemon side), interrupts and forgets.
+Interrupts are probably not working at all when uring is used. At least
+current state of libfuse will not be able to handle those for requests
+on ring queues.
+All these limitation will be addressed later.
+
+Fuse uring configuration
+========================
+
+Fuse kernel requests are queued through the classical /dev/fuse
+read/write interface - until uring setup is complete.
+
+In order to set up fuse-over-io-uring userspace has to send ioctls,
+mmap requests in the right order
+
+1) FUSE_DEV_IOC_URING ioctl with FUSE_URING_IOCTL_CMD_RING_CFG
+
+First the basic kernel data structure has to be set up, using
+FUSE_DEV_IOC_URING with subcommand FUSE_URING_IOCTL_CMD_RING_CFG.
+
+Example (from libfuse)
+
+static int fuse_uring_setup_kernel_ring(int session_fd,
+					int nr_queues, int sync_qdepth,
+					int async_qdepth, int req_arg_len,
+					int req_alloc_sz)
+{
+	int rc;
+
+	struct fuse_ring_config rconf = {
+		.nr_queues		    = nr_queues,
+		.sync_queue_depth	= sync_qdepth,
+		.async_queue_depth	= async_qdepth,
+		.req_arg_len		= req_arg_len,
+		.user_req_buf_sz	= req_alloc_sz,
+		.numa_aware		    = nr_queues > 1,
+	};
+
+	struct fuse_uring_cfg ioc_cfg = {
+		.flags = 0,
+		.cmd = FUSE_URING_IOCTL_CMD_RING_CFG,
+		.rconf = rconf,
+	};
+
+	rc = ioctl(session_fd, FUSE_DEV_IOC_URING, &ioc_cfg);
+	if (rc)
+		rc = -errno;
+
+	return rc;
+}
+
+2) MMAP
+
+For shared memory communication between kernel and userspace
+each queue has to allocate and map memory buffer.
+For numa awares kernel side verifies if the allocating thread
+is bound to a single core - in general kernel side has expectations
+that only a single thread accesses a queue and for numa aware
+memory alloation the core of the thread sending the mmap request
+is used to identify the numa node.
+
+The offsset parameter has to be FUSE_URING_MMAP_OFF to identify
+it is a request concerning fuse-over-io-uring.
+
+3) FUSE_DEV_IOC_URING ioctl with FUSE_URING_IOCTL_CMD_QUEUE_CFG
+
+This ioctl has to be send for every queue and takes the queue-id (qid)
+and memory address obtained by mmap to set up queue data structures.
+
+Kernel - userspace interface using uring
+========================================
+
+After queue ioctl setup and memory mapping userspace submits
+SQEs (opcode = IORING_OP_URING_CMD) in order to fetch
+fuse requests. Initial submit is with the sub command
+FUSE_URING_REQ_FETCH, which will just register entries
+to be available on the kernel side - it sets the according
+entry state and marks the entry as available in the queue bitmap.
+
+Once all entries for all queues are submitted kernel side starts
+to enqueue to ring queue(s). The request is copied into the shared
+memory queue entry buffer and submitted as CQE to the userspace
+side.
+Userspace side handles the CQE and submits the result as subcommand
+FUSE_URING_REQ_COMMIT_AND_FETCH - kernel side does completes the requests
+and also marks the queue entry as available again. If there are
+pending requests waiting the request will be immediately submitted
+to userspace again.
+
+Initial SQE
+-----------
+
+ |                                    |  FUSE filesystem daemon
+ |                                    |
+ |                                    |  >io_uring_submit()
+ |                                    |   IORING_OP_URING_CMD /
+ |                                    |   FUSE_URING_REQ_FETCH
+ |                                    |  [wait cqe]
+ |                                    |   >io_uring_wait_cqe() or
+ |                                    |   >io_uring_submit_and_wait()
+ |                                    |
+ |  >fuse_uring_cmd()                 |
+ |   >fuse_uring_fetch()              |
+ |    >fuse_uring_ent_release()       |
+
+
+Sending requests with CQEs
+--------------------------
+
+ |                                         |  FUSE filesystem daemon
+ |                                         |  [waiting for CQEs]
+ |  "rm /mnt/fuse/file"                    |
+ |                                         |
+ |  >sys_unlink()                          |
+ |    >fuse_unlink()                       |
+ |      [allocate request]                 |
+ |      >__fuse_request_send()             |
+ |        ...                              |
+ |       >fuse_uring_queue_fuse_req        |
+ |        [queue request on fg or          |
+ |          bg queue]                      |
+ |         >fuse_uring_assign_ring_entry() |
+ |         >fuse_uring_send_to_ring()      |
+ |          >fuse_uring_copy_to_ring()     |
+ |          >io_uring_cmd_done()           |
+ |          >request_wait_answer()         |
+ |           [sleep on req->waitq]         |
+ |                                         |  [receives and handles CQE]
+ |                                         |  [submit result and fetch next]
+ |                                         |  >io_uring_submit()
+ |                                         |   IORING_OP_URING_CMD/
+ |                                         |   FUSE_URING_REQ_COMMIT_AND_FETCH
+ |  >fuse_uring_cmd()                      |
+ |   >fuse_uring_commit_and_release()      |
+ |    >fuse_uring_copy_from_ring()         |
+ |     [ copy the result to the fuse req]  |
+ |     >fuse_uring_req_end_and_get_next()  |
+ |      >fuse_request_end()                |
+ |       [wake up req->waitq]              |
+ |      >fuse_uring_ent_release_and_fetch()|
+ |       [wait or handle next req]         |
+ |                                         |
+ |                                         |
+ |       [req->waitq woken up]             |
+ |    <fuse_unlink()                       |
+ |  <sys_unlink()                          |
+
+
+

-- 
2.40.1


