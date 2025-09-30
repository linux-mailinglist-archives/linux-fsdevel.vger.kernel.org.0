Return-Path: <linux-fsdevel+bounces-63082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB54BBAB6A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0886E192573C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 04:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A4F273D66;
	Tue, 30 Sep 2025 04:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="twMjbj9C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF597271464;
	Tue, 30 Sep 2025 04:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759207702; cv=fail; b=oNv1fGXlS1u4dK0kJE5qmeFjRZsxu2sSu2H9FbuaGls/xo7QBJIB/ONqfkJzzIyxdpazQZsYOOpBW17pnzM6QYKdVtapAgYwaMc6jplNsqXJJPUSky0vCO2/Xaq7HiOt9F6yMailEX3J6ar6A4fZunHYwAwV9y0xm7cgO9uWL7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759207702; c=relaxed/simple;
	bh=bM6zgPkc/WSk3V5BgjpmdS6XIWMDPdmgExWWZUDIDgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNzcuqxQ9ilWzK4j9l9qbytjOTOdkN6glUKdnfSZJyFJCqrwxiabQQ2NGvJIL33FgkwsdZ4D6f44xDuaY6LAKQZs7hTngUwQfJcQ49keWIMph+uKfd//QchtuS2irFithyFlSpfw+4+u6WC0Fgcii+NILEtCOZQhxDmgXAO/s3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=twMjbj9C; arc=fail smtp.client-ip=52.101.48.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojXxkU/+D+IpfQHO0ANUNJ9Cinx0uZfdu+vTvFKQ8ppbrp9jC3RZVbmFazXP3jA0JczrYhzCXKNgffdhlkB8vwZP1G1YL9Xfiq6iXawHyKcV0zMi/mjupVMzqy0YzKunlhCOeYHO2v0/ugD3uLXkEIigHjpYP0vmSk+rOvVFTo5B4kAjiLmcN1FTQRmc1uYkMQwcQzjFbDepZS2BjJyZXQIxYDhhPFv5CF5p+gvD+fMateogcXFoQtc/4SilfRnqRUtApnaMIM/n2R6DizdnHCKpSauVZLPUUjZwgCMbFR7EcSaI9l/HSjPL3ti2E5IysOqsmoarKyPuXI9dI/hQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nU85OQv+cw1A5brQstAzlJdfY3ITWl3Ohn+ZIdwk1zY=;
 b=GhPCYSJQnYxk3688AasaGcGJ61O++UsEdP+yNxH4XGrUSmkYZTpZytsS8gIbrCiLs8WdZJF1eeyShgPJ+vRJrdteCeY0HAh0dFp3M0fleo1GHK2iwBd//LuJ/St8HS7tuELhrA4XnT5BUP/H5UHil4xUAghGG4BchTE7h+PjkQT2wwm8L/Q9PHAFXhqfBgAQ2sAWTEnQ8LQcceDORcjH7wc4wxQ9CzitneFfiEnsVb2VA/AvGw0rQQNwWpCOJ+2DTuN7bZ+diuAumrVgIUbfGLqtG3N7Vig26LacYvWXMBd3RBb65EOvw1tX/8lFruDG/xulRBFIWlDb/Yf0s/wa1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nU85OQv+cw1A5brQstAzlJdfY3ITWl3Ohn+ZIdwk1zY=;
 b=twMjbj9CRYThWbmaWBh7J83HrM95N9v44tE57TuHBP9Ilx0kj5a9bV7FOg0uRE5sFbIJDwnGhXmHNNSO75AC87KZNviVK8v2iZUUWNy96L6OkyM51PqoRH0LT4GQfluaZMz8tib+TdEcI5HAxeErNRdhUhnV1xmSU91orJZsY90=
Received: from BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::13)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 04:48:13 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::f8) by BY1P220CA0016.outlook.office365.com
 (2603:10b6:a03:5c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.18 via Frontend Transport; Tue,
 30 Sep 2025 04:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 04:48:13 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 21:48:10 -0700
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
Subject: [PATCH v3 4/5] dax/hmem: Defer Soft Reserved overlap handling until CXL region assembly completes
Date: Tue, 30 Sep 2025 04:47:56 +0000
Message-ID: <20250930044757.214798-5-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: c36741de-42d0-4a67-1c2d-08ddffdc901d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|30052699003|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Gk9dqCQJvwsYEUeHSm5PII3XhQoxbbmQgHrCXAtJRrk5CnkSCcxnWsr1BQg?=
 =?us-ascii?Q?kTZ1PtBvVvieEad60AZxNtjus1Qt6at/EVAzYboBuXTG8sW5l/3kEIKGebTj?=
 =?us-ascii?Q?0t6N2sMjVEsQQmFCwIevITqGRHUVjrCEqXUEdM4SKnAR6IkhY5eF/twHb4LX?=
 =?us-ascii?Q?WduWSF6EVzUoJvuUULIJVcRec/Yw0PXKlir5Xvg9AYp/gO4paYOyqf/6NSMR?=
 =?us-ascii?Q?Sm6mXeoYs5wazfamV02tsPzadmlhzmm/PmnAHnlWNMin1SvBxvQFSIW+FgiL?=
 =?us-ascii?Q?2Jrh40V4LGx66nTxScdjncqWgTlYBeD6uyqqwZXRQOsQBQ9BCxmF2RJrHYMT?=
 =?us-ascii?Q?vd35Ejm0N1tQj6o2uFxeCE6fXvfYr8AHoimj8lwpOx8dEuhA+VOyzB0t9zTO?=
 =?us-ascii?Q?UDirgVgCS52VZzqK0WUG7yeLf0xC+64RTTJ2HPwvYB0Q8u7/vp6O0sK47qLZ?=
 =?us-ascii?Q?v3Cp3I8VlYhH68w5qOYInxvpW3wiZcY9UERim0Ru1w0uhLelJfp5Jy2/Ijrz?=
 =?us-ascii?Q?iRocL/62PN3b++uIXQZWXUzwlv79ZFX8VhmwWfdR/KXwkpL35E7Xb1E/5EEG?=
 =?us-ascii?Q?tBXjWxRWxt0MULWCLIuZ+6lvmEe+QfpiVngsp4TrNBLrEu6BMefawlQfzvjk?=
 =?us-ascii?Q?mlpS2LuBk4SgUMRPXlHLNtTpaHDlBfy0lJh/AMkk9HA6JBdf0wsJY0D4ykdZ?=
 =?us-ascii?Q?z31+SfdBgtD72E2FDXH8y+EIul3nceFnQll0NwsgZ6T/wXgcwVXSval29hns?=
 =?us-ascii?Q?CwPICtEFDCrtuC/mXh9m3FQRpNAgrePXGIyKaahbOV2kExwDCT+JQf8LMEPc?=
 =?us-ascii?Q?aZFeXvo1fRXCKImYwJLtY1i6/G/gmTwv/GZIimtyO7wOvqJyWgICmgSS2N/Y?=
 =?us-ascii?Q?v/UpHovcNC9fwKwtuALFafEIq0aVWc9afilgjZMUGBHCKL7Ck6a70wa2zWhT?=
 =?us-ascii?Q?J3s2gJ1XbQ9IQg0WdCb/RSOw2ilyIsLfwxJjU6/HkVh2Yaenqoi9AyHNAqLr?=
 =?us-ascii?Q?rZBnQYsYPTK3PdlWG1EIy13nZBf7gZRUWSjBlKgY9pBtHIEHrVgURm6JZGCL?=
 =?us-ascii?Q?JwNd7iaFGhhBKr4nh+IEvdliqZzWtYQCpEpTHAEgYTMykWR+MWbvNR4cJcq8?=
 =?us-ascii?Q?qj6tHbWsqd7FAE6Ps6MlhXVM+ZhM7eQD7ni+V20EWy2P8X83bQQ2A8J9qeOs?=
 =?us-ascii?Q?w9hQ/iQBcndnV97RCeSrXSe4bYPfrCmP8+MP56WW9G/IlKzoF2c6W/Oc9f9v?=
 =?us-ascii?Q?pAXzL2ESvC31FkPt2tp8tiRuvmVoxeG0dMHo2potwN9YfF1HV37x0FbI3Lwc?=
 =?us-ascii?Q?6lRSTPPJdAda6aF63vmCDBRcYXM38oS9OVNwG0WCaVk9/Q4up8HFKXv40Yl+?=
 =?us-ascii?Q?SislSMMNEQCsjDMm1XF0PYhHQsGxAvald3XB4j+4LxJZ2ey4i2at6w3hulzO?=
 =?us-ascii?Q?CkFanyuqTOgH39Pc9+rt2fW8Ssq/+7X2l6w4lHKuGpJGFExWIagp0ggN1vly?=
 =?us-ascii?Q?9XZuT47LCy9zFRxYdBdOYuXMB4KCZ4xJ5gRA//K1L/s+KtQXWZ0ZO7Hlxfn/?=
 =?us-ascii?Q?Wj/RTealPZEPIHlMhqI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(30052699003)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:48:13.1483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c36741de-42d0-4a67-1c2d-08ddffdc901d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735

From: Dan Williams <dan.j.williams@intel.com>

Previously, dax_hmem deferred to CXL only when an immediate resource
intersection with a CXL window was detected. This left a gap: if cxl_acpi
or cxl_pci probing or region assembly had not yet started, hmem could
prematurely claim ranges.

Fix this by introducing a dax_cxl_mode state machine and a deferred
work mechanism.

The new workqueue delays consideration of Soft Reserved overlaps until
the CXL subsystem has had a chance to complete its discovery and region
assembly. This avoids premature iomem claims, eliminates race conditions
with async cxl_pci probe, and provides a cleaner handoff between hmem and
CXL resource management.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/dax/hmem/hmem.c | 72 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index c2c110b194e5..0498cb234c06 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -58,9 +58,45 @@ static void release_hmem(void *pdev)
 	platform_device_unregister(pdev);
 }
 
+static enum dax_cxl_mode {
+	DAX_CXL_MODE_DEFER,
+	DAX_CXL_MODE_REGISTER,
+	DAX_CXL_MODE_DROP,
+} dax_cxl_mode;
+
+static int handle_deferred_cxl(struct device *host, int target_nid,
+				const struct resource *res)
+{
+	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
+			      IORES_DESC_CXL) != REGION_DISJOINT) {
+		if (dax_cxl_mode == DAX_CXL_MODE_DROP)
+			dev_dbg(host, "dropping CXL range: %pr\n", res);
+	}
+	return 0;
+}
+
+struct dax_defer_work {
+	struct platform_device *pdev;
+	struct work_struct work;
+};
+
+static void process_defer_work(struct work_struct *_work)
+{
+	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
+	struct platform_device *pdev = work->pdev;
+
+	/* relies on cxl_acpi and cxl_pci having had a chance to load */
+	wait_for_device_probe();
+
+	dax_cxl_mode = DAX_CXL_MODE_DROP;
+
+	walk_hmem_resources(&pdev->dev, handle_deferred_cxl);
+}
+
 static int hmem_register_device(struct device *host, int target_nid,
 				const struct resource *res)
 {
+	struct dax_defer_work *work = dev_get_drvdata(host);
 	struct platform_device *pdev;
 	struct memregion_info info;
 	long id;
@@ -69,8 +105,18 @@ static int hmem_register_device(struct device *host, int target_nid,
 	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
 	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
 			      IORES_DESC_CXL) != REGION_DISJOINT) {
-		dev_dbg(host, "deferring range to CXL: %pr\n", res);
-		return 0;
+		switch (dax_cxl_mode) {
+		case DAX_CXL_MODE_DEFER:
+			dev_dbg(host, "deferring range to CXL: %pr\n", res);
+			schedule_work(&work->work);
+			return 0;
+		case DAX_CXL_MODE_REGISTER:
+			dev_dbg(host, "registering CXL range: %pr\n", res);
+			break;
+		case DAX_CXL_MODE_DROP:
+			dev_dbg(host, "dropping CXL range: %pr\n", res);
+			return 0;
+		}
 	}
 
 	rc = region_intersects_soft_reserve(res->start, resource_size(res),
@@ -125,8 +171,30 @@ static int hmem_register_device(struct device *host, int target_nid,
 	return rc;
 }
 
+static void kill_defer_work(void *_work)
+{
+	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
+
+	cancel_work_sync(&work->work);
+	kfree(work);
+}
+
 static int dax_hmem_platform_probe(struct platform_device *pdev)
 {
+	struct dax_defer_work *work = kzalloc(sizeof(*work), GFP_KERNEL);
+	int rc;
+
+	if (!work)
+		return -ENOMEM;
+
+	work->pdev = pdev;
+	INIT_WORK(&work->work, process_defer_work);
+
+	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, work);
+	if (rc)
+		return rc;
+
+	platform_set_drvdata(pdev, work);
 	return walk_hmem_resources(&pdev->dev, hmem_register_device);
 }
 
-- 
2.17.1


