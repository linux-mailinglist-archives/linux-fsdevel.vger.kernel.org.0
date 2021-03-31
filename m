Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35D43506EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 20:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhCaSyH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 14:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbhCaSxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:53:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC12C061574;
        Wed, 31 Mar 2021 11:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JlA5ruehMK2CGaD5kFtLsiXzEiTkhGCnUfrLrdzu4T4=; b=h62Jc82oYIW/XhdBlBMPDnQPLh
        HkYeoNsCstVcsRipVE3njmaVhyTag8LvQpH143BEYNCf6iidjZOMjKBo1zEksv0wEKp9hFywdestY
        LvpsYXKpQ1nXd2EHU8SX6pDcTa1G0+Xrs0mEkq6t0U8m1v8D8bbp+IBv3EJgGhfgVTBaFvKXkdcTS
        X6AF7wiSI/OCg7Xr60kEJSarOkDCeIoUwpF8fYZZKH9yT818+o+t9o5XAyEhPBsOS/FTRq4U9NtbZ
        8f1w/h3BBoecV2vsnHd1VxdIfbzCjPaF2adlfNen68nGRPlZLRfsBsKHl+1K9M6VbrAHJzQPi5dqE
        w1imIeYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRfxm-004zcv-9W; Wed, 31 Mar 2021 18:53:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v6 15/27] mm/memcg: Add folio wrappers for various functions
Date:   Wed, 31 Mar 2021 19:47:16 +0100
Message-Id: <20210331184728.1188084-16-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210331184728.1188084-1-willy@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add new wrapper functions folio_memcg(), lock_folio_memcg(),
unlock_folio_memcg(), mem_cgroup_folio_lruvec() and
count_memcg_folio_event()

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0e8907957227..d8027831a681 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -456,6 +456,11 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
 		return __page_memcg(page);
 }
 
+static inline struct mem_cgroup *folio_memcg(struct folio *folio)
+{
+	return page_memcg(&folio->page);
+}
+
 /*
  * page_memcg_rcu - locklessly get the memory cgroup associated with a page
  * @page: a pointer to the page struct
@@ -1052,6 +1057,15 @@ static inline void count_memcg_page_event(struct page *page,
 		count_memcg_events(memcg, idx, 1);
 }
 
+static inline void count_memcg_folio_event(struct folio *folio,
+					  enum vm_event_item idx)
+{
+	struct mem_cgroup *memcg = folio_memcg(folio);
+
+	if (memcg)
+		count_memcg_events(memcg, idx, folio_nr_pages(folio));
+}
+
 static inline void count_memcg_event_mm(struct mm_struct *mm,
 					enum vm_event_item idx)
 {
@@ -1473,6 +1487,22 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 }
 #endif /* CONFIG_MEMCG */
 
+static inline void lock_folio_memcg(struct folio *folio)
+{
+	lock_page_memcg(&folio->page);
+}
+
+static inline void unlock_folio_memcg(struct folio *folio)
+{
+	unlock_page_memcg(&folio->page);
+}
+
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
2.30.2

