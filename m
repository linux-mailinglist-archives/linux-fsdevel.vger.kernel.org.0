Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A212C725A0C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 11:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239582AbjFGJVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 05:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239616AbjFGJVb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:21:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8C6EA;
        Wed,  7 Jun 2023 02:21:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A6B963CC2;
        Wed,  7 Jun 2023 09:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791CAC433D2;
        Wed,  7 Jun 2023 09:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686129683;
        bh=O7Noi9bkU504fMvGxhGKnIp+7G9jTf9HOKSbWcYU3tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qdl1/4B3phk4gsfq90euuCDnmGy+wYbiZYktRkBtcsJHFa+cyl1OAS8rNYXnkOt7b
         7bQxWQW0VT/fsJpBmiX4wI+j+u+uc++Q6XQboc03bYJpKEI+VF+NmgDdp0hkJmeh2j
         tCifeE69f4NGGpOtcX4L1Eh37OKMM9+DGvYyrc/IBfRiZ/RutlfZS9hZVffDAAw2mf
         3dYy+1mB14R8CjRg0jEdcMHWxQD7HcuC6VTohALECEfGfHyJYLHL/2l8GF5XSkXS5s
         Egw2+Iat1kO5J6UjtlaDds4mt1+/c0oNpiYpt3M0ahTXO/W6SnrtKI+SzYs5xu+adi
         orlGp3wRtPyhg==
Date:   Wed, 7 Jun 2023 11:21:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 28/31] block: replace fmode_t with a block-specific type
 for block open flags
Message-ID: <20230607-kocht-kornfeld-a249c6740e38@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-29-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-29-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 09:39:47AM +0200, Christoph Hellwig wrote:
> The only overlap between the block open flags mapped into the fmode_t and
> other uses of fmode_t are FMODE_READ and FMODE_WRITE.  Define a new

and FMODE_EXCL afaict

> blk_mode_t instead for use in blkdev_get_by_*, ->open and ->ioctl and
> stop abusing fmode_t.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/um/drivers/ubd_kern.c          |  8 +++---
>  arch/xtensa/platforms/iss/simdisk.c |  2 +-
>  block/bdev.c                        | 32 +++++++++++-----------
>  block/blk-zoned.c                   |  8 +++---
>  block/blk.h                         | 11 ++++----
>  block/fops.c                        | 26 +++++++++++++-----
>  block/genhd.c                       |  8 +++---
>  block/ioctl.c                       | 42 +++++++++--------------------
>  drivers/block/amiflop.c             | 12 ++++-----
>  drivers/block/aoe/aoeblk.c          |  4 +--
>  drivers/block/ataflop.c             | 25 +++++++++--------
>  drivers/block/drbd/drbd_main.c      |  7 ++---
>  drivers/block/drbd/drbd_nl.c        |  2 +-
>  drivers/block/floppy.c              | 28 +++++++++----------
>  drivers/block/loop.c                | 22 +++++++--------
>  drivers/block/mtip32xx/mtip32xx.c   |  4 +--
>  drivers/block/nbd.c                 |  4 +--
>  drivers/block/pktcdvd.c             | 17 ++++++------
>  drivers/block/rbd.c                 |  2 +-
>  drivers/block/rnbd/rnbd-clt.c       |  4 +--
>  drivers/block/rnbd/rnbd-srv.c       |  4 +--
>  drivers/block/sunvdc.c              |  2 +-
>  drivers/block/swim.c                | 16 +++++------
>  drivers/block/swim3.c               | 24 ++++++++---------
>  drivers/block/ublk_drv.c            |  2 +-
>  drivers/block/xen-blkback/xenbus.c  |  2 +-
>  drivers/block/xen-blkfront.c        |  2 +-
>  drivers/block/z2ram.c               |  2 +-
>  drivers/block/zram/zram_drv.c       |  6 ++---
>  drivers/cdrom/cdrom.c               |  4 +--
>  drivers/cdrom/gdrom.c               |  4 +--
>  drivers/md/bcache/bcache.h          |  2 +-
>  drivers/md/bcache/request.c         |  4 +--
>  drivers/md/bcache/super.c           |  6 ++---
>  drivers/md/dm-cache-target.c        | 12 ++++-----
>  drivers/md/dm-clone-target.c        | 10 +++----
>  drivers/md/dm-core.h                |  7 +++--
>  drivers/md/dm-era-target.c          |  6 +++--
>  drivers/md/dm-ioctl.c               | 10 +++----
>  drivers/md/dm-snap.c                |  4 +--
>  drivers/md/dm-table.c               | 11 ++++----
>  drivers/md/dm-thin.c                |  9 ++++---
>  drivers/md/dm-verity-fec.c          |  2 +-
>  drivers/md/dm-verity-target.c       |  6 ++---
>  drivers/md/dm.c                     | 10 +++----
>  drivers/md/dm.h                     |  2 +-
>  drivers/md/md.c                     |  8 +++---
>  drivers/mmc/core/block.c            |  8 +++---
>  drivers/mtd/devices/block2mtd.c     |  4 +--
>  drivers/mtd/mtd_blkdevs.c           |  4 +--
>  drivers/mtd/ubi/block.c             |  5 ++--
>  drivers/nvme/host/core.c            |  2 +-
>  drivers/nvme/host/ioctl.c           |  8 +++---
>  drivers/nvme/host/multipath.c       |  2 +-
>  drivers/nvme/host/nvme.h            |  4 +--
>  drivers/nvme/target/io-cmd-bdev.c   |  2 +-
>  drivers/s390/block/dasd.c           |  6 ++---
>  drivers/s390/block/dasd_genhd.c     |  3 ++-
>  drivers/s390/block/dasd_int.h       |  3 ++-
>  drivers/s390/block/dasd_ioctl.c     |  2 +-
>  drivers/s390/block/dcssblk.c        |  4 +--
>  drivers/scsi/sd.c                   | 19 ++++++-------
>  drivers/scsi/sr.c                   | 10 +++----
>  drivers/target/target_core_iblock.c |  5 ++--
>  drivers/target/target_core_pscsi.c  |  4 +--
>  fs/btrfs/dev-replace.c              |  2 +-
>  fs/btrfs/super.c                    |  4 +--
>  fs/btrfs/volumes.c                  | 16 +++++------
>  fs/btrfs/volumes.h                  |  4 +--
>  fs/erofs/super.c                    |  2 +-
>  fs/ext4/super.c                     |  2 +-
>  fs/jfs/jfs_logmgr.c                 |  2 +-
>  fs/nfs/blocklayout/dev.c            |  5 ++--
>  fs/ocfs2/cluster/heartbeat.c        |  3 ++-
>  fs/reiserfs/journal.c               |  4 +--
>  fs/xfs/xfs_super.c                  |  2 +-
>  include/linux/blkdev.h              | 30 ++++++++++++++++-----
>  include/linux/cdrom.h               |  3 ++-
>  include/linux/device-mapper.h       |  8 +++---
>  kernel/power/swap.c                 |  6 ++---
>  mm/swapfile.c                       |  2 +-
>  81 files changed, 324 insertions(+), 311 deletions(-)
> 
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 20c1a16199c503..50206feac577d5 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -108,9 +108,9 @@ static inline void ubd_set_bit(__u64 bit, unsigned char *data)
>  static DEFINE_MUTEX(ubd_lock);
>  static DEFINE_MUTEX(ubd_mutex); /* replaces BKL, might not be needed */
>  
> -static int ubd_open(struct gendisk *disk, fmode_t mode);
> +static int ubd_open(struct gendisk *disk, blk_mode_t mode);
>  static void ubd_release(struct gendisk *disk);
> -static int ubd_ioctl(struct block_device *bdev, fmode_t mode,
> +static int ubd_ioctl(struct block_device *bdev, blk_mode_t mode,
>  		     unsigned int cmd, unsigned long arg);
>  static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo);
>  
> @@ -1154,7 +1154,7 @@ static int __init ubd_driver_init(void){
>  
>  device_initcall(ubd_driver_init);
>  
> -static int ubd_open(struct gendisk *disk, fmode_t mode)
> +static int ubd_open(struct gendisk *disk, blk_mode_t mode)
>  {
>  	struct ubd *ubd_dev = disk->private_data;
>  	int err = 0;
> @@ -1389,7 +1389,7 @@ static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
>  	return 0;
>  }
>  
> -static int ubd_ioctl(struct block_device *bdev, fmode_t mode,
> +static int ubd_ioctl(struct block_device *bdev, blk_mode_t mode,
>  		     unsigned int cmd, unsigned long arg)
>  {
>  	struct ubd *ubd_dev = bdev->bd_disk->private_data;
> diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
> index 2ad9da3de0d90f..178cf96ca10acb 100644
> --- a/arch/xtensa/platforms/iss/simdisk.c
> +++ b/arch/xtensa/platforms/iss/simdisk.c
> @@ -120,7 +120,7 @@ static void simdisk_submit_bio(struct bio *bio)
>  	bio_endio(bio);
>  }
>  
> -static int simdisk_open(struct gendisk *disk, fmode_t mode)
> +static int simdisk_open(struct gendisk *disk, blk_mode_t mode)
>  {
>  	struct simdisk *dev = disk->private_data;
>  
> diff --git a/block/bdev.c b/block/bdev.c
> index db63e5bcc46ffa..bd558a9ba3cd97 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -93,7 +93,7 @@ EXPORT_SYMBOL(invalidate_bdev);
>   * Drop all buffers & page cache for given bdev range. This function bails
>   * with error if bdev has other exclusive owner (such as filesystem).
>   */
> -int truncate_bdev_range(struct block_device *bdev, fmode_t mode,
> +int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
>  			loff_t lstart, loff_t lend)
>  {
>  	/*
> @@ -101,14 +101,14 @@ int truncate_bdev_range(struct block_device *bdev, fmode_t mode,
>  	 * while we discard the buffer cache to avoid discarding buffers
>  	 * under live filesystem.
>  	 */
> -	if (!(mode & FMODE_EXCL)) {
> +	if (!(mode & BLK_OPEN_EXCL)) {
>  		int err = bd_prepare_to_claim(bdev, truncate_bdev_range, NULL);
>  		if (err)
>  			goto invalidate;
>  	}
>  
>  	truncate_inode_pages_range(bdev->bd_inode->i_mapping, lstart, lend);
> -	if (!(mode & FMODE_EXCL))
> +	if (!(mode & BLK_OPEN_EXCL))
>  		bd_abort_claiming(bdev, truncate_bdev_range);
>  	return 0;
>  
> @@ -647,7 +647,7 @@ static void blkdev_flush_mapping(struct block_device *bdev)
>  	bdev_write_inode(bdev);
>  }
>  
> -static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
> +static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
>  {
>  	struct gendisk *disk = bdev->bd_disk;
>  	int ret;
> @@ -679,7 +679,7 @@ static void blkdev_put_whole(struct block_device *bdev)
>  		bdev->bd_disk->fops->release(bdev->bd_disk);
>  }
>  
> -static int blkdev_get_part(struct block_device *part, fmode_t mode)
> +static int blkdev_get_part(struct block_device *part, blk_mode_t mode)
>  {
>  	struct gendisk *disk = part->bd_disk;
>  	int ret;
> @@ -743,11 +743,11 @@ void blkdev_put_no_open(struct block_device *bdev)
>  {
>  	put_device(&bdev->bd_device);
>  }
> -
> +	

nit: This is whitespace damage, I think. There's a trailing tab.

>  /**
>   * blkdev_get_by_dev - open a block device by device number
>   * @dev: device number of block device to open
> - * @mode: FMODE_* mask
> + * @mode: open mode (BLK_OPEN_*)
>   * @holder: exclusive holder identifier
>   * @hops: holder operations
>   *
> @@ -765,7 +765,7 @@ void blkdev_put_no_open(struct block_device *bdev)
>   * RETURNS:
>   * Reference to the block_device on success, ERR_PTR(-errno) on failure.
>   */
> -struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
> +struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>  		const struct blk_holder_ops *hops)
>  {
>  	bool unblock_events = true;
> @@ -775,8 +775,8 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
>  
>  	ret = devcgroup_check_permission(DEVCG_DEV_BLOCK,
>  			MAJOR(dev), MINOR(dev),
> -			((mode & FMODE_READ) ? DEVCG_ACC_READ : 0) |
> -			((mode & FMODE_WRITE) ? DEVCG_ACC_WRITE : 0));
> +			((mode & BLK_OPEN_READ) ? DEVCG_ACC_READ : 0) |
> +			((mode & BLK_OPEN_WRITE) ? DEVCG_ACC_WRITE : 0));
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> @@ -786,12 +786,12 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
>  	disk = bdev->bd_disk;
>  
>  	if (holder) {
> -		mode |= FMODE_EXCL;
> +		mode |= BLK_OPEN_EXCL;
>  		ret = bd_prepare_to_claim(bdev, holder, hops);
>  		if (ret)
>  			goto put_blkdev;
>  	} else {
> -		if (WARN_ON_ONCE(mode & FMODE_EXCL)) {
> +		if (WARN_ON_ONCE(mode & BLK_OPEN_EXCL)) {
>  			ret = -EIO;
>  			goto put_blkdev;
>  		}
> @@ -821,7 +821,7 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
>  		 * writeable reference is too fragile given the way @mode is
>  		 * used in blkdev_get/put().
>  		 */
> -		if ((mode & FMODE_WRITE) && !bdev->bd_write_holder &&
> +		if ((mode & BLK_OPEN_WRITE) && !bdev->bd_write_holder &&
>  		    (disk->event_flags & DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE)) {
>  			bdev->bd_write_holder = true;
>  			unblock_events = false;
> @@ -848,7 +848,7 @@ EXPORT_SYMBOL(blkdev_get_by_dev);
>  /**
>   * blkdev_get_by_path - open a block device by name
>   * @path: path to the block device to open
> - * @mode: FMODE_* mask
> + * @mode: open mode (BLK_OPEN_*)
>   * @holder: exclusive holder identifier
>   *
>   * Open the block device described by the device file at @path.  If @holder is
> @@ -861,7 +861,7 @@ EXPORT_SYMBOL(blkdev_get_by_dev);
>   * RETURNS:
>   * Reference to the block_device on success, ERR_PTR(-errno) on failure.
>   */
> -struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
> +struct block_device *blkdev_get_by_path(const char *path, blk_mode_t mode,
>  		void *holder, const struct blk_holder_ops *hops)
>  {
>  	struct block_device *bdev;
> @@ -873,7 +873,7 @@ struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
>  		return ERR_PTR(error);
>  
>  	bdev = blkdev_get_by_dev(dev, mode, holder, hops);
> -	if (!IS_ERR(bdev) && (mode & FMODE_WRITE) && bdev_read_only(bdev)) {
> +	if (!IS_ERR(bdev) && (mode & BLK_OPEN_WRITE) && bdev_read_only(bdev)) {
>  		blkdev_put(bdev, holder);
>  		return ERR_PTR(-EACCES);
>  	}
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 02cc2c629ac9be..0f9f97cdddd99c 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -356,8 +356,8 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, unsigned int cmd,
>  	return 0;
>  }
>  
> -static int blkdev_truncate_zone_range(struct block_device *bdev, fmode_t mode,
> -				      const struct blk_zone_range *zrange)
> +static int blkdev_truncate_zone_range(struct block_device *bdev,
> +		blk_mode_t mode, const struct blk_zone_range *zrange)
>  {
>  	loff_t start, end;
>  
> @@ -376,7 +376,7 @@ static int blkdev_truncate_zone_range(struct block_device *bdev, fmode_t mode,
>   * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl processing.
>   * Called from blkdev_ioctl.
>   */
> -int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
> +int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
>  			   unsigned int cmd, unsigned long arg)
>  {
>  	void __user *argp = (void __user *)arg;
> @@ -390,7 +390,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>  	if (!bdev_is_zoned(bdev))
>  		return -ENOTTY;
>  
> -	if (!(mode & FMODE_WRITE))
> +	if (!(mode & BLK_OPEN_WRITE))
>  		return -EBADF;
>  
>  	if (copy_from_user(&zrange, argp, sizeof(struct blk_zone_range)))
> diff --git a/block/blk.h b/block/blk.h
> index e28d5d67d31a28..768852a84fefb3 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -396,7 +396,7 @@ void disk_free_zone_bitmaps(struct gendisk *disk);
>  void disk_clear_zone_settings(struct gendisk *disk);
>  int blkdev_report_zones_ioctl(struct block_device *bdev, unsigned int cmd,
>  		unsigned long arg);
> -int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
> +int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
>  		unsigned int cmd, unsigned long arg);
>  #else /* CONFIG_BLK_DEV_ZONED */
>  static inline void disk_free_zone_bitmaps(struct gendisk *disk) {}
> @@ -407,7 +407,7 @@ static inline int blkdev_report_zones_ioctl(struct block_device *bdev,
>  	return -ENOTTY;
>  }
>  static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
> -		fmode_t mode, unsigned int cmd, unsigned long arg)
> +		blk_mode_t mode, unsigned int cmd, unsigned long arg)
>  {
>  	return -ENOTTY;
>  }
> @@ -451,7 +451,7 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
>  
>  struct request_queue *blk_alloc_queue(int node_id);
>  
> -int disk_scan_partitions(struct gendisk *disk, fmode_t mode);
> +int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
>  
>  int disk_alloc_events(struct gendisk *disk);
>  void disk_add_events(struct gendisk *disk);
> @@ -466,8 +466,9 @@ extern struct device_attribute dev_attr_events_poll_msecs;
>  
>  extern struct attribute_group blk_trace_attr_group;
>  
> -int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
> -		loff_t lend);
> +blk_mode_t file_to_blk_mode(struct file *file);
> +int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
> +		loff_t lstart, loff_t lend);
>  long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
>  long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
>  
> diff --git a/block/fops.c b/block/fops.c
> index 9f26e25bafa172..928c37a214f785 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -470,6 +470,24 @@ static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
>  	return error;
>  }
>  
> +blk_mode_t file_to_blk_mode(struct file *file)
> +{
> +	blk_mode_t mode = 0;
> +
> +	if (file->f_mode & FMODE_READ)
> +		mode |= BLK_OPEN_READ;
> +	if (file->f_mode & FMODE_WRITE)
> +		mode |= BLK_OPEN_WRITE;
> +	if (file->f_mode & FMODE_EXCL)
> +		mode |= BLK_OPEN_EXCL;
> +	if ((file->f_flags & O_ACCMODE) == 3)

I really don't like magic numbers like this.

Groan, O_RDONLY being defined as 0 strikes again...
Becuase of this quirk we internally map

O_RDONLY(0) -> FMODE_READ(1)
O_WRONLY(1) -> FMODE_WRITE(2)
O_RDWR(3)   -> (FMODE_READ | FMODE_WRITE)

so checking for the raw 3 here is confusing in addition to being a magic
number as it could give the impression that what's checked here is
(O_WRONLY | O_RDWR) which doesn't make sense...

So my perference would be in descending order of preference:

(file->f_flags & O_ACCMODE) == (FMODE_READ | FMODE_WRITE)

or while a little less clear but informative enough for people familiar
with the O_RDONLY quirk:

if ((file->f_flags & O_ACCMODE) == O_ACCMODE)
