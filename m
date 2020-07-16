Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D859221E03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgGPIQY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:16:24 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:58959 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbgGPIQX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:16:23 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 8A3F71A942D;
        Thu, 16 Jul 2020 18:16:18 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jvz3w-0004EU-EV; Thu, 16 Jul 2020 18:16:16 +1000
Date:   Thu, 16 Jul 2020 18:16:16 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fs/direct-io: avoid data race on ->s_dio_done_wq
Message-ID: <20200716081616.GM5369@dread.disaster.area>
References: <20200713033330.205104-1-ebiggers@kernel.org>
 <20200715013008.GD2005@dread.disaster.area>
 <20200715023714.GA38091@sol.localdomain>
 <20200715080144.GF2005@dread.disaster.area>
 <20200715161342.GA1167@sol.localdomain>
 <20200716014656.GJ2005@dread.disaster.area>
 <20200716024717.GJ12769@casper.infradead.org>
 <20200716053332.GH1167@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716053332.GH1167@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=PuJr3C3hJH1ja2Oo6fIA:9
        a=bOA-3-YMxWdk0kr0:21 a=WW9XynqRKrwYVvAG:21 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 10:33:32PM -0700, Eric Biggers wrote:
> On Thu, Jul 16, 2020 at 03:47:17AM +0100, Matthew Wilcox wrote:
> > On Thu, Jul 16, 2020 at 11:46:56AM +1000, Dave Chinner wrote:
> > > And why should we compromise performance on hundreds of millions of
> > > modern systems to fix an extremely rare race on an extremely rare
> > > platform that maybe only a hundred people world-wide might still
> > > use?
> > 
> > I thought that wasn't the argument here.  It was that some future
> > compiler might choose to do something absolutely awful that no current
> > compiler does, and that rather than disable the stupid "optimisation",
> > we'd be glad that we'd already stuffed the source code up so that it
> > lay within some tortuous reading of the C spec.
> > 
> > The memory model is just too complicated.  Look at the recent exchange
> > between myself & Dan Williams.  I spent literally _hours_ trying to
> > figure out what rules to follow.
> > 
> > https://lore.kernel.org/linux-mm/CAPcyv4jgjoLqsV+aHGJwGXbCSwbTnWLmog5-rxD2i31vZ2rDNQ@mail.gmail.com/
> > https://lore.kernel.org/linux-mm/CAPcyv4j2+7XiJ9BXQ4mj_XN0N+rCyxch5QkuZ6UsOBsOO1+2Vg@mail.gmail.com/
> > 
> > Neither Dan nor I are exactly "new" to Linux kernel development.  As Dave
> > is saying here, having to understand the memory model is too high a bar.
> > 
> > Hell, I don't know if what we ended up with for v4 is actually correct.
> > It lokos good to me, but *shrug*
> > 
> > https://lore.kernel.org/linux-mm/159009507306.847224.8502634072429766747.stgit@dwillia2-desk3.amr.corp.intel.com/
> 
> Looks like you still got it wrong :-(  It needs:
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 934c92dcb9ab..9a95fbe86e15 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -1029,7 +1029,7 @@ static int devmem_init_inode(void)
>         }
> 
>         /* publish /dev/mem initialized */
> -       WRITE_ONCE(devmem_inode, inode);
> +       smp_store_release(&devmem_inode, inode);
> 
>         return 0;
>  }
> 
> It seems one source of confusion is that READ_ONCE() and WRITE_ONCE() don't
> actually pair with each other, unless no memory barriers are needed at all.
> 
> Instead, READ_ONCE() pairs with a primitive that has "release" semantics, e.g.
> smp_store_release() or cmpxchg_release(). But READ_ONCE() is only correct if
> there's no control flow dependency; if there is, it needs to be upgraded to a
> primitive with "acquire" semantics, e.g. smp_load_acquire().

You lost your audience at "control flow dependency". i.e. you're
trying to explain memory ordering requirements by using terms that
only people who deeply grok memory ordering understand.

I can't tell you what a control flow dependency is off the top
of my head - I'd have to look up the documentation to remind myself
what it means and why it might be important. Then I'll realise yet
again that if I just use release+acquire message passing constructs,
I just don't have to care about them. And so I promptly forget about
them again.

My point is that the average programmer does not need to know what a
control flow or data depedency is to use memory ordering semantics
correctly. If you want to optimise your code down to the Nth degree
then you *may* need to know that, but almost nobody in the kernel
needs to optimise their code to that extent.

> The best approach might be to just say that the READ_ONCE() + "release" pairing
> should be avoided, and we should stick to "acquire" + "release".  (And I think
> Dave may be saying he'd prefer that for ->s_dio_done_wq?)

Pretty much.

We need to stop thinking of these synchronisation primitives as
"memory ordering" or "memory barriers" or "atomic access" and
instead think of them as tools to pass data safely between concurrent
threads.

We need to give people a simple mental model and/or pattern for
passing data safely between two racing threads, not hit them over
the head with the LKMM documentation. People are much more likely to
understand the ordering and *much* less likely to make mistakes
given clear, simple examples to follow. And that will stick if you
can relate those examples back to the locking constructs they
already understand and have been using for years.

e.g. basic message passing. foo = 0 is the initial message state, y
is the mail box flag, initially 0/locked:

			locking:	ordered code:

write message:		foo = 1		foo = 1
post message:		spin_unlock(y)	smp_store_release(y, 1)

check message box:	spin_lock(y)	if (smp_load_acquire(y) == 1)
got message:		print(foo)		print(foo)

And in both cases we will always get "foo = 1" as the output of
both sets of code. i.e. foo is the message, y is the object that
guarantees delivery of the message.

This makes the code Willy linked to obvious. The message to be
delivered is the inode and it's contents, and it is posted via
the devmem_inode. Hence:

write message:		inode = alloc_anon_inode()
post message:		smp_store_release(&devmem_inode, inode);

check message box:	inode = smp_load_acquire(&devmem_inode);
got message?		if (!inode)
    no				<fail>
   yes			<message contents guaranteed to be seen>

To someone familiar with message passing patterns, this code almost
doesn't need comments to explain it.

Using memory ordering code becomes much simpler when we think of it
as a release+acquire pattern rather than "READ_ONCE/WRITE_ONCE plus
(some set of) memory barriers" because it explicitly lays out the
ordering requirements of the code on both sides of the pattern.
Once a developer creates a mental association between the
release+acquire message passing mechanism and critical section
ordering defined by unlock->lock operations, ordering becomes much
less challenging to think and reason about.

Part of the problem is that RO/WO are now such overloaded operators
it's hard to understand all the things they do or discriminate
between which function a specific piece of code is relying on.

IMO, top level kernel developers need to stop telling people "you
need to understand the lkmm and/or memory_barriers.txt" like it's
the only way to write safe concurrent code. The reality is that most
devs don't need to understand it at all.  We'll make much more
progress on fixing broken code and having new code being written
correctly by teaching people simple patterns that are easy to
explain, easy to learn, *hard to get wrong* and easy to review. And
then they'll use them in places where they'd previously not care
about data races because they have been taught "this is the way we
should write concurrent code". They'll never learn that from being
told to read the LKMM documentation....

So if you find yourself using the words "LKMM", "control flow",
"data dependency", "compiler optimisation" or other intricate
details or the memory model, then you've already lost your
audience....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
