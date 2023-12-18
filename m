Return-Path: <linux-fsdevel+bounces-6382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C2681759D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 16:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F391F214A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 15:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDA274E0E;
	Mon, 18 Dec 2023 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wIxOQSPZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7F74097;
	Mon, 18 Dec 2023 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=b65KMtlYAzH3EUkpAxud2ReFVr8IHYHtgd3wSTH/RNI=; b=wIxOQSPZ9QaTybwrOD9nlYUkRM
	y+8Zb6dvZntvYiEKJllN8zuuGypcmjeu7cPyJWRRE+Fi8fVWQFfIPzfFljzQWA/7m7EebXSjpuGby
	ZxBT7WwEcpjYBrspB6z1WTQYVpyBXVdki2ccUQzksG71f2mGj6xHmzzSn29+2TiUT07EYabtmsSEA
	yjpaneMn2i1b5z0M+EWN6cvSKICP2g8eokXeawjJmIBfdsCN2ms6qC+WjksIXZgx/AY0iZWo/q1dc
	q1nJKDQPAPGC8P8DMR1Hb0mCPDuXhcA8+sfDzv9zFVilbUWOxiWUrz7F6UwF/edDUhPjfpeF9mZJg
	gxKIqiRg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFfc-00BEaV-0K;
	Mon, 18 Dec 2023 15:36:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/17] writeback: Add for_each_writeback_folio()
Date: Mon, 18 Dec 2023 16:35:51 +0100
Message-Id: <20231218153553.807799-16-hch@lst.de>
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

Wrap up the iterator with a nice bit of syntactic sugar.  Now the
caller doesn't need to know about wbc->err and can just return error,
not knowing that the iterator took care of storing errors correctly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
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
index 0771f19950081f..fbffd30a9cc93f 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2463,7 +2463,7 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 	return folio;
 }
 
-static struct folio *writeback_iter_init(struct address_space *mapping,
+struct folio *writeback_iter_init(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
 	if (wbc->range_cyclic)
@@ -2479,7 +2479,7 @@ static struct folio *writeback_iter_init(struct address_space *mapping,
 	return writeback_get_folio(mapping, wbc);
 }
 
-static struct folio *writeback_iter_next(struct address_space *mapping,
+struct folio *writeback_iter_next(struct address_space *mapping,
 		struct writeback_control *wbc, struct folio *folio, int error)
 {
 	unsigned long nr = folio_nr_pages(folio);
@@ -2557,9 +2557,7 @@ int write_cache_pages(struct address_space *mapping,
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


