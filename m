Return-Path: <linux-fsdevel+bounces-9497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224C8841C7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 08:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC804285BE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 07:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDAE50A70;
	Tue, 30 Jan 2024 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MO3HhY8d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843114CDEC;
	Tue, 30 Jan 2024 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706599341; cv=none; b=r8EYOHu2kMroyMwM/zLjivK5aQlA31GH03rORRmAnq+oi/OkKuyhnmSuf5KzSilYD3j0DvxXYBtkgF4awu8K7mgSnKWvMXLIDMHB2W1VkPMhR7W81tb2jHhUHSccKMrR34EuWh1TBk8R5huscO+GdgDOAjDcsJA/79Yb0XqnhAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706599341; c=relaxed/simple;
	bh=wpEkXZNJ9bBcBiJwytPGy1LD1i67Bb+XSsQ9HLpClg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku2LO4c/uKDCwHdrRV9+itgYW3W3J1UHn0SRg0dwfWJujb8VZ0NVSsyjgwpBAO2TyMYBNx3BY3wpWoKSNq3YlVYym8BeXEe+RoOpCjNPWfjC7NI4NxgePDhEc94Q2xTAFBTIRsCK+9z9gbvQYlZFHzDt34Qn4y7sGEE81XSzWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MO3HhY8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A496AC433F1;
	Tue, 30 Jan 2024 07:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706599341;
	bh=wpEkXZNJ9bBcBiJwytPGy1LD1i67Bb+XSsQ9HLpClg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MO3HhY8doPlJvmIyGUANAcJkCitjRFBg+TzDAHT6lIrrzX4flu+v03ZO2GzjlUy5k
	 GjV5uCZ37T5aPAcOIrnTjYz1d5MleMU8slPfR1366ZmRr9gAUbkkL1BY9i8NVFkkj3
	 0pNvliKCNNnUPLlJ5cc1AYhNtYHaxyoZW+G/GgSfXTOLUD44tBvIJ+ylELrukGH+zI
	 K0AGr1ihUR6Tjy+j723PP06G3X8cJFL3fouyzRjI2Nm5W2zIDFbpYsoz840uTHnrdO
	 PKOL9YU0bWuiXBTOAc3GWBQthmQreYCyYGT4y7k4/JzKvavC+ActhMCE8nhDg4Rv8h
	 fm7GuzoWR0bLQ==
Date: Tue, 30 Jan 2024 09:21:54 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org, surenb@google.com, kernel-team@android.com,
	aarcange@redhat.com, peterx@redhat.com, david@redhat.com,
	axelrasmussen@google.com, bgeffon@google.com, willy@infradead.org,
	jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com,
	timmurray@google.com
Subject: Re: [PATCH v2 2/3] userfaultfd: protect mmap_changing with rw_sem in
 userfaulfd_ctx
Message-ID: <ZbijkqepWBtAGToI@kernel.org>
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-3-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129193512.123145-3-lokeshgidra@google.com>

On Mon, Jan 29, 2024 at 11:35:11AM -0800, Lokesh Gidra wrote:
> Increments and loads to mmap_changing are always in mmap_lock
> critical section. This ensures that if userspace requests event
> notification for non-cooperative operations (e.g. mremap), userfaultfd
> operations don't occur concurrently.
> 
> This can be achieved by using a separate read-write semaphore in
> userfaultfd_ctx such that increments are done in write-mode and loads
> in read-mode, thereby eliminating the dependency on mmap_lock for this
> purpose.
> 
> This is a preparatory step before we replace mmap_lock usage with
> per-vma locks in fill/move ioctls.
> 
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  fs/userfaultfd.c              | 40 ++++++++++++----------
>  include/linux/userfaultfd_k.h | 31 ++++++++++--------
>  mm/userfaultfd.c              | 62 ++++++++++++++++++++---------------
>  3 files changed, 75 insertions(+), 58 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 58331b83d648..c00a021bcce4 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -685,12 +685,15 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
>  		ctx->flags = octx->flags;
>  		ctx->features = octx->features;
>  		ctx->released = false;
> +		init_rwsem(&ctx->map_changing_lock);
>  		atomic_set(&ctx->mmap_changing, 0);
>  		ctx->mm = vma->vm_mm;
>  		mmgrab(ctx->mm);
>  
>  		userfaultfd_ctx_get(octx);
> +		down_write(&octx->map_changing_lock);
>  		atomic_inc(&octx->mmap_changing);
> +		up_write(&octx->map_changing_lock);
>  		fctx->orig = octx;
>  		fctx->new = ctx;
>  		list_add_tail(&fctx->list, fcs);
> @@ -737,7 +740,9 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
>  	if (ctx->features & UFFD_FEATURE_EVENT_REMAP) {
>  		vm_ctx->ctx = ctx;
>  		userfaultfd_ctx_get(ctx);
> +		down_write(&ctx->map_changing_lock);
>  		atomic_inc(&ctx->mmap_changing);
> +		up_write(&ctx->map_changing_lock);
>  	} else {
>  		/* Drop uffd context if remap feature not enabled */
>  		vma_start_write(vma);
> @@ -783,7 +788,9 @@ bool userfaultfd_remove(struct vm_area_struct *vma,
>  		return true;
>  
>  	userfaultfd_ctx_get(ctx);
> +	down_write(&ctx->map_changing_lock);
>  	atomic_inc(&ctx->mmap_changing);
> +	up_write(&ctx->map_changing_lock);
>  	mmap_read_unlock(mm);
>  
>  	msg_init(&ewq.msg);
> @@ -825,7 +832,9 @@ int userfaultfd_unmap_prep(struct vm_area_struct *vma, unsigned long start,
>  		return -ENOMEM;
>  
>  	userfaultfd_ctx_get(ctx);
> +	down_write(&ctx->map_changing_lock);
>  	atomic_inc(&ctx->mmap_changing);
> +	up_write(&ctx->map_changing_lock);
>  	unmap_ctx->ctx = ctx;
>  	unmap_ctx->start = start;
>  	unmap_ctx->end = end;
> @@ -1709,9 +1718,8 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
>  	if (uffdio_copy.mode & UFFDIO_COPY_MODE_WP)
>  		flags |= MFILL_ATOMIC_WP;
>  	if (mmget_not_zero(ctx->mm)) {
> -		ret = mfill_atomic_copy(ctx->mm, uffdio_copy.dst, uffdio_copy.src,
> -					uffdio_copy.len, &ctx->mmap_changing,
> -					flags);
> +		ret = mfill_atomic_copy(ctx, uffdio_copy.dst, uffdio_copy.src,
> +					uffdio_copy.len, flags);
>  		mmput(ctx->mm);
>  	} else {
>  		return -ESRCH;
> @@ -1761,9 +1769,8 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
>  		goto out;
>  
>  	if (mmget_not_zero(ctx->mm)) {
> -		ret = mfill_atomic_zeropage(ctx->mm, uffdio_zeropage.range.start,
> -					   uffdio_zeropage.range.len,
> -					   &ctx->mmap_changing);
> +		ret = mfill_atomic_zeropage(ctx, uffdio_zeropage.range.start,
> +					   uffdio_zeropage.range.len);
>  		mmput(ctx->mm);
>  	} else {
>  		return -ESRCH;
> @@ -1818,9 +1825,8 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
>  		return -EINVAL;
>  
>  	if (mmget_not_zero(ctx->mm)) {
> -		ret = mwriteprotect_range(ctx->mm, uffdio_wp.range.start,
> -					  uffdio_wp.range.len, mode_wp,
> -					  &ctx->mmap_changing);
> +		ret = mwriteprotect_range(ctx, uffdio_wp.range.start,
> +					  uffdio_wp.range.len, mode_wp);
>  		mmput(ctx->mm);
>  	} else {
>  		return -ESRCH;
> @@ -1870,9 +1876,8 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
>  		flags |= MFILL_ATOMIC_WP;
>  
>  	if (mmget_not_zero(ctx->mm)) {
> -		ret = mfill_atomic_continue(ctx->mm, uffdio_continue.range.start,
> -					    uffdio_continue.range.len,
> -					    &ctx->mmap_changing, flags);
> +		ret = mfill_atomic_continue(ctx, uffdio_continue.range.start,
> +					    uffdio_continue.range.len, flags);
>  		mmput(ctx->mm);
>  	} else {
>  		return -ESRCH;
> @@ -1925,9 +1930,8 @@ static inline int userfaultfd_poison(struct userfaultfd_ctx *ctx, unsigned long
>  		goto out;
>  
>  	if (mmget_not_zero(ctx->mm)) {
> -		ret = mfill_atomic_poison(ctx->mm, uffdio_poison.range.start,
> -					  uffdio_poison.range.len,
> -					  &ctx->mmap_changing, 0);
> +		ret = mfill_atomic_poison(ctx, uffdio_poison.range.start,
> +					  uffdio_poison.range.len, 0);
>  		mmput(ctx->mm);
>  	} else {
>  		return -ESRCH;
> @@ -2003,13 +2007,14 @@ static int userfaultfd_move(struct userfaultfd_ctx *ctx,
>  	if (mmget_not_zero(mm)) {
>  		mmap_read_lock(mm);
>  
> -		/* Re-check after taking mmap_lock */
> +		/* Re-check after taking map_changing_lock */
> +		down_read(&ctx->map_changing_lock);
>  		if (likely(!atomic_read(&ctx->mmap_changing)))
>  			ret = move_pages(ctx, mm, uffdio_move.dst, uffdio_move.src,
>  					 uffdio_move.len, uffdio_move.mode);
>  		else
>  			ret = -EAGAIN;
> -
> +		up_read(&ctx->map_changing_lock);
>  		mmap_read_unlock(mm);
>  		mmput(mm);
>  	} else {
> @@ -2216,6 +2221,7 @@ static int new_userfaultfd(int flags)
>  	ctx->flags = flags;
>  	ctx->features = 0;
>  	ctx->released = false;
> +	init_rwsem(&ctx->map_changing_lock);
>  	atomic_set(&ctx->mmap_changing, 0);
>  	ctx->mm = current->mm;
>  	/* prevent the mm struct to be freed */
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 691d928ee864..3210c3552976 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -69,6 +69,13 @@ struct userfaultfd_ctx {
>  	unsigned int features;
>  	/* released */
>  	bool released;
> +	/*
> +	 * Prevents userfaultfd operations (fill/move/wp) from happening while
> +	 * some non-cooperative event(s) is taking place. Increments are done
> +	 * in write-mode. Whereas, userfaultfd operations, which includes
> +	 * reading mmap_changing, is done under read-mode.
> +	 */
> +	struct rw_semaphore map_changing_lock;
>  	/* memory mappings are changing because of non-cooperative event */
>  	atomic_t mmap_changing;
>  	/* mm with one ore more vmas attached to this userfaultfd_ctx */
> @@ -113,22 +120,18 @@ extern int mfill_atomic_install_pte(pmd_t *dst_pmd,
>  				    unsigned long dst_addr, struct page *page,
>  				    bool newly_allocated, uffd_flags_t flags);
>  
> -extern ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_start,
> +extern ssize_t mfill_atomic_copy(struct userfaultfd_ctx *ctx, unsigned long dst_start,
>  				 unsigned long src_start, unsigned long len,
> -				 atomic_t *mmap_changing, uffd_flags_t flags);
> -extern ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm,
> +				 uffd_flags_t flags);
> +extern ssize_t mfill_atomic_zeropage(struct userfaultfd_ctx *ctx,
>  				     unsigned long dst_start,
> -				     unsigned long len,
> -				     atomic_t *mmap_changing);
> -extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long dst_start,
> -				     unsigned long len, atomic_t *mmap_changing,
> -				     uffd_flags_t flags);
> -extern ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned long start,
> -				   unsigned long len, atomic_t *mmap_changing,
> -				   uffd_flags_t flags);
> -extern int mwriteprotect_range(struct mm_struct *dst_mm,
> -			       unsigned long start, unsigned long len,
> -			       bool enable_wp, atomic_t *mmap_changing);
> +				     unsigned long len);
> +extern ssize_t mfill_atomic_continue(struct userfaultfd_ctx *ctx, unsigned long dst_start,
> +				     unsigned long len, uffd_flags_t flags);
> +extern ssize_t mfill_atomic_poison(struct userfaultfd_ctx *ctx, unsigned long start,
> +				   unsigned long len, uffd_flags_t flags);
> +extern int mwriteprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
> +			       unsigned long len, bool enable_wp);
>  extern long uffd_wp_range(struct vm_area_struct *vma,
>  			  unsigned long start, unsigned long len, bool enable_wp);
>  
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index e3a91871462a..6e2ca04ab04d 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -353,11 +353,11 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
>   * called with mmap_lock held, it will release mmap_lock before returning.
>   */
>  static __always_inline ssize_t mfill_atomic_hugetlb(
> +					      struct userfaultfd_ctx *ctx,
>  					      struct vm_area_struct *dst_vma,
>  					      unsigned long dst_start,
>  					      unsigned long src_start,
>  					      unsigned long len,
> -					      atomic_t *mmap_changing,
>  					      uffd_flags_t flags)
>  {
>  	struct mm_struct *dst_mm = dst_vma->vm_mm;
> @@ -379,6 +379,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  	 * feature is not supported.
>  	 */
>  	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
> +		up_read(&ctx->map_changing_lock);
>  		mmap_read_unlock(dst_mm);
>  		return -EINVAL;
>  	}
> @@ -463,6 +464,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  		cond_resched();
>  
>  		if (unlikely(err == -ENOENT)) {
> +			up_read(&ctx->map_changing_lock);
>  			mmap_read_unlock(dst_mm);
>  			BUG_ON(!folio);
>  
> @@ -473,12 +475,13 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  				goto out;
>  			}
>  			mmap_read_lock(dst_mm);
> +			down_read(&ctx->map_changing_lock);
>  			/*
>  			 * If memory mappings are changing because of non-cooperative
>  			 * operation (e.g. mremap) running in parallel, bail out and
>  			 * request the user to retry later
>  			 */
> -			if (mmap_changing && atomic_read(mmap_changing)) {
> +			if (atomic_read(ctx->mmap_changing)) {
>  				err = -EAGAIN;
>  				break;
>  			}
> @@ -501,6 +504,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  	}
>  
>  out_unlock:
> +	up_read(&ctx->map_changing_lock);
>  	mmap_read_unlock(dst_mm);
>  out:
>  	if (folio)
> @@ -512,11 +516,11 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  }
>  #else /* !CONFIG_HUGETLB_PAGE */
>  /* fail at build time if gcc attempts to use this */
> -extern ssize_t mfill_atomic_hugetlb(struct vm_area_struct *dst_vma,
> +extern ssize_t mfill_atomic_hugetlb(struct userfaultfd_ctx *ctx,
> +				    struct vm_area_struct *dst_vma,
>  				    unsigned long dst_start,
>  				    unsigned long src_start,
>  				    unsigned long len,
> -				    atomic_t *mmap_changing,
>  				    uffd_flags_t flags);
>  #endif /* CONFIG_HUGETLB_PAGE */
>  
> @@ -564,13 +568,13 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
>  	return err;
>  }
>  
> -static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
> +static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  					    unsigned long dst_start,
>  					    unsigned long src_start,
>  					    unsigned long len,
> -					    atomic_t *mmap_changing,
>  					    uffd_flags_t flags)
>  {
> +	struct mm_struct *dst_mm = ctx->mm;
>  	struct vm_area_struct *dst_vma;
>  	ssize_t err;
>  	pmd_t *dst_pmd;
> @@ -600,8 +604,9 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
>  	 * operation (e.g. mremap) running in parallel, bail out and
>  	 * request the user to retry later
>  	 */
> +	down_read(&ctx->map_changing_lock);
>  	err = -EAGAIN;
> -	if (mmap_changing && atomic_read(mmap_changing))
> +	if (atomic_read(&ctx->mmap_changing))
>  		goto out_unlock;
>  
>  	/*
> @@ -633,8 +638,8 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
>  	 * If this is a HUGETLB vma, pass off to appropriate routine
>  	 */
>  	if (is_vm_hugetlb_page(dst_vma))
> -		return  mfill_atomic_hugetlb(dst_vma, dst_start, src_start,
> -					     len, mmap_changing, flags);
> +		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
> +					     src_start, len, flags);
>  
>  	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
>  		goto out_unlock;
> @@ -693,6 +698,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
>  		if (unlikely(err == -ENOENT)) {
>  			void *kaddr;
>  
> +			up_read(&ctx->map_changing_lock);
>  			mmap_read_unlock(dst_mm);
>  			BUG_ON(!folio);
>  
> @@ -723,6 +729,7 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
>  	}
>  
>  out_unlock:
> +	up_read(&ctx->map_changing_lock);
>  	mmap_read_unlock(dst_mm);
>  out:
>  	if (folio)
> @@ -733,34 +740,33 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
>  	return copied ? copied : err;
>  }
>  
> -ssize_t mfill_atomic_copy(struct mm_struct *dst_mm, unsigned long dst_start,
> +ssize_t mfill_atomic_copy(struct userfaultfd_ctx *ctx, unsigned long dst_start,
>  			  unsigned long src_start, unsigned long len,
> -			  atomic_t *mmap_changing, uffd_flags_t flags)
> +			  uffd_flags_t flags)
>  {
> -	return mfill_atomic(dst_mm, dst_start, src_start, len, mmap_changing,
> +	return mfill_atomic(ctx, dst_start, src_start, len,
>  			    uffd_flags_set_mode(flags, MFILL_ATOMIC_COPY));
>  }
>  
> -ssize_t mfill_atomic_zeropage(struct mm_struct *dst_mm, unsigned long start,
> -			      unsigned long len, atomic_t *mmap_changing)
> +ssize_t mfill_atomic_zeropage(struct userfaultfd_ctx *ctx,
> +			      unsigned long start,
> +			      unsigned long len)
>  {
> -	return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
> +	return mfill_atomic(ctx, start, 0, len,
>  			    uffd_flags_set_mode(0, MFILL_ATOMIC_ZEROPAGE));
>  }
>  
> -ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned long start,
> -			      unsigned long len, atomic_t *mmap_changing,
> -			      uffd_flags_t flags)
> +ssize_t mfill_atomic_continue(struct userfaultfd_ctx *ctx, unsigned long start,
> +			      unsigned long len, uffd_flags_t flags)
>  {
> -	return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
> +	return mfill_atomic(ctx, start, 0, len,
>  			    uffd_flags_set_mode(flags, MFILL_ATOMIC_CONTINUE));
>  }
>  
> -ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned long start,
> -			    unsigned long len, atomic_t *mmap_changing,
> -			    uffd_flags_t flags)
> +ssize_t mfill_atomic_poison(struct userfaultfd_ctx *ctx, unsigned long start,
> +			    unsigned long len, uffd_flags_t flags)
>  {
> -	return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
> +	return mfill_atomic(ctx, start, 0, len,
>  			    uffd_flags_set_mode(flags, MFILL_ATOMIC_POISON));
>  }
>  
> @@ -793,10 +799,10 @@ long uffd_wp_range(struct vm_area_struct *dst_vma,
>  	return ret;
>  }
>  
> -int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
> -			unsigned long len, bool enable_wp,
> -			atomic_t *mmap_changing)
> +int mwriteprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
> +			unsigned long len, bool enable_wp)
>  {
> +	struct mm_struct *dst_mm = ctx->mm;
>  	unsigned long end = start + len;
>  	unsigned long _start, _end;
>  	struct vm_area_struct *dst_vma;
> @@ -820,8 +826,9 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>  	 * operation (e.g. mremap) running in parallel, bail out and
>  	 * request the user to retry later
>  	 */
> +	down_read(&ctx->map_changing_lock);
>  	err = -EAGAIN;
> -	if (mmap_changing && atomic_read(mmap_changing))
> +	if (atomic_read(&ctx->mmap_changing))
>  		goto out_unlock;
>  
>  	err = -ENOENT;
> @@ -850,6 +857,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>  		err = 0;
>  	}
>  out_unlock:
> +	up_read(&ctx->map_changing_lock);
>  	mmap_read_unlock(dst_mm);
>  	return err;
>  }
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 

-- 
Sincerely yours,
Mike.

