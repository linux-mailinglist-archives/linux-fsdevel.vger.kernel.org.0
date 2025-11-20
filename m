Return-Path: <linux-fsdevel+bounces-69177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9E1C71F51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 04:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBB784E484E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 03:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F592C11E7;
	Thu, 20 Nov 2025 03:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fy2agbIl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F717DE36;
	Thu, 20 Nov 2025 03:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608783; cv=fail; b=impg64ROH/C10nopJ7dBrHd8jBGoC34s/8/ei7QHwIqjNwshU4lEV76QJ4HmmLMJCASRhTM4sP+CXwPL3Z/oIWBQMyA30Et+1SjgW7u3U8gNIxOPv7TXQOftBfd55CvBBHLBXsLWAlZa7n24UOuLh2En6nSbMxx68KCd/AHl6F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608783; c=relaxed/simple;
	bh=D5CDPxzMuUGawfcPDKzZEDXvyblSIQdNZa7YtrmUtRo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oXWtn48hcbtF5MS1SiC4jkC1sVAr6h+8jvScDzTg4wNnADIceCBTjT6qefKIO8FmxOk5ugi/BLy3DBKqpIPvFjGitZtbLiICNibd1hsTM+3pM85i0Xu3Y9k7Wp9gj+sJfJ/WXIHM2wI3HoLuhe1/dZhz2+nFrzN6z+XeV5EJun0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fy2agbIl; arc=fail smtp.client-ip=40.107.209.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaltEn4EyzrC5cPhdh81K+Bs5ZNh60Yu75RX7dbiQJsvPkJoAKY98DpHaubv8C01eMX3LifV4HjfJdYfaxmpPbP8f0y/EV/fUPFwBOfWDt+73TDBMsmvesAAZR5V4vDFihVvV6+wwHLYMuTJkJA/LkW8zVxPPDhbdV+alj3nWH7zJo/D/PuDmVTx0eq72XMuZ8wVRTqrGw/CPLM1vUocSu9hU8a16Z9At+9yH5zYDaeU3MJ9HiHptPE+cB00JLQmjSflfeGCBQ0Q4a+LSwUYsvtlrnhVPkfYJov2IzLdkAy/RK+ZFArVfxSS0CChf6w5+fbW3kfEYCAC/OlYd1NuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SS4qU1N4keZM94fTFGZtwA0lL0Yw4dPTpjSifNKUZY0=;
 b=QLYR0+sNBPWUXiKisftZWUYSN+aSm53c9kZOXcWUVYlFGaEOjturfBTJajZPo3mjuEbzBo2/Lt7Zhpb5rin1Svvg84XlImD5pvb34WK+vBb+McnXXS3TBsGqxJfzJj95JjmKuQ49HZy1u2U0r5sHlMipvtc+LwBw+gLvLhz0LNaUhGBjoYeMi+pCeUBmr8QEKP/WKcdZcvl1JKSjSQB0xw905KKGbUvxNZcXruzGPtLX9n6dyeX/sFY0UWYWNFFU4QFgjLEEIv8RGV9EQWyodizVMsGYac0a97/mmKfTUmC8H3cMqn1qMjZGfLelPAIvT1T7yp1sqCfUI/n5cgZAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS4qU1N4keZM94fTFGZtwA0lL0Yw4dPTpjSifNKUZY0=;
 b=Fy2agbIlgB5xDqOa8ijAmIOn8Sk9u7caV/jKr94yspYJu7vZo9xr2spb3860W6K4yU0Op7x/O3wD+Vdl4jyYmmeqJ+YaMwi89wREvAT0y10zxtfNyXlwIwWW/VJMyhTvkT7Va0YIPEnxMm+OesT4t2SjpfbBgtw1WXuRc4CC9Fw=
Received: from CH0PR03CA0450.namprd03.prod.outlook.com (2603:10b6:610:10e::28)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 03:19:36 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::f0) by CH0PR03CA0450.outlook.office365.com
 (2603:10b6:610:10e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 03:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 03:19:36 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 19:19:35 -0800
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
Subject: [PATCH v4 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling with CXL and HMEM
Date: Thu, 20 Nov 2025 03:19:16 +0000
Message-ID: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 95719299-ec36-4d87-287c-08de27e3a249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XjgXOf2PkooVS53Myaz3AQzaaVetdmG+4oSHBBcxpBNhLK3taDgKUeGlkVVs?=
 =?us-ascii?Q?nZZMtVEeoAZVDzWOIHOOL6GOQcYT0WtxFHkuLzBVkVTLJPxm6PRaOy5Q9tgy?=
 =?us-ascii?Q?qb67ivaMYOFeO2MG+ANdN5J+n/JGDYV0AJ5/UvupzFgLbJDo33C4TMCFpMPH?=
 =?us-ascii?Q?XhosANW9Zwu7iggTVLoc+in72ODDrDYSfXkZK28G3ERUV47h75ObWFGN1zCy?=
 =?us-ascii?Q?jmaP45Mx9JHJWh4czMOBUKGQkbEsoeqyXP5V/l09mkhOQiXu49la4fq3h5IX?=
 =?us-ascii?Q?oq7JRFWBYh3J/XQxV3/60sGGSOhzMj2n+k7C0xfLKkO7iRMxTqy1+Vb8mm5L?=
 =?us-ascii?Q?6z2eZjxkQq6zWrzMHlJyjrp+OeEtsW9Cbl0mVxfOQUlq9ge5V2zZdj9Y7kOV?=
 =?us-ascii?Q?CVHVa4r7vuDD+6NmdGT7jDm305j1wa7+hBnX30uoRpd3xH7WxaN6AJYuH+Ry?=
 =?us-ascii?Q?Mw46ctB2OEq172E8CNDsJUz2AHJYOHDq3P9g8vboKDKZvXQ7AfZKiClkAfpH?=
 =?us-ascii?Q?j3ZeQF85e3guO+ht+yOhLL9uX1qx49wpy/IGExrQos0YTJolVovSdHareAy6?=
 =?us-ascii?Q?CRb7+TdKxZbjHMNTgAfXB2UvUclNR6oPxsQdl6bbSQZAt2+xkfokCUkP5ROP?=
 =?us-ascii?Q?WzG+fvC/M+lIZ7xMsVw6Fp6CA4+z5BhJEANbd721/oJips7c+IH9EDR9Khtl?=
 =?us-ascii?Q?R6RGxOpmIFfHF92jQv/RYMS80OVMMKiPcpY0KMeX86dlVcY65jokchPyUfqF?=
 =?us-ascii?Q?3+YP5ozn1m5JaE7IsTPxIPLsag2UCPTeIwasI12qJV+89zUln4zxx/8OpwdM?=
 =?us-ascii?Q?Yv7i2yzSCCc1adiv5VZdJS7mzOXra9all8kB4YQE9Dnqa73O0s3rAiPcrTRg?=
 =?us-ascii?Q?sXuFb5aXSaZ3lxMoima/iB2EJfUAyLHhMe+4rX2LhT04bcqLCKwsq4lTDkSb?=
 =?us-ascii?Q?iD5oE2NH9e/JiTOVST3PnzhgJdZlj1J6m9kvZfobUZXdyyM82sgnLJRvQKkK?=
 =?us-ascii?Q?nA9LFK9NwG7ZXWmZdc4VUSJtPlkxy0BsEFeoG6Qy57znpbjrJvYb1IOENYX0?=
 =?us-ascii?Q?TvqZhq7PxUaDbfvlUtOy9Ike+JogwoS/cBkvsSGobA8yXJrNaZNhqZU+ET5s?=
 =?us-ascii?Q?FvHi14F5lKStZIIomh0FrHTqC9HVRYK0+P5zFHa2xM/SjzXUs1Uvy3AwKIME?=
 =?us-ascii?Q?b2G4YYF2Az5PKOam756bxz6rGFStLdzOvQR55EqJy5pC4Xw3CHMHP7Os7xIT?=
 =?us-ascii?Q?LRsOnPZYig+yJrD+7vorhPkXik4klqg8RNWY3jGpjXsARqy5ppYnzOLM8BEm?=
 =?us-ascii?Q?w7J2VTJFGyokHqqPWKDnsJPYvd8Sl6MTgv31rJ4xD34DQGS2jAUe1W64s5Rb?=
 =?us-ascii?Q?25Lyp6QxiqkZ4djGc6j/j+WZTgHGXeftK/6ZkHvmzF0UCCnh2NnpeFFUReVe?=
 =?us-ascii?Q?CRikTs204U1taCZxt+6pqtmMf7bvDfn7S3FSMb6XbPJXiZYBskzhSlkXrilo?=
 =?us-ascii?Q?QFo6UvgSCkknsocLSsp5fQh91j7IlrQuxqkxjpuWdY0EJJlE4W+8+C3VYtmu?=
 =?us-ascii?Q?hnK11MD1SC8sHrlHWxI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 03:19:36.6609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95719299-ec36-4d87-287c-08de27e3a249
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045

This series aims to address long-standing conflicts between HMEM and
CXL when handling Soft Reserved memory ranges.

Reworked from Dan's patch:
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/patch/?id=ab70c6227ee6165a562c215d9dcb4a1c55620d5d

Previous work:
https://lore.kernel.org/all/20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com/

Link to v3:
https://lore.kernel.org/all/20250930044757.214798-1-Smita.KoralahalliChannabasappa@amd.com

This series should be applied on top of:
"214291cbaace: acpi/hmat: Fix lockdep warning for hmem_register_resource()"
and is based on:
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada

I initially tried picking up the three probe ordering patches from v20/v21
of Type 2 support, but I hit a NULL pointer dereference in
devm_cxl_add_memdev() and cycle dependency with all patches so I left
them out for now. With my current series rebased on 6.18-rc2 plus
214291cbaace, probe ordering behaves correctly on AMD systems and I have
verified the scenarios mentioned below. I can pull those three patches
back in for a future revision once the failures are sorted out.

Probe order patches of interest:
cxl/mem: refactor memdev allocation
cxl/mem: Arrange for always-synchronous memdev attach
cxl/port: Arrange for always synchronous endpoint attach

[1] Hotplug looks okay. After offlining the memory I can tear down the
regions and recreate it back if CXL owns entire SR range as Soft Reserved
is gone. dax_cxl creates dax devices and onlines memory.
850000000-284fffffff : CXL Window 0
  850000000-284fffffff : region0
    850000000-284fffffff : dax0.0
      850000000-284fffffff : System RAM (kmem)

[2] With CONFIG_CXL_REGION disabled, all the resources are handled by
HMEM. Soft Reserved range shows up in /proc/iomem, no regions come up
and dax devices are created from HMEM.
850000000-284fffffff : CXL Window 0
  850000000-284fffffff : Soft Reserved
    850000000-284fffffff : dax0.0
      850000000-284fffffff : System RAM (kmem)

[3] Region assembly failures also behave okay and work same as [2].

Before:
2850000000-484fffffff : Soft Reserved
  2850000000-484fffffff : CXL Window 1
    2850000000-484fffffff : dax4.0
      2850000000-484fffffff : System RAM (kmem)

After tearing down dax4.0 and creating it back:

Logs:
[  547.847764] unregister_dax_mapping:  mapping0: unregister_dax_mapping
[  547.855000] trim_dev_dax_range: dax dax4.0: delete range[0]: 0x2850000000:0x484fffffff
[  622.474580] alloc_dev_dax_range: dax dax4.1: alloc range[0]: 0x0000002850000000:0x000000484fffffff
[  752.766194] Fallback order for Node 0: 0 1
[  752.766199] Fallback order for Node 1: 1 0
[  752.766200] Built 2 zonelists, mobility grouping on.  Total pages: 8096220
[  752.783234] Policy zone: Normal
[  752.808604] Demotion targets for Node 0: preferred: 1, fallback: 1
[  752.815509] Demotion targets for Node 1: null

After:
2850000000-484fffffff : Soft Reserved
  2850000000-484fffffff : CXL Window 1
    2850000000-484fffffff : dax4.1
      2850000000-484fffffff : System RAM (kmem)

[4] A small hack to tear down the fully assembled and probed region
(i.e region in committed state) for range 850000000-284fffffff.
This is to test the region teardown path for regions which don't
fully cover the Soft Reserved range.

850000000-284fffffff : Soft Reserved
  850000000-284fffffff : CXL Window 0
    850000000-284fffffff : dax5.0
      850000000-284fffffff : System RAM (kmem)
2850000000-484fffffff : CXL Window 1
  2850000000-484fffffff : region1
    2850000000-484fffffff : dax1.0
      2850000000-484fffffff : System RAM (kmem)
.4850000000-684fffffff : CXL Window 2
  4850000000-684fffffff : region2
    4850000000-684fffffff : dax2.0
      4850000000-684fffffff : System RAM (kmem)

daxctl list -R -u
[
  {
    "path":"\/platform\/ACPI0017:00\/root0\/decoder0.1\/region1\/dax_region1",
    "id":1,
    "size":"128.00 GiB (137.44 GB)",
    "align":2097152
  },
  {
    "path":"\/platform\/hmem.5",
    "id":5,
    "size":"128.00 GiB (137.44 GB)",
    "align":2097152
  },
  {
    "path":"\/platform\/ACPI0017:00\/root0\/decoder0.2\/region2\/dax_region2",
    "id":2,
    "size":"128.00 GiB (137.44 GB)",
    "align":2097152
  }
]

I couldn't test multiple regions under same Soft Reserved range
with/without contiguous mapping due to limiting BIOS support. Hopefully
that works.

v4 updates:
- No changes patches 1-3.
- New patches 4-7.
- handle_deferred_cxl() has been enhanced to handle case where CXL
regions do not contiguously and fully cover Soft Reserved ranges.
- Support added to defer cxl_dax registration.
- Support added to teardown cxl regions.

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
  dax/hmem, e820, resource: Defer Soft Reserved insertion until hmem is
    ready
  dax/hmem: Request cxl_acpi and cxl_pci before walking Soft Reserved
    ranges
  dax/hmem: Gate Soft Reserved deferral on DEV_DAX_CXL
  dax/hmem: Defer handling of Soft Reserved ranges that overlap CXL
    windows

Smita Koralahalli (5):
  cxl/region, dax/hmem: Arbitrate Soft Reserved ownership with
    cxl_regions_fully_map()
  cxl/region: Add register_dax flag to control probe-time devdax setup
  cxl/region, dax/hmem: Register devdax only when CXL owns Soft Reserved
    span
  cxl/region, dax/hmem: Tear down CXL regions when HMEM reclaims Soft
    Reserved
  dax/hmem: Reintroduce Soft Reserved ranges back into the iomem tree

 arch/x86/kernel/e820.c    |   2 +-
 drivers/cxl/acpi.c        |   2 +-
 drivers/cxl/core/region.c | 181 ++++++++++++++++++++++++++++++++++++--
 drivers/cxl/cxl.h         |  17 ++++
 drivers/dax/Kconfig       |   2 +
 drivers/dax/hmem/device.c |   4 +-
 drivers/dax/hmem/hmem.c   | 137 ++++++++++++++++++++++++++---
 include/linux/ioport.h    |  13 ++-
 kernel/resource.c         |  92 ++++++++++++++++---
 9 files changed, 415 insertions(+), 35 deletions(-)

base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.17.1


