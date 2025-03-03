Return-Path: <linux-fsdevel+bounces-42994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 780B9A4CAA5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 19:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E585F165B3A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB16219A90;
	Mon,  3 Mar 2025 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WI4+Su5w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A9E21B9CF
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024812; cv=none; b=ijLBz5MheZbANxqN0czgem+wJLeBxBMQCDmU0+onkt/ToPENSbWogSRbsHdrk2lk/De3XZled0qRUtOofHXSOK9wy8LoV0SleGZLDG1ZMk7ZoDSrA5ASHZZ1XCaSs+nORRhB2BHwLiKHE27KkHIu/c+ij29CoWr5aWzBMK+peVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024812; c=relaxed/simple;
	bh=ppWqVpLWY1FoF2mV9uTvYTME8yEGySTdGXXclKMhMOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnZDFFI+Q0ypfyMj0KC15y1ulV2VWS6HxbZdappuKOEpqaMW2B1mizc6nF4np6uvbvKOApixYYuS3RPsBdT1MW4/Mvp4jiLRz9fwCYjPdmEdsu2d9OEVTeCl2LPrWtAn2nMwfG8Nh6x5AJWG1be9ZNwqe/ByPrxqkMBmNjQlQJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WI4+Su5w; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ac55yYGUrmgmfjDkZd7lZLD1cRecm/nrYCkJ9H/XhoA=; b=WI4+Su5wNeZh6dg7wStk7EFkqj
	sVln2SyYzf3X9frXhnAGuaK37AeqGdQrklihxMtovIrrzuAaPjGH218lObXI50mw0+WAdneVO/ijD
	ioTMwR8e7r7n0JiIRsR9gVA3TfZJ1Q9DsawKaE0G2pEHdkD4k0u85oDFhLM8Zy7awvITp9rPetKl5
	NymWaqf7b5RNdPhqSm9w61VMBqg2+Ty3gOxunACx0ACwNb9tpxP4OaDK6RBk0asjaN2WpyWQwSQ3W
	PW8N5sLByxgueb5/70Lmrf9Oc2x01DVxA7TpyFUU5qAUD46/AodcgzjzxdHjJ4rpKQNBfOEVc1Iw8
	iEeRRbgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpA20-0000000DnEk-1nep;
	Mon, 03 Mar 2025 17:56:49 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/6] iov_iter: Convert iov_iter_extract_xarray_pages() to use folios
Date: Mon,  3 Mar 2025 17:53:12 +0000
Message-ID: <20250303175317.3277891-3-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303175317.3277891-1-willy@infradead.org>
References: <20250303175317.3277891-1-willy@infradead.org>
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
index 92642f517999..c85ae372bc05 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1646,11 +1646,11 @@ static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
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
@@ -1661,17 +1661,17 @@ static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
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


