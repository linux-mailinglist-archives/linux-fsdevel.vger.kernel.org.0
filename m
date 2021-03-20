Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CEC342B0C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 06:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCTFnH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 01:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhCTFmx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 01:42:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3A1C061762;
        Fri, 19 Mar 2021 22:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dfXfv8hmWSWW+Hl8p1PfiLq67NsbQA2iV31c9ncsY7U=; b=npwd9Hjq07XhTywsV1Cu9F4yBh
        o6W/94AumtMQKBsuMgO7/OolWgBQyOz/yqWReqmjZ8SUkSQsCwkaawF+G69uzu0YE4eAj17MCHqI8
        +OF+OX09t0oGUZMr1b/UuTHUHRtJUHOgqpD4jDT4l26D+Eh8tqA6SiCIW5LNbXIF3m70laXAOH5hR
        q8poJiTOcpkyKrRp+hsMEQn02tgCALGTut3pygxAjl6qAR1iicjckl+iiIeI8qg1zAzk1UUo1OOar
        yPVkQRqi+vH1BI6k9f0dPY+nU4OEYkdIP4zOYnb+l5lQmECZ3FFNewuwrUeQ4uEaUDiGm+AyJi/vi
        kxPiIL0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNUNi-005SaJ-Aa; Sat, 20 Mar 2021 05:42:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v5 14/27] mm/memcg: Add folio wrappers for various functions
Date:   Sat, 20 Mar 2021 05:40:51 +0000
Message-Id: <20210320054104.1300774-15-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210320054104.1300774-1-willy@infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add new wrapper functions folio_memcg(), lock_folio_memcg(),
unlock_folio_memcg() and mem_cgroup_folio_lruvec().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4064c9dda534..493136f495b6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -397,6 +397,11 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
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
@@ -1400,6 +1405,22 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
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

