Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A3F3C9685
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 05:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbhGODmu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 23:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhGODmt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:42:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA5BC06175F;
        Wed, 14 Jul 2021 20:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=B8pcrYR+hNLPq7sa1dArlFf92eyhuj070BMxPGyPphc=; b=A00dpqNer+TANE5sSbs0rKjs55
        FaVy+I5QoJC2eBkmbTCR9ZtAwBtE0WmMwV4DTeXv50m8RKBaSmm9duRpIBHe9a5IVYgbsL47LaBfv
        S9X+G+XwfQwMf0sj3SOv3MKnHTtZVFweRUJNdVtS14eHGrabegqjp7lZqRv2Y1dmnkVxY9PpMyYXA
        +TJmgQvYlkePLStwK4ScNlIIEIxPDP3QRTMLFoMO9/fFsfunUg30KxSQ+yMedYdsyFCQJ5RnjdxUL
        P4XPLDiHJkVXJbMhyBDOr5Mu382CVG7Rmnz0WJYoI5PVOVvjb+wt2GqYZmTPso9tbf3ZOsaXN40yg
        wDYOn5hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sCs-002uMs-4Y; Thu, 15 Jul 2021 03:38:48 +0000
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
Subject: [PATCH v14 003/138] mm: Add folio_pgdat(), folio_zone() and folio_zonenum()
Date:   Thu, 15 Jul 2021 04:34:49 +0100
Message-Id: <20210715033704.692967-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
index 5071084a71b9..0e14ac29a3e9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1144,6 +1144,11 @@ static inline enum zone_type page_zonenum(const struct page *page)
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
@@ -1559,6 +1564,16 @@ static inline pg_data_t *page_pgdat(const struct page *page)
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

