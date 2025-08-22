Return-Path: <linux-fsdevel+bounces-58737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A20B30CC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 05:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA0C1CE2D75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 03:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5BD17AE11;
	Fri, 22 Aug 2025 03:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xNAVZyz1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A029994B;
	Fri, 22 Aug 2025 03:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834147; cv=fail; b=PNW593uLt49FoxWzyxz1f5GRn0RRApCE/61qtb5rdrPsAVfk+bei/JYFaPrRC0LvLoMO416JgzOCVdi0v15HfCrgiBF6VCyegWOve09pF06nn5LfQKOboHKd/vAfnkVrheFb/aq2iTLqbsntgF8c4B85tosjFROhYWcY3LukPQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834147; c=relaxed/simple;
	bh=QHZ+cDCy+qyBNKOn6zxrBOfKLYEtulfBEuSvoJhkOjI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3Nv2ca9o1aD4Wx2CbhxFt20u7FJn+MXtfzEh/QBhWpL0l0U3syDeOvr3XtZjkYsCpBNE4VKaEwOP8tGJthGs5ayC6623zfiyGFBrTuJfzwKp477H4xRCBtQVy1Rk0vFDDwTxquSsZ7FDDROvYwS9C4L7wje/aRe9oPC8KVavXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xNAVZyz1; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAIGUTs+465Qg7Jpb2ddWKyugpi3WADSZgbtU0d56bJ0NHGDwbEFVOIA/A5XncBdK8z0wHVeDPB3+Cj0NiNCnOLLTTJzf9dn0z3DFFSaAnwBCVClc6txWOrwxHtarIka7qgHt3YGa8pbmFc4VKMOABgnvYj8qtdvos+ibSRgUUCqu3IsJ6tVA1MsDVtVXdmFlNNe+vI1yhZMr7QV+gINGGEMS3TEC7s9AX7KdZ7FNui/s6XC9+xiEa1i+A9VlQX/wCt4MQ8bRpDC9MCQhNZVrhEoM7axSayvIWba+XKyARDdCPFMOGQpjHCLoxZ1Y4oXSrizKJQiRalAueS0enVGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xMrOwc5VBxCl2DlrXqvAwcrz/6+g4wlVF6XcA6wb2g=;
 b=UyFLrkenTBgEk2kZnCX8pqDTsu+nhYnOzYAEPijlNJML9IH5FOjgfbedQw2EzCfnF4OxzI0qNTaxnYNN/j6qUj5sl66TY1z15bx4B1h6db3Ah9RjQYIN+7YXl4Cj4xWSg7UCODLwtXb4o2IPB6fCpBRsz0YKv6qOV0UNuhDd8ImlzL+EvzwJjXp37qjP29MDabehc+wzM1lcGa0MmR25Bh+NRKHc0KgH3uGQCfIHBCOjKxxgOPKJvVkzR+4j6z7B+khA/RJVgolnIX2A9jyznCkeb+e47U5ZsyUzI2yzolg5AYW5MtjmY5AP6pK3UZFAWYNqCR665rwsEn99HI/oIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xMrOwc5VBxCl2DlrXqvAwcrz/6+g4wlVF6XcA6wb2g=;
 b=xNAVZyz1z+ZuYgNugjmgjwrspt7suVRJfKAnnHaz896lxUI5sRmf1g4cQssIqPte6e3mY0zQjVYMDiFz9rRhwur3k6wbqeQ4heEOL92hcIcY0E6/RzjTlyb+GPR6Nn3cBan5sboArIGtgXONKo+dTv0jmKLC/SiozjwjSsWEXPg=
Received: from MN2PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:23a::25)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Fri, 22 Aug
 2025 03:42:22 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::c) by MN2PR03CA0020.outlook.office365.com
 (2603:10b6:208:23a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 03:42:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 03:42:21 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 22:42:20 -0500
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
Subject: [RFC PATCH 6/6] cxl/region, dax/hmem: Guard CXL DAX region creation and tighten HMEM deps
Date: Fri, 22 Aug 2025 03:42:02 +0000
Message-ID: <20250822034202.26896-7-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|BY5PR12MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: c305e812-4e7e-4247-7785-08dde12de6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGZORGUrUXJueS9tL2MwNHczcGhxYWV2U0RFWUhvdjE4bkh3SXlyMnVDbW1h?=
 =?utf-8?B?TUxsRExON1pYVEJWaE9KWGliTTROWnBvNnhjSkpUNXo1RDk3cmlzSG5oWEhn?=
 =?utf-8?B?dDIzMnA2bnRLWGg4VmpMYUNEaTNjelpkN2Nscmx4V3RGL3BDTU1wR2hmdWFU?=
 =?utf-8?B?UHNZemIrV21vZlBpV0lSVE9DTW1NdmNUTHlQRjltR3Aya2txMGdmd243ei9s?=
 =?utf-8?B?UEcvNm5lR21JUmpSeUZ6U1VId2lrc1NkalptcXV5Y0FyVmJKWmVQSzI0RDRI?=
 =?utf-8?B?ckg0c0RHMklPaUxvRWFoVW03UlZZY3BnWnBzOGErRFllTGJIZ1VVTERZV1JL?=
 =?utf-8?B?MFoxT3dzYnBTMjlQa1lpazJFTkdSb2UxQ0hLL2dXZTlWNS9NMFJIVWF1dExF?=
 =?utf-8?B?VXoxcFJpZWlaaVlJK3pmSTROb3drUVRmTm4yR2hKRjFHZEgvaU9wdndIRHhG?=
 =?utf-8?B?aWp5djJwQlNGb1V5eG9nU2dzbmVRRHlOWDN0bVpuQjUyYVg2TGRNbG5QRHhl?=
 =?utf-8?B?Q1MxenBlSU04cnFmMFZoN1ByU2tkUEw3Nk1Jb3ZKUDNQN1BkRmRpWjlxSXdN?=
 =?utf-8?B?ZUpLbHdyQnh0cFNZTEl3Ty84aGRTMy9hUTFUVmlHV2RhNk9IYnhGV0ZtVjZ5?=
 =?utf-8?B?Vm42Tjhxa3ZBZWp4T0U4RU56NFZFWmdJOE5neE9ZZWVOZlc3Q3AyN0YrN2Y3?=
 =?utf-8?B?RmM5NjRjN2doUmpha0JUekpJVVhFdnlrTlRCQVFRL2cxODREem1vYkFtUmlE?=
 =?utf-8?B?MDRHUjJKUFMwT3ZneFRWNDE0b2l3Tzlob0cxR0NhNEk3TEdvSE5wa0k0R3dx?=
 =?utf-8?B?NnBNbVI3Qlh6WHplc1kzdHlRR0JwNDRwdjgvS3hSejY2Rk1yRUNibmpXemxu?=
 =?utf-8?B?eXNmamRpdERteUc2YStjeWxGb3lDT0s3SXhINXgwOGg3OEc0RDl2czRWaWsz?=
 =?utf-8?B?eGdPelFqK3gvZ1hkd01HTEdCNFhsakRLZFBkcUhXSS96Rkp2NmNLSlFJNnQr?=
 =?utf-8?B?SlFPRGVKNDd3Ym1rMFhwZ0w5L1lHcm12REZTVmhNV0pzS0ZxWS9BRXlDMDJv?=
 =?utf-8?B?UnVRQ3NXTXkzK1NYMGlpaGVTZkg1eFdwYWFmNTQ5RkJJNTUrUGVQV09iVzUz?=
 =?utf-8?B?R2RaOFA2bk51d1I0b1BVQVhncjBiQ0E5c3JqK0tYQWQ0Tm05WFRRSXcwR1Q2?=
 =?utf-8?B?Rklmb2dETm9MQlpnSEVjTHNPSWRnbzl1UzN3emtLRm5tTWNyU0ZVRmlWbHNj?=
 =?utf-8?B?K1FEL1d6QktLU2hCdHpjUlBiUWFraVZES0ZKc3BDdUllSnZYeGFPK0xZcHUw?=
 =?utf-8?B?UVBxWEJFcDNUNjlBbCtTY1VLOE5hZTBxM1NQODZ1cjFSYVRWeDVZeExHUWdv?=
 =?utf-8?B?RzE0ZTNoZ05HSFdXczhiZSsvNnRrK0QxNHBOSUdWYUFCT3V5U24xdFBXUnJl?=
 =?utf-8?B?SExMNG42djVLTWFNUFVwUzU0dlJvOWdkN01WVFJaMWxBT291K2g1aW1DNHBa?=
 =?utf-8?B?N0hiN2YwTDlmTzdlNEl0OEt4SjBvRGV0MVNKYVo5SG1tKy9Sa1JDNW5idDdC?=
 =?utf-8?B?V0U1NTAxZEgvK1UvR3JlNGIyVmFqcm5QVEZJTmpuK3l0UDF0Wm8vWk5hcnZV?=
 =?utf-8?B?cWo5QXhwL3hJSkkydHRXcEhDU3FubDF4QjhFZjFGSmhmQmM5LzNkekhlOWdC?=
 =?utf-8?B?a0xvdnJNU05IY20zVG5pcGFtL2p1YXZXWUpVSkgzb2xqMkc0dWx2bE9OMWtU?=
 =?utf-8?B?U2hKcngwTUh6M0YvVGR6dktoK1hvU0sxQkVXaDI3VXg4NmpheFI5N2Q2aEN5?=
 =?utf-8?B?UUZ6emphN3hhNjBqaFBBSGhiTzZQcnJPT1A1R2RZMVY3ZnFmWjk4OWlBdWMy?=
 =?utf-8?B?UnY4ZVZ4MWlxL3RIdmQ1NzY0UmdvMFlLbFVTazZOS2NDUzRBSGJmZnYvQVpk?=
 =?utf-8?B?ck5ZNmt3R2YzY1hFUGxWd3FUZUJxT052c1RmNC9kMllDOEh6enpZdWRFaVUr?=
 =?utf-8?B?dlZrRncyckNYUkJqSjZOU2d6YjNOelRCdmMweXBDMkp0czluUU16NUNDSmVp?=
 =?utf-8?Q?B/tSmy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 03:42:21.5102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c305e812-4e7e-4247-7785-08dde12de6a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305

Prevent cxl_region_probe() from unconditionally calling into
devm_cxl_add_dax_region() when the DEV_DAX_CXL driver is not enabled.
Wrap the call with IS_ENABLED(CONFIG_DEV_DAX_CXL) so region probe skips
DAX setup cleanly if no consumer is present.

In parallel, update DEV_DAX_HMEM’s Kconfig to depend on
!CXL_BUS || (CXL_ACPI && CXL_PCI) || m. This ensures:

Built-in (y) HMEM is allowed when CXL is disabled, or when the full
CXL discovery stack is built-in. Module (m) HMEM remains always possible.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
I did not want to override Dan’s original approach, so I am posting this
as an RFC.

This patch addresses a corner case when applied on top of Patches 1–5.

When DEV_DAX_HMEM=y and CXL=m, the DEV_DAX_CXL option ends up disabled.
In that configuration, with Patches 1–5 applied, ownership of the Soft
Reserved ranges falls back to dax_hmem. As a result, /proc/iomem looks
like this:

850000000-284fffffff : CXL Window 0
  850000000-284fffffff : region3
    850000000-284fffffff : Soft Reserved
      850000000-284fffffff : dax0.0
        850000000-284fffffff : System RAM (kmem)
2850000000-484fffffff : CXL Window 1
  2850000000-484fffffff : region4
    2850000000-484fffffff : Soft Reserved
      2850000000-484fffffff : dax1.0
        2850000000-484fffffff : System RAM (kmem)
4850000000-684fffffff : CXL Window 2
  4850000000-684fffffff : region5
    4850000000-684fffffff : Soft Reserved
      4850000000-684fffffff : dax2.0
        4850000000-684fffffff : System RAM (kmem)

In this case the dax devices are created by dax_hmem, not by dax_cxl.
Consequently, a "cxl disable-region <regionx>" operation does not
unregister these devices. In addition, the dmesg output can be misleading
to users, since it looks like the CXL region driver created the devdax
devices:

  devm_cxl_add_region: cxl_acpi ACPI0017:00: decoder0.2: created region5
  ..
  ..

This patch addresses those situations. I am not entirely sure how clean
the approach of using “|| m” is, so I am sending it as RFC for feedback.
---
 drivers/cxl/core/region.c | 4 +++-
 drivers/dax/Kconfig       | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 71cc42d05248..6a2c21e55dbc 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3617,7 +3617,9 @@ static int cxl_region_probe(struct device *dev)
 					p->res->start, p->res->end, cxlr,
 					is_system_ram) > 0)
 			return 0;
-		return devm_cxl_add_dax_region(cxlr);
+		if (IS_ENABLED(CONFIG_DEV_DAX_CXL))
+			return devm_cxl_add_dax_region(cxlr);
+		return 0;
 	default:
 		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
 			cxlr->mode);
diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index 3683bb3f2311..fd12cca91c78 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -30,6 +30,7 @@ config DEV_DAX_PMEM
 config DEV_DAX_HMEM
 	tristate "HMEM DAX: direct access to 'specific purpose' memory"
 	depends on EFI_SOFT_RESERVE
+	depends on !CXL_BUS || (CXL_ACPI && CXL_PCI) || m
 	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
 	default DEV_DAX
 	help
-- 
2.17.1


