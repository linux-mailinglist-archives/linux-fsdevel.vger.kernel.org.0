Return-Path: <linux-fsdevel+bounces-55015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF41B0659C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1204E24E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56662BDC2B;
	Tue, 15 Jul 2025 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wui63A2S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8111629E0FB;
	Tue, 15 Jul 2025 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752602678; cv=fail; b=bg6MPPA0atRcykk/QAZXn5aWiRONZx9vjTu5Of0g4oye99P4XZHZKEJFKEFoVrCBCNdSwAHfwN2DGfgwuUXmChzV3p6klhWojFWaJwAJgHKrTapqJuHCMvwfDAZfq1pbIMZ8eyUgXe/U6GRtoDRoNjcaD+U3/+6oCvgNEHq1Bzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752602678; c=relaxed/simple;
	bh=g5OuHNAzAmcd1mtOUouNRCgxjgjiEgFfNdtgo/cSuHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/2D3OD3I7J88qLss9Ji5CUau9dRb7CsxL2QWdv3gfT/yoD2h3sf3JRWEGPlwQJIiNvOSaE6b4hN27oDsFE90H5C+Ff7ueBCJFlUkdRVi5beny08LOi1M9PA8BDH10o3il8G+Xp/Z+LrSb6FikXoQSrQh0e+kWJ1ugM4/BRe1qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wui63A2S; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qbdo7SbIfaWqJOA1WhmhZQTqXL3WD4cRedf8zLO1RdYAEf5sX0hY2bHBc2GKK9JLegFk9bMZ2oIo0CxkDX67FcC+B04T8FJ7a32pTS4ifLyg6kNO0jUsIPY+aX2ShxlTxAmh7bf997QMico30Vu/U/ZJiwkEANI0XUTYOMeN8NJt1AP+oBd2C82GGLcx/35kaaRFt+nRRpchmEBEyPNCZjlyyKuzOQjy307ru9j65C4q+rCeUQ7zWwo1Ib69kQCNgdQbqr1O91tmH5Pfv1bmbU3GWchiklK00h4hqAz6pmzSUjmKSEA8xfU59XRS7kx2+9VPRFuOoxNbdHcOhQhU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buMO3LfYHL8RO8UoHaQ5B6GUP+9sOoBoqKH1RQ/FUdE=;
 b=LOjACIirLsKAYpD9IEiXMu29uwvW+scOjO6uJ8JYpOUrwsPjgvvDYoynzJsgPeO80Pt56t3AdVVgDq2fX1wi0i7iEFTq7XPPnReANFbfeWusNB53B8te6+ruFOpfs7HizW7ZVxoU+aB4EX7KwhHKsJIDX6I0Pd32aa8IFTogANTmjPQo8ELkplFM4lM4VdVKdIv1hFZZApiJo00OSsAUKa1ApBM0R8aM1CaOcxKhuQSWrX2Ug0PpOhtIGjQJCqzQ1iPL0YqfzeKzu8pKahtqfoCgwoaEjWW6n/+vRtxYmOB4zjreX5glX5NQ3kFWw59F6wIV+/bjjnxBmk4bwQ179A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buMO3LfYHL8RO8UoHaQ5B6GUP+9sOoBoqKH1RQ/FUdE=;
 b=Wui63A2SwzuFlf3LIF+BC+UkfoH2lJCe7WZBDJV/BvaMwvwCaP0sy9IhKgEB1c0ce3i766wDm6snkwTZ9etdXoFcsBPfoqD139erQrTQKIoJ/UGM/IMzvfv8dE1tNfrFnB32hujV7jCZosFyR5vra4BZpsceOhfqklV0WNMh3jQ=
Received: from BY3PR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:217::8)
 by IA0PR12MB8896.namprd12.prod.outlook.com (2603:10b6:208:493::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 15 Jul
 2025 18:04:32 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::95) by BY3PR04CA0003.outlook.office365.com
 (2603:10b6:a03:217::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 18:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 18:04:31 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 13:04:29 -0500
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
Subject: [PATCH v5 5/7] dax/hmem: Save the DAX HMEM platform device pointer
Date: Tue, 15 Jul 2025 18:04:05 +0000
Message-ID: <20250715180407.47426-6-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|IA0PR12MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 40eba2bf-64d9-4f82-dfb8-08ddc3ca0c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rZEaJ2TfW+l+hh6D2vvQfO/7NZt9qa4laNn58WEIUauhgmI7BYJ4GJxep58c?=
 =?us-ascii?Q?mANxkIm/f8sVWYTNuQDfziDo3246V/CQa0vnJHNXGt4fXsSWDv9fkVN/3Pk9?=
 =?us-ascii?Q?Ml4ZH9uZ21zLhObx2hcd8/5kOkhOobHvgAVqwtRmpCr6sijb3nr3N1jCpQzn?=
 =?us-ascii?Q?/7tHaKTgqY99qfjk+s4PkJwdCdDiTBEpS+jcMqWEyq1ZncNUFl1sYt9w895F?=
 =?us-ascii?Q?HZbAs7oyUgjHhHrqvw6bvKqDhq8EhFwGPZsjkdA0u+it773pBR4V4RM/sQ+M?=
 =?us-ascii?Q?0VC8RGdIyMazR2xW62O5nVtcIxaU3Pb3McE/AF8iZ98c/wFWwe5kAC3TqTf4?=
 =?us-ascii?Q?cEG9QFG4fPCddnVcuZlYxJFTPcr1k+EQrDESzIg2PvCvScL8kqMDUshrP9aM?=
 =?us-ascii?Q?Cye3ewSyh1fcgcRswNtmw3l8DXdH26AMkB4y7T5r3/kl11KP+LyIQeDATfCN?=
 =?us-ascii?Q?npvNfQ03KpO/9lznTTc+BBBccnLE2L42pJpM4t2R4Bt/hi7N5tO5VgYJ5VGZ?=
 =?us-ascii?Q?DMgoHaaOE/KisTlAVsAi0Xf1/Gucqb87nrcRjGkeHeyK7mX4IdB8iWG3Nixq?=
 =?us-ascii?Q?m2QyWUFmMnQ4SWubwHE12h4VXrOs/kinb6FoE22ksse4CaX7TF5lVnB9Clxv?=
 =?us-ascii?Q?ubh0MpG74j9tIueL0gm/Bn29XkouXSd6VLz6hmBSI1zG2jqv0GQ8cH6zpvBQ?=
 =?us-ascii?Q?xl9C7O5gYubVKfmrRHfJeaPavDShMJhJu8wps1umhdm6OB0xGqE5DM8Yrq42?=
 =?us-ascii?Q?5ttkzOa6fvugHhI1mTw5GC11NSEVn+bzNa7uha47E4wqJk0OqEszhpyKy3Je?=
 =?us-ascii?Q?so2zFCtZVEObXsUTu3ig5QwW6yuqXRYG/V5eoSHEAkaq6i5ifXYZWwayoRf5?=
 =?us-ascii?Q?3jpIuEmwHlD+UATTVjW5q4Woryjpp9w+bkptZ/LFtUQt90nWWvbLKtD/keZ1?=
 =?us-ascii?Q?JeJwypa+2n/l1UmK5fBYVeT1wnorH9ubFsQTE9XI0nNcd0sOdjw/iJyaF/Ha?=
 =?us-ascii?Q?BsVDTYNHT7wTJd6C9EOL3NOSjo7K9riZUBEAEeP3qTCLsQtrKJX8VKVH248Y?=
 =?us-ascii?Q?C0sHLGfwRdG/Wqhjte450VMeppOSGgP+hWT/SzJtax/xNZbtb/YcXiFltxV5?=
 =?us-ascii?Q?tCihkwxzb1/p/Qs1R9xPcI9c98SvLG6BLhcNLyVWn1/v2rbzCsogMt2MqpN0?=
 =?us-ascii?Q?zDXuUng0E1DQE4ittSM4fvMRJu0y45lVrxmtU0tA0vCkw7dbUPVeNzVHn3Pa?=
 =?us-ascii?Q?eiIJpFePtS2pKxUO/DhyOWaVJzMEuBj/Pr0cZ81EzqtdnLX31ELMxDfqy4Wu?=
 =?us-ascii?Q?IPY5i7ALmDvwxr+o5syfOTezEuQPHmGeb3jCz9A534OOjy/QxMea7dhy1JsY?=
 =?us-ascii?Q?QOZApaj4+SWxO7WTL4vmXzukxA1b5PVmPWwL8gQlzPUlS3twM6Z/7t3724bn?=
 =?us-ascii?Q?itZTT2L6J4nMKIw35djZwrXYH4NbbWy+plZEpAw4niaAvz7NBvLikO5pCjIi?=
 =?us-ascii?Q?QEaCZEDwiXcq/FyR6NmhsrPBGtOV5aOBGvir?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 18:04:31.3800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40eba2bf-64d9-4f82-dfb8-08ddc3ca0c63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8896

From: Nathan Fontenot <nathan.fontenot@amd.com>

To enable registration of HMEM devices for SOFT RESERVED regions after
the DAX HMEM device is initialized, this patch saves a reference to the
DAX HMEM platform device.

This saved pointer will be used in a follow-up patch to allow late
registration of SOFT RESERVED memory ranges. It also enables
simplification of the walk_hmem_resources() by removing the need to
pass a struct device argument.

There are no functional changes.

Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/dax/hmem/device.c | 4 ++--
 drivers/dax/hmem/hmem.c   | 9 ++++++---
 include/linux/dax.h       | 5 ++---
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
index f9e1a76a04a9..59ad44761191 100644
--- a/drivers/dax/hmem/device.c
+++ b/drivers/dax/hmem/device.c
@@ -17,14 +17,14 @@ static struct resource hmem_active = {
 	.flags = IORESOURCE_MEM,
 };
 
-int walk_hmem_resources(struct device *host, walk_hmem_fn fn)
+int walk_hmem_resources(walk_hmem_fn fn)
 {
 	struct resource *res;
 	int rc = 0;
 
 	mutex_lock(&hmem_resource_lock);
 	for (res = hmem_active.child; res; res = res->sibling) {
-		rc = fn(host, (int) res->desc, res);
+		rc = fn((int) res->desc, res);
 		if (rc)
 			break;
 	}
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 5e7c53f18491..3aedef5f1be1 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -9,6 +9,8 @@
 static bool region_idle;
 module_param_named(region_idle, region_idle, bool, 0644);
 
+static struct platform_device *dax_hmem_pdev;
+
 static int dax_hmem_probe(struct platform_device *pdev)
 {
 	unsigned long flags = IORESOURCE_DAX_KMEM;
@@ -59,9 +61,9 @@ static void release_hmem(void *pdev)
 	platform_device_unregister(pdev);
 }
 
-static int hmem_register_device(struct device *host, int target_nid,
-				const struct resource *res)
+static int hmem_register_device(int target_nid, const struct resource *res)
 {
+	struct device *host = &dax_hmem_pdev->dev;
 	struct platform_device *pdev;
 	struct memregion_info info;
 	long id;
@@ -125,7 +127,8 @@ static int hmem_register_device(struct device *host, int target_nid,
 
 static int dax_hmem_platform_probe(struct platform_device *pdev)
 {
-	return walk_hmem_resources(&pdev->dev, hmem_register_device);
+	dax_hmem_pdev = pdev;
+	return walk_hmem_resources(hmem_register_device);
 }
 
 static struct platform_driver dax_hmem_platform_driver = {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index dcc9fcdf14e4..a4ad3708ea35 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -305,7 +305,6 @@ static inline void hmem_register_resource(int target_nid, struct resource *r)
 }
 #endif
 
-typedef int (*walk_hmem_fn)(struct device *dev, int target_nid,
-			    const struct resource *res);
-int walk_hmem_resources(struct device *dev, walk_hmem_fn fn);
+typedef int (*walk_hmem_fn)(int target_nid, const struct resource *res);
+int walk_hmem_resources(walk_hmem_fn fn);
 #endif
-- 
2.17.1


