Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB9A2247D6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 03:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGRBkw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 21:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGRBkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 21:40:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418E6C0619D2;
        Fri, 17 Jul 2020 18:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z/LXzyQQvIbTaBiNEA7lgQw3JPPFGRlWt4h9R1rYhrg=; b=TW/I1cKuOLoHLOvAY6NeiZQoKd
        Zz2vamGQF53yhMt6PyvGcRSJc2NCJiD8AoqZotSvdc5IfQQi3RarSXe0+gx/TrcCItHtOmrWo9qVD
        hSWDbi8PLUGIcVHTKBVSin6QPQ0TmYJ9L83ixHQ/dnfUYOUhI0C6jF+x3q+ftwoA78tmPw0utlJYo
        AXikpTIu3x3a7vkZWPeGKiaitOu9+2+GwAdXj493Fppw/gsg7RJpflX2FbkSZZ+4vfDkCPGYLps85
        X1+TZzzOwYMb+6L0J8qB0DvdAZ9754djv/z+wkZUqFKfdF+SMT2frO01tVaf7p4UI/uCgjUwFFJfA
        68q3E16A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwbqH-00016U-IO; Sat, 18 Jul 2020 01:40:45 +0000
Date:   Sat, 18 Jul 2020 02:40:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Message-ID: <20200718014045.GR12769@casper.infradead.org>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717205340.GR7625@magnolia>
 <20200718005857.GB2183@sol.localdomain>
 <20200718012555.GA1168834@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718012555.GA1168834@rowland.harvard.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 09:25:55PM -0400, Alan Stern wrote:
> On Fri, Jul 17, 2020 at 05:58:57PM -0700, Eric Biggers wrote:
> > On Fri, Jul 17, 2020 at 01:53:40PM -0700, Darrick J. Wong wrote:
> > > > +There are also cases in which the smp_load_acquire() can be replaced by
> > > > +the more lightweight READ_ONCE().  (smp_store_release() is still
> > > > +required.)  Specifically, if all initialized memory is transitively
> > > > +reachable from the pointer itself, then there is no control dependency
> > > 
> > > I don't quite understand what "transitively reachable from the pointer
> > > itself" means?  Does that describe the situation where all the objects
> > > reachable through the object that the global struct foo pointer points
> > > at are /only/ reachable via that global pointer?
> > > 
> > 
> > The intent is that "transitively reachable" means that all initialized memory
> > can be reached by dereferencing the pointer in some way, e.g. p->a->b[5]->c.
> > 
> > It could also be the case that allocating the object initializes some global or
> > static data, which isn't reachable in that way.  Access to that data would then
> > be a control dependency, which a data dependency barrier wouldn't work for.
> > 
> > It's possible I misunderstood something.  (Note the next paragraph does say that
> > using READ_ONCE() is discouraged, exactly for this reason -- it can be hard to
> > tell whether it's correct.)  Suggestions of what to write here are appreciated.
> 
> Perhaps something like this:
> 
> 	Specifically, if the only way to reach the initialized memory 
> 	involves dereferencing the pointer itself then READ_ONCE() is 
> 	sufficient.  This is because there will be an address dependency 
> 	between reading the pointer and accessing the memory, which will 
> 	ensure proper ordering.  But if some of the initialized memory 
> 	is reachable some other way (for example, if it is global or 
> 	static data) then there need not be an address dependency, 
> 	merely a control dependency (checking whether the pointer is 
> 	non-NULL).  Control dependencies do not always ensure ordering 
> 	-- certainly not for reads, and depending on the compiler, 
> 	possibly not for some writes -- and therefore a load-acquire is 
> 	necessary.
> 
> Perhaps this is more wordy than you want, but it does get the important 
> ideas across.

I don't think we should worry about wordsmithing this.  We should just
say "Use the init_pointer_once API" and then people who want to worry
about optimising the implementation of that API never have to talk to
the people who want to use that API.
