Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D00310A4C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 20:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKZTyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 14:54:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:40276 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbfKZTyp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:54:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69271B11E;
        Tue, 26 Nov 2019 19:54:44 +0000 (UTC)
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
Subject: [PATCH v4 rebase 07/10] bdev: separate parts of __blkdev_get as helper functions
Date:   Tue, 26 Nov 2019 20:54:26 +0100
Message-Id: <1bf484f0003874d8bc6935ed4653e40ba597afd4.1574797504.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574797504.git.msuchanek@suse.de>
References: <cover.1574797504.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This code will be reused in later patch. Hopefully putting it aside
rather than cut&pasting another copy will make the function more
readable.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 fs/block_dev.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 545bb6c8848a..a386ebd997fb 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1547,6 +1547,24 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
  */
 EXPORT_SYMBOL_GPL(bdev_disk_changed);
 
+static void blkdev_init_size(struct block_device *bdev)
+{
+	bd_set_size(bdev, (loff_t)get_capacity(bdev->bd_disk) << 9);
+	set_init_blocksize(bdev);
+}
+
+static void blkdev_do_partitions(struct block_device *bdev, int ret)
+{
+	/*
+	 * If the device is invalidated, rescan partition if open succeeded or
+	 * failed with -ENOMEDIUM.  The latter is necessary to prevent ghost
+	 * partitions on a removed medium.
+	 */
+	if (bdev->bd_invalidated &&
+			(!ret || ret == -ENOMEDIUM))
+		bdev_disk_changed(bdev, ret == -ENOMEDIUM);
+}
+
 /*
  * bd_mutex locking:
  *
@@ -1619,20 +1637,9 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 				}
 			}
 
-			if (!ret) {
-				bd_set_size(bdev,(loff_t)get_capacity(disk)<<9);
-				set_init_blocksize(bdev);
-			}
-
-			/*
-			 * If the device is invalidated, rescan partition
-			 * if open succeeded or failed with -ENOMEDIUM.
-			 * The latter is necessary to prevent ghost
-			 * partitions on a removed medium.
-			 */
-			if (bdev->bd_invalidated &&
-			    (!ret || ret == -ENOMEDIUM))
-				bdev_disk_changed(bdev, ret == -ENOMEDIUM);
+			if (!ret)
+				blkdev_init_size(bdev);
+			blkdev_do_partitions(bdev, ret);
 
 			if (ret)
 				goto out_clear;
@@ -1664,10 +1671,9 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 			ret = 0;
 			if (bdev->bd_disk->fops->open)
 				ret = bdev->bd_disk->fops->open(bdev, mode);
-			/* the same as first opener case, read comment there */
-			if (bdev->bd_invalidated &&
-			    (!ret || ret == -ENOMEDIUM))
-				bdev_disk_changed(bdev, ret == -ENOMEDIUM);
+
+			blkdev_do_partitions(bdev, ret);
+
 			if (ret)
 				goto out_unlock_bdev;
 		}
-- 
2.23.0

