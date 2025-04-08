Return-Path: <linux-fsdevel+bounces-45967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFAEA800B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 13:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1FB4467CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 11:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A6F268C62;
	Tue,  8 Apr 2025 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AoYqtTbZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989EF266583;
	Tue,  8 Apr 2025 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111485; cv=fail; b=K0T1pgAvRnGPipVRyJRODy9HG13YEF2ySeYsH/uTUqOlRg4R9BsY0mrhnTjuTxIInm/kbQK1HhGBsO9P4qjwKJHxAaScGBmIDDaIu0ynVpYSKkjXZXH9lMRBe72QSwCo4UWUxox0EaIdoAVgIpPmIOLkV0E1NJ6xj1gMdew6yEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111485; c=relaxed/simple;
	bh=Pv5oDwknAVGFpTNeujZAZjTtPsjtkW+O7ZT4r/BrYSU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gRBY9pJCt+pQQm/w2DaczCFbiTkglsOLvBqI5Kr4GkC92MjVoB97aD2p1E/iVdus5DsVmckFNuOQcQ6EAYDIK66IqtrrpEWQj/PkD3x9Y1N2bJwj0kiV6Nnnsfe5b1EZZCwjeDaKEmhwRtaAAZ3p536OsPN8Hcik9uEYdo1L6Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AoYqtTbZ; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkFNbyQrqv/p5RUOZK5LcPP46Y6Utgr3Rm0njyHqoAhHvj7ft4RdGdgDtgoFcblQsgHYzQVSQXNZsZqln2cR44ICHhyrnoKL+ah4fByuKV7D79eWt8jZR6zNMuKfY8U1q4XY+LkIqaqgNW5K5lgs8Cy8SP4IXx4Sy55KOQnhTnAgwRu/2XIhKJ38sfHDowI+8cRMFgHpD0kuDHxr1s65RI6TC/ItAPyuelBWxEmjY1q8Z2OrZW0Mr/RPoWga6NYUQzcQzVXYNKZgE7+TPHK+5tgKavG+w7+fKI21E2YX7pZ6oKc1Eq3okM5nGW4R4bnT6HUzcoEJrJmy1Fjv0AQM+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPhibcpVjmANhfrk+t6lfApSdxABL6JpZQVR1SdWuzw=;
 b=syaMzxwBiVU8kV3zX5vQf2UpeswONDeNADCd1NPw5vMrhO4a43L1qVutTO9oE16KSKfhE4smDAWnA3nMOGrJiK4iuX+vWjirS4NKhOJ3uHcTSXfuhKEpFySHwiv14jDzTesEo6uiX0eLOM0uJQ3hMWAJLRribJZIPfSEhptvrV7Ee8kaXsnx8nqnSAwflkuGtEqe5HV1sxiOIqs+bZF3upyQYOU19wpv+ggQJW0CZVMjkWueFVv8R2w01MhiMXDoxAoQSxtvFcbb3QMQ8ReF1XE9/v4ukjWr03Jvvy1A62StJQW3hc6QzedHlNKgf7kqX+OlECypgUnqN+7SCkZVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPhibcpVjmANhfrk+t6lfApSdxABL6JpZQVR1SdWuzw=;
 b=AoYqtTbZuoZBwmfau7kU58rHNfrwtsuYpU/X0vDBX8cNrdHu+pqoagw++K2ZyZxKJL2F+UaA0QVDEQl6L+BRbEP8oha2cGVdiaBxPgYib4DU9quO8ZizJRpEAGxfxNjW/JSeRWmxbrm0kIlfZeh7MhSH+AkL6VhPgNkPY5vmEQw=
Received: from SN7PR04CA0052.namprd04.prod.outlook.com (2603:10b6:806:120::27)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 11:24:37 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::5e) by SN7PR04CA0052.outlook.office365.com
 (2603:10b6:806:120::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Tue,
 8 Apr 2025 11:24:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Tue, 8 Apr 2025 11:24:37 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 06:24:28 -0500
From: Shivank Garg <shivankg@amd.com>
To: <seanjc@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<willy@infradead.org>, <akpm@linux-foundation.org>, <shuah@kernel.org>,
	<pbonzini@redhat.com>
CC: <ackerleytng@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <pvorel@suse.cz>, <bfoster@redhat.com>,
	<tabba@google.com>, <vannapurve@google.com>, <chao.gao@intel.com>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<yan.y.zhao@intel.com>, <Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <aik@amd.com>, <jgg@nvidia.com>,
	<kalyazin@amazon.com>, <peterx@redhat.com>, <shivankg@amd.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH RFC v7 0/8] Add NUMA mempolicy support for KVM guest-memfd
Date: Tue, 8 Apr 2025 11:23:54 +0000
Message-ID: <20250408112402.181574-1-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b0c027-ddac-4128-03a4-08dd768ff229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H50w9zhVrLGbbMFha/How8/oBHlgdSi7nLFh/L6kluIoEi6cSokK6dCyCV3I?=
 =?us-ascii?Q?eAS3DjiDirnjEvz1g/9YluX1vOOANbwbRn9mdqpm6lVh5T9DPjWILRRKkK4W?=
 =?us-ascii?Q?mYz4XN9MQik8MElHWdi5vYIFJXRK+VPhe95VjR3lV0/lDliI7/PQmJ0R3sFn?=
 =?us-ascii?Q?zOvQa6pbrHcPeHJNLg4hw+hlwmREg7ON2+CaxXmIasR7Jvu789GaLMMI3/5y?=
 =?us-ascii?Q?XMU7Dud6iQGc/BrWJeSjeOE04W3n/0SC+WfMHR9n0WQ7jb3Dfera/+mjDWzi?=
 =?us-ascii?Q?DMhLCsDAIqequa4LrMfoxRcMc2yqjIsN7vkxIEJxTqltuHBd+l0KZ4SBV7o7?=
 =?us-ascii?Q?RrQdQUW78e/t5yGOEclde76PbA/bXqcaqqhirlbyR7+pxPakzT8qDT3aLg2R?=
 =?us-ascii?Q?WNIISs5DQAIVBQkpggRAQCYCn3WrCzL+0oM+6xnbNnLoVnsiFp22f6ikuSp8?=
 =?us-ascii?Q?1UtP2rsTiR83rQyJ2lHIPmtVghr7yuIagJbCxS9QYWPuare1sayv8BMalwD1?=
 =?us-ascii?Q?6mIqQrODuWfRqbUnQWBXmrPCuzTgF6BzzqZwHjr59hO01ERJB+sy8k0LBCE2?=
 =?us-ascii?Q?2PGBfYJm9JRkGAgw5ovZmMZbkmWts/Do2Gm+uB6dc3YKzNNPC1ns37mTjDqj?=
 =?us-ascii?Q?ILgqPsq2RemJ+PYJAeNhLVkylUvUGwSvJGWl6wV9J8XSkfrBWi8OsgN078J/?=
 =?us-ascii?Q?DrEgT7+IcSAWn2PBCvKurdUXXK+98m5negL98u2cdQAHL0DTmiNADuv0pidL?=
 =?us-ascii?Q?PQYZqGBPfbJtT3P8fd/2kKYLJYm1qfcP0YsKAjeDSHzg9mUe7cez3zHBtE2x?=
 =?us-ascii?Q?5/BatcTOTrSihecQs2K21iMCD8ZRzTK+Q47SzdInnfn4Yov3uCv/eb46Pt13?=
 =?us-ascii?Q?Si1X33pgmj1Tk1RTZCQTRFU1KrjWNAFdruGnBcSUrJHPatseVot/Orv/hKp8?=
 =?us-ascii?Q?2qeMwRw1rKcvMHoLDNhBc2ZQ/txkh/Fe619qHGskoFNtsR/z0ScQS6od5/Ys?=
 =?us-ascii?Q?lIhIryPzJhUncaDCPp+Kx9LmekHU/6U57NSvKzqtDbgUVodM6JBZi32OzJzv?=
 =?us-ascii?Q?2csgWnPULRySTvLKn6hIZSqEzffWbIfm+RZ40B5xqYzDq0XFosJqTeaQ44az?=
 =?us-ascii?Q?jv2komRFUxkT3v7iJP/nkH8YbfXuQr3A5vqRlsiY82e9qnO8XGh8ROTuqfyI?=
 =?us-ascii?Q?NKUU7WB4qvjfz27a/5+0OVaYvyLbb68FbR7MKVvNIcCKN6M0TXjJUTZyKNdc?=
 =?us-ascii?Q?9cqNRm67yDc74k6M5c4IQ6hytTBmf/4sCpMDwa03dDCFrsO4tEB56jEP0ZHx?=
 =?us-ascii?Q?mUzdKqt1VxXSbxgJk6YFYicykk1c7dUMVgbGgx6YETT9ss36Um6L6ISkjuAZ?=
 =?us-ascii?Q?2ColV5Qcw0ApL0095bRpdKUm4ZQWOb79hQQ3HxdYbCdDOBmzusOIvSjElDRW?=
 =?us-ascii?Q?fzHNtqXaeJo/+t+VYyAvkdI+0SVGkMXVs8NY2MAW6DW0ZVDj9YCxrC3jiOMW?=
 =?us-ascii?Q?gsh3YsJfZLyxYVI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 11:24:37.1028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b0c027-ddac-4128-03a4-08dd768ff229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655

KVM's guest-memfd memory backend currently lacks support for NUMA policy
enforcement, causing guest memory allocations to be distributed arbitrarily
across host NUMA nodes regardless of the policy specified by the VMM. This
occurs because conventional userspace NUMA control mechanisms like mbind()
are ineffective with guest-memfd, as the memory isn't directly mapped to
userspace when allocations occur.

This patch-series adds NUMA-aware memory placement for guest_memfd backed
KVM guests. Based on community feedback, the approach has evolved as
follows:

- v1,v2: Extended the KVM_CREATE_GUEST_MEMFD IOCTL to pass mempolicy.
- v3: Introduced fbind() syscall for VMM memory-placement configuration.
- v4-v6: Current approach using shared_policy support and vm_ops (based on
         suggestions from David[1] and guest_memfd biweekly upstream
         calls[2][4]).
- v7: Use inodes to store NUMA policy instead of file[5].

== Implementation ==

This series implements proper NUMA policy support for guest-memfd by:

1. Adding mempolicy-aware allocation APIs to the filemap layer.
2. Add custom inodes (via a dedicated slab-allocated inode cache,
   kvm_gmem_inode_info) to store NUMA policy and metadata for guest memory.
3. Implementing get/set_policy vm_ops in guest_memfd to support shared policy.

With these changes, VMMs can now control guest memory placement by
specifying:
- Policy modes: default, bind, interleave, or preferred
- Host NUMA nodes: List of target nodes for memory allocation

Policies only affect future allocations and do not migrate existing memory.
This matches mbind(2)'s default behavior which affects only new allocations
unless overridden with MPOL_MF_MOVE/MPOL_MF_MOVE_ALL flags (Not supported
for guest_memfd as it is unmovable).

This series builds on the existing guest-memfd support in KVM and provides
a clean integration path for NUMA-aware memory management in confidential
computing environments. The work is primarily focused on supporting SEV-SNP
requirements, though the benefits extend to any VMM using the guest-memfd
backend that needs control over guest memory placement.

== Example usage with QEMU (requires patched QEMU from [3]) ==

Snippet of the QEMU changes[3] needed to support this feature:

        /* Create and map guest-memfd region */
        new_block->guest_memfd = kvm_create_guest_memfd(
                                  new_block->max_length, 0, errp);
...
        void *ptr_memfd = mmap(NULL, new_block->max_length,
                               PROT_READ | PROT_WRITE, MAP_SHARED,
                               new_block->guest_memfd, 0);
...
        /* Apply NUMA policy */
        int ret = mbind(ptr_memfd, new_block->max_length,
                        backend->policy, backend->host_nodes,
                        maxnode+1, 0);
...

QEMU Command to run SEV-SNP guest with interleaved memory across
nodes 0 and 1 of the host:

$ qemu-system-x86_64 \
   -enable-kvm \
  ...
   -machine memory-encryption=sev0,vmport=off \
   -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1 \
   -numa node,nodeid=0,memdev=ram0,cpus=0-15 \
   -object memory-backend-memfd,id=ram0,host-nodes=0-1,policy=interleave,size=1024M,share=true,prealloc=false

== Experiment and Analysis == 

SEV-SNP enabled host, AMD Zen 3, 2 socket 2 NUMA node system
NUMA for Policy Guest Node 0: policy=interleave, host-node=0-1

Test: Allocate and touch 50GB inside guest on node=0.


* Generic Kernel (without NUMA supported guest-memfd):
                          Node 0          Node 1           Total
Before running Test:
MemUsed                  9981.60         3312.00        13293.60
After running Test:
MemUsed                 61451.72         3201.62        64653.34

Arbitrary allocations: all ~50GB allocated on node 0.


* With NUMA supported guest-memfd:
                          Node 0          Node 1           Total
Before running Test:
MemUsed                  5003.88         3963.07         8966.94
After running Test:
MemUsed                 30607.55        29670.00        60277.55

Balanced memory distribution: Equal increase (~25GB) on both nodes.

== Conclusion ==

Adding the NUMA-aware memory management to guest_memfd will make a lot of
sense. Improving performance of memory-intensive and locality-sensitive
workloads with fine-grained control over guest memory allocations, as
pointed out in the analysis.

Please review and provide feedback!

Thanks,
Shivank

[1] https://lore.kernel.org/all/6fbef654-36e2-4be5-906e-2a648a845278@redhat.com
[2] https://lore.kernel.org/all/6f2bfac2-d9e7-4e4a-9298-7accded16b4f@redhat.com
[3] https://github.com/shivankgarg98/qemu/tree/guest_memfd_mbind_NUMA
[4] https://lore.kernel.org/all/2b77e055-98ac-43a1-a7ad-9f9065d7f38f@amd.com
[5] https://lore.kernel.org/all/diqzbjumm167.fsf@ackerleytng-ctop.c.googlers.com

== Earlier postings and changelogs ==

v7 (current):
- Add fixes suggested by Vlastimil and Ackerley.
- Store NUMA policy in custom inode struct instead of file.

v6:
- https://lore.kernel.org/all/20250226082549.6034-1-shivankg@amd.com
- Rebase to linux mainline
- Drop RFC tag
- Add selftests to ensure NUMA support for guest_memfd works correctly.

v5:
- https://lore.kernel.org/all/20250219101559.414878-1-shivankg@amd.com
- Fix documentation and style issues.
- Use EXPORT_SYMBOL_GPL
- Split preparatory change in separate patch

v4:
- https://lore.kernel.org/all/20250210063227.41125-1-shivankg@amd.com
- Dropped fbind() approach in favor of shared policy support.

v3:
- https://lore.kernel.org/all/20241105164549.154700-1-shivankg@amd.com
- Introduce fbind() syscall and drop the IOCTL-based approach.

v2:
- https://lore.kernel.org/all/20240919094438.10987-1-shivankg@amd.com
- Add fixes suggested by Matthew Wilcox.

v1:
- https://lore.kernel.org/all/20240916165743.201087-1-shivankg@amd.com
- Proposed IOCTL based approach to pass NUMA mempolicy.

Ackerley Tng (1):
  KVM: guest_memfd: Make guest mem use guest mem inodes instead of
    anonymous inodes

Shivank Garg (6):
  mm/mempolicy: Export memory policy symbols
  security: Export security_inode_init_security_anon for KVM guest_memfd
  KVM: Add kvm_gmem_exit() cleanup function
  KVM: guest_memfd: Add slab-allocated inode cache
  KVM: guest_memfd: Enforce NUMA mempolicy using shared policy
  KVM: guest_memfd: selftests: Add tests for mmap and NUMA policy
    support

Shivansh Dhiman (1):
  mm/filemap: Add mempolicy support to the filemap layer

 include/linux/pagemap.h                       |  41 +++
 include/uapi/linux/magic.h                    |   1 +
 mm/filemap.c                                  |  27 +-
 mm/mempolicy.c                                |   6 +
 security/security.c                           |   1 +
 .../testing/selftests/kvm/guest_memfd_test.c  |  86 +++++-
 virt/kvm/guest_memfd.c                        | 261 ++++++++++++++++--
 virt/kvm/kvm_main.c                           |   2 +
 virt/kvm/kvm_mm.h                             |   6 +
 9 files changed, 402 insertions(+), 29 deletions(-)

-- 
2.34.1


