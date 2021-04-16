Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE26362C04
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 01:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhDPXsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 19:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhDPXsX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 19:48:23 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18E1C061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 16:47:57 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id f19so12933442qka.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 16:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=sVPIE7b9A9r5c+fCDTLS6SJG4Vo5Oo7dtEBKz/j1+B8=;
        b=shtb1H8LFeSIDwuFBEraimbXKlxH6R7HBn6V0xKIhXZfpaqSxrvEWgwZWvBWNB5T9S
         qwRBcnVyBN9tluAgZD6idzzgVBcD40Nk+TUU1oHsAQxspH1ksp6Lxzo72ys7r5qXHT37
         82rc3eRap9W1UQIFjtcUjffQinSBs74/NBcOykvvRdBeMDUgVqd+5cIxmJvvA/OQgLXb
         W6IOCcA6TemBMGL8pNXK7liFr7l6MLyVOqUprMccNoPhbvMXRj6+MTMcitZEe8K7auD9
         iAhPMszlBlgnjnwU38dLNOcr+2htR4Ppi+1EsuVxykMmf6p71vPZP2e26JK9iPeIQQ05
         Royg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=sVPIE7b9A9r5c+fCDTLS6SJG4Vo5Oo7dtEBKz/j1+B8=;
        b=k4i5Wfli6Rk+x42q3UDUS+THxR+YunnTvoJYTxDEMLy1pJViq9uLc/NDXhjCDKIwUg
         +iWv6VjtWv36QyJFXrPzFtSvlXcE7Pz1WfFp3tNUQvILNy+f7EtPPg72NASiaK/SWQiP
         kkCPZCATEMn36UKXeXHOU9We114SNGojRB0HboTQXgkHIjayyzShVimExqEeVp5I/4xc
         qi8uan5J8L32HX1MwQO0X0JtgbqGFYpvmOfrWgJ8CqyU3qet0lUt8MDWxabw3X1w+bGi
         eHX4l0KA8gXNOpMH32jzKw9V9nWhE74Tg/yLPFn8MGNk3B7f+1IiJk3Rr/L1oOn5+Iwm
         aoyA==
X-Gm-Message-State: AOAM532j6lKg26hxCGaU9JWxzpZbg0HUdTThoL+kgynsddIFRCVK4QM/
        Xm+algPMM6X+wvXWnqQAvAU6QQ==
X-Google-Smtp-Source: ABdhPJxemUFq/3RdHXcF79aL4vX+Eny7TmHIWaXkRsSFmJvqMmzuJtXU5sos9D7TCVgF/k3NPLY/1A==
X-Received: by 2002:a37:7d84:: with SMTP id y126mr1703720qkc.155.1618616876418;
        Fri, 16 Apr 2021 16:47:56 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v3sm4711320qtp.31.2021.04.16.16.47.53
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 16 Apr 2021 16:47:55 -0700 (PDT)
Date:   Fri, 16 Apr 2021 16:47:42 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v2 4/9] userfaultfd/shmem: support UFFDIO_CONTINUE for
 shmem
In-Reply-To: <20210413051721.2896915-5-axelrasmussen@google.com>
Message-ID: <alpine.LSU.2.11.2104161643590.25373@eggly.anvils>
References: <20210413051721.2896915-1-axelrasmussen@google.com> <20210413051721.2896915-5-axelrasmussen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 12 Apr 2021, Axel Rasmussen wrote:

> With this change, userspace can resolve a minor fault within a
> shmem-backed area with a UFFDIO_CONTINUE ioctl. The semantics for this
> match those for hugetlbfs - we look up the existing page in the page
> cache, and install PTEs for it.

s/PTEs/a PTE/

> 
> This commit introduces a new helper: mcopy_atomic_install_ptes.

The plural is misleading: it only installs a single pte, so I'm going
to ask you to change it throughout to mcopy_atomic_install_pte()
(I'm not thrilled with the "mcopy" nor the "atomic", but there you are
being consistent with userfaultfd's peculiar naming, so let them be).

> 
> Why handle UFFDIO_CONTINUE for shmem in mm/userfaultfd.c, instead of in
> shmem.c? The existing userfault implementation only relies on shmem.c
> for VM_SHARED VMAs. However, minor fault handling / CONTINUE work just
> fine for !VM_SHARED VMAs as well. We'd prefer to handle CONTINUE for
> shmem in one place, regardless of shared/private (to reduce code
> duplication).
> 
> Why add a new mcopy_atomic_install_ptes helper? A problem we have with
> continue is that shmem_mcopy_atomic_pte() and mcopy_atomic_pte() are
> *close* to what we want, but not exactly. We do want to setup the PTEs
> in a CONTINUE operation, but we don't want to e.g. allocate a new page,
> charge it (e.g. to the shmem inode), manipulate various flags, etc. Also
> we have the problem stated above: shmem_mcopy_atomic_pte() and
> mcopy_atomic_pte() both handle one-half of the problem (shared /
> private) continue cares about. So, introduce mcontinue_atomic_pte(), to
> handle all of the shmem continue cases. Introduce the helper so it
> doesn't duplicate code with mcopy_atomic_pte().
> 
> In a future commit, shmem_mcopy_atomic_pte() will also be modified to
> use this new helper. However, since this is a bigger refactor, it seems
> most clear to do it as a separate change.

(Actually that turns out to be a nice deletion of lines,
but you're absolutely right to do it as a separate patch.)

> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  mm/userfaultfd.c | 176 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 131 insertions(+), 45 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 23fa2583bbd1..8df0438f5d6a 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -48,6 +48,87 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
>  	return dst_vma;
>  }
>  
> +/*
> + * Install PTEs, to map dst_addr (within dst_vma) to page.
> + *
> + * This function handles MCOPY_ATOMIC_CONTINUE (which is always file-backed),
> + * whether or not dst_vma is VM_SHARED. It also handles the more general
> + * MCOPY_ATOMIC_NORMAL case, when dst_vma is *not* VM_SHARED (it may be file
> + * backed, or not).
> + *
> + * Note that MCOPY_ATOMIC_NORMAL for a VM_SHARED dst_vma is handled by
> + * shmem_mcopy_atomic_pte instead.

Right, I'm thinking in terms of five cases below (I'm not for a moment
saying that you need to list these out in the comment, just saying that
I could not get my head around the issues in this function without
listing them out for myself):

1. anon private mcopy (using anon page newly allocated)
2. shmem private mcopy (using anon page newly allocated)
3. shmem private mcontinue (using page in cache from shmem_getpage)
4. shmem shared mcontinue (using page in cache from shmem_getpage)
5. shmem shared mcopy (using page in cache newly allocated)

Of which each has a VM_WRITE and a !VM_WRITE case; and the third and
fourth cases are new in this patch (it really would have been better
to introduce mcopy_atomic_install_pte() in a separate earlier patch,
but don't change that now we've got this far); and the fifth case does
*not* use mcopy_atomic_install_pte() in this patch, but will in future.

And while making these notes, let's hightlight again what is commented
elsewhere, the odd nature of the second case: where userfaultfd short
circuits to an anonymous CoW page without instantiating the shmem page.
(Please double-check me on that: quite a lot of my comments below are
about this case 2, so if I've got it wrong, then I've got a lot wrong.)

> + */
> +static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,

mcopy_atomic_install_pte() throughout please.

> +				     struct vm_area_struct *dst_vma,
> +				     unsigned long dst_addr, struct page *page,
> +				     bool newly_allocated, bool wp_copy)
> +{
> +	int ret;
> +	pte_t _dst_pte, *dst_pte;
> +	int writable;

Sorry, it's silly of me, but I keep getting irritated by "int writable"
in company with the various bools; and the way vm_shared is initialized
below, but writable initialized later.  Please humour me by making it
	bool writable = dst_vma->vm_flags & VM_WRITE;

> +	bool vm_shared = dst_vma->vm_flags & VM_SHARED;

And I've found that we also need
	bool page_in_cache = page->mapping;
because an anonymous page does not at this point have page->mapping
set, and does not yet satisfy PageAnon(page).  Or other naming if you
think of better; or its inverse with page_is_anon or whatever.

> +	spinlock_t *ptl;
> +	struct inode *inode;
> +	pgoff_t offset, max_off;
> +
> +	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
> +	writable = dst_vma->vm_flags & VM_WRITE;
> +	/* For private, non-anon we need CoW (don't write to page cache!) */
> +	if (!vma_is_anonymous(dst_vma) && !vm_shared)
> +		writable = 0;

That appears to differ slightly from what was done before this patch:
it is now making a case 2 VM_WRITE pte unwritable, incurring an
unnecessary write fault later on.  I think it would be better
(for all fives cases) to say:

	if (page_in_cache && !vm_shared)
		writable = false;

> +
> +	if (writable || vma_is_anonymous(dst_vma))
> +		_dst_pte = pte_mkdirty(_dst_pte);

And, unlike before, that is not marking the case 2 unwritable pte dirty.
Which works okay, because add_to_swap()'s unconditional set_page_dirty()
will make sure this page is written to swap before it is freed.  But I'd
rather not rely on that here: it's a detail which might get changed one
day, and whoever changes it may not think to update mm/userfaultfd.c.

Sticking with Andrea's caution about marking a shared unwritable dirty,
but happy as before to mark a private unwritable dirty:

	if (writable || !page_in_cache)
		_dst_pte = pte_mkdirty(_dst_pte);

This does *not* mark the new cases 3 and 4 dirty when unwritable,
but there's no chance of data loss in their case, because the kernel
has not modified the page's data: the page from shmem_getpage()
is already marked correctly (usually PageDirty, but there's a
mapped-hole case where it might not be, and that is still correct).

(Why do we mark these pages dirty when writable? To skip a hardware
fault when and if the page is written later; but I'm not sure whether
that's necessarily a good idea - we don't know here whether it was a
write fault which triggered all this. I also don't know what difference
wp_copy, which skips the mkwrite, makes to this calculus; but follow
the example of before.)

> +	if (writable) {
> +		if (wp_copy)
> +			_dst_pte = pte_mkuffd_wp(_dst_pte);
> +		else
> +			_dst_pte = pte_mkwrite(_dst_pte);
> +	}

Fine.

          else if (vm_shared) {
> +		/*
> +		 * Since we didn't pte_mkdirty(), mark the page dirty or it
> +		 * could be freed from under us. We could do this
> +		 * unconditionally, but doing it only if !writable is faster.
> +		 */
> +		set_page_dirty(page);
> +	}

But delete this block, as we all wanted. As I've argued above,
the new cases 3 and 4 using shmem_getpage() do not need an extra
set_page_dirty() here, and we can address case 5 when it's added.

> +
> +	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> +
> +	if (vma_is_shmem(dst_vma)) {
> +		/* serialize against truncate with the page table lock */
> +		inode = dst_vma->vm_file->f_inode;
> +		offset = linear_page_index(dst_vma, dst_addr);
> +		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> +		ret = -EFAULT;
> +		if (unlikely(offset >= max_off))
> +			goto out_unlock;
> +	}
> +
> +	ret = -EEXIST;
> +	if (!pte_none(*dst_pte))
> +		goto out_unlock;
> +
> +	inc_mm_counter(dst_mm, mm_counter(page));

Hard to spot, but that's wrong: because mm_counter() depends on PageAnon
to decide which count to adjust, and that does not get set until the
page_add_new_anon_rmap(). I'd expect your tests to have left "Bad rss"
warnings in the kernel log? This would be why. Just move the line down
until after page_add_new_anon_rmap() - with a comment line to say why!

> +	if (vma_is_shmem(dst_vma))

No, that gets case 2 wrong: use "if (page_in_cache)" instead.

> +		page_add_file_rmap(page, false);
> +	else
> +		page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
> +
> +	if (newly_allocated)
> +		lru_cache_add_inactive_or_unevictable(page, dst_vma);
> +
> +	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> +
> +	/* No need to invalidate - it was non-present before */
> +	update_mmu_cache(dst_vma, dst_addr, dst_pte);
> +	ret = 0;
> +out_unlock:
> +	pte_unmap_unlock(dst_pte, ptl);
> +	return ret;
> +}
> +
>  static int mcopy_atomic_pte(struct mm_struct *dst_mm,
>  			    pmd_t *dst_pmd,
>  			    struct vm_area_struct *dst_vma,
> @@ -56,13 +137,9 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
>  			    struct page **pagep,
>  			    bool wp_copy)
>  {
> -	pte_t _dst_pte, *dst_pte;
> -	spinlock_t *ptl;
>  	void *page_kaddr;
>  	int ret;
>  	struct page *page;
> -	pgoff_t offset, max_off;
> -	struct inode *inode;
>  
>  	if (!*pagep) {
>  		ret = -ENOMEM;
> @@ -99,43 +176,12 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	if (mem_cgroup_charge(page, dst_mm, GFP_KERNEL))
>  		goto out_release;
>  
> -	_dst_pte = pte_mkdirty(mk_pte(page, dst_vma->vm_page_prot));
> -	if (dst_vma->vm_flags & VM_WRITE) {
> -		if (wp_copy)
> -			_dst_pte = pte_mkuffd_wp(_dst_pte);
> -		else
> -			_dst_pte = pte_mkwrite(_dst_pte);
> -	}
> -
> -	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> -	if (dst_vma->vm_file) {
> -		/* the shmem MAP_PRIVATE case requires checking the i_size */
> -		inode = dst_vma->vm_file->f_inode;
> -		offset = linear_page_index(dst_vma, dst_addr);
> -		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> -		ret = -EFAULT;
> -		if (unlikely(offset >= max_off))
> -			goto out_release_uncharge_unlock;
> -	}
> -	ret = -EEXIST;
> -	if (!pte_none(*dst_pte))
> -		goto out_release_uncharge_unlock;
> -
> -	inc_mm_counter(dst_mm, MM_ANONPAGES);
> -	page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
> -	lru_cache_add_inactive_or_unevictable(page, dst_vma);
> -
> -	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> -
> -	/* No need to invalidate - it was non-present before */
> -	update_mmu_cache(dst_vma, dst_addr, dst_pte);
> -
> -	pte_unmap_unlock(dst_pte, ptl);
> -	ret = 0;
> +	ret = mcopy_atomic_install_ptes(dst_mm, dst_pmd, dst_vma, dst_addr,
> +					page, true, wp_copy);
> +	if (ret)
> +		goto out_release;
>  out:
>  	return ret;
> -out_release_uncharge_unlock:
> -	pte_unmap_unlock(dst_pte, ptl);
>  out_release:
>  	put_page(page);
>  	goto out;
> @@ -176,6 +222,41 @@ static int mfill_zeropage_pte(struct mm_struct *dst_mm,
>  	return ret;
>  }
>  
> +/* Handles UFFDIO_CONTINUE for all shmem VMAs (shared or private). */
> +static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
> +				pmd_t *dst_pmd,
> +				struct vm_area_struct *dst_vma,
> +				unsigned long dst_addr,
> +				bool wp_copy)
> +{
> +	struct inode *inode = file_inode(dst_vma->vm_file);
> +	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
> +	struct page *page;
> +	int ret;
> +
> +	ret = shmem_getpage(inode, pgoff, &page, SGP_READ);
> +	if (ret)
> +		goto out;
> +	if (!page) {
> +		ret = -EFAULT;
> +		goto out;
> +	}

Right, I'll go along with that. I did say to use SGP_CACHE, and I'm not
sure why you did not, but perhaps were put off it by my remarks about a
racing hole punch. Using SGP_READ here, you will not allocate an
unnecessary page in that (exceptional) case, good; but you are left with
inconsistent behaviour on fallocated (!PageUptodate: the page has been
allocated, but not yet cleared or overwritten with user data) pages.

No bad data is leaked, but the inconsistency is that handle_userfault()
believes there's a page at this offset, but mcontinue_atomic_pte() says
there is not (and might they retry forever disagreeing?). It's a somewhat
grey area: I'd say your mcontinue_atomic_pte() is the correct one (it is
a hole, but one that we happen to have reserved future space for); but
that we don't really want to complicate the other end for it (if we skip
going the VM_UFFD_MINOR way, it's more of a problem for VM_UFFD_MISSING).

I think stick with SGP_READ as you have: just be aware at the userspace
end that this case might occur (and you only have to fault the page into
the other mapping to resolve it), if anyone is using fallocate().

All the rest of 4/9 looked fine to me, though I have worried about a
couple more things.

One: whereas I tend to think of one call to handle_userfault() ending
up in one call to mcopy_atomic_install_pte() to resolve it, I see that
actually __mcopy_atomic() can be a loop over many pages, and I have
not thought through all the possibilities that might allow, and now
with the interspersal of MINOR and MISSING.

Two: mcopy_atomic_install_pte() can only install a pte, and it looks
as if it handles tails of a compound page correctly (as might come
from a MINOR userfault on a pre-existing shmem THP); but there is no
mapping of huge page by pmd, and khugepaged's userfaultfd_armed()
checks will (rightly) keep it from interfering. I guess later on,
after all the userfaultfd-ing is done, khugepaged can come around
and collapse to huge pages, if the file was on a huge mount: okay.

Hugh

> +
> +	ret = mcopy_atomic_install_ptes(dst_mm, dst_pmd, dst_vma, dst_addr,
> +					page, false, wp_copy);
> +	if (ret)
> +		goto out_release;
> +
> +	unlock_page(page);
> +	ret = 0;
> +out:
> +	return ret;
> +out_release:
> +	unlock_page(page);
> +	put_page(page);
> +	goto out;
> +}
> +
>  static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
>  {
>  	pgd_t *pgd;
> @@ -415,11 +496,16 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
>  						unsigned long dst_addr,
>  						unsigned long src_addr,
>  						struct page **page,
> -						bool zeropage,
> +						enum mcopy_atomic_mode mode,
>  						bool wp_copy)
>  {
>  	ssize_t err;
>  
> +	if (mode == MCOPY_ATOMIC_CONTINUE) {
> +		return mcontinue_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> +					    wp_copy);
> +	}
> +
>  	/*
>  	 * The normal page fault path for a shmem will invoke the
>  	 * fault, fill the hole in the file and COW it right away. The
> @@ -431,7 +517,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
>  	 * and not in the radix tree.
>  	 */
>  	if (!(dst_vma->vm_flags & VM_SHARED)) {
> -		if (!zeropage)
> +		if (mode == MCOPY_ATOMIC_NORMAL)
>  			err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
>  					       dst_addr, src_addr, page,
>  					       wp_copy);
> @@ -441,7 +527,8 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
>  	} else {
>  		VM_WARN_ON_ONCE(wp_copy);
>  		err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
> -					     dst_addr, src_addr, zeropage,
> +					     dst_addr, src_addr,
> +					     mode != MCOPY_ATOMIC_NORMAL,
>  					     page);
>  	}
>  
> @@ -463,7 +550,6 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>  	long copied;
>  	struct page *page;
>  	bool wp_copy;
> -	bool zeropage = (mcopy_mode == MCOPY_ATOMIC_ZEROPAGE);
>  
>  	/*
>  	 * Sanitize the command parameters:
> @@ -526,7 +612,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>  
>  	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
>  		goto out_unlock;
> -	if (mcopy_mode == MCOPY_ATOMIC_CONTINUE)
> +	if (!vma_is_shmem(dst_vma) && mcopy_mode == MCOPY_ATOMIC_CONTINUE)
>  		goto out_unlock;
>  
>  	/*
> @@ -574,7 +660,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>  		BUG_ON(pmd_trans_huge(*dst_pmd));
>  
>  		err = mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> -				       src_addr, &page, zeropage, wp_copy);
> +				       src_addr, &page, mcopy_mode, wp_copy);
>  		cond_resched();
>  
>  		if (unlikely(err == -ENOENT)) {
> -- 
> 2.31.1.295.g9ea45b61b8-goog
