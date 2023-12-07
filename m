Return-Path: <linux-fsdevel+bounces-5121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AE480831A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9211F207C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DFD328A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BWCJdGIy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F017C137;
	Wed,  6 Dec 2023 23:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=h89Ver0p59pKQNx+TSpFffWpkZj+ggB4gAjtPUjFpJM=; b=BWCJdGIyjf27HdNtJDJSNq9e9/
	+2tosYtJyfUolT5YsOn1Wd0NHvwcjtHGX73cGQxeDk7kN2wny0Xm/NnYKX1Q40INVp9+mk9YjenYU
	Pi63/ra3Yoac3kWbGx0/EzbywbDYX7MRhN4ch3mHPNfSjIZvsR8/OhyyJpRDYTS1fC9LRfyA9s4+V
	rNcu39p5BlRg5wdaWL8U6b993AYHJQ79m3zepBxLF3/UT8zSl5HMcODfw2aM9rswgnHiAKe/RoG09
	s0yaO9aRmR81hy1HxUBV76MmQZGNS5AJ/0CTejaQqRoTYqCNdK07bt3GRsFQP4MOa1tM/5A+D+V9Y
	1SFgUMfg==;
Received: from [2001:4bb8:191:e7ca:4bf6:cea4:9bbf:8b02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rB8nT-00C54n-2o;
	Thu, 07 Dec 2023 07:27:48 +0000
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
Subject: [PATCH 11/14] iomap: factor out a iomap_writepage_map_block helper
Date: Thu,  7 Dec 2023 08:27:07 +0100
Message-Id: <20231207072710.176093-12-hch@lst.de>
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

Split the loop body that calls into the file system to map a block and
add it to the ioend into a separate helper to prefer for refactoring of
the surrounding code.

Note that this was the only place in iomap_writepage_map that could
return an error, so include the call to ->discard_folio into the new
helper as that will help to avoid code duplication in the future.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 70 ++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 21f5019c0fe762..622764ed649d57 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1722,6 +1722,45 @@ static void iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 	wbc_account_cgroup_owner(wbc, &folio->page, len);
 }
 
+static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
+		struct writeback_control *wbc, struct folio *folio,
+		struct inode *inode, u64 pos, unsigned *count,
+		struct list_head *submit_list)
+{
+	int error;
+
+	error = wpc->ops->map_blocks(wpc, inode, pos);
+	if (error)
+		goto fail;
+	trace_iomap_writepage_map(inode, &wpc->iomap);
+
+	switch (wpc->iomap.type) {
+	case IOMAP_INLINE:
+		WARN_ON_ONCE(1);
+		error = -EIO;
+		break;
+	case IOMAP_HOLE:
+		break;
+	default:
+		iomap_add_to_ioend(wpc, wbc, folio, inode, pos, submit_list);
+		(*count)++;
+	}
+
+fail:
+	/*
+	 * We cannot cancel the ioend directly here on error.  We may have
+	 * already set other pages under writeback and hence we have to run I/O
+	 * completion to mark the error state of the pages under writeback
+	 * appropriately.
+	 *
+	 * Just let the file system know what portion of the folio failed to
+	 * map.
+	 */
+	if (error && wpc->ops->discard_folio)
+		wpc->ops->discard_folio(folio, pos);
+	return error;
+}
+
 /*
  * Check interaction of the folio with the file end.
  *
@@ -1806,7 +1845,8 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	unsigned nblocks = i_blocks_per_folio(inode, folio);
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
-	int error = 0, count = 0, i;
+	unsigned count = 0;
+	int error = 0, i;
 	LIST_HEAD(submit_list);
 
 	trace_iomap_writepage(inode, pos, folio_size(folio));
@@ -1832,19 +1872,10 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
 		if (ifs && !ifs_block_is_dirty(folio, ifs, i))
 			continue;
-
-		error = wpc->ops->map_blocks(wpc, inode, pos);
+		error = iomap_writepage_map_blocks(wpc, wbc, folio, inode, pos,
+				&count, &submit_list);
 		if (error)
 			break;
-		trace_iomap_writepage_map(inode, &wpc->iomap);
-		if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE)) {
-			error = -EIO;
-			break;
-		}
-		if (wpc->iomap.type == IOMAP_HOLE)
-			continue;
-		iomap_add_to_ioend(wpc, wbc, folio, inode, pos, &submit_list);
-		count++;
 	}
 	if (count)
 		wpc->nr_folios++;
@@ -1854,21 +1885,6 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	WARN_ON_ONCE(folio_test_writeback(folio));
 	WARN_ON_ONCE(folio_test_dirty(folio));
 
-	/*
-	 * We cannot cancel the ioend directly here on error.  We may have
-	 * already set other pages under writeback and hence we have to run I/O
-	 * completion to mark the error state of the pages under writeback
-	 * appropriately.
-	 */
-	if (unlikely(error)) {
-		/*
-		 * Let the filesystem know what portion of the current page
-		 * failed to map.
-		 */
-		if (wpc->ops->discard_folio)
-			wpc->ops->discard_folio(folio, pos);
-	}
-
 	/*
 	 * We can have dirty bits set past end of file in page_mkwrite path
 	 * while mapping the last partial folio. Hence it's better to clear
-- 
2.39.2


