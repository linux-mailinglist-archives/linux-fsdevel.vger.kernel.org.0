Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2FC387669
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 12:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243458AbhERK1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 06:27:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:35064 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239674AbhERK1X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 06:27:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 33B04AF19;
        Tue, 18 May 2021 10:26:04 +0000 (UTC)
Subject: Re: [PATCH v10 19/33] mm/filemap: Add folio_lock
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-20-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <eed3b8f5-42b8-d7d7-7b6d-1512091485e6@suse.cz>
Date:   Tue, 18 May 2021 12:26:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-20-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> This is like lock_page() but for use by callers who know they have a folio.
> Convert __lock_page() to be __folio_lock().  This saves one call to
> compound_head() per contended call to lock_page().
> 
> Saves 362 bytes of text; mostly from improved register allocation and
> inlining decisions.  __folio_lock is 59 bytes while __lock_page was 79.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/pagemap.h | 24 +++++++++++++++++++-----
>  mm/filemap.c            | 29 +++++++++++++++--------------
>  2 files changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 8dbba0074536..9a78397609b8 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -638,7 +638,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
>  	return true;
>  }
>  
> -extern void __lock_page(struct page *page);
> +void __folio_lock(struct folio *folio);
>  extern int __lock_page_killable(struct page *page);
>  extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
>  extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
> @@ -646,13 +646,24 @@ extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
>  void unlock_page(struct page *page);
>  void folio_unlock(struct folio *folio);
>  
> +static inline bool folio_trylock(struct folio *folio)
> +{
> +	return likely(!test_and_set_bit_lock(PG_locked, folio_flags(folio, 0)));
> +}
> +
>  /*
>   * Return true if the page was successfully locked
>   */
>  static inline int trylock_page(struct page *page)
>  {
> -	page = compound_head(page);
> -	return (likely(!test_and_set_bit_lock(PG_locked, &page->flags)));
> +	return folio_trylock(page_folio(page));
> +}
> +
> +static inline void folio_lock(struct folio *folio)
> +{
> +	might_sleep();
> +	if (!folio_trylock(folio))
> +		__folio_lock(folio);
>  }
>  
>  /*
> @@ -660,9 +671,12 @@ static inline int trylock_page(struct page *page)
>   */
>  static inline void lock_page(struct page *page)
>  {
> +	struct folio *folio;
>  	might_sleep();
> -	if (!trylock_page(page))
> -		__lock_page(page);
> +
> +	folio = page_folio(page);
> +	if (!folio_trylock(folio))
> +		__folio_lock(folio);
>  }
>  
>  /*
> diff --git a/mm/filemap.c b/mm/filemap.c
> index e7a6a58d6cd9..c6e5ba176764 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1187,7 +1187,7 @@ static void wake_up_page(struct page *page, int bit)
>   */
>  enum behavior {
>  	EXCLUSIVE,	/* Hold ref to page and take the bit when woken, like
> -			 * __lock_page() waiting on then setting PG_locked.
> +			 * __folio_lock() waiting on then setting PG_locked.
>  			 */
>  	SHARED,		/* Hold ref to page and check the bit when woken, like
>  			 * wait_on_page_writeback() waiting on PG_writeback.
> @@ -1576,17 +1576,16 @@ void page_endio(struct page *page, bool is_write, int err)
>  EXPORT_SYMBOL_GPL(page_endio);
>  
>  /**
> - * __lock_page - get a lock on the page, assuming we need to sleep to get it
> - * @__page: the page to lock
> + * __folio_lock - Get a lock on the folio, assuming we need to sleep to get it.
> + * @folio: The folio to lock
>   */
> -void __lock_page(struct page *__page)
> +void __folio_lock(struct folio *folio)
>  {
> -	struct page *page = compound_head(__page);
> -	wait_queue_head_t *q = page_waitqueue(page);
> -	wait_on_page_bit_common(q, page, PG_locked, TASK_UNINTERRUPTIBLE,
> +	wait_queue_head_t *q = page_waitqueue(&folio->page);
> +	wait_on_page_bit_common(q, &folio->page, PG_locked, TASK_UNINTERRUPTIBLE,
>  				EXCLUSIVE);
>  }
> -EXPORT_SYMBOL(__lock_page);
> +EXPORT_SYMBOL(__folio_lock);
>  
>  int __lock_page_killable(struct page *__page)
>  {
> @@ -1661,10 +1660,10 @@ int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
>  			return 0;
>  		}
>  	} else {
> -		__lock_page(page);
> +		__folio_lock(page_folio(page));
>  	}
> -	return 1;
>  
> +	return 1;
>  }
>  
>  /**
> @@ -2835,7 +2834,9 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
>  static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
>  				     struct file **fpin)
>  {
> -	if (trylock_page(page))
> +	struct folio *folio = page_folio(page);
> +
> +	if (folio_trylock(folio))
>  		return 1;
>  
>  	/*
> @@ -2848,7 +2849,7 @@ static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
>  
>  	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
>  	if (vmf->flags & FAULT_FLAG_KILLABLE) {
> -		if (__lock_page_killable(page)) {
> +		if (__lock_page_killable(&folio->page)) {
>  			/*
>  			 * We didn't have the right flags to drop the mmap_lock,
>  			 * but all fault_handlers only check for fatal signals
> @@ -2860,11 +2861,11 @@ static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
>  			return 0;
>  		}
>  	} else
> -		__lock_page(page);
> +		__folio_lock(folio);
> +
>  	return 1;
>  }
>  
> -
>  /*
>   * Synchronous readahead happens when we don't even find a page in the page
>   * cache at all.  We don't want to perform IO under the mmap sem, so if we have
> 

