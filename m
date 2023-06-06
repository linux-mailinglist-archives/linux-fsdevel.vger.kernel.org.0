Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9DE72399B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 09:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbjFFHlt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 03:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbjFFHlL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:41:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921C210E5;
        Tue,  6 Jun 2023 00:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nsTIQq0yPhUHECHS2iOtlxITsx7uO6845aNJ/XCeuAo=; b=Gx7BMSabHUVGyJXst+kqOEG7Jv
        bm5z+0d8YD73a6kONpH4l2+xcZFOU2Lc1u4K2VLOl/xen6EcVsywc79XZYR0ecelStRC9RylcLtZ7
        O57YU3o5ct2gnSRsXfNs6vilAOL0nm3nAdA8Bc96fD/79G00bcq9wf3yVsM0dwxzsdWxrxsWNZdXG
        zvu46A5hy2JV6paNu2JtSPVOLtI0yHq6WcJ4aom+wvKW90Oy//6UaMEZxQCL8hL+WaKYWY0OYKl+C
        daBFYnXcrMukKdh+Nbueo7XO2X+KrxIToa7CoehCj5KJKl4YAKZtqMA2A+jGEDEPTxrXwxxQFuDhe
        IFoUSOsg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6RIk-000Yyk-2T;
        Tue, 06 Jun 2023 07:40:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
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
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 09/31] block: pass a gendisk to ->open
Date:   Tue,  6 Jun 2023 09:39:28 +0200
Message-Id: <20230606073950.225178-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606073950.225178-1-hch@lst.de>
References: <20230606073950.225178-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

->open is only called on the whole device.  Make that explicit by
passing a gendisk instead of the block_device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c          |  5 ++---
 arch/xtensa/platforms/iss/simdisk.c |  4 ++--
 block/bdev.c                        |  2 +-
 drivers/block/amiflop.c             |  8 ++++----
 drivers/block/aoe/aoeblk.c          |  4 ++--
 drivers/block/ataflop.c             | 16 +++++++--------
 drivers/block/drbd/drbd_main.c      |  6 +++---
 drivers/block/floppy.c              | 30 +++++++++++++++--------------
 drivers/block/nbd.c                 |  8 ++++----
 drivers/block/pktcdvd.c             |  6 +++---
 drivers/block/rbd.c                 |  4 ++--
 drivers/block/rnbd/rnbd-clt.c       |  4 ++--
 drivers/block/swim.c                | 10 +++++-----
 drivers/block/swim3.c               | 10 +++++-----
 drivers/block/ublk_drv.c            |  4 ++--
 drivers/block/z2ram.c               |  6 ++----
 drivers/block/zram/zram_drv.c       | 13 +++++--------
 drivers/cdrom/gdrom.c               |  4 ++--
 drivers/md/bcache/super.c           |  4 ++--
 drivers/md/dm.c                     |  4 ++--
 drivers/md/md.c                     |  6 +++---
 drivers/mmc/core/block.c            |  4 ++--
 drivers/mtd/mtd_blkdevs.c           |  4 ++--
 drivers/mtd/ubi/block.c             |  4 ++--
 drivers/nvme/host/core.c            |  4 ++--
 drivers/nvme/host/multipath.c       |  4 ++--
 drivers/s390/block/dasd.c           |  4 ++--
 drivers/s390/block/dcssblk.c        |  7 +++----
 drivers/scsi/sd.c                   | 12 ++++++------
 drivers/scsi/sr.c                   |  6 +++---
 include/linux/blkdev.h              |  2 +-
 31 files changed, 102 insertions(+), 107 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index f4c1e6e97ad520..6b831f82881bc4 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -108,7 +108,7 @@ static inline void ubd_set_bit(__u64 bit, unsigned char *data)
 static DEFINE_MUTEX(ubd_lock);
 static DEFINE_MUTEX(ubd_mutex); /* replaces BKL, might not be needed */
 
-static int ubd_open(struct block_device *bdev, fmode_t mode);
+static int ubd_open(struct gendisk *disk, fmode_t mode);
 static void ubd_release(struct gendisk *disk, fmode_t mode);
 static int ubd_ioctl(struct block_device *bdev, fmode_t mode,
 		     unsigned int cmd, unsigned long arg);
@@ -1154,9 +1154,8 @@ static int __init ubd_driver_init(void){
 
 device_initcall(ubd_driver_init);
 
-static int ubd_open(struct block_device *bdev, fmode_t mode)
+static int ubd_open(struct gendisk *disk, fmode_t mode)
 {
-	struct gendisk *disk = bdev->bd_disk;
 	struct ubd *ubd_dev = disk->private_data;
 	int err = 0;
 
diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index f50caaa1c2496e..38f95f79a1270c 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -120,9 +120,9 @@ static void simdisk_submit_bio(struct bio *bio)
 	bio_endio(bio);
 }
 
-static int simdisk_open(struct block_device *bdev, fmode_t mode)
+static int simdisk_open(struct gendisk *disk, fmode_t mode)
 {
-	struct simdisk *dev = bdev->bd_disk->private_data;
+	struct simdisk *dev = disk->private_data;
 
 	spin_lock(&dev->lock);
 	++dev->users;
diff --git a/block/bdev.c b/block/bdev.c
index 981f6135795138..8a5fded303d4ed 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -652,7 +652,7 @@ static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
 	int ret;
 
 	if (disk->fops->open) {
-		ret = disk->fops->open(bdev, mode);
+		ret = disk->fops->open(disk, mode);
 		if (ret) {
 			/* avoid ghost partitions on a removed medium */
 			if (ret == -ENOMEDIUM &&
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 6de12b311749a1..0cf2e58294be68 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1654,10 +1654,10 @@ static void fd_probe(int dev)
  * /dev/PS0 etc), and disallows simultaneous access to the same
  * drive with different device numbers.
  */
-static int floppy_open(struct block_device *bdev, fmode_t mode)
+static int floppy_open(struct gendisk *disk, fmode_t mode)
 {
-	int drive = MINOR(bdev->bd_dev) & 3;
-	int system =  (MINOR(bdev->bd_dev) & 4) >> 2;
+	int drive = disk->first_minor & 3;
+	int system = (disk->first_minor & 4) >> 2;
 	int old_dev;
 	unsigned long flags;
 
@@ -1675,7 +1675,7 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 	}
 
 	if (mode & (FMODE_READ|FMODE_WRITE)) {
-		disk_check_media_change(bdev->bd_disk);
+		disk_check_media_change(disk);
 		if (mode & FMODE_WRITE) {
 			int wrprot;
 
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 128722cf6c3cad..4ca6bbb326d5de 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -204,9 +204,9 @@ aoedisk_rm_debugfs(struct aoedev *d)
 }
 
 static int
-aoeblk_open(struct block_device *bdev, fmode_t mode)
+aoeblk_open(struct gendisk *disk, fmode_t mode)
 {
-	struct aoedev *d = bdev->bd_disk->private_data;
+	struct aoedev *d = disk->private_data;
 	ulong flags;
 
 	if (!virt_addr_valid(d)) {
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index da481ddbca90db..4febd52be78cfc 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -447,7 +447,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 static void fd_probe( int drive );
 static int fd_test_drive_present( int drive );
 static void config_types( void );
-static int floppy_open(struct block_device *bdev, fmode_t mode);
+static int floppy_open(struct gendisk *disk, fmode_t mode);
 static void floppy_release(struct gendisk *disk, fmode_t mode);
 
 /************************* End of Prototypes **************************/
@@ -1915,10 +1915,10 @@ static void __init config_types( void )
  * drive with different device numbers.
  */
 
-static int floppy_open(struct block_device *bdev, fmode_t mode)
+static int floppy_open(struct gendisk *disk, fmode_t mode)
 {
-	struct atari_floppy_struct *p = bdev->bd_disk->private_data;
-	int type  = MINOR(bdev->bd_dev) >> 2;
+	struct atari_floppy_struct *p = disk->private_data;
+	int type = disk->first_minor >> 2;
 
 	DPRINT(("fd_open: type=%d\n",type));
 	if (p->ref && p->type != type)
@@ -1938,8 +1938,8 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 		return 0;
 
 	if (mode & (FMODE_READ|FMODE_WRITE)) {
-		if (disk_check_media_change(bdev->bd_disk))
-			floppy_revalidate(bdev->bd_disk);
+		if (disk_check_media_change(disk))
+			floppy_revalidate(disk);
 		if (mode & FMODE_WRITE) {
 			if (p->wpstat) {
 				if (p->ref < 0)
@@ -1953,12 +1953,12 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 	return 0;
 }
 
-static int floppy_unlocked_open(struct block_device *bdev, fmode_t mode)
+static int floppy_unlocked_open(struct gendisk *disk, fmode_t mode)
 {
 	int ret;
 
 	mutex_lock(&ataflop_mutex);
-	ret = floppy_open(bdev, mode);
+	ret = floppy_open(disk, mode);
 	mutex_unlock(&ataflop_mutex);
 
 	return ret;
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 54223f64610a05..8b6c19460f3425 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -49,7 +49,7 @@
 #include "drbd_debugfs.h"
 
 static DEFINE_MUTEX(drbd_main_mutex);
-static int drbd_open(struct block_device *bdev, fmode_t mode);
+static int drbd_open(struct gendisk *disk, fmode_t mode);
 static void drbd_release(struct gendisk *gd, fmode_t mode);
 static void md_sync_timer_fn(struct timer_list *t);
 static int w_bitmap_io(struct drbd_work *w, int unused);
@@ -1882,9 +1882,9 @@ int drbd_send_all(struct drbd_connection *connection, struct socket *sock, void
 	return 0;
 }
 
-static int drbd_open(struct block_device *bdev, fmode_t mode)
+static int drbd_open(struct gendisk *disk, fmode_t mode)
 {
-	struct drbd_device *device = bdev->bd_disk->private_data;
+	struct drbd_device *device = disk->private_data;
 	unsigned long flags;
 	int rv = 0;
 
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 3accafcbc95c85..ef3bbb7c185b56 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -402,7 +402,7 @@ static struct floppy_drive_struct drive_state[N_DRIVE];
 static struct floppy_write_errors write_errors[N_DRIVE];
 static struct timer_list motor_off_timer[N_DRIVE];
 static struct blk_mq_tag_set tag_sets[N_DRIVE];
-static struct block_device *opened_bdev[N_DRIVE];
+static struct gendisk *opened_disk[N_DRIVE];
 static DEFINE_MUTEX(open_lock);
 static struct floppy_raw_cmd *raw_cmd, default_raw_cmd;
 
@@ -3251,10 +3251,11 @@ static int set_geometry(unsigned int cmd, struct floppy_struct *g,
 			    floppy_type[type].size + 1;
 		process_fd_request();
 		for (cnt = 0; cnt < N_DRIVE; cnt++) {
-			struct block_device *bdev = opened_bdev[cnt];
-			if (!bdev || ITYPE(drive_state[cnt].fd_device) != type)
+			struct gendisk *disk = opened_disk[cnt];
+
+			if (!disk || ITYPE(drive_state[cnt].fd_device) != type)
 				continue;
-			__invalidate_device(bdev, true);
+			__invalidate_device(disk->part0, true);
 		}
 		mutex_unlock(&open_lock);
 	} else {
@@ -3973,7 +3974,7 @@ static void floppy_release(struct gendisk *disk, fmode_t mode)
 		drive_state[drive].fd_ref = 0;
 	}
 	if (!drive_state[drive].fd_ref)
-		opened_bdev[drive] = NULL;
+		opened_disk[drive] = NULL;
 	mutex_unlock(&open_lock);
 	mutex_unlock(&floppy_mutex);
 }
@@ -3983,9 +3984,9 @@ static void floppy_release(struct gendisk *disk, fmode_t mode)
  * /dev/PS0 etc), and disallows simultaneous access to the same
  * drive with different device numbers.
  */
-static int floppy_open(struct block_device *bdev, fmode_t mode)
+static int floppy_open(struct gendisk *disk, fmode_t mode)
 {
-	int drive = (long)bdev->bd_disk->private_data;
+	int drive = (long)disk->private_data;
 	int old_dev, new_dev;
 	int try;
 	int res = -EBUSY;
@@ -3994,7 +3995,7 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 	mutex_lock(&floppy_mutex);
 	mutex_lock(&open_lock);
 	old_dev = drive_state[drive].fd_device;
-	if (opened_bdev[drive] && opened_bdev[drive] != bdev)
+	if (opened_disk[drive] && opened_disk[drive] != disk)
 		goto out2;
 
 	if (!drive_state[drive].fd_ref && (drive_params[drive].flags & FD_BROKEN_DCL)) {
@@ -4004,7 +4005,7 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 
 	drive_state[drive].fd_ref++;
 
-	opened_bdev[drive] = bdev;
+	opened_disk[drive] = disk;
 
 	res = -ENXIO;
 
@@ -4038,7 +4039,7 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 		}
 	}
 
-	new_dev = MINOR(bdev->bd_dev);
+	new_dev = disk->first_minor;
 	drive_state[drive].fd_device = new_dev;
 	set_capacity(disks[drive][ITYPE(new_dev)], floppy_sizes[new_dev]);
 	if (old_dev != -1 && old_dev != new_dev) {
@@ -4054,8 +4055,8 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 			drive_state[drive].last_checked = 0;
 			clear_bit(FD_OPEN_SHOULD_FAIL_BIT,
 				  &drive_state[drive].flags);
-			if (disk_check_media_change(bdev->bd_disk))
-				floppy_revalidate(bdev->bd_disk);
+			if (disk_check_media_change(disk))
+				floppy_revalidate(disk);
 			if (test_bit(FD_DISK_CHANGED_BIT, &drive_state[drive].flags))
 				goto out;
 			if (test_bit(FD_OPEN_SHOULD_FAIL_BIT, &drive_state[drive].flags))
@@ -4073,7 +4074,7 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 	drive_state[drive].fd_ref--;
 
 	if (!drive_state[drive].fd_ref)
-		opened_bdev[drive] = NULL;
+		opened_disk[drive] = NULL;
 out2:
 	mutex_unlock(&open_lock);
 	mutex_unlock(&floppy_mutex);
@@ -4203,7 +4204,8 @@ static int floppy_revalidate(struct gendisk *disk)
 			drive_state[drive].generation++;
 		if (drive_no_geom(drive)) {
 			/* auto-sensing */
-			res = __floppy_read_block_0(opened_bdev[drive], drive);
+			res = __floppy_read_block_0(opened_disk[drive]->part0,
+						    drive);
 		} else {
 			if (cf)
 				poll_drive(false, FD_RAW_NEED_DISK);
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 65ecde3e2a5be8..7b4ee6ebaae2e6 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1553,13 +1553,13 @@ static struct nbd_config *nbd_alloc_config(void)
 	return config;
 }
 
-static int nbd_open(struct block_device *bdev, fmode_t mode)
+static int nbd_open(struct gendisk *disk, fmode_t mode)
 {
 	struct nbd_device *nbd;
 	int ret = 0;
 
 	mutex_lock(&nbd_index_mutex);
-	nbd = bdev->bd_disk->private_data;
+	nbd = disk->private_data;
 	if (!nbd) {
 		ret = -ENXIO;
 		goto out;
@@ -1587,10 +1587,10 @@ static int nbd_open(struct block_device *bdev, fmode_t mode)
 		refcount_inc(&nbd->refs);
 		mutex_unlock(&nbd->config_lock);
 		if (max_part)
-			set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
+			set_bit(GD_NEED_PART_SCAN, &disk->state);
 	} else if (nbd_disconnected(nbd->config)) {
 		if (max_part)
-			set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
+			set_bit(GD_NEED_PART_SCAN, &disk->state);
 	}
 out:
 	mutex_unlock(&nbd_index_mutex);
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 377f8b34535294..8f02a1c2ede56d 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2204,14 +2204,14 @@ static struct pktcdvd_device *pkt_find_dev_from_minor(unsigned int dev_minor)
 	return pkt_devs[dev_minor];
 }
 
-static int pkt_open(struct block_device *bdev, fmode_t mode)
+static int pkt_open(struct gendisk *disk, fmode_t mode)
 {
 	struct pktcdvd_device *pd = NULL;
 	int ret;
 
 	mutex_lock(&pktcdvd_mutex);
 	mutex_lock(&ctl_mutex);
-	pd = pkt_find_dev_from_minor(MINOR(bdev->bd_dev));
+	pd = pkt_find_dev_from_minor(disk->first_minor);
 	if (!pd) {
 		ret = -ENODEV;
 		goto out;
@@ -2233,7 +2233,7 @@ static int pkt_open(struct block_device *bdev, fmode_t mode)
 		 * needed here as well, since ext2 (among others) may change
 		 * the blocksize at mount time
 		 */
-		set_blocksize(bdev, CD_FRAMESIZE);
+		set_blocksize(disk->part0, CD_FRAMESIZE);
 	}
 
 	mutex_unlock(&ctl_mutex);
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 84ad3b17956f67..93231061db2f2b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -660,9 +660,9 @@ static bool pending_result_dec(struct pending_result *pending, int *result)
 	return true;
 }
 
-static int rbd_open(struct block_device *bdev, fmode_t mode)
+static int rbd_open(struct gendisk *disk, fmode_t mode)
 {
-	struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
+	struct rbd_device *rbd_dev = disk->private_data;
 	bool removing = false;
 
 	spin_lock_irq(&rbd_dev->lock);
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 5eb8c7855970d1..8ec00f4caf6b4c 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -921,9 +921,9 @@ rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
 	return sess;
 }
 
-static int rnbd_client_open(struct block_device *block_device, fmode_t mode)
+static int rnbd_client_open(struct gendisk *disk, fmode_t mode)
 {
-	struct rnbd_clt_dev *dev = block_device->bd_disk->private_data;
+	struct rnbd_clt_dev *dev = disk->private_data;
 
 	if (get_disk_ro(dev->gd) && (mode & FMODE_WRITE))
 		return -EPERM;
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 105bc5fd1b8c62..7ec8554187f7d7 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -608,9 +608,9 @@ static void setup_medium(struct floppy_state *fs)
 	}
 }
 
-static int floppy_open(struct block_device *bdev, fmode_t mode)
+static int floppy_open(struct gendisk *disk, fmode_t mode)
 {
-	struct floppy_state *fs = bdev->bd_disk->private_data;
+	struct floppy_state *fs = disk->private_data;
 	struct swim __iomem *base = fs->swd->base;
 	int err;
 
@@ -640,7 +640,7 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 		return 0;
 
 	if (mode & (FMODE_READ|FMODE_WRITE)) {
-		if (disk_check_media_change(bdev->bd_disk) && fs->disk_in)
+		if (disk_check_media_change(disk) && fs->disk_in)
 			fs->ejected = 0;
 		if ((mode & FMODE_WRITE) && fs->write_protected) {
 			err = -EROFS;
@@ -659,12 +659,12 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 	return err;
 }
 
-static int floppy_unlocked_open(struct block_device *bdev, fmode_t mode)
+static int floppy_unlocked_open(struct gendisk *disk, fmode_t mode)
 {
 	int ret;
 
 	mutex_lock(&swim_mutex);
-	ret = floppy_open(bdev, mode);
+	ret = floppy_open(disk, mode);
 	mutex_unlock(&swim_mutex);
 
 	return ret;
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 3d689ba312f568..c05a4e110d5275 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -248,7 +248,7 @@ static void release_drive(struct floppy_state *fs);
 static int fd_eject(struct floppy_state *fs);
 static int floppy_ioctl(struct block_device *bdev, fmode_t mode,
 			unsigned int cmd, unsigned long param);
-static int floppy_open(struct block_device *bdev, fmode_t mode);
+static int floppy_open(struct gendisk *disk, fmode_t mode);
 static void floppy_release(struct gendisk *disk, fmode_t mode);
 static unsigned int floppy_check_events(struct gendisk *disk,
 					unsigned int clearing);
@@ -923,9 +923,9 @@ static int floppy_ioctl(struct block_device *bdev, fmode_t mode,
 	return ret;
 }
 
-static int floppy_open(struct block_device *bdev, fmode_t mode)
+static int floppy_open(struct gendisk *disk, fmode_t mode)
 {
-	struct floppy_state *fs = bdev->bd_disk->private_data;
+	struct floppy_state *fs = disk->private_data;
 	struct swim3 __iomem *sw = fs->swim3;
 	int n, err = 0;
 
@@ -963,8 +963,8 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 
 	if (err == 0 && (mode & FMODE_NDELAY) == 0
 	    && (mode & (FMODE_READ|FMODE_WRITE))) {
-		if (disk_check_media_change(bdev->bd_disk))
-			floppy_revalidate(bdev->bd_disk);
+		if (disk_check_media_change(disk))
+			floppy_revalidate(disk);
 		if (fs->ejected)
 			err = -ENXIO;
 	}
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 222a0341913ffb..92c900ac2ebcb6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -447,9 +447,9 @@ static void ublk_store_owner_uid_gid(unsigned int *owner_uid,
 	*owner_gid = from_kgid(&init_user_ns, gid);
 }
 
-static int ublk_open(struct block_device *bdev, fmode_t mode)
+static int ublk_open(struct gendisk *disk, fmode_t mode)
 {
-	struct ublk_device *ub = bdev->bd_disk->private_data;
+	struct ublk_device *ub = disk->private_data;
 
 	if (capable(CAP_SYS_ADMIN))
 		return 0;
diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index c1e85f356e4dfb..a5575e012e291e 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -140,16 +140,14 @@ static void get_chipram(void)
 	return;
 }
 
-static int z2_open(struct block_device *bdev, fmode_t mode)
+static int z2_open(struct gendisk *disk, fmode_t mode)
 {
-	int device;
+	int device = disk->first_minor;
 	int max_z2_map = (Z2RAM_SIZE / Z2RAM_CHUNKSIZE) * sizeof(z2ram_map[0]);
 	int max_chip_map = (amiga_chip_size / Z2RAM_CHUNKSIZE) *
 	    sizeof(z2ram_map[0]);
 	int rc = -ENOMEM;
 
-	device = MINOR(bdev->bd_dev);
-
 	mutex_lock(&z2ram_mutex);
 	if (current_device != -1 && current_device != device) {
 		rc = -EBUSY;
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0bc779446c6f8f..f5644c60604070 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2097,19 +2097,16 @@ static ssize_t reset_store(struct device *dev,
 	return len;
 }
 
-static int zram_open(struct block_device *bdev, fmode_t mode)
+static int zram_open(struct gendisk *disk, fmode_t mode)
 {
-	int ret = 0;
-	struct zram *zram;
+	struct zram *zram = disk->private_data;
 
-	WARN_ON(!mutex_is_locked(&bdev->bd_disk->open_mutex));
+	WARN_ON(!mutex_is_locked(&disk->open_mutex));
 
-	zram = bdev->bd_disk->private_data;
 	/* zram was claimed to reset so open request fails */
 	if (zram->claim)
-		ret = -EBUSY;
-
-	return ret;
+		return -EBUSY;
+	return 0;
 }
 
 static const struct block_device_operations zram_devops = {
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 3cb92df38ebeb8..d35dd717e9fca9 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -474,11 +474,11 @@ static const struct cdrom_device_ops gdrom_ops = {
 				  CDC_RESET | CDC_DRIVE_STATUS | CDC_CD_R,
 };
 
-static int gdrom_bdops_open(struct block_device *bdev, fmode_t mode)
+static int gdrom_bdops_open(struct gendisk *disk, fmode_t mode)
 {
 	int ret;
 
-	disk_check_media_change(bdev->bd_disk);
+	disk_check_media_change(disk);
 
 	mutex_lock(&gdrom_mutex);
 	ret = cdrom_open(gd.cd_info);
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index d84c09a73af803..6683f66e701136 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -732,9 +732,9 @@ static int prio_read(struct cache *ca, uint64_t bucket)
 
 /* Bcache device */
 
-static int open_dev(struct block_device *b, fmode_t mode)
+static int open_dev(struct gendisk *disk, fmode_t mode)
 {
-	struct bcache_device *d = b->bd_disk->private_data;
+	struct bcache_device *d = disk->private_data;
 
 	if (test_bit(BCACHE_DEV_CLOSING, &d->flags))
 		return -ENXIO;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index d759f8bdb3df2f..06047a0ca4b315 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -310,13 +310,13 @@ int dm_deleting_md(struct mapped_device *md)
 	return test_bit(DMF_DELETING, &md->flags);
 }
 
-static int dm_blk_open(struct block_device *bdev, fmode_t mode)
+static int dm_blk_open(struct gendisk *disk, fmode_t mode)
 {
 	struct mapped_device *md;
 
 	spin_lock(&_minor_lock);
 
-	md = bdev->bd_disk->private_data;
+	md = disk->private_data;
 	if (!md)
 		goto out;
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 77046c91bea439..aba13830bdb556 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7767,13 +7767,13 @@ static int md_set_read_only(struct block_device *bdev, bool ro)
 	return err;
 }
 
-static int md_open(struct block_device *bdev, fmode_t mode)
+static int md_open(struct gendisk *disk, fmode_t mode)
 {
 	struct mddev *mddev;
 	int err;
 
 	spin_lock(&all_mddevs_lock);
-	mddev = mddev_get(bdev->bd_disk->private_data);
+	mddev = mddev_get(disk->private_data);
 	spin_unlock(&all_mddevs_lock);
 	if (!mddev)
 		return -ENODEV;
@@ -7789,7 +7789,7 @@ static int md_open(struct block_device *bdev, fmode_t mode)
 	atomic_inc(&mddev->openers);
 	mutex_unlock(&mddev->open_mutex);
 
-	disk_check_media_change(bdev->bd_disk);
+	disk_check_media_change(disk);
 	return 0;
 
 out_unlock:
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 00c33edb9fb94e..fe217658705d1f 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -357,9 +357,9 @@ static const struct attribute_group *mmc_disk_attr_groups[] = {
 	NULL,
 };
 
-static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
+static int mmc_blk_open(struct gendisk *disk, fmode_t mode)
 {
-	struct mmc_blk_data *md = mmc_blk_get(bdev->bd_disk);
+	struct mmc_blk_data *md = mmc_blk_get(disk);
 	int ret = -ENXIO;
 
 	mutex_lock(&block_mutex);
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 60b222799871e8..95f3ee6bde8440 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -182,9 +182,9 @@ static blk_status_t mtd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
-static int blktrans_open(struct block_device *bdev, fmode_t mode)
+static int blktrans_open(struct gendisk *disk, fmode_t mode)
 {
-	struct mtd_blktrans_dev *dev = bdev->bd_disk->private_data;
+	struct mtd_blktrans_dev *dev = disk->private_data;
 	int ret = 0;
 
 	kref_get(&dev->ref);
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 3711d7f746003d..2f3442963919fc 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -227,9 +227,9 @@ static blk_status_t ubiblock_read(struct request *req)
 	return BLK_STS_OK;
 }
 
-static int ubiblock_open(struct block_device *bdev, fmode_t mode)
+static int ubiblock_open(struct gendisk *disk, fmode_t mode)
 {
-	struct ubiblock *dev = bdev->bd_disk->private_data;
+	struct ubiblock *dev = disk->private_data;
 	int ret;
 
 	mutex_lock(&dev->dev_mutex);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ccb6eb1282f82d..b1c8af5d9376ad 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1591,9 +1591,9 @@ static void nvme_ns_release(struct nvme_ns *ns)
 	nvme_put_ns(ns);
 }
 
-static int nvme_open(struct block_device *bdev, fmode_t mode)
+static int nvme_open(struct gendisk *disk, fmode_t mode)
 {
-	return nvme_ns_open(bdev->bd_disk->private_data);
+	return nvme_ns_open(disk->private_data);
 }
 
 static void nvme_release(struct gendisk *disk, fmode_t mode)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9171452e2f6d4e..e8d5d62efa6d7c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -402,9 +402,9 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 	srcu_read_unlock(&head->srcu, srcu_idx);
 }
 
-static int nvme_ns_head_open(struct block_device *bdev, fmode_t mode)
+static int nvme_ns_head_open(struct gendisk *disk, fmode_t mode)
 {
-	if (!nvme_tryget_ns_head(bdev->bd_disk->private_data))
+	if (!nvme_tryget_ns_head(disk->private_data))
 		return -ENXIO;
 	return 0;
 }
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 9fbfce735d5650..e445b5fbd7fd27 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3234,12 +3234,12 @@ struct blk_mq_ops dasd_mq_ops = {
 	.exit_hctx = dasd_exit_hctx,
 };
 
-static int dasd_open(struct block_device *bdev, fmode_t mode)
+static int dasd_open(struct gendisk *disk, fmode_t mode)
 {
 	struct dasd_device *base;
 	int rc;
 
-	base = dasd_device_from_gendisk(bdev->bd_disk);
+	base = dasd_device_from_gendisk(disk);
 	if (!base)
 		return -ENODEV;
 
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index c09f2e053bf863..6150d20b584300 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -28,7 +28,7 @@
 #define DCSSBLK_PARM_LEN 400
 #define DCSS_BUS_ID_SIZE 20
 
-static int dcssblk_open(struct block_device *bdev, fmode_t mode);
+static int dcssblk_open(struct gendisk *disk, fmode_t mode);
 static void dcssblk_release(struct gendisk *disk, fmode_t mode);
 static void dcssblk_submit_bio(struct bio *bio);
 static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
@@ -809,12 +809,11 @@ dcssblk_remove_store(struct device *dev, struct device_attribute *attr, const ch
 }
 
 static int
-dcssblk_open(struct block_device *bdev, fmode_t mode)
+dcssblk_open(struct gendisk *disk, fmode_t mode)
 {
-	struct dcssblk_dev_info *dev_info;
+	struct dcssblk_dev_info *dev_info = disk->private_data;
 	int rc;
 
-	dev_info = bdev->bd_disk->private_data;
 	if (NULL == dev_info) {
 		rc = -ENODEV;
 		goto out;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index aab649d5bad3f8..c31a675db015e8 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1297,7 +1297,7 @@ static bool sd_need_revalidate(struct gendisk *disk, struct scsi_disk *sdkp)
 
 /**
  *	sd_open - open a scsi disk device
- *	@bdev: Block device of the scsi disk to open
+ *	@disk: disk to open
  *	@mode: FMODE_* mask
  *
  *	Returns 0 if successful. Returns a negated errno value in case 
@@ -1308,11 +1308,11 @@ static bool sd_need_revalidate(struct gendisk *disk, struct scsi_disk *sdkp)
  *	In the latter case @inode and @filp carry an abridged amount
  *	of information as noted above.
  *
- *	Locking: called with bdev->bd_disk->open_mutex held.
+ *	Locking: called with disk->open_mutex held.
  **/
-static int sd_open(struct block_device *bdev, fmode_t mode)
+static int sd_open(struct gendisk *disk, fmode_t mode)
 {
-	struct scsi_disk *sdkp = scsi_disk(bdev->bd_disk);
+	struct scsi_disk *sdkp = scsi_disk(disk);
 	struct scsi_device *sdev = sdkp->device;
 	int retval;
 
@@ -1329,8 +1329,8 @@ static int sd_open(struct block_device *bdev, fmode_t mode)
 	if (!scsi_block_when_processing_errors(sdev))
 		goto error_out;
 
-	if (sd_need_revalidate(bdev->bd_disk, sdkp))
-		sd_revalidate_disk(bdev->bd_disk);
+	if (sd_need_revalidate(disk, sdkp))
+		sd_revalidate_disk(disk);
 
 	/*
 	 * If the drive is empty, just let the open fail.
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 1592e6e10c7452..3ff3a2f9604774 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -484,9 +484,9 @@ static void sr_revalidate_disk(struct scsi_cd *cd)
 	get_sectorsize(cd);
 }
 
-static int sr_block_open(struct block_device *bdev, fmode_t mode)
+static int sr_block_open(struct gendisk *disk, fmode_t mode)
 {
-	struct scsi_cd *cd = scsi_cd(bdev->bd_disk);
+	struct scsi_cd *cd = scsi_cd(disk);
 	struct scsi_device *sdev = cd->device;
 	int ret;
 
@@ -494,7 +494,7 @@ static int sr_block_open(struct block_device *bdev, fmode_t mode)
 		return -ENXIO;
 
 	scsi_autopm_get_device(sdev);
-	if (disk_check_media_change(bdev->bd_disk))
+	if (disk_check_media_change(disk))
 		sr_revalidate_disk(cd);
 
 	mutex_lock(&cd->lock);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a1688eba7e5e9a..1366eea881860e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1386,7 +1386,7 @@ struct block_device_operations {
 	void (*submit_bio)(struct bio *bio);
 	int (*poll_bio)(struct bio *bio, struct io_comp_batch *iob,
 			unsigned int flags);
-	int (*open) (struct block_device *, fmode_t);
+	int (*open)(struct gendisk *disk, fmode_t mode);
 	void (*release) (struct gendisk *, fmode_t);
 	int (*ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
 	int (*compat_ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
-- 
2.39.2

