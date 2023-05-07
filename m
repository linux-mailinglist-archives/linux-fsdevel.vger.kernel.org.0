Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6496FB0D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 15:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbjEHNBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 09:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjEHNBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 09:01:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B2C35D9A;
        Mon,  8 May 2023 06:01:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 599641FEB8;
        Mon,  8 May 2023 13:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683550891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DJzs5jgyajGKhkeTAQwkIA4kwmTiHj3hEdSfBNB2sk0=;
        b=lW4SwAwy+UOwt4/fah+KoddJRRX60ThfAKA0zCWn+PFXIO5WsDyohgOm1jhDKrUW2esh0N
        LWJCTf7eBA7NCS5/AQaPSSJTOYdmPnEpw9TI5xVhSoo0v8CEBv/RO9Gxys2CuOuXAnkTeQ
        SaHBnCglkFoJLOIQEikaFtc5iTSG7eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683550891;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DJzs5jgyajGKhkeTAQwkIA4kwmTiHj3hEdSfBNB2sk0=;
        b=Tgu0Wh339zc156CZZzgNYX3doTuInmLIbC6HKJztSs+yXhku3sbJsvzGXzCB2qQKkjRKPW
        Vfxhw+bSLprsuiCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F076F13499;
        Mon,  8 May 2023 13:01:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0sOsOqryWGShXQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 08 May 2023 13:01:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DC609A075D; Sun,  7 May 2023 21:12:38 +0200 (CEST)
Date:   Sun, 7 May 2023 21:12:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] block: introduce holder ops
Message-ID: <20230507191238.w6b7oiq7qpdox3ps@quack3>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505175132.2236632-6-hch@lst.de>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 05-05-23 13:51:28, Christoph Hellwig wrote:
> Add a new blk_holder_ops structure, which is passed to blkdev_get_by_* and
> installed in the block_device for exclusive claims.  It will be used to
> allow the block layer to call back into the user of the block device for
> thing like notification of a removed device or a device resize.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bdev.c                        | 20 +++++++++++++++-----
>  block/fops.c                        |  2 +-
>  block/genhd.c                       |  3 ++-
>  block/ioctl.c                       |  3 ++-
>  drivers/block/drbd/drbd_nl.c        |  3 ++-
>  drivers/block/pktcdvd.c             |  5 +++--
>  drivers/block/rnbd/rnbd-srv.c       |  2 +-
>  drivers/block/xen-blkback/xenbus.c  |  2 +-
>  drivers/block/zram/zram_drv.c       |  2 +-
>  drivers/md/bcache/super.c           |  2 +-
>  drivers/md/dm.c                     |  2 +-
>  drivers/md/md.c                     |  2 +-
>  drivers/mtd/devices/block2mtd.c     |  4 ++--
>  drivers/nvme/target/io-cmd-bdev.c   |  2 +-
>  drivers/s390/block/dasd_genhd.c     |  2 +-
>  drivers/target/target_core_iblock.c |  2 +-
>  drivers/target/target_core_pscsi.c  |  3 ++-
>  fs/btrfs/dev-replace.c              |  2 +-
>  fs/btrfs/volumes.c                  |  6 +++---
>  fs/erofs/super.c                    |  2 +-
>  fs/ext4/super.c                     |  3 ++-
>  fs/f2fs/super.c                     |  4 ++--
>  fs/jfs/jfs_logmgr.c                 |  2 +-
>  fs/nfs/blocklayout/dev.c            |  5 +++--
>  fs/nilfs2/super.c                   |  2 +-
>  fs/ocfs2/cluster/heartbeat.c        |  2 +-
>  fs/reiserfs/journal.c               |  5 +++--
>  fs/super.c                          |  4 ++--
>  fs/xfs/xfs_super.c                  |  2 +-
>  include/linux/blk_types.h           |  2 ++
>  include/linux/blkdev.h              |  8 ++++++--
>  kernel/power/swap.c                 |  4 ++--
>  mm/swapfile.c                       |  3 ++-
>  33 files changed, 71 insertions(+), 46 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index bad75f6cf8edcd..297e26cef28c78 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -415,6 +415,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>  	bdev = I_BDEV(inode);
>  	mutex_init(&bdev->bd_fsfreeze_mutex);
>  	spin_lock_init(&bdev->bd_size_lock);
> +	mutex_init(&bdev->bd_holder_lock);
>  	bdev->bd_partno = partno;
>  	bdev->bd_inode = inode;
>  	bdev->bd_queue = disk->queue;
> @@ -542,7 +543,8 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
>   * Finish exclusive open of a block device. Mark the device as exlusively
>   * open by the holder and wake up all waiters for exclusive open to finish.
>   */
> -static void bd_finish_claiming(struct block_device *bdev, void *holder)
> +static void bd_finish_claiming(struct block_device *bdev, void *holder,
> +		const struct blk_holder_ops *hops)
>  {
>  	struct block_device *whole = bdev_whole(bdev);
>  
> @@ -555,7 +557,10 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder)
>  	whole->bd_holders++;
>  	whole->bd_holder = bd_may_claim;
>  	bdev->bd_holders++;
> +	mutex_lock(&bdev->bd_holder_lock);
>  	bdev->bd_holder = holder;
> +	bdev->bd_holder_ops = hops;
> +	mutex_unlock(&bdev->bd_holder_lock);
>  	bd_clear_claiming(whole, holder);
>  	mutex_unlock(&bdev_lock);
>  }
> @@ -590,7 +595,10 @@ static void bd_end_claim(struct block_device *bdev)
>  	WARN_ON_ONCE(--bdev->bd_holders < 0);
>  	WARN_ON_ONCE(--whole->bd_holders < 0);
>  	if (!bdev->bd_holders) {
> +		mutex_lock(&bdev->bd_holder_lock);
>  		bdev->bd_holder = NULL;
> +		bdev->bd_holder_ops = NULL;
> +		mutex_unlock(&bdev->bd_holder_lock);
>  		if (bdev->bd_write_holder)
>  			unblock = true;
>  	}
> @@ -720,6 +728,7 @@ void blkdev_put_no_open(struct block_device *bdev)
>   * @dev: device number of block device to open
>   * @mode: FMODE_* mask
>   * @holder: exclusive holder identifier
> + * @hops: holder operations
>   *
>   * Open the block device described by device number @dev. If @mode includes
>   * %FMODE_EXCL, the block device is opened with exclusive access.  Specifying
> @@ -736,7 +745,8 @@ void blkdev_put_no_open(struct block_device *bdev)
>   * RETURNS:
>   * Reference to the block_device on success, ERR_PTR(-errno) on failure.
>   */
> -struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
> +struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
> +		const struct blk_holder_ops *hops)
>  {
>  	bool unblock_events = true;
>  	struct block_device *bdev;
> @@ -776,7 +786,7 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
>  	if (ret)
>  		goto put_module;
>  	if (mode & FMODE_EXCL) {
> -		bd_finish_claiming(bdev, holder);
> +		bd_finish_claiming(bdev, holder, hops);
>  
>  		/*
>  		 * Block event polling for write claims if requested.  Any write
> @@ -827,7 +837,7 @@ EXPORT_SYMBOL(blkdev_get_by_dev);
>   * Reference to the block_device on success, ERR_PTR(-errno) on failure.
>   */
>  struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
> -					void *holder)
> +		void *holder, const struct blk_holder_ops *hops)
>  {
>  	struct block_device *bdev;
>  	dev_t dev;
> @@ -837,7 +847,7 @@ struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
>  	if (error)
>  		return ERR_PTR(error);
>  
> -	bdev = blkdev_get_by_dev(dev, mode, holder);
> +	bdev = blkdev_get_by_dev(dev, mode, holder, hops);
>  	if (!IS_ERR(bdev) && (mode & FMODE_WRITE) && bdev_read_only(bdev)) {
>  		blkdev_put(bdev, mode);
>  		return ERR_PTR(-EACCES);
> diff --git a/block/fops.c b/block/fops.c
> index d2e6be4e3d1c7d..2ac5ea878fa4cc 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -490,7 +490,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
>  	if ((filp->f_flags & O_ACCMODE) == 3)
>  		filp->f_mode |= FMODE_WRITE_IOCTL;
>  
> -	bdev = blkdev_get_by_dev(inode->i_rdev, filp->f_mode, filp);
> +	bdev = blkdev_get_by_dev(inode->i_rdev, filp->f_mode, filp, NULL);
>  	if (IS_ERR(bdev))
>  		return PTR_ERR(bdev);
>  
> diff --git a/block/genhd.c b/block/genhd.c
> index 9a35b8443f0b5f..d1c673b967c254 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -381,7 +381,8 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
>  	}
>  
>  	set_bit(GD_NEED_PART_SCAN, &disk->state);
> -	bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~FMODE_EXCL, NULL);
> +	bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~FMODE_EXCL, NULL,
> +				 NULL);
>  	if (IS_ERR(bdev))
>  		ret =  PTR_ERR(bdev);
>  	else
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 9c5f637ff153f8..c7d7d4345edb4f 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -454,7 +454,8 @@ static int blkdev_bszset(struct block_device *bdev, fmode_t mode,
>  	if (mode & FMODE_EXCL)
>  		return set_blocksize(bdev, n);
>  
> -	if (IS_ERR(blkdev_get_by_dev(bdev->bd_dev, mode | FMODE_EXCL, &bdev)))
> +	if (IS_ERR(blkdev_get_by_dev(bdev->bd_dev, mode | FMODE_EXCL, &bdev,
> +			NULL)))
>  		return -EBUSY;
>  	ret = set_blocksize(bdev, n);
>  	blkdev_put(bdev, mode | FMODE_EXCL);
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index 1a5d3d72d91d27..cab59dab3410aa 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -1641,7 +1641,8 @@ static struct block_device *open_backing_dev(struct drbd_device *device,
>  	int err = 0;
>  
>  	bdev = blkdev_get_by_path(bdev_path,
> -				  FMODE_READ | FMODE_WRITE | FMODE_EXCL, claim_ptr);
> +				  FMODE_READ | FMODE_WRITE | FMODE_EXCL,
> +				  claim_ptr, NULL);
>  	if (IS_ERR(bdev)) {
>  		drbd_err(device, "open(\"%s\") failed with %ld\n",
>  				bdev_path, PTR_ERR(bdev));
> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> index d5d7884cedd477..377f8b34535294 100644
> --- a/drivers/block/pktcdvd.c
> +++ b/drivers/block/pktcdvd.c
> @@ -2125,7 +2125,8 @@ static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
>  	 * to read/write from/to it. It is already opened in O_NONBLOCK mode
>  	 * so open should not fail.
>  	 */
> -	bdev = blkdev_get_by_dev(pd->bdev->bd_dev, FMODE_READ | FMODE_EXCL, pd);
> +	bdev = blkdev_get_by_dev(pd->bdev->bd_dev, FMODE_READ | FMODE_EXCL, pd,
> +				 NULL);
>  	if (IS_ERR(bdev)) {
>  		ret = PTR_ERR(bdev);
>  		goto out;
> @@ -2530,7 +2531,7 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
>  		}
>  	}
>  
> -	bdev = blkdev_get_by_dev(dev, FMODE_READ | FMODE_NDELAY, NULL);
> +	bdev = blkdev_get_by_dev(dev, FMODE_READ | FMODE_NDELAY, NULL, NULL);
>  	if (IS_ERR(bdev))
>  		return PTR_ERR(bdev);
>  	sdev = scsi_device_from_queue(bdev->bd_disk->queue);
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> index 2cfed2e58d646f..cec22bbae2f9a5 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -719,7 +719,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
>  		goto reject;
>  	}
>  
> -	bdev = blkdev_get_by_path(full_path, open_flags, THIS_MODULE);
> +	bdev = blkdev_get_by_path(full_path, open_flags, THIS_MODULE, NULL);
>  	if (IS_ERR(bdev)) {
>  		ret = PTR_ERR(bdev);
>  		pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %d\n",
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index 4807af1d580593..43b36da9b3544d 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -492,7 +492,7 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
>  	vbd->pdevice  = MKDEV(major, minor);
>  
>  	bdev = blkdev_get_by_dev(vbd->pdevice, vbd->readonly ?
> -				 FMODE_READ : FMODE_WRITE, NULL);
> +				 FMODE_READ : FMODE_WRITE, NULL, NULL);
>  
>  	if (IS_ERR(bdev)) {
>  		pr_warn("xen_vbd_create: device %08x could not be opened\n",
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index a84c4268257a99..5d21d074c7a0cd 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -508,7 +508,7 @@ static ssize_t backing_dev_store(struct device *dev,
>  	}
>  
>  	bdev = blkdev_get_by_dev(inode->i_rdev,
> -			FMODE_READ | FMODE_WRITE | FMODE_EXCL, zram);
> +			FMODE_READ | FMODE_WRITE | FMODE_EXCL, zram, NULL);
>  	if (IS_ERR(bdev)) {
>  		err = PTR_ERR(bdev);
>  		bdev = NULL;
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index ba3909bb6beabb..c22d5aafd784b5 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -2561,7 +2561,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
>  	err = "failed to open device";
>  	bdev = blkdev_get_by_path(strim(path),
>  				  FMODE_READ|FMODE_WRITE|FMODE_EXCL,
> -				  sb);
> +				  sb, NULL);
>  	if (IS_ERR(bdev)) {
>  		if (bdev == ERR_PTR(-EBUSY)) {
>  			dev_t dev;
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 3b694ba3a106e6..d759f8bdb3df2f 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -746,7 +746,7 @@ static struct table_device *open_table_device(struct mapped_device *md,
>  		return ERR_PTR(-ENOMEM);
>  	refcount_set(&td->count, 1);
>  
> -	bdev = blkdev_get_by_dev(dev, mode | FMODE_EXCL, _dm_claim_ptr);
> +	bdev = blkdev_get_by_dev(dev, mode | FMODE_EXCL, _dm_claim_ptr, NULL);
>  	if (IS_ERR(bdev)) {
>  		r = PTR_ERR(bdev);
>  		goto out_free_td;
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 8e344b4b34446f..60ab5c4bee77c5 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -3642,7 +3642,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
>  
>  	rdev->bdev = blkdev_get_by_dev(newdev,
>  			FMODE_READ | FMODE_WRITE | FMODE_EXCL,
> -			super_format == -2 ? &claim_rdev : rdev);
> +			super_format == -2 ? &claim_rdev : rdev, NULL);
>  	if (IS_ERR(rdev->bdev)) {
>  		pr_warn("md: could not open device unknown-block(%u,%u).\n",
>  			MAJOR(newdev), MINOR(newdev));
> diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
> index 4cd37ec45762b6..7ac82c6fe35024 100644
> --- a/drivers/mtd/devices/block2mtd.c
> +++ b/drivers/mtd/devices/block2mtd.c
> @@ -235,7 +235,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
>  		return NULL;
>  
>  	/* Get a handle on the device */
> -	bdev = blkdev_get_by_path(devname, mode, dev);
> +	bdev = blkdev_get_by_path(devname, mode, dev, NULL);
>  
>  #ifndef MODULE
>  	/*
> @@ -257,7 +257,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
>  		devt = name_to_dev_t(devname);
>  		if (!devt)
>  			continue;
> -		bdev = blkdev_get_by_dev(devt, mode, dev);
> +		bdev = blkdev_get_by_dev(devt, mode, dev, NULL);
>  	}
>  #endif
>  
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index c2d6cea0236b0a..9b6d6d85c72544 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -85,7 +85,7 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>  		return -ENOTBLK;
>  
>  	ns->bdev = blkdev_get_by_path(ns->device_path,
> -			FMODE_READ | FMODE_WRITE, NULL);
> +			FMODE_READ | FMODE_WRITE, NULL, NULL);
>  	if (IS_ERR(ns->bdev)) {
>  		ret = PTR_ERR(ns->bdev);
>  		if (ret != -ENOTBLK) {
> diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
> index 998a961e170417..f21198bc483e1a 100644
> --- a/drivers/s390/block/dasd_genhd.c
> +++ b/drivers/s390/block/dasd_genhd.c
> @@ -130,7 +130,7 @@ int dasd_scan_partitions(struct dasd_block *block)
>  	struct block_device *bdev;
>  	int rc;
>  
> -	bdev = blkdev_get_by_dev(disk_devt(block->gdp), FMODE_READ, NULL);
> +	bdev = blkdev_get_by_dev(disk_devt(block->gdp), FMODE_READ, NULL, NULL);
>  	if (IS_ERR(bdev)) {
>  		DBF_DEV_EVENT(DBF_ERR, block->base,
>  			      "scan partitions error, blkdev_get returned %ld",
> diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
> index cc838ffd129472..a5cbbefa78ee4e 100644
> --- a/drivers/target/target_core_iblock.c
> +++ b/drivers/target/target_core_iblock.c
> @@ -114,7 +114,7 @@ static int iblock_configure_device(struct se_device *dev)
>  	else
>  		dev->dev_flags |= DF_READ_ONLY;
>  
> -	bd = blkdev_get_by_path(ib_dev->ibd_udev_path, mode, ib_dev);
> +	bd = blkdev_get_by_path(ib_dev->ibd_udev_path, mode, ib_dev, NULL);
>  	if (IS_ERR(bd)) {
>  		ret = PTR_ERR(bd);
>  		goto out_free_bioset;
> diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
> index e7425549e39c73..e3494e036c6c85 100644
> --- a/drivers/target/target_core_pscsi.c
> +++ b/drivers/target/target_core_pscsi.c
> @@ -367,7 +367,8 @@ static int pscsi_create_type_disk(struct se_device *dev, struct scsi_device *sd)
>  	 * for TYPE_DISK and TYPE_ZBC using supplied udev_path
>  	 */
>  	bd = blkdev_get_by_path(dev->udev_path,
> -				FMODE_WRITE|FMODE_READ|FMODE_EXCL, pdv);
> +				FMODE_WRITE|FMODE_READ|FMODE_EXCL, pdv,
> +				NULL);
>  	if (IS_ERR(bd)) {
>  		pr_err("pSCSI: blkdev_get_by_path() failed\n");
>  		scsi_device_put(sd);
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 78696d331639bd..4de4984fa99ba3 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -258,7 +258,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>  	}
>  
>  	bdev = blkdev_get_by_path(device_path, FMODE_WRITE | FMODE_EXCL,
> -				  fs_info->bdev_holder);
> +				  fs_info->bdev_holder, NULL);
>  	if (IS_ERR(bdev)) {
>  		btrfs_err(fs_info, "target device %s is invalid!", device_path);
>  		return PTR_ERR(bdev);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 03f52e4a20aa9b..708350ba07e3ee 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -495,7 +495,7 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
>  {
>  	int ret;
>  
> -	*bdev = blkdev_get_by_path(device_path, flags, holder);
> +	*bdev = blkdev_get_by_path(device_path, flags, holder, NULL);
>  
>  	if (IS_ERR(*bdev)) {
>  		ret = PTR_ERR(*bdev);
> @@ -1376,7 +1376,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>  	 * values temporarily, as the device paths of the fsid are the only
>  	 * required information for assembling the volume.
>  	 */
> -	bdev = blkdev_get_by_path(path, flags, holder);
> +	bdev = blkdev_get_by_path(path, flags, holder, NULL);
>  	if (IS_ERR(bdev))
>  		return ERR_CAST(bdev);
>  
> @@ -2628,7 +2628,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  		return -EROFS;
>  
>  	bdev = blkdev_get_by_path(device_path, FMODE_WRITE | FMODE_EXCL,
> -				  fs_info->bdev_holder);
> +				  fs_info->bdev_holder, NULL);
>  	if (IS_ERR(bdev))
>  		return PTR_ERR(bdev);
>  
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 811ab66d805ede..6c263e9cd38b2a 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -254,7 +254,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>  		dif->fscache = fscache;
>  	} else if (!sbi->devs->flatdev) {
>  		bdev = blkdev_get_by_path(dif->path, FMODE_READ | FMODE_EXCL,
> -					  sb->s_type);
> +					  sb->s_type, NULL);
>  		if (IS_ERR(bdev))
>  			return PTR_ERR(bdev);
>  		dif->bdev = bdev;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index d39f386e9baf6a..99d495de2e9b08 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1101,7 +1101,8 @@ static struct block_device *ext4_blkdev_get(dev_t dev, struct super_block *sb)
>  {
>  	struct block_device *bdev;
>  
> -	bdev = blkdev_get_by_dev(dev, FMODE_READ|FMODE_WRITE|FMODE_EXCL, sb);
> +	bdev = blkdev_get_by_dev(dev, FMODE_READ|FMODE_WRITE|FMODE_EXCL, sb,
> +				 NULL);
>  	if (IS_ERR(bdev))
>  		goto fail;
>  	return bdev;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 9f15b03037dba9..7c34ab082f1382 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4025,7 +4025,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  			/* Single zoned block device mount */
>  			FDEV(0).bdev =
>  				blkdev_get_by_dev(sbi->sb->s_bdev->bd_dev,
> -					sbi->sb->s_mode, sbi->sb->s_type);
> +					sbi->sb->s_mode, sbi->sb->s_type, NULL);
>  		} else {
>  			/* Multi-device mount */
>  			memcpy(FDEV(i).path, RDEV(i).path, MAX_PATH_LEN);
> @@ -4044,7 +4044,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  					sbi->log_blocks_per_seg) - 1;
>  			}
>  			FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path,
> -					sbi->sb->s_mode, sbi->sb->s_type);
> +					sbi->sb->s_mode, sbi->sb->s_type, NULL);
>  		}
>  		if (IS_ERR(FDEV(i).bdev))
>  			return PTR_ERR(FDEV(i).bdev);
> diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
> index 695415cbfe985b..8c55030c57ed52 100644
> --- a/fs/jfs/jfs_logmgr.c
> +++ b/fs/jfs/jfs_logmgr.c
> @@ -1101,7 +1101,7 @@ int lmLogOpen(struct super_block *sb)
>  	 */
>  
>  	bdev = blkdev_get_by_dev(sbi->logdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL,
> -				 log);
> +				 log, NULL);
>  	if (IS_ERR(bdev)) {
>  		rc = PTR_ERR(bdev);
>  		goto free;
> diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
> index fea5f8821da5ef..38b066ca699ed7 100644
> --- a/fs/nfs/blocklayout/dev.c
> +++ b/fs/nfs/blocklayout/dev.c
> @@ -243,7 +243,7 @@ bl_parse_simple(struct nfs_server *server, struct pnfs_block_dev *d,
>  	if (!dev)
>  		return -EIO;
>  
> -	bdev = blkdev_get_by_dev(dev, FMODE_READ | FMODE_WRITE, NULL);
> +	bdev = blkdev_get_by_dev(dev, FMODE_READ | FMODE_WRITE, NULL, NULL);
>  	if (IS_ERR(bdev)) {
>  		printk(KERN_WARNING "pNFS: failed to open device %d:%d (%ld)\n",
>  			MAJOR(dev), MINOR(dev), PTR_ERR(bdev));
> @@ -312,7 +312,8 @@ bl_open_path(struct pnfs_block_volume *v, const char *prefix)
>  	if (!devname)
>  		return ERR_PTR(-ENOMEM);
>  
> -	bdev = blkdev_get_by_path(devname, FMODE_READ | FMODE_WRITE, NULL);
> +	bdev = blkdev_get_by_path(devname, FMODE_READ | FMODE_WRITE, NULL,
> +				  NULL);
>  	if (IS_ERR(bdev)) {
>  		pr_warn("pNFS: failed to open device %s (%ld)\n",
>  			devname, PTR_ERR(bdev));
> diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
> index 77f1e5778d1c84..91bfbd973d1d53 100644
> --- a/fs/nilfs2/super.c
> +++ b/fs/nilfs2/super.c
> @@ -1285,7 +1285,7 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
>  	if (!(flags & SB_RDONLY))
>  		mode |= FMODE_WRITE;
>  
> -	sd.bdev = blkdev_get_by_path(dev_name, mode, fs_type);
> +	sd.bdev = blkdev_get_by_path(dev_name, mode, fs_type, NULL);
>  	if (IS_ERR(sd.bdev))
>  		return ERR_CAST(sd.bdev);
>  
> diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
> index 60b97c92e2b25e..6b13b8c3f2b8af 100644
> --- a/fs/ocfs2/cluster/heartbeat.c
> +++ b/fs/ocfs2/cluster/heartbeat.c
> @@ -1786,7 +1786,7 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
>  		goto out2;
>  
>  	reg->hr_bdev = blkdev_get_by_dev(f.file->f_mapping->host->i_rdev,
> -					 FMODE_WRITE | FMODE_READ, NULL);
> +					 FMODE_WRITE | FMODE_READ, NULL, NULL);
>  	if (IS_ERR(reg->hr_bdev)) {
>  		ret = PTR_ERR(reg->hr_bdev);
>  		reg->hr_bdev = NULL;
> diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
> index 4d11d60f493c14..5e4db9a0c8e5a3 100644
> --- a/fs/reiserfs/journal.c
> +++ b/fs/reiserfs/journal.c
> @@ -2616,7 +2616,7 @@ static int journal_init_dev(struct super_block *super,
>  		if (jdev == super->s_dev)
>  			blkdev_mode &= ~FMODE_EXCL;
>  		journal->j_dev_bd = blkdev_get_by_dev(jdev, blkdev_mode,
> -						      journal);
> +						      journal, NULL);
>  		journal->j_dev_mode = blkdev_mode;
>  		if (IS_ERR(journal->j_dev_bd)) {
>  			result = PTR_ERR(journal->j_dev_bd);
> @@ -2632,7 +2632,8 @@ static int journal_init_dev(struct super_block *super,
>  	}
>  
>  	journal->j_dev_mode = blkdev_mode;
> -	journal->j_dev_bd = blkdev_get_by_path(jdev_name, blkdev_mode, journal);
> +	journal->j_dev_bd = blkdev_get_by_path(jdev_name, blkdev_mode, journal,
> +					       NULL);
>  	if (IS_ERR(journal->j_dev_bd)) {
>  		result = PTR_ERR(journal->j_dev_bd);
>  		journal->j_dev_bd = NULL;
> diff --git a/fs/super.c b/fs/super.c
> index 34afe411cf2bc3..012ce140080375 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1248,7 +1248,7 @@ int get_tree_bdev(struct fs_context *fc,
>  	if (!fc->source)
>  		return invalf(fc, "No source specified");
>  
> -	bdev = blkdev_get_by_path(fc->source, mode, fc->fs_type);
> +	bdev = blkdev_get_by_path(fc->source, mode, fc->fs_type, NULL);
>  	if (IS_ERR(bdev)) {
>  		errorf(fc, "%s: Can't open blockdev", fc->source);
>  		return PTR_ERR(bdev);
> @@ -1333,7 +1333,7 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
>  	if (!(flags & SB_RDONLY))
>  		mode |= FMODE_WRITE;
>  
> -	bdev = blkdev_get_by_path(dev_name, mode, fs_type);
> +	bdev = blkdev_get_by_path(dev_name, mode, fs_type, NULL);
>  	if (IS_ERR(bdev))
>  		return ERR_CAST(bdev);
>  
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 4d2e87462ac4a1..bc17ad350aea5a 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -386,7 +386,7 @@ xfs_blkdev_get(
>  	int			error = 0;
>  
>  	*bdevp = blkdev_get_by_path(name, FMODE_READ|FMODE_WRITE|FMODE_EXCL,
> -				    mp);
> +				    mp, NULL);
>  	if (IS_ERR(*bdevp)) {
>  		error = PTR_ERR(*bdevp);
>  		xfs_warn(mp, "Invalid device [%s], error=%d", name, error);
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 740afe80f29786..84a931caef514e 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -55,6 +55,8 @@ struct block_device {
>  	struct super_block *	bd_super;
>  	void *			bd_claiming;
>  	void *			bd_holder;
> +	const struct blk_holder_ops *bd_holder_ops;
> +	struct mutex		bd_holder_lock;
>  	/* The counter of freeze processes */
>  	int			bd_fsfreeze_count;
>  	int			bd_holders;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index e3242e67a8e3df..3f41f8c9b103cf 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1468,9 +1468,13 @@ void blkdev_show(struct seq_file *seqf, off_t offset);
>  #define BLKDEV_MAJOR_MAX	0
>  #endif
>  
> +struct blk_holder_ops {
> +};
> +
> +struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
> +		const struct blk_holder_ops *hops);
>  struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
> -		void *holder);
> -struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder);
> +		void *holder, const struct blk_holder_ops *hops);
>  int bd_prepare_to_claim(struct block_device *bdev, void *holder);
>  void bd_abort_claiming(struct block_device *bdev, void *holder);
>  void blkdev_put(struct block_device *bdev, fmode_t mode);
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 92e41ed292ada8..801c411530d11c 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -357,7 +357,7 @@ static int swsusp_swap_check(void)
>  	root_swap = res;
>  
>  	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device, FMODE_WRITE,
> -			NULL);
> +			NULL, NULL);
>  	if (IS_ERR(hib_resume_bdev))
>  		return PTR_ERR(hib_resume_bdev);
>  
> @@ -1524,7 +1524,7 @@ int swsusp_check(void)
>  		mode |= FMODE_EXCL;
>  
>  	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
> -					    mode, &holder);
> +					    mode, &holder, NULL);
>  	if (!IS_ERR(hib_resume_bdev)) {
>  		set_blocksize(hib_resume_bdev, PAGE_SIZE);
>  		clear_page(swsusp_header);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 274bbf79748006..cfbcf7d5705f5f 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2770,7 +2770,8 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
>  
>  	if (S_ISBLK(inode->i_mode)) {
>  		p->bdev = blkdev_get_by_dev(inode->i_rdev,
> -				   FMODE_READ | FMODE_WRITE | FMODE_EXCL, p);
> +				   FMODE_READ | FMODE_WRITE | FMODE_EXCL, p,
> +				   NULL);
>  		if (IS_ERR(p->bdev)) {
>  			error = PTR_ERR(p->bdev);
>  			p->bdev = NULL;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
