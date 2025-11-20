Return-Path: <linux-fsdevel+bounces-69186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5500BC71FAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 04:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E2E692B34C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 03:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2653128C2;
	Thu, 20 Nov 2025 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jeYKwExK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40C030FC0C;
	Thu, 20 Nov 2025 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608805; cv=fail; b=Qst2lSHypqn3HO3n5EoA462uDPsgFjuavChO//7JJeky5Aq9u0cWTQv1eapXEdAMN0HEGKGFzlq9wzcF3z62cuE3eYDTpKDHpK6zETTv7zCswJXAAoCuRjWZl/tbvjzGqA1ErtkUQ44KEBklK7gpkYMjuwpz7RivdWnx1LpVIXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608805; c=relaxed/simple;
	bh=EHX/DvhCVyz6Vnsxchbt4UURzEGn2DCP2LvKu4nmETA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzYyCaSwG8nSQPsvmQts+2OozYZ/TxCdBXCFwXvxZ+AzKS/AKG/RF3TZZmmrqMk4iX/Qq6liOVMsA3S45NQgH/RhVYaF3Z1KgRZyhysSrLGce6/ptkdFmK51H+Q/S2MPJ0G0ROF/xUHg62AaVSZalyQHA3ynIOWwMwrjajC5gcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jeYKwExK; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHWuhxVFTqbLXtSzw4iQlR1fPbJ/f6fG/ephokVAiIAWd03Evw7LDWBSHbHUfHxKfSvrEZHCN4bU//noGpLZvGOplyc4vVFRAitRdcPGCFoiN9LGCQSChV8bimlP2pjp/KttO4lxo7p+VtFsWIAvN1LKCW2DnEcTPZuo3VyY3fN1eIDJlHyiJgjOZ093mMq/M4RTwfuCpt4WHpbqM2t9UJiUbz2PkKSpRDxBP5e49DHyu2GH0q3CV3KKa8SfForY0nFuSdUafyCKUx4EZXCEz+uW5hs0r+uMKSeE3rKV7WJLb46l6WRIZGR++RHC5aZaoqAIIhbLT+IBOJuhPxHxkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFodpRhLBNvZ8lYQ5rn8WkUcu6dYAZJOvPlu7kNMu+U=;
 b=Y1xml+FwxPdG30uy1ai5QmbyXzMzEDTTZDYYq6s4HaC0MHVxpD3RczZHbxPNC7yMDVUFm0W4IsW/8086rUqVS4cvWc2R6c9mR9BwspafHEETZEvMF90biGwwXv9cbhVl0KbLDNcIwZZIGs8B+zwNhcrPAVrDB+avXZ7wkWBMv+RbM7ElKWtw/7GXPKsxL6mMjcw6Z/1wrD9XDFpZypu/JeuNpS2OEKI/kln6csytNTDmSVn8ZJCc4alTAk9zH/FSgsCRB0EnWe5nu7km70UaO8bnAOUWp6EBbD34cp5XdwV3KlaNDexBLZ92CWY6L+pK2O5UI471XB61xCaNRhgW1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFodpRhLBNvZ8lYQ5rn8WkUcu6dYAZJOvPlu7kNMu+U=;
 b=jeYKwExKl448KJ0TRCygezPCxOzzeHhUrRaaisJ9BN/iWbRlMcn0I6Erupb5VIEe+NTrFNl12KZDw0XY+qEXapeNNKCWsM3d7PeR4LFasg+XLu7eYKV4aZh/dGxYrBafFpG0yNsBHneUwEv4Yady9m1eR3oFaftpffE/JBQhNB0=
Received: from CH2PR18CA0039.namprd18.prod.outlook.com (2603:10b6:610:55::19)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 03:19:57 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::79) by CH2PR18CA0039.outlook.office365.com
 (2603:10b6:610:55::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 03:19:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 03:19:57 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 19:19:43 -0800
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
Subject: [PATCH v4 9/9] dax/hmem: Reintroduce Soft Reserved ranges back into the iomem tree
Date: Thu, 20 Nov 2025 03:19:25 +0000
Message-ID: <20251120031925.87762-10-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abf1174-0537-438e-4cbb-08de27e3aea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xgm8uBuiCQ2jbCHmlUzTGXZNLxqSiu9ydXLESsadK6cVuTdqEsgO+LU8D8+O?=
 =?us-ascii?Q?4F8rPzpJUAfLwsejiLj09ftFQAEA6IDhA9qabfobNu0XN5x7viyxPyOPBQjY?=
 =?us-ascii?Q?fOESXHHB3MUvBpwd7kNxGZwbs+H5abqnLsfhu1Lmbl2ifSEvZv9NaaR9pSnm?=
 =?us-ascii?Q?4LH2M2K5/trzEAGN6euC4XOOAgk1geFlZDoalHfQSyiehPwx6tjwazvv3BaW?=
 =?us-ascii?Q?F8CN27vfpwDgUDgS4kPbpkQ+E1Jr051vm1HDg2RGvsjZBSiy/QnlVRNpaR5Y?=
 =?us-ascii?Q?WcrBTLWHdkjIZGa7aSQdYB2UEFYThM5aQTI4geRA9AnJjQla4mF7CGnqV8ZP?=
 =?us-ascii?Q?BDG9S3Qz8kD026MSmv0ZDanmiaUiER3xCnxitr1f2EjLIAdjnCzyQIsKNpvA?=
 =?us-ascii?Q?opbteYKvfoScFRFHwwAgZR+FjffNHhZbye20hTeRejbvEBREe0QC6rZyUu69?=
 =?us-ascii?Q?SkqHlsC+P6Di1XnR5SkueOrwTaW6EK8HxrrRVZL9vDAvk/cjrX0lBSSG2dju?=
 =?us-ascii?Q?q48BA48Avqj97/42Xmmro2e2Qk9HWQSJ30XNeVP8gAHOej5kBMgXi19Xhl4R?=
 =?us-ascii?Q?AP+T2E3+ayo55ZtcDm0ZFu/P6PNxrFU+jOVY13pomfvaKLGnd+AODt7O60hD?=
 =?us-ascii?Q?hrxorGTe4jlGpPW/LHgbmRoAW+P8fh2LXH25ta4Cor1IKSuf2xCvWIfgPNXK?=
 =?us-ascii?Q?9z2nvOcxSXKOJbRR+p1Gr3CnRL66xIjvxjBr9SZ2zBszkjPNWVljaT8Dkc1U?=
 =?us-ascii?Q?epQkcNSDX/Ihmvjm/i7HcuvkIdcUQOvs+83wN1xJeFVLgANQHrIvdta26qkR?=
 =?us-ascii?Q?bDMRmmafc5nEDOuL2SJeSAA+oOWp19IlZ5MhlAi8ASmMZwP/TUbIsezehYqp?=
 =?us-ascii?Q?f+l3vN0AW95SLV0/V29QIhJGyKOLZUaig+7Bu/Thw+iIN6zfaowp3lJkCBMe?=
 =?us-ascii?Q?vsAKSu8KbRRUTq8Dt6fOdx9JxXsd8T0lNIX5bcAvez1A7Z1DQF5g6rh2YMVl?=
 =?us-ascii?Q?XR4bvBZvtp/X+WplOUTTZ9Y/rVH0fPEsVVGA6hp9m6TcDWj8zZVFUb+zbuRi?=
 =?us-ascii?Q?EiOs65AZsV2zjDJXJdYs5uhQkD62+TopW7GXJ4+Xn/XieOG31MCDgehk1DsC?=
 =?us-ascii?Q?o4R9X0bu6QL+w8cTHjr02wXDuSViVF6BBkcvyau0jJ/k9eoq9iCVqx+oG7mh?=
 =?us-ascii?Q?fWD57wsbtsXPvuYzmzRHB47rEAc2AWbGNM+I+gHPUGWPHi6Kcv7hl1z9U7ii?=
 =?us-ascii?Q?VwzTz78/Q2kFf4HZunv6E513hRzPuC64zo/gRpjFB539VYxRBhWU1wu5lz98?=
 =?us-ascii?Q?1gHtbXY3qzAFCqZqSTQ89ZdBAmtfGG7Duuj0Yv1zGEoRSc27ewxTdZwlD8QB?=
 =?us-ascii?Q?PsyMjHctiXUXyc2ebonuy185wPwGvOn9gpwwwl+fzkRY3U/yZAUd3g/faEEL?=
 =?us-ascii?Q?en6dgc9aCLASzuqYDehFTVYes5wqtT+ceew9QuvZLfha84MyLkp9/S19El19?=
 =?us-ascii?Q?5RigZap4ujmZZ7ArFJfB8DZzdhyN9Hz/dhDP1NDwIpBN2MT1u2lE/2j7NDxM?=
 =?us-ascii?Q?u40FYHM3XueCEDV2ink=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 03:19:57.4129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abf1174-0537-438e-4cbb-08de27e3aea7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209

Reworked from a patch by Alison Schofield <alison.schofield@intel.com>

Reintroduce Soft Reserved range into the iomem_resource tree for HMEM
to consume.

This restores visibility in /proc/iomem for ranges actively in use, while
avoiding the early-boot conflicts that occurred when Soft Reserved was
published into iomem before CXL window and region discovery.

Link: https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
Co-developed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Co-developed-by: Zhijian Li <lizhijian@fujitsu.com>
Signed-off-by: Zhijian Li <lizhijian@fujitsu.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 drivers/dax/hmem/hmem.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 7d874ee169ac..5f36b0374cf4 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -71,6 +71,34 @@ struct dax_defer_work {
 	struct work_struct work;
 };
 
+static void remove_soft_reserved(void *r)
+{
+	remove_resource(r);
+	kfree(r);
+}
+
+static int add_soft_reserve_into_iomem(struct device *host,
+				       const struct resource *res)
+{
+	struct resource *soft __free(kfree) =
+		kzalloc(sizeof(*soft), GFP_KERNEL);
+	int rc;
+
+	if (!soft)
+		return -ENOMEM;
+
+	*soft = DEFINE_RES_NAMED_DESC(res->start, (res->end - res->start + 1),
+				      "Soft Reserved", IORESOURCE_MEM,
+				      IORES_DESC_SOFT_RESERVED);
+
+	rc = insert_resource(&iomem_resource, soft);
+	if (rc)
+		return rc;
+
+	return devm_add_action_or_reset(host, remove_soft_reserved,
+					no_free_ptr(soft));
+}
+
 static int hmem_register_device(struct device *host, int target_nid,
 				const struct resource *res)
 {
@@ -103,7 +131,9 @@ static int hmem_register_device(struct device *host, int target_nid,
 	if (rc != REGION_INTERSECTS)
 		return 0;
 
-	/* TODO: Add Soft-Reserved memory back to iomem */
+	rc = add_soft_reserve_into_iomem(host, res);
+	if (rc)
+		return rc;
 
 	id = memregion_alloc(GFP_KERNEL);
 	if (id < 0) {
-- 
2.17.1


