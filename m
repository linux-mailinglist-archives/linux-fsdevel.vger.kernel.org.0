Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8787517D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 07:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjGMFEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 01:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjGMFEt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:04:49 -0400
Received: from out-5.mta1.migadu.com (out-5.mta1.migadu.com [95.215.58.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF291734
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 22:04:48 -0700 (PDT)
Date:   Thu, 13 Jul 2023 01:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689224686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eNG0Sovw8KZQpmVJ/uDd06qCqgYhnT1LPKwcum+bcDw=;
        b=Lt/6K+S5FQ4d3/q5hYoIEPR9NyDzHyktAxkBGZIlmSaIrOInb4B/eEujTkLj9AmWQKT8a5
        28hzaoDXOzKzzZU/XOow2uFccPjTngRI5GcRzZCDXqqEnFhkqt8YMNv1NNscmbTHwqRFXW
        8Wr2iYyT5nvYjlrUyYGuAdaFDsqEX5M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 7/9] filemap: Allow __filemap_get_folio to allocate
 large folios
Message-ID: <20230713050439.ehtbvs3bugm6vvtb@moria.home.lan>
References: <20230710130253.3484695-1-willy@infradead.org>
 <20230710130253.3484695-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710130253.3484695-8-willy@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 02:02:51PM +0100, Matthew Wilcox (Oracle) wrote:
> Allow callers of __filemap_get_folio() to specify a preferred folio
> order in the FGP flags.  This is only honoured in the FGP_CREATE path;
> if there is already a folio in the page cache that covers the index,
> we will return it, no matter what its order is.  No create-around is
> attempted; we will only create folios which start at the specified index.
> Unmodified callers will continue to allocate order 0 folios.

Why not just add an end_index parameter to filemap_get_folio()?

> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/pagemap.h | 34 ++++++++++++++++++++++++++++++
>  mm/filemap.c            | 46 +++++++++++++++++++++++++++++------------
>  mm/readahead.c          | 13 ------------
>  3 files changed, 67 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 911201fc41fc..d87840acbfb2 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -470,6 +470,19 @@ static inline void *detach_page_private(struct page *page)
>  	return folio_detach_private(page_folio(page));
>  }
>  
> +/*
> + * There are some parts of the kernel which assume that PMD entries
> + * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
> + * limit the maximum allocation order to PMD size.  I'm not aware of any
> + * assumptions about maximum order if THP are disabled, but 8 seems like
> + * a good order (that's 1MB if you're using 4kB pages)
> + */
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
> +#else
> +#define MAX_PAGECACHE_ORDER	8
> +#endif
> +
>  #ifdef CONFIG_NUMA
>  struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order);
>  #else
> @@ -535,9 +548,30 @@ typedef unsigned int __bitwise fgf_t;
>  #define FGP_NOWAIT		((__force fgf_t)0x00000020)
>  #define FGP_FOR_MMAP		((__force fgf_t)0x00000040)
>  #define FGP_STABLE		((__force fgf_t)0x00000080)
> +#define FGF_GET_ORDER(fgf)	(((__force unsigned)fgf) >> 26)	/* top 6 bits */
>  
>  #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
>  
> +/**
> + * fgf_set_order - Encode a length in the fgf_t flags.
> + * @size: The suggested size of the folio to create.
> + *
> + * The caller of __filemap_get_folio() can use this to suggest a preferred
> + * size for the folio that is created.  If there is already a folio at
> + * the index, it will be returned, no matter what its size.  If a folio
> + * is freshly created, it may be of a different size than requested
> + * due to alignment constraints, memory pressure, or the presence of
> + * other folios at nearby indices.
> + */
> +static inline fgf_t fgf_set_order(size_t size)
> +{
> +	unsigned int shift = ilog2(size);
> +
> +	if (shift <= PAGE_SHIFT)
> +		return 0;
> +	return (__force fgf_t)((shift - PAGE_SHIFT) << 26);
> +}
> +
>  void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
>  struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		fgf_t fgp_flags, gfp_t gfp);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 8a669fecfd1c..baafbf324c9f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1905,7 +1905,9 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		folio_wait_stable(folio);
>  no_page:
>  	if (!folio && (fgp_flags & FGP_CREAT)) {
> +		unsigned order = FGF_GET_ORDER(fgp_flags);
>  		int err;
> +
>  		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
>  			gfp |= __GFP_WRITE;
>  		if (fgp_flags & FGP_NOFS)
> @@ -1914,26 +1916,44 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  			gfp &= ~GFP_KERNEL;
>  			gfp |= GFP_NOWAIT | __GFP_NOWARN;
>  		}
> -
> -		folio = filemap_alloc_folio(gfp, 0);
> -		if (!folio)
> -			return ERR_PTR(-ENOMEM);
> -
>  		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
>  			fgp_flags |= FGP_LOCK;
>  
> -		/* Init accessed so avoid atomic mark_page_accessed later */
> -		if (fgp_flags & FGP_ACCESSED)
> -			__folio_set_referenced(folio);
> +		if (!mapping_large_folio_support(mapping))
> +			order = 0;
> +		if (order > MAX_PAGECACHE_ORDER)
> +			order = MAX_PAGECACHE_ORDER;
> +		/* If we're not aligned, allocate a smaller folio */
> +		if (index & ((1UL << order) - 1))
> +			order = __ffs(index);
>  
> -		err = filemap_add_folio(mapping, folio, index, gfp);
> -		if (unlikely(err)) {
> +		do {
> +			gfp_t alloc_gfp = gfp;
> +
> +			err = -ENOMEM;
> +			if (order == 1)
> +				order = 0;
> +			if (order > 0)
> +				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
> +			folio = filemap_alloc_folio(alloc_gfp, order);
> +			if (!folio)
> +				continue;
> +
> +			/* Init accessed so avoid atomic mark_page_accessed later */
> +			if (fgp_flags & FGP_ACCESSED)
> +				__folio_set_referenced(folio);
> +
> +			err = filemap_add_folio(mapping, folio, index, gfp);
> +			if (!err)
> +				break;
>  			folio_put(folio);
>  			folio = NULL;
> -			if (err == -EEXIST)
> -				goto repeat;
> -		}
> +		} while (order-- > 0);
>  
> +		if (err == -EEXIST)
> +			goto repeat;
> +		if (err)
> +			return ERR_PTR(err);
>  		/*
>  		 * filemap_add_folio locks the page, and for mmap
>  		 * we expect an unlocked page.
> diff --git a/mm/readahead.c b/mm/readahead.c
> index a9c999aa19af..e815c114de21 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -461,19 +461,6 @@ static int try_context_readahead(struct address_space *mapping,
>  	return 1;
>  }
>  
> -/*
> - * There are some parts of the kernel which assume that PMD entries
> - * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
> - * limit the maximum allocation order to PMD size.  I'm not aware of any
> - * assumptions about maximum order if THP are disabled, but 8 seems like
> - * a good order (that's 1MB if you're using 4kB pages)
> - */
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
> -#else
> -#define MAX_PAGECACHE_ORDER	8
> -#endif
> -
>  static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
>  		pgoff_t mark, unsigned int order, gfp_t gfp)
>  {
> -- 
> 2.39.2
> 
