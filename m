Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A8C22F43A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 18:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgG0QBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 12:01:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbgG0QBM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:01:12 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 783DD20672;
        Mon, 27 Jul 2020 16:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595865671;
        bh=TyuIfn7O9yjs35JfR7DUagieEalz1hEmViE6CiWVKtg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lkp/GaXkC6lAfR/wK8oDYvOQqYth2ZXVH7Uhzgb3o/iMjOB1Q8fUH3mSxHi/I4iAD
         uSjxRHv+RXxfRcHKo/KJrHBJX1bHA+xaf6+A+qRlqELWL9MdwJqkRKav4K/Zuxn7VV
         Xip0UI7L6rUHyd2GcT6nqKuKn0B7XDwh/tee/GR8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 37CDA3522AF4; Mon, 27 Jul 2020 09:01:11 -0700 (PDT)
Date:   Mon, 27 Jul 2020 09:01:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
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
Message-ID: <20200727160111.GH9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
 <20200718013839.GD2183@sol.localdomain>
 <20200718021304.GS12769@casper.infradead.org>
 <20200718052818.GF2183@sol.localdomain>
 <20200727151746.GC1468275@rowland.harvard.edu>
 <20200727152827.GM23808@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727152827.GM23808@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 04:28:27PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 27, 2020 at 11:17:46AM -0400, Alan Stern wrote:
> > Given a type "T", an object x of type pointer-to-T, and a function
> > "func" that takes various arguments and returns a pointer-to-T, the
> > accepted API for calling func once would be to create once_func() as
> > follows:
> > 
> > T *once_func(T **ppt, args...)
> > {
> > 	static DEFINE_MUTEX(mut);
> > 	T *p;
> > 
> > 	p = smp_load_acquire(ppt);	/* Mild optimization */
> > 	if (p)
> > 		return p;
> > 
> > 	mutex_lock(mut);
> > 	p = smp_load_acquire(ppt);
> > 	if (!p) {
> > 		p = func(args...);
> > 		if (!IS_ERR_OR_NULL(p))
> > 			smp_store_release(ppt, p);
> > 	}
> > 	mutex_unlock(mut);
> > 	return p;
> > }
> > 
> > Users then would have to call once_func(&x, args...) and check the
> > result.  Different x objects would constitute different "once"
> > domains.
> [...]
> > In fact, the only drawback I can think of is that because this relies
> > on a single mutex for all the different possible x's, it might lead to
> > locking conflicts (if func had to call once_func() recursively, for
> > example).  In most reasonable situations such conflicts would not
> > arise.
> 
> Another drawback for this approach relative to my get_foo() approach
> upthread is that, because we don't have compiler support, there's no
> enforcement that accesses to 'x' go through once_func().  My approach
> wraps accesses in a deliberately-opaque struct so you have to write
> some really ugly code to get at the raw value, and it's just easier to
> call get_foo().

Could ACCESS_PRIVATE() help in this case?  This relies on sparse rather
than the compiler, but some of the testing services do run sparse
regularly.

							Thanx, Paul
