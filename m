Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A034C2247A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 02:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgGRA7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 20:59:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgGRA67 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 20:58:59 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B814A2065E;
        Sat, 18 Jul 2020 00:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595033939;
        bh=vG8PG1WGBlJ0AL5gm2JsIz6j0+sz4k0vgDpRJOM4PMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=thlrGQyy/UZAZa70V3vjI5b/9CwLgKXaXVTnc9hc8tyntpaGvy7M9F3kizE34zxT8
         UnoVA/HY5M5gQUq/nTl2Q/60WtpRPGHSjW1XM4QBu/VOSsfmOPu+qqfzPdTjVZkqHN
         gOXHcBzM1LF2zmDa9gKvbb5uByy3pFHg1H3Ce10c=
Date:   Fri, 17 Jul 2020 17:58:57 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20200718005857.GB2183@sol.localdomain>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717205340.GR7625@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717205340.GR7625@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 01:53:40PM -0700, Darrick J. Wong wrote:
> > +There are also cases in which the smp_load_acquire() can be replaced by
> > +the more lightweight READ_ONCE().  (smp_store_release() is still
> > +required.)  Specifically, if all initialized memory is transitively
> > +reachable from the pointer itself, then there is no control dependency
> 
> I don't quite understand what "transitively reachable from the pointer
> itself" means?  Does that describe the situation where all the objects
> reachable through the object that the global struct foo pointer points
> at are /only/ reachable via that global pointer?
> 

The intent is that "transitively reachable" means that all initialized memory
can be reached by dereferencing the pointer in some way, e.g. p->a->b[5]->c.

It could also be the case that allocating the object initializes some global or
static data, which isn't reachable in that way.  Access to that data would then
be a control dependency, which a data dependency barrier wouldn't work for.

It's possible I misunderstood something.  (Note the next paragraph does say that
using READ_ONCE() is discouraged, exactly for this reason -- it can be hard to
tell whether it's correct.)  Suggestions of what to write here are appreciated.

- Eric
