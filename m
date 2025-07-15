Return-Path: <linux-fsdevel+bounces-55013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C51B06591
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513E94A31D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF4929E0E9;
	Tue, 15 Jul 2025 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CEdIx7Mx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F0229B206;
	Tue, 15 Jul 2025 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752602675; cv=fail; b=lHj2qjo1WLVDMKzvYTRD7EmU+ATnpf7pIzCCXfkV35ei0G0BT5CvOFZ6DOnh/V2tfnvWpIRS7N8d9tJX/M/Gvimff+Cyol68s/am06fS0zmO6B9aHZqWDArhuU0g/TIcwqkWoSijBzyO6YVgjeqdYlwh5346bDVLckLW1Tk50zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752602675; c=relaxed/simple;
	bh=nT+7esWnGIEqFbX/VlGU2QiF4INLVXoiRpAunxZEFSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeXGDLQSFWF9/yk4eCgntQnER+Dg14FB5/ngxsnO2BEzXuTMcuo+KQHfwhiZEryexQW/22RtxURr4okbb5jC0ZzFx7fTfpXNFvecBfumUPibgeyV/HGYO8vo8J9N+v5AfwrIPfub4P+NVRzYX61LWzx40SkLsIM9m3M/vbYCqGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CEdIx7Mx; arc=fail smtp.client-ip=40.107.101.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZ6Z2QdOXp0tdTrC9zC/bjLLOIjLwqqTH/4Uu0TvBEv7hEtnozSa/4pmvpWRv68EWYqmd9wsbWaTrS89NH59z+WRgaHKtyPPTcjy1h8Qp4x32qBmPy6ejCbjIwr1SG711TLdEmXcPnPxYQg+eaVZaFqsudJeBxkUp8HrafMTWIEwnWq1sqgB1APAKmTzEQcJe8M3mshhYujjoIt/nzZaCs5XaBtdNO0y4xfWztT4zEvhwjPLlfSdNxdcCAPY7uaGbG3dQWryn95jJIrQkjc0dngyTr81qvRl8iSCnZvJ6KWS1kU6haBQr/jZFp9vE/UDw4PGynBtFGD1FfWq4UnQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7m+dCGNO7fGDIgOpTkEGPiONiV1JFCz4LTL8dwwtIw=;
 b=Zbq8pvP70G/ewFu7wPAmU3Oh/ZDUk4YmXW4NJWzR41EAuHsrpaNcJeMewIhT+s/UIDPWxqYyKWgMk/egvbpR9G3zybxCuagSbFpBtQRZQ1dQAHVJIkzGr7+vRrWZnUQk/e7fwz2UJuI7dzNNzrinpD9f7Rq8xfb8a1DcFYt5luT23sDuCyu6jsJIop8oKCNMeA6BapgkrRAuHdgc9Tn6fDRb+Lgwye4V+Lye22go8WZRVu3q5HDOIH3SYnV36yjKNHWm7nXxI7Ur1kIX68imeNgcpmuLjr4bU2nMIhf/jZ6tc0Re8enaxoP7FcZyU0uKKss69iy1b1C4nYhj4OlkLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7m+dCGNO7fGDIgOpTkEGPiONiV1JFCz4LTL8dwwtIw=;
 b=CEdIx7MxkqHBg3NqVxdfIMVxgUKPXHtwewaJvoagGJcmfF3yPMlZcN5cdKmBrvtBDoiaCRtRk79Vdd5FBYkY2lC4rEROunz6Ax/mQGptPWsWBiBv4hsEgL/2M+rwv31MmW58eBtbE05eqkiZCa/0lTnwyvBa6KGQs0/Zry/y5JY=
Received: from BY5PR17CA0052.namprd17.prod.outlook.com (2603:10b6:a03:167::29)
 by DS4PR12MB9681.namprd12.prod.outlook.com (2603:10b6:8:281::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 18:04:31 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::6f) by BY5PR17CA0052.outlook.office365.com
 (2603:10b6:a03:167::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 18:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 18:04:30 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 13:04:28 -0500
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
Subject: [PATCH v5 4/7] cxl/region: Introduce SOFT RESERVED resource removal on region teardown
Date: Tue, 15 Jul 2025 18:04:04 +0000
Message-ID: <20250715180407.47426-5-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|DS4PR12MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: f2286c7b-37bc-45d1-a743-08ddc3ca0c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GvKmdGLLHwvEkNUW7RzPcVZCqQhsem4BT3SLt/P2nrwotennorFMeqdHzz1V?=
 =?us-ascii?Q?t/ivmiJziO29yO4rwUPV/70utBj8o07qppMKdRqBaABp75yxq/9j/FXg6K36?=
 =?us-ascii?Q?BH6haF2a65VjzkTwDDrBTKjzsQGyvRAnbHtUXm7RqK6LuLlgzjUShvq6lR+k?=
 =?us-ascii?Q?FGQnhbDTXuLHco7Xgy/afUVIGm3PKEfzfuWsskSAPoWwpnPNhmk0KSSNj+Z8?=
 =?us-ascii?Q?MazqACtoYvySzDcS4sIyxppvAe78eiwBHDpxRmINvDwqc6Wnh3AIfwtvHKnl?=
 =?us-ascii?Q?vBO1oo46GFrUxXSbXxAtxzS3IQoIYEu0o7Qi1tsa9U+vBa+qaITdV44G9TWb?=
 =?us-ascii?Q?QLsBDbm3BE+HLzvbJLB7KUbSBqpY20Y5LH7NNAI14BQEe+EICgBHCoZk/E5p?=
 =?us-ascii?Q?uStiQPn/nwKrRfexlKY5c+hWHu1oayh4hmEcXdY3gkkpLR2rLDNxN6d/xMA9?=
 =?us-ascii?Q?2XQ6T2ErRzSWr2rTJgz5xDxNzP+romkihTIIUduu0G8N25aIMIkwYLmHeQVk?=
 =?us-ascii?Q?TVGY8iaTEBEABHFWAzUNJesmInuOJ2yjaVxmpFcjaQq32hQtFY8Jp7wtGmoJ?=
 =?us-ascii?Q?znfzwgf2Ei2698IQAGTxawlz07dmi0x0/Ip/R0r3PTTirlYuUqCtQyd9rLFF?=
 =?us-ascii?Q?yWXrqlmySOd85cgdYtr1Sm4kWYsOXfPClqAWnMpj3XGKSS/BrjlyF6y+IfwS?=
 =?us-ascii?Q?FTwXMGLuXFzxF6y6GPAY2v+cr8RY9Fea3QG9GgNYaub07iF1QZ2BsHaQ5vXS?=
 =?us-ascii?Q?urj4WA8od4n9oFvfUmawz6SULrb5h57ttMoQ9FMQFiMwaV8jNVzQ08sQKfjL?=
 =?us-ascii?Q?sPoeHj6ByJjmBuxe5VqonCt/RO76gf8xCAqpsOxpVL7reflxKMshFmQV7F40?=
 =?us-ascii?Q?XBpPrARUlApEkbWXZSKeO5EVQNgjrxjJWJ6jlLK+AZzedqoZKDNbyZFtyN2Y?=
 =?us-ascii?Q?+FPnMpcr1wMF324oMmcyOFrl0Mts9pVGFqCjNzEf4Iq1BWAcFT8mljzos/3N?=
 =?us-ascii?Q?xoKKyPkW++7HzEK9Aci3yxghzkO4orRGlJ0iNuZAj6+Z5P8Riq8vXQuQvZXL?=
 =?us-ascii?Q?whK4so6mbd4/iuP6DZ1z3mW/1T0DppGsPRaII/gvGd6+AzvJNEkVnrwGwj5c?=
 =?us-ascii?Q?CKmtbspPQ4DNMJmNusNrst1u1IlGe3uxmnElDsxVMl1ztdk/hb3QNQnhpVJI?=
 =?us-ascii?Q?TtDT2YgKs8BDYdI23aWJapkQbgw4bR/5pV6LzDVB4xQzlzG1eYToLsjrmbwD?=
 =?us-ascii?Q?jDkW5Lui9UzICGz6XHwVKU9mhrlomdORAsBN9rVWO2q3DPddjgHEpwv969qx?=
 =?us-ascii?Q?WsLElkkkWN0Boaq9Uok146KFJWZCGzgwxIjb9wzYihRhiBZENUxuibMQLgU5?=
 =?us-ascii?Q?CbIDoGpXuXuMRP5b4xaiJZbtBonc25LCol1hXwZuH2qDVeyNzi0PNcd5znjP?=
 =?us-ascii?Q?xynlQUmpKkGw6UnP29C84gUMwoKRCYHJVUOQl0A4f/lbXpmnSLDbkN5jroa3?=
 =?us-ascii?Q?lWcljhVZLprsnbML/+vIBrpS+cAKpLEVnlVA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 18:04:30.9405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2286c7b-37bc-45d1-a743-08ddc3ca0c20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9681

Reworked from a patch by Alison Schofield <alison.schofield@intel.com>

Previously, when CXL regions were created through autodiscovery and their
resources overlapped with SOFT RESERVED ranges, the soft reserved resource
remained in place after region teardown. This left the HPA range
unavailable for reuse even after the region was destroyed.

Enhance the logic to reliably remove SOFT RESERVED resources associated
with a region, regardless of alignment or hierarchy in the iomem tree.

Link: https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
Co-developed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/acpi.c        |   2 +
 drivers/cxl/core/region.c | 124 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   2 +
 include/linux/ioport.h    |   1 +
 kernel/resource.c         |  34 +++++++++++
 5 files changed, 163 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 3a27289e669b..9eb8a9587dee 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -829,6 +829,8 @@ static void cxl_softreserv_mem_work_fn(struct work_struct *work)
 		pr_debug("Timeout waiting for cxl_mem probing");
 
 	wait_for_device_probe();
+
+	cxl_region_softreserv_update();
 }
 static DECLARE_WORK(cxl_sr_work, cxl_softreserv_mem_work_fn);
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6e5e1460068d..95951a1f1cab 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3486,6 +3486,130 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
 
+static int add_soft_reserved(resource_size_t start, resource_size_t len,
+			     unsigned long flags)
+{
+	struct resource *res = kzalloc(sizeof(*res), GFP_KERNEL);
+	int rc;
+
+	if (!res)
+		return -ENOMEM;
+
+	*res = DEFINE_RES_NAMED_DESC(start, len, "Soft Reserved",
+				     flags | IORESOURCE_MEM,
+				     IORES_DESC_SOFT_RESERVED);
+
+	rc = insert_resource(&iomem_resource, res);
+	if (rc) {
+		kfree(res);
+		return rc;
+	}
+
+	return 0;
+}
+
+static void remove_soft_reserved(struct cxl_region *cxlr, struct resource *soft,
+				 resource_size_t start, resource_size_t end)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	resource_size_t new_start, new_end;
+	int rc;
+
+	guard(mutex)(&cxlrd->range_lock);
+
+	if (soft->start == start && soft->end == end) {
+		/*
+		 * Exact alignment at both start and end. The entire region is
+		 * removed below.
+		 */
+
+	} else if (soft->start == start || soft->end == end) {
+		/* Aligns at either resource start or end */
+		if (soft->start == start) {
+			new_start = end + 1;
+			new_end = soft->end;
+		} else {
+			new_start = soft->start;
+			new_end = start - 1;
+		}
+
+		/*
+		 * Reuse original flags as the trimmed portion retains the same
+		 * memory type and access characteristics.
+		 */
+		rc = add_soft_reserved(new_start, new_end - new_start + 1,
+				       soft->flags);
+		if (rc)
+			dev_warn(&cxlr->dev,
+				 "cannot add new soft reserved resource at %pa\n",
+				 &new_start);
+
+	} else {
+		/* No alignment - Split into two new soft reserved regions */
+		new_start = soft->start;
+		new_end = soft->end;
+
+		rc = add_soft_reserved(new_start, start - new_start,
+				       soft->flags);
+		if (rc)
+			dev_warn(&cxlr->dev,
+				 "cannot add new soft reserved resource at %pa\n",
+				 &new_start);
+
+		rc = add_soft_reserved(end + 1, new_end - end, soft->flags);
+		if (rc)
+			dev_warn(&cxlr->dev,
+				 "cannot add new soft reserved resource at %pa + 1\n",
+				 &end);
+	}
+
+	rc = remove_resource(soft);
+	if (rc)
+		dev_warn(&cxlr->dev, "cannot remove soft reserved resource %pr\n",
+			 soft);
+}
+
+static int __cxl_region_softreserv_update(struct resource *soft,
+					  void *_cxlr)
+{
+	struct cxl_region *cxlr = _cxlr;
+	struct resource *res = cxlr->params.res;
+
+	/* Skip non-intersecting soft-reserved regions */
+	if (soft->end < res->start || soft->start > res->end)
+		return 0;
+
+	soft = normalize_resource(soft);
+	if (!soft)
+		return -EINVAL;
+
+	remove_soft_reserved(cxlr, soft, res->start, res->end);
+
+	return 0;
+}
+
+static int cxl_region_softreserv_update_cb(struct device *dev, void *data)
+{
+	struct cxl_region *cxlr;
+
+	if (!is_cxl_region(dev))
+		return 0;
+
+	cxlr = to_cxl_region(dev);
+
+	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED, IORESOURCE_MEM, 0, -1,
+			    cxlr, __cxl_region_softreserv_update);
+
+	return 0;
+}
+
+void cxl_region_softreserv_update(void)
+{
+	bus_for_each_dev(&cxl_bus_type, NULL, NULL,
+			 cxl_region_softreserv_update_cb);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_region_softreserv_update, "CXL");
+
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
 {
 	struct cxl_region_ref *iter;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3117136f0208..9f173467e497 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -862,6 +862,7 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
+void cxl_region_softreserv_update(void);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
 {
@@ -884,6 +885,7 @@ static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
 {
 	return 0;
 }
+static inline void cxl_region_softreserv_update(void) { }
 #endif
 
 void cxl_endpoint_parse_cdat(struct cxl_port *port);
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index e8b2d6aa4013..8693e095d32b 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -233,6 +233,7 @@ struct resource_constraint {
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
 
+extern struct resource *normalize_resource(struct resource *res);
 extern struct resource *request_resource_conflict(struct resource *root, struct resource *new);
 extern int request_resource(struct resource *root, struct resource *new);
 extern int release_resource(struct resource *new);
diff --git a/kernel/resource.c b/kernel/resource.c
index 8d3e6ed0bdc1..3d8dc2a59cb2 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -50,6 +50,40 @@ EXPORT_SYMBOL(iomem_resource);
 
 static DEFINE_RWLOCK(resource_lock);
 
+/*
+ * normalize_resource
+ *
+ * The walk_iomem_res_desc() returns a copy of a resource, not a reference
+ * to the actual resource in the iomem_resource tree. As a result,
+ * __release_resource() which relies on pointer equality will fail.
+ *
+ * This helper walks the children of the resource's parent to find and
+ * return the original resource pointer that matches the given resource's
+ * start and end addresses.
+ *
+ * Return: Pointer to the matching original resource in iomem_resource, or
+ *         NULL if not found or invalid input.
+ */
+struct resource *normalize_resource(struct resource *res)
+{
+	if (!res || !res->parent)
+		return NULL;
+
+	read_lock(&resource_lock);
+	for (struct resource *res_iter = res->parent->child; res_iter != NULL;
+	     res_iter = res_iter->sibling) {
+		if ((res_iter->start == res->start) &&
+		    (res_iter->end == res->end)) {
+			read_unlock(&resource_lock);
+			return res_iter;
+		}
+	}
+
+	read_unlock(&resource_lock);
+	return NULL;
+}
+EXPORT_SYMBOL_NS_GPL(normalize_resource, "CXL");
+
 /*
  * Return the next node of @p in pre-order tree traversal.  If
  * @skip_children is true, skip the descendant nodes of @p in
-- 
2.17.1


