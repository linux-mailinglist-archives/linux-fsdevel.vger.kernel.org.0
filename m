Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABCE3C631F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbhGLTHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbhGLTHX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:07:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47715C0613DD;
        Mon, 12 Jul 2021 12:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tVb0PJLN8cc5QzY8NlRBA4W55jS9HxayokROUPdtIvA=; b=d/yy51cf6amnoKymBpAU/f6rtp
        dDHeL7gNm+3yylWd7uKt4lgYIahVtiIPhLU3SI9vfBwiqCvdvButjXeM8YUGDdfDfj/v91VEezEmH
        nyhm626PwUIpsDhnZ76gp92uARknhCcLs7d/99W2lLc6Ns2iPWxlq5Qs+PDTsXJeJJZGkabdn0V7v
        61dN7URrq8MiAIPHmQvOzmadR0ChgM6ySlK/uOnnQ56rUn8dbixijgbMQ2bQtLxinQIrAxXCHFBAJ
        l/Pw1fM4VsGm/phNoLPuMEazdQdEq8OsPy+knB8+j49DgmsJsOB8c4tnFgONtniOjFTmAu7aamfEU
        aOahQ/Og==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m31D3-000LC2-Vm; Mon, 12 Jul 2021 19:03:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v13 03/32] mm: Add folio_pgdat(), folio_zone() and folio_zonenum()
Date:   Mon, 12 Jul 2021 20:01:35 +0100
Message-Id: <20210712190204.80979-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712190204.80979-1-willy@infradead.org>
References: <20210712190204.80979-1-willy@infradead.org>
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

