Return-Path: <linux-fsdevel+bounces-63083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1E3BAB6A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA2E44E0EC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 04:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373A8274641;
	Tue, 30 Sep 2025 04:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NIwA0pmu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010024.outbound.protection.outlook.com [52.101.193.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E83826FDA8;
	Tue, 30 Sep 2025 04:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759207702; cv=fail; b=nYVSVXawnABrRu0gxbB1KTSyLdw/lHYWMgZg/idqXTfKLqFtSP6D5jCjkjVxuG65rvGyhloKqzWNx4P9OjRhrkZLPC9BTXxQNf2aVycp08EhuD/R8I4wdWdQQtEfdUPbGXHz6vskQOcJIe0PyruH5QOKzLEAUcCSqfMu9f0Z6X0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759207702; c=relaxed/simple;
	bh=S85JyUpTQ4sDButVjrL3Lnh7uMgOK3RHtGJyMboZ4K0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/UJZRQSzVndJa3ZuoOIfz5IhWCokp9aKJ/EM9L41fnXrQn3Znj9/VVwBF5fJz1pxQFexj04I4oSSpePFvbNnvH0vwEeW0su14zcvNwiOkrR6zhIIugrnkyyshDcbiBUcylJltidmCC+it8YnNTbj/+Gq57IvXY/MHPOmbIybuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NIwA0pmu; arc=fail smtp.client-ip=52.101.193.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOEfj0hqAmABuWyEZU+oJxq3/EEp5zwWgklAtEZrcRDzWfw1QyItMzYhQoBxWUZ589lkpn9fbXM0efJJDm/lxcMOohE3Z0rxUc+lPi4u6zNCAnmTSX/hAfh4q6UScPE6dYkf2l8EEB89cpz4PEk6dF4AxrV1PbGgbUzPl8v8DYDOI/An5b2J6DyBxbAWGooAKB1XuT8lhSebjqtancY9L8o8L2JalwyNFnnj6lce7XWOke6w30JXOswYWmpe2gH1JlgJ1Z5k0rUZABoW4Ewo6qmsKdBS95Wb9D5NJNmFhvFpc70Cse0IWy2RntB1bsa8ANy94jf4ureIh7T7pvz6Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma5oSCysClIIkYhBFPHuIimjgX3X/PLd/CYMk3UjMg8=;
 b=u7EBNS7rVse6sEv/o7qMjpHMF8Xd1lD7puOnAu5kL9zWZjojx16N+bPFjtnhc+K50BtXTWPYx31CwhS6iFDbA7gAxLkyxiAaJDojoINu6hyREvMUGMqspASL1czAeoU9Iu12SoW9eTu5BgkEji3vTz27VG4EobnZzfKyTT36FyEkPenD107kJmczRpxbfv1kemh9I0S8dnty8KLukz6VFXnqRmaaea/vrFbBL5mJeBuAk4fGO+axHq3IjRwBrFMBCtjE5icGB6e+EnkKI36SLonCZj254FpTyDDGZwsEl58CktutX0XrP2r1t1/ylMwrlJ38v851JKe3rlEVTeiFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma5oSCysClIIkYhBFPHuIimjgX3X/PLd/CYMk3UjMg8=;
 b=NIwA0pmu++hPX6KLso4S3gMhL1qec+SNVgsqLIg4kx/5kyFLvaIDNfYzxCneeuhAmwr1M6mlYfuUhRzXLd+ZOIFnFs12yFUXu6JhgjLkjyXwg1qBPREfiivA4sOGi7QnfdO4rnudhvGMeuz1x6JxZ9QxNJC1ZZyep2hY9hr5i3o=
Received: from BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::7)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 04:48:14 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::9a) by BY1P220CA0020.outlook.office365.com
 (2603:10b6:a03:5c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 04:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 04:48:14 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 21:48:11 -0700
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
Subject: [PATCH v3 5/5] dax/hmem: Reintroduce Soft Reserved ranges back into the iomem tree
Date: Tue, 30 Sep 2025 04:47:57 +0000
Message-ID: <20250930044757.214798-6-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ec1a3c-d40a-4a44-06dc-08ddffdc90d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5QzqA9lTHUEWpt97DIpSh7YvnbmuBm6EJRJJO4Z4lqXljHpuRObGRvLEESH0?=
 =?us-ascii?Q?JN5R2KHFmgzrZi6RqfFG6NJWEqO8epQkzBQwzt6PqqOLdN9QSarzeNOS7d6f?=
 =?us-ascii?Q?GGe26J8wz//eStLvqB6NzU4NiJXath8mW/Y8V20M6AZObvwtuisi5Phkgl2Y?=
 =?us-ascii?Q?IKJnNTtDZ5RdnDBvCo1dJfvjHw77V4P7PapkAGN3vjKZWHKzTs3rawkcotVm?=
 =?us-ascii?Q?1EOWXl1kth9ALqk9aP1GMROagxj73qdH1dVN1VU3IteImD6Eb224EASagiVJ?=
 =?us-ascii?Q?Nj6kGKpi0qrN9ooQd3/l6CKtTgj3gguX5Wyh9HzRuUrVN5KAHXJFbgWJvvZJ?=
 =?us-ascii?Q?cf1sMDC2HNI7JjLsxFj3jt2wVCQGhdhf69XF8KgPZZk/On+mxzcFWjvlP7L3?=
 =?us-ascii?Q?AQs++YxmK5gwU4fVaqJcPr558mXfyetgc+lNtYat/Y0AvlBjqlRqGtwCUP6A?=
 =?us-ascii?Q?Jd0SC03MspDK9+7NYe/c76dVBJ4/YbjakzUai2mQitWLJwIpZnRK5gdwV206?=
 =?us-ascii?Q?HwAulSRlb0TVc8IvfmWMVbcJgwDENnKhXzmxmwEp96cpQ3wwyq1LNPTEnVuC?=
 =?us-ascii?Q?G73D4PA7GtlMaY4ZSVll9IdAdXtzgOLqvv+z5Szgb4dryl2Ql6HK5JNlXTVt?=
 =?us-ascii?Q?8CMK34W/byRx5FHAE0smDEo3i0EZ1JvulYdILI+pOkxrXZw7Q68H+pUd2k7b?=
 =?us-ascii?Q?MXREzBHDOrey6g9Q+0//jsZhqXBg+YY/Tpx3zC9PDTv9tXRS3RawmraNIh4r?=
 =?us-ascii?Q?gaRnnHwJkbVuSMXe9gAeKIXSRGRfFUFMUznucHIPl4DPxkniZRNl+CaS/id8?=
 =?us-ascii?Q?TmvrJIcA9/sPdFzHm1d3VxWvHIT8vXV+J4d7gaAdYGdABs7UawornxXDd4Xk?=
 =?us-ascii?Q?bnHUQWmR3oXvkqhl1o3IN8wDkkO9Pp8CStSXw3rPO2MCETBFNqtRRC/olVdw?=
 =?us-ascii?Q?ixHsaWfb6Cmmum+9oHHCs57AFh9JHNFncOBgrHed8uMZ3CO/Gy4YDneT4C2h?=
 =?us-ascii?Q?ofduHuwEYohWcJ+qHPWIUjrOaXLgTCJ+LUkRotV/+S4T+lIL1i5Qu+9B/YMc?=
 =?us-ascii?Q?Cv5+6m8tdRrd7tYXSS6TrGL9luybSFf65nsKOPeH796Kaa/sOlxb/f9E5tYW?=
 =?us-ascii?Q?qpRfAYsTq0wMFQSKiBcfso7btpU/TdYD7D2K1HWfhVd2zwHGHe2S6C9VPytS?=
 =?us-ascii?Q?GSWWPtE3b7kfgpFKCkaaVVvgN+huwJT9ncrWtvgo1SgCZ6/3UNbFBkOstEO1?=
 =?us-ascii?Q?HI4NqBXj10lMuayh586tEqbHeQZ696JcrRqp0kYBkgNK9HVw9YeUGl+mWuNQ?=
 =?us-ascii?Q?xVJcybQRzHMNpYBAaMQErlyVCRx4sdqpFc+lUJiREu2JbnDVnby1RKFln+W9?=
 =?us-ascii?Q?ZE1iIS0IrCX6PL4sKrq/08vpKxOA/GE8g2OyaGY+6XoiT+AMFWN3vNkF7pCC?=
 =?us-ascii?Q?B1x/qQ18J/AbtJo8NwIX/OczkkhQnvWdhaDY3gkyKovlsmzO7xQX+m+qPP7M?=
 =?us-ascii?Q?g9oQv5SNdCaT/NyxVHGGiOV+dU8hMjvnEBpv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:48:14.3595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ec1a3c-d40a-4a44-06dc-08ddffdc90d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319

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


