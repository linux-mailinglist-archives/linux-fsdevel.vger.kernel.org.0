Return-Path: <linux-fsdevel+bounces-45679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D20BA7A97B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E5E1887256
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CBA253B40;
	Thu,  3 Apr 2025 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bJ8A+FLQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7132517AA;
	Thu,  3 Apr 2025 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705208; cv=fail; b=U1XA0jGxos1txiAxPPIgb+Wt7MRYF2ZyEw5P2aocSBV9X8ZVcxeehUug/tZfwCPHzz13gUoY1Yr3Rne2VRNgaAKGGR8eWF887+VhdqgiPOkLkYbNnbl1EhUA+6c8kVKieMtLVUBdGhZsgvARDEu0ruXzWHMT5eTgtGjYoI42QFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705208; c=relaxed/simple;
	bh=VvEJjpowZeyHaIiVgyV0PI5CAqyLElYAbE7zimR6tSs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZuwctnNi8QaijEV7mE4RG81eosfU9TlxrmKtKleU4+xjgfcI/sXlmJGyusvTe0sJF4VSS4JHTClfTjJ7njkme65PjN9BPZKQeVvtILCLgsA8WjBcyo21wyp58vWPDq33cgNI7sCG5AQsW8fbmq4a7sz4I4AOGrwjeDKO2YP/1wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bJ8A+FLQ; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAB2urLYYgQStlfjR5ajCCfxwi88Y6hWBqBGTTYtzTs30xP8NXwbBC8uBBNuKvWa8T5oprdJZo/mKvsQZz5CnDfxfB2WidS1jytm8IOqPsO242ndqM8CMLVKFid5U76TJjpdBbjb56aqR6cOOgWiabFUejI1M63I3pDlri0lzp1GKcF2PfiJkhfEME1fB94V7bkyARN+XHqggUlPMSnEyDm1UCR/RKwwX5SYZbR6O1dzI86MF0N6oyYs/INeuSnrHdzi1dVvRRyJQYtTpRcjIwRqSKv35lXTOMOsltiF+HRbAwXR7rtiT70nROYxCsBp7BtcSU3yFnktnDzuntSn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtILwPBl+qeG0JsEjDqvlIspRH60V3TSGahUKBtcU0Y=;
 b=Ff98EKYlLashwt8PaC9xLKwosLw/EH7lSTBa7gwn8//la9nVXEP4bLLVygPFo7Q0EdHb1nRWi66yizlwXdepGpnLqqSXxqzC5R6C+fqmvOtpahxC2Mdr9eWrx8s62X+1v9J0bkwxnJJVWhprpwVV2gcYpf2j6aAVQSR27nnt5SB8eJacehRAzLe8S5elYMBNNdg9Ej/J+z4j+Q37M6UIw5jhgDfEnzFaUZ3MzNLkeZpS+nWOwo4JfAvSZbqbweVMu1YWBZaRn1vn0ildhD6G81t2Avvl8cJxu5P79fsJIj8Qh0XFhsU4S5gOFNubeb/2u+zx/aXk+I6eocsQXK21YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtILwPBl+qeG0JsEjDqvlIspRH60V3TSGahUKBtcU0Y=;
 b=bJ8A+FLQGXqhUzdbhQANA+lU+3kZvwibkdefDGNVVWodxvvOxygDmyVUjuctQV4/skXmGT9OgmiTNv6C1KjBk3VsL8nb9p2gEU/gR5s0uVijJTEY0phbcfKDbctHJKajYDP8BwVO/r/4ufugyijijwFTX+sq4hQKMK8uQQM9UXk=
Received: from SJ0PR05CA0181.namprd05.prod.outlook.com (2603:10b6:a03:330::6)
 by MW6PR12MB9019.namprd12.prod.outlook.com (2603:10b6:303:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.45; Thu, 3 Apr
 2025 18:33:23 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::83) by SJ0PR05CA0181.outlook.office365.com
 (2603:10b6:a03:330::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Thu,
 3 Apr 2025 18:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Thu, 3 Apr 2025 18:33:22 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Apr
 2025 13:33:21 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
	<rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
	<ming.li@zohomail.com>, <nathan.fontenot@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <huang.ying.caritas@gmail.com>,
	<yaoxt.fnst@fujitsu.com>, <peterz@infradead.org>,
	<gregkh@linuxfoundation.org>, <quic_jjohnson@quicinc.com>,
	<ilpo.jarvinen@linux.intel.com>, <bhelgaas@google.com>,
	<andriy.shevchenko@linux.intel.com>, <mika.westerberg@linux.intel.com>,
	<akpm@linux-foundation.org>, <gourry@gourry.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <rrichter@amd.com>, <benjamin.cheatham@amd.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lizhijian@fujitsu.com>
Subject: [PATCH v3 0/4] Add managed SOFT RESERVE resource handling
Date: Thu, 3 Apr 2025 13:33:11 -0500
Message-ID: <20250403183315.286710-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|MW6PR12MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: 19767dd3-ad4f-4564-3b2e-08dd72de03f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BQ8wl5Tw68MZoq8cH4YQFHlnCYyP+rTvFkaHYHa4TLvqrjxh8ubORXDk/RJG?=
 =?us-ascii?Q?0ytApL2QbZaej5Xf4f7FPSJfhn/7CTOF8YZLHdLuxXU0SKO88XE7MAX5SVbM?=
 =?us-ascii?Q?1wLNg4CJQfhdTYprDGl5lIg+1TSp+7sTLBB4F7AwbvBRPr6b0HgDVzOShZw6?=
 =?us-ascii?Q?aNCJCcLB8/B0AO0zQa0Pz1/aSEHNP1newmY7usku9F+04kVPPeW2fjywz6D5?=
 =?us-ascii?Q?NrAtf3nqZpLQEGf1HyThPG8DJzoVRJASSeQeTWaWOiCYzTw+Je1FBsuDzAvF?=
 =?us-ascii?Q?C2ph9R+8pAjUnTfjUZKTOPx4hKgbtP44tMIK8CjBuIH7Ew8mYpJ0dM9DOeBa?=
 =?us-ascii?Q?wvvkLepg9325XaUALcobdpUvS2eGcSca15oqpDBk6DYcbjn4XvgsaUMEuf+f?=
 =?us-ascii?Q?3eprm8f9GP1MDcYuUDa3BMwdFMxrBLiLT0AANSlY9xN2kZJj13bX/lwTLXjD?=
 =?us-ascii?Q?fq+tnlJo6nN1B+L9elJUpe4hnfRqTOvyUs9BNKdp+c36xmkqJmuYBopslN/t?=
 =?us-ascii?Q?jJXMd0Yv/2IR4m6v04N7YT4w84J3G3E7jfLlwp9/l2Dxy7URDucOPcm/IHtP?=
 =?us-ascii?Q?Sek0lHNBoVBn8iCLMcDLH9jjs+9N7kn8//UteV8iyD9A0aDR1PZIEWjUgguj?=
 =?us-ascii?Q?qSaSO82LvdTDk6kZ05W5FPFbb9fTkk4vMCseIh60FahMvy+tCSoROdzO0la8?=
 =?us-ascii?Q?Lsza0+vZO+1Gsbfej1AhC35baTSbIbCLBhaVgmdflL0COBkHZ9tf6cfrJNN1?=
 =?us-ascii?Q?W4btrRPKorULikWiQqhsTmNA8bK3cUW5LkiwYouWLE7X5XYE5QW0uzmHyYHa?=
 =?us-ascii?Q?9mede4BUmRBXcH2UX2/iPteEIt4IkaVGduEUF7COnquhUAkb8tz3NJecD6HE?=
 =?us-ascii?Q?ftqWdXgBXf6AG0Cm7yE9eTx3iChi5TMrrlNRnxWCjIXPdfNURsCLV/P5QXRo?=
 =?us-ascii?Q?GHjqRaKhEbwZ0UwcUm/9Dekk21XNT1zGH748LWXCYh+gokPWf+HNq5cvjkpD?=
 =?us-ascii?Q?Mo41LoeAfOKC5wkC5W6NuQQp5CtfyPuG79PtfDK9LbWkr0dYjkfCQZI7OkgO?=
 =?us-ascii?Q?D6dHMb6oz5lcXFM/lUAZL3wQ+fq3Lmq3RtPyT0QW4FiCzKt4bikG+3Iyu+Tm?=
 =?us-ascii?Q?rdE0TsdenMZ62TAQsf2WOPS07zniKyNQSFGU6YwDbq9F1NhRaw219MvD3BPS?=
 =?us-ascii?Q?UUMcyrl4su+bK/beVUdjlQWLZ3MMWxjiBk8ckdFFN2hqmf1giFdBYQqeXoDk?=
 =?us-ascii?Q?fAdY3VpypdBvc6lOFjlF77TIAEtqCdr07lRVyhFjCyKyf9DlNOD+MEwd2CjP?=
 =?us-ascii?Q?01WiMFhEWN37f6cJ8t/m3OvxcJsEoIJq0LFEPsVxyK5HOKpf5evara3HRfRf?=
 =?us-ascii?Q?D3eDwdIn4Jc9iLub24646A8lSwcUFfxv6o4785JnMmRvxdV55vxhlnysnhCy?=
 =?us-ascii?Q?kLNMoajBkptlKK1Blp4C+0toRCVXf00eVEGDGMK+KNjxtjPTgGUIQZEGyZTZ?=
 =?us-ascii?Q?AEmui44js2aP57w3vVyfBBj16wYbauGpcWCbFBaAmNjRguiy6053tQXwGQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 18:33:22.9625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19767dd3-ad4f-4564-3b2e-08dd72de03f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9019

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

V3 updates:
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

Nathan Fontenot (4):
  kernel/resource: Provide mem region release for SOFT RESERVES
  cxl: Update Soft Reserved resources upon region creation
  dax/mum: Save the dax mum platform device pointer
  cxl/dax: Delay consumption of SOFT RESERVE resources

 drivers/cxl/Kconfig        |  4 ---
 drivers/cxl/acpi.c         | 28 +++++++++++++++++++
 drivers/cxl/core/Makefile  |  2 +-
 drivers/cxl/core/region.c  | 34 ++++++++++++++++++++++-
 drivers/cxl/core/suspend.c | 41 ++++++++++++++++++++++++++++
 drivers/cxl/cxl.h          |  3 +++
 drivers/cxl/cxlmem.h       |  9 -------
 drivers/cxl/cxlpci.h       |  1 +
 drivers/cxl/pci.c          |  2 ++
 drivers/dax/hmem/device.c  | 47 ++++++++++++++++----------------
 drivers/dax/hmem/hmem.c    | 10 ++++---
 include/linux/dax.h        | 11 +++++---
 include/linux/ioport.h     |  3 +++
 include/linux/pm.h         |  7 -----
 kernel/resource.c          | 55 +++++++++++++++++++++++++++++++++++---
 15 files changed, 202 insertions(+), 55 deletions(-)


base-commit: aae0594a7053c60b82621136257c8b648c67b512
-- 
2.34.1


