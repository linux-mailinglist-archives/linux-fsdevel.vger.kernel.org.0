Return-Path: <linux-fsdevel+bounces-11652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8329855A9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 07:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6C3292612
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 06:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C081B94C;
	Thu, 15 Feb 2024 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sA9hTm/g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1921BC43;
	Thu, 15 Feb 2024 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707979049; cv=none; b=CG0ORHruFJKvcmJ+n1gdm4UG4qIRp/0sxrrNOCsF3+ZmhobDSJIJL/q/RxlZ0Es7VOsGbANkQpAUI5Qk6rhCUDbhPaPyV2kuy4cunR8KMbfZjy2d4Hzdz/o7rSquEPSU9hfyq0UBuGiLLpM7k9TsQKZGycIDN+ugvAG2JpG3RWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707979049; c=relaxed/simple;
	bh=w+Pgu1tzRXvirKXTbFtere9dyO9fQq//XemDJY4dhxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BDx/CqpxdJcaxPkSfiyVOMpDhIQNHqDV2yoZqXSoOURnjiuiuzhrQ23xa3Ty7ZdLORBGRIrF+XC5tDEiaW0OajsG0pNXCTyTHPttuq25WyKW0P+xhfK40j6EJWhTQkw47cDQJ8QqDFTBdRYzloYMC0j4Ao7oKBprAKzYNgmLhZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sA9hTm/g; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cxMaD8CgzKPWpzzBQiYSiO7ZuZ6eZs5SBgKJwTWN/r4=; b=sA9hTm/gXewYmu74Y6HKN+nure
	pK/w8ImihQ8or1SXbOQU1BH8PnFwBJmpIvkG7mc1M4U5tyoniQYrq05Bf/igP3fq+tdtzlcAvRwF5
	aKhKqLpa4MTE7ek+bRUa/cWrAwbNaTWZVcuZ4SrcXEE4OeerQG44/4LyCbkIZBfyv83FA41XFpg4w
	+WlAzXEYKo/bdm3jraGgGMznibtKSzdPgNUAv4zXOdzla+VVoJ7lA7cWDe+tQxf+1kpi1nfeS38o3
	mXM2Pa2LbWZG+mZD7u5jlmUOv5hzQPlc3rwSUF+MQxOPauTPE/I5kLQSIeqa8lIjeOCEJ/PUHi/HJ
	cOHPVvIg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raVN7-0000000F6zU-00HA;
	Thu, 15 Feb 2024 06:37:25 +0000
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
Subject: [PATCH 11/14] writeback: Use the folio_batch queue iterator
Date: Thu, 15 Feb 2024 07:36:46 +0100
Message-Id: <20240215063649.2164017-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215063649.2164017-1-hch@lst.de>
References: <20240215063649.2164017-1-hch@lst.de>
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
index 358ce3ade9ad1e..3cbe4a7daa357c 100644
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


