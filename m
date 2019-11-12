Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDF0F9977
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 20:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKLTON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 14:14:13 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:35124 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725997AbfKLTON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:14:13 -0500
Received: (qmail 5389 invoked by uid 2102); 12 Nov 2019 14:14:12 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Nov 2019 14:14:12 -0500
Date:   Tue, 12 Nov 2019 14:14:12 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Marco Elver <elver@google.com>, Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
In-Reply-To: <CAHk-=wjErHCwkcgO-=NReU0KR4TFozrFktbhh2rzJ=mPgRO0-g@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1911121400200.1567-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 10 Nov 2019, Linus Torvalds wrote:

> So I do think LKMM should say "writes of the same value must obviously
> result in the same value in memory afterwards", if it doesn't already.
> That's a somewhat trivial case, it's just a special case of the
> single-value atomicity issue. I thought the LKMM had that already: if
> you have writes of 'x' and 'y' to a variable from two CPU's, all CPU's
> are supposed to see _either_ 'x' or 'y', they can't ever see a mix of
> the two.

Not exactly -- the LKMM says if you have concurrent plain writes of 'x'
and 'y' to a variable from two CPUs then the writes race, and in the
presence of a data race the LKMM doesn't guarantee anything.  This may
not be the best approach, but it was all we could realistically come up
with.

Of course, if you have concurrent non-plain writes, including things
like WRITE_ONCE(), then indeed the LKMM does say that all CPUs using
non-plain reads will see either 'x' or 'y', nothing else.

> And yes, we've depended on that single-value atomicity historically.
> 
> The 'x' and 'y' have the same value is just a special case of that
> general issue - if two threads write the same value, no CPU can ever
> see anything but that value (or the original one). So in that sense,
> fundamentally the same value write cannot race with itself.

I'm starting to think that this issue is only one aspect of a whole 
larger discussion...

> But that LKMM rule is separate from a rule about a statistical tool like KCSAN.
> 
> Should KCSAN then ignore writes of the same value?
> 
> Maybe.
> 
> Because while that "variable++" data race with the same value is real,
> the likelihood of hitting it is small, so a statistical tool like
> KCSAN might as well ignore it - the tool would show the data race when
> the race _doesn't_ happen, which would be the normal case anyway, and
> would be the reason why the race hadn't been noticed by a normal human
> being.

That's not how KCSAN works, if I understand it correctly.  It never 
shows races that don't happen -- the only way it knows a race is 
present is by statistically waiting to see that one has occurred.

> So practically speaking, we might say "concurrent writes of the same
> value aren't data races" for KCSAN, even though they _could_ be data
> races.
> 
> And this is where WRITE_IDEMPOTENT would make a possible difference.
> In particular, if we make the optimization to do the "read and only
> write if changed", two CPU's doing this concurrently would do
> 
>    READ 0
>    WRITE 1
> 
> (for a "flag goes from 0->1" transition) and from a tool perspective,
> it would be very hard to know whether this is a race (two threads
> doing "variable++") or not (two threads setting a sticky flag).
> 
> So WRITE_IDEMPOTENT would then disambiguate that choice. See what I'm saying?

Let me broaden the discussion.  Concurrent writes of the same value are 
only one type of example; the kernel has plenty of other low-level 
races.

One could be the thing you brought up earlier: Suppose the compiler
decides to use the "write only if changed" transformation, so that the
code generated for the sticky write:

	x = 1;

ends up being what you would expect to see for:

	if (x != 1)
		x = 1;

Then two CPUs executing this code concurrently could still be flagged
as racing by KCSAN -- if not because of the writes then because the
read on one CPU would be perceived as racing with the write on the
other!

So changing the LKMM to say that concurrent writes of the same value 
don't race will only fix a part of the overall problem.

What we really need is a way to tell KCSAN that yes, we know certain 
accesses can race with each other at the hardware level, but at the 
source level we don't care (and we don't want KCSAN to complain about 
those accesses).  A good example is an approximate counter.  If we 
don't care whether the total sum is exactly correct then we don't mind 
if a few counts get lost because two CPUs executing

	x++;

happened to race with each other.

What we _do_ care about in these situations is:

	These accesses should be atomic (a 64-bit increment on a
	32-bit architecture really could run into trouble if there 
	was a race);

	The accesses should not write to memory outside the variable
	they affect (an architecture incapable of doing 16-bit writes
	should not do a 32-bit load/mask/store);

	The code should behave gracefully in the presence of hardware
	races (no C11 undefined behavior!);

	The object code generated by the compiler shouldn't stink.

And probably a few other things that escape me at the moment.  

READ_ONCE and WRITE_ONCE provide all of those guarantees except the
last one.  Normal reads and writes aren't suitable because of the
third requirement (and maybe the first).

But what about C11 relaxed atomic reads and writes?  They are what the
compiler writers _expect_ people to use in situations like this.  Do
you happen to know whether gcc is any good with them?  It might make
sense to define WRITE_RELAXED and READ_RELAXED analogously to
WRITE_ONCE and READ_ONCE but in terms of relaxed atomic accesses
instead of volatile accesses.

Alan Stern

