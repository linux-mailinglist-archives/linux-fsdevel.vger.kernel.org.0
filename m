Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B56738BFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 18:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjFUQqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 12:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFUQqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:46:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEEF1BCB;
        Wed, 21 Jun 2023 09:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=S9L58IPbLSJMGWxFtvlnrG4TzIQ7IOqSwhUMe45kT8U=; b=PW4Dwh4Gf1suM6iF8qmdwxhedV
        dGBA+OGAVi6nz1TzXhqQwejLNG6p8I/gHBdyJdF+v9Gwlfc+qXUjfsQRhEupLyGODb3oBlcxjqeZg
        MjDYrwlGzkp9KSAXfQWGPMLoY7z8XE2Ha7+Drv6kVcDGv88l6mKIj3vMNnmJc0wPJLF/1/j23opEa
        eo5D3L64k7UfoSUT0lpwRO6h7SIv4cOQ8G08UCt/pjyMlmUKsodXKsDFTzzN9xwAVenix5X7iC12y
        ymJp18fQp4MbBy2x2WRcwk0mKw0eF20AfD6Cvpc56WVKj7Wa6gjeZD91h/NOb3XGNU2NojtTr6joC
        HO//Edeg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qC0y2-00EjEL-0r; Wed, 21 Jun 2023 16:46:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 08/13] i915: Convert i915_gpu_error to use a folio_batch
Date:   Wed, 21 Jun 2023 17:45:52 +0100
Message-Id: <20230621164557.3510324-9-willy@infradead.org>
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

Remove one of the last remaining users of pagevec.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/gpu/drm/i915/i915_gpu_error.c | 50 +++++++++++++--------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index ec368e700235..0c38bfb60c9a 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -187,64 +187,64 @@ i915_error_printer(struct drm_i915_error_state_buf *e)
 }
 
 /* single threaded page allocator with a reserved stash for emergencies */
-static void pool_fini(struct pagevec *pv)
+static void pool_fini(struct folio_batch *fbatch)
 {
-	pagevec_release(pv);
+	folio_batch_release(fbatch);
 }
 
-static int pool_refill(struct pagevec *pv, gfp_t gfp)
+static int pool_refill(struct folio_batch *fbatch, gfp_t gfp)
 {
-	while (pagevec_space(pv)) {
-		struct page *p;
+	while (folio_batch_space(fbatch)) {
+		struct folio *folio;
 
-		p = alloc_page(gfp);
-		if (!p)
+		folio = folio_alloc(gfp, 0);
+		if (!folio)
 			return -ENOMEM;
 
-		pagevec_add(pv, p);
+		folio_batch_add(fbatch, folio);
 	}
 
 	return 0;
 }
 
-static int pool_init(struct pagevec *pv, gfp_t gfp)
+static int pool_init(struct folio_batch *fbatch, gfp_t gfp)
 {
 	int err;
 
-	pagevec_init(pv);
+	folio_batch_init(fbatch);
 
-	err = pool_refill(pv, gfp);
+	err = pool_refill(fbatch, gfp);
 	if (err)
-		pool_fini(pv);
+		pool_fini(fbatch);
 
 	return err;
 }
 
-static void *pool_alloc(struct pagevec *pv, gfp_t gfp)
+static void *pool_alloc(struct folio_batch *fbatch, gfp_t gfp)
 {
-	struct page *p;
+	struct folio *folio;
 
-	p = alloc_page(gfp);
-	if (!p && pagevec_count(pv))
-		p = pv->pages[--pv->nr];
+	folio = folio_alloc(gfp, 0);
+	if (!folio && folio_batch_count(fbatch))
+		folio = fbatch->folios[--fbatch->nr];
 
-	return p ? page_address(p) : NULL;
+	return folio ? folio_address(folio) : NULL;
 }
 
-static void pool_free(struct pagevec *pv, void *addr)
+static void pool_free(struct folio_batch *fbatch, void *addr)
 {
-	struct page *p = virt_to_page(addr);
+	struct folio *folio = virt_to_folio(addr);
 
-	if (pagevec_space(pv))
-		pagevec_add(pv, p);
+	if (folio_batch_space(fbatch))
+		folio_batch_add(fbatch, folio);
 	else
-		__free_page(p);
+		folio_put(folio);
 }
 
 #ifdef CONFIG_DRM_I915_COMPRESS_ERROR
 
 struct i915_vma_compress {
-	struct pagevec pool;
+	struct folio_batch pool;
 	struct z_stream_s zstream;
 	void *tmp;
 };
@@ -381,7 +381,7 @@ static void err_compression_marker(struct drm_i915_error_state_buf *m)
 #else
 
 struct i915_vma_compress {
-	struct pagevec pool;
+	struct folio_batch pool;
 };
 
 static bool compress_init(struct i915_vma_compress *c)
-- 
2.39.2

