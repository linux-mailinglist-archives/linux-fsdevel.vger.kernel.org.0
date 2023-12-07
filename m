Return-Path: <linux-fsdevel+bounces-5123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDBC80831F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDA9B21336
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4F5328C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hPv3ZtIv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E6AD44;
	Wed,  6 Dec 2023 23:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=iuObPO5/R9rInT1fN5flI+NvAoR7bLN0FidOhnwrFu4=; b=hPv3ZtIv5F9QERLoVHsbHaQ5on
	oaPjTKb3cXm5+2yvC/xeh4VUHe0dsxKtw0CSlOdBNM2MyTYz6nsgtJkbgKGCS04D5KhC1+BbPR0Mv
	shwx0OY+r6ZV6PbZx3C/WQSdxIrMyx3UQuceKo4AEm8ffCpMJuJoGPY07SCt7u3cDX0+3rVXd9Div
	JgQigArG/qQoMhJVPIeH+BZFs8cM6GMKN0h0tigy33trUNq0QEJTT4QZiPbxTOiNHbuPV175vP1Bz
	QOqms31OUokuLHQ/+KLEf+OSpPj5O9eTOqk4ISgIIfCJORGjBR943t5T0wPrHfRdspXxJaKZLM2Iq
	GFzsk+HA==;
Received: from [2001:4bb8:191:e7ca:4bf6:cea4:9bbf:8b02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rB8nZ-00C57a-2w;
	Thu, 07 Dec 2023 07:27:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 13/14] iomap: map multiple blocks at a time
Date: Thu,  7 Dec 2023 08:27:09 +0100
Message-Id: <20231207072710.176093-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207072710.176093-1-hch@lst.de>
References: <20231207072710.176093-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The ->map_blocks interface returns a valid range for writeback, but we
still call back into it for every block, which is a bit inefficient.

Change iomap_writepage_map to use the valid range in the map until the
end of the folio or the dirty range inside the folio instead of calling
back into every block.

Note that the range is not used over folio boundaries as we need to be
able to check the mapping sequence count under the folio lock.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 116 ++++++++++++++++++++++++++++-------------
 include/linux/iomap.h  |   7 +++
 2 files changed, 88 insertions(+), 35 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4339bc422b245d..d8f56968962b97 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2010 Red Hat, Inc.
- * Copyright (C) 2016-2019 Christoph Hellwig.
+ * Copyright (C) 2016-2023 Christoph Hellwig.
  */
 #include <linux/module.h>
 #include <linux/compiler.h>
@@ -95,6 +95,44 @@ static inline bool ifs_block_is_dirty(struct folio *folio,
 	return test_bit(block + blks_per_folio, ifs->state);
 }
 
+static unsigned ifs_find_dirty_range(struct folio *folio,
+		struct iomap_folio_state *ifs, u64 *range_start, u64 range_end)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned start_blk =
+		offset_in_folio(folio, *range_start) >> inode->i_blkbits;
+	unsigned end_blk = min_not_zero(
+		offset_in_folio(folio, range_end) >> inode->i_blkbits,
+		i_blocks_per_folio(inode, folio));
+	unsigned nblks = 1;
+
+	while (!ifs_block_is_dirty(folio, ifs, start_blk))
+		if (++start_blk == end_blk)
+			return 0;
+
+	while (start_blk + nblks < end_blk) {
+		if (!ifs_block_is_dirty(folio, ifs, start_blk + nblks))
+			break;
+		nblks++;
+	}
+
+	*range_start = folio_pos(folio) + (start_blk << inode->i_blkbits);
+	return nblks << inode->i_blkbits;
+}
+
+static unsigned iomap_find_dirty_range(struct folio *folio, u64 *range_start,
+		u64 range_end)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	if (*range_start >= range_end)
+		return 0;
+
+	if (ifs)
+		return ifs_find_dirty_range(folio, ifs, range_start, range_end);
+	return range_end - *range_start;
+}
+
 static void ifs_clear_range_dirty(struct folio *folio,
 		struct iomap_folio_state *ifs, size_t off, size_t len)
 {
@@ -1711,10 +1749,9 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos)
  */
 static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct folio *folio,
-		struct inode *inode, loff_t pos)
+		struct inode *inode, loff_t pos, unsigned len)
 {
 	struct iomap_folio_state *ifs = folio->private;
-	unsigned len = i_blocksize(inode);
 	size_t poff = offset_in_folio(folio, pos);
 	int error;
 
@@ -1738,29 +1775,41 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 
 static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct folio *folio,
-		struct inode *inode, u64 pos, unsigned *count)
+		struct inode *inode, u64 pos, unsigned dirty_len,
+		unsigned *count)
 {
 	int error;
 
-	error = wpc->ops->map_blocks(wpc, inode, pos);
-	if (error)
-		goto fail;
-	trace_iomap_writepage_map(inode, &wpc->iomap);
-
-	switch (wpc->iomap.type) {
-	case IOMAP_INLINE:
-		WARN_ON_ONCE(1);
-		error = -EIO;
-		break;
-	case IOMAP_HOLE:
-		break;
-	default:
-		error = iomap_add_to_ioend(wpc, wbc, folio, inode, pos);
-		if (!error)
-			(*count)++;
-	}
+	do {
+		unsigned map_len;
+
+		error = wpc->ops->map_blocks(wpc, inode, pos);
+		if (error)
+			break;
+		trace_iomap_writepage_map(inode, &wpc->iomap);
+
+		map_len = min_t(u64, dirty_len,
+			wpc->iomap.offset + wpc->iomap.length - pos);
+		WARN_ON_ONCE(!folio->private && map_len < dirty_len);
+
+		switch (wpc->iomap.type) {
+		case IOMAP_INLINE:
+			WARN_ON_ONCE(1);
+			error = -EIO;
+			break;
+		case IOMAP_HOLE:
+			break;
+		default:
+			error = iomap_add_to_ioend(wpc, wbc, folio, inode, pos,
+					map_len);
+			if (!error)
+				(*count)++;
+			break;
+		}
+		dirty_len -= map_len;
+		pos += map_len;
+	} while (dirty_len && !error);
 
-fail:
 	/*
 	 * We cannot cancel the ioend directly here on error.  We may have
 	 * already set other pages under writeback and hence we have to run I/O
@@ -1827,7 +1876,7 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
 		 * beyond i_size.
 		 */
 		folio_zero_segment(folio, poff, folio_size(folio));
-		*end_pos = isize;
+		*end_pos = round_up(isize, i_blocksize(inode));
 	}
 
 	return true;
@@ -1838,12 +1887,11 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 {
 	struct iomap_folio_state *ifs = folio->private;
 	struct inode *inode = folio->mapping->host;
-	unsigned len = i_blocksize(inode);
-	unsigned nblocks = i_blocks_per_folio(inode, folio);
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
 	unsigned count = 0;
-	int error = 0, i;
+	int error = 0;
+	u32 rlen;
 
 	WARN_ON_ONCE(!folio_test_locked(folio));
 	WARN_ON_ONCE(folio_test_dirty(folio));
@@ -1857,7 +1905,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	}
 	WARN_ON_ONCE(end_pos <= pos);
 
-	if (nblocks > 1) {
+	if (i_blocks_per_folio(inode, folio) > 1) {
 		if (!ifs) {
 			ifs = ifs_alloc(inode, folio, 0);
 			iomap_set_range_dirty(folio, 0, end_pos - pos);
@@ -1880,18 +1928,16 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	folio_start_writeback(folio);
 
 	/*
-	 * Walk through the folio to find areas to write back. If we
-	 * run off the end of the current map or find the current map
-	 * invalid, grab a new one.
+	 * Walk through the folio to find dirty areas to write back.
 	 */
-	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (ifs && !ifs_block_is_dirty(folio, ifs, i))
-			continue;
-		error = iomap_writepage_map_blocks(wpc, wbc, folio, inode, pos,
-				&count);
+	while ((rlen = iomap_find_dirty_range(folio, &pos, end_pos))) {
+		error = iomap_writepage_map_blocks(wpc, wbc, folio, inode,
+				pos, rlen, &count);
 		if (error)
 			break;
+		pos += rlen;
 	}
+
 	if (count)
 		wpc->nr_folios++;
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index b8d3b658ad2b03..49d93f53878565 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -309,6 +309,13 @@ struct iomap_writeback_ops {
 	/*
 	 * Required, maps the blocks so that writeback can be performed on
 	 * the range starting at offset.
+	 *
+	 * Can return arbitrarily large regions, but we need to call into it at
+	 * least once per folio to allow the file systems to synchronize with
+	 * the write path that could be invalidating mappings.
+	 *
+	 * An existing mapping from a previous call to this method can be reused
+	 * by the file system if it is still valid.
 	 */
 	int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
 				loff_t offset);
-- 
2.39.2


