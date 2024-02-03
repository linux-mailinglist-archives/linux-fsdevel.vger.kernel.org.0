Return-Path: <linux-fsdevel+bounces-10131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3131B848444
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 08:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE235B2252F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 07:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20872524C1;
	Sat,  3 Feb 2024 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZpxFIRF0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EC151C44;
	Sat,  3 Feb 2024 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706944356; cv=none; b=blBwZl4cPjSfU0pQQaV6zjEyrhCW+E4DFaBzEnNUvbnPNPNmDc7W2MgCsEDV0q8EulvTioi268Xlkx0SmdSf0OlYyhrm3+DFYRRVNK78NRWGIeCvVjNEfSs+41tUzTlvTZPR0TICcOCzDkqA81gexnKXc/CzZP+1tzxA2WOuNGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706944356; c=relaxed/simple;
	bh=C1UgprNPOHV5lXFEJypnLKWveW2N3jNOillkGbIi414=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T+4A5RNrqGdyjLgwjrTv0TlUHGplvrrGv0SWeXiE6CW2YAjWU86eeGN273uh9E2t3cUu2RFRx/QG4rwtFQeT1RtUMsu9rsgLndwS4CwscCtiQBZFT+B1TixCwFGt3w5PqvWfIgfTo6EnoIZGXD8onkP6VyKiBRR6mYSXjLWOGiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZpxFIRF0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=e37EqS2ZYYTeeuRHGuEE+Jp38DFAOi6vK8cHvx3Jpt4=; b=ZpxFIRF0rwjTTxnnah1dH4r+g/
	N+x8kCIzZ77fhJadth50deaJ77t6djMUAPPcuUsG1BbnsxFdWYEzisaWKSgIBC8xV1DytPxrky3Kq
	4Bmxmc3DKJhdTBatFBqeQFMkzLwlbU0XxvcSsuXqZqOCepbKrwmBI3VW1YMpzQanXhV/rM5cjAK4n
	fNlo6Cd3ftcE74+bpOHcLUbnwvNg2EgWBQqWeGCkHKvr+yDL9l9MwidQlkyhRbp2WGHa63Zz95LHJ
	vaMEze6Ezzq8d+IedDrC8ow1o8kZucRlgXIPTCXgpzDvwGD0AuTEHieil/ddDKnJ6ZHMijpArgbhA
	gVVCUrpg==;
Received: from [89.144.222.32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWACV-0000000Fk90-2Gz9;
	Sat, 03 Feb 2024 07:12:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 07/13] writeback: Factor writeback_get_batch() out of write_cache_pages()
Date: Sat,  3 Feb 2024 08:11:41 +0100
Message-Id: <20240203071147.862076-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240203071147.862076-1-hch@lst.de>
References: <20240203071147.862076-1-hch@lst.de>
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
[hch: heavily rebased, add helpers to get the tag and end index,
      don't keep the end index in struct writeback_control]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/writeback.h |  6 ++++
 mm/page-writeback.c       | 60 +++++++++++++++++++++++++--------------
 2 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 4b8cf9e4810bad..f67b3ea866a0fb 100644
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
+	pgoff_t index;
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct bdi_writeback *wb;	/* wb this writeback is issued under */
 	struct inode *inode;		/* inode being written out */
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 949193624baa38..23363ed712f646 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2392,6 +2392,29 @@ static bool folio_prepare_writeback(struct address_space *mapping,
 	return true;
 }
 
+static xa_mark_t wbc_to_tag(struct writeback_control *wbc)
+{
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		return PAGECACHE_TAG_TOWRITE;
+	return PAGECACHE_TAG_DIRTY;
+}
+
+static pgoff_t wbc_end(struct writeback_control *wbc)
+{
+	if (wbc->range_cyclic)
+		return -1;
+	return wbc->range_end >> PAGE_SHIFT;
+}
+
+static void writeback_get_batch(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	folio_batch_release(&wbc->fbatch);
+	cond_resched();
+	filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
+			wbc_to_tag(wbc), &wbc->fbatch);
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2429,38 +2452,32 @@ int write_cache_pages(struct address_space *mapping,
 {
 	int ret = 0;
 	int error;
-	struct folio_batch fbatch;
 	struct folio *folio;
-	int nr_folios;
-	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
-	xa_mark_t tag;
 
-	folio_batch_init(&fbatch);
 	if (wbc->range_cyclic) {
-		index = mapping->writeback_index; /* prev offset */
+		wbc->index = mapping->writeback_index; /* prev offset */
 		end = -1;
 	} else {
-		index = wbc->range_start >> PAGE_SHIFT;
+		wbc->index = wbc->range_start >> PAGE_SHIFT;
 		end = wbc->range_end >> PAGE_SHIFT;
 	}
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) {
-		tag_pages_for_writeback(mapping, index, end);
-		tag = PAGECACHE_TAG_TOWRITE;
-	} else {
-		tag = PAGECACHE_TAG_DIRTY;
-	}
-	while (index <= end) {
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		tag_pages_for_writeback(mapping, wbc->index, end);
+
+	folio_batch_init(&wbc->fbatch);
+
+	while (wbc->index <= end) {
 		int i;
 
-		nr_folios = filemap_get_folios_tag(mapping, &index, end,
-				tag, &fbatch);
+		writeback_get_batch(mapping, wbc);
 
-		if (nr_folios == 0)
+		if (wbc->fbatch.nr == 0)
 			break;
 
-		for (i = 0; i < nr_folios; i++) {
-			folio = fbatch.folios[i];
+		for (i = 0; i < wbc->fbatch.nr; i++) {
+			folio = wbc->fbatch.folios[i];
+
 			folio_lock(folio);
 			if (!folio_prepare_writeback(mapping, wbc, folio)) {
 				folio_unlock(folio);
@@ -2498,8 +2515,6 @@ int write_cache_pages(struct address_space *mapping,
 					goto done;
 			}
 		}
-		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 
 	/*
@@ -2512,12 +2527,13 @@ int write_cache_pages(struct address_space *mapping,
 	 * of the file if we are called again, which can only happen due to
 	 * -ENOMEM from the file system.
 	 */
+	folio_batch_release(&wbc->fbatch);
 	if (wbc->range_cyclic)
 		mapping->writeback_index = 0;
 	return ret;
 
 done:
-	folio_batch_release(&fbatch);
+	folio_batch_release(&wbc->fbatch);
 	if (wbc->range_cyclic)
 		mapping->writeback_index = folio->index + folio_nr_pages(folio);
 	return error;
-- 
2.39.2


