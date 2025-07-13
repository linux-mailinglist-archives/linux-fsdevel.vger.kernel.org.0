Return-Path: <linux-fsdevel+bounces-54775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2084B0325E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 19:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E61E179E6A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jul 2025 17:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC66285C9D;
	Sun, 13 Jul 2025 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SdQcn/a0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66154A00;
	Sun, 13 Jul 2025 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752428718; cv=fail; b=odM8y4VzbKbvtlXsHw99WBTnsfhtt9HX9algbwIWK1U/WY1gCBHpsgCibL5ftK1IT3h4stXGMhJTVN0l22unJOs/vJmR64KkIxr55S6+5EDgRv8d37P2MP8nwoX0NzqBBsyvz0hZNeMwZvgrQTFNhiOC3vfVdR344dP7w1JQF68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752428718; c=relaxed/simple;
	bh=xe2pPBzPGU7KMuNF7qQAaHGdjeF575mG6jquq9jKUl4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aPeFLxVxA4pMBUvSA/fi6zCx7YO76HYk5G+e5QiyeeUL986gGa3TosXtFJx/iWhn4fHyBYWKgzb6jz4m8oT9GFOxyCp/XU3LcsYwSecXEpSYm64A6mcJak0y3CpfP0hlOZ7I1j1oHuAjAQDJG+yrQo3TWQvSpvigN9lxgTsZbRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SdQcn/a0; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y895OeMu/Lxf0AdD/z35BNw8OATXFDnC7GEsWMBFHKLIkPgng9RHZ3HiN31Oi8KeG3JZHPNNZzvu6tV7AnEQVvucz8LrD4B44d1jhN+swQKUJe2ILKJSLWdDJ15kYGopwK0IqN5cpovvPB7P4igpn2pivfIOy7LH8GSC7FmLG3Zlr3oItw8hB3Dvk118PI9CzoHVq4Q2QVjgHJ5n9Fbsc9U4RPdAAo7dx2KpMpZo9m5pp6QW7jDjk9WEF1mNizrvMalQMeOWYHI5cSTvtzPqf9w+hWfwIbTcDIAKBvF7Ye8d2Mg8t6/GyN55rpbovQjYPScH7dzVzohUxmxEnerEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCEGI5PqglRS8fSBsu+aRrpERf0SxN8K2RdzJRLZS0M=;
 b=VA4ME89zxLR576Q75ZHtygapWjgtJ2FZQOBCvYdsH+yH4OPomHdSguYi2T1WwshTmHghHx468/ElFwSLy877mZxmokEmSadCTiczNZhAt6l2rY5LF8Kd4M8ro3p20389LLa+VwX/Tu0FBkv/4Q1i7NbT8HxETuOkhWE3KIU8DfglDpwvM3qnN/gy4ac63UucBlYJGrFQvt2GmjMxdrmh0bTV2ZLcBXYKfPlXlHZ/q7gdnbWxxUoSx/CBR1jWdq5LI05OQL3QaB+qlX1NlfTDu5Dqxkq8imcTvMGf/WaEShhoBeduoo5o1/G/x5j9KJNKplf2SJqENNTCO4YI9LFJrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCEGI5PqglRS8fSBsu+aRrpERf0SxN8K2RdzJRLZS0M=;
 b=SdQcn/a0NaP9u0Ij+PhTYQCcLonWwlHlyX3knxbwOychgyH9617YaEg4aHs1y7mIf3vD7KzmEecv9+Mtx/PZD+TpwU9d5me8GpRtX87Yx1JqNRy3MhIVgyI6DLEEOPL73qrz1qSRbG3T0tT7fk8TT3IDMm7EYrMFqtdwpgY+jkw=
Received: from MW4PR03CA0303.namprd03.prod.outlook.com (2603:10b6:303:dd::8)
 by DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Sun, 13 Jul
 2025 17:45:12 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::ec) by MW4PR03CA0303.outlook.office365.com
 (2603:10b6:303:dd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Sun,
 13 Jul 2025 17:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Sun, 13 Jul 2025 17:45:12 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Jul
 2025 12:44:51 -0500
From: Shivank Garg <shivankg@amd.com>
To: <seanjc@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<willy@infradead.org>, <akpm@linux-foundation.org>, <shuah@kernel.org>,
	<pbonzini@redhat.com>, <brauner@kernel.org>, <viro@zeniv.linux.org.uk>
CC: <ackerleytng@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <pvorel@suse.cz>, <bfoster@redhat.com>,
	<tabba@google.com>, <vannapurve@google.com>, <chao.gao@intel.com>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<shdhiman@amd.com>, <yan.y.zhao@intel.com>, <Neeraj.Upadhyay@amd.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <kalyazin@amazon.com>, <peterx@redhat.com>,
	<shivankg@amd.com>, <jack@suse.cz>, <rppt@kernel.org>, <hch@infradead.org>,
	<cgzones@googlemail.com>, <ira.weiny@intel.com>, <rientjes@google.com>,
	<roypat@amazon.co.uk>, <ziy@nvidia.com>, <matthew.brost@intel.com>,
	<joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>, <byungchul@sk.com>,
	<gourry@gourry.net>, <kent.overstreet@linux.dev>,
	<ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<chao.p.peng@intel.com>, <amit@infradead.org>, <ddutile@redhat.com>,
	<dan.j.williams@intel.com>, <ashish.kalra@amd.com>, <gshan@redhat.com>,
	<jgowans@amazon.com>, <pankaj.gupta@amd.com>, <papaluri@amd.com>,
	<yuzhao@google.com>, <suzuki.poulose@arm.com>, <quic_eberman@quicinc.com>,
	<aneeshkumar.kizhakeveetil@arm.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-coco@lists.linux.dev>
Subject: [PATCH V9 0/7] Add NUMA mempolicy support for KVM guest-memfd
Date: Sun, 13 Jul 2025 17:43:33 +0000
Message-ID: <20250713174339.13981-2-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DM4PR12MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c624c4-e1a7-4a64-0afd-08ddc23504d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ig/GA8y/5/ZyfOG/K2A1zciX3CeYamLisgQHR1m8LCjhK6dr76JAnR+YfFva?=
 =?us-ascii?Q?P3lZAcHcXLZEyhkcIz/Cc5aQo8UX66fpa3foufQnBbxSP9jEtBGpi5XR4x3I?=
 =?us-ascii?Q?NI2kkym/LJFK/AG7h8z8rPgIVJgUAOuObP7bn17mJBLVMzoeqY82X8VnDBv9?=
 =?us-ascii?Q?Ww4um71xmJ86WuMRSE9ocHlWs/WcmYBlJvGeyq9INDSxSR557DPY6XDKNPxW?=
 =?us-ascii?Q?y2cDi9nqj8nP8dbk/WQof5vmdaQEnhumFeEfq0JVoRSE5SUD3kPFglptXrJQ?=
 =?us-ascii?Q?FNnzZe5Newz4Z3kOTW2UthgDUbmORD+tVHboXuDWQsBudlm+HAOmlRQ82/yO?=
 =?us-ascii?Q?PNjpFfRC1WZfUd6flj2hs+9Dtjk8BHtCEscLia1iPVlPtQsrBzdjUP9YXXTK?=
 =?us-ascii?Q?fMbNL7ek0Jp37bim2k5REMUmDr95HgtRcNDLzARDfbfjJuIjHzAXWxJohEw0?=
 =?us-ascii?Q?r3e08R54JNisb0BMUNwGlsSijV5/meYkKal5Dl4VQpakv3bPXj6a12aPFT+O?=
 =?us-ascii?Q?ZZsiPbo5eu+GOKgETg2H6jEm5wrHZhSudoKQtIOXycfLKlsloZq6fFmAPWRd?=
 =?us-ascii?Q?L8qJY9Xu/8A6GaCYMU6GpVH1lIe+yn9oxz3X7rnLdLM5Y7Xf+ejUu/Zu5BCH?=
 =?us-ascii?Q?ZFnhdb23RkhvSFXqWODLSVhaR5o66uISSiza9DyrjOuWatqddGCMko3VJBoG?=
 =?us-ascii?Q?6opQVfFl3o0UQEW3FGFQU78A6Lq7FZKBTqIr57IVobFI5GLGzJ4LggcrSVGO?=
 =?us-ascii?Q?qk0MWrkZmzK6JKjGS676zFN6ozC9D2Xpb754Zn4yxeUEXMl9Q4Pvo+Lmn3D8?=
 =?us-ascii?Q?UxqW00e+PLCEXttwR74e0V4pqVIUxRIf0clwAlkPQwskDsYzQ22HOeVX2wjW?=
 =?us-ascii?Q?6xlrOn5QR6kOCuq+ilctI0wf6cfxPVs8zCY8XNd3Lpj+2Ym9wY+uFsodDphD?=
 =?us-ascii?Q?sZv0uJhRpI9rGADalQRv5QflbmXcVo5vHtmodpLr1vUu26LhE7dBSEra4JO9?=
 =?us-ascii?Q?iDFGjsbdiyD/4Ex2JVjjN7dL/el1Yndq/fOiA8SMc9dMKYEH1vgOu8ppYJ5Y?=
 =?us-ascii?Q?CHVSUVqkWiU1GJyuR5R4Qkvr6LAoDioKvbeIcZbfFEDQK2SctZOcjcFjAELm?=
 =?us-ascii?Q?oQwWBwVjNek8SQJ2YeDayK3a0ZzdUQWU+j10AsM2ddPts7WSpMybUaEWdxYR?=
 =?us-ascii?Q?V65mOuwCs/ANa7vjTSbIr3A3bwjEzYJSVTmks+6XAgOyQV6Ze0s+f6Sh8ft1?=
 =?us-ascii?Q?ZElMr8anrwJXb3hnpvYXv94+R5cFIvsAcPP6SCBCir/Wuplqik/TpNwM9CLs?=
 =?us-ascii?Q?izRWEeiIdWMpxPUoKOsOsK//nyxglymd4npd0y5gV5CVKPOVl5d16mp6/Tqu?=
 =?us-ascii?Q?dettTAcXeIWoq3kwrEAvPxJ3ejfS+EnSefVRYeUb0UMgm+ldTBx4vNMyaPGE?=
 =?us-ascii?Q?xgCcMV7shprmpsZn83iu7AxcN9AOpo5aMMzydMoZfzVOfL7+DMQ/OA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 17:45:12.5589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c624c4-e1a7-4a64-0afd-08ddc23504d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645

This series introduces NUMA-aware memory placement support for KVM guests
with guest_memfd memory backends. It builds upon Fuad Tabba's work that
enabled host-mapping for guest_memfd memory [1].

== Background == 
KVM's guest-memfd memory backend currently lacks support for NUMA policy
enforcement, causing guest memory allocations to be distributed across host
nodes  according to kernel's default behavior, irrespective of any policy
specified by the VMM. This limitation arises because conventional userspace
NUMA control mechanisms like mbind(2) don't work since the memory isn't
directly mapped to userspace when allocations occur.
Fuad's work [1] provides the necessary mmap capability, and this series
leverages it to enable mbind(2).

== Implementation ==

This series implements proper NUMA policy support for guest-memfd by:

1. Adding mempolicy-aware allocation APIs to the filemap layer.
2. Introducing custom inodes (via a dedicated slab-allocated inode cache,
   kvm_gmem_inode_info) to store NUMA policy and metadata for guest memory.
3. Implementing get/set_policy vm_ops in guest_memfd to support NUMA
   policy.

With these changes, VMMs can now control guest memory placement by mapping
guest_memfd file descriptor and using mbind(2) to specify:
- Policy modes: default, bind, interleave, or preferred
- Host NUMA nodes: List of target nodes for memory allocation

These Policies affect only future allocations and do not migrate existing
memory. This matches mbind(2)'s default behavior which affects only new
allocations unless overridden with MPOL_MF_MOVE/MPOL_MF_MOVE_ALL flags (Not
supported for guest_memfd as it is unmovable by design).

== Upstream Plan ==
Phased approach as per David's guest_memfd extension overview [2] and
community calls [3]:

Phase 1 (this series):
1. Focuses on shared guest_memfd support (non-CoCo VMs).
2. Builds on Fuad's host-mapping work.

Phase2 (future work):
1. NUMA support for private guest_memfd (CoCo VMs).
2. Depends on SNP in-place conversion support [4].

This series provides a clean integration path for NUMA-aware memory
management for guest_memfd and lays the groundwork for future confidential
computing NUMA capabilities.

Please review and provide feedback!

Thanks,
Shivank

== Changelog ==

- v1,v2: Extended the KVM_CREATE_GUEST_MEMFD IOCTL to pass mempolicy.
- v3: Introduced fbind() syscall for VMM memory-placement configuration.
- v4-v6: Current approach using shared_policy support and vm_ops (based on
         suggestions from David [5] and guest_memfd bi-weekly upstream
         call discussion [6]).
- v7: Use inodes to store NUMA policy instead of file [7].
- v8: Rebase on top of Fuad's V12: Host mmaping for guest_memfd memory.
- v9: Rebase on top of Fuad's V13 and incorporate review comments

[1] https://lore.kernel.org/all/20250709105946.4009897-1-tabba@google.com
[2] https://lore.kernel.org/all/c1c9591d-218a-495c-957b-ba356c8f8e09@redhat.com
[3] https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?tab=t.0#heading=h.svcbod20b5ur
[4] https://lore.kernel.org/all/20250613005400.3694904-1-michael.roth@amd.com
[5] https://lore.kernel.org/all/6fbef654-36e2-4be5-906e-2a648a845278@redhat.com
[6] https://lore.kernel.org/all/2b77e055-98ac-43a1-a7ad-9f9065d7f38f@amd.com
[7] https://lore.kernel.org/all/diqzbjumm167.fsf@ackerleytng-ctop.c.googlers.com

Ackerley Tng (1):
  KVM: guest_memfd: Use guest mem inodes instead of anonymous inodes

Matthew Wilcox (Oracle) (2):
  mm/filemap: Add NUMA mempolicy support to filemap_alloc_folio()
  mm/filemap: Extend __filemap_get_folio() to support NUMA memory
    policies

Shivank Garg (4):
  mm/mempolicy: Export memory policy symbols
  KVM: guest_memfd: Add slab-allocated inode cache
  KVM: guest_memfd: Enforce NUMA mempolicy using shared policy
  KVM: guest_memfd: selftests: Add tests for mmap and NUMA policy
    support

 fs/bcachefs/fs-io-buffered.c                  |   2 +-
 fs/btrfs/compression.c                        |   4 +-
 fs/btrfs/verity.c                             |   2 +-
 fs/erofs/zdata.c                              |   2 +-
 fs/f2fs/compress.c                            |   2 +-
 include/linux/pagemap.h                       |  18 +-
 include/uapi/linux/magic.h                    |   1 +
 mm/filemap.c                                  |  23 +-
 mm/mempolicy.c                                |   6 +
 mm/readahead.c                                |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/guest_memfd_test.c  | 122 ++++++++-
 virt/kvm/guest_memfd.c                        | 255 ++++++++++++++++--
 virt/kvm/kvm_main.c                           |   7 +-
 virt/kvm/kvm_mm.h                             |  10 +-
 15 files changed, 408 insertions(+), 49 deletions(-)

-- 
2.43.0
---
== Earlier Postings ==
v8: https://lore.kernel.org/all/20250618112935.7629-1-shivankg@amd.com
v7: https://lore.kernel.org/all/20250408112402.181574-1-shivankg@amd.com
v6: https://lore.kernel.org/all/20250226082549.6034-1-shivankg@amd.com
v5: https://lore.kernel.org/all/20250219101559.414878-1-shivankg@amd.com
v4: https://lore.kernel.org/all/20250210063227.41125-1-shivankg@amd.com
v3: https://lore.kernel.org/all/20241105164549.154700-1-shivankg@amd.com
v2: https://lore.kernel.org/all/20240919094438.10987-1-shivankg@amd.com
v1: https://lore.kernel.org/all/20240916165743.201087-1-shivankg@amd.com


