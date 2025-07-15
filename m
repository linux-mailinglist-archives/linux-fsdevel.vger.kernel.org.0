Return-Path: <linux-fsdevel+bounces-55017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F21B065A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A624A8268
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096C52BE7B7;
	Tue, 15 Jul 2025 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="twJVUQ7L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E9C2BE630;
	Tue, 15 Jul 2025 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752602681; cv=fail; b=hjjtjCRZNRrqcH9mWYfDJpcIYaV2z0OdJuzmRQnBo3TMnlmBK52Z/FWEnYn1HuqCQKiDKbV6oFkfqVaRHy2GuIsAHMg4kMNcULlG2FSRazUTxkECBee88HDS8JR7TVvX3bjCv0Z+ftzur2LHjl00p0ntFixQyWuMrF2Y2ZMDE3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752602681; c=relaxed/simple;
	bh=CnCOih+6DG6cc7LLPNYs4TsTogEbv/xz8U4CS7ba0q0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRARNStVNsHawlkWSzP5pYo5STdLISCQbXpydUwGq9NGq38dRkCfCJEpowo9Va/V6XKJTO/Ojmk880N1ePKTFs0o2XQzthvqFCd5hrG6J7C2HCXS53hrIW+wzRW8PuJVqXyivQ4b9iatpZsl6vFBE2MxjcNenn2T6ozarndAnRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=twJVUQ7L; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VltTdtmoyRL40oxx6lLFcUaoSN0dIvT/t34d1SZATGzQ4fq+3DD6GPMO3IDGYFCi84nWwikcnHBcIyrSMqyG5RPTVBbf/88zoQkq4kH0Jo6CU5IL45+HafVF8dOjde8rOh5sIUuMiGj6YeHaPVdnXCO9d8ocqyuqv/e+YUIhmXdkQr9UjRWIYQRfUQRC+YBREXAtGlx6JON9XFMPgIVLYLF0KwL5Gq7aTPymkXUqxmHzoflDZDZeWdoG7z/SBlO5bYv9qZXSuF5gB1PaqiV6pDzxl/AR9h9FBbYAuZZUGkwfEQHnr6m87IrlWXOPIyUhwvoOf43vDUTa58ttzKPqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6+VvgOWtMjk4Y0Q9TcpPy0GcOXf4NZ8T3smecIRPZg=;
 b=RggIlQ1HDL3IDhSsD/Ywc2cQlPhUp08IoVJO2sNuorJKI+MN/bSscQrvX6j9JZoTgE4cHgr/Bmxz+D1zcJsgomkXhepqq265xSM3um1p4eHh1kvzOULct26gW6sOn1Y5tT9svt9ltcZIJbpHtn8d/wn3Yhd6EMarigc5pgrxprIPWZu8SVqBFawzBSmS7SH9UL1ZYhZxZmQYJkNv93NvxZrxZqfaJI2MbfFv6DOXYmrzJuCbnWoStNOVCnqLdwF674v1ImlKV8DxBDtjcm3tat33LesTWT1oLqSfVf4nVuvKc55M3OShZMt+4XwdMnKXgHV+yiLRq69nzCNEco83jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6+VvgOWtMjk4Y0Q9TcpPy0GcOXf4NZ8T3smecIRPZg=;
 b=twJVUQ7LLPGD0z4jV1sV2ojA1NFLg7vYVs8NO/JVEcStSiaUgmR9HacGp0+giSRQ5Q0IS1Ov27Xx9vA0CoVEzOpL48TKu8vgE8W8emMzunktdEZH/v4K/S2Z6hZsXura6QlV5/2Z/rKJy5JixhgTvieuYdBVCwbG+p8unoCTaUs=
Received: from BY3PR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:217::19)
 by DM4PR12MB7766.namprd12.prod.outlook.com (2603:10b6:8:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 18:04:37 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::36) by BY3PR04CA0014.outlook.office365.com
 (2603:10b6:a03:217::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 18:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 18:04:37 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 13:04:31 -0500
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
Subject: [PATCH v5 7/7] dax/hmem: Preserve fallback SOFT RESERVED regions if DAX HMEM loads late
Date: Tue, 15 Jul 2025 18:04:07 +0000
Message-ID: <20250715180407.47426-8-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DM4PR12MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fae8456-d4d0-43e4-6ae4-08ddc3ca0fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1+OLS+w25xnx1ozt0pjA/srbemWhaWb6fTqtW+jC53w+0HqWi1BAvldHlbIa?=
 =?us-ascii?Q?eSTDA+OkfhRmRZ4DXQLwpYh67mfzM1+nTLypIXfhceLmxMTLc6TXICejjGUF?=
 =?us-ascii?Q?dmzh/+v3vNKcIxOHUyJbR6/6K7w2vg3JUJyt4cpspLaSCFV7o0arRIgIu5VF?=
 =?us-ascii?Q?gOwKkwBnZZGcorAhiAxenWFffUg/dRAoXbLSLbLkn52hguZK4Hy5EIkYca+G?=
 =?us-ascii?Q?8n0mZGH3m6Tqb7VrMNDg/ZSgUsiwSKk+EHjF6pnsr7pycqatz3e/+AWM7Hud?=
 =?us-ascii?Q?zxo+fc4S515f10/N2/k2S/SY7/YUSzTxAb8iuXvJD8uFCkPZ4WKYvTIbSP88?=
 =?us-ascii?Q?FXeyd0KOlEadHsFERFIctm2M+ux2nRLN5nfAvbqvfodmBMFcq8dfS1V248gq?=
 =?us-ascii?Q?hKUjgB42VftfUvxto6imyCAncdPWDHn0SduTp6zqFwz9vZp8VBWg/6DrEdEf?=
 =?us-ascii?Q?BpmbvHk5CI9bFntZagbpQVo3A6Rl0xD7MBzGGwFccWfifp1UQZ89Up26gwkQ?=
 =?us-ascii?Q?O7G/sPEABIUQsTqKAEjeSIzIUcBZkwRLGQprLhQqRj1J8lTY5sA687MxdyYi?=
 =?us-ascii?Q?aTqd/1BoZ7q8peTmNwuuqXwNYadoQ1+1gvmy4b9mn2vIZopjyzfspB44+UI4?=
 =?us-ascii?Q?PnmbcWTataQSmGd65R/FUi3OwNnHUOhHx55vkz67QCbtodffzTodAPI/iYN1?=
 =?us-ascii?Q?bTmojKGhTtzbp8pciNolSiyUPAdSH8+/ssJbiZR5ESGbHnPK0MHPt29Va7Oh?=
 =?us-ascii?Q?6uqa9fHFA9a0TRN7tiRE2kWO4sEeca7JN2xyBSuHV6B2o44e4sH5bT8sNGcT?=
 =?us-ascii?Q?7TvZpyIsQBVHr9VP2bna1PzDRBbMO7H2RiE061pgvXk9HUbitu/2zv6MxBGy?=
 =?us-ascii?Q?8MX3Zn71d4T3w0OmZiGXPtdNFSfX9mUQ5Tu7tm9wbJMEPvv1/AXMTa3J+4FZ?=
 =?us-ascii?Q?cYSxAEUPmQGWxHq1RboMVguZ0fJxJz6aw4ErfRD9Hh7gszXsEp4N3brzUb4h?=
 =?us-ascii?Q?DimunDPkA5TFr/WT4yiPjyJ317Gy5yCKqNO00o76GYR5Zf4+lVRa2serbjh8?=
 =?us-ascii?Q?2DSxX0ND70bjJJM94l+AB+6MB0WNdhoeABtCwHIR/3nSEgerZ4duRl+Jr6F8?=
 =?us-ascii?Q?awkxPGF/mXYU3lx02ArGo6Pwfb3lKWJw7AfbKMG1RwiZk1x/OiXsrMwU1B5W?=
 =?us-ascii?Q?K5ERek0mJIrT+8FZ1LwpGR29NyUNo/lQXr9mLL5T3tvtGCr9JETBubjRslrD?=
 =?us-ascii?Q?eAEhAqQg5x2zmGJTk2mPVBrvy7JsOWnyzcFnmQogqkNH3NRl2SU/HGjxAOks?=
 =?us-ascii?Q?vweE5HvJqdxDK2yqGusOcFtKgzKqZBtmqaCJFdd/S8hB845evWipdpydHBLU?=
 =?us-ascii?Q?C8Hmuo02d3Q4VLyteVnNMAXEdwOS8QjkBOmEkuLMq2j03N50i6JvaSgcAAX1?=
 =?us-ascii?Q?5evQ4hqS7c6FEtjR/Z+zbBcqskElg7Gl+iEHswW5y+bRUVp1P4wlxJGgfPLR?=
 =?us-ascii?Q?vv5Mc07pPUQzn973OYxsGkSUKXF28eV8pQ+a?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 18:04:37.1719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fae8456-d4d0-43e4-6ae4-08ddc3ca0fd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7766

After CXL completes trimming SOFT RESERVED ranges that intersect with CXL
regions, it invokes hmem_fallback_register_device() to register any
leftover ranges. If this occurs before the DAX HMEM driver has
initialized, the call becomes a no-op and those resources are lost.

To prevent this, store fallback-registered resources in a separate
deferred tree (hmem_deferred_active). When the DAX HMEM driver is
initialized, it walks this deferred list to properly register DAX
devices.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/dax/hmem/device.c      | 17 +++++++++++++----
 drivers/dax/hmem/hmem.c        |  1 -
 drivers/dax/hmem/hmem_notify.c |  2 ++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
index cc1ed7bbdb1a..41c5886a30d1 100644
--- a/drivers/dax/hmem/device.c
+++ b/drivers/dax/hmem/device.c
@@ -16,13 +16,21 @@ static struct resource hmem_active = {
 	.flags = IORESOURCE_MEM,
 };
 
+static struct resource hmem_deferred_active = {
+	.name = "Deferred HMEM devices",
+	.start = 0,
+	.end = -1,
+	.flags = IORESOURCE_MEM,
+};
+static struct resource *hmem_resource_root = &hmem_active;
+
 int walk_hmem_resources(walk_hmem_fn fn)
 {
 	struct resource *res;
 	int rc = 0;
 
 	mutex_lock(&hmem_resource_lock);
-	for (res = hmem_active.child; res; res = res->sibling) {
+	for (res = hmem_resource_root->child; res; res = res->sibling) {
 		rc = fn((int) res->desc, res);
 		if (rc)
 			break;
@@ -36,8 +44,8 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
 {
 	struct resource *new;
 
-	new = __request_region(&hmem_active, res->start, resource_size(res), "",
-			       0);
+	new = __request_region(hmem_resource_root, res->start,
+			       resource_size(res), "", 0);
 	if (!new) {
 		pr_debug("hmem range %pr already active\n", res);
 		return;
@@ -72,7 +80,8 @@ static __init int hmem_init(void)
 		walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
 				    IORESOURCE_MEM, 0, -1, NULL,
 				    hmem_register_one);
-	}
+	} else
+		hmem_resource_root = &hmem_deferred_active;
 
 	pdev = platform_device_alloc("hmem_platform", 0);
 	if (!pdev) {
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 16873ae0a53b..76a381c274a8 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -131,7 +131,6 @@ static int dax_hmem_platform_probe(struct platform_device *pdev)
 
 	if (IS_ENABLED(CONFIG_CXL_ACPI)) {
 		hmem_register_fallback_handler(hmem_register_device);
-		return 0;
 	}
 
 	return walk_hmem_resources(hmem_register_device);
diff --git a/drivers/dax/hmem/hmem_notify.c b/drivers/dax/hmem/hmem_notify.c
index 1b366ffbda66..6c276c5bd51d 100644
--- a/drivers/dax/hmem/hmem_notify.c
+++ b/drivers/dax/hmem/hmem_notify.c
@@ -23,5 +23,7 @@ void hmem_fallback_register_device(int target_nid, const struct resource *res)
 
 	if (hmem_fn)
 		hmem_fn(target_nid, res);
+	else
+		hmem_register_resource(target_nid, (struct resource *)res);
 }
 EXPORT_SYMBOL_GPL(hmem_fallback_register_device);
-- 
2.17.1


