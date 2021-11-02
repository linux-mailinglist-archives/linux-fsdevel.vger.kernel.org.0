Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC3443887
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 23:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhKBWjR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 18:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230293AbhKBWjL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:39:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E7AB61076;
        Tue,  2 Nov 2021 22:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635892595;
        bh=XcL/yji/ofphJmOG1nSJU5SP1NHCrSvT6FBl/FyJizk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=luBl2mwKcdMB8SS422yo7JWvrSuPaOCqUbSO3kqsNO10QaA89Sse5pZZqpmekhBpm
         xQDADDKd8jjyoZguACL0bLBe+GGxDB9yRQu3fT0Yc8PIT6HjlJU7adIHiUoRoc3MRo
         hDV08CejoshXzL6dpuesv+SudS+bvBuvTkatOn4jWDMcV5/oI1XuDaB3RYUa8nl3rI
         Cwm5k9+PDZ1KlUKKHgZhCp1WmhXIhnGIHKnR3hSUFWSM0Ij9rjynnpy66upSXUBS39
         v05gDVaKfPzowtYo6lgQDGuasiv1WFsGCCGp/qcxO6JofzGhC2sc+AqhuFtv8CVMgu
         lNYJwByLoKn0A==
Date:   Tue, 2 Nov 2021 15:36:35 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 08/21] iomap: Add iomap_invalidate_folio
Message-ID: <20211102223635.GJ24307@magnolia>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-9-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:39:16PM +0000, Matthew Wilcox (Oracle) wrote:
> Keep iomap_invalidatepage around as a wrapper for use in address_space
> operations.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 20 ++++++++++++--------
>  include/linux/iomap.h  |  1 +
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a6b64a1ad468..e9a60520e769 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -468,23 +468,27 @@ iomap_releasepage(struct page *page, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL_GPL(iomap_releasepage);
>  
> -void
> -iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
> +void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
>  {
> -	struct folio *folio = page_folio(page);
> -
> -	trace_iomap_invalidatepage(page->mapping->host, offset, len);
> +	trace_iomap_invalidatepage(folio->mapping->host, offset, len);
>  
>  	/*
>  	 * If we're invalidating the entire page, clear the dirty state from it
>  	 * and release it to avoid unnecessary buildup of the LRU.
>  	 */
> -	if (offset == 0 && len == PAGE_SIZE) {
> -		WARN_ON_ONCE(PageWriteback(page));
> -		cancel_dirty_page(page);
> +	if (offset == 0 && len == folio_size(folio)) {
> +		WARN_ON_ONCE(folio_test_writeback(folio));
> +		folio_cancel_dirty(folio);
>  		iomap_page_release(folio);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
> +
> +void iomap_invalidatepage(struct page *page, unsigned int offset,
> +		unsigned int len)
> +{
> +	iomap_invalidate_folio(page_folio(page), offset, len);
> +}
>  EXPORT_SYMBOL_GPL(iomap_invalidatepage);
>  
>  #ifdef CONFIG_MIGRATION
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 63f4ea4dac9b..91de58ca09fc 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -225,6 +225,7 @@ void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
>  int iomap_is_partially_uptodate(struct page *page, unsigned long from,
>  		unsigned long count);
>  int iomap_releasepage(struct page *page, gfp_t gfp_mask);
> +void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
>  void iomap_invalidatepage(struct page *page, unsigned int offset,
>  		unsigned int len);
>  #ifdef CONFIG_MIGRATION
> -- 
> 2.33.0
> 
