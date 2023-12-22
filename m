Return-Path: <linux-fsdevel+bounces-6793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09C081CBC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 16:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FDD1C211FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 15:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D01F28E16;
	Fri, 22 Dec 2023 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IUhhnEiE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895A28DCB;
	Fri, 22 Dec 2023 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/YruVy693sIGMqSVhVr/4+JF9RoXWgnIrtLSdSPK4mw=; b=IUhhnEiESKEpLJdHRKcnKDOIrR
	X/YC3xSsenqLCvV2hqbEjMjE89Dggeuq/l0/DFlCqq2/Dv9lihc3A4g65Is18xfqqudV8B8C6VTg8
	98zB4odPXmtfjhGlT9Qr5bZE5v6hPJC3SONm67/k3Xp57dGsKfSil1ishKDCXwqnoavb2P7c8sUfr
	xpVag96xhLM5Gv7QXvrXSKHI2r/WRkoMO8M3woP4O5IILeOj3HNKE56jPhc81gRlYy/HbeVTNijyj
	iI71h+qfhB9lepfDz1Iwo3wR6OeeSGbmlaG8fi6gRgnQVU6rZW669WmymrBZG0afHVD/S/0WwrTLO
	MR/NZ56Q==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGh8k-006BPW-0l;
	Fri, 22 Dec 2023 15:08:42 +0000
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
Subject: [PATCH 06/17] writeback: Factor out writeback_finish()
Date: Fri, 22 Dec 2023 16:08:16 +0100
Message-Id: <20231222150827.1329938-7-hch@lst.de>
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

Instead of having a 'done' variable that controls the nested loops,
have a writeback_finish() that can be returned directly.  This involves
keeping more things in writeback_control, but it's just moving stuff
allocated on the stack to being allocated slightly earlier on the stack.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
[hch: heavily rebased, reordered and commented struct writeback_control]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/writeback.h |  6 +++
 mm/page-writeback.c       | 79 ++++++++++++++++++++-------------------
 2 files changed, 47 insertions(+), 38 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 833ec38fc3e0c9..390f2dd03cf27e 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -11,6 +11,7 @@
 #include <linux/flex_proportions.h>
 #include <linux/backing-dev-defs.h>
 #include <linux/blk_types.h>
+#include <linux/pagevec.h>
 
 struct bio;
 
@@ -40,6 +41,7 @@ enum writeback_sync_modes {
  * in a manner such that unspecified fields are set to zero.
  */
 struct writeback_control {
+	/* public fields that can be set and/or consumed by the caller: */
 	long nr_to_write;		/* Write this many pages, and decrement
 					   this for each page written */
 	long pages_skipped;		/* Pages which were not written */
@@ -77,6 +79,10 @@ struct writeback_control {
 	 */
 	struct swap_iocb **swap_plug;
 
+	/* internal fields used by the ->writepages implementation: */
+	struct folio_batch fbatch;
+	int err;
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct bdi_writeback *wb;	/* wb this writeback is issued under */
 	struct inode *inode;		/* inode being written out */
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index c798c0d6d0abb4..564d5faf562ba7 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2360,6 +2360,29 @@ void tag_pages_for_writeback(struct address_space *mapping,
 }
 EXPORT_SYMBOL(tag_pages_for_writeback);
 
+static void writeback_finish(struct address_space *mapping,
+		struct writeback_control *wbc, pgoff_t done_index)
+{
+	folio_batch_release(&wbc->fbatch);
+
+	/*
+	 * For range cyclic writeback we need to remember where we stopped so
+	 * that we can continue there next time we are called.  If  we hit the
+	 * last page and there is more work to be done, wrap back to the start
+	 * of the file.
+	 *
+	 * For non-cyclic writeback we always start looking up at the beginning
+	 * of the file if we are called again, which can only happen due to
+	 * -ENOMEM from the file system.
+	 */
+	if (wbc->range_cyclic) {
+		if (wbc->err || wbc->nr_to_write <= 0)
+			mapping->writeback_index = done_index;
+		else
+			mapping->writeback_index = 0;
+	}
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2395,17 +2418,12 @@ int write_cache_pages(struct address_space *mapping,
 		      struct writeback_control *wbc, writepage_t writepage,
 		      void *data)
 {
-	int ret = 0;
-	int done = 0;
 	int error;
-	struct folio_batch fbatch;
 	int nr_folios;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
-	pgoff_t done_index;
 	xa_mark_t tag;
 
-	folio_batch_init(&fbatch);
 	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* prev offset */
 		end = -1;
@@ -2419,22 +2437,23 @@ int write_cache_pages(struct address_space *mapping,
 	} else {
 		tag = PAGECACHE_TAG_DIRTY;
 	}
-	done_index = index;
-	while (!done && (index <= end)) {
+
+	folio_batch_init(&wbc->fbatch);
+	wbc->err = 0;
+
+	while (index <= end) {
 		int i;
 
 		nr_folios = filemap_get_folios_tag(mapping, &index, end,
-				tag, &fbatch);
+				tag, &wbc->fbatch);
 
 		if (nr_folios == 0)
 			break;
 
 		for (i = 0; i < nr_folios; i++) {
-			struct folio *folio = fbatch.folios[i];
+			struct folio *folio = wbc->fbatch.folios[i];
 			unsigned long nr;
 
-			done_index = folio->index;
-
 			folio_lock(folio);
 
 			/*
@@ -2481,6 +2500,9 @@ int write_cache_pages(struct address_space *mapping,
 				folio_unlock(folio);
 				error = 0;
 			}
+		
+			if (error && !wbc->err)
+				wbc->err = error;
 
 			/*
 			 * For integrity sync  we have to keep going until we
@@ -2496,38 +2518,19 @@ int write_cache_pages(struct address_space *mapping,
 			 * off and media errors won't choke writeout for the
 			 * entire file.
 			 */
-			if (error && !ret)
-				ret = error;
-			if (wbc->sync_mode == WB_SYNC_NONE) {
-				if (ret || wbc->nr_to_write <= 0) {
-					done_index = folio->index + nr;
-					done = 1;
-					break;
-				}
+			if (wbc->sync_mode == WB_SYNC_NONE &&
+			    (wbc->err || wbc->nr_to_write <= 0)) {
+				writeback_finish(mapping, wbc,
+						folio->index + nr);
+				return error;
 			}
 		}
-		folio_batch_release(&fbatch);
+		folio_batch_release(&wbc->fbatch);
 		cond_resched();
 	}
 
-	/*
-	 * For range cyclic writeback we need to remember where we stopped so
-	 * that we can continue there next time we are called.  If  we hit the
-	 * last page and there is more work to be done, wrap back to the start
-	 * of the file.
-	 *
-	 * For non-cyclic writeback we always start looking up at the beginning
-	 * of the file if we are called again, which can only happen due to
-	 * -ENOMEM from the file system.
-	 */
-	if (wbc->range_cyclic) {
-		if (done)
-			mapping->writeback_index = done_index;
-		else
-			mapping->writeback_index = 0;
-	}
-
-	return ret;
+	writeback_finish(mapping, wbc, 0);
+	return 0;
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-- 
2.39.2


