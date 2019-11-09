Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40180F61D3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2019 00:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfKIXIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Nov 2019 18:08:25 -0500
Received: from netrider.rowland.org ([192.131.102.5]:45177 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726530AbfKIXIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Nov 2019 18:08:25 -0500
Received: (qmail 31724 invoked by uid 500); 9 Nov 2019 18:08:24 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Nov 2019 18:08:24 -0500
Date:   Sat, 9 Nov 2019 18:08:24 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
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
In-Reply-To: <CAHk-=wgu-QXU83ai4XBnh7JJUo2NBW41XhLWf=7wrydR4=ZP0g@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1911091708150.29750-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 8 Nov 2019, Linus Torvalds wrote:

> On Fri, Nov 8, 2019 at 1:57 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > Can we please agree to call these writes something other than
> > "idempotent"?  After all, any write to normal memory is idempotent in
> > the sense that doing it twice has the same effect as doing it once
> > (ignoring possible races, of course).
> 
> No!
> 
> You're completely missing the point.
> 
> Two writes to normal memory are *not* idempotent if they write
> different values. The ordering very much matters, and it's racy and a
> tool should complain.

What you have written strongly indicates that either you think the word
"idempotent" means something different from its actual meaning or else
you are misusing the word in a very confusing way.

Your text seems to say that two operations are idempotent if they have 
the same effect.  Compare that to the definition from Wikipedia (not 
the best in the world, perhaps, but adequate for this discussion):

	Idempotence is the property of certain operations in
	mathematics and computer science whereby they can be applied
	multiple times without changing the result beyond the initial
	application.

For example, writing 5 to x is idempotent because performing that write
multiple times will have the same result as performing it only once.
Likewise for any write to normal memory.

Therefore talking about idempotent writes as somehow being distinct 
from other writes does not make sense.  Nor does it make sense to say 
"Two writes to normal memory are *not* idempotent if they write
different values", because idempotence is a property of individual 
operations, not of pairs of operations.

You should use a different word, because what you mean is different 
from what "idempotent" actually means.

> But the point of WRITE_IDEMPOTENT() is that it *always* writes the
> same value, so it doesn't matter if two different writers race on it.
> 
> So it really is about being idempotent.

Okay, I agree that I did completely miss the point of what you
originally meant.  But what you meant wasn't "being idempotent".

> > A better name would be "write-if-different" or "write-if-changed"
> 
> No.
> 
> Again,  you're totally missing the point.
> 
> It's not about "write-if-different".
> 
> It's about idempotent writes.

Assuming you really are talking about writes (presumably in different
threads) that store the same value to the same location: Yes, two such
writes do not in practice race with each other -- even though they may
satisfy the formal definition of a data race.

On the other hand, they may each race with other accesses.

> But if you do know that all the possible racing writes are idempotent,
> then AS A POSSIBLE CACHE OPTIMIZATION, you can then say "only do this
> write if somebody else didn't already do it".

In fact, you can _always_ perform that possible optimization.  Whether
it will be worthwhile is a separate matter...

> But that's a side effect of being idempotent, not the basic rule! And
> it's not necessarily obviously an optimization at all, because the
> cacheline may already be dirty, and checking the old value and having
> a conditional on it may be much more expensive than just writing the
> new value./

Agreed.

> The point is that certain writes DO NOT CARE ABOUT ORDERING, because
> they may be setting a sticky flag (or stickily clearing a flag, as in
> this case).  The ordering doesn't matter, because the operation is
> idempotent.

Ah, here you use the word correctly.

> That's what "idempotent" means. You can do it once, or a hundred
> times, and the end result is the same (but is different from not doing
> it at all).

Precisely the point I make above.

> And no, not all writes are idempotent. That's just crazy talk. Writes
> have values.

By "writes have values", do you mean that writes store values?  Of
course they do.  But it is clear from what you wrote just above that
all writes _are_ idempotent, because doing a write once or a hundred
times will yield the same end result.

On a more productive note, do you think we should change the LKMM so 
that it won't consider two writes to race with each other if they store 
the same value?

Alan Stern

