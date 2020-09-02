Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF54625AFBD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIBPpA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:45:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27177 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728110AbgIBPow (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599061490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CuGXxadKsVJrnI33TmIgfuMt1tBEdqBVzVHBekaxae8=;
        b=LzfEj/JNdA1Vy1T+EUBoxbcSA5m81fi1sEuXY7qXyKrlxqSXeBeno3CXZTC/VZB8Dg8bDn
        w6llmVsZABIVcjcs7N/8WJPFOcWmyicMsiZ1ZBoE59QekbqtrNUuC5UKrlbHUMWunN0wE5
        O3HlsIS0o4Wo05YPVPu0ztdnKlQo2z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-RsjFokBQMwqjHeFshtGa5A-1; Wed, 02 Sep 2020 11:44:49 -0400
X-MC-Unique: RsjFokBQMwqjHeFshtGa5A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08E58801AE2;
        Wed,  2 Sep 2020 15:44:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-6.rdu2.redhat.com [10.10.113.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11A5A1002D6C;
        Wed,  2 Sep 2020 15:44:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 4/6] mm: Pass readahead_control into
 page_cache_{sync,async}_readahead() [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Sep 2020 16:44:45 +0100
Message-ID: <159906148519.663183.14012026331551396649.stgit@warthog.procyon.org.uk>
In-Reply-To: <159906145700.663183.3678164182141075453.stgit@warthog.procyon.org.uk>
References: <159906145700.663183.3678164182141075453.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass struct readahead_control into the page_cache_{sync,async}_readahead()
functions in preparation for making do_sync_mmap_readahead() pass down an
RAC struct.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/btrfs/free-space-cache.c |    4 +++-
 fs/btrfs/ioctl.c            |    9 ++++++---
 fs/btrfs/relocation.c       |   10 ++++++----
 fs/btrfs/send.c             |   16 ++++++++++------
 fs/ext4/dir.c               |   11 ++++++-----
 fs/f2fs/dir.c               |    8 ++++++--
 include/linux/pagemap.h     |    7 +++----
 mm/filemap.c                |   26 ++++++++++++++------------
 mm/khugepaged.c             |    4 ++--
 mm/readahead.c              |   34 +++++++++++++---------------------
 10 files changed, 69 insertions(+), 60 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index dc82fd0c80cb..c64af32453b6 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -288,6 +288,8 @@ static void readahead_cache(struct inode *inode)
 	struct file_ra_state *ra;
 	unsigned long last_index;
 
+	DEFINE_READAHEAD(rac, NULL, inode->i_mapping, 0);
+
 	ra = kzalloc(sizeof(*ra), GFP_NOFS);
 	if (!ra)
 		return;
@@ -295,7 +297,7 @@ static void readahead_cache(struct inode *inode)
 	file_ra_state_init(ra, inode->i_mapping);
 	last_index = (i_size_read(inode) - 1) >> PAGE_SHIFT;
 
-	page_cache_sync_readahead(inode->i_mapping, ra, NULL, 0, last_index);
+	page_cache_sync_readahead(&rac, ra, last_index);
 
 	kfree(ra);
 }
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index bd3511c5ca81..9f9321f20615 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1428,6 +1428,8 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 	struct page **pages = NULL;
 	bool do_compress = range->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
 
+	DEFINE_READAHEAD(rac, file, inode->i_mapping, 0);
+
 	if (isize == 0)
 		return 0;
 
@@ -1534,9 +1536,10 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 
 		if (i + cluster > ra_index) {
 			ra_index = max(i, ra_index);
-			if (ra)
-				page_cache_sync_readahead(inode->i_mapping, ra,
-						file, ra_index, cluster);
+			if (ra) {
+				rac._index = ra_index;
+				page_cache_sync_readahead(&rac, ra, cluster);
+			}
 			ra_index += cluster;
 		}
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4ba1ab9cc76d..3d21aeaaa762 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2684,6 +2684,8 @@ static int relocate_file_extent_cluster(struct inode *inode,
 	int nr = 0;
 	int ret = 0;
 
+	DEFINE_READAHEAD(rac, NULL, inode->i_mapping, 0);
+
 	if (!cluster->nr)
 		return 0;
 
@@ -2712,8 +2714,8 @@ static int relocate_file_extent_cluster(struct inode *inode,
 
 		page = find_lock_page(inode->i_mapping, index);
 		if (!page) {
-			page_cache_sync_readahead(inode->i_mapping,
-						  ra, NULL, index,
+			rac._index = index;
+			page_cache_sync_readahead(&rac, ra,
 						  last_index + 1 - index);
 			page = find_or_create_page(inode->i_mapping, index,
 						   mask);
@@ -2728,8 +2730,8 @@ static int relocate_file_extent_cluster(struct inode *inode,
 		}
 
 		if (PageReadahead(page)) {
-			page_cache_async_readahead(inode->i_mapping,
-						   ra, NULL, page, index,
+			rac._index = index;
+			page_cache_async_readahead(&rac, ra, page,
 						   last_index + 1 - index);
 		}
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d9813a5b075a..f41391fc4230 100644
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
+
 		page = find_lock_page(inode->i_mapping, index);
 		if (!page) {
-			page_cache_sync_readahead(inode->i_mapping, &sctx->ra,
-				NULL, index, last_index + 1 - index);
+			page_cache_sync_readahead(&rac, &sctx->ra,
+				last_index + 1 - index);
 
 			page = find_or_create_page(inode->i_mapping, index,
 					GFP_KERNEL);
@@ -4847,10 +4852,9 @@ static ssize_t fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
 			}
 		}
 
-		if (PageReadahead(page)) {
-			page_cache_async_readahead(inode->i_mapping, &sctx->ra,
-				NULL, page, index, last_index + 1 - index);
-		}
+		if (PageReadahead(page))
+			page_cache_async_readahead(&rac, &sctx->ra, page,
+				last_index + 1 - index);
 
 		if (!PageUptodate(page)) {
 			btrfs_readpage(NULL, page);
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 1d82336b1cd4..9fca0de50e0f 100644
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
@@ -176,11 +178,10 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
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
+				page_cache_sync_readahead(&rac, &file->f_ra, 1);
+			}
 			file->f_ra.prev_pos = (loff_t)index << PAGE_SHIFT;
 			bh = ext4_bread(NULL, inode, map.m_lblk, 0);
 			if (IS_ERR(bh)) {
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 069f498af1e3..69a316e7808d 100644
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
+		if (npages - n > 1 && !ra_has_index(ra, n)) {
+			rac._index = n;
+			page_cache_sync_readahead(&rac, ra,
 				min(npages - n, (pgoff_t)MAX_DIR_RA_PAGES));
+		}
 
 		dentry_page = f2fs_find_data_page(inode, n);
 		if (IS_ERR(dentry_page)) {
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8bf048a76c43..3c362ddfeb4d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -769,11 +769,10 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 
 #define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
 
-void page_cache_sync_readahead(struct address_space *, struct file_ra_state *,
-		struct file *, pgoff_t index, unsigned long req_count);
-void page_cache_async_readahead(struct address_space *, struct file_ra_state *,
-		struct file *, struct page *, pgoff_t index,
+void page_cache_sync_readahead(struct readahead_control *, struct file_ra_state *,
 		unsigned long req_count);
+void page_cache_async_readahead(struct readahead_control *, struct file_ra_state *,
+		struct page *, unsigned long req_count);
 void page_cache_readahead_unbounded(struct readahead_control *,
 		unsigned long nr_to_read, unsigned long lookahead_count);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 82b97cf4306c..fdfeedd1eb71 100644
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
@@ -2097,9 +2099,8 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		if (!page) {
 			if (iocb->ki_flags & IOCB_NOIO)
 				goto would_block;
-			page_cache_sync_readahead(mapping,
-					ra, filp,
-					index, last_index - index);
+			rac._index = index;
+			page_cache_sync_readahead(&rac, ra, last_index - index);
 			page = find_get_page(mapping, index);
 			if (unlikely(page == NULL))
 				goto no_cached_page;
@@ -2109,9 +2110,9 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 				put_page(page);
 				goto out;
 			}
-			page_cache_async_readahead(mapping,
-					ra, filp, thp_head(page),
-					index, last_index - index);
+			rac._index = index;
+			page_cache_async_readahead(&rac, ra, thp_head(page),
+					last_index - index);
 		}
 		if (!PageUptodate(page)) {
 			/*
@@ -2469,6 +2470,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	pgoff_t offset = vmf->pgoff;
 	unsigned int mmap_miss;
 
+	DEFINE_READAHEAD(rac, file, mapping, offset);
+
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ)
 		return fpin;
@@ -2477,8 +2480,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 
 	if (vmf->vma->vm_flags & VM_SEQ_READ) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-		page_cache_sync_readahead(mapping, ra, file, offset,
-					  ra->ra_pages);
+		page_cache_sync_readahead(&rac, ra, ra->ra_pages);
 		return fpin;
 	}
 
@@ -2515,10 +2517,10 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
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
@@ -2528,8 +2530,8 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 		WRITE_ONCE(ra->mmap_miss, --mmap_miss);
 	if (PageReadahead(thp_head(page))) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-		page_cache_async_readahead(mapping, ra, file,
-				thp_head(page), offset, ra->ra_pages);
+		page_cache_async_readahead(&rac, ra, thp_head(page),
+				ra->ra_pages);
 	}
 	return fpin;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f2d243077b74..84305574b36d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1703,9 +1703,9 @@ static void collapse_file(struct mm_struct *mm,
 			}
 		} else {	/* !is_shmem */
 			if (!page || xa_is_value(page)) {
+				DEFINE_READAHEAD(rac, file, mapping, index);
 				xas_unlock_irq(&xas);
-				page_cache_sync_readahead(mapping, &file->f_ra,
-							  file, index,
+				page_cache_sync_readahead(&rac, &file->f_ra,
 							  end - index);
 				/* drain pagevecs to help isolate_lru_page() */
 				lru_add_drain();
diff --git a/mm/readahead.c b/mm/readahead.c
index 366357e6e845..d8e3e59e4c46 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -633,10 +633,8 @@ static void ondemand_readahead(struct readahead_control *rac,
 
 /**
  * page_cache_sync_readahead - generic file readahead
- * @mapping: address_space which holds the pagecache and I/O vectors
+ * @rac: Readahead control.
  * @ra: file_ra_state which holds the readahead state
- * @filp: passed on to ->readpage() and ->readpages()
- * @index: Index of first page to be read.
  * @req_count: Total number of pages being read by the caller.
  *
  * page_cache_sync_readahead() should be called when a cache miss happened:
@@ -644,12 +642,10 @@ static void ondemand_readahead(struct readahead_control *rac,
  * pages onto the read request if access patterns suggest it will improve
  * performance.
  */
-void page_cache_sync_readahead(struct address_space *mapping,
-			       struct file_ra_state *ra, struct file *filp,
-			       pgoff_t index, unsigned long req_count)
+void page_cache_sync_readahead(struct readahead_control *rac,
+			       struct file_ra_state *ra,
+			       unsigned long req_count)
 {
-	DEFINE_READAHEAD(rac, filp, mapping, index);
-
 	/* no read-ahead */
 	if (!ra->ra_pages)
 		return;
@@ -658,23 +654,21 @@ void page_cache_sync_readahead(struct address_space *mapping,
 		return;
 
 	/* be dumb */
-	if (filp && (filp->f_mode & FMODE_RANDOM)) {
-		force_page_cache_readahead(&rac, req_count);
+	if (rac->file && (rac->file->f_mode & FMODE_RANDOM)) {
+		force_page_cache_readahead(rac, req_count);
 		return;
 	}
 
 	/* do read-ahead */
-	ondemand_readahead(&rac, ra, NULL, req_count);
+	ondemand_readahead(rac, ra, NULL, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_sync_readahead);
 
 /**
  * page_cache_async_readahead - file readahead for marked pages
- * @mapping: address_space which holds the pagecache and I/O vectors
+ * @rac: Readahead control.
  * @ra: file_ra_state which holds the readahead state
- * @filp: passed on to ->readpage() and ->readpages()
  * @page: The page at @index which triggered the readahead call.
- * @index: Index of first page to be read.
  * @req_count: Total number of pages being read by the caller.
  *
  * page_cache_async_readahead() should be called when a page is used which
@@ -683,13 +677,11 @@ EXPORT_SYMBOL_GPL(page_cache_sync_readahead);
  * more pages.
  */
 void
-page_cache_async_readahead(struct address_space *mapping,
-			   struct file_ra_state *ra, struct file *filp,
-			   struct page *page, pgoff_t index,
+page_cache_async_readahead(struct readahead_control *rac,
+			   struct file_ra_state *ra,
+			   struct page *page,
 			   unsigned long req_count)
 {
-	DEFINE_READAHEAD(rac, filp, mapping, index);
-
 	/* No Read-ahead */
 	if (!ra->ra_pages)
 		return;
@@ -705,14 +697,14 @@ page_cache_async_readahead(struct address_space *mapping,
 	/*
 	 * Defer asynchronous read-ahead on IO congestion.
 	 */
-	if (inode_read_congested(mapping->host))
+	if (inode_read_congested(rac->mapping->host))
 		return;
 
 	if (blk_cgroup_congested())
 		return;
 
 	/* do read-ahead */
-	ondemand_readahead(&rac, ra, page, req_count);
+	ondemand_readahead(rac, ra, page, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_async_readahead);
 


