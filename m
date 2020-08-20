Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09FF24AF13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 08:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgHTGLh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 02:11:37 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:56276 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbgHTGLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:11:37 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 47EDE1AACAD;
        Thu, 20 Aug 2020 16:11:13 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1k8dn6-00054g-GM; Thu, 20 Aug 2020 16:11:12 +1000
Date:   Thu, 20 Aug 2020 16:11:12 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     peterz@infradead.org, Chris Down <chris@chrisdown.name>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/8] memcg: Enable fine-grained per process memory
 control
Message-ID: <20200820061112.GA7728@dread.disaster.area>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
 <20200818092737.GA148695@chrisdown.name>
 <20200818100444.GN2674@hirez.programming.kicks-ass.net>
 <20200818125559.GP17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818125559.GP17456@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0 cx=a_idp_d
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=cUD-o-zCZHVta4NZjWEA:9 a=CjuIK1q_8ugA:10
        a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 01:55:59PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 18, 2020 at 12:04:44PM +0200, peterz@infradead.org wrote:
> > On Tue, Aug 18, 2020 at 10:27:37AM +0100, Chris Down wrote:
> > > peterz@infradead.org writes:
> > > > On Mon, Aug 17, 2020 at 10:08:23AM -0400, Waiman Long wrote:
> > > > > Memory controller can be used to control and limit the amount of
> > > > > physical memory used by a task. When a limit is set in "memory.high" in
> > > > > a v2 non-root memory cgroup, the memory controller will try to reclaim
> > > > > memory if the limit has been exceeded. Normally, that will be enough
> > > > > to keep the physical memory consumption of tasks in the memory cgroup
> > > > > to be around or below the "memory.high" limit.
> > > > > 
> > > > > Sometimes, memory reclaim may not be able to recover memory in a rate
> > > > > that can catch up to the physical memory allocation rate. In this case,
> > > > > the physical memory consumption will keep on increasing.
> > > > 
> > > > Then slow down the allocator? That's what we do for dirty pages too, we
> > > > slow down the dirtier when we run against the limits.
> > > 
> > > We already do that since v5.4. I'm wondering whether Waiman's customer is
> > > just running with a too-old kernel without 0e4b01df865 ("mm, memcg: throttle
> > > allocators when failing reclaim over memory.high") backported.
> > 
> > That commit is fundamentally broken, it doesn't guarantee anything.
> > 
> > Please go read how the dirty throttling works (unless people wrecked
> > that since..).
> 
> Of course they did.
> 
> https://lore.kernel.org/linux-mm/ce7975cd-6353-3f29-b52c-7a81b1d07caa@kernel.dk/

Different thing. That's memory reclaim throttling, not dirty page
throttling.  balance_dirty_pages() still works just fine as it does
not look at device congestion. page cleaning rate is accounted in
test_clear_page_writeback(), page dirtying rate is accounted
directly in balance_dirty_pages(). That feedback loop has not been
broken...

And I compeltely agree with Peter here - the control theory we
applied to the dirty throttling problem is still 100% valid and so
the algorithm still just works all these years later. I've only been
saying that allocation should use the same feedback model for
reclaim throttling since ~2011...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
