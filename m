Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6FE3CF83D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbhGTKF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237688AbhGTKEY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:04:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4835611CE;
        Tue, 20 Jul 2021 10:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777902;
        bh=b9A9+xnV7lKRA1XFg/gFz9Qsx5MdK5qZaJXx6O4On6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AmYyY9JMU6iMioUBpF6hka/E21clDZauB3VJLBYoAfU2Re+4rWWR2r1Xjjy2Ql8De
         S7Bo8nM0u9/L298U0tfxaVzgtvKMx8L7LA0zTqmkc2KFGJt3qY9gJ90K36+/5PvYGS
         T7y/piNmo27WamfmynipV/2OKy3lkyBFAYQn1FaxZt6rA9EO3bk5HkbAtHVPM/8i0S
         v3NlkCd2ywCzIloqX7rZrzGfghYm1bh67uLo2aEta/kKk/Pskzks6D60ADQgqkYVtP
         wiEX+TeBRY6qH1kDtwaTzLovqMxPswDTvA9eD9q/nyJ8LyVgu16CGHNCp/TErv4xUe
         4o4SmrUfnXztA==
Date:   Tue, 20 Jul 2021 13:44:55 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v14 019/138] mm/filemap: Add folio_lock_killable()
Message-ID: <YPapJ1Yym9zckS77@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-20-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-20-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:05AM +0100, Matthew Wilcox (Oracle) wrote:
> This is like lock_page_killable() but for use by callers who
> know they have a folio.  Convert __lock_page_killable() to be
> __folio_lock_killable().  This saves one call to compound_head() per
> contended call to lock_page_killable().
> 
> __folio_lock_killable() is 19 bytes smaller than __lock_page_killable()
> was.  filemap_fault() shrinks by 74 bytes and __lock_page_or_retry()
> shrinks by 71 bytes.  That's a total of 164 bytes of text saved.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  include/linux/pagemap.h | 15 ++++++++++-----
>  mm/filemap.c            | 17 +++++++++--------
>  2 files changed, 19 insertions(+), 13 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index c3673c55125b..88727c74e059 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -654,7 +654,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
>  }
>  
>  void __folio_lock(struct folio *folio);
> -extern int __lock_page_killable(struct page *page);
> +int __folio_lock_killable(struct folio *folio);
>  extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
>  extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
>  				unsigned int flags);
> @@ -694,6 +694,14 @@ static inline void lock_page(struct page *page)
>  		__folio_lock(folio);
>  }
>  
> +static inline int folio_lock_killable(struct folio *folio)
> +{
> +	might_sleep();
> +	if (!folio_trylock(folio))
> +		return __folio_lock_killable(folio);
> +	return 0;
> +}
> +
>  /*
>   * lock_page_killable is like lock_page but can be interrupted by fatal
>   * signals.  It returns 0 if it locked the page and -EINTR if it was
> @@ -701,10 +709,7 @@ static inline void lock_page(struct page *page)
>   */
>  static inline int lock_page_killable(struct page *page)
>  {
> -	might_sleep();
> -	if (!trylock_page(page))
> -		return __lock_page_killable(page);
> -	return 0;
> +	return folio_lock_killable(page_folio(page));
>  }
>  
>  /*
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 95f89656f126..962db5c38cd7 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1589,14 +1589,13 @@ void __folio_lock(struct folio *folio)
>  }
>  EXPORT_SYMBOL(__folio_lock);
>  
> -int __lock_page_killable(struct page *__page)
> +int __folio_lock_killable(struct folio *folio)
>  {
> -	struct page *page = compound_head(__page);
> -	wait_queue_head_t *q = page_waitqueue(page);
> -	return wait_on_page_bit_common(q, page, PG_locked, TASK_KILLABLE,
> +	wait_queue_head_t *q = page_waitqueue(&folio->page);
> +	return wait_on_page_bit_common(q, &folio->page, PG_locked, TASK_KILLABLE,
>  					EXCLUSIVE);
>  }
> -EXPORT_SYMBOL_GPL(__lock_page_killable);
> +EXPORT_SYMBOL_GPL(__folio_lock_killable);
>  
>  int __lock_page_async(struct page *page, struct wait_page_queue *wait)
>  {
> @@ -1638,6 +1637,8 @@ int __lock_page_async(struct page *page, struct wait_page_queue *wait)
>  int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
>  			 unsigned int flags)
>  {
> +	struct folio *folio = page_folio(page);
> +
>  	if (fault_flag_allow_retry_first(flags)) {
>  		/*
>  		 * CAUTION! In this case, mmap_lock is not released
> @@ -1656,13 +1657,13 @@ int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
>  	if (flags & FAULT_FLAG_KILLABLE) {
>  		int ret;
>  
> -		ret = __lock_page_killable(page);
> +		ret = __folio_lock_killable(folio);
>  		if (ret) {
>  			mmap_read_unlock(mm);
>  			return 0;
>  		}
>  	} else {
> -		__folio_lock(page_folio(page));
> +		__folio_lock(folio);
>  	}
>  
>  	return 1;
> @@ -2851,7 +2852,7 @@ static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
>  
>  	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
>  	if (vmf->flags & FAULT_FLAG_KILLABLE) {
> -		if (__lock_page_killable(&folio->page)) {
> +		if (__folio_lock_killable(folio)) {
>  			/*
>  			 * We didn't have the right flags to drop the mmap_lock,
>  			 * but all fault_handlers only check for fatal signals
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
