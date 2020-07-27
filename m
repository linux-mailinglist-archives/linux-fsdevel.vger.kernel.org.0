Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A891722EC96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 14:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgG0Mvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 08:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgG0Mvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:51:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086CFC061794;
        Mon, 27 Jul 2020 05:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DaAYayPt0rjSYJYHQGKl8PlBczwB5P48X+5+SHwawBM=; b=QHt89R9FfGq2fppSZ477pANbbQ
        SoFXylVsYKqCIG+2ofNxlnC1P4aqRHuam6ZdFpV4GDtaVAnwFKqd7ExrrLYGFiPELztpcU+xaA52M
        CcX4acasJ4IxvlBtG4F/8ZAtFMztyotzBhLNz/OxyXgaQlSFNoFqFktwQo/mzz1izN6+Gc3e6nt5z
        QuQQ+mVc++qSyWh5FpsqFZOspW52TDKZKoPrEWSxnzOvzu+PbGOlaUiXdV9rC0zbekRXYLMWB8bwL
        UiR6m4tQQ/5YGlv2zdfZeudZsMjor1GdFeHNd8M6MGIylP4FaO6OmXOYUlyznlq1VZV3UEFzJx3Si
        wHhMcw3A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k02bR-0008Cm-ED; Mon, 27 Jul 2020 12:51:37 +0000
Date:   Mon, 27 Jul 2020 13:51:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
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
Message-ID: <20200727125137.GK23808@casper.infradead.org>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
 <20200717175138.GB1156312@rowland.harvard.edu>
 <20200718010247.GC2183@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718010247.GC2183@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 06:02:47PM -0700, Eric Biggers wrote:
> On Fri, Jul 17, 2020 at 01:51:38PM -0400, Alan Stern wrote:
> > On Fri, Jul 17, 2020 at 06:47:50PM +0100, Matthew Wilcox wrote:
> > > On Thu, Jul 16, 2020 at 09:44:27PM -0700, Eric Biggers wrote:
> > ...
> > > > +		/* on success, pairs with smp_load_acquire() above and below */
> > > > +		if (cmpxchg_release(&foo, NULL, p) != NULL) {
> > > 
> > > Why do we have cmpxchg_release() anyway?  Under what circumstances is
> > > cmpxchg() useful _without_ having release semantics?
> > 
> > To answer just the last question: cmpxchg() is useful for lock 
> > acquisition, in which case it needs to have acquire semantics rather 
> > than release semantics.
> > 
> 
> To clarify, there are 4 versions of cmpxchg:
> 
> 	cmpxchg(): does ACQUIRE and RELEASE (on success)
> 	cmpxchg_acquire(): does ACQUIRE only (on success)
> 	cmpxchg_release(): does RELEASE only (on success)
> 	cmpxchg_relaxed(): no barriers
> 
> The problem here is that here we need RELEASE on success and ACQUIRE on failure.
> But no version guarantees any barrier on failure.

Why not?  Do CPU designers not do load-linked-with-acquire-semantics?
Or is it our fault for not using the appropriate instruction?

> So as far as I can tell, the best we can do is use cmpxchg_release() (or
> cmpxchg() which would be stronger but unnecessary), followed by a separate
> ACQUIRE on failure.

OK, but that detail needs to be hidden behind a higher level primitive,
not exposed to device driver writers.
