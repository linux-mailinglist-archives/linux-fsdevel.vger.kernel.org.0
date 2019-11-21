Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7073E105839
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 18:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfKURNo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 12:13:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:54298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727165AbfKURNo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:13:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B3A0B27A;
        Thu, 21 Nov 2019 17:13:41 +0000 (UTC)
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
Subject: [PATCH v4 07/10] bdev: separate parts of __blkdev_get as helper functions
Date:   Thu, 21 Nov 2019 18:13:14 +0100
Message-Id: <49c843f88373d9ad4f6e607f704f51ca84c1747d.1574355709.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574355709.git.msuchanek@suse.de>
References: <cover.1574355709.git.msuchanek@suse.de>
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
 fs/block_dev.c | 52 +++++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index a3083fbada8b..10c9e0ae2bdc 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1512,6 +1512,28 @@ EXPORT_SYMBOL(bd_set_size);
 
 static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 
+static void blkdev_init_size(struct block_device *bdev, struct gendisk *disk)
+{
+	bd_set_size(bdev, (loff_t)get_capacity(disk) << 9);
+	set_init_blocksize(bdev);
+}
+
+static void blkdev_do_partitions(struct block_device *bdev,
+				 struct gendisk *disk, int ret)
+{
+	/*
+	 * If the device is invalidated, rescan partition if open succeeded or
+	 * failed with -ENOMEDIUM.  The latter is necessary to prevent ghost
+	 * partitions on a removed medium.
+	 */
+	if (bdev->bd_invalidated) {
+		if (!ret)
+			rescan_partitions(disk, bdev);
+		else if (ret == -ENOMEDIUM)
+			invalidate_partitions(disk, bdev);
+	}
+}
+
 /*
  * bd_mutex locking:
  *
@@ -1584,23 +1606,9 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
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
-			if (bdev->bd_invalidated) {
-				if (!ret)
-					rescan_partitions(disk, bdev);
-				else if (ret == -ENOMEDIUM)
-					invalidate_partitions(disk, bdev);
-			}
+			if (!ret)
+				blkdev_init_size(bdev, disk);
+			blkdev_do_partitions(bdev, disk, ret);
 
 			if (ret)
 				goto out_clear;
@@ -1632,13 +1640,9 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 			ret = 0;
 			if (bdev->bd_disk->fops->open)
 				ret = bdev->bd_disk->fops->open(bdev, mode);
-			/* the same as first opener case, read comment there */
-			if (bdev->bd_invalidated) {
-				if (!ret)
-					rescan_partitions(bdev->bd_disk, bdev);
-				else if (ret == -ENOMEDIUM)
-					invalidate_partitions(bdev->bd_disk, bdev);
-			}
+
+			blkdev_do_partitions(bdev, disk, ret);
+
 			if (ret)
 				goto out_unlock_bdev;
 		}
-- 
2.23.0

