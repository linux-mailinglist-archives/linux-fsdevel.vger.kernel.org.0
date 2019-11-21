Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3978110583F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 18:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKUROM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 12:14:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:54188 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727173AbfKURNo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:13:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2315BB27E;
        Thu, 21 Nov 2019 17:13:42 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hou Tao <houtao1@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Hannes Reinecke <hare@suse.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 08/10] bdev: add open_finish
Date:   Thu, 21 Nov 2019 18:13:15 +0100
Message-Id: <e86a001556d880f67047be19aab905f5f51623ac.1574355709.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574355709.git.msuchanek@suse.de>
References: <cover.1574355709.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Opening a block device may require a long operation such as waiting for
the cdrom tray to close or disk to spin up. Performing this operation
with locks held locks out other attempts to open the device from
processes that donn't care about the medium state.

To avoid this issue and still be able to perform time-consuming checks
at open() the block device driver can provide open_finish(). If it does
opening the device proceeds even when an error is returned from open(),
bd_mutex is released and open_finish() is called. If open_finish()
succeeds the device is now open, if it fails release() is called.

When -ERESTARTSYS is returned from open() blkdev_get may loop without
calling open_finish(). On -ERESTARTSYS open_finish() is not called.

When -ENXIO is returned there is no device to retry opening so this
error needs to be honored and open_finish() not called.

Move a ret = 0 assignment up in the if/else branching to avoid returning
-ENXIO. Previously the return value was ignored on the unhandled branch.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: new patch
v4:
 - fix crash on ENXIO
 - initialize capacity and partitions after open_finish
---
 Documentation/filesystems/locking.rst |  2 ++
 fs/block_dev.c                        | 27 +++++++++++++++++++++++----
 include/linux/blkdev.h                |  1 +
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index fc3a0704553c..2471ced5a8cf 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -456,6 +456,7 @@ block_device_operations
 prototypes::
 
 	int (*open) (struct block_device *, fmode_t);
+	int (*open_finish) (struct block_device *, fmode_t, int);
 	int (*release) (struct gendisk *, fmode_t);
 	int (*ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
 	int (*compat_ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
@@ -473,6 +474,7 @@ locking rules:
 ops			bd_mutex
 ======================= ===================
 open:			yes
+open_finish:		no
 release:		yes
 ioctl:			no
 compat_ioctl:		no
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 10c9e0ae2bdc..dc02af02d439 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1548,6 +1548,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	int partno;
 	int perm = 0;
 	bool first_open;
+	bool need_finish = false;
 
 	if (mode & FMODE_READ)
 		perm |= MAY_READ;
@@ -1604,13 +1605,16 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 					put_disk_and_module(disk);
 					goto restart;
 				}
+				if ((ret != -ENXIO) &&
+				    bdev->bd_disk->fops->open_finish)
+					need_finish = true;
 			}
 
 			if (!ret)
 				blkdev_init_size(bdev, disk);
 			blkdev_do_partitions(bdev, disk, ret);
 
-			if (ret)
+			if (ret && !need_finish)
 				goto out_clear;
 		} else {
 			struct block_device *whole;
@@ -1636,14 +1640,18 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 		if (bdev->bd_bdi == &noop_backing_dev_info)
 			bdev->bd_bdi = bdi_get(disk->queue->backing_dev_info);
 	} else {
+		ret = 0;
 		if (bdev->bd_contains == bdev) {
-			ret = 0;
-			if (bdev->bd_disk->fops->open)
+			if (bdev->bd_disk->fops->open) {
 				ret = bdev->bd_disk->fops->open(bdev, mode);
 
+				if ((ret != -ERESTARTSYS) && (ret != -ENXIO) &&
+				    bdev->bd_disk->fops->open_finish)
+					need_finish = true;
+			}
 			blkdev_do_partitions(bdev, disk, ret);
 
-			if (ret)
+			if (ret && !need_finish)
 				goto out_unlock_bdev;
 		}
 	}
@@ -1655,6 +1663,17 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	/* only one opener holds refs to the module and disk */
 	if (!first_open)
 		put_disk_and_module(disk);
+	if (ret && need_finish) {
+		ret = bdev->bd_disk->fops->open_finish(bdev, mode, ret);
+
+		if (!ret && first_open)
+			blkdev_init_size(bdev, disk);
+		blkdev_do_partitions(bdev, disk, ret);
+	}
+	if (ret) {
+		__blkdev_put(bdev, mode, for_part);
+		return ret;
+	}
 	return 0;
 
  out_clear:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f3ea78b0c91c..b67e93c6afb7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1695,6 +1695,7 @@ static inline struct bio_vec *rq_integrity_vec(struct request *rq)
 
 struct block_device_operations {
 	int (*open) (struct block_device *, fmode_t);
+	int (*open_finish)(struct block_device *bdev, fmode_t mode, int ret);
 	void (*release) (struct gendisk *, fmode_t);
 	int (*rw_page)(struct block_device *, sector_t, struct page *, unsigned int);
 	int (*ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
-- 
2.23.0

