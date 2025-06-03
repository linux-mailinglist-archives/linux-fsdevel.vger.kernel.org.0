Return-Path: <linux-fsdevel+bounces-50528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F9CACCFCA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C27418974C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 22:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFD62571BA;
	Tue,  3 Jun 2025 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BJnZ1P3w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E7A254858;
	Tue,  3 Jun 2025 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748989213; cv=fail; b=NnBJLTtMg0xn3dXBc6zfe8duz+Tp12pGIHW0H46V3RzCUc0z7+X5owcLkQCe1PcupSMAFObOsT2YwXxm6zax5hoJjUNAw5zj9Xz1OlCZ9d/jdNT3FL9Kg4AKXhpO7Qz6PAfK8EpuGuW3c+TAVT63bN56aAUwOoxNu5VXwLVGXBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748989213; c=relaxed/simple;
	bh=z5lI6KtHmXEqtnqHp9AFcaGOmTYA2hm9+mWHS4NYsa8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fx1AKgkgsK3Xlf3lggQIqLHEwMq4ZC3ORRLDrEawMBOrd1Vd5QIzToG27gmqX+Ly6YuGLIGA30kLJtvdG2Dop1xrEb4U62f5YJ/e1luVylP4Yjhku3rqEqg6PIR4bCSDAiZH0tPuUoawz6+FLlkiH399CtEYxUl2eZXvd7gPhQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BJnZ1P3w; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1ydyi9yqCrXXn6c0GbFigOsIiNK0iSx7VXXBqvKMJ5Zl/mPwyRYdFRzRngbYCxwGb2BZgd47HwFrbuAfxqelg7txoe7v7i5VYP0ub9rdZnpHkbZdCJHrxVQwCLT/DhFqVM0wghTXyqX8MRynIf8zJh88VJQNTK9fHQwDKjS/2FHjnaDioh2ooLApSnHR28kO8KOGOxOhJhtAPVyf0K0KIa5GSebHt32TU8+RTNCR5gqdwwdJwD6x4kGwUNtNAXj9rBAn5xorRnoP1OjlzbuB7NDxeVqexOGQMJz/spljaqnm6d9yei8/xhgFtJzd+ehOxSVcK+VY8JKYRtXgWYFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpmtWlP5aWKx/WTR6+1Ad5V8DHJJNmy2EHcoch3RNiI=;
 b=YrSBvd0rPzdvNbF6HE1FpGdid6XCJBsxEC8wShDTSwcOiRCUglxtNCLtCjaQGa1w7ARChHWyU2QuWgdxduqklFkLFAKbhaqRvnWDxfPxXVMDSWIIOKtL6O7Dpk8ydCxZaVY1eyavScQLphdkBfgym/X186tGJEuig8T5E5oRO2we7WkkZpubh5sY1sCC0bc12cj9V7JFwkxloOR7boYUTA7dExKK3ZkByt9auJAdCHoApzKTklYXyKl70P3dESxHXnc9o+bmZEf/4+/JzxdCaKQbVCQB0yMci/tXozCuyU0g3u1wPS1hh5RSWDvY+Ub497pK1rWybcyM/NVVH9hUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpmtWlP5aWKx/WTR6+1Ad5V8DHJJNmy2EHcoch3RNiI=;
 b=BJnZ1P3wgAetpCvuTptqWVPbXY7jokOrNnie85mz2bpLFdqAmDG0sLHMqawj80L4EAtKQjr40d+xJw6EOQHTBkU/Um51K8cwUBbCRUK2ssIpQOlbImIvDiH13B3jz+hBSnl8JU+2MlxWVMaeDXHWpGBrVOksNGRcC/7UuPFmNDA=
Received: from CY5PR04CA0023.namprd04.prod.outlook.com (2603:10b6:930:1e::30)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 22:20:05 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::db) by CY5PR04CA0023.outlook.office365.com
 (2603:10b6:930:1e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.32 via Frontend Transport; Tue,
 3 Jun 2025 22:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 22:20:05 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 17:20:03 -0500
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
Subject: [PATCH v4 4/7] cxl/acpi: Add background worker to wait for cxl_pci and cxl_mem probe
Date: Tue, 3 Jun 2025 22:19:46 +0000
Message-ID: <20250603221949.53272-5-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|BL3PR12MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: a15b387e-5c3b-4f94-e870-08dda2eccab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jMix/kPf1IJfliNFqBNONt+oRW8yv2fbHvdBiuY9WrvlrdY+nKqV8Iy9e9F6?=
 =?us-ascii?Q?15stkrQ79ZL9v3jKdjnxnTvfm96+jPu2OBjqJDf3DASyIDsILppkwFY2ky4W?=
 =?us-ascii?Q?WBd6Z+xFA6PWfR2BUuEkfTjdYrP/WmA3aPDd1ErQYyhhh+LViUpqy39XM6R2?=
 =?us-ascii?Q?fk2LAnNun4XG4bNInCT8YjyrG9MHJ/WueccMhvDsudzs3zvPAiL62ewh+kDs?=
 =?us-ascii?Q?Ib+S5yG7DSLmMk8jjIkQsSXxKQTq3vTXhllB8MWm8SsiaSxoOwiF/Dfa1sey?=
 =?us-ascii?Q?txt18HPuU4TMjROJoLxolDUxb8JK4tvHDdK1h92Kk8hgcwRqyXfyBga3SL3h?=
 =?us-ascii?Q?qQhMOvH6u4KUruUVO/Hj4jYYhSUXgGBTMstsntNUTqydsdDk8WK3MPMGoOqn?=
 =?us-ascii?Q?kUsbc8+EIk3LJOkUHx2NoeE951JwPftAChyWxykcPCoVY8DtQMNlAnyE4kDn?=
 =?us-ascii?Q?gkGEMT54gTEspb6Oi3M6ucKSGxev6v7LqbDUuBCY5XgMvfgHtpo33VA0HeQl?=
 =?us-ascii?Q?LI14qeHIT3uwwaeco3i4uA0VaJaZ8GdS16wKgy8t+tFVev0fyVzn4fPRHKoB?=
 =?us-ascii?Q?weeAirnjp0dCK6SN+FeXEViPeDjHwz8I+bYUQ6wKxr2hlxq6Z5hkucLYQgdt?=
 =?us-ascii?Q?OzYFsHcOkmUjFX/2bYoLCZ0+nW5ZzRcKRsvwgwVDAW6rn5PrSVWXNTvlw5fk?=
 =?us-ascii?Q?nftFtURiRaZQqisvK713GwVA8w3HJApoDmT9s0luij2yMz0NvaoWcJOe8632?=
 =?us-ascii?Q?odl686erqtFFtz5U5mOKYErlkPhFtLX3i+84/X9YKDWqAQ3W7eNirR/uPtBD?=
 =?us-ascii?Q?HRJdzIkh2MmUZYnlOMA3BR5dNDY4o383Xpbxn3njyrHc22qlberkSuYM0NDq?=
 =?us-ascii?Q?MYtCazipCihE6MxGIbOkvt8NwT1kJMAx5Vtc8Za3uLlqSo6x29i9NoLr3OuZ?=
 =?us-ascii?Q?g/xOepyFaKENYBfBEeNsCgjtLCuHlwgv/Vwmhx97s1HYaJ+UoJUrf+A0f0l/?=
 =?us-ascii?Q?VadBRUKOQTX3h9GFVKcEJSasoOHjuNw1nYCZ85YQZNpj+EQFb79UWqnSpGbl?=
 =?us-ascii?Q?UrEpLt9szadiUzDarPv7BWZ9zabqaSbbCZxq1ehgndNgs3mq4MDa033aEj5F?=
 =?us-ascii?Q?6aQgzqchScBeFJztwF1m0y4DKku26RhZPGe4vUfnK7mvkviTxjreVs5rCmsS?=
 =?us-ascii?Q?JJv1HMG1jwV3MTpssw3BhrFxnmjPsnNfbZz+ydTEzTFGU0W1hzYrGJoOojjq?=
 =?us-ascii?Q?WedzvM7wFK1fiEvqigaglWw9u//slJwilNg9o/xeZrRAmJ8/KnS6yjFWgThh?=
 =?us-ascii?Q?BPSauv7HwOd3vNe4f4aNAbpPEdLK+GtyPd25GgvmkIr9yVq0RH9hT6MWr/W0?=
 =?us-ascii?Q?+Sz/Kjpmpx+Si90/6u4UR4YXkIgZuIkoZz46qcdP1Wdd9zbZsNKoQqeHePeX?=
 =?us-ascii?Q?RpfZTdNVcYRFx4ULfq2j+/kaNkQhur9hHcUiIcxJqbyAzgdEMCZ9G8DOOlLK?=
 =?us-ascii?Q?A4TXklqIthfC8CX7ZEIWaaZmvIRfIFzA9hMy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 22:20:05.2369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a15b387e-5c3b-4f94-e870-08dda2eccab5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377

Introduce a waitqueue mechanism to coordinate initialization between the
cxl_pci and cxl_mem drivers.

Launch a background worker from cxl_acpi_probe() that waits for both
drivers to complete initialization before invoking wait_for_device_probe().
Without this, the probe completion wait could begin prematurely, before
the drivers are present, leading to missed updates.

Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/acpi.c         | 23 +++++++++++++++++++++++
 drivers/cxl/core/suspend.c | 21 +++++++++++++++++++++
 drivers/cxl/cxl.h          |  2 ++
 3 files changed, 46 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index cb14829bb9be..978f63b32b41 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -813,6 +813,24 @@ static int pair_cxl_resource(struct device *dev, void *data)
 	return 0;
 }
 
+static void cxl_softreserv_mem_work_fn(struct work_struct *work)
+{
+	/* Wait for cxl_pci and cxl_mem drivers to load */
+	cxl_wait_for_pci_mem();
+
+	/*
+	 * Wait for the driver probe routines to complete after cxl_pci
+	 * and cxl_mem drivers are loaded.
+	 */
+	wait_for_device_probe();
+}
+static DECLARE_WORK(cxl_sr_work, cxl_softreserv_mem_work_fn);
+
+static void cxl_softreserv_mem_update(void)
+{
+	schedule_work(&cxl_sr_work);
+}
+
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
 	int rc;
@@ -887,6 +905,10 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 
 	/* In case PCI is scanned before ACPI re-trigger memdev attach */
 	cxl_bus_rescan();
+
+	/* Update SOFT RESERVE resources that intersect with CXL regions */
+	cxl_softreserv_mem_update();
+
 	return 0;
 }
 
@@ -918,6 +940,7 @@ static int __init cxl_acpi_init(void)
 
 static void __exit cxl_acpi_exit(void)
 {
+	cancel_work_sync(&cxl_sr_work);
 	platform_driver_unregister(&cxl_acpi_driver);
 	cxl_bus_drain();
 }
diff --git a/drivers/cxl/core/suspend.c b/drivers/cxl/core/suspend.c
index 72818a2c8ec8..c0d8f70aed56 100644
--- a/drivers/cxl/core/suspend.c
+++ b/drivers/cxl/core/suspend.c
@@ -2,12 +2,15 @@
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 #include <linux/atomic.h>
 #include <linux/export.h>
+#include <linux/wait.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
 
 static atomic_t mem_active;
 static atomic_t pci_loaded;
 
+static DECLARE_WAIT_QUEUE_HEAD(cxl_wait_queue);
+
 bool cxl_mem_active(void)
 {
 	if (IS_ENABLED(CONFIG_CXL_MEM))
@@ -19,6 +22,7 @@ bool cxl_mem_active(void)
 void cxl_mem_active_inc(void)
 {
 	atomic_inc(&mem_active);
+	wake_up(&cxl_wait_queue);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_active_inc, "CXL");
 
@@ -28,8 +32,25 @@ void cxl_mem_active_dec(void)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_active_dec, "CXL");
 
+static bool cxl_pci_loaded(void)
+{
+	if (IS_ENABLED(CONFIG_CXL_PCI))
+		return atomic_read(&pci_loaded) != 0;
+
+	return false;
+}
+
 void mark_cxl_pci_loaded(void)
 {
 	atomic_inc(&pci_loaded);
+	wake_up(&cxl_wait_queue);
 }
 EXPORT_SYMBOL_NS_GPL(mark_cxl_pci_loaded, "CXL");
+
+void cxl_wait_for_pci_mem(void)
+{
+	if (!wait_event_timeout(cxl_wait_queue, cxl_pci_loaded() &&
+				cxl_mem_active(), 30 * HZ))
+		pr_debug("Timeout waiting for cxl_pci or cxl_mem probing\n");
+}
+EXPORT_SYMBOL_NS_GPL(cxl_wait_for_pci_mem, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a9ab46eb0610..1ba7d39c2991 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -902,6 +902,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+void cxl_wait_for_pci_mem(void);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
-- 
2.17.1


