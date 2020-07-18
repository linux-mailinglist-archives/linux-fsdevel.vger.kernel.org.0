Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970ED2247D9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 03:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgGRBmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 21:42:13 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:37778 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726710AbgGRBmM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 21:42:12 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 2D677D7AA03;
        Sat, 18 Jul 2020 11:42:05 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jwbrY-0002AX-Dz; Sat, 18 Jul 2020 11:42:04 +1000
Date:   Sat, 18 Jul 2020 11:42:04 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Message-ID: <20200718014204.GN5369@dread.disaster.area>
References: <20200717044427.68747-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717044427.68747-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
        a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=8yHV2tFA8b4t9lnhJkUA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 09:44:27PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The "one-time init" pattern is implemented incorrectly in various places
> in the kernel.  And when people do try to implement it correctly, it is
> unclear what to use.  Try to give some proper guidance.
> 
> This is motivated by the discussion at
> https://lkml.kernel.org/linux-fsdevel/20200713033330.205104-1-ebiggers@kernel.org/T/#u
> regarding fixing the initialization of super_block::s_dio_done_wq.

You're still using words that the target audience of the
documentation will not understand.

This is known as the "curse of knowledge" cognative bias, where
subject matter experts try to explain something to non-experts using
terms only subject matter experts understand....

This is one of the reasons that the LKMM documetnation is so damn
difficult to read and understand: just understanding the vocabulary
it uses requires a huge learning curve, and it's not defined
anywhere. Understanding the syntax of examples requires a huge
learning curve, because it's not defined anywhere. 

Recipes are *not useful* if you need to understand the LKMM
documenation to select the correct recipe to use. Recipes are not
useful if you say "here's 5 different variations of the same thing,
up to you to understand which one you need to use". Recipes are not
useful if changes in other code can silently break the recipe that
was selected by the user by carefully considering the most optimal
variant at the time they selected it.

i.e. Recipes are not for experts who understand the LKMM - recipes
are for developers who don't really understand how the LKMM all
works and just want a single, solid, reliable pattern they can use
just about everywhere for that specific operation.

Performance and optimisation doesn't even enter the picture here -
we need to provide a simple, easy to use and understand pattern that
just works. We need to stop making this harder than it should be.

So....

> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  tools/memory-model/Documentation/recipes.txt | 151 +++++++++++++++++++
>  1 file changed, 151 insertions(+)
> 
> diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
> index 7fe8d7aa3029..04beb06dbfc7 100644
> --- a/tools/memory-model/Documentation/recipes.txt
> +++ b/tools/memory-model/Documentation/recipes.txt
> @@ -519,6 +519,157 @@ CPU1 puts the waiting task to sleep and CPU0 fails to wake it up.
>  
>  Note that use of locking can greatly simplify this pattern.
>  
> +One-time init
> +-------------
> +
> +The "one-time init" pattern is when multiple tasks can race to
> +initialize the same data structure(s) on first use.
> +
> +In many cases, it's best to just avoid the need for this by simply
> +initializing the data ahead of time.
> +
> +But in cases where the data would often go unused, one-time init can be
> +appropriate to avoid wasting kernel resources.  It can also be
> +appropriate if the initialization has other prerequisites which preclude
> +it being done ahead of time.
> +
> +First, consider if your data has (a) global or static scope, (b) can be
> +initialized from atomic context, and (c) cannot fail to be initialized.
> +If all of those apply, just use DO_ONCE() from <linux/once.h>:
> +
> +	DO_ONCE(func);
> +
> +If that doesn't apply, you'll have to implement one-time init yourself.
> +
> +The simplest implementation just uses a mutex and an 'inited' flag.
> +This implementation should be used where feasible:
> +
> +	static bool foo_inited;
> +	static DEFINE_MUTEX(foo_init_mutex);
> +
> +	int init_foo_if_needed(void)
> +	{
> +		int err = 0;
> +
> +		mutex_lock(&foo_init_mutex);
> +		if (!foo_inited) {
> +			err = init_foo();
> +			if (err == 0)
> +				foo_inited = true;
> +		}
> +		mutex_unlock(&foo_init_mutex);
> +		return err;
> +	}
> +
> +The above example uses static variables, but this solution also works
> +for initializing something that is part of another data structure.  The
> +mutex may still be static.

All good up to here - people will see this and understand that this
is the pattern they want to use, and DO_ONCE() is a great, simple
API that is easy to use.

What needs to follow is a canonical example of how to do it
locklessly and efficiently, without describing conditional use of it
using words like "initialised memory is transitively reachable" (I
don't know WTF that means!).  Don't discuss potential optimisations,
control flow/data dependencies, etc, because failing to understand
those details are the reason people are looking for a simple recipe
that does what they need in the first place ("curse of knowledge").

However, I think the whole problem around code like this is that it
is being open-coded and that is the reason people get it wrong.
Hence I agree with Willy that this needs to be wrapped in a simple,
easy to use and hard to get wrong APIs for the patterns we expect to
see people use.

And the recipes should doucment the use of that API for the
init-once pattern, not try to teach people how to open-code their
own init-once pattern that they will continue to screw up....

As a result, I think the examples should document correct use of the
API for the two main variants it would be used for. The first
variant has an external "inited" flag that handles multiple
structure initialisations, and the second variant handles allocation
and initialisation of a single structure that is stored and accessed
by a single location.

Work out an API to do these things correctly, then write the recipes
to use them. Then people like yourself can argue all day and night
on how to best optimise them, and people like myself can just ignore
that all knowing that my init_once() call will always do the right
thing.

> +For the single-pointer case, a further optimized implementation
> +eliminates the mutex and instead uses compare-and-exchange:
> +
> +	static struct foo *foo;
> +
> +	int init_foo_if_needed(void)
> +	{
> +		struct foo *p;
> +
> +		/* pairs with successful cmpxchg_release() below */
> +		if (smp_load_acquire(&foo))
> +			return 0;
> +
> +		p = alloc_foo();
> +		if (!p)
> +			return -ENOMEM;
> +
> +		/* on success, pairs with smp_load_acquire() above and below */
> +		if (cmpxchg_release(&foo, NULL, p) != NULL) {
> +			free_foo(p);
> +			/* pairs with successful cmpxchg_release() above */
> +			smp_load_acquire(&foo);

This is the failure path, not the success. So it describing it as
pairing with "successful cmpxchg_release() above" when the code that
is executing is in the path where  the cmpxchg_release() above -just
failed- doesn't help anyone understand exactly what it is pairing
with.

This is why I said in that other thread "just saying 'pairs with
<foo>' is not sufficient to explain to the reader exactly what the
memory barrier is doing. You needed two full paragraphs to explain
why this was put here and that, to me, indicate the example and
expected use case is wrong.

But even then, I think this example is incorrect and doesn't fit the
patterns people might expect. That is, if this init function
-returned foo for the caller to use-, then the smp_load_acquire() on
failure is necessary to ensure the initialisation done by the racing
context is correct seen. But this function doesn't return foo, and
so the smp_load_acquire() is required in whatever context is trying
to access the contents of foo, not the init function.

Hence I think this example is likely incorrect and will lead to bugs
because it does not, in any way, indicate that
smp_load_acquire(&foo) must always be used in the contexts where foo
may accessed before (or during) the init function has been run...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
