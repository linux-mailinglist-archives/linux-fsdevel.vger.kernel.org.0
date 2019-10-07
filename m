Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B223CEE83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 23:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfJGVoA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 17:44:00 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:36360 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728654AbfJGVn7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:43:59 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 4A31A363187;
        Tue,  8 Oct 2019 08:43:55 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iHanK-0001ig-0E; Tue, 08 Oct 2019 08:43:54 +1100
Date:   Tue, 8 Oct 2019 08:43:53 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] iomap: copy the xfs writeback code to iomap.c
Message-ID: <20191007214353.GZ16973@dread.disaster.area>
References: <20191006154608.24738-1-hch@lst.de>
 <20191006154608.24738-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006154608.24738-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=yPCof4ZbAAAA:8 a=7-415B0cAAAA:8 a=zNbEbow88BXXJ6IC_AYA:9
        a=CjuIK1q_8ugA:10 a=igBNqPyMv6gA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 06, 2019 at 05:45:59PM +0200, Christoph Hellwig wrote:
> Takes the xfs writeback code and copies it to iomap.c.  A new structure
> with three methods is added as the abstraction from the generic
> writeback code to the file system.  These methods are used to map
> blocks, submit an ioend, and cancel a page that encountered an error
> before it was added to an ioend.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [darrick: create the new iomap code, we'll delete the xfs code separately]
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
.....

> +static int
> +iomap_ioend_compare(void *priv, struct list_head *a, struct list_head *b)
> +{
> +	struct iomap_ioend *ia, *ib;
> +
> +	ia = container_of(a, struct iomap_ioend, io_list);
> +	ib = container_of(b, struct iomap_ioend, io_list);
> +	if (ia->io_offset < ib->io_offset)
> +		return -1;
> +	else if (ia->io_offset > ib->io_offset)
> +		return 1;
> +	return 0;

No need for the else here.

> +/*
> + * Test to see if we have an existing ioend structure that we could append to
> + * first, otherwise finish off the current ioend and start another.
> + */
> +static void
> +iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
> +		struct iomap_page *iop, struct iomap_writepage_ctx *wpc,
> +		struct writeback_control *wbc, struct list_head *iolist)
> +{
> +	sector_t sector = iomap_sector(&wpc->iomap, offset);
> +	unsigned len = i_blocksize(inode);
> +	unsigned poff = offset & (PAGE_SIZE - 1);
> +	bool merged, same_page = false;
> +
> +	if (!wpc->ioend ||
> +	    (wpc->iomap.flags & IOMAP_F_SHARED) !=
> +	    (wpc->ioend->io_flags & IOMAP_F_SHARED) ||

This second line of the comparison should be indented further as it
is a continuation of the the previous line's log statement, not a
unique logic statement by itself.

> +	    wpc->iomap.type != wpc->ioend->io_type ||
> +	    sector != bio_end_sector(wpc->ioend->io_bio) ||
> +	    offset != wpc->ioend->io_offset + wpc->ioend->io_size) {
> +		if (wpc->ioend)
> +			list_add(&wpc->ioend->io_list, iolist);
> +		wpc->ioend = iomap_alloc_ioend(inode, wpc, offset, sector, wbc);
> +	}
.....
> +static int
> +iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
> +{
> +	struct iomap_writepage_ctx *wpc = data;
> +	struct inode *inode = page->mapping->host;
> +	pgoff_t end_index;
> +	u64 end_offset;
> +	loff_t offset;
> +
> +	trace_iomap_writepage(inode, page, 0, 0);
> +
> +	/*
> +	 * Refuse to write the page out if we are called from reclaim context.
> +	 *
> +	 * This avoids stack overflows when called from deeply used stacks in
> +	 * random callers for direct reclaim or memcg reclaim.  We explicitly
> +	 * allow reclaim from kswapd as the stack usage there is relatively low.
> +	 *
> +	 * This should never happen except in the case of a VM regression so
> +	 * warn about it.
> +	 */
> +	if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
> +			PF_MEMALLOC))
> +		goto redirty;
> +
> +	/*
> +	 * Given that we do not allow direct reclaim to call us, we should
> +	 * never be called while in a filesystem transaction.
> +	 */
> +	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> +		goto redirty;

Is this true for all expected callers of these functions rather than
just XFS? i.e. PF_MEMALLOC_NOFS is used by transactions in XFS to
prevent transaction context recursion, but other filesystems do not
do this..

FWIW, I can also see that this is going to cause us problems if high
level code starts using memalloc_nofs_save() and then calling
filemap_datawrite() and friends...

> +iomap_writepage(struct page *page, struct writeback_control *wbc,
> +		struct iomap_writepage_ctx *wpc,
> +		const struct iomap_writeback_ops *ops)
> +{
> +	int ret;
> +
> +	wpc->ops = ops;
> +	ret = iomap_do_writepage(page, wbc, wpc);
> +	if (!wpc->ioend)
> +		return ret;
> +	return iomap_submit_ioend(wpc, wpc->ioend, ret);
> +}
> +EXPORT_SYMBOL_GPL(iomap_writepage);

Can we kill ->writepage for iomap users, please? After all, we don't
mostly don't allow memory reclaim to do writeback of dirty pages,
and that's the only caller of ->writepage.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
