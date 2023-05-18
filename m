Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A165970790B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 06:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjEREYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 00:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjEREX5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 00:23:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBE43A96;
        Wed, 17 May 2023 21:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ongTMoMI8FEf4cmvaiFjmwIegxtbslCeh+xQGxIRlfY=; b=JBnK1kSEEAFPU6gQHXuNjvWwKj
        Q5VI4+R7nhVOUqmECBivkViMWkaqHuEyrp4KQHAPrR3yztpz8FIjvSnuKuhM78MWKFBYTpujp54ag
        VWOlYuDKVRNgCwu9Gktg+bc3jrckHMw8duMVW9/CxSR5EqKBSc+OQOuOIJ8A5T8GLW35a/Kmn3Hjy
        lYkMNlvId95YEQYcumAgWK/BWz2jqXhsaR0WUFAqE3TCU0YXrjNsAJgiTd4v0a8toF7JfnKAfMHTf
        Cwn2+fmBfVBHONBN8Kp1RN7IdYJZNSVYrDe8d0IfjFw9ggwF6YydJnMoJia2nmZqdx8fKIvDQ5ixE
        no9Vk/KA==;
Received: from [2001:4bb8:188:3dd5:c90:b13:29fb:f2b9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzVB8-00BqRP-2Z;
        Thu, 18 May 2023 04:23:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 10/13] block: add a mark_dead holder operation
Date:   Thu, 18 May 2023 06:23:19 +0200
Message-Id: <20230518042323.663189-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518042323.663189-1-hch@lst.de>
References: <20230518042323.663189-1-hch@lst.de>
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
Acked-by: Christian Brauner <brauner@kernel.org>
---
 block/genhd.c          | 24 ++++++++++++++++++++++++
 include/linux/blkdev.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 226ddb8329f751..42aebf0e1e2628 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -565,6 +565,28 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
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
@@ -592,6 +614,8 @@ void blk_mark_disk_dead(struct gendisk *disk)
 	 * Prevent new I/O from crossing bio_queue_enter().
 	 */
 	blk_queue_start_drain(disk->queue);
+
+	blk_report_disk_dead(disk);
 }
 EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c94f3b63c86422..41f894f6355f96 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1466,6 +1466,7 @@ void blkdev_show(struct seq_file *seqf, off_t offset);
 #endif
 
 struct blk_holder_ops {
+	void (*mark_dead)(struct block_device *bdev);
 };
 
 struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
-- 
2.39.2

