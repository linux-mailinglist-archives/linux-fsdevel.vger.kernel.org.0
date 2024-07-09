Return-Path: <linux-fsdevel+bounces-23344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B415892AEBE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 05:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350D21F220B4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 03:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F2712C481;
	Tue,  9 Jul 2024 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I7Yh/07Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60659A21
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495835; cv=none; b=DFFCpXRKfNly708zje0R4zPFDM8QpqZdYEqiCdkof51sgVrEdV/INV+NNsForavRuD2M7fcoaKgk86xzwe6JFWSOpMI8b2A1Puso9uHMUAqHB05R7ntST8utFQ+WB8aRuEXf46FwOPWItXK3fpKqhHCHVg0INaaHQSyrkoAfLYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495835; c=relaxed/simple;
	bh=wSgAdKCZVERH9++pxvVYTnzVoL7awE6dEBYb1MVz5+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6foZJN3b9QfD1x59aiRULUcWyZKy53q3F4Xmais4hKqpfrlzgjRbYu8sgwHx8eF+arX51/Gv5dzppeJcIxhcWiKbO7gO3kSDakwwoqRGS+g1z6RfcjCtzHeVLe+PvD7NGTl0qUkBz3TE+3e7CV3TXW7sVS0m9L3UY6kmF+2lEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I7Yh/07Y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=F9Hhwuu9VH/xpU90hmF/lviEiO2kLB3Vqv+u/0gFbpk=; b=I7Yh/07YebnBUBuos5KuZwlAPY
	3mLCHJCYu9TGDPD90Gax45UGDqIV2+5hXqgSW4yWA5Pyaadcvp1/J3WUJyF/OMJwppdkKzZRPCmFu
	LosozNoB8X2DQV0lRzP+TkphMroXIn2B8872LI/kZLx1zAaCpAiemqacNZSAznU0jbG7CS0YCZd0G
	HPMt/BOjWykfqmRO8Flv5uK7d8dDr+5qzbN/4qIxTIfJlJVBKpAzz42KP35GUoJVBbBR98Kujwi/D
	DI/QYmT0c/A5AxyzqCZ6Cds6J+AEfBem1m3rd9RxqQn0SWnkr5BPOR4BD/tFS3eVT5Kgrn3hjsm1H
	ogrGQ+pw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR1Yl-00000007QSk-2KSu;
	Tue, 09 Jul 2024 03:30:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/10] ufs: Convert ufs_find_entry() to take a folio
Date: Tue,  9 Jul 2024 04:30:21 +0100
Message-ID: <20240709033029.1769992-5-willy@infradead.org>
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

This matches ext2 and pushes the use of folios out by one layer.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/dir.c   | 17 ++++++-----------
 fs/ufs/namei.c | 22 +++++++++++-----------
 fs/ufs/ufs.h   | 20 +++++++++++---------
 3 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 287cab597cc1..fb56a00b622c 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -76,12 +76,12 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 {
 	ino_t res = 0;
 	struct ufs_dir_entry *de;
-	struct page *page;
+	struct folio *folio;
 	
-	de = ufs_find_entry(dir, qstr, &page);
+	de = ufs_find_entry(dir, qstr, &folio);
 	if (de) {
 		res = fs32_to_cpu(dir->i_sb, de->d_ino);
-		ufs_put_page(page);
+		ufs_put_page(&folio->page);
 	}
 	return res;
 }
@@ -255,7 +255,7 @@ struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
  * Entry is guaranteed to be valid.
  */
 struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
-				     struct page **res_page)
+				     struct folio **foliop)
 {
 	struct super_block *sb = dir->i_sb;
 	const unsigned char *name = qstr->name;
@@ -263,7 +263,6 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 	unsigned reclen = UFS_DIR_REC_LEN(namelen);
 	unsigned long start, n;
 	unsigned long npages = dir_pages(dir);
-	struct folio *folio;
 	struct ufs_inode_info *ui = UFS_I(dir);
 	struct ufs_dir_entry *de;
 
@@ -272,16 +271,13 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 	if (npages == 0 || namelen > UFS_MAXNAMLEN)
 		goto out;
 
-	/* OFFSET_CACHE */
-	*res_page = NULL;
-
 	start = ui->i_dir_start_lookup;
 
 	if (start >= npages)
 		start = 0;
 	n = start;
 	do {
-		char *kaddr = ufs_get_folio(dir, n, &folio);
+		char *kaddr = ufs_get_folio(dir, n, foliop);
 
 		if (!IS_ERR(kaddr)) {
 			de = (struct ufs_dir_entry *)kaddr;
@@ -291,7 +287,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 					goto found;
 				de = ufs_next_entry(sb, de);
 			}
-			ufs_put_page(&folio->page);
+			ufs_put_page(&(*foliop)->page);
 		}
 		if (++n >= npages)
 			n = 0;
@@ -300,7 +296,6 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
 	return NULL;
 
 found:
-	*res_page = &folio->page;
 	ui->i_dir_start_lookup = n;
 	return de;
 }
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 9cad29463791..53e9bfad54df 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -209,14 +209,14 @@ static int ufs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode * inode = d_inode(dentry);
 	struct ufs_dir_entry *de;
-	struct page *page;
+	struct folio *folio;
 	int err = -ENOENT;
 
-	de = ufs_find_entry(dir, &dentry->d_name, &page);
+	de = ufs_find_entry(dir, &dentry->d_name, &folio);
 	if (!de)
 		goto out;
 
-	err = ufs_delete_entry(dir, de, page);
+	err = ufs_delete_entry(dir, de, &folio->page);
 	if (err)
 		goto out;
 
@@ -251,14 +251,14 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct inode *new_inode = d_inode(new_dentry);
 	struct page *dir_page = NULL;
 	struct ufs_dir_entry * dir_de = NULL;
-	struct page *old_page;
+	struct folio *old_folio;
 	struct ufs_dir_entry *old_de;
 	int err = -ENOENT;
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
 
-	old_de = ufs_find_entry(old_dir, &old_dentry->d_name, &old_page);
+	old_de = ufs_find_entry(old_dir, &old_dentry->d_name, &old_folio);
 	if (!old_de)
 		goto out;
 
@@ -270,7 +270,7 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	}
 
 	if (new_inode) {
-		struct page *new_page;
+		struct folio *new_folio;
 		struct ufs_dir_entry *new_de;
 
 		err = -ENOTEMPTY;
@@ -278,10 +278,10 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			goto out_dir;
 
 		err = -ENOENT;
-		new_de = ufs_find_entry(new_dir, &new_dentry->d_name, &new_page);
+		new_de = ufs_find_entry(new_dir, &new_dentry->d_name, &new_folio);
 		if (!new_de)
 			goto out_dir;
-		ufs_set_link(new_dir, new_de, new_page, old_inode, 1);
+		ufs_set_link(new_dir, new_de, &new_folio->page, old_inode, 1);
 		inode_set_ctime_current(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
@@ -300,7 +300,7 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	 */
 	inode_set_ctime_current(old_inode);
 
-	ufs_delete_entry(old_dir, old_de, old_page);
+	ufs_delete_entry(old_dir, old_de, &old_folio->page);
 	mark_inode_dirty(old_inode);
 
 	if (dir_de) {
@@ -321,8 +321,8 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		put_page(dir_page);
 	}
 out_old:
-	kunmap(old_page);
-	put_page(old_page);
+	kunmap(&old_folio->page);
+	folio_put(old_folio);
 out:
 	return err;
 }
diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
index 6b499180643b..161fe0bb6fd1 100644
--- a/fs/ufs/ufs.h
+++ b/fs/ufs/ufs.h
@@ -99,15 +99,17 @@ extern void ufs_put_cylinder (struct super_block *, unsigned);
 
 /* dir.c */
 extern const struct inode_operations ufs_dir_inode_operations;
-extern int ufs_add_link (struct dentry *, struct inode *);
-extern ino_t ufs_inode_by_name(struct inode *, const struct qstr *);
-extern int ufs_make_empty(struct inode *, struct inode *);
-extern struct ufs_dir_entry *ufs_find_entry(struct inode *, const struct qstr *, struct page **);
-extern int ufs_delete_entry(struct inode *, struct ufs_dir_entry *, struct page *);
-extern int ufs_empty_dir (struct inode *);
-extern struct ufs_dir_entry *ufs_dotdot(struct inode *, struct page **);
-extern void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
-			 struct page *page, struct inode *inode, bool update_times);
+
+int ufs_add_link(struct dentry *, struct inode *);
+ino_t ufs_inode_by_name(struct inode *, const struct qstr *);
+int ufs_make_empty(struct inode *, struct inode *);
+struct ufs_dir_entry *ufs_find_entry(struct inode *, const struct qstr *,
+		struct folio **);
+int ufs_delete_entry(struct inode *, struct ufs_dir_entry *, struct page *);
+int ufs_empty_dir(struct inode *);
+struct ufs_dir_entry *ufs_dotdot(struct inode *, struct page **);
+void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
+		struct page *page, struct inode *inode, bool update_times);
 
 /* file.c */
 extern const struct inode_operations ufs_file_inode_operations;
-- 
2.43.0


