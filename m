Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB62D6F8820
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 19:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjEERxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 13:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjEERxE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 13:53:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36A61CFD3;
        Fri,  5 May 2023 10:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gTes5Pm78FJvYxxSUk8UoveNBaJgC0YnqLmLhJ78wiw=; b=H3z6Rwk4JAZHUNdFWbWFlMlfXJ
        zbBk7GGrXa7wJCOtkY10rmzwZfddrr0rk2NfWG014UXHor6/tUOwALv4PgE1NCqZnmHLegNMOr0l4
        lKmEA7MNG3jOcnozjYkt7sbogJNmTRlC3aKT/U3oQxmEN4GOlyY6eYR7EKKxmYwFg7ls6ZcY7zxZr
        Bnf1iBawceI71AGxJjIEehyim7rNHLVmJ/t8q8sfUNM7IyTyo1Q704qY6xpZsdqb2t3P6FghPTRTO
        316/2VNxXyFjv/+aE7x6eW4GoM20T4nMoJ96t8oVJkYjRQnZhkou/KMHvhuDmH6O4EAoKhkKYmqQR
        7p3897Cg==;
Received: from 66-46-223-221.dedicated.allstream.net ([66.46.223.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puzaz-00BSxz-2j;
        Fri, 05 May 2023 17:51:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH 6/9] block: add a mark_dead holder operation
Date:   Fri,  5 May 2023 13:51:29 -0400
Message-Id: <20230505175132.2236632-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505175132.2236632-1-hch@lst.de>
References: <20230505175132.2236632-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a mark_dead method to blk_holder_ops that is called from blk_mark_disk_dead
to notify the holder that the block device it is using has been marked dead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c          | 24 ++++++++++++++++++++++++
 include/linux/blkdev.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index d1c673b967c254..af97a4ef1e926c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -575,6 +575,28 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 }
 EXPORT_SYMBOL(device_add_disk);
 
+static void blk_report_disk_dead(struct gendisk *disk)
+{
+	struct block_device *bdev;
+	unsigned long idx;
+
+	rcu_read_lock();
+	xa_for_each(&disk->part_tbl, idx, bdev) {
+		if (!kobject_get_unless_zero(&bdev->bd_device.kobj))
+			continue;
+		rcu_read_unlock();
+
+		mutex_lock(&bdev->bd_holder_lock);
+		if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead)
+			bdev->bd_holder_ops->mark_dead(bdev);
+		mutex_unlock(&bdev->bd_holder_lock);
+
+		put_device(&bdev->bd_device);
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+}
+
 /**
  * blk_mark_disk_dead - mark a disk as dead
  * @disk: disk to mark as dead
@@ -602,6 +624,8 @@ void blk_mark_disk_dead(struct gendisk *disk)
 	 * Prevent new I/O from crossing bio_queue_enter().
 	 */
 	blk_queue_start_drain(disk->queue);
+
+	blk_report_disk_dead(disk);
 }
 EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3f41f8c9b103cf..9706bec2be16a5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1469,6 +1469,7 @@ void blkdev_show(struct seq_file *seqf, off_t offset);
 #endif
 
 struct blk_holder_ops {
+	void (*mark_dead)(struct block_device *bdev);
 };
 
 struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
-- 
2.39.2

