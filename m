Return-Path: <linux-fsdevel+bounces-63080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5727DBAB689
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803B61925687
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 04:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B8126E6F8;
	Tue, 30 Sep 2025 04:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qf1rBX3F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91309262FD3;
	Tue, 30 Sep 2025 04:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759207697; cv=fail; b=shh+RpSoB9TyQ1LoRodVttCJBK5lLKxJ5cewgaI8eClUSbpTxejMXhcL8LPQE3I+Qg8YfmPPTurdGlUy9gYOaN9zTT8M7+QBRAMZ1QAgsQgC/3/rvGcq2hL95L6F56sBwu5AqO+YKExqLwxB63ITkoyqMvXenZfzZ6zQKBQV9YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759207697; c=relaxed/simple;
	bh=V4yMNgEhh7MK04wsd8RvmubmaMyndrueeekyKFuDYg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Whbm/wK1WeHN5R41WtK91O027AKbfYp/KFY3Ap0CoD4fJ5ITzi3kOklxaHU0degOrvFylG9QOn8QBkUeLfNoxHFY7impVzgV3weWeH4wc8rVa42QUeMoRIvdLp8sJaS02Ipcz5rBt+QYxFCyBX51j8jsIlNOcjjyL4w8WGTudBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qf1rBX3F; arc=fail smtp.client-ip=52.101.43.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iarJToUVgDzfr3l04tCjQ1jEw9D6vtcer5/QAupCpL/vCwVwLlDlp7CDTF+RBEdC5qkBB5u+k1DTOOnMMaMPSODADwZBuG2TGUwBO3NHlLrgWjiMdMnf52mPa0KINg2B4AiMxY3Nu+eH2/FeK3vDvWHamVh3bw4SUe2UVvdfuQNnZLbJBMUNq6lO7mix6DWi6dKGnyGRDOUaquQtnXvHX7o09/17e8/qX8+UnO8QPtPgW8LgB6YLqCfCRYKut7UzYKfzK2EYSw0dsTJwvZ9yKi6nONoU+5AnX3eICfqYbAee2VeSAWdm7wP/BlbJaXs2VEjm1QcSPQTVzHdk1CEMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSrO0m4u6mlcT96L/QQYH2R3BEozxm2oE5lOmnXcbIo=;
 b=Y3FVb4skizDBHuYefx2UKxAtBnNr5Dp1FPTM8mUnfuu4JgKUx1XzXGQMrEgf/YZGyMpo7ikeRCKdiPr0aFrqXyfcKEOU51JRzU+/xofqj9dTPcfQm1QMdz6sO32L6doRRlKP16By+THjOvxZB2VdyAqBLahnSph+tIJZ/akudL+VobI8zS24NEbG6FmhvtY7M9si1YxU9XZxzPZRDYla3jmySfTmCzYMY3hEV6Z84iQ9Xfkk0Afx2qLJXMEZ4lA6tFWcN73j1jezotL/dLaNqEHJg7UH+a2LV7vdG8Ia7uMeSDKNRRP8ZABT0irzlfUtJEyL3tCnz5ziE7vGEfvu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSrO0m4u6mlcT96L/QQYH2R3BEozxm2oE5lOmnXcbIo=;
 b=Qf1rBX3FrAQKs3x/yVOQC4cM97N2+gWHBBmoONW+dzgZQ6akGqVHvw7b6xXrsEXRkrXYa3dn+Kjh4KKc7VSr1iZokitZHEF1kOOBH2fYQPFlZ4dQ4WC1H6a4fdQ1fFFNGo9YIrM9Xrhk1/HBWfepS0HJgtnl3ejseJ0DYcP+WDs=
Received: from BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::12)
 by IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 04:48:10 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::f1) by BY1P220CA0025.outlook.office365.com
 (2603:10b6:a03:5c3::12) with Microsoft SMTP Server (version=TLS1_3,
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
 2025 21:48:08 -0700
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
Subject: [PATCH v3 1/5] dax/hmem, e820, resource: Defer Soft Reserved registration until hmem is ready
Date: Tue, 30 Sep 2025 04:47:53 +0000
Message-ID: <20250930044757.214798-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|IA0PR12MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 3860e479-44d1-4daf-6f24-08ddffdc8e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1gNiAstxtz3LOmNuQaigare15OzsGZS/YX2XfKOcL1sLru9JvmSK3vy2WC7F?=
 =?us-ascii?Q?tl8cOc/jZ+1E6vwE3B0O6eh5pWvLpcQLjxgbZrKxQJ0vcB+NbPEzC1y2cxiD?=
 =?us-ascii?Q?36AziOGXLDJSwv2RyuWSox8PI4fL1tDO2JYAeD/6xo1do7J1tXLg9GnH61cM?=
 =?us-ascii?Q?8YEgUQ1p6bKc8FIPQeTqGTtrEQedsi5e6U2mZbJi9zcUwNrEP3BMfODwPkXb?=
 =?us-ascii?Q?G9gXLcZFYy7ksIkDrsaOSy09/nf1ltZvjiZJ/XnQTgbmsDdvvm5NbiufQUHr?=
 =?us-ascii?Q?ubGc1TUjMDKe39NzQ78TyQk3jS97iAhu0VDapAsWL77qDp/90f9vi0VPNjDk?=
 =?us-ascii?Q?luMfj8Ftbm2NUHMMUZPvsn8Ef048/zU4S6BHuzyNxL29qvOKanm+UlLgDgXa?=
 =?us-ascii?Q?4pI9EFFfeDkZMjJR6/2XbRyRQGzVXhw+CMUPwhYoz8kJoiXZW1y9mivd7x5L?=
 =?us-ascii?Q?f3S5kg3SlI15aPhwN64d0WAsRo4fIhne/NcFSH+HDQn5R37byFLcMxiJqQVy?=
 =?us-ascii?Q?DsGNDbAx5uuiUYuf3KA79pMJxmsN54zTqX12Kr7iAyyDT8Ngcrxd7xNtj6k1?=
 =?us-ascii?Q?RgZ4d1aUcZGGD5nzDw0HQzGE7cqbuLbAAZPuWwo+qOZv6YNmlwiIkeVg3P7X?=
 =?us-ascii?Q?dADKSn8mnZhk6hAneECjt99wfuGyad+gq3MCfYyDvlOzMfLU/LlfQAPgAqeB?=
 =?us-ascii?Q?ieBb6xF4d0PSDQgIxtZBKiCKPDIKqYDug4YjwASrJyt9EdcxF0qhUNsJHrnB?=
 =?us-ascii?Q?/kluDQuLhZNJXXALBGGpDGWFdHkcHXPoeMaapKzkR/PF/mYE0F81EboNY8pV?=
 =?us-ascii?Q?Tzhem1HVlzp7NnEnw++3L7q+r7HqWwY4yhYzdI0f3K8SF14Ve1WIBfsHp6h3?=
 =?us-ascii?Q?HaAZAljYAK8wqeCdVbFSCdGSDvsQIuMpw0fjyPTnkQdtHHzcINz8fs6j4yj1?=
 =?us-ascii?Q?5ma6tUzuk9mPkHyECm2jqpiNY5FvI69dCONXUrhbxMA+2dGgNaYxcRfLRaWF?=
 =?us-ascii?Q?a/RZJ9uFH4SmgEUZWBegBfJ+iObM29aIgalikiwWBJ138W5r0r0fn9yH1RSG?=
 =?us-ascii?Q?GHMK2+dGW9efcxVR4ckVu0ALtniVVAGVmByapfIw63nnq3Cn6NLaWAv7K3WJ?=
 =?us-ascii?Q?Voi2QhEKvs0kZwx9RTcUt5CP2wZljEeiGCFohZROiaGlHz5BDj87aQJUq3Bj?=
 =?us-ascii?Q?4pgSLW5EuHKcxAt528zAcTKs8guzUQ1dcABxuhEjapp5s7KE9dAQgzuFT4nb?=
 =?us-ascii?Q?Bjr9xcVpuNGFiH0EBlFY4atOhwDY94B8oO+Jds1jeQ/j+F5LYFiRVbFKlwTj?=
 =?us-ascii?Q?jfI5mqRhI5HwiwlCOVXig2/QDvjHZUZ/QIjP86lkapcZdHbHRSgr9WCuHFRD?=
 =?us-ascii?Q?srXFYcXrOoRM6UTBh1qp0nENQDliUKFYRIgfArljTngrFv/nsFaoto3MF1gt?=
 =?us-ascii?Q?Bb4zEf/AZd9zJt7erRBmQx3N4fFf2ChDrQzKW3osswnXNTmvAFg9aFdAsewF?=
 =?us-ascii?Q?N8fcb89i2jj5ljv0YFsXwYSM8zFFuN2S2AW7RuypSf9RMc5MlU/VuwOtnF8p?=
 =?us-ascii?Q?OkNtmFiwxYjKfJlHnbM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:48:10.1480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3860e479-44d1-4daf-6f24-08ddffdc8e53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227

From: Dan Williams <dan.j.williams@intel.com>

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

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Co-developed-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
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
index 712624cba2b6..3b73adf80bb4 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -839,7 +839,7 @@ static int add_cxl_resources(struct resource *cxl_res)
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
index f9bb5481501a..70e750cc0d7b 100644
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


