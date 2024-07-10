Return-Path: <linux-fsdevel+bounces-23459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2363992C7E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 03:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92798B216C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 01:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356229476;
	Wed, 10 Jul 2024 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AtgtjWOn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9489E1C32
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574610; cv=none; b=m3+02Kbl6SsiAOS7Y5RirIMNhxLDmnk7mojFYHXkRiNCvclmOV3A74TgYpsaOyrFgMxf5J32QRcjPITxedFKjkswUKaK6TmH88MAcgVdnq3ZOMMWwq5iPa4IFOeOIO+0efjeaMcIPI4s6OksvssLTY+o8TIwHpg24oUUIFxZj14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574610; c=relaxed/simple;
	bh=4Uqbeq9H77rqiyVY/EWYQ7o8CegpGuL9dA0nBX4iRxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGUGV7DKA2g7DRAnhIsNChfpnDIyZqyALevilPvOIA8LelUwIQiuSDQQx7hQ7lokGlGnimovq+ZCgNrhT30y0tPK771Z6NQ/7IgySJZ+oVoU7Py1gZd8WOfJ+kzywDczniheY1cBDWGqGDTqlkeCcILPLTgDeJ0QzJEdwUFoGnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AtgtjWOn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=eYh0Ab03KUbPmTadz0BnuNQytEK0MKxv/++YJo48SK8=; b=AtgtjWOnTlLZ07pakbi/YkB5GM
	g42JOEbkNbIHs5WTh1Qlz0EAuMjE5go9TVP5nV5MyRIyIyPy+FdH2FOte+7SYEeRlLG9cRGy8GJ6U
	Wq/n692JoAxu4yooGl/rAsH7P1FX8SbiQ1xvxev7eRVvooOLm2tZdc5SfSji5uLa3I87G4Lh3atkJ
	9HaPQQJqVrwSGwJXWGm+AVmrP8odTB/sBEXtnBsub0BgoAuNMRfs0wzOEoVqCEyvqNVkOzapGJxjD
	C9G4CP3AWlJj8JPhRHyhv0GC/6VfpXDFYoqe59JsUcqzvftEtRtpB95aPnzF2AaAbW/4WDF4U0k7i
	ocqZf0Rg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRM3J-00000008Ya2-2agQ;
	Wed, 10 Jul 2024 01:23:25 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/7] minifs: Convert minix_set_link() and minix_dotdot() to take a folio
Date: Wed, 10 Jul 2024 02:23:17 +0100
Message-ID: <20240710012323.2039519-4-willy@infradead.org>
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

This matches ext2 and removes a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/minix/dir.c   | 23 ++++++++++-------------
 fs/minix/minix.h |  4 ++--
 fs/minix/namei.c | 10 +++++-----
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index 3bbfac32d520..c32d182c2d74 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -404,40 +404,37 @@ int minix_empty_dir(struct inode * inode)
 }
 
 /* Releases the page */
-int minix_set_link(struct minix_dir_entry *de, struct page *page,
+int minix_set_link(struct minix_dir_entry *de, struct folio *folio,
 		struct inode *inode)
 {
-	struct inode *dir = page->mapping->host;
+	struct inode *dir = folio->mapping->host;
 	struct minix_sb_info *sbi = minix_sb(dir->i_sb);
-	loff_t pos = page_offset(page) + offset_in_page(de);
+	loff_t pos = folio_pos(folio) + offset_in_folio(folio, de);
 	int err;
 
-	lock_page(page);
-	err = minix_prepare_chunk(page, pos, sbi->s_dirsize);
+	folio_lock(folio);
+	err = minix_prepare_chunk(&folio->page, pos, sbi->s_dirsize);
 	if (err) {
-		unlock_page(page);
+		folio_unlock(folio);
 		return err;
 	}
 	if (sbi->s_version == MINIX_V3)
 		((minix3_dirent *)de)->inode = inode->i_ino;
 	else
 		de->inode = inode->i_ino;
-	dir_commit_chunk(page, pos, sbi->s_dirsize);
+	dir_commit_chunk(&folio->page, pos, sbi->s_dirsize);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	return minix_handle_dirsync(dir);
 }
 
-struct minix_dir_entry * minix_dotdot (struct inode *dir, struct page **p)
+struct minix_dir_entry *minix_dotdot(struct inode *dir, struct folio **foliop)
 {
-	struct folio *folio;
 	struct minix_sb_info *sbi = minix_sb(dir->i_sb);
-	struct minix_dir_entry *de = dir_get_folio(dir, 0, &folio);
+	struct minix_dir_entry *de = dir_get_folio(dir, 0, foliop);
 
-	if (!IS_ERR(de)) {
-		*p = &folio->page;
+	if (!IS_ERR(de))
 		return minix_next_entry(de, sbi);
-	}
 	return NULL;
 }
 
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index a290dd483e69..6ed34209ed33 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -69,9 +69,9 @@ int minix_add_link(struct dentry*, struct inode*);
 int minix_delete_entry(struct minix_dir_entry*, struct page*);
 int minix_make_empty(struct inode*, struct inode*);
 int minix_empty_dir(struct inode*);
-int minix_set_link(struct minix_dir_entry *de, struct page *page,
+int minix_set_link(struct minix_dir_entry *de, struct folio *folio,
 		struct inode *inode);
-struct minix_dir_entry *minix_dotdot(struct inode*, struct page**);
+struct minix_dir_entry *minix_dotdot(struct inode*, struct folio **);
 ino_t minix_inode_by_name(struct dentry*);
 
 extern const struct inode_operations minix_file_inode_operations;
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 117264877bd7..ba82fa3332f1 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -180,7 +180,7 @@ static int minix_rename(struct mnt_idmap *idmap,
 {
 	struct inode * old_inode = d_inode(old_dentry);
 	struct inode * new_inode = d_inode(new_dentry);
-	struct page * dir_page = NULL;
+	struct folio * dir_folio = NULL;
 	struct minix_dir_entry * dir_de = NULL;
 	struct folio *old_folio;
 	struct minix_dir_entry * old_de;
@@ -195,7 +195,7 @@ static int minix_rename(struct mnt_idmap *idmap,
 
 	if (S_ISDIR(old_inode->i_mode)) {
 		err = -EIO;
-		dir_de = minix_dotdot(old_inode, &dir_page);
+		dir_de = minix_dotdot(old_inode, &dir_folio);
 		if (!dir_de)
 			goto out_old;
 	}
@@ -212,7 +212,7 @@ static int minix_rename(struct mnt_idmap *idmap,
 		new_de = minix_find_entry(new_dentry, &new_folio);
 		if (!new_de)
 			goto out_dir;
-		err = minix_set_link(new_de, &new_folio->page, old_inode);
+		err = minix_set_link(new_de, new_folio, old_inode);
 		folio_release_kmap(new_folio, new_de);
 		if (err)
 			goto out_dir;
@@ -235,13 +235,13 @@ static int minix_rename(struct mnt_idmap *idmap,
 	mark_inode_dirty(old_inode);
 
 	if (dir_de) {
-		err = minix_set_link(dir_de, dir_page, new_dir);
+		err = minix_set_link(dir_de, dir_folio, new_dir);
 		if (!err)
 			inode_dec_link_count(old_dir);
 	}
 out_dir:
 	if (dir_de)
-		unmap_and_put_page(dir_page, dir_de);
+		folio_release_kmap(dir_folio, dir_de);
 out_old:
 	folio_release_kmap(old_folio, old_de);
 out:
-- 
2.43.0


