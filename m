Return-Path: <linux-fsdevel+bounces-63079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583F5BAB67A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6071923BE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 04:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BA726A0D5;
	Tue, 30 Sep 2025 04:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="22e7cfvP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013043.outbound.protection.outlook.com [40.93.196.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062EC2472BD;
	Tue, 30 Sep 2025 04:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759207696; cv=fail; b=BzubTDuNJ/hh7+D44FjsZxXvqmpgDKA9SS6fXY/gBxsa/9M2A2eLQIcOaJ9IEO8I9albGdc4OeSnvX27JdnWVVKOHF83u1CaMjEFcVkf3zyAw4U28Y24VF+HCUQr3Esj/bQdS9YJ//OhFHzsOb4uVfrElsfx4lnXEPUeUaXbX9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759207696; c=relaxed/simple;
	bh=x2w4n85FGFNMzlT+WUxgZLDsBBJvDLZMVBgI4S9KUWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/q6bKN9JdYI95B4O3HZeqlPfP+ronKqB0PtWlWZlMKy5oXSzhMMWW4yEhUaZsLkpIgS991iVrtYZTAbcKGX3VE5y0LKPVUvYmt5HnebcWJtYJ5CzGf5VEg3oXoaunRjrURNx/j9NxEUrHA/HGcupi4Woqj+vwY7wYrLcEfjeSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=22e7cfvP; arc=fail smtp.client-ip=40.93.196.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQakiO978ARgzeOW2H8eByCCIneT3kaBQaxJNt3vYaDRjtmSDaqyLZlMqnxv0tuWVT/zp5hLskXajjSbbt8XEiQFQ2XMizpNDafMxFZfvCwhPkzzBuB1BuL97cCKVzrbxKjjchjB1LT4ex5AAgLu2dTQBAWQIA8onAa8GI2QM8P2Oyh29XKmwAy+FINhWTR0FZOSrNHCZz7iGGmcWD1XFgpkt/fDsohaxUhKdpUJUEPnSi6LqXSVAVCqCh+zBvSXU4Wa8qqJsT2zptF0B7iStt6EUvuNVER1EI8isykoFJ3nCqUlf1ypWSUVKdt5LTFRezEHoUNriaB/3AX0x6DcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSQ5jqPZDp0lVmqZYWhF+HkDbaVaexTZR4Tn1gl/iyE=;
 b=y3Ii/8HlmxIfsrCRjhtgEYqNTrCCKVBV6LI1dnYHpdUa9/TMnp+BRCAluuju0laISWoNI153XpTSWXDGc0w7rWWcXxIDCvwWfMHLMOZ1sq6Ai9XccH65Y0WfHUJk3ozvAwU6Bc58UsVAbv5QckK4psKtBLynNIa1NUo4wVECiFrm96HFHB8i5tccOkC93Wtjp9VU1o1FKtI+EkPHInfwUI+b0ApdI4uVZ7x8dxOQImNJxXPGbuz379cCr0f0+BQmw8uX5bFZdNAfmBtPTWcvgOPHffaGuji5qjVpnQLCJrlZqvmfbEbtrk0zKcB/0jWX9+3AJ14E8XeASdPVQYzQsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSQ5jqPZDp0lVmqZYWhF+HkDbaVaexTZR4Tn1gl/iyE=;
 b=22e7cfvPOTbv3kWDB6wk9g+VgR8PPWPLI+gS/orbDLxMuwuoR/sXDu28yvf6/Uf0tVqIVEf2aCFJ2e7jAlG7IvBYOJk/CjFkBXoIqETzn28pv7s8V964otXzx7rH7ibXBRjb9z4+loL2VGFa+CQIyWajOYO04OIJ7nnrBf9xA2U=
Received: from BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::9)
 by SA5PPFE494AA682.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 30 Sep
 2025 04:48:11 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::58) by BY1P220CA0024.outlook.office365.com
 (2603:10b6:a03:5c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 04:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 04:48:10 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 21:48:09 -0700
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
	<benjamin.cheatham@amd.com>, Zhijian Li <lizhijian@fujitsu.com>, "Borislav
 Petkov" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 2/5] dax/hmem: Request cxl_acpi and cxl_pci before walking Soft Reserved ranges
Date: Tue, 30 Sep 2025 04:47:54 +0000
Message-ID: <20250930044757.214798-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250930044757.214798-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250930044757.214798-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SA5PPFE494AA682:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab85c74-315b-45fb-de36-08ddffdc8ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eNMnirAhc6T53SRFalep//llpmXL5yvbroTMssJz14EJeSN19Y9ly3h7w8Z+?=
 =?us-ascii?Q?Ebdw4Dj4n4uHVzoUNw8kwFKinfdl2LFfhOi+VUDScraflDMRiyXP1lRtB/Kl?=
 =?us-ascii?Q?8DB9sUhTx/BldPnCbVmGMHBifZPBWarGq3LnHUD84baEp2+kiRKoGYzneElP?=
 =?us-ascii?Q?dDhQcc7nd7xOj2O3jGVVA5K58tFxcffGwV7U3UGXxwl8scuFpr8WZkct1zjr?=
 =?us-ascii?Q?yY+KQAojZu0hAoAloUJHGJb1Jmz6Kh1TOnINKCQTYnUco8CUycMUIK9/sMTV?=
 =?us-ascii?Q?K0XB+bRQhy+r0IZz3/K8Y9+jKB2Zy+66a5pRmegObDgvQN9Mw2MjYayBGQm8?=
 =?us-ascii?Q?jcIanS9U90G8zPYgFytL29XLmvogLYecJEQrwXvlAkX6EkeL2/xnIi8Pypr1?=
 =?us-ascii?Q?LMaF+QNHICccHvYqstDAWxEj+hXN3xLStm6Zw4eHaRPd5LwihEIMKY42eBhJ?=
 =?us-ascii?Q?hbWMn7wQq1Pxf1n9wfcIolbO904zh5/NNPA54GXyhn1b1GVW53L4hLeIwJT0?=
 =?us-ascii?Q?mUioF3AdYACCpN5S4a06ykmPopBF8xfdsCj3QYInfKWuVJ8UDPKsqBoKLjS0?=
 =?us-ascii?Q?THPQ815TBv7/6kCyaaeCvFb2Sl9Y22Ppzlb8S/1vx0WUtRD+TFNLWcNQBvEg?=
 =?us-ascii?Q?pTbutDh5CmyYtVQt55f+n4O860utocOWCnhddNqCW8kfYlLNiCP9eQPH2Ifq?=
 =?us-ascii?Q?ME6ykqOVcfBjrH3OuD4BUCRTIfTn0og5OZHp1hO5DyvSAwN/d4AlQsik7j/8?=
 =?us-ascii?Q?tPJCJ3ZoTnsR8kW2Ib8sf+BNDcQhYqT5r66uW06NUSQPF6Kety3vN3QJfwGA?=
 =?us-ascii?Q?ji9TXnl9VdUX5mHoeuLtKJJuhfm8PaHVbKqeZRuOXWHGgP5R5k9S85usSlih?=
 =?us-ascii?Q?CrMkPkss3Oj01/fcW994RCJ9vBdmWUrgHKSmiXeJ2ZjwBkpJ8DPyKCNQt9Dm?=
 =?us-ascii?Q?FPR3+k+wJhE3QfTH9bIp47llXSZ0xLA/G9ERzfE2FMuIMvL5ok+FA45/49Ul?=
 =?us-ascii?Q?B0AM8U4VGKSfvEJMMdCWqd13uxhEbW7piPv0OVYh1YyT3cey2ETY7H0xWDNi?=
 =?us-ascii?Q?Y8/ff68tYx2FIYlc5dzz8Aa0fxGC+Eu+0lD4RaQabLMJFclS6uP4twtHZHy/?=
 =?us-ascii?Q?XVQlO2uctxgCf+2uUr4YH3E31fij6m9hiS1tn41Tyx2rUvurNLR3oq5P8RIO?=
 =?us-ascii?Q?ko2DWQ/TXmP9do+W3TUtTRh7R5S2yk3p5FNrsJOGLT8Mb4GLCDh3TQC3S5g+?=
 =?us-ascii?Q?W6/DJLD1cmvtSdhbSHjnV63Eurct6EHEL7rnAfjrHAevvEz9hE4R30gXvg/A?=
 =?us-ascii?Q?3iPQqYMnPEThEfXZsnlsUYlQgduHt7og2e7nXOd0Oqn8xu6QLx5LA2GNWY0m?=
 =?us-ascii?Q?GxhNFMpJzqgx0OToBVv5q+sOl8oHp7BtibIEQdp4MOSHkjtkbPIOLqA6UNvS?=
 =?us-ascii?Q?tqnHh67v7dQY0OEQDL6Mi1agOdxVkzVF48tYM13Egm+yD+5rjDFfi2yUAN2P?=
 =?us-ascii?Q?VI1QyXiX8wxpvnbLfG4sodA9U2GA1ILPh+xmiTdQIc0x3AFWPI/qjVOYs5ho?=
 =?us-ascii?Q?YpOh8Ks6Ykv1+gWGAtE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:48:10.8397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab85c74-315b-45fb-de36-08ddffdc8ebc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE494AA682

From: Dan Williams <dan.j.williams@intel.com>

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

Add an additional explicit Kconfig ordering so that CXL_ACPI and CXL_PCI
must be initialized before DEV_DAX_HMEM. This prevents dax_hmem from
consuming Soft Reserved ranges before CXL drivers have had a chance to
claim them.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dax/Kconfig     |  2 ++
 drivers/dax/hmem/hmem.c | 17 ++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index d656e4c0eb84..3683bb3f2311 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -48,6 +48,8 @@ config DEV_DAX_CXL
 	tristate "CXL DAX: direct access to CXL RAM regions"
 	depends on CXL_BUS && CXL_REGION && DEV_DAX
 	default CXL_REGION && DEV_DAX
+	depends on CXL_ACPI >= DEV_DAX_HMEM
+	depends on CXL_PCI >= DEV_DAX_HMEM
 	help
 	  CXL RAM regions are either mapped by platform-firmware
 	  and published in the initial system-memory map as "System RAM", mapped
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 48f4642f4bb8..02e79c7adf75 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -141,6 +141,16 @@ static __init int dax_hmem_init(void)
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
@@ -161,13 +171,6 @@ static __exit void dax_hmem_exit(void)
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


