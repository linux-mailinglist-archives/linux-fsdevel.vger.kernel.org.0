Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9C83C42B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhGLEPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhGLEP3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:15:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CF3C0613DD;
        Sun, 11 Jul 2021 21:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BmJF8mjcFHM1Tho8GqMXTNLfymCr4gvrm2oudpTxXSA=; b=gTJ0LYyqd55Z+xxgj1SAzN3q8e
        /awGm2D1SXng1S15wUuwCAaLhIWMzJc1mHtL8X+el1DH+dXLFQZpdHfXfTh6x1+jwzJ39fDuqC/xu
        CSia9bgMSvJkun+Rhebpv5tmXsBjzsDNdGPJ9FZkpAMyyQCiIKC70btOxGPh14zwbkm39CwhUMg03
        44TW6Ys8+dt7FQLtujXruxYoRoDdHJreDUCiTCOYwAA6eW2kTM9K1wFA58o6so5AIDX7ElVaiPSTn
        S4x+8DEVQOcuauUE9rafYLdSMfvlsYXubWZUDrblfA8luQMCYUeKH7mlsVC9/emZxkGsi6+RMLUko
        t03c/S5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nIY-00GrMA-LN; Mon, 12 Jul 2021 04:12:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 123/137] fs: Convert vfs_dedupe_file_range_compare to folios
Date:   Mon, 12 Jul 2021 04:06:47 +0100
Message-Id: <20210712030701.4000097-124-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We still only operate on a single page of data at a time due to using
kmap().  A more complex implementation would work on each page in a folio,
but it's not clear that such a complex implementation would be worthwhile.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/remap_range.c | 116 ++++++++++++++++++++++-------------------------
 1 file changed, 55 insertions(+), 61 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index e4a5fdd7ad7b..da50f87e83e7 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -158,41 +158,41 @@ static int generic_remap_check_len(struct inode *inode_in,
 }
 
 /* Read a page's worth of file data into the page cache. */
-static struct page *vfs_dedupe_get_page(struct inode *inode, loff_t offset)
+static struct folio *vfs_dedupe_get_folio(struct inode *inode, loff_t pos)
 {
-	struct page *page;
+	struct folio *folio;
 
-	page = read_mapping_page(inode->i_mapping, offset >> PAGE_SHIFT, NULL);
-	if (IS_ERR(page))
-		return page;
-	if (!PageUptodate(page)) {
-		put_page(page);
+	folio = read_mapping_folio(inode->i_mapping, pos >> PAGE_SHIFT, NULL);
+	if (IS_ERR(folio))
+		return folio;
+	if (!folio_uptodate(folio)) {
+		folio_put(folio);
 		return ERR_PTR(-EIO);
 	}
-	return page;
+	return folio;
 }
 
 /*
- * Lock two pages, ensuring that we lock in offset order if the pages are from
- * the same file.
+ * Lock two folios, ensuring that we lock in offset order if the folios
+ * are from the same file.
  */
-static void vfs_lock_two_pages(struct page *page1, struct page *page2)
+static void vfs_lock_two_folios(struct folio *folio1, struct folio *folio2)
 {
 	/* Always lock in order of increasing index. */
-	if (page1->index > page2->index)
-		swap(page1, page2);
+	if (folio1->index > folio2->index)
+		swap(folio1, folio2);
 
-	lock_page(page1);
-	if (page1 != page2)
-		lock_page(page2);
+	folio_lock(folio1);
+	if (folio1 != folio2)
+		folio_lock(folio2);
 }
 
-/* Unlock two pages, being careful not to unlock the same page twice. */
-static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
+/* Unlock two folios, being careful not to unlock the same folio twice. */
+static void vfs_unlock_two_folios(struct folio *folio1, struct folio *folio2)
 {
-	unlock_page(page1);
-	if (page1 != page2)
-		unlock_page(page2);
+	folio_unlock(folio1);
+	if (folio1 != folio2)
+		folio_unlock(folio2);
 }
 
 /*
@@ -200,77 +200,71 @@ static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
  * Caller must have locked both inodes to prevent write races.
  */
 static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
-					 struct inode *dest, loff_t destoff,
+					 struct inode *dest, loff_t dstoff,
 					 loff_t len, bool *is_same)
 {
-	loff_t src_poff;
-	loff_t dest_poff;
-	void *src_addr;
-	void *dest_addr;
-	struct page *src_page;
-	struct page *dest_page;
-	loff_t cmp_len;
-	bool same;
-	int error;
-
-	error = -EINVAL;
-	same = true;
+	bool same = true;
+	int error = -EINVAL;
+
 	while (len) {
-		src_poff = srcoff & (PAGE_SIZE - 1);
-		dest_poff = destoff & (PAGE_SIZE - 1);
-		cmp_len = min(PAGE_SIZE - src_poff,
-			      PAGE_SIZE - dest_poff);
+		struct folio *src_folio, *dst_folio;
+		void *src_addr, *dst_addr;
+		loff_t cmp_len = min(PAGE_SIZE - offset_in_page(srcoff),
+				     PAGE_SIZE - offset_in_page(dstoff));
+
 		cmp_len = min(cmp_len, len);
 		if (cmp_len <= 0)
 			goto out_error;
 
-		src_page = vfs_dedupe_get_page(src, srcoff);
-		if (IS_ERR(src_page)) {
-			error = PTR_ERR(src_page);
+		src_folio = vfs_dedupe_get_folio(src, srcoff);
+		if (IS_ERR(src_folio)) {
+			error = PTR_ERR(src_folio);
 			goto out_error;
 		}
-		dest_page = vfs_dedupe_get_page(dest, destoff);
-		if (IS_ERR(dest_page)) {
-			error = PTR_ERR(dest_page);
-			put_page(src_page);
+		dst_folio = vfs_dedupe_get_folio(dest, dstoff);
+		if (IS_ERR(dst_folio)) {
+			error = PTR_ERR(dst_folio);
+			folio_put(src_folio);
 			goto out_error;
 		}
 
-		vfs_lock_two_pages(src_page, dest_page);
+		vfs_lock_two_folios(src_folio, dst_folio);
 
 		/*
-		 * Now that we've locked both pages, make sure they're still
+		 * Now that we've locked both folios, make sure they're still
 		 * mapped to the file data we're interested in.  If not,
 		 * someone is invalidating pages on us and we lose.
 		 */
-		if (!PageUptodate(src_page) || !PageUptodate(dest_page) ||
-		    src_page->mapping != src->i_mapping ||
-		    dest_page->mapping != dest->i_mapping) {
+		if (!folio_uptodate(src_folio) || !folio_uptodate(dst_folio) ||
+		    src_folio->mapping != src->i_mapping ||
+		    dst_folio->mapping != dest->i_mapping) {
 			same = false;
 			goto unlock;
 		}
 
-		src_addr = kmap_atomic(src_page);
-		dest_addr = kmap_atomic(dest_page);
+		src_addr = kmap_local_folio(src_folio,
+					offset_in_folio(src_folio, srcoff));
+		dst_addr = kmap_local_folio(dst_folio,
+					offset_in_folio(dst_folio, dstoff));
 
-		flush_dcache_page(src_page);
-		flush_dcache_page(dest_page);
+		flush_dcache_folio(src_folio);
+		flush_dcache_folio(dst_folio);
 
-		if (memcmp(src_addr + src_poff, dest_addr + dest_poff, cmp_len))
+		if (memcmp(src_addr, dst_addr, cmp_len))
 			same = false;
 
-		kunmap_atomic(dest_addr);
-		kunmap_atomic(src_addr);
+		kunmap_local(dst_addr);
+		kunmap_local(src_addr);
 unlock:
-		vfs_unlock_two_pages(src_page, dest_page);
-		put_page(dest_page);
-		put_page(src_page);
+		vfs_unlock_two_folios(src_folio, dst_folio);
+		folio_put(dst_folio);
+		folio_put(src_folio);
 
 		if (!same)
 			break;
 
 		srcoff += cmp_len;
-		destoff += cmp_len;
+		dstoff += cmp_len;
 		len -= cmp_len;
 	}
 
-- 
2.30.2

