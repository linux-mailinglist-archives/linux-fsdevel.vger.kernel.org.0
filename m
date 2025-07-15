Return-Path: <linux-fsdevel+bounces-55016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE5CB0659D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCAAC7B3532
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EA22BDC35;
	Tue, 15 Jul 2025 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lLKBcsmh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376C329E0EE;
	Tue, 15 Jul 2025 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752602678; cv=fail; b=QL+ZQaoi5Abo1wNEJDECbk0ICA2lplIdKOVwpXuvgngPustdIMQwLQ6yTPezCK0/+JMsBBX6ZrUCTVMxP8NTzvnUZUWjiLmv2XOuV7T2DlA7LElXVVFDyHx4xOCJFPfkJkFWpy91UG+AyA2pd4kONBiUFhNdQmv5S3ILaDXmnZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752602678; c=relaxed/simple;
	bh=sNjcrVBkr/YrcPc3Cgi/6pQk0NNTnv36ho5N+9nm104=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+NQlmB0cacMmCopS4NAdAdqayNsW3gkNOuje2GwEiUJ5EGX0JEAOHNqFLjAVehnAgcnMObF21XKRfeMXlcL/TMVcpv4a5ylYuf7EeKf3SEOMgm7Wi0srblCayeGhdDGlH6W2ao/T5uAnVNHnsezodsMh8yrTDYXsyQt5PIhbnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lLKBcsmh; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUEL4e2O5b7UpjZcoouvzECBnu40+FPum2EHLEvzhN5x7in4vY0K0oLorifIZSCl4BayO0A/jgrue5uqa1NyvGCB1WQ3rq322+TF3+QN1gFi0pT7MUJWfi66ZOm+PFEWNvPDyZKG6M3bH3elLuqmQJzj96gRyZ3UJmpxP+WQjVZqhsmz7sqJSb1OGXthhgPuZXf7a9AzLOQFrEZWwZly4+J1zjOcJNunC3L1K+iZVlCyTFEIX2jpjCypwvbHluwCPu8NV6gtGhPzzIFIjANaZdNcXbzVhRciVoLZ7/tGNNIwuiexb7BD/SFEiI3F6O5D53v+Ycx/r659Ntu2oBVE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nBOiQREOdpxsTzMWk2zUprn2elJjcxh4Ts7G8tiLuY=;
 b=tG5QaYbnUG85UuwQVidy6b3jU9OJXHRB7d1GEvUzlvSw06CTHgdjaBxkYYKbUVdehEzCWCFwGg8ouyVkBPbKoOy99c9BpIsmxF5+Sb/fHt495HM455PYVobaBdLOe6HQ44GAJ4Nvp9Jg1nDyv33KD9bg4XtFB+HhDyPALRSdO4lDZEPuhPDX/YGmFGEk1JvmBM8lDu5wenvOqZGLu/sSRMXZC6khRGhLh8qW8+qEZTx71uf9ZAbQSrQKgVhZZJlrAq3H2w3Xl83nWCJKoPI7omwbD5QqnX6F6W995CxRlimPl8tZZSJumveSQZw175DdbNMF4aACDRUCxe0POlq3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nBOiQREOdpxsTzMWk2zUprn2elJjcxh4Ts7G8tiLuY=;
 b=lLKBcsmhJDpEbYfOBbiVHkwxcEPlsM+XoR6eohdGn/dWOEgfHkaQZ/FrmGaHAxyWknfrZt90o5yTGYN7z8pSDyCYfWMg+hB1NIJs+EF29iVvLeFN8u7ZFCma+0XgU62ixrxUvnCf936F+nhAycyxxA9x9bIaBZTQOTr3GqhUQnI=
Received: from BY5PR17CA0063.namprd17.prod.outlook.com (2603:10b6:a03:167::40)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 18:04:32 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::ab) by BY5PR17CA0063.outlook.office365.com
 (2603:10b6:a03:167::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Tue,
 15 Jul 2025 18:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 18:04:31 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 13:04:30 -0500
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
Subject: [PATCH v5 6/7] dax/hmem, cxl: Defer DAX consumption of SOFT RESERVED resources until after CXL region creation
Date: Tue, 15 Jul 2025 18:04:06 +0000
Message-ID: <20250715180407.47426-7-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: 95859a01-17be-41d4-4e40-08ddc3ca0cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EM5mi5YNbjd/tqTZBpY/MIsMMgDmWEevBiw8YmXSj4lE2fZ3Vs+Od+nm22Zw?=
 =?us-ascii?Q?KsogjzRQVqFwywP9UeM7pnSZZ1qcQ/nmfjAH8vAaU2YXNNl/Um72b+pKgNK5?=
 =?us-ascii?Q?J+0gJGaptng3UWMAPyV2ktTof/BmfykZw5yqjhgXqPlZ5WtXcjReNFqdhDdL?=
 =?us-ascii?Q?Qy9dlecH+5K8FwVsc6a3cB3W7Uo6yd3YSEQS+qYSFYtJMwYQfJLvPXWtxW11?=
 =?us-ascii?Q?3Pq34QKOaxQVyfvjh8ZNhOF/+Y+eIdQzCWbYdATOgy1kDUHtfvEWuEiYck9A?=
 =?us-ascii?Q?mVfcIaWKzrydnTkoEPRrt9yRvkOlnLkKrQepGnfUUVsPeByI1P7FtAbyIoNt?=
 =?us-ascii?Q?f9aWUwdbctXTrNkl5SB75LJrefMXGTuYFc1kDAVWLJ9cbiEsNowtc8ELfLv0?=
 =?us-ascii?Q?NXJ3I0nZAg+Wdhzw8FetyZqjR4bClLJiwbYONxWrRjj2Lloi8YXmL/VINhEQ?=
 =?us-ascii?Q?W28ViAqISRW+XeoAzL1SIriHiTZAOQq3i7EN25IghGeHU7lRxV1DLvW+Rxm2?=
 =?us-ascii?Q?ofGLupNing9Dw8Cm8XAVlkmlTK76HNylYfUObL2a32QROeC3kpZLwFT29bw5?=
 =?us-ascii?Q?nIHTozkumUkCucTqG1Jn1LWvHRBAbvP2hDXFnFU5xyhgCbgNiyzHk3mF8UVV?=
 =?us-ascii?Q?L88GDGJx+lYtJ5hhEK8/YZ2yA1B3QGSWL3ftoFKo7O4imt9Dncouz3o5Etyt?=
 =?us-ascii?Q?LrbHkQkbmgeKTu9zSIArQgXmZNb6xNs9tCjOovTlvMD8fJnH/k8isa9r4C3F?=
 =?us-ascii?Q?Qh92GkFWKWkmSPtgI98j08ivZwrxsfVe9Ga159AVgjTl1MQi4ykkylAw/Ykv?=
 =?us-ascii?Q?yfCDWiDRDmjhBZWvflm841kItnmCTV5tdz+fw0623gHra1se9Bl+ej2SMhqu?=
 =?us-ascii?Q?usCUgCQTRf02YmCIOGIu7ZMo8aXfeNX49eE/qVdeb9Q3/EgwlI7FhXA5EklM?=
 =?us-ascii?Q?9gQtwv6sh5SsicEN4DhTsfndUd/386iVzkf9pGZk6Ugns4RtGi8sCgaBnJzu?=
 =?us-ascii?Q?49kw7L/72WHlhwZogQQVgf3Q9HE9NrmxYXha755OYtkkpxRvG6XYeevmT4Tj?=
 =?us-ascii?Q?TvUAjtdMPiTyaUlb66tPRjq3MO39ZABIOFVCi6iYUUnBNLaBGhuLvSZNWkTV?=
 =?us-ascii?Q?9T+xMH6Ve5P8l+JB/umqbyeCFd6GvDTj2XcmSIJncoJVf+OpTj5ELG91YJNc?=
 =?us-ascii?Q?VWbzgmAiDz3+Nq+SDlYyVvmyrMoO84uIubeDWTgM5pv5Z3LBif+RGiuCIwKL?=
 =?us-ascii?Q?eBz5C6Kr7EAYMBJSs7nVqSap7ZxcD16jp8tEMZivG5o+e7D9ns/cUhfDLH/2?=
 =?us-ascii?Q?C1GzHbrhdZZtubqsViIm8VnEtRW7F5vBaveNetNx6mojDWVHBf57D33IoZez?=
 =?us-ascii?Q?55Eye16euulsFowBSEyPJZbtScreI4vpXw1cCnPcx6l9gP0KDVslmG6FbNBR?=
 =?us-ascii?Q?XmjzMhBZSiJtzqgKBKx2VgEV5vpC1kqSHosw2Y2JF+yXszZoPaGFrTRfPwZi?=
 =?us-ascii?Q?4pZPoHnX7o6ss96UHlmKGg/gLWq8EZ2BAmPy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 18:04:31.8602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95859a01-17be-41d4-4e40-08ddc3ca0cad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367

Introduce a fallback registration mechanism in the DAX HMEM driver to
enable deferred registration of SOFT RESERVED regions. This allows
coordination with the CXL subsystem to avoid conflicts during CXL region
setup.

When CONFIG_CXL_ACPI is enabled, the DAX HMEM driver and HMAT skips
walking SOFT RESERVED resources. Instead, DAX driver provides a
fallback registration mechanism via hmem_register_fallback_handler()
and hmem_fallback_register_device().

The CXL driver invokes hmem_fallback_register_device() after trimming soft
reserves to register any remaining SOFT RESERVED regions that are not
consumed by CXL. This ensures that the DAX driver does not consume
memory ranges that are intended to be part of CXL regions.

Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/acpi/numa/hmat.c       |  4 ++++
 drivers/cxl/core/region.c      | 11 +++++++++
 drivers/dax/hmem/Makefile      |  1 +
 drivers/dax/hmem/device.c      | 43 +++++++++++++++++-----------------
 drivers/dax/hmem/hmem.c        |  6 +++++
 drivers/dax/hmem/hmem_notify.c | 27 +++++++++++++++++++++
 include/linux/dax.h            |  2 ++
 7 files changed, 73 insertions(+), 21 deletions(-)
 create mode 100644 drivers/dax/hmem/hmem_notify.c

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 9d9052258e92..8883fd4a229b 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -901,6 +901,10 @@ static void hmat_register_target_devices(struct memory_target *target)
 	if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
 		return;
 
+	/* Allow CXL to manage the dax devices if enabled */
+	if (IS_ENABLED(CONFIG_CXL_ACPI))
+		return;
+
 	for (res = target->memregions.child; res; res = res->sibling) {
 		int target_nid = pxm_to_node(target->memory_pxm);
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 95951a1f1cab..b1fa38e0b987 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -10,6 +10,7 @@
 #include <linux/sort.h>
 #include <linux/idr.h>
 #include <linux/memory-tiers.h>
+#include <linux/dax.h>
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
@@ -3603,10 +3604,20 @@ static int cxl_region_softreserv_update_cb(struct device *dev, void *data)
 	return 0;
 }
 
+static int cxl_softreserv_mem_register(struct resource *res, void *unused)
+{
+	hmem_fallback_register_device(phys_to_target_node(res->start), res);
+	return 0;
+}
+
 void cxl_region_softreserv_update(void)
 {
 	bus_for_each_dev(&cxl_bus_type, NULL, NULL,
 			 cxl_region_softreserv_update_cb);
+
+	/* Now register any remaining SOFT RESERVES with DAX */
+	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED, IORESOURCE_MEM,
+			    0, -1, NULL, cxl_softreserv_mem_register);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_region_softreserv_update, "CXL");
 
diff --git a/drivers/dax/hmem/Makefile b/drivers/dax/hmem/Makefile
index d4c4cd6bccd7..aa8742e20408 100644
--- a/drivers/dax/hmem/Makefile
+++ b/drivers/dax/hmem/Makefile
@@ -2,6 +2,7 @@
 # device_hmem.o deliberately precedes dax_hmem.o for initcall ordering
 obj-$(CONFIG_DEV_DAX_HMEM_DEVICES) += device_hmem.o
 obj-$(CONFIG_DEV_DAX_HMEM) += dax_hmem.o
+obj-y += hmem_notify.o
 
 device_hmem-y := device.o
 dax_hmem-y := hmem.o
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
index 3aedef5f1be1..16873ae0a53b 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -128,6 +128,12 @@ static int hmem_register_device(int target_nid, const struct resource *res)
 static int dax_hmem_platform_probe(struct platform_device *pdev)
 {
 	dax_hmem_pdev = pdev;
+
+	if (IS_ENABLED(CONFIG_CXL_ACPI)) {
+		hmem_register_fallback_handler(hmem_register_device);
+		return 0;
+	}
+
 	return walk_hmem_resources(hmem_register_device);
 }
 
diff --git a/drivers/dax/hmem/hmem_notify.c b/drivers/dax/hmem/hmem_notify.c
new file mode 100644
index 000000000000..1b366ffbda66
--- /dev/null
+++ b/drivers/dax/hmem/hmem_notify.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
+
+#include <linux/spinlock.h>
+#include <linux/dax.h>
+
+static walk_hmem_fn hmem_fallback_fn;
+static DEFINE_SPINLOCK(hmem_notify_lock);
+
+void hmem_register_fallback_handler(walk_hmem_fn hmem_fn)
+{
+	guard(spinlock_irqsave)(&hmem_notify_lock);
+	hmem_fallback_fn = hmem_fn;
+}
+EXPORT_SYMBOL_GPL(hmem_register_fallback_handler);
+
+void hmem_fallback_register_device(int target_nid, const struct resource *res)
+{
+	walk_hmem_fn hmem_fn;
+
+	guard(spinlock)(&hmem_notify_lock);
+	hmem_fn = hmem_fallback_fn;
+
+	if (hmem_fn)
+		hmem_fn(target_nid, res);
+}
+EXPORT_SYMBOL_GPL(hmem_fallback_register_device);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index a4ad3708ea35..069ded715e5a 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -307,4 +307,6 @@ static inline void hmem_register_resource(int target_nid, struct resource *r)
 
 typedef int (*walk_hmem_fn)(int target_nid, const struct resource *res);
 int walk_hmem_resources(walk_hmem_fn fn);
+void hmem_register_fallback_handler(walk_hmem_fn hmem_fn);
+void hmem_fallback_register_device(int target_nid, const struct resource *res);
 #endif
-- 
2.17.1


