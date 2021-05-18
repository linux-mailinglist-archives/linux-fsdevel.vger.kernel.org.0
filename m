Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D018338760B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 12:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348327AbhERKIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 06:08:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:35822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348304AbhERKIC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 06:08:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 535AAAEC6;
        Tue, 18 May 2021 10:06:43 +0000 (UTC)
Subject: Re: [PATCH v10 18/33] mm/filemap: Add folio_unlock
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-19-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e3869efd-b4a3-93a2-b510-21142db91603@suse.cz>
Date:   Tue, 18 May 2021 12:06:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-19-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> Convert unlock_page() to call folio_unlock().  By using a folio we
> avoid a call to compound_head().  This shortens the function from 39
> bytes to 25 and removes 4 instructions on x86-64.  Because we still
> have unlock_page(), it's a net increase of 24 bytes of text for the
> kernel as a whole, but any path that uses folio_unlock() will execute
> 4 fewer instructions.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/pagemap.h |  3 ++-
>  mm/filemap.c            | 27 ++++++++++-----------------
>  mm/folio-compat.c       |  6 ++++++
>  3 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 1f37d7656955..8dbba0074536 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -643,7 +643,8 @@ extern int __lock_page_killable(struct page *page);
>  extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
>  extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
>  				unsigned int flags);
> -extern void unlock_page(struct page *page);
> +void unlock_page(struct page *page);
> +void folio_unlock(struct folio *folio);
>  
>  /*
>   * Return true if the page was successfully locked
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 817a47059bd0..e7a6a58d6cd9 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1435,29 +1435,22 @@ static inline bool clear_bit_unlock_is_negative_byte(long nr, volatile void *mem
>  #endif
>  
>  /**
> - * unlock_page - unlock a locked page
> - * @page: the page
> + * folio_unlock - Unlock a locked folio.
> + * @folio: The folio.
>   *
> - * Unlocks the page and wakes up sleepers in wait_on_page_locked().
> - * Also wakes sleepers in wait_on_page_writeback() because the wakeup
> - * mechanism between PageLocked pages and PageWriteback pages is shared.
> - * But that's OK - sleepers in wait_on_page_writeback() just go back to sleep.
> + * Unlocks the folio and wakes up any thread sleeping on the page lock.
>   *
> - * Note that this depends on PG_waiters being the sign bit in the byte
> - * that contains PG_locked - thus the BUILD_BUG_ON(). That allows us to
> - * clear the PG_locked bit and test PG_waiters at the same time fairly
> - * portably (architectures that do LL/SC can test any bit, while x86 can
> - * test the sign bit).

Was it necessary to remove the comments about wait_on_page_writeback() and
PG_waiters etc?

> + * Context: May be called from interrupt or process context.  May not be
> + * called from NMI context.

Where did the NMI part come from?

>   */
> -void unlock_page(struct page *page)
> +void folio_unlock(struct folio *folio)
>  {
>  	BUILD_BUG_ON(PG_waiters != 7);
> -	page = compound_head(page);
> -	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -	if (clear_bit_unlock_is_negative_byte(PG_locked, &page->flags))
> -		wake_up_page_bit(page, PG_locked);
> +	VM_BUG_ON_FOLIO(!folio_locked(folio), folio);
> +	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio, 0)))
> +		wake_up_page_bit(&folio->page, PG_locked);
>  }
> -EXPORT_SYMBOL(unlock_page);
> +EXPORT_SYMBOL(folio_unlock);
>  
>  /**
>   * end_page_private_2 - Clear PG_private_2 and release any waiters
> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> index 5e107aa30a62..91b3d00a92f7 100644
> --- a/mm/folio-compat.c
> +++ b/mm/folio-compat.c
> @@ -11,3 +11,9 @@ struct address_space *page_mapping(struct page *page)
>  	return folio_mapping(page_folio(page));
>  }
>  EXPORT_SYMBOL(page_mapping);
> +
> +void unlock_page(struct page *page)
> +{
> +	return folio_unlock(page_folio(page));
> +}
> +EXPORT_SYMBOL(unlock_page);
> 

