Return-Path: <linux-fsdevel+bounces-8854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6528983BC97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2B91F296E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D93200C6;
	Thu, 25 Jan 2024 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r5e1XEM8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E322D1D556;
	Thu, 25 Jan 2024 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173135; cv=none; b=F4s4ijW7hzwUCavDx7Vs4uM10zo8UqIbh63LpQ/icMG086gQzJR5Y4+LgVzfWmjb/aLs10PnBcyc0j0U+6mChWDDquWOWiv9tOGT1aeejS9T0lG4nQ0t4LYymi/6aKMJA5H5FeV4O4q2BF+MVwmVXhovounPQq/LwWYjLqxpVEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173135; c=relaxed/simple;
	bh=qwBX7ZnPhqRoZ+e2l0nUI4Td9WPa5eC1nxDyNy0cFtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pSZKoec+AP7WC5H9WWynSpmnffyPA86uJn7aIwwoa34X8XnzQrc+9mCs04v5csrHrxmjdNkh5VyHoNRM9wPYNaiGf4E5tMG6sZXZDlVZF/TIOQ138j5NBjh4/iD13pOrojPKVKKDEPIuvhnOVnZVBODCBPuAx7c9k4qpzOQNwiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r5e1XEM8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=btL3AciRr+h+xXxfR+Yq/41M1ZAR/B4m6dVFwBdRQv0=; b=r5e1XEM8S9gQh8rBNXuD00dQSt
	nekiXLsV/Vk7BZw/6syGHv6F3sB9VECwP2G0QgBhGJeOnzfwy/mI92WsKGhst2tCM+Wi3az+xbmxJ
	gZldsll43mBMkAMXLPMaby4NPM0MwucidYZvYToaJikMi+1+p5W8ln2WpHXKffi82sEhTQL+PyRIO
	pO9/dx0INBNTIOEi5ebmi9UV+Yt1GOMFQJnURTXviErty+7hbRM4BtU+fUFe1923PB5lYFBpAy0j8
	iwtnO4feBgof8IrJ8Sy8flg8sIbHfcVGuX/zP/ZWCe8ajPAAkpzPcFr8i2L62RcfwSsy1r6CWYetm
	NBUCsxaw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSvZR-007QQO-0Q;
	Thu, 25 Jan 2024 08:58:49 +0000
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
Subject: [PATCH 12/19] writeback: Factor writeback_iter_init() out of write_cache_pages()
Date: Thu, 25 Jan 2024 09:57:51 +0100
Message-Id: <20240125085758.2393327-13-hch@lst.de>
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

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Make it return the first folio in the batch so that we can use it
in a typical for() pattern.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 432bb42d0829d1..ae9f659e6796ac 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2446,6 +2446,22 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 	return folio;
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
+	return writeback_get_folio(mapping, wbc);
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2481,29 +2497,14 @@ int write_cache_pages(struct address_space *mapping,
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
-		struct folio *folio = writeback_get_folio(mapping, wbc);
+	for (folio = writeback_iter_init(mapping, wbc);
+	     folio;
+	     folio = writeback_get_folio(mapping, wbc)) {
 		unsigned long nr;
 
-		if (!folio)
-			break;
-
 		folio_lock(folio);
 		if (!folio_prepare_writeback(mapping, wbc, folio)) {
 			folio_unlock(folio);
-- 
2.39.2


