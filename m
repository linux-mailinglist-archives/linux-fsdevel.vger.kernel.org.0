Return-Path: <linux-fsdevel+bounces-50529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 485D2ACCFD2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EEF07AAB74
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 22:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3D02586EC;
	Tue,  3 Jun 2025 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DcuzcDVf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBFD2550D3;
	Tue,  3 Jun 2025 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748989214; cv=fail; b=ChJzVpDZVnFprjmiQdHZJ7uiwMVnC20itPZu6whJbtggLL6Wn8HzYFrlmtnlEdbXeRrKQL3PNbnemJ3xIwAwUcnp+VNRAygCc6n9Id8lJ13yRJIPPtinIpMINoDJllfAchZgeFZ3G1UfsW53WP7w0bBx4ygHe8JP9hoNsQo9eMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748989214; c=relaxed/simple;
	bh=1osBlMvFUlp2kGJU/zmJFdZEI8qYHmB0DKaac0xYUU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPO9QMqzsnhusmOWDpnPXTMjqmzwwN+oxDCrdIiARwa1GqV6C72lRzXP2E6yHW5cBHIMzIZN5tfssZiWrPaF5uVPel1q8S/enEPH1ArAw2GrYx86cOINPHpaHaHjMjmB0vDwZI2jp9ipGgUXF2b/L2glRHVvbdRnlMgtKYYs7S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DcuzcDVf; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGyQtz3fQ93gFFw74s6V7UPZF6yFGjecd4euR9aJMbRXPsvdVn94XDbjw0dAaFVE0zDzN4ApRsq5cNAzElsEpttXPCCpxlafg8VIIixZJXQC8NIxyeFGS5BrqkAyJbzhhNqxzjd9atjQCpAL6oa0XmLFnzGEHlpVznWeDC3SeURy9DzLcODpA1nPzsYAP7qWgrxD2OCvG58gwbSHcfSYAmnCc4Gn27aoGw97/DP9zci22YP8fm7/IKmYbeibhsh0wbKbUcnR8pBR6hKfFLQ8nTbwQ1ZmedRToXG6efXoYJRpgXg3NWuVPiqW3gR8/21Lh2noaopMfivOP5E1gTHLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9fmUy2piLdGGKbNxeBJ3C6cYSaNbZu7eNQuByQYbSo=;
 b=YTBJ3dJu98boKtzuACPy8LjdRijDDCsAzY5kFz2LLFIDy9F9EbHa4CM67EGcSXWeRcV8yxa5tyuU9EI4eVj85uRn9FgyO0wE3xpciRU4GOXJ4GjNjdrPScgFIr281IwQS+jSX4/kymANOH+aVcj6opqja+EUuKaGCJCxjdiVcjPJA+I985HFPy45UGrSDS8CYGJrHTYfTr37ORKtobyDqtOJWA9bpwAlVzHtElo1HosZh5oGm0zE7YvKL0zhtnW3Z8pu1lSMEO7Lxy2QUSvwkA+VVNIKlbGPmxgTt65HVsg75CozMSHOcrsBg0bOeYyUzBdRUcpQRPH/T2T+7SD1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9fmUy2piLdGGKbNxeBJ3C6cYSaNbZu7eNQuByQYbSo=;
 b=DcuzcDVfwlU0pWUObrdCff0cA4ZZQX+l2cbFaPrwagRXL11d9DXEAu7W4rmLc7AaGoaDX3r+Hv8g+FlwnIHM9Ik3YLDkt85Qfsgq9JMjEMuvs19moc/XSQhYpSxBbHawb9cRZXYHe/KukWO48xcEVvBE9BQ9qHTY+OIiSwYbN1g=
Received: from SJ0PR13CA0199.namprd13.prod.outlook.com (2603:10b6:a03:2c3::24)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 22:20:09 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::dd) by SJ0PR13CA0199.outlook.office365.com
 (2603:10b6:a03:2c3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.26 via Frontend Transport; Tue,
 3 Jun 2025 22:20:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 22:20:08 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 17:20:06 -0500
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
Subject: [PATCH v4 7/7] cxl/dax: Defer DAX consumption of SOFT RESERVED resources until after CXL region creation
Date: Tue, 3 Jun 2025 22:19:49 +0000
Message-ID: <20250603221949.53272-8-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: cac8e9a6-6d1b-427c-a759-08dda2eccca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3hIbkdtd241RzdIaENNTUJBeDdYbTdKbTdSOW9vSkdmYVRIeTVZN0loUGd5?=
 =?utf-8?B?YUZFd1RFQnBTbDZLT0draEVIdllhV0VyN0NweTg0a2Ewc2N1amQ5b1pTYWwz?=
 =?utf-8?B?YXVTTjFYeDJpendJYzhyUkhGMGJPaXlqRFU5bDRicVcwZjBWYTdsWFVQMlF5?=
 =?utf-8?B?STYyZmlLNFYrQ2ZtWkRidHBMdWNnUnVFQThudlZUbEN2RGZibmtOZVBzTjhy?=
 =?utf-8?B?R0J6VTNuVEJqTFBPZmZuQVRkWTNWWFlvcmJzVDdEOXg5TlZpSm1VR00xUnJE?=
 =?utf-8?B?Vlc3bFlQbEczckc0L2RPUXhCNVYxNkZyUzR6S3VCZG1mTWFDYWl6VzhXUmFw?=
 =?utf-8?B?ZzVoY2VpellKcjJWWG5qaVh1aDh4RU0xcngzaEI5TTlMWXJHTUR3V2tHdFdk?=
 =?utf-8?B?ZGVnTnZyRFIwSGdBTVRDRWdXZWxzTlRmQ0VzMVhWQzluQy9sRWFCSnZHNlFK?=
 =?utf-8?B?UHZOeTduZUU3SWpFU04wbUtsVEtUdTJDRXhnUkViQm5GbUdKSVFtN1J2QXM1?=
 =?utf-8?B?OEJyOTAyelJGRWlnRmdJSC9udW1TTUp6bzBEWkhpejU4TDZQQnhLR29WQkRS?=
 =?utf-8?B?Ym9PMTJ3MXBPWlIwRkNOdS9FcXV1SFFSb0c3T1N0Q0ZqM0h0NFBlRVhIbWpO?=
 =?utf-8?B?YUpxa3JVd0ZGSldNMUFIQTdhTERmd2xMZjhaVy9COE1OenZ5REVnM24rMHBx?=
 =?utf-8?B?eldvZzJrb0RrQ0pBSTRwZFJYRFE0S0pEMnZ4SWhiTG1PaC9WazJROU5hSmoz?=
 =?utf-8?B?YllVdEcyT2M2cC9QWXlzK2J3NGk4bXJRZE02UXpPdjAvcmZUdVdGYlcvUHA5?=
 =?utf-8?B?RVRSc0dGbjNVOTFrRE5QZzVtTWZFbUlZbm5aQmJqbHJaT1BLdG1NMHByMEk2?=
 =?utf-8?B?U01PV21RbkhRWElqWnVNZzM0czhFTzFNR1pJbzQwaitxb0ZUc2MwSjZScnl0?=
 =?utf-8?B?TS8yS05jdDh3SEFJWDJGNkRZNHNXWnFXWml1QjAvS0RxUEZTSTJ5TWlVeHY5?=
 =?utf-8?B?eWN2WDc5MTdkZG9rYUpYWis0QmRpdU93c0U4SXIrcWR3RmZuOTF0VklDZDVj?=
 =?utf-8?B?c2oxUDVMMHUwVDdRU1ZFcE5vbHVXZzQ0UVhML1YzRUhjK1Qvb2VnQmplZmth?=
 =?utf-8?B?bnRyZnRjSDNJdWV6M3ZjakVPOEJrU2RXY0t2U3hSaDVRZ3h5RVR1VjZTdDdV?=
 =?utf-8?B?ZVI1K2tUcFdXeHd0SmZzSnY1aVB4QXFMR01GUVN3UXlpZmltQktrQjBSd204?=
 =?utf-8?B?NmJ2SWtqUXR2YzVlNDJSeEpxV3JLTkZoc1NRZzIwMktXclJDdUxQWWtCYzc1?=
 =?utf-8?B?dzFNSGdwUlRpQktYd1VMOUNOempDYXNqRlBjeFFmLzQ3cHRuN0ZGdkhwNGNL?=
 =?utf-8?B?L1NEWXRXbmJ0WElubnBPczFZVnd5MzlNMnR5WEdXSk9qSDVMUm9hWHZGakhY?=
 =?utf-8?B?UnVTdUJkejhwbVgyb1hIcEJYTzhkV2RhT05JUDBkbTNBdjRtU1kzdXQ4MEFQ?=
 =?utf-8?B?NEpiTFJKQVhMTStHK1pzakhMNStVdU5zeGN0RDVrbnhHN0Q4Z2IwWlZtWlBN?=
 =?utf-8?B?YkhBZVBKY2lveFNBd084QlprWnZzTm1yaXVnQ3BWdUFlQXcvWWhKOEhZTGg1?=
 =?utf-8?B?YSt6a3lZalhPRVZ1MW9hTVc2ZjVPcnFFNzR5dlRJRDhMSFJBdkVka0NlU29p?=
 =?utf-8?B?aThsZ3EzeFVZc2VGQ3BNL0dBby84TjVvU0R6bXV4R0prbHJwQlpmNVVDaTFM?=
 =?utf-8?B?R2JlSkxvSksydlFiRmJuaW5LTmN5THRaYjI1eWFna1cxVWNXTGtaNWNjODRh?=
 =?utf-8?B?MU82R0lMMzZUTXE3UkFaZ0JYRVlDSC8ycktRSERTZFRIclFEK2xUdFdSYjZO?=
 =?utf-8?B?STNnZ2ZSTytEbjNiVHk3QnhYVDBSeHBkL1R1aU9UOERNYkovc2RaSXV4Skcx?=
 =?utf-8?B?MEUvOFJtN1cvUTZzUk5sL0J1RHpEVFBzNnNiTUh4YXlRMngrRUwzQzlsTTJX?=
 =?utf-8?B?UHRFbzIzZkp0MitnRmVvSmFreUlBL1dGRnFqRjVEQVdlMGRNaGsyR3JSRHNj?=
 =?utf-8?Q?yv9g+y?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 22:20:08.5214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cac8e9a6-6d1b-427c-a759-08dda2eccca4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039

From: Nathan Fontenot <nathan.fontenot@amd.com>

The DAX HMEM driver currently consumes all SOFT RESERVED iomem resources
during initialization. This interferes with the CXL driver’s ability to
create regions and trim overlapping SOFT RESERVED ranges before DAX uses
them.

To resolve this, defer the DAX driver's resource consumption if the
cxl_acpi driver is enabled. The DAX HMEM initialization skips walking the
iomem resource tree in this case. After CXL region creation completes,
any remaining SOFT RESERVED resources are explicitly registered with the
DAX driver by the CXL driver.

This sequencing ensures proper handling of overlaps and fixes hotplug
failures.

Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/core/region.c | 10 +++++++++
 drivers/dax/hmem/device.c | 43 ++++++++++++++++++++-------------------
 drivers/dax/hmem/hmem.c   |  3 ++-
 include/linux/dax.h       |  6 ++++++
 4 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3a5ca44d65f3..c6c0c7ba3b20 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -10,6 +10,7 @@
 #include <linux/sort.h>
 #include <linux/idr.h>
 #include <linux/memory-tiers.h>
+#include <linux/dax.h>
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
@@ -3553,6 +3554,11 @@ static struct resource *normalize_resource(struct resource *res)
 	return NULL;
 }
 
+static int cxl_softreserv_mem_register(struct resource *res, void *unused)
+{
+	return hmem_register_device(phys_to_target_node(res->start), res);
+}
+
 static int __cxl_region_softreserv_update(struct resource *soft,
 					  void *_cxlr)
 {
@@ -3590,6 +3596,10 @@ int cxl_region_softreserv_update(void)
 				    __cxl_region_softreserv_update);
 	}
 
+	/* Now register any remaining SOFT RESERVES with DAX */
+	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED, IORESOURCE_MEM,
+			    0, -1, NULL, cxl_softreserv_mem_register);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_region_softreserv_update, "CXL");
diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
index 59ad44761191..cc1ed7bbdb1a 100644
--- a/drivers/dax/hmem/device.c
+++ b/drivers/dax/hmem/device.c
@@ -8,7 +8,6 @@
 static bool nohmem;
 module_param_named(disable, nohmem, bool, 0444);
 
-static bool platform_initialized;
 static DEFINE_MUTEX(hmem_resource_lock);
 static struct resource hmem_active = {
 	.name = "HMEM devices",
@@ -35,9 +34,7 @@ EXPORT_SYMBOL_GPL(walk_hmem_resources);
 
 static void __hmem_register_resource(int target_nid, struct resource *res)
 {
-	struct platform_device *pdev;
 	struct resource *new;
-	int rc;
 
 	new = __request_region(&hmem_active, res->start, resource_size(res), "",
 			       0);
@@ -47,21 +44,6 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
 	}
 
 	new->desc = target_nid;
-
-	if (platform_initialized)
-		return;
-
-	pdev = platform_device_alloc("hmem_platform", 0);
-	if (!pdev) {
-		pr_err_once("failed to register device-dax hmem_platform device\n");
-		return;
-	}
-
-	rc = platform_device_add(pdev);
-	if (rc)
-		platform_device_put(pdev);
-	else
-		platform_initialized = true;
 }
 
 void hmem_register_resource(int target_nid, struct resource *res)
@@ -83,9 +65,28 @@ static __init int hmem_register_one(struct resource *res, void *data)
 
 static __init int hmem_init(void)
 {
-	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
-			IORESOURCE_MEM, 0, -1, NULL, hmem_register_one);
-	return 0;
+	struct platform_device *pdev;
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_CXL_ACPI)) {
+		walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
+				    IORESOURCE_MEM, 0, -1, NULL,
+				    hmem_register_one);
+	}
+
+	pdev = platform_device_alloc("hmem_platform", 0);
+	if (!pdev) {
+		pr_err("failed to register device-dax hmem_platform device\n");
+		return -1;
+	}
+
+	rc = platform_device_add(pdev);
+	if (rc) {
+		pr_err("failed to add device-dax hmem_platform device\n");
+		platform_device_put(pdev);
+	}
+
+	return rc;
 }
 
 /*
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 3aedef5f1be1..a206b9b383e4 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -61,7 +61,7 @@ static void release_hmem(void *pdev)
 	platform_device_unregister(pdev);
 }
 
-static int hmem_register_device(int target_nid, const struct resource *res)
+int hmem_register_device(int target_nid, const struct resource *res)
 {
 	struct device *host = &dax_hmem_pdev->dev;
 	struct platform_device *pdev;
@@ -124,6 +124,7 @@ static int hmem_register_device(int target_nid, const struct resource *res)
 	platform_device_put(pdev);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(hmem_register_device);
 
 static int dax_hmem_platform_probe(struct platform_device *pdev)
 {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index a4ad3708ea35..5052dca8b3bc 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -299,10 +299,16 @@ static inline int dax_mem2blk_err(int err)
 
 #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
 void hmem_register_resource(int target_nid, struct resource *r);
+int hmem_register_device(int target_nid, const struct resource *res);
 #else
 static inline void hmem_register_resource(int target_nid, struct resource *r)
 {
 }
+
+static inline int hmem_register_device(int target_nid, const struct resource *res)
+{
+	return 0;
+}
 #endif
 
 typedef int (*walk_hmem_fn)(int target_nid, const struct resource *res);
-- 
2.17.1


