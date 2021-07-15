Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74783CAE15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 22:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbhGOUnc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 16:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237025AbhGOUnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:43:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29257C06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VA3slxY04uK543T+rs/K2RUbVRf5sutF+JwHtsd+vBA=; b=M418Z/OV7VJPMNjSlK6BdKsj9W
        j8D5/LYMHLP4+G+b9bvvkxjLB9+qAycXWHNC/6yuCVujMCQywkV/A98g4NdEqDY0i2gS10kl/mIYY
        mroHexpY4nWKZ3dzf/PqhXSwm/3kzZ8lUyuu8V4lm0Uk+Lbv4j1dAzXMdDEGK/NP30TMvNzYd663O
        tM8zDmS0AiGfTiFYxQKo56bBkvtSqBQymA7v4GeNTJCOXmpYdioaue95A6aUT51fpa0yQKbp+MmdY
        XUFPI2vCTbHku4ZgnNUXPqnv+LLDzlPWAroL9V0Q1nPU1PnB/bO0of1iaWcaZKJxD2rxh0LaNuPb4
        lmcNpkZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m487t-003qbK-Ep; Thu, 15 Jul 2021 20:38:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v14 39/39] mm/filemap: Add FGP_STABLE
Date:   Thu, 15 Jul 2021 21:00:30 +0100
Message-Id: <20210715200030.899216-40-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715200030.899216-1-willy@infradead.org>
References: <20210715200030.899216-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow filemap_get_folio() to wait for writeback to complete (if the
filesystem wants that behaviour).  This is the folio equivalent of
grab_cache_page_write_begin(), which is moved into the folio-compat
file as a reminder to migrate all the code using it.  This paves the
way for getting rid of AOP_FLAG_NOFS once grab_cache_page_write_begin()
is removed.

Kernel grows by 11 bytes.  filemap_get_folio() grows by 33 bytes but
grab_cache_page_write_begin() shrinks by 22 bytes to make up for it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 25 +++----------------------
 mm/folio-compat.c       | 13 +++++++++++++
 3 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index b24933eced18..83c1a798265f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -301,6 +301,7 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 #define FGP_FOR_MMAP		0x00000040
 #define FGP_HEAD		0x00000080
 #define FGP_ENTRY		0x00000100
+#define FGP_STABLE		0x00000200
 
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		int fgp_flags, gfp_t gfp);
diff --git a/mm/filemap.c b/mm/filemap.c
index 061e285aae21..0434c5a55fec 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1817,6 +1817,7 @@ static void *mapping_get_entry(struct address_space *mapping, pgoff_t index)
  * * %FGP_WRITE - The page will be written to by the caller.
  * * %FGP_NOFS - __GFP_FS will get cleared in gfp.
  * * %FGP_NOWAIT - Don't get blocked by page lock.
+ * * %FGP_STABLE - Wait for the folio to be stable (finished writeback)
  *
  * If %FGP_LOCK or %FGP_CREAT are specified then the function may sleep even
  * if the %GFP flags specified for %FGP_CREAT are atomic.
@@ -1867,6 +1868,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			folio_clear_idle(folio);
 	}
 
+	if (fgp_flags & FGP_STABLE)
+		folio_wait_stable(folio);
 no_page:
 	if (!folio && (fgp_flags & FGP_CREAT)) {
 		int err;
@@ -3590,28 +3593,6 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 }
 EXPORT_SYMBOL(generic_file_direct_write);
 
-/*
- * Find or create a page at the given pagecache position. Return the locked
- * page. This function is specifically for buffered writes.
- */
-struct page *grab_cache_page_write_begin(struct address_space *mapping,
-					pgoff_t index, unsigned flags)
-{
-	struct page *page;
-	int fgp_flags = FGP_LOCK|FGP_WRITE|FGP_CREAT;
-
-	if (flags & AOP_FLAG_NOFS)
-		fgp_flags |= FGP_NOFS;
-
-	page = pagecache_get_page(mapping, index, fgp_flags,
-			mapping_gfp_mask(mapping));
-	if (page)
-		wait_for_stable_page(page);
-
-	return page;
-}
-EXPORT_SYMBOL(grab_cache_page_write_begin);
-
 ssize_t generic_perform_write(struct file *file,
 				struct iov_iter *i, loff_t pos)
 {
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index e833e680e944..5b6ae1da314e 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -116,6 +116,7 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 }
 EXPORT_SYMBOL(add_to_page_cache_lru);
 
+noinline
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		int fgp_flags, gfp_t gfp)
 {
@@ -127,3 +128,15 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 	return folio_file_page(folio, index);
 }
 EXPORT_SYMBOL(pagecache_get_page);
+
+struct page *grab_cache_page_write_begin(struct address_space *mapping,
+					pgoff_t index, unsigned flags)
+{
+	unsigned fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
+
+	if (flags & AOP_FLAG_NOFS)
+		fgp_flags |= FGP_NOFS;
+	return pagecache_get_page(mapping, index, fgp_flags,
+			mapping_gfp_mask(mapping));
+}
+EXPORT_SYMBOL(grab_cache_page_write_begin);
-- 
2.30.2

