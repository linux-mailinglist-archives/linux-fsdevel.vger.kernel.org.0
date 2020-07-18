Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025902247A8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 03:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgGRBCu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 21:02:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgGRBCt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 21:02:49 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 034992065F;
        Sat, 18 Jul 2020 01:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595034169;
        bh=l2J74681mstclINahuFMUN0d6t9i4PUhKyWNqKN96Is=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mMfoP2V3McMONoqqj2jyFhxrobrkhAd+7hj/xgHx65YV07lnQp0KGMYMH/Uiejxm7
         7JdwseK21OmaAETUP+eE0qH12wT+BeK4RT5mDdDGPBbwR3ZeE4OQUXLKpMonCzSypb
         YOrGqK633zW10x3hiDHbbPo6TSBz+XffO0MsTZ5M=
Date:   Fri, 17 Jul 2020 18:02:47 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
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
Message-ID: <20200718010247.GC2183@sol.localdomain>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
 <20200717175138.GB1156312@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717175138.GB1156312@rowland.harvard.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 01:51:38PM -0400, Alan Stern wrote:
> On Fri, Jul 17, 2020 at 06:47:50PM +0100, Matthew Wilcox wrote:
> > On Thu, Jul 16, 2020 at 09:44:27PM -0700, Eric Biggers wrote:
> ...
> > > +		/* on success, pairs with smp_load_acquire() above and below */
> > > +		if (cmpxchg_release(&foo, NULL, p) != NULL) {
> > 
> > Why do we have cmpxchg_release() anyway?  Under what circumstances is
> > cmpxchg() useful _without_ having release semantics?
> 
> To answer just the last question: cmpxchg() is useful for lock 
> acquisition, in which case it needs to have acquire semantics rather 
> than release semantics.
> 

To clarify, there are 4 versions of cmpxchg:

	cmpxchg(): does ACQUIRE and RELEASE (on success)
	cmpxchg_acquire(): does ACQUIRE only (on success)
	cmpxchg_release(): does RELEASE only (on success)
	cmpxchg_relaxed(): no barriers

The problem here is that here we need RELEASE on success and ACQUIRE on failure.
But no version guarantees any barrier on failure.

So as far as I can tell, the best we can do is use cmpxchg_release() (or
cmpxchg() which would be stronger but unnecessary), followed by a separate
ACQUIRE on failure.

- Eric
