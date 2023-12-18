Return-Path: <linux-fsdevel+bounces-6374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB45817582
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 16:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E41A1F22B72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D645D742;
	Mon, 18 Dec 2023 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fx9/cCVV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77D5D72F;
	Mon, 18 Dec 2023 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=aHXKO1UbJHXuqoP1fMOkKbpvbuANBll89l/hQyqHhR4=; b=Fx9/cCVVlwYOnhe/PSU89cDqVD
	NI/Css67r/FlsYc8NmCfniGg54QHQxgHsspAS57gDul5cTzL0hn1ZYeRU9gC8qFIq//ZJLH1vTyTT
	NkYZETzb+w26apnFjyIKLapIGMmBHyHAabMX4hk9cvfq0clnn+uyJpYeekVoYtCuTYVUNQFlPatrZ
	SSsp/9CpzQ3RKUCNPWaBU4OgSu7Wl1+hiqb+XWiQ2Uv+YBGT9sPgftDPPkSwJXycLm4D/AKXvHjus
	0HFC0kopXSnEv2BVLjCG4hwfCCGuT9gt5VWusTok0xcANlH5KBh8QDWOzHVEd1W+MU2o0JryEnPBY
	gQ5ZhBvA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFfC-00BENM-0x;
	Mon, 18 Dec 2023 15:36:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/17] writeback: Factor writeback_get_batch() out of write_cache_pages()
Date: Mon, 18 Dec 2023 16:35:43 +0100
Message-Id: <20231218153553.807799-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218153553.807799-1-hch@lst.de>
References: <20231218153553.807799-1-hch@lst.de>
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
---
 include/linux/writeback.h |  1 +
 mm/page-writeback.c       | 49 +++++++++++++++++++++++++--------------
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 390f2dd03cf27e..195393981ccb5c 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -81,6 +81,7 @@ struct writeback_control {
 
 	/* internal fields used by the ->writepages implementation: */
 	struct folio_batch fbatch;
+	pgoff_t index;
 	int err;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 564d5faf562ba7..798e5264dc0353 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2383,6 +2383,29 @@ static void writeback_finish(struct address_space *mapping,
 	}
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
@@ -2419,38 +2442,30 @@ int write_cache_pages(struct address_space *mapping,
 		      void *data)
 {
 	int error;
-	int nr_folios;
-	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
-	xa_mark_t tag;
 
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
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		tag_pages_for_writeback(mapping, wbc->index, end);
 
 	folio_batch_init(&wbc->fbatch);
 	wbc->err = 0;
 
-	while (index <= end) {
+	while (wbc->index <= end) {
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
 
@@ -2525,8 +2540,6 @@ int write_cache_pages(struct address_space *mapping,
 				return error;
 			}
 		}
-		folio_batch_release(&wbc->fbatch);
-		cond_resched();
 	}
 
 	writeback_finish(mapping, wbc, 0);
-- 
2.39.2


