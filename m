Return-Path: <linux-fsdevel+bounces-3034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6505A7EF5F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 17:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2571C20A92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 16:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C9E374F2;
	Fri, 17 Nov 2023 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lBuDi0+u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90281B3
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 08:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Vf86B2r48b06hq56Lphk6YasHUIlClzmrRVlrcnYbEU=; b=lBuDi0+uFlBwKBKbtjXDnKKGud
	rX5G0hyB33CMmJ47hg3DEseAmCwagVH9GPP7WtDUCl092doyezqxJlxbydWz48xrawTeWv6CS1h6u
	Gqfs5ac+eCkrxHEmynbYjj9QH1BNEUEt8VtTxSxCegbRs8TQE8/L6mrZKrhuBZ8tDOq6LFnnuh2eq
	FdLtH0G1xGzwrnXnK2dAvTQZ2XVF8z9YiRa+qQcx9aO2aEAtlRsbZynXwSdNRn9bvBPn2+mVv5EQ3
	lZCGmeyoIhijEKJdx/EA67UmxwYKaA4iox4SHDgH3PzWHVgiMrOYAMc7qv8CaQmWzEAA61Hi5zi4n
	kIRbFC4A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r41Uc-00AKYn-LM; Fri, 17 Nov 2023 16:14:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/6] memory-failure: Convert delete_from_lru_cache() to take a folio
Date: Fri, 17 Nov 2023 16:14:44 +0000
Message-Id: <20231117161447.2461643-4-willy@infradead.org>
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

All three callers now have a folio; pass it in instead of the page.
Saves five calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory-failure.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d2764fd3e448..e73f2047ffcb 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -902,26 +902,26 @@ static const char * const action_page_types[] = {
  * The page count will stop it from being freed by unpoison.
  * Stress tests should be aware of this memory leak problem.
  */
-static int delete_from_lru_cache(struct page *p)
+static int delete_from_lru_cache(struct folio *folio)
 {
-	if (isolate_lru_page(p)) {
+	if (folio_isolate_lru(folio)) {
 		/*
 		 * Clear sensible page flags, so that the buddy system won't
-		 * complain when the page is unpoison-and-freed.
+		 * complain when the folio is unpoison-and-freed.
 		 */
-		ClearPageActive(p);
-		ClearPageUnevictable(p);
+		folio_clear_active(folio);
+		folio_clear_unevictable(folio);
 
 		/*
 		 * Poisoned page might never drop its ref count to 0 so we have
 		 * to uncharge it manually from its memcg.
 		 */
-		mem_cgroup_uncharge(page_folio(p));
+		mem_cgroup_uncharge(folio);
 
 		/*
-		 * drop the page count elevated by isolate_lru_page()
+		 * drop the refcount elevated by folio_isolate_lru()
 		 */
-		put_page(p);
+		folio_put(folio);
 		return 0;
 	}
 	return -EIO;
@@ -1019,7 +1019,7 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 	struct address_space *mapping;
 	bool extra_pins;
 
-	delete_from_lru_cache(p);
+	delete_from_lru_cache(folio);
 
 	/*
 	 * For anonymous folios the only reference left
@@ -1146,7 +1146,7 @@ static int me_swapcache_dirty(struct page_state *ps, struct page *p)
 	/* Trigger EIO in shmem: */
 	folio_clear_uptodate(folio);
 
-	ret = delete_from_lru_cache(p) ? MF_FAILED : MF_DELAYED;
+	ret = delete_from_lru_cache(folio) ? MF_FAILED : MF_DELAYED;
 	folio_unlock(folio);
 
 	if (ret == MF_DELAYED)
@@ -1165,7 +1165,7 @@ static int me_swapcache_clean(struct page_state *ps, struct page *p)
 
 	delete_from_swap_cache(folio);
 
-	ret = delete_from_lru_cache(p) ? MF_FAILED : MF_RECOVERED;
+	ret = delete_from_lru_cache(folio) ? MF_FAILED : MF_RECOVERED;
 	folio_unlock(folio);
 
 	if (has_extra_refcount(ps, p, false))
-- 
2.42.0


