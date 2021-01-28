Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B25B306E10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhA1HE5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhA1HEx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:04:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB8DC061756;
        Wed, 27 Jan 2021 23:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pHmMPYJfZBRLbAE614BrSgF4Qt/dpevDIb6z8WYnHzg=; b=bFVpzXOZcQmefDQap7PvwUAkLl
        WMLUcdrQNyxBidm2C0IgO+a7I0XWHj2tSfdmFWni9wtnMIZqMaGzXkbASX9I75ZS6+0a3rhSyZGtq
        qSBlxjD3klpeud5Ghl83QF+M33Sa58sdXnn8E/7JHbZjX8UjxZO/FVnaBhAaFmpnfHSXxj3poX9R/
        Jq4d0enFUE2kSRwkS7s0+Q6YA40kI+UR5KmJGB4J9d39ORTpegSxIZnko9Nowo8dydYBnKZeqP/zi
        8oU2wBa6lmowPJGHhJA0IQO7rvM/ABhinO8DtRnXLUK+6lOLnQ3YRj6Nioia8Oou7gjWz2s130Bd4
        J2kODcAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51Ld-00846D-OP; Thu, 28 Jan 2021 07:04:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/25] mm/vmstat: Add folio stat wrappers
Date:   Thu, 28 Jan 2021 07:03:42 +0000
Message-Id: <20210128070404.1922318-4-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
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
 include/linux/vmstat.h | 60 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 773135fc6e19..3c3373c2c3c2 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -396,6 +396,54 @@ static inline void drain_zonestat(struct zone *zone,
 			struct per_cpu_pageset *pset) { }
 #endif		/* CONFIG_SMP */
 
+static inline
+void __inc_zone_folio_stat(struct folio *folio, enum zone_stat_item item)
+{
+	__inc_zone_page_state(&folio->page, item);
+}
+
+static inline
+void __dec_zone_folio_stat(struct folio *folio, enum zone_stat_item item)
+{
+	__dec_zone_page_state(&folio->page, item);
+}
+
+static inline
+void inc_zone_folio_stat(struct folio *folio, enum zone_stat_item item)
+{
+	inc_zone_page_state(&folio->page, item);
+}
+
+static inline
+void dec_zone_folio_stat(struct folio *folio, enum zone_stat_item item)
+{
+	dec_zone_page_state(&folio->page, item);
+}
+
+static inline
+void __inc_node_folio_stat(struct folio *folio, enum node_stat_item item)
+{
+	__inc_node_page_state(&folio->page, item);
+}
+
+static inline
+void __dec_node_folio_stat(struct folio *folio, enum node_stat_item item)
+{
+	__dec_node_page_state(&folio->page, item);
+}
+
+static inline
+void inc_node_folio_stat(struct folio *folio, enum node_stat_item item)
+{
+	inc_node_page_state(&folio->page, item);
+}
+
+static inline
+void dec_node_folio_stat(struct folio *folio, enum node_stat_item item)
+{
+	dec_node_page_state(&folio->page, item);
+}
+
 static inline void __mod_zone_freepage_state(struct zone *zone, int nr_pages,
 					     int migratetype)
 {
@@ -530,6 +578,18 @@ static inline void __dec_lruvec_page_state(struct page *page,
 	__mod_lruvec_page_state(page, idx, -1);
 }
 
+static inline void __inc_lruvec_folio_stat(struct folio *folio,
+					   enum node_stat_item idx)
+{
+	__mod_lruvec_page_state(&folio->page, idx, 1);
+}
+
+static inline void __dec_lruvec_folio_stat(struct folio *folio,
+					   enum node_stat_item idx)
+{
+	__mod_lruvec_page_state(&folio->page, idx, -1);
+}
+
 static inline void inc_lruvec_state(struct lruvec *lruvec,
 				    enum node_stat_item idx)
 {
-- 
2.29.2

