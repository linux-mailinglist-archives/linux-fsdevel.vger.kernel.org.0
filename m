Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB243F9794
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 11:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245175AbhH0Jqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 05:46:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245076AbhH0JpX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630057474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gt3cNpgnPnlnGTHhbBV3QVTTqpuF38OZnnwBo6/e2Z4=;
        b=MN1I8rfH9ksh9qu24lWYHosN6yqOnz+C34/8awgbN9US5HjKAdd1Qi5oT/VBIzW4a/EfrG
        UXP66hywkJr05aaXt5cVPpHCD/zaCa5rz50tfydiG5/d2+vjpoFrrWjNpcjthg7eIyUtS1
        HcJIuGxQeQ3oW0u/j9v2+NdXp9b6ST0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-xHajqhRZMGO4nCwQ6vi3Tw-1; Fri, 27 Aug 2021 05:44:32 -0400
X-MC-Unique: xHajqhRZMGO4nCwQ6vi3Tw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82E4C94EE1;
        Fri, 27 Aug 2021 09:44:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11992100AE35;
        Fri, 27 Aug 2021 09:44:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 6/6] afs: Use folios in directory handling
From:   David Howells <dhowells@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, dhowells@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Aug 2021 10:44:22 +0100
Message-ID: <163005746215.2472992.8321380998443828308.stgit@warthog.procyon.org.uk>
In-Reply-To: <163005740700.2472992.12365214290752300378.stgit@warthog.procyon.org.uk>
References: <163005740700.2472992.12365214290752300378.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the AFS directory handling code to use folios.

With these changes, afs passes -g quick xfstests.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: linux-afs@lists.infradead.org
cc: ceph-devel@vger.kernel.org
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/162877312172.3085614.992850861791211206.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/162981154845.1901565.2078707403143240098.stgit@warthog.procyon.org.uk/
---

 fs/afs/dir.c      |  229 ++++++++++++++++++++++-------------------------------
 fs/afs/dir_edit.c |  154 ++++++++++++++++++------------------
 2 files changed, 174 insertions(+), 209 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 78719f2f567e..0c2e83311242 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -103,13 +103,13 @@ struct afs_lookup_cookie {
 };
 
 /*
- * Drop the refs that we're holding on the pages we were reading into.  We've
+ * Drop the refs that we're holding on the folios we were reading into.  We've
  * got refs on the first nr_pages pages.
  */
 static void afs_dir_read_cleanup(struct afs_read *req)
 {
 	struct address_space *mapping = req->vnode->vfs_inode.i_mapping;
-	struct page *page;
+	struct folio *folio;
 	pgoff_t last = req->nr_pages - 1;
 
 	XA_STATE(xas, &mapping->i_pages, 0);
@@ -118,65 +118,56 @@ static void afs_dir_read_cleanup(struct afs_read *req)
 		return;
 
 	rcu_read_lock();
-	xas_for_each(&xas, page, last) {
-		if (xas_retry(&xas, page))
+	xas_for_each(&xas, folio, last) {
+		if (xas_retry(&xas, folio))
 			continue;
-		BUG_ON(xa_is_value(page));
-		BUG_ON(PageCompound(page));
-		ASSERTCMP(page->mapping, ==, mapping);
+		BUG_ON(xa_is_value(folio));
+		ASSERTCMP(folio_file_mapping(folio), ==, mapping);
 
-		put_page(page);
+		folio_put(folio);
 	}
 
 	rcu_read_unlock();
 }
 
 /*
- * check that a directory page is valid
+ * check that a directory folio is valid
  */
-static bool afs_dir_check_page(struct afs_vnode *dvnode, struct page *page,
-			       loff_t i_size)
+static bool afs_dir_check_folio(struct afs_vnode *dvnode, struct folio *folio,
+				loff_t i_size)
 {
-	struct afs_xdr_dir_page *dbuf;
-	loff_t latter, off;
-	int tmp, qty;
+	union afs_xdr_dir_block *block;
+	size_t offset, size;
+	loff_t pos;
 
-	/* Determine how many magic numbers there should be in this page, but
+	/* Determine how many magic numbers there should be in this folio, but
 	 * we must take care because the directory may change size under us.
 	 */
-	off = page_offset(page);
-	if (i_size <= off)
+	pos = folio_pos(folio);
+	if (i_size <= pos)
 		goto checked;
 
-	latter = i_size - off;
-	if (latter >= PAGE_SIZE)
-		qty = PAGE_SIZE;
-	else
-		qty = latter;
-	qty /= sizeof(union afs_xdr_dir_block);
-
-	/* check them */
-	dbuf = kmap_atomic(page);
-	for (tmp = 0; tmp < qty; tmp++) {
-		if (dbuf->blocks[tmp].hdr.magic != AFS_DIR_MAGIC) {
-			printk("kAFS: %s(%lx): bad magic %d/%d is %04hx\n",
-			       __func__, dvnode->vfs_inode.i_ino, tmp, qty,
-			       ntohs(dbuf->blocks[tmp].hdr.magic));
-			trace_afs_dir_check_failed(dvnode, off, i_size);
-			kunmap(page);
+	size = min_t(loff_t, folio_size(folio), i_size - pos);
+	for (offset = 0; offset < size; offset += sizeof(*block)) {
+		block = kmap_local_folio(folio, offset);
+		if (block->hdr.magic != AFS_DIR_MAGIC) {
+			printk("kAFS: %s(%lx): [%llx] bad magic %zx/%zx is %04hx\n",
+			       __func__, dvnode->vfs_inode.i_ino,
+			       pos, offset, size, ntohs(block->hdr.magic));
+			trace_afs_dir_check_failed(dvnode, pos + offset, i_size);
+			kunmap_local(block);
 			trace_afs_file_error(dvnode, -EIO, afs_file_error_dir_bad_magic);
 			goto error;
 		}
 
 		/* Make sure each block is NUL terminated so we can reasonably
-		 * use string functions on it.  The filenames in the page
+		 * use string functions on it.  The filenames in the folio
 		 * *should* be NUL-terminated anyway.
 		 */
-		((u8 *)&dbuf->blocks[tmp])[AFS_DIR_BLOCK_SIZE - 1] = 0;
-	}
-
-	kunmap_atomic(dbuf);
+		((u8 *)block)[AFS_DIR_BLOCK_SIZE - 1] = 0;
 
+		kunmap_local(block);
+	}
 checked:
 	afs_stat_v(dvnode, n_read_dir);
 	return true;
@@ -190,11 +181,11 @@ static bool afs_dir_check_page(struct afs_vnode *dvnode, struct page *page,
  */
 static void afs_dir_dump(struct afs_vnode *dvnode, struct afs_read *req)
 {
-	struct afs_xdr_dir_page *dbuf;
+	union afs_xdr_dir_block *block;
 	struct address_space *mapping = dvnode->vfs_inode.i_mapping;
-	struct page *page;
-	unsigned int i, qty = PAGE_SIZE / sizeof(union afs_xdr_dir_block);
+	struct folio *folio;
 	pgoff_t last = req->nr_pages - 1;
+	size_t offset, size;
 
 	XA_STATE(xas, &mapping->i_pages, 0);
 
@@ -205,30 +196,28 @@ static void afs_dir_dump(struct afs_vnode *dvnode, struct afs_read *req)
 		req->pos, req->nr_pages,
 		req->iter->iov_offset,  iov_iter_count(req->iter));
 
-	xas_for_each(&xas, page, last) {
-		if (xas_retry(&xas, page))
+	xas_for_each(&xas, folio, last) {
+		if (xas_retry(&xas, folio))
 			continue;
 
-		BUG_ON(PageCompound(page));
-		BUG_ON(page->mapping != mapping);
-
-		dbuf = kmap_atomic(page);
-		for (i = 0; i < qty; i++) {
-			union afs_xdr_dir_block *block = &dbuf->blocks[i];
+		BUG_ON(folio_file_mapping(folio) != mapping);
 
-			pr_warn("[%02lx] %32phN\n", page->index * qty + i, block);
+		size = min_t(loff_t, folio_size(folio), req->actual_len - folio_pos(folio));
+		for (offset = 0; offset < size; offset += sizeof(*block)) {
+			block = kmap_local_folio(folio, offset);
+			pr_warn("[%02lx] %32phN\n", folio_index(folio) + offset, block);
+			kunmap_local(block);
 		}
-		kunmap_atomic(dbuf);
 	}
 }
 
 /*
- * Check all the pages in a directory.  All the pages are held pinned.
+ * Check all the blocks in a directory.  All the folios are held pinned.
  */
 static int afs_dir_check(struct afs_vnode *dvnode, struct afs_read *req)
 {
 	struct address_space *mapping = dvnode->vfs_inode.i_mapping;
-	struct page *page;
+	struct folio *folio;
 	pgoff_t last = req->nr_pages - 1;
 	int ret = 0;
 
@@ -238,14 +227,13 @@ static int afs_dir_check(struct afs_vnode *dvnode, struct afs_read *req)
 		return 0;
 
 	rcu_read_lock();
-	xas_for_each(&xas, page, last) {
-		if (xas_retry(&xas, page))
+	xas_for_each(&xas, folio, last) {
+		if (xas_retry(&xas, folio))
 			continue;
 
-		BUG_ON(PageCompound(page));
-		BUG_ON(page->mapping != mapping);
+		BUG_ON(folio_file_mapping(folio) != mapping);
 
-		if (!afs_dir_check_page(dvnode, page, req->file_size)) {
+		if (!afs_dir_check_folio(dvnode, folio, req->actual_len)) {
 			afs_dir_dump(dvnode, req);
 			ret = -EIO;
 			break;
@@ -274,15 +262,16 @@ static int afs_dir_open(struct inode *inode, struct file *file)
 
 /*
  * Read the directory into the pagecache in one go, scrubbing the previous
- * contents.  The list of pages is returned, pinning them so that they don't
+ * contents.  The list of folios is returned, pinning them so that they don't
  * get reclaimed during the iteration.
  */
 static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 	__acquires(&dvnode->validate_lock)
 {
+	struct address_space *mapping = dvnode->vfs_inode.i_mapping;
 	struct afs_read *req;
 	loff_t i_size;
-	int nr_pages, i, n;
+	int nr_pages, i;
 	int ret;
 
 	_enter("");
@@ -320,43 +309,30 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 	req->iter = &req->def_iter;
 
 	/* Fill in any gaps that we might find where the memory reclaimer has
-	 * been at work and pin all the pages.  If there are any gaps, we will
+	 * been at work and pin all the folios.  If there are any gaps, we will
 	 * need to reread the entire directory contents.
 	 */
 	i = req->nr_pages;
 	while (i < nr_pages) {
-		struct page *pages[8], *page;
-
-		n = find_get_pages_contig(dvnode->vfs_inode.i_mapping, i,
-					  min_t(unsigned int, nr_pages - i,
-						ARRAY_SIZE(pages)),
-					  pages);
-		_debug("find %u at %u/%u", n, i, nr_pages);
-
-		if (n == 0) {
-			gfp_t gfp = dvnode->vfs_inode.i_mapping->gfp_mask;
+		struct folio *folio;
 
+		folio = filemap_get_folio(mapping, i);
+		if (!folio) {
 			if (test_and_clear_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
 				afs_stat_v(dvnode, n_inval);
 
 			ret = -ENOMEM;
-			page = __page_cache_alloc(gfp);
-			if (!page)
+			folio = __filemap_get_folio(mapping,
+						    i, FGP_LOCK | FGP_CREAT,
+						    mapping->gfp_mask);
+			if (!folio)
 				goto error;
-			ret = add_to_page_cache_lru(page,
-						    dvnode->vfs_inode.i_mapping,
-						    i, gfp);
-			if (ret < 0)
-				goto error;
-
-			attach_page_private(page, (void *)1);
-			unlock_page(page);
-			req->nr_pages++;
-			i++;
-		} else {
-			req->nr_pages += n;
-			i += n;
+			folio_attach_private(folio, (void *)1);
+			folio_unlock(folio);
 		}
+
+		req->nr_pages += folio_nr_pages(folio);
+		i += folio_nr_pages(folio);
 	}
 
 	/* If we're going to reload, we need to lock all the pages to prevent
@@ -424,7 +400,7 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 	size_t nlen;
 	int tmp;
 
-	_enter("%u,%x,%p,,",(unsigned)ctx->pos,blkoff,block);
+	_enter("%llx,%x", ctx->pos, blkoff);
 
 	curr = (ctx->pos - blkoff) / sizeof(union afs_xdr_dirent);
 
@@ -513,12 +489,10 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 			   struct key *key, afs_dataversion_t *_dir_version)
 {
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
-	struct afs_xdr_dir_page *dbuf;
 	union afs_xdr_dir_block *dblock;
 	struct afs_read *req;
-	struct page *page;
-	unsigned blkoff, limit;
-	void __rcu **slot;
+	struct folio *folio;
+	unsigned offset, size;
 	int ret;
 
 	_enter("{%lu},%u,,", dir->i_ino, (unsigned)ctx->pos);
@@ -540,43 +514,30 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 	/* walk through the blocks in sequence */
 	ret = 0;
 	while (ctx->pos < req->actual_len) {
-		blkoff = ctx->pos & ~(sizeof(union afs_xdr_dir_block) - 1);
-
-		/* Fetch the appropriate page from the directory and re-add it
+		/* Fetch the appropriate folio from the directory and re-add it
 		 * to the LRU.  We have all the pages pinned with an extra ref.
 		 */
-		rcu_read_lock();
-		page = NULL;
-		slot = radix_tree_lookup_slot(&dvnode->vfs_inode.i_mapping->i_pages,
-					      blkoff / PAGE_SIZE);
-		if (slot)
-			page = radix_tree_deref_slot(slot);
-		rcu_read_unlock();
-		if (!page) {
+		folio = __filemap_get_folio(dir->i_mapping, ctx->pos / PAGE_SIZE,
+					    FGP_ACCESSED, 0);
+		if (!folio) {
 			ret = afs_bad(dvnode, afs_file_error_dir_missing_page);
 			break;
 		}
-		mark_page_accessed(page);
 
-		limit = blkoff & ~(PAGE_SIZE - 1);
+		offset = round_down(ctx->pos, sizeof(*dblock)) - folio_file_pos(folio);
+		size = min_t(loff_t, folio_size(folio),
+			     req->actual_len - folio_file_pos(folio));
 
-		dbuf = kmap(page);
-
-		/* deal with the individual blocks stashed on this page */
 		do {
-			dblock = &dbuf->blocks[(blkoff % PAGE_SIZE) /
-					       sizeof(union afs_xdr_dir_block)];
-			ret = afs_dir_iterate_block(dvnode, ctx, dblock, blkoff);
-			if (ret != 1) {
-				kunmap(page);
+			dblock = kmap_local_folio(folio, offset);
+			ret = afs_dir_iterate_block(dvnode, ctx, dblock,
+						    folio_file_pos(folio) + offset);
+			kunmap_local(dblock);
+			if (ret != 1)
 				goto out;
-			}
 
-			blkoff += sizeof(union afs_xdr_dir_block);
+		} while (offset += sizeof(*dblock), offset < size);
 
-		} while (ctx->pos < dir->i_size && blkoff < limit);
-
-		kunmap(page);
 		ret = 0;
 	}
 
@@ -2056,42 +2017,42 @@ static int afs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 }
 
 /*
- * Release a directory page and clean up its private state if it's not busy
- * - return true if the page can now be released, false if not
+ * Release a directory folio and clean up its private state if it's not busy
+ * - return true if the folio can now be released, false if not
  */
-static int afs_dir_releasepage(struct page *page, gfp_t gfp_flags)
+static int afs_dir_releasepage(struct page *subpage, gfp_t gfp_flags)
 {
-	struct afs_vnode *dvnode = AFS_FS_I(page->mapping->host);
+	struct folio *folio = page_folio(subpage);
+	struct afs_vnode *dvnode = AFS_FS_I(folio_inode(folio));
 
-	_enter("{{%llx:%llu}[%lu]}", dvnode->fid.vid, dvnode->fid.vnode, page->index);
+	_enter("{{%llx:%llu}[%lu]}", dvnode->fid.vid, dvnode->fid.vnode, folio_index(folio));
 
-	detach_page_private(page);
+	folio_detach_private(folio);
 
 	/* The directory will need reloading. */
 	if (test_and_clear_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
 		afs_stat_v(dvnode, n_relpg);
-	return 1;
+	return true;
 }
 
 /*
- * invalidate part or all of a page
- * - release a page and clean up its private data if offset is 0 (indicating
- *   the entire page)
+ * Invalidate part or all of a folio.
  */
-static void afs_dir_invalidatepage(struct page *page, unsigned int offset,
+static void afs_dir_invalidatepage(struct page *subpage, unsigned int offset,
 				   unsigned int length)
 {
-	struct afs_vnode *dvnode = AFS_FS_I(page->mapping->host);
+	struct folio *folio = page_folio(subpage);
+	struct afs_vnode *dvnode = AFS_FS_I(folio_inode(folio));
 
-	_enter("{%lu},%u,%u", page->index, offset, length);
+	_enter("{%lu},%u,%u", folio_index(folio), offset, length);
 
-	BUG_ON(!PageLocked(page));
+	BUG_ON(!folio_test_locked(folio));
 
 	/* The directory will need reloading. */
 	if (test_and_clear_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
 		afs_stat_v(dvnode, n_inval);
 
-	/* we clean up only if the entire page is being invalidated */
-	if (offset == 0 && length == thp_size(page))
-		detach_page_private(page);
+	/* we clean up only if the entire folio is being invalidated */
+	if (offset == 0 && length == folio_size(folio))
+		folio_detach_private(folio);
 }
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index f4600c1353ad..5a9098a82830 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -104,6 +104,25 @@ static void afs_clear_contig_bits(union afs_xdr_dir_block *block,
 	block->hdr.bitmap[7] &= ~(u8)(mask >> 7 * 8);
 }
 
+/*
+ * Get a new directory folio.
+ */
+static struct folio *afs_dir_get_folio(struct afs_vnode *vnode, pgoff_t index)
+{
+	struct address_space *mapping = vnode->vfs_inode.i_mapping;
+	struct folio *folio;
+
+	folio = __filemap_get_folio(mapping, index,
+				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+				    mapping->gfp_mask);
+	if (!folio)
+		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	else if (folio && !folio_test_private(folio))
+		folio_attach_private(folio, (void *)1);
+	    
+	return folio;
+}
+
 /*
  * Scan a directory block looking for a dirent of the right name.
  */
@@ -188,13 +207,11 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 		      enum afs_edit_dir_reason why)
 {
 	union afs_xdr_dir_block *meta, *block;
-	struct afs_xdr_dir_page *meta_page, *dir_page;
 	union afs_xdr_dirent *de;
-	struct page *page0, *page;
+	struct folio *folio0, *folio;
 	unsigned int need_slots, nr_blocks, b;
 	pgoff_t index;
 	loff_t i_size;
-	gfp_t gfp;
 	int slot;
 
 	_enter(",,{%d,%s},", name->len, name->name);
@@ -206,10 +223,8 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 		return;
 	}
 
-	gfp = vnode->vfs_inode.i_mapping->gfp_mask;
-	page0 = find_or_create_page(vnode->vfs_inode.i_mapping, 0, gfp);
-	if (!page0) {
-		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	folio0 = afs_dir_get_folio(vnode, 0);
+	if (!folio0) {
 		_leave(" [fgp]");
 		return;
 	}
@@ -217,42 +232,35 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	/* Work out how many slots we're going to need. */
 	need_slots = afs_dir_calc_slots(name->len);
 
-	meta_page = kmap(page0);
-	meta = &meta_page->blocks[0];
+	meta = kmap_local_folio(folio0, 0);
 	if (i_size == 0)
 		goto new_directory;
 	nr_blocks = i_size / AFS_DIR_BLOCK_SIZE;
 
-	/* Find a block that has sufficient slots available.  Each VM page
+	/* Find a block that has sufficient slots available.  Each folio
 	 * contains two or more directory blocks.
 	 */
 	for (b = 0; b < nr_blocks + 1; b++) {
-		/* If the directory extended into a new page, then we need to
-		 * tack a new page on the end.
+		/* If the directory extended into a new folio, then we need to
+		 * tack a new folio on the end.
 		 */
 		index = b / AFS_DIR_BLOCKS_PER_PAGE;
-		if (index == 0) {
-			page = page0;
-			dir_page = meta_page;
-		} else {
-			if (nr_blocks >= AFS_DIR_MAX_BLOCKS)
-				goto error;
-			gfp = vnode->vfs_inode.i_mapping->gfp_mask;
-			page = find_or_create_page(vnode->vfs_inode.i_mapping,
-						   index, gfp);
-			if (!page)
+		if (nr_blocks >= AFS_DIR_MAX_BLOCKS)
+			goto error;
+		if (index >= folio_nr_pages(folio0)) {
+			folio = afs_dir_get_folio(vnode, index);
+			if (!folio)
 				goto error;
-			if (!PagePrivate(page))
-				attach_page_private(page, (void *)1);
-			dir_page = kmap(page);
+		} else {
+			folio = folio0;
 		}
 
+		block = kmap_local_folio(folio, b * AFS_DIR_BLOCK_SIZE - folio_file_pos(folio));
+
 		/* Abandon the edit if we got a callback break. */
 		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
 			goto invalidated;
 
-		block = &dir_page->blocks[b % AFS_DIR_BLOCKS_PER_PAGE];
-
 		_debug("block %u: %2u %3u %u",
 		       b,
 		       (b < AFS_DIR_BLOCKS_WITH_CTR) ? meta->meta.alloc_ctrs[b] : 99,
@@ -266,7 +274,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 			i_size_write(&vnode->vfs_inode, (b + 1) * AFS_DIR_BLOCK_SIZE);
 		}
 
-		/* Only lower dir pages have a counter in the header. */
+		/* Only lower dir blocks have a counter in the header. */
 		if (b >= AFS_DIR_BLOCKS_WITH_CTR ||
 		    meta->meta.alloc_ctrs[b] >= need_slots) {
 			/* We need to try and find one or more consecutive
@@ -279,10 +287,10 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 			}
 		}
 
-		if (page != page0) {
-			unlock_page(page);
-			kunmap(page);
-			put_page(page);
+		kunmap_local(block);
+		if (folio != folio0) {
+			folio_unlock(folio);
+			folio_put(folio);
 		}
 	}
 
@@ -298,8 +306,8 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	i_size = AFS_DIR_BLOCK_SIZE;
 	i_size_write(&vnode->vfs_inode, i_size);
 	slot = AFS_DIR_RESV_BLOCKS0;
-	page = page0;
-	block = meta;
+	folio = folio0;
+	block = kmap_local_folio(folio, 0);
 	nr_blocks = 1;
 	b = 0;
 
@@ -318,10 +326,10 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 
 	/* Adjust the bitmap. */
 	afs_set_contig_bits(block, slot, need_slots);
-	if (page != page0) {
-		unlock_page(page);
-		kunmap(page);
-		put_page(page);
+	kunmap_local(block);
+	if (folio != folio0) {
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 
 	/* Adjust the allocation counter. */
@@ -333,18 +341,19 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	_debug("Insert %s in %u[%u]", name->name, b, slot);
 
 out_unmap:
-	unlock_page(page0);
-	kunmap(page0);
-	put_page(page0);
+	kunmap_local(meta);
+	folio_unlock(folio0);
+	folio_put(folio0);
 	_leave("");
 	return;
 
 invalidated:
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_create_inval, 0, 0, 0, 0, name->name);
 	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
-	if (page != page0) {
-		kunmap(page);
-		put_page(page);
+	kunmap_local(block);
+	if (folio != folio0) {
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 	goto out_unmap;
 
@@ -364,10 +373,9 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 void afs_edit_dir_remove(struct afs_vnode *vnode,
 			 struct qstr *name, enum afs_edit_dir_reason why)
 {
-	struct afs_xdr_dir_page *meta_page, *dir_page;
 	union afs_xdr_dir_block *meta, *block;
 	union afs_xdr_dirent *de;
-	struct page *page0, *page;
+	struct folio *folio0, *folio;
 	unsigned int need_slots, nr_blocks, b;
 	pgoff_t index;
 	loff_t i_size;
@@ -384,9 +392,8 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	}
 	nr_blocks = i_size / AFS_DIR_BLOCK_SIZE;
 
-	page0 = find_lock_page(vnode->vfs_inode.i_mapping, 0);
-	if (!page0) {
-		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	folio0 = afs_dir_get_folio(vnode, 0);
+	if (!folio0) {
 		_leave(" [fgp]");
 		return;
 	}
@@ -394,30 +401,27 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	/* Work out how many slots we're going to discard. */
 	need_slots = afs_dir_calc_slots(name->len);
 
-	meta_page = kmap(page0);
-	meta = &meta_page->blocks[0];
+	meta = kmap_local_folio(folio0, 0);
 
-	/* Find a page that has sufficient slots available.  Each VM page
+	/* Find a block that has sufficient slots available.  Each folio
 	 * contains two or more directory blocks.
 	 */
 	for (b = 0; b < nr_blocks; b++) {
 		index = b / AFS_DIR_BLOCKS_PER_PAGE;
-		if (index != 0) {
-			page = find_lock_page(vnode->vfs_inode.i_mapping, index);
-			if (!page)
+		if (index >= folio_nr_pages(folio0)) {
+			folio = afs_dir_get_folio(vnode, index);
+			if (!folio)
 				goto error;
-			dir_page = kmap(page);
 		} else {
-			page = page0;
-			dir_page = meta_page;
+			folio = folio0;
 		}
 
+		block = kmap_local_folio(folio, b * AFS_DIR_BLOCK_SIZE - folio_file_pos(folio));
+
 		/* Abandon the edit if we got a callback break. */
 		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
 			goto invalidated;
 
-		block = &dir_page->blocks[b % AFS_DIR_BLOCKS_PER_PAGE];
-
 		if (b > AFS_DIR_BLOCKS_WITH_CTR ||
 		    meta->meta.alloc_ctrs[b] <= AFS_DIR_SLOTS_PER_BLOCK - 1 - need_slots) {
 			slot = afs_dir_scan_block(block, name, b);
@@ -425,10 +429,10 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 				goto found_dirent;
 		}
 
-		if (page != page0) {
-			unlock_page(page);
-			kunmap(page);
-			put_page(page);
+		kunmap_local(block);
+		if (folio != folio0) {
+			folio_unlock(folio);
+			folio_put(folio);
 		}
 	}
 
@@ -449,10 +453,10 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 
 	/* Adjust the bitmap. */
 	afs_clear_contig_bits(block, slot, need_slots);
-	if (page != page0) {
-		unlock_page(page);
-		kunmap(page);
-		put_page(page);
+	kunmap_local(block);
+	if (folio != folio0) {
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 
 	/* Adjust the allocation counter. */
@@ -464,9 +468,9 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	_debug("Remove %s from %u[%u]", name->name, b, slot);
 
 out_unmap:
-	unlock_page(page0);
-	kunmap(page0);
-	put_page(page0);
+	kunmap_local(meta);
+	folio_unlock(folio0);
+	folio_put(folio0);
 	_leave("");
 	return;
 
@@ -474,10 +478,10 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_delete_inval,
 			   0, 0, 0, 0, name->name);
 	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
-	if (page != page0) {
-		unlock_page(page);
-		kunmap(page);
-		put_page(page);
+	kunmap_local(block);
+	if (folio != folio0) {
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 	goto out_unmap;
 


