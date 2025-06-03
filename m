Return-Path: <linux-fsdevel+bounces-50526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34719ACCFBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B89174A92
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 22:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A794255F27;
	Tue,  3 Jun 2025 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eEDVdl13"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A36A253954;
	Tue,  3 Jun 2025 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748989211; cv=fail; b=uapT27MscRfFvgH5fg96Wu7Hg2UYjyxpXSJFaP8CTTlE8KyQznJSQZqLkvagdSNOJwCSYfpSu1EF+3JytkTZ3QNBlCT7sBtEbLFIouuQTTrGY0SKXDTmZk+3YO7bsjBPKls18XeL1ZeGj5KxMzZ/5fJDl8kdV+I27AeKQXkN9K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748989211; c=relaxed/simple;
	bh=TR211uIyimTL9/eaHPNjsoUpZ5KgH0uaRqinawUN7nA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgH8GE8YF8AH7Pt4MDGTV+MIPybM1HOHG0ohEeKagj9DHtLFIOjHn76P+2MEXPbBlPgZIo2qe70UzM2aUEMXEIPL0ZDpNj2rasrZGLMIE8vcXmyVHm7fZ6jdYKXdXbQQLUG31LB1wWEMaxx9dPqnBPyRxCplBvIp6BpFllH7CH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eEDVdl13; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZfwZcLzRhPKpFAk9XhcknJy98qkdRsvE936UQfLTJqw7YqgHgiRxQ7pemRIG1Vuj4zc9c1GrNd2ZnA2F8xH24vdm4caxsfm2cMyFL0eXn0nQkUSIx8Ln5UyFBO17TvQm2ySSo/28Yn1g0melVONSa8+4Pmvvc/Oat+LqQsgd9BCjOlu9tUVWMkeQanmerGyKJKWTzi+l/wKWOPJp1v6Rm2L0wCMzuKeUlWJHy4FSC8KZJyMuG6g4IlSCNFy6Rn77tKglKZ8pKi6nVb296tm+Tp6TpiVU9MFuBD3aTRE1CJCjNdo01NftanOAVSjceFjCjuysF8e1WkmEkKE2zBd5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysrIpvkXovWCi2qQ/IJ3H4A655vB7ZwzzwefMEzAjMg=;
 b=j4G95OxArllbvlRDOulFyQC2McKVymnmXrP7pplOfBIY7eJF+1SGA5/lYi5nuyp61oaCzNuvRuXPTSedFtz5r6PBm7NVSIPsaXjTSvg48MWz7B20yhV/eRVqU25TBems7vW+g5TRyjU8BmfhOOwDQfrabNinssIgtdE9BTAie6fz3C8Ik+KVjhxa/5/2nIwRIl5wUZY7ajYqh/RKU5s/fno9tSuIfXjaipQEXzNDHQEAHhY9Y1TgK1PZo4Y4tRZ409GaICvU7+Zrp5nqSOqYLhIeFjLvC4A8CHoVvpvtThglflEkQ+PymmH3ebWXMnLBAIW50yJpj0S4aQ+w2V4+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysrIpvkXovWCi2qQ/IJ3H4A655vB7ZwzzwefMEzAjMg=;
 b=eEDVdl13RSORAEXIVCKOwHD8caeWSHxOLPAGBC5o5jY81gzF2tZ/BQ8H43HyOISIusQqUosuU0IketLEXUrFEPS2j4zA6Ac+//JVBl4oRbDTxja+itwnflFKB5SSCX3n2avDnOEI4NZv0GUTJsq+RHNI7B3qDQzFz13D9pNZXk0=
Received: from CY5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:930:1e::27)
 by SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Tue, 3 Jun
 2025 22:20:03 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::7b) by CY5PR04CA0007.outlook.office365.com
 (2603:10b6:930:1e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Tue,
 3 Jun 2025 22:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 22:20:02 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 17:20:01 -0500
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
Subject: [PATCH v4 1/7] cxl/region: Avoid null pointer dereference in is_cxl_region()
Date: Tue, 3 Jun 2025 22:19:43 +0000
Message-ID: <20250603221949.53272-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: d63db762-1d1e-480c-c211-08dda2ecc914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j+2M27VX181utQc6vDwgYJXrs3yAz4drNYbJI91m84R/XFpGsCEBV7y7cHR+?=
 =?us-ascii?Q?P80Kg4UPi9c9C0XGwNdyX8rJjO8nyUlRVkjFyVuUbvRhfU1H9zf+cH0cKZqJ?=
 =?us-ascii?Q?cdPTV75V4vDOl01Ul8ZPF1VB/xSTROs+mkGm6zDSIJNEb5TCGbZKa91gNZ2U?=
 =?us-ascii?Q?id+ViOP25n98Ko54q1GLtlu/MO6U/X86osdpOgWUYWQBDdLxHmqDtDaPPefY?=
 =?us-ascii?Q?/4SBAMcJgFuaKjCFwU1da+cZzf4Ydkv7a9mex/IGfmqqEqc+CDmYBhCWze8g?=
 =?us-ascii?Q?LByt3GOrOzX3mVo1XN7NeGh2Xb8iT00XLMtxZ1TQMoIBkri0nRP2BeArYb39?=
 =?us-ascii?Q?3F0mDKbKNABKkVpeT24OEDKPAw2cYkpNZxP4mdjdmwos4NqQlrIDTgOWUNpx?=
 =?us-ascii?Q?O37BRCPlFjWa4BDb0+BpBabGQGGJ8HEePkWLtAmjldwgbLsxIPBNlf6IEtP0?=
 =?us-ascii?Q?0jNgdaVFlG+N5tOnvHj5BZHGSI1htj0P+zPO1614O3XEE7B/G05CN9O7y8pP?=
 =?us-ascii?Q?s3wjtAiR1gDuIAlS69oNF2gH3N/GKJz5zmHZF7iwYXXof1n0HCROca8WRTui?=
 =?us-ascii?Q?Gr9Gt8GA+903QMCDV7XNsAcRcdS0lYV9qG/RFZ482ql6ewZW6pLj/iMoZlgI?=
 =?us-ascii?Q?GQ7adJvyPBW3NddLfrwes6n0lsOfO2quAhIcCBubcqVUkGivvdPqhnHOzlUi?=
 =?us-ascii?Q?m/VAOJVy/l+DzvJZF49ImTnEL+KG6na0NYm0VMYTYuKN+mYUTTWc07WX3zjy?=
 =?us-ascii?Q?l0ySt0JVHUFoiGvjBePrEQIikkBrVN5ra1wMoq8YH/ygBsXGtI1I70KHG/P7?=
 =?us-ascii?Q?p9DZfL1g/uTTxfCUQkRBK4Qc3L3IkUSR0aNxNJJxon/Su9oHjlEfsSNx2LfF?=
 =?us-ascii?Q?lapxI7sg6owdrvYXsFZA4thbNa7d7JUCys/4W+zZe1nABLOCSLhCNDFYIN1r?=
 =?us-ascii?Q?Jde9ZZ8iD91Um3hMowFpTFGpxp9TBI8uWsmFONUxh13/CK3H754x3iKcArAi?=
 =?us-ascii?Q?ejp1ngx3OxnWzyAb0strnckGNMSCRzqzh7c3m3sH06ImmnhXWEhwfWSqjy5Y?=
 =?us-ascii?Q?uSDtjrSg+PH+NC08NsTkmogNP/qciR3cmRYC4KkNYcMrQ5fbvuHwI3vqm1+0?=
 =?us-ascii?Q?E0XSyv/8z3xacem3GkdyHC16DHEtGwIVAy2hbQp4fUZCKV7LDVI73Z7g8nGq?=
 =?us-ascii?Q?7oB+87UD97z3k18laN9d6KaCftpa/A3pRkVxyPuBjLH39WFRL1wr0SzA25wl?=
 =?us-ascii?Q?lQPBjPNY6yXRnerK1wBgCdv57adXU3DjpSNqEpB/sYH2F92QCQO6RxjON4NR?=
 =?us-ascii?Q?eWtmUAROEjwPTxHkwyTg+L3NrIBlvCRrM/8EgGhnp0Ujy8ghmwbbYawP92w7?=
 =?us-ascii?Q?CHWffJ20/x5xqjpbzSd2AFY9wI5C8oNpVb2R3iIFMJd2Mj1VWDWlssq3w/ij?=
 =?us-ascii?Q?vWZOFTLJWpl5f1p9sSDLuHf3K4AyaT0/MNI9yelXOzGqRzR7Y5wUjK1GD7By?=
 =?us-ascii?Q?ZgRvWpRI61rI2Afx06nNPVD7g7abJYLcSAJ6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 22:20:02.5024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d63db762-1d1e-480c-c211-08dda2ecc914
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224

Add a NULL check in is_cxl_region() to prevent potential null pointer
dereference if a caller passes a NULL device. This change ensures the
function safely returns false instead of triggering undefined behavior
when dev is NULL.

Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c3f4dc244df7..109b8a98c4c7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2333,7 +2333,7 @@ const struct device_type cxl_region_type = {
 
 bool is_cxl_region(struct device *dev)
 {
-	return dev->type == &cxl_region_type;
+	return dev && dev->type == &cxl_region_type;
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_region, "CXL");
 
-- 
2.17.1


