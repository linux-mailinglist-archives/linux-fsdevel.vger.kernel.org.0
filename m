Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E99858792C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 10:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiHBIk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 04:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbiHBIk0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3AFDF2E;
        Tue,  2 Aug 2022 01:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 643AC60B2F;
        Tue,  2 Aug 2022 08:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EFDC433C1;
        Tue,  2 Aug 2022 08:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659429623;
        bh=rbPayMUNRP+UW1L0745xa3YzYtRl5oydAMq3hSkE6vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FiDO17vWUmS1Z8jtkPzKkyvSaZpJ7ba8MmIocSTM9w2aklYKg5e7Wtw3u7w/f6+VK
         LIziq0FVkDYgIjPpk94igb3yFJ0bXIrT7HfJwt70GEfDcfHDcHotw+CLO9ersYdL8L
         mMQzlGBgQUFgV6rO4cfbPvjVWjR6d8wmQ0c4jrTSQl8kjn2SFxRe/DXrJGyGwlOZE8
         RuTcY4uuQiERasm7s6MphVD+hXI84He3HRqVjv4qHS3+BKkG0b5+kieiq5/8BRECqW
         x6os6UN2aF3IM5cfZihjQekTnjpK9VulnTmFrbdhCvGVnyEMAp5hUKPaYqqyP8gx1+
         KyNA2GQp+KCRw==
Date:   Tue, 2 Aug 2022 09:40:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: Re: [PATCH v4 1/2] introduce test_bit_acquire and use it in
 wait_on_bit
Message-ID: <20220802084015.GB26962@willie-the-truck>
References: <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wjA8HBrVqAqAetUvwNr=hcvhfnO7oMrOAd4V8bbSqokNA@mail.gmail.com>
 <alpine.LRH.2.02.2208010640260.22006@file01.intranet.prod.int.rdu2.redhat.com>
 <20220801155421.GB26280@willie-the-truck>
 <alpine.LRH.2.02.2208011206430.31960@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2208011206430.31960@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 01, 2022 at 12:12:47PM -0400, Mikulas Patocka wrote:
> On Mon, 1 Aug 2022, Will Deacon wrote:
> > On Mon, Aug 01, 2022 at 06:42:15AM -0400, Mikulas Patocka wrote:
> > 
> > > Index: linux-2.6/arch/x86/include/asm/bitops.h
> > > ===================================================================
> > > --- linux-2.6.orig/arch/x86/include/asm/bitops.h	2022-08-01 12:27:43.000000000 +0200
> > > +++ linux-2.6/arch/x86/include/asm/bitops.h	2022-08-01 12:27:43.000000000 +0200
> > > @@ -203,8 +203,10 @@ arch_test_and_change_bit(long nr, volati
> > >  
> > >  static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
> > >  {
> > > -	return ((1UL << (nr & (BITS_PER_LONG-1))) &
> > > +	bool r = ((1UL << (nr & (BITS_PER_LONG-1))) &
> > >  		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
> > > +	barrier();
> > > +	return r;
> > 
> > Hmm, I find it a bit weird to have a barrier() here given that 'addr' is
> > volatile and we don't need a barrier() like this in the definition of
> > READ_ONCE(), for example.
> 
> gcc doesn't reorder two volatile accesses, but it can reorder non-volatile
> accesses around volatile accesses.
> 
> The purpose of the compiler barrier is to make sure that the non-volatile 
> accesses that follow test_bit are not reordered by the compiler before the 
> volatile access to addr.

If we need these accesses to be ordered reliably, then we need a CPU barrier
and that will additionally prevent the compiler reordering. So I still don't
think we need the barrier() here.

> > > Index: linux-2.6/include/linux/wait_bit.h
> > > ===================================================================
> > > --- linux-2.6.orig/include/linux/wait_bit.h	2022-08-01 12:27:43.000000000 +0200
> > > +++ linux-2.6/include/linux/wait_bit.h	2022-08-01 12:27:43.000000000 +0200
> > > @@ -71,7 +71,7 @@ static inline int
> > >  wait_on_bit(unsigned long *word, int bit, unsigned mode)
> > >  {
> > >  	might_sleep();
> > > -	if (!test_bit(bit, word))
> > > +	if (!test_bit_acquire(bit, word))
> > >  		return 0;
> > >  	return out_of_line_wait_on_bit(word, bit,
> > >  				       bit_wait,
> > 
> > Yet another approach here would be to leave test_bit as-is and add a call to
> > smp_acquire__after_ctrl_dep() since that exists already -- I don't have
> > strong opinions about it, but it saves you having to add another stub to
> > x86.
> 
> It would be the same as my previous patch with smp_rmb() that Linus didn't 
> like. But I think smp_rmb (or smp_acquire__after_ctrl_dep) would be 
> correct here.

Right, I saw Linus' objection to smp_rmb() and I'm not sure where
smp_acquire__after_ctrl_dep() fits in with his line of reasoning. On the one
hand, it's talking about acquire ordering, but on the other, it's ugly as
sin :)

Will
