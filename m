Return-Path: <linux-fsdevel+bounces-23349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A0992AEC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 05:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571B71C20DB0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 03:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304C812CD9B;
	Tue,  9 Jul 2024 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IwYJeKB+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2FE3F8F7
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495836; cv=none; b=DJ2yQZqAM8iXKTG5oCoOIwo2GyHf5RzdH58kJVxTtrWhHFffD3rqPbffZhonssKXcnUclnodTyM3c8IXAel2u95KPKrAYcpMfkO67fz3YQ8vWmMF2sykJu2WBsG2x4iPc1Im8T9hToV8MMzknqW0nASh0U+/EUNaTgIrA5K7Qz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495836; c=relaxed/simple;
	bh=q5XiBYShJOj8iEVsUlhAk9Oxfx1Gqb8GjxB96kAFvFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2k8E/nEPfaz4CtYmsUp/llhoIJINMYPBCVOLi8LG44V0quYxxBpGOgBJHcEfP86kktiVeRCm32nSBFNjjom8ZS6h1drGv2ScuFm2jrPMbWCLEapF4c03MGif2z3ybkLeGeT/eMkw7n1Wt4SJjpYUxCPFn92O/rU5viA3AdIY10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IwYJeKB+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=EmYbS0CiXqHPOHjcs6k7/ZqcK5mONyvKXbw41+0DSnk=; b=IwYJeKB+9QnDuIQllkXtXD2saE
	o3L4Yihd65GSqeJBIbUOGvD4X4EDJ7Z5P1MhFmxNnXUZeGJiA0XwjOQcZyXQyELSg1GUhIZ093uAG
	tBOt+bZCQyNCTWZ008WK6e/7ebncZADnU1CQ8bDPerCc1kLu5WZL3iGGM13jGg5Cd4HvJxcsJKUdy
	DzIHi8TdK1UDmfGrsXsfhkzvJYhuyXD3ODh114zJwp3COZEuOr7ziNW5Z0yrO5m7L27LJku7YUNDe
	j0jpIuXHhqp4U0g2B5NizlSERpqze39I8n/09ud5xkVGBJAObO7C/d+Dd5rxLAsZah0oaupvbkywL
	i9wKKGaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR1Ym-00000007QTC-0OSd;
	Tue, 09 Jul 2024 03:30:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/10] ufs: Convert ufs_prepare_chunk() to take a folio
Date: Tue,  9 Jul 2024 04:30:25 +0100
Message-ID: <20240709033029.1769992-9-willy@infradead.org>
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

All callers now have a folio, so convert ufs_prepare_chunk() to take one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/dir.c   | 8 ++++----
 fs/ufs/inode.c | 4 ++--
 fs/ufs/util.h  | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 6a2a6af38097..a20f66351c66 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -97,7 +97,7 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 	int err;
 
 	folio_lock(folio);
-	err = ufs_prepare_chunk(&folio->page, pos, len);
+	err = ufs_prepare_chunk(folio, pos, len);
 	BUG_ON(err);
 
 	de->d_ino = cpu_to_fs32(dir->i_sb, inode->i_ino);
@@ -366,7 +366,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 
 got_it:
 	pos = folio_pos(folio) + offset_in_folio(folio, de);
-	err = ufs_prepare_chunk(&folio->page, pos, rec_len);
+	err = ufs_prepare_chunk(folio, pos, rec_len);
 	if (err)
 		goto out_unlock;
 	if (de->d_ino) {
@@ -521,7 +521,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 		from = offset_in_folio(folio, pde);
 	pos = folio_pos(folio) + from;
 	folio_lock(folio);
-	err = ufs_prepare_chunk(&folio->page, pos, to - from);
+	err = ufs_prepare_chunk(folio, pos, to - from);
 	BUG_ON(err);
 	if (pde)
 		pde->d_reclen = cpu_to_fs16(sb, to - from);
@@ -549,7 +549,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-	err = ufs_prepare_chunk(&folio->page, 0, chunk_size);
+	err = ufs_prepare_chunk(folio, 0, chunk_size);
 	if (err) {
 		folio_unlock(folio);
 		goto fail;
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index a7bb2e63cdde..0e608fc0d0fd 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -479,9 +479,9 @@ static int ufs_read_folio(struct file *file, struct folio *folio)
 	return block_read_full_folio(folio, ufs_getfrag_block);
 }
 
-int ufs_prepare_chunk(struct page *page, loff_t pos, unsigned len)
+int ufs_prepare_chunk(struct folio *folio, loff_t pos, unsigned len)
 {
-	return __block_write_begin(page, pos, len, ufs_getfrag_block);
+	return __block_write_begin(&folio->page, pos, len, ufs_getfrag_block);
 }
 
 static void ufs_truncate_blocks(struct inode *);
diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 0ecd2ed792f5..bf708b68f150 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -250,9 +250,9 @@ ufs_set_inode_gid(struct super_block *sb, struct ufs_inode *inode, u32 value)
 	}
 }
 
-extern dev_t ufs_get_inode_dev(struct super_block *, struct ufs_inode_info *);
-extern void ufs_set_inode_dev(struct super_block *, struct ufs_inode_info *, dev_t);
-extern int ufs_prepare_chunk(struct page *page, loff_t pos, unsigned len);
+dev_t ufs_get_inode_dev(struct super_block *, struct ufs_inode_info *);
+void ufs_set_inode_dev(struct super_block *, struct ufs_inode_info *, dev_t);
+int ufs_prepare_chunk(struct folio *folio, loff_t pos, unsigned len);
 
 /*
  * These functions manipulate ufs buffers
-- 
2.43.0


