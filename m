Return-Path: <linux-fsdevel+bounces-45567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E57D3A79721
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 23:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4144B170CF6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 21:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427041F3BBC;
	Wed,  2 Apr 2025 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lcElZ+Id"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0671F3BAE
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627987; cv=none; b=iX6KnvmvhOFpzLvrRsDpBTnynmRuoWc1HO8gCFEJZ9pwunY5hx8ynol1yuoDwhcDA/rkMaPPJYnlTILYMk+e+STdVPbKtnZVnSzQjK936JkevTIGggQWQaRNuaCL/cZATIi/A9fW2+sNxLCgihJBX7eshlB3C1DrAn3wL0F2l/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627987; c=relaxed/simple;
	bh=c5K0La0ePXH2HpWseZinhGccyjXKOshmqDPJjeoEAlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEnQxLz4yrk9aMs5C/GLkE5HBhLIXwdvZ9WIGIY//Q/mE9iDSXVmsuUMtprvO9HF3+O41PpUhwPnxF1fom9HNFCv0h2F1dSZhQHKK4fal5BSt1yJLUTRhyI+t9JTCycOv73hFaEt2bGfuf4jgGMkZqLs7gwtfCOZ7yk0qTgg0sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lcElZ+Id; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ry/obuxLxTCzbCNXr6YZ9DzG0ANUHcRWWnA+CyLV1DU=; b=lcElZ+IdahLQIKtyF8KzPMU59L
	NT4X71vpSJPq10zxoouw8+d5CKya02jKShsS5nhZ69fPrUt6xX3V4/nX7P2tL2VnWLQv3f1vnWlGq
	ImaB5sZcdIM/K5lkGCw+2VF10f4XvuQnzUX0jRrJFWeZKD+5fOL93C0+h67BCsdHn6oVeVNBlGII7
	IlTD/jKU9oKwrToM1DeNS18ek7GN49PUL0RuZsUCDXFBL8le8RkshsrNBe+WMC58r4RZqUoKbAYxo
	6jFOU/4jwp+DbU2++Na6cQuEu/3VOX7qvW9cKFtapVJzHEJ4ehKqYdttzAg6NqFAxMYez3MJINy0r
	QWP9N8LQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u05Hq-0000000AFqM-3I8S;
	Wed, 02 Apr 2025 21:06:14 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/8] filemap: Remove readahead_page()
Date: Wed,  2 Apr 2025 22:06:03 +0100
Message-ID: <20250402210612.2444135-2-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402210612.2444135-1-willy@infradead.org>
References: <20250402210612.2444135-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All filesystems have now been converted to call readahead_folio()
so we can delete this wrapper.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 26baa78f1ca7..cd4bd0f8e5f6 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1308,9 +1308,9 @@ static inline bool filemap_range_needs_writeback(struct address_space *mapping,
  * struct readahead_control - Describes a readahead request.
  *
  * A readahead request is for consecutive pages.  Filesystems which
- * implement the ->readahead method should call readahead_page() or
- * readahead_page_batch() in a loop and attempt to start I/O against
- * each page in the request.
+ * implement the ->readahead method should call readahead_folio() or
+ * __readahead_batch() in a loop and attempt to start reads into each
+ * folio in the request.
  *
  * Most of the fields in this struct are private and should be accessed
  * by the functions below.
@@ -1415,22 +1415,6 @@ static inline struct folio *__readahead_folio(struct readahead_control *ractl)
 	return folio;
 }
 
-/**
- * readahead_page - Get the next page to read.
- * @ractl: The current readahead request.
- *
- * Context: The page is locked and has an elevated refcount.  The caller
- * should decreases the refcount once the page has been submitted for I/O
- * and unlock the page once all I/O to that page has completed.
- * Return: A pointer to the next page, or %NULL if we are done.
- */
-static inline struct page *readahead_page(struct readahead_control *ractl)
-{
-	struct folio *folio = __readahead_folio(ractl);
-
-	return &folio->page;
-}
-
 /**
  * readahead_folio - Get the next folio to read.
  * @ractl: The current readahead request.
-- 
2.47.2


