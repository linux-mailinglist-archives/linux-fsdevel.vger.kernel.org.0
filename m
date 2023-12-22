Return-Path: <linux-fsdevel+bounces-6801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A5B81CBD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 16:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857A11C21DF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 15:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00092E857;
	Fri, 22 Dec 2023 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fsTEpZhG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3582E2E837;
	Fri, 22 Dec 2023 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nwSb0aQ6WVWAqtAF+HdyJ3HlPU1688MOnHDS98Pt7+A=; b=fsTEpZhGkE4khH8MXT4PtBYhdo
	ZQgp/dXeIGwyn7s3VuOqu6GmTRUxeSslau35ljaEbUfRgqA0ZEAH8JVNUJqryffLuZ1tiX++MxAHy
	Nq+T9gs+7AeBOpWiNijbKLhyOEzHiXCvYJyQBKAzyR6Jx96R9RLRtpKuVe/PAuijSu2MSVEHhsx60
	po2QLtX1ruHagJovmBJr49HjCGb76ply2cGzBN7tNen/Y7LvzOWkGILqJzTcP2VcgfasfyxRa/YLB
	CMyztaZTGjFje4ZGqnH7q15JeaxPgTH5DZcug+qDAWvVZPH+wM4/3FoVMrbM3vDe1Jt7WqAsXg8ta
	7O6j3/7A==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGh91-006BYP-2j;
	Fri, 22 Dec 2023 15:09:00 +0000
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
Subject: [PATCH 13/17] writeback: Move the folio_prepare_writeback loop out of write_cache_pages()
Date: Fri, 22 Dec 2023 16:08:23 +0100
Message-Id: <20231222150827.1329938-14-hch@lst.de>
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

Move the loop for should-we-write-this-folio to writeback_get_folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
[hch: folded the loop into the existing helper instead of a separate one
      as suggested by Jan Kara]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index f85145f330bb36..b6048c14748fdb 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2434,6 +2434,7 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 {
 	struct folio *folio;
 
+retry:
 	folio = folio_batch_next(&wbc->fbatch);
 	if (!folio) {
 		folio_batch_release(&wbc->fbatch);
@@ -2441,8 +2442,17 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 		filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
 				wbc_to_tag(wbc), &wbc->fbatch);
 		folio = folio_batch_next(&wbc->fbatch);
+		if (!folio)
+			return NULL;
 	}
 
+	folio_lock(folio);
+	if (unlikely(!folio_prepare_writeback(mapping, wbc, folio))) {
+		folio_unlock(folio);
+		goto retry;
+	}
+
+	trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
 	return folio;
 }
 
@@ -2505,14 +2515,6 @@ int write_cache_pages(struct address_space *mapping,
 	     folio = writeback_get_folio(mapping, wbc)) {
 		unsigned long nr;
 
-		folio_lock(folio);
-		if (!folio_prepare_writeback(mapping, wbc, folio)) {
-			folio_unlock(folio);
-			continue;
-		}
-
-		trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
-
 		error = writepage(folio, wbc, data);
 		nr = folio_nr_pages(folio);
 		wbc->nr_to_write -= nr;
-- 
2.39.2


