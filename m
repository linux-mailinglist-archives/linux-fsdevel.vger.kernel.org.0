Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A466574878E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 17:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjGEPM1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 11:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjGEPMX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:12:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12D910EA;
        Wed,  5 Jul 2023 08:12:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FEA5615DB;
        Wed,  5 Jul 2023 15:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEBBC433C8;
        Wed,  5 Jul 2023 15:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688569939;
        bh=9M3W0jvMSHORjdwvhYVllucAG8b5Te1BpjD+BHEHQUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0X+2gWbVDQvenj2EVDuTAux8ELig2SSC53a6H8OazUmgef7tiiRnJxH3AjIVUh7l
         fX7ESEx+ujNA2eWYpecvIMgX2G+FNkRdEcMvmfkQwF3EQFFSxhSBeXvaipGTYK8FM2
         c6lm5vWPpmOARpP4wqCmvRLb+tpoizdBsmk/IHNmoPEBOmxjtezhDarZA0S67xNPp8
         CMXQjKLpFd3a/z4kWtia6MMI2dN3+qz64tqzNlsi1ISYpqSkeh3NXv5zZfLfGHSA8K
         A0msPWEED96D5MYn7Ib50MepuiSU7cUpuO8A/BFjD8oqdW16cQxTolDX1Z5tWc/Dlw
         KzsgxqVU1u0Hw==
Date:   Wed, 5 Jul 2023 08:12:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/6] block: Add config option to not allow writing to
 mounted devices
Message-ID: <20230705151218.GP11441@frogsfrogsfrogs>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704125702.23180-1-jack@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 04, 2023 at 02:56:49PM +0200, Jan Kara wrote:
> Writing to mounted devices is dangerous and can lead to filesystem
> corruption as well as crashes. Furthermore syzbot comes with more and
> more involved examples how to corrupt block device under a mounted
> filesystem leading to kernel crashes and reports we can do nothing
> about. Add tracking of writers to each block device and a kernel cmdline
> argument which controls whether writes to block devices open with
> BLK_OPEN_BLOCK_WRITES flag are allowed. We will make filesystems use
> this flag for used devices.
> 
> Syzbot can use this cmdline argument option to avoid uninteresting
> crashes. Also users whose userspace setup does not need writing to
> mounted block devices can set this option for hardening.
> 
> Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/Kconfig             | 16 ++++++++++
>  block/bdev.c              | 63 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/blk_types.h |  1 +
>  include/linux/blkdev.h    |  3 ++
>  4 files changed, 82 insertions(+), 1 deletion(-)
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index 86122e459fe0..8b4fa105b854 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -77,6 +77,22 @@ config BLK_DEV_INTEGRITY_T10
>  	select CRC_T10DIF
>  	select CRC64_ROCKSOFT
>  
> +config BLK_DEV_WRITE_MOUNTED
> +	bool "Allow writing to mounted block devices"
> +	default y
> +	help
> +	When a block device is mounted, writing to its buffer cache very likely
> +	going to cause filesystem corruption. It is also rather easy to crash
> +	the kernel in this way since the filesystem has no practical way of
> +	detecting these writes to buffer cache and verifying its metadata
> +	integrity. However there are some setups that need this capability
> +	like running fsck on read-only mounted root device, modifying some
> +	features on mounted ext4 filesystem, and similar. If you say N, the
> +	kernel will prevent processes from writing to block devices that are
> +	mounted by filesystems which provides some more protection from runaway
> +	priviledged processes. If in doubt, say Y. The configuration can be
> +	overridden with bdev_allow_write_mounted boot option.
> +
>  config BLK_DEV_ZONED
>  	bool "Zoned block device support"
>  	select MQ_IOSCHED_DEADLINE
> diff --git a/block/bdev.c b/block/bdev.c
> index 523ea7289834..346e68dbf0bf 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -30,6 +30,9 @@
>  #include "../fs/internal.h"
>  #include "blk.h"
>  
> +/* Should we allow writing to mounted block devices? */
> +static bool bdev_allow_write_mounted = IS_ENABLED(CONFIG_BLK_DEV_WRITE_MOUNTED);

This might be premature at this point, but I wonder if you've given any
consideration to adding a lockdown prohibition as well?  e.g.

static inline bool bdev_allow_write_mounted(void)
{
	if (security_locked_down(LOCKDOWN_MOUNTED_BDEV) != 0)
		return false;

	return __bdev_allow_write_mounted;
}

--D

>  struct bdev_inode {
>  	struct block_device bdev;
>  	struct inode vfs_inode;
> @@ -744,7 +747,34 @@ void blkdev_put_no_open(struct block_device *bdev)
>  {
>  	put_device(&bdev->bd_device);
>  }
> -	
> +
> +static bool bdev_writes_blocked(struct block_device *bdev)
> +{
> +	return bdev->bd_writers == -1;
> +}
> +
> +static void bdev_block_writes(struct block_device *bdev)
> +{
> +	bdev->bd_writers = -1;
> +}
> +
> +static void bdev_unblock_writes(struct block_device *bdev)
> +{
> +	bdev->bd_writers = 0;
> +}
> +
> +static bool blkdev_open_compatible(struct block_device *bdev, blk_mode_t mode)
> +{
> +	if (!bdev_allow_write_mounted) {
> +		/* Writes blocked? */
> +		if (mode & BLK_OPEN_WRITE && bdev_writes_blocked(bdev))
> +			return false;
> +		if (mode & BLK_OPEN_BLOCK_WRITES && bdev->bd_writers > 0)
> +			return false;
> +	}
> +	return true;
> +}
> +
>  /**
>   * blkdev_get_by_dev - open a block device by device number
>   * @dev: device number of block device to open
> @@ -787,6 +817,10 @@ struct bdev_handle *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>  	if (ret)
>  		goto free_handle;
>  
> +	/* Blocking writes requires exclusive opener */
> +	if (mode & BLK_OPEN_BLOCK_WRITES && !holder)
> +		return ERR_PTR(-EINVAL);
> +
>  	bdev = blkdev_get_no_open(dev);
>  	if (!bdev) {
>  		ret = -ENXIO;
> @@ -814,12 +848,21 @@ struct bdev_handle *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>  		goto abort_claiming;
>  	if (!try_module_get(disk->fops->owner))
>  		goto abort_claiming;
> +	ret = -EBUSY;
> +	if (!blkdev_open_compatible(bdev, mode))
> +		goto abort_claiming;
>  	if (bdev_is_partition(bdev))
>  		ret = blkdev_get_part(bdev, mode);
>  	else
>  		ret = blkdev_get_whole(bdev, mode);
>  	if (ret)
>  		goto put_module;
> +	if (!bdev_allow_write_mounted) {
> +		if (mode & BLK_OPEN_BLOCK_WRITES)
> +			bdev_block_writes(bdev);
> +		else if (mode & BLK_OPEN_WRITE)
> +			bdev->bd_writers++;
> +	}
>  	if (holder) {
>  		bd_finish_claiming(bdev, holder, hops);
>  
> @@ -842,6 +885,7 @@ struct bdev_handle *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>  		disk_unblock_events(disk);
>  	handle->bdev = bdev;
>  	handle->holder = holder;
> +	handle->mode = mode;
>  	return handle;
>  put_module:
>  	module_put(disk->fops->owner);
> @@ -914,6 +958,14 @@ void blkdev_put(struct bdev_handle *handle)
>  		sync_blockdev(bdev);
>  
>  	mutex_lock(&disk->open_mutex);
> +	if (!bdev_allow_write_mounted) {
> +		/* The exclusive opener was blocking writes? Unblock them. */
> +		if (handle->mode & BLK_OPEN_BLOCK_WRITES)
> +			bdev_unblock_writes(bdev);
> +		else if (handle->mode & BLK_OPEN_WRITE)
> +			bdev->bd_writers--;
> +	}
> +
>  	if (handle->holder)
>  		bd_end_claim(bdev, handle->holder);
>  
> @@ -1070,3 +1122,12 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
>  
>  	blkdev_put_no_open(bdev);
>  }
> +
> +static int __init setup_bdev_allow_write_mounted(char *str)
> +{
> +	if (kstrtobool(str, &bdev_allow_write_mounted))
> +		pr_warn("Invalid option string for bdev_allow_write_mounted:"
> +			" '%s'\n", str);
> +	return 1;
> +}
> +__setup("bdev_allow_write_mounted=", setup_bdev_allow_write_mounted);
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 0bad62cca3d0..5bf0d2d458fd 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -70,6 +70,7 @@ struct block_device {
>  #ifdef CONFIG_FAIL_MAKE_REQUEST
>  	bool			bd_make_it_fail;
>  #endif
> +	int			bd_writers;
>  	/*
>  	 * keep this out-of-line as it's both big and not needed in the fast
>  	 * path
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 4ae3647a0322..ca467525e6e4 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -124,6 +124,8 @@ typedef unsigned int __bitwise blk_mode_t;
>  #define BLK_OPEN_NDELAY		((__force blk_mode_t)(1 << 3))
>  /* open for "writes" only for ioctls (specialy hack for floppy.c) */
>  #define BLK_OPEN_WRITE_IOCTL	((__force blk_mode_t)(1 << 4))
> +/* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
> +#define BLK_OPEN_BLOCK_WRITES	((__force blk_mode_t)(1 << 5))
>  
>  struct gendisk {
>  	/*
> @@ -1474,6 +1476,7 @@ struct blk_holder_ops {
>  struct bdev_handle {
>  	struct block_device *bdev;
>  	void *holder;
> +	blk_mode_t mode;
>  };
>  
>  struct bdev_handle *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
> -- 
> 2.35.3
> 
