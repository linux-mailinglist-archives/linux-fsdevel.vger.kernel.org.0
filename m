Return-Path: <linux-fsdevel+bounces-45681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C7DA7A983
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10193B746D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0731B253B57;
	Thu,  3 Apr 2025 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y9lcFCy9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A780253333;
	Thu,  3 Apr 2025 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705232; cv=fail; b=ufBO3oCgZKEuPkgYZkebYe8E6Cye01mCk53IUgktCCdmcBUbKh2VKLuGHMqrh2bA9JZMeuUYK3D6qqkVjeRWCNIDd73F9oQxzG29RmVPwz9CYzMbXW/HX3f314x60fKQEfKagEoKuPSsdJ/kOfynFJD2aWp3eP51cPhNmOYNM4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705232; c=relaxed/simple;
	bh=7enGw8AteUg2sETSeRZeRLxvS7FbRpzXPKyfn4nbYAs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pskgt7Q5ZRSw6ngMlimTybcIod9K8K8c52b480roZZW+fUcRXRMoOgofh73TXGcMpSYUvYUNPu4uQih+S68Hj2/iBSAMUyu85bPiFwVOWYSsuAg8XFjbp647J7cWfOB8cl7BPxqtGyg0LwLLqGmHZ3htWDGhXVcitneOj3y+SZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y9lcFCy9; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFKq5PkOEJEe3jrnjZ3wVsaEZLXayDAkZnu3M93Vf9yytSa1WZLniEfLm0rbMHk44GARLzshEI62cFicEm0yRtne+RGZ0Le1siG8M5BsJ47a1GCn1qP3qRWT1f/5g53D8hPGyuRofWrJFfwquuUJDrlyzuY97bpYSaTTLQg2zsCDuM9c3Vp1dgk1ffCMDkgyJJXa5/q68ASpTkBIiOg41VDk9EvzD0y5PlpGoO5UvugaCAGSHmu0+WE/Eq2sOEPJfspnqYvcCI+wY2y9cSuReYIcOxYcaNuAUmH8VUM6hzhFK53T/0EmkkOuXH1FHNyTjKEd9DxO2GX6EFTE4uQWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iV3bDj45tW9zU77rgwTVWgJQ1onwWYeBqOk/WtcpY2U=;
 b=mL2IG4w3afbuvvDDnm2adlQ9HeOxcFBgqdLcl2SAdqhYFODCKs4cL5eevgV/4v67hJAcWMZ4mH/zE+PdtaT+9ik+b2JxCiyFL/NqadA+nH8fK36L/siW7TANXWoSlPHBGI+bUrJ3kxZTGftdPh5/w/99u29aQl0Waq+QHHSjGk4lbsviSoVDR2d8sjXDKrXFubUDoK+0+/qq0shWkbmBvIic2v4eIubf2uxtqcjk5/A5TnhNbItEtqNRkCM7wNUezjh5k3I6nPSEU4/wC4Q+M0DuD6edWwnDMIojGUX3fJ7PBahvi+NVrokMDRPA7sDvixyQfgupqa4DlWBMxMvP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iV3bDj45tW9zU77rgwTVWgJQ1onwWYeBqOk/WtcpY2U=;
 b=Y9lcFCy9MFyhCSdByOi2F0ZsJnZpqMJav8Q2wamfUCNPnd0u9h+/hypcxWt2Nrf44fWNCu5jOCqHGI5gAAJkO8jhpwW0ByjaHHy2QSHwRCC7+hRXIrDlxy1mfdGWuET0K5HI8XHzIS0SAR1+Nk1fJKjmrF7slx+4qvy/4YaBkks=
Received: from SJ0PR03CA0102.namprd03.prod.outlook.com (2603:10b6:a03:333::17)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Thu, 3 Apr
 2025 18:33:46 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::19) by SJ0PR03CA0102.outlook.office365.com
 (2603:10b6:a03:333::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.52 via Frontend Transport; Thu,
 3 Apr 2025 18:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Thu, 3 Apr 2025 18:33:46 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Apr
 2025 13:33:44 -0500
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
Subject: [PATCH v3 2/4] cxl: Update Soft Reserved resources upon region creation
Date: Thu, 3 Apr 2025 13:33:13 -0500
Message-ID: <20250403183315.286710-3-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ffe017b-c73f-4b42-4e8f-08dd72de11d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9EC1C8IsaMaICHcgmaPQ3/KCDwuTHJ1XOJCZFZu3aL22J8NuSKTd1BBGEIaF?=
 =?us-ascii?Q?H9O7UWe8xmJOxr5UbLfEgmVuJ4t8iawhVxQ/sIY+6/slos6frFcsPO/ZdLUX?=
 =?us-ascii?Q?3IDElYEsCTYwD+J+SjwJl4/BrAwpro++U3HQuZ/Ivpqw62nzX/JS/rnGb+Jz?=
 =?us-ascii?Q?so33bvSufVi9kVmgiP/ro8tQUQUkb6kMZT+Wo/ZzYkVZwqWz1ApEAD7y0QbB?=
 =?us-ascii?Q?sT4sB+EkkBFmn06X6quH6GllZWDWQOfdcqMAN/bXZ2hCGf17C8fAIuy2RhRR?=
 =?us-ascii?Q?Otzrdcmcy8Pq3YLedq+aTF3HCi5NsnF+ZPMQy2YcvMH8EODbPqpTfUaIJULd?=
 =?us-ascii?Q?1yCE9qz1FII2+ssLPoko4chtKt/ZI44ahwBdw0ou46aBdd8Ctk9zMutauuQZ?=
 =?us-ascii?Q?PBYLHrVF59FWvKXNljDkcDEQTkZ0vlP4P6AL/PTZcNVHL/9zxbPXapOVzn9R?=
 =?us-ascii?Q?JFk1zSTyVr4i/AdFGQP6dba1doQNmOsxtUi2cnDGM7ivdPb+rntNTnf+IkfI?=
 =?us-ascii?Q?oQdy1Pu7NaGBydxhJxBgxAowsM2vV8KDal4UEGPMbVCL3ceIwwWhKvQI3x6I?=
 =?us-ascii?Q?4KCh0vctHIIEwSrAwChT9f1UyNsz6pLH0PNEIEeJoq6jOOl6MQWd4izBQi26?=
 =?us-ascii?Q?XyZKEpmd1W13qGEdRbqNmeXhqEeUDZuPUydOpi8IUy2NuMkdUzgoV5vX2+VE?=
 =?us-ascii?Q?AusxYRbDMvp2qNOtC3NuYvQrx13dqAeLq4vDerzBJR18c5T1j39DLe/OppHV?=
 =?us-ascii?Q?BlxSow9KzT0BU3D5n50QqGHD+60W52pEcMJAlQds2AuFk1KrTlQJi6dBVnyP?=
 =?us-ascii?Q?xz/9z8qf1rxUCW4OiYltH0rFP3PTxNs6tQDP2isUj8gKlII7/myXWacOFcbC?=
 =?us-ascii?Q?1oKDk8sFf+DZAKoiPARz4fXLQKDu1FqW5sMoLrb27MXWSgijneudzzpI7NEc?=
 =?us-ascii?Q?mOoNOlBxd3G4XwZ/i5E3DGxngQpVXEu3jNUaJXMJb6MvISFZRaofwljAm+MT?=
 =?us-ascii?Q?xjcPpw8PhgebZz3vZJxn8n3fM5kzpFL7PYBnb9zEVOu456JYWP8fjanYqpk3?=
 =?us-ascii?Q?ztk6flrxeL+acl+wbb4iKCSRoevHlhG1oftEotk2ZP/sIk9DFr9vs+XYwZcq?=
 =?us-ascii?Q?3ukShEcL7GHQXa0ThNop6jmw9T6sYQQG1gu7U1nlpygIhnKfhETAft6JiGCA?=
 =?us-ascii?Q?24/QXHB9Rn1t/0hROX6TAtoNIixm+Rh1caj9CxZr4+JyPonOQpwqngbQGdnF?=
 =?us-ascii?Q?hlx08A8SL/fqVzX8mHjaxEhydM0rEpeDm50AYyywWKZOEVXFhYAd0yPqN6rh?=
 =?us-ascii?Q?6CWNcQ4/ank6O3jrEi7xKV4fjwgXXlX0IGPGNd0vBWv18e6DjlKH1Ai1t4Tl?=
 =?us-ascii?Q?wGcx/PLIblneT0SJdJNQ+EFEt/sbtbT7RCQyabzX7Y4fInlyDtfSw67i7Ynz?=
 =?us-ascii?Q?tVWh6iYgYeeMBMI8ejrYujwFNpciv+w81+9eI1v0WIBM6a4EHy/jRtWYKNLG?=
 =?us-ascii?Q?K1rPiTOVFG4Drcc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 18:33:46.2635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffe017b-c73f-4b42-4e8f-08dd72de11d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573

From: Nathan Fontenot <nathan.fontenot@amd.com>

Update handling of SOFT RESERVE iomem resources that intersect with
CXL region resources to remove intersections from the SOFT RESERVE
resources. The current approach of leaving SOFT RESERVE resources as
is can cause failures during hotplug replace of CXL devices because
the resource is not available for reuse after teardown of the CXL device.

To accomplish this the cxl acpi driver creates a worker thread at the
end of cxl_acpi_probe(). This worker thread first waits for the CXL PCI
CXL mem drivers have loaded. The cxl core/suspend.c code is updated to
add a pci_loaded variable, in addition to the mem_active variable, that
is updated when the pci driver loads. Remove CONFIG_CXL_SUSPEND Kconfig as
it is no longer needed. A new cxl_wait_for_pci_mem() routine uses a
waitqueue for both these driver to be loaded. The need to add this
additional waitqueue is ensure the CXL PCI and CXL mem drivers have loaded
before we wait for their probe, without it the cxl acpi probe worker thread
calls wait_for_device_probe() before these drivers are loaded.

After the CXL PCI and CXL mem drivers load the cxl acpi worker thread
uses wait_for_device_probe() to ensure device probe routines have
completed.

Once probe completes and regions have been created, find all cxl
regions that have been created and trim any SOFT RESERVE resources
that intersect with the region.

Update cxl_acpi_exit() to cancel pending waitqueue work.

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/Kconfig        |  4 ----
 drivers/cxl/acpi.c         | 28 ++++++++++++++++++++++++++
 drivers/cxl/core/Makefile  |  2 +-
 drivers/cxl/core/region.c  | 24 +++++++++++++++++++++-
 drivers/cxl/core/suspend.c | 41 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h          |  3 +++
 drivers/cxl/cxlmem.h       |  9 ---------
 drivers/cxl/cxlpci.h       |  1 +
 drivers/cxl/pci.c          |  2 ++
 include/linux/pm.h         |  7 -------
 10 files changed, 99 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 205547e5543a..c7377956c1d5 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -117,10 +117,6 @@ config CXL_PORT
 	default CXL_BUS
 	tristate
 
-config CXL_SUSPEND
-	def_bool y
-	depends on SUSPEND && CXL_MEM
-
 config CXL_REGION
 	bool "CXL: Region Support"
 	default CXL_BUS
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index cb14829bb9be..94f2d649bb30 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -7,6 +7,8 @@
 #include <linux/acpi.h>
 #include <linux/pci.h>
 #include <linux/node.h>
+#include <linux/pm.h>
+#include <linux/workqueue.h>
 #include <asm/div64.h>
 #include "cxlpci.h"
 #include "cxl.h"
@@ -813,6 +815,27 @@ static int pair_cxl_resource(struct device *dev, void *data)
 	return 0;
 }
 
+static void cxl_srmem_work_fn(struct work_struct *work)
+{
+	/* Wait for CXL PCI and mem drivers to load */
+	cxl_wait_for_pci_mem();
+
+	/*
+	 * Once the CXL PCI and mem drivers have loaded wait
+	 * for the driver probe routines to complete.
+	 */
+	wait_for_device_probe();
+
+	cxl_region_srmem_update();
+}
+
+DECLARE_WORK(cxl_sr_work, cxl_srmem_work_fn);
+
+static void cxl_srmem_update(void)
+{
+	schedule_work(&cxl_sr_work);
+}
+
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
 	int rc;
@@ -887,6 +910,10 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 
 	/* In case PCI is scanned before ACPI re-trigger memdev attach */
 	cxl_bus_rescan();
+
+	/* Update SOFT RESERVED resources that intersect with CXL regions */
+	cxl_srmem_update();
+
 	return 0;
 }
 
@@ -918,6 +945,7 @@ static int __init cxl_acpi_init(void)
 
 static void __exit cxl_acpi_exit(void)
 {
+	cancel_work_sync(&cxl_sr_work);
 	platform_driver_unregister(&cxl_acpi_driver);
 	cxl_bus_drain();
 }
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 086df97a0fcf..035864db8a32 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
-obj-$(CONFIG_CXL_SUSPEND) += suspend.o
+obj-y += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
 CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c3f4dc244df7..25d70175f204 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -10,6 +10,7 @@
 #include <linux/sort.h>
 #include <linux/idr.h>
 #include <linux/memory-tiers.h>
+#include <linux/ioport.h>
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
@@ -2333,7 +2334,7 @@ const struct device_type cxl_region_type = {
 
 bool is_cxl_region(struct device *dev)
 {
-	return dev->type == &cxl_region_type;
+	return dev && dev->type == &cxl_region_type;
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_region, "CXL");
 
@@ -3443,6 +3444,27 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
 
+int cxl_region_srmem_update(void)
+{
+	struct device *dev = NULL;
+	struct cxl_region *cxlr;
+	struct resource *res;
+
+	do {
+		dev = bus_find_next_device(&cxl_bus_type, dev);
+		if (is_cxl_region(dev)) {
+			cxlr = to_cxl_region(dev);
+			res = cxlr->params.res;
+			release_srmem_region_adjustable(res->start,
+							resource_size(res));
+		}
+		put_device(dev);
+	} while (dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_region_srmem_update, "CXL");
+
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
 {
 	struct cxl_region_ref *iter;
diff --git a/drivers/cxl/core/suspend.c b/drivers/cxl/core/suspend.c
index 29aa5cc5e565..4813641e1b7b 100644
--- a/drivers/cxl/core/suspend.c
+++ b/drivers/cxl/core/suspend.c
@@ -2,9 +2,14 @@
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 #include <linux/atomic.h>
 #include <linux/export.h>
+#include <linux/wait.h>
 #include "cxlmem.h"
+#include "cxlpci.h"
 
 static atomic_t mem_active;
+static atomic_t pci_loaded;
+
+static DECLARE_WAIT_QUEUE_HEAD(cxl_wait_queue);
 
 bool cxl_mem_active(void)
 {
@@ -14,6 +19,7 @@ bool cxl_mem_active(void)
 void cxl_mem_active_inc(void)
 {
 	atomic_inc(&mem_active);
+	wake_up(&cxl_wait_queue);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_active_inc, "CXL");
 
@@ -22,3 +28,38 @@ void cxl_mem_active_dec(void)
 	atomic_dec(&mem_active);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_active_dec, "CXL");
+
+void mark_cxl_pci_loaded(void)
+{
+	atomic_inc(&pci_loaded);
+	wake_up(&cxl_wait_queue);
+}
+EXPORT_SYMBOL_NS_GPL(mark_cxl_pci_loaded, "CXL");
+
+static bool cxl_pci_loaded(void)
+{
+	if (IS_ENABLED(CONFIG_CXL_PCI))
+		return atomic_read(&pci_loaded) != 0;
+
+	return true;
+}
+
+static bool cxl_mem_probed(void)
+{
+	if (IS_ENABLED(CONFIG_CXL_MEM))
+		return atomic_read(&mem_active) != 0;
+
+	return true;
+}
+
+void cxl_wait_for_pci_mem(void)
+{
+	if (IS_ENABLED(CONFIG_CXL_PCI) || IS_ENABLED(CONFIG_CXL_MEM))
+		if (wait_event_timeout(cxl_wait_queue,
+				       cxl_pci_loaded() && cxl_mem_probed(),
+				       30 * HZ)) {
+			pr_debug("Timeout waiting for CXL PCI or CXL Memory probing");
+		}
+
+}
+EXPORT_SYMBOL_NS_GPL(cxl_wait_for_pci_mem, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index be8a7dc77719..40835ec692c8 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -858,6 +858,7 @@ bool is_cxl_pmem_region(struct device *dev);
 struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_port *root,
 		      struct cxl_endpoint_decoder *cxled);
+int cxl_region_srmem_update(void);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
 #else
@@ -902,6 +903,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+void cxl_wait_for_pci_mem(void);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 3ec6b906371b..1bd1e88c4cc0 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -853,17 +853,8 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
 
-#ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
-#else
-static inline void cxl_mem_active_inc(void)
-{
-}
-static inline void cxl_mem_active_dec(void)
-{
-}
-#endif
 
 int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
 
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
index 4288f4814cc5..b784008489b3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1185,6 +1185,8 @@ static int __init cxl_pci_driver_init(void)
 	if (rc)
 		pci_unregister_driver(&cxl_pci_driver);
 
+	mark_cxl_pci_loaded();
+
 	return rc;
 }
 
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 78855d794342..11ff485c9722 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -35,14 +35,7 @@ static inline void pm_vt_switch_unregister(struct device *dev)
 }
 #endif /* CONFIG_VT_CONSOLE_SLEEP */
 
-#ifdef CONFIG_CXL_SUSPEND
 bool cxl_mem_active(void);
-#else
-static inline bool cxl_mem_active(void)
-{
-	return false;
-}
-#endif
 
 /*
  * Device power management
-- 
2.34.1


