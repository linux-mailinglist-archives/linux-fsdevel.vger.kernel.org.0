Return-Path: <linux-fsdevel+bounces-20261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B7C8D08CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 18:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F8828F60C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 16:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2264E155CB0;
	Mon, 27 May 2024 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DF+0PB+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C76155C96;
	Mon, 27 May 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827785; cv=none; b=V6Y68uJCsvRo6JZs4YRtClOSxQfraflnDsVARCEOaSkhPk2OC+9rueklfJdmpYSpH4Lu3MAIjulu2Xy3jB9P6eQbVlU6L/06C2uIapRKgsTtUUTZbZbB8tAfoBP+MC8NcOlgIOzqPTNLDbvqwHIAIWpplSOC5SfNsqF8EAqlsqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827785; c=relaxed/simple;
	bh=5PXQDAmsoR4Mi2gYo4EP22yZCBVVSAfwuHdb3qiEX/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXPtghK3kUV6ndX/pVhUYp6J4j82/ozQFU1WngGbu7wf4THVoT16e8HI8MjGcoMyKRBUJVIoscKPwBM1Twtk75CeeYc4fJsPZSFHLFX/07Kl63wPxrFd1nEc7lyHrosdV0nUKTLAgzKUcmwTyEFlhVh01ksN+TgdJMJizvcyS1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DF+0PB+J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=27+lP32Q2mw19iey55M36pSytXlr5S4+SrngC3O6v+s=; b=DF+0PB+J1G3GjShibBUkkXKzbg
	fXBJp4C12z3fLlSUjFb8iSZ12AevUEdRfRjZ65AWcrNk697Svt6DuF5gVqg4QjbjnUClInBMEI1fO
	TfEbmNaMYRqU/2QXTmXXyJL+AvEdUbrZ+JSijhLQH8oOgsoRdGmy8m7OGPwOckiF+0Z6qGrT1GbQv
	T/4dxOFKBIJdGP/bWENwVdcqF0qb34xY2V4MCNg0VQwK49HqlXvDjpSaCsAvfsFMLwrrOFg7l6wSd
	dCI/QdL+yV5U3WF7sB3kYhStTLsR9aFpkkG+H5/jCwMl6/YKu7F1t0WFZn5pMml3EY9duNuMKrv16
	rsI69DyQ==;
Received: from 2a02-8389-2341-5b80-3177-e4c1-2108-f294.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3177:e4c1:2108:f294] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBdKh-0000000Ft6T-11pI;
	Mon, 27 May 2024 16:36:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] filemap: Convert generic_perform_write() to support large folios
Date: Mon, 27 May 2024 18:36:08 +0200
Message-ID: <20240527163616.1135968-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527163616.1135968-1-hch@lst.de>
References: <20240527163616.1135968-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Modelled after the loop in iomap_write_iter(), copy larger chunks from
userspace if the filesystem has created large folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
[hch: use mapping_max_folio_size to keep supporting file systems that do
 not support large folios]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 382c3d06bfb10c..860728e26ccf32 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3981,21 +3981,24 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 	loff_t pos = iocb->ki_pos;
 	struct address_space *mapping = file->f_mapping;
 	const struct address_space_operations *a_ops = mapping->a_ops;
+	size_t chunk = mapping_max_folio_size(mapping);
 	long status = 0;
 	ssize_t written = 0;
 
 	do {
 		struct page *page;
-		unsigned long offset;	/* Offset into pagecache page */
-		unsigned long bytes;	/* Bytes to write to page */
+		struct folio *folio;
+		size_t offset;		/* Offset into folio */
+		size_t bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
 		void *fsdata = NULL;
 
-		offset = (pos & (PAGE_SIZE - 1));
-		bytes = min_t(unsigned long, PAGE_SIZE - offset,
-						iov_iter_count(i));
+		bytes = iov_iter_count(i);
+retry:
+		offset = pos & (chunk - 1);
+		bytes = min(chunk - offset, bytes);
+		balance_dirty_pages_ratelimited(mapping);
 
-again:
 		/*
 		 * Bring in the user page that we will copy from _first_.
 		 * Otherwise there's a nasty deadlock on copying from the
@@ -4017,11 +4020,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 		if (unlikely(status < 0))
 			break;
 
+		folio = page_folio(page);
+		offset = offset_in_folio(folio, pos);
+		if (bytes > folio_size(folio) - offset)
+			bytes = folio_size(folio) - offset;
+
 		if (mapping_writably_mapped(mapping))
-			flush_dcache_page(page);
+			flush_dcache_folio(folio);
 
-		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
-		flush_dcache_page(page);
+		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
+		flush_dcache_folio(folio);
 
 		status = a_ops->write_end(file, mapping, pos, bytes, copied,
 						page, fsdata);
@@ -4039,14 +4047,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 			 * halfway through, might be a race with munmap,
 			 * might be severe memory pressure.
 			 */
-			if (copied)
+			if (chunk > PAGE_SIZE)
+				chunk /= 2;
+			if (copied) {
 				bytes = copied;
-			goto again;
+				goto retry;
+			}
+		} else {
+			pos += status;
+			written += status;
 		}
-		pos += status;
-		written += status;
-
-		balance_dirty_pages_ratelimited(mapping);
 	} while (iov_iter_count(i));
 
 	if (!written)
-- 
2.43.0


