Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5292FA6FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406870AbhARRD3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406854AbhARRDU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:03:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCB6C0613CF;
        Mon, 18 Jan 2021 09:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tz7wOz4RYnvira2KM0oAvqe1K89FuiXPaOsClj1QfaY=; b=UdiLz5uCBA35aOz3zxtIadKfF3
        Es7l9PkXjAj1LOxpxGbBBaiKCH9ahgv7KikSm97OyOo4w+AIVcdFobqjPPIQ3HgV5BinxNBF/7lyC
        4IN83JD3apatXeC4EfE73qjQcjQn5nZzPIFWHPtA8O+rUqfI7MOm/qb+RA7ojy10bnNS8eXFGRQI2
        VMhCa47ifUtCbYUlvRXSNGXL8Tp/maWjVsFpItTLvOPvFncvNQl/dDW3th1N3jdLxLWoqKdCeir/u
        SbGFIqBbEyfjPx7UrrJ39cMjSD2+BJh3XTBwPu6NPRCTVmAdenQ30pCnY4Mwr8tdz/WOOmbVwW1rO
        xltHLlmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1Xug-00D7II-HS; Mon, 18 Jan 2021 17:01:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/27] mm: Add put_folio
Date:   Mon, 18 Jan 2021 17:01:26 +0000
Message-Id: <20210118170148.3126186-6-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
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
index 5b071c226fd6..4d135b62a2b6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1217,9 +1217,15 @@ static inline __must_check bool try_get_page(struct page *page)
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
@@ -1227,13 +1233,12 @@ static inline void put_page(struct page *page)
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

