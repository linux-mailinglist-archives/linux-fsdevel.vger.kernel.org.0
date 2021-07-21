Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4DA3D0C07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 12:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbhGUJGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 05:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhGUJE0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:04:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F38F66120C;
        Wed, 21 Jul 2021 09:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626860663;
        bh=5Wbzf/ASUkCCzIFCBKgsou8NswYGW+uQaYcYLAp5gLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTA0TFlajKpi6pvOtXnYuUIPEGZRxeI9DabTOp9ix+C6Bc2zEmi0MEMQeWYe8REv4
         bxlPUJxMRpDBVqmONOvCYjpjKmY+aSbK3jCTVbdTQecep3duEyuIWx4ouehXSdjwcK
         qAyNUXlCPnLUfr/pLBtlojuFNQWXfaptMM4ECx78Hcsf+5cbn6SsybJ5cZ/RgWNC4d
         /lOAAq/1BjODXcuheRwV7af7jO7vIKSyEjyJV60mc7PnyveGHMa7Qaf6XkAvHimvfT
         T964mwo889D1HqVPGkNo10ckBq+BonpjUPbabrC508puHflOjLn0NKmclaprqQ3fH9
         Zua4rbVGWjo3w==
Date:   Wed, 21 Jul 2021 12:44:15 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v14 030/138] mm/filemap: Add folio private_2 functions
Message-ID: <YPfsb4Rng7Q7NnPa@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-31-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-31-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:16AM +0100, Matthew Wilcox (Oracle) wrote:
> end_page_private_2() becomes folio_end_private_2(),
> wait_on_page_private_2() becomes folio_wait_private_2() and
> wait_on_page_private_2_killable() becomes folio_wait_private_2_killable().
> 
> Adjust the fscache equivalents to call page_folio() before calling these
> functions to avoid adding wrappers.  Ends up costing 1 byte of text
> in ceph & netfs, but the core shrinks by three calls to page_folio().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: David Howells <dhowells@redhat.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  include/linux/netfs.h   |  6 +++---
>  include/linux/pagemap.h |  6 +++---
>  mm/filemap.c            | 37 ++++++++++++++++---------------------
>  3 files changed, 22 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 9062adfa2fb9..fad8c6209edd 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -55,7 +55,7 @@ static inline void set_page_fscache(struct page *page)
>   */
>  static inline void end_page_fscache(struct page *page)
>  {
> -	end_page_private_2(page);
> +	folio_end_private_2(page_folio(page));
>  }
>  
>  /**
> @@ -66,7 +66,7 @@ static inline void end_page_fscache(struct page *page)
>   */
>  static inline void wait_on_page_fscache(struct page *page)
>  {
> -	wait_on_page_private_2(page);
> +	folio_wait_private_2(page_folio(page));
>  }
>  
>  /**
> @@ -82,7 +82,7 @@ static inline void wait_on_page_fscache(struct page *page)
>   */
>  static inline int wait_on_page_fscache_killable(struct page *page)
>  {
> -	return wait_on_page_private_2_killable(page);
> +	return folio_wait_private_2_killable(page_folio(page));
>  }
>  
>  enum netfs_read_source {
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index c8e74d67b01f..edf58a581bce 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -796,9 +796,9 @@ static inline void set_page_private_2(struct page *page)
>  	SetPagePrivate2(page);
>  }
>  
> -void end_page_private_2(struct page *page);
> -void wait_on_page_private_2(struct page *page);
> -int wait_on_page_private_2_killable(struct page *page);
> +void folio_end_private_2(struct folio *folio);
> +void folio_wait_private_2(struct folio *folio);
> +int folio_wait_private_2_killable(struct folio *folio);
>  
>  /*
>   * Add an arbitrary waiter to a page's wait queue
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 1ecaece68019..a5d02ec62eb6 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1451,56 +1451,51 @@ void folio_unlock(struct folio *folio)
>  EXPORT_SYMBOL(folio_unlock);
>  
>  /**
> - * end_page_private_2 - Clear PG_private_2 and release any waiters
> - * @page: The page
> + * folio_end_private_2 - Clear PG_private_2 and wake any waiters.
> + * @folio: The folio.
>   *
> - * Clear the PG_private_2 bit on a page and wake up any sleepers waiting for
> - * this.  The page ref held for PG_private_2 being set is released.
> + * Clear the PG_private_2 bit on a folio and wake up any sleepers waiting for
> + * it.  The page ref held for PG_private_2 being set is released.

              ^ folio reference

>   *
>   * This is, for example, used when a netfs page is being written to a local
>   * disk cache, thereby allowing writes to the cache for the same page to be
>   * serialised.
>   */
> -void end_page_private_2(struct page *page)
> +void folio_end_private_2(struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
> -
>  	VM_BUG_ON_FOLIO(!folio_test_private_2(folio), folio);
>  	clear_bit_unlock(PG_private_2, folio_flags(folio, 0));
>  	folio_wake_bit(folio, PG_private_2);
>  	folio_put(folio);
>  }
> -EXPORT_SYMBOL(end_page_private_2);
> +EXPORT_SYMBOL(folio_end_private_2);
>  
>  /**
> - * wait_on_page_private_2 - Wait for PG_private_2 to be cleared on a page
> - * @page: The page to wait on
> + * folio_wait_private_2 - Wait for PG_private_2 to be cleared on a page.

                                                                    ^ folio
> + * @folio: The folio to wait on.
>   *
> - * Wait for PG_private_2 (aka PG_fscache) to be cleared on a page.
> + * Wait for PG_private_2 (aka PG_fscache) to be cleared on a folio.
>   */
> -void wait_on_page_private_2(struct page *page)
> +void folio_wait_private_2(struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
> -
>  	while (folio_test_private_2(folio))
>  		folio_wait_bit(folio, PG_private_2);
>  }
> -EXPORT_SYMBOL(wait_on_page_private_2);
> +EXPORT_SYMBOL(folio_wait_private_2);
>  
>  /**
> - * wait_on_page_private_2_killable - Wait for PG_private_2 to be cleared on a page
> - * @page: The page to wait on
> + * folio_wait_private_2_killable - Wait for PG_private_2 to be cleared on a folio.
> + * @folio: The folio to wait on.
>   *
> - * Wait for PG_private_2 (aka PG_fscache) to be cleared on a page or until a
> + * Wait for PG_private_2 (aka PG_fscache) to be cleared on a folio or until a
>   * fatal signal is received by the calling task.
>   *
>   * Return:
>   * - 0 if successful.
>   * - -EINTR if a fatal signal was encountered.
>   */
> -int wait_on_page_private_2_killable(struct page *page)
> +int folio_wait_private_2_killable(struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
>  	int ret = 0;
>  
>  	while (folio_test_private_2(folio)) {
> @@ -1511,7 +1506,7 @@ int wait_on_page_private_2_killable(struct page *page)
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL(wait_on_page_private_2_killable);
> +EXPORT_SYMBOL(folio_wait_private_2_killable);
>  
>  /**
>   * folio_end_writeback - End writeback against a folio.
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
