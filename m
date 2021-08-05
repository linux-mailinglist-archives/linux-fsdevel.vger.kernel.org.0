Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AD83E1A68
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 19:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239708AbhHERbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 13:31:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhHERbT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:31:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0098460F42;
        Thu,  5 Aug 2021 17:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628184665;
        bh=MoFgSn3KWSScKi/BuebgAcN0GTgylIPN8NwZe4LfwiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gt/rRgIF0YR8b8yYG8cXDUIv7FCCUeplyvwl/9lmRBOKuuw9Uo8ks5g+UQS/JIWos
         9PqN8R8mHP/E15SDN03bac3Tz3czxBa71QupTjZL54gm1QNtUc2EPu43oF4wkR3oKu
         q+8WgXSCLMAxTY2UFBFQTr3Rq8wI2QvOGSFNqIOQ5ACKdU9uH0ziPNC0L/66Xl02dx
         eydwuMV1XvVGCCS9PgXp+MhgC2NkVuwgs5Gfnzt8J53OLEN8w4wEUZBVf0gbHn43vJ
         ArCx/7ZhuVg+0yRAve7VRU2zdAUlXO25qYrkXHHw0D8VjMYoaPpkx2MjPxp325liXg
         4gXpPXsyXLXCA==
Date:   Thu, 5 Aug 2021 10:31:04 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: Use kmap_local_page instead of kmap_atomic
Message-ID: <20210805173104.GF3601405@magnolia>
References: <20210803193134.1198733-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803193134.1198733-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 03, 2021 at 08:31:33PM +0100, Matthew Wilcox (Oracle) wrote:
> kmap_atomic() has the side-effect of disabling pagefaults and
> preemption.  kmap_local_page() does not do this and is preferred.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Pretty straightforward.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index c1c8cd41ea81..8ee0211bea86 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -223,10 +223,10 @@ static int iomap_read_inline_data(struct inode *inode, struct page *page,
>  	if (poff > 0)
>  		iomap_page_create(inode, page);
>  
> -	addr = kmap_atomic(page) + poff;
> +	addr = kmap_local_page(page) + poff;
>  	memcpy(addr, iomap->inline_data, size);
>  	memset(addr + size, 0, PAGE_SIZE - poff - size);
> -	kunmap_atomic(addr);
> +	kunmap_local(addr);
>  	iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
>  	return PAGE_SIZE - poff;
>  }
> @@ -682,9 +682,9 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
>  	BUG_ON(!iomap_inline_data_valid(iomap));
>  
>  	flush_dcache_page(page);
> -	addr = kmap_atomic(page);
> -	memcpy(iomap_inline_data(iomap, pos), addr + pos, copied);
> -	kunmap_atomic(addr);
> +	addr = kmap_local_page(page) + pos;
> +	memcpy(iomap_inline_data(iomap, pos), addr, copied);
> +	kunmap_local(addr);
>  
>  	mark_inode_dirty(inode);
>  	return copied;
> -- 
> 2.30.2
> 
