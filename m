Return-Path: <linux-fsdevel+bounces-69181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CF6C71F75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 04:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 8A9C929C6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 03:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABA930507B;
	Thu, 20 Nov 2025 03:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IqksVER1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011032.outbound.protection.outlook.com [40.93.194.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF8E302CA3;
	Thu, 20 Nov 2025 03:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608790; cv=fail; b=GoO8LTw15hXUnmkiqeMG6fu/HMye22E5Nmgh7aLmsFM/ztf6j5V+Lw9AL5fZo8OxKXZ0H/x3S1X50C/da3lZCx3+szgmDstzAhlcKTUauiMF8U1bMAomiSkQ4p/43E1qgcmi3zFI//paWQ6AXGXawmzA4r4ZuBHW4+7o/nd8U90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608790; c=relaxed/simple;
	bh=y2phiiBjkq3nkwBPmKUcNfSPWbT73lG/+bvkZt8F0JQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RegDnFVoiz1r1UJTwX8ahkgHJ76UtGfjUudlNb86QSNlU3lySSuM3rZarplr5FFgAHpOXXoVDEIPR9g8vVyhiDfNaO76Bumx7yX0xsELtTlRli+35Tn36JCMph/XE+B70+3kdKmOyavrRnkqV/OyTt34WWqNSKu7w9kDgyoRi4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IqksVER1; arc=fail smtp.client-ip=40.93.194.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HE1Dma/XiWkr9bJSJI76+tNvoeLxM6sMRBbNk9oQrY+MYlm0ukAZTOISoLbzRLlxr37KRB3aDLd8SDoqdLGoRIwn3wpeS1whveWFxxKrOwg1jjbjTrOcQbl3iOYL3yuFoKNhxnfrZkrxPmq7AXMZCQAjGxWmswW4QpP9B/0NssZ1EHJhWfH73n4kK3B9cvY//1LVDagrccKRqLzfUXTRkJPM9aBAo2NtupdSC1sXb9GyCGuzog6eb9NK5rP7mg55EctsynokeGGlV1l6BBvu3JlAunlwjKgm8D94yjunrH/mW6Kf/sqa2NN8Heo53QLCnHWcZXrq85n7fqBjmf17iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9xWI4MQkwa05seXtNQlP2/u0BO+Rc65ezkiYfvpShY=;
 b=w8vsKz0F/ysj3814DSMm8FJ43afwhNLbGYBmRwpG/l+8L4Yg1MkryOgPh3IvuqlsRyA+bwtglbFvobcO6qptkMbuxMi2VeuHJGby+nxlbMXGm0VADREXkZiAwXukp7yJX+if2LviDF3U2JNpzFohpWBObloSgXN5HYobOEPiuyxgzZvNe66Hlh73/NUZ9enRB8eK825z01tuJbaQ1TKIAwMKR2K7LSoKL4hWpvlO3AyGO65/z1pHD5R4ai7zJ1eCVVDr4yeUVilZiRPhI4E07aYCgncqFsjDcu22TDohK5KHOdWCU+Cck1WmLgjhmpP8jceEvQ4q7wbjL8S1s88/wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9xWI4MQkwa05seXtNQlP2/u0BO+Rc65ezkiYfvpShY=;
 b=IqksVER1rv1XtnbjlgJYnqqkM/VZ4JIzJtSWJSCG/Lug+IUFgd75SHN3YxJvycDLEV29JmDuf5Qd/1UkVb6VANFetvEvjNqyp8cr9jIJGm8UxmUWAeL3cf1dqh1yKR5LTJRH7va3B/g9pJLvRlY02JJr7FKfQrqCsF5I4vKKy8o=
Received: from CH2PR18CA0033.namprd18.prod.outlook.com (2603:10b6:610:55::13)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 03:19:40 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::72) by CH2PR18CA0033.outlook.office365.com
 (2603:10b6:610:55::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 03:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 03:19:40 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 19:19:39 -0800
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
Subject: [PATCH v4 4/9] dax/hmem: Defer handling of Soft Reserved ranges that overlap CXL windows
Date: Thu, 20 Nov 2025 03:19:20 +0000
Message-ID: <20251120031925.87762-5-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de15c55-bbb8-479a-7fc2-08de27e3a479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|30052699003|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K5NkHZiemw2oWJ1jB+ns/M/JdNfqVCvEBakQrpcyKAYdJzA9OXXbO7ILfJMB?=
 =?us-ascii?Q?f21UkADFfcyjOWFuoa6cEkd6gwKa0cicb8LPXvP1+WMI4oxGdnBE5EtocAB0?=
 =?us-ascii?Q?us9qIaoj96oK2shIyTG07pHDaFzo+3j+RE4hCljXgVFDNNSfxBoCqeNnIsVT?=
 =?us-ascii?Q?yrkR3rhhvHi0abC99nScD8029VRMJ53sxD9RND/TXJE96P/ZCC4J8vLslSUr?=
 =?us-ascii?Q?b4yJ+OQOT4d54s0U7nxbXt7VXL8eRhduGg1WPIlxrWJk3NeTFBM/+agwZdY4?=
 =?us-ascii?Q?hWQFMnS8HSVoqrd5j80ipmIowORS4LlMXYJ0PnlFplWJxYQGr7gXkovwwRXG?=
 =?us-ascii?Q?yDcaIofFQGkHlaujGAiICDLx35jx5bbq73QWXwyYHW9cWv4MzkWNabxW/lcS?=
 =?us-ascii?Q?H1tauDSoRaElbPuUvdOePjRTQTqvQTuZS0nN7cKW8dzdgQRTFy9B0DjdN6B3?=
 =?us-ascii?Q?Cm2s8lG9w7BX5slekHb+YdTGPwR7/zbu8MqSkjZvsDwT4E+TrEp8lTlPAS5t?=
 =?us-ascii?Q?sa7jADg9rpn7nCYBnlfV5Xl4NQJzmtX0LQml4ggCafqQU7hN0kF25MVqolQ2?=
 =?us-ascii?Q?BLd+pJb8jtYJuJm8UTrIDTvoPIkk8Z2Q9W4ilEqiWrdiLfVE4IXHG+ictnAj?=
 =?us-ascii?Q?TJegNT9OjD6pu0bpL/NfFCCoNimhvYdjnWMUw5ljMCUyN7HqlTbRbehgYltT?=
 =?us-ascii?Q?TQwoIHxFOAL2TXTjb3/x/vzxeLhQ959jo3eVhPn/T0NK65j2WtoseMFw+jo1?=
 =?us-ascii?Q?vdHhfKLOthvrDMigvUVBuvU9az9IFqqrINF4icVycNajrzPCDHtLgJ7gcPx5?=
 =?us-ascii?Q?eDxu1klTdCrjjG5SSZratlMcNRI0hEjCKqIcsEGexe6crJAaADt+uG3Ruzfc?=
 =?us-ascii?Q?+is3Ey1nzddW3iwb2YnOUkHnO2kvmeUr4BG9UYa5LkugvLAhxN+K/oJniDOe?=
 =?us-ascii?Q?XrQ96e0OHcm+x41qOUiuNNVV94DsnVEmO9skQJAVJ83qul0L6AREhqj+uRtC?=
 =?us-ascii?Q?W6PXKoASOxYspU/bqHNtcsASHl7QBo4PrIcw3GD1kj/z6owTYMZLPPZTOeMs?=
 =?us-ascii?Q?y8UfevD4iFXnyr7tgEo7JDxu1RFZhwQGixbhE3NoREb+R8ZmAw4nv0iFhK9A?=
 =?us-ascii?Q?Y8n5dQygii0xmPfvmiw2xZLgw7D6C7e8Vzwkr8UvDmBuhN2dmor/VoSMf079?=
 =?us-ascii?Q?cBWUyjL4KdBpFt6lByAvhYjK9qCSDa1/ZfbF98AiSekP7Rc5e3uyrIj99f6s?=
 =?us-ascii?Q?JOkmhGF50MBzScRsu5lNXpPkcWSD1eyJixKTN+sTZ3O8dVf+p50/6uTU1ti2?=
 =?us-ascii?Q?ipZn1V8s1qRSfhOBRKFcNVuqfQW0DU1RQwo9lQO2VTmtagBNDoaM0vO94x6O?=
 =?us-ascii?Q?7xjAkwv45IHLsqk5MgpeanCBHmAKSicOQ2R5hlMBGRlm/12Da7iGzwM9XLHx?=
 =?us-ascii?Q?IpnX45Z84dEb9zCLZDfWd71fOobUPuyYE7Q9fp80lsHYl4QHLDYehugqjQgj?=
 =?us-ascii?Q?y4KQBHIjIQXzc5nnCz9yHlNThsZWNgjIUshpRuorZxA75K3e6LkRIe2OYnzV?=
 =?us-ascii?Q?0THoIfelKzqeYUkCURg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(30052699003)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 03:19:40.3359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de15c55-bbb8-479a-7fc2-08de27e3a479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346

From: Dan Williams <dan.j.williams@intel.com>

Defer handling of Soft Reserved ranges that intersect CXL windows at
probe time. Delay processing until after device discovery so that the
CXL stack can publish windows and assemble regions before HMEM claims
those address ranges.

Add a deferral path that schedules deferred work when HMEM detects a
Soft Reserved range intersecting a CXL window during probe. The deferred
work runs after probe completes and allows the CXL subsystem to finish
resource discovery and region setup before HMEM takes any action.

This change does not address region assembly failures. It only delays
HMEM handling to avoid prematurely claiming ranges that CXL may own.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/dax/hmem/hmem.c | 66 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index c2c110b194e5..f70a0688bd11 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -58,9 +58,21 @@ static void release_hmem(void *pdev)
 	platform_device_unregister(pdev);
 }
 
+static enum dax_cxl_mode {
+	DAX_CXL_MODE_DEFER,
+	DAX_CXL_MODE_REGISTER,
+	DAX_CXL_MODE_DROP,
+} dax_cxl_mode;
+
+struct dax_defer_work {
+	struct platform_device *pdev;
+	struct work_struct work;
+};
+
 static int hmem_register_device(struct device *host, int target_nid,
 				const struct resource *res)
 {
+	struct dax_defer_work *work = dev_get_drvdata(host);
 	struct platform_device *pdev;
 	struct memregion_info info;
 	long id;
@@ -69,8 +81,18 @@ static int hmem_register_device(struct device *host, int target_nid,
 	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
 	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
 			      IORES_DESC_CXL) != REGION_DISJOINT) {
-		dev_dbg(host, "deferring range to CXL: %pr\n", res);
-		return 0;
+		switch (dax_cxl_mode) {
+		case DAX_CXL_MODE_DEFER:
+			dev_dbg(host, "deferring range to CXL: %pr\n", res);
+			schedule_work(&work->work);
+			return 0;
+		case DAX_CXL_MODE_REGISTER:
+			dev_dbg(host, "registering CXL range: %pr\n", res);
+			break;
+		case DAX_CXL_MODE_DROP:
+			dev_dbg(host, "dropping CXL range: %pr\n", res);
+			return 0;
+		}
 	}
 
 	rc = region_intersects_soft_reserve(res->start, resource_size(res),
@@ -125,8 +147,48 @@ static int hmem_register_device(struct device *host, int target_nid,
 	return rc;
 }
 
+static int handle_deferred_cxl(struct device *host, int target_nid,
+			       const struct resource *res)
+{
+	/* TODO: Handle region assembly failures */
+	return 0;
+}
+
+static void process_defer_work(struct work_struct *_work)
+{
+	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
+	struct platform_device *pdev = work->pdev;
+
+	/* relies on cxl_acpi and cxl_pci having had a chance to load */
+	wait_for_device_probe();
+
+	walk_hmem_resources(&pdev->dev, handle_deferred_cxl);
+}
+
+static void kill_defer_work(void *_work)
+{
+	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
+
+	cancel_work_sync(&work->work);
+	kfree(work);
+}
+
 static int dax_hmem_platform_probe(struct platform_device *pdev)
 {
+	struct dax_defer_work *work = kzalloc(sizeof(*work), GFP_KERNEL);
+	int rc;
+
+	if (!work)
+		return -ENOMEM;
+
+	work->pdev = pdev;
+	INIT_WORK(&work->work, process_defer_work);
+
+	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, work);
+	if (rc)
+		return rc;
+
+	platform_set_drvdata(pdev, work);
 	return walk_hmem_resources(&pdev->dev, hmem_register_device);
 }
 
-- 
2.17.1


