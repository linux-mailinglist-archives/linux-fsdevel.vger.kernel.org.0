Return-Path: <linux-fsdevel+bounces-50525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FC3ACCFC0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 647757A8F0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 22:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588F6255E2F;
	Tue,  3 Jun 2025 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JdvPe8Ox"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02533253941;
	Tue,  3 Jun 2025 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748989211; cv=fail; b=MukN7Fpp233yY+tNzTCGfepIgaB/jZtlLSHkS2/YGdeIlP13w+BE/HPWzRLhrojdaXPhMhV8DPidKnAu/oj4NrxNwRCyVJnNP5YAYbJxbS/1sx0e17MBzrDdM2PNsWJLSJrodMEbs9daje40rlwFGc3mmygvYsps1stjUa7bHiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748989211; c=relaxed/simple;
	bh=e8oDyjaAn0rCiJfByJQfNCNHd4YYGM3Fvx+wNGKQZHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGi3Zd28OzY+HwqroaZTU8zkWta2JoeTheo79pi8Lv1jhurQHqqENpIrRZcN4oqLf2451vfy3IH5D4bFFLByPvtPgkCVALsu/3o4gls7qQKDOjm4zkmb6FYpjK7/Pn8+W/d1uTJz4lgnbPwhpPgHVj+D/3Xuudd135eL0pMCzYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JdvPe8Ox; arc=fail smtp.client-ip=40.107.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lxg0vYmHxJ/dUlG2pSpkzW7F1RkNu/Aknru2Pkw+5fMz4GZ/b2B1JcS2+8pGpTiEzv2HNIBE3zaddubxwS687MqzcK4Yd9B++J9lzj1cS0aNselyyNC7WxsQ1H2afCeNI0X9TaLWBceY7Pmk/vuyctncTBi6hXjqr7KqU0LaRnDFYbP3DLorTpbIMCeiLt7r8p3N43WiplODPx7guA2ZypcrSKDNJdI/9dBaCE3yP6kTj9R/QsRzWkZUMj35WcEL2syaRQRmK4YnwqFw6JMQ+mqqmWxxjUhTID4VE5JQVsIRrZxs3PemAa1kpJUfrJwmqbyl6+kfkUJhh1O21OOihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRuZ6VtrrEFKjSh/DIBH37ZGIOKvDD63I32bxGsxwv0=;
 b=WivKJS4TktNBniYCppPjVl9GQJEfJ+O+BM+fuylE6QeWlgwfxhk76a5R3oJt6D6PfXsab6EnhkmGnC9XcN15DBCaGzbPOeuFFot/noLUumkxqGa7R6up7En2mBM9SqUNbNfB9NPVXS6ElACgKQh7WUCrLqpaVxILBhYdT/XoH74Emt3u80Tplut+K4Puj9leRWlVJVzgUL0Azj3bxqoZvzCXGc8mSLSNKZpaS7yxz6OeDVnN0JgR/eNC9Vmgd1Tx4bnrHNEh0mdutB48oCUAhJMU9WamX2RbnedIaVgULj77SnI4VOxrke2sMKFDk9N9xCLb1XgeVfGunsjMNlDzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRuZ6VtrrEFKjSh/DIBH37ZGIOKvDD63I32bxGsxwv0=;
 b=JdvPe8OxPdvlJc+Ijl1jZCn0oQlC7wz29stbOz/d32/lCXyOBntMBlB3oX6sfoaiUIwZ6lrrkEwUM2CimpuD4nYvEZ0bAploZ6Wa9/0VbEU69kMq3iLu+zgaynh6kPImmEvPtnsPO/iCxwkMqXYz7xD5tjav8ivZsCdDTWRkRGg=
Received: from CY5PR04CA0023.namprd04.prod.outlook.com (2603:10b6:930:1e::30)
 by SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Tue, 3 Jun
 2025 22:20:03 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::33) by CY5PR04CA0023.outlook.office365.com
 (2603:10b6:930:1e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.32 via Frontend Transport; Tue,
 3 Jun 2025 22:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 22:20:03 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 17:20:02 -0500
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
Subject: [PATCH v4 2/7] cxl/core: Remove CONFIG_CXL_SUSPEND and always build suspend.o
Date: Tue, 3 Jun 2025 22:19:44 +0000
Message-ID: <20250603221949.53272-3-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|SJ0PR12MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e013aae-4da0-4176-0be1-08dda2ecc995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FEWj4ja72xVjjE3HAvFt+5lvA+8YZgofOY1asHgfxB/xFhq5SwUw0r63kSoi?=
 =?us-ascii?Q?k6LXvAFAvBeaE2efRi4QrypuWDh1DFX/x6WHxHNncnpMjSKjSkA9EOaCrxLG?=
 =?us-ascii?Q?FF+bFeehRVhU0I9snzoqpxYfr5FIWHtUNED9xFry6yr8b5XRVEXYg9tsAGQ2?=
 =?us-ascii?Q?lDVN2plvrW1cITgE8FjC+MnWQn2WL+X1N+40OezZpkrKuAFsKxnKXAybb7qx?=
 =?us-ascii?Q?NWI/ot+DftqjVeKuLxak7QYupBgb5LEcK0wBImS05ZbBf8EuYIvAAhEMgHkz?=
 =?us-ascii?Q?iV8AWY7TdmsHWFByWs67cjmsKUU0Vyb/NdmWnWE6SWH4Jt3BEgWTDwc/cy4y?=
 =?us-ascii?Q?3Q92KYskG2AWjc9k2wrWzwZ0BwDn6BWHwqzOOCqUSBPu+MIA0M7JadJF+Fpk?=
 =?us-ascii?Q?2aosgIdvT0G+nSoamB64ZeF6LBIbOXsU2wC5NMkau9migt75S/R/nreUvdDC?=
 =?us-ascii?Q?MO/Lt1UONycqIPwSvEuKMbl2CaIGf2E95Mq/xVSSGDdMqJ8N34q8A3IrPGza?=
 =?us-ascii?Q?fTFJ6QhvwGDL/7H9iOFyZNqFV0lC+SKxs/ehwm01nDZ5BaIHLI6x9YNWGdac?=
 =?us-ascii?Q?yf9zD86kULDgZ1A1Gir15sCLgVHNyP3sw1rPITB0y8MyIo61H0hiEQPgYm5V?=
 =?us-ascii?Q?qlK7CgN6Ifbd7tnj67FYIgVWzmRHkO9TpHEm8kQaWITbtl24IzAjAxlc+Lvf?=
 =?us-ascii?Q?DeL5z03P5DVPNneKUcWySvdS6KFjeCrzwsuyhLf9KdFeV27bdoX9CMkEqPR6?=
 =?us-ascii?Q?3NYw2nLDxAn4ShLzVP/PKfsVVLPZ8rYKKXxiJB29jIfLDsKY58B7+rZkFSTM?=
 =?us-ascii?Q?F5TPg/TQMxF3zLQWCe12FJD1MgQUkgFHGYFAzzA8ArsA7s27iuHKMQEGHkAE?=
 =?us-ascii?Q?tvpDcVCu+uOe/zPVP4PWG+17ErLSOGBedjDfj8DnuJNo0W1oZh8X8LgJTexg?=
 =?us-ascii?Q?fI8AdM1cQg3q4/pSCxq1KuHIqJ4wvk0TowmlP+Ct1qW5omz5PSwY8LT7GrrY?=
 =?us-ascii?Q?Xn8+fUL2LQJLjmU7zuxrwrMWG23rwL6F0kKhZpHbmbuXjuLUKtrW//jsoEW4?=
 =?us-ascii?Q?6rJEnGfBQhNl8kDoPBNox7ANg38BBKRBSAmvMProdPgBsXMklARReeGiwnrJ?=
 =?us-ascii?Q?Itgm0ncdYPDHsHaBXWFrEeOQ0YXVlgD/1tk7Hb/VRKMaxy0HbW6+27JUP8je?=
 =?us-ascii?Q?stE1ZwaDkq+ZqdiLAMWX07CHpPZEMmQvNsZDjEBN93fSVVReBc60ThoVCrJW?=
 =?us-ascii?Q?zT8OBCYq2/3cdu7Vm7djNqWysM6r2eBIH0rih1xo5GHb59CZubB2rYdJONkI?=
 =?us-ascii?Q?rLCXuO5pXfRZLiqz/WWooCluty3W7jV+1GjAJ+uku4W684cTvbJ5TJXOcXUQ?=
 =?us-ascii?Q?Q+xdJetYkwfmZ/DAGnOJWVVKSee5W4tzzmHo5K645JEhT7OQf+djm3C4Gc6h?=
 =?us-ascii?Q?iT9DUlxpGw6ovSipY9FowRwBM0N6lTdwXMkbJaHtJIiDINlI7FaNONAtbwxd?=
 =?us-ascii?Q?Lva1YVz+OcaZ0XaH5GZWCK0L12BJDiID7DJX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 22:20:03.3441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e013aae-4da0-4176-0be1-08dda2ecc995
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616

In preparation for soft-reserved resource handling, make the suspend
infrastructure always available by removing the CONFIG_CXL_SUSPEND
Kconfig option.

This ensures cxl_mem_active_inc()/dec() and cxl_mem_active() are
unconditionally available, enabling coordination between cxl_pci and
cxl_mem drivers during region setup and hotplug operations.

Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/Kconfig        | 4 ----
 drivers/cxl/core/Makefile  | 2 +-
 drivers/cxl/core/suspend.c | 5 ++++-
 drivers/cxl/cxlmem.h       | 9 ---------
 include/linux/pm.h         | 7 -------
 5 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index cf1ba673b8c2..d09144c2002e 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -118,10 +118,6 @@ config CXL_PORT
 	default CXL_BUS
 	tristate
 
-config CXL_SUSPEND
-	def_bool y
-	depends on SUSPEND && CXL_MEM
-
 config CXL_REGION
 	bool "CXL: Region Support"
 	default CXL_BUS
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
diff --git a/drivers/cxl/core/suspend.c b/drivers/cxl/core/suspend.c
index 29aa5cc5e565..5ba4b4de0e33 100644
--- a/drivers/cxl/core/suspend.c
+++ b/drivers/cxl/core/suspend.c
@@ -8,7 +8,10 @@ static atomic_t mem_active;
 
 bool cxl_mem_active(void)
 {
-	return atomic_read(&mem_active) != 0;
+	if (IS_ENABLED(CONFIG_CXL_MEM))
+		return atomic_read(&mem_active) != 0;
+
+	return false;
 }
 
 void cxl_mem_active_inc(void)
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
 
diff --git a/include/linux/pm.h b/include/linux/pm.h
index f0bd8fbae4f2..415928e0b6ca 100644
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
2.17.1


