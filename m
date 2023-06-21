Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5223A738BFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 18:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjFUQqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 12:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjFUQqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:46:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072D01BC1;
        Wed, 21 Jun 2023 09:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yzS6LjqchbTZ4R7rHRoGuy4VZGAEBFE5nqlz2+V2o7A=; b=WBpyN9BXXz0sujrWmftgID2xoV
        kdlIrjAuPrDvE02NGbEGcLyBZ4Gh5juLzLRwS1aTs/iFXq/1LzJmB5OnGfnoB/gk9TrEijhUjAXEa
        zfpHDMGrt3LnGpZtYE4JE6eWPWyYdp2X2QggxQXZSI//nfSqIYLKPmLQneg7ai1fOJgcdgv30e8MD
        nMvTO7EwuTOqP49d04wRvN5Qg/gyTbkAb6jsLtg9q8C+RRUI0bD+XBrJIyUyiEfPwvF9jfze9zMT6
        j21Ep+8UpwfWW4NGk2mJombjhn0YtTQ396FgivudfclsdbCqddsGj33hwbEIDLfpb4JolRAADXAQL
        nT3lFN0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qC0y1-00EjDo-LH; Wed, 21 Jun 2023 16:46:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 05/13] drm: Convert drm_gem_put_pages() to use a folio_batch
Date:   Wed, 21 Jun 2023 17:45:49 +0100
Message-Id: <20230621164557.3510324-6-willy@infradead.org>
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

Remove a few hidden compound_head() calls by converting the returned
page to a folio once and using the folio APIs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/gpu/drm/drm_gem.c | 68 ++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 1a5a2cd0d4ec..78dcae201cc6 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -496,13 +496,13 @@ int drm_gem_create_mmap_offset(struct drm_gem_object *obj)
 EXPORT_SYMBOL(drm_gem_create_mmap_offset);
 
 /*
- * Move pages to appropriate lru and release the pagevec, decrementing the
- * ref count of those pages.
+ * Move folios to appropriate lru and release the folios, decrementing the
+ * ref count of those folios.
  */
-static void drm_gem_check_release_pagevec(struct pagevec *pvec)
+static void drm_gem_check_release_batch(struct folio_batch *fbatch)
 {
-	check_move_unevictable_pages(pvec);
-	__pagevec_release(pvec);
+	check_move_unevictable_folios(fbatch);
+	__folio_batch_release(fbatch);
 	cond_resched();
 }
 
@@ -534,10 +534,10 @@ static void drm_gem_check_release_pagevec(struct pagevec *pvec)
 struct page **drm_gem_get_pages(struct drm_gem_object *obj)
 {
 	struct address_space *mapping;
-	struct page *p, **pages;
-	struct pagevec pvec;
-	int i, npages;
-
+	struct page **pages;
+	struct folio *folio;
+	struct folio_batch fbatch;
+	int i, j, npages;
 
 	if (WARN_ON(!obj->filp))
 		return ERR_PTR(-EINVAL);
@@ -559,11 +559,14 @@ struct page **drm_gem_get_pages(struct drm_gem_object *obj)
 
 	mapping_set_unevictable(mapping);
 
-	for (i = 0; i < npages; i++) {
-		p = shmem_read_mapping_page(mapping, i);
-		if (IS_ERR(p))
+	i = 0;
+	while (i < npages) {
+		folio = shmem_read_folio_gfp(mapping, i,
+				mapping_gfp_mask(mapping));
+		if (IS_ERR(folio))
 			goto fail;
-		pages[i] = p;
+		for (j = 0; j < folio_nr_pages(folio); j++, i++)
+			pages[i] = folio_file_page(folio, i);
 
 		/* Make sure shmem keeps __GFP_DMA32 allocated pages in the
 		 * correct region during swapin. Note that this requires
@@ -571,23 +574,26 @@ struct page **drm_gem_get_pages(struct drm_gem_object *obj)
 		 * so shmem can relocate pages during swapin if required.
 		 */
 		BUG_ON(mapping_gfp_constraint(mapping, __GFP_DMA32) &&
-				(page_to_pfn(p) >= 0x00100000UL));
+				(folio_pfn(folio) >= 0x00100000UL));
 	}
 
 	return pages;
 
 fail:
 	mapping_clear_unevictable(mapping);
-	pagevec_init(&pvec);
-	while (i--) {
-		if (!pagevec_add(&pvec, pages[i]))
-			drm_gem_check_release_pagevec(&pvec);
+	folio_batch_init(&fbatch);
+	j = 0;
+	while (j < i) {
+		struct folio *f = page_folio(pages[j]);
+		if (!folio_batch_add(&fbatch, f))
+			drm_gem_check_release_batch(&fbatch);
+		j += folio_nr_pages(f);
 	}
-	if (pagevec_count(&pvec))
-		drm_gem_check_release_pagevec(&pvec);
+	if (fbatch.nr)
+		drm_gem_check_release_batch(&fbatch);
 
 	kvfree(pages);
-	return ERR_CAST(p);
+	return ERR_CAST(folio);
 }
 EXPORT_SYMBOL(drm_gem_get_pages);
 
@@ -603,7 +609,7 @@ void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
 {
 	int i, npages;
 	struct address_space *mapping;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 
 	mapping = file_inode(obj->filp)->i_mapping;
 	mapping_clear_unevictable(mapping);
@@ -616,23 +622,27 @@ void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
 
 	npages = obj->size >> PAGE_SHIFT;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	for (i = 0; i < npages; i++) {
+		struct folio *folio;
+
 		if (!pages[i])
 			continue;
+		folio = page_folio(pages[i]);
 
 		if (dirty)
-			set_page_dirty(pages[i]);
+			folio_mark_dirty(folio);
 
 		if (accessed)
-			mark_page_accessed(pages[i]);
+			folio_mark_accessed(folio);
 
 		/* Undo the reference we took when populating the table */
-		if (!pagevec_add(&pvec, pages[i]))
-			drm_gem_check_release_pagevec(&pvec);
+		if (!folio_batch_add(&fbatch, folio))
+			drm_gem_check_release_batch(&fbatch);
+		i += folio_nr_pages(folio) - 1;
 	}
-	if (pagevec_count(&pvec))
-		drm_gem_check_release_pagevec(&pvec);
+	if (folio_batch_count(&fbatch))
+		drm_gem_check_release_batch(&fbatch);
 
 	kvfree(pages);
 }
-- 
2.39.2

