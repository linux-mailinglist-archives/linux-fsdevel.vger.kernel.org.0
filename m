Return-Path: <linux-fsdevel+bounces-58734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACD8B30CBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 05:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2236B1CE2C85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 03:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E1D291C3B;
	Fri, 22 Aug 2025 03:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gg/IDwNg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F9928B4FA;
	Fri, 22 Aug 2025 03:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834143; cv=fail; b=so3gC7hNrYjQjxok/cQDiPSK4A4S6FWyciaNHMFZ/6XAlH8K5hXj74TawIFJeczuTDnmXCXyY5HMM1Z/YKVg/yuNGpNcyBk3nH1PkIpjrg8/QtEq612EoerzeWhOobIjx46ETWq0iPory1wWjgUnhD722Gk5jwNdWFQOWeMB3LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834143; c=relaxed/simple;
	bh=wiMk9nau87WssVgq+MdAtePeaukk24zZ/2NJ1QbOqUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lP1cWiItpA5Q7Vt3pv91cj0URAyNRbUn2FYUA1ziKVPwUmbtYRj7ihSAs+37MyMFcTGwBqA066nLg2GCRStQWP0nPU7HU9Ygufcr5QK8ZsLfrtHtdgdxGTOfncZntHj1rC10NNEpfmMZaenhAPZ8aYrPQ4PLAwKuD6CN1RV1H+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gg/IDwNg; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPW8pQcHPJ03Z++w58lGKEGRu9fEKCBpSI+5TD8bwCX9QItgGcyCQL9W3iU7sRXOrPB2cSPsyIU4eYavBNlyXgMPgIVhr3FXTII3CgHCpkAlprH0ZW/6tFkvqWfQhzId0oB/fy6Goqd4KSZT8Gsgnh4cwgZXHuHkuAkeOjFempqIc8Pv10LS/Rt2And7uv4j7/iggT5/7RyUJoK9PWOwFr3/wnF3SO+hsLHPpCO6KbFVfVSDkCi1PoZ2Zuj/KKKis34os8fQXlw1l/YJ8JlM8ob12Ui9VzdS9RE3mrXC66dNCw36DHyn5Csd8LMP2h27L+9r8tPZAIfWCg5siGDB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRIVC+g7Yqlxa6QC9HxZd2wNcXIYl+fV8j8TDOPJkIE=;
 b=Bqq1/XQVgLQT+JtbrsLEUwCt17W0hhoU/ROrpw2rJW8ycbK1crmlBr3yaFZnUnDCbTGIJ0BuVXozp1W/0Ikp7WO5yYUvzu0HhwrOo7H9G8vBdvqUSDfThVQFBrVhlsI8MNvKLcqEIXQvq89gpw8DC5W+B3qBZURNjHxc12hdKpwQcX9cTuyN1RSEnUvqDZuQkIoN6QUiVCot4zyFP89V05DG66JVuNhRk5IUBvNHLwLtmro7A+7+tJ3HKlTvr2bjqiXcnkvN5UgTviLUZbhhatxNqIdd+ZPvO2b67Dz2sS4CoewGoFoHO99pF9KfDrORckvqqbwOGPOU0YeN4/3V9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRIVC+g7Yqlxa6QC9HxZd2wNcXIYl+fV8j8TDOPJkIE=;
 b=Gg/IDwNg8wcCne3VMH2QG1aw7uh3xmfHO51V7mwgOsXdOwzo/yhvcIqqmfdZcbHqkVxb7/tt028aKPfK8Cqi/wPkLdHTw1a4EmP7IVBTR3ZtwNkFhJ7qc/EX/wtNx5fno571a9B44cgp7guAGXG+1ASKW5UtGkzG2DvpK30C2WE=
Received: from BY5PR13CA0028.namprd13.prod.outlook.com (2603:10b6:a03:180::41)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 03:42:16 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:180:cafe::7e) by BY5PR13CA0028.outlook.office365.com
 (2603:10b6:a03:180::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.7 via Frontend Transport; Fri,
 22 Aug 2025 03:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 03:42:15 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 22:42:14 -0500
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
Subject: [PATCH 1/6] dax/hmem, e820, resource: Defer Soft Reserved registration until hmem is ready
Date: Fri, 22 Aug 2025 03:41:57 +0000
Message-ID: <20250822034202.26896-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 4510eab9-b64a-404f-d7e9-08dde12de33a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bt0jF5ev+DKjs8xay/V1rp6Hp7NnQRnUngUj39Rb4dyfW4kCswgzU9jbuBHP?=
 =?us-ascii?Q?zkzAmuJH11RREAEhhhNhgLF5UJr3akVKJn+fGzS8caHS+h5vJxWkqIbC+IGD?=
 =?us-ascii?Q?6Ua1W/O7sSBRJRiN86WjBv755/6ha5vnxGriBbFRerx4n6dx+0p8qwtdVIXE?=
 =?us-ascii?Q?wkpkzdHUnhOp5RMDpODsKmNVPPf6nHfztZRq8nTTFXVM5t3bqePY9RTpiyI7?=
 =?us-ascii?Q?Kji0hAiX9VyxtrOOhgKxi53dB9JtYE1prCDihgPczDvUve+mmsN6/Y5IjR0+?=
 =?us-ascii?Q?XjnxFG7G762NP5QnwLTeXDjN/RA4jwsvmFnWs2MuUgaL5e3u7XBSFYwjbJmu?=
 =?us-ascii?Q?zD5oV9WuyOAHedREf3lQMcTlbnivSiqJSCs9kQ+g3lm8UU3IPgsgpo2zIAPr?=
 =?us-ascii?Q?bkyoEpuRVneUYtWquzXK5V81Sx5qjyTKKsVeH9ZR5v4el03DAtCjgIi80GCO?=
 =?us-ascii?Q?k+8qToyzakQn/99/gJ/lAzBUW3FjnFwS3/S7ISDbV4IJcEEIb2Z1xx5zWq41?=
 =?us-ascii?Q?v3aaK2kfAE/FAaoTOxZsRN5IYN7sxykDR41VmEsIToAEOfScf4D4THO0Nm3K?=
 =?us-ascii?Q?/8/O2jvfeUR09yWXI+OfG+hN0NGHlnpkOTUhaM9xDvyY/xjqdoSwN7C4alxt?=
 =?us-ascii?Q?YElxYrPvVwLpmLgQ4wv/Vtw2nadqxv12IkqsSILvyJqoyYbbJWp9eRcXlCZr?=
 =?us-ascii?Q?yYFD3LdrmZB+6hxGRSu/CFWyUjcmnxfWbGMAFBL4zTTLScje+ixVtdH2nZWz?=
 =?us-ascii?Q?yW4Qv2zdnwVt4nZb2tQoBWREsuvpG5JJIavx0sONB92AuwX8YmO/Pu0R3k8y?=
 =?us-ascii?Q?pDS70tCyGly3AlcRtGh3wWVz7DzDTwwVPsJmIixzFTGrKQv3Lz0UNe9g+ON2?=
 =?us-ascii?Q?vYGLtUFGT2VS2IwkSniyViskGPfva2WQJryhwt23qA/Fnvo5RuoXXFZH8oYY?=
 =?us-ascii?Q?6PyV2BiPz5EhrSBJEI2ji0hyCLCzZzVdn/3vk4MFckWev69pi0QvKphaxjVw?=
 =?us-ascii?Q?V+fJRHdrMtFBJMKEOgU+BRLZONTFe365Cy1OJzjvrM3eIeocVIDfRY3yrQq0?=
 =?us-ascii?Q?9ZFCNRzFfcTaTZ2rS6c4qrSgfx+aPsO5+wP6Adcz+Ojdq0jeiznfaB3gt+kS?=
 =?us-ascii?Q?U5N44InDplTxzoFAxIeFEKscIs+XNtIWfg0lqu4GaqqTAqY1NQD5OftXxT1L?=
 =?us-ascii?Q?ykB9S1/0zq+xVv4lSaISrFUgNjq9GU9zGAcQGgiVYTNr560oRtNGLmHi75iL?=
 =?us-ascii?Q?NXaztSjUYgV2Etlk48aWwrEMd4bEaO6Zep8Bup1CbmvHmfdl4246VEs/XuKp?=
 =?us-ascii?Q?uQ5yrHmMuZkA2aLNU6Mki060m9clxVzOW8J215D09wKub0Z+4+mnoCIb/eYo?=
 =?us-ascii?Q?/I+Uk46fslQp+QlIB2TEklbdOLscyBBkJjnSf6KlCC+F+7eEn7qabbiVp2bf?=
 =?us-ascii?Q?UVyzBAGGoZ62JeRoRPX2lPboLWuGgIBkMhMZhKkSgDw5YsErikZMjEA0Viex?=
 =?us-ascii?Q?r/bLPDGC5j0W8KUmNh4CjDY9sykQDcXb1NCE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 03:42:15.7179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4510eab9-b64a-404f-d7e9-08dde12de33a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629

Insert Soft Reserved memory into a dedicated soft_reserve_resource tree
instead of the iomem_resource tree at boot.

Publishing Soft Reserved ranges into iomem too early causes conflicts with
CXL hotplug and region assembly failure, especially when Soft Reserved
overlaps CXL regions.

Re-inserting these ranges into iomem will be handled in follow-up patches,
after ensuring CXL window publication ordering is stabilized and when the
dax_hmem is ready to consume them.

This avoids trimming or deleting resources later and provides a cleaner
handoff between EFI-defined memory and CXL resource management.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/kernel/e820.c    |  2 +-
 drivers/dax/hmem/device.c |  4 +--
 drivers/dax/hmem/hmem.c   |  8 +++++
 include/linux/ioport.h    | 24 +++++++++++++
 kernel/resource.c         | 73 +++++++++++++++++++++++++++++++++------
 5 files changed, 97 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index c3acbd26408b..aef1ff2cabda 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1153,7 +1153,7 @@ void __init e820__reserve_resources_late(void)
 	res = e820_res;
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		if (!res->parent && res->end)
-			insert_resource_expand_to_fit(&iomem_resource, res);
+			insert_resource_late(res);
 		res++;
 	}
 
diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
index f9e1a76a04a9..22732b729017 100644
--- a/drivers/dax/hmem/device.c
+++ b/drivers/dax/hmem/device.c
@@ -83,8 +83,8 @@ static __init int hmem_register_one(struct resource *res, void *data)
 
 static __init int hmem_init(void)
 {
-	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
-			IORESOURCE_MEM, 0, -1, NULL, hmem_register_one);
+	walk_soft_reserve_res_desc(IORES_DESC_SOFT_RESERVED, IORESOURCE_MEM, 0,
+				   -1, NULL, hmem_register_one);
 	return 0;
 }
 
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index c18451a37e4f..d5b8f06d531e 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -73,10 +73,18 @@ static int hmem_register_device(struct device *host, int target_nid,
 		return 0;
 	}
 
+#ifdef CONFIG_EFI_SOFT_RESERVE
+	rc = region_intersects_soft_reserve(res->start, resource_size(res),
+					    IORESOURCE_MEM,
+					    IORES_DESC_SOFT_RESERVED);
+	if (rc != REGION_INTERSECTS)
+		return 0;
+#else
 	rc = region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
 			       IORES_DESC_SOFT_RESERVED);
 	if (rc != REGION_INTERSECTS)
 		return 0;
+#endif
 
 	id = memregion_alloc(GFP_KERNEL);
 	if (id < 0) {
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index e8b2d6aa4013..889bc4982777 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -232,6 +232,9 @@ struct resource_constraint {
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
+#ifdef CONFIG_EFI_SOFT_RESERVE
+extern struct resource soft_reserve_resource;
+#endif
 
 extern struct resource *request_resource_conflict(struct resource *root, struct resource *new);
 extern int request_resource(struct resource *root, struct resource *new);
@@ -255,6 +258,22 @@ int adjust_resource(struct resource *res, resource_size_t start,
 		    resource_size_t size);
 resource_size_t resource_alignment(struct resource *res);
 
+
+#ifdef CONFIG_EFI_SOFT_RESERVE
+static inline void insert_resource_late(struct resource *new)
+{
+	if (new->desc == IORES_DESC_SOFT_RESERVED)
+		insert_resource_expand_to_fit(&soft_reserve_resource, new);
+	else
+		insert_resource_expand_to_fit(&iomem_resource, new);
+}
+#else
+static inline void insert_resource_late(struct resource *new)
+{
+	insert_resource_expand_to_fit(&iomem_resource, new);
+}
+#endif
+
 /**
  * resource_set_size - Calculate resource end address from size and start
  * @res: Resource descriptor
@@ -409,6 +428,11 @@ walk_system_ram_res_rev(u64 start, u64 end, void *arg,
 extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
+int walk_soft_reserve_res_desc(unsigned long desc, unsigned long flags,
+			       u64 start, u64 end, void *arg,
+			       int (*func)(struct resource *, void *));
+int region_intersects_soft_reserve(resource_size_t start, size_t size,
+				   unsigned long flags, unsigned long desc);
 
 struct resource *devm_request_free_mem_region(struct device *dev,
 		struct resource *base, unsigned long size);
diff --git a/kernel/resource.c b/kernel/resource.c
index f9bb5481501a..8479a99441e2 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -321,13 +321,14 @@ static bool is_type_match(struct resource *p, unsigned long flags, unsigned long
 }
 
 /**
- * find_next_iomem_res - Finds the lowest iomem resource that covers part of
- *			 [@start..@end].
+ * find_next_res - Finds the lowest resource that covers part of
+ *		   [@start..@end].
  *
  * If a resource is found, returns 0 and @*res is overwritten with the part
  * of the resource that's within [@start..@end]; if none is found, returns
  * -ENODEV.  Returns -EINVAL for invalid parameters.
  *
+ * @parent:	resource tree root to search
  * @start:	start address of the resource searched for
  * @end:	end address of same resource
  * @flags:	flags which the resource must have
@@ -337,9 +338,9 @@ static bool is_type_match(struct resource *p, unsigned long flags, unsigned long
  * The caller must specify @start, @end, @flags, and @desc
  * (which may be IORES_DESC_NONE).
  */
-static int find_next_iomem_res(resource_size_t start, resource_size_t end,
-			       unsigned long flags, unsigned long desc,
-			       struct resource *res)
+static int find_next_res(struct resource *parent, resource_size_t start,
+			 resource_size_t end, unsigned long flags,
+			 unsigned long desc, struct resource *res)
 {
 	struct resource *p;
 
@@ -351,7 +352,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 
 	read_lock(&resource_lock);
 
-	for_each_resource(&iomem_resource, p, false) {
+	for_each_resource(parent, p, false) {
 		/* If we passed the resource we are looking for, stop */
 		if (p->start > end) {
 			p = NULL;
@@ -382,16 +383,23 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 	return p ? 0 : -ENODEV;
 }
 
-static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
-				 unsigned long flags, unsigned long desc,
-				 void *arg,
-				 int (*func)(struct resource *, void *))
+static int find_next_iomem_res(resource_size_t start, resource_size_t end,
+			       unsigned long flags, unsigned long desc,
+			       struct resource *res)
+{
+	return find_next_res(&iomem_resource, start, end, flags, desc, res);
+}
+
+static int walk_res_desc(struct resource *parent, resource_size_t start,
+			 resource_size_t end, unsigned long flags,
+			 unsigned long desc, void *arg,
+			 int (*func)(struct resource *, void *))
 {
 	struct resource res;
 	int ret = -EINVAL;
 
 	while (start < end &&
-	       !find_next_iomem_res(start, end, flags, desc, &res)) {
+	       !find_next_res(parent, start, end, flags, desc, &res)) {
 		ret = (*func)(&res, arg);
 		if (ret)
 			break;
@@ -402,6 +410,15 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
 	return ret;
 }
 
+static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
+				 unsigned long flags, unsigned long desc,
+				 void *arg,
+				 int (*func)(struct resource *, void *))
+{
+	return walk_res_desc(&iomem_resource, start, end, flags, desc, arg, func);
+}
+
+
 /**
  * walk_iomem_res_desc - Walks through iomem resources and calls func()
  *			 with matching resource ranges.
@@ -426,6 +443,26 @@ int walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start,
 }
 EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
 
+#ifdef CONFIG_EFI_SOFT_RESERVE
+struct resource soft_reserve_resource = {
+	.name	= "Soft Reserved",
+	.start	= 0,
+	.end	= -1,
+	.desc	= IORES_DESC_SOFT_RESERVED,
+	.flags	= IORESOURCE_MEM,
+};
+EXPORT_SYMBOL_GPL(soft_reserve_resource);
+
+int walk_soft_reserve_res_desc(unsigned long desc, unsigned long flags,
+			       u64 start, u64 end, void *arg,
+			       int (*func)(struct resource *, void *))
+{
+	return walk_res_desc(&soft_reserve_resource, start, end, flags, desc,
+			     arg, func);
+}
+EXPORT_SYMBOL_GPL(walk_soft_reserve_res_desc);
+#endif
+
 /*
  * This function calls the @func callback against all memory ranges of type
  * System RAM which are marked as IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY.
@@ -648,6 +685,20 @@ int region_intersects(resource_size_t start, size_t size, unsigned long flags,
 }
 EXPORT_SYMBOL_GPL(region_intersects);
 
+int region_intersects_soft_reserve(resource_size_t start, size_t size,
+				   unsigned long flags, unsigned long desc)
+{
+	int ret;
+
+	read_lock(&resource_lock);
+	ret = __region_intersects(&soft_reserve_resource, start, size, flags,
+				  desc);
+	read_unlock(&resource_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(region_intersects_soft_reserve);
+
 void __weak arch_remove_reservations(struct resource *avail)
 {
 }
-- 
2.17.1


