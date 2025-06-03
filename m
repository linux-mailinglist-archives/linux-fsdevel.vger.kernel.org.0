Return-Path: <linux-fsdevel+bounces-50530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 095CCACCFD3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEEC07AA903
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 22:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD7D2594B4;
	Tue,  3 Jun 2025 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pz0SFe0s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D344B254AF2;
	Tue,  3 Jun 2025 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748989214; cv=fail; b=umq/DDFsB7RDhD6uWQScrjRqf552wEKpUQUpuQ8whyFQeOQKP62JJWjBY5ZEcAa/tvGjm2mByBAixWLmXnh0ZKPQAePQTqUQPHqlpQKQEpQqNpdpgrmqRPhh9FjxB1ewkbGJ/JWbyal5dhEPEf55P21yX1r8px6mxGOZSa1VAv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748989214; c=relaxed/simple;
	bh=rDHHnzjcg8QNC2DfMtIeARylqm5NU+anYI4Tk0iC1l4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wb7gycc0fwa5wXaNwnbTGTXFkpkNHRQ5id6zWtMWpqnztxUR2AN8q+HBRN7FDrqpDxp9igGeAm0mj4iJSTF4t7dECakpmXi6h/8jzZYYwlSZav9Af2LKH5PG2r5w/NPhovP99jtoS5jYcdAo/0tigcnJq8TU5VsI3uLcVRkUHtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pz0SFe0s; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkBM6sQawKDW876S5cQEM3hqs2dyt4UtB/fQEyFMzbchgAWUS1BQAvzoZeyoAnspcZrAlqUPN7HBU9kwu3InI0c6LMR8wkcn7Nl3gpSKEsk42Vt3A1jfVFUyNyL+JNWIOpknB9uPszKvftaULoUpC6a6kdao5M8tjN9+P9Iwh4kUsUrZ59t54UAQzXPF4nlS5n39kAz9zeVnzFSUPG1kGBYq0UefnlHF7kDlr5eIdoVGSxmlYOm90Ztm+2FoYtaubDOLrOotE0Vz4u0q6aKVrRTLEk84a6kyMNS0t57AvqOIfaq5bNt3rcP8PK5xGtyQ8xRtNY6TuDRDL6Ax9CnzEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PcE2eebWNzxSfkC0etFQADkyHVQDFR3v3Y7GKlOBYs=;
 b=LE4AwQA/3U8gEwkRx6C4uSKVmwtdj3QGeTu1evbnBjNBP8VaojjmpW/E6Lk9ya8m7SaOLLhzuZw3Kt5eHsGJ0CV+8BScLXa1gbPCAaGA3T7z6QonGpWPhFQKsMNka+QXLMkrk7WiFeG+4CzD0aKHPSVkObTmZ50GrYiyoxlOGB4GpY5rz3UDSOmd2LVg706Fqtrk01bklihf6DJcyWN1m8gNSb9xiKRcA3STTwcIGIQtPmKtu1DRHDFyUcAIPX6CbEXrM5z1Dgq7iUAAVP9NhTy5yBjLWxliQaLoqebdG1mbBaOTK4DLgS6MrgDd2N9VTQztXs8n795rpTwhtpsZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PcE2eebWNzxSfkC0etFQADkyHVQDFR3v3Y7GKlOBYs=;
 b=Pz0SFe0saSfgv1XwEesRAsS9bZo3x54YKdRkv4tjwj827lAGvaKOMvT0xPi+EDL86zrthF65Y+BwpttB9TjZObH3c2JwH4+XhAFpO6qprx4kxy1smv5zXpKX4TzPF6EXNvfEH066/w1dEeJ7cA8sWp2luWCgQPPty1PTU9dVEc8=
Received: from SJ0PR13CA0185.namprd13.prod.outlook.com (2603:10b6:a03:2c3::10)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 22:20:07 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::91) by SJ0PR13CA0185.outlook.office365.com
 (2603:10b6:a03:2c3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.17 via Frontend Transport; Tue,
 3 Jun 2025 22:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 22:20:06 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 17:20:04 -0500
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
Subject: [PATCH v4 5/7] cxl/region: Introduce SOFT RESERVED resource removal on region teardown
Date: Tue, 3 Jun 2025 22:19:47 +0000
Message-ID: <20250603221949.53272-6-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DS7PR12MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: fae3a523-9a3b-4c19-e9b3-08dda2eccb60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+mBf6GItE1wfrjsLpPH1hlLcUC4Dfp9AYnKmTUsJYgVCKTixAKif3SB3rIK6?=
 =?us-ascii?Q?VcaxCN3M5v3pNI6qHv43Fnrd7NmYuIM+1jR+OpRS6mzROgXywek40KhZmYI+?=
 =?us-ascii?Q?V367FiWKa42VuT9brtrNm2UubW4Bo4JvRlb7UU5MRlDhGrKD5NdHBQgYQqrb?=
 =?us-ascii?Q?bgTy4jNz1fWLM8/DTbjlEbt2RW7ii6J2fh/Zn8hnGRe4hweM51YDBXFCaAow?=
 =?us-ascii?Q?JZjXah/oj66GSO+d/SWsAZLCgAwMXO6dUaCEutDk06QBxFXiaukib3Y9jf7e?=
 =?us-ascii?Q?YYpec2Tx4JkA9CbWYHEpRzgoARCTmw8zjgryhedyyimZfAIXJKsFw/9yIO4h?=
 =?us-ascii?Q?IqgK6wD28W8k1kdz70RFIiUohcEY5cz5R0ITVSqNYT3xmWw/u5SYTWWViHMA?=
 =?us-ascii?Q?uE3pLdIltYbm/jNtWNQX8T4krCyECY4+PKXSEpzoKWiSnzwAfGz0y+5L79gQ?=
 =?us-ascii?Q?tsnfeLDxN8RA96+7MvLOUI+0UwY8J0vSZIgp95PvRbohcu3vAckn9040j5WI?=
 =?us-ascii?Q?I0QEt9REnQOJ0oxTAX9E35V6XNuYUiSFA//d8iKexbsRknhBtgp2XqMX54vN?=
 =?us-ascii?Q?tGGGXIllKkXACF2mXsTu0q1BHwtvoM5SKCtzFoJXIuflb/UkQRIEb+F74awN?=
 =?us-ascii?Q?0es6iLS6gDGHUWLAlInTrr7Vyrb6MjOUN/TbZ2qMVOx2vk1tID/gNLP4SVhR?=
 =?us-ascii?Q?f+nSInrHDwSLKjLaWeUA6XmWOWOqwBU1432kJCc0T4vLSRrP/Khq+JoxNfpL?=
 =?us-ascii?Q?6b+GKIoWoyBmscLKcYkRneYC/mmwpwLJpXx5yJRjqA4whJFkpZmyzpLQ3pAx?=
 =?us-ascii?Q?OjRUSmvG2Z/4lUCpEdWxZLsRyjsnXQdlVRcIo/xH9SpMdQfKtS0ftyyK2oS3?=
 =?us-ascii?Q?Q0Cs6hvdddO5d2kSElUe2KK8FitDxxrbPwdi52soeFc814t3G2w9B8i89Q/x?=
 =?us-ascii?Q?C3BcRwOPxOUVujr5zNGHUthggc2DM6KwZRSE8NMozuKD1Z0EODiBidEAn6Zw?=
 =?us-ascii?Q?jsMx/ZoY7XXiK+uLzJH0hBWcVF+h/xOsfJlQvtagaJZZIULj5o1ItUP66EV1?=
 =?us-ascii?Q?BSS7pYF0bn05mPkzYgYXkyI5xBerZ+wg5eXIrZAjEBMFvg6UY5HYte9t8kmW?=
 =?us-ascii?Q?g8zX4TWVLhMhAo5UkozEF6fbXshh8z+V8mwNlnFQNEiBf8HoCQB8J0zSwWwF?=
 =?us-ascii?Q?jmf8QyrrUbMPMR+q5/DLZadT5Id4+qMdUvd5la/76fU8Zg0jxpgEywjGpVp0?=
 =?us-ascii?Q?3ByLIhNnCGIvHiQAn25oFDKNPVHXgJnYICxZn99iXrf3txAoV24S65/E2k8w?=
 =?us-ascii?Q?0LArkwhH1//Xe2DGBT/EHrNM6gFJN+5ZUutFHUkIfGOwwePQmPR4BH5x2MoM?=
 =?us-ascii?Q?Q6tqtnx1xLqPf9DRqUD4aUoSwFcm8fXwII1YJzjeelpuOun996TU6qXs0ndh?=
 =?us-ascii?Q?NS709V91gqkvHPOQitOK07/oOfpINHHZVRoI8wzVxssLGAFtNnvR74s0HD2o?=
 =?us-ascii?Q?9bH1WfsK8pvg1KE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 22:20:06.3585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fae3a523-9a3b-4c19-e9b3-08dda2eccb60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719

Reworked from a patch by Alison Schofield <alison.schofield@intel.com>

Previously, when CXL regions were created through autodiscovery and their
resources overlapped with SOFT RESERVED ranges, the soft reserved resource
remained in place after region teardown. This left the HPA range
unavailable for reuse even after the region was destroyed.

Enhance the logic to reliably remove SOFT RESERVED resources associated
with a region, regardless of alignment or hierarchy in the iomem tree.

Link: https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
Co-developed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/acpi.c        |   2 +
 drivers/cxl/core/region.c | 151 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   5 ++
 3 files changed, 158 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 978f63b32b41..1b1388feb36d 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -823,6 +823,8 @@ static void cxl_softreserv_mem_work_fn(struct work_struct *work)
 	 * and cxl_mem drivers are loaded.
 	 */
 	wait_for_device_probe();
+
+	cxl_region_softreserv_update();
 }
 static DECLARE_WORK(cxl_sr_work, cxl_softreserv_mem_work_fn);
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 109b8a98c4c7..3a5ca44d65f3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3443,6 +3443,157 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
 
+static int add_soft_reserved(resource_size_t start, resource_size_t len,
+			     unsigned long flags)
+{
+	struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
+	int rc;
+
+	if (!res)
+		return -ENOMEM;
+
+	*res = DEFINE_RES_MEM_NAMED(start, len, "Soft Reserved");
+
+	res->desc = IORES_DESC_SOFT_RESERVED;
+	res->flags = flags;
+	rc = insert_resource(&iomem_resource, res);
+	if (rc) {
+		kfree(res);
+		return rc;
+	}
+
+	return 0;
+}
+
+static void remove_soft_reserved(struct cxl_region *cxlr, struct resource *soft,
+				 resource_size_t start, resource_size_t end)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	resource_size_t new_start, new_end;
+	int rc;
+
+	/* Prevent new usage while removing or adjusting the resource */
+	guard(mutex)(&cxlrd->range_lock);
+
+	/* Aligns at both resource start and end */
+	if (soft->start == start && soft->end == end)
+		goto remove;
+
+	/* Aligns at either resource start or end */
+	if (soft->start == start || soft->end == end) {
+		if (soft->start == start) {
+			new_start = end + 1;
+			new_end = soft->end;
+		} else {
+			new_start = soft->start;
+			new_end = start - 1;
+		}
+
+		rc = add_soft_reserved(new_start, new_end - new_start + 1,
+				       soft->flags);
+		if (rc)
+			dev_warn(&cxlr->dev, "cannot add new soft reserved resource at %pa\n",
+				 &new_start);
+
+		/* Remove the original Soft Reserved resource */
+		goto remove;
+	}
+
+	/*
+	 * No alignment. Attempt a 3-way split that removes the part of
+	 * the resource the region occupied, and then creates new soft
+	 * reserved resources for the leading and trailing addr space.
+	 */
+	new_start = soft->start;
+	new_end = soft->end;
+
+	rc = add_soft_reserved(new_start, start - new_start, soft->flags);
+	if (rc)
+		dev_warn(&cxlr->dev, "cannot add new soft reserved resource at %pa\n",
+			 &new_start);
+
+	rc = add_soft_reserved(end + 1, new_end - end, soft->flags);
+	if (rc)
+		dev_warn(&cxlr->dev, "cannot add new soft reserved resource at %pa + 1\n",
+			 &end);
+
+remove:
+	rc = remove_resource(soft);
+	if (rc)
+		dev_warn(&cxlr->dev, "cannot remove soft reserved resource %pr\n",
+			 soft);
+}
+
+/*
+ * normalize_resource
+ *
+ * The walk_iomem_res_desc() returns a copy of a resource, not a reference
+ * to the actual resource in the iomem_resource tree. As a result,
+ * __release_resource() which relies on pointer equality will fail.
+ *
+ * This helper walks the children of the resource's parent to find and
+ * return the original resource pointer that matches the given resource's
+ * start and end addresses.
+ *
+ * Return: Pointer to the matching original resource in iomem_resource, or
+ *         NULL if not found or invalid input.
+ */
+static struct resource *normalize_resource(struct resource *res)
+{
+	if (!res || !res->parent)
+		return NULL;
+
+	for (struct resource *res_iter = res->parent->child;
+	     res_iter != NULL; res_iter = res_iter->sibling) {
+		if ((res_iter->start == res->start) &&
+		    (res_iter->end == res->end))
+			return res_iter;
+	}
+
+	return NULL;
+}
+
+static int __cxl_region_softreserv_update(struct resource *soft,
+					  void *_cxlr)
+{
+	struct cxl_region *cxlr = _cxlr;
+	struct resource *res = cxlr->params.res;
+
+	/* Skip non-intersecting soft-reserved regions */
+	if (soft->end < res->start || soft->start > res->end)
+		return 0;
+
+	soft = normalize_resource(soft);
+	if (!soft)
+		return -EINVAL;
+
+	remove_soft_reserved(cxlr, soft, res->start, res->end);
+
+	return 0;
+}
+
+int cxl_region_softreserv_update(void)
+{
+	struct device *dev = NULL;
+
+	while ((dev = bus_find_next_device(&cxl_bus_type, dev))) {
+		struct device *put_dev __free(put_device) = dev;
+		struct cxl_region *cxlr;
+
+		if (!is_cxl_region(dev))
+			continue;
+
+		cxlr = to_cxl_region(dev);
+
+		walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
+				    IORESOURCE_MEM, 0, -1, cxlr,
+				    __cxl_region_softreserv_update);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_region_softreserv_update, "CXL");
+
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
 {
 	struct cxl_region_ref *iter;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1ba7d39c2991..fc39c4b24745 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -859,6 +859,7 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_port *root,
 		      struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
+int cxl_region_softreserv_update(void);
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
@@ -878,6 +879,10 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 {
 	return NULL;
 }
+static inline int cxl_region_softreserv_update(void)
+{
+	return 0;
+}
 static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
 					       u64 spa)
 {
-- 
2.17.1


