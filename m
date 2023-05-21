Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB69170ABD8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 03:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjEUBCm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 21:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEUBCl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 21:02:41 -0400
Received: from out28-83.mail.aliyun.com (out28-83.mail.aliyun.com [115.124.28.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B37F2;
        Sat, 20 May 2023 18:02:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436273|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0212644-0.000666645-0.978069;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.T7qcRl2_1684630955;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.T7qcRl2_1684630955)
          by smtp.aliyun-inc.com;
          Sun, 21 May 2023 09:02:36 +0800
Date:   Sun, 21 May 2023 09:02:36 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 1/3] filemap: Allow __filemap_get_folio to allocate large folios
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
In-Reply-To: <20230520163603.1794256-2-willy@infradead.org>
References: <20230520163603.1794256-1-willy@infradead.org> <20230520163603.1794256-2-willy@infradead.org>
Message-Id: <20230521090235.4860.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

> Allow callers of __filemap_get_folio() to specify a preferred folio
> order in the FGP flags.  This is only honoured in the FGP_CREATE path;
> if there is already a folio in the page cache that covers the index,
> we will return it, no matter what its order is.  No create-around is
> attempted; we will only create folios which start at the specified index.
> Unmodified callers will continue to allocate order 0 folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pagemap.h | 29 ++++++++++++++++++++++++---
>  mm/filemap.c            | 44 ++++++++++++++++++++++++++++-------------
>  mm/folio-compat.c       |  2 +-
>  mm/readahead.c          | 13 ------------
>  4 files changed, 57 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index a56308a9d1a4..f4d05beb64eb 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -466,6 +466,19 @@ static inline void *detach_page_private(struct page *page)
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
> @@ -505,14 +518,24 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
>  #define FGP_NOWAIT		0x00000020
>  #define FGP_FOR_MMAP		0x00000040
>  #define FGP_STABLE		0x00000080
> +#define FGP_ORDER(fgp)		((fgp) >> 26)	/* top 6 bits */
>  
>  #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
>  
> +static inline unsigned fgp_order(size_t size)
> +{
> +	unsigned int shift = ilog2(size);
> +
> +	if (shift <= PAGE_SHIFT)
> +		return 0;
> +	return (shift - PAGE_SHIFT) << 26;

int overflow will happen when size > 0.5M(2**19)?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/05/21



> +}
> +
>  void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
>  struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> -		int fgp_flags, gfp_t gfp);
> +		unsigned fgp_flags, gfp_t gfp);
>  struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
> -		int fgp_flags, gfp_t gfp);
> +		unsigned fgp_flags, gfp_t gfp);
>  
>  /**
>   * filemap_get_folio - Find and get a folio.
> @@ -586,7 +609,7 @@ static inline struct page *find_get_page(struct address_space *mapping,
>  }
>  
>  static inline struct page *find_get_page_flags(struct address_space *mapping,
> -					pgoff_t offset, int fgp_flags)
> +					pgoff_t offset, unsigned fgp_flags)
>  {
>  	return pagecache_get_page(mapping, offset, fgp_flags, 0);
>  }
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b4c9bd368b7e..5935c7aac388 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1910,7 +1910,7 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
>   * Return: The found folio or an ERR_PTR() otherwise.
>   */
>  struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
> -		int fgp_flags, gfp_t gfp)
> +		unsigned fgp_flags, gfp_t gfp)
>  {
>  	struct folio *folio;
>  
> @@ -1952,7 +1952,9 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		folio_wait_stable(folio);
>  no_page:
>  	if (!folio && (fgp_flags & FGP_CREAT)) {
> +		unsigned order = FGP_ORDER(fgp_flags);
>  		int err;
> +
>  		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
>  			gfp |= __GFP_WRITE;
>  		if (fgp_flags & FGP_NOFS)
> @@ -1961,26 +1963,40 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
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
> +			err = -ENOMEM;
> +			if (order == 1)
> +				order = 0;
> +			folio = filemap_alloc_folio(gfp, order);
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
> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> index c6f056c20503..c96e88d9a262 100644
> --- a/mm/folio-compat.c
> +++ b/mm/folio-compat.c
> @@ -92,7 +92,7 @@ EXPORT_SYMBOL(add_to_page_cache_lru);
>  
>  noinline
>  struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
> -		int fgp_flags, gfp_t gfp)
> +		unsigned fgp_flags, gfp_t gfp)
>  {
>  	struct folio *folio;
>  
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 47afbca1d122..59a071badb90 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -462,19 +462,6 @@ static int try_context_readahead(struct address_space *mapping,
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


