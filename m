Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2065C4E4919
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 23:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiCVWWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 18:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiCVWWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:22:48 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68604BF61
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 15:21:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-150-27.pa.vic.optusnet.com.au [49.186.150.27])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 227D4533BA4;
        Wed, 23 Mar 2022 09:21:16 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nWmsM-008g01-Ez; Wed, 23 Mar 2022 09:21:14 +1100
Date:   Wed, 23 Mar 2022 09:21:14 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
Subject: Re: [LSF/MM TOPIC] Better handling of negative dentries
Message-ID: <20220322222114.GE1609613@dread.disaster.area>
References: <YjDvRPuxPN0GsxLB@casper.infradead.org>
 <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
 <YjFGVxImP/nVyprQ@B-P7TQMD6M-0146.local>
 <20220316025223.GR661808@dread.disaster.area>
 <YjnmcaHhE1F2oTcH@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YjnmcaHhE1F2oTcH@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=623a4bde
        a=sPqof0Mm7fxWrhYUF33ZaQ==:117 a=sPqof0Mm7fxWrhYUF33ZaQ==:17
        a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=FGYgVTa-rSrcW4m-z4sA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 22, 2022 at 03:08:33PM +0000, Matthew Wilcox wrote:
> On Wed, Mar 16, 2022 at 01:52:23PM +1100, Dave Chinner wrote:
> > On Wed, Mar 16, 2022 at 10:07:19AM +0800, Gao Xiang wrote:
> > > On Tue, Mar 15, 2022 at 01:56:18PM -0700, Roman Gushchin wrote:
> > > > 
> > > > > On Mar 15, 2022, at 12:56 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > > > > 
> > > > > The number of negative dentries is effectively constrained only by memory
> > > > > size.  Systems which do not experience significant memory pressure for
> > > > > an extended period can build up millions of negative dentries which
> > > > > clog the dcache.  That can have different symptoms, such as inotify
> > > > > taking a long time [1], high memory usage [2] and even just poor lookup
> > > > > performance [3].  We've also seen problems with cgroups being pinned
> > > > > by negative dentries, though I think we now reparent those dentries to
> > > > > their parent cgroup instead.
> > > > 
> > > > Yes, it should be fixed already.
> > > > 
> > > > > 
> > > > > We don't have a really good solution yet, and maybe some focused
> > > > > brainstorming on the problem would lead to something that actually works.
> > > > 
> > > > I’d be happy to join this discussion. And in my opinion it’s going beyond negative dentries: there are other types of objects which tend to grow beyond any reasonable limits if there is no memory pressure.
> > > 
> > > +1, we once had a similar issue as well, and agree that is not only
> > > limited to negative dentries but all too many LRU-ed dentries and inodes.
> > 
> > Yup, any discussion solely about managing buildup of negative
> > dentries doesn't acknowledge that it is just a symptom of larger
> > problems that need to be addressed.
> 
> Yes, but let's not make this _so_ broad a discussion that it becomes
> unsolvable.  Rather, let's look for a solution to this particular problem
> that can be adopted by other caches that share a similar problem.
> 
> For example, we might be seduced into saying "this is a slab problem"
> because all the instances we have here allocate from slab.  But slab
> doesn't have enough information to solve the problem.  Maybe the working
> set of the current workload really needs 6 million dentries to perform
> optimally.  Maybe it needs 600.  Slab can't know that.  Maybe slab can
> play a role here, but the only component which can know the appropriate
> size for a cache is the cache itself.

Yes, that's correct, but it also misses the fact that we need to
replicate this for inodes, various filesystem caches that have LRUs
and shrinkers because they can grow very large very quickly (e.g.
the xfs buffer and dquot caches, the ext4 extent cache shrinker, nfs
has several shrinkable caches, etc)

> I think the logic needs to be in d_alloc().  Before it calls __d_alloc(),
> it should check ... something ... to see if it should try to shrink
> the LRU list.

ANd therein lies the issue - the dcache, inode cache, the xfs buffer
cache, the xfs dquot cache, the gfs2 dquot cache, and the nfsv4 xattr
cache all use list_lru for LRU reclaim of objects via a shrinker.

See the commonality in functionality and requirements all these
caches already have? They all allocate from a slab, all use the same
LRU infratructure to age the cache, and all have shrinkers that use
list_lru_shrink_walk() to do the shrinker iteration of the LRU.
Using list-lru infrastructure is effectively a requirement for any
shrinkable cache that wants to be memcg aware, too.

What they all need is a common method of hooking list_lru management
to allocation and/or periodic scanning mechanisms. Fix the problem
for the dcache via list-lru, and all the other caches that need the
same feedback/control mechanisms get them as well. We kill at least
6 birds with one stone, and provide the infrastructure for new
caches to manage these same problems without having to write tehir
own infrastructure to do it.

IOWs, you're still missing the bigger picture here by continuing to
focus on negative dentries and the dcache rather than the common
infrastructure that shrinkable caches use.

> The devil is in what that something should be.  I'm no
> expert on the dcache; do we just want to call prune_dcache_sb() for
> every 1/1000 time?  Rely on DCACHE_REFERENCED to make sure that we're
> not over-pruning the list?  If so, what do we set nr_to_scan to?  1000 so
> that we try to keep the dentry list the same size?  1500 so that it
> actually tries to shrink?

The numbers themselves are largely irrelevant and should be set by
the subsystem after careful analysis. What we need first is the
common infrastructure to do the periodic/demand driven list
maintenance, then individual subsystems can set the limits and
triggers according to their individual needs.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
