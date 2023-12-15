Return-Path: <linux-fsdevel+bounces-6216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 200928150C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0BC1F27F29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 20:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E181368B64;
	Fri, 15 Dec 2023 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o+JIP3Od"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240AC563A7;
	Fri, 15 Dec 2023 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=iWuo/17AnVV2eL2F0kRsj8EINE9372h1+vI87BJPV7s=; b=o+JIP3Odm8bEnfQ/co0ItO1vUz
	FRCFZFMMWJh39c2OJ4pHnnRSXol2eGTQzvKBUoVSfB20fwKFrZA3wKsqZsr2YHyafQXYFUXMn1rHH
	cOBIOb2YY6Hj+KAdXak5LJb73NiqYrROPbU2EToKFYA674ZKv5LZ6kwO7ouX7viF9OkbnbswbwXrC
	TBz9oRgmsR+zHSkSbjXKk0DrWRe1fpVRuNRq5Xko8CZ/QKM1AnM7qXh2R85fsPkqeqmLjEAMlH9yx
	LyW4Nkj0nwO+PgXBVY42quKEd4SYEgBXDxoM1aAg713iRRDworTk/HNRX5qmCjzEQVeuu7roWSeKk
	+wect5ww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEEOV-0038im-ER; Fri, 15 Dec 2023 20:02:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 06/14] bfs: Remove writepage implementation
Date: Fri, 15 Dec 2023 20:02:37 +0000
Message-Id: <20231215200245.748418-7-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231215200245.748418-1-willy@infradead.org>
References: <20231215200245.748418-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the filesystem implements migrate_folio and writepages, there is
no need for a writepage implementation.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/bfs/file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index adc2230079c6..a778411574a9 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/mpage.h>
 #include <linux/buffer_head.h>
 #include "bfs.h"
 
@@ -150,9 +151,10 @@ static int bfs_get_block(struct inode *inode, sector_t block,
 	return err;
 }
 
-static int bfs_writepage(struct page *page, struct writeback_control *wbc)
+static int bfs_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
-	return block_write_full_page(page, bfs_get_block, wbc);
+	return mpage_writepages(mapping, wbc, bfs_get_block);
 }
 
 static int bfs_read_folio(struct file *file, struct folio *folio)
@@ -190,9 +192,10 @@ const struct address_space_operations bfs_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio	= bfs_read_folio,
-	.writepage	= bfs_writepage,
+	.writepages	= bfs_writepages,
 	.write_begin	= bfs_write_begin,
 	.write_end	= generic_write_end,
+	.migrate_folio	= buffer_migrate_folio,
 	.bmap		= bfs_bmap,
 };
 
-- 
2.42.0


