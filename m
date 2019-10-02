Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88619C9064
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2019 20:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfJBSEe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Oct 2019 14:04:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbfJBSEe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Oct 2019 14:04:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 060C418C427B;
        Wed,  2 Oct 2019 18:04:33 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 065B9608C0;
        Wed,  2 Oct 2019 18:04:31 +0000 (UTC)
Date:   Wed, 2 Oct 2019 14:04:30 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] xfs: use the iomap write page code
Message-ID: <20191002180430.GC2403@bfoster>
References: <20191001071152.24403-1-hch@lst.de>
 <20191001071152.24403-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001071152.24403-11-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Wed, 02 Oct 2019 18:04:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 01, 2019 at 09:11:51AM +0200, Christoph Hellwig wrote:
> Use the new iomap writeback code that was copied from XFS to perform
> writeback.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [darrick: reduce this patch only to convert the xfs writeback code]
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Just a few nit level comments..

>  fs/xfs/xfs_aops.c  | 667 +++++----------------------------------------
>  fs/xfs/xfs_aops.h  |  17 --
>  fs/xfs/xfs_super.c |  11 +-
>  fs/xfs/xfs_trace.h |  39 ---
>  4 files changed, 74 insertions(+), 660 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 8c101081e3b1..d0a25b822123 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
...
> @@ -397,22 +265,16 @@ STATIC void
>  xfs_end_bio(
>  	struct bio		*bio)
>  {
> -	struct xfs_ioend	*ioend = bio->bi_private;
> +	struct iomap_ioend	*ioend = bio->bi_private;
>  	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
> -	struct xfs_mount	*mp = ip->i_mount;
>  	unsigned long		flags;
>  
> -	if ((ioend->io_flags & IOMAP_F_SHARED) ||
> -	    ioend->io_type == IOMAP_UNWRITTEN ||
> -	    ioend->io_append_trans != NULL) {
> -		spin_lock_irqsave(&ip->i_ioend_lock, flags);
> -		if (list_empty(&ip->i_ioend_list))
> -			WARN_ON_ONCE(!queue_work(mp->m_unwritten_workqueue,
> -						 &ip->i_ioend_work));
> -		list_add_tail(&ioend->io_list, &ip->i_ioend_list);
> -		spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
> -	} else
> -		xfs_destroy_ioend(ioend, blk_status_to_errno(bio->bi_status));

This change is a bit subtle. I think it would be good to have a new
assert here to ensure that we only ever end up in this handler for
appropriate ioends (i.e., shared || unwritten || append).

> +	spin_lock_irqsave(&ip->i_ioend_lock, flags);
> +	if (list_empty(&ip->i_ioend_list))
> +		WARN_ON_ONCE(!queue_work(ip->i_mount->m_unwritten_workqueue,
> +					 &ip->i_ioend_work));
> +	list_add_tail(&ioend->io_list, &ip->i_ioend_list);
> +	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
>  }
>  
>  /*
...
> @@ -630,24 +497,9 @@ xfs_map_blocks(
...
> +static int
>  xfs_submit_ioend(
> -	struct writeback_control *wbc,
> -	struct xfs_ioend	*ioend,
> +	struct iomap_ioend	*ioend,
>  	int			status)
>  {
>  	unsigned int		nofs_flag;
> @@ -670,139 +522,15 @@ xfs_submit_ioend(
>  	    ((ioend->io_flags & IOMAP_F_SHARED) ||
>  	     ioend->io_type != IOMAP_UNWRITTEN) &&
>  	    xfs_ioend_is_append(ioend) &&
> -	    !ioend->io_append_trans)
> +	    !ioend->io_private)
>  		status = xfs_setfilesize_trans_alloc(ioend);
>  
>  	memalloc_nofs_restore(nofs_flag);
...
> +	if ((ioend->io_flags & IOMAP_F_SHARED) ||
> +	    ioend->io_type == IOMAP_UNWRITTEN ||
> +	    ioend->io_private)
> +		ioend->io_bio->bi_end_io = xfs_end_bio;
> +	return status;

Somewhat related to the previous comment, but FWIW I find the
->submit_ioend() callback semantics a bit confusing in terms of what
layer is responsible for callback assignment, submitting/cancelling
bios, etc.

If we stick with the current semantics, could we add a function header
comment to document it clearly? IMO, something as simple as the
following is sufficient and helps set context:

/*
 * Perform any pre-submit operations that might be necessary for the ioend.
 * Replace the default iomap bio completion handler if custom completion time
 * processing is required.
 */

Also, could we consider a less misleading callback name?
->pre_submit_ioend() for example?

Those nits aside the rest of the patch looks good to me.

Brian

>  }
>  
>  /*
> @@ -816,8 +544,8 @@ xfs_vm_invalidatepage(
>   * transaction as there is no space left for block reservation (typically why we
>   * see a ENOSPC in writeback).
>   */
> -STATIC void
> -xfs_aops_discard_page(
> +static void
> +xfs_discard_page(
>  	struct page		*page)
>  {
>  	struct inode		*inode = page->mapping->host;
> @@ -839,246 +567,14 @@ xfs_aops_discard_page(
>  	if (error && !XFS_FORCED_SHUTDOWN(mp))
>  		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
>  out_invalidate:
> -	xfs_vm_invalidatepage(page, 0, PAGE_SIZE);
> -}
> -
> -/*
> - * We implement an immediate ioend submission policy here to avoid needing to
> - * chain multiple ioends and hence nest mempool allocations which can violate
> - * forward progress guarantees we need to provide. The current ioend we are
> - * adding blocks to is cached on the writepage context, and if the new block
> - * does not append to the cached ioend it will create a new ioend and cache that
> - * instead.
> - *
> - * If a new ioend is created and cached, the old ioend is returned and queued
> - * locally for submission once the entire page is processed or an error has been
> - * detected.  While ioends are submitted immediately after they are completed,
> - * batching optimisations are provided by higher level block plugging.
> - *
> - * At the end of a writeback pass, there will be a cached ioend remaining on the
> - * writepage context that the caller will need to submit.
> - */
> -static int
> -xfs_writepage_map(
> -	struct xfs_writepage_ctx *wpc,
> -	struct writeback_control *wbc,
> -	struct inode		*inode,
> -	struct page		*page,
> -	uint64_t		end_offset)
> -{
> -	LIST_HEAD(submit_list);
> -	struct iomap_page	*iop = to_iomap_page(page);
> -	unsigned		len = i_blocksize(inode);
> -	struct xfs_ioend	*ioend, *next;
> -	uint64_t		file_offset;	/* file offset of page */
> -	int			error = 0, count = 0, i;
> -
> -	ASSERT(iop || i_blocksize(inode) == PAGE_SIZE);
> -	ASSERT(!iop || atomic_read(&iop->write_count) == 0);
> -
> -	/*
> -	 * Walk through the page to find areas to write back. If we run off the
> -	 * end of the current map or find the current map invalid, grab a new
> -	 * one.
> -	 */
> -	for (i = 0, file_offset = page_offset(page);
> -	     i < (PAGE_SIZE >> inode->i_blkbits) && file_offset < end_offset;
> -	     i++, file_offset += len) {
> -		if (iop && !test_bit(i, iop->uptodate))
> -			continue;
> -
> -		error = xfs_map_blocks(wpc, inode, file_offset);
> -		if (error)
> -			break;
> -		if (wpc->iomap.type == IOMAP_HOLE)
> -			continue;
> -		xfs_add_to_ioend(inode, file_offset, page, iop, wpc, wbc,
> -				 &submit_list);
> -		count++;
> -	}
> -
> -	ASSERT(wpc->ioend || list_empty(&submit_list));
> -	ASSERT(PageLocked(page));
> -	ASSERT(!PageWriteback(page));
> -
> -	/*
> -	 * On error, we have to fail the ioend here because we may have set
> -	 * pages under writeback, we have to make sure we run IO completion to
> -	 * mark the error state of the IO appropriately, so we can't cancel the
> -	 * ioend directly here.  That means we have to mark this page as under
> -	 * writeback if we included any blocks from it in the ioend chain so
> -	 * that completion treats it correctly.
> -	 *
> -	 * If we didn't include the page in the ioend, the on error we can
> -	 * simply discard and unlock it as there are no other users of the page
> -	 * now.  The caller will still need to trigger submission of outstanding
> -	 * ioends on the writepage context so they are treated correctly on
> -	 * error.
> -	 */
> -	if (unlikely(error)) {
> -		if (!count) {
> -			xfs_aops_discard_page(page);
> -			ClearPageUptodate(page);
> -			unlock_page(page);
> -			goto done;
> -		}
> -
> -		/*
> -		 * If the page was not fully cleaned, we need to ensure that the
> -		 * higher layers come back to it correctly.  That means we need
> -		 * to keep the page dirty, and for WB_SYNC_ALL writeback we need
> -		 * to ensure the PAGECACHE_TAG_TOWRITE index mark is not removed
> -		 * so another attempt to write this page in this writeback sweep
> -		 * will be made.
> -		 */
> -		set_page_writeback_keepwrite(page);
> -	} else {
> -		clear_page_dirty_for_io(page);
> -		set_page_writeback(page);
> -	}
> -
> -	unlock_page(page);
> -
> -	/*
> -	 * Preserve the original error if there was one, otherwise catch
> -	 * submission errors here and propagate into subsequent ioend
> -	 * submissions.
> -	 */
> -	list_for_each_entry_safe(ioend, next, &submit_list, io_list) {
> -		int error2;
> -
> -		list_del_init(&ioend->io_list);
> -		error2 = xfs_submit_ioend(wbc, ioend, error);
> -		if (error2 && !error)
> -			error = error2;
> -	}
> -
> -	/*
> -	 * We can end up here with no error and nothing to write only if we race
> -	 * with a partial page truncate on a sub-page block sized filesystem.
> -	 */
> -	if (!count)
> -		end_page_writeback(page);
> -done:
> -	mapping_set_error(page->mapping, error);
> -	return error;
> +	iomap_invalidatepage(page, 0, PAGE_SIZE);
>  }
>  
> -/*
> - * Write out a dirty page.
> - *
> - * For delalloc space on the page we need to allocate space and flush it.
> - * For unwritten space on the page we need to start the conversion to
> - * regular allocated space.
> - */
> -STATIC int
> -xfs_do_writepage(
> -	struct page		*page,
> -	struct writeback_control *wbc,
> -	void			*data)
> -{
> -	struct xfs_writepage_ctx *wpc = data;
> -	struct inode		*inode = page->mapping->host;
> -	loff_t			offset;
> -	uint64_t              end_offset;
> -	pgoff_t                 end_index;
> -
> -	trace_xfs_writepage(inode, page, 0, 0);
> -
> -	/*
> -	 * Refuse to write the page out if we are called from reclaim context.
> -	 *
> -	 * This avoids stack overflows when called from deeply used stacks in
> -	 * random callers for direct reclaim or memcg reclaim.  We explicitly
> -	 * allow reclaim from kswapd as the stack usage there is relatively low.
> -	 *
> -	 * This should never happen except in the case of a VM regression so
> -	 * warn about it.
> -	 */
> -	if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
> -			PF_MEMALLOC))
> -		goto redirty;
> -
> -	/*
> -	 * Given that we do not allow direct reclaim to call us, we should
> -	 * never be called while in a filesystem transaction.
> -	 */
> -	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> -		goto redirty;
> -
> -	/*
> -	 * Is this page beyond the end of the file?
> -	 *
> -	 * The page index is less than the end_index, adjust the end_offset
> -	 * to the highest offset that this page should represent.
> -	 * -----------------------------------------------------
> -	 * |			file mapping	       | <EOF> |
> -	 * -----------------------------------------------------
> -	 * | Page ... | Page N-2 | Page N-1 |  Page N  |       |
> -	 * ^--------------------------------^----------|--------
> -	 * |     desired writeback range    |      see else    |
> -	 * ---------------------------------^------------------|
> -	 */
> -	offset = i_size_read(inode);
> -	end_index = offset >> PAGE_SHIFT;
> -	if (page->index < end_index)
> -		end_offset = (xfs_off_t)(page->index + 1) << PAGE_SHIFT;
> -	else {
> -		/*
> -		 * Check whether the page to write out is beyond or straddles
> -		 * i_size or not.
> -		 * -------------------------------------------------------
> -		 * |		file mapping		        | <EOF>  |
> -		 * -------------------------------------------------------
> -		 * | Page ... | Page N-2 | Page N-1 |  Page N   | Beyond |
> -		 * ^--------------------------------^-----------|---------
> -		 * |				    |      Straddles     |
> -		 * ---------------------------------^-----------|--------|
> -		 */
> -		unsigned offset_into_page = offset & (PAGE_SIZE - 1);
> -
> -		/*
> -		 * Skip the page if it is fully outside i_size, e.g. due to a
> -		 * truncate operation that is in progress. We must redirty the
> -		 * page so that reclaim stops reclaiming it. Otherwise
> -		 * xfs_vm_releasepage() is called on it and gets confused.
> -		 *
> -		 * Note that the end_index is unsigned long, it would overflow
> -		 * if the given offset is greater than 16TB on 32-bit system
> -		 * and if we do check the page is fully outside i_size or not
> -		 * via "if (page->index >= end_index + 1)" as "end_index + 1"
> -		 * will be evaluated to 0.  Hence this page will be redirtied
> -		 * and be written out repeatedly which would result in an
> -		 * infinite loop, the user program that perform this operation
> -		 * will hang.  Instead, we can verify this situation by checking
> -		 * if the page to write is totally beyond the i_size or if it's
> -		 * offset is just equal to the EOF.
> -		 */
> -		if (page->index > end_index ||
> -		    (page->index == end_index && offset_into_page == 0))
> -			goto redirty;
> -
> -		/*
> -		 * The page straddles i_size.  It must be zeroed out on each
> -		 * and every writepage invocation because it may be mmapped.
> -		 * "A file is mapped in multiples of the page size.  For a file
> -		 * that is not a multiple of the page size, the remaining
> -		 * memory is zeroed when mapped, and writes to that region are
> -		 * not written out to the file."
> -		 */
> -		zero_user_segment(page, offset_into_page, PAGE_SIZE);
> -
> -		/* Adjust the end_offset to the end of file */
> -		end_offset = offset;
> -	}
> -
> -	return xfs_writepage_map(wpc, wbc, inode, page, end_offset);
> -
> -redirty:
> -	redirty_page_for_writepage(wbc, page);
> -	unlock_page(page);
> -	return 0;
> -}
> +static const struct iomap_writeback_ops xfs_writeback_ops = {
> +	.map_blocks		= xfs_map_blocks,
> +	.submit_ioend		= xfs_submit_ioend,
> +	.discard_page		= xfs_discard_page,
> +};
>  
>  STATIC int
>  xfs_vm_writepage(
> @@ -1086,12 +582,8 @@ xfs_vm_writepage(
>  	struct writeback_control *wbc)
>  {
>  	struct xfs_writepage_ctx wpc = { };
> -	int			ret;
>  
> -	ret = xfs_do_writepage(page, wbc, &wpc);
> -	if (wpc.ioend)
> -		ret = xfs_submit_ioend(wbc, wpc.ioend, ret);
> -	return ret;
> +	return iomap_writepage(page, wbc, &wpc.ctx, &xfs_writeback_ops);
>  }
>  
>  STATIC int
> @@ -1100,13 +592,9 @@ xfs_vm_writepages(
>  	struct writeback_control *wbc)
>  {
>  	struct xfs_writepage_ctx wpc = { };
> -	int			ret;
>  
>  	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
> -	ret = write_cache_pages(mapping, wbc, xfs_do_writepage, &wpc);
> -	if (wpc.ioend)
> -		ret = xfs_submit_ioend(wbc, wpc.ioend, ret);
> -	return ret;
> +	return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
>  }
>  
>  STATIC int
> @@ -1119,15 +607,6 @@ xfs_dax_writepages(
>  			xfs_find_bdev_for_inode(mapping->host), wbc);
>  }
>  
> -STATIC int
> -xfs_vm_releasepage(
> -	struct page		*page,
> -	gfp_t			gfp_mask)
> -{
> -	trace_xfs_releasepage(page->mapping->host, page, 0, 0);
> -	return iomap_releasepage(page, gfp_mask);
> -}
> -
>  STATIC sector_t
>  xfs_vm_bmap(
>  	struct address_space	*mapping,
> @@ -1185,8 +664,8 @@ const struct address_space_operations xfs_address_space_operations = {
>  	.writepage		= xfs_vm_writepage,
>  	.writepages		= xfs_vm_writepages,
>  	.set_page_dirty		= iomap_set_page_dirty,
> -	.releasepage		= xfs_vm_releasepage,
> -	.invalidatepage		= xfs_vm_invalidatepage,
> +	.releasepage		= iomap_releasepage,
> +	.invalidatepage		= iomap_invalidatepage,
>  	.bmap			= xfs_vm_bmap,
>  	.direct_IO		= noop_direct_IO,
>  	.migratepage		= iomap_migrate_page,
> diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
> index c2756ed50b0d..687b11f34fa2 100644
> --- a/fs/xfs/xfs_aops.h
> +++ b/fs/xfs/xfs_aops.h
> @@ -6,23 +6,6 @@
>  #ifndef __XFS_AOPS_H__
>  #define __XFS_AOPS_H__
>  
> -extern struct bio_set xfs_ioend_bioset;
> -
> -/*
> - * Structure for buffered I/O completions.
> - */
> -struct xfs_ioend {
> -	struct list_head	io_list;	/* next ioend in chain */
> -	u16			io_type;
> -	u16			io_flags;	/* IOMAP_F_* */
> -	struct inode		*io_inode;	/* file being written to */
> -	size_t			io_size;	/* size of the extent */
> -	xfs_off_t		io_offset;	/* offset in the file */
> -	struct xfs_trans	*io_append_trans;/* xact. for size update */
> -	struct bio		*io_bio;	/* bio being built */
> -	struct bio		io_inline_bio;	/* MUST BE LAST! */
> -};
> -
>  extern const struct address_space_operations xfs_address_space_operations;
>  extern const struct address_space_operations xfs_dax_aops;
>  
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 8d1df9f8be07..0a8cf6b87a21 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -40,7 +40,6 @@
>  #include <linux/parser.h>
>  
>  static const struct super_operations xfs_super_operations;
> -struct bio_set xfs_ioend_bioset;
>  
>  static struct kset *xfs_kset;		/* top-level xfs sysfs dir */
>  #ifdef DEBUG
> @@ -1853,15 +1852,10 @@ MODULE_ALIAS_FS("xfs");
>  STATIC int __init
>  xfs_init_zones(void)
>  {
> -	if (bioset_init(&xfs_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> -			offsetof(struct xfs_ioend, io_inline_bio),
> -			BIOSET_NEED_BVECS))
> -		goto out;
> -
>  	xfs_log_ticket_zone = kmem_zone_init(sizeof(xlog_ticket_t),
>  						"xfs_log_ticket");
>  	if (!xfs_log_ticket_zone)
> -		goto out_free_ioend_bioset;
> +		goto out;
>  
>  	xfs_bmap_free_item_zone = kmem_zone_init(
>  			sizeof(struct xfs_extent_free_item),
> @@ -1996,8 +1990,6 @@ xfs_init_zones(void)
>  	kmem_zone_destroy(xfs_bmap_free_item_zone);
>   out_destroy_log_ticket_zone:
>  	kmem_zone_destroy(xfs_log_ticket_zone);
> - out_free_ioend_bioset:
> -	bioset_exit(&xfs_ioend_bioset);
>   out:
>  	return -ENOMEM;
>  }
> @@ -2028,7 +2020,6 @@ xfs_destroy_zones(void)
>  	kmem_zone_destroy(xfs_btree_cur_zone);
>  	kmem_zone_destroy(xfs_bmap_free_item_zone);
>  	kmem_zone_destroy(xfs_log_ticket_zone);
> -	bioset_exit(&xfs_ioend_bioset);
>  }
>  
>  STATIC int __init
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index eae4b29c174e..cbb23d7a3554 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -1158,45 +1158,6 @@ DEFINE_RW_EVENT(xfs_file_buffered_write);
>  DEFINE_RW_EVENT(xfs_file_direct_write);
>  DEFINE_RW_EVENT(xfs_file_dax_write);
>  
> -DECLARE_EVENT_CLASS(xfs_page_class,
> -	TP_PROTO(struct inode *inode, struct page *page, unsigned long off,
> -		 unsigned int len),
> -	TP_ARGS(inode, page, off, len),
> -	TP_STRUCT__entry(
> -		__field(dev_t, dev)
> -		__field(xfs_ino_t, ino)
> -		__field(pgoff_t, pgoff)
> -		__field(loff_t, size)
> -		__field(unsigned long, offset)
> -		__field(unsigned int, length)
> -	),
> -	TP_fast_assign(
> -		__entry->dev = inode->i_sb->s_dev;
> -		__entry->ino = XFS_I(inode)->i_ino;
> -		__entry->pgoff = page_offset(page);
> -		__entry->size = i_size_read(inode);
> -		__entry->offset = off;
> -		__entry->length = len;
> -	),
> -	TP_printk("dev %d:%d ino 0x%llx pgoff 0x%lx size 0x%llx offset %lx "
> -		  "length %x",
> -		  MAJOR(__entry->dev), MINOR(__entry->dev),
> -		  __entry->ino,
> -		  __entry->pgoff,
> -		  __entry->size,
> -		  __entry->offset,
> -		  __entry->length)
> -)
> -
> -#define DEFINE_PAGE_EVENT(name)		\
> -DEFINE_EVENT(xfs_page_class, name,	\
> -	TP_PROTO(struct inode *inode, struct page *page, unsigned long off, \
> -		 unsigned int len),	\
> -	TP_ARGS(inode, page, off, len))
> -DEFINE_PAGE_EVENT(xfs_writepage);
> -DEFINE_PAGE_EVENT(xfs_releasepage);
> -DEFINE_PAGE_EVENT(xfs_invalidatepage);
> -
>  DECLARE_EVENT_CLASS(xfs_imap_class,
>  	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count,
>  		 int whichfork, struct xfs_bmbt_irec *irec),
> -- 
> 2.20.1
> 
