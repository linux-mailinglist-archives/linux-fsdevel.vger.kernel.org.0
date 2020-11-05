Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F169B2A82D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 16:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbgKEP6s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 10:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbgKEP6s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:58:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25007C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2020 07:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=XOffVN5uASlEHb9nQYc7iCYn+w7MqWbFxrjn7dA0Bhw=; b=TvAl058h1TDq9pEfkkWaWZ5Zaa
        MENmCr11E1Y6vXl4C4n4fuM9aztkspjKaqBncSbZ53GAP7twNPAWpn2OT9+ofzxGYvaFRIax9juUG
        Rjckh3MG0NZB1oMdCfkUjFHYoYzeNmd2MM/Z4Z+6mKNaFIsCVvEz6vAPLoOhOpTw8uw2ywaOKr5Mf
        PuQRbj6Jl3gIuMXnY4fA8/0tGH3FIdkwJWn8weEFWO/k2CuNCmeR9JYooA7xXfekGugg/Tx+Sf9Kg
        /2k8ZhD7XBuRZvxL2pctd90bHrbvE5epJt73RV+m+B+NFyvO9bgTEEyUCZyrsbl1eNBQ/HwBNBxa1
        lP26XdSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaheq-0002is-4V; Thu, 05 Nov 2020 15:58:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 1/3] bcachefs: Convert to readahead
Date:   Thu,  5 Nov 2020 15:58:36 +0000
Message-Id: <20201105155838.10329-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the new readahead method instead of readpages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/bcachefs/fs-io.c | 29 +++++++++++------------------
 fs/bcachefs/fs-io.h |  3 +--
 fs/bcachefs/fs.c    |  2 +-
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
index 3aed2ca4dced..d390cbb82233 100644
--- a/fs/bcachefs/fs-io.c
+++ b/fs/bcachefs/fs-io.c
@@ -663,26 +663,22 @@ struct readpages_iter {
 };
 
 static int readpages_iter_init(struct readpages_iter *iter,
-			       struct address_space *mapping,
-			       struct list_head *pages, unsigned nr_pages)
+			       struct readahead_control *ractl)
 {
+	unsigned i, nr_pages = readahead_count(ractl);
+
 	memset(iter, 0, sizeof(*iter));
 
-	iter->mapping	= mapping;
-	iter->offset	= list_last_entry(pages, struct page, lru)->index;
+	iter->mapping	= ractl->mapping;
+	iter->offset	= readahead_index(ractl);
 
 	iter->pages = kmalloc_array(nr_pages, sizeof(struct page *), GFP_NOFS);
 	if (!iter->pages)
 		return -ENOMEM;
 
-	while (!list_empty(pages)) {
-		struct page *page = list_last_entry(pages, struct page, lru);
-
-		__bch2_page_state_create(page, __GFP_NOFAIL);
-
-		iter->pages[iter->nr_pages++] = page;
-		list_del(&page->lru);
-	}
+	__readahead_batch(ractl, iter->pages, nr_pages);
+	for (i = 0; i < nr_pages; i++)
+		__bch2_page_state_create(iter->pages[i], __GFP_NOFAIL);
 
 	return 0;
 }
@@ -889,10 +885,9 @@ static void bchfs_read(struct btree_trans *trans, struct btree_iter *iter,
 	bkey_on_stack_exit(&sk, c);
 }
 
-int bch2_readpages(struct file *file, struct address_space *mapping,
-		   struct list_head *pages, unsigned nr_pages)
+void bch2_readahead(struct readahead_control *ractl)
 {
-	struct bch_inode_info *inode = to_bch_ei(mapping->host);
+	struct bch_inode_info *inode = to_bch_ei(ractl->mapping->host);
 	struct bch_fs *c = inode->v.i_sb->s_fs_info;
 	struct bch_io_opts opts = io_opts(c, &inode->ei_inode);
 	struct btree_trans trans;
@@ -901,7 +896,7 @@ int bch2_readpages(struct file *file, struct address_space *mapping,
 	struct readpages_iter readpages_iter;
 	int ret;
 
-	ret = readpages_iter_init(&readpages_iter, mapping, pages, nr_pages);
+	ret = readpages_iter_init(&readpages_iter, ractl);
 	BUG_ON(ret);
 
 	bch2_trans_init(&trans, c, 0, 0);
@@ -936,8 +931,6 @@ int bch2_readpages(struct file *file, struct address_space *mapping,
 
 	bch2_trans_exit(&trans);
 	kfree(readpages_iter.pages);
-
-	return 0;
 }
 
 static void __bchfs_readpage(struct bch_fs *c, struct bch_read_bio *rbio,
diff --git a/fs/bcachefs/fs-io.h b/fs/bcachefs/fs-io.h
index 7063556d289b..2537a3d25ede 100644
--- a/fs/bcachefs/fs-io.h
+++ b/fs/bcachefs/fs-io.h
@@ -19,8 +19,7 @@ int bch2_writepage(struct page *, struct writeback_control *);
 int bch2_readpage(struct file *, struct page *);
 
 int bch2_writepages(struct address_space *, struct writeback_control *);
-int bch2_readpages(struct file *, struct address_space *,
-		   struct list_head *, unsigned);
+void bch2_readahead(struct readahead_control *);
 
 int bch2_write_begin(struct file *, struct address_space *, loff_t,
 		     unsigned, unsigned, struct page **, void **);
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 267d31135269..cecdb956096a 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -1064,7 +1064,7 @@ static const struct address_space_operations bch_address_space_operations = {
 	.writepage	= bch2_writepage,
 	.readpage	= bch2_readpage,
 	.writepages	= bch2_writepages,
-	.readpages	= bch2_readpages,
+	.readahead	= bch2_readahead,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
 	.write_begin	= bch2_write_begin,
 	.write_end	= bch2_write_end,
-- 
2.28.0

