Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5048721924
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jun 2023 20:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjFDSJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 14:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjFDSJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 14:09:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1AFCD;
        Sun,  4 Jun 2023 11:09:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBC6D60F19;
        Sun,  4 Jun 2023 18:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A7FC433EF;
        Sun,  4 Jun 2023 18:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685902166;
        bh=snXEXkDAnrxTtoSnSl3U0rxF0IrezhNODcRFu4UYoi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AuTtYdRCJ1ZJZ8ihd4cH0u0I3rsoduvzeSQR4NxZRaaI0Qj+oVdkmacdoUqTMVJ2I
         kzVEmwR9laVDs9IWyOF6dNx3D5IDvrlw8/mDNBf9GKYCbPtgfgbrxaKrF12wbVdAig
         WMpyEruR7CxcfnhKHEUg+3YZwkNIQ9l9BcG5hHjx1oJoETk3WuqZPWJBrjKD9KTmbk
         fr8YoWiOy8vGhao+Qq4dBbSUWGRkU6v5KFVDPWvnmOn3eM/hT2U6dHj/At0qtIJ2th
         k+0m3mnYVhKYgESWq6CQIq27aGQ/1cQTtu3eyDLa3/JL2tZnxbqcLtUxd3Uw+c8ZsT
         pFgg16/EQBJag==
Date:   Sun, 4 Jun 2023 11:09:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 5/7] filemap: Allow __filemap_get_folio to allocate
 large folios
Message-ID: <20230604180925.GF72241@frogsfrogsfrogs>
References: <20230602222445.2284892-1-willy@infradead.org>
 <20230602222445.2284892-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230602222445.2284892-6-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02, 2023 at 11:24:42PM +0100, Matthew Wilcox (Oracle) wrote:
> Allow callers of __filemap_get_folio() to specify a preferred folio
> order in the FGP flags.  This is only honoured in the FGP_CREATE path;
> if there is already a folio in the page cache that covers the index,
> we will return it, no matter what its order is.  No create-around is
> attempted; we will only create folios which start at the specified index.
> Unmodified callers will continue to allocate order 0 folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pagemap.h | 23 ++++++++++++++++++++++
>  mm/filemap.c            | 42 ++++++++++++++++++++++++++++-------------
>  mm/readahead.c          | 13 -------------
>  3 files changed, 52 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 7ab57a2bb576..667ce668f438 100644
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
> @@ -531,9 +544,19 @@ typedef unsigned int __bitwise fgp_t;
>  #define FGP_NOWAIT		((__force fgp_t)0x00000020)
>  #define FGP_FOR_MMAP		((__force fgp_t)0x00000040)
>  #define FGP_STABLE		((__force fgp_t)0x00000080)
> +#define FGP_GET_ORDER(fgp)	(((__force unsigned)fgp) >> 26)	/* top 6 bits */
>  
>  #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
>  
> +static inline fgp_t fgp_set_order(size_t size)
> +{
> +	unsigned int shift = ilog2(size);
> +
> +	if (shift <= PAGE_SHIFT)
> +		return 0;
> +	return (__force fgp_t)((shift - PAGE_SHIFT) << 26);
> +}
> +
>  void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
>  struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		fgp_t fgp_flags, gfp_t gfp);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index eb89a815f2f8..10ea9321c36e 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1937,7 +1937,9 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		folio_wait_stable(folio);
>  no_page:
>  	if (!folio && (fgp_flags & FGP_CREAT)) {
> +		unsigned order = FGP_GET_ORDER(fgp_flags);
>  		int err;
> +
>  		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
>  			gfp |= __GFP_WRITE;
>  		if (fgp_flags & FGP_NOFS)
> @@ -1946,26 +1948,40 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
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

Doesn't this interrupt the scale-down progression 2M -> 1M -> 512K ->
256K -> 128K -> 64K -> 32K -> 16K -> 4k?  What if I want 8k folios?

--D

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
> 
