Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E47842D8A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 13:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhJNL6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 07:58:41 -0400
Received: from outbound-smtp34.blacknight.com ([46.22.139.253]:44111 "EHLO
        outbound-smtp34.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230302AbhJNL6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 07:58:40 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp34.blacknight.com (Postfix) with ESMTPS id 29EAC1B28
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Oct 2021 12:56:35 +0100 (IST)
Received: (qmail 5409 invoked from network); 14 Oct 2021 11:56:34 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Oct 2021 11:56:34 -0000
Date:   Thu, 14 Oct 2021 12:56:32 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>, NeilBrown <neilb@suse.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] mm/vmscan: Throttle reclaim and compaction when too
 may pages are isolated
Message-ID: <20211014115632.GZ3959@techsingularity.net>
References: <20211008135332.19567-1-mgorman@techsingularity.net>
 <20211008135332.19567-3-mgorman@techsingularity.net>
 <5e2c8c39-29d9-61be-049f-a408f62f5acf@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <5e2c8c39-29d9-61be-049f-a408f62f5acf@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 14, 2021 at 10:06:25AM +0200, Vlastimil Babka wrote:
> On 10/8/21 15:53, Mel Gorman wrote:
> > Page reclaim throttles on congestion if too many parallel reclaim instances
> > have isolated too many pages. This makes no sense, excessive parallelisation
> > has nothing to do with writeback or congestion.
> > 
> > This patch creates an additional workqueue to sleep on when too many
> > pages are isolated. The throttled tasks are woken when the number
> > of isolated pages is reduced or a timeout occurs. There may be
> > some false positive wakeups for GFP_NOIO/GFP_NOFS callers but
> > the tasks will throttle again if necessary.
> > 
> > [shy828301@gmail.com: Wake up from compaction context]
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> ...
> 
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 90764d646e02..06d0c376efcd 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -45,6 +45,15 @@ static inline void acct_reclaim_writeback(struct page *page)
> >  		__acct_reclaim_writeback(pgdat, page, nr_throttled);
> >  }
> >  
> > +static inline void wake_throttle_isolated(pg_data_t *pgdat)
> > +{
> > +	wait_queue_head_t *wqh;
> > +
> > +	wqh = &pgdat->reclaim_wait[VMSCAN_THROTTLE_ISOLATED];
> > +	if (waitqueue_active(wqh))
> > +		wake_up_all(wqh);
> 
> Again, would it be better to wake up just one task to prevent possible
> thundering herd? We can assume that that task will call too_many_isolated()
> eventually to wake up the next one?

Same problem as the writeback throttling, there is no prioritsation of
light vs heavy allocators.

> Although it seems strange that
> too_many_isolated() is the place where we detect the situation for wake up.
> Simpler than to hook into NR_ISOLATED decrementing I guess.
> 

Simplier but more costly. Every decrement would have to check
too_many_isolated(). I think the cost of that is too high given that the
VMSCAN_THROTTLE_ISOLATED is relatively hard to trigger and the minority
of throttling events.

> > +}
> > +
> >  vm_fault_t do_swap_page(struct vm_fault *vmf);
> >  
> >  void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
> ...
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1006,11 +1006,10 @@ static void handle_write_error(struct address_space *mapping,
> >  	unlock_page(page);
> >  }
> >  
> > -static void
> > -reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
> > +void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
> >  							long timeout)
> >  {
> > -	wait_queue_head_t *wqh = &pgdat->reclaim_wait;
> > +	wait_queue_head_t *wqh = &pgdat->reclaim_wait[reason];
> 
> It seems weird that later in this function we increase nr_reclaim_throttled
> without distinguishing the reason, so effectively throttling for isolated
> pages will trigger acct_reclaim_writeback() doing the NR_THROTTLED_WRITTEN
> counting, although it's not related at all? Maybe either have separate
> nr_reclaim_throttled counters per vmscan_throttle_state (if counter of
> isolated is useful, I haven't seen the rest of series yet), or count only
> VMSCAN_THROTTLE_WRITEBACK tasks?
> 

Very good point, it would be more appropriate to only count the
writeback reason.

Diff on top is below. It'll cause minor conflicts later in the series.

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ca65d6a64bdd..58a25d42c31c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -849,7 +849,7 @@ typedef struct pglist_data {
 	wait_queue_head_t kswapd_wait;
 	wait_queue_head_t pfmemalloc_wait;
 	wait_queue_head_t reclaim_wait[NR_VMSCAN_THROTTLE];
-	atomic_t nr_reclaim_throttled;	/* nr of throtted tasks */
+	atomic_t nr_writeback_throttled;/* nr of writeback-throttled tasks */
 	unsigned long nr_reclaim_start;	/* nr pages written while throttled
 					 * when throttling started. */
 	struct task_struct *kswapd;	/* Protected by
diff --git a/mm/internal.h b/mm/internal.h
index 06d0c376efcd..3461a1055975 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -39,7 +39,7 @@ void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page,
 static inline void acct_reclaim_writeback(struct page *page)
 {
 	pg_data_t *pgdat = page_pgdat(page);
-	int nr_throttled = atomic_read(&pgdat->nr_reclaim_throttled);
+	int nr_throttled = atomic_read(&pgdat->nr_writeback_throttled);
 
 	if (nr_throttled)
 		__acct_reclaim_writeback(pgdat, page, nr_throttled);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6e198bbbd86a..29434d4fc1c7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1011,6 +1011,7 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
 {
 	wait_queue_head_t *wqh = &pgdat->reclaim_wait[reason];
 	long ret;
+	bool acct_writeback = (reason == VMSCAN_THROTTLE_WRITEBACK);
 	DEFINE_WAIT(wait);
 
 	/*
@@ -1022,7 +1023,8 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
 	    current->flags & (PF_IO_WORKER|PF_KTHREAD))
 		return;
 
-	if (atomic_inc_return(&pgdat->nr_reclaim_throttled) == 1) {
+	if (acct_writeback &&
+	    atomic_inc_return(&pgdat->nr_writeback_throttled) == 1) {
 		WRITE_ONCE(pgdat->nr_reclaim_start,
 			node_page_state(pgdat, NR_THROTTLED_WRITTEN));
 	}
@@ -1030,7 +1032,9 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
 	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
 	ret = schedule_timeout(timeout);
 	finish_wait(wqh, &wait);
-	atomic_dec(&pgdat->nr_reclaim_throttled);
+
+	if (acct_writeback)
+		atomic_dec(&pgdat->nr_writeback_throttled);
 
 	trace_mm_vmscan_throttled(pgdat->node_id, jiffies_to_usecs(timeout),
 				jiffies_to_usecs(timeout - ret),
@@ -4349,7 +4353,7 @@ static int kswapd(void *p)
 
 	WRITE_ONCE(pgdat->kswapd_order, 0);
 	WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
-	atomic_set(&pgdat->nr_reclaim_throttled, 0);
+	atomic_set(&pgdat->nr_writeback_throttled, 0);
 	for ( ; ; ) {
 		bool ret;
 
