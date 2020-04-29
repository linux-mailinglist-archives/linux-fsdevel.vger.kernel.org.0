Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FAD1BE3A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 18:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgD2QVZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 12:21:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:43240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgD2QVZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:21:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 881EDAF77;
        Wed, 29 Apr 2020 16:21:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D262D1E1298; Wed, 29 Apr 2020 18:21:20 +0200 (CEST)
Date:   Wed, 29 Apr 2020 18:21:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v5 0/4] Charge loop device i/o to issuing cgroup
Message-ID: <20200429162120.GB12716@quack2.suse.cz>
References: <20200428161355.6377-1-schatzberg.dan@gmail.com>
 <20200428214653.GD2005@dread.disaster.area>
 <20200429102540.GA12716@quack2.suse.cz>
 <20200429142230.GE5462@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429142230.GE5462@mtj.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 29-04-20 10:22:30, Tejun Heo wrote:
> Hello,
> 
> On Wed, Apr 29, 2020 at 12:25:40PM +0200, Jan Kara wrote:
> > Yeah, I was thinking about the same when reading the patch series
> > description. We already have some cgroup workarounds for btrfs kthreads if
> > I remember correctly, we have cgroup handling for flush workers, now we are
> > adding cgroup handling for loopback device workers, and soon I'd expect
> > someone comes with a need for DM/MD worker processes and IMHO it's getting
> > out of hands because the complexity spreads through the kernel with every
> > subsystem comming with slightly different solution to the problem and also
> > the number of kthreads gets multiplied by the number of cgroups. So I
> > agree some generic solution how to approach IO throttling of kthreads /
> > workers would be desirable.
> > 
> > OTOH I don't have a great idea how the generic infrastructure should look
> > like...
> 
> I don't really see a way around that. The only generic solution would be
> letting all IOs through as root and handle everything through backcharging,
> which we already can do as backcharging is already in use to handle metadata
> updates which can't be controlled directly. However, doing that for all IOs
> would make the control quality a lot worse as all control would be based on
> first incurring deficit and then try to punish the issuer after the fact.

Yeah, it will be probably somewhat worse but OTOH given we'd track the IO
balance per cgroup there will deficit only when a cgroup is starting so it
could be bearable. I'm more concerned about issues like that for some IO
controllers (e.g. for blk-iolatency or for the work preserving
controllers), it is not obvious how to sensibly estimate some cost to
charge to a cgroup since these controllers are more about giving priority
to IO of some cgroup in presence of IO from another cgroup rather than some
hard throughput limit or something like that.

> The infrastructure work done to make IO control work for btrfs is generic
> and the changes needed on btrfs side was pretty small. Most of the work was
> identifying non-regular IO pathways (bouncing through different kthreads and
> whatnot) and making sure they're annotating IO ownership and the needed
> mechanism correctly. The biggest challenge probably is ensuring that the
> filesystem doesn't add ordering dependency between separate data IOs, which
> is a nice property to have with or without cgroup support.
> 
> That leaves the nesting drivers, loop and md/dm. Given that they sit in the
> middle of IO stack and proxy a lot of its roles, they'll have to be updated
> to be transparent in terms of cgroup ownership if IO control is gonna work
> through them. Maybe we can have a common infra shared between loop, dm and
> md but they aren't many and may also be sufficiently different. idk

Yeah, as I said, I don't really have a better alternative :-|

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
