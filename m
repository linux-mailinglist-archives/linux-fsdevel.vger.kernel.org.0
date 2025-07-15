Return-Path: <linux-fsdevel+bounces-55010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCC5B06587
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13607A725E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC8D299A83;
	Tue, 15 Jul 2025 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JmpMf+Au"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD88299944;
	Tue, 15 Jul 2025 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752602672; cv=fail; b=eqXONvhqVunymNTTZmLnzyRwsVgvn+kqWiG0ay/17guDmWPQxLQ+qPhz+PH9KUrkN/63jbvzVy92NSZuVohpm1nzFvoYjhE22hZYdEli1p5TUiznLvuyHOpzPXVcrYvKY0LyN1AgaD7TFVHP1tmI2oUMpa3DbpmLula534pa0RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752602672; c=relaxed/simple;
	bh=QUzzEeA1pQ1vqbXu3Z/ME+DEWmEIZLxVxFjKpJ8XE0Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C/DT9Vm8vHu0zN1URi/N+cEPv9eaBJ/9lllwvBW4RC4w8BYkSOsjZKBpk3B3nRbxIcCGbTIkmLMV+5hJlZ9MfNu01P/MWzVkqqYaftucvzspF3zkn2k0lIQivW9LvreWg+ysVqnMu9tMOtkX21MRb6THIzfJWq7anOvoRne1z70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JmpMf+Au; arc=fail smtp.client-ip=40.107.101.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iI4f9YZLtZDh382X/R95qeVgZuYoN+2HbH6WjvZUsp+ZPdgR+zfAM8kSqLqXsDdEBE9lZb2HPuRHhaOY18hTFOJTMKBX1Q1hgRyCrhXzglnAzN6t0nUYPWfKPE2lnVqTJsvfV55nq1Q2NdlfM0ZS9ePiIgKKpyOZvN1g8EdL8za8XL8SHtr9J54OapxIRRXWlVbZIYqcAqQCXeTaJ/7GUilmdoBfmlB81WCZFV8Rkhb3zAHMCtQter9zLwWBQOpT+8/dWQD34yG3COuyrhZIOIF5qXoNN51U4XIMEuTqid40lm6COhXIZPmZN2wPHh9ddDLdg736x7gUMzeXDHDo1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfg4SmWW+QBWNTEknqFNzjG5ntPACQTby+EZhisPqFY=;
 b=dy+x/33Uk1boEH3adgesT074dYbHXGxyT/6XGEoDRTCtSKbIyqEM6Y5T2HMnpAUDPcmbv/9rFQu9Z99vG2ZYaPnDaCsNNqRgIEvgY9TFbKEWE9kz3Pw/jyWtXArA20twS7LCNsFbQV1V/KmyQ7IXyy4jBJZe0WdlMHlpEV++RLtjqkWV9QciH6+H0IeG10Kf5jMXMoXUzKnIFKlIbMzCDFzGH13f8PgRVt4CxMymPK5K2vr2YfMwMEendQvqBRqn82bfO95Dl1QiNgAC4eysFUiFMMdUNTO0P/Dh9g+5uGCwHpmEkxaSLwyMiQPmZ8Eu6ZNf51E8tiU4667IMj3wyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfg4SmWW+QBWNTEknqFNzjG5ntPACQTby+EZhisPqFY=;
 b=JmpMf+AuGh/MDnjZhA5jJDQtS02JV8kf6EtVEetJCrHB4QV1zlmYDcNyS7AG+bNjFCwKj9Nk00W4SPyj+M4AjXAnh/TGush/LZ1cq5ou14Mz0wnLsjm3juSzzqsdZ2XwvVEa3KoSZWGgNrn/nwtjbxC/Yqc/beK7Em/xI1zvE7c=
Received: from BY3PR04CA0027.namprd04.prod.outlook.com (2603:10b6:a03:217::32)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.23; Tue, 15 Jul
 2025 18:04:28 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::9e) by BY3PR04CA0027.outlook.office365.com
 (2603:10b6:a03:217::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 18:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 18:04:25 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 13:04:24 -0500
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
Subject: [PATCH v5 0/7] Add managed SOFT RESERVE resource handling
Date: Tue, 15 Jul 2025 18:04:00 +0000
Message-ID: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8968d3-d853-42b0-d52f-08ddc3ca092a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ermDAzcSQL8kKMw+nNRFzP7Vnev6fTMGYSGjby25++WheJffULVbDC2zz59Q?=
 =?us-ascii?Q?zyA9HkEg4kNK0X5e6rSBLirDC0JWhackeh1cNqwvp2ooXzisJlgVNiEJBa2J?=
 =?us-ascii?Q?DanflT6WtYwCjAbShHqRY8962JcHe37imKtInYslFo57nDx78Vs6T+b7+7E0?=
 =?us-ascii?Q?ar7y0JeL4+d4/YQ9+SRA2hsUicnBNDq+JP2gW7RRbjCi3cRPxyV3y9GAV5Bi?=
 =?us-ascii?Q?iY+UqQ0uqrrp0WTvZ3FMv2ABmL2OWOQ+CdQyrEXK/aPw6fOl2PGR9jXtgSWo?=
 =?us-ascii?Q?Vt9RLANI5z4/Spwmwig8viYwOAS1K4aZM5dVWwi0tSeOLm+i1oUEr1HSEPbb?=
 =?us-ascii?Q?6biXAfOqYki35LO+yJHhUq74tEZI8aAkIwG8yQCbO1tIM/xSlNEyJb2K4zu2?=
 =?us-ascii?Q?9SHuGgFg8NoTDVgBnVcHTjLJdRXwlL9PRZAfCDwjkTUTGfl8ArRJZNm11DjR?=
 =?us-ascii?Q?vDFFLvb8ixsnCzuLNhK4Lb7BEaA/UD99ChdC/bEpGYuFkVMy5AT4VRvvw6yV?=
 =?us-ascii?Q?KjH7XP/m/dUaKMgpwYeYLQRFVLxDaiGKBvuJpNxnE9TohTepV1/S+IfjzxAC?=
 =?us-ascii?Q?N3Tzz2HWmxSx3CfI6omtOwBKm+Rpez/VFXizPEQAj9rHnTmJlwIKJ2RFicQj?=
 =?us-ascii?Q?xeL9SrCr7p0d1KxFu7P2QNEwJVxvpxA1rsbOBXpMtpO2opUTSq2wuZMbnM5R?=
 =?us-ascii?Q?hDRItZHPyyLPp0jJTapmbPW5lPMpTedvINmkCnMFWz2hbHyf8hSHUSjSRAya?=
 =?us-ascii?Q?c1aKOvm8W102vzIFVCy+vv+W6I5u9nVhxqhg8p6DLbvzQzqD/+5xA5mEoPuh?=
 =?us-ascii?Q?E3LhMq8amweFVX+mAzYgxtve25gbnuNgCL8GyGL7EZ1XogkAggvG8kMzVHkP?=
 =?us-ascii?Q?/AOUrbKcKlGe2K/hHc+eStTsHaeLxiGZ8L1A0RSa3TaCYU2MF2YMHVcb4ouC?=
 =?us-ascii?Q?2jufFn8Gg2DoeG9Ya6Yl6LYnBOWqzLPSWgQdqTwnheXU3AvdCkT5PQ+urvqJ?=
 =?us-ascii?Q?3PGvWE9nBmKT26SIjan3HwUQhmXCdG3ONjnZk0/uQWiYKylYv5URDLMYwALq?=
 =?us-ascii?Q?OaBDbJKQLCDCYrcNssCC4v6mwgsHu3H7poF+PT0ASpQF98LS8xSurV4F7HTu?=
 =?us-ascii?Q?xjfk7g9ifqPsCqpYIWO4FA2akYzLUq784u3OVrDWOJDGxJi+6H0AEWZnuWoH?=
 =?us-ascii?Q?zrFxOHohUKn5fsDNq2TcKmtXgKCOOcX8CWvsqtkl69GZdD96DgavMZOKYBGg?=
 =?us-ascii?Q?5sLCCB49sOCOUB7f/3lDwhzGGDudu5h9X3dDeew6cjqeUaT5sikRWpSS6ilP?=
 =?us-ascii?Q?T9tW9UzzKdh5km44SpnmiGoaddJT5fzMSVLZxEWwGX85hpy2eHWJdHN79XCj?=
 =?us-ascii?Q?yfMj1SjKA5fWCkB/fuzEeGWpXj6BehlUXGnYu+vT33FULHncjiI1zpJjOo/u?=
 =?us-ascii?Q?0GCVLtD5BTEPMcnYXw8ziCyqLGthtoRQEtyqhTJ2czBzYloiG204DW/1V0Pp?=
 =?us-ascii?Q?b5mRc7bCFx1O1kVR94I4iJhzF6B27ajt1E3G9YWW8ywzqhM2yKRvSJzexA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 18:04:25.9090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8968d3-d853-42b0-d52f-08ddc3ca092a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206

This series introduces the ability to manage SOFT RESERVED iomem
resources, enabling the CXL driver to remove any portions that
intersect with created CXL regions.

The current approach of leaving SOFT RESERVED entries as is can result
in failures during device hotplug such as CXL because the address range
remains reserved and unavailable for reuse even after region teardown.

To address this, the CXL driver now uses a background worker that waits
for cxl_mem driver probe to complete before scanning for intersecting
resources. Then the driver walks through created CXL regions to trim any
intersections with SOFT RESERVED resources in the iomem tree.

The following scenarios have been tested:

Example 1: Exact alignment, soft reserved is a child of the region

|---------- "Soft Reserved" -----------|
|-------------- "Region #" ------------|

Before:
  1050000000-304fffffff : CXL Window 0
    1050000000-304fffffff : region0
      1050000000-304fffffff : Soft Reserved
        1080000000-2fffffffff : dax0.0
          1080000000-2fffffffff : System RAM (kmem)

After:
  1050000000-304fffffff : CXL Window 0
    1050000000-304fffffff : region0
      1080000000-2fffffffff : dax0.0
        1080000000-2fffffffff : System RAM (kmem)

Example 2: Start and/or end aligned and soft reserved spans multiple
regions
|----------- "Soft Reserved" -----------|
|-------- "Region #" -------|
or
|----------- "Soft Reserved" -----------|
            |-------- "Region #" -------|

Before:
  850000000-684fffffff : Soft Reserved
    850000000-284fffffff : CXL Window 0
      850000000-284fffffff : region3
        850000000-284fffffff : dax0.0
          850000000-284fffffff : System RAM (kmem)
    2850000000-484fffffff : CXL Window 1
      2850000000-484fffffff : region4
        2850000000-484fffffff : dax1.0
          2850000000-484fffffff : System RAM (kmem)
    4850000000-684fffffff : CXL Window 2
      4850000000-684fffffff : region5
        4850000000-684fffffff : dax2.0
          4850000000-684fffffff : System RAM (kmem)

After:
  850000000-284fffffff : CXL Window 0
    850000000-284fffffff : region3
      850000000-284fffffff : dax0.0
        850000000-284fffffff : System RAM (kmem)
  2850000000-484fffffff : CXL Window 1
    2850000000-484fffffff : region4
      2850000000-484fffffff : dax1.0
        2850000000-484fffffff : System RAM (kmem)
  4850000000-684fffffff : CXL Window 2
    4850000000-684fffffff : region5
      4850000000-684fffffff : dax2.0
        4850000000-684fffffff : System RAM (kmem)

Example 3: No alignment
|---------- "Soft Reserved" ----------|
	|---- "Region #" ----|

Before:
  00000000-3050000ffd : Soft Reserved
    ..
    ..
    1050000000-304fffffff : CXL Window 0
      1050000000-304fffffff : region1
        1080000000-2fffffffff : dax0.0
          1080000000-2fffffffff : System RAM (kmem)

After:
  00000000-104fffffff : Soft Reserved
    ..
    ..
  1050000000-304fffffff : CXL Window 0
    1050000000-304fffffff : region1
      1080000000-2fffffffff : dax0.0
        1080000000-2fffffffff : System RAM (kmem)
  3050000000-3050000ffd : Soft Reserved

Link to v4:
https://lore.kernel.org/linux-cxl/20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com

v5 updates:
 - Handled cases where CXL driver loads early even before HMEM driver is
   initialized.
 - Introduced callback functions to resolve dependencies.
 - Rename suspend.c to probe_state.c.
 - Refactor cxl_acpi_probe() to use a single exit path.
 - Commit description update to justify cxl_mem_active() usage.
 - Change from kmalloc -> kzalloc in add_soft_reserved().
 - Change from goto to if else blocks inside remove_soft_reserved().
 - DEFINE_RES_MEM_NAMED -> DEFINE_RES_NAMED_DESC.
 - Comments for flags inside remove_soft_reserved().
 - Add resource_lock inside normalize_resource().
 - bus_find_next_device -> bus_find_device.
 - Skip DAX consumption of soft reserves inside hmat with
   CONFIG_CXL_ACPI checks.

v4 updates:
 - Split first patch into 4 smaller patches.
 - Correct the logic for cxl_pci_loaded() and cxl_mem_active() to return
   false at default instead of true.
 - Cleanup cxl_wait_for_pci_mem() to remove config checks for cxl_pci
   and cxl_mem.
 - Fixed multiple bugs and build issues which includes correcting
   walk_iomem_resc_desc() and calculations of alignments.
 
v3 updates:
 - Remove srmem resource tree from kernel/resource.c, this is no longer
   needed in the current implementation. All SOFT RESERVE resources now
   put on the iomem resource tree.
 - Remove the no longer needed SOFT_RESERVED_MANAGED kernel config option.
 - Add the 'nid' parameter back to hmem_register_resource();
 - Remove the no longer used soft reserve notification chain (introduced
   in v2). The dax driver is now notified of SOFT RESERVED resources by
   the CXL driver.

v2 updates:
 - Add config option SOFT_RESERVE_MANAGED to control use of the
   separate srmem resource tree at boot.
 - Only add SOFT RESERVE resources to the soft reserve tree during
   boot, they go to the iomem resource tree after boot.
 - Remove the resource trimming code in the previous patch to re-use
   the existing code in kernel/resource.c
 - Add functionality for the cxl acpi driver to wait for the cxl PCI
   and mem drivers to load.

Smita Koralahalli (7):
  cxl/acpi: Refactor cxl_acpi_probe() to always schedule fallback DAX
    registration
  cxl/core: Rename suspend.c to probe_state.c and remove
    CONFIG_CXL_SUSPEND
  cxl/acpi: Add background worker to coordinate with cxl_mem probe
    completion
  cxl/region: Introduce SOFT RESERVED resource removal on region
    teardown
  dax/hmem: Save the DAX HMEM platform device pointer
  dax/hmem, cxl: Defer DAX consumption of SOFT RESERVED resources until
    after CXL region creation
  dax/hmem: Preserve fallback SOFT RESERVED regions if DAX HMEM loads
    late

 drivers/acpi/numa/hmat.c                      |   4 +
 drivers/cxl/Kconfig                           |   4 -
 drivers/cxl/acpi.c                            |  50 +++++--
 drivers/cxl/core/Makefile                     |   2 +-
 drivers/cxl/core/{suspend.c => probe_state.c} |  10 +-
 drivers/cxl/core/region.c                     | 135 ++++++++++++++++++
 drivers/cxl/cxl.h                             |   4 +
 drivers/cxl/cxlmem.h                          |   9 --
 drivers/dax/hmem/Makefile                     |   1 +
 drivers/dax/hmem/device.c                     |  62 ++++----
 drivers/dax/hmem/hmem.c                       |  14 +-
 drivers/dax/hmem/hmem_notify.c                |  29 ++++
 include/linux/dax.h                           |   7 +-
 include/linux/ioport.h                        |   1 +
 include/linux/pm.h                            |   7 -
 kernel/resource.c                             |  34 +++++
 16 files changed, 307 insertions(+), 66 deletions(-)
 rename drivers/cxl/core/{suspend.c => probe_state.c} (62%)
 create mode 100644 drivers/dax/hmem/hmem_notify.c

-- 
2.17.1


