Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027A251F1A1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiEHUjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbiEHUhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:37:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ABC12631
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HIfhBMw5f0LhpRCoQQRt/KaqnyuZgn//pHZ+XcnNlDQ=; b=hH1NograNt425aDLpWhePNANrN
        nn94rs/QJSeEaTkMcUFbYOUUSRzkzZwZKMMnyLTU8zDUoDxLpAqMI4IagwAu6c2GrAh9T7p0uLZyv
        RmMYzfIgBdldNBVPwGbVNCJK6yyrnGcV6evSwlA7UXV8o4pyZMmcq/V4+80c7XgvmEVgq2ROT11od
        qr1YlFiPq2cIZ8O8TqZWh+pTaUwi01Rh55vag24NgUsA/+MzoScgYPjWPJ2gdmV9dL8mxIufKxiBK
        zxfyto2nh0WdAOoJPPsWCZFfg3jiYMUla93PyGkHkrZVWweNGpnYfvC6fLX5hZmr8rwQG1+hawfLF
        fi3VOktw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaT-002o6n-Cj; Sun, 08 May 2022 20:33:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 5/5] fs: Remove aops->freepage
Date:   Sun,  8 May 2022 21:33:01 +0100
Message-Id: <20220508203301.669147-6-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203301.669147-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203301.669147-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All implementations now use free_folio so we can delete the callers
and the method.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fs.h | 1 -
 mm/filemap.c       | 7 -------
 mm/vmscan.c        | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 915844e6293e..6f305f1097a5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -357,7 +357,6 @@ struct address_space_operations {
 	void (*invalidate_folio) (struct folio *, size_t offset, size_t len);
 	bool (*release_folio)(struct folio *, gfp_t);
 	void (*free_folio)(struct folio *folio);
-	void (*freepage)(struct page *);
 	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 	/*
 	 * migrate the contents of a page to the specified target. If
diff --git a/mm/filemap.c b/mm/filemap.c
index adcdef56890f..fa0ca674450f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -225,16 +225,12 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
 
 void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 {
-	void (*freepage)(struct page *);
 	void (*free_folio)(struct folio *);
 	int refs = 1;
 
 	free_folio = mapping->a_ops->free_folio;
 	if (free_folio)
 		free_folio(folio);
-	freepage = mapping->a_ops->freepage;
-	if (freepage)
-		freepage(&folio->page);
 
 	if (folio_test_large(folio) && !folio_test_hugetlb(folio))
 		refs = folio_nr_pages(folio);
@@ -812,7 +808,6 @@ void replace_page_cache_page(struct page *old, struct page *new)
 	struct folio *fnew = page_folio(new);
 	struct address_space *mapping = old->mapping;
 	void (*free_folio)(struct folio *) = mapping->a_ops->free_folio;
-	void (*freepage)(struct page *) = mapping->a_ops->freepage;
 	pgoff_t offset = old->index;
 	XA_STATE(xas, &mapping->i_pages, offset);
 
@@ -842,8 +837,6 @@ void replace_page_cache_page(struct page *old, struct page *new)
 	xas_unlock_irq(&xas);
 	if (free_folio)
 		free_folio(fold);
-	if (freepage)
-		freepage(old);
 	folio_put(fold);
 }
 EXPORT_SYMBOL_GPL(replace_page_cache_page);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d8a031128ad0..edc89f26b738 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1283,10 +1283,8 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 		put_swap_page(&folio->page, swap);
 	} else {
 		void (*free_folio)(struct folio *);
-		void (*freepage)(struct page *);
 
 		free_folio = mapping->a_ops->free_folio;
-		freepage = mapping->a_ops->freepage;
 		/*
 		 * Remember a shadow entry for reclaimed file cache in
 		 * order to detect refaults, thus thrashing, later on.
@@ -1314,8 +1312,6 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 
 		if (free_folio)
 			free_folio(folio);
-		if (freepage)
-			freepage(&folio->page);
 	}
 
 	return 1;
-- 
2.34.1

