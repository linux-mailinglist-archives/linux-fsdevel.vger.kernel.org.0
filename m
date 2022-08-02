Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780DA587D3E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 15:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbiHBNhH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 09:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbiHBNhD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:37:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20811FCE8;
        Tue,  2 Aug 2022 06:37:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CBEC61386;
        Tue,  2 Aug 2022 13:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F27EC433C1;
        Tue,  2 Aug 2022 13:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659447420;
        bh=ZlMhRfPhc4uGPBAikMBqcUj88XgI6PHU0uG5CpAx4/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kSBbnspvYPUyDRKaaXWUC0c7X1DnR9vrhVLe+9f5G9nrQHMFGFWYqZjDnLXVKWI4W
         YopJcceW7IVAxkeDprutNuwpypkV0FVVsKACSY+FUBoXFDU+baAXPaYLvaNTNuj7QI
         Ot6YJzqkSVy246b8+6lga4qN5U1YXVOSeK506OUZmmWzDXDDfuNZKDOQ0me7iGII+R
         8H1YdtRAwYHBYbbuJOpHsH0KIuXT1tapPMcuqF1gLED2GXctT72YSQzg0J3ysoRO1w
         lr8NahCmGGd07RqP13zCDCeNPV48GrCXnFkJesdGQe1mCDtCCffg0aYVEfeyOb5lo9
         i005K8+IhtFGg==
Date:   Tue, 2 Aug 2022 14:36:53 +0100
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
Message-ID: <20220802133652.GA27253@willie-the-truck>
References: <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wjA8HBrVqAqAetUvwNr=hcvhfnO7oMrOAd4V8bbSqokNA@mail.gmail.com>
 <alpine.LRH.2.02.2208010640260.22006@file01.intranet.prod.int.rdu2.redhat.com>
 <20220801155421.GB26280@willie-the-truck>
 <alpine.LRH.2.02.2208011206430.31960@file01.intranet.prod.int.rdu2.redhat.com>
 <20220802084015.GB26962@willie-the-truck>
 <alpine.LRH.2.02.2208020726220.6971@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2208020726220.6971@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 02, 2022 at 07:38:17AM -0400, Mikulas Patocka wrote:
> 
> 
> On Tue, 2 Aug 2022, Will Deacon wrote:
> 
> > On Mon, Aug 01, 2022 at 12:12:47PM -0400, Mikulas Patocka wrote:
> > > On Mon, 1 Aug 2022, Will Deacon wrote:
> > > > On Mon, Aug 01, 2022 at 06:42:15AM -0400, Mikulas Patocka wrote:
> > > > 
> > > > > Index: linux-2.6/arch/x86/include/asm/bitops.h
> > > > > ===================================================================
> > > > > --- linux-2.6.orig/arch/x86/include/asm/bitops.h	2022-08-01 12:27:43.000000000 +0200
> > > > > +++ linux-2.6/arch/x86/include/asm/bitops.h	2022-08-01 12:27:43.000000000 +0200
> > > > > @@ -203,8 +203,10 @@ arch_test_and_change_bit(long nr, volati
> > > > >  
> > > > >  static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
> > > > >  {
> > > > > -	return ((1UL << (nr & (BITS_PER_LONG-1))) &
> > > > > +	bool r = ((1UL << (nr & (BITS_PER_LONG-1))) &
> > > > >  		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
> > > > > +	barrier();
> > > > > +	return r;
> > > > 
> > > > Hmm, I find it a bit weird to have a barrier() here given that 'addr' is
> > > > volatile and we don't need a barrier() like this in the definition of
> > > > READ_ONCE(), for example.
> > > 
> > > gcc doesn't reorder two volatile accesses, but it can reorder non-volatile
> > > accesses around volatile accesses.
> > > 
> > > The purpose of the compiler barrier is to make sure that the non-volatile 
> > > accesses that follow test_bit are not reordered by the compiler before the 
> > > volatile access to addr.
> > 
> > If we need these accesses to be ordered reliably, then we need a CPU barrier
> > and that will additionally prevent the compiler reordering. So I still don't
> > think we need the barrier() here.
> 
> This is x86-specific code. x86 has strong memory ordering, so we only care 
> about compiler reordering.

Indeed, but what I'm trying to say is that the _caller_ would have a memory
barrier in this case, and so there's no need for one in here. test_bit() does
not have ordering semantics.

Will
