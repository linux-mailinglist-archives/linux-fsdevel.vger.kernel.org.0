Return-Path: <linux-fsdevel+bounces-63073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D3FBAB5A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B79163F68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 04:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359F9261B6D;
	Tue, 30 Sep 2025 04:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tWf64wqt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011018.outbound.protection.outlook.com [40.93.194.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D342155C97;
	Tue, 30 Sep 2025 04:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759206515; cv=fail; b=guFtNBOF50yeydiPVjqJ13+5yEAwf5MzdtXJatuaG6x55qTAj1cf5K3CUwCb1n3knFHvVJZ3URRELgzFaHu/RapOAfnGzFpTiQNox+1NEk8/YPcHUqUJ4NuKKo6GxXLXsv6sQejBVIUSMmpXJ0Ab8B2lCPJPwb0KXm596r88MZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759206515; c=relaxed/simple;
	bh=XVgliT2EcGJ+oYgw9afyEwzbQcz1PZjXWHB6cpagb0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CE74HA1w8TvvvOp2Oqi+hpN7HJ2EYL6qACu/3FB8ZNy5GdUv1g04ywon4llkCBRIz/nJByw9avw1+1dgVasoetkXMFmt1O9pOWtCihB5yepCRfYNdq6GzghWPUFvg7rc64q/vLnBbJoBoJKyGHwGc7wA69DjpGk+2cDTqJCyBVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tWf64wqt; arc=fail smtp.client-ip=40.93.194.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aND+QwMoC/1j4eH/x+s9SKo+IDibL9KkWpPIqA2hqv1x7WilGtupBusYo0WT/qvznmmFaKe5DoC7jDxTqyynyhfjFk/WEuv/uB3vl3rTSuWRvAQ+fLbwGaj2UN79XcRx1t2KA0s6+MS5Q82Jpt83+MLyXcl27WGiVgiRe0j9wbNyG9nGDBgcdRrOBuMW0YpGgWmVAOh5RpTuYqXwcSvxPTvZ3h79LVnB3eeirL97WMv4J8eVJzALJ1H2hDhAtEFpuQVjbvMyVqScT2+wOMpXNChwRPD8CUrDmJOQ1mezj0l/Ye4B+ZCcyDjGxrf3oDc8VhV4vU9kLK3E4VnHlN0xxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8JEtvvZhbTBOofplWVQjgB0/ASZjbgEZgiIGkkaaOI=;
 b=m5Wekaf5FKv1udRxFoFycVT4HElBc7rgH/tUCATELPolqamg6oE+2x/0MngSyPlI2KHyIJjFCVl1SSsVH8rNo/JpyPicHRoX5prjsIEHXp2eD594euzix8uLypZqkH/cejtyPuOUFeNWu75/JyoOeENW4krc61qcTfGzO+83n8M8j8Moi8LWfyzDH1Y+0F1RUXEbucjC7xbKUrR+qR9jfu04zvUMl0sQGLakNJrT5eCfK3qTJi2NmDWdW6msNsUIIM2t2TYNRE7ba38l6aiQIu3uEBOwQxZJN5/jIEIoZaa12eg33Oe4FnNN+oAHsRkVJhJqOdl/FuJny8ug6xvf/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8JEtvvZhbTBOofplWVQjgB0/ASZjbgEZgiIGkkaaOI=;
 b=tWf64wqtL9WcKZMooknXFc0waD2+SUDBm7FlT88EAz1wPWpikh9iaRgGTM9aCDk0xhqQVatd3D6c96gsNM4LqFveTGkGN3InXjtXluCH0pf8dZ9wbVxcI4vbF3WOenojHOIKVjyD50KoUksT3nn7XmNP8OFChEYTdX6Sa1YTYHU=
Received: from CY5P221CA0145.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::25)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 04:28:29 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:6a:cafe::8e) by CY5P221CA0145.outlook.office365.com
 (2603:10b6:930:6a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.18 via Frontend Transport; Tue,
 30 Sep 2025 04:28:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 04:28:29 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 21:28:27 -0700
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
Subject: [PATCH v2 1/5] dax/hmem, e820, resource: Defer Soft Reserved registration until hmem is ready
Date: Tue, 30 Sep 2025 04:28:10 +0000
Message-ID: <20250930042814.213912-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250930042814.213912-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250930042814.213912-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: f5818c59-ee2c-4658-5149-08ddffd9ce90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jTMJD6X75tXZSPUBwOfY7BYKAYeiubUZl/nLoAnWc9r4tYlbho91fJi/Q8v9?=
 =?us-ascii?Q?JXGh71Di9vDwjmmudPY6UjMsO2YawXbWpDnwOIjnD2yzYw8twaIRacCzmGcV?=
 =?us-ascii?Q?l7F4XDJNamF9hyUisqaQxxW0zVYcGCxpuaKpCy04qQlHWz2YQW4/amNWvlSP?=
 =?us-ascii?Q?CDiVKEmDvESSV0J2fixHkwNpc+lO7z1oWQxsJbrP9oAt9Ebbo9UebVtRDEIA?=
 =?us-ascii?Q?Nch08V6C/ZbXh2sNsocR8ki6HJymODKAYnebZEdycgWOIKbh76GrOEihNyI7?=
 =?us-ascii?Q?D+dbYjUgAhK/FxGoNbLtCXTR70jfQC0EaMlfs5U6RCewxdeizD4kruAGwEqB?=
 =?us-ascii?Q?NiK5OIhwhx61f1Tta3sZcfGVoJI+/BXry70sd4JEvlg2aswB3aZopg0bjwJy?=
 =?us-ascii?Q?2qfPTjKNxMkZqRkEhvbdXL1meE/nt9ts7Qsn6fF2I6Df7xTLyJTM6ckmOdSi?=
 =?us-ascii?Q?gQD33gVjd3xPlsPNazAcrRe6npSk43b94yJsxNfpRCCwxaBSB17tzFWTtl34?=
 =?us-ascii?Q?3LhxVXL9PFXnKePCnu2el2lzacxzJZbYaWhDPUjmd1OEUPJiEfOxP5ghRqvy?=
 =?us-ascii?Q?x7dXzvtfHT7P9nYlHzuo+Hi9A53pzjPoL9GD83d7knSIxXaqOMJk1aADlMBY?=
 =?us-ascii?Q?3F9A8R7kSOvZHD1McgXiXKGcK16VIXrYH+Fz7+PQ9UvTyPRFKHnwePSS/Fyy?=
 =?us-ascii?Q?+T4fnA4N/Vvwn4m42o4H56E8BAYUfxheqBO05wF/DmxRHzuIj9ID4flUjJJt?=
 =?us-ascii?Q?nzEuo0Uhafbj2XmGMxIvTcExkqvG1fwfuZGAwF031AXnPIeWRZLuH7kUvrFu?=
 =?us-ascii?Q?FeCbYy2RdukdmkzrJdmRjj94ORqbZTVzSRsK4Lxtttm62xnQ6BpVfyPJMDd6?=
 =?us-ascii?Q?p2YLcD0f5qFqBgXjiCHIlPbwdV6B2FdzLcKoo1MkDjMzEEXBTkgG9cQolZGQ?=
 =?us-ascii?Q?BqsFE36efpgp09P87WY/2Ot8CYd7QUIACH1Z3/b91/T+K8BYmhW1jcDDL/Ab?=
 =?us-ascii?Q?0a/19PGLZY+9DYoOz3+ycUFOmarqdOytoOhEOZ89T8ysPdx9G+Fe1/CXtXHz?=
 =?us-ascii?Q?oqke29V3d77JNY2mhW6VxJXywHmwfQ1/xc5sLz2YTlSY5sNS3XxCsKSWcG+7?=
 =?us-ascii?Q?w/SDHe38IJHcS3O22ocQQFAlQFw+3DMMsT79o5PWLuiqwTqoTKqprNRUFLXL?=
 =?us-ascii?Q?XO2xRLgy5n0y9Uf8cghCOMi/NpXEnkKIKo6tjRNiI0gJKi77ZiM7B/N/Ts+J?=
 =?us-ascii?Q?84CbH4KI3kEx+9+xCmwSx1pBbTtm/UmnPsyS/pWeRnh/FVRTMaH/NHmuWtRq?=
 =?us-ascii?Q?yFsR28oIRs8dF6nEexSzOlEG896pJ+CONEBZ18eBwCgnF8NF+kYshc1oI80I?=
 =?us-ascii?Q?hVbNOo1BxTmosZgCpYNsR/PC/bLwEXgQUAcKFQAzcvhSg4rV1lBt/3ROeCnJ?=
 =?us-ascii?Q?FP6eaVhVIOFF3ILJV4HcyDjpGiDKhty8sUpi3s4c2RP/Gg0YwAHl/yFRyWBq?=
 =?us-ascii?Q?SsnAtZ9PSTI7J7DSg0Z9WQO8DSfJ5ZQmJqOFV8lrnzVwjtsQDwzq9xmyIF8v?=
 =?us-ascii?Q?e5/cQouwBxDsCp9CIvc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:28:29.4513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5818c59-ee2c-4658-5149-08ddffd9ce90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598

From: Dan Williams <dan.j.williams@intel.com>

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


