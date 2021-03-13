Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54B733A113
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 21:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbhCMUha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 15:37:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234182AbhCMUhD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 15:37:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CEB164ED0;
        Sat, 13 Mar 2021 20:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615667823;
        bh=UI0HkP9X7m07NOz6hRKQi+21yPSkfnX0o3Xglae/BtQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dCMb52FA4ze5ATLxcnEX79RIo5szz29rAuSnwieARL7fT0w7DNki4dnSI2iKfASOy
         Ps9aaCqGLE6bGv8fmNj2zrvQaloRQLTwvIOGM96DpG4954zZUkmKul+B9wiMX03o04
         aUOwiGFWsvFhz2qLsOw2Q0peInLNEEUamw3J8fjM=
Date:   Sat, 13 Mar 2021 12:37:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 01/25] mm: Introduce struct folio
Message-Id: <20210313123702.b7724b84d955ab6669d4417a@linux-foundation.org>
In-Reply-To: <20210305041901.2396498-2-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
        <20210305041901.2396498-2-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri,  5 Mar 2021 04:18:37 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> A struct folio refers to an entire (possibly compound) page.  A function
> which takes a struct folio argument declares that it will operate on the
> entire compound page, not just PAGE_SIZE bytes.  In return, the caller
> guarantees that the pointer it is passing does not point to a tail page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mm.h       | 30 ++++++++++++++++++++++++++++++
>  include/linux/mm_types.h | 17 +++++++++++++++++

Perhaps a new folio.h would be neater.

> @@ -1518,6 +1523,30 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
>  #endif
>  }
>  
> +static inline unsigned long folio_nr_pages(struct folio *folio)
> +{
> +	return compound_nr(&folio->page);
> +}
> +
> +static inline struct folio *next_folio(struct folio *folio)
> +{
> +#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
> +	return (struct folio *)nth_page(&folio->page, folio_nr_pages(folio));
> +#else
> +	return folio + folio_nr_pages(folio);
> +#endif
> +}

It's a shame this isn't called folio_something(), like the rest of the API.

Unclear what this does.  Some comments would help.

> +static inline unsigned int folio_shift(struct folio *folio)
> +{
> +	return PAGE_SHIFT + folio_order(folio);
> +}
> +
> +static inline size_t folio_size(struct folio *folio)
> +{
> +	return PAGE_SIZE << folio_order(folio);
> +}

Why size_t?  That's pretty rare in this space and I'd have expected
unsigned long.


> @@ -1623,6 +1652,7 @@ extern void pagefault_out_of_memory(void);
>  
>  #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
>  #define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
> +#define offset_in_folio(folio, p) ((unsigned long)(p) & (folio_size(folio) - 1))
>  
>  /*
>   * Flags passed to show_mem() and show_free_areas() to suppress output in
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 0974ad501a47..a311cb48526f 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -223,6 +223,23 @@ struct page {
>  #endif
>  } _struct_page_alignment;
>  
> +/*
> + * A struct folio is either a base (order-0) page or the head page of
> + * a compound page.
> + */
> +struct folio {
> +	struct page page;
> +};
> +
> +static inline struct folio *page_folio(struct page *page)
> +{
> +	unsigned long head = READ_ONCE(page->compound_head);
> +
> +	if (unlikely(head & 1))
> +		return (struct folio *)(head - 1);
> +	return (struct folio *)page;
> +}

What purpose does the READ_ONCE() serve?


