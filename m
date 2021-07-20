Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42DD3D05EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 01:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhGTXQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 19:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232506AbhGTXQD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 19:16:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30C5F60E0B;
        Tue, 20 Jul 2021 23:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626825397;
        bh=U92xkqIE4CqVD0WnacDiiqqfgQ5IF7soPJdMTmHHWyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gau+Iq9v5cwTf6g+Acr0QEw2rRO3wFs4avw8kumdIop0WSoNRnCcTYwA6eXU6uZ6x
         2LZ629n7hxJraRk06k7UUh02u1/u1i8uZ7+bz/XWU5eSYQuYMBjHweKNiwBJXr5zFz
         5eGANnry+27sndh7+srlD//e5jjWbw6syZjyuU3QOgTd089Ssf2AAHBfaBYVNzQ+il
         cv6BlWOFEjKxSYvXFBeLV9J7uDvj7bCtC3uiJUR5h8MNBR4HeImux7samm2zCLu5sY
         MLbrvtF7PiwJ9BzUBHu5ixiAyPzTD9SUb7U8SUJPgpoqFW+84zaNJVtONX51ezcq+S
         MX2ty9fqV+BnA==
Date:   Tue, 20 Jul 2021 16:56:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 06/17] iomap: Convert iomap_releasepage to use a folio
Message-ID: <20210720235636.GA3033223@magnolia>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-7-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:50PM +0100, Matthew Wilcox (Oracle) wrote:
> This is an address_space operation, so its argument must remain as a
> struct page, but we can use a folio internally.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

<rant>
/me curses at vger and fsdevel for not delivering this; if I have to
scrape lore to have reliable email, why don't we just use a webpage for
this? <grumble>
</rant>

The patch itself looks good though.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 83eb5fdcbe05..715b25a1c1e6 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -460,15 +460,15 @@ iomap_releasepage(struct page *page, gfp_t gfp_mask)
>  {
>  	struct folio *folio = page_folio(page);
>  
> -	trace_iomap_releasepage(page->mapping->host, page_offset(page),
> -			PAGE_SIZE);
> +	trace_iomap_releasepage(folio->mapping->host, folio_pos(folio),
> +			folio_size(folio));
>  
>  	/*
>  	 * mm accommodates an old ext3 case where clean pages might not have had
>  	 * the dirty bit cleared. Thus, it can send actual dirty pages to
>  	 * ->releasepage() via shrink_active_list(), skip those here.
>  	 */
> -	if (PageDirty(page) || PageWriteback(page))
> +	if (folio_test_dirty(folio) || folio_test_writeback(folio))
>  		return 0;
>  	iomap_page_release(folio);
>  	return 1;
> -- 
> 2.30.2
> 
