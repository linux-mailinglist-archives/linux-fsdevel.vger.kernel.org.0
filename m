Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21390F6A09
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2019 17:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfKJQJm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Nov 2019 11:09:42 -0500
Received: from netrider.rowland.org ([192.131.102.5]:40195 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726710AbfKJQJm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Nov 2019 11:09:42 -0500
Received: (qmail 30307 invoked by uid 500); 10 Nov 2019 11:09:40 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Nov 2019 11:09:40 -0500
Date:   Sun, 10 Nov 2019 11:09:40 -0500 (EST)
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
In-Reply-To: <CAHk-=wjB61GNmqpX0BLA5tpL4tsjWV7akaTc2Roth7uGgax+mw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1911101034180.29192-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 9 Nov 2019, Linus Torvalds wrote:

> On Sat, Nov 9, 2019, 15:08 Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > On Fri, 8 Nov 2019, Linus Torvalds wrote:
> > >
> > > Two writes to normal memory are *not* idempotent if they write
> > > different values. The ordering very much matters, and it's racy and a
> > > tool should complain.
> >
> > What you have written strongly indicates that either you think the word
> > "idempotent" means something different from its actual meaning or else
> > you are misusing the word in a very confusing way.
> >
> 
> "Idempotence is the property of certain operations in mathematics and
> computer science whereby they can be applied multiple times without
> changing the result beyond the initial application. "
> 
> This is (for example) commonly used when talking about nfs operations,
> where you can re-send the same nfs operation, and it's ok (even if it has
> side effects) because the server remembers that it already did the
> operation. If it's already been done, nothing changes.
> 
> It may not match your definition in some other area, but this is very much
> the accepted meaning of the word in computer science and operating systems.

Agreed.  My point was that you were using the word in a way which did
not match this definition.

Never mind that.  You did not respond to the question at the end of my 
previous email: Should the LKMM be changed so that two writes are not 
considered to race with each other if they store the same value?

That change would take care of the original issue of this email thread,
wouldn't it?  And it would render WRITE_IDEMPOTENT unnecessary.

Making that change would amount to formalizing your requirement that 
the compiler should not invent stores to shared variables.  In C11 such 
invented stores are allowed.  Given something like this:

	<A complex computation which does not involve x but does
	 require a register spill>
	x = 1234;

C11 allows the compiler to store an intermediate value in x rather than
allocating a slot on the stack for the register spill.  After all, x is
going to be overwritten anyway, and if any other thread accessed x
during the complex computation then it would race with the final store
and so the behavior would be undefined in any case.

If you want to specifically forbid the compiler from doing this, it
makes sense to change the memory model accordingly.

For those used to thinking in terms of litmus tests, consider this one:

C equivalent-writes

{}

P0(int *x)
{
	*x = 1;
}

P1(int *x)
{
	*x = 1;
}

exists (~x=1)

Should the LKMM say that this litmus test contains a race?

This suggests that we might also want to relax the notion of a write
racing with a read, although in that case I'm not at all sure what the
appropriate change to the memory model would be.  Something along the
lines of: If a write W races with a read R, but W stores the same value
that R would have read if W were not present, then it's not really a
race.  But of course this is far too vague to be useful.

Alan Stern

