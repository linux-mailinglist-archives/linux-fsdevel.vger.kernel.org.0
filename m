Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A82422F3A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 17:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgG0PRs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 11:17:48 -0400
Received: from netrider.rowland.org ([192.131.102.5]:56667 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729016AbgG0PRr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:17:47 -0400
Received: (qmail 1470770 invoked by uid 1000); 27 Jul 2020 11:17:46 -0400
Date:   Mon, 27 Jul 2020 11:17:46 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
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
Message-ID: <20200727151746.GC1468275@rowland.harvard.edu>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
 <20200718013839.GD2183@sol.localdomain>
 <20200718021304.GS12769@casper.infradead.org>
 <20200718052818.GF2183@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718052818.GF2183@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 10:28:18PM -0700, Eric Biggers wrote:
> I'm still not sure this is the best API.

I cast my vote for something along the following lines.  It's simple,
easily understood and easily used.  The approach has two variants: One
that returns an integer and one that returns a pointer.  I'll use the
pointer variant to illustrate.

Given a type "T", an object x of type pointer-to-T, and a function
"func" that takes various arguments and returns a pointer-to-T, the
accepted API for calling func once would be to create once_func() as
follows:

T *once_func(T **ppt, args...)
{
	static DEFINE_MUTEX(mut);
	T *p;

	p = smp_load_acquire(ppt);	/* Mild optimization */
	if (p)
		return p;

	mutex_lock(mut);
	p = smp_load_acquire(ppt);
	if (!p) {
		p = func(args...);
		if (!IS_ERR_OR_NULL(p))
			smp_store_release(ppt, p);
	}
	mutex_unlock(mut);
	return p;
}

Users then would have to call once_func(&x, args...) and check the
result.  Different x objects would constitute different "once"
domains.

(In the integer variant, x, p and the return type of func are all int,
and ppt is an int *.  Everything else is the same.  This variant would
be used in cases where you're not allocating anything, you're doing
some other sort of initialization only once.)

While this would be a perfectly good recipe in itself, the whole thing
can be made much simpler for users by creating a MAKE_ONCE_FUNC macro
which would generate once_func given the type T, the name "func", and
the args.  The result is type-safe.

IMO the fact that once_func() is not inline is an advantage, not a
drawback.  Yes, it doesn't actually do any allocation or anything like
that -- the idea is that once_func's purpose is merely to ensure that
func is successfully called only once.  Any memory allocation or other
stuff of that sort should be handled by func.

In fact, the only drawback I can think of is that because this relies
on a single mutex for all the different possible x's, it might lead to
locking conflicts (if func had to call once_func() recursively, for
example).  In most reasonable situations such conflicts would not
arise.

Alan Stern
