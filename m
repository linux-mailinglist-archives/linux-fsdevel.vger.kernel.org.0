Return-Path: <linux-fsdevel+bounces-23408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D392992BDBB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025021C23BE6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8162419D882;
	Tue,  9 Jul 2024 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="txqTak/0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD8B1836DC
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537399; cv=none; b=Bhix1eHqYMsdYm/Z2g7ATiRs6YxqpCTtUhDCJP2V76Y/h9Nicp7jCr65IM2/+zzRRq2VAzEvjoiG+NV5K42PO09B51Vodb/gfB9+PX+GPd0WYVtNooyN5NCn+usRS/5tjBe5VVZPX0HphtGAQN0RdmdGGDf0ziPqHg+VgpjWD3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537399; c=relaxed/simple;
	bh=e4L1wh7mbuGZ0ej7AAcNTWMdvFVzi18WV65B6RximHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNWmYFvM03Pj5ECPWbHRVwdv0SmTbEinF1k88YiQvdmF6sa6qTaL0u8GgzUKYC2IRdzk/lIG4aWN+LQg8yVUTEyigyQhbQ8/SMXW9pYq+/d95jRMF6GcFUNZ6ho2wuSJiGdh/UA7UNS6/vDOVf6PoN3EQXm7wZT0L+vdr0Q9ue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=txqTak/0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=qWokI/l0Zrn7s5mSXtC70jpneuZ21jD1PZrI1NlOQxA=; b=txqTak/0j5SAkI8H6SX2B4B6j9
	jeSpJHtERYLZo0QwAoC1Lg1Ko6E/yJk4INkZSqpKicqvGm5q+7+hxhTJK9I1/HClIcNMdEo44GNQF
	tVglbwolzltt7Yh0zbiZLxJJrvl6jYIkII2kgRpSP42gtm1NHJel7u3y3kUQers2DwD93rSdkuJ8N
	1tisvzmidl3u/EVklvE43WjBaJNNT7Vq4KxXYvn3nukp+KNRONZ77d0t4H3OKfF88/RyM3okEkubl
	0qZpnx0U4n+t+M50ij4P68gnxTzPiz9DRE2xIOzsxGAxIeMCsSjJe5tbMK0CLaWioyTgfsnfmVNPZ
	4c/jUU2w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRCN9-00000007zru-2mKx;
	Tue, 09 Jul 2024 15:03:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/7] sysv: Convert sysv_find_entry() to take a folio
Date: Tue,  9 Jul 2024 16:03:07 +0100
Message-ID: <20240709150314.1906109-3-willy@infradead.org>
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

Remove a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/sysv/dir.c   | 25 ++++++++++---------------
 fs/sysv/namei.c | 24 ++++++++++++------------
 fs/sysv/sysv.h  | 16 ++++++++--------
 3 files changed, 30 insertions(+), 35 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 1f95f82f8941..5b2e3c7c2971 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -127,39 +127,35 @@ static inline int namecompare(int len, int maxlen,
 /*
  *	sysv_find_entry()
  *
- * finds an entry in the specified directory with the wanted name. It
- * returns the cache buffer in which the entry was found, and the entry
- * itself (as a parameter - res_dir). It does NOT read the inode of the
+ * finds an entry in the specified directory with the wanted name.
+ * It does NOT read the inode of the
  * entry - you'll have to do that yourself if you want to.
  *
- * On Success unmap_and_put_page() should be called on *res_page.
+ * On Success folio_release_kmap() should be called on *foliop.
  *
  * sysv_find_entry() acts as a call to dir_get_folio() and must be treated
  * accordingly for nesting purposes.
  */
-struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_page)
+struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct folio **foliop)
 {
 	const char * name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
 	struct inode * dir = d_inode(dentry->d_parent);
 	unsigned long start, n;
 	unsigned long npages = dir_pages(dir);
-	struct folio *folio = NULL;
 	struct sysv_dir_entry *de;
 
-	*res_page = NULL;
-
 	start = SYSV_I(dir)->i_dir_start_lookup;
 	if (start >= npages)
 		start = 0;
 	n = start;
 
 	do {
-		char *kaddr = dir_get_folio(dir, n, &folio);
+		char *kaddr = dir_get_folio(dir, n, foliop);
 
 		if (!IS_ERR(kaddr)) {
 			de = (struct sysv_dir_entry *)kaddr;
-			kaddr += PAGE_SIZE - SYSV_DIRSIZE;
+			kaddr += folio_size(*foliop) - SYSV_DIRSIZE;
 			for ( ; (char *) de <= kaddr ; de++) {
 				if (!de->inode)
 					continue;
@@ -167,7 +163,7 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_
 							name, de->name))
 					goto found;
 			}
-			folio_release_kmap(folio, kaddr);
+			folio_release_kmap(*foliop, kaddr);
 		}
 
 		if (++n >= npages)
@@ -178,7 +174,6 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_
 
 found:
 	SYSV_I(dir)->i_dir_start_lookup = n;
-	*res_page = &folio->page;
 	return de;
 }
 
@@ -374,13 +369,13 @@ struct sysv_dir_entry *sysv_dotdot(struct inode *dir, struct page **p)
 
 ino_t sysv_inode_by_name(struct dentry *dentry)
 {
-	struct page *page;
-	struct sysv_dir_entry *de = sysv_find_entry (dentry, &page);
+	struct folio *folio;
+	struct sysv_dir_entry *de = sysv_find_entry (dentry, &folio);
 	ino_t res = 0;
 	
 	if (de) {
 		res = fs16_to_cpu(SYSV_SB(dentry->d_sb), de->inode);
-		unmap_and_put_page(page, de);
+		folio_release_kmap(folio, de);
 	}
 	return res;
 }
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index d6b73798071b..970043fe49ee 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -151,20 +151,20 @@ static int sysv_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 static int sysv_unlink(struct inode * dir, struct dentry * dentry)
 {
 	struct inode * inode = d_inode(dentry);
-	struct page * page;
+	struct folio *folio;
 	struct sysv_dir_entry * de;
 	int err;
 
-	de = sysv_find_entry(dentry, &page);
+	de = sysv_find_entry(dentry, &folio);
 	if (!de)
 		return -ENOENT;
 
-	err = sysv_delete_entry(de, page);
+	err = sysv_delete_entry(de, &folio->page);
 	if (!err) {
 		inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
 		inode_dec_link_count(inode);
 	}
-	unmap_and_put_page(page, de);
+	folio_release_kmap(folio, de);
 	return err;
 }
 
@@ -196,14 +196,14 @@ static int sysv_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct inode * new_inode = d_inode(new_dentry);
 	struct page * dir_page = NULL;
 	struct sysv_dir_entry * dir_de = NULL;
-	struct page * old_page;
+	struct folio *old_folio;
 	struct sysv_dir_entry * old_de;
 	int err = -ENOENT;
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
 
-	old_de = sysv_find_entry(old_dentry, &old_page);
+	old_de = sysv_find_entry(old_dentry, &old_folio);
 	if (!old_de)
 		goto out;
 
@@ -215,7 +215,7 @@ static int sysv_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	}
 
 	if (new_inode) {
-		struct page * new_page;
+		struct folio *new_folio;
 		struct sysv_dir_entry * new_de;
 
 		err = -ENOTEMPTY;
@@ -223,11 +223,11 @@ static int sysv_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			goto out_dir;
 
 		err = -ENOENT;
-		new_de = sysv_find_entry(new_dentry, &new_page);
+		new_de = sysv_find_entry(new_dentry, &new_folio);
 		if (!new_de)
 			goto out_dir;
-		err = sysv_set_link(new_de, new_page, old_inode);
-		unmap_and_put_page(new_page, new_de);
+		err = sysv_set_link(new_de, &new_folio->page, old_inode);
+		folio_release_kmap(new_folio, new_de);
 		if (err)
 			goto out_dir;
 		inode_set_ctime_current(new_inode);
@@ -242,7 +242,7 @@ static int sysv_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			inode_inc_link_count(new_dir);
 	}
 
-	err = sysv_delete_entry(old_de, old_page);
+	err = sysv_delete_entry(old_de, &old_folio->page);
 	if (err)
 		goto out_dir;
 
@@ -258,7 +258,7 @@ static int sysv_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (dir_de)
 		unmap_and_put_page(dir_page, dir_de);
 out_old:
-	unmap_and_put_page(old_page, old_de);
+	folio_release_kmap(old_folio, old_de);
 out:
 	return err;
 }
diff --git a/fs/sysv/sysv.h b/fs/sysv/sysv.h
index e3f988b469ee..be15c659a027 100644
--- a/fs/sysv/sysv.h
+++ b/fs/sysv/sysv.h
@@ -148,15 +148,15 @@ extern void sysv_destroy_icache(void);
 
 
 /* dir.c */
-extern struct sysv_dir_entry *sysv_find_entry(struct dentry *, struct page **);
-extern int sysv_add_link(struct dentry *, struct inode *);
-extern int sysv_delete_entry(struct sysv_dir_entry *, struct page *);
-extern int sysv_make_empty(struct inode *, struct inode *);
-extern int sysv_empty_dir(struct inode *);
-extern int sysv_set_link(struct sysv_dir_entry *, struct page *,
+struct sysv_dir_entry *sysv_find_entry(struct dentry *, struct folio **);
+int sysv_add_link(struct dentry *, struct inode *);
+int sysv_delete_entry(struct sysv_dir_entry *, struct page *);
+int sysv_make_empty(struct inode *, struct inode *);
+int sysv_empty_dir(struct inode *);
+int sysv_set_link(struct sysv_dir_entry *, struct page *,
 			struct inode *);
-extern struct sysv_dir_entry *sysv_dotdot(struct inode *, struct page **);
-extern ino_t sysv_inode_by_name(struct dentry *);
+struct sysv_dir_entry *sysv_dotdot(struct inode *, struct page **);
+ino_t sysv_inode_by_name(struct dentry *);
 
 
 extern const struct inode_operations sysv_file_inode_operations;
-- 
2.43.0


