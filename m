Return-Path: <linux-fsdevel+bounces-45565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CC5A79720
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 23:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05672171A11
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 21:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3F21F418D;
	Wed,  2 Apr 2025 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S1WB6wUv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58A61F3BBE
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627981; cv=none; b=A+1HhbBl0vYDzsjogu263CURmJkeg2alwWi9Hb9hP2Z/tsFqW+ykXYdE8b4tPylhmhvpYbn3G57PXbC3VG8XZnuEQA4iZQ+Y6G69iTB4ZcGWSyC8K1SAUF6Fc6T+9bYFD86KLdyRLYA+rruyptvzAfekWym/vmo/ZpxxFARo0Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627981; c=relaxed/simple;
	bh=gnIHiBcv+yBq8aIfhuYk8mi2jYFmQYVcFfyXzxludro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1YCVMi/AUTwhavTCrzuJe5YzI4lTvVR+WYuUrs7R8vg3Edl3+u0AgPo/1Vs6fuYGsAM9J2HVxWCarxUjn+ASNaSTJReD0fnLPvz/sIOUycEBOpr6ZyVmgYoH+/8VaRvCvhaWwFzBdi/gwmBY5UyKICq0VtxF1nJZnb/9t37xpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S1WB6wUv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=m4T5LNp9+vduHggkLGzj9TeayJ79kOVaHGxfjN+fZbw=; b=S1WB6wUvfDFoIOnVbTiCIdOdS7
	Z/VKJRySCxvlDmz05MAXh6BrtyZb9211AryI9i2YT3PNl2SntCgyTdEHcLDSm/JroA0MUXA7BXr4l
	ZZ7d3Gm+sr8FJEfGBQ2MC0msiRrfYXSChveFCLKf5Afa8As4zecAkP+QFzgkcKxVxB0a3ILm+5Z46
	0ZdDelC2V+242e51pvdhrroLLjnn7QcdfxHKe/EFVVX9DivrnFsGEapB+RpeaWWilwEzzxmNDVziH
	Km5tMq/f6gjc8vLmofREGkNe3Hq5Lq52gVOG/XF6slxcKKL/h3JG2dNKs2sII1VpHB/sIaausyLsU
	pWPG06nQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u05Hr-0000000AFqS-07h1;
	Wed, 02 Apr 2025 21:06:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/8] iov_iter: Convert iov_iter_extract_xarray_pages() to use folios
Date: Wed,  2 Apr 2025 22:06:06 +0100
Message-ID: <20250402210612.2444135-5-willy@infradead.org>
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

ITER_XARRAY is exclusively used with xarrays that contain folios,
not pages, so extract folio pointers from it, not page pointers.
Removes a use of find_subpage().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 lib/iov_iter.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 7c50691fc5bb..a56bbf71a5d6 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1650,11 +1650,11 @@ static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
 					     iov_iter_extraction_t extraction_flags,
 					     size_t *offset0)
 {
-	struct page *page, **p;
+	struct page **p;
+	struct folio *folio;
 	unsigned int nr = 0, offset;
 	loff_t pos = i->xarray_start + i->iov_offset;
-	pgoff_t index = pos >> PAGE_SHIFT;
-	XA_STATE(xas, i->xarray, index);
+	XA_STATE(xas, i->xarray, pos >> PAGE_SHIFT);
 
 	offset = pos & ~PAGE_MASK;
 	*offset0 = offset;
@@ -1665,17 +1665,17 @@ static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
 	p = *pages;
 
 	rcu_read_lock();
-	for (page = xas_load(&xas); page; page = xas_next(&xas)) {
-		if (xas_retry(&xas, page))
+	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
+		if (xas_retry(&xas, folio))
 			continue;
 
-		/* Has the page moved or been split? */
-		if (unlikely(page != xas_reload(&xas))) {
+		/* Has the folio moved or been split? */
+		if (unlikely(folio != xas_reload(&xas))) {
 			xas_reset(&xas);
 			continue;
 		}
 
-		p[nr++] = find_subpage(page, xas.xa_index);
+		p[nr++] = folio_file_page(folio, xas.xa_index);
 		if (nr == maxpages)
 			break;
 	}
-- 
2.47.2


