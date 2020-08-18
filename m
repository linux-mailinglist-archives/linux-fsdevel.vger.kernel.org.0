Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29382248288
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 12:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHRKFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 06:05:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:47112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgHRKFT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:05:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C6F9B12C;
        Tue, 18 Aug 2020 10:05:43 +0000 (UTC)
Date:   Tue, 18 Aug 2020 12:05:16 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     peterz@infradead.org
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
Message-ID: <20200818100516.GO28270@dhcp22.suse.cz>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
 <20200818092617.GN28270@dhcp22.suse.cz>
 <20200818095910.GM2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818095910.GM2674@hirez.programming.kicks-ass.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 18-08-20 11:59:10, Peter Zijlstra wrote:
> On Tue, Aug 18, 2020 at 11:26:17AM +0200, Michal Hocko wrote:
> > On Tue 18-08-20 11:14:53, Peter Zijlstra wrote:
> > > On Mon, Aug 17, 2020 at 10:08:23AM -0400, Waiman Long wrote:
> > > > Memory controller can be used to control and limit the amount of
> > > > physical memory used by a task. When a limit is set in "memory.high" in
> > > > a v2 non-root memory cgroup, the memory controller will try to reclaim
> > > > memory if the limit has been exceeded. Normally, that will be enough
> > > > to keep the physical memory consumption of tasks in the memory cgroup
> > > > to be around or below the "memory.high" limit.
> > > > 
> > > > Sometimes, memory reclaim may not be able to recover memory in a rate
> > > > that can catch up to the physical memory allocation rate. In this case,
> > > > the physical memory consumption will keep on increasing. 
> > > 
> > > Then slow down the allocator? That's what we do for dirty pages too, we
> > > slow down the dirtier when we run against the limits.
> > 
> > This is what we actually do. Have a look at mem_cgroup_handle_over_high.
> 
> But then how can it run-away like Waiman suggested?

As Chris mentioned in other reply. This functionality is quite new.
 
> /me goes look... and finds MEMCG_MAX_HIGH_DELAY_JIFFIES.

We can certainly tune a different backoff delays but I suspect this is
not the problem here.
 
> That's a fail... :-(

-- 
Michal Hocko
SUSE Labs
