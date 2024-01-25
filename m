Return-Path: <linux-fsdevel+bounces-8862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C9683BCB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0E01C2817D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB25D45C04;
	Thu, 25 Jan 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yI1+JGkK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E104594E;
	Thu, 25 Jan 2024 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173161; cv=none; b=DbTsKu3ziso7XUgKfAUkOta6ruQIHenkJ7DX2e36FNL7l2Duno07O/i7E8nAZMKcoYPwbB6Fb6DL72srDX1Dt8bfDXxGX7mxsMMj51BNR9TwUIMZN1DHbcKmPQczqhN+WCd1agBITkr0KnlB/8HEQImbSnawTbKFvNV/3y/4k1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173161; c=relaxed/simple;
	bh=lbhGSsXDUwZ6iENmdMOouvcma3zNI00pVBrb4PXnuHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jM+85TX7VToEpGcYjQwCeYUyJaTs5LFpO0GgoDALknmYqyfPl3Wd6n3BFBNev1hqMC3OctjCySV/iRXeXjSMaaasHMjoTRdFQ6JkE4xpbE/o3mS6eInWIOEE/rtr6nE8/8oIssZLDfYg6h1u/i37dG31AHDnBjc8Q0MR/fThwXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yI1+JGkK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=W1Pg45e3YPveg08TzLy7LzAEvB67BYDtIDXVWrYOF4k=; b=yI1+JGkKxGm9WfeiG/b4Yka18x
	c1mXHaGCYgK6mkxGcVo5gAHbOKDx9+0SYzjipTUFCR7tVQHmx8jfKBwoUQSpzV0Hl0HSi6ZIxbk4X
	o+ZvB7bpE8nEto805bTnTxGxRhJsSbfgcVGM8+wIdOoEikiUBttNbyBcb1DNZ8s75wbzeVEW07tpZ
	qSvj6gzosLUHO646NIP3w95G/xf5aiufxBVQU+oWuTXercuNL6hOZVTSXRRdpOz7d754pCeI68r0r
	Fhvwk5s7Jrh9Acbu4JXBI1UWYk3FH9vxl0k/up76e5MCS4mN1NhPBCzaj0pMgfN7TGLtGYAFIzxdR
	l/0mO7bw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSvZq-007Qbq-19;
	Thu, 25 Jan 2024 08:59:14 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/19] writeback: simplify writeback iteration
Date: Thu, 25 Jan 2024 09:57:58 +0100
Message-Id: <20240125085758.2393327-20-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125085758.2393327-1-hch@lst.de>
References: <20240125085758.2393327-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Based on the feedback from Jan I've tried to figure out how to
avoid the error magic in the for_each_writeback_folio.  This patch
tries to implement this by switching to an open while loop over a
single writeback_iter() function:

	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
		...
	}

the twist here is that the error value is passed by reference, so that
the iterator can restore it when breaking out of the loop.

Additionally it moves the AOP_WRITEPAGE_ACTIVATE out of the iterator
and into the callers, in preparation for eventually killing it off
with the phase out of write_cache_pages().

To me this form of the loop feels easier to follow, and it has the
added advantage that writeback_iter() can actually be nicely used in
nested loops, which should help with further iterizing the iomap
writeback code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c    |   7 +-
 include/linux/writeback.h |  11 +--
 mm/page-writeback.c       | 174 +++++++++++++++++++++-----------------
 3 files changed, 102 insertions(+), 90 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 58b3661f5eac9e..1593a783176ca2 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1985,12 +1985,13 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 		struct iomap_writepage_ctx *wpc,
 		const struct iomap_writeback_ops *ops)
 {
-	struct folio *folio;
-	int ret;
+	struct folio *folio = NULL;
+	int ret = 0;
 
 	wpc->ops = ops;
-	for_each_writeback_folio(mapping, wbc, folio, ret)
+	while ((folio = writeback_iter(mapping, wbc, folio, &ret)))
 		ret = iomap_do_writepage(folio, wbc, wpc);
+
 	if (!wpc->ioend)
 		return ret;
 	return iomap_submit_ioend(wpc, wpc->ioend, ret);
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 2416da933440e2..fc4605627496fc 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -367,15 +367,8 @@ int balance_dirty_pages_ratelimited_flags(struct address_space *mapping,
 
 bool wb_over_bg_thresh(struct bdi_writeback *wb);
 
-struct folio *writeback_iter_init(struct address_space *mapping,
-		struct writeback_control *wbc);
-struct folio *writeback_iter_next(struct address_space *mapping,
-		struct writeback_control *wbc, struct folio *folio, int error);
-
-#define for_each_writeback_folio(mapping, wbc, folio, error)		\
-	for (folio = writeback_iter_init(mapping, wbc);			\
-	     folio || ((error = wbc->err), false);			\
-	     folio = writeback_iter_next(mapping, wbc, folio, error))
+struct folio *writeback_iter(struct address_space *mapping,
+		struct writeback_control *wbc, struct folio *folio, int *error);
 
 typedef int (*writepage_t)(struct folio *folio, struct writeback_control *wbc,
 				void *data);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 2a4b5aee5decd9..9e1cce9be63524 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2360,29 +2360,6 @@ void tag_pages_for_writeback(struct address_space *mapping,
 }
 EXPORT_SYMBOL(tag_pages_for_writeback);
 
-static void writeback_finish(struct address_space *mapping,
-		struct writeback_control *wbc, pgoff_t done_index)
-{
-	folio_batch_release(&wbc->fbatch);
-
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
-		if (wbc->err || wbc->nr_to_write <= 0)
-			mapping->writeback_index = done_index;
-		else
-			mapping->writeback_index = 0;
-	}
-}
-
 static xa_mark_t wbc_to_tag(struct writeback_control *wbc)
 {
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
@@ -2442,10 +2419,8 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 		filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
 				wbc_to_tag(wbc), &wbc->fbatch);
 		folio = folio_batch_next(&wbc->fbatch);
-		if (!folio) {
-			writeback_finish(mapping, wbc, 0);
+		if (!folio)
 			return NULL;
-		}
 	}
 
 	folio_lock(folio);
@@ -2458,60 +2433,92 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 	return folio;
 }
 
-struct folio *writeback_iter_init(struct address_space *mapping,
-		struct writeback_control *wbc)
-{
-	if (wbc->range_cyclic)
-		wbc->index = mapping->writeback_index; /* prev offset */
-	else
-		wbc->index = wbc->range_start >> PAGE_SHIFT;
-
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		tag_pages_for_writeback(mapping, wbc->index, wbc_end(wbc));
-
-	wbc->err = 0;
-	folio_batch_init(&wbc->fbatch);
-	return writeback_get_folio(mapping, wbc);
-}
-
-struct folio *writeback_iter_next(struct address_space *mapping,
-		struct writeback_control *wbc, struct folio *folio, int error)
+/**
+ * writepage_iter - iterate folio of a mapping for writeback
+ * @mapping: address space structure to write
+ * @wbc: writeback context
+ * @folio: previously iterated folio (%NULL to start)
+ * @error: in-out pointer for writeback errors (see below)
+ *
+ * This function should be called in a while loop in the ->writepages
+ * implementation and returns the next folio for the writeback operation
+ * described by @wbc on @mapping.
+ *
+ * To start writeback @folio should be passed as NULL, for every following
+ * iteration the folio returned by this function previously should be passed.
+ * @error should contain the error from the previous writeback iteration when
+ * calling writeback_iter.
+ *
+ * Once the writeback described in @wbc has finished, this function will return
+ * %NULL and if there was an error in any iteration restore it to @error.
+ *
+ * Note: callers should not manually break out of the loop using break or goto.
+ */
+struct folio *writeback_iter(struct address_space *mapping,
+		struct writeback_control *wbc, struct folio *folio, int *error)
 {
-	unsigned long nr = folio_nr_pages(folio);
+	if (folio) {
+		wbc->nr_to_write -= folio_nr_pages(folio);
+		if (*error && !wbc->err)
+			wbc->err = *error;
 
-	wbc->nr_to_write -= nr;
-
-	/*
-	 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return value.
-	 * Eventually all instances should just unlock the folio themselves and
-	 * return 0;
-	 */
-	if (error == AOP_WRITEPAGE_ACTIVATE) {
-		folio_unlock(folio);
-		error = 0;
+		/*
+		 * For integrity sync  we have to keep going until we have
+		 * written all the folios we tagged for writeback prior to
+		 * entering the writeback loop, even if we run past
+		 * wbc->nr_to_write or encounter errors.
+		 *
+		 * This is because the file system may still have state to clear
+		 * for each folio.  We'll eventually return the first error
+		 * encountered.
+		 *
+		 * For background writeback just push done_index past this folio
+		 * so that we can just restart where we left off and media
+		 * errors won't choke writeout for the entire file.
+		 */
+		if (wbc->sync_mode == WB_SYNC_NONE &&
+		    (wbc->err || wbc->nr_to_write <= 0))
+			goto finish;
+	} else {
+		if (wbc->range_cyclic)
+			wbc->index = mapping->writeback_index; /* prev offset */
+		else
+			wbc->index = wbc->range_start >> PAGE_SHIFT;
+		if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+			tag_pages_for_writeback(mapping, wbc->index,
+					wbc_end(wbc));
+		folio_batch_init(&wbc->fbatch);
+		wbc->err = 0;
 	}
 
-	if (error && !wbc->err)
-		wbc->err = error;
+	folio = writeback_get_folio(mapping, wbc);
+	if (!folio)
+		goto finish;
+	return folio;
+
+finish:
+	folio_batch_release(&wbc->fbatch);
 
 	/*
-	 * For integrity sync  we have to keep going until we have written all
-	 * the folios we tagged for writeback prior to entering the writeback
-	 * loop, even if we run past wbc->nr_to_write or encounter errors.
-	 * This is because the file system may still have state to clear for
-	 * each folio.   We'll eventually return the first error encountered.
+	 * For range cyclic writeback we need to remember where we stopped so
+	 * that we can continue there next time we are called.  If  we hit the
+	 * last page and there is more work to be done, wrap back to the start
+	 * of the file.
 	 *
-	 * For background writeback just push done_index past this folio so that
-	 * we can just restart where we left off and media errors won't choke
-	 * writeout for the entire file.
+	 * For non-cyclic writeback we always start looking up at the beginning
+	 * of the file if we are called again, which can only happen due to
+	 * -ENOMEM from the file system.
 	 */
-	if (wbc->sync_mode == WB_SYNC_NONE &&
-	    (wbc->err || wbc->nr_to_write <= 0)) {
-		writeback_finish(mapping, wbc, folio->index + nr);
-		return NULL;
+	if (wbc->range_cyclic) {
+		WARN_ON_ONCE(wbc->sync_mode != WB_SYNC_NONE);
+		if (wbc->err || wbc->nr_to_write <= 0)
+			mapping->writeback_index =
+				folio->index + folio_nr_pages(folio);
+		else
+			mapping->writeback_index = 0;
 	}
-
-	return writeback_get_folio(mapping, wbc);
+	*error = wbc->err;
+	return NULL;
 }
 
 /**
@@ -2549,13 +2556,18 @@ int write_cache_pages(struct address_space *mapping,
 		      struct writeback_control *wbc, writepage_t writepage,
 		      void *data)
 {
-	struct folio *folio;
-	int error;
+	struct folio *folio = NULL;
+	int error = 0;
 
-	for_each_writeback_folio(mapping, wbc, folio, error)
+	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
 		error = writepage(folio, wbc, data);
+		if (error == AOP_WRITEPAGE_ACTIVATE) {
+			folio_unlock(folio);
+			error = 0;
+		}
+	}
 
-	return wbc->err;
+	return error;
 }
 EXPORT_SYMBOL(write_cache_pages);
 
@@ -2563,13 +2575,17 @@ static int writeback_use_writepage(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
 	struct blk_plug plug;
-	struct folio *folio;
-	int err;
+	struct folio *folio = 0;
+	int err = 0;
 
 	blk_start_plug(&plug);
-	for_each_writeback_folio(mapping, wbc, folio, err) {
+	while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
 		err = mapping->a_ops->writepage(&folio->page, wbc);
 		mapping_set_error(mapping, err);
+		if (err == AOP_WRITEPAGE_ACTIVATE) {
+			folio_unlock(folio);
+			err = 0;
+		}
 	}
 	blk_finish_plug(&plug);
 
@@ -2590,6 +2606,8 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 			ret = mapping->a_ops->writepages(mapping, wbc);
 		} else if (mapping->a_ops->writepage) {
 			ret = writeback_use_writepage(mapping, wbc);
+			if (!ret)
+				ret = wbc->err;
 		} else {
 			/* deal with chardevs and other special files */
 			ret = 0;
-- 
2.39.2


