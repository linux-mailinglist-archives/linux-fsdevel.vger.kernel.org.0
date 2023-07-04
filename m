Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F142747132
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjGDMYd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjGDMXd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:23:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094071704;
        Tue,  4 Jul 2023 05:22:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0DABB20572;
        Tue,  4 Jul 2023 12:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mjuMHjhognYm/jp+4laDSDXEVfZVsA6D5XD84KVXIlM=;
        b=IfhkJf/r3YX79abK//kvxzsfxO8GBec3aFCgZUqKe4njAdibvh5nuXvRT9veRG5W0AjJWZ
        xkZTl1aaAGPgSVyAjWvo8s6nnqwhJ0ZaLpuEG69dT5keFHsUoEFpqPkzUx9qP0BhNBbooO
        p9QUcEDucrmYuqaoHoaI7BQaQFfMU7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473347;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mjuMHjhognYm/jp+4laDSDXEVfZVsA6D5XD84KVXIlM=;
        b=L7ND2oVd/Fq2jDo7ljy5nF8o5bZWHZeR62gf2Xk9TE6mFJugTr7RIk/BG29uxhMgM00XlI
        Bt3Mp4tdxZ9r7HCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABAF1139ED;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KsLiKQIPpGRjMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 59701A078D; Tue,  4 Jul 2023 14:22:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Alasdair Kergon <agk@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anna Schumaker <anna@kernel.org>, Chao Yu <chao@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com, Gao Xiang <xiang@kernel.org>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Joern Engel <joern@lazybastard.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Minchan Kim <minchan@kernel.org>, ocfs2-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Song Liu <song@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        target-devel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 32/32] block: Rename blkdev_get_handle_by_*() and blkdev_handle_put()
Date:   Tue,  4 Jul 2023 14:21:59 +0200
Message-Id: <20230704122224.16257-32-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=52534; i=jack@suse.cz; h=from:subject; bh=V4VQzqtLPzebd9elTihpjhZGahpeEhAZnI7QsWZdPe4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7mNc8ek6WBAiDfxElNQMWOHzv9hYYvjHN3eTqG Gc6z8KeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO5gAKCRCcnaoHP2RA2TWdB/ 4/tliM0M2A91liOZmHDiXajUGkW4GFvo5u3EtWLBTnoITi1cexbp98BuZsmF37Cwcua38PpwNGdNvC LjevVeWqas0lSaFPJpuEMGUAzkFn4nUF9yXneLyjoILCiV1OdKQNkZRO/tJaC8ntEgkrITOiw/+Z+s 7BqpGpN/dsEGe2ND8MR1y/Zxq99oQJfHMdrtpkdg6JooqUQ7d8jiMehC0ZRkkIrhmi/l6R533RJqXL o2pkFrxgsYDkpHv/Pc7FZA3/rq2WoCPTsRqLDPl1um222jRi2sYUcgPbtMy/oAC1WeVRFT1RFUEA3V nUZ6UiuuDjVfhIUnPyhZWutX8t6+Xs
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that everybody is converted, we can rename blkdev_get_handle_by_*()
and blkdev_handle_put() back to their original names. No functional
change.

Done by Coccinelle patch:

@@
expression dev, mode, holder, hops;
@@
-	blkdev_get_handle_by_dev(dev, mode, holder, hops)
+	blkdev_get_by_dev(dev, mode, holder, hops)

@@
expression path, mode, holder, hops;
@@
-	blkdev_get_handle_by_path(path, mode, holder, hops)
+	blkdev_get_by_path(path, mode, holder, hops)

@@
expression handle;
@@
-	blkdev_handle_put(handle)
+	blkdev_put(handle)

plus manual updates of comments, strings, and function declarations itself.

CC: Alasdair Kergon <agk@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Anna Schumaker <anna@kernel.org>
CC: Chao Yu <chao@kernel.org>
CC: Christian Borntraeger <borntraeger@linux.ibm.com>
CC: Coly Li <colyli@suse.de
CC: "Darrick J. Wong" <djwong@kernel.org>
CC: Dave Kleikamp <shaggy@kernel.org>
CC: David Sterba <dsterba@suse.com>
CC: dm-devel@redhat.com
CC: drbd-dev@lists.linbit.com
CC: Gao Xiang <xiang@kernel.org>
CC: Jack Wang <jinpu.wang@ionos.com>
CC: Jaegeuk Kim <jaegeuk@kernel.org>
CC: jfs-discussion@lists.sourceforge.net
CC: Joern Engel <joern@lazybastard.org>
CC: Joseph Qi <joseph.qi@linux.alibaba.com>
CC: Kent Overstreet <kent.overstreet@gmail.com>
CC: linux-bcache@vger.kernel.org
CC: linux-btrfs@vger.kernel.org
CC: linux-erofs@lists.ozlabs.org
CC: <linux-ext4@vger.kernel.org>
CC: linux-f2fs-devel@lists.sourceforge.net
CC: linux-mm@kvack.org
CC: linux-mtd@lists.infradead.org
CC: linux-nfs@vger.kernel.org
CC: linux-nilfs@vger.kernel.org
CC: linux-nvme@lists.infradead.org
CC: linux-pm@vger.kernel.org
CC: linux-raid@vger.kernel.org
CC: linux-s390@vger.kernel.org
CC: linux-scsi@vger.kernel.org
CC: linux-xfs@vger.kernel.org
CC: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
CC: Mike Snitzer <snitzer@kernel.org>
CC: Minchan Kim <minchan@kernel.org>
CC: ocfs2-devel@oss.oracle.com
CC: reiserfs-devel@vger.kernel.org
CC: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Song Liu <song@kernel.org>
CC: Sven Schnelle <svens@linux.ibm.com>
CC: target-devel@vger.kernel.org
CC: Ted Tso <tytso@mit.edu>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>
CC: xen-devel@lists.xenproject.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c                        | 24 +++++++++---------
 block/fops.c                        |  6 ++---
 block/genhd.c                       |  6 ++---
 block/ioctl.c                       |  4 +--
 drivers/block/drbd/drbd_nl.c        | 10 ++++----
 drivers/block/pktcdvd.c             | 18 +++++++-------
 drivers/block/rnbd/rnbd-srv.c       |  7 +++---
 drivers/block/xen-blkback/xenbus.c  |  7 +++---
 drivers/block/zram/zram_drv.c       |  9 ++++---
 drivers/md/bcache/super.c           | 23 ++++++++---------
 drivers/md/dm.c                     |  6 ++---
 drivers/md/md.c                     | 11 +++++----
 drivers/mtd/devices/block2mtd.c     |  7 +++---
 drivers/nvme/target/io-cmd-bdev.c   |  7 +++---
 drivers/s390/block/dasd_genhd.c     | 20 +++++++--------
 drivers/target/target_core_iblock.c |  8 +++---
 drivers/target/target_core_pscsi.c  | 11 +++++----
 fs/btrfs/dev-replace.c              |  6 ++---
 fs/btrfs/ioctl.c                    |  4 +--
 fs/btrfs/volumes.c                  | 31 ++++++++++++-----------
 fs/erofs/super.c                    |  6 ++---
 fs/ext4/super.c                     |  8 +++---
 fs/f2fs/super.c                     | 15 +++++++-----
 fs/jfs/jfs_logmgr.c                 |  9 ++++---
 fs/nfs/blocklayout/dev.c            | 13 +++++-----
 fs/nilfs2/super.c                   |  8 +++---
 fs/ocfs2/cluster/heartbeat.c        | 10 ++++----
 fs/reiserfs/journal.c               | 10 ++++----
 fs/super.c                          | 38 ++++++++++++++---------------
 fs/xfs/xfs_super.c                  |  6 ++---
 include/linux/blkdev.h              |  8 +++---
 kernel/power/swap.c                 | 15 ++++++------
 mm/swapfile.c                       |  9 ++++---
 33 files changed, 194 insertions(+), 186 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 0423495fe5ac..523ea7289834 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -746,7 +746,7 @@ void blkdev_put_no_open(struct block_device *bdev)
 }
 	
 /**
- * blkdev_get_handle_by_dev - open a block device by device number
+ * blkdev_get_by_dev - open a block device by device number
  * @dev: device number of block device to open
  * @mode: open mode (BLK_OPEN_*)
  * @holder: exclusive holder identifier
@@ -758,7 +758,7 @@ void blkdev_put_no_open(struct block_device *bdev)
  *
  * Use this interface ONLY if you really do not have anything better - i.e. when
  * you are behind a truly sucky interface and all you are given is a device
- * number.  Everything else should use blkdev_get_handle_by_path().
+ * number.  Everything else should use blkdev_get_by_path().
  *
  * CONTEXT:
  * Might sleep.
@@ -767,8 +767,8 @@ void blkdev_put_no_open(struct block_device *bdev)
  * Handle with a reference to the block_device on success, ERR_PTR(-errno) on
  * failure.
  */
-struct bdev_handle *blkdev_get_handle_by_dev(dev_t dev, blk_mode_t mode,
-		void *holder, const struct blk_holder_ops *hops)
+struct bdev_handle *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
+				      const struct blk_holder_ops *hops)
 {
 	struct bdev_handle *handle = kmalloc(sizeof(struct bdev_handle),
 					     GFP_KERNEL);
@@ -856,10 +856,10 @@ struct bdev_handle *blkdev_get_handle_by_dev(dev_t dev, blk_mode_t mode,
 	kfree(handle);
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL(blkdev_get_handle_by_dev);
+EXPORT_SYMBOL(blkdev_get_by_dev);
 
 /**
- * blkdev_get_handle_by_path - open a block device by name
+ * blkdev_get_by_path - open a block device by name
  * @path: path to the block device to open
  * @mode: open mode (BLK_OPEN_*)
  * @holder: exclusive holder identifier
@@ -876,7 +876,7 @@ EXPORT_SYMBOL(blkdev_get_handle_by_dev);
  * Handle with a reference to the block_device on success, ERR_PTR(-errno) on
  * failure.
  */
-struct bdev_handle *blkdev_get_handle_by_path(const char *path, blk_mode_t mode,
+struct bdev_handle *blkdev_get_by_path(const char *path, blk_mode_t mode,
 		void *holder, const struct blk_holder_ops *hops)
 {
 	struct bdev_handle *handle;
@@ -887,18 +887,18 @@ struct bdev_handle *blkdev_get_handle_by_path(const char *path, blk_mode_t mode,
 	if (error)
 		return ERR_PTR(error);
 
-	handle = blkdev_get_handle_by_dev(dev, mode, holder, hops);
+	handle = blkdev_get_by_dev(dev, mode, holder, hops);
 	if (!IS_ERR(handle) && (mode & BLK_OPEN_WRITE) &&
 	    bdev_read_only(handle->bdev)) {
-		blkdev_handle_put(handle);
+		blkdev_put(handle);
 		return ERR_PTR(-EACCES);
 	}
 
 	return handle;
 }
-EXPORT_SYMBOL(blkdev_get_handle_by_path);
+EXPORT_SYMBOL(blkdev_get_by_path);
 
-void blkdev_handle_put(struct bdev_handle *handle)
+void blkdev_put(struct bdev_handle *handle)
 {
 	struct block_device *bdev = handle->bdev;
 	struct gendisk *disk = bdev->bd_disk;
@@ -934,7 +934,7 @@ void blkdev_handle_put(struct bdev_handle *handle)
 	blkdev_put_no_open(bdev);
 	kfree(handle);
 }
-EXPORT_SYMBOL(blkdev_handle_put);
+EXPORT_SYMBOL(blkdev_put);
 
 /**
  * lookup_bdev() - Look up a struct block_device by name.
diff --git a/block/fops.c b/block/fops.c
index d7f3b6e67a2f..ba928b0edeb0 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -509,8 +509,8 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	filp->f_mode |= FMODE_BUF_RASYNC;
 
 	mode = file_to_blk_mode(filp);
-	handle = blkdev_get_handle_by_dev(inode->i_rdev, mode,
-			mode & BLK_OPEN_EXCL ? filp : NULL, NULL);
+	handle = blkdev_get_by_dev(inode->i_rdev, mode,
+				   mode & BLK_OPEN_EXCL ? filp : NULL, NULL);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
@@ -527,7 +527,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 
 static int blkdev_release(struct inode *inode, struct file *filp)
 {
-	blkdev_handle_put(filp->private_data);
+	blkdev_put(filp->private_data);
 	return 0;
 }
 
diff --git a/block/genhd.c b/block/genhd.c
index d363ddb8d93a..a09fca0af308 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -366,12 +366,12 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 	}
 
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
-	handle = blkdev_get_handle_by_dev(disk_devt(disk),
-					  mode & ~BLK_OPEN_EXCL, NULL, NULL);
+	handle = blkdev_get_by_dev(disk_devt(disk), mode & ~BLK_OPEN_EXCL, NULL,
+				   NULL);
 	if (IS_ERR(handle))
 		ret = PTR_ERR(handle);
 	else
-		blkdev_handle_put(handle);
+		blkdev_put(handle);
 
 	/*
 	 * If blkdev_get_by_dev() failed early, GD_NEED_PART_SCAN is still set,
diff --git a/block/ioctl.c b/block/ioctl.c
index 940a7b9284c4..96922830f908 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -470,11 +470,11 @@ static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
 	if (mode & BLK_OPEN_EXCL)
 		return set_blocksize(bdev, n);
 
-	handle = blkdev_get_handle_by_dev(bdev->bd_dev, mode, &bdev, NULL);
+	handle = blkdev_get_by_dev(bdev->bd_dev, mode, &bdev, NULL);
 	if (IS_ERR(handle))
 		return -EBUSY;
 	ret = set_blocksize(bdev, n);
-	blkdev_handle_put(handle);
+	blkdev_put(handle);
 
 	return ret;
 }
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 4a436a428e12..1f8b53468f0e 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -82,7 +82,7 @@ static atomic_t notify_genl_seq = ATOMIC_INIT(2); /* two. */
 
 DEFINE_MUTEX(notification_mutex);
 
-/* used blkdev_get_handle_by_path, to claim our meta data device(s) */
+/* used blkdev_get_by_path, to claim our meta data device(s) */
 static char *drbd_m_holder = "Hands off! this is DRBD's meta data device.";
 
 static void drbd_adm_send_reply(struct sk_buff *skb, struct genl_info *info)
@@ -1640,8 +1640,8 @@ static struct bdev_handle *open_backing_dev(struct drbd_device *device,
 	struct bdev_handle *handle;
 	int err = 0;
 
-	handle = blkdev_get_handle_by_path(bdev_path,
-			BLK_OPEN_READ | BLK_OPEN_WRITE, claim_ptr, NULL);
+	handle = blkdev_get_by_path(bdev_path, BLK_OPEN_READ | BLK_OPEN_WRITE,
+				    claim_ptr, NULL);
 	if (IS_ERR(handle)) {
 		drbd_err(device, "open(\"%s\") failed with %ld\n",
 				bdev_path, PTR_ERR(handle));
@@ -1653,7 +1653,7 @@ static struct bdev_handle *open_backing_dev(struct drbd_device *device,
 
 	err = bd_link_disk_holder(handle->bdev, device->vdisk);
 	if (err) {
-		blkdev_handle_put(handle);
+		blkdev_put(handle);
 		drbd_err(device, "bd_link_disk_holder(\"%s\", ...) failed with %d\n",
 				bdev_path, err);
 		handle = ERR_PTR(err);
@@ -1704,7 +1704,7 @@ static void close_backing_dev(struct drbd_device *device,
 		return;
 	if (do_bd_unlink)
 		bd_unlink_disk_holder(handle->bdev, device->vdisk);
-	blkdev_handle_put(handle);
+	blkdev_put(handle);
 }
 
 void drbd_backing_dev_free(struct drbd_device *device, struct drbd_backing_dev *ldev)
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index c50333ea9c75..924557408ed0 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2169,8 +2169,8 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
 	 * to read/write from/to it. It is already opened in O_NONBLOCK mode
 	 * so open should not fail.
 	 */
-	bdev_handle = blkdev_get_handle_by_dev(pd->bdev_handle->bdev->bd_dev,
-					       BLK_OPEN_READ, pd, NULL);
+	bdev_handle = blkdev_get_by_dev(pd->bdev_handle->bdev->bd_dev,
+					BLK_OPEN_READ, pd, NULL);
 	if (IS_ERR(bdev_handle)) {
 		ret = PTR_ERR(bdev_handle);
 		goto out;
@@ -2218,7 +2218,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
 	return 0;
 
 out_putdev:
-	blkdev_handle_put(bdev_handle);
+	blkdev_put(bdev_handle);
 out:
 	return ret;
 }
@@ -2237,7 +2237,7 @@ static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
 	pkt_lock_door(pd, 0);
 
 	pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
-	blkdev_handle_put(pd->open_bdev_handle);
+	blkdev_put(pd->open_bdev_handle);
 	pd->open_bdev_handle = NULL;
 
 	pkt_shrink_pktlist(pd);
@@ -2519,13 +2519,13 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 		}
 	}
 
-	bdev_handle = blkdev_get_handle_by_dev(dev,
-			BLK_OPEN_READ | BLK_OPEN_NDELAY, NULL, NULL);
+	bdev_handle = blkdev_get_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_NDELAY,
+					NULL, NULL);
 	if (IS_ERR(bdev_handle))
 		return PTR_ERR(bdev_handle);
 	sdev = scsi_device_from_queue(bdev_handle->bdev->bd_disk->queue);
 	if (!sdev) {
-		blkdev_handle_put(bdev_handle);
+		blkdev_put(bdev_handle);
 		return -EINVAL;
 	}
 	put_device(&sdev->sdev_gendev);
@@ -2550,7 +2550,7 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	return 0;
 
 out_mem:
-	blkdev_handle_put(bdev_handle);
+	blkdev_put(bdev_handle);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
 	return -ENOMEM;
@@ -2757,7 +2757,7 @@ static int pkt_remove_dev(dev_t pkt_dev)
 	pkt_debugfs_dev_remove(pd);
 	pkt_sysfs_dev_remove(pd);
 
-	blkdev_handle_put(pd->bdev_handle);
+	blkdev_put(pd->bdev_handle);
 
 	remove_proc_entry(pd->disk->disk_name, pkt_proc);
 	dev_notice(ddev, "writer unmapped\n");
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 606db77c1238..d462d6dac297 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -219,7 +219,7 @@ void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev, bool keep_id)
 	rnbd_put_sess_dev(sess_dev);
 	wait_for_completion(&dc); /* wait for inflights to drop to zero */
 
-	blkdev_handle_put(sess_dev->bdev_handle);
+	blkdev_put(sess_dev->bdev_handle);
 	mutex_lock(&sess_dev->dev->lock);
 	list_del(&sess_dev->dev_list);
 	if (!sess_dev->readonly)
@@ -714,8 +714,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 		goto reject;
 	}
 
-	bdev_handle = blkdev_get_handle_by_path(full_path, open_flags, NULL,
-						NULL);
+	bdev_handle = blkdev_get_by_path(full_path, open_flags, NULL, NULL);
 	if (IS_ERR(bdev_handle)) {
 		ret = PTR_ERR(bdev_handle);
 		pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %d\n",
@@ -792,7 +791,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	}
 	rnbd_put_srv_dev(srv_dev);
 blkdev_put:
-	blkdev_handle_put(bdev_handle);
+	blkdev_put(bdev_handle);
 free_path:
 	kfree(full_path);
 reject:
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index b67d28584c72..c28b31872e5a 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -474,7 +474,7 @@ static void xenvbd_sysfs_delif(struct xenbus_device *dev)
 static void xen_vbd_free(struct xen_vbd *vbd)
 {
 	if (vbd->bdev_handle)
-		blkdev_handle_put(vbd->bdev_handle);
+		blkdev_put(vbd->bdev_handle);
 	vbd->bdev_handle = NULL;
 }
 
@@ -492,8 +492,9 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 
 	vbd->pdevice  = MKDEV(major, minor);
 
-	bdev_handle = blkdev_get_handle_by_dev(vbd->pdevice, vbd->readonly ?
-				 BLK_OPEN_READ : BLK_OPEN_WRITE, NULL, NULL);
+	bdev_handle = blkdev_get_by_dev(vbd->pdevice,
+					vbd->readonly ? BLK_OPEN_READ : BLK_OPEN_WRITE,
+					NULL, NULL);
 
 	if (IS_ERR(bdev_handle)) {
 		pr_warn("xen_vbd_create: device %08x could not be opened\n",
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 987e4885956e..284f433bf5e9 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -417,7 +417,7 @@ static void reset_bdev(struct zram *zram)
 	if (!zram->backing_dev)
 		return;
 
-	blkdev_handle_put(zram->bdev_handle);
+	blkdev_put(zram->bdev_handle);
 	/* hope filp_close flush all of IO */
 	filp_close(zram->backing_dev, NULL);
 	zram->backing_dev = NULL;
@@ -504,8 +504,9 @@ static ssize_t backing_dev_store(struct device *dev,
 		goto out;
 	}
 
-	bdev_handle = blkdev_get_handle_by_dev(inode->i_rdev,
-				BLK_OPEN_READ | BLK_OPEN_WRITE, zram, NULL);
+	bdev_handle = blkdev_get_by_dev(inode->i_rdev,
+					BLK_OPEN_READ | BLK_OPEN_WRITE, zram,
+					NULL);
 	if (IS_ERR(bdev_handle)) {
 		err = PTR_ERR(bdev_handle);
 		bdev_handle = NULL;
@@ -536,7 +537,7 @@ static ssize_t backing_dev_store(struct device *dev,
 	kvfree(bitmap);
 
 	if (bdev_handle)
-		blkdev_handle_put(bdev_handle);
+		blkdev_put(bdev_handle);
 
 	if (backing_dev)
 		filp_close(backing_dev, NULL);
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 2b3f35fd7477..c6b6b140f3e8 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1369,7 +1369,7 @@ static void cached_dev_free(struct closure *cl)
 		put_page(virt_to_page(dc->sb_disk));
 
 	if (dc->bdev_handle)
-		blkdev_handle_put(dc->bdev_handle);
+		blkdev_put(dc->bdev_handle);
 
 	wake_up(&unregister_wait);
 
@@ -2218,7 +2218,7 @@ void bch_cache_release(struct kobject *kobj)
 		put_page(virt_to_page(ca->sb_disk));
 
 	if (ca->bdev_handle)
-		blkdev_handle_put(ca->bdev_handle);
+		blkdev_put(ca->bdev_handle);
 
 	kfree(ca);
 	module_put(THIS_MODULE);
@@ -2357,10 +2357,10 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 		/*
 		 * If we failed here, it means ca->kobj is not initialized yet,
 		 * kobject_put() won't be called and there is no chance to
-		 * call blkdev_handle_put() to bdev in bch_cache_release(). So
-		 * we explicitly call blkdev_handle_put() here.
+		 * call blkdev_put() to bdev in bch_cache_release(). So we
+		 * explicitly call blkdev_put() here.
 		 */
-		blkdev_handle_put(bdev_handle);
+		blkdev_put(bdev_handle);
 		if (ret == -ENOMEM)
 			err = "cache_alloc(): -ENOMEM";
 		else if (ret == -EPERM)
@@ -2551,8 +2551,8 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 
 	ret = -EINVAL;
 	err = "failed to open device";
-	bdev_handle = blkdev_get_handle_by_path(strim(path), BLK_OPEN_READ,
-						NULL, NULL);
+	bdev_handle = blkdev_get_by_path(strim(path), BLK_OPEN_READ, NULL,
+					 NULL);
 	if (IS_ERR(bdev_handle))
 		goto out_free_sb;
 
@@ -2572,9 +2572,10 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	}
 
 	/* Now reopen in exclusive mode with proper holder */
-	bdev_handle2 = blkdev_get_handle_by_dev(bdev_handle->bdev->bd_dev,
-			BLK_OPEN_READ | BLK_OPEN_WRITE, holder, NULL);
-	blkdev_handle_put(bdev_handle);
+	bdev_handle2 = blkdev_get_by_dev(bdev_handle->bdev->bd_dev,
+					 BLK_OPEN_READ | BLK_OPEN_WRITE,
+					 holder, NULL);
+	blkdev_put(bdev_handle);
 	bdev_handle = bdev_handle2;
 	if (IS_ERR(bdev_handle)) {
 		ret = PTR_ERR(bdev_handle);
@@ -2646,7 +2647,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	put_page(virt_to_page(sb_disk));
 out_blkdev_put:
 	if (bdev_handle)
-		blkdev_handle_put(bdev_handle);
+		blkdev_put(bdev_handle);
 out_free_sb:
 	kfree(sb);
 out_free_path:
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index d73905149bef..018ae5802efb 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -751,7 +751,7 @@ static struct table_device *open_table_device(struct mapped_device *md,
 		return ERR_PTR(-ENOMEM);
 	refcount_set(&td->count, 1);
 
-	bdev_handle = blkdev_get_handle_by_dev(dev, mode, _dm_claim_ptr, NULL);
+	bdev_handle = blkdev_get_by_dev(dev, mode, _dm_claim_ptr, NULL);
 	if (IS_ERR(bdev_handle)) {
 		r = PTR_ERR(bdev_handle);
 		goto out_free_td;
@@ -778,7 +778,7 @@ static struct table_device *open_table_device(struct mapped_device *md,
 	return td;
 
 out_blkdev_put:
-	blkdev_handle_put(bdev_handle);
+	blkdev_put(bdev_handle);
 out_free_td:
 	kfree(td);
 	return ERR_PTR(r);
@@ -791,7 +791,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
 {
 	if (md->disk->slave_dir)
 		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
-	blkdev_handle_put(td->dm_dev.bdev_handle);
+	blkdev_put(td->dm_dev.bdev_handle);
 	put_dax(td->dm_dev.dax_dev);
 	list_del(&td->list);
 	kfree(td);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index bed142ee6f1f..595aeb6cc766 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2458,7 +2458,7 @@ static void export_rdev(struct md_rdev *rdev, struct mddev *mddev)
 	if (test_bit(AutoDetected, &rdev->flags))
 		md_autodetect_dev(rdev->bdev->bd_dev);
 #endif
-	blkdev_handle_put(rdev->bdev_handle);
+	blkdev_put(rdev->bdev_handle);
 	rdev->bdev = NULL;
 	kobject_put(&rdev->kobj);
 }
@@ -3654,9 +3654,10 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	if (err)
 		goto out_clear_rdev;
 
-	rdev->bdev_handle = blkdev_get_handle_by_dev(newdev,
-			BLK_OPEN_READ | BLK_OPEN_WRITE,
-			super_format == -2 ? &claim_rdev : rdev, NULL);
+	rdev->bdev_handle = blkdev_get_by_dev(newdev,
+					      BLK_OPEN_READ | BLK_OPEN_WRITE,
+					      super_format == -2 ? &claim_rdev : rdev,
+					      NULL);
 	if (IS_ERR(rdev->bdev_handle)) {
 		pr_warn("md: could not open device unknown-block(%u,%u).\n",
 			MAJOR(newdev), MINOR(newdev));
@@ -3694,7 +3695,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 	return rdev;
 
 out_blkdev_put:
-	blkdev_handle_put(rdev->bdev_handle);
+	blkdev_put(rdev->bdev_handle);
 out_clear_rdev:
 	md_rdev_clear(rdev);
 out_free_rdev:
diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index 1614459297d2..385d34096031 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -213,7 +213,7 @@ static void block2mtd_free_device(struct block2mtd_dev *dev)
 	if (dev->bdev_handle) {
 		invalidate_mapping_pages(
 			dev->bdev_handle->bdev->bd_inode->i_mapping, 0, -1);
-		blkdev_handle_put(dev->bdev_handle);
+		blkdev_put(dev->bdev_handle);
 	}
 
 	kfree(dev);
@@ -253,8 +253,7 @@ static struct bdev_handle __ref *mdtblock_early_get_bdev(const char *devname,
 		wait_for_device_probe();
 
 		if (!early_lookup_bdev(devname, &devt)) {
-			bdev_handle = blkdev_get_handle_by_dev(devt, mode, dev,
-							       NULL);
+			bdev_handle = blkdev_get_by_dev(devt, mode, dev, NULL);
 			if (!IS_ERR(bdev_handle))
 				break;
 		}
@@ -280,7 +279,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		return NULL;
 
 	/* Get a handle on the device */
-	bdev_handle = blkdev_get_handle_by_path(devname, mode, dev, NULL);
+	bdev_handle = blkdev_get_by_path(devname, mode, dev, NULL);
 	if (IS_ERR(bdev_handle))
 		bdev_handle = mdtblock_early_get_bdev(devname, mode, timeout,
 						      dev);
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 0f177a7e3b37..3f600dad7cbb 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -51,7 +51,7 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 {
 	if (ns->bdev_handle) {
-		blkdev_handle_put(ns->bdev_handle);
+		blkdev_put(ns->bdev_handle);
 		ns->bdev = NULL;
 		ns->bdev_handle = NULL;
 	}
@@ -85,8 +85,9 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	if (ns->buffered_io)
 		return -ENOTBLK;
 
-	ns->bdev_handle = blkdev_get_handle_by_path(ns->device_path,
-				BLK_OPEN_READ | BLK_OPEN_WRITE, NULL, NULL);
+	ns->bdev_handle = blkdev_get_by_path(ns->device_path,
+					     BLK_OPEN_READ | BLK_OPEN_WRITE,
+					     NULL, NULL);
 	if (IS_ERR(ns->bdev_handle)) {
 		ret = PTR_ERR(ns->bdev_handle);
 		if (ret != -ENOTBLK) {
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 1c22a5ee2ce7..13af36180372 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -130,8 +130,8 @@ int dasd_scan_partitions(struct dasd_block *block)
 	struct bdev_handle *bdev_handle;
 	int rc;
 
-	bdev_handle = blkdev_get_handle_by_dev(disk_devt(block->gdp),
-				BLK_OPEN_READ, NULL, NULL);
+	bdev_handle = blkdev_get_by_dev(disk_devt(block->gdp), BLK_OPEN_READ,
+					NULL, NULL);
 	if (IS_ERR(bdev_handle)) {
 		DBF_DEV_EVENT(DBF_ERR, block->base,
 			      "scan partitions error, blkdev_get returned %ld",
@@ -147,13 +147,13 @@ int dasd_scan_partitions(struct dasd_block *block)
 				"scan partitions error, rc %d", rc);
 
 	/*
-	 * Since the matching blkdev_handle_put() call to the
-	 * blkdev_get_handle_by_path() in this function is not called before
-	 * dasd_destroy_partitions the offline open_count limit needs to be
-	 * increased from 0 to 1. This is done by setting device->bdev_handle
-	 * (see dasd_generic_set_offline). As long as the partition detection
-	 * is running no offline should be allowed. That is why the assignment
-	 * to block->bdev_handle is done AFTER the BLKRRPART ioctl.
+	 * Since the matching blkdev_put() call to the blkdev_get_by_path() in
+	 * this function is not called before dasd_destroy_partitions the
+	 * offline open_count limit needs to be increased from 0 to 1. This is
+	 * done by setting device->bdev_handle (see dasd_generic_set_offline).
+	 * As long as the partition detection is running no offline should be
+	 * allowed. That is why the assignment to block->bdev_handle is done
+	 * AFTER the BLKRRPART ioctl.
 	 */
 	block->bdev_handle = bdev_handle;
 	return 0;
@@ -179,7 +179,7 @@ void dasd_destroy_partitions(struct dasd_block *block)
 	mutex_unlock(&bdev_handle->bdev->bd_disk->open_mutex);
 
 	/* Matching blkdev_put to the blkdev_get in dasd_scan_partitions. */
-	blkdev_handle_put(bdev_handle);
+	blkdev_put(bdev_handle);
 }
 
 int dasd_gendisk_init(void)
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 979b0cfbea4a..d271a536d66f 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -117,8 +117,8 @@ static int iblock_configure_device(struct se_device *dev)
 	else
 		dev->dev_flags |= DF_READ_ONLY;
 
-	bdev_handle = blkdev_get_handle_by_path(ib_dev->ibd_udev_path, mode,
-				ib_dev, NULL);
+	bdev_handle = blkdev_get_by_path(ib_dev->ibd_udev_path, mode, ib_dev,
+					 NULL);
 	if (IS_ERR(bdev_handle)) {
 		ret = PTR_ERR(bdev_handle);
 		goto out_free_bioset;
@@ -180,7 +180,7 @@ static int iblock_configure_device(struct se_device *dev)
 	return 0;
 
 out_blkdev_put:
-	blkdev_handle_put(ib_dev->ibd_bdev_handle);
+	blkdev_put(ib_dev->ibd_bdev_handle);
 out_free_bioset:
 	bioset_exit(&ib_dev->ibd_bio_set);
 out:
@@ -206,7 +206,7 @@ static void iblock_destroy_device(struct se_device *dev)
 	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
 
 	if (ib_dev->ibd_bdev_handle)
-		blkdev_handle_put(ib_dev->ibd_bdev_handle);
+		blkdev_put(ib_dev->ibd_bdev_handle);
 	bioset_exit(&ib_dev->ibd_bio_set);
 }
 
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 9ea2b29e95bf..38416426707f 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -366,10 +366,11 @@ static int pscsi_create_type_disk(struct se_device *dev, struct scsi_device *sd)
 	 * Claim exclusive struct block_device access to struct scsi_device
 	 * for TYPE_DISK and TYPE_ZBC using supplied udev_path
 	 */
-	bdev_handle = blkdev_get_handle_by_path(dev->udev_path,
-				BLK_OPEN_WRITE | BLK_OPEN_READ, pdv, NULL);
+	bdev_handle = blkdev_get_by_path(dev->udev_path,
+					 BLK_OPEN_WRITE | BLK_OPEN_READ, pdv,
+					 NULL);
 	if (IS_ERR(bdev_handle)) {
-		pr_err("pSCSI: blkdev_get_handle_by_path() failed\n");
+		pr_err("pSCSI: blkdev_get_by_path() failed\n");
 		scsi_device_put(sd);
 		return PTR_ERR(bdev_handle);
 	}
@@ -377,7 +378,7 @@ static int pscsi_create_type_disk(struct se_device *dev, struct scsi_device *sd)
 
 	ret = pscsi_add_device_to_list(dev, sd);
 	if (ret) {
-		blkdev_handle_put(bdev_handle);
+		blkdev_put(bdev_handle);
 		scsi_device_put(sd);
 		return ret;
 	}
@@ -565,7 +566,7 @@ static void pscsi_destroy_device(struct se_device *dev)
 		 */
 		if ((sd->type == TYPE_DISK || sd->type == TYPE_ZBC) &&
 		    pdv->pdv_bdev_handle) {
-			blkdev_handle_put(pdv->pdv_bdev_handle);
+			blkdev_put(pdv->pdv_bdev_handle);
 			pdv->pdv_bdev_handle = NULL;
 		}
 		/*
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 639eaecf1036..9842d777db76 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -258,8 +258,8 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 		return -EINVAL;
 	}
 
-	bdev_handle = blkdev_get_handle_by_path(device_path, BLK_OPEN_WRITE,
-				fs_info->bdev_holder, NULL);
+	bdev_handle = blkdev_get_by_path(device_path, BLK_OPEN_WRITE,
+					 fs_info->bdev_holder, NULL);
 	if (IS_ERR(bdev_handle)) {
 		btrfs_err(fs_info, "target device %s is invalid!", device_path);
 		return PTR_ERR(bdev_handle);
@@ -336,7 +336,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	return 0;
 
 error:
-	blkdev_handle_put(bdev_handle);
+	blkdev_put(bdev_handle);
 	return ret;
 }
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7d8f5625ad70..92aaba3e6948 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2722,7 +2722,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 err_drop:
 	mnt_drop_write_file(file);
 	if (bdev_handle)
-		blkdev_handle_put(bdev_handle);
+		blkdev_put(bdev_handle);
 out:
 	btrfs_put_dev_args_from_path(&args);
 	kfree(vol_args);
@@ -2770,7 +2770,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 
 	mnt_drop_write_file(file);
 	if (bdev_handle)
-		blkdev_handle_put(bdev_handle);
+		blkdev_put(bdev_handle);
 out:
 	btrfs_put_dev_args_from_path(&args);
 	kfree(vol_args);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index db63b0be5405..fb7082426498 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -517,8 +517,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 	struct block_device *bdev;
 	int ret;
 
-	*bdev_handle = blkdev_get_handle_by_path(device_path, flags, holder,
-						 NULL);
+	*bdev_handle = blkdev_get_by_path(device_path, flags, holder, NULL);
 
 	if (IS_ERR(*bdev_handle)) {
 		ret = PTR_ERR(*bdev_handle);
@@ -530,14 +529,14 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 		sync_blockdev(bdev);
 	ret = set_blocksize(bdev, BTRFS_BDEV_BLOCKSIZE);
 	if (ret) {
-		blkdev_handle_put(*bdev_handle);
+		blkdev_put(*bdev_handle);
 		goto error;
 	}
 	invalidate_bdev(bdev);
 	*disk_super = btrfs_read_dev_super(bdev);
 	if (IS_ERR(*disk_super)) {
 		ret = PTR_ERR(*disk_super);
-		blkdev_handle_put(*bdev_handle);
+		blkdev_put(*bdev_handle);
 		goto error;
 	}
 
@@ -679,7 +678,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 
 error_free_page:
 	btrfs_release_disk_super(disk_super);
-	blkdev_handle_put(bdev_handle);
+	blkdev_put(bdev_handle);
 
 	return -EINVAL;
 }
@@ -1070,7 +1069,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
 			continue;
 
 		if (device->bdev_handle) {
-			blkdev_handle_put(device->bdev_handle);
+			blkdev_put(device->bdev_handle);
 			device->bdev = NULL;
 			device->bdev_handle = NULL;
 			fs_devices->open_devices--;
@@ -1117,7 +1116,7 @@ static void btrfs_close_bdev(struct btrfs_device *device)
 		invalidate_bdev(device->bdev);
 	}
 
-	blkdev_handle_put(device->bdev_handle);
+	blkdev_put(device->bdev_handle);
 }
 
 static void btrfs_close_one_device(struct btrfs_device *device)
@@ -1388,7 +1387,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
 	 * values temporarily, as the device paths of the fsid are the only
 	 * required information for assembling the volume.
 	 */
-	bdev_handle = blkdev_get_handle_by_path(path, flags, NULL, NULL);
+	bdev_handle = blkdev_get_by_path(path, flags, NULL, NULL);
 	if (IS_ERR(bdev_handle))
 		return ERR_CAST(bdev_handle);
 
@@ -1413,7 +1412,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
 	btrfs_release_disk_super(disk_super);
 
 error_bdev_put:
-	blkdev_handle_put(bdev_handle);
+	blkdev_put(bdev_handle);
 
 	return device;
 }
@@ -2225,9 +2224,9 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	 * free the device.
 	 *
 	 * We cannot call btrfs_close_bdev() here because we're holding the sb
-	 * write lock, and blkdev_handle_put() will pull in the ->open_mutex on
-	 * the block device and it's dependencies.  Instead just flush the
-	 * device and let the caller do the final blkdev_handle_put.
+	 * write lock, and blkdev_put() will pull in the ->open_mutex on the
+	 * block device and it's dependencies.  Instead just flush the device
+	 * and let the caller do the final blkdev_put.
 	 */
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
 		btrfs_scratch_superblocks(fs_info, device->bdev,
@@ -2406,7 +2405,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 	else
 		memcpy(args->fsid, disk_super->fsid, BTRFS_FSID_SIZE);
 	btrfs_release_disk_super(disk_super);
-	blkdev_handle_put(bdev_handle);
+	blkdev_put(bdev_handle);
 	return 0;
 }
 
@@ -2639,8 +2638,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	if (sb_rdonly(sb) && !fs_devices->seeding)
 		return -EROFS;
 
-	bdev_handle = blkdev_get_handle_by_path(device_path, BLK_OPEN_WRITE,
-						fs_info->bdev_holder, NULL);
+	bdev_handle = blkdev_get_by_path(device_path, BLK_OPEN_WRITE,
+					 fs_info->bdev_holder, NULL);
 	if (IS_ERR(bdev_handle))
 		return PTR_ERR(bdev_handle);
 
@@ -2860,7 +2859,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 error_free_device:
 	btrfs_free_device(device);
 error:
-	blkdev_handle_put(bdev_handle);
+	blkdev_put(bdev_handle);
 	if (locked) {
 		mutex_unlock(&uuid_mutex);
 		up_write(&sb->s_umount);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index a4742cc05f95..60d6b43ae5e3 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -254,8 +254,8 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 			return PTR_ERR(fscache);
 		dif->fscache = fscache;
 	} else if (!sbi->devs->flatdev) {
-		bdev_handle = blkdev_get_handle_by_path(dif->path,
-				BLK_OPEN_READ, sb->s_type, NULL);
+		bdev_handle = blkdev_get_by_path(dif->path, BLK_OPEN_READ,
+						 sb->s_type, NULL);
 		if (IS_ERR(bdev_handle))
 			return PTR_ERR(bdev_handle);
 		dif->bdev_handle = bdev_handle;
@@ -816,7 +816,7 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 
 	fs_put_dax(dif->dax_dev, NULL);
 	if (dif->bdev_handle)
-		blkdev_handle_put(dif->bdev_handle);
+		blkdev_put(dif->bdev_handle);
 	erofs_fscache_unregister_cookie(dif->fscache);
 	dif->fscache = NULL;
 	kfree(dif->path);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a3b982d6abf1..cbeb8a555fe3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1112,8 +1112,8 @@ static struct bdev_handle *ext4_blkdev_get(dev_t dev, struct super_block *sb)
 {
 	struct bdev_handle *handle;
 
-	handle = blkdev_get_handle_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE,
-					  sb, &ext4_holder_ops);
+	handle = blkdev_get_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE, sb,
+				   &ext4_holder_ops);
 	if (IS_ERR(handle))
 		goto fail;
 	return handle;
@@ -1137,7 +1137,7 @@ static void ext4_blkdev_remove(struct ext4_sb_info *sbi)
 		 * hotswapped, and it breaks the `ro-after' testing code.
 		 */
 		invalidate_bdev(sbi->s_journal_bdev_handle->bdev);
-		blkdev_handle_put(sbi->s_journal_bdev_handle);
+		blkdev_put(sbi->s_journal_bdev_handle);
 		sbi->s_journal_bdev_handle = NULL;
 	}
 }
@@ -5928,7 +5928,7 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
 out_journal:
 	jbd2_journal_destroy(journal);
 out_bdev:
-	blkdev_handle_put(bdev_handle);
+	blkdev_put(bdev_handle);
 	return NULL;
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 570364954578..2823f3eb36c7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1538,7 +1538,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 	int i;
 
 	for (i = 0; i < sbi->s_ndevs; i++) {
-		blkdev_handle_put(FDEV(i).bdev_handle);
+		blkdev_put(FDEV(i).bdev_handle);
 #ifdef CONFIG_BLK_DEV_ZONED
 		kvfree(FDEV(i).blkz_seq);
 #endif
@@ -4024,9 +4024,10 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 
 		if (max_devices == 1) {
 			/* Single zoned block device mount */
-			FDEV(0).bdev_handle = blkdev_get_handle_by_dev(
-					sbi->sb->s_bdev->bd_dev,
-					mode, sbi->sb->s_type, NULL);
+			FDEV(0).bdev_handle = blkdev_get_by_dev(sbi->sb->s_bdev->bd_dev,
+								mode,
+								sbi->sb->s_type,
+								NULL);
 		} else {
 			/* Multi-device mount */
 			memcpy(FDEV(i).path, RDEV(i).path, MAX_PATH_LEN);
@@ -4044,8 +4045,10 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 					(FDEV(i).total_segments <<
 					sbi->log_blocks_per_seg) - 1;
 			}
-			FDEV(i).bdev_handle = blkdev_get_handle_by_path(
-				FDEV(i).path, mode, sbi->sb->s_type, NULL);
+			FDEV(i).bdev_handle = blkdev_get_by_path(FDEV(i).path,
+								 mode,
+								 sbi->sb->s_type,
+								 NULL);
 		}
 		if (IS_ERR(FDEV(i).bdev_handle))
 			return PTR_ERR(FDEV(i).bdev_handle);
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 9d06323261e6..4f5171f24191 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1100,8 +1100,9 @@ int lmLogOpen(struct super_block *sb)
 	 * file systems to log may have n-to-1 relationship;
 	 */
 
-	bdev_handle = blkdev_get_handle_by_dev(sbi->logdev,
-			BLK_OPEN_READ | BLK_OPEN_WRITE, log, NULL);
+	bdev_handle = blkdev_get_by_dev(sbi->logdev,
+					BLK_OPEN_READ | BLK_OPEN_WRITE, log,
+					NULL);
 	if (IS_ERR(bdev_handle)) {
 		rc = PTR_ERR(bdev_handle);
 		goto free;
@@ -1141,7 +1142,7 @@ int lmLogOpen(struct super_block *sb)
 	lbmLogShutdown(log);
 
       close:		/* close external log device */
-	blkdev_handle_put(bdev_handle);
+	blkdev_put(bdev_handle);
 
       free:		/* free log descriptor */
 	mutex_unlock(&jfs_log_mutex);
@@ -1485,7 +1486,7 @@ int lmLogClose(struct super_block *sb)
 	bdev_handle = log->bdev_handle;
 	rc = lmLogShutdown(log);
 
-	blkdev_handle_put(bdev_handle);
+	blkdev_put(bdev_handle);
 
 	kfree(log);
 
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 549de8600beb..26d22802a6f6 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -35,7 +35,7 @@ bl_free_device(struct pnfs_block_dev *dev)
 		}
 
 		if (dev->bdev_handle)
-			blkdev_handle_put(dev->bdev_handle);
+			blkdev_put(dev->bdev_handle);
 	}
 }
 
@@ -243,8 +243,8 @@ bl_parse_simple(struct nfs_server *server, struct pnfs_block_dev *d,
 	if (!dev)
 		return -EIO;
 
-	bdev_handle = blkdev_get_handle_by_dev(dev,
-			BLK_OPEN_READ | BLK_OPEN_WRITE, NULL, NULL);
+	bdev_handle = blkdev_get_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE,
+					NULL, NULL);
 	if (IS_ERR(bdev_handle)) {
 		printk(KERN_WARNING "pNFS: failed to open device %d:%d (%ld)\n",
 			MAJOR(dev), MINOR(dev), PTR_ERR(bdev_handle));
@@ -311,8 +311,9 @@ bl_open_path(struct pnfs_block_volume *v, const char *prefix)
 	if (!devname)
 		return ERR_PTR(-ENOMEM);
 
-	bdev_handle = blkdev_get_handle_by_path(devname,
-			BLK_OPEN_READ | BLK_OPEN_WRITE, NULL, NULL);
+	bdev_handle = blkdev_get_by_path(devname,
+					 BLK_OPEN_READ | BLK_OPEN_WRITE, NULL,
+					 NULL);
 	if (IS_ERR(bdev_handle)) {
 		pr_warn("pNFS: failed to open device %s (%ld)\n",
 			devname, PTR_ERR(bdev_handle));
@@ -373,7 +374,7 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 	return 0;
 
 out_blkdev_put:
-	blkdev_handle_put(d->bdev_handle);
+	blkdev_put(d->bdev_handle);
 	return error;
 }
 
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 0aba0daa06d2..310ebbcc324d 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -1304,8 +1304,8 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 	struct dentry *root_dentry;
 	int err, s_new = false;
 
-	bdev_handle = blkdev_get_handle_by_path(dev_name, sb_open_mode(flags),
-				fs_type, NULL);
+	bdev_handle = blkdev_get_by_path(dev_name, sb_open_mode(flags),
+					 fs_type, NULL);
 	if (IS_ERR(bdev_handle))
 		return ERR_CAST(bdev_handle);
 
@@ -1377,7 +1377,7 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 	}
 
 	if (!s_new)
-		blkdev_handle_put(bdev_handle);
+		blkdev_put(bdev_handle);
 
 	return root_dentry;
 
@@ -1386,7 +1386,7 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 
  failed:
 	if (!s_new)
-		blkdev_handle_put(bdev_handle);
+		blkdev_put(bdev_handle);
 	return ERR_PTR(err);
 }
 
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 5509e7fb98db..c9f76d6cd796 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1510,7 +1510,7 @@ static void o2hb_region_release(struct config_item *item)
 	}
 
 	if (reg->hr_bdev_handle)
-		blkdev_handle_put(reg->hr_bdev_handle);
+		blkdev_put(reg->hr_bdev_handle);
 
 	kfree(reg->hr_slots);
 
@@ -1795,9 +1795,9 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	if (!S_ISBLK(f.file->f_mapping->host->i_mode))
 		goto out2;
 
-	reg->hr_bdev_handle = blkdev_get_handle_by_dev(
-			f.file->f_mapping->host->i_rdev,
-			BLK_OPEN_WRITE | BLK_OPEN_READ, NULL, NULL);
+	reg->hr_bdev_handle = blkdev_get_by_dev(f.file->f_mapping->host->i_rdev,
+						BLK_OPEN_WRITE | BLK_OPEN_READ,
+						NULL, NULL);
 	if (IS_ERR(reg->hr_bdev_handle)) {
 		ret = PTR_ERR(reg->hr_bdev_handle);
 		reg->hr_bdev_handle = NULL;
@@ -1904,7 +1904,7 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 
 out3:
 	if (ret < 0) {
-		blkdev_handle_put(reg->hr_bdev_handle);
+		blkdev_put(reg->hr_bdev_handle);
 		reg->hr_bdev_handle = NULL;
 	}
 out2:
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 9518ff7865f0..3eaff21947a0 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2587,7 +2587,7 @@ static void journal_list_init(struct super_block *sb)
 static void release_journal_dev(struct reiserfs_journal *journal)
 {
 	if (journal->j_bdev_handle) {
-		blkdev_handle_put(journal->j_bdev_handle);
+		blkdev_put(journal->j_bdev_handle);
 		journal->j_bdev_handle = NULL;
 	}
 }
@@ -2614,8 +2614,8 @@ static int journal_init_dev(struct super_block *super,
 	if ((!jdev_name || !jdev_name[0])) {
 		if (jdev == super->s_dev)
 			holder = NULL;
-		journal->j_bdev_handle = blkdev_get_handle_by_dev(jdev,
-					blkdev_mode, holder, NULL);
+		journal->j_bdev_handle = blkdev_get_by_dev(jdev, blkdev_mode,
+							   holder, NULL);
 		if (IS_ERR(journal->j_bdev_handle)) {
 			result = PTR_ERR(journal->j_bdev_handle);
 			journal->j_bdev_handle = NULL;
@@ -2630,8 +2630,8 @@ static int journal_init_dev(struct super_block *super,
 		return 0;
 	}
 
-	journal->j_bdev_handle = blkdev_get_handle_by_path(jdev_name,
-				blkdev_mode, holder, NULL);
+	journal->j_bdev_handle = blkdev_get_by_path(jdev_name, blkdev_mode,
+						    holder, NULL);
 	if (IS_ERR(journal->j_bdev_handle)) {
 		result = PTR_ERR(journal->j_bdev_handle);
 		journal->j_bdev_handle = NULL;
diff --git a/fs/super.c b/fs/super.c
index d35545364c5d..ea135fece772 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1266,9 +1266,9 @@ int get_tree_bdev(struct fs_context *fc,
 	if (!fc->source)
 		return invalf(fc, "No source specified");
 
-	bdev_handle = blkdev_get_handle_by_path(fc->source,
-			sb_open_mode(fc->sb_flags), fc->fs_type,
-			&fs_holder_ops);
+	bdev_handle = blkdev_get_by_path(fc->source,
+					 sb_open_mode(fc->sb_flags),
+					 fc->fs_type, &fs_holder_ops);
 	if (IS_ERR(bdev_handle)) {
 		errorf(fc, "%s: Can't open blockdev", fc->source);
 		return PTR_ERR(bdev_handle);
@@ -1283,7 +1283,7 @@ int get_tree_bdev(struct fs_context *fc,
 	if (bdev->bd_fsfreeze_count > 0) {
 		mutex_unlock(&bdev->bd_fsfreeze_mutex);
 		warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
-		blkdev_handle_put(bdev_handle);
+		blkdev_put(bdev_handle);
 		return -EBUSY;
 	}
 
@@ -1292,7 +1292,7 @@ int get_tree_bdev(struct fs_context *fc,
 	s = sget_fc(fc, test_bdev_super_fc, set_bdev_super_fc);
 	mutex_unlock(&bdev->bd_fsfreeze_mutex);
 	if (IS_ERR(s)) {
-		blkdev_handle_put(bdev_handle);
+		blkdev_put(bdev_handle);
 		return PTR_ERR(s);
 	}
 
@@ -1301,19 +1301,18 @@ int get_tree_bdev(struct fs_context *fc,
 		if ((fc->sb_flags ^ s->s_flags) & SB_RDONLY) {
 			warnf(fc, "%pg: Can't mount, would change RO state", bdev);
 			deactivate_locked_super(s);
-			blkdev_handle_put(bdev_handle);
+			blkdev_put(bdev_handle);
 			return -EBUSY;
 		}
 
 		/*
 		 * s_umount nests inside open_mutex during
-		 * __invalidate_device().  blkdev_handle_put() acquires
-		 * open_mutex and can't be called under s_umount.  Drop
-		 * s_umount temporarily.  This is safe as we're
-		 * holding an active reference.
+		 * __invalidate_device().  blkdev_put() acquires open_mutex and
+		 * can't be called under s_umount.  Drop s_umount temporarily.
+		 * This is safe as we're holding an active reference.
 		 */
 		up_write(&s->s_umount);
-		blkdev_handle_put(bdev_handle);
+		blkdev_put(bdev_handle);
 		down_write(&s->s_umount);
 	} else {
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
@@ -1351,8 +1350,8 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 	struct super_block *s;
 	int error = 0;
 
-	bdev_handle = blkdev_get_handle_by_path(dev_name, sb_open_mode(flags),
-				fs_type, &fs_holder_ops);
+	bdev_handle = blkdev_get_by_path(dev_name, sb_open_mode(flags),
+					 fs_type, &fs_holder_ops);
 	if (IS_ERR(bdev_handle))
 		return ERR_CAST(bdev_handle);
 	bdev = bdev_handle->bdev;
@@ -1383,13 +1382,12 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 
 		/*
 		 * s_umount nests inside open_mutex during
-		 * __invalidate_device().  blkdev_handle_put() acquires
-		 * open_mutex and can't be called under s_umount.  Drop
-		 * s_umount temporarily.  This is safe as we're
-		 * holding an active reference.
+		 * __invalidate_device().  blkdev_put() acquires open_mutex and
+		 * can't be called under s_umount.  Drop s_umount temporarily.
+		 * This is safe as we're holding an active reference.
 		 */
 		up_write(&s->s_umount);
-		blkdev_handle_put(bdev_handle);
+		blkdev_put(bdev_handle);
 		down_write(&s->s_umount);
 	} else {
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
@@ -1411,7 +1409,7 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 error_s:
 	error = PTR_ERR(s);
 error_bdev:
-	blkdev_handle_put(bdev_handle);
+	blkdev_put(bdev_handle);
 error:
 	return ERR_PTR(error);
 }
@@ -1424,7 +1422,7 @@ void kill_block_super(struct super_block *sb)
 	bdev->bd_super = NULL;
 	generic_shutdown_super(sb);
 	sync_blockdev(bdev);
-	blkdev_handle_put(sb->s_bdev_handle);
+	blkdev_put(sb->s_bdev_handle);
 }
 
 EXPORT_SYMBOL(kill_block_super);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 5a958ae3a3ae..b0fbf8ea7846 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -396,8 +396,8 @@ xfs_blkdev_get(
 {
 	int			error = 0;
 
-	*handlep = blkdev_get_handle_by_path(name,
-			BLK_OPEN_READ | BLK_OPEN_WRITE, mp, &xfs_holder_ops);
+	*handlep = blkdev_get_by_path(name, BLK_OPEN_READ | BLK_OPEN_WRITE,
+				      mp, &xfs_holder_ops);
 	if (IS_ERR(*handlep)) {
 		error = PTR_ERR(*handlep);
 		xfs_warn(mp, "Invalid device [%s], error=%d", name, error);
@@ -411,7 +411,7 @@ xfs_blkdev_put(
 	struct bdev_handle	*handle)
 {
 	if (handle)
-		blkdev_handle_put(handle);
+		blkdev_put(handle);
 }
 
 STATIC void
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 134dfd1162e2..4ae3647a0322 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1476,14 +1476,14 @@ struct bdev_handle {
 	void *holder;
 };
 
-struct bdev_handle *blkdev_get_handle_by_dev(dev_t dev, blk_mode_t mode,
-		void *holder, const struct blk_holder_ops *hops);
-struct bdev_handle *blkdev_get_handle_by_path(const char *path, blk_mode_t mode,
+struct bdev_handle *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
+				      const struct blk_holder_ops *hops);
+struct bdev_handle *blkdev_get_by_path(const char *path, blk_mode_t mode,
 		void *holder, const struct blk_holder_ops *hops);
 int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
 void bd_abort_claiming(struct block_device *bdev, void *holder);
-void blkdev_handle_put(struct bdev_handle *handle);
+void blkdev_put(struct bdev_handle *handle);
 
 /* just for blk-cgroup, don't use elsewhere */
 struct block_device *blkdev_get_no_open(dev_t dev);
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 9ebac878497f..25f06d92944c 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -357,14 +357,14 @@ static int swsusp_swap_check(void)
 		return res;
 	root_swap = res;
 
-	hib_resume_bdev_handle = blkdev_get_handle_by_dev(swsusp_resume_device,
-			BLK_OPEN_WRITE, NULL, NULL);
+	hib_resume_bdev_handle = blkdev_get_by_dev(swsusp_resume_device,
+						   BLK_OPEN_WRITE, NULL, NULL);
 	if (IS_ERR(hib_resume_bdev_handle))
 		return PTR_ERR(hib_resume_bdev_handle);
 
 	res = set_blocksize(hib_resume_bdev_handle->bdev, PAGE_SIZE);
 	if (res < 0)
-		blkdev_handle_put(hib_resume_bdev_handle);
+		blkdev_put(hib_resume_bdev_handle);
 
 	return res;
 }
@@ -1522,8 +1522,9 @@ int swsusp_check(bool snapshot_test)
 	void *holder = snapshot_test ? &swsusp_holder : NULL;
 	int error;
 
-	hib_resume_bdev_handle = blkdev_get_handle_by_dev(swsusp_resume_device,
-				BLK_OPEN_READ, holder, NULL);
+	hib_resume_bdev_handle = blkdev_get_by_dev(swsusp_resume_device,
+						   BLK_OPEN_READ, holder,
+						   NULL);
 	if (!IS_ERR(hib_resume_bdev_handle)) {
 		set_blocksize(hib_resume_bdev_handle->bdev, PAGE_SIZE);
 		clear_page(swsusp_header);
@@ -1550,7 +1551,7 @@ int swsusp_check(bool snapshot_test)
 
 put:
 		if (error)
-			blkdev_handle_put(hib_resume_bdev_handle);
+			blkdev_put(hib_resume_bdev_handle);
 		else
 			pr_debug("Image signature found, resuming\n");
 	} else {
@@ -1574,7 +1575,7 @@ void swsusp_close(void)
 		return;
 	}
 
-	blkdev_handle_put(hib_resume_bdev_handle);
+	blkdev_put(hib_resume_bdev_handle);
 }
 
 /**
diff --git a/mm/swapfile.c b/mm/swapfile.c
index dbd37aa4724d..921fdb7e5e09 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2528,7 +2528,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	inode = mapping->host;
 	if (p->bdev_handle) {
 		set_blocksize(p->bdev, old_block_size);
-		blkdev_handle_put(p->bdev_handle);
+		blkdev_put(p->bdev_handle);
 	}
 
 	inode_lock(inode);
@@ -2758,8 +2758,9 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 	int error;
 
 	if (S_ISBLK(inode->i_mode)) {
-		p->bdev_handle = blkdev_get_handle_by_dev(inode->i_rdev,
-				BLK_OPEN_READ | BLK_OPEN_WRITE, p, NULL);
+		p->bdev_handle = blkdev_get_by_dev(inode->i_rdev,
+						   BLK_OPEN_READ | BLK_OPEN_WRITE,
+						   p, NULL);
 		if (IS_ERR(p->bdev_handle)) {
 			error = PTR_ERR(p->bdev_handle);
 			p->bdev_handle = NULL;
@@ -3211,7 +3212,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	p->cluster_next_cpu = NULL;
 	if (p->bdev_handle) {
 		set_blocksize(p->bdev, p->old_block_size);
-		blkdev_handle_put(p->bdev_handle);
+		blkdev_put(p->bdev_handle);
 	}
 	inode = NULL;
 	destroy_swap_extents(p);
-- 
2.35.3

