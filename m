Return-Path: <linux-fsdevel+bounces-37845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1E99F8281
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E943D189A0CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDCB1BAEDC;
	Thu, 19 Dec 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qG0n/vFf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C91A0B0D;
	Thu, 19 Dec 2024 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630010; cv=none; b=rEU+44acllPuSSdumuxRLrsy3cNGLILZ6nQmblrPEkLp7lo9Q9+grm3MJMztuzglVnCLzboHWUb6RfrL919+rpkcuitOFtzf1BHKhnji/Yvbhmsg9nishUk4zaiCmZ2PBVF5cNFFiZmRw6MsfnYJ+bljFgdp16w4kiv1tJ0W7Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630010; c=relaxed/simple;
	bh=Wr5z2YXTpoimZyn9l2mwEnXeRCpCVRWuOQFQG/94jD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4HzBiqmvVaZjwT3Y7A4pc/jwWEl3j8aXoyBi1m0Junp23CLjlhw+/4hr4yh/Btlxm8aS9aeeOsbPO7vhZ1773rIkoG8xYNal/X3ziChNewpu0rkswFHNZgs7ScXAjoccm5WmoU4Fup3JJsrVE3V71VyDGDQnSKVKOvklG/KsiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qG0n/vFf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ka14edneowdt+85rGBJijVxuFOuuVYkiDD7/pj6mgVs=; b=qG0n/vFfXS3Nc5Mynv7g7Ub+0z
	jD8YCjT0Sf2A37/Z6x/1Wx1GNd69mck662B6pcgShrx4/vqxUUBoQEKQgt8T9Org/1V2r+6dWDwZM
	wamgiCqGo0Y7O0bn1xUCB7fPHV+LA9MY4F0Zn9J/3JlbqpNOaXCMMwNDPtIj3iRzEP7Eoi7prHcJk
	YmoZIsuJKUPbS+fjRTReIgzUcyK1zKoPkF8+DsHMUaVixGxTp5Xr0pAk3JZI/qNhoDhwPtZVIKIqk
	ZLAUqNosbi9PqN3e9G1ysx+TYp9OQcLQDp2Dif+0WayGhCxUVPoSEuNfDycPfcmYTwOmw8EHDbSkC
	JhUN4h0Q==;
Received: from [2001:4bb8:2ae:97bf:7b0d:9cbd:e369:c821] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tOKVL-00000002avg-2qbg;
	Thu, 19 Dec 2024 17:40:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/10] iomap: simplify io_flags and io_type in struct iomap_ioend
Date: Thu, 19 Dec 2024 17:39:07 +0000
Message-ID: <20241219173954.22546-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241219173954.22546-1-hch@lst.de>
References: <20241219173954.22546-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The ioend fields for distinct types of I/O are a bit complicated.
Consolidate them into a single io_flag field with it's own flags
decoupled from the iomap flags.  This also prepares for adding a new
flag that is unrelated to both of the iomap namespaces.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 39 ++++++++++++++++++++++-----------------
 fs/xfs/xfs_aops.c      | 12 ++++++------
 include/linux/iomap.h  | 20 ++++++++++++++++++--
 3 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index cdccf11bb3be..3176dc996fb7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1605,13 +1605,10 @@ iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
 {
 	if (ioend->io_bio.bi_status != next->io_bio.bi_status)
 		return false;
-	if (next->io_flags & IOMAP_F_BOUNDARY)
+	if (next->io_flags & IOMAP_IOEND_BOUNDARY)
 		return false;
-	if ((ioend->io_flags & IOMAP_F_SHARED) ^
-	    (next->io_flags & IOMAP_F_SHARED))
-		return false;
-	if ((ioend->io_type == IOMAP_UNWRITTEN) ^
-	    (next->io_type == IOMAP_UNWRITTEN))
+	if ((ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
+	    (next->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
 		return false;
 	if (ioend->io_offset + ioend->io_size != next->io_offset)
 		return false;
@@ -1709,7 +1706,8 @@ static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
 }
 
 static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct inode *inode, loff_t pos)
+		struct writeback_control *wbc, struct inode *inode, loff_t pos,
+		u16 ioend_flags)
 {
 	struct iomap_ioend *ioend;
 	struct bio *bio;
@@ -1724,8 +1722,7 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 
 	ioend = iomap_ioend_from_bio(bio);
 	INIT_LIST_HEAD(&ioend->io_list);
-	ioend->io_type = wpc->iomap.type;
-	ioend->io_flags = wpc->iomap.flags;
+	ioend->io_flags = ioend_flags;
 	if (pos > wpc->iomap.offset)
 		wpc->iomap.flags &= ~IOMAP_F_BOUNDARY;
 	ioend->io_inode = inode;
@@ -1737,14 +1734,13 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 	return ioend;
 }
 
-static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos)
+static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
+		u16 ioend_flags)
 {
-	if (wpc->iomap.offset == pos && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
-		return false;
-	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
-	    (wpc->ioend->io_flags & IOMAP_F_SHARED))
+	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
 		return false;
-	if (wpc->iomap.type != wpc->ioend->io_type)
+	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
+	    (wpc->ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
 		return false;
 	if (pos != wpc->ioend->io_offset + wpc->ioend->io_size)
 		return false;
@@ -1778,14 +1774,23 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 {
 	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
+	unsigned int ioend_flags = 0;
 	int error;
 
-	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos)) {
+	if (wpc->iomap.type == IOMAP_UNWRITTEN)
+		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
+	if (wpc->iomap.flags & IOMAP_F_SHARED)
+		ioend_flags |= IOMAP_IOEND_SHARED;
+	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
+		ioend_flags |= IOMAP_IOEND_BOUNDARY;
+
+	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
 new_ioend:
 		error = iomap_submit_ioend(wpc, 0);
 		if (error)
 			return error;
-		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos);
+		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos,
+				ioend_flags);
 	}
 
 	if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index d175853da5ae..d35ac4c19fb2 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -114,7 +114,7 @@ xfs_end_ioend(
 	 */
 	error = blk_status_to_errno(ioend->io_bio.bi_status);
 	if (unlikely(error)) {
-		if (ioend->io_flags & IOMAP_F_SHARED) {
+		if (ioend->io_flags & IOMAP_IOEND_SHARED) {
 			xfs_reflink_cancel_cow_range(ip, offset, size, true);
 			xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK, offset,
 					offset + size);
@@ -125,9 +125,9 @@ xfs_end_ioend(
 	/*
 	 * Success: commit the COW or unwritten blocks if needed.
 	 */
-	if (ioend->io_flags & IOMAP_F_SHARED)
+	if (ioend->io_flags & IOMAP_IOEND_SHARED)
 		error = xfs_reflink_end_cow(ip, offset, size);
-	else if (ioend->io_type == IOMAP_UNWRITTEN)
+	else if (ioend->io_flags & IOMAP_IOEND_UNWRITTEN)
 		error = xfs_iomap_write_unwritten(ip, offset, size, false);
 
 	if (!error && xfs_ioend_is_append(ioend))
@@ -410,7 +410,7 @@ xfs_submit_ioend(
 	nofs_flag = memalloc_nofs_save();
 
 	/* Convert CoW extents to regular */
-	if (!status && (ioend->io_flags & IOMAP_F_SHARED)) {
+	if (!status && (ioend->io_flags & IOMAP_IOEND_SHARED)) {
 		status = xfs_reflink_convert_cow(XFS_I(ioend->io_inode),
 				ioend->io_offset, ioend->io_size);
 	}
@@ -418,8 +418,8 @@ xfs_submit_ioend(
 	memalloc_nofs_restore(nofs_flag);
 
 	/* send ioends that might require a transaction to the completion wq */
-	if (xfs_ioend_is_append(ioend) || ioend->io_type == IOMAP_UNWRITTEN ||
-	    (ioend->io_flags & IOMAP_F_SHARED))
+	if (xfs_ioend_is_append(ioend) ||
+	    (ioend->io_flags & (IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED)))
 		ioend->io_bio.bi_end_io = xfs_end_bio;
 
 	if (status)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index c0339678d798..31857d4750a9 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -327,13 +327,29 @@ loff_t iomap_seek_data(struct inode *inode, loff_t offset,
 sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 		const struct iomap_ops *ops);
 
+/*
+ * Flags for iomap_ioend->io_flags.
+ */
+/* shared COW extent */
+#define IOMAP_IOEND_SHARED		(1U << 0)
+/* unwritten extent */
+#define IOMAP_IOEND_UNWRITTEN		(1U << 1)
+/* don't merge into previous ioend */
+#define IOMAP_IOEND_BOUNDARY		(1U << 2)
+
+/*
+ * Flags that if set on either ioend prevent the merge of two ioends.
+ * (IOMAP_IOEND_BOUNDARY also prevents merged, but only one-way)
+ */
+#define IOMAP_IOEND_NOMERGE_FLAGS \
+	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN)
+
 /*
  * Structure for writeback I/O completions.
  */
 struct iomap_ioend {
 	struct list_head	io_list;	/* next ioend in chain */
-	u16			io_type;
-	u16			io_flags;	/* IOMAP_F_* */
+	u16			io_flags;	/* IOMAP_IOEND_* */
 	struct inode		*io_inode;	/* file being written to */
 	size_t			io_size;	/* size of the extent */
 	loff_t			io_offset;	/* offset in the file */
-- 
2.45.2


