Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF55B671934
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 11:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjARKlA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 05:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjARKkL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:40:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75644C4EAA;
        Wed, 18 Jan 2023 01:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=J1bJRn8dMRq79u1+uHawGew6oUOcQ5MnfgpdoCFCIVE=; b=TQTt/SAbg4Elgy7FQ74N+cMV0y
        8A+E+kNYML31DWmWs4Vll09VogMb8nddkG06zsPFdV8usGFtyocAqnXN57cmrApq8eZZjnL4n+ifZ
        WTSXrwV4tlafd1chRE92COzvQG7fg1aSkHlPqml0E6wNASis14pGRrZ4ApGcYImCTW6fX1CTWzUv2
        bu3Rale/X80o1JAwkRlkaLUYwMlLzC4QSa5D1tLsDmBgZbAfJpqFOeq/9AzBGbfOUTNRSkmZdrP4t
        O3Z3gS4V0zEibcUY0AsGOZXdCIYf7ruz2tu+uNRuzijI7EEK8vCpT2jpVCQcGCF3fi9K3tobLD2K6
        xqM08S8g==;
Received: from 213-147-167-250.nat.highway.webapn.at ([213.147.167.250] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pI4zR-000AD8-W6; Wed, 18 Jan 2023 09:44:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: [PATCH 9/9] mm: return an ERR_PTR from __filemap_get_folio
Date:   Wed, 18 Jan 2023 10:43:29 +0100
Message-Id: <20230118094329.9553-10-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118094329.9553-1-hch@lst.de>
References: <20230118094329.9553-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of returning NULL for all errors, distinguish between:

 - no entry found and not asked to allocated (-ENOENT)
 - failed to allocate memory (-ENOMEM)
 - would block (-EAGAIN)

so that callers don't have to guess the error based on the passed
in flags.

Also pass through the error through the direct callers:
filemap_get_folio, filemap_lock_folio filemap_grab_folio
and filemap_get_incore_folio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/afs/dir.c             | 10 +++++-----
 fs/afs/dir_edit.c        |  2 +-
 fs/afs/write.c           |  4 ++--
 fs/btrfs/disk-io.c       |  2 +-
 fs/btrfs/extent_io.c     |  2 +-
 fs/ext4/inode.c          |  2 +-
 fs/ext4/move_extent.c    |  8 ++++----
 fs/gfs2/lops.c           |  2 +-
 fs/hugetlbfs/inode.c     |  2 +-
 fs/iomap/buffered-io.c   |  6 +++---
 fs/netfs/buffered_read.c |  4 ++--
 fs/nilfs2/page.c         |  6 +++---
 mm/filemap.c             | 14 ++++++++------
 mm/folio-compat.c        |  2 +-
 mm/huge_memory.c         |  2 +-
 mm/memcontrol.c          |  2 +-
 mm/mincore.c             |  2 +-
 mm/shmem.c               |  4 ++--
 mm/swap_state.c          | 15 ++++++++-------
 mm/swapfile.c            |  4 ++--
 mm/truncate.c            | 15 ++++++++-------
 21 files changed, 57 insertions(+), 53 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index b7c1f8c84b38aa..41d0b4203870be 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -319,16 +319,16 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 		struct folio *folio;
 
 		folio = filemap_get_folio(mapping, i);
-		if (!folio) {
+		if (IS_ERR(folio)) {
 			if (test_and_clear_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
 				afs_stat_v(dvnode, n_inval);
-
-			ret = -ENOMEM;
 			folio = __filemap_get_folio(mapping,
 						    i, FGP_LOCK | FGP_CREAT,
 						    mapping->gfp_mask);
-			if (!folio)
+			if (IS_ERR(folio)) {
+				ret = PTR_ERR(folio);
 				goto error;
+			}
 			folio_attach_private(folio, (void *)1);
 			folio_unlock(folio);
 		}
@@ -524,7 +524,7 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 		 */
 		folio = __filemap_get_folio(dir->i_mapping, ctx->pos / PAGE_SIZE,
 					    FGP_ACCESSED, 0);
-		if (!folio) {
+		if (IS_ERR(folio)) {
 			ret = afs_bad(dvnode, afs_file_error_dir_missing_page);
 			break;
 		}
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index 0ab7752d1b758e..f0eddccbdd9541 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -115,7 +115,7 @@ static struct folio *afs_dir_get_folio(struct afs_vnode *vnode, pgoff_t index)
 	folio = __filemap_get_folio(mapping, index,
 				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
 				    mapping->gfp_mask);
-	if (!folio)
+	if (IS_ERR(folio))
 		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	else if (folio && !folio_test_private(folio))
 		folio_attach_private(folio, (void *)1);
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 2d3b08b7406ca7..cf1eb0d122c275 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -232,7 +232,7 @@ static void afs_kill_pages(struct address_space *mapping,
 		_debug("kill %lx (to %lx)", index, last);
 
 		folio = filemap_get_folio(mapping, index);
-		if (!folio) {
+		if (IS_ERR(folio)) {
 			next = index + 1;
 			continue;
 		}
@@ -270,7 +270,7 @@ static void afs_redirty_pages(struct writeback_control *wbc,
 		_debug("redirty %llx @%llx", len, start);
 
 		folio = filemap_get_folio(mapping, index);
-		if (!folio) {
+		if (IS_ERR(folio)) {
 			next = index + 1;
 			continue;
 		}
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7d5da43a89ee7f..f1035e0bcf8c6a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4034,7 +4034,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 
 		folio = filemap_get_folio(device->bdev->bd_inode->i_mapping,
 				     bytenr >> PAGE_SHIFT);
-		if (!folio) {
+		if (IS_ERR(folio)) {
 			errors++;
 			if (i == 0)
 				primary_failed = true;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a54d2cf74ba020..faaab9fae66d66 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -230,7 +230,7 @@ void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end)
 
 	while (index <= end_index) {
 		folio = filemap_get_folio(mapping, index);
-		if (!folio)
+		if (IS_ERR(folio))
 			continue;
 		filemap_dirty_folio(mapping, folio);
 		folio_account_redirty(folio);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fb6cd994e59afa..ee8f82c7acf9ff 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5391,7 +5391,7 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
 	while (1) {
 		struct folio *folio = filemap_lock_folio(inode->i_mapping,
 				      inode->i_size >> PAGE_SHIFT);
-		if (!folio)
+		if (IS_ERR(folio))
 			return;
 		ret = __ext4_journalled_invalidate_folio(folio, offset,
 						folio_size(folio) - offset);
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 2de9829aed63bf..7bf6d069199cbb 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -141,18 +141,18 @@ mext_folio_double_lock(struct inode *inode1, struct inode *inode2,
 	flags = memalloc_nofs_save();
 	folio[0] = __filemap_get_folio(mapping[0], index1, fgp_flags,
 			mapping_gfp_mask(mapping[0]));
-	if (!folio[0]) {
+	if (IS_ERR(folio[0])) {
 		memalloc_nofs_restore(flags);
-		return -ENOMEM;
+		return PTR_ERR(folio[0]);
 	}
 
 	folio[1] = __filemap_get_folio(mapping[1], index2, fgp_flags,
 			mapping_gfp_mask(mapping[1]));
 	memalloc_nofs_restore(flags);
-	if (!folio[1]) {
+	if (IS_ERR(folio[1])) {
 		folio_unlock(folio[0]);
 		folio_put(folio[0]);
-		return -ENOMEM;
+		return PTR_ERR(folio[1]);
 	}
 	/*
 	 * __filemap_get_folio() may not wait on folio's writeback if
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 51d4b610127cdb..9e8a00cee8afc1 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -472,7 +472,7 @@ static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
 	struct folio *folio;
 
 	folio = filemap_get_folio(jd->jd_inode->i_mapping, index);
-	if (!folio)
+	if (IS_ERR(folio))
 		return;
 
 	folio_wait_locked(folio);
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 48f1a8ad22431e..19dac1fbcd3705 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -697,7 +697,7 @@ static void hugetlbfs_zero_partial_page(struct hstate *h,
 	struct folio *folio;
 
 	folio = filemap_lock_folio(mapping, idx);
-	if (!folio)
+	if (IS_ERR(folio))
 		return;
 
 	start = start & ~huge_page_mask(h);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 356193e44cf07f..ab5a5a5a3e0283 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -614,8 +614,8 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 
 	folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
 			fgp, mapping_gfp_mask(iter->inode->i_mapping));
-	if (!folio) {
-		status = (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
+	if (IS_ERR(folio)) {
+		status = PTR_ERR(folio);
 		goto out_no_page;
 	}
 
@@ -882,7 +882,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 		/* grab locked page */
 		folio = filemap_lock_folio(inode->i_mapping,
 				start_byte >> PAGE_SHIFT);
-		if (!folio) {
+		if (IS_ERR(folio)) {
 			start_byte = ALIGN_DOWN(start_byte, PAGE_SIZE) +
 					PAGE_SIZE;
 			continue;
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 7679a68e819307..209726a9cfdb9c 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -350,8 +350,8 @@ int netfs_write_begin(struct netfs_inode *ctx,
 retry:
 	folio = __filemap_get_folio(mapping, index, fgp_flags,
 				    mapping_gfp_mask(mapping));
-	if (!folio)
-		return -ENOMEM;
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
 	if (ctx->ops->check_write_begin) {
 		/* Allow the netfs (eg. ceph) to flush conflicts. */
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 41ccd43cd9797f..5cf30827f244c4 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -259,10 +259,10 @@ int nilfs_copy_dirty_pages(struct address_space *dmap,
 			NILFS_PAGE_BUG(&folio->page, "inconsistent dirty state");
 
 		dfolio = filemap_grab_folio(dmap, folio->index);
-		if (unlikely(!dfolio)) {
+		if (unlikely(IS_ERR(dfolio))) {
 			/* No empty page is added to the page cache */
-			err = -ENOMEM;
 			folio_unlock(folio);
+			err = PTR_ERR(dfolio);
 			break;
 		}
 		if (unlikely(!folio_buffers(folio)))
@@ -311,7 +311,7 @@ void nilfs_copy_back_pages(struct address_space *dmap,
 
 		folio_lock(folio);
 		dfolio = filemap_lock_folio(dmap, index);
-		if (dfolio) {
+		if (!IS_ERR(dfolio)) {
 			/* overwrite existing folio in the destination cache */
 			WARN_ON(folio_test_dirty(dfolio));
 			nilfs_copy_page(&dfolio->page, &folio->page, 0);
diff --git a/mm/filemap.c b/mm/filemap.c
index 35baadd130795c..4037a132f7adcc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1905,7 +1905,7 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
  *
  * If there is a page cache page, it is returned with an increased refcount.
  *
- * Return: The found folio or %NULL otherwise.
+ * Return: The found folio or an ERR_PTR() otherwise.
  */
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		int fgp_flags, gfp_t gfp)
@@ -1923,7 +1923,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		if (fgp_flags & FGP_NOWAIT) {
 			if (!folio_trylock(folio)) {
 				folio_put(folio);
-				return NULL;
+				return ERR_PTR(-EAGAIN);
 			}
 		} else {
 			folio_lock(folio);
@@ -1962,7 +1962,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 
 		folio = filemap_alloc_folio(gfp, 0);
 		if (!folio)
-			return NULL;
+			return ERR_PTR(-ENOMEM);
 
 		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
 			fgp_flags |= FGP_LOCK;
@@ -1987,6 +1987,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			folio_unlock(folio);
 	}
 
+	if (!folio)
+		return ERR_PTR(-ENOENT);
 	return folio;
 }
 EXPORT_SYMBOL(__filemap_get_folio);
@@ -3126,7 +3128,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * Do we have something in the page cache already?
 	 */
 	folio = filemap_get_folio(mapping, index);
-	if (likely(folio)) {
+	if (likely(!IS_ERR(folio))) {
 		/*
 		 * We found the page, so try async readahead before waiting for
 		 * the lock.
@@ -3155,7 +3157,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		folio = __filemap_get_folio(mapping, index,
 					  FGP_CREAT|FGP_FOR_MMAP,
 					  vmf->gfp_mask);
-		if (!folio) {
+		if (IS_ERR(folio)) {
 			if (fpin)
 				goto out_retry;
 			filemap_invalidate_unlock_shared(mapping);
@@ -3506,7 +3508,7 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 		filler = mapping->a_ops->read_folio;
 repeat:
 	folio = filemap_get_folio(mapping, index);
-	if (!folio) {
+	if (IS_ERR(folio)) {
 		folio = filemap_alloc_folio(gfp, 0);
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index f3841b4977b68e..4cd173336d8589 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -97,7 +97,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 	struct folio *folio;
 
 	folio = __filemap_get_folio(mapping, index, fgp_flags, gfp);
-	if (!folio)
+	if (IS_ERR(folio))
 		return NULL;
 	return folio_file_page(folio, index);
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a2830019aaa017..b0c9170632e37c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3103,7 +3103,7 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 		struct folio *folio = filemap_get_folio(mapping, index);
 
 		nr_pages = 1;
-		if (!folio)
+		if (IS_ERR(folio))
 			continue;
 
 		if (!folio_test_large(folio))
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 893427aded0191..8bcea91099d218 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5693,7 +5693,7 @@ static struct page *mc_handle_file_pte(struct vm_area_struct *vma,
 	/* shmem/tmpfs may report page out on swap: account for that too. */
 	index = linear_page_index(vma, addr);
 	folio = filemap_get_incore_folio(vma->vm_file->f_mapping, index);
-	if (!folio)
+	if (IS_ERR(folio))
 		return NULL;
 	return folio_file_page(folio, index);
 }
diff --git a/mm/mincore.c b/mm/mincore.c
index a085a2aeabd8e6..386c1aed1a8aef 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -61,7 +61,7 @@ static unsigned char mincore_page(struct address_space *mapping, pgoff_t index)
 	 * tmpfs's .fault). So swapped out tmpfs mappings are tested here.
 	 */
 	folio = filemap_get_incore_folio(mapping, index);
-	if (folio) {
+	if (!IS_ERR(folio)) {
 		present = folio_test_uptodate(folio);
 		folio_put(folio);
 	}
diff --git a/mm/shmem.c b/mm/shmem.c
index 769107f376562f..676318f95f7b40 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -603,7 +603,7 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 
 		index = (inode->i_size & HPAGE_PMD_MASK) >> PAGE_SHIFT;
 		folio = filemap_get_folio(inode->i_mapping, index);
-		if (!folio)
+		if (IS_ERR(folio))
 			goto drop;
 
 		/* No huge page at the end of the file: nothing to split */
@@ -3187,7 +3187,7 @@ static const char *shmem_get_link(struct dentry *dentry,
 
 	if (!dentry) {
 		folio = filemap_get_folio(inode->i_mapping, 0);
-		if (!folio)
+		if (IS_ERR(folio))
 			return ERR_PTR(-ECHILD);
 		if (PageHWPoison(folio_page(folio, 0)) ||
 		    !folio_test_uptodate(folio)) {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index c39ea34bc4fc10..e853d3eecf55bb 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -330,7 +330,7 @@ struct folio *swap_cache_get_folio(swp_entry_t entry,
 	struct folio *folio;
 
 	folio = filemap_get_folio(swap_address_space(entry), swp_offset(entry));
-	if (folio) {
+	if (!IS_ERR(folio)) {
 		bool vma_ra = swap_use_vma_readahead();
 		bool readahead;
 
@@ -360,6 +360,8 @@ struct folio *swap_cache_get_folio(swp_entry_t entry,
 			if (!vma || !vma_ra)
 				atomic_inc(&swapin_readahead_hits);
 		}
+	} else {
+		folio = NULL;
 	}
 
 	return folio;
@@ -383,22 +385,21 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 	struct folio *folio = filemap_get_entry(mapping, index);
 
 	if (!xa_is_value(folio))
-		goto out;
+		return folio;
 	if (!shmem_mapping(mapping))
-		return NULL;
+		return ERR_PTR(-ENOENT);
 
 	swp = radix_to_swp_entry(folio);
 	/* There might be swapin error entries in shmem mapping. */
 	if (non_swap_entry(swp))
-		return NULL;
+		return ERR_PTR(-ENOENT);
 	/* Prevent swapoff from happening to us */
 	si = get_swap_device(swp);
 	if (!si)
-		return NULL;
+		return ERR_PTR(-ENOENT);
 	index = swp_offset(swp);
 	folio = filemap_get_folio(swap_address_space(swp), index);
 	put_swap_device(si);
-out:
 	return folio;
 }
 
@@ -425,7 +426,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		folio = filemap_get_folio(swap_address_space(entry),
 						swp_offset(entry));
 		put_swap_device(si);
-		if (folio)
+		if (!IS_ERR(folio))
 			return folio_file_page(folio, swp_offset(entry));
 
 		/*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index a5729273480e07..a128b61b6b8c91 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -136,7 +136,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	int ret = 0;
 
 	folio = filemap_get_folio(swap_address_space(entry), offset);
-	if (!folio)
+	if (IS_ERR(folio))
 		return 0;
 	/*
 	 * When this function is called from scan_swap_map_slots() and it's
@@ -2096,7 +2096,7 @@ static int try_to_unuse(unsigned int type)
 
 		entry = swp_entry(type, i);
 		folio = filemap_get_folio(swap_address_space(entry), i);
-		if (!folio)
+		if (IS_ERR(folio))
 			continue;
 
 		/*
diff --git a/mm/truncate.c b/mm/truncate.c
index 7b4ea4c4a46b20..86de31ed4d3238 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -375,7 +375,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 
 	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
 	folio = __filemap_get_folio(mapping, lstart >> PAGE_SHIFT, FGP_LOCK, 0);
-	if (folio) {
+	if (!IS_ERR(folio)) {
 		same_folio = lend < folio_pos(folio) + folio_size(folio);
 		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
 			start = folio->index + folio_nr_pages(folio);
@@ -387,14 +387,15 @@ void truncate_inode_pages_range(struct address_space *mapping,
 		folio = NULL;
 	}
 
-	if (!same_folio)
+	if (!same_folio) {
 		folio = __filemap_get_folio(mapping, lend >> PAGE_SHIFT,
 						FGP_LOCK, 0);
-	if (folio) {
-		if (!truncate_inode_partial_folio(folio, lstart, lend))
-			end = folio->index;
-		folio_unlock(folio);
-		folio_put(folio);
+		if (!IS_ERR(folio)) {
+			if (!truncate_inode_partial_folio(folio, lstart, lend))
+				end = folio->index;
+			folio_unlock(folio);
+			folio_put(folio);
+		}
 	}
 
 	index = start;
-- 
2.39.0

