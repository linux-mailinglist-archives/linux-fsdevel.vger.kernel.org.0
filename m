Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C12348775
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 04:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhCYDWp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 23:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhCYDW3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 23:22:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5F0C06174A;
        Wed, 24 Mar 2021 20:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=UUz85A1iuf4oXd78snQ2JiF1rZPcQUK1+UMD+dYaB6E=; b=FF/vQxehaHyii+iNT3J+1d7cZl
        ItUoGwVv5dctvY9n+a6r52fhBk2yhbh6/KcZc0y2stnmaSCNRsopvmFIfebRXQbnrnexTbhEfRvsJ
        ZZ3JnrdUl8gJWlSIM1UipGYBis8CmzWUiPkEotJkyEUL/O3sm9fu1ihB5AjD5s1XJTgEcscQHRQNq
        ffWQWnlXLreVD9PM47i6ozyxyMEi0TZDQh1rsp0fofP6NzZ8Lgea14gxOltXI/zfUg4G530Hf4S5+
        wmlqXE3ggS688fyzUrjhWLIs9jh2RUud0MHZXLHvTiufGghGGXvgImlUsIbMHNs68WoG9UV7JKVul
        KrSUzgpw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lPGZO-00CDsF-Qh; Thu, 25 Mar 2021 03:22:06 +0000
Date:   Thu, 25 Mar 2021 03:22:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>
Subject: [RFC] Convert sysv filesystem to use folios exclusively
Message-ID: <20210325032202.GS1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I decided to see what a filesystem free from struct page would look
like.  I chose sysv more-or-less at random; I wanted a relatively simple
filesystem, but I didn't want a toy.  The advantage of sysv is that the
maintainer is quite interested in folios ;-)

$ git grep page fs/sysv
fs/sysv/dir.c:#include <linux/pagemap.h>
fs/sysv/dir.c:          if (offset_in_page(diter->pos)) {
fs/sysv/inode.c:        .get_link       = page_get_link,
fs/sysv/inode.c:        truncate_inode_pages_final(&inode->i_data);
fs/sysv/itree.c:        block_truncate_page(inode->i_mapping, inode->i_size, get_block);
fs/sysv/itree.c:                truncate_pagecache(inode, inode->i_size);
fs/sysv/itree.c:        .readpage = sysv_read_folio,
fs/sysv/itree.c:        .writepage = sysv_write_folio,
fs/sysv/namei.c:#include <linux/pagemap.h>
fs/sysv/namei.c:        err = page_symlink(inode, symname, l);

I think those are "acceptable" mentions of pages -- offset_in_page()
is related to kmap(), page_get_link and page_symlink are in the VFS (to
be ported separately), and the others are just the names of the functions.

The big change here is the rewrite of directory iteration.
sysv_delete_entry() (and a couple of other functions) needs to recover
'pos' from the in-memory address and the struct page.  Once we move from
pages to folios, we can't realistically ask where the folio is mapped.
So switch to an iterator based approach which keeps the pos, dirent mapped
address and the struct folio together.  It's actually a nice cleanup:
204 insertions(+), 259 deletions(-).  We could be more tricksy and pass
around the pgoff_t instead of the loff_t, but I'm not really interested
in saving 4 bytes on the stack for 32-bit arches.

I don't know if this is really how one would do the conversion.
We could easily say "directories never use folios larger than a page"
and that would make evrything much simpler, but that wasn't the point
of this exercise.

There's probably bugs here; again that wasn't the point.  The direction
here looks sound -- it should be possible to write a filesystem without
the use of struct page in the future.  This patch won't apply to anything
published; it won't even link for me because I just changed a bunch of
random function types in the header files to prototype this work.

I might submit a patch to do the diter conversion anyway, although I
have no clue how to test the sysv filesystem.  Is there a mkfs for Linux?
I assume there's no support in xfstests for it.

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 88e38cd8f5c9..df38f53f1385 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -28,80 +28,85 @@ const struct file_operations sysv_dir_operations = {
 	.fsync		= generic_file_fsync,
 };
 
-static inline void dir_put_page(struct page *page)
+void sysv_diter_end(struct sysv_diter *diter)
 {
-	kunmap(page);
-	put_page(page);
+	if (diter->entry) {
+		kunmap_local(diter->entry);
+		put_folio(diter->folio);
+	}
 }
 
-static int dir_commit_chunk(struct page *page, loff_t pos, unsigned len)
+static int sysv_diter_next(struct inode *dir, struct sysv_diter *diter)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = dir->i_mapping;
+	struct folio *folio = diter->folio;
+	size_t offset;
+
+	if (diter->entry) {
+		diter->pos += sizeof(*diter->entry);
+		if (offset_in_page(diter->pos)) {
+			diter->entry++;
+			return 0;
+		}
+		kunmap_local(diter->entry);
+		offset = offset_in_folio(folio, diter->pos);
+		if (offset != 0)
+			goto map;
+		put_folio(folio);
+	}
+	folio = read_mapping_folio(mapping, diter->pos / PAGE_SIZE, NULL);
+	if (IS_ERR(folio)) {
+		diter->pos = round_up(diter->pos, PAGE_SIZE);
+		diter->entry = NULL;
+		return PTR_ERR(folio);
+	}
+	diter->folio = folio;
+	offset = offset_in_folio(folio, diter->pos);
+
+map:
+	diter->entry = kmap_local_folio(folio, offset);
+	return 0;
+}
+
+static int dir_commit_chunk(struct folio *folio, loff_t pos, unsigned len)
+{
+	struct address_space *mapping = folio->mapping;
 	struct inode *dir = mapping->host;
 	int err = 0;
 
-	block_write_end(NULL, mapping, pos, len, len, page, NULL);
+	block_write_end(NULL, mapping, pos, len, len, folio, NULL);
 	if (pos+len > dir->i_size) {
 		i_size_write(dir, pos+len);
 		mark_inode_dirty(dir);
 	}
 	if (IS_DIRSYNC(dir))
-		err = write_one_page(page);
+		err = write_one_folio(folio);
 	else
-		unlock_page(page);
+		unlock_folio(folio);
 	return err;
 }
 
-static struct page * dir_get_page(struct inode *dir, unsigned long n)
-{
-	struct address_space *mapping = dir->i_mapping;
-	struct page *page = read_mapping_page(mapping, n, NULL);
-	if (!IS_ERR(page))
-		kmap(page);
-	return page;
-}
-
 static int sysv_readdir(struct file *file, struct dir_context *ctx)
 {
-	unsigned long pos = ctx->pos;
-	struct inode *inode = file_inode(file);
-	struct super_block *sb = inode->i_sb;
-	unsigned long npages = dir_pages(inode);
-	unsigned offset;
-	unsigned long n;
-
-	ctx->pos = pos = (pos + SYSV_DIRSIZE-1) & ~(SYSV_DIRSIZE-1);
-	if (pos >= inode->i_size)
-		return 0;
-
-	offset = pos & ~PAGE_MASK;
-	n = pos >> PAGE_SHIFT;
-
-	for ( ; n < npages; n++, offset = 0) {
-		char *kaddr, *limit;
-		struct sysv_dir_entry *de;
-		struct page *page = dir_get_page(inode, n);
-
-		if (IS_ERR(page))
+	struct sysv_diter diter = {
+		.pos = round_up(ctx->pos, SYSV_DIRSIZE),
+	};
+	struct inode *dir = file_inode(file);
+	struct super_block *sb = dir->i_sb;
+
+	ctx->pos = diter.pos;
+	while (diter.pos < dir->i_size) {
+		if (sysv_diter_next(dir, &diter))
 			continue;
-		kaddr = (char *)page_address(page);
-		de = (struct sysv_dir_entry *)(kaddr+offset);
-		limit = kaddr + PAGE_SIZE - SYSV_DIRSIZE;
-		for ( ;(char*)de <= limit; de++, ctx->pos += sizeof(*de)) {
-			char *name = de->name;
-
-			if (!de->inode)
-				continue;
-
-			if (!dir_emit(ctx, name, strnlen(name,SYSV_NAMELEN),
-					fs16_to_cpu(SYSV_SB(sb), de->inode),
-					DT_UNKNOWN)) {
-				dir_put_page(page);
-				return 0;
-			}
-		}
-		dir_put_page(page);
+		if (!diter.entry->inode)
+			continue;
+		if (!dir_emit(ctx, diter.entry->name,
+				strnlen(diter.entry->name, SYSV_NAMELEN),
+				fs16_to_cpu(SYSV_SB(sb), diter.entry->inode),
+				DT_UNKNOWN))
+			break;
 	}
+	sysv_diter_end(&diter);
 	return 0;
 }
 
@@ -117,57 +122,43 @@ static inline int namecompare(int len, int maxlen,
 }
 
 /*
- *	sysv_find_entry()
+ * sysv_find_entry()
  *
  * finds an entry in the specified directory with the wanted name. It
  * returns the cache buffer in which the entry was found, and the entry
- * itself (as a parameter - res_dir). It does NOT read the inode of the
+ * itself. It does NOT read the inode of the
  * entry - you'll have to do that yourself if you want to.
+ *
+ * The diter does *not* need to be initialised before calling this function.
  */
-struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_page)
+int sysv_find_entry(const struct dentry *dentry, struct sysv_diter *diter)
 {
 	const char * name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
 	struct inode * dir = d_inode(dentry->d_parent);
-	unsigned long start, n;
-	unsigned long npages = dir_pages(dir);
-	struct page *page = NULL;
-	struct sysv_dir_entry *de;
-
-	*res_page = NULL;
+	loff_t end = (loff_t)SYSV_I(dir)->i_dir_start_lookup * PAGE_SIZE;
 
-	start = SYSV_I(dir)->i_dir_start_lookup;
-	if (start >= npages)
-		start = 0;
-	n = start;
+	if (end >= dir->i_size)
+		end = 0;
+	diter->pos = end;
+	diter->entry = NULL;
 
 	do {
-		char *kaddr;
-		page = dir_get_page(dir, n);
-		if (!IS_ERR(page)) {
-			kaddr = (char*)page_address(page);
-			de = (struct sysv_dir_entry *) kaddr;
-			kaddr += PAGE_SIZE - SYSV_DIRSIZE;
-			for ( ; (char *) de <= kaddr ; de++) {
-				if (!de->inode)
-					continue;
-				if (namecompare(namelen, SYSV_NAMELEN,
-							name, de->name))
-					goto found;
-			}
-			dir_put_page(page);
-		}
-
-		if (++n >= npages)
-			n = 0;
-	} while (n != start);
+		if (diter->pos >= dir->i_size)
+			diter->pos = 0;
+		if (sysv_diter_next(dir, diter))
+			continue;
+		if (diter->entry->inode &&
+		    namecompare(namelen, SYSV_NAMELEN, name, diter->entry->name))
+			goto found;
+	} while (diter->pos != end);
 
-	return NULL;
+	sysv_diter_end(diter);
+	return -ENOENT;
 
 found:
-	SYSV_I(dir)->i_dir_start_lookup = n;
-	*res_page = page;
-	return de;
+	SYSV_I(dir)->i_dir_start_lookup = diter->pos / PAGE_SIZE;
+	return 0;
 }
 
 int sysv_add_link(struct dentry *dentry, struct inode *inode)
@@ -175,71 +166,53 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 	struct inode *dir = d_inode(dentry->d_parent);
 	const char * name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
-	struct page *page = NULL;
-	struct sysv_dir_entry * de;
-	unsigned long npages = dir_pages(dir);
-	unsigned long n;
-	char *kaddr;
-	loff_t pos;
+	struct sysv_diter diter = { .pos = 0, };
 	int err;
 
 	/* We take care of directory expansion in the same loop */
-	for (n = 0; n <= npages; n++) {
-		page = dir_get_page(dir, n);
-		err = PTR_ERR(page);
-		if (IS_ERR(page))
+	for (;;) {
+		err = sysv_diter_next(dir, &diter);
+		if (err)
 			goto out;
-		kaddr = (char*)page_address(page);
-		de = (struct sysv_dir_entry *)kaddr;
-		kaddr += PAGE_SIZE - SYSV_DIRSIZE;
-		while ((char *)de <= kaddr) {
-			if (!de->inode)
-				goto got_it;
-			err = -EEXIST;
-			if (namecompare(namelen, SYSV_NAMELEN, name, de->name)) 
-				goto out_page;
-			de++;
-		}
-		dir_put_page(page);
+		if (!diter.entry->inode)
+			goto got_it;
+		err = -EEXIST;
+		if (namecompare(namelen, SYSV_NAMELEN, name, diter.entry->name))
+			goto out_end;
 	}
-	BUG();
-	return -EINVAL;
 
 got_it:
-	pos = page_offset(page) +
-			(char*)de - (char*)page_address(page);
-	lock_page(page);
-	err = sysv_prepare_chunk(page, pos, SYSV_DIRSIZE);
+	lock_folio(diter.folio);
+	err = sysv_prepare_chunk(diter.folio, diter.pos, SYSV_DIRSIZE);
 	if (err)
 		goto out_unlock;
-	memcpy (de->name, name, namelen);
-	memset (de->name + namelen, 0, SYSV_DIRSIZE - namelen - 2);
-	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
-	err = dir_commit_chunk(page, pos, SYSV_DIRSIZE);
+	memcpy(diter.entry->name, name, namelen);
+	memset(diter.entry->name + namelen, 0, SYSV_DIRSIZE - namelen - 2);
+	diter.entry->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
+	err = dir_commit_chunk(diter.folio, diter.pos, SYSV_DIRSIZE);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
-out_page:
-	dir_put_page(page);
+out_end:
+	sysv_diter_end(&diter);
 out:
 	return err;
 out_unlock:
-	unlock_page(page);
-	goto out_page;
+	unlock_folio(diter.folio);
+	goto out_end;
 }
 
-int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
+int sysv_delete_entry(struct sysv_diter *diter)
 {
-	struct inode *inode = page->mapping->host;
-	char *kaddr = (char*)page_address(page);
-	loff_t pos = page_offset(page) + (char *)de - kaddr;
+	struct folio *folio = diter->folio;
+	struct inode *inode = folio->mapping->host;
 	int err;
 
-	lock_page(page);
-	err = sysv_prepare_chunk(page, pos, SYSV_DIRSIZE);
+	lock_folio(folio);
+	err = sysv_prepare_chunk(folio, diter->pos, SYSV_DIRSIZE);
 	BUG_ON(err);
-	de->inode = 0;
-	err = dir_commit_chunk(page, pos, SYSV_DIRSIZE);
-	dir_put_page(page);
+	diter->entry->inode = 0;
+	err = dir_commit_chunk(folio, diter->pos, SYSV_DIRSIZE);
+	sysv_diter_end(diter);
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 	mark_inode_dirty(inode);
 	return err;
@@ -247,122 +220,102 @@ int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
 
 int sysv_make_empty(struct inode *inode, struct inode *dir)
 {
-	struct page *page = grab_cache_page(inode->i_mapping, 0);
-	struct sysv_dir_entry * de;
-	char *base;
+	struct folio *folio = grab_cache_folio(inode->i_mapping, 0);
+	struct sysv_dir_entry *de;
 	int err;
 
-	if (!page)
+	if (!folio)
 		return -ENOMEM;
-	err = sysv_prepare_chunk(page, 0, 2 * SYSV_DIRSIZE);
+	err = sysv_prepare_chunk(folio, 0, 2 * SYSV_DIRSIZE);
 	if (err) {
-		unlock_page(page);
+		unlock_folio(folio);
 		goto fail;
 	}
-	kmap(page);
+	de = kmap_local_folio(folio, 0);
 
-	base = (char*)page_address(page);
-	memset(base, 0, PAGE_SIZE);
+	memset(de, 0, folio_size(folio));
 
-	de = (struct sysv_dir_entry *) base;
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
 	strcpy(de->name,".");
 	de++;
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), dir->i_ino);
 	strcpy(de->name,"..");
 
-	kunmap(page);
-	err = dir_commit_chunk(page, 0, 2 * SYSV_DIRSIZE);
+	kunmap_local(de);
+	err = dir_commit_chunk(folio, 0, 2 * SYSV_DIRSIZE);
 fail:
-	put_page(page);
+	put_folio(folio);
 	return err;
 }
 
 /*
  * routine to check that the specified directory is empty (for rmdir)
  */
-int sysv_empty_dir(struct inode * inode)
+bool sysv_empty_dir(struct inode * inode)
 {
 	struct super_block *sb = inode->i_sb;
-	struct page *page = NULL;
-	unsigned long i, npages = dir_pages(inode);
-
-	for (i = 0; i < npages; i++) {
-		char *kaddr;
-		struct sysv_dir_entry * de;
-		page = dir_get_page(inode, i);
+	struct sysv_diter diter = { .pos = 0 };
+	struct sysv_dir_entry *de;
 
-		if (IS_ERR(page))
+	while (diter.pos < inode->i_size) {
+		if (sysv_diter_next(inode, &diter))
 			continue;
-
-		kaddr = (char *)page_address(page);
-		de = (struct sysv_dir_entry *)kaddr;
-		kaddr += PAGE_SIZE-SYSV_DIRSIZE;
-
-		for ( ;(char *)de <= kaddr; de++) {
-			if (!de->inode)
+		de = diter.entry;
+		if (!de->inode)
+			continue;
+		/* check for . and .. */
+		if (de->name[0] != '.')
+			goto not_empty;
+		if (!de->name[1]) {
+			if (de->inode == cpu_to_fs16(SYSV_SB(sb), inode->i_ino))
 				continue;
-			/* check for . and .. */
-			if (de->name[0] != '.')
-				goto not_empty;
-			if (!de->name[1]) {
-				if (de->inode == cpu_to_fs16(SYSV_SB(sb),
-							inode->i_ino))
-					continue;
-				goto not_empty;
-			}
-			if (de->name[1] != '.' || de->name[2])
-				goto not_empty;
+			goto not_empty;
 		}
-		dir_put_page(page);
+		if (de->name[1] != '.' || de->name[2])
+			goto not_empty;
 	}
-	return 1;
+	sysv_diter_end(&diter);
+	return true;
 
 not_empty:
-	dir_put_page(page);
-	return 0;
+	sysv_diter_end(&diter);
+	return false;
 }
 
-/* Releases the page */
-void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
-	struct inode *inode)
+/* Releases the diter */
+void sysv_set_link(struct sysv_diter *diter, struct inode *inode)
 {
-	struct inode *dir = page->mapping->host;
-	loff_t pos = page_offset(page) +
-			(char *)de-(char*)page_address(page);
+	struct folio *folio = diter->folio;
+	struct inode *dir = folio->mapping->host;
 	int err;
 
-	lock_page(page);
-	err = sysv_prepare_chunk(page, pos, SYSV_DIRSIZE);
+	lock_folio(folio);
+	err = sysv_prepare_chunk(folio, diter->pos, SYSV_DIRSIZE);
 	BUG_ON(err);
-	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
-	err = dir_commit_chunk(page, pos, SYSV_DIRSIZE);
-	dir_put_page(page);
+	diter->entry->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
+	err = dir_commit_chunk(folio, diter->pos, SYSV_DIRSIZE);
+	sysv_diter_end(diter);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
 }
 
-struct sysv_dir_entry * sysv_dotdot (struct inode *dir, struct page **p)
+int sysv_dotdot(struct inode *dir, struct sysv_diter *diter)
 {
-	struct page *page = dir_get_page(dir, 0);
-	struct sysv_dir_entry *de = NULL;
+	diter->pos = SYSV_DIRSIZE;
+	diter->entry = NULL;
 
-	if (!IS_ERR(page)) {
-		de = (struct sysv_dir_entry*) page_address(page) + 1;
-		*p = page;
-	}
-	return de;
+	return sysv_diter_next(dir, diter);
 }
 
 ino_t sysv_inode_by_name(struct dentry *dentry)
 {
-	struct page *page;
-	struct sysv_dir_entry *de = sysv_find_entry (dentry, &page);
+	struct sysv_diter diter;
+	int err = sysv_find_entry(dentry, &diter);
 	ino_t res = 0;
-	
-	if (de) {
-		res = fs16_to_cpu(SYSV_SB(dentry->d_sb), de->inode);
-		dir_put_page(page);
+
+	if (!err) {
+		res = fs16_to_cpu(SYSV_SB(dentry->d_sb), diter.entry->inode);
+		sysv_diter_end(&diter);
 	}
 	return res;
 }
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index 97d828a16155..a3c634e6253d 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -451,19 +451,19 @@ int sysv_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	return 0;
 }
 
-static int sysv_writepage(struct page *page, struct writeback_control *wbc)
+static int sysv_write_folio(struct folio *folio, struct writeback_control *wbc)
 {
-	return block_write_full_page(page,get_block,wbc);
+	return block_write_full_folio(folio, get_block, wbc);
 }
 
-static int sysv_readpage(struct file *file, struct folio *folio)
+static int sysv_read_folio(struct file *file, struct folio *folio)
 {
-	return block_read_full_page(folio, get_block);
+	return block_read_full_folio(folio, get_block);
 }
 
-int sysv_prepare_chunk(struct page *page, loff_t pos, unsigned len)
+int sysv_prepare_chunk(struct folio *folio, loff_t pos, unsigned len)
 {
-	return __block_write_begin(page, pos, len, get_block);
+	return __block_write_begin(folio, pos, len, get_block);
 }
 
 static void sysv_write_failed(struct address_space *mapping, loff_t to)
@@ -478,11 +478,11 @@ static void sysv_write_failed(struct address_space *mapping, loff_t to)
 
 static int sysv_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned flags,
-			struct page **pagep, void **fsdata)
+			struct folio **foliop, void **fsdata)
 {
 	int ret;
 
-	ret = block_write_begin(mapping, pos, len, flags, pagep, get_block);
+	ret = block_write_begin(mapping, pos, len, flags, foliop, get_block);
 	if (unlikely(ret))
 		sysv_write_failed(mapping, pos + len);
 
@@ -495,8 +495,8 @@ static sector_t sysv_bmap(struct address_space *mapping, sector_t block)
 }
 
 const struct address_space_operations sysv_aops = {
-	.readpage = sysv_readpage,
-	.writepage = sysv_writepage,
+	.readpage = sysv_read_folio,
+	.writepage = sysv_write_folio,
 	.write_begin = sysv_write_begin,
 	.write_end = generic_write_end,
 	.bmap = sysv_bmap
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index b2e6abc06a2d..c67cd0ea1378 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -150,16 +150,13 @@ static int sysv_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 
 static int sysv_unlink(struct inode * dir, struct dentry * dentry)
 {
+	struct sysv_diter diter;
 	struct inode * inode = d_inode(dentry);
-	struct page * page;
-	struct sysv_dir_entry * de;
-	int err = -ENOENT;
+	int err = sysv_find_entry(dentry, &diter);
 
-	de = sysv_find_entry(dentry, &page);
-	if (!de)
+	if (err)
 		goto out;
-
-	err = sysv_delete_entry (de, page);
+	err = sysv_delete_entry(&diter);
 	if (err)
 		goto out;
 
@@ -193,70 +190,60 @@ static int sysv_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		       struct dentry *old_dentry, struct inode *new_dir,
 		       struct dentry *new_dentry, unsigned int flags)
 {
+	struct sysv_diter old_iter, dir_iter = { .entry = NULL, };
 	struct inode * old_inode = d_inode(old_dentry);
 	struct inode * new_inode = d_inode(new_dentry);
-	struct page * dir_page = NULL;
-	struct sysv_dir_entry * dir_de = NULL;
-	struct page * old_page;
-	struct sysv_dir_entry * old_de;
-	int err = -ENOENT;
+	int err;
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
 
-	old_de = sysv_find_entry(old_dentry, &old_page);
-	if (!old_de)
+	err = sysv_find_entry(old_dentry, &old_iter);
+	if (err)
 		goto out;
 
 	if (S_ISDIR(old_inode->i_mode)) {
-		err = -EIO;
-		dir_de = sysv_dotdot(old_inode, &dir_page);
-		if (!dir_de)
+		err = sysv_dotdot(old_inode, &dir_iter);
+		if (err)
 			goto out_old;
 	}
 
 	if (new_inode) {
-		struct page * new_page;
-		struct sysv_dir_entry * new_de;
+		struct sysv_diter new_iter;
 
 		err = -ENOTEMPTY;
-		if (dir_de && !sysv_empty_dir(new_inode))
+		if (dir_iter.entry && !sysv_empty_dir(new_inode))
 			goto out_dir;
 
-		err = -ENOENT;
-		new_de = sysv_find_entry(new_dentry, &new_page);
-		if (!new_de)
+		err = sysv_find_entry(new_dentry, &new_iter);
+		if (err)
 			goto out_dir;
-		sysv_set_link(new_de, new_page, old_inode);
+		sysv_set_link(&new_iter, old_inode);
 		new_inode->i_ctime = current_time(new_inode);
-		if (dir_de)
+		if (dir_iter.entry)
 			drop_nlink(new_inode);
 		inode_dec_link_count(new_inode);
 	} else {
 		err = sysv_add_link(new_dentry, old_inode);
 		if (err)
 			goto out_dir;
-		if (dir_de)
+		if (dir_iter.entry)
 			inode_inc_link_count(new_dir);
 	}
 
-	sysv_delete_entry(old_de, old_page);
+	sysv_delete_entry(&old_iter);
 	mark_inode_dirty(old_inode);
 
-	if (dir_de) {
-		sysv_set_link(dir_de, dir_page, new_dir);
+	if (dir_iter.entry) {
+		sysv_set_link(&dir_iter, new_dir);
 		inode_dec_link_count(old_dir);
 	}
 	return 0;
 
 out_dir:
-	if (dir_de) {
-		kunmap(dir_page);
-		put_page(dir_page);
-	}
+	sysv_diter_end(&dir_iter);
 out_old:
-	kunmap(old_page);
-	put_page(old_page);
+	sysv_diter_end(&old_iter);
 out:
 	return err;
 }
diff --git a/fs/sysv/sysv.h b/fs/sysv/sysv.h
index 99ddf033da4f..66be87c007e9 100644
--- a/fs/sysv/sysv.h
+++ b/fs/sysv/sysv.h
@@ -134,7 +134,7 @@ extern unsigned long sysv_count_free_blocks(struct super_block *);
 
 /* itree.c */
 extern void sysv_truncate(struct inode *);
-extern int sysv_prepare_chunk(struct page *page, loff_t pos, unsigned len);
+int sysv_prepare_chunk(struct folio *folio, loff_t pos, unsigned len);
 
 /* inode.c */
 extern struct inode *sysv_iget(struct super_block *, unsigned int);
@@ -148,16 +148,21 @@ extern void sysv_destroy_icache(void);
 
 
 /* dir.c */
-extern struct sysv_dir_entry *sysv_find_entry(struct dentry *, struct page **);
-extern int sysv_add_link(struct dentry *, struct inode *);
-extern int sysv_delete_entry(struct sysv_dir_entry *, struct page *);
-extern int sysv_make_empty(struct inode *, struct inode *);
-extern int sysv_empty_dir(struct inode *);
-extern void sysv_set_link(struct sysv_dir_entry *, struct page *,
-			struct inode *);
-extern struct sysv_dir_entry *sysv_dotdot(struct inode *, struct page **);
-extern ino_t sysv_inode_by_name(struct dentry *);
+struct sysv_diter {
+	struct sysv_dir_entry *entry;
+	struct folio *folio;
+	loff_t pos;
+};
 
+void sysv_diter_end(struct sysv_diter *);
+int sysv_find_entry(const struct dentry *, struct sysv_diter *);
+int sysv_add_link(struct dentry *, struct inode *);
+int sysv_delete_entry(struct sysv_diter *);
+int sysv_make_empty(struct inode *, struct inode *);
+bool sysv_empty_dir(struct inode *);
+void sysv_set_link(struct sysv_diter *, struct inode *);
+int sysv_dotdot(struct inode *, struct sysv_diter *);
+ino_t sysv_inode_by_name(struct dentry *);
 
 extern const struct inode_operations sysv_file_inode_operations;
 extern const struct inode_operations sysv_dir_inode_operations;
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index f92330199ece..fea14a2c1977 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -215,20 +215,22 @@ extern int buffer_heads_over_limit;
  * address_spaces.
  */
 void block_invalidatepage(struct folio *folio, size_t offset, size_t length);
+int block_write_full_folio(struct folio *folio, get_block_t *get_block,
+				struct writeback_control *wbc);
 int block_write_full_page(struct page *page, get_block_t *get_block,
 				struct writeback_control *wbc);
 int __block_write_full_page(struct inode *inode, struct page *page,
 			get_block_t *get_block, struct writeback_control *wbc,
 			bh_end_io_t *handler);
-int block_read_full_page(struct folio *, get_block_t *);
+int block_read_full_folio(struct folio *, get_block_t *);
 bool block_is_partially_uptodate(struct folio *, size_t from, size_t count);
 int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
-		unsigned flags, struct page **pagep, get_block_t *get_block);
-int __block_write_begin(struct page *page, loff_t pos, unsigned len,
+		unsigned flags, struct folio **foliop, get_block_t *get_block);
+int __block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 		get_block_t *get_block);
 int block_write_end(struct file *, struct address_space *,
 				loff_t, unsigned, unsigned,
-				struct page *, void *);
+				struct folio *, void *);
 int generic_write_end(struct file *, struct address_space *,
 				loff_t, unsigned, unsigned,
 				struct page *, void *);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f53f34c2eb72..bf9fd8fb4e9d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -367,7 +367,7 @@ typedef int (*read_actor_t)(read_descriptor_t *, struct page *,
 		unsigned long, unsigned long);
 
 struct address_space_operations {
-	int (*writepage)(struct page *page, struct writeback_control *wbc);
+	int (*writepage)(struct folio *folio, struct writeback_control *wbc);
 	int (*readpage)(struct file *, struct folio *);
 
 	/* Write back some dirty pages from this mapping. */
@@ -386,7 +386,7 @@ struct address_space_operations {
 
 	int (*write_begin)(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned flags,
-				struct page **pagep, void **fsdata);
+				struct folio **pagep, void **fsdata);
 	int (*write_end)(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned copied,
 				struct page *page, void *fsdata);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 90086f93e9de..c343c165f568 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -235,7 +235,18 @@ struct page {
  * large as PAGE_SIZE.
  */
 struct folio {
-	struct page page;
+	union {
+		struct page page;
+		struct {
+			unsigned long flags;
+			struct list_head lru;
+			struct address_space *mapping;
+			pgoff_t index;
+			unsigned long private;
+			atomic_t _mapcount;
+			atomic_t _refcount;
+		};
+	};
 };
 
 /**
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 1279daf997f2..1e89de01a117 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -603,6 +603,14 @@ static inline struct page *grab_cache_page(struct address_space *mapping,
 	return find_or_create_page(mapping, index, mapping_gfp_mask(mapping));
 }
 
+static inline struct folio *grab_cache_folio(struct address_space *mapping,
+								pgoff_t index)
+{
+	return filemap_get_folio(mapping, index,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+			mapping_gfp_mask(mapping));
+}
+
 struct folio *read_cache_folio(struct address_space *, pgoff_t index,
 		filler_t *filler, void *data);
 struct page *read_cache_page(struct address_space *, pgoff_t index,
diff --git a/mm/util.c b/mm/util.c
index c4ed5b919c7d..a9d46554059c 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -686,6 +686,22 @@ struct anon_vma *page_anon_vma(struct page *page)
 	return __page_rmapping(page);
 }
 
+static inline void folio_build_bug(void)
+{
+#define FOLIO_MATCH(pg, fl)						\
+BUILD_BUG_ON(offsetof(struct page, pg) != offsetof(struct folio, fl));
+
+	FOLIO_MATCH(flags, flags);
+	FOLIO_MATCH(lru, lru);
+	FOLIO_MATCH(mapping, mapping);
+	FOLIO_MATCH(index, index);
+	FOLIO_MATCH(private, private);
+	FOLIO_MATCH(_mapcount, _mapcount);
+	FOLIO_MATCH(_refcount, _refcount);
+#undef FOLIO_MATCH
+	BUILD_BUG_ON(sizeof(struct page) != sizeof(struct folio));
+}
+
 /**
  * folio_mapping - Find the mapping where this folio is stored.
  * @folio: The folio.
