Return-Path: <linux-fsdevel+bounces-53845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8595AF813C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 21:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82786485EEB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 19:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EDF2F2C53;
	Thu,  3 Jul 2025 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R+jA8UzR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FD4136E
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751570711; cv=none; b=INNNsnMOxqEGXWca5R4mkmFbE2r6a/66lcfqPcgnOsc0LJvLlR3OCyfm8XJWnHWMx1r9blbg9sX1qrcZk0ZAnY9XQzA4CWh6uooLnqky0MBUbxP05eyS3jROGsZ6Ri1L+J0bPAW2vVpKnf7JJa6anqCglo1a9gutpbv9XCLqkEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751570711; c=relaxed/simple;
	bh=6lSHUHbqOC3ZGyYbKlB9RhuN/0WVu0TukQiyy3PnQ3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHLji6yzkmOmlcvZDt3cU1W4Q1/O90RkNITExiMmvRxFawx5t/eNMVkxbP7Dhf9/5rxvgiMWMm9hw7j+oI4pVQYy7l8BW1KvpeXwoX6TDSGD9nGrBN2Tt/007pJUEk9de2FhSnyawHAumAZEFXjKTId++JGz/+Pzg6VM6oH4mK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R+jA8UzR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=zeB9elt3qvinofGAhLEyjJZvM/7XQqKQ8Zb9/u4bL94=; b=R+jA8UzRhTIY7k+jw/Djh142F9
	64WHOSrhnZ55FAnqNhrHw9m1+8rLOxLElbdYCzdUSG9mmEiHB8UqMzxOBd3YgNjhSOZyWIrCsDDcg
	oXTzux3nhu0/gqkslNdGkL1K5t6WTJOqCb4vhed+kqTTx9iu934eq6ExZXurwWAhneWuXAWvnyHwO
	aYPvqV5xVV9iA3JQxyngPpKiR3mKwt2isbtqNaJFC78fXiyB/4UWsjMrJps1K48RC+z5qc0bweI3G
	2LEJgoXYMGJaafF368KiEI5Zoj1B7qZ1Or3fACi/Kk0qeVLG9Ajdrp3sCJqVmqmNvt/8uoetMXE5J
	xw5DD+bQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXPYK-0000000EBf4-4BF6;
	Thu, 03 Jul 2025 19:25:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/1] fuse: Use filemap_invalidate_pages()
Date: Thu,  3 Jul 2025 20:24:56 +0100
Message-ID: <20250703192459.3381327-2-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703192459.3381327-1-willy@infradead.org>
References: <20250703192459.3381327-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FUSE relies on invalidate_inode_pages2() / invalidate_inode_pages2_range()
doing writeback by calling fuse_launder_folio().  While this works, it
is inefficient as each page is written back and waited for individually.
Far better to call filemap_invalidate_pages() which will do a bulk write
first, then remove the page cache.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/dax.c   | 16 ++++------------
 fs/fuse/dir.c   | 12 +++++++-----
 fs/fuse/file.c  | 16 +++++-----------
 fs/fuse/inode.c | 17 +++++------------
 4 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index ac6d4c1064cc..160178b2fce6 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -835,19 +835,11 @@ static int dmap_writeback_invalidate(struct inode *inode,
 	loff_t start_pos = dmap->itn.start << FUSE_DAX_SHIFT;
 	loff_t end_pos = (start_pos + FUSE_DAX_SZ - 1);
 
-	ret = filemap_fdatawrite_range(inode->i_mapping, start_pos, end_pos);
-	if (ret) {
-		pr_debug("fuse: filemap_fdatawrite_range() failed. err=%d start_pos=0x%llx, end_pos=0x%llx\n",
-			 ret, start_pos, end_pos);
-		return ret;
-	}
-
-	ret = invalidate_inode_pages2_range(inode->i_mapping,
-					    start_pos >> PAGE_SHIFT,
-					    end_pos >> PAGE_SHIFT);
+	ret = filemap_invalidate_pages(inode->i_mapping, start_pos, end_pos,
+			false);
 	if (ret)
-		pr_debug("fuse: invalidate_inode_pages2_range() failed err=%d\n",
-			 ret);
+		pr_debug("fuse: filemap_invalidate_pages() failed. err=%d start_pos=0x%llx, end_pos=0x%llx\n",
+			 ret, start_pos, end_pos);
 
 	return ret;
 }
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2d817d7cab26..0151343d8393 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -718,7 +718,8 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 		if (fm->fc->atomic_o_trunc && trunc)
 			truncate_pagecache(inode, 0);
 		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
-			invalidate_inode_pages2(inode->i_mapping);
+			filemap_invalidate_pages(inode->i_mapping, 0,
+					OFFSET_MAX, false);
 	}
 	return err;
 
@@ -1715,7 +1716,8 @@ static int fuse_dir_open(struct inode *inode, struct file *file)
 		if (ff->open_flags & (FOPEN_STREAM | FOPEN_NONSEEKABLE))
 			nonseekable_open(inode, file);
 		if (!(ff->open_flags & FOPEN_KEEP_CACHE))
-			invalidate_inode_pages2(inode->i_mapping);
+			filemap_invalidate_pages(inode->i_mapping, 0,
+					OFFSET_MAX, false);
 	}
 
 	return err;
@@ -2088,13 +2090,13 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	spin_unlock(&fi->lock);
 
 	/*
-	 * Only call invalidate_inode_pages2() after removing
-	 * FUSE_NOWRITE, otherwise fuse_launder_folio() would deadlock.
+	 * Only call filemap_invalidate_pages() after removing
+	 * FUSE_NOWRITE, otherwise it would deadlock.
 	 */
 	if ((is_truncate || !is_wb) &&
 	    S_ISREG(inode->i_mode) && oldsize != outarg.attr.size) {
 		truncate_pagecache(inode, outarg.attr.size);
-		invalidate_inode_pages2(mapping);
+		filemap_invalidate_pages(mapping, 0, OFFSET_MAX, false);
 	}
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 2b04a142b493..eaa659c08132 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -277,7 +277,8 @@ static int fuse_open(struct inode *inode, struct file *file)
 		if (is_truncate)
 			truncate_pagecache(inode, 0);
 		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
-			invalidate_inode_pages2(inode->i_mapping);
+			filemap_invalidate_pages(inode->i_mapping, 0,
+					OFFSET_MAX, false);
 	}
 	if (dax_truncate)
 		filemap_invalidate_unlock(inode->i_mapping);
@@ -1566,7 +1567,8 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 		return -ENOMEM;
 
 	if (fopen_direct_io && fc->direct_io_allow_mmap) {
-		res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);
+		res = filemap_invalidate_pages(mapping, pos, (pos + count - 1),
+				false);
 		if (res) {
 			fuse_io_free(ia);
 			return res;
@@ -1580,14 +1582,6 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 			inode_unlock(inode);
 	}
 
-	if (fopen_direct_io && write) {
-		res = invalidate_inode_pages2_range(mapping, idx_from, idx_to);
-		if (res) {
-			fuse_io_free(ia);
-			return res;
-		}
-	}
-
 	io->should_dirty = !write && user_backed_iter(iter);
 	while (count) {
 		ssize_t nres;
@@ -2358,7 +2352,7 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 		if ((vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_allow_mmap)
 			return -ENODEV;
 
-		invalidate_inode_pages2(file->f_mapping);
+		filemap_invalidate_pages(file->f_mapping, 0, OFFSET_MAX, false);
 
 		if (!(vma->vm_flags & VM_MAYSHARE)) {
 			/* MAP_PRIVATE */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ecb869e895ab..905b192fa12e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -397,7 +397,8 @@ static void fuse_change_attributes_i(struct inode *inode, struct fuse_attr *attr
 		}
 
 		if (inval)
-			invalidate_inode_pages2(inode->i_mapping);
+			filemap_invalidate_pages(inode->i_mapping, 0,
+					OFFSET_MAX, false);
 	}
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
@@ -559,8 +560,6 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
 {
 	struct fuse_inode *fi;
 	struct inode *inode;
-	pgoff_t pg_start;
-	pgoff_t pg_end;
 
 	inode = fuse_ilookup(fc, nodeid, NULL);
 	if (!inode)
@@ -573,15 +572,9 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
 
 	fuse_invalidate_attr(inode);
 	forget_all_cached_acls(inode);
-	if (offset >= 0) {
-		pg_start = offset >> PAGE_SHIFT;
-		if (len <= 0)
-			pg_end = -1;
-		else
-			pg_end = (offset + len - 1) >> PAGE_SHIFT;
-		invalidate_inode_pages2_range(inode->i_mapping,
-					      pg_start, pg_end);
-	}
+	if (offset >= 0)
+		filemap_invalidate_pages(inode->i_mapping, offset,
+				offset + len - 1, false);
 	iput(inode);
 	return 0;
 }
-- 
2.47.2


