Return-Path: <linux-fsdevel+bounces-63074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8687BBAB5A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFE416CBA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 04:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7440267F58;
	Tue, 30 Sep 2025 04:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J3wNqUq4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463123C4F9;
	Tue, 30 Sep 2025 04:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759206516; cv=fail; b=aPAdQ3aH3y5xa7LKbRmDLJPMRcPWh8Wcx+CyUjovVDuuYFW5920FdmOrXWXrdvkP+qdWC7vhLLWMae1GJeqyq+vhMNqYmctVhvzVxzoiMWWuHIMljsnocAaR8y1v+KvbzFbFDb9h3vo54rSdhfx/jrVso3MT6Opp82uvquB19go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759206516; c=relaxed/simple;
	bh=TFElCL618J0pky7OWXVNwyCQiPU7n7dgQ+wbiZBATIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0UxoODI/t7CKgfxKjBr7nh3tMWvSkey5FvVIcpOisRzitZM0r68P0pGlXnkJb4Xk0vDLXGDH9ev2PKP62W2+bg9jgausqv8vQ7/+nKikk8wsNK8AHkJ8nCVNuL3g0nx5Pk3g2htjlyi/jwP2chLt3LVrhTloPw8CLrghp9K3kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J3wNqUq4; arc=fail smtp.client-ip=52.101.52.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYI4j2/VXRNwMfInXmt02PKCkUSyxz6h+wD9V2BNhqvMxnG91jYdjegCcduaXjfs58cBoCO7jDzHTLXLgATAaqLKE7pFML18FRA+j+sjeFqddRzb9rbuVQIvsdyDbGP6OF6K4JDtGJsaj2EDKD4VzfZQoUa2qQBph1F8MFbMQrlpgA7IOZ+Js0kqXvBNV+SflNtnB83y0T3Ger17ijabsHoLiRON3GnN07TJ2jVKKsxm81h9hB8gmZ8y3ZOdk180W5aNIrlZMIzSXIrhIdLrEuwMm3Vj3DkhO8q/HhI4K+BHaifH1VMGJeTW8jzyaJDBHTJU0l3KY1lbJCo359fGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87EzanpVktAnA5nd5pdnTjXwC7lc12RygdbDQPZGCFI=;
 b=aoW9mf3qWgA5Y7CXBEhgssFpY5d+TiYIxj05CUT3K8EGdSyDQp7Zk+vxgapbVZj8r8wb4X73/djFSfLjcFap9zWl75Whbo7HPdPvlc2OMOtBqKzBm0uY6eFtJt8AYBiREmyaN8otf+OsQZoddSmmiz2DIIlqRIfo4kELCObXU2QMU0V2SJlBSTzYPWfv3hGjLU90q3Dw9io1s/JOKzAWEI7WgY6K2CclLK2XPlPj0UCB0f53ilJpMRA/TKTuKRFIhv3hp0Mdf6VI6u/A8i8h7bqhhnFWMfknjzR+9Y5ajRX8rh7iLVlNu9Tn/Y7wyCZtzbBWXrWXBUz757rHjkO+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87EzanpVktAnA5nd5pdnTjXwC7lc12RygdbDQPZGCFI=;
 b=J3wNqUq4nWUswf5EMFMZXIxvx/fvHm1lbwU0RGZKnEtO3sP10vQ8JDUiMfnCZVCSQUJdy1B7Ylp3PXWlNvsWSTkRWpDS94uFIv49VOhprcXtjdnHTkPk3cCzvLE0wPS2eMRZpG+gvzU77NopGuF/vdS+3hgsGIbNLR5EjfRl91E=
Received: from DM6PR07CA0063.namprd07.prod.outlook.com (2603:10b6:5:74::40) by
 MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 04:28:31 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:5:74:cafe::e1) by DM6PR07CA0063.outlook.office365.com
 (2603:10b6:5:74::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 04:28:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 04:28:30 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 21:28:28 -0700
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
Subject: [PATCH v2 2/5] dax/hmem: Request cxl_acpi and cxl_pci before walking Soft Reserved ranges
Date: Tue, 30 Sep 2025 04:28:11 +0000
Message-ID: <20250930042814.213912-3-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 873914d4-2035-4104-bb7d-08ddffd9cf14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|30052699003|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZoWoLrftHW0E1tru+SU8WC465ns4SAx3OsuIg8/YQlkrS5vhay6ILN8bM48q?=
 =?us-ascii?Q?bfNb88/eLeKk2cW+0MHqirsU+kKL8ugbeiZAUKjHkbvZdT7+6U8nkfjPN4nE?=
 =?us-ascii?Q?SS8BwOdpCeGcYB0F3O9Xj/8I8/2jYzh/ERPIkxcrzksyRIMefyxg4kt4+rlR?=
 =?us-ascii?Q?OmJ5p5jVDqcioexrnwyzfVaVuNWC7mJVIG9D6QeuH/CiprFEisOjOLz3GE0F?=
 =?us-ascii?Q?oRKv31Y2YKHnfhR6Bew61ZMfHlSeXwv1StS7EBDm/A0xVtbdJtOl1vaftO1s?=
 =?us-ascii?Q?7ys4jd02coYHdEqlY9jdYyM9nAlM3DH4w1+KR72cwRAIAkHThX3l8rVQrrnf?=
 =?us-ascii?Q?qJgqJd7zC2uCvpJXy0ZlBLKgEDkEvHY7uXuMxngM46DL2dDBV5bxCmwaT+I/?=
 =?us-ascii?Q?3h/sKo5GJ1lfQfcxvrL0aBta+CKp2PJrh9X6FSXrsfQNOOyjdJhEsfpVzOKI?=
 =?us-ascii?Q?ZUq0LRBqB3eITnmPgn6vTkpTZh0vZjfUaGe9QdZVJE3XH705UXhE7E5frmop?=
 =?us-ascii?Q?3BAgAyRAuWBHXdT5lkaC/qxBC4IGhtNqNb1dzVujyB13DQDkXdzBRSy8uIW0?=
 =?us-ascii?Q?hD9yqd+J/Xd8n+6U/dFwEXj+LD4XQCqmxSgBCbGlRnHsTeppMbMYjceoW4bY?=
 =?us-ascii?Q?noRdNyv6AQrwHclkOfAaoJH81/fJSARFLUtiND4Kks3HQJfNlaIenVn9x18K?=
 =?us-ascii?Q?03Of6DZ4znkCfq494x5PDV9bfPi8GLVnWWxGhTq/i6yzVfKWkmai3n035cZ5?=
 =?us-ascii?Q?4J1ockjAjmmhSBJx5XKEainWB1htsxX3LNd/ebAbpwRv80EiXgK5HWs6+hD9?=
 =?us-ascii?Q?WQcGbq58BIMTGw2Pwy0INp6xAQ25vRbpXEXj7LtyMsiVinpQL7fliG45/EyL?=
 =?us-ascii?Q?UCIZpy8aYMV8XgCmSNdsvrw8eem/ca1ZIq64NyAjpe89fI4076GXIrMw/yOm?=
 =?us-ascii?Q?WXqdP7q29T/WzikbEcDDfUXtLfnjl9hmux2NZj9w1CLHwjCji9CoYz9zfidW?=
 =?us-ascii?Q?81u/fKI9npC2746Nqqc5PmPveeliInrD3LzoaFAclV5dOYZ+g7eU9Rp9U2Lz?=
 =?us-ascii?Q?AfmowsLUss0+NpRYBPSYhbZoRdVjUZ6KgbUu4thRU35lgo/IIJTE7Ilk4M8h?=
 =?us-ascii?Q?Y/cn3H6OwEKoH3SR48k8NpyIfJ+QrvfXxc+7p58lYyQ9bpvRC2oBpe7xptWw?=
 =?us-ascii?Q?mcUwqVYMy//GnbeO9dRX02nCjW0vl45+04IxvB1fu5FH+UlZA/Vie9deDvGo?=
 =?us-ascii?Q?kLtf5Qtm9nOA7lcbt6XTsuOsW4RMW5bkabR5Mck0KhLvLMHnEXJMEfPygZzJ?=
 =?us-ascii?Q?/e1z9rfQ6L53HIgIFaG8OZznbwCFoq+3/DaAYu2z+orerezqKp8tuaiwbZr6?=
 =?us-ascii?Q?9rBM+E2QcRP8h1++e4DL/SccwPJ3nh6GRHycqKuBrC7hBujGFLsQvueYIev0?=
 =?us-ascii?Q?2Sm/58cd9sqReNjoread7v+jNr/MaK1T+zCL0zTZV7rnhdfviQJ/3u9hyfea?=
 =?us-ascii?Q?BU1PIv9otzyQrU4LjgdBuMKLjsF60++URlsnzQFNcTwlFZczXSmwdZgAuKQP?=
 =?us-ascii?Q?bB2x2CK52dkLQZqIqoA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(30052699003)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:28:30.3191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 873914d4-2035-4104-bb7d-08ddffd9cf14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440

From: Dan Williams <dan.j.williams@intel.com>

From: Dan Williams <dan.j.williams@intel.com>

Ensure that cxl_acpi has published CXL Window resources before dax_hmem
walks Soft Reserved ranges.

Replace MODULE_SOFTDEP("pre: cxl_acpi") with an explicit, synchronous
request_module("cxl_acpi"). MODULE_SOFTDEP() only guarantees eventual
loading, it does not enforce that the dependency has finished init
before the current module runs. This can cause dax_hmem to start before
cxl_acpi has populated the resource tree, breaking detection of overlaps
between Soft Reserved and CXL Windows.

Also, request cxl_pci before dax_hmem walks Soft Reserved ranges. Unlike
cxl_acpi, cxl_pci attach is asynchronous and creates dependent devices
that trigger further module loads. Asynchronous probe flushing
(wait_for_device_probe()) is added later in the series in a deferred
context before dax_hmem makes ownership decisions for Soft Reserved
ranges.

Add an additional explicit Kconfig ordering so that CXL_ACPI and CXL_PCI
must be initialized before DEV_DAX_HMEM. This prevents dax_hmem from
consuming Soft Reserved ranges before CXL drivers have had a chance to
claim them.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dax/Kconfig     |  2 ++
 drivers/dax/hmem/hmem.c | 17 ++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index d656e4c0eb84..3683bb3f2311 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -48,6 +48,8 @@ config DEV_DAX_CXL
 	tristate "CXL DAX: direct access to CXL RAM regions"
 	depends on CXL_BUS && CXL_REGION && DEV_DAX
 	default CXL_REGION && DEV_DAX
+	depends on CXL_ACPI >= DEV_DAX_HMEM
+	depends on CXL_PCI >= DEV_DAX_HMEM
 	help
 	  CXL RAM regions are either mapped by platform-firmware
 	  and published in the initial system-memory map as "System RAM", mapped
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 48f4642f4bb8..02e79c7adf75 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -141,6 +141,16 @@ static __init int dax_hmem_init(void)
 {
 	int rc;
 
+	/*
+	 * Ensure that cxl_acpi and cxl_pci have a chance to kick off
+	 * CXL topology discovery at least once before scanning the
+	 * iomem resource tree for IORES_DESC_CXL resources.
+	 */
+	if (IS_ENABLED(CONFIG_DEV_DAX_CXL)) {
+		request_module("cxl_acpi");
+		request_module("cxl_pci");
+	}
+
 	rc = platform_driver_register(&dax_hmem_platform_driver);
 	if (rc)
 		return rc;
@@ -161,13 +171,6 @@ static __exit void dax_hmem_exit(void)
 module_init(dax_hmem_init);
 module_exit(dax_hmem_exit);
 
-/* Allow for CXL to define its own dax regions */
-#if IS_ENABLED(CONFIG_CXL_REGION)
-#if IS_MODULE(CONFIG_CXL_ACPI)
-MODULE_SOFTDEP("pre: cxl_acpi");
-#endif
-#endif
-
 MODULE_ALIAS("platform:hmem*");
 MODULE_ALIAS("platform:hmem_platform*");
 MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");
-- 
2.17.1


