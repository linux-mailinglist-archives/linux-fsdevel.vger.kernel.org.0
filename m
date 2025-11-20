Return-Path: <linux-fsdevel+bounces-69182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9EAC71F8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 04:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6577B352AFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 03:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166953074B1;
	Thu, 20 Nov 2025 03:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="291LuKP7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20CD286430;
	Thu, 20 Nov 2025 03:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608798; cv=fail; b=Ish2nrfIPe+5D3BjemZANpWMMyr9PaCC3vIp3E3nQd49yhgEJgTw3mHR/1yUr4zcoUHKEWXWsPz03WL5+7ZZr3Q70Q2fQ30gEJq4ANhOH3QqT+kb1H8sFd9ZDJGGV+DwZHdBoKaK3mm+efUHtfc6GDfMA2Fk6AE9aQ/iguOQl4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608798; c=relaxed/simple;
	bh=HxeTZhJvNqBO9YQRzGtaAzItShoUjxNDxiQoeF+LblM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJE9lmC6ur5HGNVcvVJSxNhmdXHWGqa8RVJ2EgSElGo9D2lkBJxHd6SdG6XKncKi7ILJb6ODOsXTV+Fp1Wd5ISm9jMMCWqHiV7HYC8xKZKZeFsHiGfMtkCocM1Jwnafz7zGjYZOIFsLXxFKeIxqMRUms5tiUdr2rKKBfmLW0F1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=291LuKP7; arc=fail smtp.client-ip=52.101.53.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NX5He2XkK3bztwzXKEf1Zp7BzrzyjOp735B6WaZnO8t8jryqtpukcnHCF0jzlt1Es0lrU0NS+I6lsKXxsXk42qh+fBStFZoH2Dl2N/oVNWA8eCi4Cs6g/l4hkmwkqZzOSriSfDNE5XoucNKr5KvwB5od5sVXmxFOiWweGdGovsDOPX2Z3UD7Zr+MoRZp9v8NYs3enhNh4GUiXkb7gwwFW/RGr7t4KtF2amb6zVD3mJ/y2vmBxmw31Uop9XeMWFUr/IBrkTPr7fXgM5z734OjgTpFjMiV43feudcNz7B1I/CSsZDRSv8BKXyVDCAX1LANBIm4aLcOm+zqueAdgFFKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wW2keJ5yGy1YMJRJUeUEciD1WUNs2t2yKUv8XGlB8gE=;
 b=X/MQTKf3uunP+bFSgf6QejrlfuFHWbsNMaEoB00N4GLqSd7GNfIqiRZxUaMgtbSxiwMiX36jYg0Exrso8Mra03PdPhUv60vjeEZU/4thjUnsQZT/11bEu+YEHi1FHQM2sJ+SJcIa1ZtRsmTl3VNRcJHqyMYjOd47oAOu1cb6meVrehSStLRA9CgKMLaq0hPUYKdljOW6c8Nxeb3c3f1uwA0LqwKdgr2UFp9zESfRPQR+G7DpFYzM17swF3hTRVFn/u1Q9CUjY/vXGxcshY/LGJRsM8tt5DUh5D/rOkAiPo9FiTOv9vSLkx9NGuS/qeBMkC68rz3/cECOyMEGBwURLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wW2keJ5yGy1YMJRJUeUEciD1WUNs2t2yKUv8XGlB8gE=;
 b=291LuKP7V22jDcEOSHwYq0rfT1WNj7A1fYoXLb9JiWviZ4uahiJCM0+7NULtJ4NMqGd15aiO+VBJASURXLjw4Ia4eFD8/aSIJJTgYvzHTI71y0YoaRN9EqTKmwS44R2Cu4/8JXvsRK6g94IxZg0hTh55+nDjzdQmkorWijvA44U=
Received: from CH2PR18CA0043.namprd18.prod.outlook.com (2603:10b6:610:55::23)
 by IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Thu, 20 Nov
 2025 03:19:52 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::93) by CH2PR18CA0043.outlook.office365.com
 (2603:10b6:610:55::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 03:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 03:19:52 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 19:19:40 -0800
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
Subject: [PATCH v4 5/9] cxl/region, dax/hmem: Arbitrate Soft Reserved ownership with cxl_regions_fully_map()
Date: Thu, 20 Nov 2025 03:19:21 +0000
Message-ID: <20251120031925.87762-6-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 3926b48f-8ecd-4dd3-257f-08de27e3ab9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NjCuZgP86AomoyS9po2+RNHCJR0X8ookUxCxpY2hcY03gdm0HZS6qQdoCDTi?=
 =?us-ascii?Q?LtWUOFVkZ9zzWYc55ow+Iyfs50BrXQi/wp0ly70MhvF43QgtXFk95YaSWh9C?=
 =?us-ascii?Q?5ndLU5DRuH92Iw+mf4a+CU25nQq8joK5BNC6u26IrnXPmOigs8HUNtOtrVxL?=
 =?us-ascii?Q?XX27Aia8+5suoNpf04zTieBOFJB0mwxFc0tUYtR7cX5HJ7SolkwEZXky2rDY?=
 =?us-ascii?Q?PuFDMeGX345j/E3qm8v1zSsimlXqrNWjko/c2MWfU1zHWzPbDeNRTEH3cAp+?=
 =?us-ascii?Q?+L5Rv3E6HdZ/3Lv3ZLg8QQlsYvvPm/2NzMNdWhBoJer9WSJeRBc1Q7sZCQwo?=
 =?us-ascii?Q?xVx/+UfreffS7Qa/HoBwhH4+pmiqkHDiflGXcjndtCqeVYoUcxbTSopXKe4R?=
 =?us-ascii?Q?Xe+jVMfN8jvIMuaCZRut56XPmxPSz70T3zCSgzse4jBGObWeaMRfRbhIIfLa?=
 =?us-ascii?Q?P2QEDZAVUkdYEs/3FOw/jU6H+XA7HjOBdvmjnlwIlsI/gsrYVLWNDcBxBDyo?=
 =?us-ascii?Q?J1cyxUbUMhZeN36IYfX2hxuHZ4pJbXyzfgVaqFsYAPFiqRtWFeJ7bM38TtT4?=
 =?us-ascii?Q?i0FI7xHQc2d7fRksod4onf1XX96YowhcvVAZ3qLjZ/Wf+6k12hdp2qaXS+Av?=
 =?us-ascii?Q?bRdgwdCzPpBKV2lUqUlJ+sCpCNhLqRu6FclOgKYMy1CBxv/RdCBEgoYC/8H5?=
 =?us-ascii?Q?yMfcOJB24nlAfEU4PSeY728yymSHbExL6WU2zkGOseYCLSttClL0ztAnVxV5?=
 =?us-ascii?Q?pPCriFl2xX4D+nRR8S5jA+Q5kxcMM2CpPpl1TwZ5KzfRMgykKgvIcupfLqOG?=
 =?us-ascii?Q?AJnurzYGp1yyH7KwYrDJIz+KTvV7VpK1ed7m28YjoJqKsCm1BshCLU32CaNn?=
 =?us-ascii?Q?Ftlho+cg3zUIWUvOYNAOmnj6+1PnoDyDuWJVo+XcHLeyX/ameAc/ddr0a2ti?=
 =?us-ascii?Q?eTdkqSGrkO//iny/M3k2ph8LOvD6v/a0L9/zryQu9jwBc0xnBsVjgx3YYlEe?=
 =?us-ascii?Q?BYpSVe+74kgrjrSjrJgMD9ybrXK/3EGcH79rgZt6sZio2J4pYoG7faVT2nB1?=
 =?us-ascii?Q?+MtdDq0eHAPjStE7WK5GTIMfJo00/l++JvWbuKAUWwlHNoFZxW3WH6pgYDhC?=
 =?us-ascii?Q?dUUhJgLtoNdy+0V58y9DKit6Gmli/UAZnLP3Ct4FDiLfx6l8aQvVsOCx4HuA?=
 =?us-ascii?Q?nJ+ThGG45y9FP8HnKnC2mCSATkPuMBml+u4D2OtAZfuJlgYcs0BRm8gnWdpe?=
 =?us-ascii?Q?+KhuYmfM2Ay0NnBfQ2PNhbadp2ViHLvQH6tFgcS8vlj5e/U4DiLasi+3sbeh?=
 =?us-ascii?Q?8fmad6d6Ch3Z9H1bxGe5JINfuvQq0PjC11k1bnUxRjgxh/xKZGafLo4yJW5A?=
 =?us-ascii?Q?Y+ERCGgtiQTZ6J6PCBYAbM5bgfmTo2HOG1kFIaPgALEmkzy/NAtsF5zuTZAX?=
 =?us-ascii?Q?Zsf8Oae2cdEBw41iB8pBgPDAO+2NCRvE/aGIxijmTDsmXTv5MaEDk0Y3WhJM?=
 =?us-ascii?Q?dl89yTbFZOhMbWa/OkXpJHPexCO4KhUnU2MOU0PcnePVhuAt+wW6P2zB/F3G?=
 =?us-ascii?Q?BsxJiwp252v6dqgpZEc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 03:19:52.3120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3926b48f-8ecd-4dd3-257f-08de27e3ab9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698

Introduce cxl_regions_fully_map() to check whether CXL regions form a
single contiguous, non-overlapping cover of a given Soft Reserved range.

Use this helper to decide whether Soft Reserved memory overlapping CXL
regions should be owned by CXL or registered by HMEM.

If the span is fully covered by CXL regions, treat the Soft Reserved
range as owned by CXL and have HMEM skip registration. Else, let HMEM
claim the range and register the corresponding devdax for it.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/core/region.c | 80 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  6 +++
 drivers/dax/hmem/hmem.c   | 14 ++++++-
 3 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b06fee1978ba..94dbbd6b5513 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3749,6 +3749,86 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
 			 cxl_region_debugfs_poison_clear, "%llx\n");
 
+static struct cxl_region *
+cxlr_overlapping_range(struct device *dev, resource_size_t s, resource_size_t e)
+{
+	struct cxl_region *cxlr;
+	struct resource *r;
+
+	if (!is_cxl_region(dev))
+		return NULL;
+
+	cxlr = to_cxl_region(dev);
+	r = cxlr->params.res;
+	if (!r)
+		return NULL;
+
+	if (r->start > e || r->end < s)
+		return NULL;
+
+	return cxlr;
+}
+
+struct cxl_range_ctx {
+	resource_size_t start;
+	resource_size_t end;
+	resource_size_t pos;
+	resource_size_t map_end;
+	bool found;
+};
+
+static int cxl_region_map_cb(struct device *dev, void *data)
+{
+	struct cxl_range_ctx *ctx = data;
+	struct cxl_region *cxlr;
+	struct resource *r;
+
+	cxlr = cxlr_overlapping_range(dev, ctx->pos, ctx->end);
+	if (!cxlr)
+		return 0;
+
+	r = cxlr->params.res;
+	if (r->start != ctx->pos)
+		return 0;
+
+	if (!ctx->found) {
+		ctx->found = true;
+		ctx->map_end = r->end;
+		return 0;
+	}
+
+	return 1;
+}
+
+bool cxl_regions_fully_map(resource_size_t start, resource_size_t end)
+{
+	resource_size_t pos = start;
+	int rc;
+
+	while (pos <= end) {
+		struct cxl_range_ctx ctx = {
+			.start   = start,
+			.end     = end,
+			.pos = pos,
+			.found = false,
+		};
+
+		rc = bus_for_each_dev(&cxl_bus_type, NULL, &ctx,
+				      cxl_region_map_cb);
+
+		if (rc || !ctx.found || ctx.map_end > end)
+			return false;
+
+		if (ctx.map_end == end)
+			break;
+
+		pos = ctx.map_end + 1;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(cxl_regions_fully_map);
+
 static int cxl_region_can_probe(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 231ddccf8977..af78c9fd37f2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -877,6 +877,7 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
+bool cxl_regions_fully_map(resource_size_t start, resource_size_t end);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
 {
@@ -899,6 +900,11 @@ static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
 {
 	return 0;
 }
+static inline bool cxl_regions_fully_map(resource_size_t start,
+					 resource_size_t end)
+{
+	return false;
+}
 #endif
 
 void cxl_endpoint_parse_cdat(struct cxl_port *port);
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index f70a0688bd11..db4c46337ac3 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -3,6 +3,8 @@
 #include <linux/memregion.h>
 #include <linux/module.h>
 #include <linux/dax.h>
+
+#include "../../cxl/cxl.h"
 #include "../bus.h"
 
 static bool region_idle;
@@ -150,7 +152,17 @@ static int hmem_register_device(struct device *host, int target_nid,
 static int handle_deferred_cxl(struct device *host, int target_nid,
 			       const struct resource *res)
 {
-	/* TODO: Handle region assembly failures */
+	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
+			      IORES_DESC_CXL) != REGION_DISJOINT) {
+
+		if (cxl_regions_fully_map(res->start, res->end))
+			dax_cxl_mode = DAX_CXL_MODE_DROP;
+		else
+			dax_cxl_mode = DAX_CXL_MODE_REGISTER;
+
+		hmem_register_device(host, target_nid, res);
+	}
+
 	return 0;
 }
 
-- 
2.17.1


