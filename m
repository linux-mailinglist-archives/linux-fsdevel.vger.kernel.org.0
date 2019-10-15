Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67955D8342
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 00:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbfJOWH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 18:07:27 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:33078 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbfJOWH1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:07:27 -0400
Received: from dread.disaster.area (pa49-181-198-88.pa.nsw.optusnet.com.au [49.181.198.88])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id D073343DDD4;
        Wed, 16 Oct 2019 09:07:21 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iKUyP-00012g-BR; Wed, 16 Oct 2019 09:07:21 +1100
Date:   Wed, 16 Oct 2019 09:07:21 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] iomap: lift the xfs writeback code to iomap
Message-ID: <20191015220721.GC16973@dread.disaster.area>
References: <20191015154345.13052-1-hch@lst.de>
 <20191015154345.13052-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015154345.13052-10-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=ocld+OpnWJCUTqzFQA3oTA==:117 a=ocld+OpnWJCUTqzFQA3oTA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=vuri3833d9zUTJQm3joA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 05:43:42PM +0200, Christoph Hellwig wrote:
> Take the xfs writeback code and move it to fs/iomap.  A new structure
> with three methods is added as the abstraction from the generic writeback
> code to the file system.  These methods are used to map blocks, submit an
> ioend, and cancel a page that encountered an error before it was added to
> an ioend.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 564 ++++++++++++++++++++++++++++++++++-
>  fs/iomap/trace.h       |  39 +++
>  fs/xfs/xfs_aops.c      | 662 ++++-------------------------------------
>  fs/xfs/xfs_aops.h      |  17 --
>  fs/xfs/xfs_super.c     |  11 +-
>  fs/xfs/xfs_trace.h     |  39 ---
>  include/linux/iomap.h  |  59 ++++
>  7 files changed, 722 insertions(+), 669 deletions(-)
.....
> @@ -468,6 +471,8 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
>  int
>  iomap_releasepage(struct page *page, gfp_t gfp_mask)
>  {
> +	trace_iomap_releasepage(page->mapping->host, page, 0, 0);
> +
>  	/*
>  	 * mm accommodates an old ext3 case where clean pages might not have had
>  	 * the dirty bit cleared. Thus, it can send actual dirty pages to
> @@ -483,6 +488,8 @@ EXPORT_SYMBOL_GPL(iomap_releasepage);
>  void
>  iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
>  {
> +	trace_iomap_invalidatepage(page->mapping->host, page, offset, len);
> +

These tracepoints should be split out into a separate patch like
the readpage(s) tracepoints. Maybe just lift all the non-writeback
ones in a single patch...

>  	/*
>  	 * If we are invalidating the entire page, clear the dirty state from it
>  	 * and release it to avoid unnecessary buildup of the LRU.
> @@ -1084,3 +1091,558 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
>  	return block_page_mkwrite_return(ret);
>  }
>  EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
> +
> +static void
> +iomap_finish_page_writeback(struct inode *inode, struct bio_vec *bvec,
> +		int error)
> +{
> +	struct iomap_page *iop = to_iomap_page(bvec->bv_page);
> +
> +	if (error) {
> +		SetPageError(bvec->bv_page);
> +		mapping_set_error(inode->i_mapping, -EIO);
> +	}
> +
> +	WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE && !iop);
> +	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) <= 0);
> +
> +	if (!iop || atomic_dec_and_test(&iop->write_count))
> +		end_page_writeback(bvec->bv_page);
> +}

Can we just pass the struct page into this function?

.....

> +/*
> + * Submit the bio for an ioend. We are passed an ioend with a bio attached to
> + * it, and we submit that bio. The ioend may be used for multiple bio
> + * submissions, so we only want to allocate an append transaction for the ioend
> + * once.  In the case of multiple bio submission, each bio will take an IO

This needs to be changed to describe what wpc->ops->submit_ioend()
is used for rather than what XFS might use this hook for.

> + * reference to the ioend to ensure that the ioend completion is only done once
> + * all bios have been submitted and the ioend is really done.
> + *
> + * If @error is non-zero, it means that we have a situation where some part of
> + * the submission process has failed after we have marked paged for writeback
> + * and unlocked them. In this situation, we need to fail the bio and ioend
> + * rather than submit it to IO. This typically only happens on a filesystem
> + * shutdown.
> + */
> +static int
> +iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
> +		int error)
> +{
> +	ioend->io_bio->bi_private = ioend;
> +	ioend->io_bio->bi_end_io = iomap_writepage_end_bio;
> +
> +	if (wpc->ops->submit_ioend)
> +		error = wpc->ops->submit_ioend(ioend, error);

I'm not sure that "submit_ioend" is the best name for this method,
as it is a pre-bio-submission hook, not an actual IO submission
method. "prepare_ioend_for_submit" is more descriptive, but probably
too long. wpc->ops->prepare_submit(ioend, error) reads pretty well,
though...

> +	if (error) {
> +		/*
> +		 * If we are failing the IO now, just mark the ioend with an
> +		 * error and finish it.  This will run IO completion immediately
> +		 * as there is only one reference to the ioend at this point in
> +		 * time.
> +		 */
> +		ioend->io_bio->bi_status = errno_to_blk_status(error);
> +		bio_endio(ioend->io_bio);
> +		return error;
> +	}
> +
> +	submit_bio(ioend->io_bio);
> +	return 0;
> +}

.....
> +/*
> + * We implement an immediate ioend submission policy here to avoid needing to
> + * chain multiple ioends and hence nest mempool allocations which can violate
> + * forward progress guarantees we need to provide. The current ioend we are
> + * adding blocks to is cached on the writepage context, and if the new block

adding pages to ... , and if the new block mapping

> + * does not append to the cached ioend it will create a new ioend and cache that
> + * instead.
> + *
> + * If a new ioend is created and cached, the old ioend is returned and queued
> + * locally for submission once the entire page is processed or an error has been
> + * detected.  While ioends are submitted immediately after they are completed,
> + * batching optimisations are provided by higher level block plugging.
> + *
> + * At the end of a writeback pass, there will be a cached ioend remaining on the
> + * writepage context that the caller will need to submit.
> + */
> +static int
> +iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> +		struct writeback_control *wbc, struct inode *inode,
> +		struct page *page, u64 end_offset)
> +{
> +	struct iomap_page *iop = to_iomap_page(page);
> +	struct iomap_ioend *ioend, *next;
> +	unsigned len = i_blocksize(inode);
> +	u64 file_offset; /* file offset of page */
> +	int error = 0, count = 0, i;
> +	LIST_HEAD(submit_list);
> +
> +	WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE && !iop);
> +	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) != 0);
> +
> +	/*
> +	 * Walk through the page to find areas to write back. If we run off the
> +	 * end of the current map or find the current map invalid, grab a new
> +	 * one.
> +	 */
> +	for (i = 0, file_offset = page_offset(page);
> +	     i < (PAGE_SIZE >> inode->i_blkbits) && file_offset < end_offset;
> +	     i++, file_offset += len) {
> +		if (iop && !test_bit(i, iop->uptodate))
> +			continue;
> +
> +		error = wpc->ops->map_blocks(wpc, inode, file_offset);
> +		if (error)
> +			break;
> +		if (wpc->iomap.type == IOMAP_HOLE)
> +			continue;
> +		iomap_add_to_ioend(inode, file_offset, page, iop, wpc, wbc,
> +				 &submit_list);
> +		count++;
> +	}
> +
> +	WARN_ON_ONCE(!wpc->ioend && !list_empty(&submit_list));
> +	WARN_ON_ONCE(!PageLocked(page));
> +	WARN_ON_ONCE(PageWriteback(page));
> +
> +	/*
> +	 * On error, we have to fail the ioend here because we may have set
> +	 * pages under writeback, we have to make sure we run IO completion to
> +	 * mark the error state of the IO appropriately, so we can't cancel the
> +	 * ioend directly here.

Few too many commas and run-ons here. Maybe reword it like this:

	/*
	 * We cannot cancel the ioend directly here if there is a submission
	 * error. We may have already set pages under writeback and hence we
	 * have to run IO completion to mark the error state of the pages under
	 * writeback appropriately.

>
>
>				That means we have to mark this page as under
> +	 * writeback if we included any blocks from it in the ioend chain so
> +	 * that completion treats it correctly.
> +	 *
> +	 * If we didn't include the page in the ioend, the on error we can
                                                       then on error

> +	 * simply discard and unlock it as there are no other users of the page
> +	 * now.  The caller will still need to trigger submission of outstanding
> +	 * ioends on the writepage context so they are treated correctly on
> +	 * error.
> +	 */

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

	   never be called in a recursive filesystem reclaim context.

> +	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> +		goto redirty;
> +

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
