Return-Path: <linux-fsdevel+bounces-2135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA927E2B4B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2512C1C20C81
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B222D7B3;
	Mon,  6 Nov 2023 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hZtcL/en"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A43F2D022
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 17:39:18 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F122410E4;
	Mon,  6 Nov 2023 09:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=SR/M6J1eCYzIfQnXQGYhFKKiXejmTRdamnCzS3EwsIM=; b=hZtcL/enOfsVgkh/Xwpllkix9F
	HBCfh6jJtyzI6iodIhegX6pFz/1Vb6UZjkmrKXtmTKf3bKqFDmKFXoG5nw3QwoA/f08bHNpXUNGqF
	ahxemfdhPA8H/bZCS31RE29/vTG5OVf9+s1rrrk6LFRCwYPtfsppHEufVQg+Csi5CkU9575oKp9n3
	nxGOD6OJbbjKBIoBcCWG1cV+gnaTUQjw5C+7ABkuMWxgaYzY0Gjyx/W222nEGC03povpERLvaXnD6
	hCdqppExoQqdcOW8TLRY7FXdqudr8n6xR0qwtkyAwx0romWgLimZZqGQFA0jDDrc98etFHPnJPzJp
	cp8eDV3g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r03Z3-007H7p-R1; Mon, 06 Nov 2023 17:39:05 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/35] nilfs2: Add nilfs_end_folio_io()
Date: Mon,  6 Nov 2023 17:38:29 +0000
Message-Id: <20231106173903.1734114-2-willy@infradead.org>
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

This is the folio counterpart of the existing nilfs_end_page_io()
which is retained as a wrapper of nilfs_end_folio_io().  Replaces
nine hidden calls to compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/segment.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 55e31cc903d1..1df03d0895be 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1739,17 +1739,18 @@ static int nilfs_segctor_write(struct nilfs_sc_info *sci,
 	return ret;
 }
 
-static void nilfs_end_page_io(struct page *page, int err)
+static void nilfs_end_folio_io(struct folio *folio, int err)
 {
-	if (!page)
+	if (!folio)
 		return;
 
-	if (buffer_nilfs_node(page_buffers(page)) && !PageWriteback(page)) {
+	if (buffer_nilfs_node(folio_buffers(folio)) &&
+			!folio_test_writeback(folio)) {
 		/*
 		 * For b-tree node pages, this function may be called twice
 		 * or more because they might be split in a segment.
 		 */
-		if (PageDirty(page)) {
+		if (folio_test_dirty(folio)) {
 			/*
 			 * For pages holding split b-tree node buffers, dirty
 			 * flag on the buffers may be cleared discretely.
@@ -1757,24 +1758,31 @@ static void nilfs_end_page_io(struct page *page, int err)
 			 * remaining buffers, and it must be cancelled if
 			 * all the buffers get cleaned later.
 			 */
-			lock_page(page);
-			if (nilfs_page_buffers_clean(page))
-				__nilfs_clear_page_dirty(page);
-			unlock_page(page);
+			folio_lock(folio);
+			if (nilfs_page_buffers_clean(&folio->page))
+				__nilfs_clear_page_dirty(&folio->page);
+			folio_unlock(folio);
 		}
 		return;
 	}
 
 	if (!err) {
-		if (!nilfs_page_buffers_clean(page))
-			__set_page_dirty_nobuffers(page);
-		ClearPageError(page);
+		if (!nilfs_page_buffers_clean(&folio->page))
+			filemap_dirty_folio(folio->mapping, folio);
+		folio_clear_error(folio);
 	} else {
-		__set_page_dirty_nobuffers(page);
-		SetPageError(page);
+		filemap_dirty_folio(folio->mapping, folio);
+		folio_set_error(folio);
 	}
 
-	end_page_writeback(page);
+	folio_end_writeback(folio);
+}
+
+static void nilfs_end_page_io(struct page *page, int err)
+{
+	if (!page)
+		return;
+	nilfs_end_folio_io(page_folio(page), err);
 }
 
 static void nilfs_abort_logs(struct list_head *logs, int err)
-- 
2.42.0


