Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B89D4F9AB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 21:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfKLU3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 15:29:42 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:35202 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727176AbfKLU3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:29:42 -0500
Received: (qmail 5845 invoked by uid 2102); 12 Nov 2019 15:29:40 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Nov 2019 15:29:40 -0500
Date:   Tue, 12 Nov 2019 15:29:40 -0500 (EST)
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
In-Reply-To: <CAHk-=wjGd0Ce2xadkiErPWxVBT2mhyeZ4TKyih2sJwyE3ohdHw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1911121515400.1567-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 12 Nov 2019, Linus Torvalds wrote:

> On Tue, Nov 12, 2019 at 11:14 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > One could be the thing you brought up earlier: Suppose the compiler
> > decides to use the "write only if changed" transformation, so that the
> > code generated for the sticky write:
> >
> >         x = 1;
> >
> > ends up being what you would expect to see for:
> >
> >         if (x != 1)
> >                 x = 1;
> 
> That is exactly the kind of  crap that would make me go "use the flag
> to disable that invalid optimization, or don't use the compiler".
> 
> We already do -param=allow-store-data-races=0
> 
> The C standards body sadly has a very bad track record on this kind of
> thing, where they have allowed absolutely insane extensions of "that's
> undefined" in the name of making C a much worse language (they say "to
> compete with Fortran", but it's the same thing).
> 
> I have talked to some people who have tried to change that course, but
> they are fed up with the standards body too, and it's fighting
> windmills.
> 
> Which is why I don't even  bother. The C standard language-lawyering
> is simply not interesting to me. Yes, there are too many people who do
> it, and I don't care.
> 
> For the kernel, we basically do not accept "that's undefined behavior,
> I might generate odd code".
> 
> If the compiler can statitcally give an error for it, then that's one
> thing, and we'd be ok with that. But the kind of mindset where people
> think it's ok to have the compiler read the standard cross-eyed and
> change the obvious meaning of the code "because it's undefined
> behavior" is to me a sign of a cn incompetent compiler writer, and I
> am not at all interested in playing that game.
> 
> Seriously.
> 
> I wish somebody on the C standard had the back-bone to say "undefined
> behavior is not acceptable", and just say that the proper
> optimizations are ones where you transform the code the obvious
> straightforward way, and then you only do optimizations that are based
> on that code and you can prove do not change semantics.
> 
> You can't add reads that weren't there.
> 
> But you can look at code that did a read, and then wrote back what you
> can prove is the same value, and say "that write is redundant, just
> looking at the code".
> 
> See the difference?
> 
> One approach makes up shit. The other approach looks at the code AS
> WRITTEN and can prove "that's stupid, I can do it better, and I can
> show why it makes no difference".
> 
> So you can change "i++; i++;" to "i +=2", even if "i" is not a private
> variable. Did that remove a write? Yes it did. But it really falls
> under the "I just improved on the code".
> 
> But you can *not* do the insane things that type-based aliasing do
> (lack the "prove it's the same" part).
> 
> Because when we notice that in the kernel, we turn it off. It's why we have
> 
>  -fno-strict-overflow
>  -fno-merge-all-constants
>  -fno-strict-aliasing
>  -fno-delete-null-pointer-checks
>  --param=allow-store-data-races=0
> 
> and probably others. Because the standard is simply wrong when you
> care about reliability.
> 
> > But what about C11 relaxed atomic reads and writes?
> 
> Again, I'm not in the least interested in the C11 standard
> language-lawyering, because it has shown itself to not be useful.
> 
> Stop bringing up the "what if" cases. They aren't interesting. If a
> compiler turns a single write into some kind of conditional write, or
> if the compiler creates dummy writes, the compiler is garbage. No
> amount of "but but but C11" is at all relevant.
> 
> What a compiler can do is:
> 
>  - generate multiple (and speculative) reads
> 
>  - combine writes to the same location (non-speciulatively)
> 
>  - take advantage of actual reads in the source code to do
> transformations that are obvious (ie "oh, you read value X, you tested
> by Y was set, now you write it back again, but clearly the value
> didn't change so I can avoid the write").
> 
> so yes, a compiler can remove a _redundant_ write, and if the SOURCE
> CODE has the read in it and the compiler decides "Oh, I already know
> it has that value" then that's one thing.
> 
> But no, the compiler can not add data races that weren't there in the
> source code and say "but C11". We're not compiling to the standard.
> We're compiling to the real world.
> 
> So if the compiler just adds its own reads, I don't want to play with
> that compiler. It may be appropriate in situations where we don't have
> threads, we don't have security issues, and we don't have various
> system and kernel concerns, but it's not appropriate for a kernel.
> 
> It really is that simple.
> 
> This is in no way different from other language lawyering, ie the
> whole "signed arithmetic overflows are undefined, so i can do
> optimization X" or "I can silently remove the NULL pointer check
> because you accessed it before and that invoced undefined behavior, so
> now I can do anthing".
> 
> Those optimizations may be valid in other projects. They are not valid
> for the kernel.
> 
> Stop bringing them up. They are irrelevant. We will keep adding the
> options to tell the compiler "no, we're not your toy benchmark, we do
> real work, and that optimization is dangerous".

Linus, calm down and read what I actually wrote.  That optimization was 
a straw man.

I'm trying to solve a real problem: How to tell KCSAN and the compiler
that we don't care about certain access patterns which result in
hardware-level races, and how to guarantee that the object code will
still work correctly when those races occur.  Not telling the compiler 
anything is a head-in-the-sand approach that will be dangerous in the 
long run.

We could annotate all those accesses with READ_ONCE/WRITE_ONCE.  You 
don't like this approach, mainly because gcc produces lousy object code 
for volatile accesses.

My question was whether gcc does a better job with C11 relaxed atomic
accesses.  If it does we could define READ_RELAXED/WRITE_RELAXED
analogously to READ_ONCE/WRITE_ONCE, and do the annotations that way.  
The resulting object code certainly ought to be robust against races,
but I don't know what the quality would be like.

On the other hand, if the compiler generates lousy code even for C11 
relaxed atomic accesses, you've got a good case to go complain to the 
GCC maintainers about.  They can't say they don't want to support such 
things, because it's in the spec.

Alan Stern

