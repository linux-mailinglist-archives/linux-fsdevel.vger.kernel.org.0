Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91DE3E492B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 17:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbhHIPtk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 11:49:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56210 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbhHIPtX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:49:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D077720022;
        Mon,  9 Aug 2021 15:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628524141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nShYExk6p9cEBY4hXuufxKZqrnFOQJX51CklWsCj/kg=;
        b=ozKC+IgHT0V4PNkD7OInrVFt6gu/k5mNJvtNpcS+txlYyB8+LZoNitCR/ukbzjO3ADDRAW
        AQfuW0jsbZstxrHb2Lwj36XOqfHGCcEbotR7r42FwU9URyuackI4cF/t7oByXwuIKGg/Lb
        SDBjiW7v4zdaOSDuj2e1f6tv1P7oeoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628524141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nShYExk6p9cEBY4hXuufxKZqrnFOQJX51CklWsCj/kg=;
        b=1NK0siZFSB06zvrxzDffLwqTJ+WU7uJJLOoNOzSzn4j/c5PCuOm+i3kkp0X6Nr5qVcs5CU
        lAckwU9IPTDV5cDQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id C1EF2A3B81;
        Mon,  9 Aug 2021 15:49:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AA5C41E3BFC; Mon,  9 Aug 2021 17:49:01 +0200 (CEST)
Date:   Mon, 9 Aug 2021 17:49:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 5/5] block: remove the bd_bdi in struct block_device
Message-ID: <20210809154901.GI30319@quack2.suse.cz>
References: <20210809141744.1203023-1-hch@lst.de>
 <20210809141744.1203023-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809141744.1203023-6-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 09-08-21 16:17:44, Christoph Hellwig wrote:
> Just retrieve the bdi from the disk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/ioctl.c               |  7 ++++---
>  fs/block_dev.c              | 13 +------------
>  fs/nilfs2/super.c           |  2 +-
>  fs/super.c                  |  2 +-
>  fs/xfs/xfs_buf.c            |  2 +-
>  include/linux/backing-dev.h |  2 +-
>  include/linux/blk_types.h   |  1 -
>  7 files changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 0c3a4a53fa11..fff161eaab42 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -506,7 +506,7 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
>  	case BLKFRASET:
>  		if(!capable(CAP_SYS_ADMIN))
>  			return -EACCES;
> -		bdev->bd_bdi->ra_pages = (arg * 512) / PAGE_SIZE;
> +		bdev->bd_disk->bdi->ra_pages = (arg * 512) / PAGE_SIZE;
>  		return 0;
>  	case BLKRRPART:
>  		return blkdev_reread_part(bdev, mode);
> @@ -556,7 +556,8 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
>  	case BLKFRAGET:
>  		if (!argp)
>  			return -EINVAL;
> -		return put_long(argp, (bdev->bd_bdi->ra_pages*PAGE_SIZE) / 512);
> +		return put_long(argp,
> +			(bdev->bd_disk->bdi->ra_pages * PAGE_SIZE) / 512);
>  	case BLKGETSIZE:
>  		size = i_size_read(bdev->bd_inode);
>  		if ((size >> 9) > ~0UL)
> @@ -628,7 +629,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
>  		if (!argp)
>  			return -EINVAL;
>  		return compat_put_long(argp,
> -			       (bdev->bd_bdi->ra_pages * PAGE_SIZE) / 512);
> +			(bdev->bd_disk->bdi->ra_pages * PAGE_SIZE) / 512);
>  	case BLKGETSIZE:
>  		size = i_size_read(bdev->bd_inode);
>  		if ((size >> 9) > ~0UL)
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index de8c3d9cbdb1..65fc0efca26b 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -801,7 +801,6 @@ static struct inode *bdev_alloc_inode(struct super_block *sb)
>  	if (!ei)
>  		return NULL;
>  	memset(&ei->bdev, 0, sizeof(ei->bdev));
> -	ei->bdev.bd_bdi = &noop_backing_dev_info;
>  	return &ei->vfs_inode;
>  }
>  
> @@ -826,16 +825,11 @@ static void init_once(void *data)
>  
>  static void bdev_evict_inode(struct inode *inode)
>  {
> -	struct block_device *bdev = &BDEV_I(inode)->bdev;
>  	truncate_inode_pages_final(&inode->i_data);
>  	invalidate_inode_buffers(inode); /* is it needed here? */
>  	clear_inode(inode);
>  	/* Detach inode from wb early as bdi_put() may free bdi->wb */
>  	inode_detach_wb(inode);
> -	if (bdev->bd_bdi != &noop_backing_dev_info) {
> -		bdi_put(bdev->bd_bdi);
> -		bdev->bd_bdi = &noop_backing_dev_info;
> -	}
>  }
>  
>  static const struct super_operations bdev_sops = {
> @@ -1229,11 +1223,8 @@ static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
>  		}
>  	}
>  
> -	if (!bdev->bd_openers) {
> +	if (!bdev->bd_openers)
>  		set_init_blocksize(bdev);
> -		if (bdev->bd_bdi == &noop_backing_dev_info)
> -			bdev->bd_bdi = bdi_get(disk->bdi);
> -	}
>  	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
>  		bdev_disk_changed(disk, false);
>  	bdev->bd_openers++;
> @@ -1266,8 +1257,6 @@ static int blkdev_get_part(struct block_device *part, fmode_t mode)
>  
>  	disk->open_partitions++;
>  	set_init_blocksize(part);
> -	if (part->bd_bdi == &noop_backing_dev_info)
> -		part->bd_bdi = bdi_get(disk->bdi);
>  done:
>  	part->bd_openers++;
>  	return 0;
> diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
> index 4abd928b0bc8..f6b2d280aab5 100644
> --- a/fs/nilfs2/super.c
> +++ b/fs/nilfs2/super.c
> @@ -1053,7 +1053,7 @@ nilfs_fill_super(struct super_block *sb, void *data, int silent)
>  	sb->s_time_gran = 1;
>  	sb->s_max_links = NILFS_LINK_MAX;
>  
> -	sb->s_bdi = bdi_get(sb->s_bdev->bd_bdi);
> +	sb->s_bdi = bdi_get(sb->s_bdev->bd_disk->bdi);
>  
>  	err = load_nilfs(nilfs, sb);
>  	if (err)
> diff --git a/fs/super.c b/fs/super.c
> index 91b7f156735b..bcef3a6f4c4b 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1203,7 +1203,7 @@ static int set_bdev_super(struct super_block *s, void *data)
>  {
>  	s->s_bdev = data;
>  	s->s_dev = s->s_bdev->bd_dev;
> -	s->s_bdi = bdi_get(s->s_bdev->bd_bdi);
> +	s->s_bdi = bdi_get(s->s_bdev->bd_disk->bdi);
>  
>  	if (blk_queue_stable_writes(s->s_bdev->bd_disk->queue))
>  		s->s_iflags |= SB_I_STABLE_WRITES;
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 8ff42b3585e0..3ab73567a0f5 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -844,7 +844,7 @@ xfs_buf_readahead_map(
>  {
>  	struct xfs_buf		*bp;
>  
> -	if (bdi_read_congested(target->bt_bdev->bd_bdi))
> +	if (bdi_read_congested(target->bt_bdev->bd_disk->bdi))
>  		return;
>  
>  	xfs_buf_read_map(target, map, nmaps,
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 44df4fcef65c..29530859d9ff 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -143,7 +143,7 @@ static inline struct backing_dev_info *inode_to_bdi(struct inode *inode)
>  	sb = inode->i_sb;
>  #ifdef CONFIG_BLOCK
>  	if (sb_is_blkdev_sb(sb))
> -		return I_BDEV(inode)->bd_bdi;
> +		return I_BDEV(inode)->bd_disk->bdi;
>  #endif
>  	return sb->s_bdi;
>  }
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 290f9061b29a..a6c015cedaf7 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -41,7 +41,6 @@ struct block_device {
>  	u8			bd_partno;
>  	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
>  	struct gendisk *	bd_disk;
> -	struct backing_dev_info *bd_bdi;
>  
>  	/* The counter of freeze processes */
>  	int			bd_fsfreeze_count;
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
