Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AAE4B5BDE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 22:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiBNUxr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 15:53:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiBNUxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:53:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A3BDF96
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 12:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IKQvQjQyaVYzMd7sIYmBk50TPxoi3xTQ2SLk9p3z5lY=; b=beCuCvlC79LZmSc0RJwQniZ7Vz
        tZhUDBMk6by181+SbK1DharJaL8MmNcQ8Q5mVoI6CYAVceN0a1fYW+mMKeMhF4iizt55NbjqqLY2P
        UQgoyPihUUUSqzXlGYSHAUQV/GFFO8a3CCC4RhTLqqS21vugd0AWnJrG2QnfabotfoaQ/iCAOnDT4
        QsOwlHS7zwIs7HAVtF5+kP6Zw2NFSq6+rpcrexk9bYzKrL3rxJLuQo0qbzqCuel9mz9/sUmY6Aasi
        MuS0XcI60wQINwgCTFABQ2Zs9DTlVBxZ9DNOHIQRKR5Xv5Ev7VfvSNlB1boozGvA3Wf9CGNJTfyJV
        P2ChehHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJhWH-00DDeA-3h; Mon, 14 Feb 2022 20:00:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 09/10] mm/truncate: Combine invalidate_mapping_pagevec() and __invalidate_mapping_pages()
Date:   Mon, 14 Feb 2022 20:00:16 +0000
Message-Id: <20220214200017.3150590-10-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220214200017.3150590-1-willy@infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
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

We can save a function call by combining these two functions, which
are identical except for the return value.  Also move the prototype
to mm/internal.h.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fs.h |  4 ----
 mm/internal.h      |  2 ++
 mm/truncate.c      | 32 +++++++++++++-------------------
 3 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index e2d892b201b0..85c584c5c623 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2749,10 +2749,6 @@ extern bool is_bad_inode(struct inode *);
 unsigned long invalidate_mapping_pages(struct address_space *mapping,
 					pgoff_t start, pgoff_t end);
 
-void invalidate_mapping_pagevec(struct address_space *mapping,
-				pgoff_t start, pgoff_t end,
-				unsigned long *nr_pagevec);
-
 static inline void invalidate_remote_inode(struct inode *inode)
 {
 	if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
diff --git a/mm/internal.h b/mm/internal.h
index d886b87b1294..6bbe40a1880a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -102,6 +102,8 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
 bool truncate_inode_partial_folio(struct folio *folio, loff_t start,
 		loff_t end);
 long invalidate_inode_page(struct page *page);
+unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
+		pgoff_t start, pgoff_t end, unsigned long *nr_pagevec);
 
 /**
  * folio_evictable - Test whether a folio is evictable.
diff --git a/mm/truncate.c b/mm/truncate.c
index 14486e75ec28..6b94b00f4307 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -492,7 +492,18 @@ void truncate_inode_pages_final(struct address_space *mapping)
 }
 EXPORT_SYMBOL(truncate_inode_pages_final);
 
-static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
+/**
+ * invalidate_mapping_pagevec - Invalidate all the unlocked pages of one inode
+ * @mapping: the address_space which holds the pages to invalidate
+ * @start: the offset 'from' which to invalidate
+ * @end: the offset 'to' which to invalidate (inclusive)
+ * @nr_pagevec: invalidate failed page number for caller
+ *
+ * This helper is similar to invalidate_mapping_pages(), except that it accounts
+ * for pages that are likely on a pagevec and counts them in @nr_pagevec, which
+ * will be used by the caller.
+ */
+unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
 		pgoff_t start, pgoff_t end, unsigned long *nr_pagevec)
 {
 	pgoff_t indices[PAGEVEC_SIZE];
@@ -557,27 +568,10 @@ static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
 unsigned long invalidate_mapping_pages(struct address_space *mapping,
 		pgoff_t start, pgoff_t end)
 {
-	return __invalidate_mapping_pages(mapping, start, end, NULL);
+	return invalidate_mapping_pagevec(mapping, start, end, NULL);
 }
 EXPORT_SYMBOL(invalidate_mapping_pages);
 
-/**
- * invalidate_mapping_pagevec - Invalidate all the unlocked pages of one inode
- * @mapping: the address_space which holds the pages to invalidate
- * @start: the offset 'from' which to invalidate
- * @end: the offset 'to' which to invalidate (inclusive)
- * @nr_pagevec: invalidate failed page number for caller
- *
- * This helper is similar to invalidate_mapping_pages(), except that it accounts
- * for pages that are likely on a pagevec and counts them in @nr_pagevec, which
- * will be used by the caller.
- */
-void invalidate_mapping_pagevec(struct address_space *mapping,
-		pgoff_t start, pgoff_t end, unsigned long *nr_pagevec)
-{
-	__invalidate_mapping_pages(mapping, start, end, nr_pagevec);
-}
-
 /*
  * This is like invalidate_inode_page(), except it ignores the page's
  * refcount.  We do this because invalidate_inode_pages2() needs stronger
-- 
2.34.1

