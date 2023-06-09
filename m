Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364B372A505
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 22:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjFIUzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 16:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFIUzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B7D30FB
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 13:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686344059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BtXUpcsSOoMANhYIjxCH4S5rCaK3q7YtG7uZtBil9Bg=;
        b=dV5j9gw5e7owp/GK5E2dvXU6Z0EWUzBuFokq3L2fx4Aas/aWAwDc0mpSgcKOVV94tMc7ER
        EBEH8Bvkg974qJdhlO3L0lpsjqd8a5n9Enp4MjMaWkeEK5BgvawdRtIZ44B5vhXez3apQ+
        JSHrO4jMBXAGsBmJnBTVFQq9uLrm0dQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-eXXXEruuPwm3dkixYb4NrQ-1; Fri, 09 Jun 2023 16:54:18 -0400
X-MC-Unique: eXXXEruuPwm3dkixYb4NrQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62849c5e9f0so3573896d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 13:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686344058; x=1688936058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtXUpcsSOoMANhYIjxCH4S5rCaK3q7YtG7uZtBil9Bg=;
        b=l09MZ7FEPqMACGEwSHaptgSfUNVwcR24s0lTPpGlLHKc9aavERthio819dsHsXgX3p
         Wg1zFfRr+jA40wJX44hZCVeoz4QOqqu6FIVYFfJOK5A9yETK/cLYwUylrACKccsPTRZ2
         Y9vJu4gu9EJ/gAj0eC6W16peXHk2IseyEqNxnXHSb58X2J7BjUgypSIJvjPN7zgnyTP2
         n6gqS76NBQ61CQcErvMwfPqI0hqA7+coCS2ypKpSbpnF5tGx9hRyZgdZZLRLxqbPi4Hz
         qAmtFCoAGxHW3KFX491kFhzEOEYwKegKwtzGbIbTL9vScxfpJ2P1Q7J0CMpKaKMnUifv
         LerA==
X-Gm-Message-State: AC+VfDxUCrNlqllsdRB2MOG0PJVL4cSYBGYvYumpA/ad5hvOiIZ6uLEo
        +oRAgnmaY9kBF4zvu3w4cDvke2Fvwig9wHQ0Mt771goXsAowclZfSEOQkGYO6QqhkpatwEdxb2s
        jPf0OBXiWZ22A2e2RHpRTvk61ZQ==
X-Received: by 2002:a05:6214:411b:b0:622:265e:3473 with SMTP id kc27-20020a056214411b00b00622265e3473mr3267180qvb.1.1686344057875;
        Fri, 09 Jun 2023 13:54:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7VmR+n9mJc3ncQaU9/pPLVR1AT84gvlgTZNz1yYb5YR/q3ykKIdaxPnpKT6M4foeVkkKwQcw==
X-Received: by 2002:a05:6214:411b:b0:622:265e:3473 with SMTP id kc27-20020a056214411b00b00622265e3473mr3267135qvb.1.1686344057488;
        Fri, 09 Jun 2023 13:54:17 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id j14-20020a0cf50e000000b0062595cd1972sm1411236qvm.82.2023.06.09.13.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:54:16 -0700 (PDT)
Date:   Fri, 9 Jun 2023 16:54:14 -0400
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
Subject: Re: [PATCH v2 5/6] mm: implement folio wait under VMA lock
Message-ID: <ZIORdizaMfvo01JO@x1n>
References: <20230609005158.2421285-1-surenb@google.com>
 <20230609005158.2421285-6-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230609005158.2421285-6-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 08, 2023 at 05:51:57PM -0700, Suren Baghdasaryan wrote:
> Follow the same pattern as mmap_lock when waiting for folio by dropping
> VMA lock before the wait and retrying once folio is available.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/pagemap.h | 14 ++++++++++----
>  mm/filemap.c            | 43 ++++++++++++++++++++++-------------------
>  mm/memory.c             | 13 ++++++++-----
>  3 files changed, 41 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index a56308a9d1a4..6c9493314c21 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -896,8 +896,8 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
>  
>  void __folio_lock(struct folio *folio);
>  int __folio_lock_killable(struct folio *folio);
> -bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
> -				unsigned int flags);
> +bool __folio_lock_or_retry(struct folio *folio, struct vm_area_struct *vma,
> +			   unsigned int flags, bool *lock_dropped);
>  void unlock_page(struct page *page);
>  void folio_unlock(struct folio *folio);
>  
> @@ -1002,10 +1002,16 @@ static inline int folio_lock_killable(struct folio *folio)
>   * __folio_lock_or_retry().
>   */
>  static inline bool folio_lock_or_retry(struct folio *folio,
> -		struct mm_struct *mm, unsigned int flags)
> +		struct vm_area_struct *vma, unsigned int flags,
> +		bool *lock_dropped)
>  {
>  	might_sleep();
> -	return folio_trylock(folio) || __folio_lock_or_retry(folio, mm, flags);
> +	if (folio_trylock(folio)) {
> +		*lock_dropped = false;
> +		return true;
> +	}
> +
> +	return __folio_lock_or_retry(folio, vma, flags, lock_dropped);
>  }
>  
>  /*
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 7cb0a3776a07..838955635fbc 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1701,37 +1701,35 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
>  
>  /*
>   * Return values:
> - * true - folio is locked; mmap_lock is still held.
> + * true - folio is locked.
>   * false - folio is not locked.
> - *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
> - *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
> - *     which case mmap_lock is still held.
> - *     If flags had FAULT_FLAG_VMA_LOCK set, meaning the operation is performed
> - *     with VMA lock only, the VMA lock is still held.
> + *
> + * lock_dropped indicates whether mmap_lock/VMA lock got dropped.
> + *     mmap_lock/VMA lock is dropped when function fails to lock the folio,
> + *     unless flags had both FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT
> + *     set, in which case mmap_lock/VMA lock is still held.

This seems to be a separate change to have "lock_dropped", would it worth a
separate patch for it if needed?

I do agree it's confusing and it might be the reason of this change, but I
think it may or may not help much.. as long as VM_FAULT_RETRY semantics
kept unchanged iiuc (it doesn't always imply mmap lock released, only if
!NOWAIT, which can be confusing too).

Especially that doesn't seem like a must for the vma change.  IIUC to
support vma lock here we can simply keep everything as before, but only
release proper lock based on the fault flag should work.  But maybe I just
missed something, so that relies on the answer to previous patch...

>   *
>   * If neither ALLOW_RETRY nor KILLABLE are set, will always return true
> - * with the folio locked and the mmap_lock unperturbed.
> + * with the folio locked and the mmap_lock/VMA lock unperturbed.
>   */
> -bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
> -			 unsigned int flags)
> +bool __folio_lock_or_retry(struct folio *folio, struct vm_area_struct *vma,
> +			 unsigned int flags, bool *lock_dropped)
>  {
> -	/* Can't do this if not holding mmap_lock */
> -	if (flags & FAULT_FLAG_VMA_LOCK)
> -		return false;
> -
>  	if (fault_flag_allow_retry_first(flags)) {
> -		/*
> -		 * CAUTION! In this case, mmap_lock is not released
> -		 * even though return 0.
> -		 */
> -		if (flags & FAULT_FLAG_RETRY_NOWAIT)
> +		if (flags & FAULT_FLAG_RETRY_NOWAIT) {
> +			*lock_dropped = false;
>  			return false;
> +		}
>  
> -		mmap_read_unlock(mm);
> +		if (flags & FAULT_FLAG_VMA_LOCK)
> +			vma_end_read(vma);
> +		else
> +			mmap_read_unlock(vma->vm_mm);
>  		if (flags & FAULT_FLAG_KILLABLE)
>  			folio_wait_locked_killable(folio);
>  		else
>  			folio_wait_locked(folio);
> +		*lock_dropped = true;
>  		return false;
>  	}
>  	if (flags & FAULT_FLAG_KILLABLE) {
> @@ -1739,13 +1737,18 @@ bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
>  
>  		ret = __folio_lock_killable(folio);
>  		if (ret) {
> -			mmap_read_unlock(mm);
> +			if (flags & FAULT_FLAG_VMA_LOCK)
> +				vma_end_read(vma);
> +			else
> +				mmap_read_unlock(vma->vm_mm);
> +			*lock_dropped = true;
>  			return false;
>  		}
>  	} else {
>  		__folio_lock(folio);
>  	}
>  
> +	*lock_dropped = false;
>  	return true;
>  }
>  
> diff --git a/mm/memory.c b/mm/memory.c
> index c234f8085f1e..acb09a3aad53 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3568,6 +3568,7 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
>  	struct folio *folio = page_folio(vmf->page);
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct mmu_notifier_range range;
> +	bool lock_dropped;
>  
>  	/*
>  	 * We need a reference to lock the folio because we don't hold
> @@ -3580,8 +3581,10 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
>  	if (!folio_try_get(folio))
>  		return 0;
>  
> -	if (!folio_lock_or_retry(folio, vma->vm_mm, vmf->flags)) {
> +	if (!folio_lock_or_retry(folio, vma, vmf->flags, &lock_dropped)) {
>  		folio_put(folio);
> +		if (lock_dropped && vmf->flags & FAULT_FLAG_VMA_LOCK)
> +			return VM_FAULT_VMA_UNLOCKED | VM_FAULT_RETRY;
>  		return VM_FAULT_RETRY;
>  	}
>  	mmu_notifier_range_init_owner(&range, MMU_NOTIFY_EXCLUSIVE, 0,
> @@ -3704,7 +3707,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	bool exclusive = false;
>  	swp_entry_t entry;
>  	pte_t pte;
> -	int locked;
> +	bool lock_dropped;
>  	vm_fault_t ret = 0;
>  	void *shadow = NULL;
>  
> @@ -3837,9 +3840,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		goto out_release;
>  	}
>  
> -	locked = folio_lock_or_retry(folio, vma->vm_mm, vmf->flags);
> -
> -	if (!locked) {
> +	if (!folio_lock_or_retry(folio, vma, vmf->flags, &lock_dropped)) {
> +		if (lock_dropped && vmf->flags & FAULT_FLAG_VMA_LOCK)
> +			ret |= VM_FAULT_VMA_UNLOCKED;
>  		ret |= VM_FAULT_RETRY;
>  		goto out_release;
>  	}
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 

-- 
Peter Xu

