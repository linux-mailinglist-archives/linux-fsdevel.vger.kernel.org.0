Return-Path: <linux-fsdevel+bounces-54469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A101EAFFFDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 12:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C4E18899EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF022E1C7E;
	Thu, 10 Jul 2025 10:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvbkjF96"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD03D24501E;
	Thu, 10 Jul 2025 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145135; cv=none; b=ZTxeKxkVs9OGoOTAOdYrvHJQZU+PRQX9wKgurO06O4AH9IxQ7wLXhAleHuDKByvSaSfbsxlrUAOFGg8vLLAUl/S4S156SlEV6DLJPVO3CgJha63mL9eDNB/WOmjOoTX9N0vbCDa7g5f0Km1LvZI1zb23oMm7ztW9u3MaMbNFpWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145135; c=relaxed/simple;
	bh=9k5W5ZlQ8WnZ+a92Zh9oGjnC5+4ALfoaYoiYSen1FNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbRAwpcoK9JRwHZE+cH6CNt/Ri6OMIDlVkV36IgrOBDgWvfWq+fqUKra/T9/JLAgAlfT0CbfEqRlNhGPPLrD6mIs7u5hAJic1rfokvsXyXlAsROypkhdGrtguko6FdSkQMtknK+3tlvRMwVOj8GmGbW0WCEajyBY6u3SsKosdjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvbkjF96; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752145131; x=1783681131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9k5W5ZlQ8WnZ+a92Zh9oGjnC5+4ALfoaYoiYSen1FNs=;
  b=UvbkjF96XtNCBWEkx8tmMtFy1FD1Gni/QuKFP8tJTv4whyx6LCqe0fZB
   pgqt0ZtUNKjFAgCF5Qod4Z9lF8VeBnKDchK6E+24SuWMnPoj7odY5ztoE
   ZVo3splVxcIRI0Yngm5EFKX2CQgZVe7jDEV2VUrrVEmqTbxBnA1GZaHu4
   +1Fg5nEsVcqYQq36nWS9elJ/DtxHEdpIcqxEoC+8aGU0v/z/qCIZR5Z2b
   IyirNTkzkGzAAydT6QZ4IlVFMh4vukh5aaw3+8gziI3odsU8LwQwnLk/w
   XZ84pFnASOi8uTeYCS3NsQIQATR8kN+8kLv1MNrFVh/KuTsHrBVAEc50/
   w==;
X-CSE-ConnectionGUID: 1dhaDUGwSDaugtSKuZcFNw==
X-CSE-MsgGUID: 9gABBNkvRtqhTxqQ/ETOVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54273831"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54273831"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 03:58:49 -0700
X-CSE-ConnectionGUID: GVMNZSOxTjSy6hBum/1yyA==
X-CSE-MsgGUID: TMRuTq9TRJ2zPj9tdZWeaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="187047312"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 10 Jul 2025 03:58:29 -0700
Date: Thu, 10 Jul 2025 18:50:09 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Vishal Annapurve <vannapurve@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Yan Zhao <yan.y.zhao@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>, Fuad Tabba <tabba@google.com>,
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
Message-ID: <aG+a4XRRc2fMrEZc@yilunxu-OptiPlex-7050>
References: <CAGtprH8eR_S50xDnnMLHNCuXrN2Lv_0mBRzA_pcTtNbnVvdv2A@mail.gmail.com>
 <CA+EHjTwjKVkw2_AK0Y0-eth1dVW7ZW2Sk=73LL9NeQYAPpxPiw@mail.gmail.com>
 <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com>
 <20250624130811.GB72557@ziepe.ca>
 <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com>
 <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com>
 <CAGtprH9-njcgQjGZvGbbVX+i8D-qPUOkKFHbOWA20962niLTcw@mail.gmail.com>
 <20250702141321.GC904431@ziepe.ca>
 <CAGtprH948W=5fHSB1UnE_DbB0L=C7LTC+a7P=g-uP0nZwY6fxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGtprH948W=5fHSB1UnE_DbB0L=C7LTC+a7P=g-uP0nZwY6fxg@mail.gmail.com>

On Wed, Jul 02, 2025 at 07:32:36AM -0700, Vishal Annapurve wrote:
> On Wed, Jul 2, 2025 at 7:13 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Jul 02, 2025 at 06:54:10AM -0700, Vishal Annapurve wrote:
> > > On Wed, Jul 2, 2025 at 1:38 AM Yan Zhao <yan.y.zhao@intel.com> wrote:
> > > >
> > > > On Tue, Jun 24, 2025 at 07:10:38AM -0700, Vishal Annapurve wrote:
> > > > > On Tue, Jun 24, 2025 at 6:08 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > > >
> > > > > > On Tue, Jun 24, 2025 at 06:23:54PM +1000, Alexey Kardashevskiy wrote:
> > > > > >
> > > > > > > Now, I am rebasing my RFC on top of this patchset and it fails in
> > > > > > > kvm_gmem_has_safe_refcount() as IOMMU holds references to all these
> > > > > > > folios in my RFC.
> > > > > > >
> > > > > > > So what is the expected sequence here? The userspace unmaps a DMA
> > > > > > > page and maps it back right away, all from the userspace? The end
> > > > > > > result will be the exactly same which seems useless. And IOMMU TLB
> > > > >
> > > > >  As Jason described, ideally IOMMU just like KVM, should just:
> > > > > 1) Directly rely on guest_memfd for pinning -> no page refcounts taken
> > > > > by IOMMU stack
> > > > In TDX connect, TDX module and TDs do not trust VMM. So, it's the TDs to inform
> > > > TDX module about which pages are used by it for DMAs purposes.
> > > > So, if a page is regarded as pinned by TDs for DMA, the TDX module will fail the
> > > > unmap of the pages from S-EPT.
> >
> > I don't see this as having much to do with iommufd.
> >
> > iommufd will somehow support the T=1 iommu inside the TDX module but
> > it won't have an IOAS for it since the VMM does not control the
> > translation.

I partially agree with this.

This is still the DMA Silent drop issue for security.  The HW (Also
applicable to AMD/ARM) screams out if the trusted DMA path (IOMMU
mapping, or access control table like RMP) is changed out of TD's
expectation. So from HW POV, it is the iommu problem.

For SW, if we don't blame iommu, maybe we rephrase as gmemfd can't
invalidate private pages unless TD agrees.

> >
> > The discussion here is for the T=0 iommu which is controlled by
> > iommufd and does have an IOAS. It should be popoulated with all the
> > shared pages from the guestmemfd.
> >
> > > > If IOMMU side does not increase refcount, IMHO, some way to indicate that
> > > > certain PFNs are used by TDs for DMA is still required, so guest_memfd can
> > > > reject the request before attempting the actual unmap.
> >
> > This has to be delt with between the TDX module and KVM. When KVM
> > gives pages to become secure it may not be able to get them back..

Just to be clear. With In-place conversion, it is not KVM gives pages
to become secure, it is gmemfd. Or maybe you mean gmemfd is part of KVM.

https://lore.kernel.org/all/aC86OsU2HSFZkJP6@google.com/

> >
> > This problem has nothing to do with iommufd.
> >
> > But generally I expect that the T=1 iommu follows the S-EPT entirely
> > and there is no notion of pages "locked for dma". If DMA is ongoing
> > and a page is made non-secure then the DMA fails.
> >
> > Obviously in a mode where there is a vPCI device we will need all the
> > pages to be pinned in the guestmemfd to prevent any kind of
> > migrations. Only shared/private conversions should change the page
> > around.

Only *guest permitted* conversion should change the page. I.e only when
VMM is dealing with the KVM_HC_MAP_GPA_RANGE hypercall. Not sure if we
could just let QEMU ensure this or KVM/guestmemfd should ensure this.

Thanks,
Yilun

> 
> Yes, guest_memfd ensures that all the faulted-in pages (irrespective
> of shared or private ranges) are not migratable. We already have a
> similar restriction with CPU accesses to encrypted memory ranges that
> need arch specific protocols to migrate memory contents.
> 
> >
> > Maybe this needs to be an integral functionality in guestmemfd?
> >
> > Jason
> 

