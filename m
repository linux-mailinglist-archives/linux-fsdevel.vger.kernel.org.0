Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE38724FFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 00:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbjFFWfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 18:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239900AbjFFWfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:35:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6F61FC9
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pSL9pSkv2HFEgf0pjXFOjg3AqNuYaN6eLfQE54KaFe0=; b=XQw/4L6wzgYFJkRXK+Vs/ofaob
        kq6OW8vTAPwiT2aX9D3aI6/B0QJBQ2K8P1Wbzf2mlqwHiQTmOP7bMPvUwJjJrYYjrnP96PNYY6Z2/
        F1gmn6jt60DasL7z/1lcwZtwhZ/NAAnThvEhgxFis5OariFU8a7+bg3N76b9MlKHe3snsB7DW/RaU
        jQ5QUViCl7OyTZ8/dzASZIdMDt/Ps7BkW0vCxl0IrXvzxWQPSYwJEV0vDleIISa6dWwYusPmW3PMY
        gT2HUnAKYa5AZtcXOWFF4I6Ns0mDmTokwart5Yco/iLY/Jz+ii1UPUmTFxqVi5GVP43ffN2i5jDPi
        mRAOx/eg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6fFV-00DbF2-H1; Tue, 06 Jun 2023 22:33:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 09/14] buffer; Convert page_zero_new_buffers() to folio_zero_new_buffers()
Date:   Tue,  6 Jun 2023 23:33:41 +0100
Message-Id: <20230606223346.3241328-10-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230606223346.3241328-1-willy@infradead.org>
References: <20230606223346.3241328-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most of the callers already have a folio; convert reiserfs_write_end()
to have a folio.  Removes a couple of hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 27 ++++++++++++++-------------
 fs/ext4/inode.c             |  4 ++--
 fs/reiserfs/inode.c         |  7 ++++---
 include/linux/buffer_head.h |  2 +-
 4 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 8ea9edd86519..5f758bab5bcb 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1927,33 +1927,34 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 EXPORT_SYMBOL(__block_write_full_folio);
 
 /*
- * If a page has any new buffers, zero them out here, and mark them uptodate
+ * If a folio has any new buffers, zero them out here, and mark them uptodate
  * and dirty so they'll be written out (in order to prevent uninitialised
  * block data from leaking). And clear the new bit.
  */
-void page_zero_new_buffers(struct page *page, unsigned from, unsigned to)
+void folio_zero_new_buffers(struct folio *folio, size_t from, size_t to)
 {
-	unsigned int block_start, block_end;
+	size_t block_start, block_end;
 	struct buffer_head *head, *bh;
 
-	BUG_ON(!PageLocked(page));
-	if (!page_has_buffers(page))
+	BUG_ON(!folio_test_locked(folio));
+	head = folio_buffers(folio);
+	if (!head)
 		return;
 
-	bh = head = page_buffers(page);
+	bh = head;
 	block_start = 0;
 	do {
 		block_end = block_start + bh->b_size;
 
 		if (buffer_new(bh)) {
 			if (block_end > from && block_start < to) {
-				if (!PageUptodate(page)) {
-					unsigned start, size;
+				if (!folio_test_uptodate(folio)) {
+					size_t start, xend;
 
 					start = max(from, block_start);
-					size = min(to, block_end) - start;
+					xend = min(to, block_end);
 
-					zero_user(page, start, size);
+					folio_zero_segment(folio, start, xend);
 					set_buffer_uptodate(bh);
 				}
 
@@ -1966,7 +1967,7 @@ void page_zero_new_buffers(struct page *page, unsigned from, unsigned to)
 		bh = bh->b_this_page;
 	} while (bh != head);
 }
-EXPORT_SYMBOL(page_zero_new_buffers);
+EXPORT_SYMBOL(folio_zero_new_buffers);
 
 static void
 iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
@@ -2104,7 +2105,7 @@ int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
 			err = -EIO;
 	}
 	if (unlikely(err))
-		page_zero_new_buffers(&folio->page, from, to);
+		folio_zero_new_buffers(folio, from, to);
 	return err;
 }
 
@@ -2208,7 +2209,7 @@ int block_write_end(struct file *file, struct address_space *mapping,
 		if (!folio_test_uptodate(folio))
 			copied = 0;
 
-		page_zero_new_buffers(&folio->page, start+copied, start+len);
+		folio_zero_new_buffers(folio, start+copied, start+len);
 	}
 	flush_dcache_folio(folio);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 02de439bf1f0..9ca583360166 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1093,7 +1093,7 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 			err = -EIO;
 	}
 	if (unlikely(err)) {
-		page_zero_new_buffers(&folio->page, from, to);
+		folio_zero_new_buffers(folio, from, to);
 	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
 		for (i = 0; i < nr_wait; i++) {
 			int err2;
@@ -1339,7 +1339,7 @@ static int ext4_write_end(struct file *file,
 }
 
 /*
- * This is a private version of page_zero_new_buffers() which doesn't
+ * This is a private version of folio_zero_new_buffers() which doesn't
  * set the buffer to be dirty, since in data=journalled mode we need
  * to call ext4_dirty_journalled_data() instead.
  */
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index ff34ee49106f..77bd3b27059f 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2872,6 +2872,7 @@ static int reiserfs_write_end(struct file *file, struct address_space *mapping,
 			      loff_t pos, unsigned len, unsigned copied,
 			      struct page *page, void *fsdata)
 {
+	struct folio *folio = page_folio(page);
 	struct inode *inode = page->mapping->host;
 	int ret = 0;
 	int update_sd = 0;
@@ -2887,12 +2888,12 @@ static int reiserfs_write_end(struct file *file, struct address_space *mapping,
 
 	start = pos & (PAGE_SIZE - 1);
 	if (unlikely(copied < len)) {
-		if (!PageUptodate(page))
+		if (!folio_test_uptodate(folio))
 			copied = 0;
 
-		page_zero_new_buffers(page, start + copied, start + len);
+		folio_zero_new_buffers(folio, start + copied, start + len);
 	}
-	flush_dcache_page(page);
+	flush_dcache_folio(folio);
 
 	reiserfs_commit_page(inode, page, start, start + copied);
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index a366e01f8bd4..c794ea7096ba 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -278,7 +278,7 @@ int block_write_end(struct file *, struct address_space *,
 int generic_write_end(struct file *, struct address_space *,
 				loff_t, unsigned, unsigned,
 				struct page *, void *);
-void page_zero_new_buffers(struct page *page, unsigned from, unsigned to);
+void folio_zero_new_buffers(struct folio *folio, size_t from, size_t to);
 void clean_page_buffers(struct page *page);
 int cont_write_begin(struct file *, struct address_space *, loff_t,
 			unsigned, struct page **, void **,
-- 
2.39.2

