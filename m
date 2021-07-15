Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337183CAE73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 23:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhGOVW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 17:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhGOVW4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:22:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7ADC60D07;
        Thu, 15 Jul 2021 21:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626384003;
        bh=BDfVjRBSfQ1ziLLEmDwkrceOcQwLTwt3pBExg/I/12A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O1B0UaIhlWhN8/dZZ6nJQyypDzIu4FGdq96diDOp3qrcEPKgVpmDLtmvo/2BsOrkX
         fOIsOXZVjU4NPuNBIQqs+at8wpVhGEptm52ASu4o0pabxw1p/xi34Zcy4JLSgFCFOd
         KmCcibYiEOmLJ2m8kr3iG/NUsfHMKra8zNz5RdI/RbllhJMXLgtykbUJDxSYY5TmB/
         zxYHziLtiAd9DltLaqXnNT1m+7vBv02uLC93AUXKakuPfoN4FGYAScBTjZJin2iW4e
         Uf7jzO8WC1QAaGsYI4znD6ZvcFjSA78cbO4oz0oTf0/8pOlJClhpM9GipZi2DpkA/X
         xs+BtGjb3clyg==
Date:   Thu, 15 Jul 2021 14:20:02 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 094/138] iomap: Convert iomap_page_release to take a
 folio
Message-ID: <20210715212002.GG22357@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-95-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-95-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:36:20AM +0100, Matthew Wilcox (Oracle) wrote:
> iomap_page_release() was also assuming that it was being passed a
> head page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Eh, looks pretty straightforward to me...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index c15a0ac52a32..251ec45426aa 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -59,18 +59,18 @@ iomap_page_create(struct inode *inode, struct folio *folio)
>  	return iop;
>  }
>  
> -static void
> -iomap_page_release(struct page *page)
> +static void iomap_page_release(struct folio *folio)
>  {
> -	struct iomap_page *iop = detach_page_private(page);
> -	unsigned int nr_blocks = i_blocks_per_page(page->mapping->host, page);
> +	struct iomap_page *iop = folio_detach_private(folio);
> +	unsigned int nr_blocks = i_blocks_per_folio(folio->mapping->host,
> +							folio);
>  
>  	if (!iop)
>  		return;
>  	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
>  	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
>  	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
> -			PageUptodate(page));
> +			folio_test_uptodate(folio));
>  	kfree(iop);
>  }
>  
> @@ -456,6 +456,8 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
>  int
>  iomap_releasepage(struct page *page, gfp_t gfp_mask)
>  {
> +	struct folio *folio = page_folio(page);
> +
>  	trace_iomap_releasepage(page->mapping->host, page_offset(page),
>  			PAGE_SIZE);
>  
> @@ -466,7 +468,7 @@ iomap_releasepage(struct page *page, gfp_t gfp_mask)
>  	 */
>  	if (PageDirty(page) || PageWriteback(page))
>  		return 0;
> -	iomap_page_release(page);
> +	iomap_page_release(folio);
>  	return 1;
>  }
>  EXPORT_SYMBOL_GPL(iomap_releasepage);
> @@ -474,6 +476,8 @@ EXPORT_SYMBOL_GPL(iomap_releasepage);
>  void
>  iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
>  {
> +	struct folio *folio = page_folio(page);
> +
>  	trace_iomap_invalidatepage(page->mapping->host, offset, len);
>  
>  	/*
> @@ -483,7 +487,7 @@ iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
>  	if (offset == 0 && len == PAGE_SIZE) {
>  		WARN_ON_ONCE(PageWriteback(page));
>  		cancel_dirty_page(page);
> -		iomap_page_release(page);
> +		iomap_page_release(folio);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(iomap_invalidatepage);
> -- 
> 2.30.2
> 
