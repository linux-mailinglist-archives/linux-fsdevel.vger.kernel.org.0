Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE5E3B675C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 19:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhF1ROe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 13:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbhF1ROd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:14:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED186C061760
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 10:12:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mn20-20020a17090b1894b02901707fc074e8so318872pjb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 10:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gCEhY7OT/PM4S4BcRqZZpvh9i6cszzrvehQ02dGXfrI=;
        b=eJtoQ7Sd2g/qcSytKyRrnUUqfjld6DGHFD33VQofjTldYGfHUaBvqP+1iaphrcPas8
         MW86XsJF+Bnzd0HMV1bw4IsUlQB2rHPFCrRqQsEMwTEeZNtq8VH0DbRRFKwm6PvQBIMm
         iDWTgoDk3qohgGl7zgcn7QXNjDJFx1yrqLruS6NM0yOpLvVmD59b10+rrtFJC8EzRICa
         fYx3CFU0wV1nL+frDup66wwGdNQpk1TWY0pGF3ff4v8aJtQG3UbvMU//UpiAjTAYi4WT
         IQiRO9qkHYu19A5LrBmCJ1j8XNtNB+sdZUeLMjnA97xD38Nkdb3CLIvZvjOAjm7VYaml
         1N4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gCEhY7OT/PM4S4BcRqZZpvh9i6cszzrvehQ02dGXfrI=;
        b=TsqNviXy6G0jeh9+vvdM6KdbCj+Qy0io3XQDKE8kYBlQgLrLJNLc20dHsqFVg2o90w
         JtAgp2yPMK/1rEu1lZD2xDGIbgM3U5tOVsCV+/e20TE1+A9dWYfCwZ7c9oQn3rIZBpxb
         IBPEAs1ZKOMwavGArIg9uZ9jQtiQVJuDu0zr0mfNmAsTvPtqNzG+X3iF1+BD2TT8sRaL
         dzIJADOr9dBKM3P8XjlEMda7FpRkMZTrc7pX8LN7SFxxIsdMxbsLr7jwIOFrbeK5ZoCa
         /DXvb3ZqvY0mRPHZmAw8etHtMzuqdhGbiVsU79CKFOa2S5BpAAhy0eyP/hhR2uHL38ud
         a+TA==
X-Gm-Message-State: AOAM5300gzVlkE5R5Z+sQu9gSNJnW7JPMhgAaA/T2iOgfEV+dXpYojW0
        wNXEGdHQ5a4bVmNUBcQlx2ns+w==
X-Google-Smtp-Source: ABdhPJyW+bWCigyJiRvZW9fgo/sLDWJpIC2xOjVji8n+yHXcsm+Ca6D3wFIpsP96nv7ft1EaCAVybw==
X-Received: by 2002:a17:90a:69e2:: with SMTP id s89mr38858516pjj.154.1624900327359;
        Mon, 28 Jun 2021 10:12:07 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:700f])
        by smtp.gmail.com with ESMTPSA id gd5sm65219pjb.45.2021.06.28.10.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 10:12:06 -0700 (PDT)
Date:   Mon, 28 Jun 2021 13:12:03 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/4] vfs: keep inodes with page cache off the inode
 shrinker LRU
Message-ID: <YNoC49bWOCxnkQ/v@cmpxchg.org>
References: <20210614211904.14420-1-hannes@cmpxchg.org>
 <20210614211904.14420-4-hannes@cmpxchg.org>
 <20210615062640.GD2419729@dread.disaster.area>
 <YMj2YbqJvVh1busC@cmpxchg.org>
 <20210616012008.GE2419729@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616012008.GE2419729@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:20:08AM +1000, Dave Chinner wrote:
> On Tue, Jun 15, 2021 at 02:50:09PM -0400, Johannes Weiner wrote:
> > On Tue, Jun 15, 2021 at 04:26:40PM +1000, Dave Chinner wrote:
> > > And in __list_lru_walk_one() just add:
> > > 
> > > 		case LRU_ROTATE_NODEFER:
> > > 			isolated++;
> > > 			/* fallthrough */
> > > 		case LRU_ROTATE:
> > > 			list_move_tail(item, &l->list);
> > > 			break;
> > > 
> > > And now inodes with active page cache  rotated to the tail of the
> > > list and are considered to have had work done on them. Hence they
> > > don't add to the work accumulation that the shrinker infrastructure
> > > defers, and so will allow the page reclaim to do it's stuff with
> > > page reclaim before such inodes will get reclaimed.
> > > 
> > > That's *much* simpler than your proposed patch and should get you
> > > pretty much the same result.
> > 
> > It solves the deferred work buildup, but it's absurdly inefficient.
> 
> So you keep saying. Show us the numbers. Show us that it's so
> inefficient that it's completely unworkable. _You_ need to justify
> why violating modularity and layering is the only viable solution to
> this problem. Given that there is an alternative simple, straight
> forward solution to the problem, it's on you to prove it is
> insufficient to solve your issues.
> 
> I'm sceptical that the complexity is necessary given that in general
> workloads, the inode shrinker doesn't even register in kernel
> profiles and that the problem being avoided generally isn't even hit
> in most workloads. IOWs, I'll take a simple but inefficient solution
> for avoiding a corner case behaviour over a solution that is
> complex, fragile and full of layering violations any day of the
> weeks.

I spent time last week benchmarking both implementations with various
combinations of icache and page cache size proportions.

You're right that most workloads don't care. But there are workloads
that do, and for them the behavior can become pathological during
drop-behind reclaim.

Page cache reclaim has two modes: 1. Workingset transitions where we
flush out the old as quickly as possible and 2. Streaming buffered IO
that doesn't benefit from caching, and so gets confined to the
smallest possible amount of memory without touching active pages.

During 1. we may rotate busy inodes a few times until their page cache
disappears. This isn't great, but at least temporary.

The issue is 2. We may do drop-behind reclaim for extended periods of
time, during which the cache workingset remains completely untouched
and the corresponding inodes never become eligible for freeing.
Rotating them over and over represents a continuous parasitic drag on
reclaim. Depending on the proportions between the icache and the
inactive cache list, this drag can make up a sizable portion or even
the majority of overall CPU consumed by reclaim. (And if you recall
the discussion around RWF_UNCACHED, dropbehind reclaim is already
bottlenecked on CPU with decent IO devices.)

My test is doing drop-behind reclaim while most memory is filled with
a cache workingset that is held by an increasing number of inodes. The
first number here is the inodes, the second is the active pages held
by each:

 1,000 * 3072 pages:  0.39%     0.05%  kswapd0          [kernel.kallsyms]   [k] shrink_slab
 10,000 * 307 pages:  0.39%     0.04%  kswapd0          [kernel.kallsyms]   [k] shrink_slab
 100,000 * 32 pages:  1.29%     0.05%  kswapd0          [kernel.kallsyms]   [k] shrink_slab
 500,000 *  6 pages: 11.36%     0.08%  kswapd0          [kernel.kallsyms]   [k] shrink_slab
1,000,000 * 3 pages: 26.40%     0.04%  kswapd0          [kernel.kallsyms]   [k] shrink_slab
1,500,000 * 2 pages: 42.97%     0.00%  kswapd0          [kernel.kallsyms]   [k] shrink_slab
3,000,000 * 1  page: 45.22%     0.00%  kswapd0          [kernel.kallsyms]   [k] shrink_slab

As we get into higher inode counts, the shrinkers end up burning most
of the reclaim cycles to rotate workingset inodes. For perspective,
with 3 million inodes, when the shrinkers eat 45% of the cycles to
busypoll the workingset inodes, page reclaim only consumes about 10%
to actually make forward progress.

IMO it goes from suboptimal to being a problem somewhere between 100k
and 500k in this table. That's not *that* many inodes - I'm counting
~74k files in my linux git tree alone.

North of 500k, it becomes pathological. That's probably less common,
but it happens in the real world. I checked the file servers that host
our internal source code trees. They have 16 times the memory of my
test box, but they routinely deal with 50 million+ inodes.

I think the additional complexity of updating the inode LRU according
to cache population state is justified in order to avoid these
pathological cornercases.
