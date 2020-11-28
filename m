Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D9D2C74BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 23:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbgK1Vte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387421AbgK1THa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:07:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03FAC02549C;
        Sat, 28 Nov 2020 08:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VyfohpMJJf6/tds88ua6YS72KF9FS+Hs1ZQ7QStrR3Y=; b=IDwA6p9bZuaf7fipocqaiu3Hk4
        LwXYpP3EoHe2rRWbxDhQy4QH9jZLqJvqjCREkvHMDveRtVqVSTFqX9VO1GtGBwFOyDnLP9WGvlXjv
        aS6zqv3VeaiqoFfB7zyP/X5oSmC4fUl73a8Pnfugsk+PJlLhZVAO9C/Qw8sF5hVnsdW4Z7tuGFZWR
        FdVWPdz9dkgREhnVP2/Cv1UX6Kycst1grHDz8SsuRShjzMMA/TYvl6M/PQTwa+WBSebR0BA8CxHZ3
        l9EcZo0H537CiL5gxiZOA2TqySJLzkaDfEhf8BT1oqO/UxGwEJlB8E6Kys4smGWGxpqR2nP6ZkHjg
        w+7LzHEQ==;
Received: from 089144198196.atnat0007.highway.a1.net ([89.144.198.196] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kj3AP-0001cK-DH; Sat, 28 Nov 2020 16:33:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 41/45] block: pass a block_device to invalidate_partition
Date:   Sat, 28 Nov 2020 17:15:06 +0100
Message-Id: <20201128161510.347752-42-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201128161510.347752-1-hch@lst.de>
References: <20201128161510.347752-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass the block_device actually needed instead of looking it up using
bdget_disk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/genhd.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 835393b7101ace..28ced566c07bb7 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -795,14 +795,8 @@ void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk)
 }
 EXPORT_SYMBOL(device_add_disk_no_queue_reg);
 
-static void invalidate_partition(struct gendisk *disk, int partno)
+static void invalidate_partition(struct block_device *bdev)
 {
-	struct block_device *bdev;
-
-	bdev = bdget_disk(disk, partno);
-	if (!bdev)
-		return;
-
 	fsync_bdev(bdev);
 	__invalidate_device(bdev, true);
 
@@ -811,7 +805,6 @@ static void invalidate_partition(struct gendisk *disk, int partno)
 	 * up any more even if openers still hold references to it.
 	 */
 	remove_inode_hash(bdev->bd_inode);
-	bdput(bdev);
 }
 
 /**
@@ -856,12 +849,12 @@ void del_gendisk(struct gendisk *disk)
 	disk_part_iter_init(&piter, disk,
 			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
 	while ((part = disk_part_iter_next(&piter))) {
-		invalidate_partition(disk, part->bdev->bd_partno);
+		invalidate_partition(part->bdev);
 		delete_partition(part);
 	}
 	disk_part_iter_exit(&piter);
 
-	invalidate_partition(disk, 0);
+	invalidate_partition(disk->part0);
 	set_capacity(disk, 0);
 	disk->flags &= ~GENHD_FL_UP;
 	up_write(&bdev_lookup_sem);
-- 
2.29.2

