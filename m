Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E093E9A34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 23:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhHKVGE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 17:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232066AbhHKVGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 17:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628715939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BrHRK/FUpDhszOEBFoeDn9JhiKTGUZBl2z4nmJkUiS4=;
        b=fgiTedc8/D/g3RiDe0SxYlkES+eNDulO4sKZsiPO9E4ckQqfeHX2RV2n+6AZfGgZU8tqQo
        K50nlYMf+UO6SecuHfLizXPZ0W8e1RpiyKFDNLrXSfjKNbJ7ClFpebcHt/xEQ0O0kj6JTG
        ZlYOQXMJrI5zHuqzycbP2Ev4z3aA1H4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-qK74ZvOTM-K1REVlUcnmLQ-1; Wed, 11 Aug 2021 17:05:35 -0400
X-MC-Unique: qK74ZvOTM-K1REVlUcnmLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECC0D871803;
        Wed, 11 Aug 2021 21:05:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24F125C232;
        Wed, 11 Aug 2021 21:05:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2408234.1628687271@warthog.procyon.org.uk>
References: <2408234.1628687271@warthog.procyon.org.uk>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
cc:     dhowells@redhat.com
cc:     Jeff Layton <jlayton@kernel.org>
cc:     Marc Dionne <marc.dionne@auristor.com>
cc:     Ilya Dryomov <idryomov@gmail.com>
cc:     linux-afs@lists.infradead.org
cc:     ceph-devel@vger.kernel.org
cc:     linux-cachefs@redhat.com
cc:     linux-kernel@vger.kernel.org
cc:     linux-mm@kvack.org
cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] afs: Use folios in directory handling
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2620309.1628715927.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 11 Aug 2021 22:05:27 +0100
Message-ID: <2620310.1628715927@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the AFS directory handling code to use folios.

Notes:

 (*) Is it permissible to hold two concurrent kmap_local_folio() mappings
     on the same folio?

 (*) When modifying an AFS directory, I cache a local copy of it and edit
     it locally according to the prescribed rules rather than downloading
     it again.  If I need to grow the directory, is it better to discard
     all of the constituent pages and redownload so as to be able to have =
a
     better chance of packing the content into larger folios?

With these changes, afs passes -g quick xfstests.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
---
 fs/afs/dir.c      |  229 ++++++++++++++++++++++--------------------------=
------
 fs/afs/dir_edit.c |  154 ++++++++++++++++++------------------
 2 files changed, 174 insertions(+), 209 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 78719f2f567e..db5bc874bf0b 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -103,13 +103,13 @@ struct afs_lookup_cookie {
 };
 =

 /*
- * Drop the refs that we're holding on the pages we were reading into.  W=
e've
+ * Drop the refs that we're holding on the folios we were reading into.  =
We've
  * got refs on the first nr_pages pages.
  */
 static void afs_dir_read_cleanup(struct afs_read *req)
 {
 	struct address_space *mapping =3D req->vnode->vfs_inode.i_mapping;
-	struct page *page;
+	struct folio *folio;
 	pgoff_t last =3D req->nr_pages - 1;
 =

 	XA_STATE(xas, &mapping->i_pages, 0);
@@ -118,65 +118,56 @@ static void afs_dir_read_cleanup(struct afs_read *re=
q)
 		return;
 =

 	rcu_read_lock();
-	xas_for_each(&xas, page, last) {
-		if (xas_retry(&xas, page))
+	xas_for_each(&xas, folio, last) {
+		if (xas_retry(&xas, folio))
 			continue;
-		BUG_ON(xa_is_value(page));
-		BUG_ON(PageCompound(page));
-		ASSERTCMP(page->mapping, =3D=3D, mapping);
+		BUG_ON(xa_is_value(folio));
+		ASSERTCMP(folio_mapping(folio), =3D=3D, mapping);
 =

-		put_page(page);
+		folio_put(folio);
 	}
 =

 	rcu_read_unlock();
 }
 =

 /*
- * check that a directory page is valid
+ * check that a directory folio is valid
  */
-static bool afs_dir_check_page(struct afs_vnode *dvnode, struct page *pag=
e,
-			       loff_t i_size)
+static bool afs_dir_check_folio(struct afs_vnode *dvnode, struct folio *f=
olio,
+				loff_t i_size)
 {
-	struct afs_xdr_dir_page *dbuf;
-	loff_t latter, off;
-	int tmp, qty;
+	union afs_xdr_dir_block *block;
+	size_t offset, size;
+	loff_t pos;
 =

-	/* Determine how many magic numbers there should be in this page, but
+	/* Determine how many magic numbers there should be in this folio, but
 	 * we must take care because the directory may change size under us.
 	 */
-	off =3D page_offset(page);
-	if (i_size <=3D off)
+	pos =3D folio_pos(folio);
+	if (i_size <=3D pos)
 		goto checked;
 =

-	latter =3D i_size - off;
-	if (latter >=3D PAGE_SIZE)
-		qty =3D PAGE_SIZE;
-	else
-		qty =3D latter;
-	qty /=3D sizeof(union afs_xdr_dir_block);
-
-	/* check them */
-	dbuf =3D kmap_atomic(page);
-	for (tmp =3D 0; tmp < qty; tmp++) {
-		if (dbuf->blocks[tmp].hdr.magic !=3D AFS_DIR_MAGIC) {
-			printk("kAFS: %s(%lx): bad magic %d/%d is %04hx\n",
-			       __func__, dvnode->vfs_inode.i_ino, tmp, qty,
-			       ntohs(dbuf->blocks[tmp].hdr.magic));
-			trace_afs_dir_check_failed(dvnode, off, i_size);
-			kunmap(page);
+	size =3D min_t(loff_t, folio_size(folio), i_size - pos);
+	for (offset =3D 0; offset < size; offset +=3D sizeof(*block)) {
+		block =3D kmap_local_folio(folio, offset);
+		if (block->hdr.magic !=3D AFS_DIR_MAGIC) {
+			printk("kAFS: %s(%lx): [%llx] bad magic %zx/%zx is %04hx\n",
+			       __func__, dvnode->vfs_inode.i_ino,
+			       pos, offset, size, ntohs(block->hdr.magic));
+			trace_afs_dir_check_failed(dvnode, pos + offset, i_size);
+			kunmap_local(block);
 			trace_afs_file_error(dvnode, -EIO, afs_file_error_dir_bad_magic);
 			goto error;
 		}
 =

 		/* Make sure each block is NUL terminated so we can reasonably
-		 * use string functions on it.  The filenames in the page
+		 * use string functions on it.  The filenames in the folio
 		 * *should* be NUL-terminated anyway.
 		 */
-		((u8 *)&dbuf->blocks[tmp])[AFS_DIR_BLOCK_SIZE - 1] =3D 0;
-	}
-
-	kunmap_atomic(dbuf);
+		((u8 *)block)[AFS_DIR_BLOCK_SIZE - 1] =3D 0;
 =

+		kunmap_local(block);
+	}
 checked:
 	afs_stat_v(dvnode, n_read_dir);
 	return true;
@@ -190,11 +181,11 @@ static bool afs_dir_check_page(struct afs_vnode *dvn=
ode, struct page *page,
  */
 static void afs_dir_dump(struct afs_vnode *dvnode, struct afs_read *req)
 {
-	struct afs_xdr_dir_page *dbuf;
+	union afs_xdr_dir_block *block;
 	struct address_space *mapping =3D dvnode->vfs_inode.i_mapping;
-	struct page *page;
-	unsigned int i, qty =3D PAGE_SIZE / sizeof(union afs_xdr_dir_block);
+	struct folio *folio;
 	pgoff_t last =3D req->nr_pages - 1;
+	size_t offset, size;
 =

 	XA_STATE(xas, &mapping->i_pages, 0);
 =

@@ -205,30 +196,28 @@ static void afs_dir_dump(struct afs_vnode *dvnode, s=
truct afs_read *req)
 		req->pos, req->nr_pages,
 		req->iter->iov_offset,  iov_iter_count(req->iter));
 =

-	xas_for_each(&xas, page, last) {
-		if (xas_retry(&xas, page))
+	xas_for_each(&xas, folio, last) {
+		if (xas_retry(&xas, folio))
 			continue;
 =

-		BUG_ON(PageCompound(page));
-		BUG_ON(page->mapping !=3D mapping);
-
-		dbuf =3D kmap_atomic(page);
-		for (i =3D 0; i < qty; i++) {
-			union afs_xdr_dir_block *block =3D &dbuf->blocks[i];
+		BUG_ON(folio_mapping(folio) !=3D mapping);
 =

-			pr_warn("[%02lx] %32phN\n", page->index * qty + i, block);
+		size =3D min_t(loff_t, folio_size(folio), req->actual_len - folio_pos(f=
olio));
+		for (offset =3D 0; offset < size; offset +=3D sizeof(*block)) {
+			block =3D kmap_local_folio(folio, offset);
+			pr_warn("[%02lx] %32phN\n", folio_index(folio) + offset, block);
+			kunmap_local(block);
 		}
-		kunmap_atomic(dbuf);
 	}
 }
 =

 /*
- * Check all the pages in a directory.  All the pages are held pinned.
+ * Check all the blocks in a directory.  All the folios are held pinned.
  */
 static int afs_dir_check(struct afs_vnode *dvnode, struct afs_read *req)
 {
 	struct address_space *mapping =3D dvnode->vfs_inode.i_mapping;
-	struct page *page;
+	struct folio *folio;
 	pgoff_t last =3D req->nr_pages - 1;
 	int ret =3D 0;
 =

@@ -238,14 +227,13 @@ static int afs_dir_check(struct afs_vnode *dvnode, s=
truct afs_read *req)
 		return 0;
 =

 	rcu_read_lock();
-	xas_for_each(&xas, page, last) {
-		if (xas_retry(&xas, page))
+	xas_for_each(&xas, folio, last) {
+		if (xas_retry(&xas, folio))
 			continue;
 =

-		BUG_ON(PageCompound(page));
-		BUG_ON(page->mapping !=3D mapping);
+		BUG_ON(folio_mapping(folio) !=3D mapping);
 =

-		if (!afs_dir_check_page(dvnode, page, req->file_size)) {
+		if (!afs_dir_check_folio(dvnode, folio, req->actual_len)) {
 			afs_dir_dump(dvnode, req);
 			ret =3D -EIO;
 			break;
@@ -274,15 +262,16 @@ static int afs_dir_open(struct inode *inode, struct =
file *file)
 =

 /*
  * Read the directory into the pagecache in one go, scrubbing the previou=
s
- * contents.  The list of pages is returned, pinning them so that they do=
n't
+ * contents.  The list of folios is returned, pinning them so that they d=
on't
  * get reclaimed during the iteration.
  */
 static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key=
 *key)
 	__acquires(&dvnode->validate_lock)
 {
+	struct address_space *mapping =3D dvnode->vfs_inode.i_mapping;
 	struct afs_read *req;
 	loff_t i_size;
-	int nr_pages, i, n;
+	int nr_pages, i;
 	int ret;
 =

 	_enter("");
@@ -320,43 +309,30 @@ static struct afs_read *afs_read_dir(struct afs_vnod=
e *dvnode, struct key *key)
 	req->iter =3D &req->def_iter;
 =

 	/* Fill in any gaps that we might find where the memory reclaimer has
-	 * been at work and pin all the pages.  If there are any gaps, we will
+	 * been at work and pin all the folios.  If there are any gaps, we will
 	 * need to reread the entire directory contents.
 	 */
 	i =3D req->nr_pages;
 	while (i < nr_pages) {
-		struct page *pages[8], *page;
-
-		n =3D find_get_pages_contig(dvnode->vfs_inode.i_mapping, i,
-					  min_t(unsigned int, nr_pages - i,
-						ARRAY_SIZE(pages)),
-					  pages);
-		_debug("find %u at %u/%u", n, i, nr_pages);
-
-		if (n =3D=3D 0) {
-			gfp_t gfp =3D dvnode->vfs_inode.i_mapping->gfp_mask;
+		struct folio *folio;
 =

+		folio =3D filemap_get_folio(mapping, i);
+		if (!folio) {
 			if (test_and_clear_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
 				afs_stat_v(dvnode, n_inval);
 =

 			ret =3D -ENOMEM;
-			page =3D __page_cache_alloc(gfp);
-			if (!page)
+			folio =3D __filemap_get_folio(mapping,
+						    i, FGP_LOCK | FGP_CREAT,
+						    mapping->gfp_mask);
+			if (!folio)
 				goto error;
-			ret =3D add_to_page_cache_lru(page,
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
-			req->nr_pages +=3D n;
-			i +=3D n;
+			folio_attach_private(folio, (void *)1);
+			folio_unlock(folio);
 		}
+
+		req->nr_pages +=3D folio_nr_pages(folio);
+		i +=3D folio_nr_pages(folio);
 	}
 =

 	/* If we're going to reload, we need to lock all the pages to prevent
@@ -424,7 +400,7 @@ static int afs_dir_iterate_block(struct afs_vnode *dvn=
ode,
 	size_t nlen;
 	int tmp;
 =

-	_enter("%u,%x,%p,,",(unsigned)ctx->pos,blkoff,block);
+	_enter("%llx,%x", ctx->pos, blkoff);
 =

 	curr =3D (ctx->pos - blkoff) / sizeof(union afs_xdr_dirent);
 =

@@ -513,12 +489,10 @@ static int afs_dir_iterate(struct inode *dir, struct=
 dir_context *ctx,
 			   struct key *key, afs_dataversion_t *_dir_version)
 {
 	struct afs_vnode *dvnode =3D AFS_FS_I(dir);
-	struct afs_xdr_dir_page *dbuf;
 	union afs_xdr_dir_block *dblock;
 	struct afs_read *req;
-	struct page *page;
-	unsigned blkoff, limit;
-	void __rcu **slot;
+	struct folio *folio;
+	unsigned offset, size;
 	int ret;
 =

 	_enter("{%lu},%u,,", dir->i_ino, (unsigned)ctx->pos);
@@ -540,43 +514,30 @@ static int afs_dir_iterate(struct inode *dir, struct=
 dir_context *ctx,
 	/* walk through the blocks in sequence */
 	ret =3D 0;
 	while (ctx->pos < req->actual_len) {
-		blkoff =3D ctx->pos & ~(sizeof(union afs_xdr_dir_block) - 1);
-
-		/* Fetch the appropriate page from the directory and re-add it
+		/* Fetch the appropriate folio from the directory and re-add it
 		 * to the LRU.  We have all the pages pinned with an extra ref.
 		 */
-		rcu_read_lock();
-		page =3D NULL;
-		slot =3D radix_tree_lookup_slot(&dvnode->vfs_inode.i_mapping->i_pages,
-					      blkoff / PAGE_SIZE);
-		if (slot)
-			page =3D radix_tree_deref_slot(slot);
-		rcu_read_unlock();
-		if (!page) {
+		folio =3D __filemap_get_folio(dir->i_mapping, ctx->pos / PAGE_SIZE,
+					    FGP_ACCESSED, 0);
+		if (!folio) {
 			ret =3D afs_bad(dvnode, afs_file_error_dir_missing_page);
 			break;
 		}
-		mark_page_accessed(page);
 =

-		limit =3D blkoff & ~(PAGE_SIZE - 1);
+		offset =3D round_down(ctx->pos, sizeof(*dblock)) - folio_file_pos(folio=
);
+		size =3D min_t(loff_t, folio_size(folio),
+			     req->actual_len - folio_file_pos(folio));
 =

-		dbuf =3D kmap(page);
-
-		/* deal with the individual blocks stashed on this page */
 		do {
-			dblock =3D &dbuf->blocks[(blkoff % PAGE_SIZE) /
-					       sizeof(union afs_xdr_dir_block)];
-			ret =3D afs_dir_iterate_block(dvnode, ctx, dblock, blkoff);
-			if (ret !=3D 1) {
-				kunmap(page);
+			dblock =3D kmap_local_folio(folio, offset);
+			ret =3D afs_dir_iterate_block(dvnode, ctx, dblock,
+						    folio_file_pos(folio) + offset);
+			kunmap_local(dblock);
+			if (ret !=3D 1)
 				goto out;
-			}
 =

-			blkoff +=3D sizeof(union afs_xdr_dir_block);
+		} while (offset +=3D sizeof(*dblock), offset < size);
 =

-		} while (ctx->pos < dir->i_size && blkoff < limit);
-
-		kunmap(page);
 		ret =3D 0;
 	}
 =

@@ -2056,42 +2017,42 @@ static int afs_rename(struct user_namespace *mnt_u=
serns, struct inode *old_dir,
 }
 =

 /*
- * Release a directory page and clean up its private state if it's not bu=
sy
- * - return true if the page can now be released, false if not
+ * Release a directory folio and clean up its private state if it's not b=
usy
+ * - return true if the folio can now be released, false if not
  */
-static int afs_dir_releasepage(struct page *page, gfp_t gfp_flags)
+static int afs_dir_releasepage(struct page *subpage, gfp_t gfp_flags)
 {
-	struct afs_vnode *dvnode =3D AFS_FS_I(page->mapping->host);
+	struct folio *folio =3D page_folio(subpage);
+	struct afs_vnode *dvnode =3D AFS_FS_I(folio_mapping(folio)->host);
 =

-	_enter("{{%llx:%llu}[%lu]}", dvnode->fid.vid, dvnode->fid.vnode, page->i=
ndex);
+	_enter("{{%llx:%llu}[%lu]}", dvnode->fid.vid, dvnode->fid.vnode, folio_i=
ndex(folio));
 =

-	detach_page_private(page);
+	folio_detach_private(folio);
 =

 	/* The directory will need reloading. */
 	if (test_and_clear_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
 		afs_stat_v(dvnode, n_relpg);
-	return 1;
+	return true;
 }
 =

 /*
- * invalidate part or all of a page
- * - release a page and clean up its private data if offset is 0 (indicat=
ing
- *   the entire page)
+ * Invalidate part or all of a folio.
  */
-static void afs_dir_invalidatepage(struct page *page, unsigned int offset=
,
+static void afs_dir_invalidatepage(struct page *subpage, unsigned int off=
set,
 				   unsigned int length)
 {
-	struct afs_vnode *dvnode =3D AFS_FS_I(page->mapping->host);
+	struct folio *folio =3D page_folio(subpage);
+	struct afs_vnode *dvnode =3D AFS_FS_I(folio_mapping(folio)->host);
 =

-	_enter("{%lu},%u,%u", page->index, offset, length);
+	_enter("{%lu},%u,%u", folio_index(folio), offset, length);
 =

-	BUG_ON(!PageLocked(page));
+	BUG_ON(!folio_test_locked(folio));
 =

 	/* The directory will need reloading. */
 	if (test_and_clear_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
 		afs_stat_v(dvnode, n_inval);
 =

-	/* we clean up only if the entire page is being invalidated */
-	if (offset =3D=3D 0 && length =3D=3D thp_size(page))
-		detach_page_private(page);
+	/* we clean up only if the entire folio is being invalidated */
+	if (offset =3D=3D 0 && length =3D=3D folio_size(folio))
+		folio_detach_private(folio);
 }
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index f4600c1353ad..5a9098a82830 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -104,6 +104,25 @@ static void afs_clear_contig_bits(union afs_xdr_dir_b=
lock *block,
 	block->hdr.bitmap[7] &=3D ~(u8)(mask >> 7 * 8);
 }
 =

+/*
+ * Get a new directory folio.
+ */
+static struct folio *afs_dir_get_folio(struct afs_vnode *vnode, pgoff_t i=
ndex)
+{
+	struct address_space *mapping =3D vnode->vfs_inode.i_mapping;
+	struct folio *folio;
+
+	folio =3D __filemap_get_folio(mapping, index,
+				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+				    mapping->gfp_mask);
+	if (!folio)
+		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	else if (folio && !folio_test_private(folio))
+		folio_attach_private(folio, (void *)1);
+	    =

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
 =

 	_enter(",,{%d,%s},", name->len, name->name);
@@ -206,10 +223,8 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 		return;
 	}
 =

-	gfp =3D vnode->vfs_inode.i_mapping->gfp_mask;
-	page0 =3D find_or_create_page(vnode->vfs_inode.i_mapping, 0, gfp);
-	if (!page0) {
-		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	folio0 =3D afs_dir_get_folio(vnode, 0);
+	if (!folio0) {
 		_leave(" [fgp]");
 		return;
 	}
@@ -217,42 +232,35 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	/* Work out how many slots we're going to need. */
 	need_slots =3D afs_dir_calc_slots(name->len);
 =

-	meta_page =3D kmap(page0);
-	meta =3D &meta_page->blocks[0];
+	meta =3D kmap_local_folio(folio0, 0);
 	if (i_size =3D=3D 0)
 		goto new_directory;
 	nr_blocks =3D i_size / AFS_DIR_BLOCK_SIZE;
 =

-	/* Find a block that has sufficient slots available.  Each VM page
+	/* Find a block that has sufficient slots available.  Each folio
 	 * contains two or more directory blocks.
 	 */
 	for (b =3D 0; b < nr_blocks + 1; b++) {
-		/* If the directory extended into a new page, then we need to
-		 * tack a new page on the end.
+		/* If the directory extended into a new folio, then we need to
+		 * tack a new folio on the end.
 		 */
 		index =3D b / AFS_DIR_BLOCKS_PER_PAGE;
-		if (index =3D=3D 0) {
-			page =3D page0;
-			dir_page =3D meta_page;
-		} else {
-			if (nr_blocks >=3D AFS_DIR_MAX_BLOCKS)
-				goto error;
-			gfp =3D vnode->vfs_inode.i_mapping->gfp_mask;
-			page =3D find_or_create_page(vnode->vfs_inode.i_mapping,
-						   index, gfp);
-			if (!page)
+		if (nr_blocks >=3D AFS_DIR_MAX_BLOCKS)
+			goto error;
+		if (index >=3D folio_nr_pages(folio0)) {
+			folio =3D afs_dir_get_folio(vnode, index);
+			if (!folio)
 				goto error;
-			if (!PagePrivate(page))
-				attach_page_private(page, (void *)1);
-			dir_page =3D kmap(page);
+		} else {
+			folio =3D folio0;
 		}
 =

+		block =3D kmap_local_folio(folio, b * AFS_DIR_BLOCK_SIZE - folio_file_p=
os(folio));
+
 		/* Abandon the edit if we got a callback break. */
 		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
 			goto invalidated;
 =

-		block =3D &dir_page->blocks[b % AFS_DIR_BLOCKS_PER_PAGE];
-
 		_debug("block %u: %2u %3u %u",
 		       b,
 		       (b < AFS_DIR_BLOCKS_WITH_CTR) ? meta->meta.alloc_ctrs[b] : 99,
@@ -266,7 +274,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 			i_size_write(&vnode->vfs_inode, (b + 1) * AFS_DIR_BLOCK_SIZE);
 		}
 =

-		/* Only lower dir pages have a counter in the header. */
+		/* Only lower dir blocks have a counter in the header. */
 		if (b >=3D AFS_DIR_BLOCKS_WITH_CTR ||
 		    meta->meta.alloc_ctrs[b] >=3D need_slots) {
 			/* We need to try and find one or more consecutive
@@ -279,10 +287,10 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 			}
 		}
 =

-		if (page !=3D page0) {
-			unlock_page(page);
-			kunmap(page);
-			put_page(page);
+		kunmap_local(block);
+		if (folio !=3D folio0) {
+			folio_unlock(folio);
+			folio_put(folio);
 		}
 	}
 =

@@ -298,8 +306,8 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	i_size =3D AFS_DIR_BLOCK_SIZE;
 	i_size_write(&vnode->vfs_inode, i_size);
 	slot =3D AFS_DIR_RESV_BLOCKS0;
-	page =3D page0;
-	block =3D meta;
+	folio =3D folio0;
+	block =3D kmap_local_folio(folio, 0);
 	nr_blocks =3D 1;
 	b =3D 0;
 =

@@ -318,10 +326,10 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 =

 	/* Adjust the bitmap. */
 	afs_set_contig_bits(block, slot, need_slots);
-	if (page !=3D page0) {
-		unlock_page(page);
-		kunmap(page);
-		put_page(page);
+	kunmap_local(block);
+	if (folio !=3D folio0) {
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 =

 	/* Adjust the allocation counter. */
@@ -333,18 +341,19 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 	_debug("Insert %s in %u[%u]", name->name, b, slot);
 =

 out_unmap:
-	unlock_page(page0);
-	kunmap(page0);
-	put_page(page0);
+	kunmap_local(meta);
+	folio_unlock(folio0);
+	folio_put(folio0);
 	_leave("");
 	return;
 =

 invalidated:
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_create_inval, 0, 0, 0, 0, na=
me->name);
 	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
-	if (page !=3D page0) {
-		kunmap(page);
-		put_page(page);
+	kunmap_local(block);
+	if (folio !=3D folio0) {
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 	goto out_unmap;
 =

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
 	nr_blocks =3D i_size / AFS_DIR_BLOCK_SIZE;
 =

-	page0 =3D find_lock_page(vnode->vfs_inode.i_mapping, 0);
-	if (!page0) {
-		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	folio0 =3D afs_dir_get_folio(vnode, 0);
+	if (!folio0) {
 		_leave(" [fgp]");
 		return;
 	}
@@ -394,30 +401,27 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	/* Work out how many slots we're going to discard. */
 	need_slots =3D afs_dir_calc_slots(name->len);
 =

-	meta_page =3D kmap(page0);
-	meta =3D &meta_page->blocks[0];
+	meta =3D kmap_local_folio(folio0, 0);
 =

-	/* Find a page that has sufficient slots available.  Each VM page
+	/* Find a block that has sufficient slots available.  Each folio
 	 * contains two or more directory blocks.
 	 */
 	for (b =3D 0; b < nr_blocks; b++) {
 		index =3D b / AFS_DIR_BLOCKS_PER_PAGE;
-		if (index !=3D 0) {
-			page =3D find_lock_page(vnode->vfs_inode.i_mapping, index);
-			if (!page)
+		if (index >=3D folio_nr_pages(folio0)) {
+			folio =3D afs_dir_get_folio(vnode, index);
+			if (!folio)
 				goto error;
-			dir_page =3D kmap(page);
 		} else {
-			page =3D page0;
-			dir_page =3D meta_page;
+			folio =3D folio0;
 		}
 =

+		block =3D kmap_local_folio(folio, b * AFS_DIR_BLOCK_SIZE - folio_file_p=
os(folio));
+
 		/* Abandon the edit if we got a callback break. */
 		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
 			goto invalidated;
 =

-		block =3D &dir_page->blocks[b % AFS_DIR_BLOCKS_PER_PAGE];
-
 		if (b > AFS_DIR_BLOCKS_WITH_CTR ||
 		    meta->meta.alloc_ctrs[b] <=3D AFS_DIR_SLOTS_PER_BLOCK - 1 - need_sl=
ots) {
 			slot =3D afs_dir_scan_block(block, name, b);
@@ -425,10 +429,10 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 				goto found_dirent;
 		}
 =

-		if (page !=3D page0) {
-			unlock_page(page);
-			kunmap(page);
-			put_page(page);
+		kunmap_local(block);
+		if (folio !=3D folio0) {
+			folio_unlock(folio);
+			folio_put(folio);
 		}
 	}
 =

@@ -449,10 +453,10 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 =

 	/* Adjust the bitmap. */
 	afs_clear_contig_bits(block, slot, need_slots);
-	if (page !=3D page0) {
-		unlock_page(page);
-		kunmap(page);
-		put_page(page);
+	kunmap_local(block);
+	if (folio !=3D folio0) {
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 =

 	/* Adjust the allocation counter. */
@@ -464,9 +468,9 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	_debug("Remove %s from %u[%u]", name->name, b, slot);
 =

 out_unmap:
-	unlock_page(page0);
-	kunmap(page0);
-	put_page(page0);
+	kunmap_local(meta);
+	folio_unlock(folio0);
+	folio_put(folio0);
 	_leave("");
 	return;
 =

@@ -474,10 +478,10 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	trace_afs_edit_dir(vnode, why, afs_edit_dir_delete_inval,
 			   0, 0, 0, 0, name->name);
 	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
-	if (page !=3D page0) {
-		unlock_page(page);
-		kunmap(page);
-		put_page(page);
+	kunmap_local(block);
+	if (folio !=3D folio0) {
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 	goto out_unmap;
 =

