Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9C972338D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 01:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjFEXKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 19:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjFEXKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:10:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAA3BE;
        Mon,  5 Jun 2023 16:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4E2761793;
        Mon,  5 Jun 2023 23:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24090C433D2;
        Mon,  5 Jun 2023 23:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686006615;
        bh=UPYKtV+iTR/mah9RwsVEjS9BMQmD7+48HR0NYv6njBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKz0Rl+ljp36qfML2Ex3+mgWcFzvrf1FHZyqt9Tu85skIm97ZEE5YyhJSam/kwRy3
         hW0+EWt2QEtP9D8bvn8qMKKywjjLElK6Pn0Dy7aM8CfHuOfbvvDCK92M/VV/M1PogD
         toacFYFLDhOZsQ/2YOHWpsRnXj+AvVJ/CX0oh6H3eytiDRBZZ4WdODRY+Bh1ZswBOl
         S6dI8xku0u1eTClwxq97PGIY5tS3FTvkl6HlHnXolgKLJufpKxO2pUTxNu0lyIK0/w
         ivSV2ti9zgNey1iU+PhypS82p4G5JCA/qRyQ9C23+5hStKHl+TbRABM88AHNX5Vynv
         sI7Gh6T0WN8sw==
Date:   Mon, 5 Jun 2023 16:10:14 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [PATCHv7 6/6] iomap: Add per-block dirty state tracking to
 improve performance
Message-ID: <20230605231014.GI1325469@frogsfrogsfrogs>
References: <cover.1685962158.git.ritesh.list@gmail.com>
 <1d83ed98de8d7896b4a7cc56c31d6f9c33be272f.1685962158.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d83ed98de8d7896b4a7cc56c31d6f9c33be272f.1685962158.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 04:25:06PM +0530, Ritesh Harjani (IBM) wrote:
> When filesystem blocksize is less than folio size (either with
> mapping_large_folio_support() or with blocksize < pagesize) and when the
> folio is uptodate in pagecache, then even a byte write can cause
> an entire folio to be written to disk during writeback. This happens
> because we currently don't have a mechanism to track per-block dirty
> state within struct iomap_page. We currently only track uptodate state.
> 
> This patch implements support for tracking per-block dirty state in
> iomap_page->state bitmap. This should help improve the filesystem write
> performance and help reduce write amplification.
> 
> Performance testing of below fio workload reveals ~16x performance
> improvement using nvme with XFS (4k blocksize) on Power (64K pagesize)
> FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
> 
> 1. <test_randwrite.fio>
> [global]
> 	ioengine=psync
> 	rw=randwrite
> 	overwrite=1
> 	pre_read=1
> 	direct=0
> 	bs=4k
> 	size=1G
> 	dir=./
> 	numjobs=8
> 	fdatasync=1
> 	runtime=60
> 	iodepth=64
> 	group_reporting=1
> 
> [fio-run]
> 
> 2. Also our internal performance team reported that this patch improves
>    their database workload performance by around ~83% (with XFS on Power)
> 
> Reported-by: Aravinda Herle <araherle@in.ibm.com>
> Reported-by: Brian Foster <bfoster@redhat.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/gfs2/aops.c         |   2 +-
>  fs/iomap/buffered-io.c | 120 +++++++++++++++++++++++++++++++++++++++--
>  fs/xfs/xfs_aops.c      |   2 +-
>  fs/zonefs/file.c       |   2 +-
>  include/linux/iomap.h  |   1 +
>  5 files changed, 120 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index a5f4be6b9213..75efec3c3b71 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -746,7 +746,7 @@ static const struct address_space_operations gfs2_aops = {
>  	.writepages = gfs2_writepages,
>  	.read_folio = gfs2_read_folio,
>  	.readahead = gfs2_readahead,
> -	.dirty_folio = filemap_dirty_folio,
> +	.dirty_folio = iomap_dirty_folio,
>  	.release_folio = iomap_release_folio,
>  	.invalidate_folio = iomap_invalidate_folio,
>  	.bmap = gfs2_bmap,
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 2a97d73edb96..e7d114b5b918 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -85,6 +85,63 @@ static void iomap_iop_set_range_uptodate(struct inode *inode,
>  		folio_mark_uptodate(folio);
>  }
> 
> +static bool iop_test_block_dirty(struct folio *folio, int block)
> +{
> +	struct iomap_page *iop = to_iomap_page(folio);
> +	struct inode *inode = folio->mapping->host;
> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> +
> +	return test_bit(block + blks_per_folio, iop->state);
> +}
> +
> +static void iop_set_range_dirty(struct inode *inode, struct folio *folio,
> +				size_t off, size_t len)
> +{
> +	struct iomap_page *iop = to_iomap_page(folio);
> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> +	unsigned int first_blk = off >> inode->i_blkbits;
> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
> +	unsigned int nr_blks = last_blk - first_blk + 1;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iop->state_lock, flags);
> +	bitmap_set(iop->state, first_blk + blks_per_folio, nr_blks);
> +	spin_unlock_irqrestore(&iop->state_lock, flags);
> +}
> +
> +static void iomap_iop_set_range_dirty(struct inode *inode, struct folio *folio,
> +				size_t off, size_t len)
> +{
> +	struct iomap_page *iop = to_iomap_page(folio);
> +
> +	if (iop)
> +		iop_set_range_dirty(inode, folio, off, len);
> +}
> +
> +static void iop_clear_range_dirty(struct inode *inode, struct folio *folio,
> +				  size_t off, size_t len)
> +{
> +	struct iomap_page *iop = to_iomap_page(folio);
> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> +	unsigned int first_blk = off >> inode->i_blkbits;
> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
> +	unsigned int nr_blks = last_blk - first_blk + 1;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iop->state_lock, flags);
> +	bitmap_clear(iop->state, first_blk + blks_per_folio, nr_blks);
> +	spin_unlock_irqrestore(&iop->state_lock, flags);
> +}
> +
> +static void iomap_iop_clear_range_dirty(struct inode *inode,
> +				struct folio *folio, size_t off, size_t len)
> +{
> +	struct iomap_page *iop = to_iomap_page(folio);
> +
> +	if (iop)
> +		iop_clear_range_dirty(inode, folio, off, len);
> +}

Same question as patch 3 -- I was under the impression that
iomap_clear_range_dirty would take a folio/off/len, and if an iop is
necessary, then it would call iomap_iop_clear_range_dirty with the
iop/folio/off/len?


> +
>  static struct iomap_page *iomap_iop_alloc(struct inode *inode,
>  				struct folio *folio, unsigned int flags)
>  {
> @@ -100,12 +157,20 @@ static struct iomap_page *iomap_iop_alloc(struct inode *inode,
>  	else
>  		gfp = GFP_NOFS | __GFP_NOFAIL;
> 
> -	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
> +	/*
> +	 * iop->state tracks two sets of state flags when the
> +	 * filesystem block size is smaller than the folio size.
> +	 * The first state tracks per-block uptodate and the
> +	 * second tracks per-block dirty state.
> +	 */
> +	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(2 * nr_blocks)),
>  		      gfp);
>  	if (iop) {
>  		spin_lock_init(&iop->state_lock);
>  		if (folio_test_uptodate(folio))
> -			bitmap_fill(iop->state, nr_blocks);
> +			bitmap_set(iop->state, 0, nr_blocks);
> +		if (folio_test_dirty(folio))
> +			bitmap_set(iop->state, nr_blocks, nr_blocks);
>  		folio_attach_private(folio, iop);
>  	}
>  	return iop;
> @@ -533,6 +598,17 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
>  }
>  EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
> 
> +bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
> +{
> +	struct inode *inode = mapping->host;
> +	size_t len = folio_size(folio);
> +
> +	iomap_iop_alloc(inode, folio, 0);

Why do we need to allocate an iop if there isn't already one?  Doesn't
it suffice to let filemap_dirty_folio even if there are multiple blocks
per folio?  I understand why __iomap_write_end would do that for a
sub-folio write, but not here where we always going to mark the whole
folio dirty...?

Oh, is it because everything else after this (write_end,
write_delalloc_punch, etc) might need to undo some of the work, hence
you want to have the iop allocated before we dirty the folio, no matter
which path lead to the folio getting dirtied?

> +	iomap_iop_set_range_dirty(inode, folio, 0, len);
> +	return filemap_dirty_folio(mapping, folio);
> +}
> +EXPORT_SYMBOL_GPL(iomap_dirty_folio);
> +
>  static void
>  iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
>  {
> @@ -739,6 +815,8 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  		return 0;
>  	iomap_iop_set_range_uptodate(inode, folio, offset_in_folio(folio, pos),
>  				     len);
> +	iomap_iop_set_range_dirty(inode, folio, offset_in_folio(folio, pos),
> +				  copied);

...and hence you don't want to be allocating it now?

--D

>  	filemap_dirty_folio(inode->i_mapping, folio);
>  	return copied;
>  }
> @@ -908,6 +986,10 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
>  		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
>  {
>  	int ret = 0;
> +	struct iomap_page *iop;
> +	unsigned int first_blk, last_blk, i;
> +	loff_t last_byte;
> +	u8 blkbits = inode->i_blkbits;
> 
>  	if (!folio_test_dirty(folio))
>  		return ret;
> @@ -919,6 +1001,29 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
>  		if (ret)
>  			goto out;
>  	}
> +	/*
> +	 * When we have per-block dirty tracking, there can be
> +	 * blocks within a folio which are marked uptodate
> +	 * but not dirty. In that case it is necessary to punch
> +	 * out such blocks to avoid leaking any delalloc blocks.
> +	 */
> +	iop = to_iomap_page(folio);
> +	if (!iop)
> +		goto skip_iop_punch;
> +
> +	last_byte = min_t(loff_t, end_byte - 1,
> +		(folio_next_index(folio) << PAGE_SHIFT) - 1);
> +	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
> +	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
> +	for (i = first_blk; i <= last_blk; i++) {
> +		if (!iop_test_block_dirty(folio, i)) {
> +			ret = punch(inode, i << blkbits, 1 << blkbits);
> +			if (ret)
> +				goto out;
> +		}
> +	}
> +
> +skip_iop_punch:
>  	/*
>  	 * Make sure the next punch start is correctly bound to
>  	 * the end of this data range, not the end of the folio.
> @@ -1652,7 +1757,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct inode *inode,
>  		struct folio *folio, u64 end_pos)
>  {
> -	struct iomap_page *iop = iomap_iop_alloc(inode, folio, 0);
> +	struct iomap_page *iop = to_iomap_page(folio);
>  	struct iomap_ioend *ioend, *next;
>  	unsigned len = i_blocksize(inode);
>  	unsigned nblocks = i_blocks_per_folio(inode, folio);
> @@ -1660,6 +1765,11 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	int error = 0, count = 0, i;
>  	LIST_HEAD(submit_list);
> 
> +	if (!iop && nblocks > 1) {
> +		iop = iomap_iop_alloc(inode, folio, 0);
> +		iomap_iop_set_range_dirty(inode, folio, 0, folio_size(folio));
> +	}
> +
>  	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
> 
>  	/*
> @@ -1668,7 +1778,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	 * invalid, grab a new one.
>  	 */
>  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
> -		if (iop && !iop_test_block_uptodate(folio, i))
> +		if (iop && !iop_test_block_dirty(folio, i))
>  			continue;
> 
>  		error = wpc->ops->map_blocks(wpc, inode, pos);
> @@ -1712,6 +1822,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		}
>  	}
> 
> +	iomap_iop_clear_range_dirty(inode, folio, 0,
> +				    end_pos - folio_pos(folio));
>  	folio_start_writeback(folio);
>  	folio_unlock(folio);
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 2ef78aa1d3f6..77c7332ae197 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -578,7 +578,7 @@ const struct address_space_operations xfs_address_space_operations = {
>  	.read_folio		= xfs_vm_read_folio,
>  	.readahead		= xfs_vm_readahead,
>  	.writepages		= xfs_vm_writepages,
> -	.dirty_folio		= filemap_dirty_folio,
> +	.dirty_folio		= iomap_dirty_folio,
>  	.release_folio		= iomap_release_folio,
>  	.invalidate_folio	= iomap_invalidate_folio,
>  	.bmap			= xfs_vm_bmap,
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index 132f01d3461f..e508c8e97372 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -175,7 +175,7 @@ const struct address_space_operations zonefs_file_aops = {
>  	.read_folio		= zonefs_read_folio,
>  	.readahead		= zonefs_readahead,
>  	.writepages		= zonefs_writepages,
> -	.dirty_folio		= filemap_dirty_folio,
> +	.dirty_folio		= iomap_dirty_folio,
>  	.release_folio		= iomap_release_folio,
>  	.invalidate_folio	= iomap_invalidate_folio,
>  	.migrate_folio		= filemap_migrate_folio,
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e2b836c2e119..eb9335c46bf3 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -264,6 +264,7 @@ bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
>  struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos);
>  bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
>  void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
> +bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
>  int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  		const struct iomap_ops *ops);
>  int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
> --
> 2.40.1
> 
