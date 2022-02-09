Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF704AFE44
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiBIUXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiBIUW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E43E040CA1
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=otyZoT34kZJb68D2ttRVvV9gcstPSo8G5Y5d8shxgyo=; b=er2Dwm353UdG3PlMytqxElleWx
        Yo1NQSn7hJxy+bUX8OPnLpetv0Z0pmOcyumnSRXNxSGPn5j+kRE0idtb+kn15x9M6uIHrLRp0Oxx+
        J2tolpSFS8P+7SKV0lauihq3wZ+tnX+/XKJQWrOz7TCO1OZZlu3eJ3N07p6S4RDJ8xwZx7C9GkuGm
        X/Wxbgwdt9j933kp+TrpMovXA5ovPd0qUDmtAJ4xirToMQYHjikY5TFDiFWaHNg4BhBH7ftLlUMK8
        s9MCi7pO1lKiu/PIWSiWo4TZfOnnVPizJt6tl83G7lfu75U0xDnKiVccbHl/p+6szPOs12rq0nhNp
        XD3uf1gQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTt-008cqs-Kl; Wed, 09 Feb 2022 20:22:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 24/56] ext4: Convert invalidatepage to invalidate_folio
Date:   Wed,  9 Feb 2022 20:21:43 +0000
Message-Id: <20220209202215.2055748-25-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extensive changes, but fairly mechanical.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c             | 56 ++++++++++++++++++-------------------
 fs/jbd2/journal.c           |  2 +-
 fs/jbd2/transaction.c       | 31 ++++++++++----------
 include/linux/jbd2.h        |  4 +--
 include/linux/pagemap.h     | 18 ++++++++++++
 include/trace/events/ext4.h | 30 ++++++++++----------
 6 files changed, 78 insertions(+), 63 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d7086209572a..678ba122f8b1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -184,7 +184,7 @@ void ext4_evict_inode(struct inode *inode)
 		 * journal. So although mm thinks everything is clean and
 		 * ready for reaping the inode might still have some pages to
 		 * write in the running transaction or waiting to be
-		 * checkpointed. Thus calling jbd2_journal_invalidatepage()
+		 * checkpointed. Thus calling jbd2_journal_invalidate_folio()
 		 * (via truncate_inode_pages()) to discard these buffers can
 		 * cause data loss. Also even if we did not discard these
 		 * buffers, we would have no way to find them after the inode
@@ -3186,7 +3186,7 @@ static void ext4_readahead(struct readahead_control *rac)
 static void ext4_invalidate_folio(struct folio *folio, size_t offset,
 				size_t length)
 {
-	trace_ext4_invalidatepage(&folio->page, offset, length);
+	trace_ext4_invalidate_folio(folio, offset, length);
 
 	/* No journalling happens on data buffers when this function is used */
 	WARN_ON(folio_buffers(folio) && buffer_jbd(folio_buffers(folio)));
@@ -3194,29 +3194,28 @@ static void ext4_invalidate_folio(struct folio *folio, size_t offset,
 	block_invalidate_folio(folio, offset, length);
 }
 
-static int __ext4_journalled_invalidatepage(struct page *page,
-					    unsigned int offset,
-					    unsigned int length)
+static int __ext4_journalled_invalidate_folio(struct folio *folio,
+					    size_t offset, size_t length)
 {
-	journal_t *journal = EXT4_JOURNAL(page->mapping->host);
+	journal_t *journal = EXT4_JOURNAL(folio->mapping->host);
 
-	trace_ext4_journalled_invalidatepage(page, offset, length);
+	trace_ext4_journalled_invalidate_folio(folio, offset, length);
 
 	/*
 	 * If it's a full truncate we just forget about the pending dirtying
 	 */
-	if (offset == 0 && length == PAGE_SIZE)
-		ClearPageChecked(page);
+	if (offset == 0 && length == folio_size(folio))
+		folio_clear_checked(folio);
 
-	return jbd2_journal_invalidatepage(journal, page, offset, length);
+	return jbd2_journal_invalidate_folio(journal, folio, offset, length);
 }
 
 /* Wrapper for aops... */
-static void ext4_journalled_invalidatepage(struct page *page,
-					   unsigned int offset,
-					   unsigned int length)
+static void ext4_journalled_invalidate_folio(struct folio *folio,
+					   size_t offset,
+					   size_t length)
 {
-	WARN_ON(__ext4_journalled_invalidatepage(page, offset, length) < 0);
+	WARN_ON(__ext4_journalled_invalidate_folio(folio, offset, length) < 0);
 }
 
 static int ext4_releasepage(struct page *page, gfp_t wait)
@@ -3601,7 +3600,7 @@ static const struct address_space_operations ext4_journalled_aops = {
 	.write_end		= ext4_journalled_write_end,
 	.set_page_dirty		= ext4_journalled_set_page_dirty,
 	.bmap			= ext4_bmap,
-	.invalidatepage		= ext4_journalled_invalidatepage,
+	.invalidate_folio	= ext4_journalled_invalidate_folio,
 	.releasepage		= ext4_releasepage,
 	.direct_IO		= noop_direct_IO,
 	.is_partially_uptodate  = block_is_partially_uptodate,
@@ -5204,13 +5203,12 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
 }
 
 /*
- * In data=journal mode ext4_journalled_invalidatepage() may fail to invalidate
- * buffers that are attached to a page stradding i_size and are undergoing
+ * In data=journal mode ext4_journalled_invalidate_folio() may fail to invalidate
+ * buffers that are attached to a folio straddling i_size and are undergoing
  * commit. In that case we have to wait for commit to finish and try again.
  */
 static void ext4_wait_for_tail_page_commit(struct inode *inode)
 {
-	struct page *page;
 	unsigned offset;
 	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
 	tid_t commit_tid = 0;
@@ -5218,25 +5216,25 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
 
 	offset = inode->i_size & (PAGE_SIZE - 1);
 	/*
-	 * If the page is fully truncated, we don't need to wait for any commit
-	 * (and we even should not as __ext4_journalled_invalidatepage() may
-	 * strip all buffers from the page but keep the page dirty which can then
-	 * confuse e.g. concurrent ext4_writepage() seeing dirty page without
+	 * If the folio is fully truncated, we don't need to wait for any commit
+	 * (and we even should not as __ext4_journalled_invalidate_folio() may
+	 * strip all buffers from the folio but keep the folio dirty which can then
+	 * confuse e.g. concurrent ext4_writepage() seeing dirty folio without
 	 * buffers). Also we don't need to wait for any commit if all buffers in
-	 * the page remain valid. This is most beneficial for the common case of
+	 * the folio remain valid. This is most beneficial for the common case of
 	 * blocksize == PAGESIZE.
 	 */
 	if (!offset || offset > (PAGE_SIZE - i_blocksize(inode)))
 		return;
 	while (1) {
-		page = find_lock_page(inode->i_mapping,
+		struct folio *folio = filemap_lock_folio(inode->i_mapping,
 				      inode->i_size >> PAGE_SHIFT);
-		if (!page)
+		if (!folio)
 			return;
-		ret = __ext4_journalled_invalidatepage(page, offset,
-						PAGE_SIZE - offset);
-		unlock_page(page);
-		put_page(page);
+		ret = __ext4_journalled_invalidate_folio(folio, offset,
+						folio_size(folio) - offset);
+		folio_unlock(folio);
+		folio_put(folio);
 		if (ret != -EBUSY)
 			return;
 		commit_tid = 0;
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index c2cf74b01ddb..fcacafa4510d 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -86,7 +86,7 @@ EXPORT_SYMBOL(jbd2_journal_start_commit);
 EXPORT_SYMBOL(jbd2_journal_force_commit_nested);
 EXPORT_SYMBOL(jbd2_journal_wipe);
 EXPORT_SYMBOL(jbd2_journal_blocks_per_page);
-EXPORT_SYMBOL(jbd2_journal_invalidatepage);
+EXPORT_SYMBOL(jbd2_journal_invalidate_folio);
 EXPORT_SYMBOL(jbd2_journal_try_to_free_buffers);
 EXPORT_SYMBOL(jbd2_journal_force_commit);
 EXPORT_SYMBOL(jbd2_journal_inode_ranged_write);
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 8e2f8275a253..d988016034e2 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2219,14 +2219,14 @@ static int __dispose_buffer(struct journal_head *jh, transaction_t *transaction)
 }
 
 /*
- * jbd2_journal_invalidatepage
+ * jbd2_journal_invalidate_folio
  *
  * This code is tricky.  It has a number of cases to deal with.
  *
  * There are two invariants which this code relies on:
  *
- * i_size must be updated on disk before we start calling invalidatepage on the
- * data.
+ * i_size must be updated on disk before we start calling invalidate_folio
+ * on the data.
  *
  *  This is done in ext3 by defining an ext3_setattr method which
  *  updates i_size before truncate gets going.  By maintaining this
@@ -2428,9 +2428,9 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 }
 
 /**
- * jbd2_journal_invalidatepage()
+ * jbd2_journal_invalidate_folio()
  * @journal: journal to use for flush...
- * @page:    page to flush
+ * @folio:    folio to flush
  * @offset:  start of the range to invalidate
  * @length:  length of the range to invalidate
  *
@@ -2439,30 +2439,29 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
  * the page is straddling i_size. Caller then has to wait for current commit
  * and try again.
  */
-int jbd2_journal_invalidatepage(journal_t *journal,
-				struct page *page,
-				unsigned int offset,
-				unsigned int length)
+int jbd2_journal_invalidate_folio(journal_t *journal, struct folio *folio,
+				size_t offset, size_t length)
 {
 	struct buffer_head *head, *bh, *next;
 	unsigned int stop = offset + length;
 	unsigned int curr_off = 0;
-	int partial_page = (offset || length < PAGE_SIZE);
+	int partial_page = (offset || length < folio_size(folio));
 	int may_free = 1;
 	int ret = 0;
 
-	if (!PageLocked(page))
+	if (!folio_test_locked(folio))
 		BUG();
-	if (!page_has_buffers(page))
+	head = folio_buffers(folio);
+	if (!head)
 		return 0;
 
-	BUG_ON(stop > PAGE_SIZE || stop < length);
+	BUG_ON(stop > folio_size(folio) || stop < length);
 
 	/* We will potentially be playing with lists other than just the
 	 * data lists (especially for journaled data mode), so be
 	 * cautious in our locking. */
 
-	head = bh = page_buffers(page);
+	bh = head;
 	do {
 		unsigned int next_off = curr_off + bh->b_size;
 		next = bh->b_this_page;
@@ -2485,8 +2484,8 @@ int jbd2_journal_invalidatepage(journal_t *journal,
 	} while (bh != head);
 
 	if (!partial_page) {
-		if (may_free && try_to_free_buffers(page))
-			J_ASSERT(!page_has_buffers(page));
+		if (may_free && try_to_free_buffers(&folio->page))
+			J_ASSERT(!folio_buffers(folio));
 	}
 	return 0;
 }
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 9c3ada74ffb1..1b9d1e205a2f 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1530,8 +1530,8 @@ void		 jbd2_journal_set_triggers(struct buffer_head *,
 					   struct jbd2_buffer_trigger_type *type);
 extern int	 jbd2_journal_dirty_metadata (handle_t *, struct buffer_head *);
 extern int	 jbd2_journal_forget (handle_t *, struct buffer_head *);
-extern int	 jbd2_journal_invalidatepage(journal_t *,
-				struct page *, unsigned int, unsigned int);
+int jbd2_journal_invalidate_folio(journal_t *, struct folio *,
+					size_t offset, size_t length);
 extern int	 jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page);
 extern int	 jbd2_journal_stop(handle_t *);
 extern int	 jbd2_journal_flush(journal_t *journal, unsigned int flags);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 469b7c4eeeed..7cd0c01fe533 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -422,6 +422,24 @@ static inline struct folio *filemap_get_folio(struct address_space *mapping,
 	return __filemap_get_folio(mapping, index, 0, 0);
 }
 
+/**
+ * filemap_lock_folio - Find and lock a folio.
+ * @mapping: The address_space to search.
+ * @index: The page index.
+ *
+ * Looks up the page cache entry at @mapping & @index.  If a folio is
+ * present, it is returned locked with an increased refcount.
+ *
+ * Context: May sleep.
+ * Return: A folio or %NULL if there is no folio in the cache for this
+ * index.  Will not return a shadow, swap or DAX entry.
+ */
+static inline struct folio *filemap_lock_folio(struct address_space *mapping,
+					pgoff_t index)
+{
+	return __filemap_get_folio(mapping, index, FGP_LOCK, 0);
+}
+
 /**
  * find_get_page - find and get a page reference
  * @mapping: the address_space to search
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 19e957b7f941..40cca0e5a811 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -597,44 +597,44 @@ DEFINE_EVENT(ext4__page_op, ext4_releasepage,
 	TP_ARGS(page)
 );
 
-DECLARE_EVENT_CLASS(ext4_invalidatepage_op,
-	TP_PROTO(struct page *page, unsigned int offset, unsigned int length),
+DECLARE_EVENT_CLASS(ext4_invalidate_folio_op,
+	TP_PROTO(struct folio *folio, size_t offset, size_t length),
 
-	TP_ARGS(page, offset, length),
+	TP_ARGS(folio, offset, length),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
 		__field(	ino_t,	ino			)
 		__field(	pgoff_t, index			)
-		__field(	unsigned int, offset		)
-		__field(	unsigned int, length		)
+		__field(	size_t, offset			)
+		__field(	size_t, length			)
 	),
 
 	TP_fast_assign(
-		__entry->dev	= page->mapping->host->i_sb->s_dev;
-		__entry->ino	= page->mapping->host->i_ino;
-		__entry->index	= page->index;
+		__entry->dev	= folio->mapping->host->i_sb->s_dev;
+		__entry->ino	= folio->mapping->host->i_ino;
+		__entry->index	= folio->index;
 		__entry->offset	= offset;
 		__entry->length	= length;
 	),
 
-	TP_printk("dev %d,%d ino %lu page_index %lu offset %u length %u",
+	TP_printk("dev %d,%d ino %lu folio_index %lu offset %zu length %zu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  (unsigned long) __entry->index,
 		  __entry->offset, __entry->length)
 );
 
-DEFINE_EVENT(ext4_invalidatepage_op, ext4_invalidatepage,
-	TP_PROTO(struct page *page, unsigned int offset, unsigned int length),
+DEFINE_EVENT(ext4_invalidate_folio_op, ext4_invalidate_folio,
+	TP_PROTO(struct folio *folio, size_t offset, size_t length),
 
-	TP_ARGS(page, offset, length)
+	TP_ARGS(folio, offset, length)
 );
 
-DEFINE_EVENT(ext4_invalidatepage_op, ext4_journalled_invalidatepage,
-	TP_PROTO(struct page *page, unsigned int offset, unsigned int length),
+DEFINE_EVENT(ext4_invalidate_folio_op, ext4_journalled_invalidate_folio,
+	TP_PROTO(struct folio *folio, size_t offset, size_t length),
 
-	TP_ARGS(page, offset, length)
+	TP_ARGS(folio, offset, length)
 );
 
 TRACE_EVENT(ext4_discard_blocks,
-- 
2.34.1

