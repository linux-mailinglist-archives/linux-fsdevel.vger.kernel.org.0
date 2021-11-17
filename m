Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DEF453E6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 03:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhKQC1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 21:27:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229733AbhKQC1W (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 21:27:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE7CC619E5;
        Wed, 17 Nov 2021 02:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637115864;
        bh=DGQEM1Zf8auR873ZCW559ed3Fgo53vyTpyTP7XMCRNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jDAI0ts5Gz6TtiNPLF8upmSauHZtFdbT4eVdFFnLxzyzXA1werh6xNNvuCqPWH74r
         eGVCzOnYRHCaRKwI/EVvQoFpVdI9gHJZD65Pm2dHjzus6Ei3I4N26LP9f5J4A3hIWC
         AyE/qVeA2OYBujC3GrnYLMvhQ858+5o4eJxkM+U9ax4yM9ffix+i3uEElySkoip0FT
         O5Tpyd6ho1FFefsOYxwN1wtduLpPLkljfrO//ZaCWxMC+MnRR5e7SPi/0XL3l0JQPx
         3u5EplPguD/4ypepveN2gQqCyxM3sX0CwEo3e/IQPAQmjHW2SSJyX7+DtMR5YJ6V7q
         RWQhPna40kgUg==
Date:   Tue, 16 Nov 2021 18:24:24 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 19/28] iomap: Convert __iomap_zero_iter to use a folio
Message-ID: <20211117022424.GJ24307@magnolia>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-20-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108040551.1942823-20-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 04:05:42AM +0000, Matthew Wilcox (Oracle) wrote:
> The zero iterator can work in folio-sized chunks instead of page-sized
> chunks.  This will save a lot of page cache lookups if the file is cached
> in multi-page folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

hch's dax decoupling series notwithstanding,

Though TBH I am kinda wondering how the two of you plan to resolve those
kinds of differences -- I haven't looked at that series, though I think
this one's been waiting in the wings for longer?

Heck, I wonder how Matthew plans to merge all this given that it touches
mm, fs, block, and iomap...?

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 64e54981b651..9c61d12028ca 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -881,17 +881,20 @@ EXPORT_SYMBOL_GPL(iomap_file_unshare);
>  
>  static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
>  {
> +	struct folio *folio;
>  	struct page *page;
>  	int status;
> -	unsigned offset = offset_in_page(pos);
> -	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
> +	size_t offset, bytes;
>  
> -	status = iomap_write_begin(iter, pos, bytes, &page);
> +	status = iomap_write_begin(iter, pos, length, &page);
>  	if (status)
>  		return status;
> +	folio = page_folio(page);
>  
> -	zero_user(page, offset, bytes);
> -	mark_page_accessed(page);
> +	offset = offset_in_folio(folio, pos);
> +	bytes = min_t(u64, folio_size(folio) - offset, length);
> +	folio_zero_range(folio, offset, bytes);
> +	folio_mark_accessed(folio);
>  
>  	return iomap_write_end(iter, pos, bytes, bytes, page);
>  }
> -- 
> 2.33.0
> 
