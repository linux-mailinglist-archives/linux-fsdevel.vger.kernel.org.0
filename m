Return-Path: <linux-fsdevel+bounces-55582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE2AB0C0D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 12:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FEE63BEF72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 10:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB1728C87B;
	Mon, 21 Jul 2025 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZmvYwc8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CCE18FC91;
	Mon, 21 Jul 2025 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092465; cv=none; b=Ta/PfsL3aCv/uCGgKAaI3ZqA+c5W0W4RTwjBXqvNJDAihFuZMeOeF1pBxbWppngSiPvpQMB/k3LZLjfAIBhA9I0IV2nZ/N3+lJVEiD3IcM8AuTH0Vp3fhGoNAJyfpXjFNXlH5MbHxSxjOkgBueMn7ji8ui5JcOPGb0GzJqjjqqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092465; c=relaxed/simple;
	bh=gnT7JnKbIZTs1/DF9F99GY/6ioIc4Qm9hwZlyLDRQAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgoGoi4PtMkt5JzP9squ9EnYqJ5tmaRV5WdwVcWN8CnZ8NSY84WldjnJ52DxTwzNDaxvqfBsp5fQEfmfSzVAT9h712Z4kOVPWCo76rUFAubE3u4MFU5Dc6wgZLGW5nqsy+QcNsiMRW5mPYP6XS6ar+NFaS3FuYB4MJUdBF+Rt8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZmvYwc8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753092463; x=1784628463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gnT7JnKbIZTs1/DF9F99GY/6ioIc4Qm9hwZlyLDRQAE=;
  b=LZmvYwc8XdoHIpYGcLD0h2L/Hj8hqcTBrUJTu7YmpSsfQw/7/Bj5dsWf
   FsnlUwyU4ptuarrOMK//1j00VsCFu/6EU14WSFNW4mXTueRUMGfpv9SUg
   Ov3d6xWfgeW4ErbYMv2WSPjKdkqAwHGFL/D6914z2LCmrQeWIdyZRetFG
   BqLeIt9D6NJyX2rvwLd4XTF96Dfc6yHqJcEslKqRrWJRuAvZVNV3NKT5g
   5MC5oniP790LkiCv8kDFZ0nLQgKu6PY4jy259JfhGa+11Ylsdsr6qNxTY
   c3Upg9TmmsKN/Lb5zaLU7r1MBQHEe7pRLtQGhhkgUSV1KXB529Al/tYX1
   Q==;
X-CSE-ConnectionGUID: kInq72B6Qx67LXght0wPKA==
X-CSE-MsgGUID: ZYosuag7Tnia8xVauTpl7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="66649594"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="66649594"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 03:07:42 -0700
X-CSE-ConnectionGUID: lZvV7H2ySFeJpzJ+XwtoCw==
X-CSE-MsgGUID: n/AN5tG9TNmXrKtBqI9eZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="158110405"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 21 Jul 2025 03:07:22 -0700
Date: Mon, 21 Jul 2025 17:58:30 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, Yan Zhao <yan.y.zhao@intel.com>,
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
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com,
	jarkko@kernel.org, jgowans@amazon.com, jhubbard@nvidia.com,
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com,
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev,
	kirill.shutemov@intel.com, liam.merwick@oracle.com,
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name,
	maz@kernel.org, mic@digikod.net, michael.roth@amd.com,
	mpe@ellerman.id.au, muchun.song@linux.dev, nikunj@amd.com,
	nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com,
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com,
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com,
	pvorel@suse.cz, qperret@google.com, quic_cvanscha@quicinc.com,
	quic_eberman@quicinc.com, quic_mnalajal@quicinc.com,
	quic_pderrin@quicinc.com, quic_pheragu@quicinc.com,
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com,
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com,
	rientjes@google.com, roypat@amazon.co.uk, rppt@kernel.org,
	seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
	steven.sistare@oracle.com, suzuki.poulose@arm.com,
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vbabka@suse.cz,
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com,
	will@kernel.org, willy@infradead.org, xiaoyao.li@intel.com,
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
Message-ID: <aH4PRnuztKTqgEYo@yilunxu-OptiPlex-7050>
References: <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com>
 <20250624130811.GB72557@ziepe.ca>
 <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com>
 <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com>
 <diqz8qknhj3l.fsf@ackerleytng-ctop.c.googlers.com>
 <aHjDIxxbv0DnqI6S@yilunxu-OptiPlex-7050>
 <diqzqzyeg3j2.fsf@ackerleytng-ctop.c.googlers.com>
 <aHm2F95XwzdD7nod@yilunxu-OptiPlex-7050>
 <687a6483506f2_3c6f1d2945a@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <687a6483506f2_3c6f1d2945a@iweiny-mobl.notmuch>

> > > >> Yan, Yilun, would it work if, on conversion,
> > > >> 
> > > >> 1. guest_memfd notifies IOMMU that a conversion is about to happen for a
> > > >>    PFN range
> > > >
> > > > It is the Guest fw call to release the pinning.
> > > 
> > > I see, thanks for explaining.
> > > 
> > > > By the time VMM get the
> > > > conversion requirement, the page is already physically unpinned. So I
> > > > agree with Jason the pinning doesn't have to reach to iommu from SW POV.
> > > >
> > > 
> > > If by the time KVM gets the conversion request, the page is unpinned,
> > > then we're all good, right?
> > 
> > Yes, unless guest doesn't unpin the page first by mistake.
> 
> Or maliciously?  :-(

Yes.

> 
> My initial response to this was that this is a bug and we don't need to be
> concerned with it.  However, can't this be a DOS from one TD to crash the
> system if the host uses the private page for something else and the
> machine #MC's?

I think we are already doing something to prevent vcpus from executing
then destroy VM, so no further TD accessing. But I assume there is
concern a TD could just leak a lot of resources, and we are
investigating if host can reclaim them.

Thanks,
Yilun

