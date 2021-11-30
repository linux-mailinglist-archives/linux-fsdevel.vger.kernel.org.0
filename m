Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4375463E66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 20:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241880AbhK3TIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 14:08:01 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:51318 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbhK3TH7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:07:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4610FCE1AF9;
        Tue, 30 Nov 2021 19:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F987C53FCC;
        Tue, 30 Nov 2021 19:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638299076;
        bh=mQg/Xy3banuO+Rk+JPTNee2e65LywjYy6rs1vF6txoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L5JZsAvE5JXRi6i0ytDaiv8XEIiGmSUHffxXM2lVjE3cZl6vH3y9jXNBuuEgb/EBL
         5+o+FTmz4QbXrBx0biR8u71+VJQySnsli75C2MCm+gggq95Xv8av1CWzP0PdvQsrrh
         OGUebXf/i+s2rF6vnp6ZbvtWYeQhRRQLw+k0WFb6H661tkagirCnj3h1WvMJmK/gK8
         vAxfEf57+wxndxXVB/gzynn30JNix53lAAx56QL6NSVBBdrvBH35bIon6zF3Fd2A6O
         xCSn21p158TknyuDd+2O6eyvWpiGmX8tNHo7n6gp1lWtXK9SR11kwFUFg/T5qAW7Wd
         RLMCxUdBZSR0Q==
Date:   Tue, 30 Nov 2021 11:04:36 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 25/29] dax: return the partition offset from
 fs_dax_get_by_bdev
Message-ID: <20211130190436.GI8467@magnolia>
References: <20211129102203.2243509-1-hch@lst.de>
 <20211129102203.2243509-26-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129102203.2243509-26-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 29, 2021 at 11:21:59AM +0100, Christoph Hellwig wrote:
> Prepare for the removal of the block_device from the DAX I/O path by
> returning the partition offset from fs_dax_get_by_bdev so that the file
> systems have it at hand for use during I/O.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  drivers/dax/super.c | 9 ++++++---
>  drivers/md/dm.c     | 4 ++--
>  fs/erofs/internal.h | 2 ++
>  fs/erofs/super.c    | 4 ++--
>  fs/ext2/ext2.h      | 1 +
>  fs/ext2/super.c     | 2 +-
>  fs/ext4/ext4.h      | 1 +
>  fs/ext4/super.c     | 2 +-
>  fs/xfs/xfs_buf.c    | 2 +-
>  fs/xfs/xfs_buf.h    | 1 +
>  include/linux/dax.h | 6 ++++--
>  11 files changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 45d931aefd063..e7152a6c4cc40 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -69,17 +69,20 @@ EXPORT_SYMBOL_GPL(dax_remove_host);
>  /**
>   * fs_dax_get_by_bdev() - temporary lookup mechanism for filesystem-dax
>   * @bdev: block device to find a dax_device for
> + * @start_off: returns the byte offset into the dax_device that @bdev starts
>   */
> -struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
> +struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev, u64 *start_off)
>  {
>  	struct dax_device *dax_dev;
> +	u64 part_size;
>  	int id;
>  
>  	if (!blk_queue_dax(bdev->bd_disk->queue))
>  		return NULL;
>  
> -	if ((get_start_sect(bdev) * SECTOR_SIZE) % PAGE_SIZE ||
> -	    (bdev_nr_sectors(bdev) * SECTOR_SIZE) % PAGE_SIZE) {
> +	*start_off = get_start_sect(bdev) * SECTOR_SIZE;
> +	part_size = bdev_nr_sectors(bdev) * SECTOR_SIZE;
> +	if (*start_off % PAGE_SIZE || part_size % PAGE_SIZE) {
>  		pr_info("%pg: error: unaligned partition for dax\n", bdev);
>  		return NULL;
>  	}
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 4eba27e75c230..4e997c02bb0a0 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -637,7 +637,7 @@ static int open_table_device(struct table_device *td, dev_t dev,
>  			     struct mapped_device *md)
>  {
>  	struct block_device *bdev;
> -
> +	u64 part_off;
>  	int r;
>  
>  	BUG_ON(td->dm_dev.bdev);
> @@ -653,7 +653,7 @@ static int open_table_device(struct table_device *td, dev_t dev,
>  	}
>  
>  	td->dm_dev.bdev = bdev;
> -	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev);
> +	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev, &part_off);
>  	return 0;
>  }
>  
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 3265688af7f9f..c1e65346e9f15 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -51,6 +51,7 @@ struct erofs_device_info {
>  	char *path;
>  	struct block_device *bdev;
>  	struct dax_device *dax_dev;
> +	u64 dax_part_off;
>  
>  	u32 blocks;
>  	u32 mapped_blkaddr;
> @@ -109,6 +110,7 @@ struct erofs_sb_info {
>  #endif	/* CONFIG_EROFS_FS_ZIP */
>  	struct erofs_dev_context *devs;
>  	struct dax_device *dax_dev;
> +	u64 dax_part_off;
>  	u64 total_blocks;
>  	u32 primarydevice_blocks;
>  
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0aed886473c8d..71efce16024d9 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -312,7 +312,7 @@ static int erofs_init_devices(struct super_block *sb,
>  			goto err_out;
>  		}
>  		dif->bdev = bdev;
> -		dif->dax_dev = fs_dax_get_by_bdev(bdev);
> +		dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off);
>  		dif->blocks = le32_to_cpu(dis->blocks);
>  		dif->mapped_blkaddr = le32_to_cpu(dis->mapped_blkaddr);
>  		sbi->total_blocks += dif->blocks;
> @@ -644,7 +644,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	sb->s_fs_info = sbi;
>  	sbi->opt = ctx->opt;
> -	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
> +	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->dax_part_off);
>  	sbi->devs = ctx->devs;
>  	ctx->devs = NULL;
>  
> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> index 3be9dd6412b78..d4f306aa5aceb 100644
> --- a/fs/ext2/ext2.h
> +++ b/fs/ext2/ext2.h
> @@ -118,6 +118,7 @@ struct ext2_sb_info {
>  	spinlock_t s_lock;
>  	struct mb_cache *s_ea_block_cache;
>  	struct dax_device *s_daxdev;
> +	u64 s_dax_part_off;
>  };
>  
>  static inline spinlock_t *
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 7e23482862e69..94f1fbd7d3ac2 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -831,7 +831,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  	}
>  	sb->s_fs_info = sbi;
>  	sbi->s_sb_block = sb_block;
> -	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev);
> +	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off);
>  
>  	spin_lock_init(&sbi->s_lock);
>  	ret = -EINVAL;
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 404dd50856e5d..9cc55bcda6ba4 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1697,6 +1697,7 @@ struct ext4_sb_info {
>  	 */
>  	struct percpu_rw_semaphore s_writepages_rwsem;
>  	struct dax_device *s_daxdev;
> +	u64 s_dax_part_off;
>  #ifdef CONFIG_EXT4_DEBUG
>  	unsigned long s_simulate_fail;
>  #endif
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 8d7e3449c6472..56228e33e52a2 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3913,7 +3913,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  	if (!sbi->s_blockgroup_lock)
>  		goto out_free_base;
>  
> -	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev);
> +	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off);
>  	sb->s_fs_info = sbi;
>  	sbi->s_sb = sb;
>  	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 4d4553ffa7050..bbb0fbd34e649 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1945,7 +1945,7 @@ xfs_alloc_buftarg(
>  	btp->bt_mount = mp;
>  	btp->bt_dev =  bdev->bd_dev;
>  	btp->bt_bdev = bdev;
> -	btp->bt_daxdev = fs_dax_get_by_bdev(bdev);
> +	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off);
>  
>  	/*
>  	 * Buffer IO error rate limiting. Limit it to no more than 10 messages
> diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
> index bd7f709f0d232..edcb6254fa6a8 100644
> --- a/fs/xfs/xfs_buf.h
> +++ b/fs/xfs/xfs_buf.h
> @@ -89,6 +89,7 @@ typedef struct xfs_buftarg {
>  	dev_t			bt_dev;
>  	struct block_device	*bt_bdev;
>  	struct dax_device	*bt_daxdev;
> +	u64			bt_dax_part_off;
>  	struct xfs_mount	*bt_mount;
>  	unsigned int		bt_meta_sectorsize;
>  	size_t			bt_meta_sectormask;
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index b79036743e7fa..f6f353382cc90 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -117,7 +117,8 @@ static inline void fs_put_dax(struct dax_device *dax_dev)
>  	put_dax(dax_dev);
>  }
>  
> -struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev);
> +struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
> +		u64 *start_off);
>  int dax_writeback_mapping_range(struct address_space *mapping,
>  		struct dax_device *dax_dev, struct writeback_control *wbc);
>  
> @@ -138,7 +139,8 @@ static inline void fs_put_dax(struct dax_device *dax_dev)
>  {
>  }
>  
> -static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
> +static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
> +		u64 *start_off)
>  {
>  	return NULL;
>  }
> -- 
> 2.30.2
> 
