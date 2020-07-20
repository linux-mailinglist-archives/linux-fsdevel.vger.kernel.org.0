Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B502255C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 04:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgGTCHi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 22:07:38 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:42707 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726225AbgGTCHi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 22:07:38 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 70025104E5B;
        Mon, 20 Jul 2020 12:07:32 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jxLDH-00026c-AP; Mon, 20 Jul 2020 12:07:31 +1000
Date:   Mon, 20 Jul 2020 12:07:31 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20200720020731.GQ5369@dread.disaster.area>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
 <20200718013839.GD2183@sol.localdomain>
 <20200718021304.GS12769@casper.infradead.org>
 <20200718052818.GF2183@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718052818.GF2183@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=7-415B0cAAAA:8
        a=6eSPBXchJsNOt_dXz80A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 10:28:18PM -0700, Eric Biggers wrote:
> What do people think about the following instead?  (Not proofread / tested yet,
> so please comment on the high-level approach, not minor mistakes :-) )

No huge long macros, please.

We don't accept people writing long complex static inline functions,
so for the same reasons it is not acceptable to write long complex
macros.  Especially ones that use variable arguments and embed
invisible locking within them.

The whole serialisation/atomic/ordering APIs have fallen badly off
the macro cliff, to the point where finding out something as simple
as the order of parameters passed to cmpxchg and what semantics it
provides requires macro-spelunking 5 layers deep to find the generic
implementation function that contains a comment describing what it
does....

That's yet another barrier to understanding what all the different
synchronisation primitives do.

....

> In the fs/direct-io.c case we'd use:
> 
> int sb_init_dio_done_wq(struct super_block *sb)
> {
> 	static DEFINE_MUTEX(sb_init_dio_done_mutex);
> 
> 	return INIT_ONCE_PTR(&sb->s_dio_done_wq, &sb_init_dio_done_mutex,
> 			     alloc_workqueue,
> 			     "dio/%s", WQ_MEM_RECLAIM, 0, sb->s_id);
> }

Yeah, that's pretty horrible...

I *much* prefer an API like Willy's suggested to somethign like
this. Just because you can hide all sorts of stuff in macros doesn't
mean you should.

> The only part I really don't like is the way arguments are passed to the
> alloc_func.  We could also make it work like the following, though it would
> break the usual rules since it looks like the function call is always executed,
> but it's not:
> 
> 	return INIT_ONCE_PTR(&sb->s_dio_done_wq, &sb_init_dio_done_mutex,
> 			     alloc_workqueue("dio/%s", WQ_MEM_RECLAIM, 0,
> 					     sb->s_id));

Yeah, that's even worse. Code that does not do what it looks like it
should needs to be nuked from orbit.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
