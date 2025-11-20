Return-Path: <linux-fsdevel+bounces-69185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1339FC71FA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 04:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E16224E4959
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 03:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4611931078B;
	Thu, 20 Nov 2025 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mx3c2FHU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BE230BF77;
	Thu, 20 Nov 2025 03:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608803; cv=fail; b=cC6jJJxkN6mSv41OeoDMYxQSjs2PGDy2pn7XKS6GRp0OBAZyi3m/y0S4GNuNfJhumGqo1jZyHqOCTWlFiwq7ATBYstLt0eeZL5jVl3FYAYHXK3N6yJXsEoV4s7KUL3UOcViBJqIpgbtqhODUTEWRYdg3J9jS6ArPPMFyHhtJMfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608803; c=relaxed/simple;
	bh=LlEUyEBSeE10nqMfo2f4d/fiOlCEneA0VJMYXCKK1os=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p80QpP+wduUDVt5ZGWCiRck6cVY8QnFjkDDRSX2R05Y7Tbk3rKrbJeFJxsD94dsmTJgkP753pmYk348mW6ZW8tIidn+EilO7BBcb0eOoxz7ZRV5E78Jow0cItZO49PqiiDfKG5OIbTR332cpmNf3ZgbHOlHwfcbClfHUuRBXFJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mx3c2FHU; arc=fail smtp.client-ip=52.101.61.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auJ+ssRvJ5oOljJjkz+lQk/cxcJDoAIlWGemx1yZd4K0YDtczMmxCDsc+jSaaDylGvuxy6RiZH2MPT7EsyVedl7Hi+Tc+mD408IQxHRC+B6QHl5l9Wl3Lg0pcHlv7EGMxhZ6cNIBCq5jTLPXjYW2UiX0j0vsN2myDT77nl+S7bpdepIemDiwcHLdaCf3xyh5g3NGVbEZa7KBEuLdgGrWf7aKqoYBzjaQ4r+O9FHVPMkrPw37gpzl3h4kMctGBNW6oika9UvGfMvIGpQxV/HFaYk33KyhgY2n5vvsHJsB1ytIaVI/qiV9kMngDVmNJuFv/V19fWU787K0quI88Mm9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Iwui5ZRW+AEGL99iX/w4GMvsJ2sVv917D4ur5GqVhc=;
 b=kM+yqcB3RMDamBdx54fe4dGF3HZ1RqC/yLkK/avuHIpvpdlGDsj5GvF0RkAgdIrwc/nh2jCbY7j5OJw7pqL26Ixerz2s9wO195Ov2hz7HPaDrD5RZIZKpKuQIcuV893QiQVaaCgj7qcOskEkBBavx+4C3Wb97FTiHieXrp88Q20ZmdzUlfIrlO2qKTwIxYt7FDL2Ex2rToHblvJ4eCFfmBX6ID4XI+ddZNFy4wt2+/EhJnb6SvK1FzPthFHd3Y6HKx6RGa1RmOkKUMDdkPhUxSD/OWtXeTLLrGNxtxp0aYQSpBUyVPaBzdCmzEhAxQuBgGoCu61Jgra0qdT9wcvfrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Iwui5ZRW+AEGL99iX/w4GMvsJ2sVv917D4ur5GqVhc=;
 b=Mx3c2FHUfLCKJAh4lomq3HfLNuW0HdzXdFB1E0DnA3narwZXfolafjc64YELcBVMlUpYkVn7NLU7S18Rszy2Cq8EzTD3XdxOpRmpNKg1sPqiLwIckmbtTz1SfZbG0j+DKvQYdHriHMs8ZpP5Evb3dMyj87F+xxRAThpPeSDwZiA=
Received: from CH2PR18CA0041.namprd18.prod.outlook.com (2603:10b6:610:55::21)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 03:19:55 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::3a) by CH2PR18CA0041.outlook.office365.com
 (2603:10b6:610:55::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 03:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 03:19:55 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 19:19:41 -0800
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
Subject: [PATCH v4 7/9] cxl/region, dax/hmem: Register cxl_dax only when CXL owns Soft Reserved span
Date: Thu, 20 Nov 2025 03:19:23 +0000
Message-ID: <20251120031925.87762-8-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: adf5591d-a73b-477b-b1f9-08de27e3ad6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zd75eiLN5FROJtvmQWsZ8deileN5c2GrMR4iNHXda8Sm02P9Qp4ta4OR6mdB?=
 =?us-ascii?Q?uYUloaWR9As7e/QsZdJbPcvBmpFQzZfRDZFOsYwea4rxyQ8FEp+d+4r+9qoB?=
 =?us-ascii?Q?aKh7NlODFXMpzL3aQnTv9gzW75RI+X28ytVgRE9c4ROJhz4LNv7xuI99D4ov?=
 =?us-ascii?Q?dsa4p/8KNuf6KrFBNgWiGeqUO8VHKH4zo97Uuln3wTRnwGOA0KVIfeT4dmtD?=
 =?us-ascii?Q?kOA8fHhtWGYmiNFsOEgvVpygnEvnz8GZ10Nh7fb3rhAKabLNE2d4Fv1mOhap?=
 =?us-ascii?Q?3yl2yVzrk7xZoDYgPI/R0TxOyaJWsVx3GUkBxdAdrKZGowpk6+Loso4EX4VE?=
 =?us-ascii?Q?psLMFnqMGxQ9aOia4iw4oMDO5XbkaDujY59+BkpSJKOz8rAve4kGi6NjC3rV?=
 =?us-ascii?Q?DzvQuMPYFOrvbzsnOau7NkgTqKrcnNpSMrkqXOWWxvdBwMxNV0YYmzjuM77N?=
 =?us-ascii?Q?4XhpiIhrdgSR9vFbMXD5fR8Z0uEy2XOrS/xXOaKSHyW8JUuAkCjRS2s9/E1w?=
 =?us-ascii?Q?JkinfsUOU1YmW+FPPZ1sVfb9kFPpkB8WVvmueit/Ue/lYin3MWGNWO590Qtq?=
 =?us-ascii?Q?HBS7J49xb38PMfGUJ3cR10ydlIGtMFqddtzW/c4nxWXCPBi1eDgsSrD2SGsY?=
 =?us-ascii?Q?+70e46SQLH0qDoVWfEmObn0her6hrEO1W2TscLmk4mU5PmX6d7mYQ08NsScE?=
 =?us-ascii?Q?R6YXVxq53msS55F/g9WDiE+kE4cfTiE1W29ykEWulh1hWBeEQ3AZ8sVBGR8c?=
 =?us-ascii?Q?DzQUxyywfXW/okEe473V+4kERPhqM+zmN5xoJyAJxw4IMsCfk8MIR6bJSP2s?=
 =?us-ascii?Q?Qogk1qRHecVKAHSKftDjAFRmyg1MNzBp+HMtB2Aa/2sNeGcpKPgHVVhVBAWD?=
 =?us-ascii?Q?4dVwvKAgGZ9ytPSZXL6WVPfSm6hk7OBf5aVYjoqhuSXnsNvuRTHfbjl2jZSb?=
 =?us-ascii?Q?VVKi2VZo76eVbMfviL0VxKzZyLGNI9cNUbi0/ZRh/m3jtEDguLOLx3Lfg7rP?=
 =?us-ascii?Q?F8vFbuI0g1Tjube/XzuuKxWjxeRkmu/SjFqIFGJW5mFpLH1QFifPC7GJPjdO?=
 =?us-ascii?Q?tkElmXSHQ3VTUAANyo7+PWTIyCjB+N5AZqeD6JitgzBxcT6wCxo0RrXs65GA?=
 =?us-ascii?Q?ieY/tTfyFNO7W4TtfNPAZmrww4tRyvI8Ne8BRMhFHtoK/1w6GZSNCyqGELOT?=
 =?us-ascii?Q?PC97NEDjUlhxKWQI1w/sHrXA4qGsUcx0eAPfumKQ/6H+QjcqRqiLDN9Xl7Mc?=
 =?us-ascii?Q?OehhGVfIiyT+F2v0xTzbpNgGHk5no4i/ZOYpSgsegpGMt456wcUkzbky/LCc?=
 =?us-ascii?Q?6J/HO5TxHwdLEbEHkZ/3mh8wSnO0soUAsEvuC4GdWEftJfXPtqzYM2UCe+gz?=
 =?us-ascii?Q?FX4Z/Mdfr5poXIKAoTcWnPT18KIvVrZt1bL5xTMr3UxwAvTQe/OahPxNwd9T?=
 =?us-ascii?Q?M0Bg+zeRfCESRB+hBeE0WQwD4u5iOHsY8QxqvEAzUawaDXNaFCxIWvhMWm30?=
 =?us-ascii?Q?k8fbarRnmHhepqr+ncuIoCfg8Ua0eG+LwNzmz6xpT0BxJ+rglpAJ5Fq8Twkd?=
 =?us-ascii?Q?9pp4QW38qU8lspgzPcg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 03:19:55.3437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adf5591d-a73b-477b-b1f9-08de27e3ad6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240

Register DAX from the HMEM path only after determining that CXL owns Soft
Reserved range. This avoids onlining memory under CXL before ownership is
finalized and prevents failed teardown when HMEM must reclaim the range.

Introduce cxl_register_dax() to walk overlapping CXL regions and register
DAX from CXL only when cxl_regions_fully_map() confirms full coverage of
the span. If CXL does not own the span, skip cxl_dax setup and allow HMEM
to register DAX and online memory.

With probe time DAX creation already suppressed in the previous patch,
this change ensures that only the single owner (CXL or HMEM) performs
DAX/KMEM setup.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/core/region.c | 42 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  5 +++++
 drivers/dax/hmem/hmem.c   |  5 +++--
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c17cd8706b9d..38e7ec6a087b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3784,6 +3784,48 @@ struct cxl_range_ctx {
 	bool found;
 };
 
+static void cxl_region_enable_dax(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	int rc;
+
+	if (walk_iomem_res_desc(IORES_DESC_NONE,
+				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+				p->res->start, p->res->end, cxlr,
+				is_system_ram) > 0)
+		return;
+
+	rc = devm_cxl_add_dax_region(cxlr);
+	if (rc)
+		dev_warn(&cxlr->dev, "failed to add DAX for %s: %d\n",
+			 dev_name(&cxlr->dev), rc);
+}
+
+static int cxl_register_dax_cb(struct device *dev, void *data)
+{
+	struct cxl_range_ctx *ctx = data;
+	struct cxl_region *cxlr;
+
+	cxlr = cxlr_overlapping_range(dev, ctx->start, ctx->end);
+	if (!cxlr)
+		return 0;
+
+	if (cxlr->mode != CXL_PARTMODE_RAM)
+		return 0;
+
+	cxl_region_enable_dax(cxlr);
+
+	return 0;
+}
+
+void cxl_register_dax(resource_size_t start, resource_size_t end)
+{
+	struct cxl_range_ctx ctx = { .start = start, .end = end };
+
+	bus_for_each_dev(&cxl_bus_type, NULL, &ctx, cxl_register_dax_cb);
+}
+EXPORT_SYMBOL_GPL(cxl_register_dax);
+
 static int cxl_region_map_cb(struct device *dev, void *data)
 {
 	struct cxl_range_ctx *ctx = data;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 324220596890..414ddf6c35d7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -879,6 +879,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
 bool cxl_regions_fully_map(resource_size_t start, resource_size_t end);
+void cxl_register_dax(resource_size_t start, resource_size_t end);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
 {
@@ -906,6 +907,10 @@ static inline bool cxl_regions_fully_map(resource_size_t start,
 {
 	return false;
 }
+static inline void cxl_register_dax(resource_size_t start,
+				    resource_size_t end)
+{
+}
 #endif
 
 void cxl_endpoint_parse_cdat(struct cxl_port *port);
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index db4c46337ac3..b9312e0f2e62 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -155,9 +155,10 @@ static int handle_deferred_cxl(struct device *host, int target_nid,
 	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
 			      IORES_DESC_CXL) != REGION_DISJOINT) {
 
-		if (cxl_regions_fully_map(res->start, res->end))
+		if (cxl_regions_fully_map(res->start, res->end)) {
 			dax_cxl_mode = DAX_CXL_MODE_DROP;
-		else
+			cxl_register_dax(res->start, res->end);
+		} else
 			dax_cxl_mode = DAX_CXL_MODE_REGISTER;
 
 		hmem_register_device(host, target_nid, res);
-- 
2.17.1


