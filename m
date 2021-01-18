Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CA42FA794
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407114AbhARRVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393188AbhARRCj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:02:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67595C061757;
        Mon, 18 Jan 2021 09:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pHmMPYJfZBRLbAE614BrSgF4Qt/dpevDIb6z8WYnHzg=; b=upDCq41TAfuJW199l8kNMMsOjq
        VGVd3mp6l0SS6Xm2saByaP4FkNxCxDqC5Te2JUP5F1uY3sZ9vV8GXZaK9kvYzp51TuJTN3Jh8xJ4m
        3hCnkl7bS8m0lOIYzNeVGh3CkCBUGJ29mQpy/Bkpdht7dxfGjPq8K3wlEK6vV+MmRmiR6P20FWusj
        sKW4huCk47QVjjeB9wjTyLbNCQUHRYBByzxIcD15PhqyZ/ly97A25h+BltJpA7JZyrnIVYKHrEBgQ
        euAbCzEymx86TS68eo/aiA1EUFb4JlWrqWB9i8dsyVS1u7jxiIDSHL5aFnnOMgkR6qh1OLwhmk8r4
        uMbgrZQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1Xuc-00D7Hr-ML; Mon, 18 Jan 2021 17:01:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/27] mm/vmstat: Add folio stat wrappers
Date:   Mon, 18 Jan 2021 17:01:24 +0000
Message-Id: <20210118170148.3126186-4-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
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

