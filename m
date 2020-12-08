Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950A22D3399
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 21:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgLHUWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 15:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgLHUWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:22:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D34C0611D0;
        Tue,  8 Dec 2020 12:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OBRZ5khcW9DTJib4sejfdcqxs/Ms3DkVSu08A7XMxMo=; b=e5HzxTpqSfCxo8BAzX4WhMvbOc
        CMQJ2Cs/JtSeAJJqIQXMhuK82i/EmNbQLFVI3DD41borkTuwJJnk9GOw3lSYQgWfd5dKUXd9T5kUh
        xX0V0X6+TgsZvIsIr2lRh1N/LNBIqzZa3kNL/O+g5HmWLExgD29KorE3blrRtJH6bbpTeethEZQT3
        B22ZuGbOv00dFtfc+YlXSJSwVyL+Xku4NwHiFqob1SCTlsPx9mHlVrVLJaRkAEBHyLQUaXxu42WAN
        pGmBCOpNRDfVwazXrK7rxjOrMeqY/RXP8d+jyj57whX8PzZUwrxs5d4oU+eV89AZey3wEqIyWXwOU
        6485/XNg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmiwr-00050H-SY; Tue, 08 Dec 2020 19:46:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 02/11] mm: Add put_folio
Date:   Tue,  8 Dec 2020 19:46:44 +0000
Message-Id: <20201208194653.19180-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201208194653.19180-1-willy@infradead.org>
References: <20201208194653.19180-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we know we have a folio, we can call put_folio() instead of put_page()
and save the overhead of calling compound_head().  Also skips the
devmap checks.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7db9a10f084b..80d38cc9561c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1189,9 +1189,15 @@ static inline __must_check bool try_get_page(struct page *page)
 	return true;
 }
 
+static inline void put_folio(struct folio *folio)
+{
+	if (put_page_testzero(&folio->page))
+		__put_page(&folio->page);
+}
+
 static inline void put_page(struct page *page)
 {
-	page = compound_head(page);
+	struct folio *folio = page_folio(page);
 
 	/*
 	 * For devmap managed pages we need to catch refcount transition from
@@ -1199,13 +1205,12 @@ static inline void put_page(struct page *page)
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
+	put_folio(folio);
 }
 
 /*
-- 
2.29.2

