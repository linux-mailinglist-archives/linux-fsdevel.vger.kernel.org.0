Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE57380909
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 13:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhENL6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 07:58:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:44578 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232930AbhENL56 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 07:57:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BBA08AEA6;
        Fri, 14 May 2021 11:56:46 +0000 (UTC)
Subject: Re: [PATCH v10 07/33] mm: Add folio_get
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-8-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <88a265ab-9ecd-18b7-c150-517a5c2e5041@suse.cz>
Date:   Fri, 14 May 2021 13:56:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-8-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Nitpick: function names in subject should IMHO also end with (). But not a
reason for resend all patches that don't...

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> If we know we have a folio, we can call folio_get() instead
> of get_page() and save the overhead of calling compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/mm.h | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 610948f0cb43..feb4645ef4f2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1219,18 +1219,26 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
>  }
>  
>  /* 127: arbitrary random number, small enough to assemble well */
> -#define page_ref_zero_or_close_to_overflow(page) \
> -	((unsigned int) page_ref_count(page) + 127u <= 127u)
> +#define folio_ref_zero_or_close_to_overflow(folio) \
> +	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
> +
> +/**
> + * folio_get - Increment the reference count on a folio.
> + * @folio: The folio.
> + *
> + * Context: May be called in any context, as long as you know that
> + * you have a refcount on the folio.  If you do not already have one,
> + * folio_try_get() may be the right interface for you to use.
> + */
> +static inline void folio_get(struct folio *folio)
> +{
> +	VM_BUG_ON_FOLIO(folio_ref_zero_or_close_to_overflow(folio), folio);
> +	folio_ref_inc(folio);
> +}
>  
>  static inline void get_page(struct page *page)
>  {
> -	page = compound_head(page);
> -	/*
> -	 * Getting a normal page or the head of a compound page
> -	 * requires to already have an elevated page->_refcount.
> -	 */
> -	VM_BUG_ON_PAGE(page_ref_zero_or_close_to_overflow(page), page);
> -	page_ref_inc(page);
> +	folio_get(page_folio(page));
>  }
>  
>  bool __must_check try_grab_page(struct page *page, unsigned int flags);
> 

