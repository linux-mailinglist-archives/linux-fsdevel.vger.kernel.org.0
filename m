Return-Path: <linux-fsdevel+bounces-55012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EA2B06590
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CBE1AA4FA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD2529CB4A;
	Tue, 15 Jul 2025 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lhw+Y7am"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BB529AAE3;
	Tue, 15 Jul 2025 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752602674; cv=fail; b=AaIVFtqvXecTdeVCwAjxMJHQkGLG2vDgYtXYalIk/A+oZZTdcnstk+DA6NyaU5ScABe27Gz4JYZ3wLqADccOqdMQw5Qo3ECDPwpjXMluIeam54fyfmJsX/6c6A5XaO9UKSSi3hKtPA7uY0WokoxkF+56Ar9m1mWiTFHGl8+ccxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752602674; c=relaxed/simple;
	bh=f3S7I5CCykyORFk8vxLMw4JFfP+kVILpBa2SkE69blc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZC0ySUUfqNMhtQBU/XTokJWm8Z8gdzgGKcmYA0vP4Yi/aY4NBW9np8BRbg13qp77k0QJ7dHh9uypzUyWzCKXiOzV8HPgu+Ef6Zsi9xZDOnVFLLOjFDvcqXqa00ep8Gxb59SNIv6E0PdsmH68PnjsLyhq/XxqR1RIUPbpViD1KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lhw+Y7am; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LP1vFKG02kLOn5kl7uIGZ7DjrWXBH+U9o/tXSg2Wh7eyTkInrMCR0sSOKfUfvLFgdK2QVMSnMOPq9Wjc/I7SHH+PGBpS3Gzvg+M4phqUubZ7Wg4UaBIpDwKXkFgp3jkHFPjZpqlyt+8SORQkcSGwKxd0/cjd41TfIhUg196wij0EbDSNP1xNFJnUPR8B8NE+8HI4kRzH8Ds+sSYst+sCNplQcPFjsDKXH1NhjDZ82Ll53A+dSG5dcEqNb8B0y9WSZbBe0uOhqSHoxxnudXt2InTCLA7sh3lDjkiEeW0Kzj6S6BYSKp6IKV7pxEIlj4Ld2vd/7WOtEVnoIotlcqXtlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7J2bo91wVPJQhPnuS1Q5588KdrQ2oBJZ953/6sUZqvY=;
 b=DZNhyl4I8KjRQ2riULWXnYKx1xNY2tOqhnKYgjb0XzIMtahwyaHyBSGP0uKfKt0/CRkoJC+XoUnTiRIrR3IsXsqpPtGwrJpjRlQx7xjocZvxipCwyaxXMpPG3k8+RIEY/u9LpxvTf2WsHUSVj84XHjOxkTSWqFxvUu4tWHe4btYZ7GuKwW5U7kJeO4RgGyDWwqjsSlNjJtdFTdAjPcfzRWami4V2l0YvraZX0HbqiJL7CQ+ue5CWHnWWxrcQV9358jg+vO0NP4I+Bh1j8Z3wfqsktcIhQqgMcEVwlof3iJhu0L2YqzZJ5uJC3Z0IyuF8p9T8VXaxBrgw0CY+Jp+kVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7J2bo91wVPJQhPnuS1Q5588KdrQ2oBJZ953/6sUZqvY=;
 b=lhw+Y7amvonCiG3U9DLwnFve1re+4+nEd3+XWt4cYJRTxmEqMR34aaCwC/KZEsfNnlZq9wScfNhLSvL0fkXAchG/cIX3xETs/dqVnRvp81y05atdy310oPKwPyIpL1CaX1BFbVjtE0xn5onTcrifVjGB6mTsCiDtUSxfK2savcI=
Received: from BY3PR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:217::33)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 18:04:29 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::89) by BY3PR04CA0028.outlook.office365.com
 (2603:10b6:a03:217::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Tue,
 15 Jul 2025 18:04:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 18:04:29 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 13:04:26 -0500
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
Subject: [PATCH v5 2/7] cxl/core: Rename suspend.c to probe_state.c and remove CONFIG_CXL_SUSPEND
Date: Tue, 15 Jul 2025 18:04:02 +0000
Message-ID: <20250715180407.47426-3-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DM6PR12MB4314:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3cd4f6-8516-41b6-39c5-08ddc3ca0b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TDBwSQygH7SidFB3Z9PjcXK30A7iawHNPuLDZD/AXPd3l2peyS7kJxvXd6sw?=
 =?us-ascii?Q?FOheg+7vUf0H048nOAP3rlPpFlzwJRb95bC57Nak2K8r8Og3+o8OrG01soK0?=
 =?us-ascii?Q?QBieZNVurj9XzF7KMZ/e1hFU5W/DeyxEhccV4kca+bKlJb2co1v28NHLUEyo?=
 =?us-ascii?Q?Pcp7hDH8HdalYAjX3tJCAMyomMfLesIUPkXQ3eQq8AaGKROn9je/uMmFiX3A?=
 =?us-ascii?Q?ofUqSffA4AwPKPCVYum6X623EyX4xoHY4nC1YwA7jJcCXthV5pJ385Zel8Vu?=
 =?us-ascii?Q?ox/QBL3vX5Y1CsqrFf+6sDU2vEu5HvldnWOXEwqWMw4n1VK2LqcGsWYffV/G?=
 =?us-ascii?Q?UKOh6twP+ExP/C49iBVET/yU3ytfTXAJU0aHZVsbJ7wWeanBAcUPINFsOS6k?=
 =?us-ascii?Q?Pa4Ky3iQwkWljogVJ/grqYWE6UVXsUn5ON7Muedzc8XMXOEiLA9IWo+h8+5h?=
 =?us-ascii?Q?MFXE3oNaAcPfal8SNzvV7wwhM8seu9aPPf+kAuq6hytoURRllzurzJEqtIro?=
 =?us-ascii?Q?9g4aC1gpOBKkhL1M/RxCXT+m8pRjFCAFUTQ2dFedMj5nGj8+X4UFUMQNcYNJ?=
 =?us-ascii?Q?7EQ/+AqZ2a/IeEo6KpO+aGA92/XUlsIBoyE+UVmAkMLfVwbq6JTkmOftyJeB?=
 =?us-ascii?Q?0LjwMIMP/Bd7LvtPpiyHrn4XbGcRh34TexDaeCZ2X3P3LyMXTYwDEnhPgWRc?=
 =?us-ascii?Q?Ck3IwC5ReiT13fo9qC3CldgvgeQ+wRujIdSaV6ejibfK9ZJculiuPp4NWEpw?=
 =?us-ascii?Q?kaLijnP89oDxYLLzQ1J/Exw/KGIeva2XKkNg2SOO4vZU7U6eVxtQIHZJQEsY?=
 =?us-ascii?Q?MOwwNzbmULkaXH0hUI3mdjMBSKKerMQrkGnXP9d1a8oxgONaYckkkEviGRZc?=
 =?us-ascii?Q?5hNN9wx1i7p5Q+TuJpbyL1EdXtbHUswSybJHfzMiG2yKfDyH3gU8STlgrOib?=
 =?us-ascii?Q?asavsdfZotTHNh/t9fZ3A1hXyDs9a2srhk66hFFuWfcxA/9RyKfLkS5k6oNG?=
 =?us-ascii?Q?d2+1lvfY4CMd/NGhwfykLWjaCEt3DxiHackJ9Utt/2GHbLBSvvFSi/7IU6EP?=
 =?us-ascii?Q?4+OC9M06CSBFnarm9337sBL7DFoE7qLu0AW8jJPOHs5EbOR7XKf8yEkuHZcN?=
 =?us-ascii?Q?pJzIQSCKOiwxA0ZrwFlo7tcA5FX4bZWni2HBIFFNdwWmhslStS6GXKP50rKQ?=
 =?us-ascii?Q?JtF2BQZ6KKfjX3HzjSMl58HeaFoop8sgZ8oKOU3My+J/sVOINFkBkKercIft?=
 =?us-ascii?Q?/YXmKnUcITqpzwI/T6vvlZyo+Od5kd9ixo9ARXwKDX5wiRJZVPqMDT8ATx1A?=
 =?us-ascii?Q?Gcm4BWBFXFGIPAOXzCudIiF10+E4gDfLvVqPq4zClCJPglnowa1wBDClQtK/?=
 =?us-ascii?Q?DqthlrUROj2ax9U94kd9DNsMiIImo80BD5Qy813TZZob3aApP15AwELoZi/a?=
 =?us-ascii?Q?BO6KlTy0ZStaB2ckb0/JJtG+RJk972yNJf1U81FULCZaqzR/B5t9mHggM4WB?=
 =?us-ascii?Q?D7OpNLC4kLPdPtOdy/dOY++gdxBxCgBTaQK6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 18:04:29.6073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3cd4f6-8516-41b6-39c5-08ddc3ca0b55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314

The cxl_mem_active_inc()/dec() and cxl_mem_active() helpers were initially
introduced to coordinate suspend/resume behavior. However, upcoming
changes will reuse these helpers to track cxl_mem_probe() activity during
SOFT RESERVED region handling.

To reflect this broader purpose, rename suspend.c to probe_state.c and
remove CONFIG_CXL_SUSPEND Kconfig option. These helpers are now always
built into the CXL core subsystem.

This ensures drivers like cxl_acpi to coordinate with cxl_mem for
region setup and hotplug handling.

Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
While these helpers are no longer specific to suspend, they couldn't be
moved into files like memdev.c or mem.c, as those are built as modules.

The problem is that cxl_mem_active() is invoked by core kernel components
such as kernel/power/suspend.c and hibernate.c, which are built into
vmlinux. If the helpers were moved into a module, it would result in
unresolved symbol errors as symbols are not guaranteed to be available.

One option would be to force memdev.o to be built-in, but that introduces
unnecessary constraints, since it includes broader device management
logic. Instead, I have renamed it to probe_state.c.
---
 drivers/cxl/Kconfig                           | 4 ----
 drivers/cxl/core/Makefile                     | 2 +-
 drivers/cxl/core/{suspend.c => probe_state.c} | 5 ++++-
 drivers/cxl/cxlmem.h                          | 9 ---------
 include/linux/pm.h                            | 7 -------
 5 files changed, 5 insertions(+), 22 deletions(-)
 rename drivers/cxl/core/{suspend.c => probe_state.c} (83%)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314afdb8..d407d2c96a7a 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -189,10 +189,6 @@ config CXL_PORT
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
index 79e2ef81fde8..0fa7aa530de4 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
-obj-$(CONFIG_CXL_SUSPEND) += suspend.o
+obj-y += probe_state.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
 CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
diff --git a/drivers/cxl/core/suspend.c b/drivers/cxl/core/probe_state.c
similarity index 83%
rename from drivers/cxl/core/suspend.c
rename to drivers/cxl/core/probe_state.c
index 29aa5cc5e565..5ba4b4de0e33 100644
--- a/drivers/cxl/core/suspend.c
+++ b/drivers/cxl/core/probe_state.c
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
index 551b0ba2caa1..86e43475a1e1 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -883,17 +883,8 @@ static inline void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd)
 { return; }
 #endif
 
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


