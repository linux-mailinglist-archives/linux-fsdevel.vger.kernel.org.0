Return-Path: <linux-fsdevel+bounces-2129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7377E2B45
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C311C20C67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560F2D054;
	Mon,  6 Nov 2023 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g82BkgnI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEC22C861
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 17:39:15 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0135D78;
	Mon,  6 Nov 2023 09:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=vqMdaczPBJ0vAOF82i4ZcjgwXI4TjAD+CcB7Mllfddw=; b=g82BkgnIYaQ13JwDngcm+gK09I
	8Q7tXJpAoaqdKn1AX8bpteSZ66YmZjKzdm9mo2F8zssm2YVd1zG0Zcxn17sdLJOLlKmVcLI6qezXz
	KDRpLhr2v9G8oOsWcjObUgudDfCsNwlJVLYdtfHYt8Pd4dUJDq/C75N9/aP/qwHS4Y4lWODm8msBt
	8pQBZy57MDn68TxPp7X6RRsgnwLMAkmbq1af9op9TjPnNAiTloIuPli50Hm32fUVYuxGrxewC/J9d
	uXHixgvOsE3Z92d8+zk5hn2762fzfM6JcKuABrl/YjoE8r+NmSRK/30iDQc0yOTUYDva8HFoSHq+K
	T4LAbRuw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r03Z4-007H8Q-NW; Mon, 06 Nov 2023 17:39:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/35] nilfs2: Convert to nilfs_clear_folio_dirty()
Date: Mon,  6 Nov 2023 17:38:36 +0000
Message-Id: <20231106173903.1734114-9-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106173903.1734114-1-willy@infradead.org>
References: <20231106173903.1734114-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers of nilfs_clear_dirty_page() now have a folio, so rename
the function and pass in the folio.  Saves three hidden calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/inode.c |  2 +-
 fs/nilfs2/mdt.c   |  2 +-
 fs/nilfs2/page.c  | 27 ++++++++++++++-------------
 fs/nilfs2/page.h  |  2 +-
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index c7ec56358a79..8fe784f62720 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -186,7 +186,7 @@ static int nilfs_writepage(struct page *page, struct writeback_control *wbc)
 		 * have dirty pages that try to be flushed in background.
 		 * So, here we simply discard this dirty page.
 		 */
-		nilfs_clear_dirty_page(page, false);
+		nilfs_clear_folio_dirty(folio, false);
 		folio_unlock(folio);
 		return -EROFS;
 	}
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 327408512b86..2e7952ac2f67 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -411,7 +411,7 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 		 * have dirty folios that try to be flushed in background.
 		 * So, here we simply discard this dirty folio.
 		 */
-		nilfs_clear_dirty_page(page, false);
+		nilfs_clear_folio_dirty(folio, false);
 		folio_unlock(folio);
 		return -EROFS;
 	}
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 29799a49c234..48a91ff059f5 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -379,7 +379,7 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 			 * was acquired.  Skip processing in that case.
 			 */
 			if (likely(folio->mapping == mapping))
-				nilfs_clear_dirty_page(&folio->page, silent);
+				nilfs_clear_folio_dirty(folio, silent);
 
 			folio_unlock(folio);
 		}
@@ -389,32 +389,33 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 }
 
 /**
- * nilfs_clear_dirty_page - discard dirty page
- * @page: dirty page that will be discarded
+ * nilfs_clear_folio_dirty - discard dirty folio
+ * @folio: dirty folio that will be discarded
  * @silent: suppress [true] or print [false] warning messages
  */
-void nilfs_clear_dirty_page(struct page *page, bool silent)
+void nilfs_clear_folio_dirty(struct folio *folio, bool silent)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct super_block *sb = inode->i_sb;
+	struct buffer_head *bh, *head;
 
-	BUG_ON(!PageLocked(page));
+	BUG_ON(!folio_test_locked(folio));
 
 	if (!silent)
 		nilfs_warn(sb, "discard dirty page: offset=%lld, ino=%lu",
-			   page_offset(page), inode->i_ino);
+			   folio_pos(folio), inode->i_ino);
 
-	ClearPageUptodate(page);
-	ClearPageMappedToDisk(page);
+	folio_clear_uptodate(folio);
+	folio_clear_mappedtodisk(folio);
 
-	if (page_has_buffers(page)) {
-		struct buffer_head *bh, *head;
+	head = folio_buffers(folio);
+	if (head) {
 		const unsigned long clear_bits =
 			(BIT(BH_Uptodate) | BIT(BH_Dirty) | BIT(BH_Mapped) |
 			 BIT(BH_Async_Write) | BIT(BH_NILFS_Volatile) |
 			 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected));
 
-		bh = head = page_buffers(page);
+		bh = head;
 		do {
 			lock_buffer(bh);
 			if (!silent)
@@ -427,7 +428,7 @@ void nilfs_clear_dirty_page(struct page *page, bool silent)
 		} while (bh = bh->b_this_page, bh != head);
 	}
 
-	__nilfs_clear_page_dirty(page);
+	__nilfs_clear_page_dirty(&folio->page);
 }
 
 unsigned int nilfs_page_count_clean_buffers(struct page *page,
diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
index a8ab800e689c..c419bb1f5b7d 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -41,7 +41,7 @@ void nilfs_page_bug(struct page *);
 
 int nilfs_copy_dirty_pages(struct address_space *, struct address_space *);
 void nilfs_copy_back_pages(struct address_space *, struct address_space *);
-void nilfs_clear_dirty_page(struct page *, bool);
+void nilfs_clear_folio_dirty(struct folio *, bool);
 void nilfs_clear_dirty_pages(struct address_space *, bool);
 unsigned int nilfs_page_count_clean_buffers(struct page *, unsigned int,
 					    unsigned int);
-- 
2.42.0


