Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06BC3B032E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 13:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhFVLui (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 07:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhFVLui (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:50:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FCDC061574;
        Tue, 22 Jun 2021 04:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5Mv5hdASTb6Ku+l6s7Ur4WdHNNxEw6oKKMr1RnOamKM=; b=gK5gZKH6BR9f+oWvX4Tyg0Q6UE
        u/BA38MCP2dpt6zzeQlpXSCQDvjo1YzBEA9CQDcxkxpGdtmDTK7UPp215MwtRpHwgDHqOWedPI0JT
        HjhGxMiEiTZ8R5KF/pO9ry5NhHx0V6X2rWsblPjR66kwZI77nH7L5RtbcFxK3IRjJKVPOz3NSdYPX
        IXFGRoDmQMxYASf54+fTFud9Vf30ML78SkPTl2RohiDoKle/wuEjBfspxkEvExSTTtWB0HX+0/BJk
        swaqjmWxHU6bUHVFtuQSC1GVYGnTqzX9bORvilDLZwTxmcqpkz+z/TIPz4nbGZVfvm6as+0x/3FpI
        W6jFDDzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvert-00EDpt-9K; Tue, 22 Jun 2021 11:47:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v12 08/33] mm: Add folio_get()
Date:   Tue, 22 Jun 2021 12:40:53 +0100
Message-Id: <20210622114118.3388190-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622114118.3388190-1-willy@infradead.org>
References: <20210622114118.3388190-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we know we have a folio, we can call folio_get() instead
of get_page() and save the overhead of calling compound_head().
No change to generated code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 include/linux/mm.h | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 08a80e2eb292..54f7f7eb6c3f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1224,18 +1224,26 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 }
 
 /* 127: arbitrary random number, small enough to assemble well */
-#define page_ref_zero_or_close_to_overflow(page) \
-	((unsigned int) page_ref_count(page) + 127u <= 127u)
+#define folio_ref_zero_or_close_to_overflow(folio) \
+	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
+
+/**
+ * folio_get - Increment the reference count on a folio.
+ * @folio: The folio.
+ *
+ * Context: May be called in any context, as long as you know that
+ * you have a refcount on the folio.  If you do not already have one,
+ * folio_try_get() may be the right interface for you to use.
+ */
+static inline void folio_get(struct folio *folio)
+{
+	VM_BUG_ON_FOLIO(folio_ref_zero_or_close_to_overflow(folio), folio);
+	folio_ref_inc(folio);
+}
 
 static inline void get_page(struct page *page)
 {
-	page = compound_head(page);
-	/*
-	 * Getting a normal page or the head of a compound page
-	 * requires to already have an elevated page->_refcount.
-	 */
-	VM_BUG_ON_PAGE(page_ref_zero_or_close_to_overflow(page), page);
-	page_ref_inc(page);
+	folio_get(page_folio(page));
 }
 
 bool __must_check try_grab_page(struct page *page, unsigned int flags);
-- 
2.30.2

