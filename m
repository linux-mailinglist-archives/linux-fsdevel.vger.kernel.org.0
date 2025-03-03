Return-Path: <linux-fsdevel+bounces-42996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A42A4CAA9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 19:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7488E168543
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69A4219A9B;
	Mon,  3 Mar 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C2Gcgd8a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31C71F2B88
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024879; cv=none; b=PWoY5G+d/te7itP+th7hCKK+pKhLHNjIH6XFm2J5I0sWBEaG7N814lR813PV+wL5wvchisqiOdR+8G5Lz9Z8eqVzp7sAzrq90ddtueouIEQfWkAgIqZZgP6s/jSV333khrNUftOGwvCKIiFULmY6e8JFtvD2ia7QGexyJdO+7/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024879; c=relaxed/simple;
	bh=2IpxagfiodeLlTSlditW/GRWScnS46KJFRnJ/rC30XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4Qqmyt029Mua7FY9X59371w1l37oigi8q53EvrSdU/JATBVv0u6YInBqw99ijNJdyIJcvCShnLF4Ug4uocsJKaQedgg5rZU3J4/oxw2FmXS9qzMd6oPGLT+lGdm7bZCtjUQx5LOpQhYissW/sWjAzBm0wmNuZpPjQgtx6T2AKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C2Gcgd8a; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=mhPMBfMr6QjIX4xpzAErSRJyHiDJ/wVChcGhzQucYw8=; b=C2Gcgd8agHSIQ1790V1Wv10iNk
	4Ix+WsA8iv+U8YNxjILMKfqqOpMjasBQQDlplBeOayYQlCVjOduBqcYvyf0iZDSO0hElsSEs2Y6zA
	3U6q2lZ9jbLmVjmIopms7q5ht3dFZMmQrEzMDcSIiyswDBkSwoEQeqdGYuNIGhwRpwdeAGRdqERpd
	LTuIAlY3A/ub8VCtHLr+OvtfWyOY1S/exosr7ekFfwjs5uj1vXje+0JgH3Nm25o+Vg5jXW0os+GC/
	7u7phC+CbUpFD6CUhHcuH06UcjRtph9PXh5dmDLAUtZC3TuSJntxM0NL1b5v3B7ZlxDbP8EiPHA4Z
	oVuRXbDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpA64-0000000DqU4-2rOs;
	Mon, 03 Mar 2025 18:01:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/6] filemap: Convert __readahead_batch() to use a folio
Date: Mon,  3 Mar 2025 17:53:14 +0000
Message-ID: <20250303175317.3277891-5-willy@infradead.org>
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

Extract folios from i_mapping, not pages.  Removes a hidden call to
compound_head(), a use of thp_nr_pages() and an unnecessary assertion
that we didn't find a tail page in the page cache.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e51c0febd036..f4b875b561e5 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1449,7 +1449,7 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
 {
 	unsigned int i = 0;
 	XA_STATE(xas, &rac->mapping->i_pages, 0);
-	struct page *page;
+	struct folio *folio;
 
 	BUG_ON(rac->_batch_count > rac->_nr_pages);
 	rac->_nr_pages -= rac->_batch_count;
@@ -1458,13 +1458,12 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
 
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


