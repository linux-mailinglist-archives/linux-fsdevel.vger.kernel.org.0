Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE6362C75
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 02:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhDQAfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 20:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbhDQAfO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 20:35:14 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF79C061760
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 17:34:47 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id e13so20877410qkl.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 17:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=uIksWak7SFr1E70pBah+NSYxowBoEqEgg2o79SFp6/s=;
        b=eeco8Eo1b6XKreVLdrIzFapBg3OD6V7CQTsi7hbrcAVdqLjwYSdqYzWpWwUFD+rf5s
         907v7V2n0Y2Frm9zSEuym+yCSLuojvf+R4W8RGdQ3WiqWpvxJbqAWDA9l2CLozizDWTX
         dXpuVwyDIl2xqjAwMLfBMuGjoMpMirWVZrJrFfAAaxZvXOi2K1+gMybaX5O6nq5PqEF9
         /+H8xMC7/ryI44kPHMTVuQpcJiVoqejoCjiqrY0puDIde83w5Tmk3UHgQN+HrAPfR3m0
         32FgeEIUK9kJBKHv6bJD16ImvNCDJno4x/CPtx+I9BMrtBhlToqV8tE+m0KlXUeopisC
         3IQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=uIksWak7SFr1E70pBah+NSYxowBoEqEgg2o79SFp6/s=;
        b=l0/QffID7GUzMPdeSYQ7jiII2WC2AQ8UAhrrzbBVzpku7RetTl4N3RTdWDrmx82pt4
         ZBU5U3L50cv+YBTkNs4z3S8I9VYH65LRpOU/xGM3NvDYTqG3yNsa962u2uWjVAOns/lt
         8OQIFIcxcs2FJZ+0NsDbW+ePN1cqNptJiHDUn040WxTBPJF3O+HiZVGORtA8DaYQBaBy
         24b2CPlEG5WZSBs2HaxroBCW+/c0naO0y4dIPf759zTbA/zkGwJnjynIfZ87w5/52JNT
         xwXTq0pQHW4sfMAYx/N4AhkP8tDp/YI3Dw/+QmAQhZwNixiuieuPJ/cbomTqENXwDdaS
         h+8w==
X-Gm-Message-State: AOAM5312ZKpwgwS8rsN3lUPaHLACVJIQIr76E16DL9C2WkKscga1fRgj
        9/aTA7Vs+qRhWmc6FS3SHIA36g==
X-Google-Smtp-Source: ABdhPJwQvWlo+O7u3+a2Gbcer/skxTUf4GsCZM4vSy5IgREWFXBEG2O7MzXmmDPXtLm1eJ1JvjNOWw==
X-Received: by 2002:ae9:e8c6:: with SMTP id a189mr1887846qkg.463.1618619686707;
        Fri, 16 Apr 2021 17:34:46 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m10sm4443515qtp.43.2021.04.16.17.34.44
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 16 Apr 2021 17:34:46 -0700 (PDT)
Date:   Fri, 16 Apr 2021 17:34:43 -0700 (PDT)
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
Subject: Re: [PATCH v2 9/9] userfaultfd/shmem: modify shmem_mcopy_atomic_pte
 to use install_ptes
In-Reply-To: <20210413051721.2896915-10-axelrasmussen@google.com>
Message-ID: <alpine.LSU.2.11.2104161648020.25373@eggly.anvils>
References: <20210413051721.2896915-1-axelrasmussen@google.com> <20210413051721.2896915-10-axelrasmussen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 12 Apr 2021, Axel Rasmussen wrote:

> In a previous commit, we added the mcopy_atomic_install_ptes() helper.
> This helper does the job of setting up PTEs for an existing page, to map
> it into a given VMA. It deals with both the anon and shmem cases, as
> well as the shared and private cases.
> 
> In other words, shmem_mcopy_atomic_pte() duplicates a case it already
> handles. So, expose it, and let shmem_mcopy_atomic_pte() use it
> directly, to reduce code duplication.
> 
> This requires that we refactor shmem_mcopy_atomic-pte() a bit:
> 
> Instead of doing accounting (shmem_recalc_inode() et al) part-way
> through the PTE setup, do it beforehand. This frees up
> mcopy_atomic_install_ptes() from having to care about this accounting,
> but it does mean we need to clean it up if we get a failure afterwards
> (shmem_uncharge()).
> 
> We can *almost* use shmem_charge() to do this, reducing code
> duplication. But, it does `inode->i_mapping->nrpages++`, which would
> double-count since shmem_add_to_page_cache() also does this.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  include/linux/userfaultfd_k.h |  5 ++++
>  mm/shmem.c                    | 52 +++++++----------------------------
>  mm/userfaultfd.c              | 25 ++++++++---------
>  3 files changed, 27 insertions(+), 55 deletions(-)

Very nice, and it gets better.

> 
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 794d1538b8ba..3e20bfa9ef80 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -53,6 +53,11 @@ enum mcopy_atomic_mode {
>  	MCOPY_ATOMIC_CONTINUE,
>  };
>  
> +extern int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,

mcopy_atomic_install_pte throughout as before.

> +				     struct vm_area_struct *dst_vma,
> +				     unsigned long dst_addr, struct page *page,
> +				     bool newly_allocated, bool wp_copy);
> +
>  extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
>  			    unsigned long src_start, unsigned long len,
>  			    bool *mmap_changing, __u64 mode);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 3f48cb5e8404..9b12298405a4 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2376,10 +2376,8 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	struct address_space *mapping = inode->i_mapping;
>  	gfp_t gfp = mapping_gfp_mask(mapping);
>  	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
> -	spinlock_t *ptl;
>  	void *page_kaddr;
>  	struct page *page;
> -	pte_t _dst_pte, *dst_pte;
>  	int ret;
>  	pgoff_t max_off;
>  
> @@ -2389,8 +2387,10 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  
>  	if (!*pagep) {
>  		page = shmem_alloc_page(gfp, info, pgoff);
> -		if (!page)
> -			goto out_unacct_blocks;
> +		if (!page) {
> +			shmem_inode_unacct_blocks(inode, 1);
> +			goto out;
> +		}
>  
>  		if (!zeropage) {	/* COPY */
>  			page_kaddr = kmap_atomic(page);
> @@ -2430,59 +2430,27 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	if (ret)
>  		goto out_release;
>  
> -	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
> -	if (dst_vma->vm_flags & VM_WRITE)
> -		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
> -	else {
> -		/*
> -		 * We don't set the pte dirty if the vma has no
> -		 * VM_WRITE permission, so mark the page dirty or it
> -		 * could be freed from under us. We could do it
> -		 * unconditionally before unlock_page(), but doing it
> -		 * only if VM_WRITE is not set is faster.
> -		 */
> -		set_page_dirty(page);
> -	}
> -
> -	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> -
> -	ret = -EFAULT;
> -	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> -	if (unlikely(pgoff >= max_off))
> -		goto out_release_unlock;
> -
> -	ret = -EEXIST;
> -	if (!pte_none(*dst_pte))
> -		goto out_release_unlock;
> -
> -	lru_cache_add(page);
> -
>  	spin_lock_irq(&info->lock);
>  	info->alloced++;
>  	inode->i_blocks += BLOCKS_PER_PAGE;
>  	shmem_recalc_inode(inode);
>  	spin_unlock_irq(&info->lock);
>  
> -	inc_mm_counter(dst_mm, mm_counter_file(page));
> -	page_add_file_rmap(page, false);
> -	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> +	ret = mcopy_atomic_install_ptes(dst_mm, dst_pmd, dst_vma, dst_addr,
> +					page, true, false);
> +	if (ret)
> +		goto out_release_uncharge;
>  
> -	/* No need to invalidate - it was non-present before */
> -	update_mmu_cache(dst_vma, dst_addr, dst_pte);
> -	pte_unmap_unlock(dst_pte, ptl);

In reviewing 4/9, I said to take out mcopy_atomic_install_pte()'s
set_page_dirty().  Just call it here instead, before the unlock_page().
You have an array of choices for how to write it:

	if (!(dst_vma->vm_flags & VM_WRITE))
		set_page_dirty(page);
or
	if (!(dst_vma->vm_flags & VM_WRITE))
		SetPageDirty(page);
or
	set_page_dirty(page);
or
	SetPageDirty(page);

Personally, I'd go for the last: this function has just modified the
page, so it ought to mark it dirty: without second-guessing what
mcopy_atomic_install_pte() might do to make that redundant in the
VM_WRITE case. set_page_dirty() or SetPageDirty()? Some years ago
I tended to favour the former for its preparatory PageDirty check;
nowadays (on shmem) I favour the latter, to avoid the function call
indirection which became more expensive with spectre+retpoline.

>  	unlock_page(page);
>  	ret = 0;
>  out:
>  	return ret;
> -out_release_unlock:
> -	pte_unmap_unlock(dst_pte, ptl);
> -	ClearPageDirty(page);
> +out_release_uncharge:

Given how 4/9 was, this did still need the ClearPageDirty()
before delete_from_page_cache(), to prevent a warning.
But not needed here if SPD is done just before unlock_page().

>  	delete_from_page_cache(page);
> +	shmem_uncharge(inode, 1);
>  out_release:
>  	unlock_page(page);
>  	put_page(page);
> -out_unacct_blocks:
> -	shmem_inode_unacct_blocks(inode, 1);
>  	goto out;
>  }
>  #endif /* CONFIG_USERFAULTFD */
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 8df0438f5d6a..3f73ba0b99f0 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -51,18 +51,13 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
>  /*
>   * Install PTEs, to map dst_addr (within dst_vma) to page.
>   *
> - * This function handles MCOPY_ATOMIC_CONTINUE (which is always file-backed),
> - * whether or not dst_vma is VM_SHARED. It also handles the more general
> - * MCOPY_ATOMIC_NORMAL case, when dst_vma is *not* VM_SHARED (it may be file
> - * backed, or not).
> - *
> - * Note that MCOPY_ATOMIC_NORMAL for a VM_SHARED dst_vma is handled by
> - * shmem_mcopy_atomic_pte instead.
> + * This function handles both MCOPY_ATOMIC_NORMAL and _CONTINUE for both shmem
> + * and anon, and for both shared and private VMAs.
>   */
> -static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> -				     struct vm_area_struct *dst_vma,
> -				     unsigned long dst_addr, struct page *page,
> -				     bool newly_allocated, bool wp_copy)
> +int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> +			      struct vm_area_struct *dst_vma,
> +			      unsigned long dst_addr, struct page *page,
> +			      bool newly_allocated, bool wp_copy)
>  {
>  	int ret;
>  	pte_t _dst_pte, *dst_pte;
> @@ -116,8 +111,12 @@ static int mcopy_atomic_install_ptes(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  	else
>  		page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
>  
> -	if (newly_allocated)
> -		lru_cache_add_inactive_or_unevictable(page, dst_vma);
> +	if (newly_allocated) {
> +		if (vma_is_shmem(dst_vma) && vm_shared)
> +			lru_cache_add(page);
> +		else
> +			lru_cache_add_inactive_or_unevictable(page, dst_vma);
> +	}

This change is not required, you'll be glad to hear. Take a look at
lru_cache_add_inactive_or_unevictable() in mm/swap.c: it's a wrapper
to set PageMlocked and do associated accounting (if appropriate) before
doing the lru_cache_add(page).  And, strictly speaking, should have been
used in shmem_mcopy_atomic_pte() all along.

I say "strictly speaking" because it would be exceptional to find a page
needing Mlock there, and not an error to delay that Mlock until sometime
later, before reclaim.  Worth a sentence in the commit message,
but not worth a "Fixes:" tag.

>  
>  	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
>  
> -- 
> 2.31.1.295.g9ea45b61b8-goog
