Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E053B0FFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 00:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhFVWXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 18:23:06 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:55046 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229718AbhFVWXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:23:05 -0400
Received: from dread.disaster.area (pa49-179-138-183.pa.nsw.optusnet.com.au [49.179.138.183])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 7E20B1B3100;
        Wed, 23 Jun 2021 08:20:45 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lvolA-00FrD1-A6; Wed, 23 Jun 2021 08:20:44 +1000
Date:   Wed, 23 Jun 2021 08:20:44 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'David Howells' <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Ted Ts'o <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
Message-ID: <20210622222044.GI2419729@dread.disaster.area>
References: <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <3221175.1624375240@warthog.procyon.org.uk>
 <3225322.1624379221@warthog.procyon.org.uk>
 <7a6d8c55749d46d09f6f6e27a99fde36@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a6d8c55749d46d09f6f6e27a99fde36@AcuMS.aculab.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=MnllW2CieawZLw/OcHE/Ng==:117 a=MnllW2CieawZLw/OcHE/Ng==:17
        a=v-Dl0aO_AE6Q_TjM:21 a=kj9zAlcOel0A:10 a=r6YtysWOX24A:10 a=drOt6m5kAAAA:8
        a=7-415B0cAAAA:8 a=LpHeB8C7BEPH7Pa3heMA:9 a=CjuIK1q_8ugA:10
        a=vIikcsq8ZuViU5wKlUpU:22 a=RMMjzBEyIzXRtoq5n5K6:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 09:55:09PM +0000, David Laight wrote:
> From: David Howells
> > Sent: 22 June 2021 17:27
> > 
> > Al Viro <viro@zeniv.linux.org.uk> wrote:
> > 
> > > On Tue, Jun 22, 2021 at 04:20:40PM +0100, David Howells wrote:
> > >
> > > > and wondering if the iov_iter_fault_in_readable() is actually effective.
> > > > Yes, it can make sure that the page we're intending to modify is dragged
> > > > into the pagecache and marked uptodate so that it can be read from, but is
> > > > it possible for the page to then get reclaimed before we get to
> > > > iov_iter_copy_from_user_atomic()?  a_ops->write_begin() could potentially
> > > > take a long time, say if it has to go and get a lock/lease from a server.
> > >
> > > Yes, it is.  So what?  We'll just retry.  You *can't* take faults while
> > > holding some pages locked; not without shitloads of deadlocks.
> > 
> > In that case, can we amend the comment immediately above
> > iov_iter_fault_in_readable()?
> > 
> > 	/*
> > 	 * Bring in the user page that we will copy from _first_.
> > 	 * Otherwise there's a nasty deadlock on copying from the
> > 	 * same page as we're writing to, without it being marked
> > 	 * up-to-date.
> > 	 *
> > 	 * Not only is this an optimisation, but it is also required
> > 	 * to check that the address is actually valid, when atomic
> > 	 * usercopies are used, below.
> > 	 */
> > 	if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
> > 
> > The first part suggests this is for deadlock avoidance.  If that's not true,
> > then this should perhaps be changed.
> 
> I'd say something like:
> 	/*
> 	 * The actual copy_from_user() is done with a lock held
> 	 * so cannot fault in missing pages.
> 	 * So fault in the pages first.
> 	 * If they get paged out the inatomic usercopy will fail
> 	 * and the whole operation is retried.
> 	 *
> 	 * Hopefully there are enough memory pages available to
> 	 * stop this looping forever.
> 	 */

What about the other 4 or 5 copies of this loop in the kernel?

This is a pattern, not a one off implementation. Comments describing
how the pattern works belong in the API documentation, not on a
single implemenation of the pattern...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
