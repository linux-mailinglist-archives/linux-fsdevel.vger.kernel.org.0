Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10556226C29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbgGTQrf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 12:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbgGTPjS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:39:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F17C061794;
        Mon, 20 Jul 2020 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ni3GtEq//rn/T0Y31rT9wL4PCiqDOjTkE6241aZZHHo=; b=BiHDGagd+pgP536ZQhYUL4DrI0
        cMFa6Nval3D9C3UFIeLO/+EGQjO3Mhic3hTUpI/yH9aoBNux/iQOFfJIryUL+8t9hgOoNK/6izEJJ
        UqzGFdBpIsrvOJALzW9a6S5U06lVkps5GrJwFxYuzn+XlCKgZJtDOsxf+g3OAvHkisZShKt+UC1I2
        A6WXqG5gbdrFpDpmKms+BNaV7LP68vdeR/ewhPKwnrKCnKvnjPk/62G+D/5qFJ/BprKn7rmdI1BTb
        fqHsANZLurUqXW+PLa3ubnx9KtVTWG2dtIDfrhyga6bBl3rIBA2zDH8OV1BfiERufy7dWhKGOaxxA
        EAyk21xw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxXsl-0005o1-Ni; Mon, 20 Jul 2020 15:39:12 +0000
Date:   Mon, 20 Jul 2020 16:39:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
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
Message-ID: <20200720153911.GX12769@casper.infradead.org>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200718014204.GN5369@dread.disaster.area>
 <20200718140811.GA1179836@rowland.harvard.edu>
 <20200720013320.GP5369@dread.disaster.area>
 <20200720145211.GC1228057@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720145211.GC1228057@rowland.harvard.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 10:52:11AM -0400, Alan Stern wrote:
> On Mon, Jul 20, 2020 at 11:33:20AM +1000, Dave Chinner wrote:
> > On Sat, Jul 18, 2020 at 10:08:11AM -0400, Alan Stern wrote:
> > > > This is one of the reasons that the LKMM documetnation is so damn
> > > > difficult to read and understand: just understanding the vocabulary
> > > > it uses requires a huge learning curve, and it's not defined
> > > > anywhere. Understanding the syntax of examples requires a huge
> > > > learning curve, because it's not defined anywhere. 
> > > 
> > > Have you seen tools/memory-model/Documentation/explanation.txt?
> > 
> > <raises eyebrow>
> > 
> > Well, yes. Several times. I look at it almost daily, but that
> > doesn't mean it's approachable, easy to read or even -that I
> > understand what large parts of it say-. IOWs, that's one of the 
> > problematic documents that I've been saying have a huge learning
> > curve.
> 
> Can you be more specific?  For example, exactly where does it start to 
> become unapproachable or difficult to read?
> 
> Don't forget that this document was meant to help mitigate the LKMM's 
> learning curve.  If it isn't successful, I want to improve it.

I can't speak for Dave, but the introduction to that documentation makes
it clear to me that it's not the document I want to read.

: This document describes the ideas underlying the LKMM.  It is meant
: for people who want to understand how the model was designed.  It does
: not go into the details of the code in the .bell and .cat files;
: rather, it explains in English what the code expresses symbolically.

I don't want to know how the model was designed.  I want to write a
device driver, or filesystem, or whatever.

Honestly, even the term "release semantics" trips me up _every_ time.
It's a barrier to understanding because I have to translate it into "Oh,
he means it's like an unlock".  Why can't you just say "unlock semantics"?
