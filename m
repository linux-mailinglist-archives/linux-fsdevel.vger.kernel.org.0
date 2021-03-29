Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49AE34DC13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 00:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhC2Wuz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 18:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230487AbhC2Wut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617058248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EEp/AWms1iQPM6gX6QYU8HGZGwUHBY8T+uSbGj6gOv0=;
        b=R/YbcfjzfF++vgHKMAppi64gVfxm9bsgPobTnU8f29Gg30FEmbnfCrGNqTidgCWPOGizrA
        EXPmIo2+k0QkyoQKCcfYpGl+kMvxY0iMLYXhTT22N14ZWHsumbeGgcpPTt9lbnn/0ek7Co
        fExntP9MbOD2mQ2fYAyhz++/74ABf5g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-Udf_pTpLPKW-0-OZ9YiygQ-1; Mon, 29 Mar 2021 18:50:46 -0400
X-MC-Unique: Udf_pTpLPKW-0-OZ9YiygQ-1
Received: by mail-qv1-f71.google.com with SMTP id s16so11963532qvw.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Mar 2021 15:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EEp/AWms1iQPM6gX6QYU8HGZGwUHBY8T+uSbGj6gOv0=;
        b=S2u/cr/ecFHiyA+jVMvK0O9yaSkRry4MV4wdUxIjXqOnmiNKIoXtOt3M6B8CIoEJl/
         V83GYKOKS1Uhmn4vaISRIaCXrbfrXi/Z9mER0Uz7fKJeFqKMG1f/fTJ4NtEUcST7R+cT
         CDrlmtlOpcsBpi8oXsEnbPQuJOZa5W/6iZF+v49l6K9cDMHruzkzMVHdOn2DP9knvJrJ
         Rzh5Ystp9SemiEGi9jinx9hEwuqOzgSDLTXKEoJYp+TueL6ldSKAbiLlEC2jI7/mke7+
         tiu9p5F7BCkcPrtmHcJ8OLHvqfeu9qBWsEhwU3CfekYk1H1tAVPj57QiFThygrLs79Zl
         AKqg==
X-Gm-Message-State: AOAM532zvRqE/z9l72XsgxvNtygW5dW2YVXRLwvCFSJW8Dqwt2rOyVDv
        NStZj7NTvpUmDPxvCy4k2Oold7S/YNZOIRE4pLGHywlkmS+KdrVgdBg7nImpSbXXef9AngTZWbG
        AxS5p4z4GUysRZtpxJXUoWhPs/w==
X-Received: by 2002:a37:9802:: with SMTP id a2mr28987603qke.473.1617058245972;
        Mon, 29 Mar 2021 15:50:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4TtfFGH5PtBrvRg+7tdRAACaWWJA5uxnJt87xc9spU6EsS47neLYRetUlyAwN4AL62ZnzNg==
X-Received: by 2002:a37:9802:: with SMTP id a2mr28987571qke.473.1617058245571;
        Mon, 29 Mar 2021 15:50:45 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n2sm11458357qta.61.2021.03.29.15.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 15:50:44 -0700 (PDT)
Date:   Mon, 29 Mar 2021 18:50:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v2] userfaultfd/shmem: fix MCOPY_ATOMIC_CONTNUE behavior
Message-ID: <20210329225042.GF429942@xz-x1>
References: <20210329200659.65971-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210329200659.65971-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 29, 2021 at 01:06:59PM -0700, Axel Rasmussen wrote:
> Previously, we shared too much of the code with COPY and ZEROPAGE, so we
> manipulated things in various invalid ways:
> 
> - Previously, we unconditionally called shmem_inode_acct_block. In the
>   continue case, we're looking up an existing page which would have been
>   accounted for properly when it was allocated. So doing it twice
>   results in double-counting, and eventually leaking.
> 
> - Previously, we made the pte writable whenever the VMA was writable.
>   However, for continue, consider this case:
> 
>   1. A tmpfs file was created
>   2. The non-UFFD-registered side mmap()-s with MAP_SHARED
>   3. The UFFD-registered side mmap()-s with MAP_PRIVATE
> 
>   In this case, even though the UFFD-registered VMA may be writable, we
>   still want CoW behavior. So, check for this case and don't make the
>   pte writable.
> 
> - The offset / max_off checking doesn't necessarily hurt anything, but
>   it's not needed in the CONTINUE case, so skip it.
> 
> - Previously, we unconditionally called ClearPageDirty() in the error
>   path. In the continue case though, since this is an existing page, it
>   might have already been dirty before we started touching it. So,
>   remember whether or not it was dirty before we set_page_dirty(), and
>   only clear the bit if it wasn't dirty before.
> 
> - Previously, we unconditionally removed the page from the page cache in
>   the error path. But in the continue case, we didn't add it - it was
>   already there because the page is present in some second
>   (non-UFFD-registered) mapping. So, removing it is invalid.
> 
> Because the error handling issues are easy to exercise in the selftest,
> make a small modification there to do so.
> 
> Finally, refactor shmem_mcopy_atomic_pte a bit. By this point, we've
> added a lot of "if (!is_continue)"-s everywhere. It's cleaner to just
> check for that mode first thing, and then "goto" down to where the parts
> we actually want are. This leaves the code in between cleaner.
> 
> Changes since v1:
> - Refactor to skip ahead with goto, instead of adding several more
>   "if (!is_continue)".
> - Fix unconditional ClearPageDirty().
> - Don't pte_mkwrite() when is_continue && !VM_SHARED.
> 
> Fixes: 00da60b9d0a0 ("userfaultfd: support minor fault handling for shmem")
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  mm/shmem.c                               | 67 ++++++++++++++----------
>  tools/testing/selftests/vm/userfaultfd.c | 12 +++++
>  2 files changed, 51 insertions(+), 28 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d2e0e81b7d2e..8ab1f1f29987 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2378,17 +2378,22 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  	pte_t _dst_pte, *dst_pte;
>  	int ret;
>  	pgoff_t offset, max_off;
> -
> -	ret = -ENOMEM;
> -	if (!shmem_inode_acct_block(inode, 1))
> -		goto out;
> +	int writable;
> +	bool was_dirty;
>  
>  	if (is_continue) {
>  		ret = -EFAULT;
>  		page = find_lock_page(mapping, pgoff);
>  		if (!page)
> -			goto out_unacct_blocks;
> -	} else if (!*pagep) {
> +			goto out;
> +		goto install_ptes;
> +	}
> +
> +	ret = -ENOMEM;
> +	if (!shmem_inode_acct_block(inode, 1))
> +		goto out;
> +
> +	if (!*pagep) {
>  		page = shmem_alloc_page(gfp, info, pgoff);
>  		if (!page)
>  			goto out_unacct_blocks;
> @@ -2415,13 +2420,11 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  		*pagep = NULL;
>  	}
>  
> -	if (!is_continue) {
> -		VM_BUG_ON(PageSwapBacked(page));
> -		VM_BUG_ON(PageLocked(page));
> -		__SetPageLocked(page);
> -		__SetPageSwapBacked(page);
> -		__SetPageUptodate(page);
> -	}
> +	VM_BUG_ON(PageSwapBacked(page));
> +	VM_BUG_ON(PageLocked(page));
> +	__SetPageLocked(page);
> +	__SetPageSwapBacked(page);
> +	__SetPageUptodate(page);
>  
>  	ret = -EFAULT;
>  	offset = linear_page_index(dst_vma, dst_addr);
> @@ -2429,16 +2432,18 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  	if (unlikely(offset >= max_off))
>  		goto out_release;
>  
> -	/* If page wasn't already in the page cache, add it. */
> -	if (!is_continue) {
> -		ret = shmem_add_to_page_cache(page, mapping, pgoff, NULL,
> -					      gfp & GFP_RECLAIM_MASK, dst_mm);
> -		if (ret)
> -			goto out_release;
> -	}
> +	ret = shmem_add_to_page_cache(page, mapping, pgoff, NULL,
> +				      gfp & GFP_RECLAIM_MASK, dst_mm);
> +	if (ret)
> +		goto out_release;
>  
> +install_ptes:
>  	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
> -	if (dst_vma->vm_flags & VM_WRITE)
> +	/* For CONTINUE on a non-shared VMA, don't pte_mkwrite for CoW. */
> +	writable = is_continue && !(dst_vma->vm_flags & VM_SHARED)
> +		? 0
> +		: dst_vma->vm_flags & VM_WRITE;
> +	if (writable)
>  		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
>  	else {
>  		/*
> @@ -2448,15 +2453,18 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  		 * unconditionally before unlock_page(), but doing it
>  		 * only if VM_WRITE is not set is faster.
>  		 */
> +		was_dirty = PageDirty(page);
>  		set_page_dirty(page);
>  	}
>  
>  	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
>  
> -	ret = -EFAULT;
> -	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> -	if (unlikely(offset >= max_off))
> -		goto out_release_unlock;
> +	if (!is_continue) {
> +		ret = -EFAULT;
> +		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> +		if (unlikely(offset >= max_off))
> +			goto out_release_unlock;
> +	}

I think you're right, but I won't touch this code explicitly since the new code
slightly affects readability, while skipping it won't save a lot of cpu cycles.
No strong opinion though.

>  
>  	ret = -EEXIST;
>  	if (!pte_none(*dst_pte))
> @@ -2485,13 +2493,16 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  	return ret;
>  out_release_unlock:
>  	pte_unmap_unlock(dst_pte, ptl);
> -	ClearPageDirty(page);
> -	delete_from_page_cache(page);
> +	if (!was_dirty)
> +		ClearPageDirty(page);

It could be using a random was_dirty from stack, does not seem right.

Maybe simply drop this ClearPageDirty()?  I'm not sure whether the page free
code will complain, but if not I think an extra dirty bit is better than losing
one, as the latter corrupts data while the former happens anyways, not to
mention this is an error path.  Maybe acceptable?

> +	if (!is_continue)
> +		delete_from_page_cache(page);
>  out_release:
>  	unlock_page(page);
>  	put_page(page);
>  out_unacct_blocks:
> -	shmem_inode_unacct_blocks(inode, 1);
> +	if (!is_continue)
> +		shmem_inode_unacct_blocks(inode, 1);
>  	goto out;
>  }
>  #endif /* CONFIG_USERFAULTFD */
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index f6c86b036d0f..d8541a59dae5 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -485,6 +485,7 @@ static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
>  static void continue_range(int ufd, __u64 start, __u64 len)
>  {
>  	struct uffdio_continue req;
> +	int ret;
>  
>  	req.range.start = start;
>  	req.range.len = len;
> @@ -493,6 +494,17 @@ static void continue_range(int ufd, __u64 start, __u64 len)
>  	if (ioctl(ufd, UFFDIO_CONTINUE, &req))
>  		err("UFFDIO_CONTINUE failed for address 0x%" PRIx64,
>  		    (uint64_t)start);
> +
> +	/*
> +	 * Error handling within the kernel for continue is subtly different
> +	 * from copy or zeropage, so it may be a source of bugs. Trigger an
> +	 * error (-EEXIST) on purpose, to verify doing so doesn't cause a BUG.
> +	 */
> +	req.mapped = 0;
> +	ret = ioctl(ufd, UFFDIO_CONTINUE, &req);
> +	if (ret >= 0 || req.mapped != -EEXIST)
> +		err("failed to exercise UFFDIO_CONTINUE error handling, ret=%d, mapped=%" PRId64,
> +		    ret, req.mapped);
>  }
>  
>  static void *locking_thread(void *arg)
> -- 
> 2.31.0.291.g576ba9dcdaf-goog
> 

-- 
Peter Xu

