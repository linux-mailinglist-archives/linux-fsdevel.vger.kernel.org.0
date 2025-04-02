Return-Path: <linux-fsdevel+bounces-45563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44959A7971E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 23:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52CDD3AAB00
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 21:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874421F3FC8;
	Wed,  2 Apr 2025 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nBSfKrRq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE7B1F0E32
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627980; cv=none; b=CM67v8azbis/Us7fv9Gt4N7SYfaFUV/te/gXEPnUFeeYjhlEMRRCVZLOdW3pdnzDsADpH1HF2IV7UZ8KbkfZKIk4QbbxibZroeHSl7mXXT1V7I9OQGIKQzBuSlUNvdE1hjsMqvOqErvRMjmF/QZ2UcTAzE54uUJ0dTdQDqz97ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627980; c=relaxed/simple;
	bh=JEqGYHlFPqeM/Nbf0+BITj+nKoRy30A+P2F+TGLzmis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9uhjbxA1OdzMXVuinSusiySJ3V1hVYIcGc24sslrmCfx4+u/t+IY1NS8/W+vLSbgANwb5vD64w4BJXkGVIOYFk2SAu0hKx3ramz7wcjvhA+HkxNbl8KlOS/VEuUa3O5EMXJv1yzM31oX/btZbdIFkJwgi0v0bgDI635dTpTJ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nBSfKrRq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=aeknInBgahlhrSIfl6BQ35gr/87Ob6URDMcFA+uZRVc=; b=nBSfKrRqW/CJy3iB/seVe8R54U
	+FqjMUO1A2E5UsJHgEobOCJKv8F4ginlYFU32AmXi8dkxt8+ZAk5qVue8Po3xbpMs7I5CgTjot4ET
	HRFdKNOe4U6hdXq3YJV0i7kABBZ33AzFc0U3jG8OI4JpjdW6GAMP1ZSbzySZ59j2iXxTMe1NRzeT0
	DvzfmWWAzubo8osUsE8Qa5ePrdQkxxW+ZcwWUWlWjQkfh8VThs1TFLgKwRRP69BuC+Fkqa5WnhN1g
	mKRhfj7AbphkJe1aFphKbHrpKB68GWHNXMCgU/W+LSEmJf8UEUaHfG08+C43bt7c9jeZAIPPa3WDE
	6YPPBgnw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u05Hr-0000000AFqW-0qhe;
	Wed, 02 Apr 2025 21:06:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/8] filemap: Convert __readahead_batch() to use a folio
Date: Wed,  2 Apr 2025 22:06:08 +0100
Message-ID: <20250402210612.2444135-7-willy@infradead.org>
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

Extract folios from i_mapping, not pages.  Removes a hidden call to
compound_head(), a use of thp_nr_pages() and an unnecessary assertion
that we didn't find a tail page in the page cache.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0ddd4bd8cdf8..c5c9b3770d75 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1424,7 +1424,7 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
 {
 	unsigned int i = 0;
 	XA_STATE(xas, &rac->mapping->i_pages, 0);
-	struct page *page;
+	struct folio *folio;
 
 	BUG_ON(rac->_batch_count > rac->_nr_pages);
 	rac->_nr_pages -= rac->_batch_count;
@@ -1433,13 +1433,12 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
 
 	xas_set(&xas, rac->_index);
 	rcu_read_lock();
-	xas_for_each(&xas, page, rac->_index + rac->_nr_pages - 1) {
-		if (xas_retry(&xas, page))
+	xas_for_each(&xas, folio, rac->_index + rac->_nr_pages - 1) {
+		if (xas_retry(&xas, folio))
 			continue;
-		VM_BUG_ON_PAGE(!PageLocked(page), page);
-		VM_BUG_ON_PAGE(PageTail(page), page);
-		array[i++] = page;
-		rac->_batch_count += thp_nr_pages(page);
+		VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+		array[i++] = folio_page(folio, 0);
+		rac->_batch_count += folio_nr_pages(folio);
 		if (i == array_sz)
 			break;
 	}
-- 
2.47.2


