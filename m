Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118A825044D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 19:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgHXRAm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 13:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgHXRAL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 13:00:11 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1348CC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 10:00:11 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id x6so4053748qvr.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 10:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m6Sp49WTu7yLkSdnzUDD1bncFEV1oNxAmLNYIupgQo4=;
        b=moOtSvH96tM5PMHSz67NQyv6JWNeB/iCtHhzFUJJBVWO2Rvf9lrzi/KnKMCLDazr3+
         bBNLLIsHpmaQXz6SCa95Mknom1fMFRCtQXjTP4dmabeFaADMauT59gMAdJ2B7Bo4NrwS
         mS7zCYW7Md0qmh2hASakd/Bblbj20PBfK3vaCFAa+Qk4PVK3AccVfvxabLZQwu3hQt0c
         R+nY181KlL8P/51nDZhaJ8F8R4zm24O7pAJOep5d4XdV3Yxf325++vzHSK/MacDp0etV
         ZcI9X/al7xtWzmuuiznZv1Z8XguBTY/NbZNKJ5Wd3ZncP8pTuUTeFwMFufkznt5HSPAD
         RV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m6Sp49WTu7yLkSdnzUDD1bncFEV1oNxAmLNYIupgQo4=;
        b=ilmDKaoYUZRfoLBCJ32noqkPD3rRIZg6kJPIyUHNSJobfNmIV32qD5/AT2Q19x/aGJ
         A8zLDIz9D5AS2LWiAoqtFipYIZkIFN2duW/zk/Epfg9zOivPz4hK0b41KI/vkqNLArKH
         TSee2oijjuJo9OBOTIdGdXEI9TKDyJDbr2Y7NZ/sWBYSAc3qqSu2LH0MimyJgvRkyj3w
         AkFJZGJ9GnTxNblB94AbQ7g2B5mtIB9exzxQ07NY5soyru+CyFR97o96W2FO2c8kJqdv
         Ra4l9QcHkXxBPecaEqhczdFgnv1zcEWBmcn9HJAFPb3jUsGvwyzHTXfHl4kN/U6++GyP
         d8nw==
X-Gm-Message-State: AOAM5318TOBZX2FO+wyST9jcD5CSzk3EHvkLBj3xl6JU7Cif4G9vVTT8
        vp0F1shqej83zvbLXWPzipooRQ==
X-Google-Smtp-Source: ABdhPJxkwq1obMEPrF7Ifk/MGby0dsQN5SjKGuy12AVkZ+tl/5O+wli92FX79Cj2w1hEPoARjEBptg==
X-Received: by 2002:ad4:438f:: with SMTP id s15mr5847416qvr.164.1598288410089;
        Mon, 24 Aug 2020 10:00:10 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id x57sm11544905qtc.61.2020.08.24.10.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:00:08 -0700 (PDT)
Date:   Mon, 24 Aug 2020 12:58:50 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>, Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20200824165850.GA932571@cmpxchg.org>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
 <20200818092617.GN28270@dhcp22.suse.cz>
 <20200818095910.GM2674@hirez.programming.kicks-ass.net>
 <20200818100516.GO28270@dhcp22.suse.cz>
 <20200818101844.GO2674@hirez.programming.kicks-ass.net>
 <20200818134900.GA829964@cmpxchg.org>
 <20200821193716.GU3982@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821193716.GU3982@worktop.programming.kicks-ass.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:37:16PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 18, 2020 at 09:49:00AM -0400, Johannes Weiner wrote:
> > On Tue, Aug 18, 2020 at 12:18:44PM +0200, peterz@infradead.org wrote:
> > > What you need is a feeback loop against the rate of freeing pages, and
> > > when you near the saturation point, the allocation rate should exactly
> > > match the freeing rate.
> > 
> > IO throttling solves a slightly different problem.
> > 
> > IO occurs in parallel to the workload's execution stream, and you're
> > trying to take the workload from dirtying at CPU speed to rate match
> > to the independent IO stream.
> > 
> > With memory allocations, though, freeing happens from inside the
> > execution stream of the workload. If you throttle allocations, you're
> 
> For a single task, but even then you're making the argument that we need
> to allocate memory to free memory, and we all know where that gets us.
>
> But we're actually talking about a cgroup here, which is a collection of
> tasks all doing things in parallel.

Right, but sharing a memory cgroup means sharing an LRU list, and that
transfers memory pressure and allocation burden between otherwise
independent tasks - if nothing else through cache misses on the
executables and libraries. I doubt that one task can go through
several comprehensive reclaim cycles on a shared LRU without
completely annihilating the latency or throughput targets of everybody
else in the group in most real world applications.

> > most likely throttling the freeing rate as well. And you'll slow down
> > reclaim scanning by the same amount as the page references, so it's
> > not making reclaim more successful either. The alloc/use/free
> > (im)balance is an inherent property of the workload, regardless of the
> > speed you're executing it at.
> 
> Arguably seeing the rate drop to near 0 is a very good point to consider
> running cgroup-OOM.

Agreed. In the past, that's actually what we did: In cgroup1, you
could disable the kernel OOM killer, and when reclaim failed at the
limit, the allocating task would be put on a waitqueue until woken up
by a freeing event. Conceptually this is clean & straight-forward.

However,

1. Putting allocation contexts with unknown locks to indefinite sleep
   caused deadlocks, for obvious reasons. Userspace OOM killing tends
   to take a lot of task-specific locks when scanning through /proc
   files for kill candidates, and can easily get stuck.

   Using bounded over indefinite waits is simply acknowledging that
   the deadlock potential when connecting arbitrary task stacks in the
   system through free->alloc ordering is equally difficult to plan
   out as alloc->free ordering.

   The non-cgroup OOM killer actually has the same deadlock potential,
   where the allocating/killing task can hold resources that the OOM
   victim requires to exit. The OOM reaper hides it, the static
   emergency reserves hide it - but to truly solve this problem, you
   would have to have full knowledge of memory & lock ordering
   dependencies of those tasks. And then can still end up with
   scenarios where the only answer is panic().

2. I don't recall ever seeing situations in cgroup1 where the precise
   matching of allocation rate to freeing rate has allowed cgroups to
   run sustainably after reclaim has failed. The practical benefit of
   a complicated feedback loop over something crude & robust once
   we're in an OOM situation is not apparent to me.

   [ That's different from the IO-throttling *while still doing
     reclaim* that Dave brought up. *That* justifies the same effort
     we put into dirty throttling. I'm only talking about the
     situation where reclaim has already failed and we need to
     facilitate userspace OOM handling. ]

So that was the motivation for the bounded sleeps. They do not
guarantee containment, but they provide a reasonable amount of time
for the userspace OOM handler to intervene, without deadlocking.


That all being said, the semantics of the new 'high' limit in cgroup2
have allowed us to move reclaim/limit enforcement out of the
allocation context and into the userspace return path.

See the call to mem_cgroup_handle_over_high() from
tracehook_notify_resume(), and the comments in try_charge() around
set_notify_resume().

This already solves the free->alloc ordering problem by allowing the
allocation to exceed the limit temporarily until at least all locks
are dropped, we know we can sleep etc., before performing enforcement.

That means we may not need the timed sleeps anymore for that purpose,
and could bring back directed waits for freeing-events again.

What do you think? Any hazards around indefinite sleeps in that resume
path? It's called before __rseq_handle_notify_resume and the
arch-specific resume callback (which appears to be a no-op currently).

Chris, Michal, what are your thoughts? It would certainly be simpler
conceptually on the memcg side.
