Return-Path: <linux-fsdevel+bounces-2127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C6D7E2B44
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7AD728184D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE292D046;
	Mon,  6 Nov 2023 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z/309ShV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A489F2C846
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 17:39:14 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390ABD7E;
	Mon,  6 Nov 2023 09:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=WMfnqygTYr57TB2SIEdKYkur5BHxcXcMLwxo3SfQNGE=; b=Z/309ShVqrHgJqjX5ad1rsasUc
	pdnYm23pylROeLhCd0AXo3RzXv+7Tjwh1fFqEpDWJmVN3m1ObHnDQ+NSTBKEkLL9jMlvJt+QnGM6J
	GpQiyi/FgES/QyWR79e9jWEcKcu7jdfhQImrDExriDXWu9Kj83iNLyczONsUkwxTT6v7YzkwbtZyj
	N3MTUYh7NDEGbL17r7FTQzT191MRsGZl4btLawcz4i57LVW2D+JCCvJVAoRx4xaqAnnuxzJRiD+Ni
	pTQl7yYygdi3s7UwOOAIyg7iLjEb0Spu7bQXgZRf5h3YTWqQSRqAEnDF3EavVaCIzRhZ1QASk+Q9m
	7J2QdmsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r03Z4-007H8d-Us; Mon, 06 Nov 2023 17:39:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/35] nilfs2: Convert nilfs_segctor_prepare_write to use folios
Date: Mon,  6 Nov 2023 17:38:38 +0000
Message-Id: <20231106173903.1734114-11-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106173903.1734114-1-willy@infradead.org>
References: <20231106173903.1734114-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new folio APIs, saving 17 hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/segment.c | 58 ++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 8c675c118c66..52995838f2de 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1665,39 +1665,39 @@ static int nilfs_segctor_assign(struct nilfs_sc_info *sci, int mode)
 	return 0;
 }
 
-static void nilfs_begin_page_io(struct page *page)
+static void nilfs_begin_folio_io(struct folio *folio)
 {
-	if (!page || PageWriteback(page))
+	if (!folio || folio_test_writeback(folio))
 		/*
 		 * For split b-tree node pages, this function may be called
 		 * twice.  We ignore the 2nd or later calls by this check.
 		 */
 		return;
 
-	lock_page(page);
-	clear_page_dirty_for_io(page);
-	set_page_writeback(page);
-	unlock_page(page);
+	folio_lock(folio);
+	folio_clear_dirty_for_io(folio);
+	folio_start_writeback(folio);
+	folio_unlock(folio);
 }
 
 static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 {
 	struct nilfs_segment_buffer *segbuf;
-	struct page *bd_page = NULL, *fs_page = NULL;
+	struct folio *bd_folio = NULL, *fs_folio = NULL;
 
 	list_for_each_entry(segbuf, &sci->sc_segbufs, sb_list) {
 		struct buffer_head *bh;
 
 		list_for_each_entry(bh, &segbuf->sb_segsum_buffers,
 				    b_assoc_buffers) {
-			if (bh->b_page != bd_page) {
-				if (bd_page) {
-					lock_page(bd_page);
-					clear_page_dirty_for_io(bd_page);
-					set_page_writeback(bd_page);
-					unlock_page(bd_page);
+			if (bh->b_folio != bd_folio) {
+				if (bd_folio) {
+					folio_lock(bd_folio);
+					folio_clear_dirty_for_io(bd_folio);
+					folio_start_writeback(bd_folio);
+					folio_unlock(bd_folio);
 				}
-				bd_page = bh->b_page;
+				bd_folio = bh->b_folio;
 			}
 		}
 
@@ -1705,28 +1705,28 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 				    b_assoc_buffers) {
 			set_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
-				if (bh->b_page != bd_page) {
-					lock_page(bd_page);
-					clear_page_dirty_for_io(bd_page);
-					set_page_writeback(bd_page);
-					unlock_page(bd_page);
-					bd_page = bh->b_page;
+				if (bh->b_folio != bd_folio) {
+					folio_lock(bd_folio);
+					folio_clear_dirty_for_io(bd_folio);
+					folio_start_writeback(bd_folio);
+					folio_unlock(bd_folio);
+					bd_folio = bh->b_folio;
 				}
 				break;
 			}
-			if (bh->b_page != fs_page) {
-				nilfs_begin_page_io(fs_page);
-				fs_page = bh->b_page;
+			if (bh->b_folio != fs_folio) {
+				nilfs_begin_folio_io(fs_folio);
+				fs_folio = bh->b_folio;
 			}
 		}
 	}
-	if (bd_page) {
-		lock_page(bd_page);
-		clear_page_dirty_for_io(bd_page);
-		set_page_writeback(bd_page);
-		unlock_page(bd_page);
+	if (bd_folio) {
+		folio_lock(bd_folio);
+		folio_clear_dirty_for_io(bd_folio);
+		folio_start_writeback(bd_folio);
+		folio_unlock(bd_folio);
 	}
-	nilfs_begin_page_io(fs_page);
+	nilfs_begin_folio_io(fs_folio);
 }
 
 static int nilfs_segctor_write(struct nilfs_sc_info *sci,
-- 
2.42.0


