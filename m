Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71B1411183
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 11:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhITJEj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 05:04:39 -0400
Received: from outbound-smtp55.blacknight.com ([46.22.136.239]:52745 "EHLO
        outbound-smtp55.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236070AbhITJEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:04:34 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id 4C867FBD7E
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Sep 2021 09:55:09 +0100 (IST)
Received: (qmail 27671 invoked from network); 20 Sep 2021 08:55:09 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 20 Sep 2021 08:55:08 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     NeilBrown <neilb@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/5] mm/vmscan: Throttle reclaim and compaction when too may pages are isolated
Date:   Mon, 20 Sep 2021 09:54:33 +0100
Message-Id: <20210920085436.20939-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210920085436.20939-1-mgorman@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Page reclaim throttles on congestion if too many parallel reclaim instances
have isolated too many pages. This makes no sense, excessive parallelisation
has nothing to do with writeback or congestion.

This patch creates an additional workqueue to sleep on when too many
pages are isolated. The throttled tasks are woken when the number
of isolated pages is reduced or a timeout occurs. There may be
some false positive wakeups for GFP_NOIO/GFP_NOFS callers but
the tasks will throttle again if necessary.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mmzone.h        |  4 +++-
 include/trace/events/vmscan.h |  4 +++-
 mm/compaction.c               |  2 +-
 mm/internal.h                 |  2 ++
 mm/page_alloc.c               |  6 +++++-
 mm/vmscan.c                   | 22 ++++++++++++++++------
 6 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ef0a63ebd21d..ca65d6a64bdd 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -275,6 +275,8 @@ enum lru_list {
 
 enum vmscan_throttle_state {
 	VMSCAN_THROTTLE_WRITEBACK,
+	VMSCAN_THROTTLE_ISOLATED,
+	NR_VMSCAN_THROTTLE,
 };
 
 #define for_each_lru(lru) for (lru = 0; lru < NR_LRU_LISTS; lru++)
@@ -846,7 +848,7 @@ typedef struct pglist_data {
 	int node_id;
 	wait_queue_head_t kswapd_wait;
 	wait_queue_head_t pfmemalloc_wait;
-	wait_queue_head_t reclaim_wait;	/* wq for throttling reclaim */
+	wait_queue_head_t reclaim_wait[NR_VMSCAN_THROTTLE];
 	atomic_t nr_reclaim_throttled;	/* nr of throtted tasks */
 	unsigned long nr_reclaim_start;	/* nr pages written while throttled
 					 * when throttling started. */
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index c317f9fe0d17..d4905bd9e9c4 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -28,10 +28,12 @@
 		) : "RECLAIM_WB_NONE"
 
 #define _VMSCAN_THROTTLE_WRITEBACK	(1 << VMSCAN_THROTTLE_WRITEBACK)
+#define _VMSCAN_THROTTLE_ISOLATED	(1 << VMSCAN_THROTTLE_ISOLATED)
 
 #define show_throttle_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",					\
-		{_VMSCAN_THROTTLE_WRITEBACK,	"VMSCAN_THROTTLE_WRITEBACK"}	\
+		{_VMSCAN_THROTTLE_WRITEBACK,	"VMSCAN_THROTTLE_WRITEBACK"},	\
+		{_VMSCAN_THROTTLE_ISOLATED,	"VMSCAN_THROTTLE_ISOLATED"}	\
 		) : "VMSCAN_THROTTLE_NONE"
 
 
diff --git a/mm/compaction.c b/mm/compaction.c
index bfc93da1c2c7..221c9c10ad7e 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -822,7 +822,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (cc->mode == MIGRATE_ASYNC)
 			return -EAGAIN;
 
-		congestion_wait(BLK_RW_ASYNC, HZ/10);
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED, HZ/10);
 
 		if (fatal_signal_pending(current))
 			return -EINTR;
diff --git a/mm/internal.h b/mm/internal.h
index e25b3686bfab..e6cd22fb5a43 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -118,6 +118,8 @@ extern unsigned long highest_memmap_pfn;
  */
 extern int isolate_lru_page(struct page *page);
 extern void putback_lru_page(struct page *page);
+extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
+								long timeout);
 
 /*
  * in mm/rmap.c:
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d849ddfc1e51..78e538067651 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7389,6 +7389,8 @@ static void pgdat_init_kcompactd(struct pglist_data *pgdat) {}
 
 static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 {
+	int i;
+
 	pgdat_resize_init(pgdat);
 
 	pgdat_init_split_queue(pgdat);
@@ -7396,7 +7398,9 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 
 	init_waitqueue_head(&pgdat->kswapd_wait);
 	init_waitqueue_head(&pgdat->pfmemalloc_wait);
-	init_waitqueue_head(&pgdat->reclaim_wait);
+
+	for (i = 0; i < NR_VMSCAN_THROTTLE; i++)
+		init_waitqueue_head(&pgdat->reclaim_wait[i]);
 
 	pgdat_page_ext_init(pgdat);
 	lruvec_init(&pgdat->__lruvec);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b58ea0b13286..eb81dcac15b2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1006,11 +1006,10 @@ static void handle_write_error(struct address_space *mapping,
 	unlock_page(page);
 }
 
-static void
-reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
+void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
 							long timeout)
 {
-	wait_queue_head_t *wqh = &pgdat->reclaim_wait;
+	wait_queue_head_t *wqh = &pgdat->reclaim_wait[reason];
 	unsigned long start = jiffies;
 	long ret;
 	DEFINE_WAIT(wait);
@@ -1044,7 +1043,7 @@ void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page)
 		READ_ONCE(pgdat->nr_reclaim_start);
 
 	if (nr_written > SWAP_CLUSTER_MAX * nr_throttled)
-		wake_up_interruptible_all(&pgdat->reclaim_wait);
+		wake_up_interruptible_all(&pgdat->reclaim_wait[VMSCAN_THROTTLE_WRITEBACK]);
 }
 
 /* possible outcome of pageout() */
@@ -2159,6 +2158,7 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
 		struct scan_control *sc)
 {
 	unsigned long inactive, isolated;
+	bool too_many;
 
 	if (current_is_kswapd())
 		return 0;
@@ -2182,6 +2182,17 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
 	if ((sc->gfp_mask & (__GFP_IO | __GFP_FS)) == (__GFP_IO | __GFP_FS))
 		inactive >>= 3;
 
+	too_many = isolated > inactive;
+
+	/* Wake up tasks throttled due to too_many_isolated. */
+	if (!too_many) {
+		wait_queue_head_t *wqh;
+
+		wqh = &pgdat->reclaim_wait[VMSCAN_THROTTLE_ISOLATED];
+		if (waitqueue_active(wqh))
+			wake_up_interruptible_all(wqh);
+	}
+
 	return isolated > inactive;
 }
 
@@ -2291,8 +2302,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 			return 0;
 
 		/* wait a bit for the reclaimer. */
-		msleep(100);
-		stalled = true;
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED, HZ/10);
 
 		/* We are about to die and free our memory. Return now. */
 		if (fatal_signal_pending(current))
-- 
2.31.1

