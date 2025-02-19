Return-Path: <linux-fsdevel+bounces-42054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D877A3BB52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 11:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB043AC0FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FE01D63FD;
	Wed, 19 Feb 2025 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jWtJNWiL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F5155753;
	Wed, 19 Feb 2025 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739960185; cv=fail; b=KxsI5QcN93MX/R/OeDg0VRiPg1XOukM/Ul8Cz+tu9fISI9YnkTFZGgg/0FSgUaO0dYaGLBBqJxxebV6LRgAwVk8tW24HO1ZZX/m1p3D7+AaNLcwbIM2qkh5VXjJFoU6mtEniuT8NwT1lmGu8TGurO44BkJ4FFIAJ+f/rLrw7Zws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739960185; c=relaxed/simple;
	bh=YD59VNZkby+qtvUfmVGGjTmCRkPANb6VwW2PmyYTMQs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Etwz1rf6Zwc3H+ou67em97lrilaPaFDR1zgGo5iyD9IU8C49bEjTeGgy9RP+yuRS43WITceZx0GUmNRIjPZscaH3lM6lLiTg/IJweyMC1Xv6N18tri9wC61Yor2MW4Bm6iRV4W7lD+Bs/Hf5TjDUYjiLC9TA3vEvJ+Vz9D+LaxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jWtJNWiL; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KD7dI3s08uEAPWAYNwuqLzJbPxAM0WBbpYSEcorFuLnk720VyozWQNg/GA0UKAQ/RcqQ26rC0MD9XFHesBAhHarQc7EjOkQFfutYdzAf1lqzpBNBlcYtDFGNK8rtjaI0TmYSudFrHRrfgGF76ef/aJgXRhWTdxOFvq866J6OfhrVr40+ypiPTFVPTucoR+mXCWJtESoKsIBkvT13+I7cuHOit3hmzBX4ZFuaW7Z6ksUI+YiIlLquptzbrNwaTCIei1cwE4ZiWgeGYFLptSsitNKHDKpk/zLonlcVXX2gKXfQ9jxv/ukSlkad5BhATxGo2MBbxeKsAVU4cA5cNoGEJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeEWryMeD5c6x5bvc4alWIWhgZSiEzBbX8nNMTT6Zxc=;
 b=ozweqUcfyM657yc4PYPfq92DAa1SAC19E9TADe4OGFCwBbZ0ZXtiDYsDAdQtim645cdWvdoSaAfOHeLnCXQTVBbR8ln1xZsY+vKF9OXie5b1BSI6JjX5EVV2lU9E0B56uIaXqz4lqLycehZdiahtrJzWtBA8QIVeGvhoX6BWk6VuSMTC3rMNTUT9jlLJofjC+EI099mSi4Du7EXQM0muoQt8+aIqVykU4C7ka6ku9vvYnwEAvElSOJ7fQQ1YSn+OsU9lvCEy3I/FHmOUzKaRdOWB5f9xkZUqssXs5esOU6YYqpmIZqEbA3/sgXpvmghAGpNjhoPoZc+kMCVLUZ1E3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeEWryMeD5c6x5bvc4alWIWhgZSiEzBbX8nNMTT6Zxc=;
 b=jWtJNWiLuokCb8l7nwEuXG7K8BtAnTL7w5iGtRRW39wgunzBpLlkQFosc+x4hwWhYsYDgdeQfg6t7f6bVemm/3lAoDaXI7XexxC1SVNWCJUhOE/C7NnTUam/tRKgZAbFgtMP7OIjRRHLn2KMpFfc1qvD/zCMWKFM+GUWJm4hP5E=
Received: from DS2PEPF0000455D.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::515) by IA0PR12MB8838.namprd12.prod.outlook.com
 (2603:10b6:208:483::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 10:16:19 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:2c:400:0:1007:0:a) by DS2PEPF0000455D.outlook.office365.com
 (2603:10b6:f:fc00::515) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.10 via Frontend Transport; Wed,
 19 Feb 2025 10:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 10:16:19 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 04:16:13 -0600
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <willy@infradead.org>, <pbonzini@redhat.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <chao.gao@intel.com>, <seanjc@google.com>,
	<ackerleytng@google.com>, <david@redhat.com>, <vbabka@suse.cz>,
	<bharata@amd.com>, <nikunj@amd.com>, <michael.day@amd.com>,
	<Neeraj.Upadhyay@amd.com>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<shivankg@amd.com>
Subject: [RFC PATCH v5 0/4] Add NUMA mempolicy support for KVM guest-memfd
Date: Wed, 19 Feb 2025 10:15:55 +0000
Message-ID: <20250219101559.414878-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA0PR12MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 4838ae97-0750-4b94-876a-08dd50ce73e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i8XRetO8GMH22Z0027Avv4xNWsqW1Rxqi0o1VN9RZzrtTQfmMGb7X7sYU9CL?=
 =?us-ascii?Q?mc6evqs6UcoWcZe8BDaJheuZNGpqHaLk14Skc4h4JajE29InRLlEA8pgRKs1?=
 =?us-ascii?Q?WqvsSv8Q3j3LbKVuxRF54kfsJQr37xH//+la6yA/bk9SyIvdXoB7Nxneayv/?=
 =?us-ascii?Q?etZ2rgdbF3gdVjNy1s1pDeh/DJItLLkHuEsg9Cc+tMgkZVW1ZF2Fe+/XWwYe?=
 =?us-ascii?Q?YPGmEy56oct04nnbMSLLurn2T5CpKOkLLtQGJWXLM4YM9FMuR/I29+hwSijA?=
 =?us-ascii?Q?yvmT87qEPX3ZhT3ZJyAD7ukD7Zh6ZJu9PV+KW5feVL7Zd1EhwtvU0y7m0U0s?=
 =?us-ascii?Q?+EL8Dtwkm5fzMsBP3fTBaq3zx1OaL6tyQJ69q900Bx2gpz6vfs2btnuFq+QO?=
 =?us-ascii?Q?Bth1Z4KiOjvSDqeVoJYkosba432ZcRDAvWrEHahwD2AMUpfQNXAXoXwL6Im1?=
 =?us-ascii?Q?AKesugzWHDX2+NsqNZ81YtR306YxKXtettx9TrS9QDJFYlN0rijaODx2GBdj?=
 =?us-ascii?Q?4GIS9CD/Ac615yzOVqCBs7Pd+lWBmY8x+TMO9+XYnyqlSjlwenWOXdgLt66C?=
 =?us-ascii?Q?sL+tRGP+gWHjDRdCvMin0Reao+8wKiGlqMfz3QxnnrHYYAUpLctrBylp6odK?=
 =?us-ascii?Q?V2MDSaoPXYNf9Sj3n7gOv9xCMjCHlogH23tZToL1Ib9hj9ZxhRYeSl0gvBSc?=
 =?us-ascii?Q?eg8/+pY+nFs8xkPk4DZhGmb/q2PPTmfsy9fGAvxoqiz8b6Jtd1jssRWJp6EB?=
 =?us-ascii?Q?jTXTGFYdktYSuA30FBxShJWXZ4hBqzsucizQ48BUBfzVT5SqkSEtb8uwVg6y?=
 =?us-ascii?Q?wRJXPR5Pu8S16vtZA41GUB1k4U6sGKqmvgCORnBrVdvDFNiWiJv7j7WLQq+N?=
 =?us-ascii?Q?UrTT+wuE8sOyy5Zy3Brf/vQxzNZ8rK9CVb9n9AJPm3lMzf5K/bFtuZbCXfe4?=
 =?us-ascii?Q?+Wl1Lo+8pEGTNYBSxZ8KtpuouJxz0aNS91WoldRw8IrCKSwJjK8AiMi6jczl?=
 =?us-ascii?Q?5J5St/xh1Uv4xwFscoGV8Sb3UAZO3vUr+TzKykuPTlBrlEIiFz6kRJXrPCSk?=
 =?us-ascii?Q?TIhwxzPNkXelNRBEaVPzjzrTv7AWx85ck6H89iFqQ/GoRbDNo9NomFXpCvYz?=
 =?us-ascii?Q?S4cHzTk0ZT6rA5SZ4u7Iq+DLM5pSVjLZJyV0lLrZ3W/lgKkg52ORTf2QPQTP?=
 =?us-ascii?Q?jin6bLj0yNe5XT0FAstAbrl55NZ13EZqOwwQ9fZXXK96KU0MBWH2Ll1ha6YA?=
 =?us-ascii?Q?0LY8JgKnWeDhO8IKx5q0txeGYq00ZlYqyU2EEjUJGTPTRuRBWygsghu3LMZs?=
 =?us-ascii?Q?SZJvVcAXE3JqN6U6i2yYFRlkz5Vl98yD1C980E1wbfZz+omFgz//LzKB7FyZ?=
 =?us-ascii?Q?TTbKlRV1koHvM0T8JxqJLnjg1VDwS4h+/DgERnYYAgupdCIsYtOZNyy36clK?=
 =?us-ascii?Q?S8XqvA6Rzck9UiYloKce8xrKxEL+hDtw4i4RG4pgf2l12C8UgEJk+w1il8un?=
 =?us-ascii?Q?HKjXTqa8un20WhE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 10:16:19.3644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4838ae97-0750-4b94-876a-08dd50ce73e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8838

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
- v4,v5: Current approach using shared_policy support and vm_ops (based on
      suggestions from David[1] and guest_memfd biweekly upstream call[2]).

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

v5 (current):
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

Shivank Garg (3):
  mm/mempolicy: export memory policy symbols
  KVM: guest_memfd: Pass file pointer instead of inode pointer
  KVM: guest_memfd: Enforce NUMA mempolicy using shared policy

Shivansh Dhiman (1):
  mm/filemap: add mempolicy support to the filemap layer

 include/linux/pagemap.h | 39 ++++++++++++++++++
 mm/filemap.c            | 30 +++++++++++---
 mm/mempolicy.c          |  6 +++
 virt/kvm/guest_memfd.c  | 87 ++++++++++++++++++++++++++++++++++++++---
 4 files changed, 151 insertions(+), 11 deletions(-)

-- 
2.34.1


