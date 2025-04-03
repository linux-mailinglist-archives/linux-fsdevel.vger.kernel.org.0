Return-Path: <linux-fsdevel+bounces-45682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A39F7A7A989
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D270189AC6A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF95F24CEE8;
	Thu,  3 Apr 2025 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kRxFS2CU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9B253333;
	Thu,  3 Apr 2025 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705244; cv=fail; b=P6W0JKxFkOGQlNS1WnBPGr7FP8CHzNRYOkfjh4dpN1jzNRz8gZ3d77iC/MQHvjP3WULDKFJf2kROUVAu5gX2iauKZ+Snz6/gnAw2kn2wSV0xPRRcHmeXn+uiWSktGcmzQ40eDDbxEg4xda8TpbwMZVSzvcj1rdagDeR4j+GjuyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705244; c=relaxed/simple;
	bh=/qnry4eeyZdPgksHohXH1VNB8FWzcPSaUS9VmrJINew=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUoX07sGpmqQO6x650u4khe6IartTuuBuku8iOPwcBmSO4btao7Z07PR1XDhlTr2LhGN0WNeYLtEIuiungkvLBU2T3+6HD0xz9747vh1erOE9X72f7P32EtrfWbAFoZP06uPlR93K6hAfrzxavGmYN/UgLH6/wxWKLL3+xiQvEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kRxFS2CU; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agMUnpk+1qIbP0xpuf8l4go1UC0Uqc56Ps5zmjTEWgL61JMLeSgoqXPK6Znwi7gm0SkQQ2RKbJ6tYl6HOrHNyPBwRWIw8aYuYs0hIddFpfa/Z0/GUfkLuGk0c1Rlbs7whi4ULeyqHKqzpu2NRxAIvl7LPLsKaIBYnSAzqkOMEKGmryic3OQHk+gL1bBdy//kbaextcbj7eAWhqCe0uunkrTcFtjSfyDLOCxkH+3hdmGw9x+53zMKl9MqUfnD9gokDOImdAkOFZ6UQe8pPFgqU3EgcOhDOYJ7JzZzfrQ3MG322Gw/LeSBnwbPHNv3+ZnieKNwxeLxL+9APYJd2eOtGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+8doWpGPDpi9+d+tVbEJhntGgQB8sRjpWP7OjYrTHQ=;
 b=oXE/+lfUZlq4DBz1uAuPrSOQWE+XS8fn/SwdqEPfcslV/cZp1ZwNmR5vgp27qXm/Tbwb4Dm0i820XxzYs2yAgMqZYIb/3uLTIuvqlVeiWjEFdmIf0p38K/YFE2SwKhv05hyfucGWeS1UTk8hUcEeBg/RP1/VaBBajzKlcyiGGFFUvj2qhOImAa0s2khgzfoVS1DBTvPQuZIIHipYkePSkzNkoHIPEHP3vEgvno4Hvc3+62sJmgXOwt/CHja0EdpjdkIpi1Q0I8qZwB21UazZ0CLlZ9z6rwBAwhH1AOmRAb1mJxV7dx29ujRgwHTzp6vUYGW8xUBPQKrdaAIA2HBsRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+8doWpGPDpi9+d+tVbEJhntGgQB8sRjpWP7OjYrTHQ=;
 b=kRxFS2CUVyYcFvk5V03r3urx1j9zLhMhC+mzM0ik7pqcDMzZtdWZ+14U2frDQgbEOVXytL/Dd1kXF9MWRKJ1+xt7v8FXYTiTaw2QLD72rKPrZJhc1H3FeBrg5dKt6jvznGVW74nVKJuppdWJTMp7v2fPqtQbH8G8FlKJqerR5e0=
Received: from MW4PR03CA0254.namprd03.prod.outlook.com (2603:10b6:303:b4::19)
 by SJ5PPF75EAF8F39.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::999) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.45; Thu, 3 Apr
 2025 18:33:58 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::2e) by MW4PR03CA0254.outlook.office365.com
 (2603:10b6:303:b4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Thu,
 3 Apr 2025 18:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Thu, 3 Apr 2025 18:33:57 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Apr
 2025 13:33:56 -0500
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
Subject: [PATCH v3 3/4] dax/mum: Save the dax mum platform device pointer
Date: Thu, 3 Apr 2025 13:33:14 -0500
Message-ID: <20250403183315.286710-4-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|SJ5PPF75EAF8F39:EE_
X-MS-Office365-Filtering-Correlation-Id: 896ba358-8e4b-491a-5c92-08dd72de18c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mEGuDp4lSsqIuimAvASJX3zi7+l6tYEWFexduSQSGeFjGOnFvcdQb6w8GaSK?=
 =?us-ascii?Q?b1bXdewdWHDgCGx7Zk/UuEafOoKt4f9MeBjrvo2nmx+IkQDZDCc8otzKR1m2?=
 =?us-ascii?Q?YohbqgEOY5vEt/D5Fnuz3W5AhkKopvDtiGFKKb0ZMROJ4jcdWU99A1F21vT8?=
 =?us-ascii?Q?6UHPf9fNhMN9VV8M4tRH0vnIVNLIm4Be6/WhkzquXCipNFTqXqPXFqU7GHyO?=
 =?us-ascii?Q?X0vXzr7D4rJjlJlgUpfY5KB2peMxWXzwSaTF9tdOtJNkuwVCg6/ZLfeWSW2L?=
 =?us-ascii?Q?5oza30vNw3APMmQj+1upi6Dn4fgYYcJxAzNopnAh73qfRLtS0+LWFl8QsJNI?=
 =?us-ascii?Q?AT53Cf/xAh09vRDA/Joa2VOnpH0kK/TkZrot80NY7nsAvdeF1TmzDfCmw+ok?=
 =?us-ascii?Q?CpyzvB373rFFhIaPGEatqpjOdt4dDb2HF2hvruugIQEDH/sYIbA4dea0UM0w?=
 =?us-ascii?Q?Rv1YSUaKZ9ZSLLpxqwEK3qXLw2zjYPcZNKPVm2l7HwVlYP7tuCTQCH5WaDow?=
 =?us-ascii?Q?hllqw2J5gq0GiVwYV3rFLGTnMqQyAjDev5fQNjALwwk33XAedUVLu9zuN1mU?=
 =?us-ascii?Q?vyOSGcW9jUyPmqd5S71OeT+KXt288zNKQbpfghIQUyuS6RXgV6MHB0ZG1+aj?=
 =?us-ascii?Q?obhGwqTVgrZe69mfNfiWJns2couDh1nG4SNobWybrUsCH0Vz/d2kavYGfjKy?=
 =?us-ascii?Q?Me2KaL1tu9BBdLPK7quy1iYrgswPknO1cB3lnuDV2BH7/BPD9dGG/lSEv4dj?=
 =?us-ascii?Q?nOlnztI+zjTamRBphzD1TFPDmr09Vih8T1nG6UY34hzEc7ZhZ0KNbyPtfcfQ?=
 =?us-ascii?Q?9Jg3wAtzXrWPiQFJI0Z11nQFbdRiX+Jf6qaJ/GF27wIUvbuVXTp3JK5SkeVX?=
 =?us-ascii?Q?XFobaOKfWpyL0XOq/URlyuU7oHI/cAlZhr3pPwP051XA8cNHeQdqF16PtYdi?=
 =?us-ascii?Q?V9/GLCphyFgAsCTU0xpo0L3lKtpWngI5N+T+NmGzyKMqy1Me0J1XhNPTpNbP?=
 =?us-ascii?Q?Y5BLtlzj8NV1f7Ps/cJhls4UW4XccgYOb6lS77uGUNAklMynnaxqo7b674f0?=
 =?us-ascii?Q?5kQsOHUpEdvXwnrW0vOoMoQtlhog9pA3lvC2uk0LhW3Bqjuav2aiolzbM1kD?=
 =?us-ascii?Q?FkujnfCs88MZe/QCLJea3Q6fBySV9+3gYEHfPPcdQxcR9sGQTv8EV8fPAMgj?=
 =?us-ascii?Q?M06QY2ju9ACFYan0WE1zUb8iQVm6iqC1Bfm638ET1AgKo04KHzrvagW9dPgW?=
 =?us-ascii?Q?2+fvBQkm95zqTjpmMgJBzPJR5HKNW2/2nS9KVBaDO5lrAUf2WXw6qfm+CBMK?=
 =?us-ascii?Q?5GQuzxLkGNX6ePWYf3bTig4bvtvDKGR+OvMBQ6N8JfJmXY44jgvAdDjHikgX?=
 =?us-ascii?Q?s2UbJtdH/9/YldxuAbGSx54trFP/wbPlp7qiJvfxYZV9ZxQDKUO3yImSQy9j?=
 =?us-ascii?Q?+55Rfu2VWmw9QlG2VB2kTGbUnkT1wegX6pOVSppU6EqMrM2OPzd7JQ6XPBWP?=
 =?us-ascii?Q?yf+LaiqD+dpfEzs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 18:33:57.8965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 896ba358-8e4b-491a-5c92-08dd72de18c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF75EAF8F39

From: Nathan Fontenot <nathan.fontenot@amd.com>

In order to handle registering hmem devices for SOFT RESERVE
resources after the dax hmem device initialization occurs
we need to save a reference to the dax hmem platform device
that will be used in a following patch.

Saving the platform device pointer also allows us to clean
up the walk_hmem_resources() routine to no require the
struct device argument.

There should be no functional changes.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
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
index df41a0017b31..4b4d16f94898 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -277,7 +277,6 @@ static inline void hmem_register_resource(int target_nid, struct resource *r)
 }
 #endif
 
-typedef int (*walk_hmem_fn)(struct device *dev, int target_nid,
-			    const struct resource *res);
-int walk_hmem_resources(struct device *dev, walk_hmem_fn fn);
+typedef int (*walk_hmem_fn)(int target_nid, const struct resource *res);
+int walk_hmem_resources(walk_hmem_fn fn);
 #endif
-- 
2.34.1


