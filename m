Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8502DC640
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgLPSZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730428AbgLPSY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:24:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DA3C061285;
        Wed, 16 Dec 2020 10:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OlRS9lx7lNND7A1m3ILFo70Suk24v9UQeorfTiAX4i0=; b=bJ+rQJJByhvyzull344NyNGyXE
        m8z07AixUU9emwwkkl9894o7Qgsx5c3cxoaE/R4bmqTEVD8gN/RdypHQ2dc/XdidkG4J8UT2/82jY
        gGvAG/xKQU8Aga2O8mdb4bwfAiJiQbMn8dGdxABi2QavHhnfKrjJOmXh/E6leD6w7x3GXrQ89RWh8
        /TmqVM39uMjbeKWeiqWwiCGynfLF6u4CyBwYk9NGq1tOmDsYVROjfHvw7RPZYqPI4Y3fPwedPNFvw
        6+UV7tLpDsemZHRVu420e1IspNZmrNoK/xALG2vTftXBUCTUcVhzH2+MXAIr3aAPbYDw+ZsFxvKTx
        O6NzZJ1g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSc-00076g-IH; Wed, 16 Dec 2020 18:23:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/25] mm: Add __alloc_folio_node and alloc_folio
Date:   Wed, 16 Dec 2020 18:23:18 +0000
Message-Id: <20201216182335.27227-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These wrappers are mostly for typesafety, but they also ensure that
the page allocator allocates a compound page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/gfp.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 53caa9846854..9e416efb4ff8 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -524,6 +524,12 @@ __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
 	return __alloc_pages(gfp_mask, order, nid);
 }
 
+static inline
+struct folio *__alloc_folio_node(int nid, gfp_t gfp, unsigned int order)
+{
+	return (struct folio *)__alloc_pages_node(nid, gfp | __GFP_COMP, order);
+}
+
 /*
  * Allocate pages, preferring the node given as nid. When nid == NUMA_NO_NODE,
  * prefer the current CPU's closest node. Otherwise node must be valid and
@@ -565,6 +571,11 @@ static inline struct page *alloc_pages(gfp_t gfp_mask, unsigned int order)
 #define alloc_page_vma(gfp_mask, vma, addr)			\
 	alloc_pages_vma(gfp_mask, 0, vma, addr, numa_node_id(), false)
 
+static inline struct folio *alloc_folio(gfp_t gfp, unsigned int order)
+{
+	return (struct folio *)alloc_pages(gfp | __GFP_COMP, order);
+}
+
 extern unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order);
 extern unsigned long get_zeroed_page(gfp_t gfp_mask);
 
-- 
2.29.2

