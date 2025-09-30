Return-Path: <linux-fsdevel+bounces-63076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D9DBAB5C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42B81923C92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 04:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C359826F2BD;
	Tue, 30 Sep 2025 04:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZR4mIeru"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8333B265629;
	Tue, 30 Sep 2025 04:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759206518; cv=fail; b=rwcbZmxZwOQh2vUhnb1Rwmqt4A4/2HKwKMd281BkxIsVm0k4Q1GtaGqxAQLpiPShwvhtrvap1dOlxoowyz/GpGawi2Fdrg3SF64Tv2aq5FzrLIX6BOQSXku9/xQJxsu+r1Peng+/KPpfnV50ccFlkW0foHG5OPLPYlS8BqyA6dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759206518; c=relaxed/simple;
	bh=Akyx+E9FFitML5nDItZdCm4pXyPaKURXa8He06tS06k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLIgIVzPE0lql2xWNfazgkhfgJ9xciRJ6kafAuTHRsAAhBXbdbyN8uFo59mek0aiIBAum0vbRd2rbaKjQodiSVyStpM5pBpRjBDEinUqx72QfijE4DCycNIhf3Y4dzfm871tKIFoNx5uGzG4/isih0ap6BXCZp7UcYkZXdcaX5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZR4mIeru; arc=fail smtp.client-ip=52.101.193.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3SZ615M6ggK70B8yEuRhpPh8E8Osm6QtQ9wTW7cE4AssBWzK6YDlyBDFEfcgOAx5/uqQdcAo7jJTjRitjo0aH9z30n9X/zYH0XOei7I/qp+cZL1UGMupLxjvP2ew+RYNCvwSewoShOmwKEDlbxmxM86jw8SQE6LvEE1PWLX8aPCJ/As69R9LGZfqmN7s0tPAWtAy0uzdx6Z3OBmLPyWyzPzeV1Zg/b4DPRjO3Ejhd8eQ+NQs4DrOX61fcR/rH+cJqg+JNn9lsPteRYSWvE6Gl0x15WLXZMtTm77xDIUuuFDeEYNqZgQBHaQNx7MXwjT28GRj2z2Pm4dAeUHKCZc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cz8G5+2OZkdzzIEFEabswkg+VtvT+UVPhgSL7dl4lJw=;
 b=IiFdUNEAm+7WadBaoEbh7jrcocsRynLFmU9R2wszPXOtERLb22wbCQkCyO2gDdFJrTKwzKOVJrH06RKmHBzfV72OApHx1l7C6VepHcw9dV4dArGK017l46r7QI66eg0R7QwuIAhxHpWzhT9YAe+Fy9BUNGjvJonLeR4V6j3fjMpxYfuh1n3+I4Iy7Fc8dYz0j8rKaal3BhkJUo6PBPsd5N+tz4oE/iGUyV39LpN1JvuZ8KBM7yjUD3D9ZIdxOJjhuZEgGDXUyK+2VREp40H3tJYw37XlNoN6Nglc/IfkrxXYUnwNT6lXRj3yCQ/DV0yl+eSOFvwMf4HsnLMKgLfeLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz8G5+2OZkdzzIEFEabswkg+VtvT+UVPhgSL7dl4lJw=;
 b=ZR4mIeru263NU0EknCDBW1U+5ZAQm/d8hY9kBn4re9YGUiAwDrLU0Q6tiKBO75+9ZHNsKhPvswD+W/ropdkEVXWaziNHamUAkOGSwLiB1dRtPoGYuMNBryS0Ym6R7F0cmHGiUgG74U1jgB+gud7keVPJMPZFoLT/TZRTq6V2214=
Received: from DM6PR07CA0055.namprd07.prod.outlook.com (2603:10b6:5:74::32) by
 MN0PR12MB6173.namprd12.prod.outlook.com (2603:10b6:208:3c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Tue, 30 Sep
 2025 04:28:31 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:5:74:cafe::8c) by DM6PR07CA0055.outlook.office365.com
 (2603:10b6:5:74::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 04:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 04:28:31 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 21:28:29 -0700
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
Subject: [PATCH v2 3/5] dax/hmem: Use DEV_DAX_CXL instead of CXL_REGION for deferral
Date: Tue, 30 Sep 2025 04:28:12 +0000
Message-ID: <20250930042814.213912-4-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|MN0PR12MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fbc8e4e-5d80-4159-6837-08ddffd9cfaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d18ycVufuFK8XqIeWxrUnq3/Qt8fECnB0agt+ZAevKRunzibJfXDJ95UA5Zv?=
 =?us-ascii?Q?osuGf2D23sM9FCeLouJ81fEospzqBCQz+5XYt2QsHzC66nhTmmjUJBNGZneG?=
 =?us-ascii?Q?HvQfay7/wXzv5k1E22CFsHFEG8y5w2zFYHkSHfVjJK6M3aiTapybxkel+RYe?=
 =?us-ascii?Q?4TFmEV3pzOSgLRybs9xyy37b/blFCeUWc2yBPQ9SMEtmcIMVy9f3UWXD+wSB?=
 =?us-ascii?Q?LgLFsSqKnGdIV1wEhdLuxzkxSlpa9S03X5D01YyO65ACypqLqJ79uRF/j6la?=
 =?us-ascii?Q?obUgFhooh6rhM9tX3Z1SB63NdmXVeRHjot4MHrVPGd0ePiHfWEVUiycSZorr?=
 =?us-ascii?Q?/1C5qbgEH08/B59vl2pOIeb25vRnyEDUBteDVyk+8LlXoqLdsN1fOsVODZO8?=
 =?us-ascii?Q?UBohZB5fkGcEU6Thh/ahYxXtaYys2SeMKWqXjH3vH3AmKMvvqEwlZhx5xg0Y?=
 =?us-ascii?Q?AirsHtcvNFc/V3epCoiZHE6cGqFf6hFLz35dPAHDbMn6JXRZS5TW4LHL/87+?=
 =?us-ascii?Q?e/qCyT4RpIU/RmxevXrIkevP35sZC6ZIMbpwv+gqMk7ZLPWB+1zANv0pNG6m?=
 =?us-ascii?Q?YFApOe/bc/UzpDYaqV3QnW700/161bW0XkbUXrAX6NQDMCNzMWtL1Y1xLb6j?=
 =?us-ascii?Q?6v5sA+9GKlSKRyOZORdP+dS47Z1q8qB91oUAiB0RFAXSadqsx5WPx24VxT5v?=
 =?us-ascii?Q?Kknnnie4M+WKVoPpiJzouZt1T67UwysTxmyEfjmDyYR+IsxzFzFhAEJpytrJ?=
 =?us-ascii?Q?50ic6QYCglGTk0WKq/gu1EoSz7iGwaleBZlcIb550CgL44iz44inpDcxF1eg?=
 =?us-ascii?Q?ek7y8rEEA+JvEpZWEtTo1NATrZcy/Av2HPT40Yyx2NzPsmkZqAvx54Vi7QgP?=
 =?us-ascii?Q?6UZC+EPAwks+1K5bKpl8W4ZuLdfcpqirTA2xACu/EFxGup+2qXB49hB5F+5p?=
 =?us-ascii?Q?3SFM/p7m3ovwPz6/DCM19PxhStlv6rpgubFRu5+gs4Bck56DVcwsnoUD39Sl?=
 =?us-ascii?Q?cRFKFINJKqqBjnVTmhldhiUtjDIHIKIn0btsrlyyU/zsGj+7WPkil1fYioUG?=
 =?us-ascii?Q?EA1Sx+BuY83WPtNR3fU8/cmAj+VLFwZumnjFUY7Bf1k6AFm5DbxprWoXetxx?=
 =?us-ascii?Q?XqI/VAS3pr/L3L8P1H9L6acDUiTa0xKtepC1ZyEe3QufsIkzgDQnI4S5QFIq?=
 =?us-ascii?Q?Cko95Qz1c/qDSsFIGDzZL9eQmKPw8bsS46kPIIAqsl2qyASBidwHq3JecYet?=
 =?us-ascii?Q?KYm1qPSo5eakL2ZsDSsojJPrrxBn3putubuKKWFI3EbpdNzSC7WEdN+mcJTl?=
 =?us-ascii?Q?gg/iS6Sp8VFbMFGk9oq3luJrEPHgBveuAm8W5G6GPEdOZUJ0x0MDDhxfIJCf?=
 =?us-ascii?Q?iRNNCoB1oMpvdYthssA4HFNEs7cdzgXgoeYS5I1IMJ5K2bP+It978v6kA+qu?=
 =?us-ascii?Q?Shf3UG8M2hfL9ebKMIy8b9dGx0wyi+R+680Wvs6/j8L94hRZ5DdLN34g9nd2?=
 =?us-ascii?Q?2I/8GApVagYvVQMkKYfJpkCJfKunMkBZiNpCl6judhrGv0usZfD6pQg9ttwa?=
 =?us-ascii?Q?jvvIlCiaV7yH5DqdAeg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:28:31.3013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbc8e4e-5d80-4159-6837-08ddffd9cfaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6173

From: Dan Williams <dan.j.williams@intel.com>

From: Dan Williams <dan.j.williams@intel.com>

Replace IS_ENABLED(CONFIG_CXL_REGION) with IS_ENABLED(CONFIG_DEV_DAX_CXL)
so that dax_hmem only defers Soft Reserved ranges when CXL DAX support
is enabled. This makes the coordination between dax_hmem and the CXL
stack more precise and prevents deferral in unrelated CXL configurations.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/dax/hmem/hmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 02e79c7adf75..c2c110b194e5 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -66,7 +66,7 @@ static int hmem_register_device(struct device *host, int target_nid,
 	long id;
 	int rc;
 
-	if (IS_ENABLED(CONFIG_CXL_REGION) &&
+	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
 	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
 			      IORES_DESC_CXL) != REGION_DISJOINT) {
 		dev_dbg(host, "deferring range to CXL: %pr\n", res);
-- 
2.17.1


