Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCB24DA8C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 04:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbiCPDKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 23:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353329AbiCPDKK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 23:10:10 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6F42C12C
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 20:08:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V7KSVpu_1647400131;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V7KSVpu_1647400131)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Mar 2022 11:08:53 +0800
Date:   Wed, 16 Mar 2022 11:08:51 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
Subject: Re: [LSF/MM TOPIC] Better handling of negative dentries
Message-ID: <YjFUw0zMAxac/PR8@B-P7TQMD6M-0146.local>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
References: <YjDvRPuxPN0GsxLB@casper.infradead.org>
 <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
 <YjFGVxImP/nVyprQ@B-P7TQMD6M-0146.local>
 <20220316025223.GR661808@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220316025223.GR661808@dread.disaster.area>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 16, 2022 at 01:52:23PM +1100, Dave Chinner wrote:
> On Wed, Mar 16, 2022 at 10:07:19AM +0800, Gao Xiang wrote:
> > On Tue, Mar 15, 2022 at 01:56:18PM -0700, Roman Gushchin wrote:
> > > 
> > > > On Mar 15, 2022, at 12:56 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > > > 
> > > > The number of negative dentries is effectively constrained only by memory
> > > > size.  Systems which do not experience significant memory pressure for
> > > > an extended period can build up millions of negative dentries which
> > > > clog the dcache.  That can have different symptoms, such as inotify
> > > > taking a long time [1], high memory usage [2] and even just poor lookup
> > > > performance [3].  We've also seen problems with cgroups being pinned
> > > > by negative dentries, though I think we now reparent those dentries to
> > > > their parent cgroup instead.
> > > 
> > > Yes, it should be fixed already.
> > > 
> > > > 
> > > > We don't have a really good solution yet, and maybe some focused
> > > > brainstorming on the problem would lead to something that actually works.
> > > 
> > > I’d be happy to join this discussion. And in my opinion it’s going beyond negative dentries: there are other types of objects which tend to grow beyond any reasonable limits if there is no memory pressure.
> > 
> > +1, we once had a similar issue as well, and agree that is not only
> > limited to negative dentries but all too many LRU-ed dentries and inodes.
> 
> Yup, any discussion solely about managing buildup of negative
> dentries doesn't acknowledge that it is just a symptom of larger
> problems that need to be addressed.
> 
> > Limited the total number may benefit to avoid shrink spiking for servers.
> 
> No, we don't want to set hard limits on object counts - that's just
> asking for systems that need frequent hand tuning and are impossible
> to get right under changing workloads. Caches need to auto size
> according to workload's working set to find a steady state balance,
> not be bound by artitrary limits.
> 
> But even cache sizing isn't the problem here - it's just another
> symptom.
> 
> > > A perfect example when it happens is when a machine is almost
> > > idle for some period of time. Periodically running processes
> > > creating various kernel objects (mostly vfs cache) which over
> > > time are filling significant portions of the total memory. And
> > > when the need for memory arises, we realize that the memory is
> > > heavily fragmented and it’s costly to reclaim it back.
> 
> Yup, the underlying issue here is that memory reclaim does nothing
> to manage long term build-up of single use cached objects when
> *there is no memory pressure*. There's of idle time and spare
> resources to manage caches sanely, but we don't. e.g. there is no
> periodic rotation of caches that could lead to detection and reclaim
> of single use objects (say over a period of minutes) and hence
> prevent them from filling up all of memory unnecessarily and
> creating transient memory reclaim and allocation latency spikes when
> memory finally fills up.
> 
> IOWs, negative dentries getting out of hand and shrinker spikes are
> both a symptom of the same problem: while memory allocation is free,
> memory reclaim does nothing to manage cache aging. Hence we only
> find out we've got a badly aged cache when we finally realise
> it has filled all of memory, and then we have heaps of work to do
> before memory can be made available for allocation again....
> 
> And then if you're going to talk memory reclaim, the elephant in the
> room is the lack of integration between shrinkers and the main
> reclaim infrastructure.  There's no priority determination, there's
> no progress feedback, there's no mechanism to allow shrinkers to
> throttle reclaim rather than have the reclaim infrastructure wind up
> priority and OOM kill when a shrinker cannot make progress quickly,
> etc. Then there's direct reclaim hammering shrinkers with unbound
> concurrency so individual shrinkers have no chance of determining
> how much memory pressure there really is by themselves, not to
> mention the lock contention problems that unbound reclaim
> concurrency on things like LRU lists can cause. And, of course,
> memcg based reclaim is still only tacked onto the side of the
> shrinker infrastructure...

Yeah, it's really a generic problem between objects and shrinkers.
Some intelligent detection and feedback loop (even without memory
pressure) would be much better than hardcoded numbers. Actually I
remembered such topic has been raised for times, hoping for some
progress..

Thanks,
Gao Xiang

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
