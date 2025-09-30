Return-Path: <linux-fsdevel+bounces-63081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BAFBAB68F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7221925693
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 04:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723EE26F2A6;
	Tue, 30 Sep 2025 04:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AAcp1Rca"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012062.outbound.protection.outlook.com [40.107.200.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5244626529B;
	Tue, 30 Sep 2025 04:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759207697; cv=fail; b=X8lZ7QIc0vlJBFJTx06qQxSpqgMSY8P9OaTLVNj8FDqBDLiNEe05sfFrb0AEjjD1ePjuVi6BvFM3Z+D5zexWJirqqJQN6nl81wCRdPHJzzFOW5vA3La/5fkaO7EQParUrREKJ8DQJwcy13PzKaCnID/ISvIwxyHDgDTVV6VxAjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759207697; c=relaxed/simple;
	bh=gyzzOdjogrF2nGbqKXspVsgzAB2DUgrZH2wJX3ELSuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHdYpSd8g7BqSfPwnVIWudFKBorN59nOnKnacs889bX9m9BPIV/r4Og9RagRE9eBWYqAzGgVcgMaAar+82hejGRtl/VcoQC0bgJ/Pjq2d1mGehUnu5uhiMcsp6DvA5+5tgsFzBulrveoWLN//dGhXWx1xLnEnYEtbKtIEZjuC5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AAcp1Rca; arc=fail smtp.client-ip=40.107.200.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNw6gh6OjutvupM3YgHSjzcSGJWGqG6+cM6MBOl1Fsx9s9xGZfYxK7RddOnTDQqbDR1d3YeJ8dYW5/cx5hsrWksiefoaKlz3opgOZxzFampyDxxdbDxSjAmVXEq/QBbSXmLlKh07U+2J/xSikOq6cbbRQIyx5IJ68cX/TCiUI1HEAMfXrqc7FEnbQmYdGqLgwg7B2Ri/CDd//FnUa2NmWPeiehjeTCaW0rBXSGLZHyB9oJJxC2Pmn5vtKQ+OYie1YQHHYRHQfHQC7HGqqQByJTSvyxce9n39Bb2ErkDcipmf7XpDFkiRYraBg+zVMw9wRgkTF+ayux4TrnSY7TFZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qi9bzNnXYcX62J6yZBgaOmuGxA469d3CJUp/ObbUFns=;
 b=xFmOjeP55mE9TrAANsKjbZUWaCEG/YKoOWWBfWJKLJT5/0lvK0EDuuyg2AhBvWPAH/uVNprKOlrCwLOLYOIGAccHEDIBH0VXjrS9Mp+Z5UV2ZG3ZGKoKVH5oDpLZ1sxKAUSA0yQQoKG/bvwDChXGjC0O6K1rdiwKf7CQhf6nv+V2+/q5GgDH1zyfTmDynvZkwcyIH+jHmYhLR1X+a1s1tvdkRo34O/Edcab/8rW9TmdwEPPzPY07DZ81iNfWsnynvzmolgbyDjWZVWEemxU9G8GjpO2LDqaIO4yL2x4ssOGELsTlzXMxmb4nN2yOUk1JwJ8MdyQX/BljLnq+tJAI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qi9bzNnXYcX62J6yZBgaOmuGxA469d3CJUp/ObbUFns=;
 b=AAcp1RcaxTYk29GsNJ/zCTOIYyyLSrwCsqy3PkHsHnC22K8XFMATSA6aQ0QWYl8dx/mC4fzLR9U/0iD7JovzKuxtHXrqj9H8KX3XmWmk5TaSLtwMIrX8tSd97yqj/kCNVsFV8E6W8nAh0+7T4z9kR4ym2A2yPul0WzRMiwwVofg=
Received: from BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::6)
 by CH1PR12MB9645.namprd12.prod.outlook.com (2603:10b6:610:2af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 30 Sep
 2025 04:48:12 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::d7) by BY1P220CA0017.outlook.office365.com
 (2603:10b6:a03:5c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 04:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 04:48:11 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 21:48:10 -0700
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
	<benjamin.cheatham@amd.com>, Zhijian Li <lizhijian@fujitsu.com>, "Borislav
 Petkov" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 3/5] dax/hmem: Use DEV_DAX_CXL instead of CXL_REGION for deferral
Date: Tue, 30 Sep 2025 04:47:55 +0000
Message-ID: <20250930044757.214798-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250930044757.214798-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250930044757.214798-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|CH1PR12MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: 15583d6b-b105-4368-77c0-08ddffdc8f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HNUo18X2izVCnTrR69VGdPEs0p2T0tM4JUPV8wPYAbKMRa0eSLUDkYXSLhba?=
 =?us-ascii?Q?wo6DaEiqHWtOMiB/8TqMeAKGGMLt1xDQcGp4tgsbNkHyLJGdxqYBUtcFeqLA?=
 =?us-ascii?Q?iXJ1gUWzBfY+434YTSZdZbNIQsoZ4ckhvpPnvGng9pT/JvcNQYwh8JC+p/iW?=
 =?us-ascii?Q?5Sakus4peTI3c2AwNPBlgxXJMLW3NT1TeT6gYv68HJTu9lhoXxU1ULWBXK/d?=
 =?us-ascii?Q?ulygT645f5p/PS7BF6FmDsmyYtiT3PSLDHRvnj3YQA69q0Sc65D+pLqswwHF?=
 =?us-ascii?Q?pWgGLulOSXubsJvupeLS745apv2IHkqe7GEpVP64UxCRuLWJhRne94o63mO0?=
 =?us-ascii?Q?FccIJrvyWbljEpttKaviIqKQxnQM3TMKK5Pu16fkcFAnMzvP497mRo0CvcZm?=
 =?us-ascii?Q?tLAl+TtYFBjLxwzgN0sd347UYT2VqNXfeL7/pby+Rzg8i/gUqTNGSRqSTj6n?=
 =?us-ascii?Q?KDizdZkQx1C6/k6KVn1B4NkY3TI+VNDdvhM/29myAvKI2P7Wg6R7+IDWlon7?=
 =?us-ascii?Q?CM/vkC4cbGZU1X/D6M4iKOlkY+RHdH9z4ixuoDvHdQ3wk2eUludGb2HYoi5y?=
 =?us-ascii?Q?le7iVkhxL//dTUlBEYArntCqSe0nSGlqVXClgaaXBUJaHadOy5UWZ78YnYJc?=
 =?us-ascii?Q?pgy7WF/R4qpQP0BRa+BD1bv7bFJYHm0V00T8FBUoLN0qCV9BhkYQZXViJW0A?=
 =?us-ascii?Q?96GggXseToYmnkySdwz6z9ynigH17BaHFJUdjVGf6EnXgt3YgTmAlsOkt7BK?=
 =?us-ascii?Q?82pCyfSYZ418wviwQSo18aAl7QhSWYN78CodyDdlCsDM8vFyL+B/Xyzru0Rl?=
 =?us-ascii?Q?zoLyU1Jm3nDDbkgdnWr0XxVNeU65cLhWQNopX4diKDReSTs9lY1PIebyUdbf?=
 =?us-ascii?Q?HncGLG3m/FxYCtUMWxrry9ICecj2mbEMG4icnRGiliYuOcXQBx89VfNLWzdI?=
 =?us-ascii?Q?wpyMsR8/+63FTbDx9nOosGieTTRsVM3//CdjMmC/M2vdCgsOendc6HNUhtjv?=
 =?us-ascii?Q?Wo0vX12OQGwAfgrh2hSJNWMu6YNqCo3T8BtuIm+/ny8PlO0oy70n17QWTmoC?=
 =?us-ascii?Q?AiM+I7NKjeDIHRVrIKybWj4ok5FLvsL9d6+pr2bugUMlbrt48ZfrWF8xg9WS?=
 =?us-ascii?Q?M8zRZrrDFWSc03InDtUhHafWgE6+/ncq1GmPLL/IIClQAan/M4XqZHv65VqT?=
 =?us-ascii?Q?eKnxWo862Le5Q8japf9bpaTEOJAUOd4drcSdrehc+5Ri6LVllAUJv8VFHUoC?=
 =?us-ascii?Q?etDVyvFgEbsFAYyHbIaCi+nafXsWIBlhLTL+hxv9v5EC38PgkYY4ejNdXzDA?=
 =?us-ascii?Q?JIeY+sTgvz3iK9eGAXlV1zQCL971rNkmthCwsdMntOBm9aOYJZXj4JTVuCh3?=
 =?us-ascii?Q?jsYxkfQxY5ZZHu0vGa2boZ77tLui2O+XYi3MMFugLqMTXlqnyctJLyYDAonY?=
 =?us-ascii?Q?eVOL7Ch8py2TLsxXAW0ODPk5W2xU7Y3/hnDaoQXi4UzOVRi/N4INHIfg77rm?=
 =?us-ascii?Q?619eLLfqF6auUarEX99wFJQw9qXjhz92pNgISfr34JGaJHB20lgEEjDL0NJe?=
 =?us-ascii?Q?npVsw92d8gynSa5IqUA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:48:11.7609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15583d6b-b105-4368-77c0-08ddffdc8f49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9645

From: Dan Williams <dan.j.williams@intel.com>

Replace IS_ENABLED(CONFIG_CXL_REGION) with IS_ENABLED(CONFIG_DEV_DAX_CXL)
so that dax_hmem only defers Soft Reserved ranges when CXL DAX support
is enabled. This makes the coordination between dax_hmem and the CXL
stack more precise and prevents deferral in unrelated CXL configurations.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/dax/hmem/hmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 02e79c7adf75..c2c110b194e5 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -66,7 +66,7 @@ static int hmem_register_device(struct device *host, int target_nid,
 	long id;
 	int rc;
 
-	if (IS_ENABLED(CONFIG_CXL_REGION) &&
+	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
 	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
 			      IORES_DESC_CXL) != REGION_DISJOINT) {
 		dev_dbg(host, "deferring range to CXL: %pr\n", res);
-- 
2.17.1


