Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED1C366343
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 03:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbhDUBCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 21:02:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20653 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233836AbhDUBCn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 21:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618966930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L8lGFtSTtYe7QCj8558nLeh4ir6XUy3/NvMAR84JMCU=;
        b=M5crLszDrJrNv/NNQhtUnQrc/VeqekaC7OxoEWmkSEQVKG+r4QyxedNUywQNdb36vv/CJE
        gwsTHM7o51TvXkOSjcZAgz6kNC5RzQVKneptTPPvMgZGaqCa/tpGs6UKUMnafwn7nndsue
        8DKfNF6fsxPLb2LnyK/2WGGsofLYrsA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-EexVHje1My2ymppPmSE9Jg-1; Tue, 20 Apr 2021 21:02:09 -0400
X-MC-Unique: EexVHje1My2ymppPmSE9Jg-1
Received: by mail-qk1-f197.google.com with SMTP id n18-20020a05620a1532b02902e4141f2fd8so1771841qkk.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Apr 2021 18:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L8lGFtSTtYe7QCj8558nLeh4ir6XUy3/NvMAR84JMCU=;
        b=YAu2mo8OCkscNuID2FqzpHSjCxtohx0Wl1AEYJpaMgkpafX9oco1qGliiP88MVlBF0
         /wF7G/FivjhAAba1bEhuwFcx6cIsE87rUN3xDNbEDb/uutHe8kWOHsE9EsY4zM3QLFAn
         CLKKP46wSFvJTEftCRjKbVN/UM+Gf3c5mzOtORySh/5kK4RGyG+D551ecdZ9fi7fMBe+
         tjao+/SZBKUlQ55ApSqDzRfB/Ur891HYoQqCcskdXW1BjKHDYKRCHc6j63zm+DajmZei
         0hEqJlDjFzlYukTWDOc0W6W501/Ps1IKPSpEqTrG62J9TmS0eGSLjrzSkKAlz0Rl3ah8
         YFHA==
X-Gm-Message-State: AOAM5322qvjHWOF5EBd4KfeqhZtzm3tMWTYRDWjWFauzmjHYJnCv4YIT
        PJ7hMnJB0Yiss4or49pEWk2YR5BwX0GQy73WtNsiC0gRTTgO1V+K7Dqpk6Ux19fOdDIoikZNZgI
        sFITU3/1QrnI3J3kDjtfEagjT2g==
X-Received: by 2002:a05:622a:1103:: with SMTP id e3mr20240284qty.346.1618966928468;
        Tue, 20 Apr 2021 18:02:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGZYeVQLcG1SJpG+xTK5I038ewCztBIA6zotSHXUk9vOdU2Z5J2CvbVwJs93g3BaQtIHkvHg==
X-Received: by 2002:a05:622a:1103:: with SMTP id e3mr20240260qty.346.1618966928149;
        Tue, 20 Apr 2021 18:02:08 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id c14sm457297qtc.5.2021.04.20.18.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 18:02:07 -0700 (PDT)
Date:   Tue, 20 Apr 2021 21:02:05 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 09/10] userfaultfd/shmem: modify
 shmem_mcopy_atomic_pte to use install_pte()
Message-ID: <20210421010205.GH4440@xz-x1>
References: <20210420220804.486803-1-axelrasmussen@google.com>
 <20210420220804.486803-10-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210420220804.486803-10-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 20, 2021 at 03:08:03PM -0700, Axel Rasmussen wrote:
> In a previous commit, we added the mcopy_atomic_install_pte() helper.
> This helper does the job of setting up PTEs for an existing page, to map
> it into a given VMA. It deals with both the anon and shmem cases, as
> well as the shared and private cases.
> 
> In other words, shmem_mcopy_atomic_pte() duplicates a case it already
> handles. So, expose it, and let shmem_mcopy_atomic_pte() use it
> directly, to reduce code duplication.
> 
> This requires that we refactor shmem_mcopy_atomic_pte() a bit:
> 
> Instead of doing accounting (shmem_recalc_inode() et al) part-way
> through the PTE setup, do it beforehand. This frees up
> mcopy_atomic_install_pte() from having to care about this accounting,
> but it does mean we need to clean it up if we get a failure afterwards
> (shmem_uncharge()).
> 
> We can *almost* use shmem_charge() to do this, reducing code
> duplication. But, it does `inode->i_mapping->nrpages++`, which would
> double-count since shmem_add_to_page_cache() also does this.

Missing to mention the lru_cache_add() replacement comment as Hugh commented on
this?

> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  include/linux/userfaultfd_k.h |  5 ++++
>  mm/shmem.c                    | 53 ++++++++---------------------------
>  mm/userfaultfd.c              | 17 ++++-------
>  3 files changed, 22 insertions(+), 53 deletions(-)
> 
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 794d1538b8ba..39c094cc6641 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -53,6 +53,11 @@ enum mcopy_atomic_mode {
>  	MCOPY_ATOMIC_CONTINUE,
>  };
>  
> +extern int mcopy_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> +				    struct vm_area_struct *dst_vma,
> +				    unsigned long dst_addr, struct page *page,
> +				    bool newly_allocated, bool wp_copy);
> +
>  extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
>  			    unsigned long src_start, unsigned long len,
>  			    bool *mmap_changing, __u64 mode);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 30c0bb501dc9..9bfa80fcd414 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2378,10 +2378,8 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
> @@ -2391,8 +2389,10 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
> @@ -2432,59 +2432,28 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
> +	ret = mcopy_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> +				       page, true, false);
> +	if (ret)
> +		goto out_release_uncharge;
>  
> -	/* No need to invalidate - it was non-present before */
> -	update_mmu_cache(dst_vma, dst_addr, dst_pte);
> -	pte_unmap_unlock(dst_pte, ptl);
> +	SetPageDirty(page);
>  	unlock_page(page);
>  	ret = 0;
>  out:
>  	return ret;
> -out_release_unlock:
> -	pte_unmap_unlock(dst_pte, ptl);
> -	ClearPageDirty(page);
> +out_release_uncharge:
>  	delete_from_page_cache(page);
> +	shmem_uncharge(inode, 1);
>  out_release:
>  	unlock_page(page);
>  	put_page(page);
> -out_unacct_blocks:

Will all the "goto out_release" miss one call to shmem_inode_unacct_blocks()?

> -	shmem_inode_unacct_blocks(inode, 1);
>  	goto out;
>  }
>  #endif /* CONFIG_USERFAULTFD */
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 51d8c0127161..3a9ddbb2dbbd 100644
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
> -static int mcopy_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> -				    struct vm_area_struct *dst_vma,
> -				    unsigned long dst_addr, struct page *page,
> -				    bool newly_allocated, bool wp_copy)
> +int mcopy_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> +			     struct vm_area_struct *dst_vma,
> +			     unsigned long dst_addr, struct page *page,
> +			     bool newly_allocated, bool wp_copy)
>  {
>  	int ret;
>  	pte_t _dst_pte, *dst_pte;
> -- 
> 2.31.1.368.gbe11c130af-goog
> 

-- 
Peter Xu

