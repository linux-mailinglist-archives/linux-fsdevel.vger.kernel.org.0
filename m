Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2564881A9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jan 2022 06:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiAHFcm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jan 2022 00:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiAHFcm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jan 2022 00:32:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB3BC061574
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jan 2022 21:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JnCPt2QlLXrB8RRmtfFumFFVUAmLrdq9M1ysDGy3Ypc=; b=LmdQNj/EpD2VPfZk5nxu/jhpRe
        4ZnYBxJEc9zewDj5ZA7vxWqeERnt+QP1jqhRdaicxGHh/g1flWANIMpUbmUuuslQG6Vy0NGblsBUj
        qwvP6ZlANHDCFeRnxX7oNdQruzzd9zGilLfdZhaGCp+5zBC7lJ2610lUI3Ptyd+azC7zeq8yeu512
        amF9Jj4OhnplLWF728XqkM4bjM1zOzWyse+jk3+iV8Vt67We4R3fk5mbt6P3w1TtWJm5rkCuIpNPx
        Q8f5YNerWiNkVxyAqBbpKmSiTa5W2RgUX6McHJf+PT4wzC9VzqkNQGfJqvXHdly39fVnQVOYKFcNZ
        AxjqWyag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n64LF-000RrW-Mv; Sat, 08 Jan 2022 05:32:37 +0000
Date:   Sat, 8 Jan 2022 05:32:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/48] Folios for 5.17
Message-ID: <Ydkh9SXkDlYJTd35@casper.infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <YdHQnSqA10iwhJ85@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdHQnSqA10iwhJ85@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 02, 2022 at 04:19:41PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 08, 2021 at 04:22:08AM +0000, Matthew Wilcox (Oracle) wrote:
> > This all passes xfstests with no new failures on both xfs and tmpfs.
> > I intend to put all this into for-next tomorrow.
> 
> As a result of Christoph's review, here's the diff.  I don't
> think it's worth re-posting the entire patch series.

After further review and integrating Hugh's fixes, here's what
I've just updated the for-next tree with.  A little late, but that's
this time of year ...

diff --git a/mm/internal.h b/mm/internal.h
index e989d8ceec91..26af8a5a5be3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -76,28 +76,7 @@ static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
 	return !(vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP));
 }
 
-/*
- * Parameter block passed down to zap_pte_range in exceptional cases.
- */
-struct zap_details {
-	struct address_space *zap_mapping;	/* Check page->mapping if set */
-	struct folio *single_folio;	/* Locked folio to be unmapped */
-};
-
-/*
- * We set details->zap_mappings when we want to unmap shared but keep private
- * pages. Return true if skip zapping this page, false otherwise.
- */
-static inline bool
-zap_skip_check_mapping(struct zap_details *details, struct page *page)
-{
-	if (!details || !page)
-		return false;
-
-	return details->zap_mapping &&
-	    (details->zap_mapping != page_rmapping(page));
-}
-
+struct zap_details;
 void unmap_page_range(struct mmu_gather *tlb,
 			     struct vm_area_struct *vma,
 			     unsigned long addr, unsigned long end,
diff --git a/mm/memory.c b/mm/memory.c
index a86027026f2a..23f2f1300d42 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1304,6 +1304,28 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 	return ret;
 }
 
+/*
+ * Parameter block passed down to zap_pte_range in exceptional cases.
+ */
+struct zap_details {
+	struct address_space *zap_mapping;	/* Check page->mapping if set */
+	struct folio *single_folio;	/* Locked folio to be unmapped */
+};
+
+/*
+ * We set details->zap_mapping when we want to unmap shared but keep private
+ * pages. Return true if skip zapping this page, false otherwise.
+ */
+static inline bool
+zap_skip_check_mapping(struct zap_details *details, struct page *page)
+{
+	if (!details || !page)
+		return false;
+
+	return details->zap_mapping &&
+		(details->zap_mapping != page_rmapping(page));
+}
+
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
diff --git a/mm/shmem.c b/mm/shmem.c
index 637de21ff40b..28d627444a24 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -151,19 +151,6 @@ int shmem_getpage(struct inode *inode, pgoff_t index,
 		mapping_gfp_mask(inode->i_mapping), NULL, NULL, NULL);
 }
 
-static int shmem_get_folio(struct inode *inode, pgoff_t index,
-		struct folio **foliop, enum sgp_type sgp)
-{
-	struct page *page = NULL;
-	int ret = shmem_getpage(inode, index, &page, sgp);
-
-	if (page)
-		*foliop = page_folio(page);
-	else
-		*foliop = NULL;
-	return ret;
-}
-
 static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
 {
 	return sb->s_fs_info;
@@ -890,6 +877,28 @@ void shmem_unlock_mapping(struct address_space *mapping)
 	}
 }
 
+static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
+{
+	struct folio *folio;
+	struct page *page;
+
+	/*
+	 * At first avoid shmem_getpage(,,,SGP_READ): that fails
+	 * beyond i_size, and reports fallocated pages as holes.
+	 */
+	folio = __filemap_get_folio(inode->i_mapping, index,
+					FGP_ENTRY | FGP_LOCK, 0);
+	if (!xa_is_value(folio))
+		return folio;
+	/*
+	 * But read a page back from swap if any of it is within i_size
+	 * (although in some cases this is just a waste of time).
+	 */
+	page = NULL;
+	shmem_getpage(inode, index, &page, SGP_READ);
+	return page ? page_folio(page) : NULL;
+}
+
 /*
  * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
@@ -904,10 +913,10 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	struct folio_batch fbatch;
 	pgoff_t indices[PAGEVEC_SIZE];
 	struct folio *folio;
+	bool same_folio;
 	long nr_swaps_freed = 0;
 	pgoff_t index;
 	int i;
-	bool partial_end;
 
 	if (lend == -1)
 		end = -1;	/* unsigned, so actually very big */
@@ -943,14 +952,10 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		index++;
 	}
 
-	partial_end = ((lend + 1) % PAGE_SIZE) != 0;
-	shmem_get_folio(inode, lstart >> PAGE_SHIFT, &folio, SGP_READ);
+	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
+	folio = shmem_get_partial_folio(inode, lstart >> PAGE_SHIFT);
 	if (folio) {
-		bool same_folio;
-
 		same_folio = lend < folio_pos(folio) + folio_size(folio);
-		if (same_folio)
-			partial_end = false;
 		folio_mark_dirty(folio);
 		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
 			start = folio->index + folio_nr_pages(folio);
@@ -962,8 +967,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		folio = NULL;
 	}
 
-	if (partial_end)
-		shmem_get_folio(inode, end, &folio, SGP_READ);
+	if (!same_folio)
+		folio = shmem_get_partial_folio(inode, lend >> PAGE_SHIFT);
 	if (folio) {
 		folio_mark_dirty(folio);
 		if (!truncate_inode_partial_folio(folio, lstart, lend))
diff --git a/mm/truncate.c b/mm/truncate.c
index 749aac71fda5..5c87cdc70e7b 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -351,7 +351,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	pgoff_t		index;
 	int		i;
 	struct folio	*folio;
-	bool		partial_end;
+	bool		same_folio;
 
 	if (mapping_empty(mapping))
 		goto out;
@@ -388,12 +388,10 @@ void truncate_inode_pages_range(struct address_space *mapping,
 		cond_resched();
 	}
 
-	partial_end = ((lend + 1) % PAGE_SIZE) != 0;
+	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
 	folio = __filemap_get_folio(mapping, lstart >> PAGE_SHIFT, FGP_LOCK, 0);
 	if (folio) {
-		bool same_folio = lend < folio_pos(folio) + folio_size(folio);
-		if (same_folio)
-			partial_end = false;
+		same_folio = lend < folio_pos(folio) + folio_size(folio);
 		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
 			start = folio->index + folio_nr_pages(folio);
 			if (same_folio)
@@ -404,8 +402,9 @@ void truncate_inode_pages_range(struct address_space *mapping,
 		folio = NULL;
 	}
 
-	if (partial_end)
-		folio = __filemap_get_folio(mapping, end, FGP_LOCK, 0);
+	if (!same_folio)
+		folio = __filemap_get_folio(mapping, lend >> PAGE_SHIFT,
+						FGP_LOCK, 0);
 	if (folio) {
 		if (!truncate_inode_partial_folio(folio, lstart, lend))
 			end = folio->index;
