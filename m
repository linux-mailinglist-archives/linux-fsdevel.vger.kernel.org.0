Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D7948FCA5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jan 2022 13:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbiAPMSl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 07:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbiAPMSd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:18:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CE3C06173F;
        Sun, 16 Jan 2022 04:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vTljgvHhqZG3cT2RqoyXMcY1zZutR0LRzeE9Ah9ayuk=; b=qpCpEjsgcgij2zVHnH1WhH1Opg
        5COj5QM3fLjZ62EFFu7Fz/3O7RcjVnqvhubuAolQcCVWIDlTTZM607nQaE76CajV2ILjyMdhUuFbF
        B07DdDlNrjU2AsmoMiUmk9oyM/iGyjXS6Xnc/K4fZkNydVYJzhEzZQB0oJJSVO5jIQjM1dpQPDhwo
        YlucFFuseK5sDqCqkpvZwpx3iCoMB3d57MvCEnX/2Q8WAg44whIg/wjHW3RWZ4oucF9LXwInqgpnv
        tyJ2fCzGXjiwFbEP3NbQo9A7FOS8eZNS1TlfQXX/bDWUJkIU5rfOJDjlxylWXtUfDeSjtb5OI3GE/
        wrK5XMnw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n94UM-007FUB-6X; Sun, 16 Jan 2022 12:18:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 01/12] mm: Add folio_put_refs()
Date:   Sun, 16 Jan 2022 12:18:11 +0000
Message-Id: <20220116121822.1727633-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220116121822.1727633-1-willy@infradead.org>
References: <20220116121822.1727633-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is like folio_put(), but puts N references at once instead of
just one.  It's like put_page_refs(), but does one atomic operation
instead of two, and is available to more than just gup.c.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/mm.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c768a7c81b0b..cb98f75b245e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1244,6 +1244,26 @@ static inline void folio_put(struct folio *folio)
 		__put_page(&folio->page);
 }
 
+/**
+ * folio_put_refs - Reduce the reference count on a folio.
+ * @folio: The folio.
+ * @refs: The amount to subtract from the folio's reference count.
+ *
+ * If the folio's reference count reaches zero, the memory will be
+ * released back to the page allocator and may be used by another
+ * allocation immediately.  Do not access the memory or the struct folio
+ * after calling folio_put_refs() unless you can be sure that these weren't
+ * the last references.
+ *
+ * Context: May be called in process or interrupt context, but not in NMI
+ * context.  May be called while holding a spinlock.
+ */
+static inline void folio_put_refs(struct folio *folio, int refs)
+{
+	if (folio_ref_sub_and_test(folio, refs))
+		__put_page(&folio->page);
+}
+
 static inline void put_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
-- 
2.34.1

