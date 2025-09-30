Return-Path: <linux-fsdevel+bounces-63075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A94BAB5B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2205E175F92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 04:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE4626CE34;
	Tue, 30 Sep 2025 04:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IAhBZpMP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010058.outbound.protection.outlook.com [40.93.198.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9122125A655;
	Tue, 30 Sep 2025 04:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759206517; cv=fail; b=cGDuqpF2DzPuuq9Ul/MrhrSQaJCYn3rGRtxLK0mUrK4UIoHMVs1pAIZOLudtBrDfB+m4r+Jkcl4tIpO0dEY/pyqcV+dGNUfvAJzQHpUcPo4liif1i/af0MKx94zyOWclqb4Rv7fwjF33stb1UGtCnQdmdU/cuMRYbKDmEum8yOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759206517; c=relaxed/simple;
	bh=mM3OwFqCfbs81AoZhq0z+75zqU0rHE6OndnRE5+Vuwo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ct2Jj2RhuKX60Fve9Crh8MoCDbdCd17CuDJKomPvYVYZ7WPBAsHgyCqYxOhFIcp5PsSiVWRbi0yUKxi6EIULkOp5RyLitoIRaHXdmbf6RrC5ubEsqUNnU1rrs+KqcEP81EsL6ZEcZ9Br9BK3fBS4yudqwCgBIgTVd3BxFChBUt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IAhBZpMP; arc=fail smtp.client-ip=40.93.198.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tjljx4Wwo9WQFtcgWN5yOHM7+7H5ZPGS8FsFH5VQEXsdK8jxBI4Etc2OxuvnwNi8P/ucFs8nRz80pxSW6AU+D10dhmxyzZZ1SRn4ULz6BI/tPMw9OSTNu7uG7Vta9EGGjBD9D3KNop+TxJYa63q0ufkSgzr3b7Q3aOCS0P1lPM0Hyzr/JTx4329bDl1vAQkbUZOYwfbQOZwDC8TteUfsvrYEJhqix47MgAfYzjdi6/bWNkkjNkqrr0/oU2LzFhh6/JLjQGmmojC46aqH/AZdddl3C8WVkA4xE9n8BhIv68bEPT3cFqIpTT6EUfnIO77Um/j+izai2XVr6E4jqjFrGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpMu8HuzQnyqOjkKjmx43q7KnVLbgYI0Q8PsEG7TJ/E=;
 b=L9bscB1kb3Qvm9nj5m0HzmIdjc/xPnMj7B7CcOGj+qpYdBOgZyyhyPdbfPB6LMMGwP5jfZ6XKUha63NVvlKOzZE0N3CJj0QfTA6okJFA/iaDT1JtUR8W5znjTEwr2UGDZAmIFYZijGmAWjqPVK2tGX1YYJRzE6Mht0tH/V9XoSB3WvNdK6GywUKWanIiErVtlCfxRiPLRYaTA1vfUM8uZRlUlBrOGhsSwIHyo8qNT+A22RC4e2xLmTO96zQSJx/06DJAprfir2Y7JlXqk7/zSdbt0C+P+/dJuG/8gjAxxx7W2s7JiLc5bpHPd0Z2f5RBhzUf+Yc7O/y0NfJKhtfLQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpMu8HuzQnyqOjkKjmx43q7KnVLbgYI0Q8PsEG7TJ/E=;
 b=IAhBZpMPsDS5rDLdMpMFe6hs/XdZ3e2u2KxErHMtmToC0v4RB6SvTozS3FZrVARiUNg7BxMwHFTJ1YGRHao0+w9tqvSpAY9q4rwPt8KIGFHoQaQM2e6gO1t+/7aPUgIFYW7Fh9cSA1P4n4tCmBCY8emlaTVcbpH2lANYm1/vzAs=
Received: from DM6PR07CA0048.namprd07.prod.outlook.com (2603:10b6:5:74::25) by
 LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 04:28:32 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:5:74:cafe::7f) by DM6PR07CA0048.outlook.office365.com
 (2603:10b6:5:74::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 04:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 04:28:32 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 21:28:30 -0700
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
Subject: [PATCH v2 4/5] dax/hmem: Defer Soft Reserved overlap handling until CXL region assembly completes
Date: Tue, 30 Sep 2025 04:28:13 +0000
Message-ID: <20250930042814.213912-5-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 692e6d9e-1a44-4a7f-e053-08ddffd9d01c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O5jSYn8A9em2Wk/pRBPdibAKCGjQANRRusqfKgqaZouP1cVdCHpGXytmZfg6?=
 =?us-ascii?Q?ajtfCn60aQkMZIQHYO8T0BeWfgFNUQRwV+YGK2XMofLD0FXpydw3MSrsiA7m?=
 =?us-ascii?Q?mLAlvIXYggGD9O3ho9wgPtIGuDo06bXwjEhGavKsjthlX6DOis5AoGdQgJNo?=
 =?us-ascii?Q?7BIwlmXlRKMNlDU5NaTN8tZCn0bGz1omvpISwD6Cd6I5vMR5rCmcJnX9fgH5?=
 =?us-ascii?Q?W57ffxEsG6f7+gyhel1Aelk0C8Jk11fcDWg9MBI5qc94CCIiVyPcrTun2rmI?=
 =?us-ascii?Q?+TuRxukMVeXKhar8lqvw2IYE32NbEwQB8UKjoxr9YEj6CaEmACJN119WLRgd?=
 =?us-ascii?Q?z6/CMHhEB167xY7y7KezTW06zTIilGZ1T95iS7Bu4NAXxloCB7i4P+G5NsyE?=
 =?us-ascii?Q?Bs5WXMdJM0K00ggpKxjzlrj3yoJ4HSVUOt+jLSjbOOYhEI6AZG6PRYuZkghm?=
 =?us-ascii?Q?0TMWLw3MsgIc27SuiGuVZCOvEx9JUz8t3C8CTUobzgTK/fg3WdIelNydHbMM?=
 =?us-ascii?Q?pI/HNWl7uBpWzzOrFet480eA/FK+D9k52zho0CoKwnmnDVM+v84RED/aU81C?=
 =?us-ascii?Q?ARIAaqpjEP8ktzdGHLMnc78HpS+KlBAhRs6LSX3mPxE8eLa5IdVn0TZtgZZF?=
 =?us-ascii?Q?9sH1ZlGsJuoPKG+b9+MhsJuTjIzN/jnkDa4ifz+A1MtU+wcAKCgZGHjS7sKd?=
 =?us-ascii?Q?Kcbv+6xdcGO0x0LDRW5yxn5vQIP4C6YxKXrOlwzwW19zVKT3XhwQXpkmJQGN?=
 =?us-ascii?Q?O+9Wcm7+6gkx3hgculknQr+iqmPhzcVLlbS/9MhRZssTsSXw/ZgxCihXh5xH?=
 =?us-ascii?Q?N4s7dhEb8J0D08mZl8z8e4DkfMuQ1EA4F9c6glUS1fVy38nDdxkZXmLwJQkQ?=
 =?us-ascii?Q?NZaIZkCJd7IF3V4WHwx8GzFOFivL+1VQTYRlP2S9av6xORRueAlHE7vQPNVz?=
 =?us-ascii?Q?2mJpkI0TlK6/xBto7XwGfMyFLLHJcd6eZSI3ycuutdHuExwOxLFQkxBe0cI+?=
 =?us-ascii?Q?alz+YA/TxKpidIWIoVAocXDZIoMNdFbadYFTUgD1UZj/ZJXC2QL5xJgN59IC?=
 =?us-ascii?Q?Vf8t4kSXGLiyJqAHY2Pu+okYMxMT0vX8VoOEr1lOXfEwzQc/e+M37ylpbRj0?=
 =?us-ascii?Q?+b9J9Zpq9q6QHIH21dcxa/D/oFgSxBcJ8uYbAF3inwMDyGSmhqYvce1yMsUz?=
 =?us-ascii?Q?11GjGietL0sqnkc6Sf8TvIHhObAkGOHqLuWEa98GazwCAR66TapffACXEoiG?=
 =?us-ascii?Q?mOlu2fGOX+ctUPWPqE3uHpfBU7oxvRyV3G7ay6ipQtQyhZYZ43EhcATfcBaC?=
 =?us-ascii?Q?J2HXyoPuF9Ushmn4sfy2JY6zUQvdvf6VDN+cYEWTCo6xOeutcChe1scwFDIg?=
 =?us-ascii?Q?/hllP5Zq6oO9pigtdueWQjE4BeEgdVGWdjqh3gzQe3Mvpijex5o+35kHvYR9?=
 =?us-ascii?Q?o2Riey7TBmGtpbS9rxHSrLgou3V2bOHIKEWH+3MPwLftdaqbW1/NmEr0Phpl?=
 =?us-ascii?Q?HjE2Z0IuGj5t2WyJfAKSTEMq7re+1KJEdIqUHfoGsvgkOFnCPoOSSoZGt/lV?=
 =?us-ascii?Q?Tcls40rYfTpHycixKjI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:28:32.0419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 692e6d9e-1a44-4a7f-e053-08ddffd9d01c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845

From: Dan Williams <dan.j.williams@intel.com>

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


