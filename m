Return-Path: <linux-fsdevel+bounces-23346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01D592AEC1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 05:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55356B212F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 03:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889AF12C48B;
	Tue,  9 Jul 2024 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GVEDGV43"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606BD2772A
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495836; cv=none; b=On80ObAzEXwy+B81mWVWz8tZOeRfnQrui2/VcvXFa4Qi5bH15E2MVYCJR+NmLF5BDe8d3jAMZGEK5FD7c9yFYPO09a2fy/JUve/fpX0xqp7tUjOd4UC2wNZmYhK9r5CgeOqYyNXP3gSvvVtK+38vgi2TMk8sg2IdQY5MscXeOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495836; c=relaxed/simple;
	bh=AY9j6OD8TiMWAQJqPlJ4/9k3HnM0gtNtNQ4nqoqeMhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCtTeEaiFZIkdcxaUf6FQSlgXJEo3AooR78Cm+aIVtJHAYzG3+vSzWYScq134LI+Xn6jZf84Fds+9J+p4xWc6KxHVnj2IBRVnPjuDM0f/fZik+7Soubm7m+mQKssat8tJ//ulflWmZx9Hn/8qEbj1QWZHaM6q97hpKzh16Chygs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GVEDGV43; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=dMl8wa5hGk6WVrF+XRUm3H21k6p6e6atwRzzEhlEt1E=; b=GVEDGV43o9FF5BnOUsodjZzvFe
	gFtvw1iqhbnqRmlUtSnPyrdhKTURxO/Yo1s+gvdLSe/rGCIebyvcbQ00KqwOKPaC7LyhhX1rIJ200
	3IBfR0tVh0kn6qMQyMWgxQ9oKc0Y2kI03+wIXmdng7KYrAkHcRFu6hwO42f1N1aunmuINO1cpRC7g
	br5WPZRivI803KMt3yqkl7fAOnMeLo746KyLWFvVvwzSkw43QnreT6UZCd6RYpiUVQRF8Z4MwULaL
	F6rWFbjqfDaMpJEUTP57bddHRBEKzpD8HCLPlq9wbM9uiY3KQcFyEMAS1n6989G3oag3SDd0J/tBH
	2mI8ZPXg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR1Yl-00000007QSr-2tTY;
	Tue, 09 Jul 2024 03:30:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/10] ufs: Convert ufs_set_link() and ufss_dotdot() to take a folio
Date: Tue,  9 Jul 2024 04:30:22 +0100
Message-ID: <20240709033029.1769992-6-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709033029.1769992-1-willy@infradead.org>
References: <20240709033029.1769992-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This matches ext2 and removes a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/dir.c   | 26 +++++++++++---------------
 fs/ufs/namei.c | 16 ++++++++--------
 fs/ufs/ufs.h   |  4 ++--
 3 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index fb56a00b622c..6fcca4dd064a 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -89,23 +89,22 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 
 /* Releases the page */
 void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
-		  struct page *page, struct inode *inode,
+		  struct folio *folio, struct inode *inode,
 		  bool update_times)
 {
-	loff_t pos = page_offset(page) +
-			(char *) de - (char *) page_address(page);
+	loff_t pos = folio_pos(folio) + offset_in_folio(folio, de);
 	unsigned len = fs16_to_cpu(dir->i_sb, de->d_reclen);
 	int err;
 
-	lock_page(page);
-	err = ufs_prepare_chunk(page, pos, len);
+	folio_lock(folio);
+	err = ufs_prepare_chunk(&folio->page, pos, len);
 	BUG_ON(err);
 
 	de->d_ino = cpu_to_fs32(dir->i_sb, inode->i_ino);
 	ufs_set_de_type(dir->i_sb, de, inode->i_mode);
 
-	ufs_commit_chunk(page, pos, len);
-	ufs_put_page(page);
+	ufs_commit_chunk(&folio->page, pos, len);
+	ufs_put_page(&folio->page);
 	if (update_times)
 		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
@@ -233,17 +232,14 @@ ufs_next_entry(struct super_block *sb, struct ufs_dir_entry *p)
 					fs16_to_cpu(sb, p->d_reclen));
 }
 
-struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
+struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct folio **foliop)
 {
-	struct folio *folio;
-	struct ufs_dir_entry *de = ufs_get_folio(dir, 0, &folio);
+	struct ufs_dir_entry *de = ufs_get_folio(dir, 0, foliop);
 
-	if (IS_ERR(de))
-		return NULL;
-	de = ufs_next_entry(dir->i_sb, de);
-	*p = &folio->page;
+	if (!IS_ERR(de))
+		return ufs_next_entry(dir->i_sb, de);
 
-	return de;
+	return NULL;
 }
 
 /*
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 53e9bfad54df..1759b710d831 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -249,7 +249,7 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 {
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
-	struct page *dir_page = NULL;
+	struct folio *dir_folio = NULL;
 	struct ufs_dir_entry * dir_de = NULL;
 	struct folio *old_folio;
 	struct ufs_dir_entry *old_de;
@@ -264,7 +264,7 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	if (S_ISDIR(old_inode->i_mode)) {
 		err = -EIO;
-		dir_de = ufs_dotdot(old_inode, &dir_page);
+		dir_de = ufs_dotdot(old_inode, &dir_folio);
 		if (!dir_de)
 			goto out_old;
 	}
@@ -281,7 +281,7 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		new_de = ufs_find_entry(new_dir, &new_dentry->d_name, &new_folio);
 		if (!new_de)
 			goto out_dir;
-		ufs_set_link(new_dir, new_de, &new_folio->page, old_inode, 1);
+		ufs_set_link(new_dir, new_de, new_folio, old_inode, 1);
 		inode_set_ctime_current(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
@@ -305,10 +305,10 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	if (dir_de) {
 		if (old_dir != new_dir)
-			ufs_set_link(old_inode, dir_de, dir_page, new_dir, 0);
+			ufs_set_link(old_inode, dir_de, dir_folio, new_dir, 0);
 		else {
-			kunmap(dir_page);
-			put_page(dir_page);
+			kunmap(&dir_folio->page);
+			folio_put(dir_folio);
 		}
 		inode_dec_link_count(old_dir);
 	}
@@ -317,8 +317,8 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 out_dir:
 	if (dir_de) {
-		kunmap(dir_page);
-		put_page(dir_page);
+		kunmap(&dir_folio->page);
+		folio_put(dir_folio);
 	}
 out_old:
 	kunmap(&old_folio->page);
diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
index 161fe0bb6fd1..1ad992ab2855 100644
--- a/fs/ufs/ufs.h
+++ b/fs/ufs/ufs.h
@@ -107,9 +107,9 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *, const struct qstr *,
 		struct folio **);
 int ufs_delete_entry(struct inode *, struct ufs_dir_entry *, struct page *);
 int ufs_empty_dir(struct inode *);
-struct ufs_dir_entry *ufs_dotdot(struct inode *, struct page **);
+struct ufs_dir_entry *ufs_dotdot(struct inode *, struct folio **);
 void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
-		struct page *page, struct inode *inode, bool update_times);
+		struct folio *folio, struct inode *inode, bool update_times);
 
 /* file.c */
 extern const struct inode_operations ufs_file_inode_operations;
-- 
2.43.0


