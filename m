Return-Path: <linux-fsdevel+bounces-6061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A43B813163
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 14:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43451F21FD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 13:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8615645A;
	Thu, 14 Dec 2023 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iaO3zrW7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810D6114;
	Thu, 14 Dec 2023 05:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gFAfQ8RI4NZqa/9LCD+jS3TStiD980ne3/Qcf1aEZzA=; b=iaO3zrW79MSicmR2sZYKfRcxiH
	i6dP0SWuEvOwauQFGQNX6drc20R0mQporbqJK9Ae/EpSzZ2URWntRpkaHP0xigV0iDY5QuSJHIiCQ
	Mo7Rto/vqm0//OV5Akxwqp+GKF4VnjeKJIRrzyZvhXp1nfFHZo6clA6Ms2vyByRzAuCo5P769hI0E
	uuu0EStnwmU0hmRpVyXiiEKSAQSDbPs5OhXxok9vD7vVpTfFx0OyvSabAZzyGs9vLoBYXlH08ZvZw
	9amAcoVDpwtwFO+Pq43XGabNC9cEhu43saMRnC8Zp09eKvIPBlEOZtG6iQCulLeEvzO1jHG5Xn8O+
	yftaE4YA==;
Received: from [88.128.88.27] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDlix-000N1N-1b;
	Thu, 14 Dec 2023 13:25:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 02/11] writeback: Factor writeback_get_batch() out of write_cache_pages()
Date: Thu, 14 Dec 2023 14:25:35 +0100
Message-Id: <20231214132544.376574-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214132544.376574-1-hch@lst.de>
References: <20231214132544.376574-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This simple helper will be the basis of the writeback iterator.
To make this work, we need to remember the current index
and end positions in writeback_control.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/writeback.h |  2 ++
 mm/page-writeback.c       | 49 +++++++++++++++++++++------------------
 2 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 05e8add4b5ae3c..be960f92ad9dbd 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -81,6 +81,8 @@ struct writeback_control {
 
 	/* internal fields used by the ->writepages implementation: */
 	struct folio_batch fbatch;
+	pgoff_t index;
+	pgoff_t end;			/* inclusive */
 	pgoff_t done_index;
 	int err;
 	unsigned range_whole:1;		/* entire file */
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 45309f3b8193f8..5d33e7b468e2cc 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2378,6 +2378,22 @@ static int writeback_finish(struct address_space *mapping,
 	return wbc->err;
 }
 
+static void writeback_get_batch(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	xa_mark_t tag;
+
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		tag = PAGECACHE_TAG_TOWRITE;
+	else
+		tag = PAGECACHE_TAG_DIRTY;
+
+	folio_batch_release(&wbc->fbatch);
+	cond_resched();
+	filemap_get_folios_tag(mapping, &wbc->index, wbc->end, tag,
+			&wbc->fbatch);
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2414,41 +2430,32 @@ int write_cache_pages(struct address_space *mapping,
 		      void *data)
 {
 	int error;
-	int nr_folios;
-	pgoff_t index;
-	pgoff_t end;		/* Inclusive */
-	xa_mark_t tag;
 
 	if (wbc->range_cyclic) {
-		index = mapping->writeback_index; /* prev offset */
-		end = -1;
+		wbc->index = mapping->writeback_index; /* prev offset */
+		wbc->end = -1;
 	} else {
-		index = wbc->range_start >> PAGE_SHIFT;
-		end = wbc->range_end >> PAGE_SHIFT;
+		wbc->index = wbc->range_start >> PAGE_SHIFT;
+		wbc->end = wbc->range_end >> PAGE_SHIFT;
 		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
 			wbc->range_whole = 1;
 	}
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
-		tag_pages_for_writeback(mapping, index, end);
-		tag = PAGECACHE_TAG_TOWRITE;
-	} else {
-		tag = PAGECACHE_TAG_DIRTY;
-	}
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		tag_pages_for_writeback(mapping, wbc->index, wbc->end);
 
-	wbc->done_index = index;
+	wbc->done_index = wbc->index;
 	folio_batch_init(&wbc->fbatch);
 	wbc->err = 0;
 
-	while (index <= end) {
+	while (wbc->index <= wbc->end) {
 		int i;
 
-		nr_folios = filemap_get_folios_tag(mapping, &index, end,
-				tag, &wbc->fbatch);
+		writeback_get_batch(mapping, wbc);
 
-		if (nr_folios == 0)
+		if (wbc->fbatch.nr == 0)
 			break;
 
-		for (i = 0; i < nr_folios; i++) {
+		for (i = 0; i < wbc->fbatch.nr; i++) {
 			struct folio *folio = wbc->fbatch.folios[i];
 			unsigned long nr;
 
@@ -2526,8 +2533,6 @@ int write_cache_pages(struct address_space *mapping,
 			    wbc->sync_mode == WB_SYNC_NONE)
 				return writeback_finish(mapping, wbc, true);
 		}
-		folio_batch_release(&wbc->fbatch);
-		cond_resched();
 	}
 
 	return writeback_finish(mapping, wbc, false);
-- 
2.39.2


