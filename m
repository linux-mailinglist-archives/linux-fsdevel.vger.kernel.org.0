Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFDC66BF95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 14:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjAPNTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 08:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjAPNSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:18:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E475249;
        Mon, 16 Jan 2023 05:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=omN11K0GI/xhx3NUwdC4C9fLf+3VpRmOQ0DYrSkQAI8=; b=b3cUub8BzpeSKs65+jE7bP9acg
        X9wv+OJT9mphIB0pbumFvGRvN7B4sryhv07C8XjHqoFGU/HbJp4xWtNxWe7I6CYDx8vu3Ma8Advdf
        umhAFCq7+w8TlGjO3Xd9zqgKEtcG8M9ukYZaeuGtt1FneWTQnvEQijaBAODQiD/LSCSNOhON2WD0V
        Hu11mAApRKqpA3DeM4TJYkZZz94qDHxyx12B56CA42TtXPifErJvfA9bdgOE7t/EKowABnAwNMnMg
        qTpEEjI1FxLozF1Ayx4ll1iPLz7rpBo2/sWYs7+PJFo8qEOudirIlWsXdlZYeMWummt23HdhcNATl
        6rxgszPw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHPNH-008lPF-Hk; Mon, 16 Jan 2023 13:18:07 +0000
Date:   Mon, 16 Jan 2023 13:18:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v6 04/10] iomap: Add iomap_get_folio helper
Message-ID: <Y8VOjyLW1Q4lbQvS@casper.infradead.org>
References: <20230108213305.GO1971568@dread.disaster.area>
 <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-5-agruenba@redhat.com>
 <20230109124642.1663842-1-agruenba@redhat.com>
 <Y70l9ZZXpERjPqFT@infradead.org>
 <Y71pWJ0JHwGrJ/iv@casper.infradead.org>
 <Y8QxYjy+4Kjg05rB@magnolia>
 <Y8QyqlAkLyysv8Qd@magnolia>
 <Y8TkmbZfe3L/Yeky@casper.infradead.org>
 <Y8T+Al0aqRcXWzwt@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8T+Al0aqRcXWzwt@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 15, 2023 at 11:34:26PM -0800, Christoph Hellwig wrote:
> We could do that.  But while reading what Darrick wrote I came up with
> another idea I quite like.  Just split the FGP_ENTRY handling into
> a separate helper.  The logic and use cases are quite different from
> the normal page cache lookup, and the returning of the xarray entry
> is exactly the kind of layering violation that Dave is complaining
> about.  So what about just splitting that use case into a separate
> self contained helper?

Essentially reverting 44835d20b2a0.  Although we retain the merging of
the lock & get functions via the use of FGP flags.  Let me think about
it for a day.

> ---
> >From b4d10f98ea57f8480c03c0b00abad6f2b7186f56 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 16 Jan 2023 08:26:57 +0100
> Subject: mm: replace FGP_ENTRY with a new __filemap_get_folio_entry helper
> 
> Split the xarray entry returning logic into a separate helper.  This will
> allow returning ERR_PTRs from __filemap_get_folio, and also isolates the
> logic that needs to known about xarray internals into a separate
> function.  This causes some code duplication, but as most flags to
> __filemap_get_folio are not applicable for the users that care about an
> entry that amount is very limited.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/pagemap.h |  6 +++--
>  mm/filemap.c            | 50 ++++++++++++++++++++++++++++++++++++-----
>  mm/huge_memory.c        |  4 ++--
>  mm/shmem.c              |  5 ++---
>  mm/swap_state.c         |  2 +-
>  5 files changed, 53 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 4b3a7124c76712..e06c14b610caf2 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -504,8 +504,7 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
>  #define FGP_NOFS		0x00000010
>  #define FGP_NOWAIT		0x00000020
>  #define FGP_FOR_MMAP		0x00000040
> -#define FGP_ENTRY		0x00000080
> -#define FGP_STABLE		0x00000100
> +#define FGP_STABLE		0x00000080
>  
>  struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		int fgp_flags, gfp_t gfp);
> @@ -546,6 +545,9 @@ static inline struct folio *filemap_lock_folio(struct address_space *mapping,
>  	return __filemap_get_folio(mapping, index, FGP_LOCK, 0);
>  }
>  
> +struct folio *__filemap_get_folio_entry(struct address_space *mapping,
> +		pgoff_t index, int fgp_flags);
> +
>  /**
>   * find_get_page - find and get a page reference
>   * @mapping: the address_space to search
> diff --git a/mm/filemap.c b/mm/filemap.c
> index c4d4ace9cc7003..d04613347b3e71 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1887,8 +1887,6 @@ static void *mapping_get_entry(struct address_space *mapping, pgoff_t index)
>   *
>   * * %FGP_ACCESSED - The folio will be marked accessed.
>   * * %FGP_LOCK - The folio is returned locked.
> - * * %FGP_ENTRY - If there is a shadow / swap / DAX entry, return it
> - *   instead of allocating a new folio to replace it.
>   * * %FGP_CREAT - If no page is present then a new page is allocated using
>   *   @gfp and added to the page cache and the VM's LRU list.
>   *   The page is returned locked and with an increased refcount.
> @@ -1914,11 +1912,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  
>  repeat:
>  	folio = mapping_get_entry(mapping, index);
> -	if (xa_is_value(folio)) {
> -		if (fgp_flags & FGP_ENTRY)
> -			return folio;
> +	if (xa_is_value(folio))
>  		folio = NULL;
> -	}
>  	if (!folio)
>  		goto no_page;
>  
> @@ -1994,6 +1989,49 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  }
>  EXPORT_SYMBOL(__filemap_get_folio);
>  
> +
> +/**
> + * __filemap_get_folio_entry - Find and get a reference to a folio.
> + * @mapping: The address_space to search.
> + * @index: The page index.
> + * @fgp_flags: %FGP flags modify how the folio is returned.
> + *
> + * Looks up the page cache entry at @mapping & @index.  If there is a shadow /
> + * swap / DAX entry, return it instead of allocating a new folio to replace it.
> + *
> + * @fgp_flags can be zero or more of these flags:
> + *
> + * * %FGP_LOCK - The folio is returned locked.
> + *
> + * If there is a page cache page, it is returned with an increased refcount.
> + *
> + * Return: The found folio or %NULL otherwise.
> + */
> +struct folio *__filemap_get_folio_entry(struct address_space *mapping,
> +		pgoff_t index, int fgp_flags)
> +{
> +	struct folio *folio;
> +
> +	if (WARN_ON_ONCE(fgp_flags & ~FGP_LOCK))
> +		return NULL;
> +
> +repeat:
> +	folio = mapping_get_entry(mapping, index);
> +	if (folio && !xa_is_value(folio) && (fgp_flags & FGP_LOCK)) {
> +		folio_lock(folio);
> +
> +		/* Has the page been truncated? */
> +		if (unlikely(folio->mapping != mapping)) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			goto repeat;
> +		}
> +		VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
> +	}
> +
> +	return folio;
> +}
> +
>  static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
>  		xa_mark_t mark)
>  {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index abe6cfd92ffa0e..88b517c338a6db 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3088,10 +3088,10 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
>  	mapping = candidate->f_mapping;
>  
>  	for (index = off_start; index < off_end; index += nr_pages) {
> -		struct folio *folio = __filemap_get_folio(mapping, index,
> -						FGP_ENTRY, 0);
> +		struct folio *folio;
>  
>  		nr_pages = 1;
> +		folio = __filemap_get_folio_entry(mapping, index, 0);
>  		if (xa_is_value(folio) || !folio)
>  			continue;
>  
> diff --git a/mm/shmem.c b/mm/shmem.c
> index c301487be5fb40..0a36563ef7a0c1 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -888,8 +888,7 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
>  	 * At first avoid shmem_get_folio(,,,SGP_READ): that fails
>  	 * beyond i_size, and reports fallocated pages as holes.
>  	 */
> -	folio = __filemap_get_folio(inode->i_mapping, index,
> -					FGP_ENTRY | FGP_LOCK, 0);
> +	folio = __filemap_get_folio_entry(inode->i_mapping, index, FGP_LOCK);
>  	if (!xa_is_value(folio))
>  		return folio;
>  	/*
> @@ -1860,7 +1859,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>  	sbinfo = SHMEM_SB(inode->i_sb);
>  	charge_mm = vma ? vma->vm_mm : NULL;
>  
> -	folio = __filemap_get_folio(mapping, index, FGP_ENTRY | FGP_LOCK, 0);
> +	folio = __filemap_get_folio_entry(mapping, index, FGP_LOCK);
>  	if (folio && vma && userfaultfd_minor(vma)) {
>  		if (!xa_is_value(folio)) {
>  			folio_unlock(folio);
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 2927507b43d819..1f45241987aea2 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -384,7 +384,7 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
>  {
>  	swp_entry_t swp;
>  	struct swap_info_struct *si;
> -	struct folio *folio = __filemap_get_folio(mapping, index, FGP_ENTRY, 0);
> +	struct folio *folio = __filemap_get_folio_entry(mapping, index, 0);
>  
>  	if (!xa_is_value(folio))
>  		goto out;
> -- 
> 2.39.0
> 
