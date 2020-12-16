Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1442DC64F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbgLPSZP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbgLPSZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:25:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB46C0611BB;
        Wed, 16 Dec 2020 10:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=l2yMUgDCI85xqTDbJL6qkzRnWESJ2wANbKuBp7hynpE=; b=N/MwXharVyk8/YOc7Gnjzvatp+
        oAKvIXPmZVOQH06p52yHNS8oPU4kY5thhs5sTkbaPgLlx/tz7uBh7KsM98ZoILRNyU21Fgrit1E6n
        3TfK5cDtNCDS5Dk5kjGUcIn0oBTVvNjYjmD6JFVgbUIYtmTw69cf+P5Z1jjn8H/TNJOR6Nrns4Ilj
        eyWyog1y4+7xgAq7Fvo2l6No/1EXSbCCeFnPZwqTYOFDcqg+Ctzdy7uOvK1UCD3FDWPkZoGDn1pEw
        vKq95ikvtohkTqhWvPEGzxVh/Jhujk0bvt6bbusjsX81ALw+foPjxiTL0gHj0hg6bUkaoO1FJ8XIe
        /GRnrrSA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSb-000761-5u; Wed, 16 Dec 2020 18:23:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/25] mm: Add put_folio
Date:   Wed, 16 Dec 2020 18:23:12 +0000
Message-Id: <20201216182335.27227-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
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
index ed20fd0c6169..a9191dc250a6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1194,9 +1194,15 @@ static inline __must_check bool try_get_page(struct page *page)
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
@@ -1204,13 +1210,12 @@ static inline void put_page(struct page *page)
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

