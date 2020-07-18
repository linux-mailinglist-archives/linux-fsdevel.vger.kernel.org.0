Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E413E2247CC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 03:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgGRBim (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 21:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgGRBim (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 21:38:42 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2E3F2073E;
        Sat, 18 Jul 2020 01:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595036321;
        bh=s/JzOkxSkfNtv0xY8lsJGN9mFrYMl/KFrYLNGUU2bU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0q7XdCxMQYLX0NebmbgdVQvCEgD4SLGqw/gmgT3IMo1D9Lre+Dt/3vWV0HLuLH5D3
         YfUWGxoleps2vT9xLkxsnxAH7BRLP6YaEnUFPWK/rerRuzemezhsUL5hSngYCjbAKB
         YckhkW+QVYv7Tgcp0WBtGi+6Z3e6pkmqfhcfcTnU=
Date:   Fri, 17 Jul 2020 18:38:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Message-ID: <20200718013839.GD2183@sol.localdomain>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717174750.GQ12769@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 06:47:50PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 16, 2020 at 09:44:27PM -0700, Eric Biggers wrote:
> > +If that doesn't apply, you'll have to implement one-time init yourself.
> > +
> > +The simplest implementation just uses a mutex and an 'inited' flag.
> > +This implementation should be used where feasible:
> 
> I think some syntactic sugar should make it feasible for normal people
> to implement the most efficient version of this just like they use locks.

Note that the cmpxchg version is not necessarily the "most efficient".

If the one-time initialization is expensive, e.g. if it allocates a lot of
memory or if takes a long time, it could be better to use the mutex version so
that at most one task does it.

> How about something like this ...
> 
> once.h:
> 
> static struct init_once_pointer {
> 	void *p;
> };
> 
> static inline void *once_get(struct init_once_pointer *oncep)
> { ... }
> 
> static inline bool once_store(struct init_once_pointer *oncep, void *p)
> { ... }
> 
> --- foo.c ---
> 
> struct foo *get_foo(gfp_t gfp)
> {
> 	static struct init_once_pointer my_foo;
> 	struct foo *foop;
> 
> 	foop = once_get(&my_foo);
> 	if (foop)
> 		return foop;
> 
> 	foop = alloc_foo(gfp);
> 	if (!once_store(&my_foo, foop)) {
> 		free_foo(foop);
> 		foop = once_get(&my_foo);
> 	}
> 
> 	return foop;
> }
> 
> Any kernel programmer should be able to handle that pattern.  And no mutex!

I don't think this version would be worthwhile.  It eliminates type safety due
to the use of 'void *', and doesn't actually save any lines of code.  Nor does
it eliminate the need to correctly implement the cmpxchg failure case, which is
tricky (it must free the object and get the new one) and will be rarely tested.

It also forces all users of the struct to use this helper function to access it.
That could be considered a good thing, but it's also bad because even with
one-time init there's still usually some sort of ordering of "initialization"
vs. "use".  Just taking a random example I'm familiar with, we do one-time init
of inode::i_crypt_info when we open an encrypted file, so we guarantee it's set
for all I/O to the file, where we then simply access ->i_crypt_info directly.
We don't want the code to read like it's initializing ->i_crypt_info in the
middle of ->writepages(), since that would be wrong.

An improvement might be to make once_store() take the free function as a
parameter so that it would handle the failure case for you:

struct foo *get_foo(gfp_t gfp)
{
	static struct init_once_pointer my_foo;
	struct foo *foop;
 
 	foop = once_get(&my_foo);
 	if (!foop) {
		foop = alloc_foo(gfp);
		if (foop)
			once_store(&my_foo, foop, free_foo);
	}
 	return foop;
}

I'm not sure even that version would be worthwhile, though.

What I do like is DO_ONCE() in <linux/once.h>, which is used as just:

    DO_ONCE(func)

But it has limitations:

   - Only atomic context
   - Initialization can't fail
   - Only global/static data

We could address the first two limitations by splitting it into DO_ONCE_ATOMIC()
and DO_ONCE_BLOCKING(), and by allowing the initialization function to return an
error code.  That would make it work for all global/static data cases, I think.

Ideally we'd have something almost as simple for non-global/non-static data too.
I'm not sure the best way to do it, though.  It would have to be something more
complex like:

    ONETIME_INIT_DATA(&my_foo, alloc_foo, free_foo)

- Eric
