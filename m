Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDBA22199A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 03:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGPBrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 21:47:04 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:56342 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726785AbgGPBrD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:47:03 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 5AC483AA635;
        Thu, 16 Jul 2020 11:46:57 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jvszA-0001y6-2f; Thu, 16 Jul 2020 11:46:56 +1000
Date:   Thu, 16 Jul 2020 11:46:56 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fs/direct-io: avoid data race on ->s_dio_done_wq
Message-ID: <20200716014656.GJ2005@dread.disaster.area>
References: <20200713033330.205104-1-ebiggers@kernel.org>
 <20200715013008.GD2005@dread.disaster.area>
 <20200715023714.GA38091@sol.localdomain>
 <20200715080144.GF2005@dread.disaster.area>
 <20200715161342.GA1167@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715161342.GA1167@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=p68NMH57DQzvjREzIioA:9 a=Trv5CCooIfyJ-1wu:21 a=SIlSwGWthHDq-VID:21
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 09:13:42AM -0700, Eric Biggers wrote:
> On Wed, Jul 15, 2020 at 06:01:44PM +1000, Dave Chinner wrote:
> > > > >  /* direct-io.c: */
> > > > > -int sb_init_dio_done_wq(struct super_block *sb);
> > > > > +int __sb_init_dio_done_wq(struct super_block *sb);
> > > > > +static inline int sb_init_dio_done_wq(struct super_block *sb)
> > > > > +{
> > > > > +	/* pairs with cmpxchg() in __sb_init_dio_done_wq() */
> > > > > +	if (likely(READ_ONCE(sb->s_dio_done_wq)))
> > > > > +		return 0;
> > > > > +	return __sb_init_dio_done_wq(sb);
> > > > > +}
> > > > 
> > > > Ummm, why don't you just add this check in sb_init_dio_done_wq(). I
> > > > don't see any need for adding another level of function call
> > > > abstraction in the source code?
> > > 
> > > This keeps the fast path doing no function calls and one fewer branch, as it was
> > > before.  People care a lot about minimizing direct I/O overhead, so it seems
> > > desirable to keep this simple optimization.  Would you rather it be removed?
> > 
> > No.
> > 
> > What I'm trying to say is that I'd prefer fast path checks don't get
> > hidden away in a static inline function wrappers that require the
> > reader to go look up code in a different file to understand that
> > code in yet another different file is conditionally executed.
> > 
> > Going from obvious, easy to read fast path code to spreading the
> > fast path logic over functions in 3 different files is not an
> > improvement in the code - it is how we turn good code into an
> > unmaintainable mess...
> 
> The alternative would be to duplicate the READ_ONCE() at all 3 call sites --
> including the explanatory comment.  That seems strictly worse.
> 
> And the code before was broken, so I disagree it was "obvious" or "good".

It's only "broken" on anything but an ancient platform that
has a unique, one-off, never to be repeated, whacky
memory model.

And why should we compromise performance on hundreds of millions of
modern systems to fix an extremely rare race on an extremely rare
platform that maybe only a hundred people world-wide might still
use?

Indeed, if you are going to use "fast path performance" as the
justification for READ_ONCE() over a more robust but slightly slower
release/acquire barrier pair, then I'd suggest that the check and
dynamic allocation of the workqueue should be removed entirely and
it should be allocated at mount time by filesytems that require it. 

IOWs, If we are truly concerned with fast path performance, then
we'd elide the entire branch from the fast path altogether, thereby
getting rid of the cmpxchg code and the data race at the same
time....

I'm talking from self interest here: I need to be able to understand
and debug this code, and if I struggle to understand what the memory
ordering relationship is and have to work it out from first
principles every time I have to look at the code, then *that is bad
code*.

I don't care about speed if I can't understand or easily modify the
code without it breaking unexpectedly. IO performance comes from the
algorithms, not micro-optimisation of CPU usage. If one CPU is not
enough, I've got another thousand I can also use. Make the code
simple, stupid, easy to maintain, and easy to test - performance
will come from smart, highly concurrent algorithms, not single CPU
usage micro-optimisations.

> > > > Also, you need to explain the reason for the READ_ONCE() existing
> > > > rather than just saying "it pairs with <some other operation>".
> > > > Knowing what operation it pairs with doesn't explain why the pairing
> > > > is necessary in the first place, and that leads to nobody reading
> > > > the code being able to understand what this is protecting against.
> > > > 
> > > 
> > > How about this?
> > > 
> > > 	/*
> > > 	 * Nothing to do if ->s_dio_done_wq is already set.  But since another
> > > 	 * process may set it concurrently, we need to use READ_ONCE() rather
> > > 	 * than a plain read to avoid a data race (undefined behavior) and to
> > > 	 * ensure we observe the pointed-to struct to be fully initialized.
> > > 	 */
> > > 	if (likely(READ_ONCE(sb->s_dio_done_wq)))
> > > 		return 0;
> > 
> > You still need to document what it pairs with, as "data race" doesn't
> > describe the actual dependency we are synchronising against is.
> > 
> > AFAICT from your description, the data race is not on
> > sb->s_dio_done_wq itself, but on seeing the contents of the
> > structure being pointed to incorrectly. i.e. we need to ensure that
> > writes done before the cmpxchg are ordered correctly against
> > reads done after the pointer can be seen here.
> > 
> 
> No, the data race is on ->s_dio_done_wq itself.  How about this:

Then we -just don't care- that it races because false negatives call
into sb_init_dio_done_wq() and it does the right thing. And given
that -false positives- cannot occur (requires time travel to see the
variable set before it has actually been set by the cmpxchg) there
is nothing wrong with this check being racy.

>         /*
>          * Nothing to do if ->s_dio_done_wq is already set.  The READ_ONCE()
>          * here pairs with the cmpxchg() in __sb_init_dio_done_wq().  Since the
>          * cmpxchg() may set ->s_dio_done_wq concurrently, a plain load would be
>          * a data race (undefined behavior),

No, it is *not undefined*. If we know what is racing, then it is
trivial to determine what the outcome of the race will be. And that
-defines- the behaviour that will occur, and as per above, once
we've defined the behaviour we realise that *we just don't care
about races on setting/reading ->s_dio_done_wq because the code
will *always do the right thing*.

>          so READ_ONCE() is needed.
>          * READ_ONCE() also includes any needed read data dependency barrier to
>          * ensure that the pointed-to struct is seen to be fully initialized.
>          */

IOWs, the only problem started here is the read data dependency
that results from not explicitly ordering loads from the memory that
->s_dio_done_wq points to before it is made visible via the cmpxchg.

Most people will be able to understand this as a
store-release/load-acquire data relationship.  Yes, I know that
because the related write operations that need ordering occur in the
same structure the atomic ops publish via a pointer to that
structure, it can be reduced to just a pure read data dependency.
But understanding that from the code and reasoning that the
dependency is unchanged by future modifications is complex and
beyond the capability of many people, likely including *me*.

If we leave the code as a simple store-release/load_acquire pattern,
then we just don't have to care about hidden or subtle data/control
dependencies. The code will work regardless of whether they exist or
not, so it will be much more robust against future changes.

> FWIW, long-term we really need to get developers to understand these sorts of
> issues, so that the code is written correctly in the first place and we don't
> need to annotate common patterns like one-time-init with a long essay and have a
> long discussion.

Well, yes, but slamming READ_ONCE/WRITE_ONCE all through the code
-does not acheive that-. Go back and look at the recent discussion
I had with PeterZ over the memory ordering in ttwu(). [1] You can
document the memory ordering, but that *does not make the code
understandable*. Memory ordering requires a -lot- of knowledge to
understand the context in which the ordering is necessary, and
nobody can understand that from a terse comment like "pairs with
<op> in <func>".

[1] https://lore.kernel.org/linux-xfs/20200626223254.GH2005@dread.disaster.area/

> Recently KCSAN was merged upstream
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/dev-tools/kcsan.rst)
> and the memory model documentation was improved
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/explanation.txt?h=v5.8-rc5#n1922),
> so hopefully that will raise awareness...

The majority of the _good_ programmers I know run away screaming
from this stuff. As was said many, many years ago - understanding
memory-barriers.txt is an -extremely high bar- to set as a basic
requirement for being a kernel developer.

This needs to be simplified down into a small set of common
patterns. store-release/load-acquire is a simple pattern, especially
for people who understand that unlock-to-lock provides a memory
barrier for the critical section inside the lock. When you explain
that this is a store-release/load-acquire memory ordering pattern,
it's much easier to form a working understanding of the ordering
of operations.

> > If so, can't we just treat this as a normal
> > store-release/load-acquire ordering pattern and hence use more
> > relaxed memory barriers instead of have to patch up what we have now
> > to specifically make ancient platforms that nobody actually uses
> > with weird and unusual memory models work correctly?
> 
> READ_ONCE() is already as relaxed as it can get, as it includes a read data
> dependency barrier only (which is no-op on everything other than Alpha).
> 
> If anything it should be upgraded to smp_load_acquire(), which handles control
> dependencies too.  I didn't see anything obvious in the workqueue code that
> would need that (i.e. accesses to some global structure that isn't transitively
> reachable via the workqueue_struct itself).  But we could use it to be safe if
> we're okay with any performance implications of the additional memory barrier it
> would add.

That's exactly the point I've been trying to make - if people cannot
reason why the code is correct/safe from reading it, then it doesn't
matter how fast it is.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
