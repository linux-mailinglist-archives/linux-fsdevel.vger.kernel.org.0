Return-Path: <linux-fsdevel+bounces-58735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DC9B30CC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 05:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E1E6061F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 03:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733D2299927;
	Fri, 22 Aug 2025 03:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VCSWmqE1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9A228C871;
	Fri, 22 Aug 2025 03:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834144; cv=fail; b=IKWh1Zx6spDDZ++IZ9DGGf85wmWNw6ZzG+8/xjTkpHlDhhUy7AeXlnOrFb8hGctr2MGb7UaYSjr0kzAanjebHKnT9OanAc8FvRX3Tqy+WBIkatP/iBm6ZRVEKDapWrhSJ8w2TmInVSU5nBNiCto4KBQuXEKjhYRzDYEtL/C3BUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834144; c=relaxed/simple;
	bh=88Cg+lLQBuqi3QqjIFfsXWqKP25eldIGvx4aDTQ/dsE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMx3elhhb/E41BI+lFAGzQYPgYVPqDWuqacm6NntME83A+5Jl037HTKfkwEPga1cpBomK1xXGA0ywYZjvhrbWBLecnd6uCTTgOR1LaMYS7udYmt+U9t+3NRXbrJNUcqcLpo0BxZvTmt32q63GzLYtFD9wW+u3RmyhGyzivyKnS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VCSWmqE1; arc=fail smtp.client-ip=40.107.102.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNohLDNbBTExnUfbkVCGgGoUNPGmjsjl0eQkHzKu63pegbbPW3dyuGuaEI06JjdZl5qKWLctnWDiazhVG61b6/9oCuXc1G87Iw9HtpGsGn83LxO0ZG+8ImVZrnxyJBIOszrfi8BCGwn6bxy/+O/VPW0vVVUkfGkSWU8Mh/CA//9UpN1dweF4kZ2cPt+pf7E5cXETk/rpN3fGkEsB44dzDxouBDg16Sm/HDWy/y7WJATncVnBuD5Tkwthw0uV7sxz/heEnxbj7ekmvaaztqjHEaNjf4ZEnnuLNHToAarsRTnawadNXWF/O5bbkheZGSqn4ReGphO0GtCDkSZq85TlCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eo0n6MX0Oo5gQAFDbyEJWjC43s5ka2o7WU52PkP8iPA=;
 b=Bib+OfEiphkNtCOsOiRol2h7+4KTXudolKy6Jc5YTZGlj8Y5H3K4wktOTkS+svotfFmi4vrmBKIyUHCnX8iN4IpVHzODb/Omr5G7ukui8MdQA2LjQ0nqHtFUD2gh2UHHeB2FAIsz7gFoQmZvJebXwyxi7UCWZg1eFxtkTLdpNc8Sk1ln2sNp/NLLjutkGtNe31ou8cWP1ULRma2ir/gPQwOSwOagnGDSy6e+1vGst8glvBj+hwcufECgfeZlkW3OrekmpqO03IBaoxtf+qdQgTL+Bk/2Fiq9Q1rxIgsRnK444ZhoGMPr74pK8iPC6ujtulcoMCavYkK8n6UrS0+akw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo0n6MX0Oo5gQAFDbyEJWjC43s5ka2o7WU52PkP8iPA=;
 b=VCSWmqE1+UPvi6jcmLeMT4ggG/3NiMcaHGCe5kPYZGArJvx0xtNPn9Lc0EXBsm+F3+MGRBlv9cSzzAdC55uqfHYNEi+ZevL+19/m7BP1s6Uk6yf2A3XUzE9eQ6YxMD16N75Kiu1aNQa3l4C6pKZJBwv2Zdvy7T+1BvP61vi1VxI=
Received: from BN0PR04CA0147.namprd04.prod.outlook.com (2603:10b6:408:ed::32)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 03:42:19 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::d8) by BN0PR04CA0147.outlook.office365.com
 (2603:10b6:408:ed::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Fri,
 22 Aug 2025 03:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 03:42:19 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 22:42:17 -0500
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
Subject: [PATCH 4/6] dax/hmem: Defer Soft Reserved overlap handling until CXL region assembly completes
Date: Fri, 22 Aug 2025 03:42:00 +0000
Message-ID: <20250822034202.26896-5-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 487aa085-bd91-414d-78da-08dde12de566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5CuOD1FAaYS92BSeZqeY0X/2336v1yjj90idPpG+xX5Aj4CkkhsoC22wvsVJ?=
 =?us-ascii?Q?M4JT1lOLcuiyrps6sNifyby2P/7Fut/IqaiuXOqn3UileL062YLQMN2Js7tz?=
 =?us-ascii?Q?Vb53zxxz8nMq61S8cfe2u2020uexBNZHoUBNQEaaAbkBiMItqf+gucHgI/pb?=
 =?us-ascii?Q?sBzAYYOInIKa2KYhEMFmy+Ld2ALmAkZGHMvkqVszPZNDm4pgp04mwcOzGO8x?=
 =?us-ascii?Q?clFbHGrIa5si9ZLx8IVN90caTT2AQtRFfmys93Ze12p+Rb337iPFMZVkOPwp?=
 =?us-ascii?Q?whHiDV/FbGbh4AjF/XAV8J3C6/EoZ21CCjN67UmqHOBnOQy72Lb2AZBV/XHY?=
 =?us-ascii?Q?iCTPvyz4tsQCsIb188WW3uxsroos8dftRsurv9mPHKp6Q16wjX6GmpD6tZkN?=
 =?us-ascii?Q?AmFkids8pGL2u9l8OsDxML/uzKuUiITylIkZEcZsKFShSLTDEgzNoP6MPuJ5?=
 =?us-ascii?Q?bWWiML2w/kGlVH4b5vTr+p1qGGa2Q5bfoEmjm/HMDpgrLmEA5gRngH5KvXhZ?=
 =?us-ascii?Q?MTLRFyfggeCy30tjCxTqPb9c+TzPogysd9OvAm7CZ/Vmi4zcRNt48s9j7IGt?=
 =?us-ascii?Q?Vjva4RafkhkpZZj53GB/PyeG4XiBD2uflpqDRjiyrkMgqKPHzJ41sZ9gOe1k?=
 =?us-ascii?Q?ZKuJGLp2/6YH+7Ic95ytdKiVlvvEQZ4G/TVF5oIlVwfcia+e2pgb8tuRHntp?=
 =?us-ascii?Q?SVbtYEU7U64N4c5nJcPLydB/IgcO1E7LEEX2+bhZUVNRU4nSnklANesUmLcS?=
 =?us-ascii?Q?61edRhCKdLh87Q32QG02k84oFHB2GimmrdLYc4VhEWebblF+vpK1JEqs5Ohl?=
 =?us-ascii?Q?cm0IJ19huK3C+fkoHEmli5gmJh1d1crfgJgQoY8U0zawKGCiurXh2NUPnqJx?=
 =?us-ascii?Q?yXaS+b3hVovm71lUqJ6MXB8jrQ5BjT5RE4nPaG3CuMBOn3noqtUHjyL/mdHb?=
 =?us-ascii?Q?NMWttHJrVkfRT5s9mqMhUUXSjx41PFHJXMpmrO3NK95yYqkzqSgohI9FZBGz?=
 =?us-ascii?Q?XxkAqNAo0IkUdiOS0WMzJdIvjJ6g8TO2Eqlxnd/96c1IHDQZEw5WV/SGYdEb?=
 =?us-ascii?Q?lMrWpdH+eEC4oCf03MBSSwbNwDx83LD9D8ktvIcy9wwhF298/+aWkgR8OOH9?=
 =?us-ascii?Q?3ufxe6WNOYj11bqCXV/0rOO8Vfbo40TiHeuwCdBi2VxbyhQXhLztYsNjKBoF?=
 =?us-ascii?Q?0L0xY3JN1uYBtxZloNPRm5rZ/Fx4s5ydP2qPdfw0yqy2TYg0FaV40IdPHdUV?=
 =?us-ascii?Q?uo/8GVnFrzEGOlTkNcBELj2SKtw8uHemKeek22mmUOsxUAzXowCnnrDioFBu?=
 =?us-ascii?Q?b1Uc6EfDwIBRgyspFO2Zre+P6M+TV/Bi6bqLje0qRwAgMkztRJy0QmaLvs9Z?=
 =?us-ascii?Q?WDJVm/Hczw4383Wtbmz57NxKGlBJg/U4uSaxBtIB6sx7GCPTT51SVgsPCbuK?=
 =?us-ascii?Q?MCKH0p5S/zAdhpysLlkpyFdF6h8wccRbIzYSQyn4ZCcaAF6KxmhaIwVEATw8?=
 =?us-ascii?Q?Czj685PQeCnnmLQwMeeWUPbRyAh9pD8sE8SR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 03:42:19.4532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 487aa085-bd91-414d-78da-08dde12de566
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341

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

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/hmem/hmem.c | 72 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 7ada820cb177..90978518e5f4 100644
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
 
 #ifdef CONFIG_EFI_SOFT_RESERVE
@@ -130,8 +176,30 @@ static int hmem_register_device(struct device *host, int target_nid,
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


