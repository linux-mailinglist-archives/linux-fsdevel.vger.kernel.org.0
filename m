Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45246226699
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbgGTQEg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 12:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732463AbgGTQEf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:04:35 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FB1320684;
        Mon, 20 Jul 2020 16:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261074;
        bh=qdORIBFauGX+RlOa8U16iXHiLl+0wTtPgvKAEkWyzl0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LEGcdINyNzKCbCQ5wXX5ZfNJtY1BviG61dvpY5itgMnb+pGqfBoafq2w7cs8b+pa1
         W0vSJhrpcc6VZhyj5E/PTxTxJlEIKfe9giRYmNze5HTCnvFSt9xhyZ5bjJL9yl0vww
         xEwnV3+E0AKOEYt5J9leynZvBhNfL36vSmHnj5UE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0B1D93522A8C; Mon, 20 Jul 2020 09:04:34 -0700 (PDT)
Date:   Mon, 20 Jul 2020 09:04:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Dave Chinner <david@fromorbit.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Message-ID: <20200720160433.GQ9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200718014204.GN5369@dread.disaster.area>
 <20200718140811.GA1179836@rowland.harvard.edu>
 <20200720013320.GP5369@dread.disaster.area>
 <20200720145211.GC1228057@rowland.harvard.edu>
 <20200720153911.GX12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720153911.GX12769@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 04:39:11PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 20, 2020 at 10:52:11AM -0400, Alan Stern wrote:
> > On Mon, Jul 20, 2020 at 11:33:20AM +1000, Dave Chinner wrote:
> > > On Sat, Jul 18, 2020 at 10:08:11AM -0400, Alan Stern wrote:
> > > > > This is one of the reasons that the LKMM documetnation is so damn
> > > > > difficult to read and understand: just understanding the vocabulary
> > > > > it uses requires a huge learning curve, and it's not defined
> > > > > anywhere. Understanding the syntax of examples requires a huge
> > > > > learning curve, because it's not defined anywhere. 
> > > > 
> > > > Have you seen tools/memory-model/Documentation/explanation.txt?
> > > 
> > > <raises eyebrow>
> > > 
> > > Well, yes. Several times. I look at it almost daily, but that
> > > doesn't mean it's approachable, easy to read or even -that I
> > > understand what large parts of it say-. IOWs, that's one of the 
> > > problematic documents that I've been saying have a huge learning
> > > curve.
> > 
> > Can you be more specific?  For example, exactly where does it start to 
> > become unapproachable or difficult to read?
> > 
> > Don't forget that this document was meant to help mitigate the LKMM's 
> > learning curve.  If it isn't successful, I want to improve it.
> 
> I can't speak for Dave, but the introduction to that documentation makes
> it clear to me that it's not the document I want to read.
> 
> : This document describes the ideas underlying the LKMM.  It is meant
> : for people who want to understand how the model was designed.  It does
> : not go into the details of the code in the .bell and .cat files;
> : rather, it explains in English what the code expresses symbolically.
> 
> I don't want to know how the model was designed.  I want to write a
> device driver, or filesystem, or whatever.
> 
> Honestly, even the term "release semantics" trips me up _every_ time.
> It's a barrier to understanding because I have to translate it into "Oh,
> he means it's like an unlock".  Why can't you just say "unlock semantics"?

One way to think of it is "release" as in "release a lock".

But to answer your question:

1.	The rest of the industry settled on "release" for that form
	of atomics a very long time ago.  Yes, we could insist on
	Linux-kernel exceptionalism, but that doesn't seem consistent
	with the large number of people coming into the kernel, even if
	only briefly.

2.	If we were to say "unlock" instead of "release", consistency
	would demand that we also say "lock" instead of "acquire".
	But "lock" is subtlely different than "acquire", and there is
	a history of people requesting further divergence.

3.	At least one architecture has started using GCC intrinsics
	to implement atomics.  I would expect more to follow.  And
	the GCC intrinsics say "_release".

4.	More cynically (and I do not bleach my hair, so yes, I do have the
	hair color for it), the Linux kernel community is sufficiently
	creative in its (ab)use of whatever tools happen to be lying
	around that any name will become misleading over time in any case.

							Thanx, Paul
