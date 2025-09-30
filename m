Return-Path: <linux-fsdevel+bounces-63077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA30BAB5D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371B8173B4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 04:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8F7272801;
	Tue, 30 Sep 2025 04:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j5cKPUWC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C7C26CE2B;
	Tue, 30 Sep 2025 04:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759206519; cv=fail; b=T1Czv0BwYxzqZbaoKwBGp/3Dhz6J50ZyKD0QMx3pZYEOjDPMgkbkHMvEI17CG9bCWzdqLu5aISnDdjf1v8hVEfogmfxC2v7oRS87Zut9iHDOcFQXL9PH/3QeDYtUbOZrXhBKv1jiGeaSdJTeacjq+QvajBJzPvWLCNNkxGsupuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759206519; c=relaxed/simple;
	bh=S85JyUpTQ4sDButVjrL3Lnh7uMgOK3RHtGJyMboZ4K0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuPQMVdOMpSRl82BKz/K4E23w+2VkXya1QZ/COVjqRv+Rmwe6pWEXqOGetTBxresiEHTtGj7mEzJLWdSrEsYhOKnCXJydBq3A3cik3OyE95O9YjwWSEnlWlklT4Popfg3f39kyABvZf07t3MQDhsgpKObF4HltyT6c6Z4nRBpyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j5cKPUWC; arc=fail smtp.client-ip=40.107.209.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUa7EXFYEkkarOmtyqeGy0Rt+zm9mLFlJZx1lEmx6CzFvaJUqiHFgddhGpjRiF5LFS8RcRepE6D4qCCVEQFew7LsKP3jwD4TLBwWuSEekQ51P8UnYk7mnFPGimnVGH0LY97OCvbp63ixB6LCVBc2oHHcjVSWHP+HFEP7GB/Qey1wFo9hbx8M7W5zerFtvxPYfR/x4e+mQYcJWUTUkyQQ/nYt+po3XukoE5gUSd3KpDo0r9gGIwuzuceF0k53z3G1j08FbmMQ0iRBFMRZesZwpYiqLlAQ7WS8mvEY+84ydAAUFNQbus1rQCBtRvF1kmjaRLrBkGR2xRCftlclnlK4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma5oSCysClIIkYhBFPHuIimjgX3X/PLd/CYMk3UjMg8=;
 b=dxbYszrmqDo4cCGBBcQo5+dNvGGQizprhGtPm/EgVC9o5TjR8WPNDUcqDiaHCq9mLVwL04UJ8cjtFz/VMclxBOvxRxlvhsYjMKspHwoLysymau5cHaKl0ZPCdP1BwAFL5RP/CpaqCAL8fkQlgQaLttCLphu+CR4vbCiUnP4z7itsKd6pErRWF6MCX38VYmIp7YQ/U7LKkLJGC0c45KB53OzQpNcmQjhtT54WRR7mB8FSY39Jy75F9uJWaybWUZbm91jHUdBNt+aVm2+9+UvoX4YAQLNVnG/CZRFmBvr09m0qvyVHQxt1ct7awXqD00Ih8o5b4devC6sJvP0v0KzgyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma5oSCysClIIkYhBFPHuIimjgX3X/PLd/CYMk3UjMg8=;
 b=j5cKPUWCiVxzDw5G1xC2LXTxkd6sz2FJWNZwYXTACrbhJdlwphyrkX5XgQNOftReN644SY45SW2FTLtTiSDTC6B4DatyiJ6fAOeQjM2dwCkqLdVgZDGIEzXbIXOLOO9x8Bi+1ebn7lhRCC2aCxE4PWWmaJN/9c0zv5t3avvq05A=
Received: from PH8PR02CA0004.namprd02.prod.outlook.com (2603:10b6:510:2d0::26)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 04:28:33 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::a0) by PH8PR02CA0004.outlook.office365.com
 (2603:10b6:510:2d0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Tue,
 30 Sep 2025 04:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 04:28:33 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 21:28:31 -0700
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
Subject: [PATCH v2 5/5] dax/hmem: Reintroduce Soft Reserved ranges back into the iomem tree
Date: Tue, 30 Sep 2025 04:28:14 +0000
Message-ID: <20250930042814.213912-6-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c11f2e-a27a-487f-e7c6-08ddffd9d0b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BMhv/C58fLyIYI4he7xntNUBpSE0uwJAmVMe3YkkZvIUr8tr7WPq+IeaACMN?=
 =?us-ascii?Q?UGHrcaFU3V0KnPGrMYYLcv0Pmdpo37X6dWafx+BmQVWeT7WmI/d+nJuqIaj4?=
 =?us-ascii?Q?sITm/8cn2Sdw+nRhznl8WpTUHviD8BLVjcPYLnLgVXvWOwV38T/hnWTXr/Ct?=
 =?us-ascii?Q?QyRK5WayY9SDgPvb4Cqr4fSWz8pTWVavrfS3ZajnBCezII0dwiSiFHDV5Re0?=
 =?us-ascii?Q?P9Shr7EYwyOZ7fqk2QvT1XlmG4YdR1aj+gnqB2AjlimoL01AxVTNH187NNiJ?=
 =?us-ascii?Q?h6JdU8rJiH1O3qssv5paCuff5nCILLyhw1XK/s2VFOeq2EJ/FOhh8sLkzK/Q?=
 =?us-ascii?Q?LVTV+GWstRW4Bf2CpxK/OMll0Rj4vWffPbQBIJb2jsEAcslJagJTO91DdnfU?=
 =?us-ascii?Q?LLQJkNqbgxyvNAGr97PcWpcEbNK0MrGa0OdbQRLEVIxW1ZFRRIQvDoy64xv1?=
 =?us-ascii?Q?x6MRTpKoLabk76LBaooiD4+wZcvk+Qz/VCSpfAIXSkAisQjpyimI3JAwq/vr?=
 =?us-ascii?Q?NvCVoDo3vdw8d7eG89x9Lg4OWHciJCf1541iNgsFnV2dwvZWuqTE6Ya7U8dm?=
 =?us-ascii?Q?r32C/xtCJz6z5DztwxImnsgKlecB2SgJUtsjpM9SVb68K3+/9qIhWee+rtR7?=
 =?us-ascii?Q?BSbEoAuWisyzC0wBWLjIkj/3Xe5Y+yQyjcLXphOxFAmFmLWP7ViLePncGzdW?=
 =?us-ascii?Q?yDufY2Fho/Z9wwnpkBu8gWX5bLIpQoAwiGMazj3qrNu0FYtCIDTqEEj92oij?=
 =?us-ascii?Q?CwKaNCehEYkjY8kYEzuPZPWR7fVDHhstezVAsLiCx3Cdf4TcdN9Orq2m4FPp?=
 =?us-ascii?Q?yYd0OjAJM7Y/MLcNA6LVJFJ80ImFs9aCC5cHYyfRYDVuTytd2Cp1F/LiJIoM?=
 =?us-ascii?Q?7+cWge7HNLQg73MWV8U5pckLKWzRZupy9M0NHvGOFqsZfCeSy2JzlYSx35oS?=
 =?us-ascii?Q?PMNGfRo0LfeOtXBq0OkxX/4l2qnmTWyE4b7nC4YLvE0s8RwYGR78kdwsDnVI?=
 =?us-ascii?Q?tshTvHTMZ3Vv2/f08oWZKG1hREZ6K5whyxjDofdniCKszuaPKSgf2JwobChL?=
 =?us-ascii?Q?xMynsyFrRSG8KqyKJK+jzRk69A9I6MKLoxuE8fEqm3LLXE24rymDScTgdAHx?=
 =?us-ascii?Q?wKcRuqHAfds4wPfVjI7FDG29zx5zh8dgHlkGhCiiO5hPKns87sTwdcS5Vbfn?=
 =?us-ascii?Q?tmv/IONBL95budYdVjhzosKi4rPKPnmGfWnVhKZTUFIEhMATOvbqIZR67QeK?=
 =?us-ascii?Q?O6UXV+SEqeSMylvt7aPwfg9UjJYEZ5LnUPe0IunfAmU9Z75sRMIu2XK13237?=
 =?us-ascii?Q?AUqSz0PvKjQWT4J5J8JfUhYEwoABauHy8FhLm3E1VkjM5R74RBk40hJB7agx?=
 =?us-ascii?Q?TjIDXK8fxirCohc7Zn1vv8Y6HqCuZ/iCvZa6s8zReCyzpH74G0mb21tc2l4Z?=
 =?us-ascii?Q?ASlipJ20ytzQ0sa5Rntf51v0pMpCW45jWGJ4wbq1vTBzfytGFK/QAIJ9cR2m?=
 =?us-ascii?Q?mJwd7XFKTuG48aHNAWT2KTjuqcLpNdjaYCNw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:28:33.0201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c11f2e-a27a-487f-e7c6-08ddffd9d0b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002

Reworked from a patch by Alison Schofield <alison.schofield@intel.com>

Reintroduce Soft Reserved range into the iomem_resource tree for dax_hmem
to consume.

This restores visibility in /proc/iomem for ranges actively in use, while
avoiding the early-boot conflicts that occurred when Soft Reserved was
published into iomem before CXL window and region discovery.

Link: https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
Co-developed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Co-developed-by: Zhijian Li <lizhijian@fujitsu.com>
Signed-off-by: Zhijian Li <lizhijian@fujitsu.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 drivers/dax/hmem/hmem.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 0498cb234c06..9dc6eb15c4d2 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -93,6 +93,34 @@ static void process_defer_work(struct work_struct *_work)
 	walk_hmem_resources(&pdev->dev, handle_deferred_cxl);
 }
 
+static void remove_soft_reserved(void *r)
+{
+	remove_resource(r);
+	kfree(r);
+}
+
+static int add_soft_reserve_into_iomem(struct device *host,
+				       const struct resource *res)
+{
+	struct resource *soft __free(kfree) =
+		kzalloc(sizeof(*soft), GFP_KERNEL);
+	int rc;
+
+	if (!soft)
+		return -ENOMEM;
+
+	*soft = DEFINE_RES_NAMED_DESC(res->start, (res->end - res->start + 1),
+				      "Soft Reserved", IORESOURCE_MEM,
+				      IORES_DESC_SOFT_RESERVED);
+
+	rc = insert_resource(&iomem_resource, soft);
+	if (rc)
+		return rc;
+
+	return devm_add_action_or_reset(host, remove_soft_reserved,
+					no_free_ptr(soft));
+}
+
 static int hmem_register_device(struct device *host, int target_nid,
 				const struct resource *res)
 {
@@ -125,7 +153,9 @@ static int hmem_register_device(struct device *host, int target_nid,
 	if (rc != REGION_INTERSECTS)
 		return 0;
 
-	/* TODO: Add Soft-Reserved memory back to iomem */
+	rc = add_soft_reserve_into_iomem(host, res);
+	if (rc)
+		return rc;
 
 	id = memregion_alloc(GFP_KERNEL);
 	if (id < 0) {
-- 
2.17.1


