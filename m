Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFAE5151E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379593AbiD2R3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379531AbiD2R3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34D8A0BC6
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vB/FUDznW007D/1dFC/irSstDYRSCilgx1jaSg3ClnQ=; b=KZdZlT9gQJyZpixyUsbYP3rXB0
        elGwm107T+HsDmLsqbDob56qvrMC5kd2EzB5fYyCpAW4eKWN1/9mUwykKsMEv8NXN7pv60MxoFnAj
        mHOUsqfVwmewR8Izgi4Nb84SoOtvZq8cPm5WaF5Yqi/W2AusnPwsS9mzmsyuaEIa9JVXeigbC12Fx
        WKOVsDWyOSTPV/140J8eRmiM8QBgfrSfOVl7w2rPe6DV84tHKd+H5qr3yLzTy/wOVoBdATYmBbWrX
        q7wdXrgFOE35dTm0AXIXOPz9LxlN2p4FVjCgBlju4e94iXmDiXnOzBGMoe+wrX330GApO5Z3HQj3k
        IW1RWOAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNZ-00CdZZ-Qn; Fri, 29 Apr 2022 17:26:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 30/69] fs: Convert is_dirty_writeback() to take a folio
Date:   Fri, 29 Apr 2022 18:25:17 +0100
Message-Id: <20220429172556.3011843-31-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass a folio instead of a page to aops->is_dirty_writeback().
Convert both implementations and the caller.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/vfs.rst | 10 +++++-----
 fs/buffer.c                       | 16 ++++++++--------
 fs/nfs/file.c                     | 21 +++++++++------------
 include/linux/buffer_head.h       |  2 +-
 include/linux/fs.h                |  2 +-
 mm/vmscan.c                       |  2 +-
 6 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 30f303180a7d..469882f72fc1 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -747,7 +747,7 @@ cache in your filesystem.  The following members are defined:
 
 		bool (*is_partially_uptodate) (struct folio *, size_t from,
 					       size_t count);
-		void (*is_dirty_writeback) (struct page *, bool *, bool *);
+		void (*is_dirty_writeback)(struct folio *, bool *, bool *);
 		int (*error_remove_page) (struct mapping *mapping, struct page *page);
 		int (*swap_activate)(struct file *);
 		int (*swap_deactivate)(struct file *);
@@ -932,14 +932,14 @@ cache in your filesystem.  The following members are defined:
 	without needing I/O to bring the whole page up to date.
 
 ``is_dirty_writeback``
-	Called by the VM when attempting to reclaim a page.  The VM uses
+	Called by the VM when attempting to reclaim a folio.  The VM uses
 	dirty and writeback information to determine if it needs to
 	stall to allow flushers a chance to complete some IO.
-	Ordinarily it can use PageDirty and PageWriteback but some
-	filesystems have more complex state (unstable pages in NFS
+	Ordinarily it can use folio_test_dirty and folio_test_writeback but
+	some filesystems have more complex state (unstable folios in NFS
 	prevent reclaim) or do not set those flags due to locking
 	problems.  This callback allows a filesystem to indicate to the
-	VM if a page should be treated as dirty or writeback for the
+	VM if a folio should be treated as dirty or writeback for the
 	purposes of stalling.
 
 ``error_remove_page``
diff --git a/fs/buffer.c b/fs/buffer.c
index d538495a0553..fb4df259c92d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -79,26 +79,26 @@ void unlock_buffer(struct buffer_head *bh)
 EXPORT_SYMBOL(unlock_buffer);
 
 /*
- * Returns if the page has dirty or writeback buffers. If all the buffers
- * are unlocked and clean then the PageDirty information is stale. If
- * any of the pages are locked, it is assumed they are locked for IO.
+ * Returns if the folio has dirty or writeback buffers. If all the buffers
+ * are unlocked and clean then the folio_test_dirty information is stale. If
+ * any of the buffers are locked, it is assumed they are locked for IO.
  */
-void buffer_check_dirty_writeback(struct page *page,
+void buffer_check_dirty_writeback(struct folio *folio,
 				     bool *dirty, bool *writeback)
 {
 	struct buffer_head *head, *bh;
 	*dirty = false;
 	*writeback = false;
 
-	BUG_ON(!PageLocked(page));
+	BUG_ON(!folio_test_locked(folio));
 
-	if (!page_has_buffers(page))
+	head = folio_buffers(folio);
+	if (!head)
 		return;
 
-	if (PageWriteback(page))
+	if (folio_test_writeback(folio))
 		*writeback = true;
 
-	head = page_buffers(page);
 	bh = head;
 	do {
 		if (buffer_locked(bh))
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 314d2d7ba84a..f05c4b18b681 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -430,19 +430,16 @@ static int nfs_release_page(struct page *page, gfp_t gfp)
 	return nfs_fscache_release_page(page, gfp);
 }
 
-static void nfs_check_dirty_writeback(struct page *page,
+static void nfs_check_dirty_writeback(struct folio *folio,
 				bool *dirty, bool *writeback)
 {
 	struct nfs_inode *nfsi;
-	struct address_space *mapping = page_file_mapping(page);
-
-	if (!mapping || PageSwapCache(page))
-		return;
+	struct address_space *mapping = folio->mapping;
 
 	/*
-	 * Check if an unstable page is currently being committed and
-	 * if so, have the VM treat it as if the page is under writeback
-	 * so it will not block due to pages that will shortly be freeable.
+	 * Check if an unstable folio is currently being committed and
+	 * if so, have the VM treat it as if the folio is under writeback
+	 * so it will not block due to folios that will shortly be freeable.
 	 */
 	nfsi = NFS_I(mapping->host);
 	if (atomic_read(&nfsi->commit_info.rpcs_out)) {
@@ -451,11 +448,11 @@ static void nfs_check_dirty_writeback(struct page *page,
 	}
 
 	/*
-	 * If PagePrivate() is set, then the page is not freeable and as the
-	 * inode is not being committed, it's not going to be cleaned in the
-	 * near future so treat it as dirty
+	 * If the private flag is set, then the folio is not freeable
+	 * and as the inode is not being committed, it's not going to
+	 * be cleaned in the near future so treat it as dirty
 	 */
-	if (PagePrivate(page))
+	if (folio_test_private(folio))
 		*dirty = true;
 }
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 6e5a64005fef..805c4e12700a 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -146,7 +146,7 @@ BUFFER_FNS(Defer_Completion, defer_completion)
 #define page_has_buffers(page)	PagePrivate(page)
 #define folio_buffers(folio)		folio_get_private(folio)
 
-void buffer_check_dirty_writeback(struct page *page,
+void buffer_check_dirty_writeback(struct folio *folio,
 				     bool *dirty, bool *writeback);
 
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b35ce086a7a1..2be852661a29 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -369,7 +369,7 @@ struct address_space_operations {
 	int (*launder_folio)(struct folio *);
 	bool (*is_partially_uptodate) (struct folio *, size_t from,
 			size_t count);
-	void (*is_dirty_writeback) (struct page *, bool *, bool *);
+	void (*is_dirty_writeback) (struct folio *, bool *dirty, bool *wb);
 	int (*error_remove_page)(struct address_space *, struct page *);
 
 	/* swapfile support */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1678802e03e7..27851232e00c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1451,7 +1451,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
 
 	mapping = folio_mapping(folio);
 	if (mapping && mapping->a_ops->is_dirty_writeback)
-		mapping->a_ops->is_dirty_writeback(&folio->page, dirty, writeback);
+		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
 }
 
 static struct page *alloc_demote_page(struct page *page, unsigned long node)
-- 
2.34.1

