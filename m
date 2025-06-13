Return-Path: <linux-fsdevel+bounces-51637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1928AAD9800
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 00:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A604A2E10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 22:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E7C28EA4D;
	Fri, 13 Jun 2025 22:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KUyIHq4M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A784A28D8D1
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 22:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749852242; cv=none; b=asAQD9RpEarg5grFH2UcJ/INWNkM0+3vaUvB9wFLviKxjLU9VDtJJChLg0mQTu2sqbVFH55DH9wVJg7t3jJvjlUxDPxKn861DT0VIFvqNJBD/fgiEI0vNzXNSyg+ZSb23hauAaYZDF2WjHr73jVD3mAktcYSlGk3HWuDU5MrvJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749852242; c=relaxed/simple;
	bh=b6vnFqaX2n97IlYyxQa0+UgDTjkPtsvB+Ywg9HxnT1Y=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ZU973u71KWHxWVZAxVJt7SoAWItwxafxv1w02bRr1olUZPz6XvQDL+MebluUaPeTfabDcFj+kRa9y7mKbrN4tqY+UznMlgJf1wEPWTiZmL8aUBOBj98qib3c+LYiJQOYSKk6UYR7qG8+3OMAajJZ3elyauWoKbtBozMJciXnio0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KUyIHq4M; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74620e98ec8so2066465b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 15:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749852239; x=1750457039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i/40CUi0IHiFJ0hUhxJyhxAHD9gYzpVe1ssTOnGIXjM=;
        b=KUyIHq4Md5LrX13b4r8xjqSAZBXK2qTQjO9SSIoPxB9YXbCJSHpZyAdp5Jc5z+oqrq
         mphTcJMJX7U6+PRC4+rkpSvkL9WOwmhj6px3qTMqt6wWC9JlL7fPKXx9dUB1+vCyS9Xk
         a1jKjlkIx759V+Sqx57W6p6niJrVC/Zrd//K4sp56TRNgKKDX82YdnW/me+bX27KNLKZ
         mECkExjaxI/YEPnHVp79E8ukWyyPPUsV2tjeKi/JDnXOdO5ckGr8eHRehcxk+5NO0hz1
         J211SjAF29X48Ye81A34LjKSYGHGdbL3HRG2NV9S25yA0mkqOqR7yTx66YZjpBEi2/iE
         qqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749852239; x=1750457039;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/40CUi0IHiFJ0hUhxJyhxAHD9gYzpVe1ssTOnGIXjM=;
        b=HQyczKr/JCnl3KnEI6tvko19ZCHRohFaYCy8ArCzGLJ1kcGN0hrOpcXJ9cbMGb12L+
         P1o1R8ce8N5zGgnLUCL+kvj0ye2X5Ne3+0zmkpLJFDlB1wVUWG1Askrf8pPNqA/tZ8FY
         UE6v/tqU2Rgw0KzHDUTGW1nzOJ7zGjjUzUhaBIYtqmBJscBpwhQXzuSWkHizqyDssGJI
         nitBqvVZUZDHfnM1+d/wbZMFII8ASOHqPF7q+jhflfAkTEig+Bv/PdlCs46tyTp4C9CT
         KzB1y4cfXEUpcsvrG59U3mskN0YJ9670nwLlMq2sAjlIq1QgUCTf/KifoTyCZQfFFn4s
         d0sw==
X-Forwarded-Encrypted: i=1; AJvYcCU9y36F6bJUC9AWw6Bnz/wWlSM6EcA1OJ6fKBnL9mOdvOyC/7g2ZCaYJ1805/9vzl/D7FD8N07NYdeS4cDG@vger.kernel.org
X-Gm-Message-State: AOJu0YwzzrIkxiXpfWaCrmf67c7I7urTAnbQb1ASSN6MXz1+zwXgyZK6
	ciTUXDkE5TxgugjnCN5wTA9kip1VamYK7MzfTuXNS+zfFqMc2qZnq9hnlWJHqgYbjsmYJ8MKjqR
	xhQ24Ghcz/kMwywCgHrtn5jdRLQ==
X-Google-Smtp-Source: AGHT+IHRiKPTqW11h+ooG+958h5cZWs5QjDR2ZCbryJ+gAhM50EoMo0ybgtH7IXYe+r4kn8Tmi/t2fTL6o6uGEc16w==
X-Received: from pfbct11.prod.google.com ([2002:a05:6a00:f8b:b0:746:247f:7384])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3a08:b0:736:3ea8:4813 with SMTP id d2e1a72fcca58-7489c3e4cf3mr1576873b3a.2.1749852238827;
 Fri, 13 Jun 2025 15:03:58 -0700 (PDT)
Date: Fri, 13 Jun 2025 15:03:57 -0700
In-Reply-To: <683b94b359be_1303152941e@iweiny-mobl.notmuch> (message from Ira
 Weiny on Sat, 31 May 2025 18:45:55 -0500)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzv7ozmh82.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 22/51] mm: hugetlb: Refactor hugetlb allocation functions
From: Ackerley Tng <ackerleytng@google.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, kirill.shutemov@intel.com, liam.merwick@oracle.com, 
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
>> Refactor dequeue_hugetlb_folio() and alloc_surplus_hugetlb_folio() to
>> take mpol, nid and nodemask. This decouples allocation of a folio from
>> a vma.
>> 
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> Change-Id: I890fb46fe8c6349383d8cf89befc68a4994eb416
>> ---
>>  mm/hugetlb.c | 64 ++++++++++++++++++++++++----------------------------
>>  1 file changed, 30 insertions(+), 34 deletions(-)
>> 
>
> [snip]
>
>>  
>> @@ -2993,6 +2974,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>>  	int ret, idx;
>>  	struct hugetlb_cgroup *h_cg = NULL;
>>  	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
>> +	struct mempolicy *mpol;
>> +	nodemask_t *nodemask;
>> +	gfp_t gfp_mask;
>> +	pgoff_t ilx;
>> +	int nid;
>>  
>>  	idx = hstate_index(h);
>>  
>> @@ -3032,7 +3018,6 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>>  
>>  		subpool_reservation_exists = npages_req == 0;
>>  	}
>> -
>>  	reservation_exists = vma_reservation_exists || subpool_reservation_exists;
>>  
>>  	/*
>> @@ -3048,21 +3033,30 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>>  			goto out_subpool_put;
>>  	}
>>  
>> +	mpol = get_vma_policy(vma, addr, h->order, &ilx);
>
> Why does the memory policy need to be acquired here instead of after the
> cgroup charge?  AFAICT this is not needed and would at least eliminate 1
> of the error conditions puts.
>

I was hoping that by taking this early, the upcoming refactoring out of
hugetlb_alloc_folio() will look like a nice, clean removal of the middle
of this function, leaving acquiring of the mpol and mpol_cond_put()
in-place.

In the next revision I'm splitting up the refactoring in this patch
further so if this is still an issue in some number of revisions' time,
I can fix this.

>> +
>>  	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg);
>> -	if (ret)
>> +	if (ret) {
>> +		mpol_cond_put(mpol);
>                 ^^^^
> 		here
>
> All that said I think the use of some new cleanup macros could really help
> a lot of this code.
>

I'm happy to try that out...

> What do folks in this area of the kernel think of those?
>

not sure though.

> Ira
>
> [snip]

