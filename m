Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD0C342AFE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 06:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCTFmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 01:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhCTFmH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 01:42:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C44DC061762;
        Fri, 19 Mar 2021 22:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sKdiLShqM4pfbmiBvyCzfayGAMK3XUXmIyOzYWIGXNo=; b=YG8P3ln1vJQeY/S0Cljbd/dMK0
        3prCT1rnYK/84KUpkP6ioSwPFL/NOohjafE6CcM58Hu1wmGYCv/5ijdmdo3bMtQpcMZAAKOfLmqQP
        it0pECz5YXR402Foor2coWCWxNOCzU46kUqPdLXUcbfVZKJ3lFWLikz6WkUPY04VisyeZWJqk6+AV
        R2fUCBJyaoidRQf50cJr7R8wUcVjjuybZVDEJJx/k7BAhdSEH3tQ+ht9CVeU1F3qsE91eyf9tH0le
        y1YyAKxn+b9ilRaGdDvkRfmdKQAvHGVz/69cPYiox9UR7ijvDtGZvteZ+tgkURelpcFexBtNzNLB6
        DFoMY1hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNUMx-005SU4-EH; Sat, 20 Mar 2021 05:41:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v5 06/27] mm/vmstat: Add functions to account folio statistics
Date:   Sat, 20 Mar 2021 05:40:43 +0000
Message-Id: <20210320054104.1300774-7-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210320054104.1300774-1-willy@infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow page counters to be more readily modified by callers which have
a folio.  Name these wrappers with 'stat' instead of 'state' as requested
by Linus here:
https://lore.kernel.org/linux-mm/CAHk-=wj847SudR-kt+46fT3+xFFgiwpgThvm7DJWGdi4cVrbnQ@mail.gmail.com/

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/vmstat.h | 107 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 3299cd69e4ca..d287d7c31b8f 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -402,6 +402,78 @@ static inline void drain_zonestat(struct zone *zone,
 			struct per_cpu_pageset *pset) { }
 #endif		/* CONFIG_SMP */
 
+static inline void __zone_stat_mod_folio(struct folio *folio,
+		enum zone_stat_item item, long nr)
+{
+	__mod_zone_page_state(folio_zone(folio), item, nr);
+}
+
+static inline void __zone_stat_add_folio(struct folio *folio,
+		enum zone_stat_item item)
+{
+	__mod_zone_page_state(folio_zone(folio), item, folio_nr_pages(folio));
+}
+
+static inline void __zone_stat_sub_folio(struct folio *folio,
+		enum zone_stat_item item)
+{
+	__mod_zone_page_state(folio_zone(folio), item, -folio_nr_pages(folio));
+}
+
+static inline void zone_stat_mod_folio(struct folio *folio,
+		enum zone_stat_item item, long nr)
+{
+	mod_zone_page_state(folio_zone(folio), item, nr);
+}
+
+static inline void zone_stat_add_folio(struct folio *folio,
+		enum zone_stat_item item)
+{
+	mod_zone_page_state(folio_zone(folio), item, folio_nr_pages(folio));
+}
+
+static inline void zone_stat_sub_folio(struct folio *folio,
+		enum zone_stat_item item)
+{
+	mod_zone_page_state(folio_zone(folio), item, -folio_nr_pages(folio));
+}
+
+static inline void __node_stat_mod_folio(struct folio *folio,
+		enum node_stat_item item, long nr)
+{
+	__mod_node_page_state(folio_pgdat(folio), item, nr);
+}
+
+static inline void __node_stat_add_folio(struct folio *folio,
+		enum node_stat_item item)
+{
+	__mod_node_page_state(folio_pgdat(folio), item, folio_nr_pages(folio));
+}
+
+static inline void __node_stat_sub_folio(struct folio *folio,
+		enum node_stat_item item)
+{
+	__mod_node_page_state(folio_pgdat(folio), item, -folio_nr_pages(folio));
+}
+
+static inline void node_stat_mod_folio(struct folio *folio,
+		enum node_stat_item item, long nr)
+{
+	mod_node_page_state(folio_pgdat(folio), item, nr);
+}
+
+static inline void node_stat_add_folio(struct folio *folio,
+		enum node_stat_item item)
+{
+	mod_node_page_state(folio_pgdat(folio), item, folio_nr_pages(folio));
+}
+
+static inline void node_stat_sub_folio(struct folio *folio,
+		enum node_stat_item item)
+{
+	mod_node_page_state(folio_pgdat(folio), item, -folio_nr_pages(folio));
+}
+
 static inline void __mod_zone_freepage_state(struct zone *zone, int nr_pages,
 					     int migratetype)
 {
@@ -530,6 +602,24 @@ static inline void __dec_lruvec_page_state(struct page *page,
 	__mod_lruvec_page_state(page, idx, -1);
 }
 
+static inline void __lruvec_stat_mod_folio(struct folio *folio,
+					   enum node_stat_item idx, int val)
+{
+	__mod_lruvec_page_state(&folio->page, idx, val);
+}
+
+static inline void __lruvec_stat_add_folio(struct folio *folio,
+					   enum node_stat_item idx)
+{
+	__lruvec_stat_mod_folio(folio, idx, folio_nr_pages(folio));
+}
+
+static inline void __lruvec_stat_sub_folio(struct folio *folio,
+					   enum node_stat_item idx)
+{
+	__lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
+}
+
 static inline void inc_lruvec_page_state(struct page *page,
 					 enum node_stat_item idx)
 {
@@ -542,4 +632,21 @@ static inline void dec_lruvec_page_state(struct page *page,
 	mod_lruvec_page_state(page, idx, -1);
 }
 
+static inline void lruvec_stat_mod_folio(struct folio *folio,
+					 enum node_stat_item idx, int val)
+{
+	mod_lruvec_page_state(&folio->page, idx, val);
+}
+
+static inline void lruvec_stat_add_folio(struct folio *folio,
+					 enum node_stat_item idx)
+{
+	lruvec_stat_mod_folio(folio, idx, folio_nr_pages(folio));
+}
+
+static inline void lruvec_stat_sub_folio(struct folio *folio,
+					 enum node_stat_item idx)
+{
+	lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
+}
 #endif /* _LINUX_VMSTAT_H */
-- 
2.30.2

