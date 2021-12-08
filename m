Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4288446CC65
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbhLHE1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240112AbhLHE0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E0EC0698C5
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sGlg8/qoS2pD0+lmCeNJGiM/awa+dbIop15sAKpzu3c=; b=qKxd4LXF0iFL6SZF2ySJm+5ymB
        pibp64Dq52T8XBLNAqrtOYBBAw5OD4LNxlrfM6QANyz++3Qvn2qYILgFKFUCabxJ90FGj7fP7UVSW
        xgguWb5QR53SfITu5UBw1ZanLp3QEAZKB2tQUD923iKR0bk7aqDrO4bwZp7K9IVDgc3KvJRDjpWVo
        SRiUhyPhi2cj6aIid7mjvV4ycyRMvbb5K59r/VZdPbDfeKvFJthh8A38P3Z+ptNcLZWo7Rnje+c3s
        rV989oytNf2iiKLUL93d4nYVswhaO4h2fgbm69jNdMgI8E9W3rDBRpm/KkvHLK8wiqx0TIKnbe3ym
        jM2ecS+A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU4-0084Yv-Fc; Wed, 08 Dec 2021 04:23:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 24/48] filemap: Convert filemap_fault to folio
Date:   Wed,  8 Dec 2021 04:22:32 +0000
Message-Id: <20211208042256.1923824-25-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of converting back-and-forth between the actual page and
the head page, just convert once at the end of the function where we
set the vmf->page.  Saves 241 bytes of text, or 15% of the size of
filemap_fault().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 77 +++++++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 0838b08557f5..fc0f1d9904d2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2898,21 +2898,20 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
 #ifdef CONFIG_MMU
 #define MMAP_LOTSAMISS  (100)
 /*
- * lock_page_maybe_drop_mmap - lock the page, possibly dropping the mmap_lock
+ * lock_folio_maybe_drop_mmap - lock the page, possibly dropping the mmap_lock
  * @vmf - the vm_fault for this fault.
- * @page - the page to lock.
+ * @folio - the folio to lock.
  * @fpin - the pointer to the file we may pin (or is already pinned).
  *
- * This works similar to lock_page_or_retry in that it can drop the mmap_lock.
- * It differs in that it actually returns the page locked if it returns 1 and 0
- * if it couldn't lock the page.  If we did have to drop the mmap_lock then fpin
- * will point to the pinned file and needs to be fput()'ed at a later point.
+ * This works similar to lock_folio_or_retry in that it can drop the
+ * mmap_lock.  It differs in that it actually returns the folio locked
+ * if it returns 1 and 0 if it couldn't lock the folio.  If we did have
+ * to drop the mmap_lock then fpin will point to the pinned file and
+ * needs to be fput()'ed at a later point.
  */
-static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
+static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
 				     struct file **fpin)
 {
-	struct folio *folio = page_folio(page);
-
 	if (folio_trylock(folio))
 		return 1;
 
@@ -3038,7 +3037,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
  * vma->vm_mm->mmap_lock must be held on entry.
  *
  * If our return value has VM_FAULT_RETRY set, it's because the mmap_lock
- * may be dropped before doing I/O or by lock_page_maybe_drop_mmap().
+ * may be dropped before doing I/O or by lock_folio_maybe_drop_mmap().
  *
  * If our return value does not have VM_FAULT_RETRY set, the mmap_lock
  * has not been released.
@@ -3054,29 +3053,27 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	struct file *fpin = NULL;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
-	pgoff_t offset = vmf->pgoff;
-	pgoff_t max_off;
-	struct page *page;
+	pgoff_t max_idx, index = vmf->pgoff;
+	struct folio *folio;
 	vm_fault_t ret = 0;
 	bool mapping_locked = false;
 
-	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
-	if (unlikely(offset >= max_off))
+	max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	if (unlikely(index >= max_idx))
 		return VM_FAULT_SIGBUS;
 
 	/*
 	 * Do we have something in the page cache already?
 	 */
-	page = find_get_page(mapping, offset);
-	if (likely(page)) {
-		struct folio *folio = page_folio(page);
+	folio = filemap_get_folio(mapping, index);
+	if (likely(folio)) {
 		/*
 		 * We found the page, so try async readahead before waiting for
 		 * the lock.
 		 */
 		if (!(vmf->flags & FAULT_FLAG_TRIED))
 			fpin = do_async_mmap_readahead(vmf, folio);
-		if (unlikely(!PageUptodate(page))) {
+		if (unlikely(!folio_test_uptodate(folio))) {
 			filemap_invalidate_lock_shared(mapping);
 			mapping_locked = true;
 		}
@@ -3088,17 +3085,17 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		fpin = do_sync_mmap_readahead(vmf);
 retry_find:
 		/*
-		 * See comment in filemap_create_page() why we need
+		 * See comment in filemap_create_folio() why we need
 		 * invalidate_lock
 		 */
 		if (!mapping_locked) {
 			filemap_invalidate_lock_shared(mapping);
 			mapping_locked = true;
 		}
-		page = pagecache_get_page(mapping, offset,
+		folio = __filemap_get_folio(mapping, index,
 					  FGP_CREAT|FGP_FOR_MMAP,
 					  vmf->gfp_mask);
-		if (!page) {
+		if (!folio) {
 			if (fpin)
 				goto out_retry;
 			filemap_invalidate_unlock_shared(mapping);
@@ -3106,22 +3103,22 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		}
 	}
 
-	if (!lock_page_maybe_drop_mmap(vmf, page, &fpin))
+	if (!lock_folio_maybe_drop_mmap(vmf, folio, &fpin))
 		goto out_retry;
 
 	/* Did it get truncated? */
-	if (unlikely(compound_head(page)->mapping != mapping)) {
-		unlock_page(page);
-		put_page(page);
+	if (unlikely(folio->mapping != mapping)) {
+		folio_unlock(folio);
+		folio_put(folio);
 		goto retry_find;
 	}
-	VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page);
+	VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
 
 	/*
 	 * We have a locked page in the page cache, now we need to check
 	 * that it's up-to-date. If not, it is going to be due to an error.
 	 */
-	if (unlikely(!PageUptodate(page))) {
+	if (unlikely(!folio_test_uptodate(folio))) {
 		/*
 		 * The page was in cache and uptodate and now it is not.
 		 * Strange but possible since we didn't hold the page lock all
@@ -3129,8 +3126,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		 * try again.
 		 */
 		if (!mapping_locked) {
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			goto retry_find;
 		}
 		goto page_not_uptodate;
@@ -3142,7 +3139,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * redo the fault.
 	 */
 	if (fpin) {
-		unlock_page(page);
+		folio_unlock(folio);
 		goto out_retry;
 	}
 	if (mapping_locked)
@@ -3152,14 +3149,14 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * Found the page and have a reference on it.
 	 * We must recheck i_size under page lock.
 	 */
-	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
-	if (unlikely(offset >= max_off)) {
-		unlock_page(page);
-		put_page(page);
+	max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	if (unlikely(index >= max_idx)) {
+		folio_unlock(folio);
+		folio_put(folio);
 		return VM_FAULT_SIGBUS;
 	}
 
-	vmf->page = page;
+	vmf->page = folio_file_page(folio, index);
 	return ret | VM_FAULT_LOCKED;
 
 page_not_uptodate:
@@ -3170,10 +3167,10 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * and we need to check for errors.
 	 */
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-	error = filemap_read_folio(file, mapping, page_folio(page));
+	error = filemap_read_folio(file, mapping, folio);
 	if (fpin)
 		goto out_retry;
-	put_page(page);
+	folio_put(folio);
 
 	if (!error || error == AOP_TRUNCATED_PAGE)
 		goto retry_find;
@@ -3187,8 +3184,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * re-find the vma and come back and find our hopefully still populated
 	 * page.
 	 */
-	if (page)
-		put_page(page);
+	if (folio)
+		folio_put(folio);
 	if (mapping_locked)
 		filemap_invalidate_unlock_shared(mapping);
 	if (fpin)
-- 
2.33.0

