Return-Path: <linux-fsdevel+bounces-69183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A29C71F87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 04:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id C59812CD49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 03:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000FF309F01;
	Thu, 20 Nov 2025 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UA/hQpwE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73CB306B15;
	Thu, 20 Nov 2025 03:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608800; cv=fail; b=MKX2MOTfgsljsHy613z2hrDZmy6wTmCc9obIcHuOWxJL78T4f2txVPBE19X4rRDqsOiMAVnWbNVpJsFjkO1aZNTh1G4sWA+nhK5trZobPmA1wW23swdr1F08Z01igqzMTSCrVAfGi/CHNBIryjmQV6KRnOB+BqbhKC1puWwQOOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608800; c=relaxed/simple;
	bh=OSzygp4WqTgr4ivu7vTopkcfR65fuDfHauepEVpDH+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHBKgiUgZPHeh1bTV8USEqly2zH/VjX8IAfJ39GkUEAzNXc2wY/1YRd/wXeSvWdMS9DIG20YsTEaMQgXL2HHng0m1KXat4adunmvio/Z9/0+jXzq2bLNdxLjKlMicjkQ1wW66LX0U9yAYlovHgQZsff8azUqd2MuST8UvCizuZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UA/hQpwE; arc=fail smtp.client-ip=52.101.193.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fx0kpe2om7Fhx9SRqi24KaoVj8fxgib4vKKfgWnot6++BrrjioB5/pqee9ZuYSHu1eYoZRJbkrnwiP6XxTdicDTrTH3x4e3AlOxIAPCzX5dnajRYNAJ0EvMFQN/+LCBh4rNZVgTt1Dn97fysB8SyPRuoyWBbD/poMhYscrr4x5uh0WAwDB2aWGq/SAJjdzJpV3tBP8KQ2sDps4kSDsNQPLULtlDJtGYyBrK9R5KjVF/SfuF646sDEjoEkm7ny+UCurX/rrCoPz2xpaA0FnkwED+65JsQ7CvjNiPh7DxyYvpdT3SimP/bM4bK5i+dnonQmh84epaRRsZZ4Pz6JV2Jlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9C2fj47eWefGZQqqoTc5BSxLJhD4WcvkOPyLBdzsIo=;
 b=PsHz5W7VXkNBgDtpvvh3tq7LshRS9BWgqoUkar5buBqDts6YikmAeivZZxC/43Q6Y3/jmEU/czBHKaFyLGfq+XTQTDeo9I1P0G0c3lTO4finVD29o4k9QEML+2adaiN176hffv3rFldxzHCfzEVxT73KS+e4sQa5gwDganJ93HkKUXPDBGFDreGouGd+eoR6qUulhdcf1CSGClQPEJ6Ox6s8luttyPvy3Zw1ML0Xw8HWJ1Duqo0GRDlmCAG8oB9SQJzhpxlKpbjuf8WhkAIP7Rj8ltC2TIqjsW0r4J1y6HFGzWHMz3pwEnV33UkZugsXz6Qb1td7CcDd6V5K1l902Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9C2fj47eWefGZQqqoTc5BSxLJhD4WcvkOPyLBdzsIo=;
 b=UA/hQpwE6ohIlqLD3eul1BbQQmLmMiBIijG8unnB2FB4slYe3UievUedf7r55PShGzPwMLYzf7jQdezKJRxrd10EN45lKN+LDpYhJZGjyxuBdhXb3QJ8D65HofYQJOJzzErly4lTGpVvGMDjfv36QXYxVHopWCjJDGMtS63BYTU=
Received: from CH2PR18CA0059.namprd18.prod.outlook.com (2603:10b6:610:55::39)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 03:19:55 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::3d) by CH2PR18CA0059.outlook.office365.com
 (2603:10b6:610:55::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 03:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 03:19:54 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 19:19:40 -0800
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
Subject: [PATCH v4 6/9] cxl/region: Add register_dax flag to defer DAX setup
Date: Thu, 20 Nov 2025 03:19:22 +0000
Message-ID: <20251120031925.87762-7-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: a1328027-235f-4cb3-6040-08de27e3ad2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SYLgpHzE21Ka0LQ0+9/C5YRXkACktLEDhojjXngWHyS+WuLfc5e9Guq4vUmO?=
 =?us-ascii?Q?W9zKaDxXoF2/J7LxyF8Exp5fxlcPlW7ol4//1gu6fMj1matrRFMWIfaPzGri?=
 =?us-ascii?Q?yg2pRj6DNCabUf89BcMW5mEua5ORyhmDfP3bGC/Im1NhoxiuQ/8MHGONdrEW?=
 =?us-ascii?Q?qPNxro7kUBGK+/ygQWbxVPYbUBGVbfU5SesgeKdR/Nrlmj1e5G2P9rZgQh5u?=
 =?us-ascii?Q?WImyWUJ+oC85zZMh+W5ZoctKgmXG7ojkL07PkZZ+EMGc+WQvdqm/AXG8G8uk?=
 =?us-ascii?Q?DAXEnT6+aIT2QkNJE7o7pe7DIW4l8v6G4aVwZJRwpdlwe85hGhE6RF+8Y1Gg?=
 =?us-ascii?Q?Umn5FiT69mFGe2txCXx1mEc0GJsu/98GQnj03A/1YPDtna5kWRKZUqc/AJJp?=
 =?us-ascii?Q?1tOINDDv/IEbmX1WBS2C9DiLMoBdHReApsJufW0+4x4l92IvRcEwXEPQdB83?=
 =?us-ascii?Q?W+T9LV6gqcdDfRK7c1493ErGhZnH+VSUWazUnrXK12vgK1tmvTI5usTAi21T?=
 =?us-ascii?Q?64FuraPAo3KZvfbULzlr2wl5EZD7TL+8/MaHm4ZQ0kyT2Uq44S4kb8dQ66q/?=
 =?us-ascii?Q?NCPNVmKgoaYl2na2Gndg2+E/PekTLlV6iiHdv+jyluBclmt5uX8fyLmRuhvK?=
 =?us-ascii?Q?ebwwg9cVo9tkYL/OE4KQoxGFG6Rl67Llko84S+c/pycy19CJrQcZvJd9W3Bv?=
 =?us-ascii?Q?1sCnye8QeUFHRb4CKvO7J8MexTUt7v2GdlB0OtbSR2Tt+jMXGC36DGGZ1hvQ?=
 =?us-ascii?Q?JsBvt0qKXkQ4vFl9suSpynB01OsM4AVw8MMd3YWS8Q2ZFiNJQBk33gZY8zUz?=
 =?us-ascii?Q?DmYDODgPjactCS8/ykg0V6immTu/W5SUYWYANPy0MO3T/VT8WV1zOd7JvToz?=
 =?us-ascii?Q?BTw4OcTwWCpFUSgsBrkx+GK2L3Q7hgKFJEUWaFNCxIssE0RhC+gOA1IyM9mE?=
 =?us-ascii?Q?nrUKrC8BYW5XhueOFbSR6268Z8hpGI0y+DwtdMLGmUse8DV4oge8G0cF4J4g?=
 =?us-ascii?Q?Jj5a6c0qceaiS1s4hNsH3mVNMaVf3Rw9QXJDat/7nLTIKWyXuVxDLxkfkt+D?=
 =?us-ascii?Q?l3nmyVvsU3vsmu659G9BqMVWBiP6Ze1Zx83H71ZvCKzCBPF+ikxu9Uzk+u8C?=
 =?us-ascii?Q?WRfmqyJnE8O3Sa+QeWoYSPidQF5MHOmFP54FSainnfTjPTzWqBV7W+rI1ON2?=
 =?us-ascii?Q?eVknJfoFvXhik3BU98kSS0BQGe6ool06/N3ossQcVCc+Fi4PdSae719vNcy/?=
 =?us-ascii?Q?Bu1Qg3B/vH4Q0uZgfZD07E8AED8ovGbiG4y8M2JgDNYUuciODLZDxR9Nkeuz?=
 =?us-ascii?Q?iO0uYbAxRcGwrMpvQxtM8wHw6fVvR3hiwmh9KAV8DKIXXasmQULA3ZQ+cu8r?=
 =?us-ascii?Q?c3SYDT6h/R7p+steZRFqbrb2jhNflVRSFs414bhUERAK9GyfBD/bA/JhonzS?=
 =?us-ascii?Q?PoiGFf0vj/jIKO2XVoSutSeqTANOU7lIKGoFj4ff6+WJ+lhj3mYVzb67Sbj1?=
 =?us-ascii?Q?Ct99bONfglW3oS1K2hwnlg0SdeBZ1kWhjf33ISq1WtcP2DMSipB5ot1BRvFL?=
 =?us-ascii?Q?klL4rRgkdFB0r5uTrKQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 03:19:54.9296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1328027-235f-4cb3-6040-08de27e3ad2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424

Stop creating cxl_dax during cxl_region_probe(). Early DAX registration
can online memory before ownership of Soft Reserved ranges is finalized.
This makes it difficult to tear down regions later when HMEM determines
that a region should not claim that range.

Introduce a register_dax flag in struct cxl_region_params and gate DAX
registration on this flag. Leave probe time registration disabled for
regions discovered during early CXL enumeration; set the flag only for
regions created dynamically at runtime to preserve existing behaviour.

This patch prepares the region code for later changes where cxl_dax
setup occurs from the HMEM path only after ownership arbitration
completes.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/core/region.c | 21 ++++++++++++++++-----
 drivers/cxl/cxl.h         |  1 +
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 94dbbd6b5513..c17cd8706b9d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2540,9 +2540,11 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
 static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 					      int id,
 					      enum cxl_partition_mode mode,
-					      enum cxl_decoder_type type)
+					      enum cxl_decoder_type type,
+					      bool register_dax)
 {
 	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
+	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
 	struct device *dev;
 	int rc;
@@ -2553,6 +2555,9 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	cxlr->mode = mode;
 	cxlr->type = type;
 
+	p = &cxlr->params;
+	p->register_dax = register_dax;
+
 	dev = &cxlr->dev;
 	rc = dev_set_name(dev, "region%d", id);
 	if (rc)
@@ -2593,7 +2598,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode, int id,
+					  bool register_dax)
 {
 	int rc;
 
@@ -2615,7 +2621,8 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM,
+				   register_dax);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2629,7 +2636,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, true);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3523,7 +3530,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id), false);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
@@ -3930,6 +3937,10 @@ static int cxl_region_probe(struct device *dev)
 					p->res->start, p->res->end, cxlr,
 					is_system_ram) > 0)
 			return 0;
+
+		if (!p->register_dax)
+			return 0;
+
 		return devm_cxl_add_dax_region(cxlr);
 	default:
 		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index af78c9fd37f2..324220596890 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -495,6 +495,7 @@ struct cxl_region_params {
 	struct cxl_endpoint_decoder *targets[CXL_DECODER_MAX_INTERLEAVE];
 	int nr_targets;
 	resource_size_t cache_size;
+	bool register_dax;
 };
 
 enum cxl_partition_mode {
-- 
2.17.1


