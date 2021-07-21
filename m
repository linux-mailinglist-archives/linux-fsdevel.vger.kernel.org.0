Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B602E3D0CB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 13:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbhGUJmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 05:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237708AbhGUJRy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:17:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3A1460FDA;
        Wed, 21 Jul 2021 09:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626861511;
        bh=yg3A/XmekVR8rLDWBTeMI77jnMmj6hE4tX8618Ab1AM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O5pD51VgqSxVDtDIsF+crC5cK4JdD4w5vGuB4cg2Qx1A+lKK1Ii2MkpkYNqWXx8gB
         mA/murD3q0BRVdiGxJobSXxrz/t0/1lnq96EVnBp8b+o3vR/yIvJXhdf0l4N+OuaUW
         8qfxMBqET0ONx/GL2ymdZ8FaX14y8HTtsvWXP1xwcx6T/8liR7h+qmdaNokh/UQq7t
         QL+9WgLjQrQfK6kQWeS6N70LWc/eA7PF1wX9I6LVVgVa7bMmZcUcBRu2MXychIcxu6
         4bS6OAHm0/Mu9B7Bbmtti0THfrFA5CGxMrOGTbrC14+m4R/6Lm4G8pJKFHHp7/Sy4f
         amsbLLuqfpSKw==
Date:   Wed, 21 Jul 2021 12:58:24 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 054/138] mm: Add kmap_local_folio()
Message-ID: <YPfvwNHk6H9dOCKK@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-55-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-55-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:40AM +0100, Matthew Wilcox (Oracle) wrote:
> This allows us to map a portion of a folio.  Callers can only expect
> to access up to the next page boundary.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/highmem-internal.h | 11 +++++++++
>  include/linux/highmem.h          | 38 ++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> index 7902c7d8b55f..d5d6f930ae1d 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -73,6 +73,12 @@ static inline void *kmap_local_page(struct page *page)
>  	return __kmap_local_page_prot(page, kmap_prot);
>  }
>  
> +static inline void *kmap_local_folio(struct folio *folio, size_t offset)
> +{
> +	struct page *page = folio_page(folio, offset / PAGE_SIZE);
> +	return __kmap_local_page_prot(page, kmap_prot) + offset % PAGE_SIZE;
> +}
> +
>  static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
>  {
>  	return __kmap_local_page_prot(page, prot);
> @@ -160,6 +166,11 @@ static inline void *kmap_local_page(struct page *page)
>  	return page_address(page);
>  }
>  
> +static inline void *kmap_local_folio(struct folio *folio, size_t offset)
> +{
> +	return page_address(&folio->page) + offset;
> +}
> +
>  static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
>  {
>  	return kmap_local_page(page);
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 8c6e8e996c87..85de3bd0b47d 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -96,6 +96,44 @@ static inline void kmap_flush_unused(void);
>   */
>  static inline void *kmap_local_page(struct page *page);
>  
> +/**
> + * kmap_local_folio - Map a page in this folio for temporary usage
> + * @folio:	The folio to be mapped.
> + * @offset:	The byte offset within the folio.
> + *
> + * Returns: The virtual address of the mapping
> + *
> + * Can be invoked from any context.

Context: Can be invoked from any context.

> + *
> + * Requires careful handling when nesting multiple mappings because the map
> + * management is stack based. The unmap has to be in the reverse order of
> + * the map operation:
> + *
> + * addr1 = kmap_local_folio(page1, offset1);
> + * addr2 = kmap_local_folio(page2, offset2);

Please s/page/folio/g here and in the description below

> + * ...
> + * kunmap_local(addr2);
> + * kunmap_local(addr1);
> + *
> + * Unmapping addr1 before addr2 is invalid and causes malfunction.
> + *
> + * Contrary to kmap() mappings the mapping is only valid in the context of
> + * the caller and cannot be handed to other contexts.
> + *
> + * On CONFIG_HIGHMEM=n kernels and for low memory pages this returns the
> + * virtual address of the direct mapping. Only real highmem pages are
> + * temporarily mapped.
> + *
> + * While it is significantly faster than kmap() for the higmem case it
> + * comes with restrictions about the pointer validity. Only use when really
> + * necessary.
> + *
> + * On HIGHMEM enabled systems mapping a highmem page has the side effect of
> + * disabling migration in order to keep the virtual address stable across
> + * preemption. No caller of kmap_local_folio() can rely on this side effect.
> + */
> +static inline void *kmap_local_folio(struct folio *folio, size_t offset);
> +
>  /**
>   * kmap_atomic - Atomically map a page for temporary usage - Deprecated!
>   * @page:	Pointer to the page to be mapped
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
