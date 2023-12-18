Return-Path: <linux-fsdevel+bounces-6380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F37817595
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 16:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A76FB24003
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FFE74088;
	Mon, 18 Dec 2023 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v8x9AkNH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FED4239E;
	Mon, 18 Dec 2023 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wPsE/cfutq1rEAGOfLa3oRuKt43FXWjmjgTx/hXSxEs=; b=v8x9AkNHKUmXVr4XL4EvllOnXA
	eHt9IpWbfIqZsl1l7GqGaWOhzmg7u5y0N6GXufr1QDG5Dy7byB/Ne/jM7TatIS09Ec2dHkXOUe7/u
	wOQSxttmSJUsViYu0u/sGGD8jd/9BN8AV+ZNSqlidRqS51/pJwK9kSVc6RvzUm2iAJ+W0choBCDJd
	bai/UgzHAqgH0KE8i6zm8sSU0/4s5FB3jvvqfsCsjkCv3EPmOP5o/6fiWeoS5HFappECuG9zpVo2N
	sMBisySZfzOCUvCGxwiPCRERS0bvvDG6T4NQRManmuNEyWGFFp5FR4NjXzlm6p4330y/hWtdN16Jg
	KZLsOkZQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFfV-00BEXI-2C;
	Mon, 18 Dec 2023 15:36:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] writeback: Factor writeback_get_folio() out of write_cache_pages()
Date: Mon, 18 Dec 2023 16:35:49 +0100
Message-Id: <20231218153553.807799-14-hch@lst.de>
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

Move the loop for should-we-write-this-folio to its own function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page-writeback.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index efcfffa800884d..9d37dd5e58ffb6 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2442,6 +2442,25 @@ static bool should_writeback_folio(struct address_space *mapping,
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
@@ -2455,7 +2474,7 @@ static struct folio *writeback_iter_init(struct address_space *mapping,
 
 	wbc->err = 0;
 	folio_batch_init(&wbc->fbatch);
-	return writeback_get_next(mapping, wbc);
+	return writeback_get_folio(mapping, wbc);
 }
 
 /**
@@ -2498,17 +2517,9 @@ int write_cache_pages(struct address_space *mapping,
 
 	for (folio = writeback_iter_init(mapping, wbc);
 	     folio;
-	     folio = writeback_get_next(mapping, wbc)) {
+	     folio = writeback_get_folio(mapping, wbc)) {
 		unsigned long nr;
 
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
 		wbc->nr_to_write -= nr;
-- 
2.39.2


