Return-Path: <linux-fsdevel+bounces-6795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD5381CBCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 16:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54B33B2563C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 15:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B6B2C1B8;
	Fri, 22 Dec 2023 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wfmB6gnW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69B2C19F;
	Fri, 22 Dec 2023 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BwSwsSrvBcosA4alobfWiefPc9fIbR5mK3Ls0770Y3s=; b=wfmB6gnWpnCr0AsGy1pjmk2FRv
	9RZSI3vxFS6RBs4R1tZQlsDjGMbS5AgfaIQyY8ZfRUa4Z0Obe+NYQYoO8e7R/4Gt2MiyF4eHZhRpa
	04GcAhvmm7iS/h1QLGYOxhyxxFto7ZTNAYSq8hoonSrTIW3QjmzBVy9hvaw9kQzam+c+YWh/OsC7/
	vN8H5b3iW7d1DEOYaDwwWMp75w/Qoi7X7UiegVtM3tVbW7TPNFsyHfpA2nIdBmnDd7s88Npe2D92p
	0alD3lK0uoAVqQynOao5x+eGhNarLIbFcKcxno0TpTXOOEO9PCYfs8kBEYY8lzUkrY//dXLo6d4qB
	F8spWMTw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGh8p-006BRN-0o;
	Fri, 22 Dec 2023 15:08:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 08/17] writeback: Factor folio_prepare_writeback() out of write_cache_pages()
Date: Fri, 22 Dec 2023 16:08:18 +0100
Message-Id: <20231222150827.1329938-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231222150827.1329938-1-hch@lst.de>
References: <20231222150827.1329938-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Reduce write_cache_pages() by about 30 lines; much of it is commentary,
but it all bundles nicely into an obvious function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
[hch: rename should_writeback_folio to folio_prepare_writeback based on
      a comment from Jan Kara]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 61 +++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 798e5264dc0353..fe508548482217 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2397,6 +2397,38 @@ static pgoff_t wbc_end(struct writeback_control *wbc)
 	return wbc->range_end >> PAGE_SHIFT;
 }
 
+static bool folio_prepare_writeback(struct address_space *mapping,
+		struct writeback_control *wbc, struct folio *folio)
+{
+	/*
+	 * Folio truncated or invalidated. We can freely skip it then,
+	 * even for data integrity operations: the folio has disappeared
+	 * concurrently, so there could be no real expectation of this
+	 * data integrity operation even if there is now a new, dirty
+	 * folio at the same pagecache index.
+	 */
+	if (unlikely(folio->mapping != mapping))
+		return false;
+
+	/*
+	 * Did somebody else write it for us?
+	 */
+	if (!folio_test_dirty(folio))
+		return false;
+
+	if (folio_test_writeback(folio)) {
+		if (wbc->sync_mode == WB_SYNC_NONE)
+			return false;
+		folio_wait_writeback(folio);
+	}
+	BUG_ON(folio_test_writeback(folio));
+
+	if (!folio_clear_dirty_for_io(folio))
+		return false;
+
+	return true;
+}
+
 static void writeback_get_batch(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
@@ -2470,38 +2502,13 @@ int write_cache_pages(struct address_space *mapping,
 			unsigned long nr;
 
 			folio_lock(folio);
-
-			/*
-			 * Page truncated or invalidated. We can freely skip it
-			 * then, even for data integrity operations: the page
-			 * has disappeared concurrently, so there could be no
-			 * real expectation of this data integrity operation
-			 * even if there is now a new, dirty page at the same
-			 * pagecache address.
-			 */
-			if (unlikely(folio->mapping != mapping)) {
-continue_unlock:
+			if (!folio_prepare_writeback(mapping, wbc, folio)) {
 				folio_unlock(folio);
 				continue;
 			}
 
-			if (!folio_test_dirty(folio)) {
-				/* someone wrote it for us */
-				goto continue_unlock;
-			}
-
-			if (folio_test_writeback(folio)) {
-				if (wbc->sync_mode != WB_SYNC_NONE)
-					folio_wait_writeback(folio);
-				else
-					goto continue_unlock;
-			}
-
-			BUG_ON(folio_test_writeback(folio));
-			if (!folio_clear_dirty_for_io(folio))
-				goto continue_unlock;
-
 			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
+
 			error = writepage(folio, wbc, data);
 			nr = folio_nr_pages(folio);
 			wbc->nr_to_write -= nr;
-- 
2.39.2


