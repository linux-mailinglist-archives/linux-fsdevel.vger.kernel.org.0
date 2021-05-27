Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F3C39295C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 10:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbhE0ISk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 04:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbhE0ISi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 04:18:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEC4C061574;
        Thu, 27 May 2021 01:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ilTao0QAQFFlmXt4TkkVkrE9r3MYBAKwAoaeeQyIzaU=; b=nviw6qUHuJ1mCLRDhuptqUI4gJ
        rOQ4xjgl1q3HyxS9NLhcN+7gsPAYGuwfpNos1XKrnhAVWqpW8uQRkbNnk4MswQrbQDuCEuAjjI8d9
        hLrRFThUSz9rf2CxaUDpIdH741C5yxVuEXWSXzuzgHRiRje2eZC5gCJsLd5qj6lu1M0JxO6vUejs9
        rHO9ZZuMKSUhElcH+OjPlME4fDCGTDeN1xsrxRx9lly4WiQ8z4LDT4tSoJ4hJdDNppcmzIa5zDtfa
        OE9N9FFk16xeIPA1BpI8T1sEXM+syj3IvQov2dA3U+AxZpwMd8006TWJWF3KbZRZFIF2MuE6X8Lgb
        fGeN5Zxg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lmBC6-005K7X-Kd; Thu, 27 May 2021 08:16:49 +0000
Date:   Thu, 27 May 2021 09:16:42 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/33] mm: Add folio_try_get_rcu
Message-ID: <YK9VagEO+bKurYlz@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511214735.1836149-9-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 10:47:10PM +0100, Matthew Wilcox (Oracle) wrote:
> -static inline int page_ref_add_unless(struct page *page, int nr, int u)
> +static inline bool page_ref_add_unless(struct page *page, int nr, int u)
>  {
> -	int ret = atomic_add_unless(&page->_refcount, nr, u);
> +	bool ret = atomic_add_unless(&page->_refcount, nr, u);
>  
>  	if (page_ref_tracepoint_active(page_ref_mod_unless))
>  		__page_ref_mod_unless(page, nr, ret);
>  	return ret;
>  }

Unrelated but neat cleanup.

>  
> -static inline int folio_ref_add_unless(struct folio *folio, int nr, int u)
> +static inline bool folio_ref_add_unless(struct folio *folio, int nr, int u)
>  {
>  	return page_ref_add_unless(&folio->page, nr, u);
>  }

This should probably go into the patch adding folio_ref_add_unless.

> +static inline bool folio_ref_try_add_rcu(struct folio *folio, int count)

Should this have a __ prefix and/or a don't use direct comment?

> +{
> +#ifdef CONFIG_TINY_RCU
> +	/*
> +	 * The caller guarantees the folio will not be freed from interrupt
> +	 * context, so (on !SMP) we only need preemption to be disabled
> +	 * and TINY_RCU does that for us.
> +	 */
> +# ifdef CONFIG_PREEMPT_COUNT
> +	VM_BUG_ON(!in_atomic() && !irqs_disabled());
> +# endif

	VM_BUG_ON(IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
		  !in_atomic() && !irqs_disabled());

?

> +	VM_BUG_ON_FOLIO(folio_ref_count(folio) == 0, folio);
> +	folio_ref_add(folio, count);
> +#else
> +	if (unlikely(!folio_ref_add_unless(folio, count, 0))) {
> +		/* Either the folio has been freed, or will be freed. */
> +		return false;
> +	}
> +#endif
> +	return true;

but is this tiny rcu optimization really worth it?  I guess we're just
preserving it from the existing code and don't rock the boat..

> @@ -1746,6 +1746,26 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
>  }
>  EXPORT_SYMBOL(page_cache_prev_miss);
>  
> +/*
> + * Lockless page cache protocol:
> + * On the lookup side:
> + * 1. Load the folio from i_pages
> + * 2. Increment the refcount if it's not zero
> + * 3. If the folio is not found by xas_reload(), put the refcount and retry
> + *
> + * On the removal side:
> + * A. Freeze the page (by zeroing the refcount if nobody else has a reference)
> + * B. Remove the page from i_pages
> + * C. Return the page to the page allocator
> + *
> + * This means that any page may have its reference count temporarily
> + * increased by a speculative page cache (or fast GUP) lookup as it can
> + * be allocated by another user before the RCU grace period expires.
> + * Because the refcount temporarily acquired here may end up being the
> + * last refcount on the page, any page allocation must be freeable by
> + * put_folio().
> + */
> +
>  /*
>   * mapping_get_entry - Get a page cache entry.
>   * @mapping: the address_space to search

Is this really a good place for the comment?  I'd expect it either near
a relevant function or at the top of a file.
