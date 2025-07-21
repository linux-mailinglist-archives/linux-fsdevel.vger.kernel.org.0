Return-Path: <linux-fsdevel+bounces-55601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D31B0C643
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 16:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4C8188B8EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 14:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721B22DAFB7;
	Mon, 21 Jul 2025 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BpUZhmBJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105352D9EF2;
	Mon, 21 Jul 2025 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108052; cv=none; b=Jpc0JjNMK/ltrB9xxTTyaUnml2Jsc+XtXW1aYM1aMa4akiowNtSdXMPMCFx2gXad9n0xDhzgz93+skFfWObytcv5+xWTHbgWsEqmAUAGCDOTFRYoejOMAXBlUyhozCz5ma916e/xlHUCpf3sm5kIhOzeME4+sbvIvKLRmxG4Lfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108052; c=relaxed/simple;
	bh=PNJKS+TVTTfsECa7XS5I8d4xMGqWb4m/BU6pFdO60nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKca9n07agi3zxkWYcKtHnQUucoTw34Aii+3/7S0MBVKzWokMnfnxK8yKKZq5/1S8S+rbUY5je0CYhjNJAzQkXbyWNXV/86N+c/QIkES0GzJRKmVg/oLOkjcz0TWYAeWYLQWOLT243dt7QxVuoeNv9uNfsscuJdf34+9q/BcwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BpUZhmBJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753108051; x=1784644051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PNJKS+TVTTfsECa7XS5I8d4xMGqWb4m/BU6pFdO60nA=;
  b=BpUZhmBJMvOZjl7A7VmpRjwAhH4R65FAe884t36bYwEXkEdCMtemr/h0
   o4edBPSccAwiIJjdjJWwiLgT1oUrNBdcWBRDHBaxzzn7Jgwax//9gfyDO
   VwZvmBr+D2+Su8Xg0/wRJ/W4MyzupRhHxubTEmZ4Q81a/eOfRl34aJXhQ
   GKcTXZ3dCZplYtKsEYMQtKW9XW8rEIW1Z/TYlQnjOTpof6sKZ3HF+1YD3
   x6bGISk3LbLs7HuxNbsmceTSWXBp5A95xq7Ey2FGeE5HiZh6KvOOuio1M
   9SsSsncxcw7TrMbYEOKimDMwR3BUpKtDuy2qEAAEt6ZImR3Kzi9JdZN5y
   g==;
X-CSE-ConnectionGUID: 8FZFIA/VTOKBu7+Sy1N04g==
X-CSE-MsgGUID: UnB9IzYOTWivtOvRrKtzlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="54424867"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="54424867"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 07:27:30 -0700
X-CSE-ConnectionGUID: z23pwguhRCq0pG2C6uHt2g==
X-CSE-MsgGUID: R04oqIF4Qc+jd/Sk1KqXag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="162898084"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 21 Jul 2025 07:27:11 -0700
Date: Mon, 21 Jul 2025 22:18:18 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ackerley Tng <ackerleytng@google.com>, Yan Zhao <yan.y.zhao@intel.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Alexey Kardashevskiy <aik@amd.com>, Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
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
Message-ID: <aH5MKseUAGFFWc8T@yilunxu-OptiPlex-7050>
References: <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com>
 <20250624130811.GB72557@ziepe.ca>
 <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com>
 <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com>
 <diqz8qknhj3l.fsf@ackerleytng-ctop.c.googlers.com>
 <aHjDIxxbv0DnqI6S@yilunxu-OptiPlex-7050>
 <diqzqzyeg3j2.fsf@ackerleytng-ctop.c.googlers.com>
 <aHm2F95XwzdD7nod@yilunxu-OptiPlex-7050>
 <20250718141559.GF2206214@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718141559.GF2206214@ziepe.ca>

On Fri, Jul 18, 2025 at 11:15:59AM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 18, 2025 at 10:48:55AM +0800, Xu Yilun wrote:
> > > If by the time KVM gets the conversion request, the page is unpinned,
> > > then we're all good, right?
> > 
> > Yes, unless guest doesn't unpin the page first by mistake. Guest would
> > invoke a fw call tdg.mem.page.release to unpin the page before
> > KVM_HC_MAP_GPA_RANGE.
> 
> What does guest pinning mean?

TDX firmware provides a mode, that host can't block the S-EPT mapping
after TD accepts the mapping. Guest 'pins' the private mapping (KVM &
IOMMU).

TD should explicitly unaccept the page by tdg.mem.page.release, then
host could successfully block/unmap the S-EPT. This is necessary when
shared <-> private conversion.

When TDX Connect is enabled, this mode is enforced.

Thanks,
Yilun

> 
> Jason
> 

