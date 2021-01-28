Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4ED306E1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhA1HGG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhA1HFb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:05:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960F8C061786;
        Wed, 27 Jan 2021 23:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=O+SOh6FjYUdwemBXkbtGC6Ng+dRvNnKO/x3/zt96gdU=; b=oePg0t8HDrqe/OjyR+D1O/ahmK
        PjT2A55vy4O3Ax4Y9PYxeWbb0ry/DE1PHKlJ77BC6s5KJb5xGbSxTMpX7x7PmtV5/xkK8MLH/ILse
        sWBfKCgs0xEuRIxBJbj2MGk0OeqQVboeLTLkrKHgXc6kX+udgs60UZHc055dHY/v0B29mhFQuNXnE
        d/yV5ZvVXinDhnEKRziprtvLxNH9XAI5QnDvPVqR05w7ThEf9972024DJFTR0Bt9z1aJl4nZuFvXn
        Hod26d5dGs5nIXue7xtNizAOoeeRlSD8uYCUuNNTaepQ6hsDfqHJUv4+9oHbSVKdWxPZKeQ+k7nHZ
        wgNsa0Bw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51Lj-00847E-OA; Thu, 28 Jan 2021 07:04:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/25] mm: Add get_folio
Date:   Thu, 28 Jan 2021 07:03:45 +0000
Message-Id: <20210128070404.1922318-7-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
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
index 873d649107ba..d71c5776b571 100644
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

