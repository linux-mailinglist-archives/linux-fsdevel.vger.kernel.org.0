Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9433CBD9F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 10:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436849AbfIYIg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 04:36:56 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:53890 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404845AbfIYIg4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:36:56 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6DA7A36382D;
        Wed, 25 Sep 2019 18:36:51 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iD2n4-0001BZ-Nt; Wed, 25 Sep 2019 18:36:50 +1000
Date:   Wed, 25 Sep 2019 18:36:50 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/15] fs: Introduce i_blocks_per_page
Message-ID: <20190925083650.GE804@dread.disaster.area>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925005214.27240-3-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
        a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=cFTJNmiEAYDDdQa2eyoA:9
        a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:52:01PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This helper is useful for both large pages in the page cache and for
> supporting block size larger than page size.  Convert some example
> users (we have a few different ways of writing this idiom).
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I'm actually working on abstrcting this code from both block size
and page size via the helpers below. We ahve need to support block
size > page size, and so that requires touching a bunch of all the
same code as this patchset. I'm currently trying to combine your
last patch set with my patchset so I can easily test allocating 64k
page cache pages on a 64k block size filesystem on a 4k page size
machine with XFS....

/*
 * Return the chunk size we should use for page cache based operations.
 * This supports both large block sizes and variable page sizes based on the
 * restriction that order-n blocks and page cache pages are order-n file offset
 * aligned.
 *
 * This will return the inode block size for block size < page_size(page),
 * otherwise it will return page_size(page).
 */
static inline unsigned
iomap_chunk_size(struct inode *inode, struct page *page)
{
        return min_t(unsigned, page_size(page), i_blocksize(inode));
}

static inline unsigned
iomap_chunk_bits(struct inode *inode, struct page *page)
{
        return min_t(unsigned, page_shift(page), inode->i_blkbits);
}

static inline unsigned
iomap_chunks_per_page(struct inode *inode, struct page *page)
{
        return page_size(page) >> inode->i_blkbits;
}

Basically, the process is to convert the iomap code over to
iterating "chunks" rather than blocks or pages, and then allocate
a struct iomap_page according to the difference between page and
block size....

> ---
>  fs/iomap/buffered-io.c  |  4 ++--
>  fs/jfs/jfs_metapage.c   |  2 +-
>  fs/xfs/xfs_aops.c       |  8 ++++----
>  include/linux/pagemap.h | 13 +++++++++++++
>  4 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e25901ae3ff4..0e76a4b6d98a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -24,7 +24,7 @@ iomap_page_create(struct inode *inode, struct page *page)
>  {
>  	struct iomap_page *iop = to_iomap_page(page);
>  
> -	if (iop || i_blocksize(inode) == PAGE_SIZE)
> +	if (iop || i_blocks_per_page(inode, page) <= 1)
>  		return iop;

That also means checks like these become:

	if (iop || iomap_chunks_per_page(inode, page) <= 1)

as a single file can now have multiple pages per block, a page per
block and multiple blocks per page as the page size changes...

I'd like to only have to make one pass over this code to abstract
out page and block sizes, so I'm guessing we'll need to do some
co-ordination here....

> @@ -636,4 +636,17 @@ static inline unsigned long dir_pages(struct inode *inode)
>  			       PAGE_SHIFT;
>  }
>  
> +/**
> + * i_blocks_per_page - How many blocks fit in this page.
> + * @inode: The inode which contains the blocks.
> + * @page: The (potentially large) page.
> + *
> + * Context: Any context.
> + * Return: The number of filesystem blocks covered by this page.
> + */
> +static inline
> +unsigned int i_blocks_per_page(struct inode *inode, struct page *page)
> +{
> +	return page_size(page) >> inode->i_blkbits;
> +}
>  #endif /* _LINUX_PAGEMAP_H */

It also means that we largely don't need to touch mm headers as
all the helpers end up being iomap specific and private...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
