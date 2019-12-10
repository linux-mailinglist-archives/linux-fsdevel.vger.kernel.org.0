Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFA85117D1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 02:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfLJBUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 20:20:52 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:57265 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727059AbfLJBUw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 20:20:52 -0500
Received: from dread.disaster.area (pa49-195-139-249.pa.nsw.optusnet.com.au [49.195.139.249])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 67CED7EA394;
        Tue, 10 Dec 2019 12:20:37 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ieUCa-0006iz-IA; Tue, 10 Dec 2019 12:20:36 +1100
Date:   Tue, 10 Dec 2019 12:20:36 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix hanging shrinker management on long
 do_shrink_slab
Message-ID: <20191210012036.GB19213@dread.disaster.area>
References: <20191129214541.3110-1-ptikhomirov@virtuozzo.com>
 <4e2d959a-0b0e-30aa-59b4-8e37728e9793@virtuozzo.com>
 <20191206020953.GS2695@dread.disaster.area>
 <CALvZod4YrnLLbaqTrZR92Y45rd4G+UzcqrkwAptJGJ2Kc8i6Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4YrnLLbaqTrZR92Y45rd4G+UzcqrkwAptJGJ2Kc8i6Og@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=KoypXv6BqLCQNZUs2nCMWg==:117 a=KoypXv6BqLCQNZUs2nCMWg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=x8hb-4BqU8MrIrHTnBsA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 06, 2019 at 09:11:25AM -0800, Shakeel Butt wrote:
> On Thu, Dec 5, 2019 at 6:10 PM Dave Chinner <david@fromorbit.com> wrote:
> > If a shrinker is blocking for a long time, then we need to
> > work to fix the shrinker implementation because blocking is a much
> > bigger problem than just register/unregister.
> >
> 
> Yes, we should be fixing the implementations of all shrinkers and yes
> it is bigger issue but we can also fix register/unregister isolation
> issue in parallel. Fixing all shrinkers would a tedious and long task
> and we should not block fixing isolation issue on it.

"fixing all shrinkers" is a bit of hyperbole - you've identified
only one instance where blocking is causing you problems. Indeed,
most shrinkers are already non-blocking and won't cause you any
problems at all.

> > IOWs, we already know that cycling a global rwsem on every
> > individual shrinker invocation is going to cause noticable
> > scalability problems. Hence I don't think that this sort of "cycle
> > the global rwsem faster to reduce [un]register latency" solution is
> > going to fly because of the runtime performance regressions it will
> > introduce....
> >
> 
> I agree with your scalability concern (though others would argue to
> first demonstrate the issue before adding more sophisticated scalable
> code).

Look at the git history. We *know* this is a problem, so anyone
arguing that we have to prove it can go take a long walk of a short
plank....

> Most memory reclaim code is written without the performance or
> scalability concern, maybe we should switch our thinking.

I think there's a lot of core mm and other developers that would
disagree with you there. With respect to shrinkers, we've been
directly concerned about performance and scalability of the
individual instances as well as the infrastructure for at least the
last decade....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
