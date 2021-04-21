Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431EF367072
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 18:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244403AbhDUQql (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 12:46:41 -0400
Received: from mx2.veeam.com ([64.129.123.6]:41976 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244370AbhDUQqj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:46:39 -0400
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 0FDFA424B9;
        Wed, 21 Apr 2021 12:45:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1619023559; bh=wcm/Vxh/k3YGgzIVuZKWUD3Up5EwpdCaQtTu9lM71ME=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=BeZlOsCg8/F2VPH67Yx74ffQ2+UWv8u0p4wizftzHlhZATcxysfMUNPo7NiOhkX8u
         u1QXrF+mCBCkkPqtF7JBZrRxW+WNAowTqn1GhS0KLrHentO+rIpQIKMrRnKGbi4IWq
         o3BTzAidCabs9TnH/Sh40sdEd/ERKYBiGTnDc684=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 21 Apr 2021 18:45:56 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, <dm-devel@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH v9 1/4] Adds blk_interposer
Date:   Wed, 21 Apr 2021 19:45:42 +0300
Message-ID: <1619023545-23431-2-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1619023545-23431-1-git-send-email-sergei.shtepa@veeam.com>
References: <1619023545-23431-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B59677566
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Additional fields were added in the block_device structure:
bd_interposer and bd_interposer_lock. The bd_interposer field contains
a pointer to an interposer block device. bd_interposer_lock is a lock
which allows to safely attach and detach the interposer device.

New functions bdev_interposer_attach() and bdev_interposer_detach()
allow to attach and detach an interposer device. But first it is
required to lock the processing of bio requests by the block device
with bdev_interposer_lock() function.

The BIO_INTERPOSED flag means that the bio request has been already
interposed. This flag avoids recursive bio request interception.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 block/genhd.c             | 52 +++++++++++++++++++++++++++++++++++++++
 fs/block_dev.c            |  3 +++
 include/linux/blk_types.h |  6 +++++
 include/linux/blkdev.h    | 32 ++++++++++++++++++++++++
 4 files changed, 93 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 8c8f543572e6..3ec77947b3ba 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1938,3 +1938,55 @@ static void disk_release_events(struct gendisk *disk)
 	WARN_ON_ONCE(disk->ev && disk->ev->block != 1);
 	kfree(disk->ev);
 }
+
+/**
+ * bdev_interposer_attach - Attach an interposer block device to original
+ * @original: original block device
+ * @interposer: interposer block device
+ *
+ * Before attaching an interposer, it is necessary to lock the processing
+ * of bio requests of the original device by calling bdev_interposer_lock().
+ *
+ * The bdev_interposer_detach() function allows to detach the interposer
+ * from the original block device.
+ */
+int bdev_interposer_attach(struct block_device *original,
+			   struct block_device *interposer)
+{
+	struct block_device *bdev;
+
+	WARN_ON(!original);
+	if (original->bd_interposer)
+		return -EBUSY;
+
+	bdev = bdgrab(interposer);
+	if (!bdev)
+		return -ENODEV;
+
+	original->bd_interposer = bdev;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bdev_interposer_attach);
+
+/**
+ * bdev_interposer_detach - Detach interposer from block device
+ * @original: original block device
+ *
+ * Before detaching an interposer, it is necessary to lock the processing
+ * of bio requests of the original device by calling bdev_interposer_lock().
+ *
+ * The interposer should be attached using the bdev_interposer_attach()
+ * function.
+ */
+void bdev_interposer_detach(struct block_device *original)
+{
+	if (WARN_ON(!original))
+		return;
+
+	if (!original->bd_interposer)
+		return;
+
+	bdput(original->bd_interposer);
+	original->bd_interposer = NULL;
+}
+EXPORT_SYMBOL_GPL(bdev_interposer_detach);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 09d6f7229db9..a98a56cc634f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -809,6 +809,7 @@ static void bdev_free_inode(struct inode *inode)
 {
 	struct block_device *bdev = I_BDEV(inode);
 
+	percpu_free_rwsem(&bdev->bd_interposer_lock);
 	free_percpu(bdev->bd_stats);
 	kfree(bdev->bd_meta_info);
 
@@ -909,6 +910,8 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 		iput(inode);
 		return NULL;
 	}
+	bdev->bd_interposer = NULL;
+	percpu_init_rwsem(&bdev->bd_interposer_lock);
 	return bdev;
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index db026b6ec15a..8e4309eb3b18 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -46,6 +46,11 @@ struct block_device {
 	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
 	struct gendisk *	bd_disk;
 	struct backing_dev_info *bd_bdi;
+	/* The interposer allows to redirect bio to another device */
+	struct block_device	*bd_interposer;
+	/* Lock the queue of block device to attach or detach interposer.
+	 * Allows to safely suspend and flush interposer. */
+	struct percpu_rw_semaphore bd_interposer_lock;
 
 	/* The counter of freeze processes */
 	int			bd_fsfreeze_count;
@@ -304,6 +309,7 @@ enum {
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
 	BIO_REMAPPED,
+	BIO_INTERPOSED,		/* bio was reassigned to another block device */
 	BIO_FLAG_LAST
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 158aefae1030..3e38b0c40b9d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -2029,4 +2029,36 @@ int fsync_bdev(struct block_device *bdev);
 int freeze_bdev(struct block_device *bdev);
 int thaw_bdev(struct block_device *bdev);
 
+/**
+ * bdev_interposer_lock - Lock bio processing
+ * @bdev: locking block device
+ *
+ * Lock the bio processing in submit_bio_noacct() for the new requests in the
+ * original block device. Requests from the interposer will not be locked.
+ *
+ * To unlock, use the bdev_interposer_unlock() function.
+ *
+ * This lock should be used to attach/detach the interposer to the device.
+ */
+static inline void bdev_interposer_lock(struct block_device *bdev)
+{
+	percpu_down_write(&bdev->bd_interposer_lock);
+}
+
+/**
+ * bdev_interposer_unlock - Unlock bio processing
+ * @bdev: locked block device
+ *
+ * Unlock the bio processing that was locked by bdev_interposer_lock() function.
+ *
+ * This lock should be used to attach/detach the interposer to the device.
+ */
+static inline void bdev_interposer_unlock(struct block_device *bdev)
+{
+	percpu_up_write(&bdev->bd_interposer_lock);
+}
+
+int bdev_interposer_attach(struct block_device *original,
+			   struct block_device *interposer);
+void bdev_interposer_detach(struct block_device *original);
 #endif /* _LINUX_BLKDEV_H */
-- 
2.20.1

