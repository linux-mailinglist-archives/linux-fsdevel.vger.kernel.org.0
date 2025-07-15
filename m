Return-Path: <linux-fsdevel+bounces-55011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC479B0658B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373BD3B603F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E14A29B799;
	Tue, 15 Jul 2025 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hFnn2OFa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107BF299AB3;
	Tue, 15 Jul 2025 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752602673; cv=fail; b=WgX9bW0PCxRhbzUqky74U2eJav5OYy51MF85XRgublRC2/eUJUij9qdwcyzAZyI+KJUEZhBHfdzcDzV8T9KbH3+4qL3/LNobg2NjnTgr8sg1sR6B9RKf+zIuOdM+2rlymXWBhfVo83Mo1gGloxGMQXA4tCoAN3ZtWVizImTYLq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752602673; c=relaxed/simple;
	bh=tT1dXhB9yY2Z+P0RQNxzfnRgt8D/I7yDzhyXyJRfm4M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mieEUTK3Dn+rMHChGyVH1eUOOwaa/S4uegbFL+UPtXD5W4tv+UHCghvZRmmVgmzuCSnN9wEgd2hg9ZlJbaivhj0p9c9/IT1lxyBtTklJrx8RHYxFPZg1mJcRl4Kqt8fs5Ex6JpDb6ffR8LhO3gr3kL4rVVTE3H1CeNlRRi/fS3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hFnn2OFa; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDyL/idn5Lvik91KHosKuXT0091Y+rjgJfGNP6lvUnpSV/0UUTBuEw9uRFBBa/mwf0ZmjwE48BT5lLOaaRl2eqgPjpd4YeS74DK+ACIqQ4nxF76BBY8MCjPJvYzaqouyEkyB+pqPbpcNOjAi4b4BZAdrgwxCkqhIPRukOKNWqHarJerUCOlAIr+n/wVpRWK3YqSs/TlZ9hGI4sozOoJtWPlTyQGGeRJyLK5I6vIdQI8da9WUqX7beAgSsqkG7uVQ/FcRpngiwsaf6KyaNqKZGOzBoUcnhBs7eqtteEuCGrDK4mgxtOJs0oJz0SAjg42zx2fUlu69KHymCdORvtlEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjDSqg6fSX2JA+g/uTYt7OPCuo06uidLe6//XkxdMuA=;
 b=jIg5Js52p49kMq9NnkiSB3Pz7lZzC4YdzOa6tSqFxINxvSx/JhstT0Gc6KmMI3jU+cWQ+YfQpBan0cVKRuHWOzo8QvvErKIVtQST3EB4Lq2ik9sMADBISzhDzgSyuISTrBK6oOD8kybTwwbsmvBaagnX0ds1vM5/sJfOGc7PcmYDmmdMHWtYobkephAf790MIwd7FKXmDd1d0PLISvDAsC1VRkMkjOvBJIIHD5prTWbUB+XUgrsAcGywThmVYrXuuBocVaXd0AksE2aumIaUqKC9FKQGWfegaeyiziVLFWKSTZwlx0NtPKc9c/ueni0zlEhGM+7KaqRO2DLI775+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjDSqg6fSX2JA+g/uTYt7OPCuo06uidLe6//XkxdMuA=;
 b=hFnn2OFawGUDp86fYPoRfkFAHn3Oz16NbKUxyjxMQc9LcUNjakemK4/Y/hOX/SinzgRG50I3jh/tRc2G5KeW30yNKj/+tJ5J1dqKVl66ArdCGJAZ9a6sxmrU/1fHzzgGEIsBn6Rgqz1eIiyfMvRCufN/6oJ4g8ZH7JfB25zna8A=
Received: from BY3PR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:217::31)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 18:04:28 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::6d) by BY3PR04CA0026.outlook.office365.com
 (2603:10b6:a03:217::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 18:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 18:04:27 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 13:04:25 -0500
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
Subject: [PATCH v5 1/7] cxl/acpi: Refactor cxl_acpi_probe() to always schedule fallback DAX registration
Date: Tue, 15 Jul 2025 18:04:01 +0000
Message-ID: <20250715180407.47426-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|SA0PR12MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: efa62404-7dbe-4fd7-6554-08ddc3ca09e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bQCWiBXDd7BrOWzDL8BRNyTuSv9w7T6T//ZCi5xWMgtoZFYX7aAp99DY60zz?=
 =?us-ascii?Q?aj5DH1JR00j5EqcG/KIY0kxygPByQbrULtFD+4T+lXeY+TNOBd0dx5zzblHo?=
 =?us-ascii?Q?12wJtSc0SFBAPyiFpG/t6FgMswyGTq8lvlS3nokX3j0o8QBSDy8gZHN9vMfK?=
 =?us-ascii?Q?owkUzESJ254GnUmB0fuh2FfqkasgSW/F1NSOqhiUlc5+/mKGnPgEWyYY4jzo?=
 =?us-ascii?Q?BBlFUmlVzvBUxtPws+FAATdKRd7dJOennn/2bPMrMorLwUwu9Bkoqp28ploY?=
 =?us-ascii?Q?LQ+bcZfQ1SDi1uKUS5uv9BVz94wnPWiSLR0mqncBhoGw+kVyiYyh0sZ7LAT7?=
 =?us-ascii?Q?0pNpmUzd0yqQPVQ26IWdKh8M45B5kVc3d2FW7ooyqc68UMOgJj/QpVjKSerX?=
 =?us-ascii?Q?cbfY3vCvwlDPfZpI3s9cY08HBn6M5h359TiK7hPL1sRnyTY001EFb1Rvw0Ug?=
 =?us-ascii?Q?BdCskUAL6mAiM7VPqnAIypBqKRoi/+Y2mtO1XWfekuJeNbB64gsf2G7IwQmr?=
 =?us-ascii?Q?npSTG1RmBCRkuI0gCzfgz77V31RoBsenOHWCDTUUFVxjWAXWGTqNe1gXP/lE?=
 =?us-ascii?Q?HrCyeEQimVSNnr0uTxXyVz5e/5D4KppTqjegiHeFaZjgOqjFp09R4TllxdCn?=
 =?us-ascii?Q?djQlds8fcXiDYdj+Dpp647zuYzEtoZd5fKDTn327wkcov50UPsaNQ6TKP/ak?=
 =?us-ascii?Q?wyVayW74kE50VDtT2/voSpLQynSESFZTbKS+/2xXMHGvNH49zqRAqSwEEaQU?=
 =?us-ascii?Q?sfP8DAHdLJD5+3jhcJG1AWRkoqJazzUOFUyII8bkC0rAidTeJ1cdJa1gx3cK?=
 =?us-ascii?Q?W+AITn8FUHxFBLXZ/EdbtECI7vbdeAeul5gKdrkH5/D9DJLuPJQa+DF8Vd8G?=
 =?us-ascii?Q?yFbZ8afA2/8IDe4BCA3+InuisMpL7CXS/clTFA6d6NxwOkcpNz0tLPDnn3+3?=
 =?us-ascii?Q?uCLbbUklI22Ge1Jl5fU+e49DoFpff3I1p9LD/aw1I96EtTOVaC65fsJWpQ+B?=
 =?us-ascii?Q?JzFsiIO63bLNYMBxykOAgdZSv/6ngm3PMi78BuAd9k7slMsEpw1eXHFpQut3?=
 =?us-ascii?Q?AjePIx7nCc9TMmx13XuAti74Y/vYgWqon8LiewKM+bjXp6dQgHPmf2C39726?=
 =?us-ascii?Q?W1tBFkKtgWwmkjHwL0LqPCfPJoK8a68Gd02b2cECjzDWTm3XQHRBzbQ6AyA8?=
 =?us-ascii?Q?UcRDTDuu0IrknarjIpal0PK34pqaTsZ5eVp9KSEbCEYu/YuiWJ1aV3w2DBBz?=
 =?us-ascii?Q?C9Ya9WJDiwoF4hw2zlUc8fs8o335f2cK6HDCIubPstmzBELeT0FCg/ULwgNU?=
 =?us-ascii?Q?1RQUOok/9ijDEjDwSijsaGmkHOOtxRIzg4o1xKhyPQFg7/RVFDojKkQXKWhB?=
 =?us-ascii?Q?c63Ds65C2TWZ0L95J+zpCCghA+DNJpEpF2/NT+TGTSRwzhtk31/UtHDMJZnm?=
 =?us-ascii?Q?yYTOocqayEuSQ0ljyrCzieyPf11WP5cHZ2HkGJ6YRgYBYbq5a6oSgkM5MdxA?=
 =?us-ascii?Q?49gKomSMNFbYBmje2o2pVeJt13VyAVZLRIQZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 18:04:27.1869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efa62404-7dbe-4fd7-6554-08ddc3ca09e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384

Refactor cxl_acpi_probe() to use a single exit path so that the fallback
DAX registration can be scheduled regardless of probe success or failure.

With CONFIG_CXL_ACPI enabled, future patches will bypass DAX device
registration via the HMAT and hmem drivers. To avoid missing DAX
registration for SOFT RESERVED regions, the fallback path must be
triggered regardless of probe outcome.

No functional changes.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/acpi.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index a1a99ec3f12c..ca06d5acdf8f 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -825,7 +825,7 @@ static int pair_cxl_resource(struct device *dev, void *data)
 
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
-	int rc;
+	int rc = 0;
 	struct resource *cxl_res;
 	struct cxl_root *cxl_root;
 	struct cxl_port *root_port;
@@ -837,7 +837,7 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	rc = devm_add_action_or_reset(&pdev->dev, cxl_acpi_lock_reset_class,
 				      &pdev->dev);
 	if (rc)
-		return rc;
+		goto out;
 
 	cxl_res = devm_kzalloc(host, sizeof(*cxl_res), GFP_KERNEL);
 	if (!cxl_res)
@@ -848,18 +848,20 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	cxl_res->flags = IORESOURCE_MEM;
 
 	cxl_root = devm_cxl_add_root(host, &acpi_root_ops);
-	if (IS_ERR(cxl_root))
-		return PTR_ERR(cxl_root);
+	if (IS_ERR(cxl_root)) {
+		rc = PTR_ERR(cxl_root);
+		goto out;
+	}
 	root_port = &cxl_root->port;
 
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
 			      add_host_bridge_dport);
 	if (rc < 0)
-		return rc;
+		goto out;
 
 	rc = devm_add_action_or_reset(host, remove_cxl_resources, cxl_res);
 	if (rc)
-		return rc;
+		goto out;
 
 	ctx = (struct cxl_cfmws_context) {
 		.dev = host,
@@ -867,12 +869,14 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 		.cxl_res = cxl_res,
 	};
 	rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, cxl_parse_cfmws, &ctx);
-	if (rc < 0)
-		return -ENXIO;
+	if (rc < 0) {
+		rc = -ENXIO;
+		goto out;
+	}
 
 	rc = add_cxl_resources(cxl_res);
 	if (rc)
-		return rc;
+		goto out;
 
 	/*
 	 * Populate the root decoders with their related iomem resource,
@@ -887,17 +891,19 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
 			      add_host_bridge_uport);
 	if (rc < 0)
-		return rc;
+		goto out;
 
 	if (IS_ENABLED(CONFIG_CXL_PMEM))
 		rc = device_for_each_child(&root_port->dev, root_port,
 					   add_root_nvdimm_bridge);
 	if (rc < 0)
-		return rc;
+		goto out;
 
 	/* In case PCI is scanned before ACPI re-trigger memdev attach */
 	cxl_bus_rescan();
-	return 0;
+
+out:
+	return rc;
 }
 
 static const struct acpi_device_id cxl_acpi_ids[] = {
-- 
2.17.1


