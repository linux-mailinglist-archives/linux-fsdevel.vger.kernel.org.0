Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978DE3C96FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbhGOEQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhGOEQH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:16:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3771EC06175F;
        Wed, 14 Jul 2021 21:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BdoAHA2ru4kTgi8z9gwqyWzIyxADlec1I5LhK9PXph4=; b=I2QG9LRtXEdKN6mvYhbJAUscJd
        yxeDXtrVw8o9C8PSRv4TPSp0RRmDQBXMtAIVXvvWiW4CdqUIWLVJr/vhsUlFpkCcWltED57tIwpj6
        rXRbQOj9KILnUSq6z9NQq92AHyjKhE8II6SpuRXBvDK0Zulox2y/6LsGOxMJCyB/ck/eect6sNoDT
        Pbn/bDeSKaR/LxH4/2mFrs5hey5YYDvAkknehA0ikq83xTbj6ySazxUhhGNFaJ65brmz8gIxK7dIm
        LdUUt8Txw6h+yRri/4XuEL6CuJg4DlywVv0V+JmGiM2j9BUhkcLmmx4qHgm+W4VD7yz7uuTAthzCH
        RNHhMUnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sj6-002wLu-10; Thu, 15 Jul 2021 04:12:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 044/138] mm/memcg: Convert mem_cgroup_track_foreign_dirty_slowpath() to folio
Date:   Thu, 15 Jul 2021 04:35:30 +0100
Message-Id: <20210715033704.692967-45-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The page was only being used for the memcg and to gather trace
information, so this is a simple conversion.  The only caller of
mem_cgroup_track_foreign_dirty() will be converted to folios in a later
patch, so doing this now makes that patch simpler.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/memcontrol.h       | 7 ++++---
 include/trace/events/writeback.h | 8 ++++----
 mm/memcontrol.c                  | 6 +++---
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d75a708eac13..20084c47d2ca 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1560,17 +1560,18 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 			 unsigned long *pheadroom, unsigned long *pdirty,
 			 unsigned long *pwriteback);
 
-void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
+void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 					     struct bdi_writeback *wb);
 
 static inline void mem_cgroup_track_foreign_dirty(struct page *page,
 						  struct bdi_writeback *wb)
 {
+	struct folio *folio = page_folio(page);
 	if (mem_cgroup_disabled())
 		return;
 
-	if (unlikely(&page_memcg(page)->css != wb->memcg_css))
-		mem_cgroup_track_foreign_dirty_slowpath(page, wb);
+	if (unlikely(&folio_memcg(folio)->css != wb->memcg_css))
+		mem_cgroup_track_foreign_dirty_slowpath(folio, wb);
 }
 
 void mem_cgroup_flush_foreign(struct bdi_writeback *wb);
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 840d1ba84cf5..297871ca0004 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -236,9 +236,9 @@ TRACE_EVENT(inode_switch_wbs,
 
 TRACE_EVENT(track_foreign_dirty,
 
-	TP_PROTO(struct page *page, struct bdi_writeback *wb),
+	TP_PROTO(struct folio *folio, struct bdi_writeback *wb),
 
-	TP_ARGS(page, wb),
+	TP_ARGS(folio, wb),
 
 	TP_STRUCT__entry(
 		__array(char,		name, 32)
@@ -250,7 +250,7 @@ TRACE_EVENT(track_foreign_dirty,
 	),
 
 	TP_fast_assign(
-		struct address_space *mapping = page_mapping(page);
+		struct address_space *mapping = folio_mapping(folio);
 		struct inode *inode = mapping ? mapping->host : NULL;
 
 		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
@@ -258,7 +258,7 @@ TRACE_EVENT(track_foreign_dirty,
 		__entry->ino		= inode ? inode->i_ino : 0;
 		__entry->memcg_id	= wb->memcg_css->id;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
-		__entry->page_cgroup_ino = cgroup_ino(page_memcg(page)->css.cgroup);
+		__entry->page_cgroup_ino = cgroup_ino(folio_memcg(folio)->css.cgroup);
 	),
 
 	TP_printk("bdi %s[%llu]: ino=%lu memcg_id=%u cgroup_ino=%lu page_cgroup_ino=%lu",
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 92bbced86bdb..96c34357fbca 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4571,17 +4571,17 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
  * As being wrong occasionally doesn't matter, updates and accesses to the
  * records are lockless and racy.
  */
-void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
+void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 					     struct bdi_writeback *wb)
 {
-	struct mem_cgroup *memcg = page_memcg(page);
+	struct mem_cgroup *memcg = folio_memcg(folio);
 	struct memcg_cgwb_frn *frn;
 	u64 now = get_jiffies_64();
 	u64 oldest_at = now;
 	int oldest = -1;
 	int i;
 
-	trace_track_foreign_dirty(page, wb);
+	trace_track_foreign_dirty(folio, wb);
 
 	/*
 	 * Pick the slot to use.  If there is already a slot for @wb, keep
-- 
2.30.2

