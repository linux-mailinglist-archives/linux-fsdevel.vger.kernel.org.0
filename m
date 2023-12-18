Return-Path: <linux-fsdevel+bounces-6379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46017817592
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 16:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 875F2B22346
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 15:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F1C7147D;
	Mon, 18 Dec 2023 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MXOOyyiG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4917204D;
	Mon, 18 Dec 2023 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=11fJOeLJtEu+HLcWStjNzVEg8D8E0pgLFFPvW65M4Co=; b=MXOOyyiG08iR+isoX6KD7RrhRt
	0QmbZm+seKCas0S98o9hhqfjQr+vlWEOPT/rhVKpCa/ug/D/NkXWj7C1tgZXQeIQVkVhCIs//zQHy
	t3gNoGV16ux4RaT1JuRzdxFP47V9wmEuzUaBUuWpBMIWmvjTHcVrRKP+iRpnx2k+O0LglLWfTgCiC
	p3ZhIyUOhbchYAy4iRYYUIw38YozNgK4QODvPde8KbAfKrK0yLwBCx3tJ63AZ+x815DPNLbVSczvb
	H5oQ+NezuCm0IvG56bFh5739uRp0nWlfpeCgsFIiZRsfEL8M9gbUEyjA6HfZ7Y7yfgWBJfb13/aN4
	WwKzKFCg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFfS-00BEVg-0O;
	Mon, 18 Dec 2023 15:36:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/17] writeback: Factor writeback_iter_init() out of write_cache_pages()
Date: Mon, 18 Dec 2023 16:35:48 +0100
Message-Id: <20231218153553.807799-13-hch@lst.de>
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

Make it return the first folio in the batch so that we can use it
in a typical for() pattern.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page-writeback.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 70f42fd9a95b5d..efcfffa800884d 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2442,6 +2442,22 @@ static bool should_writeback_folio(struct address_space *mapping,
 	return true;
 }
 
+static struct folio *writeback_iter_init(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	if (wbc->range_cyclic)
+		wbc->index = mapping->writeback_index; /* prev offset */
+	else
+		wbc->index = wbc->range_start >> PAGE_SHIFT;
+
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		tag_pages_for_writeback(mapping, wbc->index, wbc_end(wbc));
+
+	wbc->err = 0;
+	folio_batch_init(&wbc->fbatch);
+	return writeback_get_next(mapping, wbc);
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2477,29 +2493,14 @@ int write_cache_pages(struct address_space *mapping,
 		      struct writeback_control *wbc, writepage_t writepage,
 		      void *data)
 {
+	struct folio *folio;
 	int error;
-	pgoff_t end;		/* Inclusive */
 
-	if (wbc->range_cyclic) {
-		wbc->index = mapping->writeback_index; /* prev offset */
-		end = -1;
-	} else {
-		wbc->index = wbc->range_start >> PAGE_SHIFT;
-		end = wbc->range_end >> PAGE_SHIFT;
-	}
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		tag_pages_for_writeback(mapping, wbc->index, end);
-
-	folio_batch_init(&wbc->fbatch);
-	wbc->err = 0;
-
-	for (;;) {
-		struct folio *folio = writeback_get_next(mapping, wbc);
+	for (folio = writeback_iter_init(mapping, wbc);
+	     folio;
+	     folio = writeback_get_next(mapping, wbc)) {
 		unsigned long nr;
 
-		if (!folio)
-			break;
-
 		folio_lock(folio);
 		if (!should_writeback_folio(mapping, wbc, folio)) {
 			folio_unlock(folio);
-- 
2.39.2


