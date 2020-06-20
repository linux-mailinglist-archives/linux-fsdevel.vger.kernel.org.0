Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8247201FEE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 04:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbgFTCxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 22:53:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54914 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732110AbgFTCxf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 22:53:35 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7D7C0D81B474283F06C9;
        Sat, 20 Jun 2020 10:53:33 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sat, 20 Jun 2020
 10:53:22 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <jack@suse.cz>
CC:     <adilger.kernel@dilger.ca>, <zhangxiaoxu5@huawei.com>,
        <yi.zhang@huawei.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v3 5/5] jbd2: remove unused parameter in jbd2_journal_try_to_free_buffers()
Date:   Sat, 20 Jun 2020 10:54:27 +0800
Message-ID: <20200620025427.1756360-6-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200620025427.1756360-1-yi.zhang@huawei.com>
References: <20200620025427.1756360-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Parameter gfp_mask in jbd2_journal_try_to_free_buffers() is no longer
used after commit <536fc240e7147> ("jbd2: clean up
jbd2_journal_try_to_free_buffers()"), so just remove it.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/inode.c       | 2 +-
 fs/ext4/super.c       | 4 ++--
 fs/jbd2/transaction.c | 7 +------
 include/linux/jbd2.h  | 2 +-
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 79b73a86ef6c..61a56023bec6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3288,7 +3288,7 @@ static int ext4_releasepage(struct page *page, gfp_t wait)
 	if (PageChecked(page))
 		return 0;
 	if (journal)
-		return jbd2_journal_try_to_free_buffers(journal, page, wait);
+		return jbd2_journal_try_to_free_buffers(journal, page);
 	else
 		return try_to_free_buffers(page);
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 513d1e270f6d..b622995723e4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1294,8 +1294,8 @@ static int bdev_try_to_free_page(struct super_block *sb, struct page *page,
 	if (!page_has_buffers(page))
 		return 0;
 	if (journal)
-		return jbd2_journal_try_to_free_buffers(journal, page,
-						wait & ~__GFP_DIRECT_RECLAIM);
+		return jbd2_journal_try_to_free_buffers(journal, page);
+
 	return try_to_free_buffers(page);
 }
 
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index a4932e8dcb65..7b20c77fefa9 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2078,10 +2078,6 @@ __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
  * int jbd2_journal_try_to_free_buffers() - try to free page buffers.
  * @journal: journal for operation
  * @page: to try and free
- * @gfp_mask: we use the mask to detect how hard should we try to release
- * buffers. If __GFP_DIRECT_RECLAIM and __GFP_FS is set, we wait for commit
- * code to release the buffers.
- *
  *
  * For all the buffers on this page,
  * if they are fully written out ordered data, move them onto BUF_CLEAN
@@ -2112,8 +2108,7 @@ __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
  *
  * Return 0 on failure, 1 on success
  */
-int jbd2_journal_try_to_free_buffers(journal_t *journal,
-				struct page *page, gfp_t gfp_mask)
+int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
 {
 	struct buffer_head *head;
 	struct buffer_head *bh;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index f613d8529863..6d94b2c4cf75 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1376,7 +1376,7 @@ extern int	 jbd2_journal_dirty_metadata (handle_t *, struct buffer_head *);
 extern int	 jbd2_journal_forget (handle_t *, struct buffer_head *);
 extern int	 jbd2_journal_invalidatepage(journal_t *,
 				struct page *, unsigned int, unsigned int);
-extern int	 jbd2_journal_try_to_free_buffers(journal_t *, struct page *, gfp_t);
+extern int	 jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page);
 extern int	 jbd2_journal_stop(handle_t *);
 extern int	 jbd2_journal_flush (journal_t *);
 extern void	 jbd2_journal_lock_updates (journal_t *);
-- 
2.25.4

