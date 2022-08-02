Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511CD587967
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 10:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiHBIzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 04:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbiHBIzG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:55:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4653642ADC;
        Tue,  2 Aug 2022 01:55:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F24ADB819ED;
        Tue,  2 Aug 2022 08:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B243C433C1;
        Tue,  2 Aug 2022 08:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659430502;
        bh=v15SE+bUAYu+VHGxejCWUdqp30Em57EgFuZNbFuNzTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbqFy2fE3Hh6GUPcBuRDtvA42awecTErYS9b1Hsb9KTF/K59i5ujZxqkV0Umlmo9u
         UP/RyYbwe/IKDhdjQCqUDCxefMu6VfEry+/VRsPztmsyBNyeAZmuOy21xxh4dR13Zo
         /Cr2iCHUecG9MSfjHQaSRAwT3Fzxvgl6/W2cteBcXPB+ABgRQWFwiIJ/rXc9vnKy6a
         G20Cvw8Tlsr8wQrzWFfQldfN8qmG7x2sjBP9GMZysrv7K8p89F8JrfCVYwUg4Af/fm
         UdOR78bEMaQyZwOGK/3T81a4FdefnqNZ3EEevH4hrM2ZiPRxIsYVWhZ1KECk0gmSnb
         oJ10SWnBG+yvg==
Date:   Tue, 2 Aug 2022 09:54:55 +0100
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] make buffer_locked provide an acquire semantics
Message-ID: <20220802085455.GC26962@willie-the-truck>
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <20220731173011.GX2860372@paulmck-ThinkPad-P17-Gen-1>
 <20220801154108.GA26280@willie-the-truck>
 <20220801192035.GA2860372@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801192035.GA2860372@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 01, 2022 at 12:20:35PM -0700, Paul E. McKenney wrote:
> On Mon, Aug 01, 2022 at 04:41:09PM +0100, Will Deacon wrote:
> > Apologies for the slow response here; believe it or not, I was attending
> > a workshop about memory ordering.
> 
> Nice!!!  Anything that I can/should know from that gathering?  ;-)

Oh come off it, you know this stuff already ;)

> > On Sun, Jul 31, 2022 at 10:30:11AM -0700, Paul E. McKenney wrote:
> > > On Sun, Jul 31, 2022 at 09:51:47AM -0700, Linus Torvalds wrote:
> > > > Even alpha is specified to be locally ordered wrt *one* memory
> > > > location, including for reads (See table 5-1: "Processor issue order",
> > > > and also 5.6.2.2: "Litmus test 2"). So if a previous read has seen a
> > > > new value, a subsequent read is not allowed to see an older one - even
> > > > without a memory barrier.
> > > > 
> > > > Will, Paul? Maybe that's only for overlapping loads/stores, not for
> > > > loads/loads. Because maybe alpha for once isn't the weakest possible
> > > > ordering.
> > > 
> > > The "bad boy" in this case is Itanium, which can do some VLIW reordering
> > > of accesses.  Or could, I am not sure that newer Itanium hardware
> > > does this.  But this is why Itanium compilers made volatile loads use
> > > the ld,acq instruction.
> > > 
> > > Which means that aligned same-sized marked accesses to a single location
> > > really do execute consistently with some global ordering, even on Itanium.
> > 
> > Although this is true, there's a really subtle issue which crops up if you
> > try to compose this read-after-read ordering with dependencies in the case
> > where the two reads read the same value (which is encapsulated by the
> > unusual RSW litmus test that I've tried to convert to C below):
> 
> RSW from the infamous test6.pdf, correct?

That's the badger. I've no doubt that you're aware of it already, but I
thought it was a useful exercise to transcribe it to C and have it on the
mailing list for folks to look at.

> > /* Global definitions; assume everything zero-initialised */
> > struct foo {
> > 	int *x;
> > };
> > 
> > int x;
> > struct foo foo;
> > struct foo *ptr;
> > 
> > 
> > /* CPU 0 */
> > WRITE_ONCE(x, 1);
> 
> Your x is RSW's z?

Yes.

> > WRITE_ONCE(foo.x, &x);
> 
> And your foo.x is RSW's x?  If so, the above WRITE_ONCE() could happen at
> compile time, correct?  Or in the initialization clause of a litmus test?

Yes, although I think it's a tiny bit more like real code to have it done
here, although it means that the "surprising" outcome relies on this being
reordered before the store to x.

> > /*
> >  * Release ordering to ensure that somebody following a non-NULL ptr will
> >  * see a fully-initialised 'foo'. smp_[w]mb() would work as well.
> >  */
> > smp_store_release(&ptr, &foo);
> 
> Your ptr is RSW's y, correct?

Yes.

> > /* CPU 1 */
> > int *xp1, *xp2, val;
> > struct foo *foop;
> > 
> > /* Load the global pointer and check that it's not NULL. */
> > foop = READ_ONCE(ptr);
> > if (!foop)
> > 	return;
> 
> A litmus tests can do this via the filter clause.

Indeed, but I was trying to make this look like C code for non-litmus
speakers!

> > /*
> >  * Load 'foo.x' via the pointer we just loaded. This is ordered after the
> >  * previous READ_ONCE() because of the address dependency.
> >  */
> > xp1 = READ_ONCE(foop->x);
> > 
> > /*
> >  * Load 'foo.x' directly via the global 'foo'.
> >  * _This is loading the same address as the previous READ_ONCE() and
> >  *  therefore cannot return a stale (NULL) value!_
> >  */
> > xp2 = READ_ONCE(foo.x);
> 
> OK, same location, but RSW calls only for po, not addr from the initial
> read to this read, got it.  (My first attempt left out this nuance,
> in case you were wondering.)

Right, there is only po from the initial read to this read. If there was an
address dependency, then we'd have a chain of address dependencies from the
first read to the last read on this CPU and the result (of x == 0) would be
forbidden.

> > /*
> >  * Load 'x' via the pointer we just loaded.
> >  * _We may see zero here!_
> >  */
> > val = READ_ONCE(*xp2);
> 
> And herd7/LKMM agree with this, at least assuming I got the litmus
> test right.  (I used RSW's variables as a cross-check.)

That's promising, but see below...

> C rsw
> 
> {
> 	a=0;
> 	x=z;
> 	y=a;
> 	z=0;
> }
> 
> P0(int *x, int **y, int *z)
> {
> 	WRITE_ONCE(*z, 1);
> 	WRITE_ONCE(*y, x);
> }

Ah wait, you need a barrier between these two writes, don't you? I used
an smp_store_release() but smp[w]_mb() should do too.

Will
