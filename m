Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF37B25989B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 18:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbgIAQ24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 12:28:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27555 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732081AbgIAQ2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598977730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rma8EEYokNJyj7U2S+lyQcYfQd/6lZ6gn4LjeXLRtak=;
        b=NKtjb0BK5t19TBYkUcg+Nfng5nsjQWjnzirBn6Jk/z5AhB0APn+9+jtRF05r/Ci626yqQw
        NQpYtfE4w4QctpCwJ9IjQQqAkhKTcq6/gTKdM0VTlxTIF6RVMHb5ulVGoGGqt8+LOiKIGJ
        lTvs0xusUE5rnhhGtKTaA/oVWcKu/YA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-ON2iMVIQMum_xgurU1Ybdw-1; Tue, 01 Sep 2020 12:28:48 -0400
X-MC-Unique: ON2iMVIQMum_xgurU1Ybdw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E89211DDF3;
        Tue,  1 Sep 2020 16:28:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-231.rdu2.redhat.com [10.10.113.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF2945C22D;
        Tue,  1 Sep 2020 16:28:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 4/7] mm: Pass readahead_control into
 page_cache_{sync,async}_readahead()
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 01 Sep 2020 17:28:44 +0100
Message-ID: <159897772488.405783.17347371323944662006.stgit@warthog.procyon.org.uk>
In-Reply-To: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
References: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass struct readahead_control into the page_cache_{sync,async}_readahead()
functions in preparation for making do_sync_mmap_readahead() pass down an
RAC struct.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/btrfs/free-space-cache.c |    7 ++++---
 fs/btrfs/ioctl.c            |   10 +++++++---
 fs/btrfs/relocation.c       |   14 ++++++++------
 fs/btrfs/send.c             |   15 +++++++++------
 fs/ext4/dir.c               |   12 +++++++-----
 fs/f2fs/dir.c               |   10 +++++++---
 include/linux/pagemap.h     |    8 +++-----
 mm/filemap.c                |   27 +++++++++++++++------------
 mm/khugepaged.c             |    6 +++---
 mm/readahead.c              |   40 ++++++++++++----------------------------
 10 files changed, 75 insertions(+), 74 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index dc82fd0c80cb..0ca9361acf30 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -286,16 +286,17 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 static void readahead_cache(struct inode *inode)
 {
 	struct file_ra_state *ra;
-	unsigned long last_index;
+
+	DEFINE_READAHEAD(rac, NULL, inode->i_mapping, 0);
 
 	ra = kzalloc(sizeof(*ra), GFP_NOFS);
 	if (!ra)
 		return;
 
 	file_ra_state_init(ra, inode->i_mapping);
-	last_index = (i_size_read(inode) - 1) >> PAGE_SHIFT;
+	rac._nr_pages = (i_size_read(inode) - 1) >> PAGE_SHIFT;
 
-	page_cache_sync_readahead(inode->i_mapping, ra, NULL, 0, last_index);
+	page_cache_sync_readahead(&rac, ra);
 
 	kfree(ra);
 }
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index bd3511c5ca81..5025a6a800e9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1428,6 +1428,8 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 	struct page **pages = NULL;
 	bool do_compress = range->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
 
+	DEFINE_READAHEAD(rac, file, inode->i_mapping, 0);
+
 	if (isize == 0)
 		return 0;
 
@@ -1534,9 +1536,11 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 
 		if (i + cluster > ra_index) {
 			ra_index = max(i, ra_index);
-			if (ra)
-				page_cache_sync_readahead(inode->i_mapping, ra,
-						file, ra_index, cluster);
+			if (ra) {
+				rac._index = ra_index;
+				rac._nr_pages = cluster;
+				page_cache_sync_readahead(&rac, ra);
+			}
 			ra_index += cluster;
 		}
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4ba1ab9cc76d..1979803fd475 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2684,6 +2684,8 @@ static int relocate_file_extent_cluster(struct inode *inode,
 	int nr = 0;
 	int ret = 0;
 
+	DEFINE_READAHEAD(rac, NULL, inode->i_mapping, 0);
+
 	if (!cluster->nr)
 		return 0;
 
@@ -2712,9 +2714,9 @@ static int relocate_file_extent_cluster(struct inode *inode,
 
 		page = find_lock_page(inode->i_mapping, index);
 		if (!page) {
-			page_cache_sync_readahead(inode->i_mapping,
-						  ra, NULL, index,
-						  last_index + 1 - index);
+			rac._index = index;
+			rac._nr_pages = last_index + 1 - index;
+			page_cache_sync_readahead(&rac, ra);
 			page = find_or_create_page(inode->i_mapping, index,
 						   mask);
 			if (!page) {
@@ -2728,9 +2730,9 @@ static int relocate_file_extent_cluster(struct inode *inode,
 		}
 
 		if (PageReadahead(page)) {
-			page_cache_async_readahead(inode->i_mapping,
-						   ra, NULL, page, index,
-						   last_index + 1 - index);
+			rac._index = index;
+			rac._nr_pages = last_index + 1 - index;
+			page_cache_async_readahead(&rac, ra, page);
 		}
 
 		if (!PageUptodate(page)) {
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d9813a5b075a..ee0a9a2b5d08 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4811,6 +4811,8 @@ static ssize_t fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
 	unsigned pg_offset = offset_in_page(offset);
 	ssize_t ret = 0;
 
+	DEFINE_READAHEAD(rac, NULL, NULL, 0);
+
 	inode = btrfs_iget(fs_info->sb, sctx->cur_ino, root);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
@@ -4829,15 +4831,18 @@ static ssize_t fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
 	/* initial readahead */
 	memset(&sctx->ra, 0, sizeof(struct file_ra_state));
 	file_ra_state_init(&sctx->ra, inode->i_mapping);
+	rac.mapping = inode->i_mapping;
 
 	while (index <= last_index) {
 		unsigned cur_len = min_t(unsigned, len,
 					 PAGE_SIZE - pg_offset);
 
+		rac._index = index;
+		rac._nr_pages = last_index + 1 - index;
+
 		page = find_lock_page(inode->i_mapping, index);
 		if (!page) {
-			page_cache_sync_readahead(inode->i_mapping, &sctx->ra,
-				NULL, index, last_index + 1 - index);
+			page_cache_sync_readahead(&rac, &sctx->ra);
 
 			page = find_or_create_page(inode->i_mapping, index,
 					GFP_KERNEL);
@@ -4847,10 +4852,8 @@ static ssize_t fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
 			}
 		}
 
-		if (PageReadahead(page)) {
-			page_cache_async_readahead(inode->i_mapping, &sctx->ra,
-				NULL, page, index, last_index + 1 - index);
-		}
+		if (PageReadahead(page))
+			page_cache_async_readahead(&rac, &sctx->ra, page);
 
 		if (!PageUptodate(page)) {
 			btrfs_readpage(NULL, page);
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 1d82336b1cd4..6205c6830454 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -118,6 +118,8 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 	struct buffer_head *bh = NULL;
 	struct fscrypt_str fstr = FSTR_INIT(NULL, 0);
 
+	DEFINE_READAHEAD(rac, file, sb->s_bdev->bd_inode->i_mapping, 0);
+
 	if (IS_ENCRYPTED(inode)) {
 		err = fscrypt_get_encryption_info(inode);
 		if (err)
@@ -176,11 +178,11 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 		if (err > 0) {
 			pgoff_t index = map.m_pblk >>
 					(PAGE_SHIFT - inode->i_blkbits);
-			if (!ra_has_index(&file->f_ra, index))
-				page_cache_sync_readahead(
-					sb->s_bdev->bd_inode->i_mapping,
-					&file->f_ra, file,
-					index, 1);
+			if (!ra_has_index(&file->f_ra, index)) {
+				rac._index = index;
+				rac._nr_pages = 1;
+				page_cache_sync_readahead(&rac, &file->f_ra);
+			}
 			file->f_ra.prev_pos = (loff_t)index << PAGE_SHIFT;
 			bh = ext4_bread(NULL, inode, map.m_lblk, 0);
 			if (IS_ERR(bh)) {
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 069f498af1e3..982f6d37454a 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -1027,6 +1027,8 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 	struct fscrypt_str fstr = FSTR_INIT(NULL, 0);
 	int err = 0;
 
+	DEFINE_READAHEAD(rac, file, inode->i_mapping, 0);
+
 	if (IS_ENCRYPTED(inode)) {
 		err = fscrypt_get_encryption_info(inode);
 		if (err)
@@ -1052,9 +1054,11 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 		cond_resched();
 
 		/* readahead for multi pages of dir */
-		if (npages - n > 1 && !ra_has_index(ra, n))
-			page_cache_sync_readahead(inode->i_mapping, ra, file, n,
-				min(npages - n, (pgoff_t)MAX_DIR_RA_PAGES));
+		if (npages - n > 1 && !ra_has_index(ra, n)) {
+			rac._index = n;
+			rac._nr_pages = min(npages - n, (pgoff_t)MAX_DIR_RA_PAGES);
+			page_cache_sync_readahead(&rac, ra);
+		}
 
 		dentry_page = f2fs_find_data_page(inode, n);
 		if (IS_ERR(dentry_page)) {
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8bf048a76c43..cd7bde29d4cc 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -769,11 +769,9 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 
 #define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
 
-void page_cache_sync_readahead(struct address_space *, struct file_ra_state *,
-		struct file *, pgoff_t index, unsigned long req_count);
-void page_cache_async_readahead(struct address_space *, struct file_ra_state *,
-		struct file *, struct page *, pgoff_t index,
-		unsigned long req_count);
+void page_cache_sync_readahead(struct readahead_control *, struct file_ra_state *);
+void page_cache_async_readahead(struct readahead_control *, struct file_ra_state *,
+				struct page *);
 void page_cache_readahead_unbounded(struct readahead_control *,
 		unsigned long nr_to_read, unsigned long lookahead_count);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 82b97cf4306c..9f2f99db7318 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2070,6 +2070,8 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	unsigned int prev_offset;
 	int error = 0;
 
+	DEFINE_READAHEAD(rac, filp, mapping, 0);
+
 	if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
 		return 0;
 	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
@@ -2097,9 +2099,9 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		if (!page) {
 			if (iocb->ki_flags & IOCB_NOIO)
 				goto would_block;
-			page_cache_sync_readahead(mapping,
-					ra, filp,
-					index, last_index - index);
+			rac._index = index;
+			rac._nr_pages = last_index - index;
+			page_cache_sync_readahead(&rac, ra);
 			page = find_get_page(mapping, index);
 			if (unlikely(page == NULL))
 				goto no_cached_page;
@@ -2109,9 +2111,9 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 				put_page(page);
 				goto out;
 			}
-			page_cache_async_readahead(mapping,
-					ra, filp, thp_head(page),
-					index, last_index - index);
+			rac._index = index;
+			rac._nr_pages = last_index - index;
+			page_cache_async_readahead(&rac, ra, thp_head(page));
 		}
 		if (!PageUptodate(page)) {
 			/*
@@ -2469,6 +2471,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	pgoff_t offset = vmf->pgoff;
 	unsigned int mmap_miss;
 
+	DEFINE_READAHEAD(rac, file, mapping, offset);
+
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ)
 		return fpin;
@@ -2477,8 +2481,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 
 	if (vmf->vma->vm_flags & VM_SEQ_READ) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-		page_cache_sync_readahead(mapping, ra, file, offset,
-					  ra->ra_pages);
+		rac._nr_pages = ra->ra_pages;
+		page_cache_sync_readahead(&rac, ra);
 		return fpin;
 	}
 
@@ -2515,10 +2519,10 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 {
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
-	struct address_space *mapping = file->f_mapping;
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
-	pgoff_t offset = vmf->pgoff;
+
+	DEFINE_READAHEAD(rac, file, file->f_mapping, vmf->pgoff);
 
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
@@ -2528,8 +2532,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 		WRITE_ONCE(ra->mmap_miss, --mmap_miss);
 	if (PageReadahead(thp_head(page))) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-		page_cache_async_readahead(mapping, ra, file,
-				thp_head(page), offset, ra->ra_pages);
+		page_cache_async_readahead(&rac, ra, thp_head(page));
 	}
 	return fpin;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f2d243077b74..0bece7ab0ce7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1703,10 +1703,10 @@ static void collapse_file(struct mm_struct *mm,
 			}
 		} else {	/* !is_shmem */
 			if (!page || xa_is_value(page)) {
+				DEFINE_READAHEAD(rac, file, mapping, index);
+				rac._nr_pages = end - index;
 				xas_unlock_irq(&xas);
-				page_cache_sync_readahead(mapping, &file->f_ra,
-							  file, index,
-							  end - index);
+				page_cache_sync_readahead(&rac, &file->f_ra);
 				/* drain pagevecs to help isolate_lru_page() */
 				lru_add_drain();
 				page = find_lock_page(mapping, index);
diff --git a/mm/readahead.c b/mm/readahead.c
index e557c6d5a183..7114246b4e41 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -635,24 +635,17 @@ static void ondemand_readahead(struct readahead_control *rac,
 
 /**
  * page_cache_sync_readahead - generic file readahead
- * @mapping: address_space which holds the pagecache and I/O vectors
+ * @rac: Readahead control.
  * @ra: file_ra_state which holds the readahead state
- * @filp: passed on to ->readpage() and ->readpages()
- * @index: Index of first page to be read.
- * @req_count: Total number of pages being read by the caller.
  *
  * page_cache_sync_readahead() should be called when a cache miss happened:
  * it will submit the read.  The readahead logic may decide to piggyback more
  * pages onto the read request if access patterns suggest it will improve
  * performance.
  */
-void page_cache_sync_readahead(struct address_space *mapping,
-			       struct file_ra_state *ra, struct file *filp,
-			       pgoff_t index, unsigned long req_count)
+void page_cache_sync_readahead(struct readahead_control *rac,
+			       struct file_ra_state *ra)
 {
-	DEFINE_READAHEAD(rac, filp, mapping, index);
-	rac._nr_pages = req_count;
-
 	/* no read-ahead */
 	if (!ra->ra_pages)
 		return;
@@ -661,39 +654,30 @@ void page_cache_sync_readahead(struct address_space *mapping,
 		return;
 
 	/* be dumb */
-	if (filp && (filp->f_mode & FMODE_RANDOM)) {
-		force_page_cache_readahead(&rac);
+	if (rac->file && (rac->file->f_mode & FMODE_RANDOM)) {
+		force_page_cache_readahead(rac);
 		return;
 	}
 
 	/* do read-ahead */
-	ondemand_readahead(&rac, ra, NULL);
+	ondemand_readahead(rac, ra, NULL);
 }
 EXPORT_SYMBOL_GPL(page_cache_sync_readahead);
 
 /**
  * page_cache_async_readahead - file readahead for marked pages
- * @mapping: address_space which holds the pagecache and I/O vectors
+ * @rac: Readahead control.
  * @ra: file_ra_state which holds the readahead state
- * @filp: passed on to ->readpage() and ->readpages()
- * @page: The page at @index which triggered the readahead call.
- * @index: Index of first page to be read.
- * @req_count: Total number of pages being read by the caller.
  *
  * page_cache_async_readahead() should be called when a page is used which
  * is marked as PageReadahead; this is a marker to suggest that the application
  * has used up enough of the readahead window that we should start pulling in
  * more pages.
  */
-void
-page_cache_async_readahead(struct address_space *mapping,
-			   struct file_ra_state *ra, struct file *filp,
-			   struct page *page, pgoff_t index,
-			   unsigned long req_count)
+void page_cache_async_readahead(struct readahead_control *rac,
+				struct file_ra_state *ra,
+				struct page *page)
 {
-	DEFINE_READAHEAD(rac, filp, mapping, index);
-	rac._nr_pages = req_count;
-
 	/* No Read-ahead */
 	if (!ra->ra_pages)
 		return;
@@ -709,14 +693,14 @@ page_cache_async_readahead(struct address_space *mapping,
 	/*
 	 * Defer asynchronous read-ahead on IO congestion.
 	 */
-	if (inode_read_congested(mapping->host))
+	if (inode_read_congested(rac->mapping->host))
 		return;
 
 	if (blk_cgroup_congested())
 		return;
 
 	/* do read-ahead */
-	ondemand_readahead(&rac, ra, page);
+	ondemand_readahead(rac, ra, page);
 }
 EXPORT_SYMBOL_GPL(page_cache_async_readahead);
 


