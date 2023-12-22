Return-Path: <linux-fsdevel+bounces-6802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DA681CBD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 16:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B607F280995
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528EA2EB1B;
	Fri, 22 Dec 2023 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QcpTyTJu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AB22EB07;
	Fri, 22 Dec 2023 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Cpsd8l7OUn8C5bZQLGYGz9qCV/TqxduSbkyPfu2Mjvk=; b=QcpTyTJuJ95zy8zQxfBVMOoGDn
	sw2GJk7mt4gkoe22EcMVpN5zoyxcTZ73p+PdkX60CZgHZeUAuIUr2oVe8FRVmI8/vAcpKnpluXuEu
	TUUZxssJV21oSRM3MQ9FjEgkhDo2BKBvRLib0rucgP+qyhWCD0t6FBI8QvgXSiu3rZjMwYBrflf0M
	uoIruyUMiuNMWZXyPdg5PqtA3L2CzyA4EIAD0M+B5pGflz0iEsiuxw8YZ2tO6wp2UnPyPwLrtqOIi
	L2C1oIjxnOjwUKsQO/pO4H+bWqA1WGkCM7vItyfaVkeb+MtDYyqFpiRj3tcKyxP2vT3yQKv8ByTNA
	uje57PSw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGh96-006Bb2-1Z;
	Fri, 22 Dec 2023 15:09:04 +0000
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
Subject: [PATCH 15/17] writeback: Add for_each_writeback_folio()
Date: Fri, 22 Dec 2023 16:08:25 +0100
Message-Id: <20231222150827.1329938-16-hch@lst.de>
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

Wrap up the iterator with a nice bit of syntactic sugar.  Now the
caller doesn't need to know about wbc->err and can just return error,
not knowing that the iterator took care of storing errors correctly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/writeback.h | 10 ++++++++++
 mm/page-writeback.c       |  8 +++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 195393981ccb5c..1c1a543070c17b 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -368,6 +368,16 @@ int balance_dirty_pages_ratelimited_flags(struct address_space *mapping,
 
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
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index a041cc563762ae..5c33a4a527b3fa 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2458,7 +2458,7 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 	return folio;
 }
 
-static struct folio *writeback_iter_init(struct address_space *mapping,
+struct folio *writeback_iter_init(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
 	if (wbc->range_cyclic)
@@ -2474,7 +2474,7 @@ static struct folio *writeback_iter_init(struct address_space *mapping,
 	return writeback_get_folio(mapping, wbc);
 }
 
-static struct folio *writeback_iter_next(struct address_space *mapping,
+struct folio *writeback_iter_next(struct address_space *mapping,
 		struct writeback_control *wbc, struct folio *folio, int error)
 {
 	unsigned long nr = folio_nr_pages(folio);
@@ -2552,9 +2552,7 @@ int write_cache_pages(struct address_space *mapping,
 	struct folio *folio;
 	int error;
 
-	for (folio = writeback_iter_init(mapping, wbc);
-	     folio;
-	     folio = writeback_iter_next(mapping, wbc, folio, error))
+	for_each_writeback_folio(mapping, wbc, folio, error)
 		error = writepage(folio, wbc, data);
 
 	return wbc->err;
-- 
2.39.2


