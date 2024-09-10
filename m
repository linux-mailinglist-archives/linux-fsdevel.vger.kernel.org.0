Return-Path: <linux-fsdevel+bounces-28989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CBB97286B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1B82B2329E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B93016B3B7;
	Tue, 10 Sep 2024 04:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="20gsku6z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9490A14387B;
	Tue, 10 Sep 2024 04:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943214; cv=none; b=nvjqqbR38Y9S8sQ1XdXsRAWMy/jYrEovN8SQXYyckV+NykQvofnCVA0jQaOJD2RIGjxAFIfuC7UeTlpdtvXhaY5YPGWkARU0BnD+qDVA+zX8sVWaEpMSQcfMusybBqboh61GlCzFZvEHT1JQ1jrtEc6Eo7qNuMILSJ3OfWu48Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943214; c=relaxed/simple;
	bh=szl7PVp7cDvl+wmX0Wc6m7QSsmI81+QrEUkh2NHcoJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDIyF+Ynz6nK2id4b85LG+Z1uFNm4U3kqJI6wckMd9f02R6lCCU8vGna/oOQw/gqAGacNQZ214d157ZqHlqI6DBDVgiZ44V7FCAG2I2noNhNbHAoinq3VAzuir0WNKn21WbjEnjS3z7hUTmo4bebGPBD9ze1syGCBo0PkAI9wFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=20gsku6z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RjmaHn84o+JC/zfYelgZpF4O7kf3xQZtwo2hUPogIsw=; b=20gsku6ziUu0rfxh0JbJR9OmFi
	hBrUYdbSnVGxoq/oR1UeJORFGJpyOLuh0XUpqkVT5V4JnvzUITZsEIgEbGrNrhmvW9Vx11HZAH1Dj
	P68vqjDfIqiG5tyT8gLIs/1XH7HVjtEWtRDQfooBb87HJUnVkMeyiICJ6H6nJ1CYskdUSXrl2VyrS
	NmIcOLQQABurx5ZLjVgD6o8HBA/nZPBoXCcbBS4FkoFIGe1XPMyCUOgIddCVUmjVIvc9FIZ9PvVRY
	xJS2/Kw3htdM39JInxsm5at0OQcHAgvzjFm+qWYGDqQNII1nQ0pm3lKxNAt6EbXYeA6RXw+dOfmAS
	3tmeT0/A==;
Received: from ppp-2-84-49-240.home.otenet.gr ([2.84.49.240] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snsfj-00000004Epm-25cJ;
	Tue, 10 Sep 2024 04:40:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/12] iomap: pass the iomap to the punch callback
Date: Tue, 10 Sep 2024 07:39:06 +0300
Message-ID: <20240910043949.3481298-5-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910043949.3481298-1-hch@lst.de>
References: <20240910043949.3481298-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

XFS will need to look at the flags in the iomap structure, so pass it
down all the way to the callback.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 25 +++++++++++++------------
 fs/xfs/xfs_iomap.c     |  3 ++-
 include/linux/iomap.h  |  3 ++-
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ac4666fede4c18..a0bc7c3654cc36 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1047,7 +1047,7 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 
 static int iomap_write_delalloc_ifs_punch(struct inode *inode,
 		struct folio *folio, loff_t start_byte, loff_t end_byte,
-		iomap_punch_t punch)
+		struct iomap *iomap, iomap_punch_t punch)
 {
 	unsigned int first_blk, last_blk, i;
 	loff_t last_byte;
@@ -1072,7 +1072,7 @@ static int iomap_write_delalloc_ifs_punch(struct inode *inode,
 	for (i = first_blk; i <= last_blk; i++) {
 		if (!ifs_block_is_dirty(folio, ifs, i)) {
 			ret = punch(inode, folio_pos(folio) + (i << blkbits),
-				    1 << blkbits);
+				    1 << blkbits, iomap);
 			if (ret)
 				return ret;
 		}
@@ -1084,7 +1084,7 @@ static int iomap_write_delalloc_ifs_punch(struct inode *inode,
 
 static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
 		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
-		iomap_punch_t punch)
+		struct iomap *iomap, iomap_punch_t punch)
 {
 	int ret = 0;
 
@@ -1094,14 +1094,14 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
 	/* if dirty, punch up to offset */
 	if (start_byte > *punch_start_byte) {
 		ret = punch(inode, *punch_start_byte,
-				start_byte - *punch_start_byte);
+				start_byte - *punch_start_byte, iomap);
 		if (ret)
 			return ret;
 	}
 
 	/* Punch non-dirty blocks within folio */
-	ret = iomap_write_delalloc_ifs_punch(inode, folio, start_byte,
-			end_byte, punch);
+	ret = iomap_write_delalloc_ifs_punch(inode, folio, start_byte, end_byte,
+			iomap, punch);
 	if (ret)
 		return ret;
 
@@ -1134,7 +1134,7 @@ static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
  */
 static int iomap_write_delalloc_scan(struct inode *inode,
 		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
-		iomap_punch_t punch)
+		struct iomap *iomap, iomap_punch_t punch)
 {
 	while (start_byte < end_byte) {
 		struct folio	*folio;
@@ -1150,7 +1150,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 		}
 
 		ret = iomap_write_delalloc_punch(inode, folio, punch_start_byte,
-						 start_byte, end_byte, punch);
+				start_byte, end_byte, iomap, punch);
 		if (ret) {
 			folio_unlock(folio);
 			folio_put(folio);
@@ -1199,7 +1199,8 @@ static int iomap_write_delalloc_scan(struct inode *inode,
  * the code to subtle off-by-one bugs....
  */
 static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
-		loff_t end_byte, unsigned flags, iomap_punch_t punch)
+		loff_t end_byte, unsigned flags, struct iomap *iomap,
+		iomap_punch_t punch)
 {
 	loff_t punch_start_byte = start_byte;
 	loff_t scan_end_byte = min(i_size_read(inode), end_byte);
@@ -1252,7 +1253,7 @@ static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 		WARN_ON_ONCE(data_end > scan_end_byte);
 
 		error = iomap_write_delalloc_scan(inode, &punch_start_byte,
-				start_byte, data_end, punch);
+				start_byte, data_end, iomap, punch);
 		if (error)
 			goto out_unlock;
 
@@ -1262,7 +1263,7 @@ static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
 
 	if (punch_start_byte < end_byte)
 		error = punch(inode, punch_start_byte,
-				end_byte - punch_start_byte);
+				end_byte - punch_start_byte, iomap);
 out_unlock:
 	filemap_invalidate_unlock(inode->i_mapping);
 	return error;
@@ -1329,7 +1330,7 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 		return 0;
 
 	return iomap_write_delalloc_release(inode, start_byte, end_byte, flags,
-					punch);
+					iomap, punch);
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 47b5c83588259e..695e5bee776f94 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1212,7 +1212,8 @@ static int
 xfs_buffered_write_delalloc_punch(
 	struct inode		*inode,
 	loff_t			offset,
-	loff_t			length)
+	loff_t			length,
+	struct iomap		*iomap)
 {
 	xfs_bmap_punch_delalloc_range(XFS_I(inode), offset, offset + length);
 	return 0;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 83da37d64d1144..a931190f6d858b 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -274,7 +274,8 @@ int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
 			const struct iomap_ops *ops);
 
-typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length);
+typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length,
+		struct iomap *iomap);
 int iomap_file_buffered_write_punch_delalloc(struct inode *inode, loff_t pos,
 		loff_t length, ssize_t written, unsigned flag,
 		struct iomap *iomap, iomap_punch_t punch);
-- 
2.45.2


