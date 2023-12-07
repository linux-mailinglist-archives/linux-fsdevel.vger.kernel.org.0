Return-Path: <linux-fsdevel+bounces-5117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA24808358
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9E31F22353
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90694328C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RIUcxFiW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CF0D53;
	Wed,  6 Dec 2023 23:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QONJ5rVMeXRLccdslDLpZ5HqIsxxIVMeDHe0C1ZUtgk=; b=RIUcxFiWEJ0V302AG0+hUHEj0v
	n9k1soiml3LNoAh5NB1kmRciUTAtP3XtynwvEjVTBgl07VlkkLBLEbYdVMwt4qMIvf2N4JtQ8IlZg
	LuMytH5CzCDmdpO5zWsVkmvNK73VX8TziCKRe11FZFvTopoy2Ak7ITh/XYlInBaw7qp+yqyMplxAd
	mMiSnQudZoyfYiqW7GJkFfcYvaD4zRYu8rlywkzr/BQVcuM+Y2z2db+rjlA61OlOvRpQmnCvrPO1A
	FyxR90xeyu1z5O226OnD/qioo8+KKZg4hImspan9q/G3UZCMQVaCtLElpHs9Cdbc9ydVYFqEqoO3k
	lXPS/Euw==;
Received: from [2001:4bb8:191:e7ca:4bf6:cea4:9bbf:8b02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rB8nE-00C4ze-26;
	Thu, 07 Dec 2023 07:27:33 +0000
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
Subject: [PATCH 06/14] iomap: move all remaining per-folio logic into iomap_writepage_map
Date: Thu,  7 Dec 2023 08:27:02 +0100
Message-Id: <20231207072710.176093-7-hch@lst.de>
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

Move the tracepoint and the iomap check from iomap_do_writepage into
iomap_writepage_map.  This keeps all logic in one places, and leaves
iomap_do_writepage just as the wrapper for the callback conventions of
write_cache_pages, which will go away when that is converted to an
iterator.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c011647239f84e..be23defc09c325 100644
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
@@ -1954,28 +1960,10 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
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


