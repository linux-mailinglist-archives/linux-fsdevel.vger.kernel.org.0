Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B2F11C9DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 10:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfLLJtk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 04:49:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbfLLJtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O3xinI1kamjpKJJzMpyW5CEk6wAOZJqBOx1CkHZvbUc=; b=B1KP5Ztxcp7hIojNtXhxAm/dM
        5bdYC1R0Hu8UJU2Awb7q0EHTAnogIEQ2TAtrXKAMUd65Jm4h1/nMMlJKa7+Tz+sjuQANRdLNx4bBS
        Z/oVCPq2QCHtSdDxe84nUhG/fnlLAex6NNgfG3AGOHwoX0r9E2Gw/6aqLwrmMLBgUBROKygoU0Laz
        JUmKVhfYJ9b0k7HgpH7v0LQdNwAG+PtvJmXTwUdb3ya8HffwiigHm7I7LjONPVSEE44Med5SBwxik
        Apa8t9s1qn4XLXlWd6p0uwyZXZ75QMfXr9AhIAt+W1bdLcGPa/VssSo8z++usS3uLfQsuKga3SdN5
        ku3DU0Bwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifL6K-0004XT-1Y; Thu, 12 Dec 2019 09:49:40 +0000
Date:   Thu, 12 Dec 2019 01:49:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com, fdmanana@kernel.org,
        dsterba@suse.cz, jthumshirn@suse.de, nborisov@suse.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/8] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20191212094940.GC15977@infradead.org>
References: <20191212003043.31093-1-rgoldwyn@suse.de>
 <20191212003043.31093-4-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212003043.31093-4-rgoldwyn@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 06:30:38PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Switch from __blockdev_direct_IO() to iomap_dio_rw().
> Rename btrfs_get_blocks_direct() to btrfs_dio_iomap_begin() and use it
> as iomap_begin() for iomap direct I/O functions. This function
> allocates and locks all the blocks required for the I/O.
> btrfs_submit_direct() is used as the submit_io() hook for direct I/O
> ops.
> 
> Since we need direct I/O reads to go through iomap_dio_rw(), we change
> file_operations.read_iter() to a btrfs_file_read_iter() which calls
> btrfs_direct_IO() for direct reads and falls back to
> generic_file_buffered_read() for incomplete reads and buffered reads.
> 
> We don't need address_space.direct_IO() anymore so set it to noop.
> Similarly, we don't need flags used in __blockdev_direct_IO(). iomap is
> capable of direct I/O reads from a hole, so we don't need to return
> -ENOENT.
> 
> BTRFS direct I/O is now done under i_rwsem, shared in case of
> reads and exclusive in case of writes. This guards against simultaneous
> truncates.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/ctree.h |   1 +
>  fs/btrfs/file.c  |  21 +++++-
>  fs/btrfs/inode.c | 190 ++++++++++++++++++++++++++-----------------------------
>  3 files changed, 109 insertions(+), 103 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b2e8fd8a8e59..113dcd1a11cd 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2904,6 +2904,7 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
>  void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
>  					  u64 end, int uptodate);
>  extern const struct dentry_operations btrfs_dentry_operations;
> +ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
>  
>  /* ioctl.c */
>  long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 0cb43b682789..7010dd7beccc 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1832,7 +1832,7 @@ static ssize_t __btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  	loff_t endbyte;
>  	int err;
>  
> -	written = generic_file_direct_write(iocb, from);
> +	written = btrfs_direct_IO(iocb, from);
>  
>  	if (written < 0 || !iov_iter_count(from))
>  		return written;
> @@ -3444,9 +3444,26 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
>  	return generic_file_open(inode, filp);
>  }
>  
> +static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	ssize_t ret = 0;
> +
> +	if (iocb->ki_flags & IOCB_DIRECT) {
> +		struct inode *inode = file_inode(iocb->ki_filp);
> +
> +		inode_lock_shared(inode);
> +		ret = btrfs_direct_IO(iocb, to);
> +		inode_unlock_shared(inode);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return generic_file_buffered_read(iocb, to, ret);
> +}
> +
>  const struct file_operations btrfs_file_operations = {
>  	.llseek		= btrfs_file_llseek,
> -	.read_iter      = generic_file_read_iter,
> +	.read_iter      = btrfs_file_read_iter,
>  	.splice_read	= generic_file_splice_read,
>  	.write_iter	= btrfs_file_write_iter,
>  	.mmap		= btrfs_file_mmap,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 56032c518b26..91b830022146 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -29,6 +29,7 @@
>  #include <linux/iversion.h>
>  #include <linux/swap.h>
>  #include <linux/sched/mm.h>
> +#include <linux/iomap.h>
>  #include <asm/unaligned.h>
>  #include "misc.h"
>  #include "ctree.h"
> @@ -7510,7 +7511,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
>  }
>  
>  static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
> -			      struct extent_state **cached_state, int writing)
> +			      struct extent_state **cached_state, bool writing)
>  {
>  	struct btrfs_ordered_extent *ordered;
>  	int ret = 0;
> @@ -7648,30 +7649,7 @@ static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
>  }
>  
>  
> -static int btrfs_get_blocks_direct_read(struct extent_map *em,
> -					struct buffer_head *bh_result,
> -					struct inode *inode,
> -					u64 start, u64 len)
> -{
> -	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> -
> -	if (em->block_start == EXTENT_MAP_HOLE ||
> -			test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
> -		return -ENOENT;
> -
> -	len = min(len, em->len - (start - em->start));
> -
> -	bh_result->b_blocknr = (em->block_start + (start - em->start)) >>
> -		inode->i_blkbits;
> -	bh_result->b_size = len;
> -	bh_result->b_bdev = fs_info->fs_devices->latest_bdev;
> -	set_buffer_mapped(bh_result);
> -
> -	return 0;
> -}
> -
>  static int btrfs_get_blocks_direct_write(struct extent_map **map,
> -					 struct buffer_head *bh_result,
>  					 struct inode *inode,
>  					 struct btrfs_dio_data *dio_data,
>  					 u64 start, u64 len)
> @@ -7733,7 +7711,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
>  	}
>  
>  	/* this will cow the extent */
> -	len = bh_result->b_size;
>  	free_extent_map(em);
>  	*map = em = btrfs_new_extent_direct(inode, start, len);
>  	if (IS_ERR(em)) {
> @@ -7744,15 +7721,6 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
>  	len = min(len, em->len - (start - em->start));
>  
>  skip_cow:
> -	bh_result->b_blocknr = (em->block_start + (start - em->start)) >>
> -		inode->i_blkbits;
> -	bh_result->b_size = len;
> -	bh_result->b_bdev = fs_info->fs_devices->latest_bdev;
> -	set_buffer_mapped(bh_result);
> -
> -	if (!test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
> -		set_buffer_new(bh_result);
> -
>  	/*
>  	 * Need to update the i_size under the extent lock so buffered
>  	 * readers will get the updated i_size when we unlock.
> @@ -7768,24 +7736,37 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
>  	return ret;
>  }
>  
> -static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
> -				   struct buffer_head *bh_result, int create)
> +static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
> +		loff_t length, unsigned flags, struct iomap *iomap,
> +		struct iomap *srcmap)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct extent_map *em;
>  	struct extent_state *cached_state = NULL;
>  	struct btrfs_dio_data *dio_data = NULL;
> -	u64 start = iblock << inode->i_blkbits;
>  	u64 lockstart, lockend;
> -	u64 len = bh_result->b_size;
> +	bool write = !!(flags & IOMAP_WRITE);
>  	int ret = 0;
> +	u64 len = length;
> +	bool unlock_extents = false;
>  
> -	if (!create)
> +	if (!write)
>  		len = min_t(u64, len, fs_info->sectorsize);
>  
>  	lockstart = start;
>  	lockend = start + len - 1;
>  
> +	/*
> +	 * The generic stuff only does filemap_write_and_wait_range, which
> +	 * isn't enough if we've written compressed pages to this area, so
> +	 * we need to flush the dirty pages again to make absolutely sure
> +	 * that any outstanding dirty pages are on disk.
> +	 */
> +	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
> +		     &BTRFS_I(inode)->runtime_flags))
> +		ret = filemap_fdatawrite_range(inode->i_mapping, start,
> +					 start + length - 1);
> +
>  	if (current->journal_info) {
>  		/*
>  		 * Need to pull our outstanding extents and set journal_info to NULL so
> @@ -7801,7 +7782,7 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
>  	 * this range and we need to fallback to buffered.
>  	 */
>  	if (lock_extent_direct(inode, lockstart, lockend, &cached_state,
> -			       create)) {
> +			       write)) {
>  		ret = -ENOTBLK;
>  		goto err;
>  	}
> @@ -7833,35 +7814,52 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
>  		goto unlock_err;
>  	}
>  
> -	if (create) {
> -		ret = btrfs_get_blocks_direct_write(&em, bh_result, inode,
> +	len = min(len, em->len - (start - em->start));
> +	if (write) {
> +		ret = btrfs_get_blocks_direct_write(&em, inode,
>  						    dio_data, start, len);
>  		if (ret < 0)
>  			goto unlock_err;
> -
> -		unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart,
> -				     lockend, &cached_state);
> +		unlock_extents = true;
> +		/* Recalc len in case the new em is smaller than requested */
> +		len = min(len, em->len - (start - em->start));
> +	} else if (em->block_start == EXTENT_MAP_HOLE ||
> +			test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
> +		/* Unlock in case of direct reading from a hole */
> +		unlock_extents = true;
>  	} else {
> -		ret = btrfs_get_blocks_direct_read(em, bh_result, inode,
> -						   start, len);
> -		/* Can be negative only if we read from a hole */
> -		if (ret < 0) {
> -			ret = 0;
> -			free_extent_map(em);
> -			goto unlock_err;
> -		}
>  		/*
>  		 * We need to unlock only the end area that we aren't using.
>  		 * The rest is going to be unlocked by the endio routine.
>  		 */
> -		lockstart = start + bh_result->b_size;
> -		if (lockstart < lockend) {
> -			unlock_extent_cached(&BTRFS_I(inode)->io_tree,
> -					     lockstart, lockend, &cached_state);
> -		} else {
> -			free_extent_state(cached_state);
> -		}
> +		lockstart = start + len;
> +		if (lockstart < lockend)
> +			unlock_extents = true;
> +	}
> +
> +	if (unlock_extents)
> +		unlock_extent_cached(&BTRFS_I(inode)->io_tree,
> +				lockstart, lockend, &cached_state);
> +	else
> +		free_extent_state(cached_state);
> +
> +	/*
> +	 * Translate extent map information to iomap
> +	 * We trim the extents (and move the addr) even though
> +	 * iomap code does that, since we have locked only the parts
> +	 * we are performing I/O in.
> +	 */
> +	if ((em->block_start == EXTENT_MAP_HOLE) ||
> +	    (test_bit(EXTENT_FLAG_PREALLOC, &em->flags) && !write)) {
> +		iomap->addr = IOMAP_NULL_ADDR;
> +		iomap->type = IOMAP_HOLE;
> +	} else {
> +		iomap->addr = em->block_start + (start - em->start);
> +		iomap->type = IOMAP_MAPPED;
>  	}
> +	iomap->offset = start;
> +	iomap->bdev = fs_info->fs_devices->latest_bdev;
> +	iomap->length = len;
>  
>  	free_extent_map(em);
>  
> @@ -8230,9 +8228,8 @@ static void btrfs_endio_direct_read(struct bio *bio)
>  	kfree(dip);
>  
>  	dio_bio->bi_status = err;
> -	dio_end_io(dio_bio);
> +	bio_endio(dio_bio);
>  	btrfs_io_bio_free_csum(io_bio);
> -	bio_put(bio);

I'm not a btrfs export, but doesn't this introduce a use after free
as bio_endio also frees io_bio?
