Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EC73CAEC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 23:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhGOVyk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 17:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229776AbhGOVyj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:54:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED588613D4;
        Thu, 15 Jul 2021 21:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626385906;
        bh=6Oj1YIskroeIo98doAzAyq0ZaBG4ZNuSkw6bLyFZkuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K7//o4Kf3ebr4owF1Nuu5WrcpljB7Mk/gtKqc6RYzhIggMkoNhgGM90HMtaeb73It
         KYwLev45eDH5guJs20tuO61bt1ir27w3N6Hid9Pv8IjHnbqTftfn5s0HvI5c4LKTpr
         fRjto+/OAJoi0bza+NGyTmqK5nwCuiiQx7xYGkKl8+pTsWWAwNAqAbeaJDtrCVT+II
         MaEWXeKG9BW2Fs3PtZPXp1J3ATnh7qzML8lbX7zyHj1FA7pjivTewO4aVpZwBN/gGN
         3/n82iP9d5eBu0eYPzkJhZTBYW28YcFqdn33DdLk1TLIh30Q4L06GbXcPgYinm8jOV
         DCkoaQ+9BTiaA==
Date:   Thu, 15 Jul 2021 14:51:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 103/138] iomap: Convert iomap_read_inline_data to
 take a folio
Message-ID: <20210715215145.GN22357@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-104-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-104-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:36:29AM +0100, Matthew Wilcox (Oracle) wrote:
> Inline data is restricted to being less than a page in size, so we

$deity I hope so.

> don't need to handle multi-page folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 5e0aa23d4693..c616ef1feb21 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -194,24 +194,24 @@ struct iomap_readpage_ctx {
>  	struct readahead_control *rac;
>  };
>  
> -static void
> -iomap_read_inline_data(struct inode *inode, struct page *page,
> +static void iomap_read_inline_data(struct inode *inode, struct folio *folio,
>  		struct iomap *iomap)
>  {
>  	size_t size = i_size_read(inode);
>  	void *addr;
>  
> -	if (PageUptodate(page))
> +	if (folio_test_uptodate(folio))
>  		return;
>  
> -	BUG_ON(page->index);
> +	BUG_ON(folio->index);
> +	BUG_ON(folio_multi(folio));
>  	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
>  
> -	addr = kmap_atomic(page);
> +	addr = kmap_local_folio(folio, 0);
>  	memcpy(addr, iomap->inline_data, size);
>  	memset(addr + size, 0, PAGE_SIZE - size);
> -	kunmap_atomic(addr);
> -	SetPageUptodate(page);
> +	kunmap_local(addr);
> +	folio_mark_uptodate(folio);
>  }
>  
>  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> @@ -236,7 +236,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  
>  	if (iomap->type == IOMAP_INLINE) {
>  		WARN_ON_ONCE(pos);
> -		iomap_read_inline_data(inode, &folio->page, iomap);
> +		iomap_read_inline_data(inode, folio, iomap);
>  		return PAGE_SIZE;
>  	}
>  
> @@ -614,7 +614,7 @@ static int iomap_write_begin(struct inode *inode, loff_t pos, size_t len,
>  
>  	page = folio_file_page(folio, pos >> PAGE_SHIFT);
>  	if (srcmap->type == IOMAP_INLINE)
> -		iomap_read_inline_data(inode, page, srcmap);
> +		iomap_read_inline_data(inode, folio, srcmap);
>  	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
>  		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
>  	else
> -- 
> 2.30.2
> 
