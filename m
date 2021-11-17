Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709C1453E64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 03:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhKQCXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 21:23:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhKQCXn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 21:23:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7ACB361A02;
        Wed, 17 Nov 2021 02:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637115645;
        bh=iDWosObnHm99i06fmmb/ibxReLZuqcaTJgnFQrMovjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQsgwu9bKobTRau2zYYHf2QuET4megCLNghaVvKhsR1XO57RRlK8hgRlaf4Wjw+Wg
         WcC6YTeiUXrq64iW2J0QZgAx3ERmSkP0H6Kp2ee3VryzZWTEmNAoKOp2zfOTgY1pZz
         6DKG/KETf3imixg4+WTwCNXYDPy21lL2RRRSspGZRz2gJ5HSUu0+X6g9PU1EElsjbq
         JcRzq6B8Vvg/0r6jJY7lTdC93kd+Bcfi5b68Pzu3MLYa3SKTh8jblaNxOqe6T06dGB
         eqy0mpnI/xUcOW+ftqfHUxOmkqTuj+UpGYPKE+RVvCRc1IvcGH2SHVUBFgnkKmTK8V
         GxYeZvPJawdbQ==
Date:   Tue, 16 Nov 2021 18:20:45 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 12/28] iomap: Add iomap_invalidate_folio
Message-ID: <20211117022045.GI24307@magnolia>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108040551.1942823-13-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 04:05:35AM +0000, Matthew Wilcox (Oracle) wrote:
> Keep iomap_invalidatepage around as a wrapper for use in address_space
> operations.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 20 ++++++++++++--------
>  include/linux/iomap.h  |  1 +
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 49f96fdadcb4..b7cbe4d202d8 100644
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
> index 6d1b08d0ae93..29491fb9c5ba 100644
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
