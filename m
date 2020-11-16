Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2EE2B47F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 16:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbgKPPAT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 10:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731176AbgKPPAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:00:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E9DC0613CF;
        Mon, 16 Nov 2020 07:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qT96BeHilVft1JkG10iCrLJR6muck82GuXTsF+6HaBs=; b=HgOm4x8yBW2tnGE4ZX83eavFQ1
        f+qiZeutF3C4x7tuDGFh++e5/QiXl2bHAz05M5M3dUddIxY+Y/evoUTbHl2ZIlekRUKqyhE5E0PVX
        hMFXVk/Jptmtqg7zb6DuiwaXED2QI0Al/Pw8e16nbsMp0jFR4NBY6hKDRfpALL6DpKxh5ZyNmlQb4
        dTi19AUznD+xt+W/9664dH7K0sC5bsfYZaGYXpE4CzAaURhA3tKbMezxtPpka8je7m82AxuOo9z0k
        0qEQF/Fuu296FLCSW86j5ha3QmhlH1fFdD03H8DB5ds5kjLX5SbWCnFvDV9qvWn2BOewIEOKsLbJW
        BVLz5ydg==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefz9-0004L7-5x; Mon, 16 Nov 2020 15:00:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 78/78] block: remove i_bdev
Date:   Mon, 16 Nov 2020 15:58:09 +0100
Message-Id: <20201116145809.410558-79-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch the block device lookup interfaces to directly work with a dev_t
so that struct block_device references are only acquired by the
blkdev_get variants (and the blk-cgroup special case).  This means that
we not don't need an extra reference in the inode.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/ioctl.c                                |   3 +-
 drivers/block/loop.c                         |   8 +-
 drivers/md/dm-table.c                        |   9 +-
 drivers/mtd/mtdsuper.c                       |  17 +-
 drivers/target/target_core_file.c            |   6 +-
 drivers/usb/gadget/function/storage_common.c |   8 +-
 fs/block_dev.c                               | 206 +++++--------------
 fs/btrfs/volumes.c                           |  13 +-
 fs/inode.c                                   |   3 -
 fs/internal.h                                |   6 +-
 fs/io_uring.c                                |   2 +-
 fs/pipe.c                                    |   5 +-
 fs/quota/quota.c                             |  31 +--
 fs/statfs.c                                  |   2 +-
 fs/super.c                                   |  63 ++----
 include/linux/blkdev.h                       |   2 +-
 include/linux/fs.h                           |   4 +-
 17 files changed, 114 insertions(+), 274 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 7207b716b6c9a7..39341409927607 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -602,8 +602,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 {
 	int ret;
 	void __user *argp = compat_ptr(arg);
-	struct inode *inode = file->f_mapping->host;
-	struct block_device *bdev = inode->i_bdev;
+	struct block_device *bdev = I_BDEV(file->f_mapping->host);
 	struct gendisk *disk = bdev->bd_disk;
 	fmode_t mode = file->f_mode;
 	loff_t size;
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 91e47c5b52f1cb..4a0037586f93b2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -675,10 +675,10 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 	while (is_loop_device(f)) {
 		struct loop_device *l;
 
-		if (f->f_mapping->host->i_bdev == bdev)
+		if (f->f_mapping->host->i_rdev == bdev->bd_dev)
 			return -EBADF;
 
-		l = f->f_mapping->host->i_bdev->bd_disk->private_data;
+		l = I_BDEV(f->f_mapping->host)->bd_disk->private_data;
 		if (l->lo_state != Lo_bound) {
 			return -EINVAL;
 		}
@@ -885,9 +885,7 @@ static void loop_config_discard(struct loop_device *lo)
 	 * file-backed loop devices: discarded regions read back as zero.
 	 */
 	if (S_ISBLK(inode->i_mode) && !lo->lo_encrypt_key_size) {
-		struct request_queue *backingq;
-
-		backingq = bdev_get_queue(inode->i_bdev);
+		struct request_queue *backingq = bdev_get_queue(I_BDEV(inode));
 
 		max_discard_sectors = backingq->limits.max_write_zeroes_sectors;
 		granularity = backingq->limits.discard_granularity ?:
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index ce543b761be7b2..dea67772171053 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -348,16 +348,9 @@ static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode,
 dev_t dm_get_dev_t(const char *path)
 {
 	dev_t dev;
-	struct block_device *bdev;
 
-	bdev = lookup_bdev(path);
-	if (IS_ERR(bdev))
+	if (lookup_bdev(path, &dev))
 		dev = name_to_dev_t(path);
-	else {
-		dev = bdev->bd_dev;
-		bdput(bdev);
-	}
-
 	return dev;
 }
 EXPORT_SYMBOL_GPL(dm_get_dev_t);
diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index c3e2098372f2e5..38b6aa849c6383 100644
--- a/drivers/mtd/mtdsuper.c
+++ b/drivers/mtd/mtdsuper.c
@@ -120,8 +120,8 @@ int get_tree_mtd(struct fs_context *fc,
 				struct fs_context *fc))
 {
 #ifdef CONFIG_BLOCK
-	struct block_device *bdev;
-	int ret, major;
+	dev_t dev;
+	int ret;
 #endif
 	int mtdnr;
 
@@ -169,20 +169,15 @@ int get_tree_mtd(struct fs_context *fc,
 	/* try the old way - the hack where we allowed users to mount
 	 * /dev/mtdblock$(n) but didn't actually _use_ the blockdev
 	 */
-	bdev = lookup_bdev(fc->source);
-	if (IS_ERR(bdev)) {
-		ret = PTR_ERR(bdev);
+	ret = lookup_bdev(fc->source, &dev);
+	if (ret) {
 		errorf(fc, "MTD: Couldn't look up '%s': %d", fc->source, ret);
 		return ret;
 	}
 	pr_debug("MTDSB: lookup_bdev() returned 0\n");
 
-	major = MAJOR(bdev->bd_dev);
-	mtdnr = MINOR(bdev->bd_dev);
-	bdput(bdev);
-
-	if (major == MTD_BLOCK_MAJOR)
-		return mtd_get_sb_by_nr(fc, mtdnr, fill_super);
+	if (MAJOR(dev) == MTD_BLOCK_MAJOR)
+		return mtd_get_sb_by_nr(fc, MINOR(dev), fill_super);
 
 #endif /* CONFIG_BLOCK */
 
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 7143d03f0e027e..b0cb5b95e892d3 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -133,10 +133,10 @@ static int fd_configure_device(struct se_device *dev)
 	 */
 	inode = file->f_mapping->host;
 	if (S_ISBLK(inode->i_mode)) {
-		struct request_queue *q = bdev_get_queue(inode->i_bdev);
+		struct request_queue *q = bdev_get_queue(I_BDEV(inode));
 		unsigned long long dev_size;
 
-		fd_dev->fd_block_size = bdev_logical_block_size(inode->i_bdev);
+		fd_dev->fd_block_size = bdev_logical_block_size(I_BDEV(inode));
 		/*
 		 * Determine the number of bytes from i_size_read() minus
 		 * one (1) logical sector from underlying struct block_device
@@ -559,7 +559,7 @@ fd_execute_unmap(struct se_cmd *cmd, sector_t lba, sector_t nolb)
 
 	if (S_ISBLK(inode->i_mode)) {
 		/* The backend is block device, use discard */
-		struct block_device *bdev = inode->i_bdev;
+		struct block_device *bdev = I_BDEV(inode);
 		struct se_device *dev = cmd->se_dev;
 
 		ret = blkdev_issue_discard(bdev,
diff --git a/drivers/usb/gadget/function/storage_common.c b/drivers/usb/gadget/function/storage_common.c
index f7e6c42558eb76..b859a158a4140e 100644
--- a/drivers/usb/gadget/function/storage_common.c
+++ b/drivers/usb/gadget/function/storage_common.c
@@ -204,7 +204,7 @@ int fsg_lun_open(struct fsg_lun *curlun, const char *filename)
 	if (!(filp->f_mode & FMODE_WRITE))
 		ro = 1;
 
-	inode = file_inode(filp);
+	inode = filp->f_mapping->host;
 	if ((!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))) {
 		LINFO(curlun, "invalid file type: %s\n", filename);
 		goto out;
@@ -221,7 +221,7 @@ int fsg_lun_open(struct fsg_lun *curlun, const char *filename)
 	if (!(filp->f_mode & FMODE_CAN_WRITE))
 		ro = 1;
 
-	size = i_size_read(inode->i_mapping->host);
+	size = i_size_read(inode);
 	if (size < 0) {
 		LINFO(curlun, "unable to find file size: %s\n", filename);
 		rc = (int) size;
@@ -231,8 +231,8 @@ int fsg_lun_open(struct fsg_lun *curlun, const char *filename)
 	if (curlun->cdrom) {
 		blksize = 2048;
 		blkbits = 11;
-	} else if (inode->i_bdev) {
-		blksize = bdev_logical_block_size(inode->i_bdev);
+	} else if (S_ISBLK(inode->i_mode)) {
+		blksize = bdev_logical_block_size(I_BDEV(inode));
 		blkbits = blksize_bits(blksize);
 	} else {
 		blksize = 512;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index e1457bf76c6f34..6b43ee6ee571df 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -523,7 +523,7 @@ EXPORT_SYMBOL(sync_blockdev);
  */
 int fsync_bdev(struct block_device *bdev)
 {
-	struct super_block *sb = get_super(bdev);
+	struct super_block *sb = get_super(bdev->bd_dev, false);
 	if (sb) {
 		int res = sync_filesystem(sb);
 		drop_super(sb);
@@ -557,7 +557,7 @@ struct super_block *freeze_bdev(struct block_device *bdev)
 		 * to freeze_bdev grab an active reference and only the last
 		 * thaw_bdev drops it.
 		 */
-		sb = get_super(bdev);
+		sb = get_super(bdev->bd_dev, false);
 		if (sb)
 			drop_super(sb);
 		mutex_unlock(&bdev->bd_fsfreeze_mutex);
@@ -890,7 +890,6 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 
 	inode->i_mode = S_IFBLK;
 	inode->i_rdev = 0;
-	inode->i_bdev = bdev;
 	inode->i_data.a_ops = &def_blk_aops;
 
 	return bdev;
@@ -942,71 +941,8 @@ void bdput(struct block_device *bdev)
 {
 	iput(bdev->bd_inode);
 }
-
 EXPORT_SYMBOL(bdput);
  
-static struct block_device *bd_acquire(struct inode *inode)
-{
-	struct block_device *bdev;
-
-	spin_lock(&bdev_lock);
-	bdev = inode->i_bdev;
-	if (bdev && !inode_unhashed(bdev->bd_inode)) {
-		bdgrab(bdev);
-		spin_unlock(&bdev_lock);
-		return bdev;
-	}
-	spin_unlock(&bdev_lock);
-
-	/*
-	 * i_bdev references block device inode that was already shut down
-	 * (corresponding device got removed).  Remove the reference and look
-	 * up block device inode again just in case new device got
-	 * reestablished under the same device number.
-	 */
-	if (bdev)
-		bd_forget(inode);
-
-	bdev = bdget(inode->i_rdev);
-	if (!bdev) {
-		blk_request_module(inode->i_rdev);
-		bdev = bdget(inode->i_rdev);
-	}
-	if (bdev) {
-		spin_lock(&bdev_lock);
-		if (!inode->i_bdev) {
-			/*
-			 * We take an additional reference to bd_inode,
-			 * and it's released in clear_inode() of inode.
-			 * So, we can access it via ->i_mapping always
-			 * without igrab().
-			 */
-			bdgrab(bdev);
-			inode->i_bdev = bdev;
-			inode->i_mapping = bdev->bd_inode->i_mapping;
-		}
-		spin_unlock(&bdev_lock);
-	}
-	return bdev;
-}
-
-/* Call when you free inode */
-
-void bd_forget(struct inode *inode)
-{
-	struct block_device *bdev = NULL;
-
-	spin_lock(&bdev_lock);
-	if (!sb_is_blkdev_sb(inode->i_sb))
-		bdev = inode->i_bdev;
-	inode->i_bdev = NULL;
-	inode->i_mapping = &inode->i_data;
-	spin_unlock(&bdev_lock);
-
-	if (bdev)
-		bdput(bdev);
-}
-
 /**
  * bd_may_claim - test whether a block device can be claimed
  * @bdev: block device of interest
@@ -1485,32 +1421,44 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 }
 
 /**
- * blkdev_get - open a block device
- * @bdev: block_device to open
+ * blkdev_get_by_dev - open a block device by device number
+ * @dev: device number of block device to open
  * @mode: FMODE_* mask
  * @holder: exclusive holder identifier
  *
- * Open @bdev with @mode.  If @mode includes %FMODE_EXCL, @bdev is
- * open with exclusive access.  Specifying %FMODE_EXCL with %NULL
- * @holder is invalid.  Exclusive opens may nest for the same @holder.
+ * Open the block device described by device number @dev.  If @mode includes
+ * If @mode includes %FMODE_EXCL, the block device is opened with exclusive
+ * access.  Specifying %FMODE_EXCL with a %NULL @holder is invalid.  Exclusive
+ * opens may nest for the same @holder.
  *
- * On success, the reference count of @bdev is unchanged.  On failure,
- * @bdev is put.
+ * Use this interface ONLY if you really do not have anything better - i.e. when
+ * you are behind a truly sucky interface and all you are given is a device
+ * number.  Everything else should use blkdev_get_by_path().
  *
  * CONTEXT:
  * Might sleep.
  *
  * RETURNS:
- * 0 on success, -errno on failure.
+ * Reference to the block_device on success, ERR_PTR(-errno) on failure.
  */
-static int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
+struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 {
+	struct block_device *bdev;
 	int ret, perm = 0;
 
 	if (mode & FMODE_READ)
 		perm |= MAY_READ;
 	if (mode & FMODE_WRITE)
 		perm |= MAY_WRITE;
+
+	bdev = bdget(dev);
+	if (!bdev) {
+		blk_request_module(dev);
+		bdev = bdget(dev);
+		if (!bdev)
+			return ERR_PTR(-ENOMEM);
+	}
+
 	ret = devcgroup_inode_permission(bdev->bd_inode, perm);
 	if (ret)
 		goto bdput;
@@ -1522,8 +1470,9 @@ static int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 
 bdput:
 	bdput(bdev);
-	return ret;
+	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL(blkdev_get_by_dev);
 
 /**
  * blkdev_get_by_path - open a block device by name
@@ -1531,32 +1480,31 @@ static int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
  * @mode: FMODE_* mask
  * @holder: exclusive holder identifier
  *
- * Open the blockdevice described by the device file at @path.  @mode
- * and @holder are identical to blkdev_get().
+ * Open the block device described by the device file at &path.
  *
- * On success, the returned block_device has reference count of one.
+ * If @mode includes %FMODE_EXCL, the block device is opened with exclusive
+ * access.  Specifying %FMODE_EXCL with a %NULL @holder is invalid.  Exclusive
+ * opens may nest for the same @holder.
  *
  * CONTEXT:
  * Might sleep.
  *
  * RETURNS:
- * Pointer to block_device on success, ERR_PTR(-errno) on failure.
+ * Reference to the block_device on success, ERR_PTR(-errno) on failure.
  */
 struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 					void *holder)
 {
 	struct block_device *bdev;
-	int err;
-
-	bdev = lookup_bdev(path);
-	if (IS_ERR(bdev))
-		return bdev;
+	dev_t dev;
+	int error;
 
-	err = blkdev_get(bdev, mode, holder);
-	if (err)
-		return ERR_PTR(err);
+	error = lookup_bdev(path, &dev);
+	if (error)
+		return ERR_PTR(error);
 
-	if ((mode & FMODE_WRITE) && bdev_read_only(bdev)) {
+	bdev = blkdev_get_by_dev(dev, mode, holder);
+	if (!IS_ERR(bdev) && (mode & FMODE_WRITE) && bdev_read_only(bdev)) {
 		blkdev_put(bdev, mode);
 		return ERR_PTR(-EACCES);
 	}
@@ -1565,49 +1513,6 @@ struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 }
 EXPORT_SYMBOL(blkdev_get_by_path);
 
-/**
- * blkdev_get_by_dev - open a block device by device number
- * @dev: device number of block device to open
- * @mode: FMODE_* mask
- * @holder: exclusive holder identifier
- *
- * Open the blockdevice described by device number @dev.  @mode and
- * @holder are identical to blkdev_get().
- *
- * Use it ONLY if you really do not have anything better - i.e. when
- * you are behind a truly sucky interface and all you are given is a
- * device number.  _Never_ to be used for internal purposes.  If you
- * ever need it - reconsider your API.
- *
- * On success, the returned block_device has reference count of one.
- *
- * CONTEXT:
- * Might sleep.
- *
- * RETURNS:
- * Pointer to block_device on success, ERR_PTR(-errno) on failure.
- */
-struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
-{
-	struct block_device *bdev;
-	int err;
-
-	bdev = bdget(dev);
-	if (!bdev) {
-		blk_request_module(dev);
-		bdev = bdget(dev);
-	}
-	if (!bdev)
-		return ERR_PTR(-ENOMEM);
-
-	err = blkdev_get(bdev, mode, holder);
-	if (err)
-		return ERR_PTR(err);
-
-	return bdev;
-}
-EXPORT_SYMBOL(blkdev_get_by_dev);
-
 static int blkdev_open(struct inode * inode, struct file * filp)
 {
 	struct block_device *bdev;
@@ -1629,14 +1534,12 @@ static int blkdev_open(struct inode * inode, struct file * filp)
 	if ((filp->f_flags & O_ACCMODE) == 3)
 		filp->f_mode |= FMODE_WRITE_IOCTL;
 
-	bdev = bd_acquire(inode);
-	if (bdev == NULL)
-		return -ENOMEM;
-
+	bdev = blkdev_get_by_dev(inode->i_rdev, filp->f_mode, filp);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
 	filp->f_mapping = bdev->bd_inode->i_mapping;
 	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
-
-	return blkdev_get(bdev, filp->f_mode, filp);
+	return 0;
 }
 
 static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
@@ -1939,43 +1842,38 @@ const struct file_operations def_blk_fops = {
  * namespace if possible and return it.  Return ERR_PTR(error)
  * otherwise.
  */
-struct block_device *lookup_bdev(const char *pathname)
+int lookup_bdev(const char *pathname, dev_t *dev)
 {
-	struct block_device *bdev;
 	struct inode *inode;
 	struct path path;
 	int error;
 
 	if (!pathname || !*pathname)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	error = kern_path(pathname, LOOKUP_FOLLOW, &path);
 	if (error)
-		return ERR_PTR(error);
+		return error;
 
 	inode = d_backing_inode(path.dentry);
 	error = -ENOTBLK;
 	if (!S_ISBLK(inode->i_mode))
-		goto fail;
+		goto out_path_put;
 	error = -EACCES;
 	if (!may_open_dev(&path))
-		goto fail;
-	error = -ENOMEM;
-	bdev = bd_acquire(inode);
-	if (!bdev)
-		goto fail;
-out:
+		goto out_path_put;
+
+	*dev = inode->i_rdev;
+	error = 0;
+out_path_put:
 	path_put(&path);
-	return bdev;
-fail:
-	bdev = ERR_PTR(error);
-	goto out;
+	return error;
 }
 EXPORT_SYMBOL(lookup_bdev);
 
 int __invalidate_device(struct block_device *bdev, bool kill_dirty)
 {
-	struct super_block *sb = get_super(bdev);
+	struct super_block *sb = get_super(bdev->bd_dev, false);
 	int res = 0;
 
 	if (sb) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ce43732f945f45..76dedfcbd03716 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -929,16 +929,16 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		 * make sure it's the same device if the device is mounted
 		 */
 		if (device->bdev) {
-			struct block_device *path_bdev;
+			int error;
+			dev_t path_dev;
 
-			path_bdev = lookup_bdev(path);
-			if (IS_ERR(path_bdev)) {
+			error = lookup_bdev(path, &path_dev);
+			if (error) {
 				mutex_unlock(&fs_devices->device_list_mutex);
-				return ERR_CAST(path_bdev);
+				return ERR_PTR(error);
 			}
 
-			if (device->bdev != path_bdev) {
-				bdput(path_bdev);
+			if (device->bdev->bd_dev != path_dev) {
 				mutex_unlock(&fs_devices->device_list_mutex);
 				btrfs_warn_in_rcu(device->fs_info,
 	"duplicate device %s devid %llu generation %llu scanned by %s (%d)",
@@ -947,7 +947,6 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 						  task_pid_nr(current));
 				return ERR_PTR(-EEXIST);
 			}
-			bdput(path_bdev);
 			btrfs_info_in_rcu(device->fs_info,
 	"devid %llu device path %s changed to %s scanned by %s (%d)",
 					  devid, rcu_str_deref(device->name),
diff --git a/fs/inode.c b/fs/inode.c
index 9d78c37b00b817..cb008acf0efdb8 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -155,7 +155,6 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_bytes = 0;
 	inode->i_generation = 0;
 	inode->i_pipe = NULL;
-	inode->i_bdev = NULL;
 	inode->i_cdev = NULL;
 	inode->i_link = NULL;
 	inode->i_dir_seq = 0;
@@ -580,8 +579,6 @@ static void evict(struct inode *inode)
 		truncate_inode_pages_final(&inode->i_data);
 		clear_inode(inode);
 	}
-	if (S_ISBLK(inode->i_mode) && inode->i_bdev)
-		bd_forget(inode);
 	if (S_ISCHR(inode->i_mode) && inode->i_cdev)
 		cd_forget(inode);
 
diff --git a/fs/internal.h b/fs/internal.h
index a7cd0f64faa4ab..36f87f0ac4f969 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -25,7 +25,6 @@ extern void __init bdev_cache_init(void);
 extern int __sync_blockdev(struct block_device *bdev, int wait);
 void iterate_bdevs(void (*)(struct block_device *, void *), void *);
 void emergency_thaw_bdev(struct super_block *sb);
-void bd_forget(struct inode *inode);
 #else
 static inline void bdev_cache_init(void)
 {
@@ -43,9 +42,6 @@ static inline int emergency_thaw_bdev(struct super_block *sb)
 {
 	return 0;
 }
-static inline void bd_forget(struct inode *inode)
-{
-}
 #endif /* CONFIG_BLOCK */
 
 /*
@@ -114,7 +110,7 @@ extern struct file *alloc_empty_file_noaccount(int, const struct cred *);
  */
 extern int reconfigure_super(struct fs_context *);
 extern bool trylock_super(struct super_block *sb);
-extern struct super_block *user_get_super(dev_t);
+struct super_block *get_super(dev_t, bool excl);
 extern bool mount_capable(struct fs_context *);
 
 /*
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4ead291b2976f3..84d2fae8518471 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2733,7 +2733,7 @@ static bool io_file_supports_async(struct file *file, int rw)
 	umode_t mode = file_inode(file)->i_mode;
 
 	if (S_ISBLK(mode)) {
-		if (io_bdev_nowait(file->f_inode->i_bdev))
+		if (io_bdev_nowait(I_BDEV(file->f_mapping->host)))
 			return true;
 		return false;
 	}
diff --git a/fs/pipe.c b/fs/pipe.c
index 0ac197658a2d6e..c5989cfd564d45 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1342,9 +1342,8 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 }
 
 /*
- * After the inode slimming patch, i_pipe/i_bdev/i_cdev share the same
- * location, so checking ->i_pipe is not enough to verify that this is a
- * pipe.
+ * Note that i_pipe and i_cdev share the same location, so checking ->i_pipe is
+ * not enough to verify that this is a pipe.
  */
 struct pipe_inode_info *get_pipe_info(struct file *file, bool for_splice)
 {
diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 21d43933213965..3087225b90880c 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -20,6 +20,7 @@
 #include <linux/writeback.h>
 #include <linux/nospec.h>
 #include "compat.h"
+#include "../internal.h"
 
 static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
 				     qid_t id)
@@ -864,31 +865,31 @@ static bool quotactl_cmd_onoff(int cmd)
  */
 static struct super_block *quotactl_block(const char __user *special, int cmd)
 {
-#ifdef CONFIG_BLOCK
-	struct block_device *bdev;
 	struct super_block *sb;
-	struct filename *tmp = getname(special);
+	struct filename *tmp;
+	int error;
+	dev_t dev;
+
+	if (!IS_ENABLED(CONFIG_BLOCK))
+		return ERR_PTR(-ENODEV);
 
+	tmp = getname(special);
 	if (IS_ERR(tmp))
 		return ERR_CAST(tmp);
-	bdev = lookup_bdev(tmp->name);
-	putname(tmp);
-	if (IS_ERR(bdev))
-		return ERR_CAST(bdev);
+	error = lookup_bdev(tmp->name, &dev);
+	if (error)
+		return ERR_PTR(error);
+
 	if (quotactl_cmd_onoff(cmd))
-		sb = get_super_thawed(bdev, true);
+		sb = get_super_thawed(dev, true);
 	else if (quotactl_cmd_write(cmd))
-		sb = get_super_thawed(bdev, false);
+		sb = get_super_thawed(dev, false);
 	else
-		sb = get_super(bdev);
-	bdput(bdev);
+		sb = get_super(dev, false);
+
 	if (!sb)
 		return ERR_PTR(-ENODEV);
-
 	return sb;
-#else
-	return ERR_PTR(-ENODEV);
-#endif
 }
 
 /*
diff --git a/fs/statfs.c b/fs/statfs.c
index 59f33752c1311f..52230a9814337a 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -235,7 +235,7 @@ SYSCALL_DEFINE3(fstatfs64, unsigned int, fd, size_t, sz, struct statfs64 __user
 
 static int vfs_ustat(dev_t dev, struct kstatfs *sbuf)
 {
-	struct super_block *s = user_get_super(dev);
+	struct super_block *s = get_super(dev);
 	int err;
 	if (!s)
 		return -EINVAL;
diff --git a/fs/super.c b/fs/super.c
index 50995f8abd1bf1..ffc16e4eee99c4 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -740,19 +740,25 @@ void iterate_supers_type(struct file_system_type *type,
 
 EXPORT_SYMBOL(iterate_supers_type);
 
-static struct super_block *__get_super(struct block_device *bdev, bool excl)
+/**
+ * get_super - get the superblock of a device
+ * @dev: device to get the superblock for
+ * @excl: lock s_umount exclusive if %true, else shared.
+ *
+ * Scans the superblock list and finds the superblock of the file system mounted
+ * on the device.  The superblock is returned with s_umount held, or %NULL if no
+ * superblock was found.
+ */
+struct super_block *get_super(dev_t dev, bool excl)
 {
 	struct super_block *sb;
 
-	if (!bdev)
-		return NULL;
-
 	spin_lock(&sb_lock);
 rescan:
 	list_for_each_entry(sb, &super_blocks, s_list) {
 		if (hlist_unhashed(&sb->s_instances))
 			continue;
-		if (sb->s_bdev == bdev) {
+		if (sb->s_dev == dev) {
 			sb->s_count++;
 			spin_unlock(&sb_lock);
 			if (!excl)
@@ -776,22 +782,9 @@ static struct super_block *__get_super(struct block_device *bdev, bool excl)
 	return NULL;
 }
 
-/**
- *	get_super - get the superblock of a device
- *	@bdev: device to get the superblock for
- *
- *	Scans the superblock list and finds the superblock of the file system
- *	mounted on the device given. %NULL is returned if no match is found.
- */
-struct super_block *get_super(struct block_device *bdev)
-{
-	return __get_super(bdev, false);
-}
-EXPORT_SYMBOL(get_super);
-
 /**
  * get_super_thawed - get thawed superblock of a device
- * @bdev: device to get the superblock for
+ * @dev: device to get the superblock for
  * @excl: lock s_umount exclusive if %true, else shared.
  *
  * Scans the superblock list and finds the superblock of the file system mounted
@@ -799,10 +792,11 @@ EXPORT_SYMBOL(get_super);
  * thawed (or immediately if it was not frozen), or %NULL if no superblock was
  * found.
  */
-struct super_block *get_super_thawed(struct block_device *bdev, bool excl)
+struct super_block *get_super_thawed(dev_t dev, bool excl)
 {
 	while (1) {
-		struct super_block *s = __get_super(bdev, excl);
+		struct super_block *s = get_super(dev, excl);
+
 		if (!s || s->s_writers.frozen == SB_UNFROZEN)
 			return s;
 		if (!excl)
@@ -847,33 +841,6 @@ struct super_block *get_active_super(struct block_device *bdev)
 	return NULL;
 }
 
-struct super_block *user_get_super(dev_t dev)
-{
-	struct super_block *sb;
-
-	spin_lock(&sb_lock);
-rescan:
-	list_for_each_entry(sb, &super_blocks, s_list) {
-		if (hlist_unhashed(&sb->s_instances))
-			continue;
-		if (sb->s_dev ==  dev) {
-			sb->s_count++;
-			spin_unlock(&sb_lock);
-			down_read(&sb->s_umount);
-			/* still alive? */
-			if (sb->s_root && (sb->s_flags & SB_BORN))
-				return sb;
-			up_read(&sb->s_umount);
-			/* nope, got unmounted */
-			spin_lock(&sb_lock);
-			__put_super(sb);
-			goto rescan;
-		}
-	}
-	spin_unlock(&sb_lock);
-	return NULL;
-}
-
 /**
  * reconfigure_super - asks filesystem to change superblock parameters
  * @fc: The superblock and configuration
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ed40144ab80339..9dc44f1ae22bb1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1973,7 +1973,7 @@ int bdev_read_only(struct block_device *bdev);
 int set_blocksize(struct block_device *bdev, int size);
 
 const char *bdevname(struct block_device *bdev, char *buffer);
-struct block_device *lookup_bdev(const char *);
+int lookup_bdev(const char *pathname, dev_t *dev);
 
 void blkdev_show(struct seq_file *seqf, off_t offset);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d026d177a526bf..bd16b8ad5dde32 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -696,7 +696,6 @@ struct inode {
 	struct list_head	i_devices;
 	union {
 		struct pipe_inode_info	*i_pipe;
-		struct block_device	*i_bdev;
 		struct cdev		*i_cdev;
 		char			*i_link;
 		unsigned		i_dir_seq;
@@ -3131,8 +3130,7 @@ extern int vfs_readlink(struct dentry *, char __user *, int);
 extern struct file_system_type *get_filesystem(struct file_system_type *fs);
 extern void put_filesystem(struct file_system_type *fs);
 extern struct file_system_type *get_fs_type(const char *name);
-extern struct super_block *get_super(struct block_device *);
-struct super_block *get_super_thawed(struct block_device *bdev, bool excl);
+struct super_block *get_super_thawed(dev_t dev, bool excl);
 extern struct super_block *get_active_super(struct block_device *bdev);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
-- 
2.29.2

