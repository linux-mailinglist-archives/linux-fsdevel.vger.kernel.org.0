Return-Path: <linux-fsdevel+bounces-69178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBEAC71F5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 04:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0D574E4963
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 03:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6BA2C3770;
	Thu, 20 Nov 2025 03:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gJ/beCaH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010037.outbound.protection.outlook.com [40.93.198.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7706E256C9E;
	Thu, 20 Nov 2025 03:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608783; cv=fail; b=fd5uBMCSY9f0CO0w9y0NHxoLkpu3xMi5KIKq9kF4d9pNMYyR2n/NkVzr1sacApWzRdzBrccKmDTYSgmCk4vlB02oeJOwXDkt6S6jNQunoWmyp1k47Fcbx7NMzHX7e15tgYSWTOxYcm5jNjOGW1HJMkM0sQm1Kb2tS99XC5BzYg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608783; c=relaxed/simple;
	bh=RFEx0pmpZhf4F8ppIyx9aB8xkQiJ/ojPe0UbZpXWBAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDS9KuRDQq0y/nihSUGQGDlEYTL5VGX148gV7P+Ae6P6CD/uKMxjhRTuS78XESnbeSY5ePXwJxCjh8ePdZRY5QKLj/CLom5V3QFE21iiQW9LV43GGkg69qtjzFI/C8988lAB/G8FS5scoWZHTnqdWDe0uLFFCjcN//iolsGqZf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gJ/beCaH; arc=fail smtp.client-ip=40.93.198.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5jZR5ZZM1uEIEij1So+2sZlzkAUR5NRUgbpWNdSHkpOemkDPJrwlVQKdBkx5tYrDTSSQ51nKIh2dy4tthtKSN3acDCHMY0vxZqicP2b65IudKELlPRTrdeqGGeguUG0Z3BvPSBNee4LyNCOwp9bzHl0x6aPmZoD2xdsHWWVBWweBP9h29uV+vwwT0o3iNt/3cfmVn6tM8M1RE3d5FZd26WRyZTp1BFt0sA1jiRHsqdrVxkbPZws7CaFCF+SL/vi4NWILoCB7hV0KmzEsaRIOuZQ1L9pcNIVAmGWULev6wR6FhxU7XX2hXIStJA7Q142AWY9GwWAgF4wb9hfgTLqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd0Mke/S9wEMVjc8P6hlfH/ROlPlZSCD2uUSrFFSKyM=;
 b=bjxqJ3OidrxhEYyJhPaFGdP2wn+J8poUfVH3ec3kEM2Z01MkIPbqzTVZOi5FmjSJNSLqJjkAtO9nTy9LIYix0GDuip85xE5JcNYc/cOsKAu9k/tczQhSv2Otckoc97SMJTIxuEYpQzomuZFb6DXV6StBE/tfXAi8XMP9KNoBSbYGbUldfqheyo3qnX+R4ZWtXouSNuqfJ/xu4VWh36MgM8YpyympwUktLzLIZqzSTCfS0DVTHCBV9B7kiu1nzqkWifzRe9+fHpa1EA54MOOMbjgcLljKa3O3wafO/UzlnETYGV6gEVXgpm4UpNfQInWraHL4zOTbpUqkZrSg1Nq1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd0Mke/S9wEMVjc8P6hlfH/ROlPlZSCD2uUSrFFSKyM=;
 b=gJ/beCaHplHjSulQwbZTXj/sce79ZWJzFzyozFraO6Nmxvvht21/hSJzA6H5rmGrULPJwR8n79NJLQKLfWSAdll7YvmJihsBAhOpGOObscSf0nD6XPjkS5nAUuwiBiZ7bIETJUYYGkjEpX7lwf5eu55/u4FF3qEECEOKVwf0zaw=
Received: from CH0PR03CA0441.namprd03.prod.outlook.com (2603:10b6:610:10e::34)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 03:19:37 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::64) by CH0PR03CA0441.outlook.office365.com
 (2603:10b6:610:10e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 03:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 03:19:37 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 19:19:36 -0800
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
Subject: [PATCH v4 1/9] dax/hmem, e820, resource: Defer Soft Reserved insertion until hmem is ready
Date: Thu, 20 Nov 2025 03:19:17 +0000
Message-ID: <20251120031925.87762-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|DM6PR12MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfcb96a-98dd-4d02-e9ff-08de27e3a2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Os3U+mGKs4LdhYCNM2+eeFLN1kHciZeuiSa9RNVFhz/Wxb+I5/r9VPO96fHh?=
 =?us-ascii?Q?k9d1ZPhF8327lJ1ihxLpDGsMulztcr7hjM5rImNsXNaPBRrk1MrG3ugt3CBe?=
 =?us-ascii?Q?/rik08PMmglub2BjPPGUE9+93MOdrPdwm1piyX4582N54YbP82QWL2CGVi6d?=
 =?us-ascii?Q?at9m+9rpOSoUMJLxxCvvPDjzI8KmxHkT5KvvDctmGWr3V/sQO3SyfyLpcfqn?=
 =?us-ascii?Q?Oy3GuIKcySrCT2s6WVsUuhgWaITKOSudZl2aFidRmdBRInv4ktjdfXMTQblI?=
 =?us-ascii?Q?YMdBs6fy8+i2mVWM5nwPO9Cieag0MBBUomqQfuW79M1R/APx4g05iAqg3JTQ?=
 =?us-ascii?Q?iVEWCMpeTdJxhRPeKyCHNur4OPzA1omnPBuQmvk113y8M9TEXTDFlalYoYm8?=
 =?us-ascii?Q?dwPvne2SBq1yeAagihZwUj4uuPo8TdBFloOr2eDrKTBDgLpveMRYJlDjTQs/?=
 =?us-ascii?Q?3/FE3+/VL99MvE4pm9Q+AscSYTtBRhL/S+DsGIWgxr1Prv+Mjw2kjsRXd1rZ?=
 =?us-ascii?Q?Wn7phA/k6OpJAb/0vOkttKvYHLYmpYCJsx3lM/qwDd8ej/XNZpDyH8YI57eh?=
 =?us-ascii?Q?AjO9f5z6ueBYCdrxjFHlH0WmoUOzFryDZoDZIct1hKD5Oss17yQzBT9vRt81?=
 =?us-ascii?Q?HD3bwxxaTsqcW3gvRSh04l7iwFnYBfPpWqFJMWiQscWbKaH7TOE6SH23LR63?=
 =?us-ascii?Q?LoHNizk0safrLAhb/GR8Aa07ptZ6/uwPagCxOkozH8D0s8IzARfFof7KKP8y?=
 =?us-ascii?Q?cOlghw6u+pP78w1crwk50/wCFBLNw6frc2OWMjWUvX/txOD4OntdkT26DWk1?=
 =?us-ascii?Q?BJmOUmJV7OgY0v9LrrzgqwIoL/ZJSvOVtfkVgA1qbDuKzSVyOmAuwY6OfeSh?=
 =?us-ascii?Q?pLj0WiLVTEi/QlpGZuRCDr2HB4aE23zunRr4DSaK5HS3ZZaW8NTH++KhF0hr?=
 =?us-ascii?Q?r88B92pqF7lS5jvcElJyiXet5eho9hdN3mEs3cZPF+kERnLAP+ygDb5Ney3S?=
 =?us-ascii?Q?JbhC9xjeN9Z3dC0OFe6RfcXsDv3rEC5RL6EYoilQoKsUB1spH/5fa12bJW95?=
 =?us-ascii?Q?3Si6Ls9igRhbzMTfPhWSLMzwPy48WKJFTTEtwCfMLRSxonbJEZO4ZyGhkrTJ?=
 =?us-ascii?Q?IHdjtwFuMkjw1W2SNWH4lpsMSUV7IXX96aVVLseor6ad8zSHCFHqIffZ5d4X?=
 =?us-ascii?Q?bpxYl88YhgF+0OmD+IoO7IcG5TP4Y95YvJpHkcuqOz9lJt+Y6+Nwosmd3YfK?=
 =?us-ascii?Q?tXJH/0/YOTB7ClEEFOovTyg9gBlptE7uApPSbKIMmGjZy1bBlt493fhOMOiz?=
 =?us-ascii?Q?zPpzJBBlhWG4C8Pi4aPTWE9u3QNm0TPNdKKRyCxV2uQxsewy12YAcoFmP8ch?=
 =?us-ascii?Q?dOFdiT8RH6INDfw8MXb+RATjPE+ofWlRh0S1SfqX22GnoFZRTtw5C0o0lVfK?=
 =?us-ascii?Q?yJhQy75VF96xEklKm3YYAl0/YgKPkkcZSsRhgdCTKlpw/uXiDD4ZNJBaomFy?=
 =?us-ascii?Q?I1TQ1AfcBAVRoyjvQMDQYrmOjl/vgJQH+AQnbL8o5VO9XS5YEEHtwm0WJ+fY?=
 =?us-ascii?Q?TGIIbYpcUaKUKmB2TEs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 03:19:37.5522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfcb96a-98dd-4d02-e9ff-08de27e3a2d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187

From: Dan Williams <dan.j.williams@intel.com>

Insert Soft Reserved memory into a dedicated soft_reserve_resource tree
instead of the iomem_resource tree at boot. Delay publishing these ranges
into the iomem hierarchy until ownership is resolved and the HMEM path
is ready to consume them.

Publishing Soft Reserved ranges into iomem too early conflicts with CXL
hotplug and prevents region assembly when those ranges overlap CXL
windows.

Follow up patches will reinsert Soft Reserved ranges into iomem after CXL
window publication is complete and HMEM is ready to claim the memory. This
provides a cleaner handoff between EFI-defined memory ranges and CXL
resource management without trimming or deleting resources later.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 arch/x86/kernel/e820.c    |  2 +-
 drivers/cxl/acpi.c        |  2 +-
 drivers/dax/hmem/device.c |  4 +-
 drivers/dax/hmem/hmem.c   |  7 ++-
 include/linux/ioport.h    | 13 +++++-
 kernel/resource.c         | 92 +++++++++++++++++++++++++++++++++------
 6 files changed, 100 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index c3acbd26408b..c32f144f0e4a 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1153,7 +1153,7 @@ void __init e820__reserve_resources_late(void)
 	res = e820_res;
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		if (!res->parent && res->end)
-			insert_resource_expand_to_fit(&iomem_resource, res);
+			insert_resource_expand_to_fit(res);
 		res++;
 	}
 
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index bd2e282ca93a..b37858f797be 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -847,7 +847,7 @@ static int add_cxl_resources(struct resource *cxl_res)
 		 */
 		cxl_set_public_resource(res, new);
 
-		insert_resource_expand_to_fit(&iomem_resource, new);
+		__insert_resource_expand_to_fit(&iomem_resource, new);
 
 		next = res->sibling;
 		while (next && resource_overlaps(new, next)) {
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
index c18451a37e4f..48f4642f4bb8 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -73,11 +73,14 @@ static int hmem_register_device(struct device *host, int target_nid,
 		return 0;
 	}
 
-	rc = region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
-			       IORES_DESC_SOFT_RESERVED);
+	rc = region_intersects_soft_reserve(res->start, resource_size(res),
+					    IORESOURCE_MEM,
+					    IORES_DESC_SOFT_RESERVED);
 	if (rc != REGION_INTERSECTS)
 		return 0;
 
+	/* TODO: Add Soft-Reserved memory back to iomem */
+
 	id = memregion_alloc(GFP_KERNEL);
 	if (id < 0) {
 		dev_err(host, "memregion allocation failure for %pr\n", res);
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index e8b2d6aa4013..e20226870a81 100644
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
@@ -242,7 +245,8 @@ extern void reserve_region_with_split(struct resource *root,
 			     const char *name);
 extern struct resource *insert_resource_conflict(struct resource *parent, struct resource *new);
 extern int insert_resource(struct resource *parent, struct resource *new);
-extern void insert_resource_expand_to_fit(struct resource *root, struct resource *new);
+extern void __insert_resource_expand_to_fit(struct resource *root, struct resource *new);
+extern void insert_resource_expand_to_fit(struct resource *new);
 extern int remove_resource(struct resource *old);
 extern void arch_remove_reservations(struct resource *avail);
 extern int allocate_resource(struct resource *root, struct resource *new,
@@ -409,6 +413,13 @@ walk_system_ram_res_rev(u64 start, u64 end, void *arg,
 extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
+extern int
+walk_soft_reserve_res_desc(unsigned long desc, unsigned long flags,
+			   u64 start, u64 end, void *arg,
+			   int (*func)(struct resource *, void *));
+extern int
+region_intersects_soft_reserve(resource_size_t start, size_t size,
+			       unsigned long flags, unsigned long desc);
 
 struct resource *devm_request_free_mem_region(struct device *dev,
 		struct resource *base, unsigned long size);
diff --git a/kernel/resource.c b/kernel/resource.c
index b9fa2a4ce089..208eaafcc681 100644
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
@@ -648,6 +685,22 @@ int region_intersects(resource_size_t start, size_t size, unsigned long flags,
 }
 EXPORT_SYMBOL_GPL(region_intersects);
 
+#ifdef CONFIG_EFI_SOFT_RESERVE
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
+#endif
+
 void __weak arch_remove_reservations(struct resource *avail)
 {
 }
@@ -966,7 +1019,7 @@ EXPORT_SYMBOL_GPL(insert_resource);
  * Insert a resource into the resource tree, possibly expanding it in order
  * to make it encompass any conflicting resources.
  */
-void insert_resource_expand_to_fit(struct resource *root, struct resource *new)
+void __insert_resource_expand_to_fit(struct resource *root, struct resource *new)
 {
 	if (new->parent)
 		return;
@@ -997,7 +1050,20 @@ void insert_resource_expand_to_fit(struct resource *root, struct resource *new)
  * to use this interface. The former are built-in and only the latter,
  * CXL, is a module.
  */
-EXPORT_SYMBOL_NS_GPL(insert_resource_expand_to_fit, "CXL");
+EXPORT_SYMBOL_NS_GPL(__insert_resource_expand_to_fit, "CXL");
+
+void insert_resource_expand_to_fit(struct resource *new)
+{
+	struct resource *root = &iomem_resource;
+
+#ifdef CONFIG_EFI_SOFT_RESERVE
+	if (new->desc == IORES_DESC_SOFT_RESERVED)
+		root = &soft_reserve_resource;
+#endif
+
+	__insert_resource_expand_to_fit(root, new);
+}
+EXPORT_SYMBOL_GPL(insert_resource_expand_to_fit);
 
 /**
  * remove_resource - Remove a resource in the resource tree
-- 
2.17.1


