Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD9A2187A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 14:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgGHMeu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 08:34:50 -0400
Received: from casper.infradead.org ([90.155.50.34]:33786 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbgGHMet (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:34:49 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jul 2020 08:34:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZkV04PitK4z6d5CfWwL1ZjMYfYxppkuHiqkKWa0poRE=; b=OBEWlLAZdyoVGQ3F5UVsXk5uZw
        nMNE39D2XcSvos21kke5WovZt265gieLA72C1jKxq5BIqd2Lf6QNblmhffb4xcJr5B3BSpJPvOCfG
        z+At9jPRFrEOo7BAZ1UsaVAFQcP6Ln2qq3AXuoZLzjrhojdNKyheHXZTJEfcCS2pB53LQ6lNIwcam
        SQWOu7CXvq/VhMXVydmZ+d07/e7V/p13CKVbJ5NHC9hxPQJ1UEuAO6OZcAx6qlPuwHHaYPfLfSYoj
        u3t/+IEwSH375ANyPPVIDYjQAzvdC8z5Pez4lqVopg4f4MMTx3zYCtY6ntJ5mIqKrZAJmiSDOGbrY
        e57MQyAA==;
Received: from 213-225-32-40.nat.highway.a1.net ([213.225.32.40] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jt9Ha-000280-NX; Wed, 08 Jul 2020 12:34:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/6] block: remove flush_disk
Date:   Wed,  8 Jul 2020 14:25:43 +0200
Message-Id: <20200708122546.214579-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708122546.214579-1-hch@lst.de>
References: <20200708122546.214579-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

flush_disk has only two callers, so open code it there.  That also helps
clarifying the error message for the particular case, and allows to remove
setting bd_invalidated in check_disk_size_change, which will be cleared
again instantly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 2d2fcb50e78eac..a36d5b6907ea4e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1347,26 +1347,6 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);
 #endif
 
-/**
- * flush_disk - invalidates all buffer-cache entries on a disk
- *
- * @bdev:      struct block device to be flushed
- * @kill_dirty: flag to guide handling of dirty inodes
- *
- * Invalidates all buffer-cache entries on a disk. It should be called
- * when a disk has been changed -- either by a media change or online
- * resize.
- */
-static void flush_disk(struct block_device *bdev, bool kill_dirty)
-{
-	if (__invalidate_device(bdev, kill_dirty)) {
-		printk(KERN_WARNING "VFS: busy inodes on changed media or "
-		       "resized disk %s\n",
-		       bdev->bd_disk ? bdev->bd_disk->disk_name : "");
-	}
-	bdev->bd_invalidated = 1;
-}
-
 /**
  * check_disk_size_change - checks for disk size change and adjusts bdev size.
  * @disk: struct gendisk to check
@@ -1391,8 +1371,9 @@ static void check_disk_size_change(struct gendisk *disk,
 			       disk->disk_name, bdev_size, disk_size);
 		}
 		i_size_write(bdev->bd_inode, disk_size);
-		if (bdev_size > disk_size)
-			flush_disk(bdev, false);
+		if (bdev_size > disk_size && __invalidate_device(bdev, false))
+			pr_warn("VFS: busy inodes on resized disk %s\n",
+				disk->disk_name);
 	}
 	bdev->bd_invalidated = 0;
 }
@@ -1451,7 +1432,10 @@ int check_disk_change(struct block_device *bdev)
 	if (!(events & DISK_EVENT_MEDIA_CHANGE))
 		return 0;
 
-	flush_disk(bdev, true);
+	if (__invalidate_device(bdev, true))
+		pr_warn("VFS: busy inodes on changed media %s\n",
+			disk->disk_name);
+	bdev->bd_invalidated = 1;
 	if (bdops->revalidate_disk)
 		bdops->revalidate_disk(bdev->bd_disk);
 	return 1;
-- 
2.26.2

