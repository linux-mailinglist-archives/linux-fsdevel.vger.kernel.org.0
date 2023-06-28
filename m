Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F45741323
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 15:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjF1N6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 09:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232064AbjF1N6t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687960683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JYzYNLyrwKZjoVt2FCIvZU7ZjxaA3Zye71p87P7RzXI=;
        b=EA5m8qv9naoU5bFV/Z9TJL9LMuN5jXiquw0sCIKesM7ZpJuf1ZnMKxj6cBz9gCXQ2j/mYW
        fdU9v8pToc3/6JoR80fdJrL4/EU+rfDDaUyqGMNcNi/h23Gyh4DvHChMZao6yX3v8pUIVE
        gCi+25Oi2gDw1oKGhprgLhCxhQ3zr9k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-b6hxrZFsNDaduea85fQjiA-1; Wed, 28 Jun 2023 09:58:02 -0400
X-MC-Unique: b6hxrZFsNDaduea85fQjiA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7672918d8a4so6746685a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 06:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687960682; x=1690552682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYzYNLyrwKZjoVt2FCIvZU7ZjxaA3Zye71p87P7RzXI=;
        b=hRp0mPym+96XPHKUNAY3Ny4dqAut4f+5YZTdk758j3kEnEDnaU+XG47DACmDikGiLK
         fgJeG5xAm5VJhgN88MhR1qbHKZ50R29y6IcUn5x1pSfaedyCyS9896LhuUL2BC2msSqB
         CPppUmc9vjlz1q5S74Lk+UuMtsB0g9Q3xdSDZC9BVTkkZea6BzU4AZy7gAkJmHFvjEuU
         Uoe59YDkhAfe6/WOIpSC1X3wJcTf0QubOJksM9RvIqB5hdWqmoILf2Wwjw81VIGz6TZT
         F4Y5iSheARYaiSoXhJUH447HNrIUh5Fy0ok/ks68Z4+Dq5gdvsRw+uZshBvGZKUtn1X5
         ThBg==
X-Gm-Message-State: AC+VfDxZWGm3hR7qgWYmXtUuERnPUV8+O9m2OPRXlwGWtC0E5HXFiCR8
        5gxcqLwTieLzzARKEHmJF3+1IsC/ErrXitfICECaJMJRGiOaXCLIwkmU31RMzHnxZ6rh1l4HH+T
        EW/FoUWw4ZqIFVEXPJhgfHcjQVw==
X-Received: by 2002:a05:620a:4729:b0:765:5b3d:8195 with SMTP id bs41-20020a05620a472900b007655b3d8195mr15915987qkb.6.1687960681767;
        Wed, 28 Jun 2023 06:58:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ47gsOJ6QhWw/S41/WKg5moO8T066bkifMgasTc0OBSImjp90BJRxw0vuWhMV4vuuk6eTnW1A==
X-Received: by 2002:a05:620a:4729:b0:765:5b3d:8195 with SMTP id bs41-20020a05620a472900b007655b3d8195mr15915971qkb.6.1687960681437;
        Wed, 28 Jun 2023 06:58:01 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id z12-20020a05620a100c00b0076525e0375dsm5082715qkj.36.2023.06.28.06.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:58:01 -0700 (PDT)
Date:   Wed, 28 Jun 2023 09:57:59 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v4 6/6] mm: handle userfaults under VMA lock
Message-ID: <ZJw8Z3E3d4dHPDuZ@x1n>
References: <20230628071800.544800-1-surenb@google.com>
 <20230628071800.544800-7-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230628071800.544800-7-surenb@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 12:18:00AM -0700, Suren Baghdasaryan wrote:
> Enable handle_userfault to operate under VMA lock by releasing VMA lock
> instead of mmap_lock and retrying. Note that FAULT_FLAG_RETRY_NOWAIT
> should never be used when handling faults under per-VMA lock protection
> because that would break the assumption that lock is dropped on retry.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Besides the NOWAIT typo all look sane.  Since there seems to need at least
one more version I'll still comment on a few things..

> ---
>  fs/userfaultfd.c   | 39 ++++++++++++++++++---------------------
>  include/linux/mm.h | 39 +++++++++++++++++++++++++++++++++++++++
>  mm/filemap.c       |  8 --------
>  mm/memory.c        |  9 ---------
>  4 files changed, 57 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 4e800bb7d2ab..d019e7df6f15 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -277,17 +277,16 @@ static inline struct uffd_msg userfault_msg(unsigned long address,
>   * hugepmd ranges.
>   */
>  static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
> -					 struct vm_area_struct *vma,
> -					 unsigned long address,
> -					 unsigned long flags,
> -					 unsigned long reason)
> +					      struct vm_fault *vmf,
> +					      unsigned long reason)
>  {
> +	struct vm_area_struct *vma = vmf->vma;
>  	pte_t *ptep, pte;
>  	bool ret = true;
>  
> -	mmap_assert_locked(ctx->mm);
> +	assert_fault_locked(ctx->mm, vmf);

AFAIU ctx->mm must be the same as vma->vm_mm here, so maybe we can also
drop *ctx here altogether if we've already dropped plenty.

>  
> -	ptep = hugetlb_walk(vma, address, vma_mmu_pagesize(vma));
> +	ptep = hugetlb_walk(vma, vmf->address, vma_mmu_pagesize(vma));
>  	if (!ptep)
>  		goto out;
>  
> @@ -308,10 +307,8 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
>  }
>  #else
>  static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
> -					 struct vm_area_struct *vma,
> -					 unsigned long address,
> -					 unsigned long flags,
> -					 unsigned long reason)
> +					      struct vm_fault *vmf,
> +					      unsigned long reason)
>  {
>  	return false;	/* should never get here */
>  }
> @@ -325,11 +322,11 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
>   * threads.
>   */
>  static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
> -					 unsigned long address,
> -					 unsigned long flags,
> +					 struct vm_fault *vmf,
>  					 unsigned long reason)
>  {
>  	struct mm_struct *mm = ctx->mm;
> +	unsigned long address = vmf->address;
>  	pgd_t *pgd;
>  	p4d_t *p4d;
>  	pud_t *pud;
> @@ -337,7 +334,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
>  	pte_t *pte;
>  	bool ret = true;
>  
> -	mmap_assert_locked(mm);
> +	assert_fault_locked(mm, vmf);
>  
>  	pgd = pgd_offset(mm, address);
>  	if (!pgd_present(*pgd))
> @@ -445,7 +442,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>  	 * Coredumping runs without mmap_lock so we can only check that
>  	 * the mmap_lock is held, if PF_DUMPCORE was not set.
>  	 */
> -	mmap_assert_locked(mm);
> +	assert_fault_locked(mm, vmf);
>  
>  	ctx = vma->vm_userfaultfd_ctx.ctx;
>  	if (!ctx)
> @@ -522,8 +519,11 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>  	 * and wait.
>  	 */
>  	ret = VM_FAULT_RETRY;
> -	if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
> +	if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT) {
> +		/* Per-VMA lock is expected to be dropped on VM_FAULT_RETRY */
> +		BUG_ON(vmf->flags & FAULT_FLAG_RETRY_NOWAIT);

Here is not the only place that we can have FAULT_FLAG_RETRY_NOWAIT.
E.g. folio_lock_or_retry() can also get it, so check here may or may not
help much.

The other thing is please consider not using BUG_ON if possible.
WARN_ON_ONCE() is IMHO always more preferred if the kernel can still try to
run even if it triggers.

I'd rather drop this change, leaving space for future when vma lock may be
supported in gup paths with NOWAIT, then here it'll work naturally, afaiu.
If we really want a sanity check, maybe the best place is when entering
handle_mm_fault(), to be explicit, sanitize_fault_flags().

>  		goto out;
> +	}
>  
>  	/* take the reference before dropping the mmap_lock */
>  	userfaultfd_ctx_get(ctx);
> @@ -561,15 +561,12 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>  	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
>  
>  	if (!is_vm_hugetlb_page(vma))
> -		must_wait = userfaultfd_must_wait(ctx, vmf->address, vmf->flags,
> -						  reason);
> +		must_wait = userfaultfd_must_wait(ctx, vmf, reason);
>  	else
> -		must_wait = userfaultfd_huge_must_wait(ctx, vma,
> -						       vmf->address,
> -						       vmf->flags, reason);
> +		must_wait = userfaultfd_huge_must_wait(ctx, vmf, reason);
>  	if (is_vm_hugetlb_page(vma))
>  		hugetlb_vma_unlock_read(vma);
> -	mmap_read_unlock(mm);
> +	release_fault_lock(vmf);
>  
>  	if (likely(must_wait && !READ_ONCE(ctx->released))) {
>  		wake_up_poll(&ctx->fd_wqh, EPOLLIN);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index fec149585985..70bb2f923e33 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -705,6 +705,17 @@ static inline bool vma_try_start_write(struct vm_area_struct *vma)
>  	return true;
>  }
>  
> +static inline void vma_assert_locked(struct vm_area_struct *vma)
> +{
> +	int mm_lock_seq;
> +
> +	if (__is_vma_write_locked(vma, &mm_lock_seq))
> +		return;
> +
> +	lockdep_assert_held(&vma->vm_lock->lock);
> +	VM_BUG_ON_VMA(!rwsem_is_locked(&vma->vm_lock->lock), vma);
> +}
> +
>  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
>  {
>  	int mm_lock_seq;
> @@ -723,6 +734,23 @@ static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
>  struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  					  unsigned long address);
>  
> +static inline
> +void assert_fault_locked(struct mm_struct *mm, struct vm_fault *vmf)
> +{
> +	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> +		vma_assert_locked(vmf->vma);
> +	else
> +		mmap_assert_locked(mm);
> +}
> +
> +static inline void release_fault_lock(struct vm_fault *vmf)
> +{
> +	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> +		vma_end_read(vmf->vma);
> +	else
> +		mmap_read_unlock(vmf->vma->vm_mm);
> +}
> +
>  #else /* CONFIG_PER_VMA_LOCK */
>  
>  static inline void vma_init_lock(struct vm_area_struct *vma) {}
> @@ -736,6 +764,17 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}
>  static inline void vma_mark_detached(struct vm_area_struct *vma,
>  				     bool detached) {}
>  
> +static inline
> +void assert_fault_locked(struct mm_struct *mm, struct vm_fault *vmf)
> +{
> +	mmap_assert_locked(mm);
> +}
> +
> +static inline void release_fault_lock(struct vm_fault *vmf)
> +{
> +	mmap_read_unlock(vmf->vma->vm_mm);
> +}
> +
>  #endif /* CONFIG_PER_VMA_LOCK */
>  
>  /*
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 7ee078e1a0d2..d4d8f474e0c5 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1699,14 +1699,6 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
>  	return ret;
>  }
>  
> -static void release_fault_lock(struct vm_fault *vmf)
> -{
> -	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> -		vma_end_read(vmf->vma);
> -	else
> -		mmap_read_unlock(vmf->vma->vm_mm);
> -}

The movement is fine but may not be the cleanest.  It'll be nicer to me if
it's put at the right place when introduced - after all in the same series.

Thanks,

> -
>  /*
>   * Return values:
>   * 0 - folio is locked.
> diff --git a/mm/memory.c b/mm/memory.c
> index 76c7907e7286..c6c759922f39 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5294,15 +5294,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  	if (!vma_start_read(vma))
>  		goto inval;
>  
> -	/*
> -	 * Due to the possibility of userfault handler dropping mmap_lock, avoid
> -	 * it for now and fall back to page fault handling under mmap_lock.
> -	 */
> -	if (userfaultfd_armed(vma)) {
> -		vma_end_read(vma);
> -		goto inval;
> -	}
> -
>  	/* Check since vm_start/vm_end might change before we lock the VMA */
>  	if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
>  		vma_end_read(vma);
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 

-- 
Peter Xu

