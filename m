Return-Path: <linux-fsdevel+bounces-23458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD9792C7E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 03:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC738282775
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 01:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D428494;
	Wed, 10 Jul 2024 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k65KVAfz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9486810FF
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574610; cv=none; b=lHvw6xBdPYk/zNTMCn9JSM35YTeK1yx5fD4YN6wdQ0zL2dzn3pxLTTH4C9tp8be+9BrXX5dnm5MBo1U/TkEzQEHpXSZDBueNtPO4Ir9DRo4K8ybWyBT3ZTVS5S5bxqkuXIPyJjsDjaIftdOxVWyGbN39kYC8XJAO6VXbF+mHIpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574610; c=relaxed/simple;
	bh=at+hOssBnO21BOqu4rSvyICPpJkqsx5QjEhsfVofSQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uI7iZt7dPEXYYm5XZs0ctsXA8YaToIXQzlngGETVq8rcKVGmhPxeUsQeUipQlajZsi/ZcWmCZhSvdxk5oTMcLfy25bWFveH6LWhtIe6RaWoP7dFCjX5HLMB3P2AJNO0M8xuHyNuD1mVqowYtEdMiULqStM42qSbRWm24toPwzOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k65KVAfz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=myylJ+DP1qvMQUFEQCUZX8G3MEKHMxoSQ/ebW6yjIh4=; b=k65KVAfz1q5KRC9Yahuq4b+mzz
	AAwcFRBf7qSsgF1W3WO8Kobs3J6BndIzeGubN+W/uWPicviL1n+eE7dtb60ZP7FTs4FQ+dxK1JeIh
	GGM7trjeWoi4DEYPclYZxt9KFd2emXX9ZLVA0Cr8RYoxzdfOT/lJSeYWAojjkuzS/KSZ2uOjFJIQS
	j8Gptep4L8TuHIwMKbvNtTaxsGm3FYeWbQx35S4KFU+HG9AqCG5ujlOKs8+dnng5aMBhBKSj7yakj
	HsMI3jKe+LBzC5xFBiN7elF3ldy5mwEagc/h5mmYOt8jgLjD5S9aHQtYgD3OFJQ8loYsZrR5Yi8vD
	LunGqq1w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRM3J-00000008YaL-3w29;
	Wed, 10 Jul 2024 01:23:25 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/7] minixfs: Convert minix_prepare_chunk() to take a folio
Date: Wed, 10 Jul 2024 02:23:20 +0100
Message-ID: <20240710012323.2039519-7-willy@infradead.org>
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

All callers now have a folio, so convert minix_prepare_chunk() to
take one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/minix/dir.c   |  8 ++++----
 fs/minix/inode.c |  4 ++--
 fs/minix/minix.h | 24 ++++++++++++------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index 15b3ef1e473c..26bfea508028 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -260,7 +260,7 @@ int minix_add_link(struct dentry *dentry, struct inode *inode)
 
 got_it:
 	pos = folio_pos(folio) + offset_in_folio(folio, p);
-	err = minix_prepare_chunk(&folio->page, pos, sbi->s_dirsize);
+	err = minix_prepare_chunk(folio, pos, sbi->s_dirsize);
 	if (err)
 		goto out_unlock;
 	memcpy (namx, name, namelen);
@@ -292,7 +292,7 @@ int minix_delete_entry(struct minix_dir_entry *de, struct folio *folio)
 	int err;
 
 	folio_lock(folio);
-	err = minix_prepare_chunk(&folio->page, pos, len);
+	err = minix_prepare_chunk(folio, pos, len);
 	if (err) {
 		folio_unlock(folio);
 		return err;
@@ -316,7 +316,7 @@ int minix_make_empty(struct inode *inode, struct inode *dir)
 
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
-	err = minix_prepare_chunk(&folio->page, 0, 2 * sbi->s_dirsize);
+	err = minix_prepare_chunk(folio, 0, 2 * sbi->s_dirsize);
 	if (err) {
 		folio_unlock(folio);
 		goto fail;
@@ -413,7 +413,7 @@ int minix_set_link(struct minix_dir_entry *de, struct folio *folio,
 	int err;
 
 	folio_lock(folio);
-	err = minix_prepare_chunk(&folio->page, pos, sbi->s_dirsize);
+	err = minix_prepare_chunk(folio, pos, sbi->s_dirsize);
 	if (err) {
 		folio_unlock(folio);
 		return err;
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 1c3df63162ef..0002337977e0 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -427,9 +427,9 @@ static int minix_read_folio(struct file *file, struct folio *folio)
 	return block_read_full_folio(folio, minix_get_block);
 }
 
-int minix_prepare_chunk(struct page *page, loff_t pos, unsigned len)
+int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len)
 {
-	return __block_write_begin(page, pos, len, minix_get_block);
+	return __block_write_begin(&folio->page, pos, len, minix_get_block);
 }
 
 static void minix_write_failed(struct address_space *mapping, loff_t to)
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index 063bab8faa6b..d54273c3c9ff 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -42,18 +42,18 @@ struct minix_sb_info {
 	unsigned short s_version;
 };
 
-extern struct inode *minix_iget(struct super_block *, unsigned long);
-extern struct minix_inode * minix_V1_raw_inode(struct super_block *, ino_t, struct buffer_head **);
-extern struct minix2_inode * minix_V2_raw_inode(struct super_block *, ino_t, struct buffer_head **);
-extern struct inode * minix_new_inode(const struct inode *, umode_t);
-extern void minix_free_inode(struct inode * inode);
-extern unsigned long minix_count_free_inodes(struct super_block *sb);
-extern int minix_new_block(struct inode * inode);
-extern void minix_free_block(struct inode *inode, unsigned long block);
-extern unsigned long minix_count_free_blocks(struct super_block *sb);
-extern int minix_getattr(struct mnt_idmap *, const struct path *,
-			 struct kstat *, u32, unsigned int);
-extern int minix_prepare_chunk(struct page *page, loff_t pos, unsigned len);
+struct inode *minix_iget(struct super_block *, unsigned long);
+struct minix_inode *minix_V1_raw_inode(struct super_block *, ino_t, struct buffer_head **);
+struct minix2_inode *minix_V2_raw_inode(struct super_block *, ino_t, struct buffer_head **);
+struct inode *minix_new_inode(const struct inode *, umode_t);
+void minix_free_inode(struct inode *inode);
+unsigned long minix_count_free_inodes(struct super_block *sb);
+int minix_new_block(struct inode *inode);
+void minix_free_block(struct inode *inode, unsigned long block);
+unsigned long minix_count_free_blocks(struct super_block *sb);
+int minix_getattr(struct mnt_idmap *, const struct path *,
+		struct kstat *, u32, unsigned int);
+int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len);
 
 extern void V1_minix_truncate(struct inode *);
 extern void V2_minix_truncate(struct inode *);
-- 
2.43.0


