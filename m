Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB3D3C981F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239250AbhGOFQY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhGOFQX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:16:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49312C06175F;
        Wed, 14 Jul 2021 22:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ubkBUcZkQq7PEz+ieCUNeeq4MwyrT33JYJHMPgq6Lhk=; b=p8ZEbAMZsDVunWkl1areZpIQfW
        61kna7QKhWLs4vqHciKHU/MJViW2/ZeWw/M6hg9pH8ewB3y7e1R1tzl1Cw0WXWMIRIVzTVfeK7vTp
        sZZeeyDOyoOUD1X3GQqjTPm/d6e1T4+ZdrWC+AI5kR8a1tTi1uS1L0WAfLiZRwKyCPsYlFVZaS5wj
        zAxf7Pw78n5NymBncm4vKDIK/rJbphyJXMegMTI86/87AAH5vRdnVQQLYzIGg+/K6Q5ArQSfO5oXO
        i8XbmpqehAEG0BHi0VFLg4qwlDbgch2Dc0GRohH3ds0NJqVlzjUhrARu/lrcxAp2eK0geb2qTNkrf
        oXQppnhw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tfR-0030IM-AL; Thu, 15 Jul 2021 05:12:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 117/138] mm/filemap: Convert filemap_fault to folio
Date:   Thu, 15 Jul 2021 04:36:43 +0100
Message-Id: <20210715033704.692967-118-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
 mm/filemap.c | 78 +++++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 078c318e2f16..b0fe3234a20b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2801,21 +2801,20 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
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
 
@@ -2904,7 +2903,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
  * was pinned if we have to drop the mmap_lock in order to do IO.
  */
 static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
-					    struct page *page)
+					    struct folio *folio)
 {
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
@@ -2919,10 +2918,10 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	mmap_miss = READ_ONCE(ra->mmap_miss);
 	if (mmap_miss)
 		WRITE_ONCE(ra->mmap_miss, --mmap_miss);
-	if (PageReadahead(page)) {
+	if (folio_test_readahead(folio)) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		page_cache_async_readahead(mapping, ra, file,
-					   page, offset, ra->ra_pages);
+					   &folio->page, offset, ra->ra_pages);
 	}
 	return fpin;
 }
@@ -2941,7 +2940,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
  * vma->vm_mm->mmap_lock must be held on entry.
  *
  * If our return value has VM_FAULT_RETRY set, it's because the mmap_lock
- * may be dropped before doing I/O or by lock_page_maybe_drop_mmap().
+ * may be dropped before doing I/O or by lock_folio_maybe_drop_mmap().
  *
  * If our return value does not have VM_FAULT_RETRY set, the mmap_lock
  * has not been released.
@@ -2957,58 +2956,57 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	struct file *fpin = NULL;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
-	pgoff_t offset = vmf->pgoff;
-	pgoff_t max_off;
-	struct page *page;
+	pgoff_t max_idx, index = vmf->pgoff;
+	struct folio *folio;
 	vm_fault_t ret = 0;
 
-	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
-	if (unlikely(offset >= max_off))
+	max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	if (unlikely(index >= max_idx))
 		return VM_FAULT_SIGBUS;
 
 	/*
 	 * Do we have something in the page cache already?
 	 */
-	page = find_get_page(mapping, offset);
-	if (likely(page) && !(vmf->flags & FAULT_FLAG_TRIED)) {
+	folio = filemap_get_folio(mapping, index);
+	if (likely(folio) && !(vmf->flags & FAULT_FLAG_TRIED)) {
 		/*
 		 * We found the page, so try async readahead before
 		 * waiting for the lock.
 		 */
-		fpin = do_async_mmap_readahead(vmf, page);
-	} else if (!page) {
+		fpin = do_async_mmap_readahead(vmf, folio);
+	} else if (!folio) {
 		/* No page in the page cache at all */
 		count_vm_event(PGMAJFAULT);
 		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
 		ret = VM_FAULT_MAJOR;
 		fpin = do_sync_mmap_readahead(vmf);
 retry_find:
-		page = pagecache_get_page(mapping, offset,
+		folio = __filemap_get_folio(mapping, index,
 					  FGP_CREAT|FGP_FOR_MMAP,
 					  vmf->gfp_mask);
-		if (!page) {
+		if (!folio) {
 			if (fpin)
 				goto out_retry;
 			return VM_FAULT_OOM;
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
-	if (unlikely(!PageUptodate(page)))
+	if (unlikely(!folio_test_uptodate(folio)))
 		goto page_not_uptodate;
 
 	/*
@@ -3017,7 +3015,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * redo the fault.
 	 */
 	if (fpin) {
-		unlock_page(page);
+		folio_unlock(folio);
 		goto out_retry;
 	}
 
@@ -3025,14 +3023,14 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
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
@@ -3043,10 +3041,10 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
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
@@ -3059,8 +3057,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * re-find the vma and come back and find our hopefully still populated
 	 * page.
 	 */
-	if (page)
-		put_page(page);
+	if (folio)
+		folio_put(folio);
 	if (fpin)
 		fput(fpin);
 	return ret | VM_FAULT_RETRY;
-- 
2.30.2

