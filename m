Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D2D3C4177
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhGLDQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhGLDQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:16:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91109C0613DD;
        Sun, 11 Jul 2021 20:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BsTVLelJsz77cn0RYbDahBxZWse2jWTeGn4yCZaQdoM=; b=CAwjJzBZtyINLYP7aXmV7jTWqk
        QGFMi0QD0vFgEEAl3jZChb0KU2zhAZ+Y5ztsV6VRaNELQeYPTMlgmURnN15GnHEZo/a8LCERGgcGi
        nCEVXZNDncrFRedhgqgQVn7qhpwPHg8iSNEkmT9w9ajyEpHGMR//Ly4UhrVSmM2WTD/zn3mqUWOK0
        EHLIwLe8gO4GOImhZtpscoE40XyLtR51yvQ9ar2HJsa2sATGsXyNs/XAHBLW0GpSJbmLhfEH+A/2+
        glqAbfGcnncwt2sLSmO2NVHg0g/IAhWPyOIhVQtKTbx1belb0dd7eC84oFtzj05/2rvJqveTNRflr
        o+fufVVw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mME-00Gn2V-ET; Mon, 12 Jul 2021 03:11:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v13 007/137] mm: Add folio_put()
Date:   Mon, 12 Jul 2021 04:04:51 +0100
Message-Id: <20210712030701.4000097-8-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we know we have a folio, we can call folio_put() instead of put_page()
and save the overhead of calling compound_head().  Also skips the
devmap checks.

This commit looks like it should be a no-op, but actually saves 684 bytes
of text with the distro-derived config that I'm testing.  Some functions
grow a little while others shrink.  I presume the compiler is making
different inlining decisions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 include/linux/mm.h | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 460e9805dd9f..c981e3b28eb0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -749,6 +749,11 @@ static inline int put_page_testzero(struct page *page)
 	return page_ref_dec_and_test(page);
 }
 
+static inline int folio_put_testzero(struct folio *folio)
+{
+	return put_page_testzero(&folio->page);
+}
+
 /*
  * Try to grab a ref unless the page has a refcount of zero, return false if
  * that is the case.
@@ -1245,9 +1250,28 @@ static inline __must_check bool try_get_page(struct page *page)
 	return true;
 }
 
+/**
+ * folio_put - Decrement the reference count on a folio.
+ * @folio: The folio.
+ *
+ * If the folio's reference count reaches zero, the memory will be
+ * released back to the page allocator and may be used by another
+ * allocation immediately.  Do not access the memory or the struct folio
+ * after calling folio_put() unless you can be sure that it wasn't the
+ * last reference.
+ *
+ * Context: May be called in process or interrupt context, but not in NMI
+ * context.  May be called while holding a spinlock.
+ */
+static inline void folio_put(struct folio *folio)
+{
+	if (folio_put_testzero(folio))
+		__put_page(&folio->page);
+}
+
 static inline void put_page(struct page *page)
 {
-	page = compound_head(page);
+	struct folio *folio = page_folio(page);
 
 	/*
 	 * For devmap managed pages we need to catch refcount transition from
@@ -1255,13 +1279,12 @@ static inline void put_page(struct page *page)
 	 * need to inform the device driver through callback. See
 	 * include/linux/memremap.h and HMM for details.
 	 */
-	if (page_is_devmap_managed(page)) {
-		put_devmap_managed_page(page);
+	if (page_is_devmap_managed(&folio->page)) {
+		put_devmap_managed_page(&folio->page);
 		return;
 	}
 
-	if (put_page_testzero(page))
-		__put_page(page);
+	folio_put(folio);
 }
 
 /*
-- 
2.30.2

