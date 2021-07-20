Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCEF3CF841
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbhGTKFo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237596AbhGTKEJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:04:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EE026120D;
        Tue, 20 Jul 2021 10:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777857;
        bh=N0zKnVQsGkaOEjiTv1PGzCm9/s6FXJtGgu/gxkEykTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lVLd3vW/ksDVbvoxJ2nXxdmFvDJPT8pj7vfLGtdW7NVWEA2CkkMwFA8jwlDI2XT63
         X06mvlixAtxRxBj5glqZGNsVzdHpVqCeBQMTWRXDKcgnzaYoVuFBQ38zvas3gdMlft
         JlW5PNHtWdsUpl1EWdCpxj9j4spK+vl5G9L2wyCo2Ccx4VV6lFDIeq/h1NFIsZXiRy
         MnOg24fPaEtGZplbBysRFDd6IPD5DJrGBYHYpSr0P/++Jh9dyK0VEMkJIt1nyMXiny
         kLAZ8UTw0X8FMoOj8J8LoSA6n+AjEO4aA/ZOnss2hh/6/dVqUm0bwOh1DJTxqCVyG9
         pGGAlNOWr0wsA==
Date:   Tue, 20 Jul 2021 13:44:10 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v14 011/138] mm/lru: Add folio LRU functions
Message-ID: <YPao+syEWXGhDxay@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-12-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:34:57AM +0100, Matthew Wilcox (Oracle) wrote:
> Handle arbitrary-order folios being added to the LRU.  By definition,
> all pages being added to the LRU were already head or base pages, but
> call page_folio() on them anyway to get the type right and avoid the
> buried calls to compound_head().
> 
> Saves 783 bytes of kernel text; no functions grow.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Yu Zhao <yuzhao@google.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: David Howells <dhowells@redhat.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  include/linux/mm_inline.h      | 98 ++++++++++++++++++++++------------
>  include/trace/events/pagemap.h |  2 +-
>  2 files changed, 65 insertions(+), 35 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 355ea1ee32bd..ee155d19885e 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -6,22 +6,27 @@
>  #include <linux/swap.h>
>  
>  /**
> - * page_is_file_lru - should the page be on a file LRU or anon LRU?
> - * @page: the page to test
> + * folio_is_file_lru - should the folio be on a file LRU or anon LRU?
> + * @folio: the folio to test
>   *
> - * Returns 1 if @page is a regular filesystem backed page cache page or a lazily
> - * freed anonymous page (e.g. via MADV_FREE).  Returns 0 if @page is a normal
> - * anonymous page, a tmpfs page or otherwise ram or swap backed page.  Used by
> - * functions that manipulate the LRU lists, to sort a page onto the right LRU
> - * list.
> + * Returns 1 if @folio is a regular filesystem backed page cache folio
> + * or a lazily freed anonymous folio (e.g. via MADV_FREE).  Returns 0 if
> + * @folio is a normal anonymous folio, a tmpfs folio or otherwise ram or
> + * swap backed folio.  Used by functions that manipulate the LRU lists,
> + * to sort a folio onto the right LRU list.
>   *
>   * We would like to get this info without a page flag, but the state
> - * needs to survive until the page is last deleted from the LRU, which
> + * needs to survive until the folio is last deleted from the LRU, which
>   * could be as far down as __page_cache_release.

It seems mm_inline.h is not a part of generated API docs, otherwise
kerneldoc would be unhappy about missing Return: description.

>   */
> +static inline int folio_is_file_lru(struct folio *folio)
> +{
> +	return !folio_test_swapbacked(folio);
> +}
> +
>  static inline int page_is_file_lru(struct page *page)
>  {
> -	return !PageSwapBacked(page);
> +	return folio_is_file_lru(page_folio(page));
>  }
>  
>  static __always_inline void update_lru_size(struct lruvec *lruvec,
> @@ -39,69 +44,94 @@ static __always_inline void update_lru_size(struct lruvec *lruvec,
>  }
>  
>  /**
> - * __clear_page_lru_flags - clear page lru flags before releasing a page
> - * @page: the page that was on lru and now has a zero reference
> + * __folio_clear_lru_flags - clear page lru flags before releasing a page
> + * @folio: The folio that was on lru and now has a zero reference
>   */
> -static __always_inline void __clear_page_lru_flags(struct page *page)
> +static __always_inline void __folio_clear_lru_flags(struct folio *folio)
>  {
> -	VM_BUG_ON_PAGE(!PageLRU(page), page);
> +	VM_BUG_ON_FOLIO(!folio_test_lru(folio), folio);
>  
> -	__ClearPageLRU(page);
> +	__folio_clear_lru(folio);
>  
>  	/* this shouldn't happen, so leave the flags to bad_page() */
> -	if (PageActive(page) && PageUnevictable(page))
> +	if (folio_test_active(folio) && folio_test_unevictable(folio))
>  		return;
>  
> -	__ClearPageActive(page);
> -	__ClearPageUnevictable(page);
> +	__folio_clear_active(folio);
> +	__folio_clear_unevictable(folio);
> +}
> +
> +static __always_inline void __clear_page_lru_flags(struct page *page)
> +{
> +	__folio_clear_lru_flags(page_folio(page));
>  }
>  
>  /**
> - * page_lru - which LRU list should a page be on?
> - * @page: the page to test
> + * folio_lru_list - which LRU list should a folio be on?
> + * @folio: the folio to test
>   *
> - * Returns the LRU list a page should be on, as an index
> + * Returns the LRU list a folio should be on, as an index

      ^ Return: 

>   * into the array of LRU lists.
>   */
> -static __always_inline enum lru_list page_lru(struct page *page)
> +static __always_inline enum lru_list folio_lru_list(struct folio *folio)
>  {
>  	enum lru_list lru;
>  
> -	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
> +	VM_BUG_ON_FOLIO(folio_test_active(folio) && folio_test_unevictable(folio), folio);
>  
> -	if (PageUnevictable(page))
> +	if (folio_test_unevictable(folio))
>  		return LRU_UNEVICTABLE;
>  
> -	lru = page_is_file_lru(page) ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
> -	if (PageActive(page))
> +	lru = folio_is_file_lru(folio) ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
> +	if (folio_test_active(folio))
>  		lru += LRU_ACTIVE;
>  
>  	return lru;
>  }

. . .
