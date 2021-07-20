Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D663CF80F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbhGTKAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237352AbhGTJ7i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 05:59:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65BAF61003;
        Tue, 20 Jul 2021 10:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777613;
        bh=oit8KASw4VGl936MooGr9NxSoLULbYuezj0qb+dRt/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Okx0xdqklCsIRsXyt7Jvy/+L0397JE/0ImYa0rBZi40QVpcOprShfQ9kMSwSmj02Q
         vdN6KAz7LWdqQSyPjZWa9zHHf5z+P2uqsf3P3JXGU8FYeAlm9kKH+v/23sQcbSQ/sl
         IGj5uH9ltsA0+429w2JxVTuRRMKYdwGWIDaUxVYE7r9nKTvY1mftCJIcqn19KeekCA
         lsa/RF6OxchrirVVKeNDCqIXiWN0R/pWGWpO8I4TIjBplrvMwr2bakQtYaaf5ds/T4
         Bb3tre/5X804JDErdehM3A6lvHvn2EAkDN5lygHG8iEauYRYrq7vZpKogndDV5k6aq
         CN0tSS4tDLfwA==
Date:   Tue, 20 Jul 2021 13:40:05 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 002/138] mm: Introduce struct folio
Message-ID: <YPaoBcXmrLv7zpD2@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-3-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:34:48AM +0100, Matthew Wilcox (Oracle) wrote:
> A struct folio is a new abstraction to replace the venerable struct page.
> A function which takes a struct folio argument declares that it will
> operate on the entire (possibly compound) page, not just PAGE_SIZE bytes.
> In return, the caller guarantees that the pointer it is passing does
> not point to a tail page.  No change to generated code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: David Howells <dhowells@redhat.com>

Except for small nits below

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  Documentation/core-api/mm-api.rst |  1 +
>  include/linux/mm.h                | 74 +++++++++++++++++++++++++++++++
>  include/linux/mm_types.h          | 60 +++++++++++++++++++++++++
>  include/linux/page-flags.h        | 28 ++++++++++++
>  4 files changed, 163 insertions(+)
> 
> diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
> index a42f9baddfbf..2a94e6164f80 100644
> --- a/Documentation/core-api/mm-api.rst
> +++ b/Documentation/core-api/mm-api.rst
> @@ -95,6 +95,7 @@ More Memory Management Functions
>  .. kernel-doc:: mm/mempolicy.c
>  .. kernel-doc:: include/linux/mm_types.h
>     :internal:
> +.. kernel-doc:: include/linux/page-flags.h
>  .. kernel-doc:: include/linux/mm.h
>     :internal:
>  .. kernel-doc:: include/linux/mmzone.h
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8dd65290bac0..5071084a71b9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -949,6 +949,20 @@ static inline unsigned int compound_order(struct page *page)
>  	return page[1].compound_order;
>  }
>  
> +/**
> + * folio_order - The allocation order of a folio.
> + * @folio: The folio.
> + *
> + * A folio is composed of 2^order pages.  See get_order() for the definition
> + * of order.
> + *
> + * Return: The order of the folio.
> + */
> +static inline unsigned int folio_order(struct folio *folio)
> +{
> +	return compound_order(&folio->page);
> +}
> +
>  static inline bool hpage_pincount_available(struct page *page)
>  {
>  	/*
> @@ -1594,6 +1608,65 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
>  #endif
>  }
>  
> +/**
> + * folio_nr_pages - The number of pages in the folio.
> + * @folio: The folio.
> + *
> + * Return: A number which is a power of two.
> + */
> +static inline unsigned long folio_nr_pages(struct folio *folio)
> +{
> +	return compound_nr(&folio->page);
> +}
> +
> +/**
> + * folio_next - Move to the next physical folio.
> + * @folio: The folio we're currently operating on.
> + *
> + * If you have physically contiguous memory which may span more than
> + * one folio (eg a &struct bio_vec), use this function to move from one
> + * folio to the next.  Do not use it if the memory is only virtually
> + * contiguous as the folios are almost certainly not adjacent to each
> + * other.  This is the folio equivalent to writing ``page++``.
> + *
> + * Context: We assume that the folios are refcounted and/or locked at a
> + * higher level and do not adjust the reference counts.
> + * Return: The next struct folio.
> + */
> +static inline struct folio *folio_next(struct folio *folio)
> +{
> +	return (struct folio *)folio_page(folio, folio_nr_pages(folio));
> +}
> +
> +/**
> + * folio_shift - The number of bits covered by this folio.

For me this sounds like the size of the folio in bits.
Maybe just repeat "The base-2 logarithm of the size of this folio" here and
in return description?

> + * @folio: The folio.
> + *
> + * A folio contains a number of bytes which is a power-of-two in size.
> + * This function tells you which power-of-two the folio is.
> + *
> + * Context: The caller should have a reference on the folio to prevent
> + * it from being split.  It is not necessary for the folio to be locked.
> + * Return: The base-2 logarithm of the size of this folio.
> + */
> +static inline unsigned int folio_shift(struct folio *folio)
> +{
> +	return PAGE_SHIFT + folio_order(folio);
> +}
> +
> +/**
> + * folio_size - The number of bytes in a folio.
> + * @folio: The folio.
> + *
> + * Context: The caller should have a reference on the folio to prevent
> + * it from being split.  It is not necessary for the folio to be locked.
> + * Return: The number of bytes in this folio.
> + */
> +static inline size_t folio_size(struct folio *folio)
> +{
> +	return PAGE_SIZE << folio_order(folio);
> +}
> +
>  /*
>   * Some inline functions in vmstat.h depend on page_zone()
>   */
> @@ -1699,6 +1772,7 @@ extern void pagefault_out_of_memory(void);
>  
>  #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
>  #define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
> +#define offset_in_folio(folio, p) ((unsigned long)(p) & (folio_size(folio) - 1))
>  
>  /*
>   * Flags passed to show_mem() and show_free_areas() to suppress output in
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 52bbd2b7cb46..f023eaa866fe 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -231,6 +231,66 @@ struct page {
>  #endif
>  } _struct_page_alignment;
>  
> +/**
> + * struct folio - Represents a contiguous set of bytes.
> + * @flags: Identical to the page flags.
> + * @lru: Least Recently Used list; tracks how recently this folio was used.
> + * @mapping: The file this page belongs to, or refers to the anon_vma for
> + *    anonymous pages.
> + * @index: Offset within the file, in units of pages.  For anonymous pages,

Nit:                                                          maybe memory? ^

> + *    this is the index from the beginning of the mmap.
> + * @private: Filesystem per-folio data (see folio_attach_private()).
> + *    Used for swp_entry_t if folio_test_swapcache().
> + * @_mapcount: Do not access this member directly.  Use folio_mapcount() to
> + *    find out how many times this folio is mapped by userspace.
> + * @_refcount: Do not access this member directly.  Use folio_ref_count()
> + *    to find how many references there are to this folio.
> + * @memcg_data: Memory Control Group data.
> + *
> + * A folio is a physically, virtually and logically contiguous set
> + * of bytes.  It is a power-of-two in size, and it is aligned to that
> + * same power-of-two.  It is at least as large as %PAGE_SIZE.  If it is
> + * in the page cache, it is at a file offset which is a multiple of that
> + * power-of-two.  It may be mapped into userspace at an address which is
> + * at an arbitrary page offset, but its kernel virtual address is aligned
> + * to its size.
> + */
> +struct folio {
> +	/* private: don't document the anon union */
> +	union {
> +		struct {
> +	/* public: */
> +			unsigned long flags;
> +			struct list_head lru;
> +			struct address_space *mapping;
> +			pgoff_t index;
> +			void *private;
> +			atomic_t _mapcount;
> +			atomic_t _refcount;
> +#ifdef CONFIG_MEMCG
> +			unsigned long memcg_data;
> +#endif
> +	/* private: the union with struct page is transitional */
> +		};
> +		struct page page;
> +	};
> +};
> +
> +static_assert(sizeof(struct page) == sizeof(struct folio));
> +#define FOLIO_MATCH(pg, fl)						\
> +	static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
> +FOLIO_MATCH(flags, flags);
> +FOLIO_MATCH(lru, lru);
> +FOLIO_MATCH(compound_head, lru);
> +FOLIO_MATCH(index, index);
> +FOLIO_MATCH(private, private);
> +FOLIO_MATCH(_mapcount, _mapcount);
> +FOLIO_MATCH(_refcount, _refcount);
> +#ifdef CONFIG_MEMCG
> +FOLIO_MATCH(memcg_data, memcg_data);
> +#endif
> +#undef FOLIO_MATCH
> +
>  static inline atomic_t *compound_mapcount_ptr(struct page *page)
>  {
>  	return &page[1].compound_mapcount;
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 5922031ffab6..70ede8345538 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -191,6 +191,34 @@ static inline unsigned long _compound_head(const struct page *page)
>  
>  #define compound_head(page)	((typeof(page))_compound_head(page))
>  
> +/**
> + * page_folio - Converts from page to folio.
> + * @p: The page.
> + *
> + * Every page is part of a folio.  This function cannot be called on a
> + * NULL pointer.
> + *
> + * Context: No reference, nor lock is required on @page.  If the caller
> + * does not hold a reference, this call may race with a folio split, so
> + * it should re-check the folio still contains this page after gaining
> + * a reference on the folio.
> + * Return: The folio which contains this page.
> + */
> +#define page_folio(p)		(_Generic((p),				\
> +	const struct page *:	(const struct folio *)_compound_head(p), \
> +	struct page *:		(struct folio *)_compound_head(p)))
> +
> +/**
> + * folio_page - Return a page from a folio.
> + * @folio: The folio.
> + * @n: The page number to return.
> + *
> + * @n is relative to the start of the folio.  This function does not
> + * check that the page number lies within @folio; the caller is presumed
> + * to have a reference to the page.
> + */
> +#define folio_page(folio, n)	nth_page(&(folio)->page, n)
> +
>  static __always_inline int PageTail(struct page *page)
>  {
>  	return READ_ONCE(page->compound_head) & 1;
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
