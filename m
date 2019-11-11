Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02EEAF780D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 16:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKKPvM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 10:51:12 -0500
Received: from netrider.rowland.org ([192.131.102.5]:40563 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726893AbfKKPvM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:51:12 -0500
Received: (qmail 14399 invoked by uid 500); 11 Nov 2019 10:51:11 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Nov 2019 10:51:11 -0500
Date:   Mon, 11 Nov 2019 10:51:11 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Marco Elver <elver@google.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
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
In-Reply-To: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 10 Nov 2019, Marco Elver wrote:

> On Sun, 10 Nov 2019 at 17:09, Alan Stern <stern@rowland.harvard.edu> wrote:
...

> > For those used to thinking in terms of litmus tests, consider this one:
> >
> > C equivalent-writes
> >
> > {}
> >
> > P0(int *x)
> > {
> >         *x = 1;
> > }
> >
> > P1(int *x)
> > {
> >         *x = 1;
> > }
> >
> > exists (~x=1)
> >
> > Should the LKMM say that this litmus test contains a race?
> >
> > This suggests that we might also want to relax the notion of a write
> > racing with a read, although in that case I'm not at all sure what the
> > appropriate change to the memory model would be.  Something along the
> > lines of: If a write W races with a read R, but W stores the same value
> > that R would have read if W were not present, then it's not really a
> > race.  But of course this is far too vague to be useful.
> 
> What if you introduce to the above litmus test:
> 
> P2(int *x) { *x = 2; }

Then clearly the test _would_ contain a data race.

> How can a developer, using the LKMM as a reference, hope to prove
> their code is free from data races without having to enumerate all
> possible values a variable could contain (in addition to all possible
> interleavings)?

Well, for one thing the new rule doesn't say anything about all
possible values a variable could contain; it only talks about the
values of a pair of concurrent writes.  Of course, this would still
require you to be aware of (if not to fully enumerate) all possible
values a write could store, so perhaps it's not much of an improvement.

On the other hand, one way to prove your code is data-race-free under
the revised LKMM would be to show that it is data-race-free under the
original (i.e., current) LKMM.  Then you wouldn't have to enumerate any
lists of possible values.

> I view introducing data value dependencies, for the sake of allowing
> more programs, to a language memory model as a slippery slope, and am
> not aware of any precedent where this worked out. The additional
> complexity in the memory model would put a burden on developers and
> the compiler that is unlikely to be a real benefit (as you pointed
> out, the compiler may even need to disable some transformations).

This may be so.  But if the resulting model is a better match to the
way kernel developers think about their code, wouldn't it be
appropriate?

>  From
> a practical point of view, if the LKMM departs further and further
> from C11's memory model, how do we ensure all compilers do the right
> thing?

Linus has already committed to doing this.  To quote the latest example
(from a message he posted shortly after yours):

	I don't care one whit about C11. Made-up stores to shared data
	are not acceptable. Ever. We will turn that off with a compiler
	switch if the compiler thinks it can do them, the same way we
	turn off other incorrect optimizations like the type-based
	aliasing or the insane "signed integer arithmetic can have
	undefined behavior" stupidity that the standards people
	allowed.

Given that the kernel _requires_ compilers to behave this way, 
shouldn't the LKMM reflect this requirement?

> My vote would go to explicit annotation, not only because it reduces
> hidden complexity, but also because it makes the code more
> understandable, for developers and tooling. As an additional point, I
> find the original suggestion to add WRITE_ONCE to be the least bad (or
> some other better named WRITE_). Consider somebody changing the code,
> changing the semantics and the values written to "non_rcu". With a
> WRITE_ONCE, the developer would be clear about the fact that the write
> can happen concurrently, and ensure new code is written with the
> assumption that concurrent writes can happen.

I dislike the explicit annotation approach, because it shifts the
burden of proving correctness from the automatic verifier to the
programmer.  Let's take the litmus test above as example.  I could
annotate it to read:

P0(int *x) { WRITE_IDEMPOTENT(*x, 1); }
P1(int *x) { WRITE_IDEMPOTENT(*x, 1); }

and then KCSAN would take my word for it that the two writes don't race
with each other (or if they do race, it doesn't matter).  But now if
the code was changed by adding:

P2(int *x) { WRITE_IDEMPOTENT(*x, 2); }

then KCSAN would still believe there was no race, meaning it would be
up to me to audit all possible writes to x to make sure they store the
same value.  That is not how automated tooling should work.

Alan Stern

