Return-Path: <linux-fsdevel+bounces-41365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC7AA2E433
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 07:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE59F18868E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 06:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A0A1A317F;
	Mon, 10 Feb 2025 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OS8xa24K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33293987D;
	Mon, 10 Feb 2025 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739169486; cv=fail; b=t2OdAbdNYS8Q182ba369CwCgTt6V8EBPJcaQ3PcEvh8Nkes+664ZwwJ9oX6FFJfOoqUqohGwePw0luFW5NMLy1FqJeihXh12YpEzSA/kYJXzbq8SomKtg+Vm+r9CJ3sY5Z43USw2noMZ5aZCLriVs+RrFsR++1hkmoTlv2cQzXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739169486; c=relaxed/simple;
	bh=vJJIIrb5Dk7U96Gwh0oY2ug4XuC2+mH/ohG2Bsanhg8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DNtt5ULPhV9kSL0I1JOuAuUWkZBwfTCEGFSUxYIAcZEw7IMGX0vBs22mp4/qJah//gyCm9vK5rFFFjXDJbCgiWl5mJ6yr7QlBH1I+zLd2FJ/FhHphGoQ1oARtfzHqm6ViMlX2AaPD96keHwcNl4QKvhXpI/xE3Df2xKECjDr+TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OS8xa24K; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdozUxLhGeBCalcMq7CyV2vABTdrA7jbrRU5i+WmWAgOqtTPStx4TPvBlUIrqHvLYVx6Cu1GAYLrY8iHLnqKEn61rNA+XV5vMuVQlpooFhcDP4U4bKq4Z6OpC3dDm7ZtafApdMQXjiIU0AEnxUUqdhdmgNKJoKWVHi+Ryfcy1YMbAOicvPC3lzxK+/rFNYyxWmq/h04QIf+kXpBT5+f/0Jcr45X1N3A5L7suW9d/CRZJD5WuwXfml6rIPQ3AQXLQTE6H9IE9s6ZpD7BAMqOEbfD2TZ83KLZ/4Gp+hOWpYf5OLVru0MUINX9g5VJ3K2YUqFLzcTRuvQx34d6TOHRtcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxASIlbNI7h/WfO7nn+uQa4WjxHuyX8DFCOPvUSqA9c=;
 b=hVxPMI5YBxGLGi3qyQk3exASYJ+YxU3U+XTNkaWJlzpDkffAj5VesPhZL1y/t9whfAjVsE+xEcOOFvN/vrliSSa5Shtw5Mb2PnGIDqR36BS9sMTV+Ud0Jx0VbyLl1Aeyclt5O42NHkPmNrdivXxX+I3Bv9NkgH1blGI1wlC9peOxA7/R26CUtNqSaYHYy7ibx988dz7+B90+90hd0PCPQq3MaCoJPUl3M0gz/uZ5HdD3RADoq+m0DH34913CoGUM7bZm1Ltn+dOctQH4K+21ywlN1Vio9j4D2ra1t2OzvQIshyJd1pRhU5pKgOhbyLAsOqJOOLUYxrd6NPc4lT6CKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxASIlbNI7h/WfO7nn+uQa4WjxHuyX8DFCOPvUSqA9c=;
 b=OS8xa24KfrN49xV/DrzMYpc00HkYRQCFziDC/Atisjg5382nkuZ4xaPi775SxMdMUpH/K/R7JyBGGBn8g/eIX+XfsZ52l0kb+wxAFjGb8IPmkNVT0pqc7NZPr8FDpmBreH7LDEKdQbV6HKoF3dRl67aAgBypShkilLkNzEGP+2c=
Received: from BN8PR07CA0005.namprd07.prod.outlook.com (2603:10b6:408:ac::18)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 06:37:57 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:ac:cafe::93) by BN8PR07CA0005.outlook.office365.com
 (2603:10b6:408:ac::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 06:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 06:37:56 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 00:37:51 -0600
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <willy@infradead.org>, <pbonzini@redhat.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <chao.gao@intel.com>, <seanjc@google.com>,
	<ackerleytng@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<shivankg@amd.com>
Subject: [RFC PATCH v4 0/3] Add NUMA mempolicy support for KVM guest-memfd
Date: Mon, 10 Feb 2025 06:32:25 +0000
Message-ID: <20250210063227.41125-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eaf930f-7a56-4827-d6f7-08dd499d7470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JWHWnuqsoYQZ7W0kK/FwFUQ+zVsOgdQKHNzFcJAo7N+P7gyO6NazJS2R72IU?=
 =?us-ascii?Q?lcBW35v3uGcprqzvTRJhD/oQPZwu1qNJKpuWyWFBLyePuGScgNv/sp+IYamj?=
 =?us-ascii?Q?XVDjFVm0bIanjAUsJwDfnydy/g8Jylrzvphkl5mw1TPdmLqr0OPerEXFgbXd?=
 =?us-ascii?Q?c122QOOIR0qgBZN7Yt4fUG40BukCG2DxBOe7m+JjxtSKF5PEzsR32HvP39d1?=
 =?us-ascii?Q?oEjretSiJxnCYDM7uVN5Vxn8JlqqfZQZPokmjlnkiewqvyHPKw9D4X9VNefI?=
 =?us-ascii?Q?+QJYc/y9SyvOqNmyX8jJOYWQWMlwYcCFbLkMDTP+QbQLPRBuWilGaws+KeGG?=
 =?us-ascii?Q?Tng4tcUE3+Qr4l+zpviPF0qiACeq0ULXobP3/7UiC2YQxId5+69Jw+SQr+q9?=
 =?us-ascii?Q?vDXuaDGRdYRmqkTOCNn9+FVCsNDdPeYXtWhuRm6fUTjygB431FIk3oeGemja?=
 =?us-ascii?Q?O5I6YaukTd8gnw1l1Em7CAngK7rMBwEjdDjRhROxilvEjscGUgEG1MyjrOff?=
 =?us-ascii?Q?m3SdW8ITbscK88LKJd/akx8sngaKssygbZh4Ax7OHWHTxXvl4OSkEs9o8gVi?=
 =?us-ascii?Q?R894jYYWp2o6UAx2wBQQIgYxHQ3l0QCkqNv9h0Zs72bqTG7d21+mEVBvfy7c?=
 =?us-ascii?Q?KoqkzIQ18jAIeA6l5juD/YowARpPyFPWB9ktqqpoBG5iqTKclzf9aObvBitO?=
 =?us-ascii?Q?qBG1L3xMijWpEnkkfRIDPmJbYjSRV9pxnhKvoNPG4c/lbEe0y7K1gF1rXCZb?=
 =?us-ascii?Q?fgkdzZR3qoNDthQSplTlaSFdeeL5WO1ZPkQF8k+whoJGebf19OR2UAXBC5an?=
 =?us-ascii?Q?I9GNRwghFUdRKcBOt0wzgTLY24BJchyxqUZKl6+QpaHlrsckZ0IWhj1yVJZD?=
 =?us-ascii?Q?A/L72QGzt5Jf9QOlwoOk/+OO5sxjumx01eEzoTHS76q7tC8Nl9QCbvvXBzyT?=
 =?us-ascii?Q?NCGTlm6V7ZCvdSvycHM4TBLcBWFRexXatdNx6DZrvGv1T0FtPFmTN2ZQTHXw?=
 =?us-ascii?Q?+Kj0xsExwaJACHq78jGGxxqW1C07PACHILdDP1+cngfMB0HDQUCBIhhI5vs8?=
 =?us-ascii?Q?6jrH0SvKXYvxlT0sNYDKhOfMo3V720DKtYstvougvgfx4vThOcHoxdUWkjMe?=
 =?us-ascii?Q?DOC+B0yzOjDKAH1zAjy7TjQ2lRJyVS/FMg0Jmu9qRzbYqa3R0ngcxRjj+YcY?=
 =?us-ascii?Q?LWzsTQ0YLOy8Nx0Y3+Elz/eYGO5etxXQLxSsshTRQwh/UCgNxhO3dEG907i8?=
 =?us-ascii?Q?TJw5qX3+o41W0zJOJyvSJXnOhUsrUNPLBYfDpO0+5UbE9eZceKI+wEQxbXPN?=
 =?us-ascii?Q?7cnidug+odTWqPPPKttdOSFPV/VXvxj1z9ziAz6+lKKyQi9zSprWSCkMHH0+?=
 =?us-ascii?Q?MNdc+jK0AkeP1dMlCmOP/xNN3ILv/v1k6argWRFDiS/GhLFlttVcaFd6I7SM?=
 =?us-ascii?Q?jyMrGNqcL2qQHiosv0hgM1uJWHb+f79d?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 06:37:56.7942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eaf930f-7a56-4827-d6f7-08dd499d7470
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146

KVM's guest-memfd memory backend currently lacks support for NUMA policy
enforcement, causing guest memory allocations to be distributed arbitrarily
across host NUMA nodes regardless of the policy specified by the VMM. This
occurs because conventional userspace NUMA control mechanisms like mbind()
are ineffective with guest-memfd, as the memory isn't directly mapped to
userspace when allocations occur.

For SEV-SNP guests, which use the guest-memfd memory backend, NUMA-aware
memory placement is essential for optimal performance, particularly for
memory-intensive workloads.

This series implements proper NUMA policy support for guest-memfd by:
1. Adding mempolicy-aware allocation APIs to the filemap layer.
2. Implementing get/set_policy vm_ops in the guest_memfd to support the
   shared policy.

With these changes, VMMs can now control guest memory placement by
specifying:
- Policy modes: default, bind, interleave, or preferred
- Host NUMA nodes: List of target nodes for memory allocation

This series builds on the existing guest-memfd support in KVM and provides
a clean integration path for NUMA-aware memory management in confidential
computing environments. The work is primarily focused on supporting SEV-SNP
requirements, though the benefits extend to any VMM using the guest-memfd
backend that needs control over guest memory placement.

This approach suggested by David [1] and also discussed in bi-weekly
guest_memfd upstream call on 2024-11-14 [2].

== Example usage with QEMU (requires patched QEMU from [3]) ==

The QEMU changes[3] needed to support this feature are available at:

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

SEV-SNP enabled host, 6.14.0-rc1, AMD Zen 3, 2 socket 2 NUMA node system
NUMA for Policy Guest Node 0: policy=interleave, host-node=0-1

Test: Allocate and touch 50GB inside guest on node=0.

Generic Kernel (without NUMA supported guest-memfd):
                          Node 0          Node 1           Total
Before running Test:
MemUsed                  9981.60         3312.00        13293.60
After running Test:
MemUsed                 61451.72         3201.62        64653.34

Arbitrary allocations: all ~50GB allocated on node 0.

With NUMA supported guest-memfd:
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

== Earlier postings and changelogs ==

v4:
- Dropped fbind() approach in favor of shared policy support

v3:
- https://lore.kernel.org/linux-mm/20241105164549.154700-1-shivankg@amd.com
- Introduce fbind() syscall and drop the IOCTL-based approach

v2:
- https://lore.kernel.org/linux-mm/20240919094438.10987-1-shivankg@amd.com
- Add fixes suggested by Matthew Wilcox

v1:
- https://lore.kernel.org/linux-mm/20240916165743.201087-1-shivankg@amd.com
- Proposed IOCTL based approach to pass NUMA mempolicy

Shivank Garg (2):
  mm/mempolicy: export memory policy symbols
  KVM: guest_memfd: Enforce NUMA mempolicy using shared policy

Shivansh Dhiman (1):
  mm/filemap: add mempolicy support to the filemap layer

 include/linux/pagemap.h | 40 ++++++++++++++++++++
 mm/filemap.c            | 30 ++++++++++++---
 mm/mempolicy.c          |  6 +++
 virt/kvm/guest_memfd.c  | 84 ++++++++++++++++++++++++++++++++++++++---
 4 files changed, 149 insertions(+), 11 deletions(-)

-- 
2.34.1


