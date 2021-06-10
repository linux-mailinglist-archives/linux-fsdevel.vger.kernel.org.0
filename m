Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6163A2A05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 13:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhFJLR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 07:17:58 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3831 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFJLRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:17:51 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G11Vr4g0DzWsdF;
        Thu, 10 Jun 2021 19:11:00 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 10
 Jun 2021 19:15:53 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <jack@suse.cz>, <tytso@mit.edu>
CC:     <adilger.kernel@dilger.ca>, <david@fromorbit.com>,
        <hch@infradead.org>, <yi.zhang@huawei.com>
Subject: [RFC PATCH v4 8/8] fs: remove bdev_try_to_free_page callback
Date:   Thu, 10 Jun 2021 19:24:40 +0800
Message-ID: <20210610112440.3438139-9-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610112440.3438139-1-yi.zhang@huawei.com>
References: <20210610112440.3438139-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After remove the unique user of sop->bdev_try_to_free_page() callback,
we could remove the callback and the corresponding blkdev_releasepage()
at all.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c     | 15 ---------------
 include/linux/fs.h |  1 -
 2 files changed, 16 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6cc4d4cfe0c2..e215da6d49b4 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1733,20 +1733,6 @@ ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 }
 EXPORT_SYMBOL_GPL(blkdev_read_iter);
 
-/*
- * Try to release a page associated with block device when the system
- * is under memory pressure.
- */
-static int blkdev_releasepage(struct page *page, gfp_t wait)
-{
-	struct super_block *super = BDEV_I(page->mapping->host)->bdev.bd_super;
-
-	if (super && super->s_op->bdev_try_to_free_page)
-		return super->s_op->bdev_try_to_free_page(super, page, wait);
-
-	return try_to_free_buffers(page);
-}
-
 static int blkdev_writepages(struct address_space *mapping,
 			     struct writeback_control *wbc)
 {
@@ -1760,7 +1746,6 @@ static const struct address_space_operations def_blk_aops = {
 	.write_begin	= blkdev_write_begin,
 	.write_end	= blkdev_write_end,
 	.writepages	= blkdev_writepages,
-	.releasepage	= blkdev_releasepage,
 	.direct_IO	= blkdev_direct_IO,
 	.migratepage	= buffer_migrate_page_norefs,
 	.is_dirty_writeback = buffer_check_dirty_writeback,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..c3277b445f96 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2171,7 +2171,6 @@ struct super_operations {
 	ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
 	struct dquot **(*get_dquots)(struct inode *);
 #endif
-	int (*bdev_try_to_free_page)(struct super_block*, struct page*, gfp_t);
 	long (*nr_cached_objects)(struct super_block *,
 				  struct shrink_control *);
 	long (*free_cached_objects)(struct super_block *,
-- 
2.31.1

