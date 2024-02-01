Return-Path: <linux-fsdevel+bounces-9914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A81845EB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 18:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A047FB25F31
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EE06FBA7;
	Thu,  1 Feb 2024 17:38:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4626FB88;
	Thu,  1 Feb 2024 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809136; cv=none; b=hPr1b6Nbmg16yTLAvC4i4/CnnPPS1Cx4DhhtpcTMbAsVlz6aFQBhmLzUsx2Amv2/vGz47kzSiICPWP9YdGKUVvO/ZcXzgD45F2fzgQRu0HujJVtq8b1zuQbBza5JodlA3E52nC1M/Z/yfHHtS2AkFHUcL60CbLUldwo/zTXVq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809136; c=relaxed/simple;
	bh=+jscayz1j5iTQ/gLXe+z+HvDEvJcz5+9nneP6cJ+HKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1Oy54BLboD4+svxMA0HRo41tJ+2bcrddkoFADgqFDbHUU9IMwqoOxBzB8XccNQrhMK2fPukgZFprHGGr8nucHvaMzSTZqE3vJcZZ909Zyt9TD/4PZP6bdtBI/70ea3rkwmTNB3YCDoFwrTJm1ZJiJ9Zw5XjffuJO6ItZC22Hps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32134DA7;
	Thu,  1 Feb 2024 09:39:36 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95BF13F738;
	Thu,  1 Feb 2024 09:38:48 -0800 (PST)
Date: Thu, 1 Feb 2024 17:38:42 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, vincenzo.frascino@arm.com, david@redhat.com,
	eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 31/35] khugepaged: arm64: Don't collapse MTE
 enabled VMAs
Message-ID: <ZbvXImzAJNKQvamJ@raptor>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-32-alexandru.elisei@arm.com>
 <599769c3-0aef-4c5b-ac98-f109649862f7@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <599769c3-0aef-4c5b-ac98-f109649862f7@arm.com>

On Thu, Feb 01, 2024 at 01:42:08PM +0530, Anshuman Khandual wrote:
> 
> 
> On 1/25/24 22:12, Alexandru Elisei wrote:
> > copy_user_highpage() will do memory allocation if there are saved tags for
> > the destination page, and the page is missing tag storage.
> > 
> > After commit a349d72fd9ef ("mm/pgtable: add rcu_read_lock() and
> > rcu_read_unlock()s"), collapse_huge_page() calls
> > __collapse_huge_page_copy() -> .. -> copy_user_highpage() with the RCU lock
> > held, which means that copy_user_highpage() can only allocate memory using
> > GFP_ATOMIC or equivalent.
> > 
> > Get around this by refusing to collapse pages into a transparent huge page
> > if the VMA is MTE-enabled.
> 
> Makes sense when copy_user_highpage() will allocate memory for tag storage.
> 
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> > 
> > Changes since rfc v2:
> > 
> > * New patch. I think an agreement on whether copy*_user_highpage() should be
> > always allowed to sleep, or should not be allowed, would be useful.
> 
> This is a good question ! Even after preventing the collapse of MTE VMA here,
> there still might be more paths where a sleeping (i.e memory allocating)
> copy*_user_highpage() becomes problematic ?

Exactly!

> 
> > 
> >  arch/arm64/include/asm/pgtable.h    | 3 +++
> >  arch/arm64/kernel/mte_tag_storage.c | 5 +++++
> >  include/linux/khugepaged.h          | 5 +++++
> >  mm/khugepaged.c                     | 4 ++++
> >  4 files changed, 17 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index 87ae59436162..d0473538c926 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -1120,6 +1120,9 @@ static inline bool arch_alloc_cma(gfp_t gfp_mask)
> >  	return true;
> >  }
> >  
> > +bool arch_hugepage_vma_revalidate(struct vm_area_struct *vma, unsigned long address);
> > +#define arch_hugepage_vma_revalidate arch_hugepage_vma_revalidate
> > +
> >  #endif /* CONFIG_ARM64_MTE_TAG_STORAGE */
> >  #endif /* CONFIG_ARM64_MTE */
> >  
> > diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
> > index ac7b9c9c585c..a99959b70573 100644
> > --- a/arch/arm64/kernel/mte_tag_storage.c
> > +++ b/arch/arm64/kernel/mte_tag_storage.c
> > @@ -636,3 +636,8 @@ void arch_alloc_page(struct page *page, int order, gfp_t gfp)
> >  	if (tag_storage_enabled() && alloc_requires_tag_storage(gfp))
> >  		reserve_tag_storage(page, order, gfp);
> >  }
> > +
> > +bool arch_hugepage_vma_revalidate(struct vm_area_struct *vma, unsigned long address)
> > +{
> > +	return !(vma->vm_flags & VM_MTE);
> > +}
> > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > index f68865e19b0b..461e4322dff2 100644
> > --- a/include/linux/khugepaged.h
> > +++ b/include/linux/khugepaged.h
> > @@ -38,6 +38,11 @@ static inline void khugepaged_exit(struct mm_struct *mm)
> >  	if (test_bit(MMF_VM_HUGEPAGE, &mm->flags))
> >  		__khugepaged_exit(mm);
> >  }
> > +
> > +#ifndef arch_hugepage_vma_revalidate
> > +#define arch_hugepage_vma_revalidate(vma, address) 1
> 
> Please replace s/1/true as arch_hugepage_vma_revalidate() returns bool ?

Yeah, that's strange, I don't know why I used 1 there. Will change it to true,
thanks for spotting it.

> 
> > +#endif
> 
> Right, above construct is much better than __HAVE_ARCH_XXXX based one.

Thanks!

Alex

> 
> > +
> >  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
> >  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
> >  {
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 2b219acb528e..cb9a9ddb4d86 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -935,6 +935,10 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> >  	 */
> >  	if (expect_anon && (!(*vmap)->anon_vma || !vma_is_anonymous(*vmap)))
> >  		return SCAN_PAGE_ANON;
> > +
> > +	if (!arch_hugepage_vma_revalidate(vma, address))
> > +		return SCAN_VMA_CHECK;
> > +
> >  	return SCAN_SUCCEED;
> >  }
> >  
> 
> Otherwise this LGTM.

