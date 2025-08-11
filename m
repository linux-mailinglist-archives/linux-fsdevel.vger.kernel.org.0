Return-Path: <linux-fsdevel+bounces-57272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00FAB2029B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776F73A7E28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AD92DCF6E;
	Mon, 11 Aug 2025 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dvvzTMOR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3A15ADB4;
	Mon, 11 Aug 2025 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903223; cv=fail; b=aVG+kXs2W9SdNPCspt66dAMWBJHd9r1F7/U5eF03ESFB92Gm4HnBWxm+HTkeWfOtEQRwlhn6qydJIvxhXctgXs2PrU+9T+Vg2dDOfzeC6yLegPjGJLss5PY+DqGiQMNsHcHl2eNDNd+Q/Q9fdbYPXK5VZkQcNaMBIKOOdDGafn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903223; c=relaxed/simple;
	bh=Bi17VvEv6ch/ISrZD9pRIqbBAar3ygO84UYDAfQmuPE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CuWWnNlZBpCMJZsCIYTRqMG7I0TwjyyiHtpSiovhZ3Ta0TcD5DgHdW8TrhocsBCybK9pzeyncHPeJa6MsKPiteJZqZu3fGrMHob4jk3/Hl7LSvvPP/2fr0vJI9Yc+7iLenFaUdOhy3GAbe4xhKYeUVjyq5g040Y8y0l2KZRCO8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dvvzTMOR; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zc81q3bx0eFVggDA7MN5eLLMpQ/aFNcVLur6ypMjsY0tl5CeXnPA1qXB97A3LPh0/7ww7xDeroBnrFdAHBWo1qGXdHU1KPb+CYRTHMQbKDXiu/bsp8N9BIerluOjPFiTJKR8OCIpGNoWhTvS0bJPTMNjbkkyVADsR1rJIBpmbpHg1wNDB1YNdIyGu9Y3iGoRz7bI+j4NhJLreBNGgGkMTeEuGUx+qvC9+UyCa4uSXFhf+Dg41a3FKv63+wxy/ieUjAcWm7AX5NZ4qakgtL94F4KIjwLfV2EhLMMPm8HpmlbC7NLI/Lk8/oNskm00XuBJue7iB8QPuUuCoyAInSsYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uv5+boXBi9GcmLuACnjZmSG/opn/uYE/QrGzAfABB28=;
 b=Nq4IOL+rPTlcnSaeIl1cGXNugNHyaVYOWrnr1dnbukcjWDXfHeRrH5F4oJF5iDwdSByB5LWkDa1pBAoEekguKYGbeabgZmWSbd7YwaiUYfyrdVGtT/4nHbbdeyY3qPKjYkA/E4HqaHIlBl9Ey7hGB/d4BegU/BufdJcE13k7wxFlTYaa8cCoX4vMAr8KWyarOTga9QDML9mPDb2D+frOWydbD1s0hqPWdUDP9XmWn7hESX31EhVnjleO+kQU6sT2A38b1iMBXIYD9TlsH7kUG1njs5IWxfC2jKvF2zw98oVI26cRMcFHkgM1mjn/bg6C74enRxwEuu+b5PxhG/Cnkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uv5+boXBi9GcmLuACnjZmSG/opn/uYE/QrGzAfABB28=;
 b=dvvzTMORIAezSz/crwrVqRNaCvSQbq8ZX0wBKtJT2FaaAP+XgJwWNKX166GXsLJ5cTlwX6sii0v0M0VpWl2HuKTrruakO77jmL+ihb8RYRGDR38vPuGNQNfvDvU2U/qBKcRmSbWYBp14LWyWF1rCsbOSrdAsR8HbGRMxpFVZjNw=
Received: from MN2PR20CA0015.namprd20.prod.outlook.com (2603:10b6:208:e8::28)
 by DM4PR12MB6544.namprd12.prod.outlook.com (2603:10b6:8:8d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Mon, 11 Aug 2025 09:06:56 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::49) by MN2PR20CA0015.outlook.office365.com
 (2603:10b6:208:e8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 09:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 09:06:56 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 04:06:40 -0500
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
Subject: [PATCH RFC V10 0/7] Add NUMA mempolicy support for KVM guest-memfd
Date: Mon, 11 Aug 2025 09:05:58 +0000
Message-ID: <20250811090605.16057-2-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|DM4PR12MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 970f4225-81a0-45ab-7eff-08ddd8b66be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y1tJRcR7xL/ZLOLjoz8L/8oxdTSX83N0QfI7rYpYQieNilHFQPRxXaIak3jb?=
 =?us-ascii?Q?eW658Y3kuERQtbk9MAmgbDede4LI17gSRq+qef+8KNWGzRGU3ELqg201aRNL?=
 =?us-ascii?Q?aNimS+881jDOzS19SizgeHs4IVQP+nakrRgBkZofCtdsHzZb09u/eVePY35E?=
 =?us-ascii?Q?HZxBUyzIRQDOnmLMGMe147ZBXKu6YPqa8t5z8Iw0DpmFXWl1fPOv7PCPIh9I?=
 =?us-ascii?Q?/Iml5UdvvhJi8neoHY9a/vNzfji6KLULaAJQeqUK9Ewj2oeLtSpCX40UgZ0/?=
 =?us-ascii?Q?xfB6u2HsZyX93ZQczW9pP0UpZF6B5j6+5koKlAWXTGaAb5ldvTKM+F/cjVuR?=
 =?us-ascii?Q?KmjGed0T3aFyq4THkt/ZHJkEA0k2MYKv6H527xJu01RhpQJq+h63mMSOt206?=
 =?us-ascii?Q?kxqHgTyQjMXSkCqKz2zI1SxHQjUP1m30f7p2bPJlQ+b8LddgQlzMK8383CeD?=
 =?us-ascii?Q?DKOwt+/HyQ246liMjflCKJZAx2nI7c3t7+HWZ4u8UKPRJgwMWgH9vNDwmbCl?=
 =?us-ascii?Q?R1pP73imu6Wy4H460m1z/o1FDdVafufMrM5UuITwtmrc3xKHgoI6xVK+5Fpw?=
 =?us-ascii?Q?t6CpZGHeHy49uu0ODWkMfbwvoJjlCoTJ5xK+0iXRv7kj/xPXZtZNEFlxeL/U?=
 =?us-ascii?Q?BmIr4TgLGq3C528EfDW7Kn+RKcUXdbj7oxnAyoulQtqYwDi+fdolBcqtcukF?=
 =?us-ascii?Q?c6OIZMxASysCT+KtL43dZnFUZ6lxeQ7OfHS19wz0kWZNqzHYmcaALaWbcnk4?=
 =?us-ascii?Q?1O1eR1eUKUfQDmjNKL2gMKsrvQ6sgkmvt+ZRzLXvm5QSiQ/Jx4SzIwPve402?=
 =?us-ascii?Q?63mXij4Z6HfdLayskP8lmxef5BFjemYDZLkIkGz4HuQHSn+2/jvUJUd9jACy?=
 =?us-ascii?Q?SA2qzrobXtWAKMq18xJdnRSigoJdPp6pdcwdZSFqEdykRTt8Jii41VbynT3c?=
 =?us-ascii?Q?d1Rqd1ozC4CGzeoiTjrJCVwHtWCMmu1zhvJRa4v8P3eEUET1dqgp+/j7prGW?=
 =?us-ascii?Q?cWUooDlCMZj/t55ksCEw+GQw9bT6fhZR85Tdf6J0es1yKcZert5kVTY0cdv3?=
 =?us-ascii?Q?sewR2WEe6xdjJbXhR/6RpfX54Lqcxlj+m23JFlq/j39Rso8ZXuOdg+yf/gO6?=
 =?us-ascii?Q?heHXPM5UycA+yiYZq6fXt1pUl68TfRi29UD4QSWInKlpkuB1hFuj/YzIhfxJ?=
 =?us-ascii?Q?KlJChMSS+Nwuy2+bkOvZ9+nrqdUt1Vm/ZGwAhNl56XaZIIKE7lGD344JYJzO?=
 =?us-ascii?Q?LE4rQHf3VN/5HMsGNvBGTQaWKJVaH35UiqdVRGM/gzzRQXovLZwda1ohx1oU?=
 =?us-ascii?Q?ytZ88wB2IlqNogtP2gJkwHGxDtTWuyo2zw6pVidRIk9Va2bt50fwptZA8k4e?=
 =?us-ascii?Q?GL/HlP1Xy3Cued+ayvFfsBVGRB2XP88n3opoRfq9QwzA3DfF1bcOMnFYKcR9?=
 =?us-ascii?Q?WDf3JExPHlRSwash90moYbMa8nU75naoOWOyW5P3QJH/05Y9VfMa4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 09:06:56.1951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 970f4225-81a0-45ab-7eff-08ddd8b66be6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6544

This series introduces NUMA-aware memory placement support for KVM guests
with guest_memfd memory backends. It builds upon Fuad Tabba's work (V17)
that enabled host-mapping for guest_memfd memory [1].

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
- V10: Rebase on top of Fuad's V17. Use latest guest_memfd inode patch
       from Ackerley (with David's review comments). Use newer kmem_cache_create()
       API variant with arg parameter (Vlastimil)

[1] https://lore.kernel.org/all/20250729225455.670324-1-seanjc@google.com
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
 .../testing/selftests/kvm/guest_memfd_test.c  | 121 ++++++++
 virt/kvm/guest_memfd.c                        | 260 ++++++++++++++++--
 virt/kvm/kvm_main.c                           |   7 +-
 virt/kvm/kvm_mm.h                             |   9 +-
 15 files changed, 410 insertions(+), 50 deletions(-)

-- 
2.43.0


