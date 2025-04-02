Return-Path: <linux-fsdevel+bounces-45566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D655AA79727
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 23:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7DF18944E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 21:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE7E1F3B82;
	Wed,  2 Apr 2025 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E2XzTSoy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0389A1F3BBE
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627984; cv=none; b=jYFFtm4oQlO1of/pCCDxoUuq1uW/TPNvBxwYNt8HL8y5xo8oCnyE2Mn0czl2DW8tVyubqRxodUVCXrE31+E9am3ndBs/iEd8Pl4kpgnbqOAcYKWxBRRTLE4qtG9ZFj6p8R82PSrbTMP3hUvwhOgAQwkI81Yh0TkNCHl+C5kJxZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627984; c=relaxed/simple;
	bh=+/vd25kpsQdToYBDEEn8QF2H3E8pjoOKSZg6qP3DmCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXA9W+LxWEDyPvHt3ZZ6QsJAlQLVeSXXehLSo/dA7FlYW+d+z2EzX66KpNsBj3RzVjTMM9ZT1aGREqYWwqj3yFQl4weKvxZ09KvArfwVXOlEqGWUR99Bones2okSWX/6wvTCFfmgBlA7q0Nsm2CQVV/z+FLnW8VFcCAylWMA+Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E2XzTSoy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9u8Vjz9C0E4LvrVZKlU/rxeiFIcc78vR/nB2GrB7LV8=; b=E2XzTSoyxW912FP5dXOOzZxQnK
	mExtIKyJWSjZM0kAHZhVxiU6tOokazeU0Fe7GY2ZCRp8J0gcloVL0CXUWtcUwHS/a2dB/KpS2V5l6
	gWF4ytOrvykWlTrBmqXA2YzYU2nl/Mt58FBI9TeNkn7I6jpvjYwFGvxDQNbVeVJuBLmZYT4Kctmep
	USgKIRGGErnVEPFqSM8fqIm1dZQYMWCtqy5Ng0YQstNSUBMsQbbHkAGdSH16g4+IkV0pO4jSLhGje
	BvefpRZIwGGgmBoy1av3RWCKJ8hxWI2QiyPCh2KIxF1S1MEcin/0ffQoJapCsrAZn7uT252TrDRXJ
	D8NixFtg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u05Hr-0000000AFqU-0V6p;
	Wed, 02 Apr 2025 21:06:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/8] filemap: Remove find_subpage()
Date: Wed,  2 Apr 2025 22:06:07 +0100
Message-ID: <20250402210612.2444135-6-willy@infradead.org>
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

All users of this function now call folio_file_page() instead.
Delete it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index cd4bd0f8e5f6..0ddd4bd8cdf8 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -945,19 +945,6 @@ static inline bool folio_contains(struct folio *folio, pgoff_t index)
 	return index - folio_index(folio) < folio_nr_pages(folio);
 }
 
-/*
- * Given the page we found in the page cache, return the page corresponding
- * to this index in the file
- */
-static inline struct page *find_subpage(struct page *head, pgoff_t index)
-{
-	/* HugeTLBfs wants the head page regardless */
-	if (PageHuge(head))
-		return head;
-
-	return head + (index & (thp_nr_pages(head) - 1));
-}
-
 unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch);
 unsigned filemap_get_folios_contig(struct address_space *mapping,
-- 
2.47.2


