Return-Path: <linux-fsdevel+bounces-3040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B697EF5F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 17:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3B3281204
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 16:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC223EA86;
	Fri, 17 Nov 2023 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eXvcsDQf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75365D4F
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 08:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=d2kHOzpOuXHwXRsMk1/dqyTvVthpU9cofZVkTm/4UCo=; b=eXvcsDQfEbE9m+fx+sPaMT6dVQ
	MU/QNu2vC2S3Mtrv/KKQxuyOHY5bQQXKyIvihXhZN9FRE5L8l+c/n/DM6QaT3iyoLVt3MYZ6ZAybo
	qdTOEVEkw2MrjPfZ2ltKr/jSKwRJl9LvCnzMYTN8PJXSZpUbTuGfEJyI2Oi4gV9O5WL9sLzrOUG5E
	s/t53XaeJp8uQGwS5j3IpKHmaVwy65XlvR+WckNOM1OVZcLkQOh3Y8/AGIb6EKTgBgW0UzJRtQs2L
	Hjj9sHkPaVDBYiK5Cfl9xCuPLPFwMtrj7aV0mGKzScoBPRZjbawb6L0P5v3ha3tPiQGSsdfD+Y8GJ
	gIRppf0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r41Uc-00AKbJ-RK; Fri, 17 Nov 2023 16:14:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/6] memory-failure: Convert truncate_error_page to truncate_error_folio
Date: Fri, 17 Nov 2023 16:14:46 +0000
Message-Id: <20231117161447.2461643-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231117161447.2461643-1-willy@infradead.org>
References: <20231117161447.2461643-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both callers now have a folio, so pass it in.  Nothing downstream was
expecting a tail page; that's asserted in generic_error_remove_page(),
for example.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory-failure.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d97d247c0224..6aec94821fda 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -927,14 +927,13 @@ static int delete_from_lru_cache(struct folio *folio)
 	return -EIO;
 }
 
-static int truncate_error_page(struct page *p, unsigned long pfn,
+static int truncate_error_page(struct folio *folio, unsigned long pfn,
 				struct address_space *mapping)
 {
-	struct folio *folio = page_folio(p);
 	int ret = MF_FAILED;
 
 	if (mapping->a_ops->error_remove_page) {
-		int err = mapping->a_ops->error_remove_page(mapping, p);
+		int err = mapping->a_ops->error_remove_page(mapping, &folio->page);
 
 		if (err != 0)
 			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
@@ -1055,7 +1054,7 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 	 *
 	 * Open: to take i_rwsem or not for this? Right now we don't.
 	 */
-	ret = truncate_error_page(p, page_to_pfn(p), mapping);
+	ret = truncate_error_page(folio, page_to_pfn(p), mapping);
 	if (has_extra_refcount(ps, p, extra_pins))
 		ret = MF_FAILED;
 
@@ -1189,7 +1188,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 
 	mapping = folio_mapping(folio);
 	if (mapping) {
-		res = truncate_error_page(&folio->page, page_to_pfn(p), mapping);
+		res = truncate_error_page(folio, page_to_pfn(p), mapping);
 		/* The page is kept in page cache. */
 		extra_pins = true;
 		folio_unlock(folio);
-- 
2.42.0


