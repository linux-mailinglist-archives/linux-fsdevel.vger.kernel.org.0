Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2C567D602
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjAZUNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAZUNI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:13:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188A6113E5
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 12:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Y51dXADnL7zWI8vmJc6dsKp26+zduLjuQ6xNcrpB0a4=; b=b2In0Mtz8IWlLDdiD/2OpJ9r0J
        yTjEk/QSwkwrRm1+My1KdwnWp/wYGe2UOHOEew8a4PidEI9zHJnMrmve+vY7z8IL3N4WJpkiTeRVv
        H92Cw7kgEqgvVsBw3VKdNQvh1xmE7bTcWWHO87PZepZQVMDCndqyjq6L2IOjo86hWVBa3+zA078qk
        LcwkPibjZVNAMpBP/H86WZD88U8XypR833JyE6mSrE24xTAn6DhkYIG/+GKaF1zSAIIKtwhuL8tmX
        W/697j26jvNFxO0d1nWbBNbKVVO5UDW+LNWJMPtUCjfn7P2SUUHEryuJ0wHIoZYQp9niHleb8pGwe
        AGD8e8fA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8cD-0073M8-HP; Thu, 26 Jan 2023 20:12:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/2] fs: Convert writepage_t callback to pass a folio
Date:   Thu, 26 Jan 2023 20:12:54 +0000
Message-Id: <20230126201255.1681189-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230126201255.1681189-1-willy@infradead.org>
References: <20230126201255.1681189-1-willy@infradead.org>
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

We always write back an entire folio, but that's currently passed as
the head page.  Convert all filesystems that use write_cache_pages()
to expect a folio instead of a page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/cifs/file.c            |  8 ++++----
 fs/ext4/inode.c           |  4 ++--
 fs/ext4/super.c           |  6 +++---
 fs/fuse/file.c            | 18 +++++++++---------
 fs/iomap/buffered-io.c    |  5 ++---
 fs/mpage.c                |  3 ++-
 fs/nfs/write.c            |  7 ++++---
 fs/ntfs3/inode.c          |  6 +++---
 fs/orangefs/inode.c       | 23 +++++++++++------------
 include/linux/writeback.h |  2 +-
 mm/page-writeback.c       |  6 +++---
 11 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index bc4d9951c412..5568a5f4bc5a 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2676,14 +2676,14 @@ wdata_send_pages(struct cifs_writedata *wdata, unsigned int nr_pages,
 static int
 cifs_writepage_locked(struct page *page, struct writeback_control *wbc);
 
-static int cifs_write_one_page(struct page *page, struct writeback_control *wbc,
-		void *data)
+static int cifs_write_one_page(struct folio *folio,
+		struct writeback_control *wbc, void *data)
 {
 	struct address_space *mapping = data;
 	int ret;
 
-	ret = cifs_writepage_locked(page, wbc);
-	unlock_page(page);
+	ret = cifs_writepage_locked(&folio->page, wbc);
+	folio_unlock(folio);
 	mapping_set_error(mapping, ret);
 	return ret;
 }
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 977b65580ad5..b8b3e2e0d9fd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2710,10 +2710,10 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	return err;
 }
 
-static int ext4_writepage_cb(struct page *page, struct writeback_control *wbc,
+static int ext4_writepage_cb(struct folio *folio, struct writeback_control *wbc,
 			     void *data)
 {
-	return ext4_writepage(page, wbc);
+	return ext4_writepage(&folio->page, wbc);
 }
 
 static int ext4_do_writepages(struct mpage_da_data *mpd)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b31db521d6bf..b8aaf55dff34 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -482,7 +482,7 @@ static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
  *
  * However, we may have to redirty a page (see below.)
  */
-static int ext4_journalled_writepage_callback(struct page *page,
+static int ext4_journalled_writepage_callback(struct folio *folio,
 					      struct writeback_control *wbc,
 					      void *data)
 {
@@ -490,7 +490,7 @@ static int ext4_journalled_writepage_callback(struct page *page,
 	struct buffer_head *bh, *head;
 	struct journal_head *jh;
 
-	bh = head = page_buffers(page);
+	bh = head = folio_buffers(folio);
 	do {
 		/*
 		 * We have to redirty a page in these cases:
@@ -509,7 +509,7 @@ static int ext4_journalled_writepage_callback(struct page *page,
 		if (buffer_dirty(bh) ||
 		    (jh && (jh->b_transaction != transaction ||
 			    jh->b_next_transaction))) {
-			redirty_page_for_writepage(wbc, page);
+			folio_redirty_for_writepage(wbc, folio);
 			goto out;
 		}
 	} while ((bh = bh->b_this_page) != head);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 82710d103556..ff0b3ef774d4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2186,7 +2186,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
 	return false;
 }
 
-static int fuse_writepages_fill(struct page *page,
+static int fuse_writepages_fill(struct folio *folio,
 		struct writeback_control *wbc, void *_data)
 {
 	struct fuse_fill_wb_data *data = _data;
@@ -2205,7 +2205,7 @@ static int fuse_writepages_fill(struct page *page,
 			goto out_unlock;
 	}
 
-	if (wpa && fuse_writepage_need_send(fc, page, ap, data)) {
+	if (wpa && fuse_writepage_need_send(fc, &folio->page, ap, data)) {
 		fuse_writepages_send(data);
 		data->wpa = NULL;
 	}
@@ -2240,7 +2240,7 @@ static int fuse_writepages_fill(struct page *page,
 		data->max_pages = 1;
 
 		ap = &wpa->ia.ap;
-		fuse_write_args_fill(&wpa->ia, data->ff, page_offset(page), 0);
+		fuse_write_args_fill(&wpa->ia, data->ff, folio_pos(folio), 0);
 		wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
 		wpa->next = NULL;
 		ap->args.in_pages = true;
@@ -2248,13 +2248,13 @@ static int fuse_writepages_fill(struct page *page,
 		ap->num_pages = 0;
 		wpa->inode = inode;
 	}
-	set_page_writeback(page);
+	folio_start_writeback(folio);
 
-	copy_highpage(tmp_page, page);
+	copy_highpage(tmp_page, &folio->page);
 	ap->pages[ap->num_pages] = tmp_page;
 	ap->descs[ap->num_pages].offset = 0;
 	ap->descs[ap->num_pages].length = PAGE_SIZE;
-	data->orig_pages[ap->num_pages] = page;
+	data->orig_pages[ap->num_pages] = &folio->page;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
 	inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
@@ -2268,13 +2268,13 @@ static int fuse_writepages_fill(struct page *page,
 		spin_lock(&fi->lock);
 		ap->num_pages++;
 		spin_unlock(&fi->lock);
-	} else if (fuse_writepage_add(wpa, page)) {
+	} else if (fuse_writepage_add(wpa, &folio->page)) {
 		data->wpa = wpa;
 	} else {
-		end_page_writeback(page);
+		folio_end_writeback(folio);
 	}
 out_unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 
 	return err;
 }
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d3c300563eb8..6f4c97a6d7e9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1714,10 +1714,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
  * For unwritten space on the page, we need to start the conversion to
  * regular allocated space.
  */
-static int
-iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
+static int iomap_do_writepage(struct folio *folio,
+		struct writeback_control *wbc, void *data)
 {
-	struct folio *folio = page_folio(page);
 	struct iomap_writepage_ctx *wpc = data;
 	struct inode *inode = folio->mapping->host;
 	u64 end_pos, isize;
diff --git a/fs/mpage.c b/fs/mpage.c
index b8e7975159bc..840f57ed2542 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -445,9 +445,10 @@ void clean_page_buffers(struct page *page)
 	clean_buffers(page, ~0U);
 }
 
-static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
+static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 		      void *data)
 {
+	struct page *page = &folio->page;
 	struct mpage_data *mpd = data;
 	struct bio *bio = mpd->bio;
 	struct address_space *mapping = page->mapping;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 1a80d548253a..ba3799097d1a 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -690,13 +690,14 @@ int nfs_writepage(struct page *page, struct writeback_control *wbc)
 	return ret;
 }
 
-static int nfs_writepages_callback(struct page *page, struct writeback_control *wbc, void *data)
+static int nfs_writepages_callback(struct folio *folio,
+		struct writeback_control *wbc, void *data)
 {
 	int ret;
 
-	ret = nfs_do_writepage(page, wbc, data);
+	ret = nfs_do_writepage(&folio->page, wbc, data);
 	if (ret != AOP_WRITEPAGE_ACTIVATE)
-		unlock_page(page);
+		folio_unlock(folio);
 	return ret;
 }
 
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index bc4c9e35a6fc..3d2e4c1270e4 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -844,7 +844,7 @@ int ntfs_set_size(struct inode *inode, u64 new_size)
 	return err;
 }
 
-static int ntfs_resident_writepage(struct page *page,
+static int ntfs_resident_writepage(struct folio *folio,
 		struct writeback_control *wbc, void *data)
 {
 	struct address_space *mapping = data;
@@ -852,11 +852,11 @@ static int ntfs_resident_writepage(struct page *page,
 	int ret;
 
 	ni_lock(ni);
-	ret = attr_data_write_resident(ni, page);
+	ret = attr_data_write_resident(ni, &folio->page);
 	ni_unlock(ni);
 
 	if (ret != E_NTFS_NONRESIDENT)
-		unlock_page(page);
+		folio_unlock(folio);
 	mapping_set_error(mapping, ret);
 	return ret;
 }
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 11e21a0e65ce..c4c135f96aab 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -154,21 +154,20 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 	return ret;
 }
 
-static int orangefs_writepages_callback(struct page *page,
-    struct writeback_control *wbc, void *data)
+static int orangefs_writepages_callback(struct folio *folio,
+		struct writeback_control *wbc, void *data)
 {
 	struct orangefs_writepages *ow = data;
-	struct orangefs_write_range *wr;
+	struct orangefs_write_range *wr = folio->private;
 	int ret;
 
-	if (!PagePrivate(page)) {
-		unlock_page(page);
+	if (!wr) {
+		folio_unlock(folio);
 		/* It's not private so there's nothing to write, right? */
 		printk("writepages_callback not private!\n");
 		BUG();
 		return 0;
 	}
-	wr = (struct orangefs_write_range *)page_private(page);
 
 	ret = -1;
 	if (ow->npages == 0) {
@@ -176,7 +175,7 @@ static int orangefs_writepages_callback(struct page *page,
 		ow->len = wr->len;
 		ow->uid = wr->uid;
 		ow->gid = wr->gid;
-		ow->pages[ow->npages++] = page;
+		ow->pages[ow->npages++] = &folio->page;
 		ret = 0;
 		goto done;
 	}
@@ -188,7 +187,7 @@ static int orangefs_writepages_callback(struct page *page,
 	}
 	if (ow->off + ow->len == wr->pos) {
 		ow->len += wr->len;
-		ow->pages[ow->npages++] = page;
+		ow->pages[ow->npages++] = &folio->page;
 		ret = 0;
 		goto done;
 	}
@@ -198,10 +197,10 @@ static int orangefs_writepages_callback(struct page *page,
 			orangefs_writepages_work(ow, wbc);
 			ow->npages = 0;
 		}
-		ret = orangefs_writepage_locked(page, wbc);
-		mapping_set_error(page->mapping, ret);
-		unlock_page(page);
-		end_page_writeback(page);
+		ret = orangefs_writepage_locked(&folio->page, wbc);
+		mapping_set_error(folio->mapping, ret);
+		folio_unlock(folio);
+		folio_end_writeback(folio);
 	} else {
 		if (ow->npages == ow->maxpages) {
 			orangefs_writepages_work(ow, wbc);
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 3f1491b07474..46020373e155 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -366,7 +366,7 @@ int balance_dirty_pages_ratelimited_flags(struct address_space *mapping,
 
 bool wb_over_bg_thresh(struct bdi_writeback *wb);
 
-typedef int (*writepage_t)(struct page *page, struct writeback_control *wbc,
+typedef int (*writepage_t)(struct folio *folio, struct writeback_control *wbc,
 				void *data);
 
 void tag_pages_for_writeback(struct address_space *mapping,
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 92b90d2ab513..516b1aa247e8 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2470,7 +2470,7 @@ int write_cache_pages(struct address_space *mapping,
 				goto continue_unlock;
 
 			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
-			error = writepage(&folio->page, wbc, data);
+			error = writepage(folio, wbc, data);
 			if (unlikely(error)) {
 				/*
 				 * Handle errors according to the type of
@@ -2528,11 +2528,11 @@ int write_cache_pages(struct address_space *mapping,
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-static int writepage_cb(struct page *page, struct writeback_control *wbc,
+static int writepage_cb(struct folio *folio, struct writeback_control *wbc,
 		void *data)
 {
 	struct address_space *mapping = data;
-	int ret = mapping->a_ops->writepage(page, wbc);
+	int ret = mapping->a_ops->writepage(&folio->page, wbc);
 	mapping_set_error(mapping, ret);
 	return ret;
 }
-- 
2.35.1

