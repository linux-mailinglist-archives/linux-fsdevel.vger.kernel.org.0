Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE4EFC05B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2019 14:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfI0Mtp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Sep 2019 08:49:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfI0Mto (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rvlIy3RLIJZPQNk2Zr5B3uFv1m1PNMIJ4Fy2wsXUVfY=; b=prY2xvdZ/jaRLk08/tjfYYcwH
        LNqHwXmfPN4T10bYx2KwdEjOyCk+5o9QpFRj/QuZzn0gMCUUZ2XAv9kjr4sQflL5T3LUvbwRv22aq
        /EPqVpb2it6Bd+nNGM+u9cuehf3mWcmTR5P2DI3mtsvnL9/PoyVqZmi9BAy6lUcm51DAPVsoYs8A8
        W7W+UVI7DJQkSHiMw18zJA/rEKJHG2V5uSWX7iV0QOExY6C3Rpscs8QAYire2UdWejd1ZusJOUeFl
        7uwiY5O2mDtUpNJ/tx/dXiIBr/T4iFCn7RCxXvq0MDYTXXGVrN9StWvUQmq9WCknZ5WkY0ajYmwAf
        yvVA+cEAQ==;
Received: from [188.205.208.251] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDpgj-0003FH-Ki; Fri, 27 Sep 2019 12:49:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF6C19801D6; Fri, 27 Sep 2019 14:49:29 +0200 (CEST)
Date:   Fri, 27 Sep 2019 14:49:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        jose.marchesi@oracle.com
Subject: Re: Do we need to correct barriering in circular-buffers.rst?
Message-ID: <20190927124929.GB4643@worktop.programming.kicks-ass.net>
References: <CAHk-=wj85tOp8WjcUp6gwstp4Cg2WT=p209S=fOzpWAgqqQPKg@mail.gmail.com>
 <20190915145905.hd5xkc7uzulqhtzr@willie-the-truck>
 <25289.1568379639@warthog.procyon.org.uk>
 <28447.1568728295@warthog.procyon.org.uk>
 <20190917170716.ud457wladfhhjd6h@willie-the-truck>
 <15228.1568821380@warthog.procyon.org.uk>
 <5385.1568901546@warthog.procyon.org.uk>
 <20190923144931.GC2369@hirez.programming.kicks-ass.net>
 <20190927095107.GA13098@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927095107.GA13098@andrea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 27, 2019 at 11:51:07AM +0200, Andrea Parri wrote:

> For the record, the LKMM doesn't currently model "order" derived from
> control dependencies to a _plain_ access (even if the plain access is
> a write): in particular, the following is racy (as far as the current
> LKMM is concerned):
> 
> C rb
> 
> { }
> 
> P0(int *tail, int *data, int *head)
> {
> 	if (READ_ONCE(*tail)) {
> 		*data = 1;
> 		smp_wmb();
> 		WRITE_ONCE(*head, 1);
> 	}
> }
> 
> P1(int *tail, int *data, int *head)
> {
> 	int r0;
> 	int r1;
> 
> 	r0 = READ_ONCE(*head);
> 	smp_rmb();
> 	r1 = *data;
> 	smp_mb();
> 	WRITE_ONCE(*tail, 1);
> }
> 
> Replacing the plain "*data = 1" with "WRITE_ONCE(*data, 1)" (or doing
> s/READ_ONCE(*tail)/smp_load_acquire(tail)) suffices to avoid the race.
> Maybe I'm short of imagination this morning...  but I can't currently
> see how the compiler could "break" the above scenario.

The compiler; if sufficiently smart; is 'allowed' to change P0 into
something terrible like:

	*data = 1;
	if (*tail) {
		smp_wmb();
		*head = 1;
	} else
		*data = 0;


(assuming it knows *data was 0 from a prior store or something)

Using WRITE_ONCE() defeats this because volatile indicates external
visibility.

> I also didn't spend much time thinking about it.  memory-barriers.txt
> has a section "CONTROL DEPENDENCIES" dedicated to "alerting developers
> using control dependencies for ordering".  That's quite a long section
> (and probably still incomplete); the last paragraph summarizes:  ;-)

Barring LTO the above works for perf because of inter-translation-unit
function calls, which imply a compiler barrier.

Now, when the compiler inlines, it looses that sync point (and thereby
subtlely changes semantics from the non-inline variant). I suspect LTO
does the same and can cause subtle breakage through this transformation.

> (*) Compilers do not understand control dependencies.  It is therefore
>     your job to ensure that they do not break your code.

It is one the list of things I want to talk about when I finally get
relevant GCC and LLVM people in the same room ;-)

Ideally the compiler can be taught to recognise conditionals dependent
on 'volatile' loads and disallow problematic transformations around
them.

I've added Nick (clang) and Jose (GCC) on Cc, hopefully they can help
find the right people for us.
