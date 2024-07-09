Return-Path: <linux-fsdevel+bounces-23347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B64E592AEC0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 05:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69EE91F22B99
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 03:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E4012C49B;
	Tue,  9 Jul 2024 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G/BXDjDt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60685849C
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495836; cv=none; b=DPYJEh57jvNwhFJfbdjeX7s3s/Ud8mw5lm6CB/mP94sr8iCSJNaKS4IQYe/V4yUdHcNKkMCKE0uqobXXdM8sUVHI2/XXTk3/pk2TJcZhp9j1874Z4YR2XQB0i2yXgvxgry3v4pXCevMg4i6ebUrivdgXA+Knxe4DokHLE7TGg/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495836; c=relaxed/simple;
	bh=67hxrAtFvOWGIJAYRGolctFyKYVySX3pIW8gqzasJ3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfelSEtb0LlaO6twnNNXEzPRa1ImsJt54aj6lAcQKvl6CqgnYpBGgRzGhDInbPmFNUdCrHtQN6wRu9TeQ9wGKTGjQgJPoDFZlpezFj03VP8Mcw2mHAdA4gO1DhLS3nb0idyG1GKsNzLM9IbeaW0iJ68pUDzTJ//eKJT3rNRUp5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G/BXDjDt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=wiPlt8CPgEZD6LleA4Arv3XM/aGWZNuxt60+mAY9AsM=; b=G/BXDjDtvVWFwR0RZAT66X0dS9
	pN7Zcd+2ip031W7OJgfk+TSeYmCyrOgNDCo6gVBVwP61othdVH+0k0RLh7mQvLhmg0EY8JogL+hSW
	/UuYdtyTN/IrqaTeCno/1dhIoJ5fvUpS8k/cVRp6pTJusGcGdLhehbEtNMBDGcC2sl2QX7HZRpHhJ
	FDFO2HEYqw5lldcsKDwf6Jz4U6FV0vmrt6uvcEgTrBKOxCt0c6WYrgM4U+mRuy42SfUKPQrd/3jPX
	hFlCFvCzyyP2lUS/69yyU8T+dAeHBBlzoKwr445+qcAXtOdtkcakpD1tivsiyOTtUEK5CVrJpw/lS
	IxeYGq0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR1Yl-00000007QSy-3M7V;
	Tue, 09 Jul 2024 03:30:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 06/10] ufs: Convert ufs_delete_entry() to work on a folio
Date: Tue,  9 Jul 2024 04:30:23 +0100
Message-ID: <20240709033029.1769992-7-willy@infradead.org>
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

Match ext2 and remove a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/dir.c   | 29 ++++++++++++++++-------------
 fs/ufs/namei.c |  4 ++--
 fs/ufs/ufs.h   |  2 +-
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 6fcca4dd064a..945fff87b385 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -485,19 +485,23 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
  * previous entry.
  */
 int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
-		     struct page * page)
+		     struct folio *folio)
 {
 	struct super_block *sb = inode->i_sb;
-	char *kaddr = page_address(page);
-	unsigned from = ((char*)dir - kaddr) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
-	unsigned to = ((char*)dir - kaddr) + fs16_to_cpu(sb, dir->d_reclen);
+	size_t from, to;
+	char *kaddr;
 	loff_t pos;
-	struct ufs_dir_entry *pde = NULL;
-	struct ufs_dir_entry *de = (struct ufs_dir_entry *) (kaddr + from);
+	struct ufs_dir_entry *de, *pde = NULL;
 	int err;
 
 	UFSD("ENTER\n");
 
+	from = offset_in_folio(folio, dir);
+	to = from + fs16_to_cpu(sb, dir->d_reclen);
+	kaddr = (char *)dir - from;
+	from &= ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
+	de = (struct ufs_dir_entry *) (kaddr + from);
+
 	UFSD("ino %u, reclen %u, namlen %u, name %s\n",
 	      fs32_to_cpu(sb, de->d_ino),
 	      fs16_to_cpu(sb, de->d_reclen),
@@ -514,21 +518,20 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 		de = ufs_next_entry(sb, de);
 	}
 	if (pde)
-		from = (char*)pde - (char*)page_address(page);
-
-	pos = page_offset(page) + from;
-	lock_page(page);
-	err = ufs_prepare_chunk(page, pos, to - from);
+		from = offset_in_folio(folio, pde);
+	pos = folio_pos(folio) + from;
+	folio_lock(folio);
+	err = ufs_prepare_chunk(&folio->page, pos, to - from);
 	BUG_ON(err);
 	if (pde)
 		pde->d_reclen = cpu_to_fs16(sb, to - from);
 	dir->d_ino = 0;
-	ufs_commit_chunk(page, pos, to - from);
+	ufs_commit_chunk(&folio->page, pos, to - from);
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 	err = ufs_handle_dirsync(inode);
 out:
-	ufs_put_page(page);
+	ufs_put_page(&folio->page);
 	UFSD("EXIT\n");
 	return err;
 }
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 1759b710d831..a9b0c15de067 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -216,7 +216,7 @@ static int ufs_unlink(struct inode *dir, struct dentry *dentry)
 	if (!de)
 		goto out;
 
-	err = ufs_delete_entry(dir, de, &folio->page);
+	err = ufs_delete_entry(dir, de, folio);
 	if (err)
 		goto out;
 
@@ -300,7 +300,7 @@ static int ufs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	 */
 	inode_set_ctime_current(old_inode);
 
-	ufs_delete_entry(old_dir, old_de, &old_folio->page);
+	ufs_delete_entry(old_dir, old_de, old_folio);
 	mark_inode_dirty(old_inode);
 
 	if (dir_de) {
diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
index 1ad992ab2855..a2c762cb65a0 100644
--- a/fs/ufs/ufs.h
+++ b/fs/ufs/ufs.h
@@ -105,7 +105,7 @@ ino_t ufs_inode_by_name(struct inode *, const struct qstr *);
 int ufs_make_empty(struct inode *, struct inode *);
 struct ufs_dir_entry *ufs_find_entry(struct inode *, const struct qstr *,
 		struct folio **);
-int ufs_delete_entry(struct inode *, struct ufs_dir_entry *, struct page *);
+int ufs_delete_entry(struct inode *, struct ufs_dir_entry *, struct folio *);
 int ufs_empty_dir(struct inode *);
 struct ufs_dir_entry *ufs_dotdot(struct inode *, struct folio **);
 void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
-- 
2.43.0


