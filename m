Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14938374729
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 19:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbhEERrq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 13:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbhEERqH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 13:46:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA200C061342;
        Wed,  5 May 2021 10:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3oul7NQQ/uE+srpwctZ89k99gmcgVzJVHJCnnkiuaMk=; b=iAX7sPAQm9wyCQagLFCssgPtRz
        0W1Qo9ESTuRbTUcdZhOBFlryC/+oGX9wddBfq7URIzysA+/kjjk5PCbrKmjImgkPkeZXAa0e1XleI
        xy+L+xWbEkDmEPtuYcDqtrk+gWBujNM5r/t6gi/klQjzG2PYW8FYuoQxfTZhNM/S5wWCV23/i+82a
        xfTsgUDy8yqafl9ysJITYlxPvq6+uNH+pQ+p/pZ4C5WnhufZJBSzL1npFdT74MoHZKo7ehKHuRvWq
        EC1s9nAswdBBee+Y0OhQX4vK7kTUcWTsl5SUom9y1CiLjhevGRd1ygogFhybRWN/yi9zMg4dYp0mK
        /2MGRV6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leL00-000cla-ER; Wed, 05 May 2021 17:08:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 81/96] mm/filemap: Add filemap_get_stable_folio
Date:   Wed,  5 May 2021 16:06:13 +0100
Message-Id: <20210505150628.111735-82-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the folio equivalent of grab_cache_page_write_begin(), which is
reimplemented as a wrapper around it.

Kernel grows by 88 bytes.  filemap_get_stable_folio() is the same
size as the old grab_cache_page_write_begin(), but the wrapper is
80 bytes, plus the 8 bytes for the EXPORT_SYMBOL.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 20 ++++++++++----------
 mm/folio-compat.c       |  9 +++++++++
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 03125035077c..726cfc61b9e5 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -589,6 +589,8 @@ static inline unsigned find_get_pages_tag(struct address_space *mapping,
 					nr_pages, pages);
 }
 
+struct folio *filemap_get_stable_folio(struct address_space *mapping,
+		pgoff_t index, unsigned flags);
 struct page *grab_cache_page_write_begin(struct address_space *mapping,
 			pgoff_t index, unsigned flags);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 3d8715a6dd08..8399deb678f6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3574,26 +3574,26 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 EXPORT_SYMBOL(generic_file_direct_write);
 
 /*
- * Find or create a page at the given pagecache position. Return the locked
- * page. This function is specifically for buffered writes.
+ * Find or create a folio at the given pagecache position. Return the locked
+ * folio once there are no pending writes.
  */
-struct page *grab_cache_page_write_begin(struct address_space *mapping,
+struct folio *filemap_get_stable_folio(struct address_space *mapping,
 					pgoff_t index, unsigned flags)
 {
-	struct page *page;
-	int fgp_flags = FGP_LOCK|FGP_WRITE|FGP_CREAT;
+	struct folio *folio;
+	int fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT;
 
 	if (flags & AOP_FLAG_NOFS)
 		fgp_flags |= FGP_NOFS;
 
-	page = pagecache_get_page(mapping, index, fgp_flags,
+	folio = filemap_get_folio(mapping, index, fgp_flags,
 			mapping_gfp_mask(mapping));
-	if (page)
-		wait_for_stable_page(page);
+	if (folio)
+		folio_wait_stable(folio);
 
-	return page;
+	return folio;
 }
-EXPORT_SYMBOL(grab_cache_page_write_begin);
+EXPORT_SYMBOL(filemap_get_stable_folio);
 
 ssize_t generic_perform_write(struct file *file,
 				struct iov_iter *i, loff_t pos)
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index df0038c65da9..940fe515a3a2 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -96,3 +96,12 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 	return folio_file_page(folio, index);
 }
 EXPORT_SYMBOL(pagecache_get_page);
+
+struct page *grab_cache_page_write_begin(struct address_space *mapping,
+					pgoff_t index, unsigned flags)
+{
+	struct folio *folio = filemap_get_stable_folio(mapping, index, flags);
+
+	return folio ? folio_file_page(folio, index) : NULL;
+}
+EXPORT_SYMBOL(grab_cache_page_write_begin);
-- 
2.30.2

