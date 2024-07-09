Return-Path: <linux-fsdevel+bounces-23409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF15192BDBC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9C11C22585
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDD719CD03;
	Tue,  9 Jul 2024 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cAyqJZuD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9982119CCE8
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537400; cv=none; b=QagLVDwGVK13FeQZxi13D9sBREk44MHanJrKaZ49cz6eyp4wprPkHV4gsehsT4Q6QsbH+k2k3/gYwLUi1teK9TgRCEESOHe2UY9csnPRYGqqnU9XmqV6s2CnVeLeMwMxLK1ZKoUjzm8dlDglVBgyn0KsrZUhYwvzBBBQNanycsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537400; c=relaxed/simple;
	bh=jssJsGARWMzSFAhp9zZZJUdYG2vwfUG0aQIxNKhL3nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcoDPadY25Z/CUhoUXXibqfMkInumiS4puVleR6z5wKFtH8O7GC4fJ6LTY+FCnlc1njihvF2tw77Dm9hj+wU7ZdHTzvVsrIqHJ9zE2cC0nho4DwJk8hnvGMgTzWULsASvvZSMa+IWQJ7uOx9KYCn9PVkITe3QgLBh97RpDuPOX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cAyqJZuD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BE9x7wCw8UMWOEVAiCw3SIS/KUZX7ZNyTILs/3gwvOk=; b=cAyqJZuDWd9MoGB2qwjY+8tnhT
	UG9/dYI8L3dC/u6xf2kN0XE8Jy9H2N7Grj26CDmmIiPwpflgsMbq00x241+RzCY7prxrzoVv8wWEV
	iyt73sHeyuQzTfhQ1gpp5tzKVfF0ZRk0w5EtuG7k6dpTRX+Y3EXoZvJ3pihaigciGfCHaUR95XnJE
	XokMXmXyEFBjxnpIKZf2RqkSwmZJlNNa4Sgcz/hRcSVWql5F3mn+mmG6oHYsFnQr/1hC18G4HMw2B
	je6sfh47zEqJJrKEIOtUN2TvIodNy3IpTPNzmRRCQ94baCUGW+5yoUWw83X70/5kMnSUIUC3fTBHD
	2qRD068A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRCN9-00000007zry-3GUB;
	Tue, 09 Jul 2024 15:03:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/7] sysv: Convert sysv_set_link() and sysv_dotdot() to take a folio
Date: Tue,  9 Jul 2024 16:03:08 +0100
Message-ID: <20240709150314.1906109-4-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709150314.1906109-1-willy@infradead.org>
References: <20240709150314.1906109-1-willy@infradead.org>
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
 fs/sysv/dir.c   | 23 ++++++++++-------------
 fs/sysv/namei.c | 10 +++++-----
 fs/sysv/sysv.h  |  4 ++--
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 5b2e3c7c2971..ebccf7bb5b69 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -327,21 +327,21 @@ int sysv_empty_dir(struct inode * inode)
 }
 
 /* Releases the page */
-int sysv_set_link(struct sysv_dir_entry *de, struct page *page,
-	struct inode *inode)
+int sysv_set_link(struct sysv_dir_entry *de, struct folio *folio,
+		struct inode *inode)
 {
-	struct inode *dir = page->mapping->host;
-	loff_t pos = page_offset(page) + offset_in_page(de);
+	struct inode *dir = folio->mapping->host;
+	loff_t pos = folio_pos(folio) + offset_in_folio(folio, de);
 	int err;
 
-	lock_page(page);
-	err = sysv_prepare_chunk(page, pos, SYSV_DIRSIZE);
+	folio_lock(folio);
+	err = sysv_prepare_chunk(&folio->page, pos, SYSV_DIRSIZE);
 	if (err) {
-		unlock_page(page);
+		folio_unlock(folio);
 		return err;
 	}
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
-	dir_commit_chunk(page, pos, SYSV_DIRSIZE);
+	dir_commit_chunk(&folio->page, pos, SYSV_DIRSIZE);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	return sysv_handle_dirsync(inode);
@@ -354,15 +354,12 @@ int sysv_set_link(struct sysv_dir_entry *de, struct page *page,
  * sysv_dotdot() acts as a call to dir_get_folio() and must be treated
  * accordingly for nesting purposes.
  */
-struct sysv_dir_entry *sysv_dotdot(struct inode *dir, struct page **p)
+struct sysv_dir_entry *sysv_dotdot(struct inode *dir, struct folio **foliop)
 {
-	struct folio *folio;
-
-	struct sysv_dir_entry *de = dir_get_folio(dir, 0, &folio);
+	struct sysv_dir_entry *de = dir_get_folio(dir, 0, foliop);
 
 	if (IS_ERR(de))
 		return NULL;
-	*p = &folio->page;
 	/* ".." is the second directory entry */
 	return de + 1;
 }
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index 970043fe49ee..ef4d91431225 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -194,7 +194,7 @@ static int sysv_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 {
 	struct inode * old_inode = d_inode(old_dentry);
 	struct inode * new_inode = d_inode(new_dentry);
-	struct page * dir_page = NULL;
+	struct folio *dir_folio;
 	struct sysv_dir_entry * dir_de = NULL;
 	struct folio *old_folio;
 	struct sysv_dir_entry * old_de;
@@ -209,7 +209,7 @@ static int sysv_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	if (S_ISDIR(old_inode->i_mode)) {
 		err = -EIO;
-		dir_de = sysv_dotdot(old_inode, &dir_page);
+		dir_de = sysv_dotdot(old_inode, &dir_folio);
 		if (!dir_de)
 			goto out_old;
 	}
@@ -226,7 +226,7 @@ static int sysv_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		new_de = sysv_find_entry(new_dentry, &new_folio);
 		if (!new_de)
 			goto out_dir;
-		err = sysv_set_link(new_de, &new_folio->page, old_inode);
+		err = sysv_set_link(new_de, new_folio, old_inode);
 		folio_release_kmap(new_folio, new_de);
 		if (err)
 			goto out_dir;
@@ -249,14 +249,14 @@ static int sysv_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	mark_inode_dirty(old_inode);
 
 	if (dir_de) {
-		err = sysv_set_link(dir_de, dir_page, new_dir);
+		err = sysv_set_link(dir_de, dir_folio, new_dir);
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
diff --git a/fs/sysv/sysv.h b/fs/sysv/sysv.h
index be15c659a027..ee90af7dbed9 100644
--- a/fs/sysv/sysv.h
+++ b/fs/sysv/sysv.h
@@ -153,9 +153,9 @@ int sysv_add_link(struct dentry *, struct inode *);
 int sysv_delete_entry(struct sysv_dir_entry *, struct page *);
 int sysv_make_empty(struct inode *, struct inode *);
 int sysv_empty_dir(struct inode *);
-int sysv_set_link(struct sysv_dir_entry *, struct page *,
+int sysv_set_link(struct sysv_dir_entry *, struct folio *,
 			struct inode *);
-struct sysv_dir_entry *sysv_dotdot(struct inode *, struct page **);
+struct sysv_dir_entry *sysv_dotdot(struct inode *, struct folio **);
 ino_t sysv_inode_by_name(struct dentry *);
 
 
-- 
2.43.0


