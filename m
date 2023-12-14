Return-Path: <linux-fsdevel+bounces-6065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BF481316C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 14:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09361B21AE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 13:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB7B56476;
	Thu, 14 Dec 2023 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D9YSNoUn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C08E137;
	Thu, 14 Dec 2023 05:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MxYyShLiRKm/b2kgWMNr7J68lt6H7F1PYCAdmGQu21k=; b=D9YSNoUndTNHZOJBIIstgZm299
	fqPapOf+sTH1GXW0IqUNd0YqzZtYfAXncK2PeCKGRRHmhuG09goKRpeMQWwnoW7FXknQOalV4l2fH
	uMjwqwUUmCi3br7beZe20CmuYsuPnXaM6VvFGr0zv6SNQZqvI5wZ9sv1+odmLUM63q3Fu85vAG2gf
	s/8DG9HAvLdUTA+2GNHp/WSl9Y/MqL5YMQytvl73whfVH0xPfqs91rWMXyaWVagm/AxS13FvHlweg
	mjFa5QkB005ny4hVt62BETy702qH2PMBV67OIuknvVwncXTerzZRoIe+aF+KZ8szfS1i+JuPt8KvI
	m8mTW8UA==;
Received: from [88.128.88.27] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDljB-000N7L-0i;
	Thu, 14 Dec 2023 13:26:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 06/11] writeback: Use the folio_batch queue iterator
Date: Thu, 14 Dec 2023 14:25:39 +0100
Message-Id: <20231214132544.376574-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214132544.376574-1-hch@lst.de>
References: <20231214132544.376574-1-hch@lst.de>
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
 mm/page-writeback.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 2087d16115710e..2243a0d1b2d3c7 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2378,11 +2378,15 @@ static int writeback_finish(struct address_space *mapping,
 	return wbc->err;
 }
 
-static void writeback_get_batch(struct address_space *mapping,
+static struct folio *writeback_get_next(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
+	struct folio *folio = folio_batch_next(&wbc->fbatch);
 	xa_mark_t tag;
 
+	if (folio)
+		return folio;
+
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
 		tag = PAGECACHE_TAG_TOWRITE;
 	else
@@ -2392,6 +2396,7 @@ static void writeback_get_batch(struct address_space *mapping,
 	cond_resched();
 	filemap_get_folios_tag(mapping, &wbc->index, wbc->end, tag,
 			&wbc->fbatch);
+	return folio_batch_next(&wbc->fbatch);
 }
 
 static bool should_writeback_folio(struct address_space *mapping,
@@ -2460,7 +2465,6 @@ int write_cache_pages(struct address_space *mapping,
 		      void *data)
 {
 	int error;
-	int i = 0;
 
 	if (wbc->range_cyclic) {
 		wbc->index = mapping->writeback_index; /* prev offset */
@@ -2479,18 +2483,12 @@ int write_cache_pages(struct address_space *mapping,
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
 		wbc->done_index = folio->index;
 
 		folio_lock(folio);
-- 
2.39.2


