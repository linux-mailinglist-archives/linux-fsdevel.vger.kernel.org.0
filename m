Return-Path: <linux-fsdevel+bounces-42640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5CDA45816
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF828161FFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6EF1E1DEF;
	Wed, 26 Feb 2025 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4h6+esaP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A540664C6;
	Wed, 26 Feb 2025 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558468; cv=fail; b=CwoaOh49aqQ9xYbgelLvqLIzKH2L/iGVU5bVj6wwUinVJqdDVCaJIh3kAZxxInIsvJgYM5few9Iz/lAdDHQV9sq6skfKUBP81ZeyVj19P2fwC5Hvw0CEV8YHSaI7hMpRgXji4OhZpW+FJQF17yD/5dfDhPWqOqhDlD2vIPVUa1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558468; c=relaxed/simple;
	bh=HKQN2rKJl/bezJ88Yixn4sec/DCcpKL1rDvGPOi2HA8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sDYJMcrI+bqE92Ac1wyomNCsAA5uEU7hQP0auDJipZMx8nCAlgJKy4RuT0eOivT8FhmGvrcNZqSiIqNTVQLaCKlXINIfWOc8cBC2JNnvjoW/FZVsgqurcNAjpwZDFoZOZC7dveSTxASst9AwAU/Ij24Ndpo7zyF0M8IoJtQegfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4h6+esaP; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4LfgRejqBGFSPUAzOjR3RdyrwY1dWN4MkuN9zYJtwT3x4qsHJxcv9TMW3kyaZWRDKlavnmhfQH6q9cAWkbOeV9Tc/X056e6nfodEKAlJEwWp4fys1p7KfH4zzRJQuU7HG/D3Uzqz+r+fQ3T+HwA8YYnioJHNkwWxtTy9WZT1Tirc8MhJxm+h7xIloWsgWYjkSgsV5xc857S0+JMYzAQ1/9rgiMoVJLL4glOlW9PPU0jRRY4EDm5gbl1G/+vYgKHU12CPZ3J4FvOexsYVISsnO3JfB2qjwPvG46FJifNUe292OxSSYdhfLqfqpF/bN/LIyEdIJftupZg73ijeecv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Z1CMXo1Vzk7Qjy0gEXx2NtQMkXlq7LgoMdxVwHlt6M=;
 b=AL+BtvsGRPj08Xw2hiGLOGBW+OuCsJyS940ZuHBdhhH8n/jnBbsvWl30AD2tQkhq8fEG3YRV90RNFNVeQ8QaFZo1A8IKIG2FBVZnugJ/PzPhfR5JHWzUI0ZbgBYVNFsF2EMew75Lmrff/vEDUqw4jo6ETYiXPa6c8wiLYr7IUJKyfiPVfCbG6txi5D1yzGoNKdI8nwrRLSWpt0grN1ilKe5Iv3/lySjHQzw2J3bxYum7Gqo+GoaIjBMUYvzGk2nr51ecKYOU3JqS/UNvHtnmN5cEwCY5kwPLxQMs0EoyV6th8O2Ez24P/2/XSLEPoyDmv/1XUdxfMqCVWVNeSj8JxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Z1CMXo1Vzk7Qjy0gEXx2NtQMkXlq7LgoMdxVwHlt6M=;
 b=4h6+esaPDeCVuj1P8t5//I1I7N//HY3TA+7dpQ6b5wo/R86u/J7TfH2RUnlmvW8Zk+AXeYnUxIaacmOqT6tKvCYhOodL+GgPxn8nk/+53Wa8DzPPSgq0dKxozbfYloau3lukgoYVT5MG15xXjl2iAMjNMmrMtyRX/TtP3o/ujVc=
Received: from PH7P220CA0061.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::25)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Wed, 26 Feb
 2025 08:27:42 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::77) by PH7P220CA0061.outlook.office365.com
 (2603:10b6:510:32c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Wed,
 26 Feb 2025 08:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Wed, 26 Feb 2025 08:27:41 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 02:27:35 -0600
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <willy@infradead.org>, <pbonzini@redhat.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <chao.gao@intel.com>, <seanjc@google.com>,
	<ackerleytng@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<shivankg@amd.com>, <tabba@google.com>
Subject: [PATCH v6 0/5] Add NUMA mempolicy support for KVM guest-memfd
Date: Wed, 26 Feb 2025 08:25:44 +0000
Message-ID: <20250226082549.6034-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db46084-b7a8-49fd-9d84-08dd563f6fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S6oeeia3Wh8Jmjg+sFS0BLTs3i/UcIxVL+7B7uMYGzpOOzU9Nqeaiv3QdX1b?=
 =?us-ascii?Q?PJKmhiplTKH9OIFjSzCr5Grev3JbGisRLbZ5Da7FK9lg2TK3U0Ay0e5NiTs5?=
 =?us-ascii?Q?Cz7fkF1vaN/W9YUJButTBRK174bMitG9zB9aXTEVkSXzu8pxmUTWboefLIuP?=
 =?us-ascii?Q?dLLTaAhzmGnkvTljP+q8QZql9hwNIiN468CkV/MPdQzoPetg3z+oDDrl16yB?=
 =?us-ascii?Q?30rRwxDUE5VruWCtormPzMOGygd46sVLPkVnhFYbdq9V+Bxc7xRpwplCJ9z+?=
 =?us-ascii?Q?CSjHNzC2drKzktn8ey6VPubiYq/V24uCRhDGa5VMtp0i8k9EI9B8OSHLEZtB?=
 =?us-ascii?Q?16dLwHscFPKUgDQxPUIJ591C0GbV649poDfb6Q3uMv2zkoRCIjaEDTNC+YbO?=
 =?us-ascii?Q?HiyBBU2IUHH3zVThgcXO/3LGQXRy4X6d7IwrdnHw+JAsxSttCcIa/anfWQuV?=
 =?us-ascii?Q?YskHNj7xy06BTrutZTs9PSl0MULVt/dpKY1pedAcI4aJZVGbPIEhDCdq0iYj?=
 =?us-ascii?Q?zBXeWiwccLf/4hQx8UEkOVikEHrkb8Vhim2iHKEUal6z/gfbE9+KKI76eZMI?=
 =?us-ascii?Q?6OTaLxHOinLc/wlH781Di71lpZgOhWxlRJB1Cy4RX24bblYJeAxYQxxaE8He?=
 =?us-ascii?Q?Qw1II8y3ybDMufcDijjmACi86DIGsFeNFPLbC2rCfqLWPCMtUxGYIOccYzXx?=
 =?us-ascii?Q?H2TwxQ+eFZznKhZcK9Iuv4tS7bZoxMrQrfK6m0aI+wHFzAIdle5aNMxczjAO?=
 =?us-ascii?Q?wAjotm2C+zZATSByxPfP8Bpj7c1eXub/RGE4OEV4byHvU8DqhHHRTrtRp8Js?=
 =?us-ascii?Q?YwIb++S8o5/JyLYR+NYapCYjqEpsDf9NaDcSRbIRF8CpB4op3OShtt4VmYZu?=
 =?us-ascii?Q?Y98DCCJCWzDMIrX5VRStkt9PXov9ZPBpsiSNNJ+csbJ0mgEjJmM5eefS1DmX?=
 =?us-ascii?Q?hB9FMBy7wrtIB7rGRljOMsmX1OrOTxwUDKhYjL/GdUCHOSTc/87P0BpX+DNY?=
 =?us-ascii?Q?tTXgn5WQBQ/TtsDRYNZSXS5pe7H/hCZW05ET2dFAPgaCHJ5J/ZQatY/KPmPl?=
 =?us-ascii?Q?t5LA3j+QTf5AwHBB4X2Wrla0v2FoZzRC+yXlp76+ro5t6ybxOFF2IYuG1SPA?=
 =?us-ascii?Q?OzxuYv4c5ZepJwv2H7E7wALioUW+ic8lAn9fYsSZhrtdq6KNEN/9gtGCeAfG?=
 =?us-ascii?Q?pIkDAreWYGx5EQf1j7/hdfwXpxcAkKs/qcHVk3VuQpM9Z8MI6YDUeon+FpmG?=
 =?us-ascii?Q?Yh65lcdHAD4/rBeI5IRK5j/FP8X+vScZyE8LH1SV+/TVOvfYQRGmZsTGsQXw?=
 =?us-ascii?Q?GGfdT7epxaEKM4QWbasPmxdlXprwGOu0swSYMB6ryBNI4eMLqy1LMUGIXFbm?=
 =?us-ascii?Q?Z/uRMICIfgNGbx90h3ZKvqA2bWxG5J1FQWXgeCTOTtcheq55i1zRdyLLgWg+?=
 =?us-ascii?Q?G7l57LB+s26KhCVjfHBdM0T7mlfqWBiJyiHvYOLAIwVSWpSgUVIBZpVjKB3s?=
 =?us-ascii?Q?bX4mk0Dzrbp6HVc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 08:27:41.4835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db46084-b7a8-49fd-9d84-08dd563f6fe0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013

In this patch-series:
Based on the discussion in the bi-weekly guest_memfd upstream call on
2025-02-20[4], I have dropped the RFC tag, documented the memory allocation
behavior after policy changes and added selftests.


KVM's guest-memfd memory backend currently lacks support for NUMA policy
enforcement, causing guest memory allocations to be distributed arbitrarily
across host NUMA nodes regardless of the policy specified by the VMM. This
occurs because conventional userspace NUMA control mechanisms like mbind()
are ineffective with guest-memfd, as the memory isn't directly mapped to
userspace when allocations occur.

This patch-series adds NUMA binding capabilities to guest_memfd backend
KVM guests. It has evolved through several approaches based on community
feedback:

- v1,v2: Extended the KVM_CREATE_GUEST_MEMFD IOCTL to pass mempolicy.
- v3: Introduced fbind() syscall for VMM memory-placement configuration.
- v4-v6: Current approach using shared_policy support and vm_ops (based on
      suggestions from David[1] and guest_memfd biweekly upstream call[2]).

For SEV-SNP guests, which use the guest-memfd memory backend, NUMA-aware
memory placement is essential for optimal performance, particularly for
memory-intensive workloads.

This series implements proper NUMA policy support for guest-memfd by:

1. Adding mempolicy-aware allocation APIs to the filemap layer.
2. Implementing get/set_policy vm_ops in guest_memfd to support shared policy.

With these changes, VMMs can now control guest memory placement by
specifying:
- Policy modes: default, bind, interleave, or preferred
- Host NUMA nodes: List of target nodes for memory allocation

The policy change only affect future allocations and do not migrate
existing memory. This matches mbind(2)'s default behavior which affects
only new allocations unless overridden with MPOL_MF_MOVE/MPOL_MF_MOVE_ALL
flags, which are not supported for guest_memfd as it is unmovable.

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

[1] https://lore.kernel.org/linux-mm/6fbef654-36e2-4be5-906e-2a648a845278@redhat.com
[2] https://lore.kernel.org/linux-mm/82c53460-a550-4236-a65a-78f292814edb@redhat.com
[3] https://github.com/shivankgarg98/qemu/tree/guest_memfd_mbind_NUMA
[4] https://lore.kernel.org/linux-mm/2b77e055-98ac-43a1-a7ad-9f9065d7f38f@amd.com

== Earlier postings and changelogs ==

v6 (current):
- Rebase to linux mainline
- Drop RFC tag
- Add selftests to ensure NUMA support for guest_memfd works correctly.

v5:
- https://lore.kernel.org/linux-mm/20250219101559.414878-1-shivankg@amd.com
- Fix documentation and style issues.
- Use EXPORT_SYMBOL_GPL
- Split preparatory change in separate patch

v4:
- https://lore.kernel.org/linux-mm/20250210063227.41125-1-shivankg@amd.com
- Dropped fbind() approach in favor of shared policy support.

v3:
- https://lore.kernel.org/linux-mm/20241105164549.154700-1-shivankg@amd.com
- Introduce fbind() syscall and drop the IOCTL-based approach.

v2:
- https://lore.kernel.org/linux-mm/20240919094438.10987-1-shivankg@amd.com
- Add fixes suggested by Matthew Wilcox.

v1:
- https://lore.kernel.org/linux-mm/20240916165743.201087-1-shivankg@amd.com
- Proposed IOCTL based approach to pass NUMA mempolicy.

Shivank Garg (4):
  mm/mempolicy: export memory policy symbols
  KVM: guest_memfd: Pass file pointer instead of inode pointer
  KVM: guest_memfd: Enforce NUMA mempolicy using shared policy
  KVM: guest_memfd: selftests: add tests for mmap and NUMA policy
    support

Shivansh Dhiman (1):
  mm/filemap: add mempolicy support to the filemap layer

 include/linux/pagemap.h                       | 39 +++++++++
 mm/filemap.c                                  | 30 +++++--
 mm/mempolicy.c                                |  6 ++
 .../testing/selftests/kvm/guest_memfd_test.c  | 86 +++++++++++++++++-
 virt/kvm/guest_memfd.c                        | 87 +++++++++++++++++--
 5 files changed, 233 insertions(+), 15 deletions(-)

-- 
2.34.1


