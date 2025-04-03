Return-Path: <linux-fsdevel+bounces-45683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8A3A7A992
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4CC172982
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DA7253F05;
	Thu,  3 Apr 2025 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZM9/aZMO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B09E253354;
	Thu,  3 Apr 2025 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705260; cv=fail; b=brEa7fFRLpB3D1DtlJlQoQLOvQXwj3fzdy+wu52sRWVECKZ9ntXpQwI3cfyyOIYLtSqlPhVTPoANCeCjwIXbt0tl9xMujrpgRXKFA8AWNd7hqzZeUyHAlz42jyxI4bgFCUlWuK6Q7CO84NJlQLvczGp4lJEgk/hnOnFSOYEOdmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705260; c=relaxed/simple;
	bh=G3c0tHgzlvHJ/3FvYX3yOz67ej/rNF/u4xOVL6yUB64=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1B+SVZTSkmJfHbKFdZp8dAME3oJlH/QlRrtScTVnuECMfUkgUpbIXLucR7ObdAth7LrOv8whi9ysauhVLojwK9J3igEPrptig0IomIxLnBkUbO0lwUUpfl8BRxyU5sjzyMQLZnJmURkEu+FGFyj7ML6XQwPSu8UFDFmAikqhZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZM9/aZMO; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asmtTMVCxZWphFK+QE9VEoZCpPzN0lV0ICyW1xegSRM5lf4QdGekXPFSjZVbz3TeWDp0Rwk3NWoq5LWM1Fs34VFQT98gikdRE8e8s8mFJm23ZOzrWJKYeVOqIb+rnwNnWKPfXFkuR3zWv+SbJjeacHqY6l/Zf2CmjP0pPGiEm+wxzyhNJp0up7V7piDE4DF5v85oWT/AmqosyNuNeT3JbLHPHIROXOO0uYeZ/KjGzPDpTuRAMZ392M/NCdly1KZY5DdylRFklcNdzrkF7CPr18u/71b+aIAnjkGFAnmluDw9fM2pcADN4Fy/bW9Gw0zF+8YtWF05/kFuTjRhqNSbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY+xdnr5O6gTc+IhEpoy46Ls+W70O7ZGJaHQ964CO1g=;
 b=cTJeOO2p4U/nI/3wZr5tApPmRxa5Oob+kold4QdCZjdbJJYOv68Be4iEcYcagx404U6lIhJXTRllHkih8IV740WXsPC/tbM/xvrIbWvfdfL51y4Mxidl1fMtQVwtxinoSuCKmdz7eBh7jJ2x7CRuuBw9ZPxbKHzNkuKCHs3sDu0+gCxRwmWYZouQ/GAIrpQj4sK4YT6yHIP0a4NxYKSjyBxECUkKddHXn/RA/tx2uSMEp4r6zpVQTzgvulQRjsvbt+6KQaW0mTF7AAa8TkdNKWRcFDHA/mdhrx6V5JXuQCKHe8rYVBR9UDAo/uAwLYCvutounX8khTVlNjHdIxK5QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY+xdnr5O6gTc+IhEpoy46Ls+W70O7ZGJaHQ964CO1g=;
 b=ZM9/aZMOGPBHQ68ytRrOpS08LGy5tFzPiBHqm+Z+QQwexNuVv295PF7zeJiNVq+o9SEii+jHRljfc8b0iTCBBpbsIdQotpmmj6TY9qtAbAZjD9VB2dJSxWPmQxaCSx9UXvW4y04XQSFFA/RbWFzuQXegSpolgvbXlJPIYn7ZvyE=
Received: from BYAPR07CA0006.namprd07.prod.outlook.com (2603:10b6:a02:bc::19)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Thu, 3 Apr
 2025 18:34:12 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a02:bc:cafe::6d) by BYAPR07CA0006.outlook.office365.com
 (2603:10b6:a02:bc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.42 via Frontend Transport; Thu,
 3 Apr 2025 18:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Thu, 3 Apr 2025 18:34:09 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Apr
 2025 13:34:07 -0500
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
Subject: [PATCH v3 4/4] cxl/dax: Delay consumption of SOFT RESERVE resources
Date: Thu, 3 Apr 2025 13:33:15 -0500
Message-ID: <20250403183315.286710-5-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 4def0378-e14e-4595-d805-08dd72de1faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CNvYzSJyrB2zRTgzSZ1ueUXea751EXAF2o5Uqzgj1hEPxMhea3K6T1Mqw6iw?=
 =?us-ascii?Q?5D0J7rCMsWfz6F5Ay7bl5AN4Za9kg0gTIUzqNRLi1opxLyj42SbZ7Wya0MuU?=
 =?us-ascii?Q?Dhih591ud0aklSm9UEId6VtThpuwOYAFvl9YJNIylKy5htD+wXjFDj+4WS0Q?=
 =?us-ascii?Q?k5vFImNr8RJWWtxHK5QCDDGLwB47cZ57ZIZwjdNCiy1uA5dPf/RE16KBtbCN?=
 =?us-ascii?Q?eNS1iK3RL0cBnEe2Qlg1v3aWawBfgI9XwIsURGZaT+a4J3TRaPssPLmTbzKm?=
 =?us-ascii?Q?ueHqDEZGT1kPFrVkZaPBl8Na1rX2+2jYFnDwdqjn8Jy/vO9f5p4qVRS1M1BV?=
 =?us-ascii?Q?TRe2cQ/BK7J9Ncv3/nevtPO85vWEAMM5rmWq6XHk8qoW6dL9akYZVxNIIEnK?=
 =?us-ascii?Q?KoAH40Wy8Jfx+f3lyNk3RACapsKj/TyHG/YOeFKgwTwStcPoA8JsiHFAObcC?=
 =?us-ascii?Q?t1inMDfXrFwEo7PxAh+tq7KuUFBZ5nLYJQwM0sTVXy3FYpBqxDAAQvccrvR/?=
 =?us-ascii?Q?XkqLR6p5QcYu495zD5Lvl1jepa4YJprHmYaT6sCL772esky3hcq1yyLipg5C?=
 =?us-ascii?Q?pIGORS7/OCeka6oiXRN3OhWRuGjgC0zmvq/6P212unkRyHb6flgjmzXRex7u?=
 =?us-ascii?Q?/ydCo6xqWpdMnOdrTxm6WHQqpp9Tl6Ul75E52xDyGaJOr5PdtzvvVwG2GJb6?=
 =?us-ascii?Q?US/P12EEFhuTTUcRJA8QRDZMmMPmZjglnec+48v5HWofKk9DSkqd0aA1qjir?=
 =?us-ascii?Q?dkwPcJ1aMuQlI4DNYyOmC2xJN407BWXwZ94jHL4eNLADwda34o1X6n/vtxOi?=
 =?us-ascii?Q?hu7YOtTp+IMXKZiVGdN4a2jrnusuPD7tX4y/mjw9BZlYuzuvlkvxbm+CtdS4?=
 =?us-ascii?Q?jDsySHFvKVNLSLayvRi8pQeu/glIFfnL+Y5t73wL0h9f4GfSqdLf0vdckANv?=
 =?us-ascii?Q?Mj+zSCcXiFs1af230o/N0xF6nLJqN7CJNAy1mRMxq2pjzSgLsYQaN89KulK8?=
 =?us-ascii?Q?yic4pB/aAB2qhz7xIJoU0T5OwDQKw4C7ellmv5Ag3e5le6LrUBLu/QI/BbfU?=
 =?us-ascii?Q?UKdD0IuFn6CZhqG41PBp0T+DuGIUZVAlrbd+Tp1YUcEYCn5oepJu6xcipzPI?=
 =?us-ascii?Q?radVUpiJexsZf+5w2pdfl7eCC2spEsxU3dI8y/7TCAfgnwTiN7A+9zNfUCvC?=
 =?us-ascii?Q?xCNIItrNUwqb2TRd0nZAlTb97mtViSp7Lvnm4scOCJcfnv4VbOAomS5V6H73?=
 =?us-ascii?Q?WzRXOp7p4eHs3N7N08tbVIyDUn9pUG1PjfGonJJWHE3Dpc8HT194vPRx70zr?=
 =?us-ascii?Q?guyIb+aLZWBFhKkZqqLbMrEN2UO2h9b6Lz6ud5nueTO3+pYW8LiN5ELOAxEB?=
 =?us-ascii?Q?W7y0/a5s9qznhZxLC+UMNKrQvmyuxsYioeogtwvA3XwrLnQmj+utyHYSz5Rk?=
 =?us-ascii?Q?0+svC0J/y6GJoDsGO+MmseTswLTJLoCqfucqY0lxy07YRBlrAiY3unPi3xzF?=
 =?us-ascii?Q?VQX3fmi2CLGzuG4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 18:34:09.4512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4def0378-e14e-4595-d805-08dd72de1faa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319

From: Nathan Fontenot <nathan.fontenot@amd.com>

The dax hmem device initialization will consume any iomem
SOFT RESERVE resources prior to CXL region creation. To allow
for the CXL driver to complete region creation and trim any
SOFT RESERVE resources before the dax driver consumes them
we need to delay the dax driver's search for SOFT RESERVEs.

To do this the dax driver hmem device initialization code
skips the walk of the iomem resource tree if the CXL ACPI
driver is enabled. This allows the CXL driver to complete
region creation and trim any SOFT RESERVES. Once the CXL
driver completes this, the CXL driver then registers any
remaining SOFT RESERVE resources with the dax hmem driver.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/region.c | 10 +++++++++
 drivers/dax/hmem/device.c | 43 ++++++++++++++++++++-------------------
 drivers/dax/hmem/hmem.c   |  3 ++-
 include/linux/dax.h       |  6 ++++++
 4 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 25d70175f204..bf4a4371d98b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -11,6 +11,7 @@
 #include <linux/idr.h>
 #include <linux/memory-tiers.h>
 #include <linux/ioport.h>
+#include <linux/dax.h>
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
@@ -3444,6 +3445,11 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
 
+static int cxl_srmem_register(struct resource *res, void *unused)
+{
+	return hmem_register_device(phys_to_target_node(res->start), res);
+}
+
 int cxl_region_srmem_update(void)
 {
 	struct device *dev = NULL;
@@ -3461,6 +3467,10 @@ int cxl_region_srmem_update(void)
 		put_device(dev);
 	} while (dev);
 
+	/* Now register any remaining SOFT RESERVES with dax */
+	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED, IORESOURCE_MEM,
+			    0, -1, NULL, cxl_srmem_register);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_region_srmem_update, "CXL");
diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
index 59ad44761191..cc1ed7bbdb1a 100644
--- a/drivers/dax/hmem/device.c
+++ b/drivers/dax/hmem/device.c
@@ -8,7 +8,6 @@
 static bool nohmem;
 module_param_named(disable, nohmem, bool, 0444);
 
-static bool platform_initialized;
 static DEFINE_MUTEX(hmem_resource_lock);
 static struct resource hmem_active = {
 	.name = "HMEM devices",
@@ -35,9 +34,7 @@ EXPORT_SYMBOL_GPL(walk_hmem_resources);
 
 static void __hmem_register_resource(int target_nid, struct resource *res)
 {
-	struct platform_device *pdev;
 	struct resource *new;
-	int rc;
 
 	new = __request_region(&hmem_active, res->start, resource_size(res), "",
 			       0);
@@ -47,21 +44,6 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
 	}
 
 	new->desc = target_nid;
-
-	if (platform_initialized)
-		return;
-
-	pdev = platform_device_alloc("hmem_platform", 0);
-	if (!pdev) {
-		pr_err_once("failed to register device-dax hmem_platform device\n");
-		return;
-	}
-
-	rc = platform_device_add(pdev);
-	if (rc)
-		platform_device_put(pdev);
-	else
-		platform_initialized = true;
 }
 
 void hmem_register_resource(int target_nid, struct resource *res)
@@ -83,9 +65,28 @@ static __init int hmem_register_one(struct resource *res, void *data)
 
 static __init int hmem_init(void)
 {
-	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
-			IORESOURCE_MEM, 0, -1, NULL, hmem_register_one);
-	return 0;
+	struct platform_device *pdev;
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_CXL_ACPI)) {
+		walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
+				    IORESOURCE_MEM, 0, -1, NULL,
+				    hmem_register_one);
+	}
+
+	pdev = platform_device_alloc("hmem_platform", 0);
+	if (!pdev) {
+		pr_err("failed to register device-dax hmem_platform device\n");
+		return -1;
+	}
+
+	rc = platform_device_add(pdev);
+	if (rc) {
+		pr_err("failed to add device-dax hmem_platform device\n");
+		platform_device_put(pdev);
+	}
+
+	return rc;
 }
 
 /*
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 3aedef5f1be1..a206b9b383e4 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -61,7 +61,7 @@ static void release_hmem(void *pdev)
 	platform_device_unregister(pdev);
 }
 
-static int hmem_register_device(int target_nid, const struct resource *res)
+int hmem_register_device(int target_nid, const struct resource *res)
 {
 	struct device *host = &dax_hmem_pdev->dev;
 	struct platform_device *pdev;
@@ -124,6 +124,7 @@ static int hmem_register_device(int target_nid, const struct resource *res)
 	platform_device_put(pdev);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(hmem_register_device);
 
 static int dax_hmem_platform_probe(struct platform_device *pdev)
 {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 4b4d16f94898..a1a75ade9ea7 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -271,10 +271,16 @@ static inline int dax_mem2blk_err(int err)
 
 #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
 void hmem_register_resource(int target_nid, struct resource *r);
+int hmem_register_device(int target_nid, const struct resource *res);
 #else
 static inline void hmem_register_resource(int target_nid, struct resource *r)
 {
 }
+
+static inline int hmem_register_device(int target_nid, const struct resource *res)
+{
+	return 0;
+}
 #endif
 
 typedef int (*walk_hmem_fn)(int target_nid, const struct resource *res);
-- 
2.34.1


