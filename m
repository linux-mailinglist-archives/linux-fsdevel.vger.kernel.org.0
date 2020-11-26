Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6BE2C54CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 14:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389992AbgKZNHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 08:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389982AbgKZNHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:07:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AE7C0613D4;
        Thu, 26 Nov 2020 05:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tTzT8jq2JcyLxT+MVTv6IpSRH5wR3ADhzhpNBZQZp9A=; b=MQmIXKifz0KnTEIu7IEqIGZAjZ
        0XBYWs2SAQyChCu395vtRAVsj/re3eaOi/QBvDSAf9psqAsgo74Pf2LS6Q7WPQNJx15BMKG58tLW8
        QzhlOD99YeD8TVIb1aMUEXLQJuS5b2J7sNRDL+ufV2WeuvYwq7FGQqpBnmqXafhkhi5tiTEQlI9tR
        0uEQd6SVwBwBjGR7GunTUdnxjvZG/WOId3d3MmtCgRNuvTIhhSYlEsSrfumK/53T5+8lWuvjfou4O
        wjP6L9mQU2DFzSU0nfeVthDDJk1YF8HTgY1jQekup7mN3j1YDZ23KrrA7bXQlu9v0+4vZDe1ecvPJ
        S35gY1cA==;
Received: from [2001:4bb8:18c:1dd6:27b8:b8a1:c13e:ceb1] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGzQ-00044E-Kl; Thu, 26 Nov 2020 13:07:13 +0000
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
Subject: [PATCH 28/44] block: initialize struct block_device in bdev_alloc
Date:   Thu, 26 Nov 2020 14:04:06 +0100
Message-Id: <20201126130422.92945-29-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126130422.92945-1-hch@lst.de>
References: <20201126130422.92945-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't play tricks with slab constructors as bdev structures tends to not
get reused very much, and this makes the code a lot less error prone.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Tejun Heo <tj@kernel.org>
---
 fs/block_dev.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index f180ac0e87844f..58e8532d8580a1 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -784,20 +784,11 @@ static void bdev_free_inode(struct inode *inode)
 	kmem_cache_free(bdev_cachep, BDEV_I(inode));
 }
 
-static void init_once(void *foo)
+static void init_once(void *data)
 {
-	struct bdev_inode *ei = (struct bdev_inode *) foo;
-	struct block_device *bdev = &ei->bdev;
+	struct bdev_inode *ei = data;
 
-	memset(bdev, 0, sizeof(*bdev));
-	mutex_init(&bdev->bd_mutex);
-#ifdef CONFIG_SYSFS
-	INIT_LIST_HEAD(&bdev->bd_holder_disks);
-#endif
-	bdev->bd_bdi = &noop_backing_dev_info;
 	inode_init_once(&ei->vfs_inode);
-	/* Initialize mutex for freeze. */
-	mutex_init(&bdev->bd_fsfreeze_mutex);
 }
 
 static void bdev_evict_inode(struct inode *inode)
@@ -873,12 +864,17 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	mapping_set_gfp_mask(&inode->i_data, GFP_USER);
 
 	bdev = I_BDEV(inode);
+	memset(bdev, 0, sizeof(*bdev));
+	mutex_init(&bdev->bd_mutex);
+	mutex_init(&bdev->bd_fsfreeze_mutex);
 	spin_lock_init(&bdev->bd_size_lock);
 	bdev->bd_disk = disk;
 	bdev->bd_partno = partno;
-	bdev->bd_super = NULL;
 	bdev->bd_inode = inode;
-	bdev->bd_part_count = 0;
+	bdev->bd_bdi = &noop_backing_dev_info;
+#ifdef CONFIG_SYSFS
+	INIT_LIST_HEAD(&bdev->bd_holder_disks);
+#endif
 	return bdev;
 }
 
-- 
2.29.2

