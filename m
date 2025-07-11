Return-Path: <linux-fsdevel+bounces-54585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A841B0125B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 06:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073A7648395
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 04:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C961AD3E5;
	Fri, 11 Jul 2025 04:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K85h6idU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969AA2110E;
	Fri, 11 Jul 2025 04:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208841; cv=none; b=ES5wgPZkTvs+DRWCf3wTlfZWLPGIbQ3sj0O4O3nB6Fenv/RjK9+rw88NFSfutr/70Bojp12o6UsiaZni/6TwoMWRt+ZSeHUnDIb/ui2CV8BKLqzNn+wW1XR9XXLfM209tyElNOxRI/Y3Z+SEx8mfc62krwMQs0QpGFt5lS9jx38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208841; c=relaxed/simple;
	bh=R0JRR0jPdWQFsnHeDQicLF6rapHJfa6O3V7xWIsXrEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Udax6gMvKaOzPyFZyNq+FKz86YXA/mlsrlStnbExoffT7z3ccjfYbbe1n9sVpeU+jRzw5q96WVPbuDCQgUTPDt5wo75tqWyJxqiib7LYKdN16iB78rgvCQf1hEWMzN77shzuiVC7ik7YQErTCbwQSUhVF3q6z669rYS23+pH0ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K85h6idU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752208839; x=1783744839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=R0JRR0jPdWQFsnHeDQicLF6rapHJfa6O3V7xWIsXrEc=;
  b=K85h6idUoBtLsGi5lSWunJa0dJvcpH9JYg+dKP8+tBTdpb8h2tpTFxPz
   +snXLecMl10+glYDwvnba07lRSnoWl+SF8YFIqJbRGZotKwgOoR2a8fVl
   IzXAMJl3z2VfaFpKLkMb7/QKyR2lByrXJBLPEM6UMtM6ajf1F60xdMdSG
   Wc9Kr0WIbxjZglYvIBbG8WYGu7w7yBmdWWLJ9drHWJF9UGGVt8UFdGP4h
   FyvwAsB1qhtVYWVejZT/FcwNPreSiaPQqaahsKm28i3MxPYncwI4lHuR5
   SeYBBiYn8K3VvECw1s/frY2NoPj/C1+1mg6MHG/Br+58bXmzv/c0LV2tg
   w==;
X-CSE-ConnectionGUID: m9Fs2OH/S5a2uC2hAIa5wg==
X-CSE-MsgGUID: //vb/Z5rR0GOLIrBNVKXRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="79934940"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="79934940"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 21:40:38 -0700
X-CSE-ConnectionGUID: klaS2TZATH+2blf4tv6DUQ==
X-CSE-MsgGUID: uYwPD74pRiG2cr/33/gDWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="155685771"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 10 Jul 2025 21:40:19 -0700
Date: Fri, 11 Jul 2025 12:31:56 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Vishal Annapurve <vannapurve@google.com>,
	Yan Zhao <yan.y.zhao@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
	Fuad Tabba <tabba@google.com>,
	Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org,
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
Message-ID: <aHCTvAAtvE4Mofy2@yilunxu-OptiPlex-7050>
References: <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com>
 <20250624130811.GB72557@ziepe.ca>
 <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com>
 <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com>
 <CAGtprH9-njcgQjGZvGbbVX+i8D-qPUOkKFHbOWA20962niLTcw@mail.gmail.com>
 <20250702141321.GC904431@ziepe.ca>
 <CAGtprH948W=5fHSB1UnE_DbB0L=C7LTC+a7P=g-uP0nZwY6fxg@mail.gmail.com>
 <aG+a4XRRc2fMrEZc@yilunxu-OptiPlex-7050>
 <20250710175449.GA1870174@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250710175449.GA1870174@ziepe.ca>

On Thu, Jul 10, 2025 at 02:54:49PM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 10, 2025 at 06:50:09PM +0800, Xu Yilun wrote:
> > On Wed, Jul 02, 2025 at 07:32:36AM -0700, Vishal Annapurve wrote:
> > > On Wed, Jul 2, 2025 at 7:13 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Wed, Jul 02, 2025 at 06:54:10AM -0700, Vishal Annapurve wrote:
> > > > > On Wed, Jul 2, 2025 at 1:38 AM Yan Zhao <yan.y.zhao@intel.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 24, 2025 at 07:10:38AM -0700, Vishal Annapurve wrote:
> > > > > > > On Tue, Jun 24, 2025 at 6:08 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jun 24, 2025 at 06:23:54PM +1000, Alexey Kardashevskiy wrote:
> > > > > > > >
> > > > > > > > > Now, I am rebasing my RFC on top of this patchset and it fails in
> > > > > > > > > kvm_gmem_has_safe_refcount() as IOMMU holds references to all these
> > > > > > > > > folios in my RFC.
> > > > > > > > >
> > > > > > > > > So what is the expected sequence here? The userspace unmaps a DMA
> > > > > > > > > page and maps it back right away, all from the userspace? The end
> > > > > > > > > result will be the exactly same which seems useless. And IOMMU TLB
> > > > > > >
> > > > > > >  As Jason described, ideally IOMMU just like KVM, should just:
> > > > > > > 1) Directly rely on guest_memfd for pinning -> no page refcounts taken
> > > > > > > by IOMMU stack
> > > > > > In TDX connect, TDX module and TDs do not trust VMM. So, it's the TDs to inform
> > > > > > TDX module about which pages are used by it for DMAs purposes.
> > > > > > So, if a page is regarded as pinned by TDs for DMA, the TDX module will fail the
> > > > > > unmap of the pages from S-EPT.
> > > >
> > > > I don't see this as having much to do with iommufd.
> > > >
> > > > iommufd will somehow support the T=1 iommu inside the TDX module but
> > > > it won't have an IOAS for it since the VMM does not control the
> > > > translation.
> > 
> > I partially agree with this.
> > 
> > This is still the DMA Silent drop issue for security.  The HW (Also
> > applicable to AMD/ARM) screams out if the trusted DMA path (IOMMU
> > mapping, or access control table like RMP) is changed out of TD's
> > expectation. So from HW POV, it is the iommu problem.
> 
> I thought the basic idea was that the secure world would sanity check
> what the insecure is doing and if it is not OK then it blows up. So if

Yes. The secure world checks. But it let alone the unexpected change on
CPU path cause CPU is synchronous and VM just pends on the fault, no
security concern. While DMA is asynchronous and the secure world must
blow up.

> the DMA fails because the untrusted world revoked sharability when it
> should not have then this is correct and expected?

OK. From secure world POV the failing is correct & expected.

> 
> > For SW, if we don't blame iommu, maybe we rephrase as gmemfd can't
> > invalidate private pages unless TD agrees.
> 
> I think you mean guestmemfd in the kernel cannot autonomously change
> 'something' unless instructed to explicitly by userspace.
> 
> The expectation is the userspace will only give such instructions
> based on the VM telling it to do a shared/private change.
> 
> If userspace gives an instruction that was not agreed with the guest
> then the secure world can police the error and blow up.

Yes.

>  
> > Just to be clear. With In-place conversion, it is not KVM gives pages
> > to become secure, it is gmemfd. Or maybe you mean gmemfd is part of KVM.
> 
> Yeah, I mean part of.
> 
> > > > Obviously in a mode where there is a vPCI device we will need all the
> > > > pages to be pinned in the guestmemfd to prevent any kind of
> > > > migrations. Only shared/private conversions should change the page
> > > > around.
> > 
> > Only *guest permitted* conversion should change the page. I.e only when
> > VMM is dealing with the KVM_HC_MAP_GPA_RANGE hypercall. Not sure if we
> > could just let QEMU ensure this or KVM/guestmemfd should ensure this.
> 
> I think it should not be part of the kernel, no need. From a kernel
> perspective userspace has requested a shared/private conversion and if
> it wasn't agreed with the VM then it will explode.

I'm OK with it now. It's simple if we don't try to recover from the
explosion. Although I see the after explosion processing in kernel is
complex and not sure how it will advance.

Thanks,
Yilun

> 
> Jason

