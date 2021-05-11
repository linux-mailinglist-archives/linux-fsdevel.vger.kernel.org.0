Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC45437B115
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 23:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhEKVxw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 17:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKVxw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 17:53:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E26C061574;
        Tue, 11 May 2021 14:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=db+PTL9EAtXLFkws4aJ1HfijoiuB9GF9rbs4PdOnE3Q=; b=MFqKZGuXtzdHVX/Tyqm9ExcJds
        O1nylkqDmXL0xMkmNVKjh2EdkSnkgghLSfK6s/GuPd1ZQXNr177C2eZxgQVx4auMK+exPAcdvdoRD
        yJamOWJ6U0cJC+X7szP1l0/cS9BP3rh3WJKYcLF8Fq27jt7NoYNCc5YVgqHZ651s8pVW1alwkiNPC
        6Wkvn+pnrB1yjctVo152quYQ8HTTOGw/Se1vURPwCTi3dKH5L4TlldHfwXmeCRua1O37+O7nSuail
        yCDCWYhDaqmclOAvQrmAi7Yi4p/wryMwIzqc0tT79eDqAW6oKMTEiObO/MfLECUI5TyUwh453VduR
        blxiv8hQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgaHC-007hoG-Iq; Tue, 11 May 2021 21:51:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v10 06/33] mm: Add folio_put
Date:   Tue, 11 May 2021 22:47:08 +0100
Message-Id: <20210511214735.1836149-7-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210511214735.1836149-1-willy@infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we know we have a folio, we can call folio_put() instead of put_page()
and save the overhead of calling compound_head().  Also skips the
devmap checks.

This commit looks like it should be a no-op, but actually saves 1312 bytes
of text with the distro-derived config that I'm testing.  Some functions
grow a little while others shrink.  I presume the compiler is making
different inlining decisions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/mm.h | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a55c2c0628b6..610948f0cb43 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -751,6 +751,11 @@ static inline int put_page_testzero(struct page *page)
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
@@ -1242,9 +1247,28 @@ static inline __must_check bool try_get_page(struct page *page)
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
@@ -1252,13 +1276,12 @@ static inline void put_page(struct page *page)
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

