Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C154DA8A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 03:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350506AbiCPCxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 22:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbiCPCxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:53:41 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4521D5C352
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 19:52:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-150-27.pa.vic.optusnet.com.au [49.186.150.27])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D691010E5699;
        Wed, 16 Mar 2022 13:52:24 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nUJlv-005zO8-FH; Wed, 16 Mar 2022 13:52:23 +1100
Date:   Wed, 16 Mar 2022 13:52:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
Subject: Re: [LSF/MM TOPIC] Better handling of negative dentries
Message-ID: <20220316025223.GR661808@dread.disaster.area>
References: <YjDvRPuxPN0GsxLB@casper.infradead.org>
 <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
 <YjFGVxImP/nVyprQ@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YjFGVxImP/nVyprQ@B-P7TQMD6M-0146.local>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=623150eb
        a=sPqof0Mm7fxWrhYUF33ZaQ==:117 a=sPqof0Mm7fxWrhYUF33ZaQ==:17
        a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=7N29KvIgx71kk7lOLegA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 16, 2022 at 10:07:19AM +0800, Gao Xiang wrote:
> On Tue, Mar 15, 2022 at 01:56:18PM -0700, Roman Gushchin wrote:
> > 
> > > On Mar 15, 2022, at 12:56 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > > 
> > > The number of negative dentries is effectively constrained only by memory
> > > size.  Systems which do not experience significant memory pressure for
> > > an extended period can build up millions of negative dentries which
> > > clog the dcache.  That can have different symptoms, such as inotify
> > > taking a long time [1], high memory usage [2] and even just poor lookup
> > > performance [3].  We've also seen problems with cgroups being pinned
> > > by negative dentries, though I think we now reparent those dentries to
> > > their parent cgroup instead.
> > 
> > Yes, it should be fixed already.
> > 
> > > 
> > > We don't have a really good solution yet, and maybe some focused
> > > brainstorming on the problem would lead to something that actually works.
> > 
> > I’d be happy to join this discussion. And in my opinion it’s going beyond negative dentries: there are other types of objects which tend to grow beyond any reasonable limits if there is no memory pressure.
> 
> +1, we once had a similar issue as well, and agree that is not only
> limited to negative dentries but all too many LRU-ed dentries and inodes.

Yup, any discussion solely about managing buildup of negative
dentries doesn't acknowledge that it is just a symptom of larger
problems that need to be addressed.

> Limited the total number may benefit to avoid shrink spiking for servers.

No, we don't want to set hard limits on object counts - that's just
asking for systems that need frequent hand tuning and are impossible
to get right under changing workloads. Caches need to auto size
according to workload's working set to find a steady state balance,
not be bound by artitrary limits.

But even cache sizing isn't the problem here - it's just another
symptom.

> > A perfect example when it happens is when a machine is almost
> > idle for some period of time. Periodically running processes
> > creating various kernel objects (mostly vfs cache) which over
> > time are filling significant portions of the total memory. And
> > when the need for memory arises, we realize that the memory is
> > heavily fragmented and it’s costly to reclaim it back.

Yup, the underlying issue here is that memory reclaim does nothing
to manage long term build-up of single use cached objects when
*there is no memory pressure*. There's of idle time and spare
resources to manage caches sanely, but we don't. e.g. there is no
periodic rotation of caches that could lead to detection and reclaim
of single use objects (say over a period of minutes) and hence
prevent them from filling up all of memory unnecessarily and
creating transient memory reclaim and allocation latency spikes when
memory finally fills up.

IOWs, negative dentries getting out of hand and shrinker spikes are
both a symptom of the same problem: while memory allocation is free,
memory reclaim does nothing to manage cache aging. Hence we only
find out we've got a badly aged cache when we finally realise
it has filled all of memory, and then we have heaps of work to do
before memory can be made available for allocation again....

And then if you're going to talk memory reclaim, the elephant in the
room is the lack of integration between shrinkers and the main
reclaim infrastructure.  There's no priority determination, there's
no progress feedback, there's no mechanism to allow shrinkers to
throttle reclaim rather than have the reclaim infrastructure wind up
priority and OOM kill when a shrinker cannot make progress quickly,
etc. Then there's direct reclaim hammering shrinkers with unbound
concurrency so individual shrinkers have no chance of determining
how much memory pressure there really is by themselves, not to
mention the lock contention problems that unbound reclaim
concurrency on things like LRU lists can cause. And, of course,
memcg based reclaim is still only tacked onto the side of the
shrinker infrastructure...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
