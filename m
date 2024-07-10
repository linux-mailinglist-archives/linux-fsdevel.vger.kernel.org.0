Return-Path: <linux-fsdevel+bounces-23460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D709392C7E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 03:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FB31F23E78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 01:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE50AD51;
	Wed, 10 Jul 2024 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZqHjM3Of"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B50C79C0
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574611; cv=none; b=My1Nyty2aob3vzs/N3Sm/wadH0eGNIi4A7BMK2t6f1Uutv0ORc1HxmJD9eVaUjTCmOCyuuKepV3NpyOqfTtJT6A0mq3BKG+38Tb9CE5o41QiL7OHHi5udx4gognf5fLMXn2iUbdgNz1XwXw2v5q1UDl+rjtR2q6Tge9dFIMis+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574611; c=relaxed/simple;
	bh=gUTx3L7j0mxdzjFHXXTjqcqGJ+9PXUPMqj94Q350TfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlnKDxQD//vn6ga0QTlfZBVFD4ouUhQYVOUW41kSfJT+Oi/HrN5U7/mOOk28PL9ZMbr052UbMCKRmMimOvBAi1gr7YbJ/ZV6BeQ8XFUEUpOBBEo3ka55PPtXapcRCk8qTA96qhhYZTAxpcQ2XFLYOwraWpKYc+6tnNr9P3NEmyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZqHjM3Of; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=tQT2phDWusyoq7TdZJ5e81MyD1YuneUr3UVIvKIUcWc=; b=ZqHjM3OfsY3HdY/nwu89hccA62
	znJLWBHFGaoAuU2Le4LYxmK6IouKg6obHxRBxrv34yCPLGp9uaTqPZjnwRD9kChOwRMc90F8gkIsD
	1veoNENiGosy38y9A9/CO5GAOHI0XBndmHOP/uG5ObO48HOlL9NwsdUI/348DRys0H2E3+JeE2RC4
	MFb8niaNae3DwRiv3fUw+YrCvO2Bm0tIf8VXv/DbjnlWNkqsd6zkCtn0xR8BtPXK+rHTUjG6HWkdE
	qrCANEqInbcg0D//W+D8VFAwNb5VBmy9YolYBIobRYcQKPdlGqEktkaKdDfUM6PNODNP0Xmna1QRu
	sYzEU9pA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRM3J-00000008Ya0-2Cdi;
	Wed, 10 Jul 2024 01:23:25 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/7] minixfs: Convert minix_find_entry() to take a folio
Date: Wed, 10 Jul 2024 02:23:16 +0100
Message-ID: <20240710012323.2039519-3-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710012323.2039519-1-willy@infradead.org>
References: <20240710012323.2039519-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/minix/dir.c   | 25 +++++++++++--------------
 fs/minix/minix.h | 14 +++++++-------
 fs/minix/namei.c | 25 ++++++++++++-------------
 3 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index 41e6c0c2e243..3bbfac32d520 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -145,12 +145,13 @@ static inline int namecompare(int len, int maxlen,
 /*
  *	minix_find_entry()
  *
- * finds an entry in the specified directory with the wanted name. It
- * returns the cache buffer in which the entry was found, and the entry
- * itself (as a parameter - res_dir). It does NOT read the inode of the
+ * finds an entry in the specified directory with the wanted name.
+ * It does NOT read the inode of the
  * entry - you'll have to do that yourself if you want to.
+ * 
+ * On Success folio_release_kmap() should be called on *foliop.
  */
-minix_dirent *minix_find_entry(struct dentry *dentry, struct page **res_page)
+minix_dirent *minix_find_entry(struct dentry *dentry, struct folio **foliop)
 {
 	const char * name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
@@ -159,17 +160,15 @@ minix_dirent *minix_find_entry(struct dentry *dentry, struct page **res_page)
 	struct minix_sb_info * sbi = minix_sb(sb);
 	unsigned long n;
 	unsigned long npages = dir_pages(dir);
-	struct folio *folio = NULL;
 	char *p;
 
 	char *namx;
 	__u32 inumber;
-	*res_page = NULL;
 
 	for (n = 0; n < npages; n++) {
 		char *kaddr, *limit;
 
-		kaddr = dir_get_folio(dir, n, &folio);
+		kaddr = dir_get_folio(dir, n, foliop);
 		if (IS_ERR(kaddr))
 			continue;
 
@@ -189,12 +188,11 @@ minix_dirent *minix_find_entry(struct dentry *dentry, struct page **res_page)
 			if (namecompare(namelen, sbi->s_namelen, name, namx))
 				goto found;
 		}
-		folio_release_kmap(folio, kaddr);
+		folio_release_kmap(*foliop, kaddr);
 	}
 	return NULL;
 
 found:
-	*res_page = &folio->page;
 	return (minix_dirent *)p;
 }
 
@@ -445,20 +443,19 @@ struct minix_dir_entry * minix_dotdot (struct inode *dir, struct page **p)
 
 ino_t minix_inode_by_name(struct dentry *dentry)
 {
-	struct page *page;
-	struct minix_dir_entry *de = minix_find_entry(dentry, &page);
+	struct folio *folio;
+	struct minix_dir_entry *de = minix_find_entry(dentry, &folio);
 	ino_t res = 0;
 
 	if (de) {
-		struct address_space *mapping = page->mapping;
-		struct inode *inode = mapping->host;
+		struct inode *inode = folio->mapping->host;
 		struct minix_sb_info *sbi = minix_sb(inode->i_sb);
 
 		if (sbi->s_version == MINIX_V3)
 			res = ((minix3_dirent *) de)->inode;
 		else
 			res = de->inode;
-		unmap_and_put_page(page, de);
+		folio_release_kmap(folio, de);
 	}
 	return res;
 }
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index d493507c064f..a290dd483e69 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -64,15 +64,15 @@ extern int V2_minix_get_block(struct inode *, long, struct buffer_head *, int);
 extern unsigned V1_minix_blocks(loff_t, struct super_block *);
 extern unsigned V2_minix_blocks(loff_t, struct super_block *);
 
-extern struct minix_dir_entry *minix_find_entry(struct dentry*, struct page**);
-extern int minix_add_link(struct dentry*, struct inode*);
-extern int minix_delete_entry(struct minix_dir_entry*, struct page*);
-extern int minix_make_empty(struct inode*, struct inode*);
-extern int minix_empty_dir(struct inode*);
+struct minix_dir_entry *minix_find_entry(struct dentry *, struct folio **);
+int minix_add_link(struct dentry*, struct inode*);
+int minix_delete_entry(struct minix_dir_entry*, struct page*);
+int minix_make_empty(struct inode*, struct inode*);
+int minix_empty_dir(struct inode*);
 int minix_set_link(struct minix_dir_entry *de, struct page *page,
 		struct inode *inode);
-extern struct minix_dir_entry *minix_dotdot(struct inode*, struct page**);
-extern ino_t minix_inode_by_name(struct dentry*);
+struct minix_dir_entry *minix_dotdot(struct inode*, struct page**);
+ino_t minix_inode_by_name(struct dentry*);
 
 extern const struct inode_operations minix_file_inode_operations;
 extern const struct inode_operations minix_dir_inode_operations;
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index d6031acc34f0..117264877bd7 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -141,15 +141,15 @@ static int minix_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 static int minix_unlink(struct inode * dir, struct dentry *dentry)
 {
 	struct inode * inode = d_inode(dentry);
-	struct page * page;
+	struct folio *folio;
 	struct minix_dir_entry * de;
 	int err;
 
-	de = minix_find_entry(dentry, &page);
+	de = minix_find_entry(dentry, &folio);
 	if (!de)
 		return -ENOENT;
-	err = minix_delete_entry(de, page);
-	unmap_and_put_page(page, de);
+	err = minix_delete_entry(de, &folio->page);
+	folio_release_kmap(folio, de);
 
 	if (err)
 		return err;
@@ -182,14 +182,14 @@ static int minix_rename(struct mnt_idmap *idmap,
 	struct inode * new_inode = d_inode(new_dentry);
 	struct page * dir_page = NULL;
 	struct minix_dir_entry * dir_de = NULL;
-	struct page * old_page;
+	struct folio *old_folio;
 	struct minix_dir_entry * old_de;
 	int err = -ENOENT;
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
 
-	old_de = minix_find_entry(old_dentry, &old_page);
+	old_de = minix_find_entry(old_dentry, &old_folio);
 	if (!old_de)
 		goto out;
 
@@ -201,7 +201,7 @@ static int minix_rename(struct mnt_idmap *idmap,
 	}
 
 	if (new_inode) {
-		struct page * new_page;
+		struct folio *new_folio;
 		struct minix_dir_entry * new_de;
 
 		err = -ENOTEMPTY;
@@ -209,12 +209,11 @@ static int minix_rename(struct mnt_idmap *idmap,
 			goto out_dir;
 
 		err = -ENOENT;
-		new_de = minix_find_entry(new_dentry, &new_page);
+		new_de = minix_find_entry(new_dentry, &new_folio);
 		if (!new_de)
 			goto out_dir;
-		err = minix_set_link(new_de, new_page, old_inode);
-		kunmap(new_page);
-		put_page(new_page);
+		err = minix_set_link(new_de, &new_folio->page, old_inode);
+		folio_release_kmap(new_folio, new_de);
 		if (err)
 			goto out_dir;
 		inode_set_ctime_current(new_inode);
@@ -229,7 +228,7 @@ static int minix_rename(struct mnt_idmap *idmap,
 			inode_inc_link_count(new_dir);
 	}
 
-	err = minix_delete_entry(old_de, old_page);
+	err = minix_delete_entry(old_de, &old_folio->page);
 	if (err)
 		goto out_dir;
 
@@ -244,7 +243,7 @@ static int minix_rename(struct mnt_idmap *idmap,
 	if (dir_de)
 		unmap_and_put_page(dir_page, dir_de);
 out_old:
-	unmap_and_put_page(old_page, old_de);
+	folio_release_kmap(old_folio, old_de);
 out:
 	return err;
 }
-- 
2.43.0


