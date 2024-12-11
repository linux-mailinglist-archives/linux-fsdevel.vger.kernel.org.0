Return-Path: <linux-fsdevel+bounces-37029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E549EC7D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 09:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84D01881F8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330621EC4E6;
	Wed, 11 Dec 2024 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2lATUxpP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643791E9B3E;
	Wed, 11 Dec 2024 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907272; cv=none; b=lRHG1TFGsnIpGAMsCTg+8esg9D3u5bDnEEmK8u4MqA0jIYvtRGDunIWHce64mEYw9wh5Yo/BrK/3354y3BGd68EEMDZJ8XjCOeLh1W2h+6oo8MVWJW8BJ4zWRYsyfShMps0htZwj/NcU57x+lgS88RWxHsllhyk2FhFrrhVYbRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907272; c=relaxed/simple;
	bh=ASvzn/ksOHhTMpgZdQ6+gAD/30MgklApsl+zoL1lQW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXY60MWjcSz+QrMANG3o6kU91mn+rAsfFLh20h+/4sb0Bcp7HpxHx2F+55eykNZAexXVpVBOSLknZjuvdYJZR1UgLIJDqc6l6ntaSosrWpGmoLeLUbe6J20lk5C5/bTaoz3VHGXRdFMYZQqFVx9bTg1/AW7a6NNy5J2KJpoQV1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2lATUxpP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VsPJTD3PM2K25lsa31JFaRchkSiZA4CjYpKI10kaTFE=; b=2lATUxpP+CgGRQK2DjLVFSViPd
	VlK40o80kQVFv0gmjQki2kw0afkNiqDWnwwRM5h7bDhUcEPvre1jVBiQTM6j0QPWh96WL6LdOv71z
	Km9Psvzebx33D+qPnhluzKT+ZpDn1M8bHeC6KVUtjfzgmq1dgwRiDQhRbBxtPMXF9fhK3JEDTgKW4
	DfHTOFFWnXl0erGqPNyb4ji3miymEHdi4kavUoQhUDoSyry1ZDMUI/YOypQrMgxE+/RsroWT8CefJ
	rjCFc9zdccSS3MOFG003R2NCK4yPMf7rCcIuUmKd2gpAlrxL0f6pZpP7S3hhlGc/YR7m4g7tIDJ+m
	wOi14G4w==;
Received: from [2001:4bb8:2ae:8817:935:3eb8:759c:c417] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLIUH-0000000EIL4-2iCj;
	Wed, 11 Dec 2024 08:54:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/8] iomap: simplify io_flags and io_type in struct iomap_ioend
Date: Wed, 11 Dec 2024 09:53:42 +0100
Message-ID: <20241211085420.1380396-3-hch@lst.de>
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

The ioend fields for distinct types of I/O are a bit complicated.
Consolidate them into a single io_flag field with it's own flags
decoupled from the iomap flags.  This also prepares for adding a new
flag that is unrelated to both of the iomap namespaces.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 39 ++++++++++++++++++++++-----------------
 fs/xfs/xfs_aops.c      | 12 ++++++------
 include/linux/iomap.h  | 16 ++++++++++++++--
 3 files changed, 42 insertions(+), 25 deletions(-)

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
index c0339678d798..1d8658c7beb8 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -327,13 +327,25 @@ loff_t iomap_seek_data(struct inode *inode, loff_t offset,
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


