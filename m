Return-Path: <linux-fsdevel+bounces-63078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140CDBAB66E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 06:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC6D3C3ABC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 04:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD00261B9E;
	Tue, 30 Sep 2025 04:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VRIa0rYi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DF3288DB;
	Tue, 30 Sep 2025 04:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759207694; cv=fail; b=mDGtUYHVgBFP9miR5qFbzGmJ0MpUJ32NCKtrTXOR3wWZX1TjJ3noIwM522ZOeR+AW7lJdEUIfRTtYOS3auYlvmVuAPRvSuD26GZ7KF6mGR5iyZneHiTf4VtOhZJ6s3CQqp9pI0g74YmmwYEDFEXak7uJ9IxPG5BavBHre57EOyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759207694; c=relaxed/simple;
	bh=bl11tSgnwbq/DxuhM8MEDpResSpq/nfi1HGVspLJe+8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L+N4RNZ4+xrSz0Da5v21C+le7sZeaTHoL6hQ9yKskr/HPqywMpF+UcuIZ9X5W4EabJbzmrY6FK/L30ELE32J8uEH5AjO08otO89NIe3GiRvyp7C8qi8tMGkhKJ2+qq+u3gYhecLkrBiTq3GUs4yKyd3j8uNwxtBCIJgS7IYpE7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VRIa0rYi; arc=fail smtp.client-ip=52.101.43.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECvHb6sj3PYOnJ2cAdWFwNCDEhPMwOSPAWPUvaJSGJg2x0DTyqNv3ty2dUjDCGzXNzshe7yAn/ce8pob6DT0Pl3W6Bt8GWTkd+6jX3CoaoLT3c1AOYgF5cltPjSnvMk8h1OGsvQ1fKYovnH2es3wTowpTY4Gx7ZbrlIp/jUea4O38VP2Qr/BzLji4XJzcjExpfbhOhFBITwlrQF4LbavxcjEU5u7fDsclgYIf292Fof1CCqxHAv/Hyb+5RaOwQf8ocNq8ORMrmzUp+XVl1jy6/cshKcelQwBglWaDEjlYTNA33YcIsmkhKfWGe1ljOsuPewdTbch0u+wTCGX7goK3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJHRv4jPEL2Kfoliy0Y6X3xLVZk0kA5kxg2OrTveKc0=;
 b=p3LQLZq6ivhARg/CwZOpuna32OY9jTEb9mImNCU9Wl5t+CgSHJV6nEgfQXbkdH+5P5FV70lb7dqhX2br9h7Ih5zuSb5StpdkuYsyhz24zm5x+V61o3XisEiUWQxMmcxsxL7jqs5fVjlH+gphOZhh/eI1MoOdjnYr6R3zMqmimXpktAxYIWTP5c4nKmn8rugjxB1xeSRU9sJfpgU85jrPB4OSfEcGjqqcrJPS2JsEmdZpDTSRbNKW89jEB/xmMZbW0+Ei4megmTgn5YHHN3nfK27i14r1eqqaKoc8XI9khcDGMOn+ewtY4yB3dK+bkyIGw3Vujzs/R/7srV4i4WD1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJHRv4jPEL2Kfoliy0Y6X3xLVZk0kA5kxg2OrTveKc0=;
 b=VRIa0rYiJabOZ49DDZrUXtTt6pUhyGLmVzbBh0GVsGRi7Mek2cJG+cypoThiSck4CEiHGNnvChT6TZRmcaEAAio7Lyxa6hWk7ZgklFwnKF7jznR9yZIHE25np29paqkkVBaXu3K7AS0uxLNT1GqlFqH+WPHHyQmgamIKAoJAJ6I=
Received: from BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::17)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 04:48:09 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::a7) by BY1P220CA0026.outlook.office365.com
 (2603:10b6:a03:5c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.18 via Frontend Transport; Tue,
 30 Sep 2025 04:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 04:48:08 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 21:48:07 -0700
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
Subject: [PATCH v3 0/5] dax/hmem, cxl: Coordinate Soft Reserved handling with CXL
Date: Tue, 30 Sep 2025 04:47:52 +0000
Message-ID: <20250930044757.214798-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 0110a754-c6fd-4363-1edf-08ddffdc8d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v/y8lPnE/pRcyDIxrrIRZjGb4iV4w39pO9MRNamvAi+h1aJzK5TOYZ/HmtYc?=
 =?us-ascii?Q?cgx7bQ4gZiW0HrtBRhPwP2+4wSX5KObyTbOmc5JqHBSzO1ANMmRhKJ3vSrBQ?=
 =?us-ascii?Q?fvzHYB4kv02d+ifXdcjKlxsAaj3qPpTkTDczaeSyWy0SB9zj4qPVjU1dYK0y?=
 =?us-ascii?Q?LuKcSKIK4nYvPwseEIeoxZG0zpv9Gqm6KqBxE4LMreH5wshhbK4qPO+pspiq?=
 =?us-ascii?Q?A1BenU0ZWwuQMRP490cEXFc7s+wCHypai9X+I5Z2F87bp76SQnviIPD+DAro?=
 =?us-ascii?Q?LANNIvidKsqLcqkU2ghHRqTegtiCEdox7JMpPrWvTpK46CEgpsUMW1rONNx/?=
 =?us-ascii?Q?BkRQjpNbp8XzWAUWPY2z3J15rng7ISoNFFvWulZE9+5T5UIEcnbPBWtip4iq?=
 =?us-ascii?Q?usobu1zQ1GGgIrAotpsxSRFtcCuM82f69wMgHv4Y1NnAU15rCkrBI0H2M0lW?=
 =?us-ascii?Q?q5K9mnI9iRGotzWWJWgrXMzcVqrsblI+Pnzvsq7YlBC/rjwzbcW8w2ynYVi1?=
 =?us-ascii?Q?pnxwk2yLc5CD57z+0b7fqtgoE8kQVbSXW6qwv1dTftMV5gtjiBUIY2x++hcX?=
 =?us-ascii?Q?k5X6Z/VhVuGBFSyHZruMQvtLOy/H/bYFPB1uLKn8hk7/CPwwHIkxD8/KOaQX?=
 =?us-ascii?Q?og2I/P+oz+RuSDxdpL9nbTlFPK974rVOOZ+eD6qTloO0XL/idTW85bvzoprq?=
 =?us-ascii?Q?4c+lTrYMnZk1o54+/MJZD3391rQVqlp18EzpXgZ/MlbN/N+noNy6FNrZvsDJ?=
 =?us-ascii?Q?XKKbKse/P9QZBDoYVrDRvM1tJ1qeVKmA7t5V475afd8K+48+SLq3nXLkxqMU?=
 =?us-ascii?Q?skNMkQFz43c5+rtqFmlID3qc1k5FCEz85LznF8btYJxMrGo9P/TDmwtYlrud?=
 =?us-ascii?Q?m5E37o9D6S4aqq6o8ZzY78869OaCgJGrDpRlVUPP8ZfEs6jW+K4PLdC3nBdp?=
 =?us-ascii?Q?PjJndsPXJN7mM4qJgmQht06Bey3lJpQCXhXcJH7bUdO72h+ZWauJIrddexYX?=
 =?us-ascii?Q?JQ8tiXSMYhh1cnfmZpstPcR1gvZw7SkQ2jDUShlFJYBQHckp1xBFRjtQbTDR?=
 =?us-ascii?Q?F7Ms6fVmS04Y1tF1HJTRts3FqNWUHdCamOjvhnX8tM5bYoVyGGBjkz/zP6Pm?=
 =?us-ascii?Q?OFGLmdLNq8GR0uEpQUWJa274QG9Pl1BrjTXbsy49UgzwE1CZ/xvj35Nu+YZY?=
 =?us-ascii?Q?t+isZqSE0gNKPlPhxgHSmSBJtd7cIsVdOMS7yh+j1VRLexBfgcTy87qxuVkO?=
 =?us-ascii?Q?0BPgdDCiiINUoTFOSpXr5JOrhX3W9bYsvkBz7guHSuU+WwwAZ0GlcDOcgpLq?=
 =?us-ascii?Q?RYK7Is12z0VjZJTmALAqYQaPf/NPzuWgLz/SbAoZ3uyuk9T2FUPazWrqB2Fb?=
 =?us-ascii?Q?/HrP/UVq+2LYFGkELt297+Ifx8Jsg8p9ZJZahIr4VALkHBX6CUmSEn5Bsqen?=
 =?us-ascii?Q?KLdEOA+nD716c5txVx+lr/9kN3Xdoo2ZMiW7nzTePwS9ESGL6xMMkA1oXmot?=
 =?us-ascii?Q?B7Rb/xDVWQzbDxJEgvdeKCGs5ySu3q4jS3gI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:48:08.9201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0110a754-c6fd-4363-1edf-08ddffdc8d98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493

This series aims to address long-standing conflicts between dax_hmem and
CXL when handling Soft Reserved memory ranges.

Reworked from Dan's patch:
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/patch/?id=ab70c6227ee6165a562c215d9dcb4a1c55620d5d

Previous work:
https://lore.kernel.org/all/20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com/

Link to v2:
https://lore.kernel.org/all/20250930042814.213912-1-Smita.KoralahalliChannabasappa@amd.com/

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

v3 updates:
 - Fixed two "From".

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


