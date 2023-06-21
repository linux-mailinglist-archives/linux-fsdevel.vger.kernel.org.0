Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9EC738C26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 18:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjFUQqj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 12:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjFUQqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:46:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8FF1BD4;
        Wed, 21 Jun 2023 09:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/u3R6ommui0jzmNm5KqQbCKjAYY2UMYMLfe/n8/4JuI=; b=SA7wCjqcWMwZI6QRZjnXU4BdsS
        H2NVvLwwEgWYTdDfqbIir6UM//Pdysn6BSpEU5tQrwXLiUi9lYRn6b1kZ9qx1fAUBvXd7kLDwwkhY
        5AAQLBbNy1luSMqNDTeWh+iK0WGYWrfqKDGYqZciSOpheoDHNVBuHpWm43NXX9E4ZJXfruCyIH/UW
        HB+wG8b8HwLzzjf53mwVPcA53m7cznZE0yRcrwmRkU0fOjoCKs9ya07eXP9QmjjMztGSPQSsClls5
        jOcuaSGUbCg3/YuJMblU2LvWjfE9SoN7h5k2L6Zq6mpZcMsd5xCOJiy9+fCqNLsH/jrQq/u4kXAFF
        K/koQlnw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qC0y2-00EjEX-9H; Wed, 21 Jun 2023 16:46:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 10/13] mm: Remove struct pagevec
Date:   Wed, 21 Jun 2023 17:45:54 +0100
Message-Id: <20230621164557.3510324-11-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230621164557.3510324-1-willy@infradead.org>
References: <20230621164557.3510324-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All users are now converted to use the folio_batch so we can get rid of
this data structure.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagevec.h | 63 +++--------------------------------------
 mm/swap.c               | 18 ++++++------
 2 files changed, 13 insertions(+), 68 deletions(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 3a9d29dd28a3..87cc678adc85 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -3,65 +3,18 @@
  * include/linux/pagevec.h
  *
  * In many places it is efficient to batch an operation up against multiple
- * pages.  A pagevec is a multipage container which is used for that.
+ * folios.  A folio_batch is a container which is used for that.
  */
 
 #ifndef _LINUX_PAGEVEC_H
 #define _LINUX_PAGEVEC_H
 
-#include <linux/xarray.h>
+#include <linux/types.h>
 
-/* 15 pointers + header align the pagevec structure to a power of two */
+/* 15 pointers + header align the folio_batch structure to a power of two */
 #define PAGEVEC_SIZE	15
 
-struct page;
 struct folio;
-struct address_space;
-
-/* Layout must match folio_batch */
-struct pagevec {
-	unsigned char nr;
-	bool percpu_pvec_drained;
-	struct page *pages[PAGEVEC_SIZE];
-};
-
-void __pagevec_release(struct pagevec *pvec);
-
-static inline void pagevec_init(struct pagevec *pvec)
-{
-	pvec->nr = 0;
-	pvec->percpu_pvec_drained = false;
-}
-
-static inline void pagevec_reinit(struct pagevec *pvec)
-{
-	pvec->nr = 0;
-}
-
-static inline unsigned pagevec_count(struct pagevec *pvec)
-{
-	return pvec->nr;
-}
-
-static inline unsigned pagevec_space(struct pagevec *pvec)
-{
-	return PAGEVEC_SIZE - pvec->nr;
-}
-
-/*
- * Add a page to a pagevec.  Returns the number of slots still available.
- */
-static inline unsigned pagevec_add(struct pagevec *pvec, struct page *page)
-{
-	pvec->pages[pvec->nr++] = page;
-	return pagevec_space(pvec);
-}
-
-static inline void pagevec_release(struct pagevec *pvec)
-{
-	if (pagevec_count(pvec))
-		__pagevec_release(pvec);
-}
 
 /**
  * struct folio_batch - A collection of folios.
@@ -78,11 +31,6 @@ struct folio_batch {
 	struct folio *folios[PAGEVEC_SIZE];
 };
 
-/* Layout must match pagevec */
-static_assert(sizeof(struct pagevec) == sizeof(struct folio_batch));
-static_assert(offsetof(struct pagevec, pages) ==
-		offsetof(struct folio_batch, folios));
-
 /**
  * folio_batch_init() - Initialise a batch of folios
  * @fbatch: The folio batch.
@@ -127,10 +75,7 @@ static inline unsigned folio_batch_add(struct folio_batch *fbatch,
 	return folio_batch_space(fbatch);
 }
 
-static inline void __folio_batch_release(struct folio_batch *fbatch)
-{
-	__pagevec_release((struct pagevec *)fbatch);
-}
+void __folio_batch_release(struct folio_batch *pvec);
 
 static inline void folio_batch_release(struct folio_batch *fbatch)
 {
diff --git a/mm/swap.c b/mm/swap.c
index 423199ee8478..10348c1cf9c5 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1044,25 +1044,25 @@ void release_pages(release_pages_arg arg, int nr)
 EXPORT_SYMBOL(release_pages);
 
 /*
- * The pages which we're about to release may be in the deferred lru-addition
+ * The folios which we're about to release may be in the deferred lru-addition
  * queues.  That would prevent them from really being freed right now.  That's
- * OK from a correctness point of view but is inefficient - those pages may be
+ * OK from a correctness point of view but is inefficient - those folios may be
  * cache-warm and we want to give them back to the page allocator ASAP.
  *
- * So __pagevec_release() will drain those queues here.
+ * So __folio_batch_release() will drain those queues here.
  * folio_batch_move_lru() calls folios_put() directly to avoid
  * mutual recursion.
  */
-void __pagevec_release(struct pagevec *pvec)
+void __folio_batch_release(struct folio_batch *fbatch)
 {
-	if (!pvec->percpu_pvec_drained) {
+	if (!fbatch->percpu_pvec_drained) {
 		lru_add_drain();
-		pvec->percpu_pvec_drained = true;
+		fbatch->percpu_pvec_drained = true;
 	}
-	release_pages(pvec->pages, pagevec_count(pvec));
-	pagevec_reinit(pvec);
+	release_pages(fbatch->folios, folio_batch_count(fbatch));
+	folio_batch_reinit(fbatch);
 }
-EXPORT_SYMBOL(__pagevec_release);
+EXPORT_SYMBOL(__folio_batch_release);
 
 /**
  * folio_batch_remove_exceptionals() - Prune non-folios from a batch.
-- 
2.39.2

