Return-Path: <linux-fsdevel+bounces-53744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9285AF662D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 01:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B3B1C44B72
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912D625523C;
	Wed,  2 Jul 2025 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W8O3WppP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E29238150;
	Wed,  2 Jul 2025 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751498755; cv=fail; b=fmO8iTLD38ah+dKy9X0Qo1E/IV9YAzyo0yClVwUk0dqlvO28npe4o8qfO2ALoQ3iVOpH0Q44QHPV2gjC0lnMdiQ4BwtvlIKeXusr27Y5glskKG08hrrBxSMd6ZbBxKS65kv7G1VkeCNrkbi041u5Xe11Fm1XDjywlvHDf2RWIkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751498755; c=relaxed/simple;
	bh=kuNog4izGm2BEszzscfXnpfhdoavRM4WNpazzS2guRc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F45ZT7qgDTIH5gtHLZEP/k7WIq3Ov+zUe0t77ZuN0xyErBdqvjdNurB9F6MEuIXNJK4uMd842jJK5NEzou0E5RWzHB2d4US3GgV4+3HD7AfHHgnT0kJaqu1NpJjf/LixWbb0+hWZVDPTRoUMuLJJ1e0fpEVviDPTuvIlrONsvcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W8O3WppP; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNhaCUz+WiFYto223ybYmFhwvWq+Njf+1u/dC8GHT3D/ldvUsH53204kAY4KfrZcZFs3JKnm4ee7NjjEJ4q/bQLvLj3HwH1h2W3y+HBrDQ8EWWbCTG9ja6RBYXR4ozCLd6S+mlkWepkif8k9obMDvkpEXcm8FHC0tX5DxdpvnpFtE8hGgdxhOurPEYnBmatE5ohCp18djiMNCuupaQHfYFk//Zv0VYILHaIPlJdv794RJyHWrWbjtfm2tGhIodfku0SAfszjJQprykQ8nZ3+DiBjbSQdF6+n26iyc+IxUxbdRXiIuCDZrndCzVNiq9QCts8C8iDXMAW1y/HVj8dNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAtjyM8gVbSdiygXD26WGjcyJ22E6N5cBMZAP+LGxcQ=;
 b=DKDeMOEqLAdvQ+wiOry9ubhD3/JXlWzU96uQVQ6KQkX2YJt3M/mP7xQCstpiRJJgg0qHsEwMp7z9Nlw3Cu5rkgKk+rJRBBaGd7e9ECdCm4BP9KSXKbcikkknIZZh8rsIr0/Lc4h2MZfyHJ3OjehFZ+BdK4ht45TNzSvYN5HZhpXnGcxUSdGbBJIlLh1W3l6qtaCMbkAEZQCl8cXInW67nrjPjJ2SS8U95ys8xsR308yrCgfUAMwF5bJ5EkGcrhI8wX4Ti+GKiV+imztW4KeJbqyPvXNq3ybXRA8Dp1wB1qM9nLJuROu2Df+zryUkkeab9YRQpu/QBalGKo//livhHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAtjyM8gVbSdiygXD26WGjcyJ22E6N5cBMZAP+LGxcQ=;
 b=W8O3WppPzOguAiVc8BUY+yJ5xiZYM43djLZgFKgvgmaSivUhGjIS2E+ybE4lWYRmWVPpLuv1d9LQhFnTGgFfvNb0LrwiiG+hldrqMYImkjN6iwjIWIyXrkIkqDzpHsXfFwCqNu2bF46QiJZb29rJ1A/1USuiwi+W8BjTyA5ka/M=
Received: from BYAPR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:40::16)
 by SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 23:25:44 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::27) by BYAPR04CA0003.outlook.office365.com
 (2603:10b6:a03:40::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 23:25:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 23:25:44 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 18:25:39 -0500
Date: Wed, 2 Jul 2025 18:25:17 -0500
From: Michael Roth <michael.roth@amd.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <aik@amd.com>, <ajones@ventanamicro.com>,
	<akpm@linux-foundation.org>, <amoorthy@google.com>,
	<anthony.yznaga@oracle.com>, <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
	<bfoster@redhat.com>, <binbin.wu@linux.intel.com>, <brauner@kernel.org>,
	<catalin.marinas@arm.com>, <chao.p.peng@intel.com>, <chenhuacai@kernel.org>,
	<dave.hansen@intel.com>, <david@redhat.com>, <dmatlack@google.com>,
	<dwmw@amazon.co.uk>, <erdemaktas@google.com>, <fan.du@intel.com>,
	<fvdl@google.com>, <graf@amazon.com>, <haibo1.xu@intel.com>,
	<hch@infradead.org>, <hughd@google.com>, <ira.weiny@intel.com>,
	<isaku.yamahata@intel.com>, <jack@suse.cz>, <james.morse@arm.com>,
	<jarkko@kernel.org>, <jgg@ziepe.ca>, <jgowans@amazon.com>,
	<jhubbard@nvidia.com>, <jroedel@suse.de>, <jthoughton@google.com>,
	<jun.miao@intel.com>, <kai.huang@intel.com>, <keirf@google.com>,
	<kent.overstreet@linux.dev>, <kirill.shutemov@intel.com>,
	<liam.merwick@oracle.com>, <maciej.wieczor-retman@intel.com>,
	<mail@maciej.szmigiero.name>, <maz@kernel.org>, <mic@digikod.net>,
	<mpe@ellerman.id.au>, <muchun.song@linux.dev>, <nikunj@amd.com>,
	<nsaenz@amazon.es>, <oliver.upton@linux.dev>, <palmer@dabbelt.com>,
	<pankaj.gupta@amd.com>, <paul.walmsley@sifive.com>, <pbonzini@redhat.com>,
	<pdurrant@amazon.co.uk>, <peterx@redhat.com>, <pgonda@google.com>,
	<pvorel@suse.cz>, <qperret@google.com>, <quic_cvanscha@quicinc.com>,
	<quic_eberman@quicinc.com>, <quic_mnalajal@quicinc.com>,
	<quic_pderrin@quicinc.com>, <quic_pheragu@quicinc.com>,
	<quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
	<richard.weiyang@gmail.com>, <rick.p.edgecombe@intel.com>,
	<rientjes@google.com>, <roypat@amazon.co.uk>, <rppt@kernel.org>,
	<seanjc@google.com>, <shuah@kernel.org>, <steven.price@arm.com>,
	<steven.sistare@oracle.com>, <suzuki.poulose@arm.com>, <tabba@google.com>,
	<thomas.lendacky@amd.com>, <usama.arif@bytedance.com>,
	<vannapurve@google.com>, <vbabka@suse.cz>, <viro@zeniv.linux.org.uk>,
	<vkuznets@redhat.com>, <wei.w.wang@intel.com>, <will@kernel.org>,
	<willy@infradead.org>, <xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>,
	<yilun.xu@intel.com>, <yuzenghui@huawei.com>, <zhiquan1.li@intel.com>
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
Message-ID: <20250702232517.k2nqwggxfpfp3yym@amd.com>
References: <20250529054227.hh2f4jmyqf6igd3i@amd.com>
 <diqz1prqvted.fsf@ackerleytng-ctop.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <diqz1prqvted.fsf@ackerleytng-ctop.c.googlers.com>
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: 431b833f-2416-4f9c-0110-08ddb9bfc489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d8B9kr5TEw+YhOHMlgfusJFNQQPvAn5233IvNKbJvxROu6oBywqtIhidFdKV?=
 =?us-ascii?Q?UZyt0RL3hCEY1iQjgkn7Xzb0fupnsXeT1EWPQDgiBZstaBdFKf3ZMSBt8Qbd?=
 =?us-ascii?Q?gmydeEb5GvEeGVlKsfsM2O43/EMNw83V9QHKLyqxdJiDN4wVIbRlMpbiUxKm?=
 =?us-ascii?Q?tjvDw8a2B4OADmjFZCBjiI/5CRENItHa5pQ9ldgjYq1W74a4ifMidYRNi00J?=
 =?us-ascii?Q?HghlHS8irj3B/G7PAc2RjXEFXteUzG4yQNwC8ep/eu7ep9gDJ3dgRjoXoABK?=
 =?us-ascii?Q?vsv9ii3a6fP6alKuCQ5NAKn6iH5nNOIFEkhSrRN9OcvMOVEuRI6z7lUxhGV5?=
 =?us-ascii?Q?Wy9JFwM3XLbgdnP05IMCwEoRdSIV50a6kaYn7abOe7UDKX462CKqJ3qVC5Mn?=
 =?us-ascii?Q?QIsecpdeaAWG0FszrFZvN5Zf0RrGlmNmV/DtCfElf6prh8Cwyt7EVjCAaR8/?=
 =?us-ascii?Q?44GLMB3ORGbibwYtohoFNeTOiBJxcDX9f2k+WXjg9TmnQXACPbQwixe4gqAD?=
 =?us-ascii?Q?aNj9sJ1k+dPdRy0n+O3pONpDtfwckM0kK87Mq3USlEG2p673iThnl2tV06vE?=
 =?us-ascii?Q?3kPFUrhYRZKWbRBX5u1aj7NTs3MFir76ycM4+X26gz9UDQePPMxTOxp/zqyW?=
 =?us-ascii?Q?tfHDhthycv+NZCFTfZv9YNcxtM1SC8yV6oKqVoczD886ZavCNvGGNu5qF1zs?=
 =?us-ascii?Q?Nsd5PxiWjomQbIw2DLKNkZ5r4ybTLxudVEPp5RxjljzdzcpgPbuulBJsWhbX?=
 =?us-ascii?Q?4VCJwjZ/sWAl/ZmXY7uv8CxDTvxQtirjsPumXAKO4aMr8l02dypRKte/a9fG?=
 =?us-ascii?Q?6B23y4jJ1fG97OVfluOcOQQGpyCFCNzusEWXGgtmtczKbIJfjmpw8w96T3Ae?=
 =?us-ascii?Q?Tawgqw58minajAjF6DRBYTTbiRS4ybjNsmIr74RwrsuaDtG7+RS+lRA/lH8d?=
 =?us-ascii?Q?Q9DBI8b23PPVBx7jh6O4uzvKPf78kjZRGB1EGATng2oFtEbPSJC8aPkaziJ1?=
 =?us-ascii?Q?/JqXjMGgo+5HzpHcol7Uv7MQ6N+d+czImokVSCiGvsxdERDdVnMX8x8xUX+v?=
 =?us-ascii?Q?CsDlF5geqPoVHwRwSCumO84kTMzTsmhHt5/iTuuJKofGpj2itDhuM7BGUT5u?=
 =?us-ascii?Q?py81zDvx9Yxt0j8Xt1Is/DvbBm/YrPx/hktds37AN12kzQhKGduNYZnKd4+V?=
 =?us-ascii?Q?sxd0ObXifh5ewTUhHdq51yfL8I3U3sQWM9BSDi1mjN6P7ncxlCm2skfyUzgM?=
 =?us-ascii?Q?kaOd3LP+vvnlvaDgp/u/1Lg6dXGzdcj1lryfDpskmFhBpwJrbLvrMW4e/Aia?=
 =?us-ascii?Q?Rwvu2lMAOVzbZ193zquuALRCwXhXg0t8/d0ENI4FsO4VQ4ayKk5/Sp+7Ap2h?=
 =?us-ascii?Q?vPwOXcIO+JNs+qAcbWtW3F0EU1/8nPxKLQC+6cnJUG4pP/pno5657Mv5tnTr?=
 =?us-ascii?Q?lvFWN46Tf8nRFFIwlVkzADtfzqWFdiCPbNmBhEB+2OUkHCxPagotBfJJaMWs?=
 =?us-ascii?Q?2nR7bAHUwedzC6nISE+Ezm1KdXsBiCmFra57aEjEXp4VyXMQ33xZ3caJHw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 23:25:44.2341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 431b833f-2416-4f9c-0110-08ddb9bfc489
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9471

On Wed, Jun 11, 2025 at 02:51:38PM -0700, Ackerley Tng wrote:
> Michael Roth <michael.roth@amd.com> writes:
> 
> > On Wed, May 14, 2025 at 04:41:41PM -0700, Ackerley Tng wrote:
> >> Track guest_memfd memory's shareability status within the inode as
> >> opposed to the file, since it is property of the guest_memfd's memory
> >> contents.
> >> 
> >> Shareability is a property of the memory and is indexed using the
> >> page's index in the inode. Because shareability is the memory's
> >> property, it is stored within guest_memfd instead of within KVM, like
> >> in kvm->mem_attr_array.
> >> 
> >> KVM_MEMORY_ATTRIBUTE_PRIVATE in kvm->mem_attr_array must still be
> >> retained to allow VMs to only use guest_memfd for private memory and
> >> some other memory for shared memory.
> >> 
> >> Not all use cases require guest_memfd() to be shared with the host
> >> when first created. Add a new flag, GUEST_MEMFD_FLAG_INIT_PRIVATE,
> >> which when set on KVM_CREATE_GUEST_MEMFD, initializes the memory as
> >> private to the guest, and therefore not mappable by the
> >> host. Otherwise, memory is shared until explicitly converted to
> >> private.
> >> 
> >> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> >> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> >> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> >> Co-developed-by: Fuad Tabba <tabba@google.com>
> >> Signed-off-by: Fuad Tabba <tabba@google.com>
> >> Change-Id: If03609cbab3ad1564685c85bdba6dcbb6b240c0f
> >> ---
> >>  Documentation/virt/kvm/api.rst |   5 ++
> >>  include/uapi/linux/kvm.h       |   2 +
> >>  virt/kvm/guest_memfd.c         | 124 ++++++++++++++++++++++++++++++++-
> >>  3 files changed, 129 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> >> index 86f74ce7f12a..f609337ae1c2 100644
> >> --- a/Documentation/virt/kvm/api.rst
> >> +++ b/Documentation/virt/kvm/api.rst
> >> @@ -6408,6 +6408,11 @@ belonging to the slot via its userspace_addr.
> >>  The use of GUEST_MEMFD_FLAG_SUPPORT_SHARED will not be allowed for CoCo VMs.
> >>  This is validated when the guest_memfd instance is bound to the VM.
> >>  
> >> +If the capability KVM_CAP_GMEM_CONVERSIONS is supported, then the 'flags' field
> >> +supports GUEST_MEMFD_FLAG_INIT_PRIVATE.  Setting GUEST_MEMFD_FLAG_INIT_PRIVATE
> >> +will initialize the memory for the guest_memfd as guest-only and not faultable
> >> +by the host.
> >> +
> >
> > KVM_CAP_GMEM_CONVERSION doesn't get introduced until later, so it seems
> > like this flag should be deferred until that patch is in place. Is it
> > really needed at that point though? Userspace would be able to set the
> > initial state via KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls.
> >
> 
> I can move this change to the later patch. Thanks! Will fix in the next
> revision.
> 
> > The mtree contents seems to get stored in the same manner in either case so
> > performance-wise only the overhead of a few userspace<->kernel switches
> > would be saved. Are there any other reasons?
> >
> > Otherwise, maybe just settle on SHARED as a documented default (since at
> > least non-CoCo VMs would be able to reliably benefit) and let
> > CoCo/GUEST_MEMFD_FLAG_SUPPORT_SHARED VMs set PRIVATE at whatever
> > granularity makes sense for the architecture/guest configuration.
> >
> 
> Because shared pages are split once any memory is allocated, having a
> way to INIT_PRIVATE could avoid the split and then merge on
> conversion. I feel that is enough value to have this config flag, what
> do you think?
> 
> I guess we could also have userspace be careful not to do any allocation
> before converting.

I assume we do want to support things like preallocating guest memory so
not sure this approach is feasible to avoid splits.

But I feel like we might be working around a deeper issue here, which is
that we are pre-emptively splitting anything that *could* be mapped into
userspace (i.e. allocated+shared/mixed), rather than splitting when
necessary.

I know that was the plan laid out in the guest_memfd calls, but I've run
into a couple instances that have me thinking we should revisit this.

1) Some of the recent guest_memfd seems to be gravitating towards having
   userspace populate/initialize guest memory payload prior to boot via
   mmap()'ing the shared guest_memfd pages so things work the same as
   they would for initialized normal VM memory payload (rather than
   relying on back-channels in the kernel to user data into guest_memfd
   pages).

   When you do this though, for an SNP guest at least, that memory
   acceptance is done in chunks of 4MB (with accept_memory=lazy), and
   because that will put each 1GB page into an allocated+mixed state,
   we end up splitting every 1GB to 4K and the guest can't even
   accept/PVALIDATE it 2MB at that point even if userspace doesn't touch
   anything in the range. As some point the guest will convert/accept
   the entire range, at which point we could merge, but for SNP we'd
   need guest cooperation to actually use a higher-granularity in stage2
   page tables at that point since RMP entries are effectively all split
   to 4K.

   I understand the intent is to default to private where this wouldn't
   be an issue, and we could punt to userspace to deal with it, but it
   feels like an artificial restriction to place on userspace. And if we
   do want to allow/expect guest_memfd contents to be initialized pre-boot
   just like normal memory, then userspace would need to jump through
   some hoops:

   - if defaulting to private: add hooks to convert each range that's being
     modified to a shared state prior to writing to it
   - if defaulting to shared: initialize memory in-place, then covert
     everything else to private to avoid unecessarily splitting folios
     at run-time

   It feels like implementations details are bleeding out into the API
   to some degree here (e.g. we'd probably at least need to document
   this so users know how to take proper advantage of hugepage support).

2) There are some use-cases for HugeTLB + CoCo that have come to my
   attention recently that put a lot of weight on still being able to
   maximize mapping/hugepage size when accessing shared mem from userspace,
   e.g. for certain DPDK workloads that accessed shared guest buffers
   from host userspace. We don't really have a story for this, and I
   wouldn't expect us to at this stage, but I think it ties into #1 so
   might be worth considering in that context.

I'm still fine with the current approach as a starting point, but I'm
wondering if improving both #1/#2 might not be so bad and maybe even
give us some more flexibility (for instance, Sean had mentioned leaving
open the option of tracking more than just shareability/mappability, and
if there is split/merge logic associated with those transitions then
re-scanning each of these attributes for a 1G range seems like it could
benefit from some sort of intermediate data structure to help determine
things like what mapping granularity is available for guest/userspace
for a particular range.

One approach I was thinking of was that we introduce a data structure
similar to KVM's memslot->arch.lpage_info() where we store information
about what 1G/2M ranges are shared/private/mixed, and then instead of
splitting ahead of time we just record that state into this data
structure (using the same write lock as with the
shareability/mappability state), and then at *fault* time we split the
folio if our lpage_info-like data structure says the range is mixed.

Then, if guest converts a 2M/4M range to private while lazilly-accepting
(for instance), we can still keep the folio intact as 1GB, but mark
the 1G range in the lpage_info-like data structure as mixed so that we
still inform KVM/etc. they need to map it as 2MB or lower in stage2
page tables. In that case, even at guest fault-time, we can leave the
folio unsplit until userspace tries to touch it (though in most cases
it never will and we can keep most of the guest's 1G intact for the
duration of its lifetime).

On the userspace side, another nice thing there is if we see 1G is in a
mixed state, but 2M is all-shared, then we can still leave the folio as 2M,
and I think the refcount'ing logic would still work for the most part,
which makes #2 a bit easier to implement as well.

And of course, we wouldn't need the INIT_PRIVATE then since we are only
splitting when necessary.

But I guess this all comes down to how much extra pain there is in
tracking a 1G folio that's been split into a mixed of 2MB/4K regions,
but I think we'd get a lot more mileage out of getting that working and
just completely stripping out all of the merging logic for initial
implementation (other than at cleanup time), so maybe complexity-wise
it balances out a bit?

Thanks,

Mike

> 
> >>  See KVM_SET_USER_MEMORY_REGION2 for additional details.
> >>  
> >>  4.143 KVM_PRE_FAULT_MEMORY
> >> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> >> index 4cc824a3a7c9..d7df312479aa 100644
> >> --- a/include/uapi/linux/kvm.h
> >> +++ b/include/uapi/linux/kvm.h
> >> @@ -1567,7 +1567,9 @@ struct kvm_memory_attributes {
> >>  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> >>  
> >>  #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
> >> +
> >>  #define GUEST_MEMFD_FLAG_SUPPORT_SHARED	(1UL << 0)
> >> +#define GUEST_MEMFD_FLAG_INIT_PRIVATE	(1UL << 1)
> >>  
> >>  struct kvm_create_guest_memfd {
> >>  	__u64 size;
> >> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> >> index 239d0f13dcc1..590932499eba 100644
> >> --- a/virt/kvm/guest_memfd.c
> >> +++ b/virt/kvm/guest_memfd.c
> >> @@ -4,6 +4,7 @@
> >>  #include <linux/falloc.h>
> >>  #include <linux/fs.h>
> >>  #include <linux/kvm_host.h>
> >> +#include <linux/maple_tree.h>
> >>  #include <linux/pseudo_fs.h>
> >>  #include <linux/pagemap.h>
> >>  
> >> @@ -17,6 +18,24 @@ struct kvm_gmem {
> >>  	struct list_head entry;
> >>  };
> >>  
> >> +struct kvm_gmem_inode_private {
> >> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> >> +	struct maple_tree shareability;
> >> +#endif
> >> +};
> >> +
> >> +enum shareability {
> >> +	SHAREABILITY_GUEST = 1,	/* Only the guest can map (fault) folios in this range. */
> >> +	SHAREABILITY_ALL = 2,	/* Both guest and host can fault folios in this range. */
> >> +};
> >> +
> >> +static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index);
> >> +
> >> +static struct kvm_gmem_inode_private *kvm_gmem_private(struct inode *inode)
> >> +{
> >> +	return inode->i_mapping->i_private_data;
> >> +}
> >> +
> >>  /**
> >>   * folio_file_pfn - like folio_file_page, but return a pfn.
> >>   * @folio: The folio which contains this index.
> >> @@ -29,6 +48,58 @@ static inline kvm_pfn_t folio_file_pfn(struct folio *folio, pgoff_t index)
> >>  	return folio_pfn(folio) + (index & (folio_nr_pages(folio) - 1));
> >>  }
> >>  
> >> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> >> +
> >> +static int kvm_gmem_shareability_setup(struct kvm_gmem_inode_private *private,
> >> +				      loff_t size, u64 flags)
> >> +{
> >> +	enum shareability m;
> >> +	pgoff_t last;
> >> +
> >> +	last = (size >> PAGE_SHIFT) - 1;
> >> +	m = flags & GUEST_MEMFD_FLAG_INIT_PRIVATE ? SHAREABILITY_GUEST :
> >> +						    SHAREABILITY_ALL;
> >> +	return mtree_store_range(&private->shareability, 0, last, xa_mk_value(m),
> >> +				 GFP_KERNEL);
> >
> > One really nice thing about using a maple tree is that it should get rid
> > of a fairly significant startup delay for SNP/TDX when the entire xarray gets
> > initialized with private attribute entries via KVM_SET_MEMORY_ATTRIBUTES
> > (which is the current QEMU default behavior).
> >
> > I'd originally advocated for sticking with the xarray implementation Fuad was
> > using until we'd determined we really need it for HugeTLB support, but I'm
> > sort of thinking it's already justified just based on the above.
> >
> > Maybe it would make sense for KVM memory attributes too?
> >
> >> +}
> >> +
> >> +static enum shareability kvm_gmem_shareability_get(struct inode *inode,
> >> +						 pgoff_t index)
> >> +{
> >> +	struct maple_tree *mt;
> >> +	void *entry;
> >> +
> >> +	mt = &kvm_gmem_private(inode)->shareability;
> >> +	entry = mtree_load(mt, index);
> >> +	WARN(!entry,
> >> +	     "Shareability should always be defined for all indices in inode.");
> >> +
> >> +	return xa_to_value(entry);
> >> +}
> >> +
> >> +static struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t index)
> >> +{
> >> +	if (kvm_gmem_shareability_get(inode, index) != SHAREABILITY_ALL)
> >> +		return ERR_PTR(-EACCES);
> >> +
> >> +	return kvm_gmem_get_folio(inode, index);
> >> +}
> >> +
> >> +#else
> >> +
> >> +static int kvm_gmem_shareability_setup(struct maple_tree *mt, loff_t size, u64 flags)
> >> +{
> >> +	return 0;
> >> +}
> >> +
> >> +static inline struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t index)
> >> +{
> >> +	WARN_ONCE("Unexpected call to get shared folio.")
> >> +	return NULL;
> >> +}
> >> +
> >> +#endif /* CONFIG_KVM_GMEM_SHARED_MEM */
> >> +
> >>  static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
> >>  				    pgoff_t index, struct folio *folio)
> >>  {
> >> @@ -333,7 +404,7 @@ static vm_fault_t kvm_gmem_fault_shared(struct vm_fault *vmf)
> >>  
> >>  	filemap_invalidate_lock_shared(inode->i_mapping);
> >>  
> >> -	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
> >> +	folio = kvm_gmem_get_shared_folio(inode, vmf->pgoff);
> >>  	if (IS_ERR(folio)) {
> >>  		int err = PTR_ERR(folio);
> >>  
> >> @@ -420,8 +491,33 @@ static struct file_operations kvm_gmem_fops = {
> >>  	.fallocate	= kvm_gmem_fallocate,
> >>  };
> >>  
> >> +static void kvm_gmem_free_inode(struct inode *inode)
> >> +{
> >> +	struct kvm_gmem_inode_private *private = kvm_gmem_private(inode);
> >> +
> >> +	kfree(private);
> >> +
> >> +	free_inode_nonrcu(inode);
> >> +}
> >> +
> >> +static void kvm_gmem_destroy_inode(struct inode *inode)
> >> +{
> >> +	struct kvm_gmem_inode_private *private = kvm_gmem_private(inode);
> >> +
> >> +#ifdef CONFIG_KVM_GMEM_SHARED_MEM
> >> +	/*
> >> +	 * mtree_destroy() can't be used within rcu callback, hence can't be
> >> +	 * done in ->free_inode().
> >> +	 */
> >> +	if (private)
> >> +		mtree_destroy(&private->shareability);
> >> +#endif
> >> +}
> >> +
> >>  static const struct super_operations kvm_gmem_super_operations = {
> >>  	.statfs		= simple_statfs,
> >> +	.destroy_inode	= kvm_gmem_destroy_inode,
> >> +	.free_inode	= kvm_gmem_free_inode,
> >>  };
> >>  
> >>  static int kvm_gmem_init_fs_context(struct fs_context *fc)
> >> @@ -549,12 +645,26 @@ static const struct inode_operations kvm_gmem_iops = {
> >>  static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
> >>  						      loff_t size, u64 flags)
> >>  {
> >> +	struct kvm_gmem_inode_private *private;
> >>  	struct inode *inode;
> >> +	int err;
> >>  
> >>  	inode = alloc_anon_secure_inode(kvm_gmem_mnt->mnt_sb, name);
> >>  	if (IS_ERR(inode))
> >>  		return inode;
> >>  
> >> +	err = -ENOMEM;
> >> +	private = kzalloc(sizeof(*private), GFP_KERNEL);
> >> +	if (!private)
> >> +		goto out;
> >> +
> >> +	mt_init(&private->shareability);
> >> +	inode->i_mapping->i_private_data = private;
> >> +
> >> +	err = kvm_gmem_shareability_setup(private, size, flags);
> >> +	if (err)
> >> +		goto out;
> >> +
> >>  	inode->i_private = (void *)(unsigned long)flags;
> >>  	inode->i_op = &kvm_gmem_iops;
> >>  	inode->i_mapping->a_ops = &kvm_gmem_aops;
> >> @@ -566,6 +676,11 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
> >>  	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> >>  
> >>  	return inode;
> >> +
> >> +out:
> >> +	iput(inode);
> >> +
> >> +	return ERR_PTR(err);
> >>  }
> >>  
> >>  static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
> >> @@ -654,6 +769,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
> >>  	if (kvm_arch_vm_supports_gmem_shared_mem(kvm))
> >>  		valid_flags |= GUEST_MEMFD_FLAG_SUPPORT_SHARED;
> >>  
> >> +	if (flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED)
> >> +		valid_flags |= GUEST_MEMFD_FLAG_INIT_PRIVATE;
> >> +
> >>  	if (flags & ~valid_flags)
> >>  		return -EINVAL;
> >>  
> >> @@ -842,6 +960,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> >>  	if (!file)
> >>  		return -EFAULT;
> >>  
> >> +	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
> >> +
> >
> > I like the idea of using a write-lock/read-lock to protect write/read access
> > to shareability state (though maybe not necessarily re-using filemap's
> > invalidate lock), it's simple and still allows concurrent faulting in of gmem
> > pages. One issue on the SNP side (which also came up in one of the gmem calls)
> > is if we introduce support for tracking preparedness as discussed (e.g. via a
> > new SHAREABILITY_GUEST_PREPARED state) the
> > SHAREABILITY_GUEST->SHAREABILITY_GUEST_PREPARED transition would occur at
> > fault-time, and so would need to take the write-lock and no longer allow for
> > concurrent fault-handling.
> >
> > I was originally planning on introducing a new rw_semaphore with similar
> > semantics to the rw_lock that Fuad previously had in his restricted mmap
> > series[1] (and simiar semantics to filemap invalidate lock here). The main
> > difference, to handle setting SHAREABILITY_GUEST_PREPARED within fault paths,
> > was that in the case of a folio being present for an index, the folio lock would
> > also need to be held in order to update the shareability state. Because
> > of that, fault paths (which will always either have or allocate folio
> > basically) can rely on the folio lock to guard shareability state in a more
> > granular way and so can avoid a global write lock.
> >
> > They would still need to hold the read lock to access the tree however.
> > Or more specifically, any paths that could allocate a folio need to take
> > a read lock so there isn't a TOCTOU situation where shareability is
> > being updated for an index for which a folio hasn't been allocated, but
> > then just afterward the folio gets faulted in/allocated while the
> > shareability state is already being updated which the understand that
> > there was no folio around that needed locking.
> >
> > I had a branch with in-place conversion support for SNP[2] that added this
> > lock reworking on top of Fuad's series along with preparation tracking,
> > but I'm now planning to rebase that on top of the patches from this
> > series that Sean mentioned[3] earlier:
> >
> >   KVM: guest_memfd: Add CAP KVM_CAP_GMEM_CONVERSION
> >   KVM: Query guest_memfd for private/shared status
> >   KVM: guest_memfd: Skip LRU for guest_memfd folios
> >   KVM: guest_memfd: Introduce KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
> >   KVM: guest_memfd: Introduce and use shareability to guard faulting
> >   KVM: guest_memfd: Make guest mem use guest mem inodes instead of anonymous inodes
> >
> > but figured I'd mention it here in case there are other things to consider on
> > the locking front.
> >
> > Definitely agree with Sean though that it would be nice to start identifying a
> > common base of patches for the in-place conversion enablement for SNP, TDX, and
> > pKVM so the APIs/interfaces for hugepages can be handled separately.
> >
> > -Mike
> >
> > [1] https://lore.kernel.org/kvm/20250328153133.3504118-1-tabba@google.com/
> > [2] https://github.com/mdroth/linux/commits/mmap-swprot-v10-snp0-wip2/
> > [3] https://lore.kernel.org/kvm/aC86OsU2HSFZkJP6@google.com/
> >
> >>  	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, &is_prepared, max_order);
> >>  	if (IS_ERR(folio)) {
> >>  		r = PTR_ERR(folio);
> >> @@ -857,8 +977,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> >>  		*page = folio_file_page(folio, index);
> >>  	else
> >>  		folio_put(folio);
> >> -
> >>  out:
> >> +	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
> >>  	fput(file);
> >>  	return r;
> >>  }
> >> -- 
> >> 2.49.0.1045.g170613ef41-goog
> >> 
> 

