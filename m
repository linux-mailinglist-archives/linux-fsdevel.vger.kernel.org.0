Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC7CE15A2CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 09:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgBLIFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 03:05:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57084 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgBLIFL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=64WRuNGSs6zRlmEHBPpsCTOuTomz3AlIGGfX1deuR68=; b=SAnOenWWDhwj/RuwTNArPd3T+w
        1bS1rq85FMcLd3OM0qUo0NNSgl8QJ2ULEb0ijNXgPcuKOTYEDXjmsFLZJ2PMzZI2kMzPDIeyfXAdj
        X2h4ExDo7vuTkZ4wzDUy+4XfZJF37p+RGyInQf/tFG/vVNsgJTr6h/cy8fUr/IdjDryTmpTUNJ5Yt
        3Picr7Yi2dJsZJ8Y2NdTXqDnvVaRy9tfXxLajslGaNJeZz0LXKlzg2SZtzx35D7hP1SLhmSU4Zwuv
        gRfIWSxS6366LebxosJbVmA5nmyxGmRfT4WoCFmkgv1exFW0NtRtM2p2vtzgy+MGkUqcEfe9wxOcY
        ajp0fHWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1n1C-0000vU-VU; Wed, 12 Feb 2020 08:05:10 +0000
Date:   Wed, 12 Feb 2020 00:05:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/25] iomap: Support arbitrarily many blocks per page
Message-ID: <20200212080510.GA24497@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-15-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:34PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Size the uptodate array dynamically.  Now that this array is protected
> by a spinlock, we can use bitmap functions to set the bits in this array
> instead of a loop around set_bit().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index c551a48e2a81..5e5a6b038fc3 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -22,14 +22,14 @@
>  #include "../internal.h"
>  
>  /*
> - * Structure allocated for each page when block size < PAGE_SIZE to track
> + * Structure allocated for each page when block size < page size to track
>   * sub-page uptodate status and I/O completions.
>   */
>  struct iomap_page {
>  	atomic_t		read_count;
>  	atomic_t		write_count;
>  	spinlock_t		uptodate_lock;
> -	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
> +	unsigned long		uptodate[];
>  };
>  
>  static inline struct iomap_page *to_iomap_page(struct page *page)
> @@ -45,15 +45,14 @@ static struct iomap_page *
>  iomap_page_create(struct inode *inode, struct page *page)
>  {
>  	struct iomap_page *iop = to_iomap_page(page);
> +	unsigned int n, nr_blocks = i_blocks_per_page(inode, page);
>  
> -	if (iop || i_blocks_per_page(inode, page) <= 1)
> +	if (iop || nr_blocks <= 1)
>  		return iop;
>  
> -	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
> -	atomic_set(&iop->read_count, 0);
> -	atomic_set(&iop->write_count, 0);
> +	n = BITS_TO_LONGS(nr_blocks);
> +	iop = kzalloc(struct_size(iop, uptodate, n), GFP_NOFS | __GFP_NOFAIL);

Nit: I don't really hink we need the n variable here, we can just
opencode the BITS_TO_LONGS in the struct_size call.

>  	struct inode *inode = page->mapping->host;
>  	unsigned first = off >> inode->i_blkbits;
> -	unsigned last = (off + len - 1) >> inode->i_blkbits;
> -	bool uptodate = true;
> +	unsigned count = len >> inode->i_blkbits;
>  	unsigned long flags;
> -	unsigned int i;
>  
>  	spin_lock_irqsave(&iop->uptodate_lock, flags);
> -	for (i = 0; i < i_blocks_per_page(inode, page); i++) {
> -		if (i >= first && i <= last)
> -			set_bit(i, iop->uptodate);
> -		else if (!test_bit(i, iop->uptodate))
> -			uptodate = false;
> -	}
> -
> -	if (uptodate)
> +	bitmap_set(iop->uptodate, first, count);
> +	if (bitmap_full(iop->uptodate, i_blocks_per_page(inode, page)))
>  		SetPageUptodate(page);

Switching to the bitmap helpers might be worthwhile prep patch that
can go in directly now that we're having the uptodate_lock.
