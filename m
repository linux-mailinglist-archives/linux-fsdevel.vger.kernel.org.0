Return-Path: <linux-fsdevel+bounces-54604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E048B01882
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823381790DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 09:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2729C27EFEA;
	Fri, 11 Jul 2025 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3EEP0+F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6C027E1D0;
	Fri, 11 Jul 2025 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226965; cv=none; b=Rr3+QLC4tZ6PKS9JZ7KsrvE1bL/y8m5SJUTBIr+XADvK+UPf8PbD3mp3sFnGsTFoYp3lkZcXhiazZAOl6EZCNmGqWFsX1WVq4x9LFu1bxyl3BmJxsypWEirOf1gMYSwulb4L+FiGUt4keBfAKRzkUHsAFzBOAdXpch5QMEcgbYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226965; c=relaxed/simple;
	bh=oDBY8JF9G1/mTrz3j3EAZiovopcRWBuv++8VUSjyj/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHt7EFuGZZ5TQi4YEchURQkvpNM9q96jZjcHrPxVAXXVtbLPfEOHP1gQtTmD62kkSx20CVc4+xusi2bR7c/aZXkr4pRneVpzDDuIj3HgRWARXj8IZM0K598j5z9QN9FFB2cfZ1WcTHaZ6hAeFacIHC+5JhMV5IMg1QG41FZuh8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3EEP0+F; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752226964; x=1783762964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oDBY8JF9G1/mTrz3j3EAZiovopcRWBuv++8VUSjyj/4=;
  b=O3EEP0+Fli3oGZiJTfwqInFUAbYWL2JXcIg/QPj8uEo2cP+FTIPE5USN
   WF+w+ulAqPPque52y4g+WsuLBwwtR/oynkZhTdxk8rHxukEdLxwTvjpWK
   O9S+y3ALWFe2RD1eSiwjxk+RF+4VwicZOUnTXotqdjirjsVkZKKfuEylo
   m1gbLGWo1XAqkxZ5Hpl88MowfPx59AOq8pi0bzEJZRU3Y3dcjn9FXLP9e
   XGIacUuZkIahebJ6k3zFYDbpb9emGTU0NxFTlf5ck3KZ5cTlSCRRd/kCP
   A+mcL3qBf7wnRDDOXhmgkMewSoRQZaxvnMND5eFDJTiF6K/i2FGIKLi7s
   Q==;
X-CSE-ConnectionGUID: eWj/przoSqyuSf3lM67htw==
X-CSE-MsgGUID: 8wQdi5VITQK9POby+y93Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65104697"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="65104697"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 02:42:42 -0700
X-CSE-ConnectionGUID: Ry1VIS8iTJqgroNk8yFFkw==
X-CSE-MsgGUID: QqzhhYC7SZuEOXM1tMmJxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="162019431"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 11 Jul 2025 02:42:22 -0700
Date: Fri, 11 Jul 2025 17:33:59 +0800
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
Message-ID: <aHDah15CN7Y16Lxx@yilunxu-OptiPlex-7050>
References: <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com>
 <20250624130811.GB72557@ziepe.ca>
 <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com>
 <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com>
 <CAGtprH9-njcgQjGZvGbbVX+i8D-qPUOkKFHbOWA20962niLTcw@mail.gmail.com>
 <20250702141321.GC904431@ziepe.ca>
 <CAGtprH948W=5fHSB1UnE_DbB0L=C7LTC+a7P=g-uP0nZwY6fxg@mail.gmail.com>
 <aG+a4XRRc2fMrEZc@yilunxu-OptiPlex-7050>
 <20250710175449.GA1870174@ziepe.ca>
 <aHCTvAAtvE4Mofy2@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHCTvAAtvE4Mofy2@yilunxu-OptiPlex-7050>

> > > 
> > > Only *guest permitted* conversion should change the page. I.e only when
> > > VMM is dealing with the KVM_HC_MAP_GPA_RANGE hypercall. Not sure if we
> > > could just let QEMU ensure this or KVM/guestmemfd should ensure this.
> > 
> > I think it should not be part of the kernel, no need. From a kernel
> > perspective userspace has requested a shared/private conversion and if
> > it wasn't agreed with the VM then it will explode.
> 
> I'm OK with it now. It's simple if we don't try to recover from the
> explosion. Although I see the after explosion processing in kernel is
> complex and not sure how it will advance.

I see the discussion in another thread about similar issue. That TDX
Module BUG causes S-EPT unmap impossible and just KVM_BUG_ON(). But this
conversion issue is a little different, usually it's not decent to panic
because of userspace request. So may need further error handling, or a
KVM/gmemfd kAPI to disallow/allow conversion and prevent more complex
error.

Thanks,
Yilun

> 
> Thanks,
> Yilun
> 
> > 
> > Jason
> 

