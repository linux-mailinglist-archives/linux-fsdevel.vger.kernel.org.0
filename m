Return-Path: <linux-fsdevel+bounces-29699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 125D397C779
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 11:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 591B6B25891
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 09:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935E719CD18;
	Thu, 19 Sep 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w5PJOmyn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F9019ADA8;
	Thu, 19 Sep 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726739106; cv=fail; b=jRr9zVNGxW+tdeEW0kwkE5pSCTA8V/mB+X1DqwdmqMtVukHPpz1qAoR/nyaeTe1MhRu2jtbKsm5ZRQkk0aHzP9lxhsRJKoPW8imDDk44r6/EHaSolDLaZe0zPebrbWuWqpHQx1im0+hGMHcIpxiR5BoX89qrOIlWwr4khWQpUG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726739106; c=relaxed/simple;
	bh=rmJHCLbt0gvHOMWItXpES0UwcC25EKDgn9AhBUlaPdc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g5MSDKDX1YjQ0HIqPXJpxmlt9RZNZ2VYBSL4ppZxHcnhy+1fMttZ9mSKh82yPWD9qI8lv8Q/EEiQwkM+ub1Of/ZsPuqMLZeDC9gRCAB8b7eUVzYD/3m3o2tSIUumQN9kDs0/bVqMVQdxUPnlfZyuk/Ef/FzHwfAlceOBC8jll1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w5PJOmyn; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdAD7ZMqPMRfMymCYhosJN3gcVuaXbpoLwroZWun+15h2veJkyS945KYF3uiXhZWEJrWRHRER9tUc4JgC8qjPjMd6NNWEioh4mTEDrVEYoLaw3MzWkm2+WZAQxYk1cuYV86kIjtmqzihADT4nLS6S2POwZcVLTQ/VoUO8pdVdtGvPEzkhCxhhHljQGcdkdFhvNiAhSYBYHBkIsCkZEovWh7x7xOxP7VBrLD82fU//1cmaaGzGSPBMfupX/T0bFtbHYFk2gc4mCM74HvX4lug/T5p3BJq1VI1I2GR5Xj5G9scTmU+ey/bRfXGCl2JPNoIiv3sY3tWTYLPoOuodJ/9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RX70B6oiVsdzGQ5F/xs6/PIPqNSP+XkdXHUH5Mi+Lic=;
 b=lPIGTr2Pe/XXFoQYZAvqKxLmRd5gvY72ZEAltmSudVftrg/wEZG+0IEhb4ISAZDSUjFzzO1yvieslIxBvQb5j9137ApLcILGTgcsojeCEuERY5/DSpxVRnuog1mAZS0a6RBmv9Gga8L176v9CbGUMwOAP6tIJtYWqtWjSaZVXUfsUtnOlaAzQQ9qnKvTb3ICcaxsbUVovBFNy0sXc7uBpOexNVoefu0jNsZ1WWnvR2EmcFyJE6UhxY73LhE+S2hyLHPmMnBTdwN+eUZGt5Gl3uPLpshEmymFrvMhjsKNlXOTJSz5gWDbWWJB92QrIsdGXKN2YTq+yupNQ87cvr2hUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RX70B6oiVsdzGQ5F/xs6/PIPqNSP+XkdXHUH5Mi+Lic=;
 b=w5PJOmynk241d1sRaT0dp2cWcFUoc5vjxmTM09WJeJOUqwfHWIpdCoa9qlPhRHw+qGBDa8CdCm6APNg6v8+ub3vd0TX+vQHIjcEItklUgkMizQeCjhtlaudVLBaroDfDtJLT4xc4+tPUpxqjg8OaLa7eWGiahul7ARGhioYHgak=
Received: from DS7PR05CA0044.namprd05.prod.outlook.com (2603:10b6:8:2f::10) by
 LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 09:45:00 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::29) by DS7PR05CA0044.outlook.office365.com
 (2603:10b6:8:2f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.14 via Frontend
 Transport; Thu, 19 Sep 2024 09:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 09:44:59 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 04:44:54 -0500
From: Shivank Garg <shivankg@amd.com>
To: <pbonzini@redhat.com>, <corbet@lwn.net>, <akpm@linux-foundation.org>,
	<willy@infradead.org>
CC: <acme@redhat.com>, <namhyung@kernel.org>, <mpe@ellerman.id.au>,
	<isaku.yamahata@intel.com>, <joel@jms.id.au>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>, <shivankg@amd.com>,
	<bharata@amd.com>, <nikunj@amd.com>
Subject: [RFC PATCH V2 0/3] Add NUMA mempolicy support for KVM guest_memfd
Date: Thu, 19 Sep 2024 09:44:35 +0000
Message-ID: <20240919094438.10987-1-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: c8321190-3553-4775-2a41-08dcd88fba45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZIXI3q1MW5JVr7P99zA2ej//YmX42SKQAurzNt1xej8w48NX3UfaJeLb66wn?=
 =?us-ascii?Q?+xahlKAkot7PEukmTGpMvHKF1dFsvFXqb7xDYbS+d0hh81LBf3uX1YApz3xl?=
 =?us-ascii?Q?4+MBV9I95RI+M3u/QoEWAGA3sQRWJYJ6FczVHw2Xb9/SRbOYib/qLY79640d?=
 =?us-ascii?Q?dHiPlLTq8IHRE5ATrYKS3yOAB/T2CN46Du4oG/sA42XjL0kIfS1tQwyEgqMR?=
 =?us-ascii?Q?Kh8coYVyLj/TFewPXbaK/8POBCB8ZclbHNmlXBttQVCle2+LE+zSnr8HmeCQ?=
 =?us-ascii?Q?mdHaphUN6ny6O+nXiSyvLYh/KBL39+rlnRKUVKnvYBFcEupmdfU+z7hrqrjL?=
 =?us-ascii?Q?5sklSSw1wHXkrC555Ddv+DENE6L3nOFbVh9/X3UAeN3+0Wgxvp0uYlAOZs81?=
 =?us-ascii?Q?83vMy76TQ+UZ7uSSUJu2aoqDpF3/LZtzHgnpDBpPVSzE6wIhOFvcy0MFWVGd?=
 =?us-ascii?Q?asOhBx2ljFEt/ThlNwm8xxzqRE23FBQkCTJbVgs1Qn/vgcp9dGhIityE4zh4?=
 =?us-ascii?Q?BiUmDJ53+4N9Qsk3jXrmhB2VeXQ6Fpxrwnt5h6xtEUjDy/oaLtyxPxCACsZl?=
 =?us-ascii?Q?/3Fg+ABVWKnOadQWfk6EXzEiz0n4XE1PMjmz4wUta+vhWnDTVSAwBEcqcRnB?=
 =?us-ascii?Q?xFeQ2Lp7Nm3JEw9q1qzISMmMUs+zp38xA6pD3CZ6JiFUrIc6jUccYyzNhibp?=
 =?us-ascii?Q?FcrYcVa17y4hIZN8z7dZ+nHLHPm7dkLZS3YV8jS7ENUN9f7J4r/bNxy0Cp+A?=
 =?us-ascii?Q?LNYahzJIQdajncD1nPYu7AwnLiO47qyqVo2l2kffGvBubyTAiIAiRVjTf59X?=
 =?us-ascii?Q?Ql4kzTJryBptwy9siNCfMINP5T0ZJgVtJHYyb1gZpLs8FxG1B2F2pJwEBobP?=
 =?us-ascii?Q?QIHyf7qEGImG1X+wFZAY7XW71tluTf8evD/7IXIV6lASAcK2L2QQ9ycjLZO1?=
 =?us-ascii?Q?JWR0rOdJ4+CTz1xrj7g8Pmzzz4nIXhwZiq8jsbipZmE6XrqBFFQ20S4tEIbv?=
 =?us-ascii?Q?vMegB8Vl0ySvWlDGoMvuZYaCzmsb63LiEtd0sJMv0qxMJ/roPD32p9jjHcYv?=
 =?us-ascii?Q?ovauxDV1ES5Kptot1me+v7E2fGBol17msID2/Br0lKyMpZR6SYRAJLhu2JWQ?=
 =?us-ascii?Q?DafM6VKao029bkCwMEgVG1GKNEATmyav9w7q3CG8KG0++j9bxtDEv98ig+oS?=
 =?us-ascii?Q?/9OvieCxkAHZKncs02J2euJtDFqyITgfX8V5hsCcBW9aAzN5kFcXFQUuwkZv?=
 =?us-ascii?Q?/Vo+4n1phwVO1AtVofhhvjelt2uweYroMB2cWd5h+je8ZeDkfUGznSxD2XjF?=
 =?us-ascii?Q?MtcHOjkQNxWBs8WeiXGi7J1r4O721niweXJZADmAe1WNsJTRwOPDGDlrK/K1?=
 =?us-ascii?Q?IkdW5RcTIDGi/FJIS6/eJoMz5ANisc/83nRb3eWDuvw1D1maenbXyfTJnRis?=
 =?us-ascii?Q?R2Q0DBjmOPMGtUOnxIXxF/hM4w4mRw3fXkcJUSunquiw3o45QFTOxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 09:44:59.5690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8321190-3553-4775-2a41-08dcd88fba45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167

The current implementation of KVM guest-memfd does not honor the settings
provided by VMM. While mbind() can be used for NUMA policy support in
userspace applications, it is not functional for guest-memfd as the memory
is not mapped to userspace.

This patch-series adds support to specify NUMA memory policy for guests
with private guest-memfd memory backend. KVM guest-memfd support for
memory backend is already available in QEMU RAMBlock. However, the NUMA
support was missing. This cause memory allocation from guest to randomly
allocate on host NUMA nodes even when passing policy and host-nodes in the
QEMU command. It ensures that VMM provided NUMA policy is adhered.

This feature is particularly useful for SEV-SNP guests as they require
guest_memfd memory backend for allocations. Workloads with high memory-
locality are likely to benefit with this change.

Users can provide a policy mode such as default, bind, interleave, or
preferred along with a list of node IDs from the host machine.

To try this patch-series, build the custom QEMU with NUMA supported KVM
guest-memfd:
QEMU tree- https://github.com/AMDESE/qemu/tree/NUMA_guest_memfd
For instance, to run a SEV-SNP guest bound to NUMA Node 0 of the host,
the corresponding QEMU command would be:

$ qemu-system-x86_64 \
   -enable-kvm \
  ...
   -machine memory-encryption=sev0,vmport=off \
   -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1 \
   -numa node,nodeid=0,memdev=ram0,cpus=0-15 \
   -object memory-backend-memfd,id=ram0,policy=bind,host-nodes=0,size=1024M,share=true,prealloc=false


v2:
- Add fixes suggested by Matthew Wilcox

v1: https://lore.kernel.org/linux-mm/20240916165743.201087-1-shivankg@amd.com

Shivansh Dhiman (3):
  KVM: guest_memfd: Extend creation API to support NUMA mempolicy
  mm: Add mempolicy support to the filemap layer
  KVM: guest_memfd: Enforce NUMA mempolicy if available

 Documentation/virt/kvm/api.rst | 13 ++++++++-
 include/linux/mempolicy.h      |  4 +++
 include/linux/pagemap.h        | 40 ++++++++++++++++++++++++++
 include/uapi/linux/kvm.h       |  5 +++-
 mm/filemap.c                   | 30 ++++++++++++++++----
 mm/mempolicy.c                 | 52 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/kvm.h |  5 +++-
 virt/kvm/guest_memfd.c         | 28 ++++++++++++++----
 virt/kvm/kvm_mm.h              |  3 ++
 9 files changed, 167 insertions(+), 13 deletions(-)

-- 
2.34.1


