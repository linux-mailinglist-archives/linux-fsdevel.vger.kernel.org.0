Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D34D3575C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 22:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356064AbhDGUUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 16:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbhDGUUe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:20:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BEDC061760
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Apr 2021 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WzqWaSdo3hFj8je+2Ho7r6EUHHJaQ5hJdKrRIjV1Loc=; b=eMXNIhfPtO2PoHQL116IeTnh1i
        LtvJCPzr2MqFnj+nEt85iwOpi5TerlDP+sluaApTfjY2rTuL4Q+EyFoctueiFodTQMpP7fbEtutsj
        lqxpK72JIL3GVzlzZ67VpCccIAoG79cdFwhLIjS7o5INKuA2LGYE2d0B1cLU4bMgJD15/qtSniZbt
        zySuSgP5vhKezPO0Pd1q930v+SbXi6phMAvgeC/8kUvkKDmdoh4eeDo+rSCtFmbNpqPFhWJGlxJsq
        EHozh2/n81P5j0k9+USDLhmQ/bXDTdNVdZSG/MHEOxP6e2WObJ00P61S1AFhUflDHuHpErCG4OcTZ
        xHzqkLAw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUEe7-00F25A-E9; Wed, 07 Apr 2021 20:19:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] mm/filemap: Pass the file_ra_state in the ractl
Date:   Wed,  7 Apr 2021 21:18:55 +0100
Message-Id: <20210407201857.3582797-2-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210407201857.3582797-1-willy@infradead.org>
References: <20210407201857.3582797-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For readahead_expand(), we need to modify the file ra_state, so pass it
down by adding it to the ractl.  We have to do this because it's not always
the same as f_ra in the struct file that is already being passed.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/verity.c        |  2 +-
 fs/f2fs/file.c          |  2 +-
 fs/f2fs/verity.c        |  2 +-
 include/linux/pagemap.h | 20 +++++++++++---------
 mm/filemap.c            |  4 ++--
 mm/internal.h           |  7 +++----
 mm/readahead.c          | 22 +++++++++++-----------
 7 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 00e3cbde472e..07438f46b558 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -370,7 +370,7 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
 					       unsigned long num_ra_pages)
 {
-	DEFINE_READAHEAD(ractl, NULL, inode->i_mapping, index);
+	DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
 	struct page *page;
 
 	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f3ca63b55843..e6cd08559375 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4051,7 +4051,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 
 static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 {
-	DEFINE_READAHEAD(ractl, NULL, inode->i_mapping, page_idx);
+	DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, page_idx);
 	struct address_space *mapping = inode->i_mapping;
 	struct page *page;
 	pgoff_t redirty_idx = page_idx;
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 15ba36926fad..03549b5ba204 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -261,7 +261,7 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
 					       unsigned long num_ra_pages)
 {
-	DEFINE_READAHEAD(ractl, NULL, inode->i_mapping, index);
+	DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
 	struct page *page;
 
 	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 72bca08f96a2..350e1c9726f2 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -826,20 +826,23 @@ static inline int add_to_page_cache(struct page *page,
  * @file: The file, used primarily by network filesystems for authentication.
  *	  May be NULL if invoked internally by the filesystem.
  * @mapping: Readahead this filesystem object.
+ * @ra: File readahead state.  May be NULL.
  */
 struct readahead_control {
 	struct file *file;
 	struct address_space *mapping;
+	struct file_ra_state *ra;
 /* private: use the readahead_* accessors instead */
 	pgoff_t _index;
 	unsigned int _nr_pages;
 	unsigned int _batch_count;
 };
 
-#define DEFINE_READAHEAD(rac, f, m, i)					\
-	struct readahead_control rac = {				\
+#define DEFINE_READAHEAD(ractl, f, r, m, i)				\
+	struct readahead_control ractl = {				\
 		.file = f,						\
 		.mapping = m,						\
+		.ra = r,						\
 		._index = i,						\
 	}
 
@@ -847,10 +850,9 @@ struct readahead_control {
 
 void page_cache_ra_unbounded(struct readahead_control *,
 		unsigned long nr_to_read, unsigned long lookahead_count);
-void page_cache_sync_ra(struct readahead_control *, struct file_ra_state *,
+void page_cache_sync_ra(struct readahead_control *, unsigned long req_count);
+void page_cache_async_ra(struct readahead_control *, struct page *,
 		unsigned long req_count);
-void page_cache_async_ra(struct readahead_control *, struct file_ra_state *,
-		struct page *, unsigned long req_count);
 void readahead_expand(struct readahead_control *ractl,
 		      loff_t new_start, size_t new_len);
 
@@ -872,8 +874,8 @@ void page_cache_sync_readahead(struct address_space *mapping,
 		struct file_ra_state *ra, struct file *file, pgoff_t index,
 		unsigned long req_count)
 {
-	DEFINE_READAHEAD(ractl, file, mapping, index);
-	page_cache_sync_ra(&ractl, ra, req_count);
+	DEFINE_READAHEAD(ractl, file, ra, mapping, index);
+	page_cache_sync_ra(&ractl, req_count);
 }
 
 /**
@@ -895,8 +897,8 @@ void page_cache_async_readahead(struct address_space *mapping,
 		struct file_ra_state *ra, struct file *file,
 		struct page *page, pgoff_t index, unsigned long req_count)
 {
-	DEFINE_READAHEAD(ractl, file, mapping, index);
-	page_cache_async_ra(&ractl, ra, page, req_count);
+	DEFINE_READAHEAD(ractl, file, ra, mapping, index);
+	page_cache_async_ra(&ractl, page, req_count);
 }
 
 /**
diff --git a/mm/filemap.c b/mm/filemap.c
index 5b4afb35c861..7aacec5684c7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2855,7 +2855,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
 	struct address_space *mapping = file->f_mapping;
-	DEFINE_READAHEAD(ractl, file, mapping, vmf->pgoff);
+	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
 
@@ -2867,7 +2867,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 
 	if (vmf->vma->vm_flags & VM_SEQ_READ) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-		page_cache_sync_ra(&ractl, ra, ra->ra_pages);
+		page_cache_sync_ra(&ractl, ra->ra_pages);
 		return fpin;
 	}
 
diff --git a/mm/internal.h b/mm/internal.h
index 213762665d1d..46eb82eaa195 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -51,13 +51,12 @@ void unmap_page_range(struct mmu_gather *tlb,
 
 void do_page_cache_ra(struct readahead_control *, unsigned long nr_to_read,
 		unsigned long lookahead_size);
-void force_page_cache_ra(struct readahead_control *, struct file_ra_state *,
-		unsigned long nr);
+void force_page_cache_ra(struct readahead_control *, unsigned long nr);
 static inline void force_page_cache_readahead(struct address_space *mapping,
 		struct file *file, pgoff_t index, unsigned long nr_to_read)
 {
-	DEFINE_READAHEAD(ractl, file, mapping, index);
-	force_page_cache_ra(&ractl, &file->f_ra, nr_to_read);
+	DEFINE_READAHEAD(ractl, file, &file->f_ra, mapping, index);
+	force_page_cache_ra(&ractl, nr_to_read);
 }
 
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
diff --git a/mm/readahead.c b/mm/readahead.c
index 4446dada0bc2..e115b1174981 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -272,9 +272,10 @@ void do_page_cache_ra(struct readahead_control *ractl,
  * memory at once.
  */
 void force_page_cache_ra(struct readahead_control *ractl,
-		struct file_ra_state *ra, unsigned long nr_to_read)
+		unsigned long nr_to_read)
 {
 	struct address_space *mapping = ractl->mapping;
+	struct file_ra_state *ra = ractl->ra;
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	unsigned long max_pages, index;
 
@@ -433,10 +434,10 @@ static int try_context_readahead(struct address_space *mapping,
  * A minimal readahead algorithm for trivial sequential/random reads.
  */
 static void ondemand_readahead(struct readahead_control *ractl,
-		struct file_ra_state *ra, bool hit_readahead_marker,
-		unsigned long req_size)
+		bool hit_readahead_marker, unsigned long req_size)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(ractl->mapping->host);
+	struct file_ra_state *ra = ractl->ra;
 	unsigned long max_pages = ra->ra_pages;
 	unsigned long add_pages;
 	unsigned long index = readahead_index(ractl);
@@ -550,7 +551,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 }
 
 void page_cache_sync_ra(struct readahead_control *ractl,
-		struct file_ra_state *ra, unsigned long req_count)
+		unsigned long req_count)
 {
 	bool do_forced_ra = ractl->file && (ractl->file->f_mode & FMODE_RANDOM);
 
@@ -560,7 +561,7 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 	 * read-ahead will do the right thing and limit the read to just the
 	 * requested range, which we'll set to 1 page for this case.
 	 */
-	if (!ra->ra_pages || blk_cgroup_congested()) {
+	if (!ractl->ra->ra_pages || blk_cgroup_congested()) {
 		if (!ractl->file)
 			return;
 		req_count = 1;
@@ -569,21 +570,20 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 
 	/* be dumb */
 	if (do_forced_ra) {
-		force_page_cache_ra(ractl, ra, req_count);
+		force_page_cache_ra(ractl, req_count);
 		return;
 	}
 
 	/* do read-ahead */
-	ondemand_readahead(ractl, ra, false, req_count);
+	ondemand_readahead(ractl, false, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_sync_ra);
 
 void page_cache_async_ra(struct readahead_control *ractl,
-		struct file_ra_state *ra, struct page *page,
-		unsigned long req_count)
+		struct page *page, unsigned long req_count)
 {
 	/* no read-ahead */
-	if (!ra->ra_pages)
+	if (!ractl->ra->ra_pages)
 		return;
 
 	/*
@@ -604,7 +604,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
 		return;
 
 	/* do read-ahead */
-	ondemand_readahead(ractl, ra, true, req_count);
+	ondemand_readahead(ractl, true, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_async_ra);
 
-- 
2.30.2

