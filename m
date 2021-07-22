Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE883D2BE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 20:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhGVRqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 13:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhGVRp7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 13:45:59 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C828C06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jul 2021 11:26:34 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id g14-20020a17090a4b0eb029017395ea5199so353854pjh.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jul 2021 11:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zdafpjZOpX7w6ukm7UkyAJ9U3xYdHtSO79XymBUPu/o=;
        b=sdJPsNKSHYFbC/G+xIVl3Qk4+Rvo57mP9IEXixCOWBzjsFotznwfryTn0zYl4yGHpT
         5FbXMLAs09OWq4xdRxZEWNwM37C7Yfl0z+VPM7fkn95Nvhi0H/e7MguHjswI8IY9Mp7G
         S6uyExEloYAuxSMXUTRs7RX59i0LVbF7Y35beGZ/Cq6/wSnj/Bp2XIkL3GESUE28Aunf
         KymWbsI5an9Me7Ud4ap2MSa3GHzDYoWngDnUwCY+tiKKQooheZHW4YdNkkQqGdw3zMrw
         0j77ZArAzNLojl5RKH3amMWjXtdz+m2PmxAghXCgrthIgKOW1jpZ2r9FucoCbdjaNPhi
         DxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zdafpjZOpX7w6ukm7UkyAJ9U3xYdHtSO79XymBUPu/o=;
        b=LUQPgharNv1x9Vykg1fj19gjV7UryF7RR0xCD1N/UWte4+S6WstMfaVrPCmAZjKJ+v
         RWKVtd7Vznf5EJCdvihU7zrnv751k+IIrA/QDHKe5RhqgeYHmtHPMENpA48yuLDyZKON
         nTi9KcnTsR8Ff7bM9MVYWtttRZXr0JHX9uNqcL06dXXuMVRt6snozYpzxe3UxCdWRVqj
         DUVmQOvh+dbLJjJJdUNNwtDtd+4XLY/DsuEUv1ynS6KeO0x00DjsHSCG9+qDcKTh8Tvt
         mtPlyqDm3wMODqv8z4yKAWMtAgBTgEV21u8iWcLo+EjX9CSEkULipznTuxKdRSFJdGE0
         QteA==
X-Gm-Message-State: AOAM531GiKfU1J4DIUAZljet0B+ZQHr9U/iEMC6HTyJVjUn/rFuZKxey
        Q64o5HckbB5dhFVNTjJmZ1ks0jRQlL2IZg==
X-Google-Smtp-Source: ABdhPJwcAqY66M07KTVd1PIwkXpHctb2IIw+Mqa4e3ZiMuTmqXewQLqvt4qbhgjgAWx4ur65ahffx9kXqjiLIQ==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:eee8:d6f7:9645:48ee])
 (user=shakeelb job=sendgmr) by 2002:a63:5118:: with SMTP id
 f24mr1257023pgb.34.1626978393555; Thu, 22 Jul 2021 11:26:33 -0700 (PDT)
Date:   Thu, 22 Jul 2021 11:26:27 -0700
Message-Id: <20210722182627.2267368-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH] writeback: memcg: simplify cgroup_writeback_by_id
From:   Shakeel Butt <shakeelb@google.com>
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Jan Kara <jack@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently cgroup_writeback_by_id calls mem_cgroup_wb_stats() to get
dirty pages for a memcg. However mem_cgroup_wb_stats() does a lot more
than just get the number of dirty pages. Just directly get the number of
dirty pages instead of calling mem_cgroup_wb_stats(). Also
cgroup_writeback_by_id() is only called for best-effort dirty flushing,
so remove the unused 'nr' parameter and no need to explicitly flush
memcg stats.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 fs/fs-writeback.c          | 20 +++++++++-----------
 include/linux/memcontrol.h | 15 +++++++++++++++
 include/linux/writeback.h  |  2 +-
 mm/memcontrol.c            | 13 +------------
 4 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 867984e778c3..35894a2dba75 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1039,20 +1039,20 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
  * cgroup_writeback_by_id - initiate cgroup writeback from bdi and memcg IDs
  * @bdi_id: target bdi id
  * @memcg_id: target memcg css id
- * @nr: number of pages to write, 0 for best-effort dirty flushing
  * @reason: reason why some writeback work initiated
  * @done: target wb_completion
  *
  * Initiate flush of the bdi_writeback identified by @bdi_id and @memcg_id
  * with the specified parameters.
  */
-int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr,
+int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 			   enum wb_reason reason, struct wb_completion *done)
 {
 	struct backing_dev_info *bdi;
 	struct cgroup_subsys_state *memcg_css;
 	struct bdi_writeback *wb;
 	struct wb_writeback_work *work;
+	unsigned long dirty;
 	int ret;
 
 	/* lookup bdi and memcg */
@@ -1081,24 +1081,22 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr,
 	}
 
 	/*
-	 * If @nr is zero, the caller is attempting to write out most of
+	 * The caller is attempting to write out most of
 	 * the currently dirty pages.  Let's take the current dirty page
 	 * count and inflate it by 25% which should be large enough to
 	 * flush out most dirty pages while avoiding getting livelocked by
 	 * concurrent dirtiers.
+	 *
+	 * BTW the memcg stats are flushed periodically and this is best-effort
+	 * estimation, so some potential error is ok.
 	 */
-	if (!nr) {
-		unsigned long filepages, headroom, dirty, writeback;
-
-		mem_cgroup_wb_stats(wb, &filepages, &headroom, &dirty,
-				      &writeback);
-		nr = dirty * 10 / 8;
-	}
+	dirty = memcg_page_state(mem_cgroup_from_css(memcg_css), NR_FILE_DIRTY);
+	dirty = dirty * 10 / 8;
 
 	/* issue the writeback work */
 	work = kzalloc(sizeof(*work), GFP_NOWAIT | __GFP_NOWARN);
 	if (work) {
-		work->nr_pages = nr;
+		work->nr_pages = dirty;
 		work->sync_mode = WB_SYNC_NONE;
 		work->range_cyclic = 1;
 		work->reason = reason;
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b4c6b613e162..7028d8e4a3d7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -989,6 +989,16 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
 	local_irq_restore(flags);
 }
 
+static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
+{
+	long x = READ_ONCE(memcg->vmstats.state[idx]);
+#ifdef CONFIG_SMP
+	if (x < 0)
+		x = 0;
+#endif
+	return x;
+}
+
 static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
 					      enum node_stat_item idx)
 {
@@ -1444,6 +1454,11 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
 {
 }
 
+static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
+{
+	return 0;
+}
+
 static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
 					      enum node_stat_item idx)
 {
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 1f34ddf284dc..109e0dcd1d21 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -218,7 +218,7 @@ void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
 void wbc_detach_inode(struct writeback_control *wbc);
 void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
 			      size_t bytes);
-int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr_pages,
+int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 			   enum wb_reason reason, struct wb_completion *done);
 void cgroup_writeback_umount(void);
 bool cleanup_offline_cgwb(struct bdi_writeback *wb);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 35bb5f8f9ea8..6580c2381a3e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -631,17 +631,6 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
 }
 
-/* idx can be of type enum memcg_stat_item or node_stat_item. */
-static unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
-{
-	long x = READ_ONCE(memcg->vmstats.state[idx]);
-#ifdef CONFIG_SMP
-	if (x < 0)
-		x = 0;
-#endif
-	return x;
-}
-
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
 static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 {
@@ -4609,7 +4598,7 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 		    atomic_read(&frn->done.cnt) == 1) {
 			frn->at = 0;
 			trace_flush_foreign(wb, frn->bdi_id, frn->memcg_id);
-			cgroup_writeback_by_id(frn->bdi_id, frn->memcg_id, 0,
+			cgroup_writeback_by_id(frn->bdi_id, frn->memcg_id,
 					       WB_REASON_FOREIGN_FLUSH,
 					       &frn->done);
 		}
-- 
2.32.0.432.gabb21c7263-goog

