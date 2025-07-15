Return-Path: <linux-fsdevel+bounces-55014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C98DB06596
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F693AE66C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2852BD005;
	Tue, 15 Jul 2025 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0QYAmwzH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F2029C328;
	Tue, 15 Jul 2025 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752602676; cv=fail; b=bWdwdNhY0WcKbAuQp5c820b9gGN134XKLiElZXh3ZSM2KLzgramM2g47HikjClYA8pKtVnlBYZFAH2hqgeLnkxjrLzqbJY97/gSdL86393CKdXEGTPxIfCdn37v9fL8X6fk/KC+Wen+nGKRzOghamRI79kz+39QSHmp8fUUgxLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752602676; c=relaxed/simple;
	bh=oDoXq258QUMOumsvgMo4BYpsBp5f7Di5WWHSB1jNbng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWs+xAfTsTTqjDR8TqRk3mJseUyzQNKhF7V8GFxLiBRHA8rPROLF7fPj+QtsPFW1Z0Y7RfnCKAFC0IhIyTRW3g9mHzuRiiy0uvHiCw+92YqMpNsbTLbQs3aNhQ6NI3MSuULVNOWpfc1iw678J/apDiuIBTdRHzJjctOb9+hbO5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0QYAmwzH; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Og3uBfPdn0ClV3IHEGdK3EYh3o1yb3zOKl35OTRsq1vNJIdYzbKqKs8svP+Y4Jd8Qo2YtPdiDYgjo+2l04kw/2naDavzKRk0BEGFHUpdfvbwop4NLuObsLhPsalfckqdRKDXHU524d59f9axp7XlyyHjdGiDzraEXFMNoD8BGiJocoxbdi1kfSQiEvCeemN2b7iP6iSIKBTNW6ZkrdP70KjwW46Oik9PsQA82Ti/yc1I3ulLDHjsOquPbSQM6jqmLN1zsq7Cv3D8IlQh2dXD/cEuow1yhNFQgq8N7CCG0+9b0SY11YgXfz6Ny8WeQ0yUumYLFrfI/skPK1+ZOaPibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGVzPLsW5IcmU3fwL+pJo3+R4qkmThPMGSYxwuQhB54=;
 b=exle9nOWXJjjFLS7JXOiCwy+FXq0yAPQh6tmM+r1cO/fssI0epk8QRACNC389Qe/QX9G78iQ4EviBHyjYgok2SPKGlpJjgSPyRYzPpz1rGuTc6pKe8dykfOId8ei43Te/ZU//GOhMzlp+cGqwZ52M/QUdMRnf5krav5RhfAytQzP6FKZuExgaRiIU6cak0TTnRR0YRypv6qpt1I81nWBOjGsmt4jzYvPLvHUCz/YYvNZDePMQJl+dM8YRTJJHGUcDt8B4vEm1c4M/fb2GafmhoZTSjJDfHM2Foa3ReRwMs3B1Bl+xSrD4fkPMtNVvnV77aBCACxwHLak05CK4EX1dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGVzPLsW5IcmU3fwL+pJo3+R4qkmThPMGSYxwuQhB54=;
 b=0QYAmwzHQVxSNSn8vCll5U1p4MbsaP4TnCYcjS+DbuFBX5/hnfapUgxmEwCG9yzzbEPcpsW9VyO0NxoVRyGblPPSVS50IzEb7ZI3yRKWxR1GQ7w4Bim5MwHwvKthKVNJg2F5TLjLJ8DZW4kV0ZAbbbTVewLMJG7nhuHeT2T266w=
Received: from BY3PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:217::25)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 18:04:30 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::c3) by BY3PR04CA0020.outlook.office365.com
 (2603:10b6:a03:217::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 18:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 18:04:30 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 13:04:27 -0500
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
Subject: [PATCH v5 3/7] cxl/acpi: Add background worker to coordinate with cxl_mem probe completion
Date: Tue, 15 Jul 2025 18:04:03 +0000
Message-ID: <20250715180407.47426-4-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: e0573b98-a259-4ccd-552d-08ddc3ca0bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?syndIYNd/fXioqKJk648z59M+VY6yoJw1+baD9B8o9GIFp5qyeIfT1NKj2j+?=
 =?us-ascii?Q?KondhjKnLV2wBeFbybgETSay7wqIDJSkZFciaH7AUrp1PU1x3WQe7OYWvRVO?=
 =?us-ascii?Q?VbXJ3UY/yzqmwZ6kHHXUFJqFMGa5NtNEOzIgcnhUGfepq7jvqyKHiDVO8IDZ?=
 =?us-ascii?Q?qF8+k/ejXnXabCljpaT2/ykwIJPoXekr7I4MC68Szw2R3iFFfbFJJNAUSxG2?=
 =?us-ascii?Q?kuHNcaNSSUr6eXDuFyXLV4lQOVxAVSqsDaBPnCWZXNJ/hA2j/7q1C2KcsZRI?=
 =?us-ascii?Q?jaaNbP42o03wwiFcWa3ROYimQ5bbTsxCciJUmGE11/lOpkS+/9ins5CJBXnL?=
 =?us-ascii?Q?i4y3+aXSYLFYDB1jxikTXJTXmq6UMUP6g4KNEonJHq+x3AMSGjr7YO8KEDKd?=
 =?us-ascii?Q?0Ri9/jQIOJtP8uvrI69w4UNnjj3TIS7IbVXfBPaouGJNC+sbNGKfrToWIZz7?=
 =?us-ascii?Q?qDxgPgtK2t3zC3uEze7NNfAQR29OlmuMvmkHx9suSRXFPG2QlTLhpUazStmt?=
 =?us-ascii?Q?ZHVLk7YvzgLbEnq+Saif1sjcO26L9D/zcXL5EyrQEf+0t+eCJdOzteLCHxaQ?=
 =?us-ascii?Q?RG6MwaXUndfm+J5ia9Sdw7sbfba1eRRkuzZVoE7LTNkYivwn7pMICiHfhFm4?=
 =?us-ascii?Q?9MsPjXTrMyVDxXiq1E/xMzgWE4nttQeQ8yQtovctkATIFRdiMOhPklxcAOE4?=
 =?us-ascii?Q?6wZZS8Qjf2BpMkFAMlAtNyKk4bcR7tJ0sUBV4bAJzKyFuL+paWSMSLTar4qW?=
 =?us-ascii?Q?3jqkF07JQbzNI2Yuv2SERvm1fAi6x5xGYREZ1qNEL5zujGk164tFHgCG1+Xo?=
 =?us-ascii?Q?jBm6W+B5FgeU6ic6gTHl9h6pIVEkEzIaLUgYgioaLAIthUUkiYnuph+keOwK?=
 =?us-ascii?Q?g4hgN1yWcGt46PGx+eZKCl4UkxBBG7FTgBKKsRrg6fcUpFPpH636liJJyNxD?=
 =?us-ascii?Q?ugzeVKMeVM9I0aW5xxZFGkIm2KcShHdSFzBE3XffFZAsHQZRZZl09NW7+eIH?=
 =?us-ascii?Q?jBMSsPYh8i8mRvrMm6P/2FpYELYyZgDwTaGmPuV4AGu2HQFWQle3kBhpEjUo?=
 =?us-ascii?Q?Lb0pEFNwL+ZoHa/uTvoclVMksaOxd4qZxJAh5PIzl+Aj7g6wwjm9vLMSJ5JY?=
 =?us-ascii?Q?q36mw6YUKfI3dz06OD2DGoDqBkCdK7LWid2k89TQ/ZDUNVlA3hiKbVgCSGKk?=
 =?us-ascii?Q?/6dijOXW5ylQvo44yeo8vLyAhodZRT2sDRhE4CC5hX0qGKhACLdbH0YUYzz4?=
 =?us-ascii?Q?1iNFBdcqGgrHV36d9hmrkpsJ+Ang8l7W9yHr2hUfinvgS0G6kIcQleIxo1Hj?=
 =?us-ascii?Q?TCvxuFWcjYRt9DFBziKnYqXNcXOh/730E7NYK+QrXlCT58r5AmLIxfSUcMrk?=
 =?us-ascii?Q?yOUtkssRfLHZLy6xWdjbg0Jwdk0U+HeYZj0dcg/DDG3PIyD4C7ST3VP+al3k?=
 =?us-ascii?Q?YxpFWAEYwFO5TwtGsmyB+E2CAwq54m48xPe6taSfWFGLhVsxthmpON0tjrPF?=
 =?us-ascii?Q?sXqzjXIJelpYsEqYZBo2Hq2KojrMNuKqR96z?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 18:04:30.2175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0573b98-a259-4ccd-552d-08ddc3ca0bb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785

Introduce a background worker in cxl_acpi to delay SOFT RESERVE handling
until the cxl_mem driver has probed at least one device. This coordination
ensures that DAX registration or fallback handling for soft-reserved
regions is not triggered prematurely.

The worker waits on cxl_wait_queue, which is signaled via
cxl_mem_active_inc() during cxl_mem_probe(). Once at least one memory
device probe is confirmed, the worker invokes wait_for_device_probe()
to allow the rest of the CXL device hierarchy to complete initialization.

Additionally, it also handles initialization order issues where
cxl_acpi_probe() may complete before other drivers such as cxl_port or
cxl_mem have loaded, especially when cxl_acpi and cxl_port are built-in
and cxl_mem is a loadable module. In such cases, using only
wait_for_device_probe() is insufficient, as it may return before all
relevant probes are registered.

While region creation happens in cxl_port_probe(), waiting on
cxl_mem_active() would be sufficient as cxl_mem_probe() can only succeed
after the port hierarchy is in place. Furthermore, since cxl_mem depends
on cxl_pci, this also guarantees that cxl_pci has loaded by the time the
wait completes.

As cxl_mem_active() infrastructure already exists for tracking probe
activity, cxl_acpi can use it without introducing new coordination
mechanisms.

Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/acpi.c             | 18 ++++++++++++++++++
 drivers/cxl/core/probe_state.c |  5 +++++
 drivers/cxl/cxl.h              |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index ca06d5acdf8f..3a27289e669b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -823,6 +823,20 @@ static int pair_cxl_resource(struct device *dev, void *data)
 	return 0;
 }
 
+static void cxl_softreserv_mem_work_fn(struct work_struct *work)
+{
+	if (!wait_event_timeout(cxl_wait_queue, cxl_mem_active(), 30 * HZ))
+		pr_debug("Timeout waiting for cxl_mem probing");
+
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
 	int rc = 0;
@@ -903,6 +917,9 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	cxl_bus_rescan();
 
 out:
+	/* Update SOFT RESERVE resources that intersect with CXL regions */
+	cxl_softreserv_mem_update();
+
 	return rc;
 }
 
@@ -934,6 +951,7 @@ static int __init cxl_acpi_init(void)
 
 static void __exit cxl_acpi_exit(void)
 {
+	cancel_work_sync(&cxl_sr_work);
 	platform_driver_unregister(&cxl_acpi_driver);
 	cxl_bus_drain();
 }
diff --git a/drivers/cxl/core/probe_state.c b/drivers/cxl/core/probe_state.c
index 5ba4b4de0e33..3089b2698b32 100644
--- a/drivers/cxl/core/probe_state.c
+++ b/drivers/cxl/core/probe_state.c
@@ -2,9 +2,12 @@
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 #include <linux/atomic.h>
 #include <linux/export.h>
+#include <linux/wait.h>
 #include "cxlmem.h"
 
 static atomic_t mem_active;
+DECLARE_WAIT_QUEUE_HEAD(cxl_wait_queue);
+EXPORT_SYMBOL_NS_GPL(cxl_wait_queue, "CXL");
 
 bool cxl_mem_active(void)
 {
@@ -13,10 +16,12 @@ bool cxl_mem_active(void)
 
 	return false;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_mem_active, "CXL");
 
 void cxl_mem_active_inc(void)
 {
 	atomic_inc(&mem_active);
+	wake_up(&cxl_wait_queue);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_active_inc, "CXL");
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3f1695c96abc..3117136f0208 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -903,6 +903,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+extern wait_queue_head_t cxl_wait_queue;
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
-- 
2.17.1


