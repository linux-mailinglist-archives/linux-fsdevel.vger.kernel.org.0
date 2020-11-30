Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159E12C8BDE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 18:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387731AbgK3R4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 12:56:44 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:32774 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387518AbgK3R4o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:56:44 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUHt6sJ032368;
        Mon, 30 Nov 2020 17:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=yU/s1Wkvr4/ioNoOs3LBBcInryfxg69nAE5giYmsDtI=;
 b=BrK4tMKOyzxrwpzYTlNpbblVdyLj99rOklmu5b7G3fLXIWb2oNqMQu74n9tgiYZwSkBI
 q8IW2lAJ5A6imO7tAcmjiauSeYKxYgvojWgmqUb+glplMcsSBpQB/nymMvV9krD+mvOx
 DJ6IExm9EXZp2F4lOGfprRJVEjVxzJHYcSqaNjkbyM3Wnz0FCyTZBf6e1ZkXGRMOrel5
 iTClNF3xexyfxuNMgiBvvTscsy1ludxN/bcAKiqWKZHalWlxEqVF8X/LXFrIQD7ENvWF
 7khVBK6sKTyMNkKp2BlgN/EPcZ+SSXaDxEH2cewbxY+orjH/5z/Hz13U2jTrI6mOMPxb Ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 353c2apjs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 17:55:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUHk2nh011017;
        Mon, 30 Nov 2020 17:55:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3540ewv77j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 17:55:34 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AUHtSUK012345;
        Mon, 30 Nov 2020 17:55:28 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Nov 2020 09:55:28 -0800
Date:   Mon, 30 Nov 2020 09:55:26 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 04/45] fs: simplify freeze_bdev/thaw_bdev
Message-ID: <20201130175526.GA143012@magnolia>
References: <20201128161510.347752-1-hch@lst.de>
 <20201128161510.347752-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128161510.347752-5-hch@lst.de>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=1 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011300116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 lowpriorityscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011300117
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 28, 2020 at 05:14:29PM +0100, Christoph Hellwig wrote:
> Store the frozen superblock in struct block_device to avoid the awkward
> interface that can return a sb only used a cookie, an ERR_PTR or NULL.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: Chao Yu <yuchao0@huawei.com>		[f2fs]
> ---
>  drivers/md/dm-core.h      |  5 -----
>  drivers/md/dm.c           | 20 ++++++--------------
>  fs/block_dev.c            | 37 +++++++++++++++----------------------
>  fs/buffer.c               |  2 +-
>  fs/ext4/ioctl.c           |  2 +-
>  fs/f2fs/file.c            | 14 +++++---------
>  fs/xfs/xfs_fsops.c        |  7 ++-----

For the xfs part:
Acked-by: Darrick J. Wong <darrick.wong@oracle.com>

(I did glance at the other 44 patches and didn't see anything that
screamed 'wrong' but I wouldn't call that a strong review...)

--D

>  include/linux/blk_types.h |  1 +
>  include/linux/blkdev.h    |  4 ++--
>  9 files changed, 33 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> index d522093cb39dda..aace147effcacb 100644
> --- a/drivers/md/dm-core.h
> +++ b/drivers/md/dm-core.h
> @@ -96,11 +96,6 @@ struct mapped_device {
>  	 */
>  	struct workqueue_struct *wq;
>  
> -	/*
> -	 * freeze/thaw support require holding onto a super block
> -	 */
> -	struct super_block *frozen_sb;
> -
>  	/* forced geometry settings */
>  	struct hd_geometry geometry;
>  
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 54739f1b579bc8..50541d336c719b 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -2392,27 +2392,19 @@ static int lock_fs(struct mapped_device *md)
>  {
>  	int r;
>  
> -	WARN_ON(md->frozen_sb);
> +	WARN_ON(test_bit(DMF_FROZEN, &md->flags));
>  
> -	md->frozen_sb = freeze_bdev(md->bdev);
> -	if (IS_ERR(md->frozen_sb)) {
> -		r = PTR_ERR(md->frozen_sb);
> -		md->frozen_sb = NULL;
> -		return r;
> -	}
> -
> -	set_bit(DMF_FROZEN, &md->flags);
> -
> -	return 0;
> +	r = freeze_bdev(md->bdev);
> +	if (!r)
> +		set_bit(DMF_FROZEN, &md->flags);
> +	return r;
>  }
>  
>  static void unlock_fs(struct mapped_device *md)
>  {
>  	if (!test_bit(DMF_FROZEN, &md->flags))
>  		return;
> -
> -	thaw_bdev(md->bdev, md->frozen_sb);
> -	md->frozen_sb = NULL;
> +	thaw_bdev(md->bdev);
>  	clear_bit(DMF_FROZEN, &md->flags);
>  }
>  
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index d8664f5c1ff669..33c29106c98907 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -548,55 +548,47 @@ EXPORT_SYMBOL(fsync_bdev);
>   * count down in thaw_bdev(). When it becomes 0, thaw_bdev() will unfreeze
>   * actually.
>   */
> -struct super_block *freeze_bdev(struct block_device *bdev)
> +int freeze_bdev(struct block_device *bdev)
>  {
>  	struct super_block *sb;
>  	int error = 0;
>  
>  	mutex_lock(&bdev->bd_fsfreeze_mutex);
> -	if (++bdev->bd_fsfreeze_count > 1) {
> -		/*
> -		 * We don't even need to grab a reference - the first call
> -		 * to freeze_bdev grab an active reference and only the last
> -		 * thaw_bdev drops it.
> -		 */
> -		sb = get_super(bdev);
> -		if (sb)
> -			drop_super(sb);
> -		mutex_unlock(&bdev->bd_fsfreeze_mutex);
> -		return sb;
> -	}
> +	if (++bdev->bd_fsfreeze_count > 1)
> +		goto done;
>  
>  	sb = get_active_super(bdev);
>  	if (!sb)
> -		goto out;
> +		goto sync;
>  	if (sb->s_op->freeze_super)
>  		error = sb->s_op->freeze_super(sb);
>  	else
>  		error = freeze_super(sb);
> +	deactivate_super(sb);
> +
>  	if (error) {
> -		deactivate_super(sb);
>  		bdev->bd_fsfreeze_count--;
> -		mutex_unlock(&bdev->bd_fsfreeze_mutex);
> -		return ERR_PTR(error);
> +		goto done;
>  	}
> -	deactivate_super(sb);
> - out:
> +	bdev->bd_fsfreeze_sb = sb;
> +
> +sync:
>  	sync_blockdev(bdev);
> +done:
>  	mutex_unlock(&bdev->bd_fsfreeze_mutex);
> -	return sb;	/* thaw_bdev releases s->s_umount */
> +	return error;
>  }
>  EXPORT_SYMBOL(freeze_bdev);
>  
>  /**
>   * thaw_bdev  -- unlock filesystem
>   * @bdev:	blockdevice to unlock
> - * @sb:		associated superblock
>   *
>   * Unlocks the filesystem and marks it writeable again after freeze_bdev().
>   */
> -int thaw_bdev(struct block_device *bdev, struct super_block *sb)
> +int thaw_bdev(struct block_device *bdev)
>  {
> +	struct super_block *sb;
>  	int error = -EINVAL;
>  
>  	mutex_lock(&bdev->bd_fsfreeze_mutex);
> @@ -607,6 +599,7 @@ int thaw_bdev(struct block_device *bdev, struct super_block *sb)
>  	if (--bdev->bd_fsfreeze_count > 0)
>  		goto out;
>  
> +	sb = bdev->bd_fsfreeze_sb;
>  	if (!sb)
>  		goto out;
>  
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 23f645657488ba..a7595ada9400ff 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -523,7 +523,7 @@ static int osync_buffers_list(spinlock_t *lock, struct list_head *list)
>  
>  void emergency_thaw_bdev(struct super_block *sb)
>  {
> -	while (sb->s_bdev && !thaw_bdev(sb->s_bdev, sb))
> +	while (sb->s_bdev && !thaw_bdev(sb->s_bdev))
>  		printk(KERN_WARNING "Emergency Thaw on %pg\n", sb->s_bdev);
>  }
>  
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index f0381876a7e5b0..524e134324475e 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -624,7 +624,7 @@ static int ext4_shutdown(struct super_block *sb, unsigned long arg)
>  	case EXT4_GOING_FLAGS_DEFAULT:
>  		freeze_bdev(sb->s_bdev);
>  		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
> -		thaw_bdev(sb->s_bdev, sb);
> +		thaw_bdev(sb->s_bdev);
>  		break;
>  	case EXT4_GOING_FLAGS_LOGFLUSH:
>  		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ee861c6d9ff026..a9fc482a0e60a5 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2230,16 +2230,12 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>  
>  	switch (in) {
>  	case F2FS_GOING_DOWN_FULLSYNC:
> -		sb = freeze_bdev(sb->s_bdev);
> -		if (IS_ERR(sb)) {
> -			ret = PTR_ERR(sb);
> +		ret = freeze_bdev(sb->s_bdev);
> +		if (ret)
>  			goto out;
> -		}
> -		if (sb) {
> -			f2fs_stop_checkpoint(sbi, false);
> -			set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
> -			thaw_bdev(sb->s_bdev, sb);
> -		}
> +		f2fs_stop_checkpoint(sbi, false);
> +		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
> +		thaw_bdev(sb->s_bdev);
>  		break;
>  	case F2FS_GOING_DOWN_METASYNC:
>  		/* do checkpoint only */
> diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
> index ef1d5bb88b93ab..b7c5783a031c69 100644
> --- a/fs/xfs/xfs_fsops.c
> +++ b/fs/xfs/xfs_fsops.c
> @@ -433,13 +433,10 @@ xfs_fs_goingdown(
>  {
>  	switch (inflags) {
>  	case XFS_FSOP_GOING_FLAGS_DEFAULT: {
> -		struct super_block *sb = freeze_bdev(mp->m_super->s_bdev);
> -
> -		if (sb && !IS_ERR(sb)) {
> +		if (!freeze_bdev(mp->m_super->s_bdev)) {
>  			xfs_force_shutdown(mp, SHUTDOWN_FORCE_UMOUNT);
> -			thaw_bdev(sb->s_bdev, sb);
> +			thaw_bdev(mp->m_super->s_bdev);
>  		}
> -
>  		break;
>  	}
>  	case XFS_FSOP_GOING_FLAGS_LOGFLUSH:
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index d9b69bbde5cc54..ebfb4e7c1fd125 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -46,6 +46,7 @@ struct block_device {
>  	int			bd_fsfreeze_count;
>  	/* Mutex for freeze */
>  	struct mutex		bd_fsfreeze_mutex;
> +	struct super_block	*bd_fsfreeze_sb;
>  } __randomize_layout;
>  
>  /*
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 05b346a68c2eee..12810a19edebc4 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -2020,7 +2020,7 @@ static inline int sync_blockdev(struct block_device *bdev)
>  #endif
>  int fsync_bdev(struct block_device *bdev);
>  
> -struct super_block *freeze_bdev(struct block_device *bdev);
> -int thaw_bdev(struct block_device *bdev, struct super_block *sb);
> +int freeze_bdev(struct block_device *bdev);
> +int thaw_bdev(struct block_device *bdev);
>  
>  #endif /* _LINUX_BLKDEV_H */
> -- 
> 2.29.2
> 
