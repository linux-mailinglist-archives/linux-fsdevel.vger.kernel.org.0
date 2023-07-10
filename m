Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9D374E25D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 01:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjGJX7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 19:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjGJX7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:59:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D119E4F;
        Mon, 10 Jul 2023 16:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1M/Y7aO6nWELov0unKkjWdsJ0ROVIaS9QJPVnR7cVh4=; b=en1YXEEI9n1eyW0rG42cMreqis
        GNPOp8wpSg3EF7L6JQ8xDUVUQpCwl6SIMPoSqce1peF4HReJLCY26LLBpMzYr8ZiD99qFoiKmnEj5
        EZhf4e6Q933WHgppkgaoAYhvTSGpFgyIYsHMjMT7dmlRKM7Y67Q81AeB3Q080KQXoxvMLKZoIy3LH
        +8c+2mTr1sQ1L6rQoH9ysnys+422Ho4fd/9fGk1c3LQbgQ+T7IJKDqJj0HHH/hPMwuRHh7gXedDkj
        Y+xEgzWaydyhXVyPKDznbbqm+8oik4WEg7IjUMkbmRYEVtg7iM31RJiwRzTEzxG1Ep/s/PTyUJXfg
        ZF8V8lPw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJ0mN-00D0X5-0d;
        Mon, 10 Jul 2023 23:58:55 +0000
Date:   Mon, 10 Jul 2023 16:58:55 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 7/9] filemap: Allow __filemap_get_folio to allocate
 large folios
Message-ID: <ZKybP22DRs1w4G3a@bombadil.infradead.org>
References: <20230710130253.3484695-1-willy@infradead.org>
 <20230710130253.3484695-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710130253.3484695-8-willy@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Curious how this ended up being the heuristic used to shoot for the
MAX_PAGECACHE_ORDER sky first, and then go down 1/2 each time. I don't
see it explained on the commit log but I'm sure there's has to be
some reasonable rationale. From the cover letter, I could guess that
it means the gains of always using the largest folio possible means
an implied latency savings through other means, so the small latencies
spent looking seem to no where compare to the saving in using. But
I rather understand a bit more for the rationale.

Are there situations where perhaps limitting this initial max preferred
high order folio might be smaller than MAX_PAGECACHE_ORDER? How if not,
how do we know?

  Luis
