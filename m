Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8FA72473E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 17:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbjFFPGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 11:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbjFFPGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:06:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9535290;
        Tue,  6 Jun 2023 08:06:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21CE162D8D;
        Tue,  6 Jun 2023 15:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7222AC433D2;
        Tue,  6 Jun 2023 15:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686063997;
        bh=I0OjnQHJQRMo1zVA9+lCXwR0ERqKYpDUqeaksT2bcIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LOjnyJFGzls8OvOLX1K9p5OMjDay6ZHR0C6QEb1t5f82BxE7tIEvOkAtK3jWtH28B
         2fjMGqjEbcFu4mhmK40V5hIrEAhHVs+mZk79LzDub9GeKP4KJTko8WfpdrCUsJq2L7
         qtqWm062dhBqVUGP6nN+2oHXfVjaPTaQVfDJ+pvTvWTGrXQ4OVT/WZz459zSlgHxoO
         ngzlnG7S+a6zzd2A+0g8ydrF8VX8+Qf05LfgO7Z1Leyl1dKXXmWNmSXdjdsfUOax+U
         jk5Lse5c9aUrulOMg6BbUi2W6cveflMNQVNsVvwUbMQdjIxmYwg7BwQamDIsfDXlJU
         WZcWGmh+OM8wA==
Date:   Tue, 6 Jun 2023 08:06:36 -0700
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
Subject: Re: [PATCHv8 5/5] iomap: Add per-block dirty state tracking to
 improve performance
Message-ID: <20230606150636.GL1325469@frogsfrogsfrogs>
References: <cover.1686050333.git.ritesh.list@gmail.com>
 <0c3108f6ea45e18c7aae87c2fb3d8fa3311c13a4.1686050333.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c3108f6ea45e18c7aae87c2fb3d8fa3311c13a4.1686050333.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 05:13:52PM +0530, Ritesh Harjani (IBM) wrote:
> When filesystem blocksize is less than folio size (either with
> mapping_large_folio_support() or with blocksize < pagesize) and when the
> folio is uptodate in pagecache, then even a byte write can cause
> an entire folio to be written to disk during writeback. This happens
> because we currently don't have a mechanism to track per-block dirty
> state within struct iomap_folio. We currently only track uptodate state.
> 
> This patch implements support for tracking per-block dirty state in
> iomap_folio->state bitmap. This should help improve the filesystem write
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
>  fs/iomap/buffered-io.c | 126 +++++++++++++++++++++++++++++++++++++++--
>  fs/xfs/xfs_aops.c      |   2 +-
>  fs/zonefs/file.c       |   2 +-
>  include/linux/iomap.h  |   1 +
>  5 files changed, 126 insertions(+), 7 deletions(-)
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
> index 2b72ca3ba37a..b99d611f1cd5 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -84,6 +84,70 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
>  		folio_mark_uptodate(folio);
>  }
>  
> +static inline bool iomap_iof_is_block_dirty(struct folio *folio,
> +			struct iomap_folio *iof, int block)
> +{
> +	struct inode *inode = folio->mapping->host;
> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> +
> +	return test_bit(block + blks_per_folio, iof->state);
> +}
> +
> +static void iomap_iof_clear_range_dirty(struct folio *folio,
> +			struct iomap_folio *iof, size_t off, size_t len)
> +{
> +	struct inode *inode = folio->mapping->host;
> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> +	unsigned int first_blk = off >> inode->i_blkbits;
> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
> +	unsigned int nr_blks = last_blk - first_blk + 1;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iof->state_lock, flags);
> +	bitmap_clear(iof->state, first_blk + blks_per_folio, nr_blks);
> +	spin_unlock_irqrestore(&iof->state_lock, flags);
> +}
> +
> +static void iomap_clear_range_dirty(struct folio *folio, size_t off, size_t len)
> +{
> +	struct iomap_folio *iof = iomap_get_iof(folio);
> +
> +	if (!iof)
> +		return;
> +	iomap_iof_clear_range_dirty(folio, iof, off, len);
> +}
> +
> +static void iomap_iof_set_range_dirty(struct inode *inode, struct folio *folio,
> +			struct iomap_folio *iof, size_t off, size_t len)
> +{
> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> +	unsigned int first_blk = off >> inode->i_blkbits;
> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
> +	unsigned int nr_blks = last_blk - first_blk + 1;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iof->state_lock, flags);
> +	bitmap_set(iof->state, first_blk + blks_per_folio, nr_blks);
> +	spin_unlock_irqrestore(&iof->state_lock, flags);
> +}
> +
> +/*
> + * The reason we pass inode explicitly here is to avoid any race with truncate
> + * when iomap_set_range_dirty() gets called from iomap_dirty_folio().
> + * Check filemap_dirty_folio() & __folio_mark_dirty() for more details.
> + * Hence we explicitly pass mapping->host to iomap_set_range_dirty() from
> + * iomap_dirty_folio().
> + */
> +static void iomap_set_range_dirty(struct inode *inode, struct folio *folio,
> +				  size_t off, size_t len)
> +{
> +	struct iomap_folio *iof = iomap_get_iof(folio);
> +
> +	if (!iof)
> +		return;
> +	iomap_iof_set_range_dirty(inode, folio, iof, off, len);
> +}
> +
>  static struct iomap_folio *iomap_iof_alloc(struct inode *inode,
>  				struct folio *folio, unsigned int flags)
>  {
> @@ -99,12 +163,20 @@ static struct iomap_folio *iomap_iof_alloc(struct inode *inode,
>  	else
>  		gfp = GFP_NOFS | __GFP_NOFAIL;
>  
> -	iof = kzalloc(struct_size(iof, state, BITS_TO_LONGS(nr_blocks)),
> +	/*
> +	 * iof->state tracks two sets of state flags when the
> +	 * filesystem block size is smaller than the folio size.
> +	 * The first state tracks per-block uptodate and the
> +	 * second tracks per-block dirty state.
> +	 */
> +	iof = kzalloc(struct_size(iof, state, BITS_TO_LONGS(2 * nr_blocks)),
>  		      gfp);
>  	if (iof) {
>  		spin_lock_init(&iof->state_lock);
>  		if (folio_test_uptodate(folio))
> -			bitmap_fill(iof->state, nr_blocks);
> +			bitmap_set(iof->state, 0, nr_blocks);
> +		if (folio_test_dirty(folio))
> +			bitmap_set(iof->state, nr_blocks, nr_blocks);
>  		folio_attach_private(folio, iof);
>  	}
>  	return iof;
> @@ -529,6 +601,17 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
>  }
>  EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
>  
> +bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
> +{
> +	struct inode *inode = mapping->host;
> +	size_t len = folio_size(folio);
> +
> +	iomap_iof_alloc(inode, folio, 0);
> +	iomap_set_range_dirty(inode, folio, 0, len);
> +	return filemap_dirty_folio(mapping, folio);
> +}
> +EXPORT_SYMBOL_GPL(iomap_dirty_folio);
> +
>  static void
>  iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
>  {
> @@ -733,6 +816,8 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  	if (unlikely(copied < len && !folio_test_uptodate(folio)))
>  		return 0;
>  	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
> +	iomap_set_range_dirty(inode, folio, offset_in_folio(folio, pos),
> +			      copied);
>  	filemap_dirty_folio(inode->i_mapping, folio);
>  	return copied;
>  }
> @@ -902,6 +987,10 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
>  		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
>  {
>  	int ret = 0;
> +	struct iomap_folio *iof;
> +	unsigned int first_blk, last_blk, i;
> +	loff_t last_byte;
> +	u8 blkbits = inode->i_blkbits;
>  
>  	if (!folio_test_dirty(folio))
>  		return ret;
> @@ -913,6 +1002,29 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
>  		if (ret)
>  			goto out;
>  	}
> +	/*
> +	 * When we have per-block dirty tracking, there can be
> +	 * blocks within a folio which are marked uptodate
> +	 * but not dirty. In that case it is necessary to punch
> +	 * out such blocks to avoid leaking any delalloc blocks.
> +	 */
> +	iof = iomap_get_iof(folio);
> +	if (!iof)
> +		goto skip_iof_punch;
> +
> +	last_byte = min_t(loff_t, end_byte - 1,
> +		(folio_next_index(folio) << PAGE_SHIFT) - 1);
> +	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
> +	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
> +	for (i = first_blk; i <= last_blk; i++) {
> +		if (!iomap_iof_is_block_dirty(folio, iof, i)) {
> +			ret = punch(inode, i << blkbits, 1 << blkbits);

Isn't the second argument to punch() supposed to be the offset within
the file, not the offset within the folio?

I /almost/ wonder if this chunk should be its own static inline
iomap_iof_delalloc_punch function, but ... eh.  My enthusiasm for
slicing and dicing is weak today.

--D

> +			if (ret)
> +				goto out;
> +		}
> +	}
> +
> +skip_iof_punch:
>  	/*
>  	 * Make sure the next punch start is correctly bound to
>  	 * the end of this data range, not the end of the folio.
> @@ -1646,7 +1758,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct inode *inode,
>  		struct folio *folio, u64 end_pos)
>  {
> -	struct iomap_folio *iof = iomap_iof_alloc(inode, folio, 0);
> +	struct iomap_folio *iof = iomap_get_iof(folio);
>  	struct iomap_ioend *ioend, *next;
>  	unsigned len = i_blocksize(inode);
>  	unsigned nblocks = i_blocks_per_folio(inode, folio);
> @@ -1654,6 +1766,11 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	int error = 0, count = 0, i;
>  	LIST_HEAD(submit_list);
>  
> +	if (!iof && nblocks > 1) {
> +		iof = iomap_iof_alloc(inode, folio, 0);
> +		iomap_set_range_dirty(inode, folio, 0, folio_size(folio));
> +	}
> +
>  	WARN_ON_ONCE(iof && atomic_read(&iof->write_bytes_pending) != 0);
>  
>  	/*
> @@ -1662,7 +1779,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	 * invalid, grab a new one.
>  	 */
>  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
> -		if (iof && !iomap_iof_is_block_uptodate(iof, i))
> +		if (iof && !iomap_iof_is_block_dirty(folio, iof, i))
>  			continue;
>  
>  		error = wpc->ops->map_blocks(wpc, inode, pos);
> @@ -1706,6 +1823,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		}
>  	}
>  
> +	iomap_clear_range_dirty(folio, 0, end_pos - folio_pos(folio));
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
