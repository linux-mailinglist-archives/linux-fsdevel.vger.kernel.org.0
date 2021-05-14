Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A705E380DA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 17:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhENP5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 11:57:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:58768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231503AbhENP47 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 11:56:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 66346B05C;
        Fri, 14 May 2021 15:55:47 +0000 (UTC)
Subject: Re: [PATCH v10 12/33] mm/filemap: Add folio_index, folio_file_page
 and folio_contains
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-13-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <77357d4f-5f56-6c12-7602-697773c2f125@suse.cz>
Date:   Fri, 14 May 2021 17:55:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-13-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> folio_index() is the equivalent of page_index() for folios.
> folio_file_page() is the equivalent of find_subpage().

find_subpage() special cases hugetlbfs, folio_file_page() doesn't.

> folio_contains() is the equivalent of thp_contains().

Yet here, both thp_contains() and folio_contains() does.

This patch doesn't add users so maybe it becomes obvious later, but perhaps
worth explaining in the changelog or comment?

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/pagemap.h | 53 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index bc5fa3d7204e..8eaeffccfd38 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -386,6 +386,59 @@ static inline bool thp_contains(struct page *head, pgoff_t index)
>  	return page_index(head) == (index & ~(thp_nr_pages(head) - 1UL));
>  }
>  
> +#define swapcache_index(folio)	__page_file_index(&(folio)->page)
> +
> +/**
> + * folio_index - File index of a folio.
> + * @folio: The folio.
> + *
> + * For a folio which is either in the page cache or the swap cache,
> + * return its index within the address_space it belongs to.  If you know
> + * the page is definitely in the page cache, you can look at the folio's
> + * index directly.
> + *
> + * Return: The index (offset in units of pages) of a folio in its file.
> + */
> +static inline pgoff_t folio_index(struct folio *folio)
> +{
> +        if (unlikely(folio_swapcache(folio)))
> +                return swapcache_index(folio);
> +        return folio->index;
> +}
> +
> +/**
> + * folio_file_page - The page for a particular index.
> + * @folio: The folio which contains this index.
> + * @index: The index we want to look up.
> + *
> + * Sometimes after looking up a folio in the page cache, we need to
> + * obtain the specific page for an index (eg a page fault).
> + *
> + * Return: The page containing the file data for this index.
> + */
> +static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
> +{
> +	return folio_page(folio, index & (folio_nr_pages(folio) - 1));
> +}
> +
> +/**
> + * folio_contains - Does this folio contain this index?
> + * @folio: The folio.
> + * @index: The page index within the file.
> + *
> + * Context: The caller should have the page locked in order to prevent
> + * (eg) shmem from moving the page between the page cache and swap cache
> + * and changing its index in the middle of the operation.
> + * Return: true or false.
> + */
> +static inline bool folio_contains(struct folio *folio, pgoff_t index)
> +{
> +	/* HugeTLBfs indexes the page cache in units of hpage_size */
> +	if (folio_hugetlb(folio))
> +		return folio->index == index;
> +	return index - folio_index(folio) < folio_nr_pages(folio);
> +}
> +
>  /*
>   * Given the page we found in the page cache, return the page corresponding
>   * to this index in the file
> 

