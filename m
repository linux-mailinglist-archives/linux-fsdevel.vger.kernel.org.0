Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A7222120E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 18:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgGOQNq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 12:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:32850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgGOQNp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:13:45 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F93120663;
        Wed, 15 Jul 2020 16:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594829624;
        bh=IJsMkoevTsx6L9HNxlWZDWP3nwinEoBjxQZqDR3QAYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N0z0tBQotG8LArmmiAePX5kmgXENP4UAKHIg9UhO1qGZPrV8Ilw+LOIpBvIm+VROW
         AoElmez3OskjYxnq2+b63SuxSI83F+O+C3V4lqsRfNbW0Dqvog97lsMD/99y4sRwB+
         FhOZI9bPxybyBjGn3THjrB6bMu7VYjNnUaTHySQw=
Date:   Wed, 15 Jul 2020 09:13:42 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fs/direct-io: avoid data race on ->s_dio_done_wq
Message-ID: <20200715161342.GA1167@sol.localdomain>
References: <20200713033330.205104-1-ebiggers@kernel.org>
 <20200715013008.GD2005@dread.disaster.area>
 <20200715023714.GA38091@sol.localdomain>
 <20200715080144.GF2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715080144.GF2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 06:01:44PM +1000, Dave Chinner wrote:
> > > >  /* direct-io.c: */
> > > > -int sb_init_dio_done_wq(struct super_block *sb);
> > > > +int __sb_init_dio_done_wq(struct super_block *sb);
> > > > +static inline int sb_init_dio_done_wq(struct super_block *sb)
> > > > +{
> > > > +	/* pairs with cmpxchg() in __sb_init_dio_done_wq() */
> > > > +	if (likely(READ_ONCE(sb->s_dio_done_wq)))
> > > > +		return 0;
> > > > +	return __sb_init_dio_done_wq(sb);
> > > > +}
> > > 
> > > Ummm, why don't you just add this check in sb_init_dio_done_wq(). I
> > > don't see any need for adding another level of function call
> > > abstraction in the source code?
> > 
> > This keeps the fast path doing no function calls and one fewer branch, as it was
> > before.  People care a lot about minimizing direct I/O overhead, so it seems
> > desirable to keep this simple optimization.  Would you rather it be removed?
> 
> No.
> 
> What I'm trying to say is that I'd prefer fast path checks don't get
> hidden away in a static inline function wrappers that require the
> reader to go look up code in a different file to understand that
> code in yet another different file is conditionally executed.
> 
> Going from obvious, easy to read fast path code to spreading the
> fast path logic over functions in 3 different files is not an
> improvement in the code - it is how we turn good code into an
> unmaintainable mess...

The alternative would be to duplicate the READ_ONCE() at all 3 call sites --
including the explanatory comment.  That seems strictly worse.

And the code before was broken, so I disagree it was "obvious" or "good".

> 
> > > Also, you need to explain the reason for the READ_ONCE() existing
> > > rather than just saying "it pairs with <some other operation>".
> > > Knowing what operation it pairs with doesn't explain why the pairing
> > > is necessary in the first place, and that leads to nobody reading
> > > the code being able to understand what this is protecting against.
> > > 
> > 
> > How about this?
> > 
> > 	/*
> > 	 * Nothing to do if ->s_dio_done_wq is already set.  But since another
> > 	 * process may set it concurrently, we need to use READ_ONCE() rather
> > 	 * than a plain read to avoid a data race (undefined behavior) and to
> > 	 * ensure we observe the pointed-to struct to be fully initialized.
> > 	 */
> > 	if (likely(READ_ONCE(sb->s_dio_done_wq)))
> > 		return 0;
> 
> You still need to document what it pairs with, as "data race" doesn't
> describe the actual dependency we are synchronising against is.
> 
> AFAICT from your description, the data race is not on
> sb->s_dio_done_wq itself, but on seeing the contents of the
> structure being pointed to incorrectly. i.e. we need to ensure that
> writes done before the cmpxchg are ordered correctly against
> reads done after the pointer can be seen here.
> 

No, the data race is on ->s_dio_done_wq itself.  How about this:

        /*
         * Nothing to do if ->s_dio_done_wq is already set.  The READ_ONCE()
         * here pairs with the cmpxchg() in __sb_init_dio_done_wq().  Since the
         * cmpxchg() may set ->s_dio_done_wq concurrently, a plain load would be
         * a data race (undefined behavior), so READ_ONCE() is needed.
         * READ_ONCE() also includes any needed read data dependency barrier to
         * ensure that the pointed-to struct is seen to be fully initialized.
         */

FWIW, long-term we really need to get developers to understand these sorts of
issues, so that the code is written correctly in the first place and we don't
need to annotate common patterns like one-time-init with a long essay and have a
long discussion.  Recently KCSAN was merged upstream
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/dev-tools/kcsan.rst)
and the memory model documentation was improved
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/explanation.txt?h=v5.8-rc5#n1922),
so hopefully that will raise awareness...

> If so, can't we just treat this as a normal
> store-release/load-acquire ordering pattern and hence use more
> relaxed memory barriers instead of have to patch up what we have now
> to specifically make ancient platforms that nobody actually uses
> with weird and unusual memory models work correctly?

READ_ONCE() is already as relaxed as it can get, as it includes a read data
dependency barrier only (which is no-op on everything other than Alpha).

If anything it should be upgraded to smp_load_acquire(), which handles control
dependencies too.  I didn't see anything obvious in the workqueue code that
would need that (i.e. accesses to some global structure that isn't transitively
reachable via the workqueue_struct itself).  But we could use it to be safe if
we're okay with any performance implications of the additional memory barrier it
would add.

- Eric
