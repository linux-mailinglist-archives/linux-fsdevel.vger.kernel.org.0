Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55AD221A2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 04:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgGPCj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 22:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgGPCj7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 22:39:59 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 726D420775;
        Thu, 16 Jul 2020 02:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594867198;
        bh=j/hoiMBoGyR7vawRZBB/BhJA92ztWmhMeUJTQ0begzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qeeGc1q3OAYCfrn9he6sMqvRS0BMg9EXaQjOMohKediMdjzM+XFHyizC2Jib9FDIf
         3qEz9HN9mSUTa9BfTvw5Z8jTP4Gj6gg1QnlssCrY746cTXzBII3d1LPPkJW9PhZe9C
         KTdSHhzzCCsX3yJhZVoAoYsbDw8u3aZzy4AKI5qg=
Date:   Wed, 15 Jul 2020 19:39:57 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fs/direct-io: avoid data race on ->s_dio_done_wq
Message-ID: <20200716023957.GD1167@sol.localdomain>
References: <20200713033330.205104-1-ebiggers@kernel.org>
 <20200715013008.GD2005@dread.disaster.area>
 <20200715023714.GA38091@sol.localdomain>
 <20200715080144.GF2005@dread.disaster.area>
 <20200715161342.GA1167@sol.localdomain>
 <20200716014656.GJ2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716014656.GJ2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:46:56AM +1000, Dave Chinner wrote:
> > > > > Also, you need to explain the reason for the READ_ONCE() existing
> > > > > rather than just saying "it pairs with <some other operation>".
> > > > > Knowing what operation it pairs with doesn't explain why the pairing
> > > > > is necessary in the first place, and that leads to nobody reading
> > > > > the code being able to understand what this is protecting against.
> > > > > 
> > > > 
> > > > How about this?
> > > > 
> > > > 	/*
> > > > 	 * Nothing to do if ->s_dio_done_wq is already set.  But since another
> > > > 	 * process may set it concurrently, we need to use READ_ONCE() rather
> > > > 	 * than a plain read to avoid a data race (undefined behavior) and to
> > > > 	 * ensure we observe the pointed-to struct to be fully initialized.
> > > > 	 */
> > > > 	if (likely(READ_ONCE(sb->s_dio_done_wq)))
> > > > 		return 0;
> > > 
> > > You still need to document what it pairs with, as "data race" doesn't
> > > describe the actual dependency we are synchronising against is.
> > > 
> > > AFAICT from your description, the data race is not on
> > > sb->s_dio_done_wq itself, but on seeing the contents of the
> > > structure being pointed to incorrectly. i.e. we need to ensure that
> > > writes done before the cmpxchg are ordered correctly against
> > > reads done after the pointer can be seen here.
> > > 
> > 
> > No, the data race is on ->s_dio_done_wq itself.  How about this:
> 
> Then we -just don't care- that it races because false negatives call
> into sb_init_dio_done_wq() and it does the right thing. And given
> that -false positives- cannot occur (requires time travel to see the
> variable set before it has actually been set by the cmpxchg) there
> is nothing wrong with this check being racy.
> 
> >         /*
> >          * Nothing to do if ->s_dio_done_wq is already set.  The READ_ONCE()
> >          * here pairs with the cmpxchg() in __sb_init_dio_done_wq().  Since the
> >          * cmpxchg() may set ->s_dio_done_wq concurrently, a plain load would be
> >          * a data race (undefined behavior),
> 
> No, it is *not undefined*. If we know what is racing, then it is
> trivial to determine what the outcome of the race will be. And that
> -defines- the behaviour that will occur, and as per above, once
> we've defined the behaviour we realise that *we just don't care
> about races on setting/reading ->s_dio_done_wq because the code
> will *always do the right thing*.

You're just wrong here.  The C standard allows compilers to assume that
variables accessed by plain accesses aren't concurrently changed by other CPUs.
It's undefined behavior if other CPUs do in fact change the variable.

For example, it's perfectly allowed for the compiler to load the variable twice,
do the NULL check on the second copy, then actually use the first copy --- since
it can assume the two copies will have the same value.  But here the first copy
could be NULL and the second copy could be non-NULL.

See https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE for a
discussion of the many other reasons to properly annotate data races as well.

I understand that many kernel developers are perfectly happy to rely on the
compiler being "reasonable" (with everyone having their own opinion of what is
"reasonable").  I think that's not enough.  Whenever feasible, we should write
unambiguously correct code.

Anyway, do you have a concrete suggestion for this patch itself?  You've
suggested about four different things and not clearly said what you prefer.
As I see it, the options are:

- Do nothing.  I.e. retain undefined behavior, and also retain brokenness on a
  supported Linux architecture.

- Use READ_ONCE() (which you apparently want duplicated in 3 places?)

- Use smp_load_acquire() (which part of your email suggested you prefer, but
  would also affect performance slightly whereas another part of your email
  complained about compromising performance)

- Make filesystems allocate the workqueue at mount time.  Note that in many
  cases this workqueue will never be used, and the comment above
  sb_init_dio_done_wq() specifically calls out that the workqueue is
  intentionally not allocated when unneeded.  So we'd be changing that.

Perhaps it would help if we waited on this patch until the one-time init pattern
is properly documented in tools/memory-model/Documentation/recipes.txt?

- Eric
