Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B5640B4CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 18:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhINQfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 12:35:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36500 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhINQfx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:35:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EDDDE20133;
        Tue, 14 Sep 2021 16:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631637274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w/5E6AWO4hf1qDQZmMriostoBVgIJHLgFFxt8gqBe3c=;
        b=GPlgASYjwPg/+6ImD5cCGGmdO4aWmWL2bdooVFmdGdap+N019pBj5XRhIhDF2WRCdi63/Y
        vP3UTpstIdq5nN0nkJMb9XALm/VGjhh6yJPefoyEkOmWhlwyFV4CJ+/azEvG38saEmXq+E
        0GFikVD9KiQgQUIQ+f4Km0OduuXubV0=
Received: from suse.com (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1EA27A3B91;
        Tue, 14 Sep 2021 16:34:34 +0000 (UTC)
Date:   Tue, 14 Sep 2021 17:34:32 +0100
From:   Mel Gorman <mgorman@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] EXT4: Remove ENOMEM/congestion_wait() loops.
Message-ID: <20210914163432.GR3828@suse.com>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
 <163157838437.13293.14244628630141187199.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <163157838437.13293.14244628630141187199.stgit@noble.brown>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 10:13:04AM +1000, NeilBrown wrote:
> Indefinite loops waiting for memory allocation are discouraged by
> documentation in gfp.h which says the use of __GFP_NOFAIL that it
> 
>  is definitely preferable to use the flag rather than opencode endless
>  loop around allocator.
> 
> Such loops that use congestion_wait() are particularly unwise as
> congestion_wait() is indistinguishable from
> schedule_timeout_uninterruptible() in practice - and should be
> deprecated.
> 
> So this patch changes the two loops in ext4_ext_truncate() to use
> __GFP_NOFAIL instead of looping.
> 
> As the allocation is multiple layers deeper in the call stack, this
> requires passing the EXT4_EX_NOFAIL flag down and handling it in various
> places.
> 
> Of particular interest is the ext4_journal_start family of calls which
> can now have EXT4_EX_NOFAIL 'or'ed in to the 'type'.  This could be seen
> as a blurring of types.  However 'type' is 8 bits, and EXT4_EX_NOFAIL is
> a high bit, so it is safe in practice.
> 
> jbd2__journal_start() is enhanced so that the gfp_t flags passed are
> used for *all* allocations.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

I'm not a fan. GFP_NOFAIL allows access to emergency reserves increasing
the risk of a livelock if memory is completely depleted where as some
callers can afford to wait.

The key event should be reclaim making progress. The hack below is
intended to vaguely demonstrate how blocking can be based on reclaim
making progress instead of "congestion" but has not even been booted. A
more complete overhaul may involve introducing
reclaim_congestion_wait_nodemask(gfp_t gfp_mask, long timeout, nodemask_t *nodemask)
and
reclaim_congestion_wait_nodemask(gfp_t gfp_mask, long timeout)
and converting congestion_wait and wait_iff_congestion to calling
reclaim_congestion_wait_nodemask which waits on the first usable node
and then audit every single congestion_wait() user to see which API
they should call. Further work would be to establish whether the page allocator should
call reclaim_congestion_wait_nodemask() if direct reclaim is not making
progress or whether that should be in vmscan.c. Conceivably, GFP_NOFAIL
could then soften its access to emergency reserves but I haven't given
it much thought.

Yes it's significant work, but it would be a better than letting
__GFP_NOFAIL propagate further and kicking us down the road.

This hack is terrible, it's not the right way to do it, it's just to
illustrate the idea of "waiting on memory should be based on reclaim
making progress and not the state of storage" is not impossible.

--8<--
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 5c0318509f9e..5ed81c5746ec 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -832,6 +832,7 @@ typedef struct pglist_data {
 	unsigned long node_spanned_pages; /* total size of physical page
 					     range, including holes */
 	int node_id;
+	wait_queue_head_t reclaim_wait;
 	wait_queue_head_t kswapd_wait;
 	wait_queue_head_t pfmemalloc_wait;
 	struct task_struct *kswapd;	/* Protected by
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 6122c78ce914..21a9cd693d12 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/writeback.h>
 #include <linux/device.h>
+#include <linux/swap.h>
 #include <trace/events/writeback.h>
 
 struct backing_dev_info noop_backing_dev_info;
@@ -1013,25 +1014,41 @@ void set_bdi_congested(struct backing_dev_info *bdi, int sync)
 EXPORT_SYMBOL(set_bdi_congested);
 
 /**
- * congestion_wait - wait for a backing_dev to become uncongested
- * @sync: SYNC or ASYNC IO
- * @timeout: timeout in jiffies
+ * congestion_wait - the docs are now worthless but avoiding a rename
  *
- * Waits for up to @timeout jiffies for a backing_dev (any backing_dev) to exit
- * write congestion.  If no backing_devs are congested then just wait for the
- * next write to be completed.
+ * New thing -- wait for a timeout or reclaim to make progress
  */
 long congestion_wait(int sync, long timeout)
 {
+	pg_data_t *pgdat;
 	long ret;
 	unsigned long start = jiffies;
 	DEFINE_WAIT(wait);
-	wait_queue_head_t *wqh = &congestion_wqh[sync];
+	wait_queue_head_t *wqh;
 
-	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
-	ret = io_schedule_timeout(timeout);
+	/* Never let kswapd sleep on itself */
+	if (current_is_kswapd())
+		goto trace;
+
+	/*
+	 * Dangerous, local memory may be forbidden by cpuset or policies,
+	 * use first eligible zone in zonelists node instead
+	 */
+	preempt_disable();
+	pgdat = NODE_DATA(smp_processor_id());
+	preempt_enable();
+	wqh = &pgdat->reclaim_wait;
+
+	/*
+	 * Should probably check watermark of suitable zones here
+	 * in case this is spuriously called
+	 */
+
+	prepare_to_wait(wqh, &wait, TASK_INTERRUPTIBLE);
+	ret = schedule_timeout(timeout);
 	finish_wait(wqh, &wait);
 
+trace:
 	trace_writeback_congestion_wait(jiffies_to_usecs(timeout),
 					jiffies_to_usecs(jiffies - start));
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5b09e71c9ce7..4b87b73d1264 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7418,6 +7418,7 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
 	pgdat_init_split_queue(pgdat);
 	pgdat_init_kcompactd(pgdat);
 
+	init_waitqueue_head(&pgdat->reclaim_wait);
 	init_waitqueue_head(&pgdat->kswapd_wait);
 	init_waitqueue_head(&pgdat->pfmemalloc_wait);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 158c9c93d03c..0ac2cf6be5e3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2888,6 +2888,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, NULL)));
 }
 
+static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx);
+
 static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 {
 	struct reclaim_state *reclaim_state = current->reclaim_state;
@@ -3070,6 +3072,18 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 				    sc))
 		goto again;
 
+	/*
+	 * Might be race-prone, more appropriate to do this when exiting
+	 * direct reclaim and when kswapd finds that pgdat is balanced.
+	 * May also be appropriate to update pgdat_balanced to take
+	 * a watermark level and wakeup when min watermarks are ok
+	 * instead of waiting for the high watermark
+	 */
+	if (waitqueue_active(&pgdat->reclaim_wait) &&
+	    pgdat_balanced(pgdat, 0, ZONE_MOVABLE)) {
+		wake_up_interruptible(&pgdat->reclaim_wait);
+	}
+
 	/*
 	 * Kswapd gives up on balancing particular nodes after too
 	 * many failures to reclaim anything from them and goes to
