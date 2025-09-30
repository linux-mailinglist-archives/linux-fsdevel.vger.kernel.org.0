Return-Path: <linux-fsdevel+bounces-63072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D77BAB597
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 657557A0868
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 04:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C6C25B1C7;
	Tue, 30 Sep 2025 04:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1k7icWDo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012035.outbound.protection.outlook.com [52.101.48.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1BA3596D;
	Tue, 30 Sep 2025 04:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759206515; cv=fail; b=LzjTaKMf2aJMMCe1mX68/m0UhUGaJ/+DoObswEDYClmbAtRnCqpIOXoGbgLIsTcFa+nsGwITa5UVl2jKk7QGTlr8klzfPhLQrX0R7myzhkexZA1ACEFOUhj3OUR97ZB+bbIH5WdW7FN+NfHxqJOZs+JolCXEWVBXJBlrJ3mOqrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759206515; c=relaxed/simple;
	bh=1y13MbLpwKodnJTDmG7JH1p2GlDFDwNjYvsMshiOogM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bFryMfgY5dtX+DT76Rc86iVkbAvd5SvfMGUQp13Nn2JM86cpQ7M5RTSIZkwLzzRyn4ARdJ4C+uMHN+6JnJCqiflecMcJ4k7tGe5SN1C2dlAmG3AF0kGQBhAnDRVfD44Jr8olMANi/0FSbj0WwKgxyRkg/lkyuaUfNosvf521fDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1k7icWDo; arc=fail smtp.client-ip=52.101.48.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Glm5lRe12csUAhHpYUgm8IJNGFtsuy+G/9iKibqrSis4LlyUr37fJ33D4IGQPG8If9Uo8MsUV8KPe+ZYR4c3CA675lsJRI/rb8cs5cGEyvOFu1uOXw+SSo323tsd1UShS2k3xHO/wbhKfiwvyP2s6081bCO1Q8c8Us6zmJ/CzotpqFFLstMKIFebZ8MuiC2A5Jg6wFesbVUtyLykSAV6Xy98uf6xhhrSj8LHm9pZUp/GivwatCRJYhU4/uzqVQnxJrBZIE2i3I34jzLzmsVTRqL4ultz9qeDuZyoYriDiYH5QsRk22GgXCiOL1gt9sUzjg72MWfZT4eMJZc9MD+gqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8yqaaggpSFQ2NytylX4pZi5GSckyn+hU8OFE1L3TF4=;
 b=Isj0UN92kfPs/D0ktCfGYh80lN+EnuAsO4Rn17ngg7gdL5p3DdieTrTfFKu3vhcSAcn/Kj9EQQYqmaakRJVIwu0EFYF9olnNXVM3FCdTqw9L0xubIJ7WwxFakxk1Upyfh8avbPpbY/KmO/saQK71dNmrgxswqiACEH+8krssFMqdjiOvHxRdQ2ryx7y8+daUHMUvPvbKV2/gM3lr/9flaZwmtce3hMXrpdY6X8a/reY+nEWtMqfjPPix67z3EvbAunZEbLJr027ArOdDqVAX41rAAxegC5mo8V8ztievrlr7EW3nY3BqGXBplkOmFKDCkJqWbeaAq7HcqBfeY+DiGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8yqaaggpSFQ2NytylX4pZi5GSckyn+hU8OFE1L3TF4=;
 b=1k7icWDot1x3Cb6XrBxkaKcaT60jlD8az8LvKOwlKq3H2ZvDnRqvlUimoR8KAjbYhz7K8tsSzx8LWWKHYqJ7xUbLN9FTyCDGIJd7PJ6IplwhiWdNSc98n6RPrxvRXIDQEml9tENQya24AF//Sxtz0tqkz+CICTZX3AGxO9VAmjI=
Received: from CY5P221CA0149.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::9) by
 SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Tue, 30 Sep 2025 04:28:28 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:6a:cafe::93) by CY5P221CA0149.outlook.office365.com
 (2603:10b6:930:6a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 04:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 04:28:28 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 21:28:26 -0700
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
Subject: [PATCH v2 0/5] dax/hmem, cxl: Coordinate Soft Reserved handling with CXL
Date: Tue, 30 Sep 2025 04:28:09 +0000
Message-ID: <20250930042814.213912-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|SJ0PR12MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a9f40b-983e-47d1-40c9-08ddffd9cdd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8piPunmQ5nTYYPH1Snup3rTwrZ790PFZ+HizLYc+UNnBfZtsB8avR/7eg1Qb?=
 =?us-ascii?Q?gOAm6RPKF6EtK13NJ/xuj8zT0jaDk97thW9oLMpjLd/cr5KWZyccg4+E7Xjy?=
 =?us-ascii?Q?M+SZYEWw2EDP4Q+TPTBKmg+7tTONHFD8PImLm5gT6CUsYS4cKt6v5DSrO6Ic?=
 =?us-ascii?Q?QxwZwo3buqLEr0JJF9RsCOJBjLg0AyNSQA7Vzbwt9Dr0wwJKbO/tRHooiZWm?=
 =?us-ascii?Q?1k4/j6sdAHnq1hdbO/tlBuHW0dMvFdTIqR13w4iLNuIhhwJoxrc82NnBxmJM?=
 =?us-ascii?Q?F8lQtYNorqS7knjGBYAwwM9K/Ffa49hn6OSq7emQbJdmN0+ItZrd1wovmegN?=
 =?us-ascii?Q?3D3FpQOC0Ck2Y7yRjaZQJpI+kquv+m9E4Za5l15ncyQ3iWCftXeCR3jRQKej?=
 =?us-ascii?Q?6xOZtHigjpwNzTLwY23VXz6HZn09+NC/Nqxg56vIMtoYZtKXooq0ccS/510F?=
 =?us-ascii?Q?sHeEVcSXF9uPi2wCa2+PIjUivY4JNV7MfguSi8pzuEk58YxRpqj6uKdnan1H?=
 =?us-ascii?Q?yAUaJFq4olKkyMjr+CyuGf1Re9hZSDIVPcZic0xygp9BmoCKv5ezbzr8qmfM?=
 =?us-ascii?Q?+Ntp+8rIEx4WH46HJg810qeQDK8ge1vQ8NzhB46ql/cu5yp8h4QDCNiCYx0r?=
 =?us-ascii?Q?j28OkdbLen+l8MBkcds0NG3FSQZX1I2njtOHxIE4WDZfCx1PH1ZpxCieKutd?=
 =?us-ascii?Q?7w0Z83xeQanDdUFM53cNHos6xzTejCzyyzmhSwD27y9cHnp6zqKp6coMKOhy?=
 =?us-ascii?Q?Uai2P1jyqTyoeE/S7gGMF7U6HC14YUWxYnFIlcB/XXXpmZu6WLK5fLTnEGQz?=
 =?us-ascii?Q?d9X+F+VtucBWVUAd5HeVWpHt4YU3ZqK3tO1aQEBIKCOSVpa2jXCQXIMX9osD?=
 =?us-ascii?Q?pSBM05t+t4UMT69WVniTNa74R4+mqzZAzLj/P1fSTNd/msBm4BBo90YJfBvf?=
 =?us-ascii?Q?XBZzBL/94mqdQROv0qYlwCXXuFsvPXXN8fGQNu2V3e9NZkIIzKBTLBx7hxf/?=
 =?us-ascii?Q?LkzAsbTntbgBvd7nCIEeSh2WSWxFoB+mjkzuEBOXGHVxbe3GFao4duGOJvEs?=
 =?us-ascii?Q?41JKL55S3eWkM4JPRRVaCpoQfaDG5EF6MN0LamD4UBl+geW9HD63PYX//qd8?=
 =?us-ascii?Q?JVXYF08ytdHl6lEAEWsxV0TP78CZUog9tipHD3InURbj2msbWGnLoATf8ohq?=
 =?us-ascii?Q?wKCFEVns2ECTWhheNKkgjqNJNpAjANZQ8/fJ/+iwe46DIbfvYT6PtevHhr6S?=
 =?us-ascii?Q?jQ4JsD9UvDnh4IUASvJzrETG42vkjLBdgD7HDYAmDPP/A5tKAmKXLpIPdFSu?=
 =?us-ascii?Q?11BpNNtHvUCKe5HdxsupJXw1bfPlWbj+UfKwSsQyMdhAE5QBb2wIPu56eLL6?=
 =?us-ascii?Q?ziW9GjfGmCX9HAj7KCxzB7yRcBnqhs9fDey/U+nPEy2JAPn4mDMtWinvurj3?=
 =?us-ascii?Q?9oqBAtEMmUkrB6ZTyrIbIfWMJO5kbqORXfsFD6ULMKh1npLd17Nz3n2wuyYY?=
 =?us-ascii?Q?EOaLBlQjLzzwz2+Ba0B1jFPhAQH32lEVKAVq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:28:28.2259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a9f40b-983e-47d1-40c9-08ddffd9cdd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634

This series aims to address long-standing conflicts between dax_hmem and
CXL when handling Soft Reserved memory ranges.

Reworked from Dan's patch:
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/patch/?id=ab70c6227ee6165a562c215d9dcb4a1c55620d5d

Previous work:
https://lore.kernel.org/all/20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com/

Link to v1:
https://lore.kernel.org/all/20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com/

To note:
I have dropped 6/6th patch from v1 based on discussion with Zhijian. This
patch series doesn't cover the case of DEV_DAX_HMEM=y and CXL=m, which
results in DEV_DAX_CXL being disabled.

In that configuration, ownership of the soft-reserved ranges is handled by
HMEM instead of being managed by CXL.

/proc/iomem for this case looks like below:

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

Link to the patch and discussions on this:
https://lore.kernel.org/all/20250822034202.26896-7-Smita.KoralahalliChannabasappa@amd.com/

I would appreciate input on how best to handle this scenario efficiently.

Applies to mainline master.

v2 updates:
 - Removed conditional check on CONFIG_EFI_SOFT_RESERVE as dax_hmem
   depends on CONFIG_EFI_SOFT_RESERVE. (Zhijian)
 - Added TODO note. (Zhijian)
 - Included region_intersects_soft_reserve() inside CONFIG_EFI_SOFT_RESERVE
   conditional check. (Zhijian)
 - insert_resource_late() -> insert_resource_expand_to_fit() and
   __insert_resource_expand_to_fit() replacement. (Boris)
 - Fixed Co-developed and Signed-off by. (Dan)
 - Combined 2/6 and 3/6 into a single patch. (Zhijian).
 - Skip local variable in remove_soft_reserved. (Jonathan)
 - Drop kfree with __free(). (Jonathan)
 - return 0 -> return dev_add_action_or_reset(host...) (Jonathan)
 - Dropped 6/6.
 - Reviewed-by tags (Dave, Jonathan)

Dan Williams (4):
  dax/hmem, e820, resource: Defer Soft Reserved registration until hmem
    is ready
  dax/hmem: Request cxl_acpi and cxl_pci before walking Soft Reserved
    ranges
  dax/hmem: Use DEV_DAX_CXL instead of CXL_REGION for deferral
  dax/hmem: Defer Soft Reserved overlap handling until CXL region
    assembly completes

Smita Koralahalli (1):
  dax/hmem: Reintroduce Soft Reserved ranges back into the iomem tree

 arch/x86/kernel/e820.c    |   2 +-
 drivers/cxl/acpi.c        |   2 +-
 drivers/dax/Kconfig       |   2 +
 drivers/dax/hmem/device.c |   4 +-
 drivers/dax/hmem/hmem.c   | 128 ++++++++++++++++++++++++++++++++++----
 include/linux/ioport.h    |  13 +++-
 kernel/resource.c         |  92 +++++++++++++++++++++++----
 7 files changed, 213 insertions(+), 30 deletions(-)

-- 
2.17.1


