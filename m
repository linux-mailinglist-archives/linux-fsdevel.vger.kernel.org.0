Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CA5586307
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 05:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbiHADUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jul 2022 23:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239521AbiHADUu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:20:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A3F6451;
        Sun, 31 Jul 2022 20:20:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47EC460FF8;
        Mon,  1 Aug 2022 03:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45A2C433C1;
        Mon,  1 Aug 2022 03:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659324045;
        bh=XcVtSPHVyz9TCIWPL/CT3cYLdvOGA6J9UpEZKi9CB1A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nsrKs+ys2S25dcwsjC8ako9YHKLFBcjGWqrL2ZwsOgq3SUCdyq9E3FBS5biNuOxlz
         d6/BclXitukK1K/SsGd3InWgEeSPbe2F8ldOkx12ijVHPe7YxCvivh2hxiJ6uDKklN
         VmUzder6K/DS2y+dv93Jsjl2eGtUu7F7w/Y/w8pIBFY1I/yyDTADnP900YnDi/kN3J
         lrlxCYEDS+cdW8CPjeIOK7LzbohoYIE44FJxlK76isCIxDruJlOFxxdFH9KUtHKS4I
         yH+Htssn8Rvh9+0NqzKHFpcEIHOci29ys7B586tQxjUcN0p/VE9NLqEtO7/yezQ9NV
         ZTxYslP/bHiUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 433805C03E0; Sun, 31 Jul 2022 20:20:45 -0700 (PDT)
Date:   Sun, 31 Jul 2022 20:20:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
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
Message-ID: <20220801032045.GZ2860372@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <20220731173011.GX2860372@paulmck-ThinkPad-P17-Gen-1>
 <YucGwGr4KTPPxbYJ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YucGwGr4KTPPxbYJ@casper.infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 31, 2022 at 11:48:32PM +0100, Matthew Wilcox wrote:
> On Sun, Jul 31, 2022 at 10:30:11AM -0700, Paul E. McKenney wrote:
> > That said, I confess that I am having a hard time finding the
> > buffer_locked() definition.  So if buffer_locked() uses normal C-language
> > accesses to sample the BH_Lock bit of the ->b_state field, then yes,
> > there could be a problem.  The compiler would then be free to reorder
> > calls to buffer_locked() because it could then assume that no other
> > thread was touching that ->b_state field.
> 
> You're having a hard time finding it because it's constructed with the C
> preprocessor.  I really wish we generated header files using CPP once
> and then included the generated/ file.  That would make them greppable.
> 
> You're looking for include/linux/buffer_head.h and it's done like this:
> 
> enum bh_state_bits {
> ...
>         BH_Lock,        /* Is locked */
> ...
> 
> #define BUFFER_FNS(bit, name)                                           \
> ...
> static __always_inline int buffer_##name(const struct buffer_head *bh)  \
> {                                                                       \
>         return test_bit(BH_##bit, &(bh)->b_state);                      \
> }
> 
> BUFFER_FNS(Lock, locked)
> 
> (fwiw, the page/folio versions of these functions don't autogenerate
> the lock or uptodate ones because they need extra functions called)

Thank you!

Another thing that would have helped me find it would have been to leave
the "BH_" prefix on the bit name in the BUFFER_FNS() invocation, as in
ditch the "BH_##" in the definition and then just say "BUFFER_FNS(BH_Lock,
locked)".

But what is life without a challenge?  ;-/

Anyway, on x86 this will use the constant_test_bit() function, which
uses a volatile declaration for its parameter.  So it should avoid
vulnerability to the vicissitudes of the compiler.

So I feel much better now.

							Thanx, Paul
