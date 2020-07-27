Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16B322F568
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 18:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbgG0Qbv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 12:31:51 -0400
Received: from netrider.rowland.org ([192.131.102.5]:53561 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730962AbgG0Qbu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:31:50 -0400
Received: (qmail 1473885 invoked by uid 1000); 27 Jul 2020 12:31:49 -0400
Date:   Mon, 27 Jul 2020 12:31:49 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20200727163149.GD1468275@rowland.harvard.edu>
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
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Something like that could be included in once_func too.  It's relatively 
tangential to the main point I was making, which was to settle on an 
overall API and discuss how it should be described in recipes.txt.

Alan Stern
