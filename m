Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176753B0554
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhFVM7E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhFVM7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:59:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C60C061574;
        Tue, 22 Jun 2021 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JJaZiPnSuuNOzB/6aENHsDzMj9Vk4E7kgG+v4Zoamzw=; b=o4n6mIEWIQnNZfqNoT/SsusYKd
        eManugI5okW797cSLpEWU++lTs8+1h3v+/VyHZrvgwOZnmMseDlf+9hdCnH8WyQRoA1ODkb3ABIWy
        cZMXdCONsOfShhGYzSDWbeQvN2l4ks4XkxvTyTOcoS4QfB5JYUkKSfZyB/qYTBLlgvnS9wo8Sr5Vx
        WM8Fe9IGuMIVeXAEV41F7EVtzdFp6AKoBTs9ZgvK7OnuysxDoo+oHS1jJbL0AvE9ftUzy8y0k+ftF
        pu4vx9K8yc5ObfZhm1X2PKmZC5fV2m4Ul/PvF3RmFrRtuN01lUSypMHY5qx0dweJ2+ob2xGqJQkVj
        bVPbLZSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfwP-00EJAM-D6; Tue, 22 Jun 2021 12:56:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 46/46] mm/filemap: Add FGP_STABLE
Date:   Tue, 22 Jun 2021 13:15:51 +0100
Message-Id: <20210622121551.3398730-47-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
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

Kernel grows by 11 bytes.  filemap_get_folio() grows by 33 bytes
but grab_cache_page_write_begin() shrinks by 22 bytes to make up
for it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 25 +++----------------------
 mm/folio-compat.c       | 13 +++++++++++++
 3 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 669bdebe2861..865b7784e99b 100644
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
index e431461279c3..4951fe8787d8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1817,6 +1817,7 @@ static struct folio *mapping_get_entry(struct address_space *mapping,
  * * %FGP_WRITE - The page will be written to by the caller.
  * * %FGP_NOFS - __GFP_FS will get cleared in gfp.
  * * %FGP_NOWAIT - Don't get blocked by page lock.
+ * * %FGP_STABLE - Wait for the folio to be stable (finished writeback)
  *
  * If %FGP_LOCK or %FGP_CREAT are specified then the function may sleep even
  * if the %GFP flags specified for %FGP_CREAT are atomic.
@@ -1867,6 +1868,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			folio_clear_idle_flag(folio);
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
index 78365eaee7d3..206bedd621d0 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -115,6 +115,7 @@ void lru_cache_add(struct page *page)
 }
 EXPORT_SYMBOL(lru_cache_add);
 
+noinline
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		int fgp_flags, gfp_t gfp)
 {
@@ -126,3 +127,15 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
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

