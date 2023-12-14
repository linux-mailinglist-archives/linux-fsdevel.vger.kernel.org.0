Return-Path: <linux-fsdevel+bounces-6060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACC7813162
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 14:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3E71C2167A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 13:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E06755C39;
	Thu, 14 Dec 2023 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ztKYDWSI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F29118;
	Thu, 14 Dec 2023 05:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dGiI8OkHMxqBpcMGTmwSGDbSvODrydoaDrjFK0YrpEE=; b=ztKYDWSIzMbt21zCgDHn0IQVdR
	WEnQpPcfNE9IlRkh+DfxnVLV9Y7bB90QZSd/Lgm77je6hoN3kXz5/FjSVlwy075Pt5Qfc+OGTIGDA
	/RRDRJbdv3i7JmHPk6/sfyN27+59AhFDskZx5dg8aL2TD08X8OUYfLgW7aYfX/Zk6CX/bX53bbbSb
	iWXq5RbHXwlywgPE8elTNw4eOQlPgFXKwCnb2QiLjjeLh9DMPsJmIO6KbmVgsmrTBrVyM5Ucz9Kyu
	jeStapBP9fjfHrc+av6YzxBJtg9mqdk3JliqK0MEFezGFRPl+cEs7bc1E/jKgORcUtfPBSE/Ay7R0
	KOPvYEGw==;
Received: from [88.128.88.27] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDliu-000N0o-0h;
	Thu, 14 Dec 2023 13:25:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 01/11] writeback: Factor out writeback_finish()
Date: Thu, 14 Dec 2023 14:25:34 +0100
Message-Id: <20231214132544.376574-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214132544.376574-1-hch@lst.de>
References: <20231214132544.376574-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Instead of having a 'done' variable that controls the nested loops,
have a writeback_finish() that can be returned directly.  This involves
keeping more things in writeback_control, but it's just moving stuff
allocated on the stack to being allocated slightly earlier on the stack.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
[hch: reorder and comment struct writeback_control]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/writeback.h |  8 +++++
 mm/page-writeback.c       | 72 +++++++++++++++++++++------------------
 2 files changed, 46 insertions(+), 34 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 083387c00f0c8b..05e8add4b5ae3c 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -11,6 +11,7 @@
 #include <linux/flex_proportions.h>
 #include <linux/backing-dev-defs.h>
 #include <linux/blk_types.h>
+#include <linux/pagevec.h>
 
 struct bio;
 
@@ -40,6 +41,7 @@ enum writeback_sync_modes {
  * in a manner such that unspecified fields are set to zero.
  */
 struct writeback_control {
+	/* public fields that can be set and/or consumed by the caller: */
 	long nr_to_write;		/* Write this many pages, and decrement
 					   this for each page written */
 	long pages_skipped;		/* Pages which were not written */
@@ -77,6 +79,12 @@ struct writeback_control {
 	 */
 	struct swap_iocb **swap_plug;
 
+	/* internal fields used by the ->writepages implementation: */
+	struct folio_batch fbatch;
+	pgoff_t done_index;
+	int err;
+	unsigned range_whole:1;		/* entire file */
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct bdi_writeback *wb;	/* wb this writeback is issued under */
 	struct inode *inode;		/* inode being written out */
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index ee2fd6a6af4072..45309f3b8193f8 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2360,6 +2360,24 @@ void tag_pages_for_writeback(struct address_space *mapping,
 }
 EXPORT_SYMBOL(tag_pages_for_writeback);
 
+static int writeback_finish(struct address_space *mapping,
+		struct writeback_control *wbc, bool done)
+{
+	folio_batch_release(&wbc->fbatch);
+
+	/*
+	 * If we hit the last page and there is more work to be done:
+	 * wrap the index back to the start of the file for the next
+	 * time we are called.
+	 */
+	if (wbc->range_cyclic && !done)
+		wbc->done_index = 0;
+	if (wbc->range_cyclic || (wbc->range_whole && wbc->nr_to_write > 0))
+		mapping->writeback_index = wbc->done_index;
+
+	return wbc->err;
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2395,18 +2413,12 @@ int write_cache_pages(struct address_space *mapping,
 		      struct writeback_control *wbc, writepage_t writepage,
 		      void *data)
 {
-	int ret = 0;
-	int done = 0;
 	int error;
-	struct folio_batch fbatch;
 	int nr_folios;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
-	pgoff_t done_index;
-	int range_whole = 0;
 	xa_mark_t tag;
 
-	folio_batch_init(&fbatch);
 	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* prev offset */
 		end = -1;
@@ -2414,7 +2426,7 @@ int write_cache_pages(struct address_space *mapping,
 		index = wbc->range_start >> PAGE_SHIFT;
 		end = wbc->range_end >> PAGE_SHIFT;
 		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
-			range_whole = 1;
+			wbc->range_whole = 1;
 	}
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
 		tag_pages_for_writeback(mapping, index, end);
@@ -2422,21 +2434,25 @@ int write_cache_pages(struct address_space *mapping,
 	} else {
 		tag = PAGECACHE_TAG_DIRTY;
 	}
-	done_index = index;
-	while (!done && (index <= end)) {
+
+	wbc->done_index = index;
+	folio_batch_init(&wbc->fbatch);
+	wbc->err = 0;
+
+	while (index <= end) {
 		int i;
 
 		nr_folios = filemap_get_folios_tag(mapping, &index, end,
-				tag, &fbatch);
+				tag, &wbc->fbatch);
 
 		if (nr_folios == 0)
 			break;
 
 		for (i = 0; i < nr_folios; i++) {
-			struct folio *folio = fbatch.folios[i];
+			struct folio *folio = wbc->fbatch.folios[i];
 			unsigned long nr;
 
-			done_index = folio->index;
+			wbc->done_index = folio->index;
 
 			folio_lock(folio);
 
@@ -2490,13 +2506,13 @@ int write_cache_pages(struct address_space *mapping,
 					folio_unlock(folio);
 					error = 0;
 				} else if (wbc->sync_mode != WB_SYNC_ALL) {
-					ret = error;
-					done_index = folio->index + nr;
-					done = 1;
-					break;
+					wbc->err = error;
+					wbc->done_index = folio->index + nr;
+					return writeback_finish(mapping,
+							wbc, true);
 				}
-				if (!ret)
-					ret = error;
+				if (!wbc->err)
+					wbc->err = error;
 			}
 
 			/*
@@ -2507,26 +2523,14 @@ int write_cache_pages(struct address_space *mapping,
 			 */
 			wbc->nr_to_write -= nr;
 			if (wbc->nr_to_write <= 0 &&
-			    wbc->sync_mode == WB_SYNC_NONE) {
-				done = 1;
-				break;
-			}
+			    wbc->sync_mode == WB_SYNC_NONE)
+				return writeback_finish(mapping, wbc, true);
 		}
-		folio_batch_release(&fbatch);
+		folio_batch_release(&wbc->fbatch);
 		cond_resched();
 	}
 
-	/*
-	 * If we hit the last page and there is more work to be done: wrap
-	 * back the index back to the start of the file for the next
-	 * time we are called.
-	 */
-	if (wbc->range_cyclic && !done)
-		done_index = 0;
-	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
-		mapping->writeback_index = done_index;
-
-	return ret;
+	return writeback_finish(mapping, wbc, false);
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-- 
2.39.2


