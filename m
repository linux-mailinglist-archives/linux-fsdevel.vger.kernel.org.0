Return-Path: <linux-fsdevel+bounces-69180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7136C71F6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 04:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DD6A4E48F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 03:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90C02FFDF2;
	Thu, 20 Nov 2025 03:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TeAfHydm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEFF28689B;
	Thu, 20 Nov 2025 03:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608785; cv=fail; b=CGBR3IqyDUXMMVWQinErS9ssiwZpQEGHDLnZ4lfv5IATtd60z6jsM2j8rXhUboc+1e17fk/AvknsdE/zh1DrNCYur04/l15EFuDmszopj3tWhdJgegJ/b0lY6FSajJR5VtS4CSbj7iGpBx0A1CuVogjxWKPFl1rIGP27aO0j8tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608785; c=relaxed/simple;
	bh=A0ZvGWvLQiYUuyCwQmHWKHsHYIK3WZ0NrmRRYoEl5mg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZvbmo3lgmS2Vw6MAxDDSLaquwKRimZUFCjdXesJjYEH5Y+28JQMxfhPUKtLyQHNmlgnkkH3PUQjk527fhN0SF1Xso5wQkhRDYSRS9b6H7mBlmirZrjlAMqrphiL6hagw+gh8UjumC4iENuP+yrJzSTBx+L511/G/Mb+VJs/rP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TeAfHydm; arc=fail smtp.client-ip=52.101.52.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUUTaP9NJhmtGTtD1zWZ4LwKgg6mCIkhxqvALiXnYQLbkhdlR/2zrxLXe53Q2tqbHIglBDjYnSrJgufajcsm8sHJb1LSnIZYKACu/EUZneqk7M+Lj5DnDoo55d507P4W6XcJjREA1roM2hJI8epixfQLbOPQfzGqYg/gJecv14+sCc3cfrG2z39py+/wU7STqVPKDx9vVED5ktMDgQ0ZVfx/yILKZmuUcgx4F1iw6O616ToUrtY190TBhBakiSZ+O1gGywF6H7bRTfRzgYG+CvQRt7A6Z4oG4DsrakyJhoMIfC19Z/Pod4l39gGoZ7kIj6CsjQyAXOsES37b/DsEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuQHVh+laQ8UK0QlBKnoNwFubDNBRJndZX9SSxhErsM=;
 b=ZR5cu2mIUFiMtwsCj+tdqvTevxq8toNPnx1YGJ9QvQGlPs/e4rEvvWPEIhzXtiQga1leI6OBSRUYw9gBpu88+0OfvZY4uP6eVAo7aTq24sucx0WiUAIFen1DJxi2xYisUei/IeFqTPuXtPVXkcPAfewoYFwjdSOoyFf60VvLK/SQsNKmhMO8zrsY1q5lQi/H8q0VsZH9nCVw0WCO96DK4Ouzpb6L7oHj84iRdD/cflpeKCfQFuJdsdFjheaVFSzPLAeHjmz8p/KGLxNsdGa0WvbV9+Z+ohy9Js4RGUdhSbIg6B4knBKN3CJtL3SEeWKhEDqQCZt+7btModlMigItbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuQHVh+laQ8UK0QlBKnoNwFubDNBRJndZX9SSxhErsM=;
 b=TeAfHydmZsxR2ps4SEg8Uux2PtuHu6gli9DqMd2c2wDL3aWCIiYq7iGq3imgSvakxiOpsIvFjcsMM85wSUDvtvM7VbB3TKn4O4fd1PchkbIkoC7ovQMJUukNwpvJTAPcy0rkkXEQ8+a5E3F6HdEQ2+awlr9sqjHDqhTIUhR9f20=
Received: from CH2PR18CA0054.namprd18.prod.outlook.com (2603:10b6:610:55::34)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 03:19:39 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::cf) by CH2PR18CA0054.outlook.office365.com
 (2603:10b6:610:55::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 03:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 03:19:39 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 19:19:38 -0800
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, Zhijian Li <lizhijian@fujitsu.com>, "Borislav
 Petkov" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 3/9] dax/hmem: Gate Soft Reserved deferral on DEV_DAX_CXL
Date: Thu, 20 Nov 2025 03:19:19 +0000
Message-ID: <20251120031925.87762-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c33421c-dab1-4c75-d1da-08de27e3a3f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hhC1Gdhuzb5dp2pRT6lji7uFOOooXPA7nMAnotlNiLwR+Nye1x7v0/n2HDYR?=
 =?us-ascii?Q?zzsQ+0h25prH376rFIadkTGq9bXaMVhw84gDQP6P3AkP9+hUDk7FsZ5YUFcJ?=
 =?us-ascii?Q?bXTJ0+7ZBH8eRFcwCi+xx/YGuSEqANPZsCtyQvdN0pspBZa34jYr5vFQ3Mln?=
 =?us-ascii?Q?ZJmPl4o1EU+WVI8OBZlbSYJXM3iMWRX+peQhc0RZi8ZqB+S30mmdg5RKNeR/?=
 =?us-ascii?Q?WRx/jkbjHxmpAR9sYkhMAJbEnVza+BXk6MDRfMjHdGLARmdjK5P7JizoESso?=
 =?us-ascii?Q?xV8jo46ZauePP+afNAXCbkf15NuiOVzUei/2V/xzUxqKszF8DUOkejPJt9Bg?=
 =?us-ascii?Q?5wrSxJPW85dgl59aeOUCtCaCftQX4Z554gjkYnOPEbyQEpnmlH+iHY64beWv?=
 =?us-ascii?Q?p48cM6N89ovwgXfF0C+4T5paXZwXXodMOFxJYzOt3gdT1EBD2UIqOtRbqZQR?=
 =?us-ascii?Q?czMi8zT/9JrKYVbf1nfD4pMJ6xRV+bcwor2RkmRXBLrT1AVTR7mTLoRUOcIQ?=
 =?us-ascii?Q?cLTD/IV8KV3vsEw1iZV4Ee1y9sCwdsD3ZEX00KIHiqy6dmzyVCTro7/IutcM?=
 =?us-ascii?Q?el9r/3nBwQUrMQrUaNaV8hqd/WMHzoswThQ09FxCuZ2xkI4oLl9NziLnyCK4?=
 =?us-ascii?Q?oOd7ir4aVPsQvoGqHeCcDS2UudaijhqwgiikL81X28+b8Ok7zz1QZ8Q8hFhf?=
 =?us-ascii?Q?v5F2Dqhfcj1L5eMt1zaBOjrNm+7EHwd6ck6LTETw/Ief21GlVd6k3cLB4aqq?=
 =?us-ascii?Q?hanadx/07BkjahSIYT4IlPlPSUKOHskAw6HSbH8ke/GInI7IlZOKBKnIK+L1?=
 =?us-ascii?Q?LCeDGw+AUFmCstXsp/Hv9PXuA9rdPQ7b7IEVHpmy4f4YhOLBBgyW0G5PwASt?=
 =?us-ascii?Q?kuelJVQuZhnnZJFvwtCRhzahjG9DAIbYYsGQ++j7zVBl+OBWnigemttEbNXy?=
 =?us-ascii?Q?6nydg9awrMT6nDzQbCdaXaFuhoY5Z72ruXvxISs+r1JQxRb0nu/pEq9S9xbd?=
 =?us-ascii?Q?4HX/28lJbz4VbV+1wNYt9Klnje/YAiY3yR5RAI3HhJIT41FKCAYiqXWrXtpJ?=
 =?us-ascii?Q?oxmTwwRG+JyOU13XR9lsMGcw3fR5QufrLOh1jGzW/thSFqsjTw5D0OqOdVlY?=
 =?us-ascii?Q?u0ORWNe0UgVdsu2kUo3RqFWhPJq9wtYr3LbIE64m+AuzvR/PAJBZL4ZK2SXQ?=
 =?us-ascii?Q?GZUg838ZEg+ODqgBnI3fgo4OZ0jCdjoTRfBa9aiWFaySjVbtFysxmS970xd+?=
 =?us-ascii?Q?K4MMxiYkDlCXD75nxXSOtTeZwKy4n3BHcPrNc0bOGIW7mlC9veCqh8VoXeXT?=
 =?us-ascii?Q?Y+xGbjQNfT+gH1NOXfBlHfeA3/m7LeF5q3ODkCtcTA+zs/QxMC0TFqoYcSpB?=
 =?us-ascii?Q?K5/wmqNh08KbNWEhfR0xstg8eMEmou0AtbajngJ9T40d3+t6TV55Sjl8YTV1?=
 =?us-ascii?Q?uNYRO7zm+pbhJwawe5Yq2FJNWEwT27Ogu4W9qOzCsp2r44o54Ljg7bbmlN3+?=
 =?us-ascii?Q?PrR/dWLdADhCCRvwx7i7mnUzb4raCRbzKTqTOSgbK+7Uw0Ty2fKhQJqCM6q5?=
 =?us-ascii?Q?DgrJYRRU5atjQoVpH80=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 03:19:39.4647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c33421c-dab1-4c75-d1da-08de27e3a3f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982

From: Dan Williams <dan.j.williams@intel.com>

Replace IS_ENABLED(CONFIG_CXL_REGION) with IS_ENABLED(CONFIG_DEV_DAX_CXL)
so that HMEM only defers Soft Reserved ranges when CXL DAX support is
enabled. This makes the coordination between HMEM and the CXL stack more
precise and prevents deferral in unrelated CXL configurations.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/dax/hmem/hmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 02e79c7adf75..c2c110b194e5 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -66,7 +66,7 @@ static int hmem_register_device(struct device *host, int target_nid,
 	long id;
 	int rc;
 
-	if (IS_ENABLED(CONFIG_CXL_REGION) &&
+	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
 	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
 			      IORES_DESC_CXL) != REGION_DISJOINT) {
 		dev_dbg(host, "deferring range to CXL: %pr\n", res);
-- 
2.17.1


