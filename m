Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C45DC3182
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 12:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbfJAKct (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 06:32:49 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37645 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730314AbfJAKct (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:32:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4so11426903edy.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2019 03:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hkj8XVJ/JUK9saNg13tQ3faYHAWqr5mxxbpKyWY+/lk=;
        b=NbJgxJgb2fDhq/gnPWMIPrPM/oV+fS4TBXJvQAXcqmX50zg8TaU+J9jp6/owm8xdTO
         77d7jWEAwC9B88ER83cuQjSkF0gKE34LfPv2slmWytVuVJNOI2fqpyoQ8W3mkMywStFB
         zYqPlSb4r1fqYURb1Oq3HfaDWTiSfxUoJ/tK2DeO4krnh1Yso3P1WQ2XG5tRuC1HDl06
         b2CcPsJ3vq912hJH77+m5oxVY0W2Zby2DH/cwYspL6cQxatIpDNPiGtpKWtpLx3QA5sT
         uM9fF5EAZ2poz03M6z6QHx4WLxWskE/JrelAPO1DQbyldqxFEbq3j2Rr99D6IC1/IP7h
         /N9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hkj8XVJ/JUK9saNg13tQ3faYHAWqr5mxxbpKyWY+/lk=;
        b=aS/3B9g8fQNslfu78csODXQS5GsToK05f67zqlkygrG4BMjCUr4yqa5LRxcAOMaEao
         2VqqP2OseqSg5KPIdEXeM66pJ93RuD+OYue/PZgf5q+ly6g0AeA313VJl8zCLBx/drIV
         xe2SxIPJaSwkZuEPwMJqqNnT5ml8aYQQ7jN+CorydabdETFC9UxItfR6dc6CmPC1Fh7m
         vTUvO6cmkywoi4LyeQWSSsZNEmRdAFdtZJ0oVOpGc5HkEgXbv5H1VPw0qY69xuc0cSO/
         YE7jQorzGmhelFSozR/P0IgEOBr65RY2/wrS2Hi/0+8P1RZP/0EW8WoJY3YheuDQMcLX
         Yzyg==
X-Gm-Message-State: APjAAAXkZdwPUhQpnLKqv8dqQ8PQcSaf0jmFbd7rIaBdOc8PiWdTV5+/
        HvnxGgfS8HhPE+pV3WHC3y17PW3iOnA=
X-Google-Smtp-Source: APXvYqwJKL8NZI0rPzJBtmIdStjGyQsB05mczE+qkf3OKCLP9xcEDXlOu63DS9N0WrWNB+DqyKJtYw==
X-Received: by 2002:a05:6402:1adc:: with SMTP id ba28mr25451063edb.103.1569925966479;
        Tue, 01 Oct 2019 03:32:46 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r18sm3052121edx.94.2019.10.01.03.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 03:32:45 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E6139102FB8; Tue,  1 Oct 2019 13:32:45 +0300 (+03)
Date:   Tue, 1 Oct 2019 13:32:45 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] mm: Allow find_get_page to be used for large pages
Message-ID: <20191001103245.zmgbtoer4f7ytxg2@box>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925005214.27240-11-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:52:09PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Add FGP_PMD to indicate that we're trying to find-or-create a page that
> is at least PMD_ORDER in size.  The internal 'conflict' entry usage
> is modelled after that in DAX, but the implementations are different
> due to DAX using multi-order entries and the page cache using multiple
> order-0 entries.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pagemap.h | 13 ++++++
>  mm/filemap.c            | 99 +++++++++++++++++++++++++++++++++++------
>  2 files changed, 99 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index d610a49be571..d6d97f9fb762 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -248,6 +248,19 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
>  #define FGP_NOFS		0x00000010
>  #define FGP_NOWAIT		0x00000020
>  #define FGP_FOR_MMAP		0x00000040
> +/*
> + * If you add more flags, increment FGP_ORDER_SHIFT (no further than 25).
> + * Do not insert flags above the FGP order bits.
> + */
> +#define FGP_ORDER_SHIFT		7
> +#define FGP_PMD			((PMD_SHIFT - PAGE_SHIFT) << FGP_ORDER_SHIFT)
> +#define FGP_PUD			((PUD_SHIFT - PAGE_SHIFT) << FGP_ORDER_SHIFT)
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define fgp_order(fgp)		((fgp) >> FGP_ORDER_SHIFT)
> +#else
> +#define fgp_order(fgp)		0
> +#endif
>  
>  struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
>  		int fgp_flags, gfp_t cache_gfp_mask);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index afe8f5d95810..8eca91547e40 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1576,7 +1576,71 @@ struct page *find_get_entry(struct address_space *mapping, pgoff_t offset)
>  
>  	return page;
>  }
> -EXPORT_SYMBOL(find_get_entry);
> +
> +static bool pagecache_is_conflict(struct page *page)
> +{
> +	return page == XA_RETRY_ENTRY;
> +}
> +
> +/**
> + * __find_get_page - Find and get a page cache entry.
> + * @mapping: The address_space to search.
> + * @offset: The page cache index.
> + * @order: The minimum order of the entry to return.
> + *
> + * Looks up the page cache entries at @mapping between @offset and
> + * @offset + 2^@order.  If there is a page cache page, it is returned with
> + * an increased refcount unless it is smaller than @order.
> + *
> + * If the slot holds a shadow entry of a previously evicted page, or a
> + * swap entry from shmem/tmpfs, it is returned.
> + *
> + * Return: the found page, a value indicating a conflicting page or %NULL if
> + * there are no pages in this range.
> + */
> +static struct page *__find_get_page(struct address_space *mapping,
> +		unsigned long offset, unsigned int order)
> +{
> +	XA_STATE(xas, &mapping->i_pages, offset);
> +	struct page *page;
> +
> +	rcu_read_lock();
> +repeat:
> +	xas_reset(&xas);
> +	page = xas_find(&xas, offset | ((1UL << order) - 1));
> +	if (xas_retry(&xas, page))
> +		goto repeat;
> +	/*
> +	 * A shadow entry of a recently evicted page, or a swap entry from
> +	 * shmem/tmpfs.  Skip it; keep looking for pages.
> +	 */
> +	if (xa_is_value(page))
> +		goto repeat;
> +	if (!page)
> +		goto out;
> +	if (compound_order(page) < order) {
> +		page = XA_RETRY_ENTRY;
> +		goto out;
> +	}
> +
> +	if (!page_cache_get_speculative(page))
> +		goto repeat;
> +
> +	/*
> +	 * Has the page moved or been split?
> +	 * This is part of the lockless pagecache protocol. See
> +	 * include/linux/pagemap.h for details.
> +	 */
> +	if (unlikely(page != xas_reload(&xas))) {
> +		put_page(page);
> +		goto repeat;
> +	}

You need to re-check compound_order() after obtaining reference to the
page. Otherwise the page could be split under you.

> +	page = find_subpage(page, offset);
> +out:
> +	rcu_read_unlock();
> +
> +	return page;
> +}
>  
>  /**
>   * find_lock_entry - locate, pin and lock a page cache entry
> @@ -1618,12 +1682,12 @@ EXPORT_SYMBOL(find_lock_entry);
>   * pagecache_get_page - find and get a page reference
>   * @mapping: the address_space to search
>   * @offset: the page index
> - * @fgp_flags: PCG flags
> + * @fgp_flags: FGP flags
>   * @gfp_mask: gfp mask to use for the page cache data page allocation
>   *
>   * Looks up the page cache slot at @mapping & @offset.
>   *
> - * PCG flags modify how the page is returned.
> + * FGP flags modify how the page is returned.
>   *
>   * @fgp_flags can be:
>   *
> @@ -1636,6 +1700,10 @@ EXPORT_SYMBOL(find_lock_entry);
>   * - FGP_FOR_MMAP: Similar to FGP_CREAT, only we want to allow the caller to do
>   *   its own locking dance if the page is already in cache, or unlock the page
>   *   before returning if we had to add the page to pagecache.
> + * - FGP_PMD: We're only interested in pages at PMD granularity.  If there
> + *   is no page here (and FGP_CREATE is set), we'll create one large enough.
> + *   If there is a smaller page in the cache that overlaps the PMD page, we
> + *   return %NULL and do not attempt to create a page.

I still think it's suboptimal interface. It's okay to ask for PMD page,
but there's small page already caller should deal with it. Otherwise the
caller will do one additional lookup in xarray for fallback path for no
real reason.

>   *
>   * If FGP_LOCK or FGP_CREAT are specified then the function may sleep even
>   * if the GFP flags specified for FGP_CREAT are atomic.
> @@ -1649,10 +1717,11 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
>  {
>  	struct page *page;
>  
> +	BUILD_BUG_ON(((63 << FGP_ORDER_SHIFT) >> FGP_ORDER_SHIFT) != 63);
>  repeat:
> -	page = find_get_entry(mapping, offset);
> -	if (xa_is_value(page))
> -		page = NULL;
> +	page = __find_get_page(mapping, offset, fgp_order(fgp_flags));
> +	if (pagecache_is_conflict(page))
> +		return NULL;
>  	if (!page)
>  		goto no_page;
>  
> @@ -1686,7 +1755,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
>  		if (fgp_flags & FGP_NOFS)
>  			gfp_mask &= ~__GFP_FS;
>  
> -		page = __page_cache_alloc(gfp_mask);
> +		page = __page_cache_alloc_order(gfp_mask, fgp_order(fgp_flags));
>  		if (!page)
>  			return NULL;
>  
> @@ -1704,13 +1773,17 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
>  			if (err == -EEXIST)
>  				goto repeat;
>  		}
> +		if (page) {
> +			if (fgp_order(fgp_flags))
> +				count_vm_event(THP_FILE_ALLOC);
>  
> -		/*
> -		 * add_to_page_cache_lru locks the page, and for mmap we expect
> -		 * an unlocked page.
> -		 */
> -		if (page && (fgp_flags & FGP_FOR_MMAP))
> -			unlock_page(page);
> +			/*
> +			 * add_to_page_cache_lru locks the page, and
> +			 * for mmap we expect an unlocked page.
> +			 */
> +			if (fgp_flags & FGP_FOR_MMAP)
> +				unlock_page(page);
> +		}
>  	}
>  
>  	return page;
> -- 
> 2.23.0
> 

-- 
 Kirill A. Shutemov
