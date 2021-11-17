Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406AC454BB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 18:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhKQRP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 12:15:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhKQRPY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:15:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F06CA61A62;
        Wed, 17 Nov 2021 17:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637169146;
        bh=spPfOkCEhGj2bIxfvVoXY7amamtmAaSgjL0UdzceFeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLgU0odos/f98nsG/Uf2rvd0fqaPD8bwkHvCD36XoGJQ2DfUuSNqrcLx3QO9izUxd
         PdLUFBPJ+wPgqa8OFoE7SvAUmTDk4m/cykTTHPrSzhnECaaPtprET+4AI/j1oBBt1z
         SovL2NlmS6EQggQJMr7deIFYrBVjW5ldWsctsmzcQHmn8oC7rNAyH683K7YkAEWCZj
         zjg5m9GLdFh+efkrKtc4PYhF2bpqOZyHlGOjTzuV0cxsxDzAiOGdBeOjHN775h08o6
         wmk38aDdFvw+nxXfaJj2+tPnZ3MUo/ekwab3AyB97aZS36003w/3KqT3WEOPb8yKpN
         uI8wOzF+JwDBg==
Date:   Wed, 17 Nov 2021 09:12:25 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH] iomap: iomap_read_inline_data cleanup
Message-ID: <20211117171225.GY24307@magnolia>
References: <20211117103202.44346-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117103202.44346-1-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 11:32:02AM +0100, Andreas Gruenbacher wrote:
> Change iomap_read_inline_data to return 0 or an error code; this
> simplifies the callers.  Add a description.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks good, thank you for cleaning this up for me!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index fe10d8a30f6b..f1bc9a35184d 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -205,7 +205,15 @@ struct iomap_readpage_ctx {
>  	struct readahead_control *rac;
>  };
>  
> -static loff_t iomap_read_inline_data(const struct iomap_iter *iter,
> +/**
> + * iomap_read_inline_data - copy inline data into the page cache
> + * @iter: iteration structure
> + * @page: page to copy to
> + *
> + * Copy the inline data in @iter into @page and zero out the rest of the page.
> + * Only a single IOMAP_INLINE extent is allowed at the end of each file.
> + */
> +static int iomap_read_inline_data(const struct iomap_iter *iter,
>  		struct page *page)
>  {
>  	const struct iomap *iomap = iomap_iter_srcmap(iter);
> @@ -214,7 +222,7 @@ static loff_t iomap_read_inline_data(const struct iomap_iter *iter,
>  	void *addr;
>  
>  	if (PageUptodate(page))
> -		return PAGE_SIZE - poff;
> +		return 0;
>  
>  	if (WARN_ON_ONCE(size > PAGE_SIZE - poff))
>  		return -EIO;
> @@ -231,7 +239,7 @@ static loff_t iomap_read_inline_data(const struct iomap_iter *iter,
>  	memset(addr + size, 0, PAGE_SIZE - poff - size);
>  	kunmap_local(addr);
>  	iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
> -	return PAGE_SIZE - poff;
> +	return 0;
>  }
>  
>  static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
> @@ -256,13 +264,8 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>  	unsigned poff, plen;
>  	sector_t sector;
>  
> -	if (iomap->type == IOMAP_INLINE) {
> -		loff_t ret = iomap_read_inline_data(iter, page);
> -
> -		if (ret < 0)
> -			return ret;
> -		return 0;
> -	}
> +	if (iomap->type == IOMAP_INLINE)
> +		return iomap_read_inline_data(iter, page);
>  
>  	/* zero post-eof blocks as the page may be mapped */
>  	iop = iomap_page_create(iter->inode, page);
> @@ -587,15 +590,10 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  static int iomap_write_begin_inline(const struct iomap_iter *iter,
>  		struct page *page)
>  {
> -	int ret;
> -
>  	/* needs more work for the tailpacking case; disable for now */
>  	if (WARN_ON_ONCE(iomap_iter_srcmap(iter)->offset != 0))
>  		return -EIO;
> -	ret = iomap_read_inline_data(iter, page);
> -	if (ret < 0)
> -		return ret;
> -	return 0;
> +	return iomap_read_inline_data(iter, page);
>  }
>  
>  static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
> -- 
> 2.31.1
> 
