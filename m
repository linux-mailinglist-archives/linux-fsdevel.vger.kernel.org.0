Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7EA3CAED0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 23:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhGOV6G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 17:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229776AbhGOV6F (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:58:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A836260240;
        Thu, 15 Jul 2021 21:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626386111;
        bh=IZhXG0pFZmYaSBld/7CAwZc8B7u7L40FuYffUY/p3/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W3DFgeuTWh5VVOoNJ0gbXPTbjBbFT/EgbckCbMmG8A+gngFuTlO0l2+0gBjrmOs77
         q5nBihgxs2PiXv2qpSoCEg+GtXnsXMUtzyp7sRBrgm/MGceXZ5P0ova+s5NY+SOrXd
         herhQ/ELYwITCcyT7XTabXrmTQIpYULgs3KXhumjLFjJPIkzwr94t/rxleAEshmt/R
         749cFi2H7R4ku2B5KGpUzhtRpy0rGSA5aRQIfbqCoBs95X0MPtrZ5bIVCxs50uJM+0
         kBJ+K5ZMF1QNRA0zMjKMPf6uTPlDb1QBa+xetSgUrhMdhov9AjBIJKubIUyVFCdR8x
         NCp0l/GTTpiSw==
Date:   Thu, 15 Jul 2021 14:55:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 104/138] iomap: Convert iomap_write_end_inline to
 take a folio
Message-ID: <20210715215511.GO22357@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-105-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-105-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:36:30AM +0100, Matthew Wilcox (Oracle) wrote:
> Inline data only occupies a single page, but using a folio means that
> we don't need to call compound_head() in PageUptodate().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

/me isn't the expert on inlinedata, but this looks reasonable to me...

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index c616ef1feb21..ac33f19325ab 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -662,18 +662,18 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  	return copied;
>  }
>  
> -static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
> +static size_t iomap_write_end_inline(struct inode *inode, struct folio *folio,
>  		struct iomap *iomap, loff_t pos, size_t copied)
>  {
>  	void *addr;
>  
> -	WARN_ON_ONCE(!PageUptodate(page));
> +	WARN_ON_ONCE(!folio_test_uptodate(folio));
>  	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
>  
> -	flush_dcache_page(page);
> -	addr = kmap_atomic(page);
> +	flush_dcache_folio(folio);
> +	addr = kmap_local_folio(folio, 0);
>  	memcpy(iomap->inline_data + pos, addr + pos, copied);
> -	kunmap_atomic(addr);
> +	kunmap_local(addr);
>  
>  	mark_inode_dirty(inode);
>  	return copied;
> @@ -690,7 +690,7 @@ static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  	size_t ret;
>  
>  	if (srcmap->type == IOMAP_INLINE) {
> -		ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
> +		ret = iomap_write_end_inline(inode, folio, iomap, pos, copied);
>  	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
>  		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
>  				page, NULL);
> -- 
> 2.30.2
> 
