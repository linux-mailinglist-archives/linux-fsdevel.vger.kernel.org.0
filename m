Return-Path: <linux-fsdevel+bounces-58736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A87FB30CC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 05:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B001CE2D67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 03:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B45299951;
	Fri, 22 Aug 2025 03:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WGnVk+x7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7581028D83D;
	Fri, 22 Aug 2025 03:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834145; cv=fail; b=VkrH3hap1BNBJqdFjAJeEE2E5Bew+A7dJlbEOvGlwkKa8tSsaErTwz2e7YdKtVyGx1MNnkZzC/i+LNUrv43uIt/PG86M4wflbXfh+AYzDwQ3q+UZbh8YQoNHCZkLHso5Cs9UTb/+0XbkrDQtgA/VmOYM74AZ9PwDxv+6SUjzfbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834145; c=relaxed/simple;
	bh=GLsjNpbsy1Jpga/89eMrs0wbKIHAEjhOIPLfUG2hgV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=haDg1O6O+4WCNLntuBtmyTy44jZm1XuM2q62LKItrJaNRgi6+HvyA+FJzHLxYQKNGhAv2YKOvzNqEISPPVqEFH3cERCI4cm2JOcVZYQPg/deBHYRWNsvcDcDoMUmvcIIRkR4QwHCv4jfXZb9UjrCoHMRmmx4Y73xcaAnif6MhbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WGnVk+x7; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVbv0BUAsCoxa7inhqEZpnYD1ZDVpyzecSolDLJnnEHdYHpt73DMzMBzizL4SJeUSqlS4/8NrRBm252rRkz4f9xJ6g8is0CnUKQt2Aly61iYHFR4X9b5i2vmE+8xt+tzgfOG0FYZ0pTHExr4J4t9wgy6TCyaSBQPyoMx5K0tpaMNxoYR3Ot/jBT0aY2b8ON1nus2GbrsHnjQ99gf7+mcBhGHLCQvoj0DZlVRkrUJbt2MCDyLTiA/OK4ym5eQbxVEqGwyPcYlkQOk4tvS10F7mufWHAkCIcuWjeMATrwslofofMycsh5Yt11NnocHAwQf4k23qzpDt3DBhYfsbU9BKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvvpaH957xAQl6KpXPvvoBnQ0bdUsdx6q8ABmS07MFE=;
 b=x7mZVcnwMfU3yo8B0+7WRwvIgTrpOfty7GoxqSeLqq8T9kuvcp0ZcApSFRw6Zs8m8gp2IOIB9bDZgQPVOP7sEsAadpvBIvQXawMWPOBhGvqAiF24/w5Q/kdz+BHKG68nhPwRGODKCxpC/B5yL8sbTyOgiWeAA4kgPl1XSOprKy/W9qYNLEGcPi0ieU6Zzga6fAGW0Qr1V1AjIA1gJtlkmUuuhvHWvhPbP1sFYLH2P/Kp+JBIWCNvt3P9qn7sStiBK//SKEOgfkA0Te4CoKQ+G2BDDqjiNS0NCiFGo/pRNGQA9Kn2NDxuwxZVbNe424XSu11v4iTjPOWq2wdk1vkHFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvvpaH957xAQl6KpXPvvoBnQ0bdUsdx6q8ABmS07MFE=;
 b=WGnVk+x7fqrpUAPKctGl5ei7t/Zzn7xyUv331S/fFfhHlTN2UNsAP3sg6VW0ph8lK/hVrS5nhkpN6/kgDIMIIWYP7Ef+in2LNLqcLFSysaEqb2dDlG5P7UdPd+mgepJP2jSftylkAIb5M59+XpaoK5n6cGKBh9hDWOyQvZnj4d4=
Received: from YTBP288CA0004.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01:14::17)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 03:42:17 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:b01:14:cafe::c6) by YTBP288CA0004.outlook.office365.com
 (2603:10b6:b01:14::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Fri,
 22 Aug 2025 03:41:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 03:42:17 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 22:42:15 -0500
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li <lizhijian@fujitsu.com>
Subject: [PATCH 2/6] dax/hmem: Request cxl_acpi and cxl_pci before walking Soft Reserved ranges
Date: Fri, 22 Aug 2025 03:41:58 +0000
Message-ID: <20250822034202.26896-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|DS7PR12MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2867ee-4414-4bf5-c8c1-08dde12de41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|30052699003|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gkz5EkIK+O8jYkSilkB1ps8zkxY7kxLhaHCTUSbssgUVyXD2hC5w/UvIu8k6?=
 =?us-ascii?Q?ISLrb1AkkSa4MWDdAYGpRr+MdEiBXYw1Kep+tiUCrWitmyAurKAJ5p8JdGTk?=
 =?us-ascii?Q?KiAeuh81ZxnJlBsyKNxTZdZ2KhhEGGnl8kD697HgxEkc03kOxzht+ZjBBahD?=
 =?us-ascii?Q?mRPlKlGSJkvALzNLjEWO5HNNEBbw7GyCDsweWfWNJLW0bAaO8IVGWLl4LMC2?=
 =?us-ascii?Q?RWv90yQ6NELmsPeOXuVzHVQlT+m0FBJ7p7Y/QUcXTGndgWytGRSWmPt9YzoT?=
 =?us-ascii?Q?mvwBAI/+M+elod1VZW9dN588eLhp7a1Vp9QN8Xl83yIUq56ei594b8KrSqGg?=
 =?us-ascii?Q?hH5KWZnphOsV7ne4Ip1hNyT29TNO0XYgF/Ie6oZh37Z95To2L8aiKMl4xNqC?=
 =?us-ascii?Q?z6nqpBsrCDYGG92W0PQLltQC1lgHLOWjy5fn7CQra74ehPjRzCXQ10GwgBNZ?=
 =?us-ascii?Q?CVALSBegUGSZIulwl7BGBUDrWuBaJZSewDZ3NL7s7C/pBmc+uIL7oTcJXEo3?=
 =?us-ascii?Q?iwIoTQlm1oFLnQYylaHDcv6c387g/0H7ZJutnFFVm9q4XGwkXu0icZBd64jq?=
 =?us-ascii?Q?XuN2z3LpcZRKHT8RgbrsLwgvMrsTVnaYaFCrCo8xW6EQiBXPDY7l4ndH0jX1?=
 =?us-ascii?Q?KXQVp50jxaPqWV2eiHF4PQsAhxV2L3Ub0iXfJNJyzdAqymCQsgB9ISjFfIpK?=
 =?us-ascii?Q?nGjILySIQ24ZryGKBqW2gA2i3Q571TA0ZtTs7/k5+y1o+eZ6QkVzYMIj6G1x?=
 =?us-ascii?Q?STpfhwS2kphZnKFfUBTul1nSGrxjjjSOrw+n/gM6yGNO06YZNuTdgslk18DE?=
 =?us-ascii?Q?st+n31mGv8pOHS79FYRLPYrvAD0E7OKyrotPNucNuw270hRNbp74s3unjuVV?=
 =?us-ascii?Q?91VXyOZkEnK0IWL40WmrkyyfDHWJXc1cFlnf0lDo2ZHo1ao3j2F/JadXWBmZ?=
 =?us-ascii?Q?uNmBdD09GuHtGftqJuZ1aq/EyinOnE1lZGDA5KdB8aOz135KBVV2lsJkSvFA?=
 =?us-ascii?Q?C5OEdNDnYtiqAiJiU5jkIByNwjUkiemLMLY6OR7ePAuCr5yaTlx5FnIBWEJd?=
 =?us-ascii?Q?qwDeEiH5dQzxalCDKj5FdG9zx4ONzIyACGq7IqSRreBkXkwABb61ZmsgOKyM?=
 =?us-ascii?Q?SC57Prea/qQ6cT33s+e/AMI4b3sARrLU1Y95CRZD8i/BlcCAjeY92RxHbbDx?=
 =?us-ascii?Q?gxdl5I116/z5a7sszEjHogWuI/DUzNJ3cT5LHk1cSl5ywAPI+Hrukj08tRsM?=
 =?us-ascii?Q?dXAUvMdaMHRnBNx7QK4VwQslOEGP/cJb1hxKl0ddPYbhJftFMKfKnZW8vMP7?=
 =?us-ascii?Q?7aVqvV2Q8/0LCWzvCwoAWRh7XOjt9ktFE5xpeJKyQjGTElq1w2tVsjen+9JT?=
 =?us-ascii?Q?s3SyQVs1regWZuffxRWv0EJFryP0SwEfC6S/ZRMgajQQ4FCcBSOSG+lTuTK0?=
 =?us-ascii?Q?6PdX74uoQchVYG7oC5korREc6bw+BaOGEYB74nMpPdO/NCG4187mNYHwxA7g?=
 =?us-ascii?Q?/UMoIhsYEJYn7HchXJS+wswgJjjzKGd4ro+E?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(30052699003)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 03:42:17.3127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2867ee-4414-4bf5-c8c1-08dde12de41f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083

Ensure that cxl_acpi has published CXL Window resources before dax_hmem
walks Soft Reserved ranges.

Replace MODULE_SOFTDEP("pre: cxl_acpi") with an explicit, synchronous
request_module("cxl_acpi"). MODULE_SOFTDEP() only guarantees eventual
loading, it does not enforce that the dependency has finished init
before the current module runs. This can cause dax_hmem to start before
cxl_acpi has populated the resource tree, breaking detection of overlaps
between Soft Reserved and CXL Windows.

Also, request cxl_pci before dax_hmem walks Soft Reserved ranges. Unlike
cxl_acpi, cxl_pci attach is asynchronous and creates dependent devices
that trigger further module loads. Asynchronous probe flushing
(wait_for_device_probe()) is added later in the series in a deferred
context before dax_hmem makes ownership decisions for Soft Reserved
ranges.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/hmem/hmem.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index d5b8f06d531e..9277e5ea0019 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -146,6 +146,16 @@ static __init int dax_hmem_init(void)
 {
 	int rc;
 
+	/*
+	 * Ensure that cxl_acpi and cxl_pci have a chance to kick off
+	 * CXL topology discovery at least once before scanning the
+	 * iomem resource tree for IORES_DESC_CXL resources.
+	 */
+	if (IS_ENABLED(CONFIG_DEV_DAX_CXL)) {
+		request_module("cxl_acpi");
+		request_module("cxl_pci");
+	}
+
 	rc = platform_driver_register(&dax_hmem_platform_driver);
 	if (rc)
 		return rc;
@@ -166,13 +176,6 @@ static __exit void dax_hmem_exit(void)
 module_init(dax_hmem_init);
 module_exit(dax_hmem_exit);
 
-/* Allow for CXL to define its own dax regions */
-#if IS_ENABLED(CONFIG_CXL_REGION)
-#if IS_MODULE(CONFIG_CXL_ACPI)
-MODULE_SOFTDEP("pre: cxl_acpi");
-#endif
-#endif
-
 MODULE_ALIAS("platform:hmem*");
 MODULE_ALIAS("platform:hmem_platform*");
 MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");
-- 
2.17.1


