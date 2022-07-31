Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEC958601D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jul 2022 19:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbiGaRaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jul 2022 13:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiGaRaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jul 2022 13:30:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BFD5F8A;
        Sun, 31 Jul 2022 10:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B3D260F1F;
        Sun, 31 Jul 2022 17:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9DDC433C1;
        Sun, 31 Jul 2022 17:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659288611;
        bh=FH0blCyVvfudwL8ce3BTQJUuYsbrfBaewHrHEz9SgsU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=P8416Z2Yh37otidwE8Z7NVDq7lcvqpRNoWfUOua9IveI8aEUOJ52Nlt/CNTT7wMF2
         2IQ+XlCnziFRSmUT41WYd3b8Bf8aS6D61RTcDsydT8licqRQQVY5psT7Eg3Uc2+PP+
         DajKlQ/1UwQyTEquO8QYUNvlJul+JwnzfQ0YVhO/jCDVnYpzNtH1TAFN3k+N+AAvHv
         IPK1GKzuoTpiwZQuBThZkghdQUhwU6dTh8MWT/qTJy4jrQsVJprRkaEjcyaMVV1W1Y
         1t2KGjeiV7vuhZZSLA5mRlcuQsrIMr2qCHYwlV75I97xPzWwNsInYkUMi6yBQnRWbW
         On4VzjDbmLQbg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3CBD75C03E0; Sun, 31 Jul 2022 10:30:11 -0700 (PDT)
Date:   Sun, 31 Jul 2022 10:30:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Will Deacon <will@kernel.org>,
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
Message-ID: <20220731173011.GX2860372@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 31, 2022 at 09:51:47AM -0700, Linus Torvalds wrote:
> [ Will and Paul, question for you below ]
> 
> On Sun, Jul 31, 2022 at 8:08 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > Also, there is this pattern present several times:
> >         wait_on_buffer(bh);
> >         if (!buffer_uptodate(bh))
> >                 err = -EIO;
> > It may be possible that buffer_uptodate is executed before wait_on_buffer
> > and it may return spurious error.
> 
> I'm not convinced that's actually valid.
> 
> They are testing the same memory location, and I don't think our
> memory ordering model allows for _that_ to be out-of-order. Memory
> barriers are for accesses to different memory locations.

Yes, aligned same-sized marked accesses to a given location are always
executed so as to be consistent with some global order.  Please note the
"marked accesses".  The compiler can rearrange unmarked reads and in
some cases can discard unmarked writes.  For more information, please
see tools/memory-model/Documentation/recipes.txt's "Single CPU or single
memory location" section.

> Even alpha is specified to be locally ordered wrt *one* memory
> location, including for reads (See table 5-1: "Processor issue order",
> and also 5.6.2.2: "Litmus test 2"). So if a previous read has seen a
> new value, a subsequent read is not allowed to see an older one - even
> without a memory barrier.
> 
> Will, Paul? Maybe that's only for overlapping loads/stores, not for
> loads/loads. Because maybe alpha for once isn't the weakest possible
> ordering.

The "bad boy" in this case is Itanium, which can do some VLIW reordering
of accesses.  Or could, I am not sure that newer Itanium hardware
does this.  But this is why Itanium compilers made volatile loads use
the ld,acq instruction.

Which means that aligned same-sized marked accesses to a single location
really do execute consistently with some global ordering, even on Itanium.

That said, I confess that I am having a hard time finding the
buffer_locked() definition.  So if buffer_locked() uses normal C-language
accesses to sample the BH_Lock bit of the ->b_state field, then yes,
there could be a problem.  The compiler would then be free to reorder
calls to buffer_locked() because it could then assume that no other
thread was touching that ->b_state field.

> I didn't find this actually in our documentation, so maybe other
> architectures allow it? Our docs talk about "overlapping loads and
> stores", and maybe that was meant to imply that "load overlaps with
> load" case, but it really reads like load-vs-store, not load-vs-load.

I placed the relevant text from recipes.txt at the end of this email.

> But the patch looks fine, though I agree that the ordering in
> __wait_on_buffer should probably be moved into
> wait_on_bit/wait_on_bit_io.
> 
> And would we perhaps want the bitops to have the different ordering
> versions? Like "set_bit_release()" and "test_bit_acquire()"? That
> would seem to be (a) cleaner and (b) possibly generate better code for
> architectures where that makes a difference?

As always, I defer to the architecture maintainers on this one.

							Thanx, Paul

------------------------------------------------------------------------

Single CPU or single memory location
------------------------------------

If there is only one CPU on the one hand or only one variable
on the other, the code will execute in order.  There are (as
usual) some things to be careful of:

1.	Some aspects of the C language are unordered.  For example,
	in the expression "f(x) + g(y)", the order in which f and g are
	called is not defined; the object code is allowed to use either
	order or even to interleave the computations.

2.	Compilers are permitted to use the "as-if" rule.  That is, a
	compiler can emit whatever code it likes for normal accesses,
	as long as the results of a single-threaded execution appear
	just as if the compiler had followed all the relevant rules.
	To see this, compile with a high level of optimization and run
	the debugger on the resulting binary.

3.	If there is only one variable but multiple CPUs, that variable
	must be properly aligned and all accesses to that variable must
	be full sized.	Variables that straddle cachelines or pages void
	your full-ordering warranty, as do undersized accesses that load
	from or store to only part of the variable.

4.	If there are multiple CPUs, accesses to shared variables should
	use READ_ONCE() and WRITE_ONCE() or stronger to prevent load/store
	tearing, load/store fusing, and invented loads and stores.
	There are exceptions to this rule, including:

	i.	When there is no possibility of a given shared variable
		being updated by some other CPU, for example, while
		holding the update-side lock, reads from that variable
		need not use READ_ONCE().

	ii.	When there is no possibility of a given shared variable
		being either read or updated by other CPUs, for example,
		when running during early boot, reads from that variable
		need not use READ_ONCE() and writes to that variable
		need not use WRITE_ONCE().
