Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7054722F5E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 18:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgG0Q7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 12:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgG0Q7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:59:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D73C061794;
        Mon, 27 Jul 2020 09:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qKCvvUqZxubrOC+RuxMq8NEC5P8ybthEmCL48oWCrpQ=; b=ckvE44+e+1WMR2mp8dKzBgbajf
        MRjIbVSLSEnIOpTHTPlktISnxkb3xb2LJoWBCVy2RimzwCRNAbuutSOq//ZLA1NcW8kONGkUvbCyn
        TPu9GpGYCln4xEmK8HPSS6Kp1T8nd7KxnSY6hao2LqmVDG0ivjCGiFPUh9VT9P6R8BnRzKRlpUcFk
        JMMTU8SNcxhfHyUdvofky9QjWN7hjaWNUodRngN6yT9Nyb1J4CIK38an75whMYwherJSmx+BVzBpk
        NKduur9QXgpSqPv+S46Xmo1XdmQKDep7agWIvtf4w6s9TojDwbWNTvZGFsatOXVoklpH5QOZIxL8b
        GLPAOf6A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k06T7-0005TL-BJ; Mon, 27 Jul 2020 16:59:17 +0000
Date:   Mon, 27 Jul 2020 17:59:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <20200727165917.GN23808@casper.infradead.org>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
 <20200718013839.GD2183@sol.localdomain>
 <20200718021304.GS12769@casper.infradead.org>
 <20200718052818.GF2183@sol.localdomain>
 <20200727151746.GC1468275@rowland.harvard.edu>
 <20200727152827.GM23808@casper.infradead.org>
 <20200727163149.GD1468275@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727163149.GD1468275@rowland.harvard.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 12:31:49PM -0400, Alan Stern wrote:
> On Mon, Jul 27, 2020 at 04:28:27PM +0100, Matthew Wilcox wrote:
> > On Mon, Jul 27, 2020 at 11:17:46AM -0400, Alan Stern wrote:
> > > Given a type "T", an object x of type pointer-to-T, and a function
> > > "func" that takes various arguments and returns a pointer-to-T, the
> > > accepted API for calling func once would be to create once_func() as
> > > follows:
> > > 
> > > T *once_func(T **ppt, args...)
> > > {
> > > 	static DEFINE_MUTEX(mut);
> > > 	T *p;
> > > 
> > > 	p = smp_load_acquire(ppt);	/* Mild optimization */
> > > 	if (p)
> > > 		return p;
> > > 
> > > 	mutex_lock(mut);
> > > 	p = smp_load_acquire(ppt);
> > > 	if (!p) {
> > > 		p = func(args...);
> > > 		if (!IS_ERR_OR_NULL(p))
> > > 			smp_store_release(ppt, p);
> > > 	}
> > > 	mutex_unlock(mut);
> > > 	return p;
> > > }
> > > 
> > > Users then would have to call once_func(&x, args...) and check the
> > > result.  Different x objects would constitute different "once"
> > > domains.
> > [...]
> > > In fact, the only drawback I can think of is that because this relies
> > > on a single mutex for all the different possible x's, it might lead to
> > > locking conflicts (if func had to call once_func() recursively, for
> > > example).  In most reasonable situations such conflicts would not
> > > arise.
> > 
> > Another drawback for this approach relative to my get_foo() approach
> > upthread is that, because we don't have compiler support, there's no
> > enforcement that accesses to 'x' go through once_func().  My approach
> > wraps accesses in a deliberately-opaque struct so you have to write
> > some really ugly code to get at the raw value, and it's just easier to
> > call get_foo().
> 
> Something like that could be included in once_func too.  It's relatively 
> tangential to the main point I was making, which was to settle on an 
> overall API and discuss how it should be described in recipes.txt.

Then I think you're trying to describe something which is too complicated
because it's overly general.  I don't think device drivers should contain
"smp_load_acquire" and "smp_store_release".  Most device driver authors
struggle with spinlocks and mutexes.

The once_get() / once_store() API:

struct foo *get_foo(gfp_t gfp)
{
	static struct once_pointer my_foo;
	struct foo *foop;

	foop = once_get(&my_foo);
	if (foop)
		return foop;

	foop = alloc_foo(gfp);
	if (foop && !once_store(&my_foo, foop)) {
		free_foo(foop);
		foop = once_get(&my_foo);
	}

	return foop;
}

is easy to understand.  There's no need to talk about acquire and release
semantics, barriers, reordering, ... it all just works in the obvious way
that it's written.

If you want to put a mutex around all this, you can:

struct foo *get_foo(gfp_t gfp)
{
	static DEFINE_MUTEX(m);
	static struct init_once_pointer my_foo;
	struct foo *foop;

	foop = once_get(&my_foo);
	if (foop)
		return foop;

	mutex_lock(&m);
	foop = once_get(&my_foo);
	if (!foop) {
		foop = alloc_foo(gfp);
		if (foop && !once_store(&my_foo, foop)) {
			free_foo(foop);
			foop = once_get(&my_foo);
		}
	}
	mutex_unlock(&m);

	return foop;
}
