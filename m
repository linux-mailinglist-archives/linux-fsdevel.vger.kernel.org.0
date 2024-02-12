Return-Path: <linux-fsdevel+bounces-11085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 852D7850DCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 08:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5771F261E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 07:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4643117BAB;
	Mon, 12 Feb 2024 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3Wgal8GD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A859179AD;
	Mon, 12 Feb 2024 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722065; cv=none; b=d6VmVq9PMQ7mw3rPqxH/I3szS9RVLKJ7SrAYvFX/8ccxmQJPhBk0JBxsaObNaEtVWjOUKtzIHV99tHTdxMt9AdWKFkrZ1fR6/AEJwg3wB2AA7V+KK0FaZvgJ+3ngY8vSwV9VNsPyPlbjbm+XrsOD0yFIeiO9nlp8Nf/Mi8CDYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722065; c=relaxed/simple;
	bh=6aonBwnYQ6BWDoALBt40yIo2buIID3W1FQ0bJNZOifM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iFYW2y5NLNAQj1QxOQMpBvUVJiJy7QOoSr7t3f1SLZ9jg6lCf3g6g6lRgGm6t8GqyXfejeyHyH/i1Eyw3yuzMWFXFUzvfZDn/wVRDFYoKP0rEVJOhTzht/3XS9aTSihJPXKRFiAmk+F/JNjraoX9jY1CyhGWKNHefMH1oeQBsNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3Wgal8GD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=H733Z/OisKZKsSfT6EaxuE1uZOfzplnZ1VkoSGD6LBY=; b=3Wgal8GDp/OO9yjFp2rFlOqj97
	HkjNBFs0/l40rFgt1jrEGxE8wnNu03bxBKTl3NTcTQuZO2IQ9whXrFw4ywFkPBVeGdRxlwT952/aY
	HUJZx5cwg5j+WUQy6PpgVM9QoYQxm7VM7J7CezwBeQ7OSkRI6Tl1alD4403gJfiTKV/OBTMfHnAG5
	cHHon1/aXcJNCBKrycB3riZqjjN1xA33iCRxNaVsiib1eeCpk1GWuKFMDJuz1BxJjjk4ZWkSQ2QXS
	sCihHV3jAxBSfvV4E7dY3u4REiqg6qbcf74I1PFnXLQBFgrRStfMEtIZ3muezb+y0n/tRO0brIXPb
	Hv2IvJJg==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQWC-00000004SyE-3a0i;
	Mon, 12 Feb 2024 07:14:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 08/14] writeback: Factor writeback_get_batch() out of write_cache_pages()
Date: Mon, 12 Feb 2024 08:13:42 +0100
Message-Id: <20240212071348.1369918-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212071348.1369918-1-hch@lst.de>
References: <20240212071348.1369918-1-hch@lst.de>
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
index 20ff00c8be9d90..045ca252c0423d 100644
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
@@ -2512,6 +2527,7 @@ int write_cache_pages(struct address_space *mapping,
 	 * of the file if we are called again, which can only happen due to
 	 * -ENOMEM from the file system.
 	 */
+	folio_batch_release(&wbc->fbatch);
 	if (wbc->range_cyclic)
 		mapping->writeback_index = 0;
 	return ret;
@@ -2519,7 +2535,7 @@ int write_cache_pages(struct address_space *mapping,
 done:
 	if (wbc->range_cyclic)
 		mapping->writeback_index = folio->index + folio_nr_pages(folio);
-	folio_batch_release(&fbatch);
+	folio_batch_release(&wbc->fbatch);
 	return error;
 }
 EXPORT_SYMBOL(write_cache_pages);
-- 
2.39.2


