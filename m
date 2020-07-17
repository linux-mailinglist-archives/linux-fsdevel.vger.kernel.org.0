Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CD6224286
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 19:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgGQRrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 13:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgGQRrz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:47:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDD6C0619D2;
        Fri, 17 Jul 2020 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5bNn1iv9D2whBZXnI8V5/oS3EG1YDPh+syl8DNPsUhU=; b=U1Kt4wEojI31oe5jA4aI9n41ye
        RZezlbwJ3X5butEOMLladO4jta0f0vUwJqYU8ihCRZ4yFReYwo0/Vjrmyq8kRDeBHPXt7UfwAyHyy
        pWahWEldkFExAGO4V2T1OYGcSJ2FFPQ/3j4copIVUZl+bizT33QXFj5hboCKts4RC/KrpM9Q7MmNw
        okSWSQXnJpfB2uAt3vOcAP/djy3NIRDRn8odyEKYx4QzyHGFcS2vEXMZl7Qf611ePcwtNPZP+1fTI
        vGzba+AjWykxIei1LwB1yuSoS6pz9LTNanBUxQoBw3No3wPpKcQ/8ba/Gi+EZCOBB/o80CYg3EBQV
        puExjdtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwUSc-00036X-Lw; Fri, 17 Jul 2020 17:47:50 +0000
Date:   Fri, 17 Jul 2020 18:47:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
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
Message-ID: <20200717174750.GQ12769@casper.infradead.org>
References: <20200717044427.68747-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717044427.68747-1-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 09:44:27PM -0700, Eric Biggers wrote:
> +If that doesn't apply, you'll have to implement one-time init yourself.
> +
> +The simplest implementation just uses a mutex and an 'inited' flag.
> +This implementation should be used where feasible:

I think some syntactic sugar should make it feasible for normal people
to implement the most efficient version of this just like they use locks.

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

Why do we have cmpxchg_release() anyway?  Under what circumstances is
cmpxchg() useful _without_ having release semantics?

> +			free_foo(p);
> +			/* pairs with successful cmpxchg_release() above */
> +			smp_load_acquire(&foo);
> +		}
> +		return 0;
> +	}

How about something like this ...

once.h:

static struct init_once_pointer {
	void *p;
};

static inline void *once_get(struct init_once_pointer *oncep)
{ ... }

static inline bool once_store(struct init_once_pointer *oncep, void *p)
{ ... }

--- foo.c ---

struct foo *get_foo(gfp_t gfp)
{
	static struct init_once_pointer my_foo;
	struct foo *foop;

	foop = once_get(&my_foo);
	if (foop)
		return foop;

	foop = alloc_foo(gfp);
	if (!once_store(&my_foo, foop)) {
		free_foo(foop);
		foop = once_get(&my_foo);
	}

	return foop;
}

Any kernel programmer should be able to handle that pattern.  And no mutex!
