Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61328314F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 14:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfHFM16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 08:27:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46591 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfHFM15 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:27:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E0F730B9BE0;
        Tue,  6 Aug 2019 12:27:57 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CA8861140;
        Tue,  6 Aug 2019 12:27:56 +0000 (UTC)
Date:   Tue, 6 Aug 2019 08:27:54 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/24] mm: directed shrinker work deferral
Message-ID: <20190806122754.GA2979@bfoster>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-2-david@fromorbit.com>
 <20190802152709.GA60893@bfoster>
 <20190804014930.GR7777@dread.disaster.area>
 <20190805174226.GB14760@bfoster>
 <20190805234318.GB7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805234318.GB7777@dread.disaster.area>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 06 Aug 2019 12:27:57 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 09:43:18AM +1000, Dave Chinner wrote:
> On Mon, Aug 05, 2019 at 01:42:26PM -0400, Brian Foster wrote:
> > On Sun, Aug 04, 2019 at 11:49:30AM +1000, Dave Chinner wrote:
> > > On Fri, Aug 02, 2019 at 11:27:09AM -0400, Brian Foster wrote:
> > > > On Thu, Aug 01, 2019 at 12:17:29PM +1000, Dave Chinner wrote:
> > > > >  };
> > > > >  
> > > > >  #define SHRINK_STOP (~0UL)
> > > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > > index 44df66a98f2a..ae3035fe94bc 100644
> > > > > --- a/mm/vmscan.c
> > > > > +++ b/mm/vmscan.c
> > > > > @@ -541,6 +541,13 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> > > > >  	trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
> > > > >  				   freeable, delta, total_scan, priority);
> > > > >  
> > > > > +	/*
> > > > > +	 * If the shrinker can't run (e.g. due to gfp_mask constraints), then
> > > > > +	 * defer the work to a context that can scan the cache.
> > > > > +	 */
> > > > > +	if (shrinkctl->will_defer)
> > > > > +		goto done;
> > > > > +
> > > > 
> > > > Who's responsible for clearing the flag? Perhaps we should do so here
> > > > once it's acted upon since we don't call into the shrinker again?
> > > 
> > > Each shrinker invocation has it's own shrink_control context - they
> > > are not shared between shrinkers - the higher level is responsible
> > > for setting up the control state of each individual shrinker
> > > invocation...
> > > 
> > 
> > Yes, but more specifically, it appears to me that each level is
> > responsible for setting up control state managed by that level. E.g.,
> > shrink_slab_memcg() initializes the unchanging state per iteration and
> > do_shrink_slab() (re)sets the scan state prior to ->scan_objects().
> 
> do_shrink_slab() is responsible for iterating the scan in
> shrinker->batch sizes, that's all it's doing there. We have to do
> some accounting work from scan to scan. However, if ->will_defer is
> set, we skip that entire loop, so it's largely irrelevant IMO.
> 

The point is very simply that there are scenarios where ->will_defer
might be true or might be false on do_shrink_slab() entry and I'm just
noting it as a potential landmine. It's not a bug in the current code
from what I can tell. I can't imagine why we wouldn't just reset the
flag prior to the ->count_objects() call, but alas I'm not a maintainer
of this code so I'll leave it to other reviewers/maintainers at this
point..

> > > > Granted the deferred state likely hasn't
> > > > changed, but the fact that we'd call back into the count callback to set
> > > > it again implies the logic could be a bit more explicit, particularly if
> > > > this will eventually be used for more dynamic shrinker state that might
> > > > change call to call (i.e., object dirty state, etc.).
> > > > 
> > > > BTW, do we need to care about the ->nr_cached_objects() call from the
> > > > generic superblock shrinker (super_cache_scan())?
> > > 
> > > No, and we never had to because it is inside the superblock shrinker
> > > and the superblock shrinker does the GFP_NOFS context checks.
> > > 
> > 
> > Ok. Though tbh this topic has me wondering whether a shrink_control
> > boolean is the right approach here. Do you envision ->will_defer being
> > used for anything other than allocation context restrictions? If not,
> 
> Not at this point. If there are other control flags needed, we can
> ad them in future - I don't like the idea of having a single control
> flag mean different things in different contexts.
> 

I don't think we're talking about the same thing here..

> > perhaps we should do something like optionally set alloc flags required
> > for direct scanning in the struct shrinker itself and let the core
> > shrinker code decide when to defer to kswapd based on the shrink_control
> > flags and the current shrinker. That way an arbitrary shrinker can't
> > muck around with core behavior in unintended ways. Hm?
> 
> Arbitrary shrinkers can't "muck about" with the core behaviour any
> more than they already could with this code. If you want to screw up
> the core reclaim by always returning SHRINK_STOP to ->scan_objects
> instead of doing work, then there is nothing stopping you from doing
> that right now. Formalising there work deferral into a flag in the
> shrink_control doesn't really change that at all, adn as such I
> don't see any need for over-complicating the mechanism here....
> 

If you add a generic "defer work" knob to the shrinker mechanism, but
only process it as an "allocation context" check, I expect it could be
easily misused. For example, some shrinkers may decide to set the the
flag dynamically based on in-core state. This will work when called from
some contexts but not from others (unrelated to allocation context),
which is confusing. Therefore, what I'm saying is that if the only
current use case is to defer work from shrinkers that currently skip
work due to allocation context restraints, this might be better codified
with something like the appended (untested) example patch. This may or
may not be a preferable interface to the flag, but it's certainly not an
overcomplication...

Brian

--- 8< ---

diff --git a/fs/super.c b/fs/super.c
index 113c58f19425..4e05ed9d6154 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -69,13 +69,6 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 
 	sb = container_of(shrink, struct super_block, s_shrink);
 
-	/*
-	 * Deadlock avoidance.  We may hold various FS locks, and we don't want
-	 * to recurse into the FS that called us in clear_inode() and friends..
-	 */
-	if (!(sc->gfp_mask & __GFP_FS))
-		return SHRINK_STOP;
-
 	if (!trylock_super(sb))
 		return SHRINK_STOP;
 
@@ -264,6 +257,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_shrink.count_objects = super_cache_count;
 	s->s_shrink.batch = 1024;
 	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
+	s->s_shrink.direct_mask = __GFP_FS;
 	if (prealloc_shrinker(&s->s_shrink))
 		goto fail;
 	if (list_lru_init_memcg(&s->s_dentry_lru, &s->s_shrink))
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 9443cafd1969..e94e4edf7f1e 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -75,6 +75,8 @@ struct shrinker {
 #endif
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
+
+	gfp_t	direct_mask;
 };
 #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 44df66a98f2a..fb339399e26a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -541,6 +541,15 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
 				   freeable, delta, total_scan, priority);
 
+	/*
+	 * If the shrinker can't run (e.g. due to gfp_mask constraints), then
+	 * defer the work to a context that can scan the cache.
+	 */
+	if (shrinker->direct_mask &&
+	    ((shrinkctl->gfp_mask & shrinker->direct_mask) !=
+	     shrinker->direct_mask))
+		goto done;
+
 	/*
 	 * Normally, we should not scan less than batch_size objects in one
 	 * pass to avoid too frequent shrinker calls, but if the slab has less
@@ -575,6 +584,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		cond_resched();
 	}
 
+done:
 	if (next_deferred >= scanned)
 		next_deferred -= scanned;
 	else
