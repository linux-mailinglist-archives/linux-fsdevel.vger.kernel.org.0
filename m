Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8800D32E0A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhCEEXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhCEEXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:23:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EF1C061574;
        Thu,  4 Mar 2021 20:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OeuwNxzVk52kWY8FtpOwc6yIjdYdkVvfN03G7e/qaqE=; b=F8xZYKPdFD5KN2VsEC1HcYRhhR
        ja3lBgAfbAoA0uq72SIm73VsH2GoLB3JKjH4mIQD4TwyYcoUZUFMR4cetnM/J22qvf/CH8bzj6Vw9
        uAxTMANRs47KrtVzL63x7NhKoRYjCaQoYClE2xoL/3/9U9nP50zK8w7v8Kz08d19PwrgDoc5aZ5KV
        droHRWOOqMvgGxhuA0aU7mIqlkYM21pvUlxPnOV8f1Gjf+8ruDHzSlmr9Dzx8FwjyysJUNThaxjrc
        +xBaz832GU4n63hF/x3pY1vz4vhrR25O929eafuB7yLOAjTX/cxKCB6zGkuz+RglmxfDv0i+w2qdt
        yI+KO2XA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI1ya-00A3i5-2g; Fri, 05 Mar 2021 04:22:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 11/25] mm/memcg: Add folio wrappers for various memcontrol functions
Date:   Fri,  5 Mar 2021 04:18:47 +0000
Message-Id: <20210305041901.2396498-12-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add new functions folio_memcg(), lock_folio_memcg(),
unlock_folio_memcg() and mem_cgroup_folio_lruvec().  These will
all be used by other functions later.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e6dc793d587d..564ce61319d4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -383,6 +383,11 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
 	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
 
+static inline struct mem_cgroup *folio_memcg(struct folio *folio)
+{
+	return page_memcg(&folio->page);
+}
+
 /*
  * page_memcg_rcu - locklessly get the memory cgroup associated with a page
  * @page: a pointer to the page struct
@@ -871,6 +876,16 @@ struct mem_cgroup *lock_page_memcg(struct page *page);
 void __unlock_page_memcg(struct mem_cgroup *memcg);
 void unlock_page_memcg(struct page *page);
 
+static inline struct mem_cgroup *lock_folio_memcg(struct folio *folio)
+{
+	return lock_page_memcg(&folio->page);
+}
+
+static inline void unlock_folio_memcg(struct folio *folio)
+{
+	unlock_page_memcg(&folio->page);
+}
+
 /*
  * idx can be of type enum memcg_stat_item or node_stat_item.
  * Keep in sync with memcg_exact_page_state().
@@ -1291,6 +1306,11 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
 }
 
+static inline struct mem_cgroup *lock_folio_memcg(struct folio *folio)
+{
+	return NULL;
+}
+
 static inline struct mem_cgroup *lock_page_memcg(struct page *page)
 {
 	return NULL;
@@ -1300,6 +1320,10 @@ static inline void __unlock_page_memcg(struct mem_cgroup *memcg)
 {
 }
 
+static inline void unlock_folio_memcg(struct folio *folio)
+{
+}
+
 static inline void unlock_page_memcg(struct page *page)
 {
 }
@@ -1431,6 +1455,12 @@ static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
 }
 #endif /* CONFIG_MEMCG */
 
+static inline struct lruvec *mem_cgroup_folio_lruvec(struct folio *folio,
+						    struct pglist_data *pgdat)
+{
+	return mem_cgroup_page_lruvec(&folio->page, pgdat);
+}
+
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
 {
 	__mod_lruvec_kmem_state(p, idx, 1);
-- 
2.30.0

