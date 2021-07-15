Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A493CAEF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 00:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhGOWNM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 18:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230314AbhGOWNM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:13:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B54936127C;
        Thu, 15 Jul 2021 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626387018;
        bh=DL1+EY8Up3dbdkcsy7P1QWytHaaB0X9T2s1KQsnZABU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MRSlL9xMC+YUaOuXc+MFpLlCQTPT/W/DMMt98Zqvu7y9MI4TDFZvfGq321ZcrocJV
         qh1BxpLNgf7uFTAMB15z/Vtp8RCTcSnTXezamauzrfK6H8bRfl/o/GpzzyvN0hIGpH
         GZfruex10UPUy3ceQNhJOT3nhLgLXCyJOrUxnJMCqQ0K20DF/rB5JLLdYg8EIe/slY
         +qO5+27L84doDqhXxgz5TJwpy0jT1ijUlZBqGgBj8roqtJSroTIUsyXKKz9V4uf6Dp
         XPyhnQndHvgm1jcmiuE9Rozby6zEh/Rrf8CrzSHE8ItjFG07W0eus70zBQTj83wUpt
         j2XXFkcDdTasQ==
Date:   Thu, 15 Jul 2021 15:10:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 128/138] iomap: Support multi-page folios in
 invalidatepage
Message-ID: <20210715221018.GT22357@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-129-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-129-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:36:54AM +0100, Matthew Wilcox (Oracle) wrote:
> If we're punching a hole in a multi-page folio, we need to remove the
> per-page iomap data as the folio is about to be split and each page will
> need its own.  This means that writepage can now come across a page with
> no iop allocated, so remove the assertion that there is already one,
> and just create one (with the uptodate bits set) if there isn't one.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Lol, Andreas already did the bottom half of the change for you.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 48de198c5603..7f78256fc0ba 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -474,13 +474,17 @@ iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
>  	trace_iomap_invalidatepage(folio->mapping->host, offset, len);
>  
>  	/*
> -	 * If we are invalidating the entire page, clear the dirty state from it
> -	 * and release it to avoid unnecessary buildup of the LRU.
> +	 * If we are invalidating the entire folio, clear the dirty state
> +	 * from it and release it to avoid unnecessary buildup of the LRU.
>  	 */
>  	if (offset == 0 && len == folio_size(folio)) {
>  		WARN_ON_ONCE(folio_test_writeback(folio));
>  		folio_cancel_dirty(folio);
>  		iomap_page_release(folio);
> +	} else if (folio_multi(folio)) {
> +		/* Must release the iop so the page can be split */
> +		WARN_ON_ONCE(!folio_test_uptodate(folio) && folio_test_dirty(folio));
> +		iomap_page_release(folio);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(iomap_invalidatepage);
> @@ -1300,7 +1304,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct inode *inode,
>  		struct folio *folio, loff_t end_pos)
>  {
> -	struct iomap_page *iop = to_iomap_page(folio);
> +	struct iomap_page *iop = iomap_page_create(inode, folio);
>  	struct iomap_ioend *ioend, *next;
>  	unsigned len = i_blocksize(inode);
>  	unsigned nblocks = i_blocks_per_folio(inode, folio);
> @@ -1308,7 +1312,6 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	int error = 0, count = 0, i;
>  	LIST_HEAD(submit_list);
>  
> -	WARN_ON_ONCE(nblocks > 1 && !iop);
>  	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
>  
>  	/*
> -- 
> 2.30.2
> 
