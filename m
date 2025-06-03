Return-Path: <linux-fsdevel+bounces-50524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 516DCACCFBA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 313C57A8988
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 22:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A58725394B;
	Tue,  3 Jun 2025 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1/DHXfgc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0659B1474DA;
	Tue,  3 Jun 2025 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748989209; cv=fail; b=bucfRpzqybqWqHWu/L10srwqDNyUm67ElaJIclhAVny2TpBdmV8uuM6Tt2tjzaIMhYS1XUDAmmQzWDdye0VGKLZsl1GVOwLepGrxFRcfzQYSL9ua053ceQZUhxkfO6JLXv0lvP5EC7Iq8v29L0bwsjNzttqK3s3YZjScVCpv5jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748989209; c=relaxed/simple;
	bh=Tnf66geRnjUcZt+UWmwGE1IRvFPcqlwnDjs51DGy67E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9l6WhqC/RREGkt3ikugqIdZw2qKl9aMDgpFQ1lhUbudTFFsDeyBWHpYFEnMtJJv4sByRZHofYq3Hq0wuJRC7hPWQTTnlEErjsbCuB4HAQTd8q0HoEnIhMcklmtauNjbxl86O9BrlB+FnipALd8P3yB+GcloJD1jGOl8gsD1JOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1/DHXfgc; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoe6coLv4gHH6LxYLvc1s1MojBTfUdvHKeWwSUkVE7PrKwcVdP3CxRoB+TqyE4RM6xYFwvdBUNR160jMHzXK3/iJXWivkCucDYqtO3OS/mivCBvQl9Jh8YwITusv3yQMwRVO05/LCZANqGG1v929q1BN1Q9kRFT7BjKTxkN7kElVBSTkJAIfIw22TCLizai8OBuPeihpULy8Ds8L/Sc6r8LS5XCKdWvpfMjdf7y6DY9aY8AwYP0IUyj1y34O3noaxa5D8GqAAL6DK87g3daq2dpWDrjMqPLqWK6jPatQ37oSAjzwRl/XB77K4Ij8NGru4KlM3dKHiLC7VL7xq8exCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BM2jZaLcyBV7d9evKbwxRNEE7WAFzwxfV99WEiPEQew=;
 b=qPzriMWOheawo/VAkZazGOgyL1BFJAO72VuieZ1mLmUjyy+fWHyhCpgF5nBnQ0HhPYKdgW55/HTRFSsZ8dIvDtO0Pt14ONKlWbi8zJKZp3auTyV0XQhnMrV/3bmfIm9bvHkxOc6fEJwNNDbNsETQRFkvv5wVTDbsRLDFoYbccSHdVR2d3jRZHU8nI8Ps8/Nl9Wr2vxWESCYfb2RWOCrGJcX7x+Vd8J7NwSrc6aSsFzbSLX/dr5zqV5hqxPi/Y/SktLJIM2435G8wp9nLxSk9LiOG3VE8oKBMmTJiAsgYS5/D8UBTIVe7PHfAmDPWOPU8uxldPN7HUZI1bihbxRr5IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BM2jZaLcyBV7d9evKbwxRNEE7WAFzwxfV99WEiPEQew=;
 b=1/DHXfgcrVmzcuuo7S7FUPP/L8X8j/vpdnQssfZ+AdrzkQffwjFlnV9FMCIarL5yHXvipWaTr4QyfqQdVET+rYiXmqvwVembQJSFD7y7y6nK8fHe17wmBZBWu2UUHSKxXscV57GCdLmj9MeHhYby2r8i9rIK02Z7mxXSBsQMW68=
Received: from CY5PR04CA0012.namprd04.prod.outlook.com (2603:10b6:930:1e::11)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 22:20:04 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::2f) by CY5PR04CA0012.outlook.office365.com
 (2603:10b6:930:1e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.21 via Frontend Transport; Tue,
 3 Jun 2025 22:20:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 22:20:04 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 17:20:03 -0500
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
Subject: [PATCH v4 3/7] cxl/pci: Add pci_loaded tracking to mark PCI driver readiness
Date: Tue, 3 Jun 2025 22:19:45 +0000
Message-ID: <20250603221949.53272-4-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 128f61a1-4cb2-4843-dfe4-08dda2ecca77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o7sDmwrsRGixGPR5QausHBijSNpESwp7fCCmdM96W/mwo9QmqNDp17N9ii59?=
 =?us-ascii?Q?qs8umRLSaNhjgHf0NNsT9jAaQ48/+YWcLm2/zZ5o6dyKm37AFn4loRbVv0q3?=
 =?us-ascii?Q?YcWF5l8dpUsZf7U49IxZRMXVtYPRuXQ6nsSLcPSyGaJErpjuE5H0H/f7OAdU?=
 =?us-ascii?Q?tcn1Ppr7RlrhQF58ciWW49+cQJPDEuYULY0UZlwK+xcna++Dn3apXvDtqmnQ?=
 =?us-ascii?Q?VDddWfbjqgBtswZfXUkqwy5wwr9Isi1stX0f7I9120ZwI2ws9In4HRrjr0fs?=
 =?us-ascii?Q?K26yBnBS5D2/e6X7xUUyUfiBZ1EQp/xElD7Dd7gV/crWotF/bchAoScP/G58?=
 =?us-ascii?Q?5BDpRcRQIekrjggSoBjac5X/9JsX2cVtLb6H1MqTNoD1hjTZTuzJ3zjVBO0W?=
 =?us-ascii?Q?pD7X9zM8EPxyy/sPOgI8ROHZyDaPnSeoVdCF8IrH/7S/VyKR9OyOcSps4+Fq?=
 =?us-ascii?Q?PFgjXI69aer47esEsr8AHXDLKNCBCwfpVOFMXR0x1q5nIGUvxPVj7Y3QpnZZ?=
 =?us-ascii?Q?QfsNbMO5Iu9O8hM7Xw2UzEYvM2lvA4ad/Gmgf/I7NInyffs/MZUMAEYQ4nca?=
 =?us-ascii?Q?HPRE1RLUzGmjFpMt4723IsMipVZIrWrGX6vmyUloBFnj9x43SkwMU/AnXbIo?=
 =?us-ascii?Q?W6P2qFkY7hm1IRpg3jncT73VjAHaJ1b7DRKK63I5kN9V2dkKKYjoEc7LBtA3?=
 =?us-ascii?Q?wR88GWseKipb2+necWEUliQSliexF+J/F1VnA9EYNgZeh23+jEThlp7axnAQ?=
 =?us-ascii?Q?DW0Gj9sWdMHsGJhzVB0OaElzf96kth2kyqB/n8Iiz0CQ0iBiKodCXc4KKTZQ?=
 =?us-ascii?Q?7JZR6Y3Y2+cnrg/RFn5WD5R4Wl6j0uiz/gzyuXCL/S3OwkI4uLbnj2ChecXF?=
 =?us-ascii?Q?e80173CITI70uMwRNRkM5fi1MJxeuXmEg/e6iN64ZJGCoi30l3Rie9vBzQaz?=
 =?us-ascii?Q?04T6nKjNI5cUphXDmQpFKrHV+m3v9BbDqtYkqCF5uvOOw7gwujuNreOk5LuB?=
 =?us-ascii?Q?l3MZGeXp20nVreG3SJ5HtZnxN/avYv4XNEkWo1gioLET/GhDtEt3w/nrRDV9?=
 =?us-ascii?Q?11psz/we8veHLg0/Vek0jHdPyMIjdBJuMV5cDLyFmEez/PxznSDnF6/9hWrC?=
 =?us-ascii?Q?Bl4AQldaP7ojHksNlQXHQUo7tUSpDTGkd14uk5bwf8OrWvhM9b2SI7eNAg6m?=
 =?us-ascii?Q?bnwHyxiLJjUo9acIAe/OPikLjCkBOhUfPwNTuFxONqa/lUAk/UU6/lEw6K4f?=
 =?us-ascii?Q?WLEZCNu9Hp+D5sgko6l7pk9V81k9qEznaNUzhykxoqwN+zruIM5Erj4nacBj?=
 =?us-ascii?Q?+ql4CfTGlzG8i3RTGDIHK0zsidqnKgBfPRNtLDiINsWxLoiK0e0ftokzPRaK?=
 =?us-ascii?Q?9IOCCeVoZKRug66g5wfPwYLPYAQ+yeIlNUMjWdi+kv23Pn14OilUJ5dNRtVo?=
 =?us-ascii?Q?5pCT8z5QpaoRAhBLAnuMmJgaomFRv9pJpZWXgJgjmA35vljLXAH8r4qV68/t?=
 =?us-ascii?Q?LjMqD9PmbCLjtsyRV7fhxYgOkVeAGgHTLtsT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 22:20:04.8251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 128f61a1-4cb2-4843-dfe4-08dda2ecca77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407

Introduce a pci_loaded flag similar to mem_active, and define
mark_cxl_pci_loaded() to indicate when the PCI driver has initialized.

This will be used by other CXL components, such as cxl_acpi and the soft
reserved resource handling logic, to coordinate initialization and ensure
that dependent operations proceed only after both cxl_pci and cxl_mem
drivers are ready.

Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/core/suspend.c | 8 ++++++++
 drivers/cxl/cxlpci.h       | 1 +
 drivers/cxl/pci.c          | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/drivers/cxl/core/suspend.c b/drivers/cxl/core/suspend.c
index 5ba4b4de0e33..72818a2c8ec8 100644
--- a/drivers/cxl/core/suspend.c
+++ b/drivers/cxl/core/suspend.c
@@ -3,8 +3,10 @@
 #include <linux/atomic.h>
 #include <linux/export.h>
 #include "cxlmem.h"
+#include "cxlpci.h"
 
 static atomic_t mem_active;
+static atomic_t pci_loaded;
 
 bool cxl_mem_active(void)
 {
@@ -25,3 +27,9 @@ void cxl_mem_active_dec(void)
 	atomic_dec(&mem_active);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_active_dec, "CXL");
+
+void mark_cxl_pci_loaded(void)
+{
+	atomic_inc(&pci_loaded);
+}
+EXPORT_SYMBOL_NS_GPL(mark_cxl_pci_loaded, "CXL");
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 54e219b0049e..5a811ac63fcf 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -135,4 +135,5 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+void mark_cxl_pci_loaded(void);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 785aa2af5eaa..b019bd324dba 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1189,6 +1189,8 @@ static int __init cxl_pci_driver_init(void)
 	if (rc)
 		pci_unregister_driver(&cxl_pci_driver);
 
+	mark_cxl_pci_loaded();
+
 	return rc;
 }
 
-- 
2.17.1


