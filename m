Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E07F35F4FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 15:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351427AbhDNNkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 09:40:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16915 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351378AbhDNNkB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:40:01 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FL3ST6jdkzjZ9Y;
        Wed, 14 Apr 2021 21:37:45 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 14 Apr 2021
 21:39:28 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
Subject: [RFC PATCH v2 4/7] jbd2: do not free buffers in jbd2_journal_try_to_free_buffers()
Date:   Wed, 14 Apr 2021 21:47:34 +0800
Message-ID: <20210414134737.2366971-5-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210414134737.2366971-1-yi.zhang@huawei.com>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch move try_to_free_buffers() out from
jbd2_journal_try_to_free_buffers() to the caller function, it just check
the buffers are JBD2 journal busy or not, and the caller should invoke
try_to_free_buffers() if it want to release page.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/block_dev.c        |  8 +++++---
 fs/ext4/inode.c       |  6 ++++--
 fs/ext4/super.c       |  5 +++--
 fs/jbd2/transaction.c | 17 ++++++++---------
 4 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 09d6f7229db9..5ed79a9063f6 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1735,11 +1735,13 @@ EXPORT_SYMBOL_GPL(blkdev_read_iter);
 static int blkdev_releasepage(struct page *page, gfp_t wait)
 {
 	struct super_block *super = BDEV_I(page->mapping->host)->bdev.bd_super;
+	int ret = 0;
 
 	if (super && super->s_op->bdev_try_to_free_page)
-		return super->s_op->bdev_try_to_free_page(super, page, wait);
-
-	return try_to_free_buffers(page);
+		ret = super->s_op->bdev_try_to_free_page(super, page, wait);
+	if (!ret)
+		return try_to_free_buffers(page);
+	return 0;
 }
 
 static int blkdev_writepages(struct address_space *mapping,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0948a43f1b3d..3211af9c969f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3301,6 +3301,7 @@ static void ext4_journalled_invalidatepage(struct page *page,
 static int ext4_releasepage(struct page *page, gfp_t wait)
 {
 	journal_t *journal = EXT4_JOURNAL(page->mapping->host);
+	int ret = 0;
 
 	trace_ext4_releasepage(page);
 
@@ -3308,9 +3309,10 @@ static int ext4_releasepage(struct page *page, gfp_t wait)
 	if (PageChecked(page))
 		return 0;
 	if (journal)
-		return jbd2_journal_try_to_free_buffers(journal, page);
-	else
+		ret = jbd2_journal_try_to_free_buffers(journal, page);
+	if (!ret)
 		return try_to_free_buffers(page);
+	return 0;
 }
 
 static bool ext4_inode_datasync_dirty(struct inode *inode)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b9693680463a..55c7a0d8d77d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1444,7 +1444,8 @@ static int ext4_nfs_commit_metadata(struct inode *inode)
  * Try to release metadata pages (indirect blocks, directories) which are
  * mapped via the block device.  Since these pages could have journal heads
  * which would prevent try_to_free_buffers() from freeing them, we must use
- * jbd2 layer's try_to_free_buffers() function to release them.
+ * jbd2 layer's try_to_free_buffers() function to check and we could
+ * release them if it return 0.
  */
 static int bdev_try_to_free_page(struct super_block *sb, struct page *page,
 				 gfp_t wait)
@@ -1457,7 +1458,7 @@ static int bdev_try_to_free_page(struct super_block *sb, struct page *page,
 	if (journal)
 		return jbd2_journal_try_to_free_buffers(journal, page);
 
-	return try_to_free_buffers(page);
+	return 0;
 }
 
 #ifdef CONFIG_FS_ENCRYPTION
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 3e0db4953fe4..451798051fde 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2089,10 +2089,9 @@ __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
  * if they are fully written out ordered data, move them onto BUF_CLEAN
  * so try_to_free_buffers() can reap them.
  *
- * This function returns non-zero if we wish try_to_free_buffers()
- * to be called. We do this if the page is releasable by try_to_free_buffers().
- * We also do it if the page has locked or dirty buffers and the caller wants
- * us to perform sync or async writeout.
+ * This function returns zero if all the buffers on this page are
+ * journal cleaned and the caller should invoke try_to_free_buffers() and
+ * could release page if the page is releasable by try_to_free_buffers().
  *
  * This complicates JBD locking somewhat.  We aren't protected by the
  * BKL here.  We wish to remove the buffer from its committing or
@@ -2112,7 +2111,7 @@ __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
  * cannot happen because we never reallocate freed data as metadata
  * while the data is part of a transaction.  Yes?
  *
- * Return 0 on failure, 1 on success
+ * Return 0 on success, -EBUSY if any buffer is still journal busy.
  */
 int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
 {
@@ -2140,12 +2139,12 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
 		__journal_try_to_free_buffer(journal, bh);
 		spin_unlock(&jh->b_state_lock);
 		jbd2_journal_put_journal_head(jh);
-		if (buffer_jbd(bh))
-			goto busy;
+		if (buffer_jbd(bh)) {
+			ret = -EBUSY;
+			break;
+		}
 	} while ((bh = bh->b_this_page) != head);
 
-	ret = try_to_free_buffers(page);
-busy:
 	return ret;
 }
 
-- 
2.25.4

