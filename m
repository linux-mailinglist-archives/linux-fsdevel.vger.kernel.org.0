Return-Path: <linux-fsdevel+bounces-6069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F0F813176
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 14:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEEA91C2175C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 13:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5440F5647B;
	Thu, 14 Dec 2023 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FpcH5Bmf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3077E10F;
	Thu, 14 Dec 2023 05:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+EjBTTu0WiLV+Q73nxsWHktHLf8xanuJ2SDeP86Fuu8=; b=FpcH5BmfnsmbIgWMunX3/hZPox
	tLAIZ4W/GC6ayMAPNn5BY589vQNYhvpCUHsur984ldcZbvmNVmyABftvrU8KE0pxTLjrF/LT/lF6h
	SiflrOMvjG+E1PERscpCGlpvsObop7COIxi6gE91+X0cch22c4DoY7nQHyHRL1yFc2u2hfZZOFomB
	HXmpsS0q7VhQuYxeu8rRNY+C/aQRPGP9bmc3cMhWDWqkkF3gpfPUI9+2H4YOMkDdjkx2ZMV1YtHbc
	yBPNNlsuIhZzoQYxOnc6gtiz5hY+BMwSY0GP/N1RdxH7A7pmUVX/bJlYXECIOQmgGJr+9r7+K2c92
	Wog0fx2Q==;
Received: from [88.128.88.27] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDljP-000NEm-28;
	Thu, 14 Dec 2023 13:26:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 10/11] writeback: Add for_each_writeback_folio()
Date: Thu, 14 Dec 2023 14:25:43 +0100
Message-Id: <20231214132544.376574-11-hch@lst.de>
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

Wrap up the iterator with a nice bit of syntactic sugar.  Now the
caller doesn't need to know about wbc->err and can just return error,
not knowing that the iterator took care of storing errors correctly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/writeback.h | 14 +++++++++++---
 mm/page-writeback.c       | 11 ++++-------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index be960f92ad9dbd..b5fcf91cf18bdd 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -371,14 +371,22 @@ int balance_dirty_pages_ratelimited_flags(struct address_space *mapping,
 
 bool wb_over_bg_thresh(struct bdi_writeback *wb);
 
+struct folio *writeback_iter_init(struct address_space *mapping,
+		struct writeback_control *wbc);
+struct folio *writeback_iter_next(struct address_space *mapping,
+		struct writeback_control *wbc, struct folio *folio, int error);
+
+#define for_each_writeback_folio(mapping, wbc, folio, error)		\
+	for (folio = writeback_iter_init(mapping, wbc);			\
+	     folio || ((error = wbc->err), false);			\
+	     folio = writeback_iter_next(mapping, wbc, folio, error))
+
 typedef int (*writepage_t)(struct folio *folio, struct writeback_control *wbc,
 				void *data);
-
-void tag_pages_for_writeback(struct address_space *mapping,
-			     pgoff_t start, pgoff_t end);
 int write_cache_pages(struct address_space *mapping,
 		      struct writeback_control *wbc, writepage_t writepage,
 		      void *data);
+
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
 void writeback_set_ratelimit(void);
 void tag_pages_for_writeback(struct address_space *mapping,
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 4fae912f7a86e2..e4a1444502ccd4 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2450,7 +2450,7 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 	return folio;
 }
 
-static struct folio *writeback_iter_init(struct address_space *mapping,
+struct folio *writeback_iter_init(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
 	if (wbc->range_cyclic) {
@@ -2472,7 +2472,7 @@ static struct folio *writeback_iter_init(struct address_space *mapping,
 	return writeback_get_folio(mapping, wbc);
 }
 
-static struct folio *writeback_iter_next(struct address_space *mapping,
+struct folio *writeback_iter_next(struct address_space *mapping,
 		struct writeback_control *wbc, struct folio *folio, int error)
 {
 	unsigned long nr = folio_nr_pages(folio);
@@ -2551,13 +2551,10 @@ int write_cache_pages(struct address_space *mapping,
 	struct folio *folio;
 	int error;
 
-	for (folio = writeback_iter_init(mapping, wbc);
-	     folio;
-	     folio = writeback_iter_next(mapping, wbc, folio, error)) {
+	for_each_writeback_folio(mapping, wbc, folio, error)
 		error = writepage(folio, wbc, data);
-	}
 
-	return wbc->err;
+	return error;
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-- 
2.39.2


