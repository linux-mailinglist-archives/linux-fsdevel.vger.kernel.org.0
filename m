Return-Path: <linux-fsdevel+bounces-50527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BACACCFC7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF22175D0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 22:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859582571B0;
	Tue,  3 Jun 2025 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qKsIUTbM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8CC253F39;
	Tue,  3 Jun 2025 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748989212; cv=fail; b=LBgT3BD/qPt49M8YAMAYJJBo+udCmF3CJAM7lRiMAL2NEN7/gxbRHctncZCLxFntoRptimwKqd9mvLXmOu+rAyTgbmqXzWnvO+q8vOsXXnXkwNOBfQHFSr2ohMtoHisQFBDgCQ5FR5CgoL4njdw10kLvmcf1gnAwLGz5z69D6qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748989212; c=relaxed/simple;
	bh=g5OuHNAzAmcd1mtOUouNRCgxjgjiEgFfNdtgo/cSuHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taBJKxcQrtovJ2gPuXfgymdWik8QmT9rXX0ysrV6uuYJOk1G6B9dg7pfh7FoqK7TyS/kE0hQMkcqXwZnrkEI0eLtTcaygYocT40FoxfUsxovDvc1v+3AQcRUPdL787xbBL7bUN4br83NMm+OqBTZfO1aLSORQjWwtk2nSgC+BAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qKsIUTbM; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyoRZNdDKdMA6keGcRI90m4lci0KPckb/RZRROACLs5J/KjXL71rg18eZ9WcGmIFFIAWEDbzP1+G66dgCJ1rq8XeH896Xp3tuCgBUbm5AjsV4Q6fPS8fdptFWb6KzGGvEleV6qwzkDiem+10LxEKCd0QNeVpExm/JKgwaGFcpfdwNe65Ag3pb3peiFLTKF/QkexHtyYsdQZd3LOwwwKm/bI07jmtnb2ToKMuJKiydtZKSrjplaDjNr4BmhP9cEr88Ol6Xx1Rb2MRnE3JBjWNfRLkYzpkz4FRiW9ShQH901m+iqX3UyhI12t1NUflrw18ZrXpNqzvECgs1USQxkHgfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buMO3LfYHL8RO8UoHaQ5B6GUP+9sOoBoqKH1RQ/FUdE=;
 b=VxXmxVundBcj7QsiZVIzladUUg3vOmOjgvCAnrEH8KoFoIiAKphBNw9b/7rnBXES3EsdQ/Pg+uFhjw14Dl5c2Q8TZI2aVkX1gLQOpemNWQQ0j4va7jtup4WDXeMLGpmw/kNGqtcrRb+l/iC+i4pbYJRCrLmODDSDVVQtyCNDXEQzaeol/ADZcUMTUa9j2epnAl2KNz/TEWRTIF1Np6H6XkqfpGA+1JgqolYW+7V7KWnJnf1QH5SVxHXo1HyBPowza6jWu7yXfYyOgbQx6BzN4ePX/blGnZtbqa9toumDOOAdSNCuqyGX82RXSHGDs3a4027jtFBjJDDy1cedIC4QkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buMO3LfYHL8RO8UoHaQ5B6GUP+9sOoBoqKH1RQ/FUdE=;
 b=qKsIUTbMDzVXkroP4wjJ8h/bIZFFdMnqlkI9K3ieBOQDosIxpX4Y6aCgQBYwcJafgLqSHUlGncMAa46CzCuuAFKS73asihfZ34lih8A2GPGDV6whV2LHTmYivoAGiOJBzVnIjmCU0ujfsEFXzTz8wNcJrJVp2C1QxASpwg1ptPU=
Received: from SJ0PR13CA0182.namprd13.prod.outlook.com (2603:10b6:a03:2c3::7)
 by CH3PR12MB8355.namprd12.prod.outlook.com (2603:10b6:610:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 22:20:07 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::2b) by SJ0PR13CA0182.outlook.office365.com
 (2603:10b6:a03:2c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Tue,
 3 Jun 2025 22:20:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 22:20:07 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 17:20:05 -0500
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
Subject: [PATCH v4 6/7] dax/hmem: Save the DAX HMEM platform device pointer
Date: Tue, 3 Jun 2025 22:19:48 +0000
Message-ID: <20250603221949.53272-7-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CH3PR12MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 138b1f30-b838-4124-ce63-08dda2eccc16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fGcF9T5phHIkDhsNueCzrfsMgMcZzwMbuTOxtrsoKD+/xY/iLG9ngLyPjpdH?=
 =?us-ascii?Q?UKD9/roJjG+mAHb2V9yh1Ldl8Jg7H5STz85fgTq55F55kafQgsCUXofHXYgA?=
 =?us-ascii?Q?r2CqCB7d/leU2BD2x4i3ipObva2mamhXjQ/sX10jmC0I1ke3o+zIXcMblFhL?=
 =?us-ascii?Q?AqccJ3sqWsx8Ct3SobnMcxeIXPSUaiPU7V1CRGsfJMReEP9i0R5oZ49lm6GQ?=
 =?us-ascii?Q?8x6vPiaF9Qh90cFvTm/29zuTpmV5yN3GaOk2764ohneMmo3WE7XRppEqqJrh?=
 =?us-ascii?Q?wHKo7b9cePlQcCj8WtxvVYIMlXYXGmp/KX6q0jL11QeDzm6B03ImSJUwQijd?=
 =?us-ascii?Q?M31KqP+FS1a0Zn1nDBPLikSEiHblLIsEa5zsHaPT2g5AIcS8KAG90xoGKD2z?=
 =?us-ascii?Q?kCSYNRRg08ginyZQ2lcrRtDImSK+kBs/6oi9I3PK2VPQBcWpg4BFGDXNNsWe?=
 =?us-ascii?Q?bYYL1Cpa0TcyidpKmMIVsNxeYBsLXRwkROUXL0PNDgFZq+m+0nYIKB9h6L0y?=
 =?us-ascii?Q?l+uMe1GprL0AO+CLPPtf/0OOCN7xceWYYtPYPsvc7Tmvh2xBS98Ba+A0qYWb?=
 =?us-ascii?Q?iEyAqFrMhClprKoE0euJe4CYmu6uhurqOjbvMLTsEXegvVB40xQDlywA2xTA?=
 =?us-ascii?Q?ASyHd4XxkhxwI4D46ZzhEpkfUZxej6A4PVihBc02T/IWJXvf8K/WAmgIgVit?=
 =?us-ascii?Q?tUo3y7S347MCBWEd163GaKCP5AULVbhujd8lDybDXL0DycbxPEMWeztI3FOj?=
 =?us-ascii?Q?kgEqw8ouqmyTW6gnpxy1k9xcmCRtKa7ZkN+gznKQLP3ufpBdVZ5y64qXRni6?=
 =?us-ascii?Q?xLyaa0/p9RBAIJYEIHvMlIFuibVJrVOB4dfEZKapYLtdWBg8esLrC2wEUQw7?=
 =?us-ascii?Q?8D+mESbws36VY5W59V4C4LMIRfbybFWruluuq8ahQg0OwuRz0wzJIS9lpxLA?=
 =?us-ascii?Q?GU2zjY4PeKnSlRiLeHNzseQjVuaRXgDBdk6LUPQ9ICJ9Ji/x4THXtv1eUm0p?=
 =?us-ascii?Q?9FNejMQCjd8D2NzHDZlT2jrW+VHhupTu/nWIkF1nmAaXxDYnwxBmo2kJJoJd?=
 =?us-ascii?Q?kYuHQtzVn1WkMTXfgTEVkwfwmNvLlonq/tLo370JJaHPSuRC519w/faik2Es?=
 =?us-ascii?Q?rUlDgeM3w5/hLJOI6muXvUKuFUkmgNXZA4QZhC6+9q814yM9VAOore8ehhAC?=
 =?us-ascii?Q?Drf/5pCxXrLvO2i1qbJQ4jow03Pw/4L6C9BAi7U0XMfvsoCprXG+X6nK2kJY?=
 =?us-ascii?Q?k+/nRFnSoBJCAKpkAnfw2tSabDyBi98JnL6vKdLwWlepWeMnkGkUgTk4XMAu?=
 =?us-ascii?Q?M3avCinry3M1NqFsZiBkhodQZGrteGWsz/gUu2J5uyv8PB3VRCuO09YVue58?=
 =?us-ascii?Q?COZ3kRomfkOKgqdWFR8uOZJirwwgwbFhTGVdt0OYgtbhJkB5535jVZOO0uWp?=
 =?us-ascii?Q?9DhmM8cf3N6q7hXid5bHu/gZqd459QA3eJyRh4WZiq1k7Xh3YhWWlZgrzJPH?=
 =?us-ascii?Q?APyTasadRPIoutNuH3M0uxu0CurpD9tRbKyJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 22:20:07.5506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 138b1f30-b838-4124-ce63-08dda2eccc16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8355

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


