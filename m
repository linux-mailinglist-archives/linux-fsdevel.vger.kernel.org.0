Return-Path: <linux-fsdevel+bounces-50523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 505A4ACCFB9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED01B3A61BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 22:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA3825394C;
	Tue,  3 Jun 2025 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EG3Cm12i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950BB3FE4;
	Tue,  3 Jun 2025 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748989209; cv=fail; b=rAP/bwgfah1g1Uwi2oZ7ht47E9SJl3wvGyjamE0e5zmEZ1MKst65e7VY+g+CaHiy4CaFGXmr2A5aBx10dItwncfifFLUId0G6UeJ1ivY/sa/ZRTfgXufL7p5XGAcyuBLq6qfOhtR0e6NF41P8ccZOHhy7CQHE/srRS7pXzKIung=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748989209; c=relaxed/simple;
	bh=DOGCLb9gDtpRy7m/Q4mPYHGXU7kd6MmTwsNFIXiYtR8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p3ekF/vnjWOboDBdV6fQj+GtjCmXHlbY8wo5kZxeO+ncIgFyDZCPfmq9vnO+7pST9t79EEB/YFWTW3gPfZtsZMq1Tj5JT5FwcrvWqvReZYR9OomrC1O3Pl6oSCckZm6ZbvHKA1RHWtxzPX1NpnuqdixUnqxhH5cmlqfOErL65DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EG3Cm12i; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQcS6gCJOKR8BZ4j0uwgkVhp/WQcLn80nnlV347vdY+Vm+CtS3EwAtraDZKVrslsCur9iZU52AaHxBkfV+rLSSeDCiSDrDjitFGTe6WjiSRnf7pB6QseYMahSK6/vwYgbm7AZrjzsvXaqz64ut3aHnJzVOwQKe7KBANE0mHr6q+Sbu6oG82ZYiMD6Az8J2tPZ97dQoN1XoxEzPxXKz3VOZQ6CyxZpPAVD99vq9LmRflpG4Fx9Q0MTfk4kt6Gjm1YOPUstCsiU2j0s8WE/2F8KtlOJzLsoUG+lgBJ9Mc6u3ACRrj3PSip2ihvs6WY1yPNoTdipk67pvMMwnu97y268Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFWm5nVKzoziQZxSzIkT0myjQIEY1dbQRUF6RkdNX5w=;
 b=pmxnjLuEYTrfQuqON0llnlDE5h7luINzSXZOP00UHF/l4vJaie0C0nM93pq3lKMcSE7j1AwBCrq+WBCbRmgl9PDcrKM9PS25dOb9VVcyuPYY/svYonND5LXz8cbbX1qsH9aFU3zJBfVQwskHGzOeqRE7saMDyktK5aRnHsCPV4GN4gu+GR5PAkixLZL0fSduEw15BYP95cRdFMeXNWg+JnRmFM/SuKa86uylN1fgUMzlfjKtaRSf6ggw+ytCB1P/K0ecCS4SGEfAAiCoqH8mH363J/UujWEkUKnn91yxZXe0rUOZuf0vx0FozEts7GhGltQawZavXDeDv+mxkj6Rbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFWm5nVKzoziQZxSzIkT0myjQIEY1dbQRUF6RkdNX5w=;
 b=EG3Cm12iuRrwZQcWXjItzCQLbMd8NWC+lXEm28O3CdkdSewZ9AWc9rnZXqb9zfNZSP08ZpB/mrhDTDswWkykU7Z78JKDSshphgIYxuLCP8lqvBbhNVjhGKam9p2YcHcP8wU4rFPCA9pyf9SEEG1atT51fqK/oA+jg5f4uUNWUa8=
Received: from CY5PR04CA0020.namprd04.prod.outlook.com (2603:10b6:930:1e::10)
 by DM4PR12MB6157.namprd12.prod.outlook.com (2603:10b6:8:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 22:20:02 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::6b) by CY5PR04CA0020.outlook.office365.com
 (2603:10b6:930:1e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Tue,
 3 Jun 2025 22:20:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 22:20:01 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 17:20:00 -0500
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
Subject: [PATCH v4 0/7] Add managed SOFT RESERVE resource handling
Date: Tue, 3 Jun 2025 22:19:42 +0000
Message-ID: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DM4PR12MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 241e68dc-7ef4-4e63-b345-08dda2ecc89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEJwRjdiZ1M1T3Z1U1FqUE5HOWZ0b2ZvZEpLMTc4SGdCRlVrK1V5c0lmZTNS?=
 =?utf-8?B?SFNHSUpLZUM0R1pvcld6aWNnRGhha00yQU02eElXNWdWMk90Y3J0U2VjMU5x?=
 =?utf-8?B?ZytXTUNoN0FHeHJDZEdSaDhhK1dtVk1kNDdkbG9tVDk1RmluODFKWFdZUDNN?=
 =?utf-8?B?WlUxTjIveDJGN1d5QVRGTE1HS1RqS0hYaTQvdkxxcXFBL2t5S0RSbE90ZlR6?=
 =?utf-8?B?a2grZ1ZHOHB5TVhVRkdMUXRKMUJYQlY2Y20raUNmQUJLNmUzKzRSZnNTdHNM?=
 =?utf-8?B?aDJPL2p1dHh4bXFpR2hpYjk0UldwWUQvbnlHYmxWLzdveEpGT2U1T0taSUlt?=
 =?utf-8?B?S0RiQXI2SC90NTBLcjZ3TnFrQVNRaHpKREVrRnlMeis0ZVBqcDlYejMvYVll?=
 =?utf-8?B?Y2pjSEhjeVhJWFAwK3RJb3F6SnpRU3dUeTlxbGVTYkt0ZlN5T3cxL0piTFY2?=
 =?utf-8?B?bldRR0MzOXFtUHRIZ1ZmV0x0aDVCWG5tMHcvMEhwK3Q0S2hWTEFBekV1M3pS?=
 =?utf-8?B?NVpHeDg3QXlua2tpblNYQitpc3JiVlZrYXAwajBKUEdoclY5R2t0bnl4a2Jm?=
 =?utf-8?B?MGVQUE5PUm9VU0NmWUlPMWdRcWpLVmQzeDhCN0YzTUJhZ3FVdUxCZnhFeGw3?=
 =?utf-8?B?VDlPWHlBc2NNTXpaMFhsQ1dseklubjNoZDUxcllGL0Y5SE9oTWpLUUF4cVRn?=
 =?utf-8?B?dmJoTmxacDU4ampCN1Z5Mk10QTNFV1kzUEJrNzRYOXFTWEROdG5WSjRYVG5y?=
 =?utf-8?B?MkpBNGlXMWRWQ3pGdnVmaWVjS2dQSC9qc0M2UkF3Uk1ya0FHQUNabTQrR1ZL?=
 =?utf-8?B?YUZwNS9zNERRdTZtSmpUS0tBMFBXMWJsLzZYOW5jdXl0U0Q4REFLeTNzcUUr?=
 =?utf-8?B?Y1F6ZjlXbWErY3I0ekx5Y3hyNVJYMVkxNWd4ZkJGQXhFWXRvTm9KbDQwbW5j?=
 =?utf-8?B?c1d6OXg3Zi94b3p1eFpIa0dXQkhSanJpZ1ErTDY4VHZ3K1czaFlTUlNwWG54?=
 =?utf-8?B?aGhxUXhmMGhydU52TUdOWEFHNE1QL3FxME1QN0taTmJndUIzaDQ1N0JITzJM?=
 =?utf-8?B?Q2hhVmpKVkFpZWhreGZQVWFVemFOdlB5MUptc3lKUkUvYm1TQm5UMFk4eU5w?=
 =?utf-8?B?TXAxY25WcmU5Z0hWczhHLzBhbW1TWjBOaTZDT2UrTE1Qa01pTmZCL21MbTkv?=
 =?utf-8?B?aDdtN1NTWTRiV3ZSOVJtOEtTdUF0dXV1U1lQOS81RGYrM1NtODJOS2d0Ykh1?=
 =?utf-8?B?dkxZUVFIeXNpeUZRbVYxWmR2Wkp1UjNHdmRraTE1c2x6Y0R0RTdsYnNRNW15?=
 =?utf-8?B?K0h0RHNMRDhhRksvTUpFMkR0VXU0aTRzejNsUDhmaFgzN0RZbTZXQzBzNDVC?=
 =?utf-8?B?QzYxbnE1Y1pnUlY2VDZNd01SYUJGOHdnSnNWTHE4M1ZWV2NySEtkcDV5SGRM?=
 =?utf-8?B?bXk5TlpNUlN0dHFFdjFIV2cyYXVDellCenR6NkptOWV2eHU3WTAxYmttWDJy?=
 =?utf-8?B?ektBbXRXSmxPajMxRElPelBpWVpjMGhqeHUxbzBzd2FHNlJVUmMydXQxU3la?=
 =?utf-8?B?Sy9ORmw4bEVZVjRmcytxZTNJcEJ1ZHdXZzRHRHExQzNMWjMvUm15REV2SlEy?=
 =?utf-8?B?VFZlMi92NWNobUxLTHFIQmZpbDlHTmlYeFJzSG1kRk16TDlNZTdCQjVvTmU1?=
 =?utf-8?B?cU95bllNUTdsdXpNTGZJb2k2ei9sZkVYYmJJbFg3RnIweldEa3V4MTNIVDhq?=
 =?utf-8?B?RUk2OThPamNTaDJ6cHgyTXVOUm5YZFlBeEsvZW1JM0VvOVNQdFE3VkMxa1VJ?=
 =?utf-8?B?c0ZlQzRtQTkxRlcwbVZIMUpiTFRrQktuZ1J3S2FRV1dVdmlGTzRONjY0aG5h?=
 =?utf-8?B?ZGxoMGF2SXhUSlYxVC9UK05jODVMMjdmNjhFenErUTdmOFRtVzRyUG1PM0Rq?=
 =?utf-8?B?SzdoYStnV295eWpCMVI1bThHdTNzLy9hWWhEQm5LNUNCamN1Tlhpc29BdERl?=
 =?utf-8?B?N21tVzFRSW9xanpEaWx0REc3YnRHR2RwR3M1TmZ5WWltZmxoR2VRaFlxTk15?=
 =?utf-8?Q?UaMin7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 22:20:01.7044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 241e68dc-7ef4-4e63-b345-08dda2ecc89b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6157

Add the ability to manage SOFT RESERVE iomem resources prior to them being
added to the iomem resource tree. This allows drivers, such as CXL, to
remove any pieces of the SOFT RESERVE resource that intersect with created
CXL regions.

The current approach of leaving the SOFT RESERVE resources as is can cause
failures during hotplug of devices, such as CXL, because the resource is
not available for reuse after teardown of the device.

The approach is to add SOFT RESERVE resources to a separate tree during
boot. This allows any drivers to update the SOFT RESERVE resources before
they are merged into the iomem resource tree. In addition a notifier chain
is added so that drivers can be notified when these SOFT RESERVE resources
are added to the ioeme resource tree.

The CXL driver is modified to use a worker thread that waits for the CXL
PCI and CXL mem drivers to be loaded and for their probe routine to
complete. Then the driver walks through any created CXL regions to trim any
intersections with SOFT RESERVE resources in the iomem tree.

The dax driver uses the new soft reserve notifier chain so it can consume
any remaining SOFT RESERVES once they're added to the iomem tree.

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
    1050000000-304fffffff : region1
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
   and me drivers to load.

Smita Koralahalli (7):
  cxl/region: Avoid null pointer dereference in is_cxl_region()
  cxl/core: Remove CONFIG_CXL_SUSPEND and always build suspend.o
  cxl/pci: Add pci_loaded tracking to mark PCI driver readiness
  cxl/acpi: Add background worker to wait for cxl_pci and cxl_mem probe
  cxl/region: Introduce SOFT RESERVED resource removal on region
    teardown
  dax/hmem: Save the DAX HMEM platform device pointer
  cxl/dax: Defer DAX consumption of SOFT RESERVED resources until after
    CXL region creation

 drivers/cxl/Kconfig        |   4 -
 drivers/cxl/acpi.c         |  25 ++++++
 drivers/cxl/core/Makefile  |   2 +-
 drivers/cxl/core/region.c  | 163 ++++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/suspend.c |  34 +++++++-
 drivers/cxl/cxl.h          |   7 ++
 drivers/cxl/cxlmem.h       |   9 --
 drivers/cxl/cxlpci.h       |   1 +
 drivers/cxl/pci.c          |   2 +
 drivers/dax/hmem/device.c  |  47 +++++------
 drivers/dax/hmem/hmem.c    |  10 ++-
 include/linux/dax.h        |  11 ++-
 include/linux/pm.h         |   7 --
 13 files changed, 270 insertions(+), 52 deletions(-)

-- 
2.17.1


