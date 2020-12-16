Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E379B2DC658
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbgLPSZX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbgLPSZP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:25:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079CEC0619D9;
        Wed, 16 Dec 2020 10:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4MqLFYJa0b7azqVsLM60kPgjw++nWYQ7R+STxN4unJs=; b=irCQja3s7K39SfpugPIB3PSSMo
        RwJiuclU+1EQOKFJR8+wz5F+jNfp+M/HCf1ytu81HKBbteYYJQobxp57otUv2HPY9ovLLT1vBNLla
        Chls+AEh+tenkDlZTW+yWgvQp+83il8kdKB+HIt44M1Sd6qzXfK2xQ6x/0FabbH8uT4RtLPaDc4yu
        y4iQ01N2dbQi77lZU8U6zZNOaaLIXR/09RW/wRHC3binaSpLMw6JFeve4rmmXh/5EaAsuU8tj+Pg/
        gZMQt4+2LecfdPSfpJG+1htPvi+IsQE5md8Zlb143yrEpAjmlBWtsSBEPfhk0+KVZ4lR40s66Tb2J
        ZCLwfh4w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSk-00079Q-FV; Wed, 16 Dec 2020 18:23:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 25/25] fs: Convert vfs_dedupe_file_range_compare to folios
Date:   Wed, 16 Dec 2020 18:23:35 +0000
Message-Id: <20201216182335.27227-26-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Simplify the implementation somewhat by working in pgoff_t instead
of loff_t.  We still only operate on a single page of data at a time
due to using kmap().  A more complex implementation would work on
an entire folio at a time and (if the pages are highmem) map and
unmap, but it's not clear that such a complex implementation would
be worthwhile.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/remap_range.c | 109 ++++++++++++++++++++++-------------------------
 1 file changed, 52 insertions(+), 57 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 77dba3a49e65..0ee52c2da2cf 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -158,41 +158,41 @@ static int generic_remap_check_len(struct inode *inode_in,
 }
 
 /* Read a page's worth of file data into the page cache. */
-static struct page *vfs_dedupe_get_page(struct inode *inode, loff_t offset)
+static struct folio *vfs_dedupe_get_folio(struct inode *inode, pgoff_t index)
 {
-	struct page *page;
+	struct folio *folio;
 
-	page = read_mapping_page(inode->i_mapping, offset >> PAGE_SHIFT, NULL);
-	if (IS_ERR(page))
-		return page;
-	if (!PageUptodate(page)) {
-		put_page(page);
+	folio = read_mapping_folio(inode->i_mapping, index, NULL);
+	if (IS_ERR(folio))
+		return folio;
+	if (!FolioUptodate(folio)) {
+		put_folio(folio);
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
+	if (folio_index(folio1) > folio_index(folio2))
+		swap(folio1, folio2);
 
-	lock_page(page1);
-	if (page1 != page2)
-		lock_page(page2);
+	lock_folio(folio1);
+	if (folio1 != folio2)
+		lock_folio(folio2);
 }
 
-/* Unlock two pages, being careful not to unlock the same page twice. */
-static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
+/* Unlock two folios, being careful not to unlock the same folio twice. */
+static void vfs_unlock_two_folios(struct folio *folio1, struct folio *folio2)
 {
-	unlock_page(page1);
-	if (page1 != page2)
-		unlock_page(page2);
+	unlock_folio(folio1);
+	if (folio1 != folio2)
+		unlock_folio(folio2);
 }
 
 /*
@@ -203,68 +203,63 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 					 struct inode *dest, loff_t destoff,
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
+		void *src_addr, *dest_addr;
+		pgoff_t src_index = srcoff / PAGE_SIZE;
+		pgoff_t dst_index = destoff / PAGE_SIZE;
+		loff_t cmp_len = min(PAGE_SIZE - offset_in_page(srcoff),
+				     PAGE_SIZE - offset_in_page(destoff));
+
 		cmp_len = min(cmp_len, len);
 		if (cmp_len <= 0)
 			goto out_error;
 
-		src_page = vfs_dedupe_get_page(src, srcoff);
-		if (IS_ERR(src_page)) {
-			error = PTR_ERR(src_page);
+		src_folio = vfs_dedupe_get_folio(src, src_index);
+		if (IS_ERR(src_folio)) {
+			error = PTR_ERR(src_folio);
 			goto out_error;
 		}
-		dest_page = vfs_dedupe_get_page(dest, destoff);
-		if (IS_ERR(dest_page)) {
-			error = PTR_ERR(dest_page);
-			put_page(src_page);
+		dst_folio = vfs_dedupe_get_folio(dest, dst_index);
+		if (IS_ERR(dst_folio)) {
+			error = PTR_ERR(dst_folio);
+			put_folio(src_folio);
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
+		if (!FolioUptodate(src_folio) || !FolioUptodate(dst_folio) ||
+		    folio_mapping(src_folio) != src->i_mapping ||
+		    folio_mapping(dst_folio) != dest->i_mapping) {
 			same = false;
 			goto unlock;
 		}
 
-		src_addr = kmap_atomic(src_page);
-		dest_addr = kmap_atomic(dest_page);
+		src_addr = kmap_atomic(folio_page(src_folio, src_index));
+		dest_addr = kmap_atomic(folio_page(dst_folio, dst_index));
 
-		flush_dcache_page(src_page);
-		flush_dcache_page(dest_page);
+		flush_dcache_folio(src_folio);
+		flush_dcache_folio(dst_folio);
 
-		if (memcmp(src_addr + src_poff, dest_addr + dest_poff, cmp_len))
+		if (memcmp(src_addr + offset_in_page(srcoff),
+			   dest_addr + offset_in_page(destoff), cmp_len))
 			same = false;
 
 		kunmap_atomic(dest_addr);
 		kunmap_atomic(src_addr);
 unlock:
-		vfs_unlock_two_pages(src_page, dest_page);
-		put_page(dest_page);
-		put_page(src_page);
+		vfs_unlock_two_folios(src_folio, dst_folio);
+		put_folio(dst_folio);
+		put_folio(src_folio);
 
 		if (!same)
 			break;
-- 
2.29.2

