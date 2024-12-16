Return-Path: <linux-fsdevel+bounces-37502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 567579F350D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 16:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33DDB1889C10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 15:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39342202C3E;
	Mon, 16 Dec 2024 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T7fJugSM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A831B87C4;
	Mon, 16 Dec 2024 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364454; cv=none; b=M21vgyd+xVqjAa0dqOUe+nOuz1/6Zzdn9OPkPqO8vCURcmE9MV17vRohXYmKKesWc4vNQK057Pp7WCslAqkZEUPYjw711QRx2ZaRdbM0i0dmUPNfa3dVq9COsfsPdTpORaK0Lge9Sjdd/tFuNDRbsnBLRq+LWCx16ZVtyQR7IT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364454; c=relaxed/simple;
	bh=FrI9TvgaUznNWBxBsuyTskoDG48Y+j7W1cyFNQMFQ4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqU3BsmYqcKTC+RXkJ0cjv07YFSL+FvSDRCQwkvaGyOWVxVnnBYq7ZUIhvAiBwYCnVEaKZlipitHvFGs+XwfmTqO0Jm9wUZao+bMINc3sSdSv/UDNSMqFvvnQjp99T/vdyNpq5+TQmHk+PbwHFgEB1lUEAePx+GRvuFJOiyB8rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T7fJugSM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=iSSfIRVYFh9OixVSiPRYAanTfhJia6O8dwZi1nuoKzs=; b=T7fJugSMgUXI/si204QfAuhmxI
	Q2WBIIzhXzLjb0y/BpZjDG4/CPsZ8+Wn9SVhkAIA0xF7NQMSr+LhbKq5r41nYiHK/f+Kw3iyFd2Xu
	+gUmCFPB7pp9HLnv9a+Kp9XUFP+DlOnnZHV185ggKJUdyzeGrvqwHUjQwUz/jGUCX/JYjGd6JOv4V
	IT9i7AyS+tEe+ZwzFcodpliUdsykJlRA8BNheJJP6f/vH+xXazJJeVUgHR8sDAYVuPKidB5HQHeur
	cc5CqjAtcbwVyBsFIsnIQKZWfxhHgK8fng7sLxDw7zDBTxoj8weqsBdFjn3832M5T2Sfe6klUGmvm
	qVMExFPA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDQB-000000002CK-0yMa;
	Mon, 16 Dec 2024 15:54:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] dax: Use folios more widely within DAX
Date: Mon, 16 Dec 2024 15:53:56 +0000
Message-ID: <20241216155408.8102-2-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216155408.8102-1-willy@infradead.org>
References: <20241216155408.8102-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert from pfn to folio instead of page and use those folios
throughout to avoid accesses to page->index and page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/dax.c | 53 +++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 21b47402b3dc..972febc6fb9d 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -320,38 +320,39 @@ static unsigned long dax_end_pfn(void *entry)
 	for (pfn = dax_to_pfn(entry); \
 			pfn < dax_end_pfn(entry); pfn++)
 
-static inline bool dax_page_is_shared(struct page *page)
+static inline bool dax_folio_is_shared(struct folio *folio)
 {
-	return page->mapping == PAGE_MAPPING_DAX_SHARED;
+	return folio->mapping == PAGE_MAPPING_DAX_SHARED;
 }
 
 /*
- * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
+ * Set the folio->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
  * refcount.
  */
-static inline void dax_page_share_get(struct page *page)
+static inline void dax_folio_share_get(struct folio *folio)
 {
-	if (page->mapping != PAGE_MAPPING_DAX_SHARED) {
+	if (folio->mapping != PAGE_MAPPING_DAX_SHARED) {
 		/*
 		 * Reset the index if the page was already mapped
 		 * regularly before.
 		 */
-		if (page->mapping)
-			page->share = 1;
-		page->mapping = PAGE_MAPPING_DAX_SHARED;
+		if (folio->mapping)
+			folio->page.share = 1;
+		folio->mapping = PAGE_MAPPING_DAX_SHARED;
 	}
-	page->share++;
+	folio->page.share++;
 }
 
-static inline unsigned long dax_page_share_put(struct page *page)
+static inline unsigned long dax_folio_share_put(struct folio *folio)
 {
-	return --page->share;
+	return --folio->page.share;
 }
 
 /*
- * When it is called in dax_insert_entry(), the shared flag will indicate that
- * whether this entry is shared by multiple files.  If so, set the page->mapping
- * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
+ * When it is called in dax_insert_entry(), the shared flag will indicate
+ * that whether this entry is shared by multiple files.  If so, set
+ * the folio->mapping PAGE_MAPPING_DAX_SHARED, and use page->share
+ * as refcount.
  */
 static void dax_associate_entry(void *entry, struct address_space *mapping,
 		struct vm_area_struct *vma, unsigned long address, bool shared)
@@ -364,14 +365,14 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 
 	index = linear_page_index(vma, address & ~(size - 1));
 	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
+		struct folio *folio = pfn_folio(pfn);
 
 		if (shared) {
-			dax_page_share_get(page);
+			dax_folio_share_get(folio);
 		} else {
-			WARN_ON_ONCE(page->mapping);
-			page->mapping = mapping;
-			page->index = index + i++;
+			WARN_ON_ONCE(folio->mapping);
+			folio->mapping = mapping;
+			folio->index = index + i++;
 		}
 	}
 }
@@ -385,17 +386,17 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 		return;
 
 	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
+		struct folio *folio = pfn_folio(pfn);
 
-		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
-		if (dax_page_is_shared(page)) {
+		WARN_ON_ONCE(trunc && folio_ref_count(folio) > 1);
+		if (dax_folio_is_shared(folio)) {
 			/* keep the shared flag if this page is still shared */
-			if (dax_page_share_put(page) > 0)
+			if (dax_folio_share_put(folio) > 0)
 				continue;
 		} else
-			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
-		page->mapping = NULL;
-		page->index = 0;
+			WARN_ON_ONCE(folio->mapping && folio->mapping != mapping);
+		folio->mapping = NULL;
+		folio->index = 0;
 	}
 }
 
-- 
2.45.2


