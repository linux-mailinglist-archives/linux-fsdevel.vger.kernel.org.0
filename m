Return-Path: <linux-fsdevel+bounces-37034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF8C9EC7DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 09:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6280B166225
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CD81EC4F4;
	Wed, 11 Dec 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2WTPXu2E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193731E9B34;
	Wed, 11 Dec 2024 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907286; cv=none; b=XL34J7Jgfgl2tNLDo16kBlvb6T8xDUOt4PSrk8/Ih0z9V1krA0X/2wgzgfQDYSnjTJnRw8WAk1Pu9qmH2CoFYleqqiLQUweBg146rgulHcJKJ36V58nxPCjJ+0goeKy3qpGn5aTDKwZJaX88JDuyqA/XW8AjySF6g4iGfMk55Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907286; c=relaxed/simple;
	bh=Fqf3iC3e8vvaltdLrjYAhwu6cGr0XEqrcZ3c+cjXSNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfz7r/WHs/GB5WKapJH8WVkW1ax4h9jHOA0UjbezPru85djx4fTniwL0JcNgSv4OPs5XyQCsSYUcsPT7xpy7MXMXgo9QG6xFFVjFnZzh6G7mDOwsNb4yyPYjg/3aS/EMImVzYuvR6ViA5IuF0V7AxgIxcwDN+5EjK6ApHynNb1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2WTPXu2E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yIvaurwbwBm6NZN6LEqWjzd8lX0Uy6glu4tBrdak1/M=; b=2WTPXu2EjoLNWpFZPxhBifQXuo
	evmhHQ1KewsWLBDHER2w83WLSw9dV3pvXAeuEpucq/SDEmWquFODC68hTvoEjrOQJJvwAKnOUjPbz
	CIyeGh7nZjwvtOFCUyQ8odcLO/1XBrcpLhw2y0b5SJiQwHHsqm5k4II3YWHJ3j7NiOixZqDksaeOy
	Sc7FuJARXP0JYlTMeR5gMmAyTCoRgHojfZHgxTnLTXJkSs7mVrMLVa6RDlNm0pe40WlRTIyxKABQX
	Ft0JSEOyxbZJx1fOUIp2Pa+ImVLwOs01BNhUg75yTwx3vJpiVTHjHG54Z16jCBm7EHDzXOVeRUcDz
	8pHCgLyQ==;
Received: from [2001:4bb8:2ae:8817:935:3eb8:759c:c417] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLIUW-0000000EIRo-0uLN;
	Wed, 11 Dec 2024 08:54:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/8] iomap: pass private data to iomap_zero_range
Date: Wed, 11 Dec 2024 09:53:47 +0100
Message-ID: <20241211085420.1380396-8-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211085420.1380396-1-hch@lst.de>
References: <20241211085420.1380396-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Allow the file system to pass private data which can be used by the
iomap_begin and iomap_end methods through the private pointer in the
iomap_iter structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/bmap.c         | 3 ++-
 fs/iomap/buffered-io.c | 6 ++++--
 fs/xfs/xfs_iomap.c     | 2 +-
 include/linux/iomap.h  | 2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 1795c4e8dbf6..366516b98b3f 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1300,7 +1300,8 @@ static int gfs2_block_zero_range(struct inode *inode, loff_t from,
 				 unsigned int length)
 {
 	BUG_ON(current->journal_info);
-	return iomap_zero_range(inode, from, length, NULL, &gfs2_iomap_ops);
+	return iomap_zero_range(inode, from, length, NULL, &gfs2_iomap_ops,
+			NULL);
 }
 
 #define GFS2_JTRUNC_REVOKES 8192
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0863c78dc69f..6bfee1c7aedb 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1397,13 +1397,14 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 
 int
 iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
-		const struct iomap_ops *ops)
+		const struct iomap_ops *ops, void *private)
 {
 	struct iomap_iter iter = {
 		.inode		= inode,
 		.pos		= pos,
 		.len		= len,
 		.flags		= IOMAP_ZERO,
+		.private	= private,
 	};
 	struct address_space *mapping = inode->i_mapping;
 	unsigned int blocksize = i_blocksize(inode);
@@ -1471,7 +1472,8 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 	/* Block boundary? Nothing to do */
 	if (!off)
 		return 0;
-	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops);
+	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops,
+			NULL);
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 50fa3ef89f6c..3410c55f544a 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1497,7 +1497,7 @@ xfs_zero_range(
 		return dax_zero_range(inode, pos, len, did_zero,
 				      &xfs_dax_write_iomap_ops);
 	return iomap_zero_range(inode, pos, len, did_zero,
-				&xfs_buffered_write_iomap_ops);
+				&xfs_buffered_write_iomap_ops, NULL);
 }
 
 int
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 2d1c53024ed1..2a88dfa6ec55 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -313,7 +313,7 @@ bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
-		bool *did_zero, const struct iomap_ops *ops);
+		bool *did_zero, const struct iomap_ops *ops, void *private);
 int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops);
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
-- 
2.45.2


