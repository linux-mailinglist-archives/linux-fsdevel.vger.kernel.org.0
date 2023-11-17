Return-Path: <linux-fsdevel+bounces-3036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D6D7EF5F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 17:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626A3281163
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8793EA99;
	Fri, 17 Nov 2023 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N8WgV35M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6425EA4
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 08:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=8gvR0hfnArLw42hOz7sYaHZFkVWRhDjUXlO4vAmkjQw=; b=N8WgV35M5s0mjyyNderE17Qmxo
	OJkL8RyC2nLLhMIa4daHxxYStcbBxFBTzYl8S3jkoIz5p6orZfU9FrKQAwvGkN6aTsFtlZxxAmFIA
	r5Kj/oTZc8CWxZKbqy3Sb+8FKsXEWExbklZZzEUjtK4T3XCuSFEEBxZj8bw7GejebeIHdyD7zU9H5
	Haf1YaqvY5uVuZILuYO0OZ7t7EkW32MsGqMrRtxpB1H3vUlDY/grumRFHB7TX6eEMYJcx6uCepG9W
	YHAitttCXDyAfZcqSAo+d7j5o3vN3ahTw+XTkI9uBaK3xszSQYi2lajCeKpSh+MJjqL6osb9Ob7X6
	vrRzipgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r41Uc-00AKWa-GQ; Fri, 17 Nov 2023 16:14:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/6] memory-failure: Use a folio in me_pagecache_clean()
Date: Fri, 17 Nov 2023 16:14:42 +0000
Message-Id: <20231117161447.2461643-2-willy@infradead.org>
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

Replaces three hidden calls to compound_head() with one visible one.
Fix up a few comments while I'm modifying this function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory-failure.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b601f59ed062..496e8ecd8496 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1014,6 +1014,7 @@ static int me_unknown(struct page_state *ps, struct page *p)
  */
 static int me_pagecache_clean(struct page_state *ps, struct page *p)
 {
+	struct folio *folio = page_folio(p);
 	int ret;
 	struct address_space *mapping;
 	bool extra_pins;
@@ -1021,10 +1022,10 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 	delete_from_lru_cache(p);
 
 	/*
-	 * For anonymous pages we're done the only reference left
+	 * For anonymous folios the only reference left
 	 * should be the one m_f() holds.
 	 */
-	if (PageAnon(p)) {
+	if (folio_test_anon(folio)) {
 		ret = MF_RECOVERED;
 		goto out;
 	}
@@ -1036,11 +1037,9 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 	 * has a reference, because it could be file system metadata
 	 * and that's not safe to truncate.
 	 */
-	mapping = page_mapping(p);
+	mapping = folio_mapping(folio);
 	if (!mapping) {
-		/*
-		 * Page has been teared down in the meanwhile
-		 */
+		/* Folio has been torn down in the meantime */
 		ret = MF_FAILED;
 		goto out;
 	}
@@ -1061,7 +1060,7 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 		ret = MF_FAILED;
 
 out:
-	unlock_page(p);
+	folio_unlock(folio);
 
 	return ret;
 }
-- 
2.42.0


