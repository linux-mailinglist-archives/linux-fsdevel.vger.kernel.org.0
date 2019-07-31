Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892967D1AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 01:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbfGaXE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 19:04:28 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:34735 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726417AbfGaXE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:04:28 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 13A8743EC11;
        Thu,  1 Aug 2019 09:04:23 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hsxcp-0002Sw-2y; Thu, 01 Aug 2019 09:03:15 +1000
Date:   Thu, 1 Aug 2019 09:03:15 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] iomap: Support large pages
Message-ID: <20190731230315.GJ7777@dread.disaster.area>
References: <20190731171734.21601-1-willy@infradead.org>
 <20190731171734.21601-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731171734.21601-2-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=WQvca8WHDlrIu5qLAPkA:9
        a=zqzhHmcM8JVGume9:21 a=xL7_rN_kTCjolvjS:21 a=CjuIK1q_8ugA:10
        a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 10:17:33AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Change iomap_page from a statically sized uptodate bitmap to a
> dynamically allocated uptodate bitmap, allowing an arbitrarily large page.
> 
> Calculate the size of the page everywhere instead of using a base
> PAGE_SIZE.
> 
> Based on a patch from Christoph Hellwig.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 82 ++++++++++++++++++++++++++----------------
>  include/linux/iomap.h  |  2 +-
>  2 files changed, 53 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e25901ae3ff4..4d56b8060b6c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -23,14 +23,17 @@ static struct iomap_page *
>  iomap_page_create(struct inode *inode, struct page *page)
>  {
>  	struct iomap_page *iop = to_iomap_page(page);
> +	unsigned int nbits;
>  
> -	if (iop || i_blocksize(inode) == PAGE_SIZE)
> +	if (iop || i_blocksize(inode) == page_size(page))
>  		return iop;
>  
> -	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
> +	nbits = BITS_TO_LONGS(page_size(page) / SECTOR_SIZE);

nbits = BITS_TO_LONGS(page_size(page) / i_blocksize(inode));

> +	iop = kmalloc(struct_size(iop, uptodate, nbits),
> +			GFP_NOFS | __GFP_NOFAIL);
>  	atomic_set(&iop->read_count, 0);
>  	atomic_set(&iop->write_count, 0);
> -	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
> +	bitmap_zero(iop->uptodate, nbits);
>  
>  	/*
>  	 * migrate_page_move_mapping() assumes that pages with private data have
> @@ -61,15 +64,16 @@ iomap_page_release(struct page *page)
>   * Calculate the range inside the page that we actually need to read.
>   */
>  static void
> -iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
> +iomap_adjust_read_range(struct inode *inode, struct page *page,
>  		loff_t *pos, loff_t length, unsigned *offp, unsigned *lenp)
>  {
> +	struct iomap_page *iop = to_iomap_page(page);
>  	loff_t orig_pos = *pos;
>  	loff_t isize = i_size_read(inode);
>  	unsigned block_bits = inode->i_blkbits;
>  	unsigned block_size = (1 << block_bits);
> -	unsigned poff = offset_in_page(*pos);
> -	unsigned plen = min_t(loff_t, PAGE_SIZE - poff, length);
> +	unsigned poff = *pos & (page_size(page) - 1);
> +	unsigned plen = min_t(loff_t, page_size(page) - poff, length);
>  	unsigned first = poff >> block_bits;
>  	unsigned last = (poff + plen - 1) >> block_bits;

This all kinda looks familar. In my block size > page size patch
set, I was trying to wrap these sorts of things in helpers as they
ge repeated over and over again. e.g:

/*
 * Return the block size we should use for page cache based operations.
 * This will return the inode block size for block size < PAGE_SIZE,
 * otherwise it will return PAGE_SIZE.
 */
static inline unsigned
iomap_chunk_size(struct inode *inode)
{
	return min_t(unsigned, PAGE_SIZE, i_blocksize(inode));
}

"chunk" being the name that Christoph suggested as the size of the
region we need to operate over in this function.

IOws, if we have a normal page, it's as per the above, but if
we have block size > PAGE_SIZE, it's the block size we need to work
from, and if it's a huge page, is the huge page size we need to
use....

So starting by wrapping a bunch of these common length/size/offset
calculations will make this code much easier to understand, follow,
maintain as we explode the number of combinations of page and block
size it supports in the near future...

FYI, the blocksize > pagesize patchset was first posted here:

https://lore.kernel.org/linux-fsdevel/20181107063127.3902-1-david@fromorbit.com/

[ Bad memories, this patchset is what lead us to discover how 
horribly broken copy_file_range and friends were. ]

> @@ -107,7 +111,8 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
>  	 * page cache for blocks that are entirely outside of i_size.
>  	 */
>  	if (orig_pos <= isize && orig_pos + length > isize) {
> -		unsigned end = offset_in_page(isize - 1) >> block_bits;
> +		unsigned end = (isize - 1) & (page_size(page) - 1) >>
> +				block_bits;

iomap_offset_in_page()....

>  
>  		if (first <= end && last > end)
>  			plen -= (last - end) * block_size;
> @@ -128,7 +133,7 @@ iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>  	bool uptodate = true;
>  
>  	if (iop) {
> -		for (i = 0; i < PAGE_SIZE / i_blocksize(inode); i++) {
> +		for (i = 0; i < page_size(page) / i_blocksize(inode); i++) {

                                iomap_blocks_per_page()

>  			if (i >= first && i <= last)
>  				set_bit(i, iop->uptodate);
>  			else if (!test_bit(i, iop->uptodate))
> @@ -194,11 +199,12 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
>  		return;
>  
>  	BUG_ON(page->index);
> -	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +	BUG_ON(size > page_size(page) - ((unsigned long)iomap->inline_data &
> +						(page_size(page) - 1)));

Inline data should never use a huge page - it's a total waste of
2MB of memory because inline data is intended for very small data
files that fit inside an inode. If anyone ever needs inline data
larger than PAGE_SIZE then we can worry about how to support that
at that time. Right now it should just refuse to use a huge page...

>  
>  	addr = kmap_atomic(page);
>  	memcpy(addr, iomap->inline_data, size);
> -	memset(addr + size, 0, PAGE_SIZE - size);
> +	memset(addr + size, 0, page_size(page) - size);
>  	kunmap_atomic(addr);
>  	SetPageUptodate(page);
>  }
> @@ -218,11 +224,11 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	if (iomap->type == IOMAP_INLINE) {
>  		WARN_ON_ONCE(pos);
>  		iomap_read_inline_data(inode, page, iomap);
> -		return PAGE_SIZE;
> +		return page_size(page);
>  	}
>  
>  	/* zero post-eof blocks as the page may be mapped */
> -	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
> +	iomap_adjust_read_range(inode, page, &pos, length, &poff, &plen);
>  	if (plen == 0)
>  		goto done;
>  
> @@ -258,7 +264,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  
>  	if (!ctx->bio || !is_contig || bio_full(ctx->bio, plen)) {
>  		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
> -		int nr_vecs = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +		int nr_vecs = (length + page_size(page) - 1) >> page_shift(page);

iomap_nr_pages(page)?

>  
>  		if (ctx->bio)
>  			submit_bio(ctx->bio);
> @@ -293,9 +299,9 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
>  	unsigned poff;
>  	loff_t ret;
>  
> -	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
> +	for (poff = 0; poff < page_size(page); poff += ret) {
>  		ret = iomap_apply(inode, page_offset(page) + poff,
> -				PAGE_SIZE - poff, 0, ops, &ctx,
> +				page_size(page) - poff, 0, ops, &ctx,
>  				iomap_readpage_actor);
>  		if (ret <= 0) {
>  			WARN_ON_ONCE(ret == 0);
> @@ -342,7 +348,7 @@ iomap_next_page(struct inode *inode, struct list_head *pages, loff_t pos,
>  		 * readpages call itself as every page gets checked again once
>  		 * actually needed.
>  		 */
> -		*done += PAGE_SIZE;
> +		*done += page_size(page);
>  		put_page(page);
>  	}
>  
> @@ -355,9 +361,14 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
>  {
>  	struct iomap_readpage_ctx *ctx = data;
>  	loff_t done, ret;
> +	size_t pg_left = 0;
> +
> +	if (ctx->cur_page)
> +		pg_left = page_size(ctx->cur_page) -
> +					(pos & (page_size(ctx->cur_page) - 1));

What's this unreadable magic do?

>  
>  	for (done = 0; done < length; done += ret) {
> -		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
> +		if (ctx->cur_page && pg_left == 0) {
>  			if (!ctx->cur_page_in_bio)
>  				unlock_page(ctx->cur_page);
>  			put_page(ctx->cur_page);
> @@ -369,9 +380,11 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
>  			if (!ctx->cur_page)
>  				break;
>  			ctx->cur_page_in_bio = false;
> +			pg_left = page_size(ctx->cur_page);
>  		}
>  		ret = iomap_readpage_actor(inode, pos + done, length - done,
>  				ctx, iomap);
> +		pg_left -= ret;
>  	}
>  
>  	return done;
> @@ -386,8 +399,9 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
>  		.is_readahead	= true,
>  	};
>  	loff_t pos = page_offset(list_entry(pages->prev, struct page, lru));
> -	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
> -	loff_t length = last - pos + PAGE_SIZE, ret = 0;
> +	struct page *last_page = list_entry(pages->next, struct page, lru);
> +	loff_t length = page_offset(last_page) - pos + page_size(last_page);

More magic that could do with a helper.

> +	loff_t ret = 0;
>  
>  	while (length > 0) {
>  		ret = iomap_apply(mapping->host, pos, length, 0, ops,
> @@ -435,7 +449,7 @@ iomap_is_partially_uptodate(struct page *page, unsigned long from,
>  	unsigned i;
>  
>  	/* Limit range to one page */
> -	len = min_t(unsigned, PAGE_SIZE - from, count);
> +	len = min_t(unsigned, page_size(page) - from, count);
>  
>  	/* First and last blocks in range within page */
>  	first = from >> inode->i_blkbits;
> @@ -474,7 +488,7 @@ iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
>  	 * If we are invalidating the entire page, clear the dirty state from it
>  	 * and release it to avoid unnecessary buildup of the LRU.
>  	 */
> -	if (offset == 0 && len == PAGE_SIZE) {
> +	if (offset == 0 && len == page_size(page)) {
>  		WARN_ON_ONCE(PageWriteback(page));
>  		cancel_dirty_page(page);
>  		iomap_page_release(page);
> @@ -550,18 +564,20 @@ static int
>  __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
>  		struct page *page, struct iomap *iomap)
>  {
> -	struct iomap_page *iop = iomap_page_create(inode, page);
>  	loff_t block_size = i_blocksize(inode);
>  	loff_t block_start = pos & ~(block_size - 1);
>  	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
> -	unsigned from = offset_in_page(pos), to = from + len, poff, plen;
> +	unsigned from = pos & (page_size(page) - 1);

iomap_offset_in_page() again :)

> +	unsigned to = from + len;
> +	unsigned poff, plen;
>  	int status = 0;
>  
>  	if (PageUptodate(page))
>  		return 0;
> +	iomap_page_create(inode, page);
>  
>  	do {
> -		iomap_adjust_read_range(inode, iop, &block_start,
> +		iomap_adjust_read_range(inode, page, &block_start,
>  				block_end - block_start, &poff, &plen);
>  		if (plen == 0)
>  			break;
> @@ -673,7 +689,7 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  	 */
>  	if (unlikely(copied < len && !PageUptodate(page)))
>  		return 0;
> -	iomap_set_range_uptodate(page, offset_in_page(pos), len);
> +	iomap_set_range_uptodate(page, pos & (page_size(page) - 1), len);

ditto.

>  	iomap_set_page_dirty(page);
>  	return copied;
>  }
> @@ -685,7 +701,9 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
>  	void *addr;
>  
>  	WARN_ON_ONCE(!PageUptodate(page));
> -	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +	BUG_ON(pos + copied > page_size(page) -
> +			((unsigned long)iomap->inline_data &
> +			 (page_size(page) - 1)));

Again, I think we should just avoid huge pages for inline data.

>  
>  	addr = kmap_atomic(page);
>  	memcpy(iomap->inline_data + pos, addr + pos, copied);
> @@ -749,6 +767,10 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		unsigned long bytes;	/* Bytes to write to page */
>  		size_t copied;		/* Bytes copied from user */
>  
> +		/*
> +		 * XXX: We don't know what size page we'll find in the
> +		 * page cache, so only copy up to a regular page boundary.
> +		 */
>  		offset = offset_in_page(pos);
>  		bytes = min_t(unsigned long, PAGE_SIZE - offset,
>  						iov_iter_count(i));
> @@ -1047,11 +1069,11 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
>  		goto out_unlock;
>  	}
>  
> -	/* page is wholly or partially inside EOF */
> -	if (((page->index + 1) << PAGE_SHIFT) > size)
> -		length = offset_in_page(size);
> +	/* page is wholly or partially beyond EOF */
> +	if (((page->index + compound_nr(page)) << PAGE_SHIFT) > size)
> +		length = size & (page_size(page) - 1);
>  	else
> -		length = PAGE_SIZE;
> +		length = page_size(page);

Yeah, that needs some help :)

Basically, I'd love to have all the things that end up being
variable because of block size or page size or a combination of both
moved into helpers. That way we end up the the code that does the
work being clean and easy to maintain, and all the nastiness
inherent to variable size objects is isolated to the helper
functions...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
