Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8111DDA2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 00:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbgEUWYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 18:24:46 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:43232 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730041AbgEUWYq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 18:24:46 -0400
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id DD61ED585F3;
        Fri, 22 May 2020 08:24:42 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jbtcE-0000Wh-8K; Fri, 22 May 2020 08:24:38 +1000
Date:   Fri, 22 May 2020 08:24:38 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/36] iomap: Support large pages in
 iomap_adjust_read_range
Message-ID: <20200521222438.GT2005@dread.disaster.area>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200515131656.12890-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515131656.12890-15-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=kj9zAlcOel0A:10 a=sTwFKg_x9MkA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=IOCeXHPP9RvrO-5I4wsA:9 a=4EiQV0XcPOQVQSqq:21 a=hAGzneUFbVT3-FjE:21
        a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 06:16:34AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Pass the struct page instead of the iomap_page so we can determine the
> size of the page.  Use offset_in_thp() instead of offset_in_page() and use
> thp_size() instead of PAGE_SIZE.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 4a79061073eb..423ffc9d4a97 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -83,15 +83,16 @@ iomap_page_release(struct page *page)
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
> +	unsigned poff = offset_in_thp(page, *pos);
> +	unsigned plen = min_t(loff_t, thp_size(page) - poff, length);
>  	unsigned first = poff >> block_bits;
>  	unsigned last = (poff + plen - 1) >> block_bits;
>  
> @@ -129,7 +130,7 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
>  	 * page cache for blocks that are entirely outside of i_size.
>  	 */
>  	if (orig_pos <= isize && orig_pos + length > isize) {
> -		unsigned end = offset_in_page(isize - 1) >> block_bits;
> +		unsigned end = offset_in_thp(page, isize - 1) >> block_bits;
>  
>  		if (first <= end && last > end)
>  			plen -= (last - end) * block_size;
> @@ -256,7 +257,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	}
>  
>  	/* zero post-eof blocks as the page may be mapped */
> -	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
> +	iomap_adjust_read_range(inode, page, &pos, length, &poff, &plen);
>  	if (plen == 0)
>  		goto done;
>  
> @@ -571,7 +572,6 @@ static int
>  __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  		struct page *page, struct iomap *srcmap)
>  {
> -	struct iomap_page *iop = iomap_page_create(inode, page);
>  	loff_t block_size = i_blocksize(inode);
>  	loff_t block_start = pos & ~(block_size - 1);
>  	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
> @@ -580,9 +580,10 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  
>  	if (PageUptodate(page))
>  		return 0;
> +	iomap_page_create(inode, page);

What problem does this fix? i.e. if we can get here with an
uninitialised page, why isn't this a separate bug fix. I don't see
anything in this patch that actually changes behaviour, and there's
nothing in the commit description to tell me why this is here,
so... ???

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
