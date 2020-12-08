Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8B42D33A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 21:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgLHUWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 15:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbgLHUWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:22:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C2BC0611C5;
        Tue,  8 Dec 2020 12:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Zgk3uniXZHMKVYayYIMFcPF5p6Rw4gFHSO/CHoSUCok=; b=NqZO69OQznUEUwJBcNulHAJYsw
        LOy/OrRJNK+7F7WWhejVoD3LMVv1Ie8o6d59//iJ9605oRObFWGJRK+bGuwK49+Rocv78u9UhML/l
        b7wFc9aEcvEynjrhFqfuUwLQogSxkTmslcQxgNG9WMC5uQGjRllyWU32xmIPKb9w11BI75yEApUGK
        DbSZ1pDpRpb6kTc4SprKCXdfDjICcEOElFQdPoluvSawqDcm7oaa3YZgdO3vH+zCSve9a+ooiSR8g
        yoHK2Ak4eD+y42KipwScwZQFYI+cH4qbHJzbt85qOmLuWdwFfj0hUESNFy5MfEt+Op1h8hCCy5GjJ
        FJxIuKhg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmiws-00050P-8R; Tue, 08 Dec 2020 19:46:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/11] mm: Add get_folio
Date:   Tue,  8 Dec 2020 19:46:45 +0000
Message-Id: <20201208194653.19180-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201208194653.19180-1-willy@infradead.org>
References: <20201208194653.19180-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we know we have a folio, we can call get_folio() instead of get_page()
and save the overhead of calling compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 80d38cc9561c..32ac5c14097d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1167,15 +1167,17 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 #define page_ref_zero_or_close_to_overflow(page) \
 	((unsigned int) page_ref_count(page) + 127u <= 127u)
 
+static inline void get_folio(struct folio *folio)
+{
+	/* Getting a page requires an already elevated page->_refcount. */
+	VM_BUG_ON_PAGE(page_ref_zero_or_close_to_overflow(&folio->page),
+			&folio->page);
+	page_ref_inc(&folio->page);
+}
+
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

