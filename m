Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92817586DEC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 17:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiHAPlU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 11:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiHAPlS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:41:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3C828702;
        Mon,  1 Aug 2022 08:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A09C760B84;
        Mon,  1 Aug 2022 15:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC09C433D6;
        Mon,  1 Aug 2022 15:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659368477;
        bh=McQjB7B9+v6P6Vwsyy7FekofjGEdZ7yr6p3TwkW422k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/nizH6z4oa2MFgq4rDBoMlCCjcUelTNIm48N5xxMvOpwrvypb0hLAAiDoZoX8Fis
         gM8FG/bdT1Gf34pKc+iQaH0gmhTJHRRvDcWXfxlcsTwilbW8YRcJQpDXVZrLNBvitZ
         vGC8IlZnklxu1jty5KQCaxtoNxW4ZIYcCB/sgnr3BKJMmeWP3PFx64AHFV2zCd+OKL
         RBQVZKu0o7T9bJ6vE2PAk4ef2gagrtXOywMx3frPCbQUeKaLXXeyHzQI+8wlcVDEC+
         PkKklTA1+araS+GHQrRIXYFCNjk/GIdf+1EItsoDxUTLeSksBXcdu0LTEuE85Bz67I
         pUP6BQV42Wc5g==
Date:   Mon, 1 Aug 2022 16:41:09 +0100
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
Message-ID: <20220801154108.GA26280@willie-the-truck>
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <20220731173011.GX2860372@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220731173011.GX2860372@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus, Paul,

Apologies for the slow response here; believe it or not, I was attending
a workshop about memory ordering.

On Sun, Jul 31, 2022 at 10:30:11AM -0700, Paul E. McKenney wrote:
> On Sun, Jul 31, 2022 at 09:51:47AM -0700, Linus Torvalds wrote:
> > Even alpha is specified to be locally ordered wrt *one* memory
> > location, including for reads (See table 5-1: "Processor issue order",
> > and also 5.6.2.2: "Litmus test 2"). So if a previous read has seen a
> > new value, a subsequent read is not allowed to see an older one - even
> > without a memory barrier.
> > 
> > Will, Paul? Maybe that's only for overlapping loads/stores, not for
> > loads/loads. Because maybe alpha for once isn't the weakest possible
> > ordering.
> 
> The "bad boy" in this case is Itanium, which can do some VLIW reordering
> of accesses.  Or could, I am not sure that newer Itanium hardware
> does this.  But this is why Itanium compilers made volatile loads use
> the ld,acq instruction.
> 
> Which means that aligned same-sized marked accesses to a single location
> really do execute consistently with some global ordering, even on Itanium.

Although this is true, there's a really subtle issue which crops up if you
try to compose this read-after-read ordering with dependencies in the case
where the two reads read the same value (which is encapsulated by the
unusual RSW litmus test that I've tried to convert to C below):


/* Global definitions; assume everything zero-initialised */
struct foo {
	int *x;
};

int x;
struct foo foo;
struct foo *ptr;


/* CPU 0 */
WRITE_ONCE(x, 1);
WRITE_ONCE(foo.x, &x);

/*
 * Release ordering to ensure that somebody following a non-NULL ptr will
 * see a fully-initialised 'foo'. smp_[w]mb() would work as well.
 */
smp_store_release(&ptr, &foo);


/* CPU 1 */
int *xp1, *xp2, val;
struct foo *foop;

/* Load the global pointer and check that it's not NULL. */
foop = READ_ONCE(ptr);
if (!foop)
	return;

/*
 * Load 'foo.x' via the pointer we just loaded. This is ordered after the
 * previous READ_ONCE() because of the address dependency.
 */
xp1 = READ_ONCE(foop->x);

/*
 * Load 'foo.x' directly via the global 'foo'.
 * _This is loading the same address as the previous READ_ONCE() and
 *  therefore cannot return a stale (NULL) value!_
 */
xp2 = READ_ONCE(foo.x);

/*
 * Load 'x' via the pointer we just loaded.
 * _We may see zero here!_
 */
val = READ_ONCE(*xp2);


So in this case, the two same-location reads on CPU1 are actually executed
out of order, but you can't tell just by looking at them in isolation
because they returned the same value (i.e. xp1 == xp2 == &x). However, you
*can* tell when you compose them in funny situations such as above (and I
believe that this is demonstrably true on PPC and Arm; effectively the
read-after-read ordering machinery only triggers in response to incoming
snoops).

There's probably a more-compelling variant using an (RCpc) load acquire
instead of the last address dependency on CPU 1 as well.

Anyway, I think all I'm trying to say is that I'd tend to shy away from
relying on read-after-read ordering if it forms part of a more involved
ordering relationship.

> > But the patch looks fine, though I agree that the ordering in
> > __wait_on_buffer should probably be moved into
> > wait_on_bit/wait_on_bit_io.
> > 
> > And would we perhaps want the bitops to have the different ordering
> > versions? Like "set_bit_release()" and "test_bit_acquire()"? That
> > would seem to be (a) cleaner and (b) possibly generate better code for
> > architectures where that makes a difference?
> 
> As always, I defer to the architecture maintainers on this one.

FWIW, that makes sense to me. We already have release/acquire/releaxed
variants of the bitops in the atomic_t API so it seems natural to have
a counterpart in the actual bitops API as well.

Will
