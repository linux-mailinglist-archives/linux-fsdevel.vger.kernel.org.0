Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4043A7016
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 22:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhFNUTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 16:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbhFNUTi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:19:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E92C0617AF;
        Mon, 14 Jun 2021 13:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TXsh4FqcuWpahP9XDxthp+mcjlyoxQTiGJilDphr8hQ=; b=lXkMjEnQTwC/lUBeNGY+Ln+0P+
        DUbjWK+QH4GMVWmW7J+sJcGRKJe9IQ0aBLTHpmg6Z/kUDF3/sJm31gvKZOK9MCiKQI9DLLZJhs2Jl
        9SaENZ+ZFYUB4K5hn+t+QlaIQFDX1QaFRvR5hGpvEcCuT+04j+kYT5Suqn7rEX1cZODan3G+6FbZI
        PLpsCRX4e2NotSpXThxwfbucfj8/4KqVEhBTcWRmt3Dd88Zawf5F4zmV6QyP3anySefOmNI11IhiA
        w5Df0JQJIFl7ktAghwTv0ydZyhT1jk/az0nDagmgrfpcYPnaLUVDgi8F89H9KE43xrRyQhthiPg3I
        KWHbBgBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lst09-005mtJ-JQ; Mon, 14 Jun 2021 20:16:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v11 03/33] mm: Add folio_pgdat(), folio_zone() and folio_zonenum()
Date:   Mon, 14 Jun 2021 21:14:05 +0100
Message-Id: <20210614201435.1379188-4-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210614201435.1379188-1-willy@infradead.org>
References: <20210614201435.1379188-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are just convenience wrappers for callers with folios; pgdat and
zone can be reached from tail pages as well as head pages.  No change
to generated code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/mm.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 19f2ec1a2221..0432f811f1b5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1145,6 +1145,11 @@ static inline enum zone_type page_zonenum(const struct page *page)
 	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
 }
 
+static inline enum zone_type folio_zonenum(const struct folio *folio)
+{
+	return page_zonenum(&folio->page);
+}
+
 #ifdef CONFIG_ZONE_DEVICE
 static inline bool is_zone_device_page(const struct page *page)
 {
@@ -1560,6 +1565,16 @@ static inline pg_data_t *page_pgdat(const struct page *page)
 	return NODE_DATA(page_to_nid(page));
 }
 
+static inline struct zone *folio_zone(const struct folio *folio)
+{
+	return page_zone(&folio->page);
+}
+
+static inline pg_data_t *folio_pgdat(const struct folio *folio)
+{
+	return page_pgdat(&folio->page);
+}
+
 #ifdef SECTION_IN_PAGE_FLAGS
 static inline void set_page_section(struct page *page, unsigned long section)
 {
-- 
2.30.2

