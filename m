Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B959F58714E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 21:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiHATUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 15:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiHATUi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82091B0D;
        Mon,  1 Aug 2022 12:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05E6160D33;
        Mon,  1 Aug 2022 19:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56689C433D6;
        Mon,  1 Aug 2022 19:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659381636;
        bh=zzXyf7TJzmP7QyPlXsvbbhy9XsF6eg6AGGTJjS/KQ8A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=q1GNB9G6PpUUqsGTikI74F1iV0ghrhGbMMpvAz5OaprUZ/JyecWcFshywi+0dwCv7
         qNUHk719JJc1qisCycKETZjzBJQ7PL5JvjF4+RBU7cvuwAFojugW7kTYbUVg/jV9Vl
         S7poi65EORt/dfg+5auNWlWVEPjq9/QJh4Nnl+VR53ZpMiTJBpLD6OVnCoRf/2kYjY
         W5A4XZBJ0LQWumP/ELCZYbxFJm+fX2qNfx+fG8TTzwRrB4c9D7OPOyTpZcqbSDB6tj
         O5vtFnCtuoBeHHfrhpVGl0XkUuqtWfBgSmKdWcBvOaXEzzRd2BNzaOYseyIrWiOlod
         fHUBNlZCriybg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DFD105C0D2B; Mon,  1 Aug 2022 12:20:35 -0700 (PDT)
Date:   Mon, 1 Aug 2022 12:20:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
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
Message-ID: <20220801192035.GA2860372@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <20220731173011.GX2860372@paulmck-ThinkPad-P17-Gen-1>
 <20220801154108.GA26280@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801154108.GA26280@willie-the-truck>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 01, 2022 at 04:41:09PM +0100, Will Deacon wrote:
> Hi Linus, Paul,
> 
> Apologies for the slow response here; believe it or not, I was attending
> a workshop about memory ordering.

Nice!!!  Anything that I can/should know from that gathering?  ;-)

> On Sun, Jul 31, 2022 at 10:30:11AM -0700, Paul E. McKenney wrote:
> > On Sun, Jul 31, 2022 at 09:51:47AM -0700, Linus Torvalds wrote:
> > > Even alpha is specified to be locally ordered wrt *one* memory
> > > location, including for reads (See table 5-1: "Processor issue order",
> > > and also 5.6.2.2: "Litmus test 2"). So if a previous read has seen a
> > > new value, a subsequent read is not allowed to see an older one - even
> > > without a memory barrier.
> > > 
> > > Will, Paul? Maybe that's only for overlapping loads/stores, not for
> > > loads/loads. Because maybe alpha for once isn't the weakest possible
> > > ordering.
> > 
> > The "bad boy" in this case is Itanium, which can do some VLIW reordering
> > of accesses.  Or could, I am not sure that newer Itanium hardware
> > does this.  But this is why Itanium compilers made volatile loads use
> > the ld,acq instruction.
> > 
> > Which means that aligned same-sized marked accesses to a single location
> > really do execute consistently with some global ordering, even on Itanium.
> 
> Although this is true, there's a really subtle issue which crops up if you
> try to compose this read-after-read ordering with dependencies in the case
> where the two reads read the same value (which is encapsulated by the
> unusual RSW litmus test that I've tried to convert to C below):

RSW from the infamous test6.pdf, correct?

> /* Global definitions; assume everything zero-initialised */
> struct foo {
> 	int *x;
> };
> 
> int x;
> struct foo foo;
> struct foo *ptr;
> 
> 
> /* CPU 0 */
> WRITE_ONCE(x, 1);

Your x is RSW's z?

> WRITE_ONCE(foo.x, &x);

And your foo.x is RSW's x?  If so, the above WRITE_ONCE() could happen at
compile time, correct?  Or in the initialization clause of a litmus test?

> /*
>  * Release ordering to ensure that somebody following a non-NULL ptr will
>  * see a fully-initialised 'foo'. smp_[w]mb() would work as well.
>  */
> smp_store_release(&ptr, &foo);

Your ptr is RSW's y, correct?

> /* CPU 1 */
> int *xp1, *xp2, val;
> struct foo *foop;
> 
> /* Load the global pointer and check that it's not NULL. */
> foop = READ_ONCE(ptr);
> if (!foop)
> 	return;

A litmus tests can do this via the filter clause.

> /*
>  * Load 'foo.x' via the pointer we just loaded. This is ordered after the
>  * previous READ_ONCE() because of the address dependency.
>  */
> xp1 = READ_ONCE(foop->x);
> 
> /*
>  * Load 'foo.x' directly via the global 'foo'.
>  * _This is loading the same address as the previous READ_ONCE() and
>  *  therefore cannot return a stale (NULL) value!_
>  */
> xp2 = READ_ONCE(foo.x);

OK, same location, but RSW calls only for po, not addr from the initial
read to this read, got it.  (My first attempt left out this nuance,
in case you were wondering.)

> /*
>  * Load 'x' via the pointer we just loaded.
>  * _We may see zero here!_
>  */
> val = READ_ONCE(*xp2);

And herd7/LKMM agree with this, at least assuming I got the litmus
test right.  (I used RSW's variables as a cross-check.)

> So in this case, the two same-location reads on CPU1 are actually executed
> out of order, but you can't tell just by looking at them in isolation
> because they returned the same value (i.e. xp1 == xp2 == &x). However, you
> *can* tell when you compose them in funny situations such as above (and I
> believe that this is demonstrably true on PPC and Arm; effectively the
> read-after-read ordering machinery only triggers in response to incoming
> snoops).

Again, I leave the hardware specifics to the respective maintainers.

> There's probably a more-compelling variant using an (RCpc) load acquire
> instead of the last address dependency on CPU 1 as well.
> 
> Anyway, I think all I'm trying to say is that I'd tend to shy away from
> relying on read-after-read ordering if it forms part of a more involved
> ordering relationship.

Agreed.  As soon as you add that second variable, you need more ordering.
The read-after-read ordering applies only within the confines of a single
variable, and you need more ordering when you add that second variable.
And as Will's RSW example shows, more ordering than you might think.

> > > But the patch looks fine, though I agree that the ordering in
> > > __wait_on_buffer should probably be moved into
> > > wait_on_bit/wait_on_bit_io.
> > > 
> > > And would we perhaps want the bitops to have the different ordering
> > > versions? Like "set_bit_release()" and "test_bit_acquire()"? That
> > > would seem to be (a) cleaner and (b) possibly generate better code for
> > > architectures where that makes a difference?
> > 
> > As always, I defer to the architecture maintainers on this one.
> 
> FWIW, that makes sense to me. We already have release/acquire/releaxed
> variants of the bitops in the atomic_t API so it seems natural to have
> a counterpart in the actual bitops API as well.

Just to join you guys in liking acquire and release better than smp_wmb()
and smp_rmb().  My RCU life got much better after update-side uses of
smp_wmb() were replaced by rcu_assign_pointer() and read-side uses of
smp_read_barrier_depends() were replaced by rcu_dereference().

							Thanx, Paul

------------------------------------------------------------------------

C rsw

{
	a=0;
	x=z;
	y=a;
	z=0;
}

P0(int *x, int **y, int *z)
{
	WRITE_ONCE(*z, 1);
	WRITE_ONCE(*y, x);
}

P1(int *x, int **y, int *z)
{
	r1 = READ_ONCE(*y);
	r2 = READ_ONCE(*r1);
	r3 = READ_ONCE(*x);
	r4 = READ_ONCE(*r3);
}

filter(1:r1=x)
exists(1:r2=z /\ 1:r3=z /\ 1:r4=0)

------------------------------------------------------------------------

$ herd7 -conf linux-kernel.cfg /tmp/rsw.litmus
Test rsw Allowed
States 2
1:r2=z; 1:r3=z; 1:r4=0;
1:r2=z; 1:r3=z; 1:r4=1;
Ok
Witnesses
Positive: 1 Negative: 1
Condition exists (1:r2=z /\ 1:r3=z /\ 1:r4=0)
Observation rsw Sometimes 1 1
Time rsw 0.00
Hash=03618e3079eb0d371ca0f1ab679f3eae
