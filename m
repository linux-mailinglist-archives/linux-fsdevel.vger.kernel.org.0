Return-Path: <linux-fsdevel+bounces-55235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 828D7B08982
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 11:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E004A389C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 09:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A900A28A715;
	Thu, 17 Jul 2025 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTnqgVgC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93C429D0E;
	Thu, 17 Jul 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745283; cv=none; b=tAo5Qy/ySHDw6dYLNTqgNm/Xma3P1mAAC7m4ZRSZgq1YTNi4p7G2JQCdTdOzsIhrUQUHHqQjbL11JyT2l+lHKhZt9TKT2C/Zy32QQXV0hcDrd+RafIle/QLBuV5yrnrqv8YJcj75Wrb9gW+5h3LF7eHobXf8ULevR+QSWnKVhC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745283; c=relaxed/simple;
	bh=f158b21SAzsqoT29eGBt9+eUZ2LbMQkUBicROPZ4jXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEGA6iFxb5CufyMNZtB2ozVq3I/YuIX2SbiotLQ+RJ69KTgpV/mlZTlBkvshBjx2RS/7XbMBsnx3esbxepBTuAwm+GIWHph6KekPocdPxPvE0cMBOaeCkx9OZBWVAQS/rw2NHy1NszP5uG1tV7YwZiUFgmua7LHi3kaovXBa9vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTnqgVgC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752745281; x=1784281281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=f158b21SAzsqoT29eGBt9+eUZ2LbMQkUBicROPZ4jXw=;
  b=WTnqgVgCB52v+WzvcBNU6gHkE8HFMv/nnj2uQZqDtL9bG37+77L/+MrX
   IIJ6av1A1Gxe0F3FX+OsMG1HH8JKOWgFAHwpDNE55hCHzpeI/tdNtSW3q
   lHIjFkAihbGB5+MmOcceWv+VsiDZLPGnx9qZgSwSSnGPlAVPnReG3WiAn
   vkGP8odtpDQAchPdrMZPhIofvHp1mAZvc69caDnHGd+wZDOY4BchKvEMm
   sadWc6/tqDGPuX+YRrb7BpD7JDr0e6mt76jqDJHS1zrbzvEM7r4lux8kh
   632x9gFVSp7d0Y3J4YXYtQ/QIETzYrCMKybgEYzNFhnjjAt7yJ96Nz7jE
   g==;
X-CSE-ConnectionGUID: dXyERcIsQdOH7nQ1nKq54A==
X-CSE-MsgGUID: zSUSpihrSICAlFGcnKbwrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55162682"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="55162682"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 02:41:20 -0700
X-CSE-ConnectionGUID: mGURc28dR2qraEFpNo381g==
X-CSE-MsgGUID: UBWhswFOQou9MrnZsXvkkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="157818401"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa007.jf.intel.com with ESMTP; 17 Jul 2025 02:41:00 -0700
Date: Thu, 17 Jul 2025 17:32:19 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>,
	Fuad Tabba <tabba@google.com>, kvm@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-fsdevel@vger.kernel.org, ajones@ventanamicro.com,
	akpm@linux-foundation.org, amoorthy@google.com,
	anthony.yznaga@oracle.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, bfoster@redhat.com,
	binbin.wu@linux.intel.com, brauner@kernel.org,
	catalin.marinas@arm.com, chao.p.peng@intel.com,
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com,
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com,
	fan.du@intel.com, fvdl@google.com, graf@amazon.com,
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com,
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz,
	james.morse@arm.com, jarkko@kernel.org, jgowans@amazon.com,
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com,
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com,
	kent.overstreet@linux.dev, kirill.shutemov@intel.com,
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com,
	mail@maciej.szmigiero.name, maz@kernel.org, mic@digikod.net,
	michael.roth@amd.com, mpe@ellerman.id.au, muchun.song@linux.dev,
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev,
	palmer@dabbelt.com, pankaj.gupta@amd.com, paul.walmsley@sifive.com,
	pbonzini@redhat.com, pdurrant@amazon.co.uk, peterx@redhat.com,
	pgonda@google.com, pvorel@suse.cz, qperret@google.com,
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com,
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com,
	quic_pheragu@quicinc.com, quic_svaddagi@quicinc.com,
	quic_tsoni@quicinc.com, richard.weiyang@gmail.com,
	rick.p.edgecombe@intel.com, rientjes@google.com,
	roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com,
	shuah@kernel.org, steven.price@arm.com, steven.sistare@oracle.com,
	suzuki.poulose@arm.com, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, vbabka@suse.cz, viro@zeniv.linux.org.uk,
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org,
	willy@infradead.org, xiaoyao.li@intel.com, yilun.xu@intel.com,
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
Message-ID: <aHjDIxxbv0DnqI6S@yilunxu-OptiPlex-7050>
References: <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
 <CA+EHjTxtHOgichL=UvAzczoqS1608RSUNn5HbmBw2NceO941ng@mail.gmail.com>
 <CAGtprH8eR_S50xDnnMLHNCuXrN2Lv_0mBRzA_pcTtNbnVvdv2A@mail.gmail.com>
 <CA+EHjTwjKVkw2_AK0Y0-eth1dVW7ZW2Sk=73LL9NeQYAPpxPiw@mail.gmail.com>
 <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com>
 <20250624130811.GB72557@ziepe.ca>
 <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com>
 <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com>
 <diqz8qknhj3l.fsf@ackerleytng-ctop.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <diqz8qknhj3l.fsf@ackerleytng-ctop.c.googlers.com>

On Wed, Jul 16, 2025 at 03:22:06PM -0700, Ackerley Tng wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> 
> > On Tue, Jun 24, 2025 at 07:10:38AM -0700, Vishal Annapurve wrote:
> >> On Tue, Jun 24, 2025 at 6:08 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >> >
> >> > On Tue, Jun 24, 2025 at 06:23:54PM +1000, Alexey Kardashevskiy wrote:
> >> >
> >> > > Now, I am rebasing my RFC on top of this patchset and it fails in
> >> > > kvm_gmem_has_safe_refcount() as IOMMU holds references to all these
> >> > > folios in my RFC.
> >> > >
> >> > > So what is the expected sequence here? The userspace unmaps a DMA
> >> > > page and maps it back right away, all from the userspace? The end
> >> > > result will be the exactly same which seems useless. And IOMMU TLB
> >> 
> >>  As Jason described, ideally IOMMU just like KVM, should just:
> >> 1) Directly rely on guest_memfd for pinning -> no page refcounts taken
> >> by IOMMU stack
> > In TDX connect, TDX module and TDs do not trust VMM. So, it's the TDs to inform
> > TDX module about which pages are used by it for DMAs purposes.
> > So, if a page is regarded as pinned by TDs for DMA, the TDX module will fail the
> > unmap of the pages from S-EPT.
> >
> > If IOMMU side does not increase refcount, IMHO, some way to indicate that
> > certain PFNs are used by TDs for DMA is still required, so guest_memfd can
> > reject the request before attempting the actual unmap.
> > Otherwise, the unmap of TD-DMA-pinned pages will fail.
> >
> > Upon this kind of unmapping failure, it also doesn't help for host to retry
> > unmapping without unpinning from TD.
> >
> >
> 
> Yan, Yilun, would it work if, on conversion,
> 
> 1. guest_memfd notifies IOMMU that a conversion is about to happen for a
>    PFN range

It is the Guest fw call to release the pinning. By the time VMM get the
conversion requirement, the page is already physically unpinned. So I
agree with Jason the pinning doesn't have to reach to iommu from SW POV.

> 2. IOMMU forwards the notification to TDX code in the kernel
> 3. TDX code in kernel tells TDX module to stop thinking of any PFNs in
>    the range as pinned for DMA?

TDX host can't stop the pinning. Actually this mechanism is to prevent
host from unpin/unmap the DMA out of Guest expectation.

Thanks,
Yilun

> 
> If the above is possible then by the time we get to unmapping from
> S-EPTs, TDX module would already consider the PFNs in the range "not
> pinned for DMA".

