Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A192FA75D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405613AbhARRVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406853AbhARRDU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:03:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07633C0613D3;
        Mon, 18 Jan 2021 09:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WgNdplJNqnnOYl1riVEoZNoIZGy5sqydAea+QriKwC8=; b=hqFOZKIykRiuK22uV9CHZGGjMy
        m0tgyY5WePVEghFx5I2EiG37sQNLbUaBqizPy61VXorPOeL++cg7oUPcrfUOVtTocor/3D38XFIeh
        HUXGVHaoWSANy3gSnCk/VN8eLgO4E79nVRG/Ky9yvxa/AqxvamuC30eJthnA2/U+wTE+norPTWVqs
        9Mc6ru2SySTjvVKHn25BM5JsRzyFhwT7HQhM3xDLGarAwcuMtbsVrWOb9mOVdjDFDCV7KMiZv6BFb
        FE9Kzu5XIIkoXfzQDLZk9y+vJxNh4esUJC7lDSLgh84dKb7YiyTUhtOLiNXfvvZ5pOzv8n9PPmIJu
        IVgK53vA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1Xuh-00D7IS-TP; Mon, 18 Jan 2021 17:02:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/27] mm: Add get_folio
Date:   Mon, 18 Jan 2021 17:01:27 +0000
Message-Id: <20210118170148.3126186-7-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we know we have a folio, we can call get_folio() instead of get_page()
and save the overhead of calling compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4d135b62a2b6..380328930d6c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1192,18 +1192,19 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 }
 
 /* 127: arbitrary random number, small enough to assemble well */
-#define page_ref_zero_or_close_to_overflow(page) \
-	((unsigned int) page_ref_count(page) + 127u <= 127u)
+#define folio_ref_zero_or_close_to_overflow(folio) \
+	((unsigned int) page_ref_count(&folio->page) + 127u <= 127u)
+
+static inline void get_folio(struct folio *folio)
+{
+	/* Getting a page requires an already elevated page->_refcount. */
+	VM_BUG_ON_FOLIO(folio_ref_zero_or_close_to_overflow(folio), folio);
+	page_ref_inc(&folio->page);
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
+	get_folio(page_folio(page));
 }
 
 bool __must_check try_grab_page(struct page *page, unsigned int flags);
-- 
2.29.2

