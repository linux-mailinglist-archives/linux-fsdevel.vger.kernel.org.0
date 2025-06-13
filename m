Return-Path: <linux-fsdevel+bounces-51638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BED5AD9809
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 00:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91236188FF60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 22:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA94428DB56;
	Fri, 13 Jun 2025 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0QSf5fzl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CF528BAAF
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749852457; cv=none; b=U647zbcreNgeXobbfm3pGJIqfG1dLep6NeTLVa6c84pICn/FPMTMTaDmdGUtqEDCYEfxUyE6anRFH6j0iUJW2nCf2Z7bq157pC1s9oQi57ZjlA8q/hsJpRfdttsacxLsYCGePvMBepEqb6TNz1H6aWWKyX278eDoRpESxAet6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749852457; c=relaxed/simple;
	bh=5LQDwgXZiTJZifCIskJfO8E5M68MeEmmWIMewJk/ejw=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=VkbqWVm20ry4PI0eYqLXliNGw/4hUhw4r3TToGgDsdHWn2AmXbRfuBVx/NHxfnQ2QHnCmhZKdrgGjf+xnycyR9+5uZRJNgORnC7Ki1jGce5IO+uNqgcxLG3mY+cRAOqJ/uXPiuV/LF9uBKbq5Zij8i1dU6g5OQ2WSjw9ub+F+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0QSf5fzl; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b0e0c573531so1497031a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 15:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749852454; x=1750457254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jHrVv2kDcovHNoP3EEC76tcx39dbcoagl8VnybVR6Q8=;
        b=0QSf5fzlMGtX0Pn75NwkwkK0kZumjQz1FggRUy6UK32q5jjWMAC9zOTemgzXCGvSF+
         pG/HZjYnhMT4m8LU2WIKVf2CPJ1NoMTtwuFym4u/uoX8vB/3s/9YJyjukGoPIB6IXx37
         /sdYtGBaw5DJ3BPN40i3wQkhfFt/vSBh2Ttj2TB62g0s0oh/Gok5GamUetIDzAgEDKWE
         g32ltwFtLAGqDZh+a9b/JZY35pxcuYtS3P1dzx7Qi8U2VNfeb9pYfTj1FMe6BELbd105
         /ND3PKyanhmapwizsk0QC07VkkIp7IkqD/6BCSxFtPoETQxbFoDSWyHgTGMevk9LcJ6y
         NEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749852454; x=1750457254;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jHrVv2kDcovHNoP3EEC76tcx39dbcoagl8VnybVR6Q8=;
        b=c8B0b+gxH9450uSmA02bF6r1vuamy/8PtM5Gz3WJlrnR7giPprb6HT5IiIcGsx8VxB
         OOW/YJx3mUjpowFMK74GZeCbHbOoUF+pDyTpyP8XEx1d+nW07HOEyXpOPTXYgqBl0U4k
         YKz6PW/BxcoznXfAWmhENzpUbvotv44HwhfftWTWK6sCONdQkDPAb0x+p+PTsVZrkiYL
         OoukVp0nsITzMsNooPHllZnOV0u/Z6TqM5glGlVtCpRqthxLRQb+vDNKIUTB9J20QBl6
         Kduaz66Dk2EBYjgVuAX3huTMfqIOHLC+/E+tOkBkrF3Nbu/Lv18ltChNI1qWXMxj9X1b
         7raQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhzJV3jkcxRVAX8E+lsGFbJ5XnCid+ohvBBSfmdvUYhIttTMleOyH4c1oMlMR2smAmEygsxicEwSS895fm@vger.kernel.org
X-Gm-Message-State: AOJu0YyHrffiloCB5N3nRty0G2h9gbyFMLTchvrLX/et74apiRWgFogY
	/WfqVJtSsoQEIb7rZDD7XpPBz9y3eRPt1nJ+PsiBCG2JEWzllUfZ1nXQhDOXKzUW6p/59bQ/isQ
	CZ64lyjvpsZcdc3lk3WBwtJOy5Q==
X-Google-Smtp-Source: AGHT+IFVHWXFz2fZtkBz3H5QkGTBOJiqvd4jqlHEGetNFDiMdeIl66etnmH5TFa6nz2Zwxoho7DNwLI7pEhSfm9NmQ==
X-Received: from pgbfy15.prod.google.com ([2002:a05:6a02:2a8f:b0:b2e:c15e:3eb7])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3943:b0:21f:97f3:d4c2 with SMTP id adf61e73a8af0-21fbd525cffmr1383658637.16.1749852454508;
 Fri, 13 Jun 2025 15:07:34 -0700 (PDT)
Date: Fri, 13 Jun 2025 15:07:33 -0700
In-Reply-To: <683ba0fe64dd5_13031529421@iweiny-mobl.notmuch> (message from Ira
 Weiny on Sat, 31 May 2025 19:38:22 -0500)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzsek3mh22.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 23/51] mm: hugetlb: Refactor out hugetlb_alloc_folio()
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
>> Refactor out hugetlb_alloc_folio() from alloc_hugetlb_folio(), which
>> handles allocation of a folio and cgroup charging.
>>
>> Other than flags to control charging in the allocation process,
>> hugetlb_alloc_folio() also has parameters for memory policy.
>>
>> This refactoring as a whole decouples the hugetlb page allocation from
>> hugetlbfs, (1) where the subpool is stored at the fs mount, (2)
>> reservations are made during mmap and stored in the vma, and (3) mpol
>> must be stored at vma->vm_policy (4) a vma must be used for allocation
>> even if the pages are not meant to be used by host process.
>>
>> This decoupling will allow hugetlb_alloc_folio() to be used by
>> guest_memfd in later patches. In guest_memfd, (1) a subpool is created
>> per-fd and is stored on the inode, (2) no vma-related reservations are
>> used (3) mpol may not be associated with a vma since (4) for private
>> pages, the pages will not be mappable to userspace and hence have to
>> associated vmas.
>>
>> This could hopefully also open hugetlb up as a more generic source of
>> hugetlb pages that are not bound to hugetlbfs, with the complexities
>> of userspace/mmap/vma-related reservations contained just to
>> hugetlbfs.
>>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> Change-Id: I60528f246341268acbf0ed5de7752ae2cacbef93
>> ---
>>  include/linux/hugetlb.h |  12 +++
>>  mm/hugetlb.c            | 192 ++++++++++++++++++++++------------------
>>  2 files changed, 118 insertions(+), 86 deletions(-)
>>
>
> [snip]
>
>>
>> +/**
>> + * hugetlb_alloc_folio() - Allocates a hugetlb folio.
>> + *
>> + * @h: struct hstate to allocate from.
>> + * @mpol: struct mempolicy to apply for this folio allocation.
>> + * @ilx: Interleave index for interpretation of @mpol.
>> + * @charge_cgroup_rsvd: Set to true to charge cgroup reservation.
>> + * @use_existing_reservation: Set to true if this allocation should use an
>> + *                            existing hstate reservation.
>> + *
>> + * This function handles cgroup and global hstate reservations. VMA-related
>> + * reservations and subpool debiting must be handled by the caller if necessary.
>> + *
>> + * Return: folio on success or negated error otherwise.
>> + */
>> +struct folio *hugetlb_alloc_folio(struct hstate *h, struct mempolicy *mpol,
>> +				  pgoff_t ilx, bool charge_cgroup_rsvd,
>> +				  bool use_existing_reservation)
>> +{
>> +	unsigned int nr_pages = pages_per_huge_page(h);
>> +	struct hugetlb_cgroup *h_cg = NULL;
>> +	struct folio *folio = NULL;
>> +	nodemask_t *nodemask;
>> +	gfp_t gfp_mask;
>> +	int nid;
>> +	int idx;
>> +	int ret;
>> +
>> +	idx = hstate_index(h);
>> +
>> +	if (charge_cgroup_rsvd) {
>> +		if (hugetlb_cgroup_charge_cgroup_rsvd(idx, nr_pages, &h_cg))
>> +			goto out;
>
> Why not just return here?
> 			return ERR_PTR(-ENOSPC);
>

I wanted to consistently exit the function on errors at the same place,
and also make this refactoring look like I just took the middle of
alloc_hugetlb_folio() out as much as possible.

>> +	}
>> +
>> +	if (hugetlb_cgroup_charge_cgroup(idx, nr_pages, &h_cg))
>> +		goto out_uncharge_cgroup_reservation;
>> +
>> +	gfp_mask = htlb_alloc_mask(h);
>> +	nid = policy_node_nodemask(mpol, gfp_mask, ilx, &nodemask);
>> +
>> +	spin_lock_irq(&hugetlb_lock);
>> +
>> +	if (use_existing_reservation || available_huge_pages(h))
>> +		folio = dequeue_hugetlb_folio(h, gfp_mask, mpol, nid, nodemask);
>> +
>> +	if (!folio) {
>> +		spin_unlock_irq(&hugetlb_lock);
>> +		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, mpol, nid, nodemask);
>> +		if (!folio)
>> +			goto out_uncharge_cgroup;
>> +		spin_lock_irq(&hugetlb_lock);
>> +		list_add(&folio->lru, &h->hugepage_activelist);
>> +		folio_ref_unfreeze(folio, 1);
>> +		/* Fall through */
>> +	}
>> +
>> +	if (use_existing_reservation) {
>> +		folio_set_hugetlb_restore_reserve(folio);
>> +		h->resv_huge_pages--;
>> +	}
>> +
>> +	hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, folio);
>> +
>> +	if (charge_cgroup_rsvd)
>> +		hugetlb_cgroup_commit_charge_rsvd(idx, nr_pages, h_cg, folio);
>> +
>> +	spin_unlock_irq(&hugetlb_lock);
>> +
>> +	gfp_mask = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
>> +	ret = mem_cgroup_charge_hugetlb(folio, gfp_mask);
>> +	/*
>> +	 * Unconditionally increment NR_HUGETLB here. If it turns out that
>> +	 * mem_cgroup_charge_hugetlb failed, then immediately free the page and
>> +	 * decrement NR_HUGETLB.
>> +	 */
>> +	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
>> +
>> +	if (ret == -ENOMEM) {
>> +		free_huge_folio(folio);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	return folio;
>> +
>> +out_uncharge_cgroup:
>> +	hugetlb_cgroup_uncharge_cgroup(idx, nr_pages, h_cg);
>> +out_uncharge_cgroup_reservation:
>> +	if (charge_cgroup_rsvd)
>> +		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, nr_pages, h_cg);
>
> I find the direct copy of the unwind logic from alloc_hugetlb_folio()
> cumbersome and it seems like a good opportunity to clean it up.
>

I really wanted to make this refactoring look like I just took the
middle of alloc_hugetlb_folio() out as much as possible, to make it
obvious and understandable. I think the cleanup can be a separate patch
(series?)

>> +out:
>> +	folio = ERR_PTR(-ENOSPC);
>> +	goto out;
>
> Endless loop?
>

Thanks, this should have been

return folio;

> Ira
>
> [snip]

