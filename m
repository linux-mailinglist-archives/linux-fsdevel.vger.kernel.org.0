Return-Path: <linux-fsdevel+bounces-45680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 748CAA7A985
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EAC8178172
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BD0253F0D;
	Thu,  3 Apr 2025 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f+kRGhki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F3E253358;
	Thu,  3 Apr 2025 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705221; cv=fail; b=STaYhY2nOMwi56+Plf96RSN1ltfHwRJ882iti4hl3LiE3RB9coyjw1cnOEVpHU3rSBghL61M5do8AGFeF3nXIIiqgU5SgH64vzJJ3zZ14M6LhH0LMHdWBH4SdWgsFG9GSvattheP8Eehbmb69V86ZqFIohQGYdjE4WD91Q2bNjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705221; c=relaxed/simple;
	bh=m+6V5bZBytlD9zruM+9+jBppyxSolXw2iFWcfq1D0IE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwoQxJpqh85rlUlNegDmrEdiX9rWNGOIfw1Lo0WvtI/kjfmR37hD1IFK5NuS4nerF+cGkkp+l1VEhPqpUJR+UL/TPIllNYbX72OYrsYQBa1almtnADPCtMhXvvJjRLj+QagWlVGeWzQF5qABEZZxHEGJmXdsWEvutfqZcJLCIKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f+kRGhki; arc=fail smtp.client-ip=40.107.96.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8BKm+fQZ+wHhxWl3olHrQZs+CaHowcDT4DuLgKLz2CFccnvG4zzQgGakpnbwz0JWzfZixCkGcewCtUCoDkYy0XxrtTo9ugmA1GCJ7/f+M7MnqFzfG3+TJY0DA0fEyi1RJ4dbXvoCVE3CZ/X0VZsqObKOxr9hY9t6W802Xei23YKltFi5kLiLT8jaQXRpo3X59AxbTVDH9Ck1r8HSERnyDAqTjpjDP8frGqZgFg3S7rw8TNnOdA7ljP1UhWjxxrVCmAp1QsTSBIxN8irKmgMWGIxQ7RrZTJkEUjoghqk6flfs+KecS+ZwAWFhJwiDvoinPOX5mq9RsADzx++dxDSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiDKEEAmDjq6v2zb3gdKuFidXF7+aJSnulzAIwD91sw=;
 b=OYZIsE3VvYm3cEH9Wrn4F3d7RkMGhKLxmP1+XXZO9wbe9VEzx+OK/ACMxKfolm1EVAr81IK1OYb7ifjp/YHBQSO7HNHD2zG0nL9B68/M/3q0KWYyz73V9yK6VdRiLPXdfPf3q0C5tGeDnmoqLZA+wJlcp4lmI8trR2Rm3NvkK2Bo0nSQhzY+fKgZiddc30LKp6sd7RIRYLAkihhIxfdI+AMpfQ6fJbFenqSemr6xYhnmpPTLT4JNzCDWDuzNP78KiZ0NDrbwBSAFBf/4ZHFJkW2/KS8b4uBKQQ0pqkxjkS59JcWk9HsjC+dUwkdyu+msI5asFXfqLL9O59dNN//XBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiDKEEAmDjq6v2zb3gdKuFidXF7+aJSnulzAIwD91sw=;
 b=f+kRGhkip0pa9FGL4rYAGOCWUOGVt/8jJXBrwT2zbz6aOtBOh1fjVvgzXZUhJf9YC4sNVzq845zWEJy87eOf9PwPR8Jo4xb/3PlkZw1AvtBQ/TpKjwxGggpylL9+2lKsQSShRROVa9QmKiDX9D2z3jguXVTThlL/UYqXpKzLdug=
Received: from MW4PR04CA0107.namprd04.prod.outlook.com (2603:10b6:303:83::22)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Thu, 3 Apr
 2025 18:33:35 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::6b) by MW4PR04CA0107.outlook.office365.com
 (2603:10b6:303:83::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.27 via Frontend Transport; Thu,
 3 Apr 2025 18:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Thu, 3 Apr 2025 18:33:34 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Apr
 2025 13:33:33 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
	<rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
	<ming.li@zohomail.com>, <nathan.fontenot@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <huang.ying.caritas@gmail.com>,
	<yaoxt.fnst@fujitsu.com>, <peterz@infradead.org>,
	<gregkh@linuxfoundation.org>, <quic_jjohnson@quicinc.com>,
	<ilpo.jarvinen@linux.intel.com>, <bhelgaas@google.com>,
	<andriy.shevchenko@linux.intel.com>, <mika.westerberg@linux.intel.com>,
	<akpm@linux-foundation.org>, <gourry@gourry.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <rrichter@amd.com>, <benjamin.cheatham@amd.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lizhijian@fujitsu.com>
Subject: [PATCH v3 1/4] kernel/resource: Provide mem region release for SOFT RESERVES
Date: Thu, 3 Apr 2025 13:33:12 -0500
Message-ID: <20250403183315.286710-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403183315.286710-1-terry.bowman@amd.com>
References: <20250403183315.286710-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ded528-fa0d-401b-4fdc-08dd72de0af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xbe1tUGv8Evpp1RprCZqTA8d+a2Pc8paReA1jPFJBx7190AXZQUEbeHQI5Gv?=
 =?us-ascii?Q?6IsDwwKZzjxH1pRfjMDR7sGq/PMvx71ehXl8bXzZZVksu8mGXXs9RGUo4D+m?=
 =?us-ascii?Q?7kzigrV7Zh9l6gY/IUfv683dvfqQ3n8dvepLbRqWiWVGDAPsbsjxRMkjDSRq?=
 =?us-ascii?Q?MVmWB+SMHJ+ya2sTQV8MrqATnJLGDBF2KV7kHVDhSN/EMMvXnnLuqAXv2pxR?=
 =?us-ascii?Q?sNVzvLT6RqJzW804Xr0nlabpgNvq3Jnzdj+SOkEAJgP1X1UY5wKBCruCgcsI?=
 =?us-ascii?Q?8P7+WY145jIVFfExaRMV+Qr9gF6t0sRoig3+iY4zD5HM+eQk9+e1Agr+d9Z5?=
 =?us-ascii?Q?ylmhHXCyhc1eYvGd+CI4s4VgmjowIOn8fA8PQU2aI/BOUZ/x+htAi/Ha+lyw?=
 =?us-ascii?Q?5a5o2ObsA+S/Y4jiXIpW+GnKNSK4WKXBZJ9SXjj+nt7fAX4AFEZ1p9OrBnZL?=
 =?us-ascii?Q?LrIAdOOn3WUtfXZ6KEhmguvx4OcxGmvC21HZIgXMUO6LgD2sXoMMXKJFAuc4?=
 =?us-ascii?Q?mDaIV/iIXsDAwfJKp4/RL7uLD0guPwt5YcO1IR9oBwyw7RXAA5LZjRh49KBq?=
 =?us-ascii?Q?YOmNVlenk0tt1GyPu9DnUemNQCHEk4tPa/IqOwxAx/kcuHdTnEe/7DoOhxzB?=
 =?us-ascii?Q?DI4SalR852NijE3yWst8XRwgzuB9kt0+Dg9MsXbL8vZBVBf7WN9cUzgTw+kf?=
 =?us-ascii?Q?2jB3FHh1iS887JjVydK9CIRkm9Y7GrZA4Sg7l8qPoY28QOvpL+iwo+F7wzXY?=
 =?us-ascii?Q?cfcx/46aBpvO383Vi752EKra9ShDwt50FEjZZ6v3enJTta5ufkFTDA4ElDKU?=
 =?us-ascii?Q?m9/bxnu9UIzoPHL1zQgS5lwlr7c18t85HLilWK6vJWlkSuRN18L3ifTegQpY?=
 =?us-ascii?Q?x7mxeGfri15pjYbb1g9XYAAraKrpPSqRSa2XdjbtI3KReKe0jeKv94EgY9+F?=
 =?us-ascii?Q?InaFVxiKP9XrGczmFGX4KPM7/0JDfMEhQYZq2BiAXhrMjavyA01cAhNw8dOF?=
 =?us-ascii?Q?iJmvyscMSeuhZb85hHP/dUXmG+q484tBaexmGa2XI5v9OhJUGtMf/gj2SDMZ?=
 =?us-ascii?Q?Knj0Ci1WgXmffKAqKjtrF9nnzIqe5bC/3/Mr68VykHogGd7G5Ksc0I3EHelU?=
 =?us-ascii?Q?nKA8Yvb7theb2WxMJPobl4FWTNV6P+DTvfiCRyn3hlW0T2bCgbDbZIPP9YPI?=
 =?us-ascii?Q?xUZ1c0pcf+eUrt/+aYFaw8Gc3y0Of5YbF6CqGMUyDKXL1fctjKOLRc23gwhA?=
 =?us-ascii?Q?lTsI5OAOrqSEGH57XSp22pMJ55EIQFBezEm9Rbv9xNPCsMTJIM1hXOM0aoTR?=
 =?us-ascii?Q?specNlpNBy7KquqkiZK1hoNb39hXTffLKfQrwjKN1nimjVmwQ6WXo354S99Y?=
 =?us-ascii?Q?JWHLtGKxQ1alEBBCr9CdZ7As+fm/kbt/rgqwD8o98O9YQEITch8wyCP8wqQQ?=
 =?us-ascii?Q?1cHwejyGDjiwn8n2xCbyaLvEF8SYZ16YKlKn0Oe9H4VhynXdP1UETwG35ym7?=
 =?us-ascii?Q?i2UeUMycQqV5GbM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 18:33:34.7489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ded528-fa0d-401b-4fdc-08dd72de0af9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077

From: Nathan Fontenot <nathan.fontenot@amd.com>

Add a release_Sam_region_adjustable() interface to allow for
removing SOFT RESERVE memory resources. This extracts out the code
to remove a mem region into a common __release_mem_region_adjustable()
routine, this routine takes additional parameters of an IORES
descriptor type to add checks for IORES_DESC_* and a flag to check
for IORESOURCE_BUSY to control it's behavior.

The existing release_mem_region_adjustable() is a front end to the
common code and a new release_srmem_region_adjustable() is added to
release SOFT RESERVE resources.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 include/linux/ioport.h |  3 +++
 kernel/resource.c      | 55 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 5385349f0b8a..718360c9c724 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -357,6 +357,9 @@ extern void __release_region(struct resource *, resource_size_t,
 #ifdef CONFIG_MEMORY_HOTREMOVE
 extern void release_mem_region_adjustable(resource_size_t, resource_size_t);
 #endif
+#ifdef CONFIG_CXL_REGION
+extern void release_srmem_region_adjustable(resource_size_t, resource_size_t);
+#endif
 #ifdef CONFIG_MEMORY_HOTPLUG
 extern void merge_system_ram_resource(struct resource *res);
 #endif
diff --git a/kernel/resource.c b/kernel/resource.c
index 12004452d999..0195b31064b0 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1387,7 +1387,7 @@ void __release_region(struct resource *parent, resource_size_t start,
 }
 EXPORT_SYMBOL(__release_region);
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
+#if defined(CONFIG_MEMORY_HOTREMOVE) || defined(CONFIG_CXL_REGION)
 /**
  * release_mem_region_adjustable - release a previously reserved memory region
  * @start: resource start address
@@ -1407,7 +1407,10 @@ EXPORT_SYMBOL(__release_region);
  *   assumes that all children remain in the lower address entry for
  *   simplicity.  Enhance this logic when necessary.
  */
-void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
+static void __release_mem_region_adjustable(resource_size_t start,
+					    resource_size_t size,
+					    bool busy_check,
+					    int res_desc)
 {
 	struct resource *parent = &iomem_resource;
 	struct resource *new_res = NULL;
@@ -1446,7 +1449,12 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
 		if (!(res->flags & IORESOURCE_MEM))
 			break;
 
-		if (!(res->flags & IORESOURCE_BUSY)) {
+		if (busy_check && !(res->flags & IORESOURCE_BUSY)) {
+			p = &res->child;
+			continue;
+		}
+
+		if (res_desc != IORES_DESC_NONE && res->desc != res_desc) {
 			p = &res->child;
 			continue;
 		}
@@ -1496,7 +1504,46 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
 	write_unlock(&resource_lock);
 	free_resource(new_res);
 }
-#endif	/* CONFIG_MEMORY_HOTREMOVE */
+#endif
+
+#ifdef CONFIG_MEMORY_HOTREMOVE
+/**
+ * release_mem_region_adjustable - release a previously reserved memory region
+ * @start: resource start address
+ * @size: resource region size
+ *
+ * This interface is intended for memory hot-delete.  The requested region
+ * is released from a currently busy memory resource.  The requested region
+ * must either match exactly or fit into a single busy resource entry.  In
+ * the latter case, the remaining resource is adjusted accordingly.
+ * Existing children of the busy memory resource must be immutable in the
+ * request.
+ *
+ * Note:
+ * - Additional release conditions, such as overlapping region, can be
+ *   supported after they are confirmed as valid cases.
+ * - When a busy memory resource gets split into two entries, the code
+ *   assumes that all children remain in the lower address entry for
+ *   simplicity.  Enhance this logic when necessary.
+ */
+void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
+{
+	return __release_mem_region_adjustable(start, size,
+					       true, IORES_DESC_NONE);
+}
+EXPORT_SYMBOL(release_mem_region_adjustable);
+#endif
+
+#ifdef CONFIG_CXL_REGION
+void release_srmem_region_adjustable(resource_size_t start,
+				     resource_size_t size)
+{
+	return __release_mem_region_adjustable(start, size,
+					       false, IORES_DESC_SOFT_RESERVED);
+}
+EXPORT_SYMBOL(release_srmem_region_adjustable);
+#endif
+
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 static bool system_ram_resources_mergeable(struct resource *r1,
-- 
2.34.1


