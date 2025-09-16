Return-Path: <linux-fsdevel+bounces-61835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C442B7EEC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6D81BC8071
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 22:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61112E3B11;
	Tue, 16 Sep 2025 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K01nSe04"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013055.outbound.protection.outlook.com [40.93.196.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908CB2C3244;
	Tue, 16 Sep 2025 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758063146; cv=fail; b=XVTfG/RiivfE6s3U3y+omdsV0Me3te6BlUSyNUrw8IKjU92rclXfzl+SbVF53dMr71ffvmdoqc0GcUi+xHUQdiMYtdnrOKhlO9L/QGQA1uZMEgRp8gu6YHvZN3BSUKofxg1betD9DkpKzlfyVODnOvp5PcHkS6B+HnIh9rqw950=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758063146; c=relaxed/simple;
	bh=kvC/JWjuNwx42U2kWzwyu7k1O6Wdtc6HTeqAaz0Wa4M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hi2fdDQ0KayAr9R9dr0URKKXGTDHdL5o9JSM8wM89/zPAcaReWm6LlD0usXeYJZlydEscPnrzFPy9LouSKSInBqgV8k70wDWe3iIA4zGOYeyOeP2bnaXCwvHVN6rGJWceORX8D/erdX9eGBW5x58wWdoF/2LpVjOUR/3TAWGddg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K01nSe04; arc=fail smtp.client-ip=40.93.196.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5nHjUSwPwCKiEi9LWnkwWxF1Ee6xqK2twxCOYiu/lbL9EyENGApS9Q/cJXKCbYrgC3qaP0E9uuDkY8Y2fWDlafb1Y6giICSKZU66BbwqHUBc01/s3n5vL1labNchBRGX3FYySW0Lb6jcD/RnrKs+NTaDt6nQFNzVp2SSQX4plXAbdUavsjK56GDfsopPR7AlQ+U3FkheVyhvvDq2jAikB6olwWR+aRT/O/MA0Cs9/NkEc0WBmcEGlR4DxUtZJ1dZCS6uOlVbMz2SdICGFUFcYVwmi7ThKQ2+yDjmCTFagJO0h4aWW2WqsLrGww6+aiJDeNqImUu1mE2oHNGPH90UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMtO28GYSz5vMZAhs62tYpH0NATG+6M/yKPKZk3d3+0=;
 b=DvrG8nXVwvQ3uHsYtIt4nz1ySec4a7sdTZywaEyftvCEDVU+bImL1TVfZ/FOtj+dcBuJA4eVQK1ph6TocdA45abalbU6ccgmMAgbPEbZNkvAohIQwqmtGDlbC1YgS8cTywx6U4bvanzk7D8Bg53WudyF1qqIgjgRu4CDpSK5GykWvhZ4iPP+kPPZ/vAZ2nW2pwQezxNM5joIS30Ibjpv+ZmySktEjAyn0f8COX3SIwYbZIQPODkrBnoHmiwSvw5ujgdejpNiHeXJs2bUO1TLKfJrYT5WrrK1VZQGkcygwKXf/q0rBLM7Lzz1qyBlveAwUr+qfk1oijS6WWGcjXJm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMtO28GYSz5vMZAhs62tYpH0NATG+6M/yKPKZk3d3+0=;
 b=K01nSe040vcCAvVd4dASJQMGbps175U2UPmxBGfd1Ugqrd14TOh01BFaueCNEDmygq0MPnV3FCnHzUOytoFzrS0GLl0ILJa2q0TFSffgWkA8UcPcn8uV6vvEVqVuWrI3Z/5tu5yxeKIKhLoxHrJaEiy5xbDDPWbDjA5cKSFg5GE=
Received: from SJ0PR03CA0169.namprd03.prod.outlook.com (2603:10b6:a03:338::24)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 22:52:18 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::e6) by SJ0PR03CA0169.outlook.office365.com
 (2603:10b6:a03:338::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 22:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 22:52:18 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 15:52:09 -0700
Date: Tue, 16 Sep 2025 17:41:33 -0500
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
Subject: Re: [RFC PATCH v2 29/51] mm: guestmem_hugetlb: Wrap HugeTLB as an
 allocator for guest_memfd
Message-ID: <20250916224133.ysuqlboywxyybsbl@amd.com>
References: <diqzzffcfy3k.fsf@ackerleytng-ctop.c.googlers.com>
 <diqzecwofg7w.fsf@ackerleytng-ctop.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <diqzecwofg7w.fsf@ackerleytng-ctop.c.googlers.com>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f69efc8-502b-4ad5-f7eb-08ddf573b076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ec2oaiBz5Ek+1wiO411ZHT0yLQ7l39bRz1RJulXqMWk/M++okY5tHtgaQwKM?=
 =?us-ascii?Q?0WWf/6ybfgd+gNy6PRQ1yfgBs2isXY5oyHCZxAi08wREVd+D5R+TdlkeACTn?=
 =?us-ascii?Q?q3l7bNAO+GmEGov6QDdnEkUYMFZHvS5X2lacdSb8Bg7VRj2Ia9xpNgzWx4lX?=
 =?us-ascii?Q?X/TAYP92I6eh/6FfgHn56CFawFxSf9IjEiVZkGv5Fw69gY9JwByJ4uLrzobF?=
 =?us-ascii?Q?Kw3dR6oqm5/1VqEosnk/hi3axKKXgqbc8JIqevVvZkJamEZzEywUIRm6/bvs?=
 =?us-ascii?Q?nT41If+qSaI6I3ty8E/d1eSGbzfYOTYAXPxFWzv97Qt2t+wBVBC2gz3Irazx?=
 =?us-ascii?Q?+V3SSL03kGk8/QZW9yEsSAmg8E7zMnT95Gp9lwsNpWwHL/h7mZ2jW/LkP0y/?=
 =?us-ascii?Q?pQ3w+YpdTuwcEbcFBe4UxAeQdWzmUhSIww1ixaYZfWAmcKwQN0bQ/R84PIC8?=
 =?us-ascii?Q?Hvd7qgOQuxRq6XK1nQhgpfIDwp+1c7xqtobZUjXRQAxMJv9otKqs0akgKtCT?=
 =?us-ascii?Q?30M9/slahoIxqvFviU2BUJ0QXo/teD2dJAJ6ZDiT7AXSSgc90klSoTpHHQ/i?=
 =?us-ascii?Q?NqXloS9xtC6I2mXYNN6AMCK3ycucGmB7UdvxXNzZpZ+C611d5Db5kr1AnS1P?=
 =?us-ascii?Q?FBQtaJbmxD8anD9VIvZ/vBizvjTWDBT+wwkXqVVWDjCO3ZA3VeAKPgmIhRD8?=
 =?us-ascii?Q?W2oBpDHpO7EMD5OsdKFjXb99HVuNnYQKoArg+Nirk/RYAXnzqMtIBjvvD3FO?=
 =?us-ascii?Q?d7a852xZt897WhhFnfcUq7mk/VnR+1xy/B0sihjm/sn14IOsq5ESPnagjg9K?=
 =?us-ascii?Q?PWhqp9KoT16RlyA84OO6iU02N2TpXFG9wDmSwdRIMvL1ztuCWibDZaN1NI6f?=
 =?us-ascii?Q?y2LSbhvhTLnBJB5OSOATk+vFc4xa6QFTq4QVjEydRY6v37Ay4Rbl/wJ8/wOY?=
 =?us-ascii?Q?O1mF8irywQhCoy9b2FfumEWdRZFvPL5/Q+fQU+kl9GksOlmcr6B28Rh8g811?=
 =?us-ascii?Q?ODqy9xEOP4BJFSFTPVoVXme//vIr58dRSDms0DLhgttpq/37Q0kak4Fr9NY5?=
 =?us-ascii?Q?Kv89/BRP5eW0zXG9eKeSgc0AeAT/h6CTQmZwKGVjfE0EH3C385xe+B3tKTxP?=
 =?us-ascii?Q?DXoyIHs0SDEagkarFiMUuxeXEHfGcjK3ExYokgKgyKpe/98Bw/PR2uVxfZuZ?=
 =?us-ascii?Q?VMO7cfyvahKnwpTB6l0xJmfsAyoFUCwa1APkhT9xhvXNRmFsLrJKFABNbeOq?=
 =?us-ascii?Q?kviYYkhBiGoUXFfKhCqAIsRQFcYghMSCwua0IKLe9MbZRwpNA82HOjn0fToL?=
 =?us-ascii?Q?JoEfjBC0VPRdl1Q/xdPxnoTIn41QrMHsCF/m8HlR062UN43hLPNYNUQ3sxp2?=
 =?us-ascii?Q?PaYVSBV2IxgylQqb2hL5PrZeA5rAQ1QLbvjnOtXqDmDWMC7mlcX/PRz2iY65?=
 =?us-ascii?Q?B8TqhvksP9khkZV6Y4xAq+BQp/jHUJfB0bSUt4oJGk98WDMtcHoV+9+Hjp/1?=
 =?us-ascii?Q?qOF4noNHME+0E8KCJsRGpE0VSyDultnNjC94?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 22:52:18.5774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f69efc8-502b-4ad5-f7eb-08ddf573b076
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099

On Fri, May 16, 2025 at 01:33:39PM -0700, Ackerley Tng wrote:
> Ackerley Tng <ackerleytng@google.com> writes:
> 
> > Ackerley Tng <ackerleytng@google.com> writes:
> >
> >> guestmem_hugetlb is an allocator for guest_memfd. It wraps HugeTLB to
> >> provide huge folios for guest_memfd.
> >>
> >> This patch also introduces guestmem_allocator_operations as a set of
> >> operations that allocators for guest_memfd can provide. In a later
> >> patch, guest_memfd will use these operations to manage pages from an
> >> allocator.
> >>
> >> The allocator operations are memory-management specific and are placed
> >> in mm/ so key mm-specific functions do not have to be exposed
> >> unnecessarily.
> >>
> >> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> >>
> >> Change-Id: I3cafe111ea7b3c84755d7112ff8f8c541c11136d
> >> ---
> >>  include/linux/guestmem.h      |  20 +++++
> >>  include/uapi/linux/guestmem.h |  29 +++++++
> >>  mm/Kconfig                    |   5 +-
> >>  mm/guestmem_hugetlb.c         | 159 ++++++++++++++++++++++++++++++++++
> >>  4 files changed, 212 insertions(+), 1 deletion(-)
> >>  create mode 100644 include/linux/guestmem.h
> >>  create mode 100644 include/uapi/linux/guestmem.h
> >>
> >> <snip>
> >>
> >> diff --git a/mm/Kconfig b/mm/Kconfig
> >> index 131adc49f58d..bb6e39e37245 100644
> >> --- a/mm/Kconfig
> >> +++ b/mm/Kconfig
> >> @@ -1218,7 +1218,10 @@ config SECRETMEM
> >>  
> >>  config GUESTMEM_HUGETLB
> >>  	bool "Enable guestmem_hugetlb allocator for guest_memfd"
> >> -	depends on HUGETLBFS
> >> +	select GUESTMEM
> >> +	select HUGETLBFS
> >> +	select HUGETLB_PAGE
> >> +	select HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> >
> > My bad. I left out CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=y in
> > my testing and just found that when it is set, I hit
> >
> >   BUG_ON(pte_page(ptep_get(pte)) != walk->reuse_page);
> >
> > with the basic guest_memfd_test on splitting pages on allocation.
> >
> > I'll follow up with the fix soon.
> >
> > Another note about testing: I've been testing in a nested VM for the
> > development process:
> >
> > 1. Host
> > 2. VM for development
> > 3. Nested VM running kernel being developed
> > 4. Nested nested VMs created during selftests
> >
> > This series has not yet been tested on a physical host.
> >
> >>  	help
> >>  	  Enable this to make HugeTLB folios available to guest_memfd
> >>  	  (KVM virtualization) as backing memory.
> >>
> >> <snip>
> >>
> 
> Here's the fix for this issue
> 
> From 998af6404d4e39920ba42764e7f3815cb9bb9e3d Mon Sep 17 00:00:00 2001
> Message-ID: <998af6404d4e39920ba42764e7f3815cb9bb9e3d.1747427489.git.ackerleytng@google.com>
> From: Ackerley Tng <ackerleytng@google.com>
> Date: Fri, 16 May 2025 13:14:55 -0700
> Subject: [RFC PATCH v2 1/1] KVM: guest_memfd: Reorder undoing vmemmap
>  optimization and stashing hugetlb folio metadata
> 
> Without this patch, when HugeTLB folio metadata is stashed, the
> vmemmap_optimized flag, stored in a HugeTLB folio's folio->private was
> stashed as set.
> 
> The first splitting works, but on merging, when the folio metadata was
> unstashed, vmemmap_optimized is unstashed as set, making the call to
> hugetlb_vmemmap_optimize_folio() skip actually applying optimizations.
> 
> On a second split, hugetlb_vmemmap_restore_folio() attempts to reapply
> optimizations when it was already applied, hence hitting the BUG().
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  mm/guestmem_hugetlb.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/guestmem_hugetlb.c b/mm/guestmem_hugetlb.c
> index 8727598cf18e..2c0192543676 100644
> --- a/mm/guestmem_hugetlb.c
> +++ b/mm/guestmem_hugetlb.c
> @@ -200,16 +200,21 @@ static int guestmem_hugetlb_split_folio(struct folio *folio)
>  		return 0;
>  
>  	orig_nr_pages = folio_nr_pages(folio);
> -	ret = guestmem_hugetlb_stash_metadata(folio);
> +
> +	/*
> +	 * hugetlb_vmemmap_restore_folio() has to be called ahead of the rest
> +	 * because it checks page type. This doesn't actually split the folio,
> +	 * so the first few struct pages are still intact.
> +	 */
> +	ret = hugetlb_vmemmap_restore_folio(folio_hstate(folio), folio);
>  	if (ret)
>  		return ret;
>  
>  	/*
> -	 * hugetlb_vmemmap_restore_folio() has to be called ahead of the rest
> -	 * because it checks and page type. This doesn't actually split the
> -	 * folio, so the first few struct pages are still intact.
> +	 * Stash metadata after vmemmap stuff so the outcome of the vmemmap
> +	 * restoration is stashed.
>  	 */
> -	ret = hugetlb_vmemmap_restore_folio(folio_hstate(folio), folio);
> +	ret = guestmem_hugetlb_stash_metadata(folio);
>  	if (ret)
>  		goto err;

Doh, I missed this before replying earlier. This definitely seems like
the cleaner fix as it pertains to other flags/state that potentially
becomes stale after calling hugetlb_vmemmap_restore_folio().

-Mike

