Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288773C416D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhGLDNX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGLDNX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:13:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B90C0613DD;
        Sun, 11 Jul 2021 20:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tVb0PJLN8cc5QzY8NlRBA4W55jS9HxayokROUPdtIvA=; b=mX/NIusWApcrjk5nlKwJKpAwQ2
        K+odUk8pyHERflF8iwrMqdZAfGrjKoZXphvYNVEip/IfPJXZu4gCYx7E0ZJevdOve3TGrHDZvFTT0
        JtFocPQ9Jx5AIMUGQIw/cRMPr0mwSW30EU5RoaokRZ9yxQbKjdTQ2BoJMBRQpMfZ7V6XpGVjuSPIF
        6JRnsaWBdBtJAK5J+5j0xLfz0Kxp5AsdAdNzTYRu1Ccw6dy9k1Ia+iDUeWJ45HWEXKKhkaGvNmhP4
        SuxK8ZfMxBe4mUI9E9VOR/ptI1y9+LWm5Iihgim5PNrxC9/rIWO24EHKFYWpduYx7auZfPXyg+JUo
        SrTIYXMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mJp-00Gmpn-3N; Mon, 12 Jul 2021 03:09:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v13 003/137] mm: Add folio_pgdat(), folio_zone() and folio_zonenum()
Date:   Mon, 12 Jul 2021 04:04:47 +0100
Message-Id: <20210712030701.4000097-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
Reviewed-by: David Howells <dhowells@redhat.com>
---
 include/linux/mm.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 054812351960..460e9805dd9f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1143,6 +1143,11 @@ static inline enum zone_type page_zonenum(const struct page *page)
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
@@ -1558,6 +1563,16 @@ static inline pg_data_t *page_pgdat(const struct page *page)
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

