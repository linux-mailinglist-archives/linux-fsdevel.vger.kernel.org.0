Return-Path: <linux-fsdevel+bounces-69179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D91C71F66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 04:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69EDE350D80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 03:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535932FB0BD;
	Thu, 20 Nov 2025 03:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2ByYWbiL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1680B267B15;
	Thu, 20 Nov 2025 03:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608784; cv=fail; b=lJTx6/XD0dTv8egIpfloh94qX7x/GXTxaWHoF7CDtr63GrMJfMueLtPkDrb2nNahT0WmmwawCg4qY8qPtnFFdWNKX+WAFrRYXk/fJxcbU+lCX0j752t70PdrUzBlu/fnf7ABeiX5K+/8/8ykcTTsxoCciZtX1u+e1JoqC4A216s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608784; c=relaxed/simple;
	bh=zSUmrcNK/tdj4iy+xmK3dSDwUEb1skXyA4YbC1f35uk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdzdLSxf7ElU5B9prnXjNIy2gPS3TZ3HpEeBJjq+O1/sIfawDhRYZ5R/nWb5voyG2HiJrJ0q3TO5TLFvVAsYwqffNAEnH90Q4Fw/lci5ir2Mwwxuo5+/HWYDsTmLLFiMWGcA1zprStJe1qQeXn3LS3SzkDiVmTwJOHukFRwIOTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2ByYWbiL; arc=fail smtp.client-ip=52.101.48.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v22qPtZq5MC/HvLJeT8hdEdA+PaMVhwjvxvlD1s87fmcHqQfMAgcGEFDb9GHgVrfjQp7Bp4t8IL3myfP5Uh400kpKH8qNz9c8SRNFO8aYxw8z36Iv4Dd0swJPRVrF4NCv9NpYhJpLwR2S400/KBou6Kx6uWXbizyxlJAxqjfNFsueystSZ5aQvMQ2A+m9lFkYA+k0nbyYOmlR4Gc9rq8UZP8NkCVceKSpPJsgstbLkd2dUdPdhC5t9IHhdHWk9siAkpnBsUxRwlLdgsPe6WWgQhsaKLJXEj9ZX9rRwtiMXUwQmdnglvDJ9Ucp7tBhrlB2d9yFerREWpFcBXpJ7TfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXqZzl595Ao2lU1pbP0EkgtZQtr6RLzo9o4e95IumHU=;
 b=h0+3TvQ0geVObB2bpKUS3JcSqcXSuMmzVKqtDHGT6Nc2pAfwPsKZj3nf6ajDAuZ9Cb8uiHdLmtKIweq96XCa1E7C7oGoY5bwX4QR0VF73n3+CFRdjqgrj+AjxFl3Zw8qXhm03OTWY/VIFF8G9QCRpMVFqQR5UkVnZ6QYwz4M0QLppE3Q5+0CE1n/Bnt7NKHZzCPrw8F8QV6oMblWwNhrQQU8YhEuaX0B9D0sGkTPrj7kUxhx2vaorg3tASFe3MJu3KVuWC9+7f1kVRs3YhII0fU42N3udYA8CGBRYbNEkpprl5SigWm50HHhGBLGidp/+/dN8a3JhUA0KxDB2l/keQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXqZzl595Ao2lU1pbP0EkgtZQtr6RLzo9o4e95IumHU=;
 b=2ByYWbiLyZb6ht98gq32bB2O/3c88gr6IvbImpvDZvYhD4fAePRkCUg1YAuEWSarIsGl306WLxtWd7AjGXaCFOSSRE8uPNSiU2r60dZ24rQflL8hCxuce1cim8W/wmPfdKXVYdafsssdYRudz3LbGLql+Co184EE+ZyU/AxJYMA=
Received: from CH2PR14CA0048.namprd14.prod.outlook.com (2603:10b6:610:56::28)
 by SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Thu, 20 Nov
 2025 03:19:38 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::f0) by CH2PR14CA0048.outlook.office365.com
 (2603:10b6:610:56::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 03:19:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 03:19:38 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 19:19:37 -0800
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, Zhijian Li <lizhijian@fujitsu.com>, "Borislav
 Petkov" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 2/9] dax/hmem: Request cxl_acpi and cxl_pci before walking Soft Reserved ranges
Date: Thu, 20 Nov 2025 03:19:18 +0000
Message-ID: <20251120031925.87762-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SA1PR12MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b2b7a9-a5be-4acb-0c86-08de27e3a369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|30052699003|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vudv8M7FCpYtCYmWAkO18yPJHASZZ4fidW6CebdfrwsmUaBF465VsSOv6Vl/?=
 =?us-ascii?Q?AGjVriDN+OFGHfcmZ/3hafQaSOhzDcINu0d+c4oCtg84K91mOuUEJt1fNdKh?=
 =?us-ascii?Q?b8sOB6ENFSXMD3xBA72oWrnzMG7pTjUEw59f7iUJOPk9p9x2FO2m8A2Fiylx?=
 =?us-ascii?Q?MvnCPJ0WSP6vanvM21eraNHtdM95qpHO55XnspTi2PDXXXO833lIAsCattvW?=
 =?us-ascii?Q?jRZD1+sozL7MHB/LIcj48W8ofsexos7rlGE1e3I2p/TihoFnd3ZxzRpFCzH9?=
 =?us-ascii?Q?LG+UFsM7uzeI16/tovtcG6R9GVPcrpgx7BjCPcRjR98ZLHGah7ve6DpJEm8L?=
 =?us-ascii?Q?MqT5U30QrGYGRveAZc/CIcqe6jl/OKbXyEuLGVidiJobeql6ib8f4IdxbrRZ?=
 =?us-ascii?Q?DqqDU1C5taZWD6K9zqqgLYxhzMZQwmY66I80H3lw2vfGM4kynCZ2Dr4xOdzc?=
 =?us-ascii?Q?QlLj9DDKVMYRxAq4wQ8KHsnLjJ2kWcV2oRL3YBg0bJSDaz+Elwm8ZOEg1YkS?=
 =?us-ascii?Q?uq075Fvf3DSguAaGqpdpS12PBhPzhYRjNemcTT2TPU2HNsCArNVO+1YFVpcB?=
 =?us-ascii?Q?ZH7ENYf5C2wm/maWQzOrvIOY0nCGGT2DwM0+VkKHjpMfb/TxP7Z+6Wyp4MPe?=
 =?us-ascii?Q?f2YyZhKFWSg/qyTbaSIgwElc09FXAVgfECjAH+/0Sf1glPouApM7yEjcFE0Y?=
 =?us-ascii?Q?RvR/zJxOvDcdi4f8IzvUqHErouuWryAIisJtlYcVUDd9dUJJ30YH2eQlOdSL?=
 =?us-ascii?Q?HkfQvFMz0jPxflzVOCvQMf9sDBdzRRj4jhx01YregYrarp1i/USIvAwgu2+b?=
 =?us-ascii?Q?4oHItVcdiLK3PV64viyoWPJAyPlMt5UwpYy5f8NM1NOUt4iXkJMGXxp0ozLA?=
 =?us-ascii?Q?kEfut/WgxNA2FupzBPsxfDt+pGkuw/5bhkc5c+s6JS0GVaZq5tYj0tZ6Ry9F?=
 =?us-ascii?Q?jpEeVkghJA+fDLdPFoTAt0f49BX7HQ3O593WR5k7IW4qJvAdbBaPSnN+ju3A?=
 =?us-ascii?Q?jqRi8TBxpIUysKW39Lxp9ckF9jCXRxIGSZZmdxTEjUaWXvMW5OvzyRkSNqQP?=
 =?us-ascii?Q?80xoNbIvk+uTTymaZkogDrtYXzi1ICBnJO3AmDWCsNU8oZwPpmRR0BLed/lJ?=
 =?us-ascii?Q?RTbY69qeM1o47SKjoAMqZ/FJ+B8/A9cNbylJZ2PiGLDiBD8/okTHClHJQFR8?=
 =?us-ascii?Q?LqCHaQBAJHRnFT3+NIUwcNuFlDdVq5jIW6yVjOZSyw75eu4vLWIwvyMw6fUJ?=
 =?us-ascii?Q?nLEEd8i01kW/4lI6hh+MqcF9OZDwTh0ij71EphlafKiWoUFz8WsB4rBTJhMc?=
 =?us-ascii?Q?2E/9JotaxdVcgxqWN8dlzcRHY5c+/fjOIECSfEA1G7FJvqV1jyMarxS1Eahh?=
 =?us-ascii?Q?qcz04vHUw5TAOP9tnTTdpF0ZVXuqMNeYwtPGyeHqKiJD5es7e1QXN8OCp9oZ?=
 =?us-ascii?Q?5HGf4TGq3zwMZa4g2MYPJoyJuPsdK0FAUwSYD3L4g3DK1bs0eE54iLLHL9G2?=
 =?us-ascii?Q?BVoByIAbIvlQHAw5lQGw2JG3mjTydjLD4xlHi5+XSL8sXCJD9H8+CUgMbxhT?=
 =?us-ascii?Q?nuH4Fl/HZNFxmFSCP1Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(30052699003)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 03:19:38.5484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b2b7a9-a5be-4acb-0c86-08de27e3a369
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657

From: Dan Williams <dan.j.williams@intel.com>

Ensure cxl_acpi has published CXL Window resources before HMEM walks Soft
Reserved ranges.

Replace MODULE_SOFTDEP("pre: cxl_acpi") with an explicit, synchronous
request_module("cxl_acpi"). MODULE_SOFTDEP() only guarantees eventual
loading, it does not enforce that the dependency has finished init
before the current module runs. This can cause HMEM to start before
cxl_acpi has populated the resource tree, breaking detection of overlaps
between Soft Reserved and CXL Windows.

Also, request cxl_pci before HMEM walks Soft Reserved ranges. Unlike
cxl_acpi, cxl_pci attach is asynchronous and creates dependent devices
that trigger further module loads. Asynchronous probe flushing
(wait_for_device_probe()) is added later in the series in a deferred
context before HMEM makes ownership decisions for Soft Reserved ranges.

Add an additional explicit Kconfig ordering so that CXL_ACPI and CXL_PCI
must be initialized before DEV_DAX_HMEM. This prevents HMEM from consuming
Soft Reserved ranges before CXL drivers have had a chance to claim them.

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


