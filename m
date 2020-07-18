Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7032247F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 04:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgGRCAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 22:00:09 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:55270 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726665AbgGRCAJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 22:00:09 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 5990F105E9E;
        Sat, 18 Jul 2020 12:00:02 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jwc8v-0002KH-1J; Sat, 18 Jul 2020 12:00:01 +1000
Date:   Sat, 18 Jul 2020 12:00:01 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Message-ID: <20200718020001.GO5369@dread.disaster.area>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717205340.GR7625@magnolia>
 <20200718005857.GB2183@sol.localdomain>
 <20200718012555.GA1168834@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718012555.GA1168834@rowland.harvard.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=7-415B0cAAAA:8
        a=m2fqJy7gfEZGdrr6IoAA:9 a=uIZ0nfzhNTXwYeV5:21 a=TVXeNXAKodzJbbhi:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
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

Recipes are aimed at people who simply don't understand any of that
goobledegook. This won't help them -write correct code-.

> Perhaps this is more wordy than you want, but it does get the important 
> ideas across.

You think they are important because you understand what those words
mean.  Large numbers of developers do not understand what they mean,
nor how to put them into practise correctly.

Seriously: if you want people to use this stuff correctly, you need
to -dumb it down-, not make it even more challenging by explaining
words people don't understand with yet more words they don't
understand...

This is the "curse of knowledge" cognative bias in a nutshell.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
