Return-Path: <linux-fsdevel+bounces-49289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C3AABA23E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 19:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA62B4E3EEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 17:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EF627586F;
	Fri, 16 May 2025 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mG7GnUsT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A004527585E
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747418021; cv=none; b=WFcd/edZrWIveBxSuyX4Bf3lfVk/YE9CNP7BaYVBic9XJZ96dWp1suJUOBbn/rx/J6QzJ/vwnAahei1po1xNcnvhSW3tvb3ie2kCKLmDayO5oE4VPwt1YX+hYPy8KDo7yrDGms8DteN4Y/lZobf2uWQDWQCfwXFm1evYgR/Txw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747418021; c=relaxed/simple;
	bh=HJfPGu9SHo5W2l3D7Ly+k/GNEpBm/EasByT5N7ysZac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Un66IC1M/0xPzzSDZmtgr6tluWZA+fmUHBU2jrDoRQ5X6Fr320eOJFbS8PFC6qaByJcxSt+kbwmG8Dini9MXuKxLyq4pIgJZ5WYlo2szVM+GtqufvGrPDpv4gEuadSU5aTZ2gmq1bJmLUPAJkJMyd5gCpuVnTMSp/6tvBib2mzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mG7GnUsT; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7429fc0bfc8so1527549b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747418019; x=1748022819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8cF3oG0ZvlxQApliLAWy8AhC33oXxmPcmw1u1Vqb2bU=;
        b=mG7GnUsToXtW+YWIzm9HwjARtlPmALFGp58UoOIWR0XDUiiAvVPhQVDeA+s7gtJTQn
         6o9VMxY9vH5/EpB+pO706VumTrw9OXc8LkCIIctGmugQAoHgY9cONBTcArwYbHOh92Ow
         T8BZVX2yElEuKOZ/LCn3bQvVH2YXE3ZMMU4XuBlzjUxnpD7tyyjdySQWyDSsrZ+QpWcj
         tBomF7OU+NTx1YL27Dy0Az32h9G2XNjgFRSgDoGkyw1Sv4zGtXW9tw7V5IpfC+dq5jqU
         VTVwxLroNSRm8r7H92pGqdQfh4KIQ/uKmRMu2NJSV/0yAehLPihClVF2PjtTi3/mjmsL
         ByKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747418019; x=1748022819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cF3oG0ZvlxQApliLAWy8AhC33oXxmPcmw1u1Vqb2bU=;
        b=KAbXWio9/NHhGxwU4ucLI5rAa3iOjoYnbQmNADUpXG0E9bPqDfY91yHUen0tddPKuj
         8wyA6rCvdgi4iZVWWHx1S8+EHbV+FPX4AaXGOVhooiOTJ/2VZVF7f+UadbYFhuQfKPwj
         ckdgJn0kLOuwC2PW41PRbeeNukktgF9a6ABUvmi9FKnOQFe9kP5iFnfvhVUPMFofwIuw
         APWwzrtZ/6UF+0I666U/qju0to3yn0lizkpkwO3sEv3HYU+OTcMO/ArUYpyg4WSXCU2O
         X6v4IOxopIGWpaMdugOFx5EnYOxASXNWnHWQPQ621N6d3I6hPGWHAGhRELc5AQOpkqEu
         dN4A==
X-Forwarded-Encrypted: i=1; AJvYcCUPV42rJEIhkeo62tG0G+L39o/PojAWzLS6X+BB8AxonHO0J9BfdTzCqTRotk0HNlmrT4mwisM8038o0ngV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc4asp64K42Id6PalezAppwRIY1RcGZqr/mLpkbAoZ8/+V2a45
	X8xyH5PEpv8bWw8AHIPFZ4Jjl0Je7fJcY47A4OASB6KlhiP7PTDOSecb4Ly5vwyycA2ph0zTrP0
	e2cnBIhVqCnaS0Y6rmTi8EtEkJA==
X-Google-Smtp-Source: AGHT+IHTUNH+ccDKQDLHandSLB8Cs2YqxqxBQL8lX50pqIiEe34TWuIXzn9EkbeNJjz0gF0OHqoknNNeE+FoIqCs2g==
X-Received: from pfbmc24.prod.google.com ([2002:a05:6a00:7698:b0:740:b53a:e67f])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d494:b0:215:eb10:9f13 with SMTP id adf61e73a8af0-2165f87269fmr5223554637.17.1747418018754;
 Fri, 16 May 2025 10:53:38 -0700 (PDT)
Date: Fri, 16 May 2025 10:53:37 -0700
In-Reply-To: <6825ff323cc63_337c39294e3@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
 <6825ff323cc63_337c39294e3@iweiny-mobl.notmuch>
Message-ID: <diqzjz6gfnmm.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
From: Ackerley Tng <ackerleytng@google.com>
To: Ira Weiny <ira.weiny@intel.com>, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: aik@amd.com, ajones@ventanamicro.com, akpm@linux-foundation.org, 
	amoorthy@google.com, anthony.yznaga@oracle.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, bfoster@redhat.com, binbin.wu@linux.intel.com, 
	brauner@kernel.org, catalin.marinas@arm.com, chao.p.peng@intel.com, 
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com, 
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, graf@amazon.com, haibo1.xu@intel.com, 
	hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Ira Weiny <ira.weiny@intel.com> writes:

> Ackerley Tng wrote:
>
> [snip]
>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> 
>
> [snip]
>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 590932499eba..f802116290ce 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -30,6 +30,10 @@ enum shareability {
>>  };
>>  
>>  static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index);
>> +static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
>> +				      pgoff_t end);
>> +static void kvm_gmem_invalidate_end(struct kvm_gmem *gmem, pgoff_t start,
>> +				    pgoff_t end);
>>  
>>  static struct kvm_gmem_inode_private *kvm_gmem_private(struct inode *inode)
>>  {
>> @@ -85,6 +89,306 @@ static struct folio *kvm_gmem_get_shared_folio(struct inode *inode, pgoff_t inde
>>  	return kvm_gmem_get_folio(inode, index);
>>  }
>>  
>> +/**
>> + * kvm_gmem_shareability_store() - Sets shareability to @value for range.
>> + *
>> + * @mt: the shareability maple tree.
>> + * @index: the range begins at this index in the inode.
>> + * @nr_pages: number of PAGE_SIZE pages in this range.
>> + * @value: the shareability value to set for this range.
>> + *
>> + * Unlike mtree_store_range(), this function also merges adjacent ranges that
>> + * have the same values as an optimization.
>
> Is this an optimization or something which will be required to convert
> from shared back to private and back to a huge page mapping?
>

This is an optimization.

> If this is purely an optimization it might be best to leave it out for now
> to get functionality first.
>

I see this (small) optimization as part of using maple trees.

Fuad's version [1] uses xarrays and has 1 xarray entry per page
offset. I wanted to illustrate that by using maple trees, we can share
just 1 entry for a whole range, and part of that sharing involves
merging adjacent shareability entries that have the same value.

IIUC, these other users of maple trees also do some kind of
expansion/range merging:

+ VMAs in vma_expand() [2]
+ regcache in regcache_maple_write() [3]

> I have more to review but wanted to ask this.
>
> Ira
>
> [snip]

[1] https://lore.kernel.org/all/20250328153133.3504118-4-tabba@google.com/
[2] https://elixir.bootlin.com/linux/v6.14.6/source/mm/vma.c#L1059
[3] https://elixir.bootlin.com/linux/v6.14.6/source/drivers/base/regmap/regcache-maple.c#L38

