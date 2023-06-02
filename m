Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27546720BEE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 00:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbjFBWZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 18:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbjFBWZR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:25:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A120E45;
        Fri,  2 Jun 2023 15:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nAYJDYU3TRUT7Dhvxc7GBzlQVR6Ge/TZndntkJ0o7dI=; b=dBSj4/uKGMJyWkSGkU4yfbFulx
        zS6WOpCVK3X2YoMv2Qa/K/jI8P5ZolkuouCVzbmU1ZocPW+lZvOMKblRgvxOdjiFtbt99/3oL37lJ
        D5pCYoJFDMK0eQU6/PE1zH3SpxfU9au7/RIOeBK4VyHpiYJDHPt+iKi6YDjrktHofwMGqq0j7ZWby
        J3QMEN0c+4Du6Iwd/It2os/4OyyLV48AFXBz6eBh/r5qxDbud15UvDMsLv5NyOS0UQTxBhsoa4DpV
        HpFwye2x3vliQdnRLStDqJpzzIYH4hlKhz/8s8CajtJfE6H2dtJUKEfKaDUDRbZcJpen0DkQv7XnH
        u7qOvTfg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q5DCR-009aPQ-2T; Fri, 02 Jun 2023 22:24:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 5/7] filemap: Allow __filemap_get_folio to allocate large folios
Date:   Fri,  2 Jun 2023 23:24:42 +0100
Message-Id: <20230602222445.2284892-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230602222445.2284892-1-willy@infradead.org>
References: <20230602222445.2284892-1-willy@infradead.org>
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

Allow callers of __filemap_get_folio() to specify a preferred folio
order in the FGP flags.  This is only honoured in the FGP_CREATE path;
if there is already a folio in the page cache that covers the index,
we will return it, no matter what its order is.  No create-around is
attempted; we will only create folios which start at the specified index.
Unmodified callers will continue to allocate order 0 folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 23 ++++++++++++++++++++++
 mm/filemap.c            | 42 ++++++++++++++++++++++++++++-------------
 mm/readahead.c          | 13 -------------
 3 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 7ab57a2bb576..667ce668f438 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -466,6 +466,19 @@ static inline void *detach_page_private(struct page *page)
 	return folio_detach_private(page_folio(page));
 }
 
+/*
+ * There are some parts of the kernel which assume that PMD entries
+ * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
+ * limit the maximum allocation order to PMD size.  I'm not aware of any
+ * assumptions about maximum order if THP are disabled, but 8 seems like
+ * a good order (that's 1MB if you're using 4kB pages)
+ */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
+#else
+#define MAX_PAGECACHE_ORDER	8
+#endif
+
 #ifdef CONFIG_NUMA
 struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order);
 #else
@@ -531,9 +544,19 @@ typedef unsigned int __bitwise fgp_t;
 #define FGP_NOWAIT		((__force fgp_t)0x00000020)
 #define FGP_FOR_MMAP		((__force fgp_t)0x00000040)
 #define FGP_STABLE		((__force fgp_t)0x00000080)
+#define FGP_GET_ORDER(fgp)	(((__force unsigned)fgp) >> 26)	/* top 6 bits */
 
 #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
 
+static inline fgp_t fgp_set_order(size_t size)
+{
+	unsigned int shift = ilog2(size);
+
+	if (shift <= PAGE_SHIFT)
+		return 0;
+	return (__force fgp_t)((shift - PAGE_SHIFT) << 26);
+}
+
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		fgp_t fgp_flags, gfp_t gfp);
diff --git a/mm/filemap.c b/mm/filemap.c
index eb89a815f2f8..10ea9321c36e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1937,7 +1937,9 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		folio_wait_stable(folio);
 no_page:
 	if (!folio && (fgp_flags & FGP_CREAT)) {
+		unsigned order = FGP_GET_ORDER(fgp_flags);
 		int err;
+
 		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
 			gfp |= __GFP_WRITE;
 		if (fgp_flags & FGP_NOFS)
@@ -1946,26 +1948,40 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			gfp &= ~GFP_KERNEL;
 			gfp |= GFP_NOWAIT | __GFP_NOWARN;
 		}
-
-		folio = filemap_alloc_folio(gfp, 0);
-		if (!folio)
-			return ERR_PTR(-ENOMEM);
-
 		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
 			fgp_flags |= FGP_LOCK;
 
-		/* Init accessed so avoid atomic mark_page_accessed later */
-		if (fgp_flags & FGP_ACCESSED)
-			__folio_set_referenced(folio);
+		if (!mapping_large_folio_support(mapping))
+			order = 0;
+		if (order > MAX_PAGECACHE_ORDER)
+			order = MAX_PAGECACHE_ORDER;
+		/* If we're not aligned, allocate a smaller folio */
+		if (index & ((1UL << order) - 1))
+			order = __ffs(index);
 
-		err = filemap_add_folio(mapping, folio, index, gfp);
-		if (unlikely(err)) {
+		do {
+			err = -ENOMEM;
+			if (order == 1)
+				order = 0;
+			folio = filemap_alloc_folio(gfp, order);
+			if (!folio)
+				continue;
+
+			/* Init accessed so avoid atomic mark_page_accessed later */
+			if (fgp_flags & FGP_ACCESSED)
+				__folio_set_referenced(folio);
+
+			err = filemap_add_folio(mapping, folio, index, gfp);
+			if (!err)
+				break;
 			folio_put(folio);
 			folio = NULL;
-			if (err == -EEXIST)
-				goto repeat;
-		}
+		} while (order-- > 0);
 
+		if (err == -EEXIST)
+			goto repeat;
+		if (err)
+			return ERR_PTR(err);
 		/*
 		 * filemap_add_folio locks the page, and for mmap
 		 * we expect an unlocked page.
diff --git a/mm/readahead.c b/mm/readahead.c
index 47afbca1d122..59a071badb90 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -462,19 +462,6 @@ static int try_context_readahead(struct address_space *mapping,
 	return 1;
 }
 
-/*
- * There are some parts of the kernel which assume that PMD entries
- * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
- * limit the maximum allocation order to PMD size.  I'm not aware of any
- * assumptions about maximum order if THP are disabled, but 8 seems like
- * a good order (that's 1MB if you're using 4kB pages)
- */
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
-#else
-#define MAX_PAGECACHE_ORDER	8
-#endif
-
 static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 		pgoff_t mark, unsigned int order, gfp_t gfp)
 {
-- 
2.39.2

