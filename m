Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5DB1FE9DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 06:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgFREUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 00:20:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38312 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbgFREUc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 00:20:32 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A8AC1B93092C9B07A690;
        Thu, 18 Jun 2020 12:20:30 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 18 Jun 2020
 12:20:23 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <hch@infradead.org>, <axboe@kernel.dk>, <bvanassche@acm.org>,
        <jaegeuk@kernel.org>, <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <houtao1@huawei.com>, <yi.zhang@huawei.com>,
        <zhengbin13@huawei.com>
Subject: [PATCH v3 2/2] block: make function 'kill_bdev' static
Date:   Thu, 18 Jun 2020 12:21:38 +0800
Message-ID: <20200618042138.2094266-3-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200618042138.2094266-1-zhengbin13@huawei.com>
References: <20200618042138.2094266-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kill_bdev does not have any external user, so make it static.

Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/block_dev.c     | 5 ++---
 include/linux/fs.h | 2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 47860e589388..0137ed31d58d 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -75,7 +75,7 @@ static void bdev_write_inode(struct block_device *bdev)
 }

 /* Kill _all_ buffers and pagecache , dirty or not.. */
-void kill_bdev(struct block_device *bdev)
+static void kill_bdev(struct block_device *bdev)
 {
 	struct address_space *mapping = bdev->bd_inode->i_mapping;

@@ -84,8 +84,7 @@ void kill_bdev(struct block_device *bdev)

 	invalidate_bh_lrus();
 	truncate_inode_pages(mapping, 0);
-}	
-EXPORT_SYMBOL(kill_bdev);
+}

 /* Invalidate clean unused buffers and pagecache. */
 void invalidate_bdev(struct block_device *bdev)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2e675c075694..f5bb1efc0c45 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2609,7 +2609,6 @@ extern void bdput(struct block_device *);
 extern void invalidate_bdev(struct block_device *);
 extern void iterate_bdevs(void (*)(struct block_device *, void *), void *);
 extern int sync_blockdev(struct block_device *bdev);
-extern void kill_bdev(struct block_device *);
 extern struct super_block *freeze_bdev(struct block_device *);
 extern void emergency_thaw_all(void);
 extern void emergency_thaw_bdev(struct super_block *sb);
@@ -2625,7 +2624,6 @@ static inline bool sb_is_blkdev_sb(struct super_block *sb)
 #else
 static inline void bd_forget(struct inode *inode) {}
 static inline int sync_blockdev(struct block_device *bdev) { return 0; }
-static inline void kill_bdev(struct block_device *bdev) {}
 static inline void invalidate_bdev(struct block_device *bdev) {}

 static inline struct super_block *freeze_bdev(struct block_device *sb)
--
2.25.4

