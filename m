Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDC932E08A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCEETe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhCEETd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:19:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217B8C061574;
        Thu,  4 Mar 2021 20:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=M6kHCP2ErIBVLFqPGPar7eIkGAUP7r+SY6+0x2DcRsk=; b=BtYx3on1gAjsZVKoYT5FUu6v1a
        EM/Rq722gHomS4jffeqmg1qCOPQ3GOB7fJHzuQhCgBrMckl8DVZEtA+XQTEvlXZInbF1+iRJaT6bg
        8JCeAdRuleiE8u0XQtFMkcKSQKQClhQTFCxIEI4kQen8VzaQ+EIkUt8jXUqzew4jEL6NrHfeI1gV1
        mM50ZICpfcjvM15fTiI5Td0yb5iK0naAb+HBVoEqWVIJ3EynFXLoT537u+r6BtjTMOiB4Exd4seWS
        6/z4b9wZZ+HXyla9cicOdUN/ax8VBu5NCCeYG2aFHOxRpVEKfrbEYSFRpbeAIuJfQ6OwkXKxj6qJk
        PJnEd3kQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI1vr-00A3T3-LO; Fri, 05 Mar 2021 04:19:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v4 05/25] mm: Add put_folio
Date:   Fri,  5 Mar 2021 04:18:41 +0000
Message-Id: <20210305041901.2396498-6-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we know we have a folio, we can call put_folio() instead of put_page()
and save the overhead of calling compound_head().  Also skips the
devmap checks.

This commit looks like it should be a no-op, but actually saves 1714 bytes
of text with the distro-derived config that I'm testing.  Some functions
grow a little while others shrink.  I presume the compiler is making
different inlining decisions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/mm.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecfe202aa4ec..30fd431b1b05 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1205,9 +1205,15 @@ static inline __must_check bool try_get_page(struct page *page)
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
@@ -1215,13 +1221,12 @@ static inline void put_page(struct page *page)
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
2.30.0

