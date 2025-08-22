Return-Path: <linux-fsdevel+bounces-58733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8CEB30CBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 05:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D82CF7BD979
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 03:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EB828E59E;
	Fri, 22 Aug 2025 03:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t7SNxVho"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5C926B0A9;
	Fri, 22 Aug 2025 03:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834143; cv=fail; b=K2SFHTbJCyLiavH5D0nvRaZrm8sf53DOuhjQuNuK4l4aRL42fD95xOCBsg9SB6yisdkYWx6iTPgicjPgoJGXsekw2aP77kwK6TJEaigRZsHzKi6oZ8BLER45OM8MjIqJezp98hVgZw2HqoSytTomWZ9Tctv85rEhvnVKRWvu0KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834143; c=relaxed/simple;
	bh=SWE7FHFRT3ZWvaPD7FTVEpgdCQte8FOOcuBuaL5niSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDUXNusrCkN0TS+qRoPdqiNpj96+FPLN6TbAy0cqWNWJN+i1XS0JMiB8dsyUqLTTmERxpQJF/Y8/fhrS+ncLjWWZqdEH4jBRG7KSPPFx9o8tu55lsHQC8WtR7Ee20HOzbtb9amm210MBKGk0g3XWGtO9wDjWb6Fl2J4rrlkRYIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t7SNxVho; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VT8AYoJVwtnjkY7rewqbSfQvImE11qXG4ovko4oiZ/UIFBFxCiy6l6qsuqFdnj9N1OI1gEmDWzKaC1Q+cT9Is/7Vw9vhFFYzRgP7Bm8YWS5d+lm5TPEFNyZbR0M5e/eHt4LLgMZ3v+cYOM4bB8MPirmDO1pes/nUdutQyl1C7h6CrqkEaE+wIrnXYoTbw74Yx2YAKWlbxapz8BsYYcOPAMNlL4/5OwSpmnxffo3o/W5cFDEHL43918Rx1B5EMJN4kP/Hx6i6CpwK3WzTn3jXdQ9G6+qf5PHiiYVQDAJ4DsSvDDJOw/oMAt1Nj9OYWoT+KkiWWawJbj9X1W8a5CISPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTAWbdqN8kd2OY7GYH1ultj6kEbWvczlW6XDc4bODfc=;
 b=WceSnKQ65NtxuMAH1jdUyq0I+YUR5FoDsFc6KPeJYucqDDVeya0EWQne403/4mRyZ/GXbbGKWL3d47ymb3WiZ3C30Dc9MN7Mp1bsMY5GNi57tcMG6fDClW6wm9DS0DFTlZr/YscLcnJdFyk1mad/i+KnbybngD8fAsAOdemeKNleZetoBV45Fc6wfVWNOfwxx/UBn9+tgUOYYOpLin8xKeHUJZ6i3Z8LMPaWiuBHZthx0WZkCH9HfZ+feuVQXAxBMi+QQaRvvrCPVkVpwS/Y7xNCUKQCIuN+TXPzuzTOKR9EChcgyTvSaQKfKmPH53y7h+OgCWjUnj3+hci7LgzlnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTAWbdqN8kd2OY7GYH1ultj6kEbWvczlW6XDc4bODfc=;
 b=t7SNxVhoPdIPsWUpsNOHC3Crq+09CscYKPWjBC5H0UUPqgJaGutjVWk3osj+nSPgLE7w7irWLsxZISuA0lQyhqvuULV4xylcjzpGtuCeU6aRfX5wPbRVM6VS5/jzqAIPwc2REy3Uj/J6vi3GpqEczyD4ePuLfsjMreIRUMAx3lA=
Received: from SJ0PR03CA0380.namprd03.prod.outlook.com (2603:10b6:a03:3a1::25)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Fri, 22 Aug
 2025 03:42:18 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::1b) by SJ0PR03CA0380.outlook.office365.com
 (2603:10b6:a03:3a1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Fri,
 22 Aug 2025 03:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 03:42:18 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 22:42:16 -0500
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
Subject: [PATCH 3/6] dax/hmem, cxl: Tighten dependencies on DEV_DAX_CXL and dax_hmem
Date: Fri, 22 Aug 2025 03:41:59 +0000
Message-ID: <20250822034202.26896-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: cd952e4c-7c80-40af-2fa1-08dde12de4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j+BxH58AIV0IzVnSzWde204ZhMtXDWdzKsG3LNoLr3G2GHogNohk0WiRuR6u?=
 =?us-ascii?Q?bK1qQznmjpOwbxvnmkEhaAtxIZkS91ilv5SoI7ARdt7yK7QTfLgr90e9vGWf?=
 =?us-ascii?Q?aCj1To5SUwRs+v4QD6pbkv/yZsW0mwQO13boga+iIsNVUx9rFxuObbdKhP6b?=
 =?us-ascii?Q?apdmad3C5Y7b/EkN3j9U7+hQeDe6rEl3dJ8+3CiMeeOxyJJ6Xjk+oils5QgR?=
 =?us-ascii?Q?/AzuUDK3QLTsRSR0rTR+4A9Q4y9lPhngmJvjGpHCkfkPPjxOlqo1otiLiDvr?=
 =?us-ascii?Q?X3ZnQwKonRuOrCp+IefaE8MHaHuI7Dz+QrqNL2AxflEuqrTta/8JoHhSBldf?=
 =?us-ascii?Q?8Jt6kGLSgTmOBbtj8gwXxhzTPLCCIwxem36BbBrNwwSdBk8QzM2qO60R0YhW?=
 =?us-ascii?Q?DtoiGrRC1jbnCGRHly4TdlWYFFbu+79brbFlfQjQ04CqoUitke5d9eZg0b/3?=
 =?us-ascii?Q?2zRs6Nw2zKX2xgPAgota0sw2BkDSC9FWoJO5vFXXB509VarX3WrUpez8U9rb?=
 =?us-ascii?Q?QcsXojGUSYUP8A62VxeCWIBydqHAbyk8oFiUfzd7hL5vj9+FxNZF+/qLG2L3?=
 =?us-ascii?Q?btao5V8Cgr/4hXH3VujBBhSnmXVn2ua9tW3ASX6RiRvAHdIg8PR2H/nrVnhD?=
 =?us-ascii?Q?6utJh+gppEFluVYC5fr0IxRrV6o6eTGa6dWzFhjBzBxFVHO/d2R4fLlwAfwx?=
 =?us-ascii?Q?403SzOc1Y/l7sMvea1lr5ipR4eWgZz9rzoxCcBQF9oXqzqt6mauY3X+91HHh?=
 =?us-ascii?Q?HnITAPlN0EbcCS9tC4Kz+NDGT2CtsecbdT791TyzWGwg3ZuUEgokVwBKYBJN?=
 =?us-ascii?Q?YlIIk9JTx/9/j8zlF4w3zP+wlwJaYxIAy2Um+2xEX0Z3tpS6xGqshGMb4GyX?=
 =?us-ascii?Q?HMrg8zAxxTnTxiuqVvHNZr33N60twRdxQCtkKZq+D3UhJ+h0dBR0cidQW7BR?=
 =?us-ascii?Q?VL/hXgNMSQJzH7siQuVtmLkoH1lJCQyP++zaoF6s2fi/rWX1s1iuN5icvhbT?=
 =?us-ascii?Q?Qb69DQp/JP35wr3Xh/c7kv9dbKA+j+alyb6NNyNCe2oyqOM+edavqzX/lUSn?=
 =?us-ascii?Q?3p1d0L7W1V9SKAFEf7e4Zjy4q1pdo3nncKO8ooMN1RvAXldfUUnHlzPfNb+7?=
 =?us-ascii?Q?4QeZSZm3rmnUil2uHB86rZsmIHzVjZVbUx1pKCZRgV6YOruToeFGbBHiQV9B?=
 =?us-ascii?Q?X+WMjovVXdHtWcU9fL2p7IcYtsz6Ce8yIL5HKB6Sb4uDG3XiNgQ6pzyi6bKH?=
 =?us-ascii?Q?CTGjh9jJN72ky+8s4tSyDKpFzm//ZLSnpxqOhjRLn+e2tdxrJmUDb5W+sbnk?=
 =?us-ascii?Q?Vo5CM6UrU3b3DHj7oF1a92V0ogyRkBCL3FHcVr5QUreINNfuSbbB+F/u9rau?=
 =?us-ascii?Q?V1AVryc5QmmmYBzlFNBAoZkpenlvppE1k6xvuXk8NVA0e6i0iXx5DZJpmQqk?=
 =?us-ascii?Q?ykdtiFrm4EnmKb5+NkC34eGUqRTT9mvaoONoR4XW75n//afqMz5xgKmvosUV?=
 =?us-ascii?Q?W+NHH3tE7pOfx0iBC/pGountslIZXvBC9Vvs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 03:42:18.3552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd952e4c-7c80-40af-2fa1-08dde12de4cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874

Update Kconfig and runtime checks to better coordinate dax_cxl and dax_hmem
registration.

Add explicit Kconfig ordering so that CXL_ACPI and CXL_PCI must be
initialized before DEV_DAX_HMEM. This prevents dax_hmem from consuming
Soft Reserved ranges before CXL drivers have had a chance to claim them.

Replace IS_ENABLED(CONFIG_CXL_REGION) with IS_ENABLED(CONFIG_DEV_DAX_CXL)
so the code more precisely reflects when CXL-specific DAX coordination is
expected.

This ensures that ownership of Soft Reserved ranges is consistently
handed off to the CXL stack when DEV_DAX_CXL is configured.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/Kconfig     | 2 ++
 drivers/dax/hmem/hmem.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index d656e4c0eb84..3683bb3f2311 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -48,6 +48,8 @@ config DEV_DAX_CXL
 	tristate "CXL DAX: direct access to CXL RAM regions"
 	depends on CXL_BUS && CXL_REGION && DEV_DAX
 	default CXL_REGION && DEV_DAX
+	depends on CXL_ACPI >= DEV_DAX_HMEM
+	depends on CXL_PCI >= DEV_DAX_HMEM
 	help
 	  CXL RAM regions are either mapped by platform-firmware
 	  and published in the initial system-memory map as "System RAM", mapped
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 9277e5ea0019..7ada820cb177 100644
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


