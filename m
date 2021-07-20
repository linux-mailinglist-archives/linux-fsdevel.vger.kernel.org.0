Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDBA3CF843
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbhGTKFq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:05:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237597AbhGTKEJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:04:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E7956121E;
        Tue, 20 Jul 2021 10:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777876;
        bh=d9tgQRq5Fxmw0iM7eOYgV7BJgKToxktV0wuTYMVmwP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g2mGuPskK6Nj7LoCcncu+7a8hq9J1NBVblyMfE7ks/Mtl6mUTbLOoxoGILFW8HZ0r
         QKBKa374DCJFSS3dmy7Z9JR7K+CqZ5xvGOe1fZob2e5osd5CVa8FlRKABg0UcOGbd2
         qxPno3wSzxFEwAodHzsjH9f7XsMB6ya4bGPVRy2d1GJnzzBgknpmL676mytJ9y1HYs
         crmtHOj6BZZR4l93oEjFAvPgRNWcY11QLhm9LcQLc0aDh6ErM7ZIaYRyy/FIKkL4+V
         q6hJF/Yn/B/rIMgCaz8CsW6N/iPu0ST6sxXy68KCTXMM96rIHq0olbdIjwx/tG5GKG
         h23FpmJCtKfqQ==
Date:   Tue, 20 Jul 2021 13:44:27 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 016/138] mm/util: Add folio_mapping() and
 folio_file_mapping()
Message-ID: <YPapC3HOBTpaFTmx@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-17-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:02AM +0100, Matthew Wilcox (Oracle) wrote:
> These are the folio equivalent of page_mapping() and page_file_mapping().
> Add an out-of-line page_mapping() wrapper around folio_mapping()
> in order to prevent the page_folio() call from bloating every caller
> of page_mapping().  Adjust page_file_mapping() and page_mapping_file()
> to use folios internally.  Rename __page_file_mapping() to
> swapcache_mapping() and change it to take a folio.
> 
> This ends up saving 122 bytes of text overall.  folio_mapping() is
> 45 bytes shorter than page_mapping() was, but the new page_mapping()
> wrapper is 30 bytes.  The major reduction is a few bytes less in dozens
> of nfs functions (which call page_file_mapping()).  Most of these appear
> to be a slight change in gcc's register allocation decisions, which allow:
> 
>    48 8b 56 08         mov    0x8(%rsi),%rdx
>    48 8d 42 ff         lea    -0x1(%rdx),%rax
>    83 e2 01            and    $0x1,%edx
>    48 0f 44 c6         cmove  %rsi,%rax
> 
> to become:
> 
>    48 8b 46 08         mov    0x8(%rsi),%rax
>    48 8d 78 ff         lea    -0x1(%rax),%rdi
>    a8 01               test   $0x1,%al
>    48 0f 44 fe         cmove  %rsi,%rdi
> 
> for a reduction of a single byte.  Once the NFS client is converted to
> use folios, this entire sequence will disappear.
> 
> Also add folio_mapping() documentation.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  Documentation/core-api/mm-api.rst |  2 ++
>  include/linux/mm.h                | 14 -------------
>  include/linux/pagemap.h           | 35 +++++++++++++++++++++++++++++--
>  include/linux/swap.h              |  6 ++++++
>  mm/Makefile                       |  2 +-
>  mm/folio-compat.c                 | 13 ++++++++++++
>  mm/swapfile.c                     |  8 +++----
>  mm/util.c                         | 30 +++++++++++++++-----------
>  8 files changed, 77 insertions(+), 33 deletions(-)
>  create mode 100644 mm/folio-compat.c
> 
> diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
> index 5c459ee2acce..dcce6605947a 100644
> --- a/Documentation/core-api/mm-api.rst
> +++ b/Documentation/core-api/mm-api.rst
> @@ -100,3 +100,5 @@ More Memory Management Functions
>     :internal:
>  .. kernel-doc:: include/linux/page_ref.h
>  .. kernel-doc:: include/linux/mmzone.h
> +.. kernel-doc:: mm/util.c
> +   :functions: folio_mapping
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 788fbc4cde0c..9d28f5b2e983 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1753,19 +1753,6 @@ void page_address_init(void);
>  
>  extern void *page_rmapping(struct page *page);
>  extern struct anon_vma *page_anon_vma(struct page *page);
> -extern struct address_space *page_mapping(struct page *page);
> -
> -extern struct address_space *__page_file_mapping(struct page *);
> -
> -static inline
> -struct address_space *page_file_mapping(struct page *page)
> -{
> -	if (unlikely(PageSwapCache(page)))
> -		return __page_file_mapping(page);
> -
> -	return page->mapping;
> -}
> -
>  extern pgoff_t __page_file_index(struct page *page);
>  
>  /*
> @@ -1780,7 +1767,6 @@ static inline pgoff_t page_index(struct page *page)
>  }
>  
>  bool page_mapped(struct page *page);
> -struct address_space *page_mapping(struct page *page);
>  
>  /*
>   * Return true only if the page has been allocated with
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index aa71fa82d6be..a0925a89ba11 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -162,14 +162,45 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
>  
>  void release_pages(struct page **pages, int nr);
>  
> +struct address_space *page_mapping(struct page *);
> +struct address_space *folio_mapping(struct folio *);
> +struct address_space *swapcache_mapping(struct folio *);
> +
> +/**
> + * folio_file_mapping - Find the mapping this folio belongs to.
> + * @folio: The folio.
> + *
> + * For folios which are in the page cache, return the mapping that this
> + * page belongs to.  Folios in the swap cache return the mapping of the
> + * swap file or swap device where the data is stored.  This is different
> + * from the mapping returned by folio_mapping().  The only reason to
> + * use it is if, like NFS, you return 0 from ->activate_swapfile.
> + *
> + * Do not call this for folios which aren't in the page cache or swap cache.

Missing return value description.

> + */
> +static inline struct address_space *folio_file_mapping(struct folio *folio)
> +{
> +	if (unlikely(folio_test_swapcache(folio)))
> +		return swapcache_mapping(folio);
> +
> +	return folio->mapping;
> +}
> +
> +static inline struct address_space *page_file_mapping(struct page *page)
> +{
> +	return folio_file_mapping(page_folio(page));
> +}
> +

[ snip ]

> diff --git a/mm/util.c b/mm/util.c
> index 9043d03750a7..1cde6218d6d1 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -686,30 +686,36 @@ struct anon_vma *page_anon_vma(struct page *page)
>  	return __page_rmapping(page);
>  }
>  
> -struct address_space *page_mapping(struct page *page)
> +/**
> + * folio_mapping - Find the mapping where this folio is stored.
> + * @folio: The folio.
> + *
> + * For folios which are in the page cache, return the mapping that this
> + * page belongs to.  Folios in the swap cache return the swap mapping
> + * this page is stored in (which is different from the mapping for the
> + * swap file or swap device where the data is stored).
> + *
> + * You can call this for folios which aren't in the swap cache or page
> + * cache and it will return NULL.
> + */

Missing return value description.

> +struct address_space *folio_mapping(struct folio *folio)
>  {
>  	struct address_space *mapping;
>  
> -	page = compound_head(page);
> -
>  	/* This happens if someone calls flush_dcache_page on slab page */
> -	if (unlikely(PageSlab(page)))
> +	if (unlikely(folio_test_slab(folio)))
>  		return NULL;
>  
> -	if (unlikely(PageSwapCache(page))) {
> -		swp_entry_t entry;
> -
> -		entry.val = page_private(page);
> -		return swap_address_space(entry);
> -	}
> +	if (unlikely(folio_test_swapcache(folio)))
> +		return swap_address_space(folio_swap_entry(folio));
>  
> -	mapping = page->mapping;
> +	mapping = folio->mapping;
>  	if ((unsigned long)mapping & PAGE_MAPPING_ANON)
>  		return NULL;
>  
>  	return (void *)((unsigned long)mapping & ~PAGE_MAPPING_FLAGS);
>  }
> -EXPORT_SYMBOL(page_mapping);
> +EXPORT_SYMBOL(folio_mapping);
>  
>  /* Slow path of page_mapcount() for compound pages */
>  int __page_mapcount(struct page *page)
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
