Return-Path: <linux-fsdevel+bounces-52032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96337ADEA01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 13:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FC2189D6F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 11:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3A42C0307;
	Wed, 18 Jun 2025 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PSTzJrKf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB59A2BEC2F;
	Wed, 18 Jun 2025 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246215; cv=fail; b=alDzyIl/kNr0+gLjPnRivKIf/UDJLAg9FFVzMThmNVqcyHZjRTILPUqHIQD35rievzcHgqWR89z5jbYv+TsguTKGV4RlPwe5opjLMl9vry6dqsQPOuacRckVKqMpqM2Turd/wuAGiLx2g1+fEG9PVwpgIH6bJBU2iczEgzBNeJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246215; c=relaxed/simple;
	bh=zZ5X25kGB2rU/6cUf3LdxXZPX+8WptpYCSjQhYObmyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nmjbHLk4z5XWRIZ0Gc64ZpH/Jy4YCdDWItD1U3Q58ExoAdR7N3isZpn/Awvi7R2dv++IDWpsznHMz0P4Avb/u5l5R2a+sft5lg9I+J4J57GCpzmKhfkKJoMIdsE9z7YirYohQncYz88gsTS35kfUktTcScHT8DgmUQtuglHWbUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PSTzJrKf; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLhQ/bRF8ezK/C3V70/2cMAoBFAMnYOgtnQuju3KQHfoYPcwC+cYc5IgAq1n+kkhxfcUF9E8y2fEjkfBVZ7eE6vsoZzn8/+4UOJX8tdx3aGqaCwhnBXAJ6dVUpFaarfHYQfHj5IlaRCuT2v8IXu73HhZjA6FzouCM5OIERxggdPuijs9pxaAf/pdUwrD8gr8QmN/yfTPYzs2vIMmfIHfKG5BHqIymcQRx0s1944akLUlk+eDrWA94Ot4r95EzOeRSoNtuAWpvvvWslvsVMliWjZn5YjUuc/FHDAvCzARkqVmbquKaxUkcfa/8z+0hVSyKaoXwpAHIQKG/XfaajTf7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReNgZB+Yfn8yoSBGdN30BgPF6sVv1aO0+f+9oyTJ4xQ=;
 b=yR+FfR9a6TfwW40E9lEi0jrxU+hFamig6js2JTldow3CIdBi97n5UqzaQIScfelaljgAjThPNqh7jLGdyPSoG43VEblS1PfNQTpqHrLAK55s8DwaSuBYucc4LGZwZ5/7PXbIkGQ+9gOie5T5qi1zmlD7RCK3AUGI/FifkWQsYymb7yVpcaT9P/fwQLzNKb4ffYHzf0fOy2LfCByoQ0RskTVYLjPrsMrsAwNVlCc/gjc++573N5GOw0JPbMdkZEI4BY2bT3zUXEycti4AhYUmnIukR4VzawJFrS4nUZXgY2hD0wa9MMC1WyvDJnJCp6uRGwhb5mNbG7+569Lta2XMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReNgZB+Yfn8yoSBGdN30BgPF6sVv1aO0+f+9oyTJ4xQ=;
 b=PSTzJrKfGwvoeGH3fEO/P2c3HWT2LOTuCppFGEpL/tNltefeKxLV+tZTMpoaxoko7eBh0S6b90q3rCbw2UwRTf98QDnMQ9s7gtpSOnNp90m5HmWgdTAYg1eKwGUcLflnawsd87w6wA9pcLhOhuHAj/iSjlLMl29dDROcXosQ0v0=
Received: from DS0PR17CA0010.namprd17.prod.outlook.com (2603:10b6:8:191::26)
 by SJ5PPF1394451C7.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Wed, 18 Jun
 2025 11:30:09 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::89) by DS0PR17CA0010.outlook.office365.com
 (2603:10b6:8:191::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.34 via Frontend Transport; Wed,
 18 Jun 2025 11:30:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 11:30:08 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 06:29:53 -0500
From: Shivank Garg <shivankg@amd.com>
To: <seanjc@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<willy@infradead.org>, <akpm@linux-foundation.org>, <shuah@kernel.org>,
	<pbonzini@redhat.com>, <brauner@kernel.org>, <viro@zeniv.linux.org.uk>
CC: <ackerleytng@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <pvorel@suse.cz>, <bfoster@redhat.com>,
	<tabba@google.com>, <vannapurve@google.com>, <chao.gao@intel.com>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<yan.y.zhao@intel.com>, <Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <aik@amd.com>, <jgg@nvidia.com>,
	<kalyazin@amazon.com>, <peterx@redhat.com>, <shivankg@amd.com>,
	<jack@suse.cz>, <rppt@kernel.org>, <hch@infradead.org>,
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
Subject: [RFC PATCH v8 0/7] Add NUMA mempolicy support for KVM guest-memfd
Date: Wed, 18 Jun 2025 11:29:28 +0000
Message-ID: <20250618112935.7629-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SJ5PPF1394451C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 98dadf55-4372-4237-fd23-08ddae5b7b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2emCzA+YJ85i3B0/AmlQYiLmq2p3G5eDXAbs5gzttg1zvUQ9zUpmUTc576do?=
 =?us-ascii?Q?fyTKVDG6Yv60pwoMIU3wOvIOyJDpSn6a2a8SKouTwRR7LOrM52NLKj+/72MB?=
 =?us-ascii?Q?UTp095Qx5YLQxBJzTBltQB03E6iCTXXUfV8s4e2puVyIkyQfRXEnlDIMqZRf?=
 =?us-ascii?Q?8v28tpiq5vawph0wAEqfqK1W+MMBVui92u9Gi4dH8eht2lqYnB9sKg6W+gk2?=
 =?us-ascii?Q?GCJNsxWL5gyx2LtrAjpFupCwJylcDSIHCsgWp8g/d7tAceZ1nKlvFEuPITNF?=
 =?us-ascii?Q?NDxoREn8j3sMux/iSsHbUO0owzDJphGi6gWpOxGsyQlJQ5ddtUmFLkM/E/P2?=
 =?us-ascii?Q?U8cCRM83RWhSFIbcQTiU817IRKPRBdUMf7drKWMrTR8bYXZweoZz8Xw4YZjg?=
 =?us-ascii?Q?7FJgLpcHzvukaYUc883/CkiHQ+DgQhZzStvUb1Xlndwhpj+/eg4uzJeWIjZ1?=
 =?us-ascii?Q?vjrEJbEulXDBvmTzUhbCLsz8f4QC51dCQYLgvwsbvFHAgVU/MxVFGJGJjYbg?=
 =?us-ascii?Q?tPzd8uA2vxSCvJpXD2z/L9w//0dnBjEfqkxexd51O5QNo/i4Gy5bFPeJeN96?=
 =?us-ascii?Q?wY5cFpej6sxNsZuOCkRz77PHC4ukNxevyiXGKcGd/Ptt+a4hahtWi/UMXcaU?=
 =?us-ascii?Q?ICu0QWxJ66L32tkx00LWPCz9diqfn4eK10QXatwueugpiDol8Ik1bEZt7FA7?=
 =?us-ascii?Q?Z5vdIUpz4q3dOMNyWj/f6gBFMbmSZk2LzAtJClIcdKWQLENU8DfSG4Z1YOT4?=
 =?us-ascii?Q?JlC2oqzl9reuWj8BY95NCWqcyIVsqf5h5/EB7yr/LJhbOrmpyQjptro6gbPn?=
 =?us-ascii?Q?aKeKJuZy3hpgMdHoIN2iIv+Fh/bfpePUtu47/0FRw8MhRYJt9LYLjquxcQsq?=
 =?us-ascii?Q?7UL9ri8R9eSeijcBK34CNOGBT1HoCMrqDQyXscbk/j5Tgd7o5uWRBcEwST3P?=
 =?us-ascii?Q?lTj1Md1lsNYZAF3ohVhgfExwdOQMObbpG3UD2shC7tffZjPvb8qGlsgH4ldk?=
 =?us-ascii?Q?Y04ZNKDgbhaVlinQFPwF5s/XkZVfJDbV2tb1ND8zvMUKpdVAuQ+VSb6RFd4y?=
 =?us-ascii?Q?6mH6T3IlIj6JXzFYxj1gNnMDhhhgG1NiUooUWdjQ4dFSG63oODlDg2U54KoX?=
 =?us-ascii?Q?WjDv2YEW0neBuX/+iDeoX/9lOOTYayum0M63w3xGTJPfRCNjdqRyRnDA38SP?=
 =?us-ascii?Q?zQN+K1lM5XtDVb2QI9EBTujMOp7hn/47EqU+R2b+m66J3iucp94Pt2p4oi7A?=
 =?us-ascii?Q?nwxf89PKs2MFB3W+PrMeO2NM+OM1ZikI8dg6L2/Vi/5VR2fkCXeIEjqSHfVy?=
 =?us-ascii?Q?/RCYCG3XuxdsH5MCcyDtvIvyUul4KRPEEW87OuUcDw8S2ZPh25CmWhZf6mZw?=
 =?us-ascii?Q?3j7wrgvgbkHRnAr57gewN9V+aXp3uYfHneFpvP87v3T9Iw4SWh+JhQ4UoMrd?=
 =?us-ascii?Q?8YXZFBpQK1ld4QwIgbXbeW/0xjtdi3fYp7SPO7MhMfKOIahdiRaRFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:30:08.8476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98dadf55-4372-4237-fd23-08ddae5b7b3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1394451C7

This series introduces NUMA-aware memory placement support for KVM guests
with guest_memfd memory backends. It builds upon Fuad Tabba's work that
enabled host-mapping for guest_memfd memory [1] and can be applied directly
on KVM tree (branch:queue, base commit:7915077245) [2].

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
Phased approach as per David's guest_memfd extension overview [3] and
community calls [4]:

Phase 1 (this series):
1. Focuses on shared guest_memfd support (non-CoCo VMs).
2. Builds on Fuad's host-mapping work.

Phase2 (future work):
1. NUMA support for private guest_memfd (CoCo VMs).
2. Depends on SNP in-place conversion support [5].

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
         suggestions from David [6] and guest_memfd bi-weekly upstream
         call discussion [7]).
- v7: Use inodes to store NUMA policy instead of file [8].
- v8: Rebase on top of Fuad's V12: Host mmaping for guest_memfd memory.

[1] https://lore.kernel.org/all/20250611133330.1514028-1-tabba@google.com
[2] https://git.kernel.org/pub/scm/virt/kvm/kvm.git/log/?h=queue
[3] https://lore.kernel.org/all/c1c9591d-218a-495c-957b-ba356c8f8e09@redhat.com
[4] https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?tab=t.0#heading=h.svcbod20b5ur
[5] https://lore.kernel.org/all/20250613005400.3694904-1-michael.roth@amd.com
[6] https://lore.kernel.org/all/6fbef654-36e2-4be5-906e-2a648a845278@redhat.com
[7] https://lore.kernel.org/all/2b77e055-98ac-43a1-a7ad-9f9065d7f38f@amd.com
[8] https://lore.kernel.org/all/diqzbjumm167.fsf@ackerleytng-ctop.c.googlers.com

Ackerley Tng (1):
  KVM: guest_memfd: Use guest mem inodes instead of anonymous inodes

Shivank Garg (5):
  security: Export anon_inode_make_secure_inode for KVM guest_memfd
  mm/mempolicy: Export memory policy symbols
  KVM: guest_memfd: Add slab-allocated inode cache
  KVM: guest_memfd: Enforce NUMA mempolicy using shared policy
  KVM: guest_memfd: selftests: Add tests for mmap and NUMA policy
    support

Shivansh Dhiman (1):
  mm/filemap: Add mempolicy support to the filemap layer

 fs/anon_inodes.c                              |  20 +-
 include/linux/fs.h                            |   2 +
 include/linux/pagemap.h                       |  41 +++
 include/uapi/linux/magic.h                    |   1 +
 mm/filemap.c                                  |  27 +-
 mm/mempolicy.c                                |   6 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/guest_memfd_test.c  | 123 ++++++++-
 virt/kvm/guest_memfd.c                        | 254 ++++++++++++++++--
 virt/kvm/kvm_main.c                           |   7 +-
 virt/kvm/kvm_mm.h                             |  10 +-
 11 files changed, 456 insertions(+), 36 deletions(-)

-- 
2.43.0
---
== Earlier Postings ==
v7: https://lore.kernel.org/all/20250408112402.181574-1-shivankg@amd.com
v6: https://lore.kernel.org/all/20250226082549.6034-1-shivankg@amd.com
v5: https://lore.kernel.org/all/20250219101559.414878-1-shivankg@amd.com
v4: https://lore.kernel.org/all/20250210063227.41125-1-shivankg@amd.com
v3: https://lore.kernel.org/all/20241105164549.154700-1-shivankg@amd.com
v2: https://lore.kernel.org/all/20240919094438.10987-1-shivankg@amd.com
v1: https://lore.kernel.org/all/20240916165743.201087-1-shivankg@amd.com

