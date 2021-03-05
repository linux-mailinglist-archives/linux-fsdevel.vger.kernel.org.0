Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83DD32E086
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhCEETU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCEETT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:19:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17A3C061574;
        Thu,  4 Mar 2021 20:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TfEJs96Ck13Yfn0mZfn2F+YPOt+7EPnxf8ur6JTtW6I=; b=cRV61d0eP1fedPSGYC6ZnAUwFS
        XtfS+nf5eiaZmnEnJSVbX/ArI+5Jxk4D+PP4MaR41DXmEWpdpey/mm30HlcSeETtWWuYeCA8MLaPg
        vrhI2uhim3+Xmu/JZGTttjrD3I2rzxICJciJ3vB4y25C2Z+aDaRaLkMoxEzThBoiVyY954V/Yzj+V
        BXK5Qtmh7STyqh3UcPJZ5KB7amOvBhsWy/UFdiszD8jv787MW7fjQAn7uYvaCopZwEQK2GMQD/uEc
        7+qkSU7PI4XATdFC1B0rxyMxmhHveknKkQe7TB9YKMeNvgykMpnX8pLipQMskxj/eJ678h2IB4QLx
        MvfEas1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI1vk-00A3Sg-4R; Fri, 05 Mar 2021 04:19:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 03/25] mm/vmstat: Add functions to account folio statistics
Date:   Fri,  5 Mar 2021 04:18:39 +0000
Message-Id: <20210305041901.2396498-4-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
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
 include/linux/vmstat.h | 83 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 506d625163a1..dff5342df07b 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -402,6 +402,54 @@ static inline void drain_zonestat(struct zone *zone,
 			struct per_cpu_pageset *pset) { }
 #endif		/* CONFIG_SMP */
 
+static inline
+void __inc_zone_folio_stat(struct folio *folio, enum zone_stat_item item)
+{
+	__mod_zone_page_state(folio_zone(folio), item, folio_nr_pages(folio));
+}
+
+static inline
+void __dec_zone_folio_stat(struct folio *folio, enum zone_stat_item item)
+{
+	__mod_zone_page_state(folio_zone(folio), item, -folio_nr_pages(folio));
+}
+
+static inline
+void inc_zone_folio_stat(struct folio *folio, enum zone_stat_item item)
+{
+	mod_zone_page_state(folio_zone(folio), item, folio_nr_pages(folio));
+}
+
+static inline
+void dec_zone_folio_stat(struct folio *folio, enum zone_stat_item item)
+{
+	mod_zone_page_state(folio_zone(folio), item, -folio_nr_pages(folio));
+}
+
+static inline
+void __inc_node_folio_stat(struct folio *folio, enum node_stat_item item)
+{
+	__mod_node_page_state(folio_pgdat(folio), item, folio_nr_pages(folio));
+}
+
+static inline
+void __dec_node_folio_stat(struct folio *folio, enum node_stat_item item)
+{
+	__mod_node_page_state(folio_pgdat(folio), item, -folio_nr_pages(folio));
+}
+
+static inline
+void inc_node_folio_stat(struct folio *folio, enum node_stat_item item)
+{
+	mod_node_page_state(folio_pgdat(folio), item, folio_nr_pages(folio));
+}
+
+static inline
+void dec_node_folio_stat(struct folio *folio, enum node_stat_item item)
+{
+	mod_node_page_state(folio_pgdat(folio), item, -folio_nr_pages(folio));
+}
+
 static inline void __mod_zone_freepage_state(struct zone *zone, int nr_pages,
 					     int migratetype)
 {
@@ -536,6 +584,24 @@ static inline void __dec_lruvec_page_state(struct page *page,
 	__mod_lruvec_page_state(page, idx, -1);
 }
 
+static inline void __mod_lruvec_folio_stat(struct folio *folio,
+					   enum node_stat_item idx, int val)
+{
+	__mod_lruvec_page_state(&folio->page, idx, val);
+}
+
+static inline void __inc_lruvec_folio_stat(struct folio *folio,
+					   enum node_stat_item idx)
+{
+	__mod_lruvec_folio_stat(folio, idx, folio_nr_pages(folio));
+}
+
+static inline void __dec_lruvec_folio_stat(struct folio *folio,
+					   enum node_stat_item idx)
+{
+	__mod_lruvec_folio_stat(folio, idx, -folio_nr_pages(folio));
+}
+
 static inline void inc_lruvec_state(struct lruvec *lruvec,
 				    enum node_stat_item idx)
 {
@@ -560,4 +626,21 @@ static inline void dec_lruvec_page_state(struct page *page,
 	mod_lruvec_page_state(page, idx, -1);
 }
 
+static inline void mod_lruvec_folio_stat(struct folio *folio,
+					 enum node_stat_item idx, int val)
+{
+	mod_lruvec_page_state(&folio->page, idx, val);
+}
+
+static inline void inc_lruvec_folio_stat(struct folio *folio,
+					 enum node_stat_item idx)
+{
+	mod_lruvec_folio_stat(folio, idx, folio_nr_pages(folio));
+}
+
+static inline void dec_lruvec_folio_stat(struct folio *folio,
+					 enum node_stat_item idx)
+{
+	mod_lruvec_folio_stat(folio, idx, -folio_nr_pages(folio));
+}
 #endif /* _LINUX_VMSTAT_H */
-- 
2.30.0

