Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB6E359E18
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 13:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbhDIL6U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 07:58:20 -0400
Received: from mx2.veeam.com ([64.129.123.6]:33488 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233856AbhDIL6T (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:58:19 -0400
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Apr 2021 07:58:19 EDT
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id EA95F4031D;
        Fri,  9 Apr 2021 07:48:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1617968899; bh=+2bPtzUzVtQpEC7fz562SgI0kxywzXxLV22LRhp0aV8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=bGioDGFC4vYO9Kw7IENWqkl83hoPIRbfgkGl43DlVtL41g1K5aw1qFJbPFNXnDiLV
         utbTxsaUj8QkBQ+y1b8W8P14BLWqGWyxlr4kFIHJsp6CgkQixftfncqXs6gvK/Puy/
         CsyvkbjxziPKG2smA5sKl2du5GnSKfC42NC44rAg=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 9 Apr 2021 13:48:17 +0200
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
Subject: [PATCH v8 1/4] Adds blk_interposer. It allows to redirect bio requests to another block device.
Date:   Fri, 9 Apr 2021 14:48:01 +0300
Message-ID: <1617968884-15149-2-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617968884-15149-1-git-send-email-sergei.shtepa@veeam.com>
References: <1617968884-15149-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B59657262
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 block/genhd.c             | 51 +++++++++++++++++++++++++++++++++++++++
 fs/block_dev.c            |  3 +++
 include/linux/blk_types.h |  6 +++++
 include/linux/blkdev.h    | 32 ++++++++++++++++++++++++
 4 files changed, 92 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 8c8f543572e6..533b33897187 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1938,3 +1938,54 @@ static void disk_release_events(struct gendisk *disk)
 	WARN_ON_ONCE(disk->ev && disk->ev->block != 1);
 	kfree(disk->ev);
 }
+
+/**
+ * bdev_interposer_attach - Attach interposer block device to original
+ * @original: original block device
+ * @interposer: interposer block device
+ *
+ * Before attaching the interposer, it is necessary to lock the processing
+ * of bio requests of the original device by calling the bdev_interposer_lock().
+ *
+ * The bdev_interposer_detach() function allows to detach the interposer
+ * from original block device.
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
+ * Before detaching the interposer, it is necessary to lock the processing
+ * of bio requests of the original device by calling the bdev_interposer_lock().
+ *
+ * The interposer should be attached using function bdev_interposer_attach().
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
index 158aefae1030..9e376ee34e19 100644
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
+ * original block device. Requests from interposer will not be locked.
+ *
+ * To unlock, use the function bdev_interposer_unlock().
+ *
+ * This lock should be used to attach/detach interposer to the device.
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
+ * Unlock the bio processing that was locked by function bdev_interposer_lock().
+ *
+ * This lock should be used to attach/detach interposer to the device.
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

