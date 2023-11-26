Return-Path: <linux-fsdevel+bounces-3847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C3B7F92AD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 13:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFB428114A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 12:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9308BDDA0;
	Sun, 26 Nov 2023 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SkqyrcyT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F433EB;
	Sun, 26 Nov 2023 04:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DnW5FaY2JPUdEYeKkwlUgXI6kxbQRrG+lXTwt1j3Pj8=; b=SkqyrcyTWBevzcViL8RCvyh8oM
	fhW8wGieAcY/7Ik2E1WUOMtf0BhdmTbtGqkOkKltT3v06dwXlY1X3Lev0WuwWF1EouauF0kzdBrlG
	8od2UZfj7AYbRGXz0niRE2BB/vC1GN4H8QS4EY0oQ3jxm13V6C3c/RdaV+0vZsCoIhkfYV/efOuZ4
	jC4LthkILELqGBgdEjT5H28FgJOWLHF1begp1Xlt9umtOHIpR1Jjzmvco4nD7xnjcAM05Zh3ih/q4
	+tSqGFyqbD+sd/EWClA5DXXqWNxFxdtuAbeSYWvk3z2eky16BdUBOgIovQ3oO2lA6bR27qqbdLWHf
	V+XkGzJw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r7EY4-00BCIQ-1w;
	Sun, 26 Nov 2023 12:47:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/13] iomap: move all remaining per-folio logic into xfs_writepage_map
Date: Sun, 26 Nov 2023 13:47:13 +0100
Message-Id: <20231126124720.1249310-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231126124720.1249310-1-hch@lst.de>
References: <20231126124720.1249310-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Move the tracepoint and the iomap check from iomap_do_writepage into
iomap_writepage_map.  This keeps all logic in one places, and leaves
iomap_do_writepage just as the wrapper for the callback conventions of
write_cache_pages, which will go away when that is convertd to an
iterator.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4a5a21809b0182..5834aa46bdb8cf 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1842,19 +1842,25 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
  * At the end of a writeback pass, there will be a cached ioend remaining on the
  * writepage context that the caller will need to submit.
  */
-static int
-iomap_writepage_map(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct inode *inode,
-		struct folio *folio, u64 end_pos)
+static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
+		struct writeback_control *wbc, struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
+	struct inode *inode = folio->mapping->host;
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	unsigned nblocks = i_blocks_per_folio(inode, folio);
 	u64 pos = folio_pos(folio);
+	u64 end_pos = pos + folio_size(folio);
 	int error = 0, count = 0, i;
 	LIST_HEAD(submit_list);
 
+	trace_iomap_writepage(inode, pos, folio_size(folio));
+
+	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
+		folio_unlock(folio);
+		return 0;
+	}
 	WARN_ON_ONCE(end_pos <= pos);
 
 	if (!ifs && nblocks > 1) {
@@ -1952,28 +1958,10 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	return error;
 }
 
-/*
- * Write out a dirty page.
- *
- * For delalloc space on the page, we need to allocate space and flush it.
- * For unwritten space on the page, we need to start the conversion to
- * regular allocated space.
- */
 static int iomap_do_writepage(struct folio *folio,
 		struct writeback_control *wbc, void *data)
 {
-	struct iomap_writepage_ctx *wpc = data;
-	struct inode *inode = folio->mapping->host;
-	u64 end_pos = folio_pos(folio) + folio_size(folio);
-
-	trace_iomap_writepage(inode, folio_pos(folio), folio_size(folio));
-
-	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
-		folio_unlock(folio);
-		return 0;
-	}
-
-	return iomap_writepage_map(wpc, wbc, inode, folio, end_pos);
+	return iomap_writepage_map(data, wbc, folio);
 }
 
 int
-- 
2.39.2


