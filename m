Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929911A943A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 09:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404063AbgDOH1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 03:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403937AbgDOH1n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:27:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E2AC061A0C;
        Wed, 15 Apr 2020 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zpVApyPSKNUh671Lce6Q4vlcf5khOoA/VRo2OWbqlac=; b=Qpjxm2R2rmmgUR7/xJzRAqA0Jy
        eSIYEXsZzoVe02qupqqavVrgYyFbF/pIykDnW8TLwp0THBDAkcBMhVrZO12b/qihH2Plo2tr2yxu2
        fE6gjGUT8b4DV6V2uuLnfvSQfCBMnYDSyfxXlw5VU+J7DsnH3/sF8MtgEU1/kMCpVprtgqlRn7BF5
        37fxxY7FbmpIatlpRhxO6zjpJcyK/ovO55a9qZCN5BMxLl0UEB37+Mk62YTecpH55MVg7nve71cpD
        UgLpPTAZhKh3UBwKKpmq03QlTQb8u1NoTSkkP0juofeITx/1Ca5aZ2mpo9dQcQEbjj3hhKkcS396i
        r+L6AhPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOcS0-0005Lr-QZ; Wed, 15 Apr 2020 07:27:12 +0000
Date:   Wed, 15 Apr 2020 00:27:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 4/5] mm/swapfile: refcount block and queue before using
 blkcg_schedule_throttle()
Message-ID: <20200415072712.GB21099@infradead.org>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-5-mcgrof@kernel.org>
 <20200414154447.GC25765@infradead.org>
 <20200415054234.GQ11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415054234.GQ11244@42.do-not-panic.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 05:42:34AM +0000, Luis Chamberlain wrote:
> > I don't understand the atomic part of the comment.  How does
> > bdgrab/bdput help us there?
> 
> The commit log above did a better job at explaining this in terms of our
> goal to use the request_queue and how this use would prevent the risk of
> releasing the request_queue, which could sleep.

So bdput eventually does and iput, but what leads to an out of context
offload?

But anyway, isn't the original problem better solved by simply not
releasing the queue from atomic context to start with?  There isn't
really any good reason we keep holding the spinlock once we have a
reference on the queue, so something like this (not even compile tested)
should do the work:

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c5dc833212e1..45faa851f789 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1673,6 +1673,17 @@ void blkcg_maybe_throttle_current(void)
 	blk_put_queue(q);
 }
 
+/* consumes a reference on q */
+void __blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay)
+{
+	if (current->throttle_queue)
+		blk_put_queue(current->throttle_queue);
+	current->throttle_queue = q;
+	if (use_memdelay)
+		current->use_memdelay = use_memdelay;
+	set_notify_resume(current);
+}
+
 /**
  * blkcg_schedule_throttle - this task needs to check for throttling
  * @q: the request queue IO was submitted on
@@ -1694,16 +1705,8 @@ void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay)
 {
 	if (unlikely(current->flags & PF_KTHREAD))
 		return;
-
-	if (!blk_get_queue(q))
-		return;
-
-	if (current->throttle_queue)
-		blk_put_queue(current->throttle_queue);
-	current->throttle_queue = q;
-	if (use_memdelay)
-		current->use_memdelay = use_memdelay;
-	set_notify_resume(current);
+	if (blk_get_queue(q))
+		__blkcg_schedule_throttle(q, use_memdelay);
 }
 
 /**
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 35f8ffe92b70..68440cb3ea9e 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -679,6 +679,7 @@ static inline void blkcg_clear_delay(struct blkcg_gq *blkg)
 
 void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta);
 void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
+void __blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
 void blkcg_maybe_throttle_current(void);
 #else	/* CONFIG_BLK_CGROUP */
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5871a2aa86a5..4c6aa59ee593 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3749,9 +3749,10 @@ void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
 				  gfp_t gfp_mask)
 {
 	struct swap_info_struct *si, *next;
+	struct request_queue *q = NULL;
+
 	if (!(gfp_mask & __GFP_IO) || !memcg)
 		return;
-
 	if (!blk_cgroup_congested())
 		return;
 
@@ -3761,17 +3762,21 @@ void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
 	 */
 	if (current->throttle_queue)
 		return;
+	if (unlikely(current->flags & PF_KTHREAD))
+		return;
 
 	spin_lock(&swap_avail_lock);
 	plist_for_each_entry_safe(si, next, &swap_avail_heads[node],
 				  avail_lists[node]) {
 		if (si->bdev) {
-			blkcg_schedule_throttle(bdev_get_queue(si->bdev),
-						true);
+			if (blk_get_queue(dev_get_queue(si->bdev)))
+				q = dev_get_queue(si->bdev);
 			break;
 		}
 	}
 	spin_unlock(&swap_avail_lock);
+	if (q)
+		__blkcg_schedule_throttle(q, true);
 }
 #endif
 
