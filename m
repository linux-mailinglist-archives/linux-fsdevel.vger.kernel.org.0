Return-Path: <linux-fsdevel+bounces-10134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BABE884844C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 08:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE03E1C25C30
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 07:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CE055C22;
	Sat,  3 Feb 2024 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UVZT0U8O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E271A5578E;
	Sat,  3 Feb 2024 07:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706944369; cv=none; b=ILCKOpQzGRhTeA4O+urGC1yShOTjvefCSYRREov7SQ5r3KR4d7P4J952Crvcai1gQe5VgJLgraIRSt5TdNn0glLfo16ObMl0OAcKgn9KAgYPEx1Gc2Xz9kFmZ5yl0HYRNDBvV1Y0gm5VPVVwaKVCWyc2GwR52KQC8ZYgir3gifA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706944369; c=relaxed/simple;
	bh=SGRAuVhJI7Lth/Gasz34I52NDhUw1SIUQLUzjXA01lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YwktG1dEtbnEssTk28TZeU+hb4LKX6pAhVToh3/uHDDWwbX7yYv4Bqyui/l12V9XqKUtResfeQhF3aDQPl5EXy/fHH2D6fVEPLDHDmPUu9L//I6RdBoRaVaoHxXG6oTP/x43XX+176FfDumcfa5di17k+BlKA8gi3Ws7mwtwGbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UVZT0U8O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vMuVWuEQ40U143WWo2Ps+rfcdCaB4a+PakD93tsqYPU=; b=UVZT0U8O/OGsWBbA5J5L5DbkUG
	SmurBjpTmleDtvpw2bIr/rnEVzN8rjTX/aNoUn+C4KAtED42DW3RQVqwlvQC/yzmqGqoWaZxdSYXM
	GVzgszHwHO9An1ZeyUqAzpxJTAG+W+qouZ7Lgp9GpZyziDRqZHuPHOYf4ID+oxozldM2iGP1P+N6g
	tf9vH/pqi0+xMruv51PFKnq0+WgjmlKuqh4BdJMW/fNaqPe/lMFUsojx+nfiOqL87BxG6SMlcW+Pv
	OROo1W/J6KtBHth1yL+GCwFdhJuuVYMDmvSY6cBYYXdtFAjwyr5JEiYBZFU9qWweuDv9rL9io0lsI
	YA2ZqZhQ==;
Received: from [89.144.222.32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWACi-0000000FkF5-2eII;
	Sat, 03 Feb 2024 07:12:45 +0000
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
Subject: [PATCH 10/13] writeback: Use the folio_batch queue iterator
Date: Sat,  3 Feb 2024 08:11:44 +0100
Message-Id: <20240203071147.862076-11-hch@lst.de>
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

Instead of keeping our own local iterator variable, use the one just
added to folio_batch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d7ab42def43035..095ba4db9dcc17 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2406,13 +2406,21 @@ static pgoff_t wbc_end(struct writeback_control *wbc)
 	return wbc->range_end >> PAGE_SHIFT;
 }
 
-static void writeback_get_batch(struct address_space *mapping,
+static struct folio *writeback_get_folio(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
-	folio_batch_release(&wbc->fbatch);
-	cond_resched();
-	filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
-			wbc_to_tag(wbc), &wbc->fbatch);
+	struct folio *folio;
+
+	folio = folio_batch_next(&wbc->fbatch);
+	if (!folio) {
+		folio_batch_release(&wbc->fbatch);
+		cond_resched();
+		filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
+				wbc_to_tag(wbc), &wbc->fbatch);
+		folio = folio_batch_next(&wbc->fbatch);
+	}
+
+	return folio;
 }
 
 /**
@@ -2454,7 +2462,6 @@ int write_cache_pages(struct address_space *mapping,
 	int error;
 	struct folio *folio;
 	pgoff_t end;		/* Inclusive */
-	int i = 0;
 
 	if (wbc->range_cyclic) {
 		wbc->index = mapping->writeback_index; /* prev offset */
@@ -2469,15 +2476,10 @@ int write_cache_pages(struct address_space *mapping,
 	folio_batch_init(&wbc->fbatch);
 
 	for (;;) {
-		if (i == wbc->fbatch.nr) {
-			writeback_get_batch(mapping, wbc);
-			i = 0;
-		}
-		if (wbc->fbatch.nr == 0)
+		folio = writeback_get_folio(mapping, wbc);
+		if (!folio)
 			break;
 
-		folio = wbc->fbatch.folios[i++];
-
 		folio_lock(folio);
 		if (!folio_prepare_writeback(mapping, wbc, folio)) {
 			folio_unlock(folio);
-- 
2.39.2


