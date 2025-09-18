Return-Path: <linux-fsdevel+bounces-62069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DDCB832A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 08:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147F5722276
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 06:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F582D97B6;
	Thu, 18 Sep 2025 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rKdUgwVB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2D22D77ED
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 06:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177499; cv=none; b=pD+r5+5IYbsK9HqdTIJYMoRG+++Foym+NS1yHx5Qz0o0mtJxLOqPMPfAfRfcRxkLtqNZ/odxWeStsWdHquK8nQNBCNA8yfKho8Xzm/8MV+SNvH+vH2pcTukmhK2mLPLGjEL0Du7AT34PW6cmrOggnbh3CANFBl5FpsCm+iMNsU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177499; c=relaxed/simple;
	bh=oEAkMPokEPthqy/sYUaxWKjhNDV64NNbfnLb9g0p/f0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QeaNtsAnEzOQ+BGd675X+WX6QVTsoldI9NzsKsYwmYeUZqH+OgGkVVFGRLo1pKBp243IXap4VD+adPDF50znNOAVRquOp5TxFWVhVZHG0UHmXSBYi8SptVpyaht1GmUyswyYSBwMoXOeUVMMT9Ji3MUbLO6eIF/trd1X8jDzhTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rKdUgwVB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5509ed1854so28463a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 23:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758177497; x=1758782297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EhQgZCX3g/hqgKkVAO2ALoNMZAYeb5CdIihGIJQ0jtk=;
        b=rKdUgwVBnpccRrpAHjyXiHImQVzf7FSNM4xbGaDma+o794KqHyzY9KS4FkbUm1nnM8
         ctY86EL1vQoId5pHHxCGJ3RDhIk5Jz3rgg9JzDx76XFsLn8fhDMeY33foRU3MxWf9uwX
         XfGFqwbeDPcPcYPiUDAO5y9G+g38CHy5cDEFWVf3W6NtB3sgCS2QRO7fcfWS2v5ZMl0n
         pYqELeu/x7u5JamfNRrM79eoFW5OlwGOrULAd4pUo4gH7fvh04jJ/6bEmoMEFz85uJEn
         cHHGObIs0Hxim88EulbnA0t6kIcqJaI2mwbg5ipSSXhTvlCszDQLC45kG7+IUF/SuPn9
         fksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758177497; x=1758782297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhQgZCX3g/hqgKkVAO2ALoNMZAYeb5CdIihGIJQ0jtk=;
        b=dP5b9jUVBMoseh7d73u5e5P+BG0Z9O967uFLUfbCgZNOGlt0bmAzddl6rbEw1a2W1E
         GDd8XKCRiTP3Ay+nvKpkLjNXm4ui9SBUgmSKrybHvt/eGLyOmPspVf+pa/7qQRVC9zi8
         6+yjVLCovcPquXrxT1tFXtr+MRVT5tIY2CQCEfsPb7zh0TOdd05NAm+1URnWsbXbdUCR
         7Xii9/IiEO+5Gb9YVA0+JqJqkTQiWp7EetXz9gYDtNlOwFQy0k3LDt27FbVwEhZHkv8l
         SvHaYIrivWQczAQcU39itk/r8IzcT4Y8aKoFDhbWYvYAbN5A1lKWOs23gSo02PsXacuX
         C4Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVqwG8wCg52SONzLEkOWShhKbPIcLQbbLLOSLTIbLzt+KV085JN2qC5PczyOBb7eYN49hv5r3m0H02eaiFw@vger.kernel.org
X-Gm-Message-State: AOJu0YxTDU/RBDovfJGMsOkEPatAxWGGcyUPHQHYGMtg2cRBKICNSRSi
	+BpvrNSRVXZVWIbj+b1tDnpNXOxAghpyv6guoWdDdp3U3MWevs34CCewrUMFzVX2qneBu6OrgUy
	P2F6EvF+mn+ExtL7xxWQGPPiKtQ==
X-Google-Smtp-Source: AGHT+IHY8aUBQSPecvIOlTBaO7WQ/oRvPgoE9Oznnfm9prH3oA8ybxcIs1MwL4W0ClARcwmzZJztakkHVEY0YIHinA==
X-Received: from pjbpw5.prod.google.com ([2002:a17:90b:2785:b0:330:7dd8:2dc2])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2c8c:b0:324:e96a:2ada with SMTP id 98e67ed59e1d1-32ee3f2ffefmr5352489a91.21.1758177497343;
 Wed, 17 Sep 2025 23:38:17 -0700 (PDT)
Date: Thu, 18 Sep 2025 06:38:16 +0000
In-Reply-To: <20250916225528.iycrfgf4nz6bcdce@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <b3c2da681c5bf139e2eaf0ea82c7422f972f6288.1747264138.git.ackerleytng@google.com>
 <20250916225528.iycrfgf4nz6bcdce@amd.com>
Message-ID: <diqzjz1wp8o7.fsf@google.com>
Subject: Re: [RFC PATCH v2 29/51] mm: guestmem_hugetlb: Wrap HugeTLB as an
 allocator for guest_memfd
From: Ackerley Tng <ackerleytng@google.com>
To: Michael Roth <michael.roth@amd.com>
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
	mic@digikod.net, mpe@ellerman.id.au, muchun.song@linux.dev, nikunj@amd.com, 
	nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, 
	qperret@google.com, quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
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

Michael Roth <michael.roth@amd.com> writes:

> On Wed, May 14, 2025 at 04:42:08PM -0700, Ackerley Tng wrote:
>> 
>> [...snip...]
>> 
>> +static void *guestmem_hugetlb_setup(size_t size, u64 flags)
>> +
>> +{
>> +	struct guestmem_hugetlb_private *private;
>> +	struct hugetlb_cgroup *h_cg_rsvd = NULL;
>> +	struct hugepage_subpool *spool;
>> +	unsigned long nr_pages;
>> +	int page_size_log;
>> +	struct hstate *h;
>> +	long hpages;
>> +	int idx;
>> +	int ret;
>> +
>> +	page_size_log = (flags >> GUESTMEM_HUGETLB_FLAG_SHIFT) &
>> +			GUESTMEM_HUGETLB_FLAG_MASK;
>> +	h = hstate_sizelog(page_size_log);
>> +	if (!h)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	/*
>> +	 * Check against h because page_size_log could be 0 to request default
>> +	 * HugeTLB page size.
>> +	 */
>> +	if (!IS_ALIGNED(size, huge_page_size(h)))
>> +		return ERR_PTR(-EINVAL);
>
> For SNP testing we ended up needing to relax this to play along a little
> easier with QEMU/etc. and instead just round the size up via:
>
>   size = round_up(size, huge_page_size(h));
>
> The thinking is that since, presumably, the size would span beyond what
> we actually bind to any memslots, that KVM will simply map them as 4K
> in nested page table, and userspace already causes 4K split and inode
> size doesn't change as part of this adjustment so the extra pages would
> remain inaccessible.
>
> The accounting might get a little weird but it's probably fair to
> document that non-hugepage-aligned gmemfd sizes can result in wasted memory
> if userspace wants to fine tune around that.

Is there a specific use case where the userspace VMM must allocate some
guest_memfd file size that isn't huge_page_size(h) aligned?

Rounding up silently feels like it would be hiding errors, and feels a
little especially when we're doing so much work to save memory,
retaining HVO, removing double allocation and all.

>
> -Mike
>
>> +
>> +	private = kzalloc(sizeof(*private), GFP_KERNEL);
>> +	if (!private)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	/* Creating a subpool makes reservations, hence charge for them now. */
>> +	idx = hstate_index(h);
>> +	nr_pages = size >> PAGE_SHIFT;
>> +	ret = hugetlb_cgroup_charge_cgroup_rsvd(idx, nr_pages, &h_cg_rsvd);
>> +	if (ret)
>> +		goto err_free;
>> +
>> +	hpages = size >> huge_page_shift(h);
>> +	spool = hugepage_new_subpool(h, hpages, hpages, false);
>> +	if (!spool)
>> +		goto err_uncharge;
>> +
>> +	private->h = h;
>> +	private->spool = spool;
>> +	private->h_cg_rsvd = h_cg_rsvd;
>> +
>> +	return private;
>> +
>> +err_uncharge:
>> +	ret = -ENOMEM;
>> +	hugetlb_cgroup_uncharge_cgroup_rsvd(idx, nr_pages, h_cg_rsvd);
>> +err_free:
>> +	kfree(private);
>> +	return ERR_PTR(ret);
>> +}
>> +
>> 
>> [...snip...]
>> 

