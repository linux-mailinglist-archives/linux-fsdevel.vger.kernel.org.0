Return-Path: <linux-fsdevel+bounces-6067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0970813173
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 14:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DBAF283338
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 13:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11C056457;
	Thu, 14 Dec 2023 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fYKo14Qx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B131412E;
	Thu, 14 Dec 2023 05:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kAPP6X55X6rvLdfMOtbLbsXeMDzuMOl2croRJo78UX4=; b=fYKo14QxQKLG96JxNh2gKkqwXa
	wsvp3uUwGV/Pnm6RVQ/FkMXvsez7eoeecA/pnOwd1vlL/3q7t/raPaZZEcb8RfyZEmpowiZMPLews
	ppeYWW2XD2womPwLiqiyZobEmdUTrc9J1baAEJ+PnEaO9wafX1ux6yu8ZSaE3ttElyNcNu5l7JyZ6
	aE1PvkMIS0bXSJEWwBte6poJSIKKE0+N5v2kwDU42DTmDcVmeNJCjolZuPnbW6cySjI5L2MIe9N7t
	820nBKAWHp+TfTTmFYqUoodssCijbcLm2oCZalIcEf11h3nd3Ltie7vsrHAttdJKjAc5duP5q0ioq
	LbAP1U3Q==;
Received: from [88.128.88.27] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDljI-000NBD-36;
	Thu, 14 Dec 2023 13:26:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 08/11] writeback: Factor writeback_get_folio() out of write_cache_pages()
Date: Thu, 14 Dec 2023 14:25:41 +0100
Message-Id: <20231214132544.376574-9-hch@lst.de>
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

Move the loop for should-we-write-this-folio to its own function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page-writeback.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 8c220c6a7f824d..b0accca1f4bfa7 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2429,6 +2429,27 @@ static bool should_writeback_folio(struct address_space *mapping,
 	return true;
 }
 
+static struct folio *writeback_get_folio(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	struct folio *folio;
+
+	for (;;) {
+		folio = writeback_get_next(mapping, wbc);
+		if (!folio)
+			return NULL;
+		wbc->done_index = folio->index;
+
+		folio_lock(folio);
+		if (likely(should_writeback_folio(mapping, wbc, folio)))
+			break;
+		folio_unlock(folio);
+	}
+
+	trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
+	return folio;
+}
+
 static struct folio *writeback_iter_init(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
@@ -2448,7 +2469,7 @@ static struct folio *writeback_iter_init(struct address_space *mapping,
 	folio_batch_init(&wbc->fbatch);
 	wbc->err = 0;
 
-	return writeback_get_next(mapping, wbc);
+	return writeback_get_folio(mapping, wbc);
 }
 
 /**
@@ -2491,19 +2512,9 @@ int write_cache_pages(struct address_space *mapping,
 
 	for (folio = writeback_iter_init(mapping, wbc);
 	     folio;
-	     folio = writeback_get_next(mapping, wbc)) {
+	     folio = writeback_get_folio(mapping, wbc)) {
 		unsigned long nr;
 
-		wbc->done_index = folio->index;
-
-		folio_lock(folio);
-		if (!should_writeback_folio(mapping, wbc, folio)) {
-			folio_unlock(folio);
-			continue;
-		}
-
-		trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
-
 		error = writepage(folio, wbc, data);
 		nr = folio_nr_pages(folio);
 		if (unlikely(error)) {
-- 
2.39.2


