Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86AF375CAD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 23:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhEFVOS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 17:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhEFVOR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 17:14:17 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD32C061574
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 May 2021 14:13:17 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id j19so5165950qtp.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 May 2021 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=RIxjuE33E7abAYMCMrXM50GaBY0vVKTUwZ41pzyN8mw=;
        b=vReVRGzSSRnZQlAPvJ2DacbKod0eIA0ssz5lX+asfZZg6uy3eRr+wGUPBBqAHJIQie
         7ks2vWl/MUqITz5IsQH2dmW6V7jIG+xy/KYRnDq/QNf5XD3FjECe8zSe4KORTYSJ2ZRq
         Llp0gaWSoZB0Z9R0UjG9PaV6HmFCU9z2N+d4e0DrOVZFEbRzhcqtkzvqqxPk2JbRpzPh
         nFjXOgcyLy2612p+uKpG7QWQjPtu0reqF4HU+lwDhPW4sctgmt0ZDT9NBRi3t7eIuB+z
         8wJd3IX/SreTsc0cVpAqH9PrASzE1K4IuF8Pv9krQAqA6pyfvz0iEgwHwh0x0njngTn3
         2sBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=RIxjuE33E7abAYMCMrXM50GaBY0vVKTUwZ41pzyN8mw=;
        b=nYe9J/Dj5gDECrzrXc3hbVT53NpJVPDdZerXXJMaa6uZh+czHZRfOI6atePRhMwNwx
         nOAvrf0M0Gvh172z6aikefDdGi6UzM67zoKG8l96Z/6UeBlfPytdwPRM2GhOPZhjgH+9
         XAFEFZpL6uv56PlENd/nOFqpD+5Dal4jRilot8MjSUuRXVBqCvGqxCpYMDkWRrmJn3/0
         JrmyT15hP5zwIGf5eC7g6oJo9CI/ewQ79ofTvwMYR+/hCLDav70CCyi4qapEpyn3GuwZ
         NC8CzYRbGMRSY4Tu0NHNWEa2WfZF6VRmN2t+EotSnz14kQk8yfI5KsCSRyQ4pu+kTWFA
         sK2Q==
X-Gm-Message-State: AOAM532e/x6fePiyvJzfa7PmiVqT6GiN+2lln0aCKGV8zspYLO6ETO/w
        WhieU2Llsbk5iawW0CiNcs24gg==
X-Google-Smtp-Source: ABdhPJwFMLMm7IMnquula3QCavOTg+gg74rWfhuq1EJmCOuYsiMfW5eCmRctYncEQYduQsFmbTASgA==
X-Received: by 2002:a05:622a:3cc:: with SMTP id k12mr6387909qtx.233.1620335596632;
        Thu, 06 May 2021 14:13:16 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t203sm3062531qke.83.2021.05.06.14.13.13
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 06 May 2021 14:13:15 -0700 (PDT)
Date:   Thu, 6 May 2021 14:12:59 -0700 (PDT)
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
Subject: Re: [PATCH v6 06/10] userfaultfd/shmem: modify shmem_mfill_atomic_pte
 to use install_pte()
In-Reply-To: <20210503180737.2487560-7-axelrasmussen@google.com>
Message-ID: <alpine.LSU.2.11.2105061407330.699@eggly.anvils>
References: <20210503180737.2487560-1-axelrasmussen@google.com> <20210503180737.2487560-7-axelrasmussen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 3 May 2021, Axel Rasmussen wrote:

> In a previous commit, we added the mfill_atomic_install_pte() helper.
> This helper does the job of setting up PTEs for an existing page, to map
> it into a given VMA. It deals with both the anon and shmem cases, as
> well as the shared and private cases.
> 
> In other words, shmem_mfill_atomic_pte() duplicates a case it already
> handles. So, expose it, and let shmem_mfill_atomic_pte() use it
> directly, to reduce code duplication.
> 
> This requires that we refactor shmem_mfill_atomic_pte() a bit:
> 
> Instead of doing accounting (shmem_recalc_inode() et al) part-way
> through the PTE setup, do it afterward. This frees up
> mfill_atomic_install_pte() from having to care about this accounting,
> and means we don't need to e.g. shmem_uncharge() in the error path.
> 
> A side effect is this switches shmem_mfill_atomic_pte() to use
> lru_cache_add_inactive_or_unevictable() instead of just lru_cache_add().
> This wrapper does some extra accounting in an exceptional case, if
> appropriate, so it's actually the more correct thing to use.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Hugh Dickins <hughd@google.com>

And thanks for doing those late mcopy->mfill renamings,
I think those represent Andrea's intent better.

As far as I'm concerned, this series is now ripe for picking
into mmotm (bearing in mind the dependencies you noted in 00/10):
thank you Axel.

> ---
>  include/linux/userfaultfd_k.h |  5 +++
>  mm/shmem.c                    | 58 ++++++++---------------------------
>  mm/userfaultfd.c              | 17 ++++------
>  3 files changed, 23 insertions(+), 57 deletions(-)
> 
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 794d1538b8ba..331d2ccf0bcc 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -53,6 +53,11 @@ enum mcopy_atomic_mode {
>  	MCOPY_ATOMIC_CONTINUE,
>  };
>  
> +extern int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> +				    struct vm_area_struct *dst_vma,
> +				    unsigned long dst_addr, struct page *page,
> +				    bool newly_allocated, bool wp_copy);
> +
>  extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
>  			    unsigned long src_start, unsigned long len,
>  			    bool *mmap_changing, __u64 mode);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e361f1d81c8d..2e9f56c83489 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2378,14 +2378,11 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
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
> -	ret = -ENOMEM;
>  	if (!shmem_inode_acct_block(inode, 1)) {
>  		/*
>  		 * We may have got a page, returned -ENOENT triggering a retry,
> @@ -2396,10 +2393,11 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  			put_page(*pagep);
>  			*pagep = NULL;
>  		}
> -		goto out;
> +		return -ENOMEM;
>  	}
>  
>  	if (!*pagep) {
> +		ret = -ENOMEM;
>  		page = shmem_alloc_page(gfp, info, pgoff);
>  		if (!page)
>  			goto out_unacct_blocks;
> @@ -2414,9 +2412,9 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  			/* fallback to copy_from_user outside mmap_lock */
>  			if (unlikely(ret)) {
>  				*pagep = page;
> -				shmem_inode_unacct_blocks(inode, 1);
> +				ret = -ENOENT;
>  				/* don't free the page */
> -				return -ENOENT;
> +				goto out_unacct_blocks;
>  			}
>  		} else {		/* ZEROPAGE */
>  			clear_highpage(page);
> @@ -2442,32 +2440,10 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
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
> +	ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> +				       page, true, false);
> +	if (ret)
> +		goto out_delete_from_cache;
>  
>  	spin_lock_irq(&info->lock);
>  	info->alloced++;
> @@ -2475,27 +2451,17 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  	shmem_recalc_inode(inode);
>  	spin_unlock_irq(&info->lock);
>  
> -	inc_mm_counter(dst_mm, mm_counter_file(page));
> -	page_add_file_rmap(page, false);
> -	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> -
> -	/* No need to invalidate - it was non-present before */
> -	update_mmu_cache(dst_vma, dst_addr, dst_pte);
> -	pte_unmap_unlock(dst_pte, ptl);
> +	SetPageDirty(page);
>  	unlock_page(page);
> -	ret = 0;
> -out:
> -	return ret;
> -out_release_unlock:
> -	pte_unmap_unlock(dst_pte, ptl);
> -	ClearPageDirty(page);
> +	return 0;
> +out_delete_from_cache:
>  	delete_from_page_cache(page);
>  out_release:
>  	unlock_page(page);
>  	put_page(page);
>  out_unacct_blocks:
>  	shmem_inode_unacct_blocks(inode, 1);
> -	goto out;
> +	return ret;
>  }
>  #endif /* CONFIG_USERFAULTFD */
>  
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index d1ac73a0d2a9..5508f7d9e2dc 100644
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
> -static int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> -				    struct vm_area_struct *dst_vma,
> -				    unsigned long dst_addr, struct page *page,
> -				    bool newly_allocated, bool wp_copy)
> +int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> +			     struct vm_area_struct *dst_vma,
> +			     unsigned long dst_addr, struct page *page,
> +			     bool newly_allocated, bool wp_copy)
>  {
>  	int ret;
>  	pte_t _dst_pte, *dst_pte;
> -- 
> 2.31.1.527.g47e6f16901-goog
> 
> 
