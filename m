Return-Path: <linux-fsdevel+bounces-2150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 283457E2B5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9416FB2171A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E782E637;
	Mon,  6 Nov 2023 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZxVcI+0P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6709C2C84E
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 17:39:20 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1206110FD;
	Mon,  6 Nov 2023 09:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1cG286y5GAw2GB25GESmvS8q26knZkjNHGUK8msdP0Y=; b=ZxVcI+0PnEjAtuAatbGZ13Fhaj
	o+qJ6K6evkwbSXkUrxlbfU++s3HsQwM3ezdlF9O1SmyF3SL6lOTGxSZUO71xclcKie5YsCRp4bycD
	+3Adt5cyYi2/osQdNHoPxaZ2rr6E44iNT9E1emgqWMmPjTX91k6sx+ycsclynzjRQnz1HSSpt/TbB
	tlz7aQMbZehpZ05sdcz5bSDDcPRDgfg2Ae7MCsEs6mIZefdWAVVE7wFXEdepyaeqzOhtHi4bGzPwi
	dcAEbacWuYz1UPWOqMDnonDShC5vzK4Z4E1PkaSQLDYGNkrV4vI3op+fGh7Jsl74DYF0vIXVjydLS
	e/Slt9tQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r03Z7-007HB9-MH; Mon, 06 Nov 2023 17:39:09 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 30/35] nilfs2: Convert nilfs_rename() to use folios
Date: Mon,  6 Nov 2023 17:38:58 +0000
Message-Id: <20231106173903.1734114-31-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106173903.1734114-1-willy@infradead.org>
References: <20231106173903.1734114-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This involves converting nilfs_find_entry(), nilfs_dotdot(),
nilfs_set_link(), nilfs_delete_entry() and nilfs_do_unlink()
to use folios as well.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/dir.c   | 74 ++++++++++++++++++++++-------------------------
 fs/nilfs2/namei.c | 28 +++++++++---------
 fs/nilfs2/nilfs.h | 20 ++++++-------
 3 files changed, 59 insertions(+), 63 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 9f2a02b71ddc..25a468dda0f3 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -323,38 +323,35 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
 }
 
 /*
- *	nilfs_find_entry()
+ * nilfs_find_entry()
  *
- * finds an entry in the specified directory with the wanted name. It
- * returns the page in which the entry was found, and the entry itself
- * (as a parameter - res_dir). Page is returned mapped and unlocked.
- * Entry is guaranteed to be valid.
+ * Finds an entry in the specified directory with the wanted name. It
+ * returns the folio in which the entry was found, and the entry itself.
+ * The folio is mapped and unlocked.  When the caller is finished with
+ * the entry, it should call folio_release_kmap().
+ *
+ * On failure, returns NULL and the caller should ignore foliop.
  */
-struct nilfs_dir_entry *
-nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
-		 struct page **res_page)
+struct nilfs_dir_entry *nilfs_find_entry(struct inode *dir,
+		const struct qstr *qstr, struct folio **foliop)
 {
 	const unsigned char *name = qstr->name;
 	int namelen = qstr->len;
 	unsigned int reclen = NILFS_DIR_REC_LEN(namelen);
 	unsigned long start, n;
 	unsigned long npages = dir_pages(dir);
-	struct folio *folio = NULL;
 	struct nilfs_inode_info *ei = NILFS_I(dir);
 	struct nilfs_dir_entry *de;
 
 	if (npages == 0)
 		goto out;
 
-	/* OFFSET_CACHE */
-	*res_page = NULL;
-
 	start = ei->i_dir_start_lookup;
 	if (start >= npages)
 		start = 0;
 	n = start;
 	do {
-		char *kaddr = nilfs_get_folio(dir, n, &folio);
+		char *kaddr = nilfs_get_folio(dir, n, foliop);
 		if (!IS_ERR(kaddr)) {
 			de = (struct nilfs_dir_entry *)kaddr;
 			kaddr += nilfs_last_byte(dir, n) - reclen;
@@ -362,14 +359,14 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 				if (de->rec_len == 0) {
 					nilfs_error(dir->i_sb,
 						"zero-length directory entry");
-					folio_release_kmap(folio, kaddr);
+					folio_release_kmap(*foliop, kaddr);
 					goto out;
 				}
 				if (nilfs_match(namelen, name, de))
 					goto found;
 				de = nilfs_next_entry(de);
 			}
-			folio_release_kmap(folio, kaddr);
+			folio_release_kmap(*foliop, kaddr);
 		}
 		if (++n >= npages)
 			n = 0;
@@ -386,14 +383,13 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 	return NULL;
 
 found:
-	*res_page = &folio->page;
 	ei->i_dir_start_lookup = n;
 	return de;
 }
 
-struct nilfs_dir_entry *nilfs_dotdot(struct inode *dir, struct page **p)
+struct nilfs_dir_entry *nilfs_dotdot(struct inode *dir, struct folio **foliop)
 {
-	struct nilfs_dir_entry *de = nilfs_get_page(dir, 0, p);
+	struct nilfs_dir_entry *de = nilfs_get_folio(dir, 0, foliop);
 
 	if (IS_ERR(de))
 		return NULL;
@@ -404,32 +400,32 @@ ino_t nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 {
 	ino_t res = 0;
 	struct nilfs_dir_entry *de;
-	struct page *page;
+	struct folio *folio;
 
-	de = nilfs_find_entry(dir, qstr, &page);
+	de = nilfs_find_entry(dir, qstr, &folio);
 	if (de) {
 		res = le64_to_cpu(de->inode);
-		unmap_and_put_page(page, de);
+		folio_release_kmap(folio, de);
 	}
 	return res;
 }
 
-/* Releases the page */
+/* Releases the folio */
 void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
-		    struct page *page, struct inode *inode)
+		    struct folio *folio, struct inode *inode)
 {
-	unsigned int from = offset_in_page(de);
-	unsigned int to = from + nilfs_rec_len_from_disk(de->rec_len);
-	struct address_space *mapping = page->mapping;
+	size_t from = offset_in_folio(folio, de);
+	size_t to = from + nilfs_rec_len_from_disk(de->rec_len);
+	struct address_space *mapping = folio->mapping;
 	int err;
 
-	lock_page(page);
-	err = nilfs_prepare_chunk(page, from, to);
+	folio_lock(folio);
+	err = nilfs_prepare_chunk(&folio->page, from, to);
 	BUG_ON(err);
 	de->inode = cpu_to_le64(inode->i_ino);
 	nilfs_set_de_type(de, inode);
-	nilfs_commit_chunk(page, mapping, from, to);
-	unmap_and_put_page(page, de);
+	nilfs_commit_chunk(&folio->page, mapping, from, to);
+	folio_release_kmap(folio, de);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 }
 
@@ -533,14 +529,14 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 
 /*
  * nilfs_delete_entry deletes a directory entry by merging it with the
- * previous entry. Page is up-to-date. Releases the page.
+ * previous entry. Folio is up-to-date. Releases the folio.
  */
-int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
+int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct folio *folio)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
-	char *kaddr = (char *)((unsigned long)dir & PAGE_MASK);
-	unsigned int from, to;
+	char *kaddr = (char *)((unsigned long)dir & ~(folio_size(folio) - 1));
+	size_t from, to;
 	struct nilfs_dir_entry *de, *pde = NULL;
 	int err;
 
@@ -560,16 +556,16 @@ int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
 	}
 	if (pde)
 		from = (char *)pde - kaddr;
-	lock_page(page);
-	err = nilfs_prepare_chunk(page, from, to);
+	folio_lock(folio);
+	err = nilfs_prepare_chunk(&folio->page, from, to);
 	BUG_ON(err);
 	if (pde)
 		pde->rec_len = nilfs_rec_len_to_disk(to - from);
 	dir->inode = 0;
-	nilfs_commit_chunk(page, mapping, from, to);
+	nilfs_commit_chunk(&folio->page, mapping, from, to);
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 out:
-	unmap_and_put_page(page, kaddr);
+	folio_release_kmap(folio, kaddr);
 	return err;
 }
 
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 8eebd8a464d8..d9d23f3cc4d7 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -260,11 +260,11 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode;
 	struct nilfs_dir_entry *de;
-	struct page *page;
+	struct folio *folio;
 	int err;
 
 	err = -ENOENT;
-	de = nilfs_find_entry(dir, &dentry->d_name, &page);
+	de = nilfs_find_entry(dir, &dentry->d_name, &folio);
 	if (!de)
 		goto out;
 
@@ -279,7 +279,7 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 			   inode->i_ino, inode->i_nlink);
 		set_nlink(inode, 1);
 	}
-	err = nilfs_delete_entry(de, page);
+	err = nilfs_delete_entry(de, folio);
 	if (err)
 		goto out;
 
@@ -347,9 +347,9 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 {
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
-	struct page *dir_page = NULL;
+	struct folio *dir_folio = NULL;
 	struct nilfs_dir_entry *dir_de = NULL;
-	struct page *old_page;
+	struct folio *old_folio;
 	struct nilfs_dir_entry *old_de;
 	struct nilfs_transaction_info ti;
 	int err;
@@ -362,19 +362,19 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 		return err;
 
 	err = -ENOENT;
-	old_de = nilfs_find_entry(old_dir, &old_dentry->d_name, &old_page);
+	old_de = nilfs_find_entry(old_dir, &old_dentry->d_name, &old_folio);
 	if (!old_de)
 		goto out;
 
 	if (S_ISDIR(old_inode->i_mode)) {
 		err = -EIO;
-		dir_de = nilfs_dotdot(old_inode, &dir_page);
+		dir_de = nilfs_dotdot(old_inode, &dir_folio);
 		if (!dir_de)
 			goto out_old;
 	}
 
 	if (new_inode) {
-		struct page *new_page;
+		struct folio *new_folio;
 		struct nilfs_dir_entry *new_de;
 
 		err = -ENOTEMPTY;
@@ -382,10 +382,10 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 			goto out_dir;
 
 		err = -ENOENT;
-		new_de = nilfs_find_entry(new_dir, &new_dentry->d_name, &new_page);
+		new_de = nilfs_find_entry(new_dir, &new_dentry->d_name, &new_folio);
 		if (!new_de)
 			goto out_dir;
-		nilfs_set_link(new_dir, new_de, new_page, old_inode);
+		nilfs_set_link(new_dir, new_de, new_folio, old_inode);
 		nilfs_mark_inode_dirty(new_dir);
 		inode_set_ctime_current(new_inode);
 		if (dir_de)
@@ -408,10 +408,10 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 	 */
 	inode_set_ctime_current(old_inode);
 
-	nilfs_delete_entry(old_de, old_page);
+	nilfs_delete_entry(old_de, old_folio);
 
 	if (dir_de) {
-		nilfs_set_link(old_inode, dir_de, dir_page, new_dir);
+		nilfs_set_link(old_inode, dir_de, dir_folio, new_dir);
 		drop_nlink(old_dir);
 	}
 	nilfs_mark_inode_dirty(old_dir);
@@ -422,9 +422,9 @@ static int nilfs_rename(struct mnt_idmap *idmap,
 
 out_dir:
 	if (dir_de)
-		unmap_and_put_page(dir_page, dir_de);
+		folio_release_kmap(dir_folio, dir_de);
 out_old:
-	unmap_and_put_page(old_page, old_de);
+	folio_release_kmap(old_folio, old_de);
 out:
 	nilfs_transaction_abort(old_dir->i_sb);
 	return err;
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index 8046490cd7fe..98cffaf0ac12 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -226,16 +226,16 @@ static inline __u32 nilfs_mask_flags(umode_t mode, __u32 flags)
 }
 
 /* dir.c */
-extern int nilfs_add_link(struct dentry *, struct inode *);
-extern ino_t nilfs_inode_by_name(struct inode *, const struct qstr *);
-extern int nilfs_make_empty(struct inode *, struct inode *);
-extern struct nilfs_dir_entry *
-nilfs_find_entry(struct inode *, const struct qstr *, struct page **);
-extern int nilfs_delete_entry(struct nilfs_dir_entry *, struct page *);
-extern int nilfs_empty_dir(struct inode *);
-extern struct nilfs_dir_entry *nilfs_dotdot(struct inode *, struct page **);
-extern void nilfs_set_link(struct inode *, struct nilfs_dir_entry *,
-			   struct page *, struct inode *);
+int nilfs_add_link(struct dentry *, struct inode *);
+ino_t nilfs_inode_by_name(struct inode *, const struct qstr *);
+int nilfs_make_empty(struct inode *, struct inode *);
+struct nilfs_dir_entry *nilfs_find_entry(struct inode *, const struct qstr *,
+		struct folio **);
+int nilfs_delete_entry(struct nilfs_dir_entry *, struct folio *);
+int nilfs_empty_dir(struct inode *);
+struct nilfs_dir_entry *nilfs_dotdot(struct inode *, struct folio **);
+void nilfs_set_link(struct inode *, struct nilfs_dir_entry *,
+			   struct folio *, struct inode *);
 
 /* file.c */
 extern int nilfs_sync_file(struct file *, loff_t, loff_t, int);
-- 
2.42.0


