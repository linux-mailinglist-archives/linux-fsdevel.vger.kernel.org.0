Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95F233A116
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 21:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhCMUhd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 15:37:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234535AbhCMUhR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 15:37:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8BB664ECD;
        Sat, 13 Mar 2021 20:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615667836;
        bh=a+bgrH0JujcMhS3lCPeeuyib36jjyyn038EZGI2s/IM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C1W0+23kv6UgGDUQ1g2wVzwyPM5CpFtnBx7E7McqCO3FFHqn4PAVL0En16axkIBKL
         KauS+uwBBgVJQN+TtTQLqjkGE711ieFcpHCShJJkvAgSAGcWiILSnQbXuMfVWwcyUJ
         ABzaE96msq+1OaGpH4JjpHn4UsTbR8G7iieio75k=
Date:   Sat, 13 Mar 2021 12:37:16 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 09/25] mm: Add folio_index, folio_page and
 folio_contains
Message-Id: <20210313123716.a4f9403e9f6ebbd719dac2a8@linux-foundation.org>
In-Reply-To: <20210305041901.2396498-10-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
        <20210305041901.2396498-10-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri,  5 Mar 2021 04:18:45 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> folio_index() is the equivalent of page_index() for folios.  folio_page()
> finds the page in a folio for a page cache index.  folio_contains()
> tells you whether a folio contains a particular page cache index.
> 

copy-paste changelog into each function's covering comment?

> ---
>  include/linux/pagemap.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index f07c03da83f6..5094b50f7680 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -447,6 +447,29 @@ static inline bool thp_contains(struct page *head, pgoff_t index)
>  	return page_index(head) == (index & ~(thp_nr_pages(head) - 1UL));
>  }
>  
> +static inline pgoff_t folio_index(struct folio *folio)
> +{
> +        if (unlikely(FolioSwapCache(folio)))
> +                return __page_file_index(&folio->page);
> +        return folio->page.index;
> +}
> +
> +static inline struct page *folio_page(struct folio *folio, pgoff_t index)
> +{
> +	index -= folio_index(folio);
> +	VM_BUG_ON_FOLIO(index >= folio_nr_pages(folio), folio);
> +	return &folio->page + index;
> +}

One would expect folio_page() to be the reverse of page_folio(), only
it isn't anything like that.

> +/* Does this folio contain this index? */
> +static inline bool folio_contains(struct folio *folio, pgoff_t index)
> +{
> +	/* HugeTLBfs indexes the page cache in units of hpage_size */
> +	if (PageHuge(&folio->page))
> +		return folio->page.index == index;
> +	return index - folio_index(folio) < folio_nr_pages(folio);
> +}
> +
>  /*
>   * Given the page we found in the page cache, return the page corresponding
>   * to this index in the file

