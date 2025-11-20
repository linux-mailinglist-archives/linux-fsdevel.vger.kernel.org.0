Return-Path: <linux-fsdevel+bounces-69184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 478C0C71FA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 04:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20E874E401C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 03:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635C030EF87;
	Thu, 20 Nov 2025 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YoHhNBI7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64A30AACA;
	Thu, 20 Nov 2025 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608802; cv=fail; b=JTSAtNCT0DeSAwHg5hKSRxprPoSa2N57GN1hABPsgacT3XLG3IGS1Uj4dUC7L7fuDBsICqI3N8nBTMl/xWK0nhsG0eE3G+nZbO+a/agH5sRHcfvnLNY7Qajnq1LptIjHNKsw5bgMeLpuKea6jFaeqidmyAd8hfPDbvGLBG86m4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608802; c=relaxed/simple;
	bh=VRJjlMiaufE4te1dnbReZ26V0U5sSizffoz1rYyOwd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOWLfuhbVSkGBRpDfxHEbZ6CuHVdWlLf6KytexdKn6msjSGjENjgudXy03euoegDnu7L0dM9l9Xk6qMexG09f1ul9/G1iLBVvtltJW0DmYt3l8mV4iVxPqaqZPdJ7B2Pi3x0knD4bLslZtCjPDwnTDvr166ynZqC5zQJPFT4Z9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YoHhNBI7; arc=fail smtp.client-ip=52.101.48.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTWnzz4mFS4V22NZYa4XTuy+U7FCkj6Kcvhj7M0DixUIRrpIuBxTVbptRth0HckTVWpwiBrcluOTOEruHoQvE2PiQFGP0mErmAl36iMe3/INc0kLbmX9P3iIESYciyUS4en7jywPBkeT6C7f9ppVSoq87Al9aUz67nLHhkbffyYLcCPKyFKG+PMVyelGf14VAerbXruJ+xwzuCjPlW5+Z+Dry4DT4LmIPRK0FErs3zSvd/p0tXTEUN+UeCK04+onE0Of0FSt/TOkAnE0wU+Wg3J1RtnqRoSIe/6cqndJ/yFM50+WtkWMWD1eiieZzXu+Cl1Ly+F6LPSH2I2Ys/03iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXd5qeId6wjJr6jDBt04wqyOs2rnP1NtE9pArbqBpW0=;
 b=MIL9oJYJOSUsLVTpqEme+IheKrjyikq/3LPOzRgMH+l3OvKhs0tZOaMHWDO+5CtZk57rkhcBR1cDvDSWjzLyyYpI0Rs/6jyyPTuYU25AttdsrwYPH9LE1G2m8436x5eU8jEPrOM7tOJugCsrYJ1tnws7WLVhuhMh3xT4xUDhqFdpvQROSMUUmPjqi3GwxBrYmYWc/9vHK4sRylHy/x9LnZ6i+lgvclMIb9gsu+G+Rjkjq8df/zAi5udqJ+MIs6hTvw4LaEKPDvUylAMClM1E8hGP+O6LdayDZ67CodEynBmIeSLyI3tHPzo+jaxJSkROtTn5kPdbY5pD8/c2UOvZsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXd5qeId6wjJr6jDBt04wqyOs2rnP1NtE9pArbqBpW0=;
 b=YoHhNBI7n1qeVFWtSOlKEy0mOETSrz//AXC+1PrbUd7/khsjmB7t6oZhFZbaca1V2z+F3YxSD4vRCFz45mX53XTsm0OrFU52JkkeMWKW7WY+qNk5TSUnZ2+W3bSMyxOu9GCVtzG+UiWugNrasdhLxY/kuyZtVRPHny+l6iTcou0=
Received: from CH2PR18CA0058.namprd18.prod.outlook.com (2603:10b6:610:55::38)
 by PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Thu, 20 Nov
 2025 03:19:56 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::c1) by CH2PR18CA0058.outlook.office365.com
 (2603:10b6:610:55::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 03:19:54 +0000
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
 2025 19:19:42 -0800
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
Subject: [PATCH v4 8/9] cxl/region, dax/hmem: Tear down CXL regions when HMEM reclaims Soft Reserved
Date: Thu, 20 Nov 2025 03:19:24 +0000
Message-ID: <20251120031925.87762-9-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 246f79ed-560d-4e1b-89a9-08de27e3ad97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RedRE+Q8EFXAdxdsOm4f5sK6hE5CkLyQ/Z4SVUUmsqdDxZ663Hni/2Axuxdn?=
 =?us-ascii?Q?xD5eDKPmxzpjg52xd6LqMqi0yqAn7CkC+sRtnfRX88kd1nzZf8aao2aU0VMR?=
 =?us-ascii?Q?n36+rl0yoeP77EuUO7nzCqYTXXkh8Z0bWWZh56hCR75oc4R5TVeOFFgTb8YA?=
 =?us-ascii?Q?HvcxphvJFKIJD97OGEcUk8b5gAMh5h/Oa+sJqunJwn+X/jmWQiUAZJkWE1Fr?=
 =?us-ascii?Q?ckccLTObfZqQI4UtcYrRbCrKrqYi3NF/ZPib/aSR+fM8OIlUm8FZ78geq9lk?=
 =?us-ascii?Q?xAv7OceZnP9GQ5qax/V3jgbLxeS7pgPoYdWpNwNlYpl9QZEh+Fk1p3nE6jpR?=
 =?us-ascii?Q?/zZqiFPtBsuXqJH1LC9vVk+7xAyu58R7KeJjosk/lVymAvy4lx9Js3JIK8q2?=
 =?us-ascii?Q?LOhR04ENlsSJB8UyB68syx9+U22FKC8aYDfL4fXUv6ZnDpIaQxX+WLfGACov?=
 =?us-ascii?Q?rBgfaIRk9kQ9qnIlKnoNF4PxxIJ3096/kh0aCcbEEEq1JDNly/9S/vvlDDft?=
 =?us-ascii?Q?rzhJWcttaJjTmx7wC7KAQUwOfctoyWaU3dEz7WOn9RpAYxDN11Vb/o128EK6?=
 =?us-ascii?Q?30GnIDz+uK0Tvig/GpfrBev/9NuT5xDPKSolt06Xm6160e9v8ogyCO7e6/uk?=
 =?us-ascii?Q?Ik747Fyu0mJPzZXdgKWydRFTsfu0WRTNmBAmLr+M5NQWEYnE6kwXGBIuyQN3?=
 =?us-ascii?Q?Wr1977H4Z/IR9s8s/BCsDRY/EnhatVf7liStgiPDg7+OvNqvk92P6MNQoYe4?=
 =?us-ascii?Q?mh+YSUYL7lML6E4+FHU391UNQIy7t9xDfOfFGyTEWTJsz+yEw4DMgEKQTd0q?=
 =?us-ascii?Q?kJfZ8IlkvY0J4g3S+ybu5LFxp+REKkq4wv+eDIE+ADSc0x4WHinYyQCvExqZ?=
 =?us-ascii?Q?SOGgnhbDNw8FyAZg0k5SWoSnX9sj9CD/RAkY9RTmjW02e2vjvH5ryfGmImCR?=
 =?us-ascii?Q?ZrdH/NHNMTONi4lfABFUW/rsUoOqIuY12z9ATqMIGy/5SWe/9icEMGO98Mkd?=
 =?us-ascii?Q?PCxjnaaOed2SIc7iVFA+bK+MEIEt+R+jXr0unn1KzqJKh5PsBS0OsmGt++4Z?=
 =?us-ascii?Q?L9G/AyUboIIs4Bh6uJo7hSEM+bSPAJotNnvihK0/qS76RmuihUfVns4wXES4?=
 =?us-ascii?Q?aRmmrGZK54tjkABPDsAUGRsRucESQOjY/QVddj7rP8N2USf/jSFSXvBuAQ4F?=
 =?us-ascii?Q?0RMLNJjLeIGqVJ5c/TqUsMB5mYqEmRFvOse75xl+43qNojM2aOP/WTqnUUPF?=
 =?us-ascii?Q?6DA6LX9NxsUGv/9u28mw9DC749IjSI0dd4EZatIr2qwN+rytUlvAI1mvU3tk?=
 =?us-ascii?Q?hNOGeg1SCYmosGO6FnBAht98WnPCdRpPAktus6kn8qWx1CdRxUv76ORC5lxr?=
 =?us-ascii?Q?j13hnhiVjLxt0AdkL7H/vDzb8RICh/j5uH4v6O4CV0D+3q4xwJuEglKcCLP6?=
 =?us-ascii?Q?Fsvr8+sjmhpGD+MSVfgZNQ0xrRpilPRT5JO3tKEooGh7DW0rDkLWGzTyQvPl?=
 =?us-ascii?Q?64TTXiwjr9/8IiqK3aIcYCFnCtYWNbPmvKAHREjVhGnIHQ5Cw2190WcE2IiF?=
 =?us-ascii?Q?0sftl0RTdN6ZfEBpGU4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 03:19:55.6315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 246f79ed-560d-4e1b-89a9-08de27e3ad97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974

If CXL regions do not fully cover a Soft Reserved span, HMEM takes
ownership. Tear down overlapping CXL regions before allowing HMEM to
register and online the memory.

Add cxl_region_teardown() to walk CXL regions overlapping a span and
unregister them via devm_release_action() and unregister_region().

Force the region state back to CXL_CONFIG_ACTIVE before unregistering to
prevent the teardown path from resetting decoders HMEM still relies on
to create its dax and online memory.

Co-developed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/core/region.c | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  5 +++++
 drivers/dax/hmem/hmem.c   |  4 +++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 38e7ec6a087b..266b24028df0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3784,6 +3784,44 @@ struct cxl_range_ctx {
 	bool found;
 };
 
+static int cxl_region_teardown_cb(struct device *dev, void *data)
+{
+	struct cxl_range_ctx *ctx = data;
+	struct cxl_root_decoder *cxlrd;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	struct cxl_port *port;
+
+	cxlr = cxlr_overlapping_range(dev, ctx->start, ctx->end);
+	if (!cxlr)
+		return 0;
+
+	cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	port = cxlrd_to_port(cxlrd);
+	p = &cxlr->params;
+
+	/* Force the region state back to CXL_CONFIG_ACTIVE so that
+	 * unregister_region() does not run the full decoder reset path
+	 * which would invalidate the decoder programming that HMEM
+	 * relies on to create its DAX device and online the underlying
+	 * memory.
+	 */
+	scoped_guard(rwsem_write, &cxl_rwsem.region)
+		p->state = min(p->state, CXL_CONFIG_ACTIVE);
+
+	devm_release_action(port->uport_dev, unregister_region, cxlr);
+
+	return 0;
+}
+
+void cxl_region_teardown(resource_size_t start, resource_size_t end)
+{
+	struct cxl_range_ctx ctx = { .start = start, .end = end };
+
+	bus_for_each_dev(&cxl_bus_type, NULL, &ctx, cxl_region_teardown_cb);
+}
+EXPORT_SYMBOL_GPL(cxl_region_teardown);
+
 static void cxl_region_enable_dax(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 414ddf6c35d7..a215a88ef59c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -880,6 +880,7 @@ struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
 bool cxl_regions_fully_map(resource_size_t start, resource_size_t end);
 void cxl_register_dax(resource_size_t start, resource_size_t end);
+void cxl_region_teardown(resource_size_t start, resource_size_t end);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
 {
@@ -911,6 +912,10 @@ static inline void cxl_register_dax(resource_size_t start,
 				    resource_size_t end)
 {
 }
+static inline void cxl_region_teardown(resource_size_t start,
+				       resource_size_t end)
+{
+}
 #endif
 
 void cxl_endpoint_parse_cdat(struct cxl_port *port);
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index b9312e0f2e62..7d874ee169ac 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -158,8 +158,10 @@ static int handle_deferred_cxl(struct device *host, int target_nid,
 		if (cxl_regions_fully_map(res->start, res->end)) {
 			dax_cxl_mode = DAX_CXL_MODE_DROP;
 			cxl_register_dax(res->start, res->end);
-		} else
+		} else {
 			dax_cxl_mode = DAX_CXL_MODE_REGISTER;
+			cxl_region_teardown(res->start, res->end);
+		}
 
 		hmem_register_device(host, target_nid, res);
 	}
-- 
2.17.1


