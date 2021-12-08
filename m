Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C104D46CC57
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240067AbhLHE0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbhLHE0n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5EAC061746
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DYYtBGhjj8cEREZ7h3ka1eCGfC7joF81SMsCjzMNVEU=; b=q76KeqFugBaLOBGAos+7cxdUoj
        OCg4sRWPuVIfOGIY9eII2Xc0HoUKM3cElnqNxLs7hfC0s+PbdVd6+3Mj3ca3X7YDmM2VoikhlSbDO
        TXWChAhXEWe9Hi2Qmdtu9YGRqQGDAmiAG751LLRunV1ID27E1Xkk36vD75c4MWBhn6cMtzeu/NomU
        pIayQ/cFmnvYLcxxDiuRYDTmzc6relojgK4ddwovztMvwf5e+E9N/Nve6LaPmlNHV1slIHPHadIQr
        keeBu95LYdAsTr97uxzUzeZTbTxnO7qDrzaw8MycGq/SZ5I+lTne7c/N0+uxpZk/feMaw96SXJAxv
        jjYn41JQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU2-0084X8-6e; Wed, 08 Dec 2021 04:23:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 07/48] iov_iter: Convert iter_xarray to use folios
Date:   Wed,  8 Dec 2021 04:22:15 +0000
Message-Id: <20211208042256.1923824-8-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Take advantage of how kmap_local_folio() works to simplify the loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 lib/iov_iter.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 66a740e6e153..03cf43b003a0 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -69,42 +69,39 @@
 #define iterate_xarray(i, n, base, len, __off, STEP) {		\
 	__label__ __out;					\
 	size_t __off = 0;					\
-	struct page *head = NULL;				\
+	struct folio *folio;					\
 	loff_t start = i->xarray_start + i->iov_offset;		\
-	unsigned offset = start % PAGE_SIZE;			\
 	pgoff_t index = start / PAGE_SIZE;			\
-	int j;							\
-								\
 	XA_STATE(xas, i->xarray, index);			\
 								\
+	len = PAGE_SIZE - offset_in_page(start);		\
 	rcu_read_lock();					\
-	xas_for_each(&xas, head, ULONG_MAX) {			\
+	xas_for_each(&xas, folio, ULONG_MAX) {			\
 		unsigned left;					\
-		if (xas_retry(&xas, head))			\
+		size_t offset = offset_in_folio(folio, start + __off);	\
+		if (xas_retry(&xas, folio))			\
 			continue;				\
-		if (WARN_ON(xa_is_value(head)))			\
+		if (WARN_ON(xa_is_value(folio)))		\
 			break;					\
-		if (WARN_ON(PageHuge(head)))			\
+		if (WARN_ON(folio_test_hugetlb(folio)))		\
 			break;					\
-		for (j = (head->index < index) ? index - head->index : 0; \
-		     j < thp_nr_pages(head); j++) {		\
-			void *kaddr = kmap_local_page(head + j);	\
-			base = kaddr + offset;			\
-			len = PAGE_SIZE - offset;		\
+		while (offset < folio_size(folio)) {		\
+			base = kmap_local_folio(folio, offset);	\
 			len = min(n, len);			\
 			left = (STEP);				\
-			kunmap_local(kaddr);			\
+			kunmap_local(base);			\
 			len -= left;				\
 			__off += len;				\
 			n -= len;				\
 			if (left || n == 0)			\
 				goto __out;			\
-			offset = 0;				\
+			offset += len;				\
+			len = PAGE_SIZE;			\
 		}						\
 	}							\
 __out:								\
 	rcu_read_unlock();					\
-	i->iov_offset += __off;						\
+	i->iov_offset += __off;					\
 	n = __off;						\
 }
 
-- 
2.33.0

