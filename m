Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC0348E011
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 23:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbiAMWIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 17:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbiAMWI3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 17:08:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D49C061574;
        Thu, 13 Jan 2022 14:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IDWd/IwHC04isId/iqsr+2lvOr59lemWZtcJ7xJcHQ8=; b=S6PRB2iNVWjdYGSM5xIlrNR7DL
        H3ZXNb0AaFUeQDx9woQRC3mynAnlA0zO42J4QTvToV1e4TNqV8JLEG8SSBByob0QXShOpu/f7+rfh
        jp/mlnGeNk1sHZtPGVBD6uPhx8Fjk1fFXvvgruGRPz47DtBNVttFY4jhqgb4/h7p43DC6PJ+Qmeo2
        T155/22ATgwj7NFEIOV0QFjVxko9cSzqG/gDRqcvbbRnSIcrL7dlAQKP50G6StK2CrIK8cj6fJTdZ
        yG2BzbbVfP87B8f3OGkeTCp4xOKddJBqe/UIWLwH2Wizlx5WRJVpIsKjEDWyCe/A/biA75/XZkOWF
        zLQ7+fhw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n88Gc-005HEW-D7; Thu, 13 Jan 2022 22:08:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 1/2] mm: Add folio_put_refs()
Date:   Thu, 13 Jan 2022 22:08:15 +0000
Message-Id: <20220113220816.1257657-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220113220816.1257657-1-willy@infradead.org>
References: <20220113220816.1257657-1-willy@infradead.org>
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
2.33.0

