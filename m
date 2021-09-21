Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E13141324B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 13:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhIULOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 07:14:11 -0400
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:58859 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232268AbhIULOH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:14:07 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id E57FE1C4DEF
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Sep 2021 12:12:36 +0100 (IST)
Received: (qmail 18735 invoked from network); 21 Sep 2021 11:12:36 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Sep 2021 11:12:36 -0000
Date:   Tue, 21 Sep 2021 12:12:34 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     NeilBrown <neilb@suse.de>
Cc:     Linux-MM <linux-mm@kvack.org>, Theodore Ts'o <tytso@mit.edu>,
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
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] mm/vmscan: Throttle reclaim until some writeback
 completes if congested
Message-ID: <20210921111234.GQ3959@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>
 <20210920085436.20939-2-mgorman@techsingularity.net>
 <163217994752.3992.5443677201798473600@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <163217994752.3992.5443677201798473600@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 09:19:07AM +1000, NeilBrown wrote:
> On Mon, 20 Sep 2021, Mel Gorman wrote:
> >  
> > +void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page);
> > +static inline void acct_reclaim_writeback(struct page *page)
> > +{
> > +	pg_data_t *pgdat = page_pgdat(page);
> > +
> > +	if (atomic_read(&pgdat->nr_reclaim_throttled))
> > +		__acct_reclaim_writeback(pgdat, page);
> 
> The first thing __acct_reclaim_writeback() does is repeat that
> atomic_read().
> Should we read it once and pass the value in to
> __acct_reclaim_writeback(), or is that an unnecessary
> micro-optimisation?
> 

I think it's a micro-optimisation but I can still do it.

> 
> > +/*
> > + * Account for pages written if tasks are throttled waiting on dirty
> > + * pages to clean. If enough pages have been cleaned since throttling
> > + * started then wakeup the throttled tasks.
> > + */
> > +void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page)
> > +{
> > +	unsigned long nr_written;
> > +	int nr_throttled = atomic_read(&pgdat->nr_reclaim_throttled);
> > +
> > +	__inc_node_page_state(page, NR_THROTTLED_WRITTEN);
> > +	nr_written = node_page_state(pgdat, NR_THROTTLED_WRITTEN) -
> > +		READ_ONCE(pgdat->nr_reclaim_start);
> > +
> > +	if (nr_written > SWAP_CLUSTER_MAX * nr_throttled)
> > +		wake_up_interruptible_all(&pgdat->reclaim_wait);
> 
> A simple wake_up() could be used here.  "interruptible" is only needed
> if non-interruptible waiters should be left alone.  "_all" is only needed
> if there are some exclusive waiters.  Neither of these apply, so I think
> the simpler interface is best.
> 

You're right.

> 
> > +}
> > +
> >  /* possible outcome of pageout() */
> >  typedef enum {
> >  	/* failed to write page out, page is locked */
> > @@ -1412,9 +1453,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
> >  
> >  		/*
> >  		 * The number of dirty pages determines if a node is marked
> > -		 * reclaim_congested which affects wait_iff_congested. kswapd
> > -		 * will stall and start writing pages if the tail of the LRU
> > -		 * is all dirty unqueued pages.
> > +		 * reclaim_congested. kswapd will stall and start writing
> > +		 * pages if the tail of the LRU is all dirty unqueued pages.
> >  		 */
> >  		page_check_dirty_writeback(page, &dirty, &writeback);
> >  		if (dirty || writeback)
> > @@ -3180,19 +3220,20 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  		 * If kswapd scans pages marked for immediate
> >  		 * reclaim and under writeback (nr_immediate), it
> >  		 * implies that pages are cycling through the LRU
> > -		 * faster than they are written so also forcibly stall.
> > +		 * faster than they are written so forcibly stall
> > +		 * until some pages complete writeback.
> >  		 */
> >  		if (sc->nr.immediate)
> > -			congestion_wait(BLK_RW_ASYNC, HZ/10);
> > +			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK, HZ/10);
> >  	}
> >  
> >  	/*
> >  	 * Tag a node/memcg as congested if all the dirty pages
> >  	 * scanned were backed by a congested BDI and
> 
> "congested BDI" doesn't mean anything any more.  Is this a good time to
> correct that comment.
> This comment seems to refer to the test
> 
>       sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
> 
> a few lines down.  But nr.congested is set from nr_congested which
> counts when inode_write_congested() is true - almost never - and when 
> "writeback and PageReclaim()".
> 
> Is that last test the sign that we are cycling through the LRU to fast?
> So the comment could become:
> 
>    Tag a node/memcg as congested if all the dirty page were
>    already marked for writeback and immediate reclaim (counted in
>    nr.congested).
> 
> ??
> 
> Patch seems to make sense to me, but I'm not expert in this area.
> 

Comments updated.

Diff on top looks like

diff --git a/mm/internal.h b/mm/internal.h
index e25b3686bfab..90764d646e02 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -34,13 +34,15 @@
 
 void page_writeback_init(void);
 
-void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page);
+void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page,
+						int nr_throttled);
 static inline void acct_reclaim_writeback(struct page *page)
 {
 	pg_data_t *pgdat = page_pgdat(page);
+	int nr_throttled = atomic_read(&pgdat->nr_reclaim_throttled);
 
-	if (atomic_read(&pgdat->nr_reclaim_throttled))
-		__acct_reclaim_writeback(pgdat, page);
+	if (nr_throttled)
+		__acct_reclaim_writeback(pgdat, page, nr_throttled);
 }
 
 vm_fault_t do_swap_page(struct vm_fault *vmf);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b58ea0b13286..2dc17de91d32 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1034,10 +1034,10 @@ reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
  * pages to clean. If enough pages have been cleaned since throttling
  * started then wakeup the throttled tasks.
  */
-void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page)
+void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page,
+							int nr_throttled)
 {
 	unsigned long nr_written;
-	int nr_throttled = atomic_read(&pgdat->nr_reclaim_throttled);
 
 	__inc_node_page_state(page, NR_THROTTLED_WRITTEN);
 	nr_written = node_page_state(pgdat, NR_THROTTLED_WRITTEN) -
@@ -3228,9 +3228,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	}
 
 	/*
-	 * Tag a node/memcg as congested if all the dirty pages
-	 * scanned were backed by a congested BDI and
-	 * non-kswapd tasks will stall on reclaim_throttle.
+	 * Tag a node/memcg as congested if all the dirty pages were marked
+	 * for writeback and immediate reclaim (counted in nr.congested).
 	 *
 	 * Legacy memcg will stall in page writeback so avoid forcibly
 	 * stalling in reclaim_throttle().
@@ -3241,8 +3240,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		set_bit(LRUVEC_CONGESTED, &target_lruvec->flags);
 
 	/*
-	 * Stall direct reclaim for IO completions if underlying BDIs
-	 * and node is congested. Allow kswapd to continue until it
+	 * Stall direct reclaim for IO completions if the lruvec is
+	 * node is congested. Allow kswapd to continue until it
 	 * starts encountering unqueued dirty pages or cycling through
 	 * the LRU too quickly.
 	 */
@@ -4427,7 +4426,7 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 
 	trace_mm_vmscan_wakeup_kswapd(pgdat->node_id, highest_zoneidx, order,
 				      gfp_flags);
-	wake_up_interruptible(&pgdat->kswapd_wait);
+	wake_up_all(&pgdat->kswapd_wait);
 }
 
 #ifdef CONFIG_HIBERNATION
