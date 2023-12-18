Return-Path: <linux-fsdevel+bounces-6377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4686F81758C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 16:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBD39B221F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 15:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410D142381;
	Mon, 18 Dec 2023 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="THuXRAhN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536C34239E;
	Mon, 18 Dec 2023 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3B9Hp+QAdQFWcqrQUPpFbTk6qvR0M5sjBup3lTEiqhs=; b=THuXRAhNeLCiO2K1fm6woSSF0o
	FKejSp1UwrESZMKns9PM7cdQ7F8P7vGO1leM/ItulT1ZAASbVhH3soffvn0yy2cYNQ7Db4BAOr9ku
	m7Aeco/LSG1tytEmmHRNB8t01Capsk3p3022lowatIGQS/92K5TIZZ50ORvE1uUbfbl5qTGihahCG
	t7RR7qRTsnt6rYpRX6/KmySAwqvvivwVdHHPiSnYv+ICCPdXwP4idam3OfER0xCEM1QDucjIIGYwL
	z3kxcpHeMwiL3Gk+EC3dtqn2BU8RvjxXmiBBSf79ujCTwihDzG75A4W/ShiFDKWGhEztFg+1o/gtd
	WL+ry0qg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFfO-00BEUC-1y;
	Mon, 18 Dec 2023 15:36:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] writeback: Use the folio_batch queue iterator
Date: Mon, 18 Dec 2023 16:35:47 +0100
Message-Id: <20231218153553.807799-12-hch@lst.de>
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

Instead of keeping our own local iterator variable, use the one just
added to folio_batch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page-writeback.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index c7983ea3040be4..70f42fd9a95b5d 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2397,13 +2397,19 @@ static pgoff_t wbc_end(struct writeback_control *wbc)
 	return wbc->range_end >> PAGE_SHIFT;
 }
 
-static void writeback_get_batch(struct address_space *mapping,
+static struct folio *writeback_get_next(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
+	struct folio *folio = folio_batch_next(&wbc->fbatch);
+
+	if (folio)
+		return folio;
+
 	folio_batch_release(&wbc->fbatch);
 	cond_resched();
 	filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
 			wbc_to_tag(wbc), &wbc->fbatch);
+	return folio_batch_next(&wbc->fbatch);
 }
 
 static bool should_writeback_folio(struct address_space *mapping,
@@ -2473,7 +2479,6 @@ int write_cache_pages(struct address_space *mapping,
 {
 	int error;
 	pgoff_t end;		/* Inclusive */
-	int i = 0;
 
 	if (wbc->range_cyclic) {
 		wbc->index = mapping->writeback_index; /* prev offset */
@@ -2489,18 +2494,12 @@ int write_cache_pages(struct address_space *mapping,
 	wbc->err = 0;
 
 	for (;;) {
-		struct folio *folio;
+		struct folio *folio = writeback_get_next(mapping, wbc);
 		unsigned long nr;
 
-		if (i == wbc->fbatch.nr) {
-			writeback_get_batch(mapping, wbc);
-			i = 0;
-		}
-		if (wbc->fbatch.nr == 0)
+		if (!folio)
 			break;
 
-		folio = wbc->fbatch.folios[i++];
-
 		folio_lock(folio);
 		if (!should_writeback_folio(mapping, wbc, folio)) {
 			folio_unlock(folio);
-- 
2.39.2


