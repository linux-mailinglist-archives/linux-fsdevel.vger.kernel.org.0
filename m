Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9047E643B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 10:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfGJIl5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 04:41:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:60498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726198AbfGJIl4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:41:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 413FDAE15;
        Wed, 10 Jul 2019 08:41:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 239281E3F45; Wed, 10 Jul 2019 10:41:53 +0200 (CEST)
Date:   Wed, 10 Jul 2019 10:41:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Boaz Harrosh <openosd@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: pagecache locking
Message-ID: <20190710084153.GA962@quack2.suse.cz>
References: <CAHk-=wgz+7O0pdn8Wfxc5EQKNy44FTtf4LAPO1WgCidNjxbWzg@mail.gmail.com>
 <20190617224714.GR14363@dread.disaster.area>
 <CAHk-=wiR3a7+b0cUN45hGp1dvFh=s1i1OkVhoP7CivJxKqsLFQ@mail.gmail.com>
 <CAOQ4uxjqQjrCCt=ixgdUYjBJvKLhw4R9NeMZOB_s2rrWvoDMBw@mail.gmail.com>
 <20190619103838.GB32409@quack2.suse.cz>
 <20190619223756.GC26375@dread.disaster.area>
 <3f394239-f532-23eb-9ff1-465f7d1f3cb4@gmail.com>
 <20190705233157.GD7689@dread.disaster.area>
 <20190708133114.GC20507@quack2.suse.cz>
 <20190709234712.GL7689@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709234712.GL7689@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 10-07-19 09:47:12, Dave Chinner wrote:
> On Mon, Jul 08, 2019 at 03:31:14PM +0200, Jan Kara wrote:
> > I'd be really careful with nesting range locks. You can have nasty
> > situations like:
> > 
> > Thread 1		Thread 2
> > read_lock(0,1000)	
> > 			write_lock(500,1500) -> blocks due to read lock
> > read_lock(1001,1500) -> blocks due to write lock (or you have to break
> >   fairness and then deal with starvation issues).
> >
> > So once you allow nesting of range locks, you have to very carefully define
> > what is and what is not allowed.
> 
> Yes. I do understand the problem with rwsem read nesting and how
> that can translate to reange locks.
> 
> That's why my range locks don't even try to block on other pending
> waiters. The case where read nesting vs write might occur like above
> is something like copy_file_range() vs truncate, but otherwise for
> IO locks we simply don't have arbitrarily deep nesting of range
> locks.
> 
> i.e. for your example my range lock would result in:
> 
> Thread 1		Thread 2
> read_lock(0,1000)	
> 			write_lock(500,1500)
> 			<finds conflicting read lock>
> 			<marks read lock as having a write waiter>
> 			<parks on range lock wait list>
> <...>
> read_lock_nested(1001,1500)
> <no overlapping range in tree>
> <gets nested range lock>
> 
> <....>
> read_unlock(1001,1500)	<stays blocked because nothing is waiting
> 		         on (1001,1500) so no wakeup>
> <....>
> read_unlock(0,1000)
> <sees write waiter flag, runs wakeup>
> 			<gets woken>
> 			<retries write lock>
> 			<write lock gained>
> 
> IOWs, I'm not trying to complicate the range lock implementation
> with complex stuff like waiter fairness or anti-starvation semantics
> at this point in time. Waiters simply don't impact whether a new lock
> can be gained or not, and hence the limitations of rwsem semantics
> don't apply.
> 
> If such functionality is necessary (and I suspect it will be to
> prevent AIO from delaying truncate and fallocate-like operations
> indefinitely) then I'll add a "barrier" lock type (e.g.
> range_lock_write_barrier()) that will block new range lock attempts
> across it's span.
> 
> However, because this can cause deadlocks like the above, a barrier
> lock will not block new *_lock_nested() or *_trylock() calls, hence
> allowing runs of nested range locking to complete and drain without
> deadlocking on a conflicting barrier range. And that still can't be
> modelled by existing rwsem semantics....

Clever :). Thanks for explanation.

> > That's why in my range lock implementation
> > ages back I've decided to treat range lock as a rwsem for deadlock
> > verification purposes.
> 
> IMO, treating a range lock as a rwsem for deadlock purposes defeats
> the purpose of adding range locks in the first place. The
> concurrency models are completely different, and some of the
> limitations on rwsems are a result of implementation choices rather
> than limitations of a rwsem construct.

Well, even a range lock that cannot nest allows concurrent non-overlapping
read and write to the same file which rwsem doesn't allow. But I agree that
your nesting variant offers more (but also at the cost of higher complexity
of the lock semantics).

> In reality I couldn't care less about what lockdep can or can't
> verify. I've always said lockdep is a crutch for people who don't
> understand locks and the concurrency model of the code they
> maintain. That obviously extends to the fact that lockdep
> verification limitations should not limit what we allow new locking
> primitives to do.

I didn't say we have to constrain new locking primitives to what lockdep
can support. It is just a locking correctness verification tool so naturally
lockdep should be taught to what it needs to know about any locking scheme
we come up with. And sometimes it is just too much effort which is why e.g.
page lock still doesn't have lockdep coverage.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
