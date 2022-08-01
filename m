Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21780586E1E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 17:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiHAPyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 11:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbiHAPye (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:54:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847AF3DF1F;
        Mon,  1 Aug 2022 08:54:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3709AB81252;
        Mon,  1 Aug 2022 15:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4E7C433D7;
        Mon,  1 Aug 2022 15:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659369270;
        bh=wETN0skpqza1G2a1AdifFLbckspm2eShjFjwhavetjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MzJVvG5h2GNIc1ys4vKYkGPP3l+3267DHrNX4BuxanV9KbqAyjyxn+l0CVZ4lTOEa
         eZvnjjtomrwFK7j8a/66B8sFrLl37v7+Brzcf4zyWVtYA92o7ziSPdzCJepzVXtbNP
         HaeczdgwxLGZY+jCQ6StvVPXuiK9c0L/px6lLIXWU9u8gV/rfWLkPOszS1TdvcsRrQ
         9M0R5wwiADT8BGDWRzf3Ss8XuuKiNsgp3aLk8YLaDYTXGBkdGJBjIC6mkFGZjfQBru
         U1DO0aQ4lKcZsYzKKerYRJcWjY2t1ZR3f8nnZjEZNPSVX7Lllb/9nNTJCmwhMSRwXO
         skXkDeIUQOLDQ==
Date:   Mon, 1 Aug 2022 16:54:22 +0100
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
Message-ID: <20220801155421.GB26280@willie-the-truck>
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wjA8HBrVqAqAetUvwNr=hcvhfnO7oMrOAd4V8bbSqokNA@mail.gmail.com>
 <alpine.LRH.2.02.2208010640260.22006@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2208010640260.22006@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 01, 2022 at 06:42:15AM -0400, Mikulas Patocka wrote:
> wait_on_bit tests the bit without any memory barriers, consequently the
> code that follows wait_on_bit may be moved before testing the bit on
> architectures with weak memory ordering. When the code tests for some
> event using wait_on_bit and then performs a load operation, the load may
> be unexpectedly moved before wait_on_bit and it may return data that
> existed before the event occurred.
> 
> Such bugs exist in fs/buffer.c:__wait_on_buffer,
> drivers/md/dm-bufio.c:new_read,
> drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:dvb_usb_start_feed,
> drivers/bluetooth/btusb.c:btusb_mtk_hci_wmt_sync
> and perhaps in other places.
> 
> We fix this class of bugs by adding a new function test_bit_acquire that
> reads the bit and provides acquire memory ordering semantics.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
> 
> ---
>  arch/s390/include/asm/bitops.h                       |   10 ++++++++++
>  arch/x86/include/asm/bitops.h                        |    7 ++++++-
>  include/asm-generic/bitops/instrumented-non-atomic.h |   11 +++++++++++
>  include/asm-generic/bitops/non-atomic.h              |   13 +++++++++++++
>  include/linux/wait_bit.h                             |    8 ++++----
>  kernel/sched/wait_bit.c                              |    6 +++---
>  6 files changed, 47 insertions(+), 8 deletions(-)
> 
> Index: linux-2.6/arch/x86/include/asm/bitops.h
> ===================================================================
> --- linux-2.6.orig/arch/x86/include/asm/bitops.h	2022-08-01 12:27:43.000000000 +0200
> +++ linux-2.6/arch/x86/include/asm/bitops.h	2022-08-01 12:27:43.000000000 +0200
> @@ -203,8 +203,10 @@ arch_test_and_change_bit(long nr, volati
>  
>  static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
>  {
> -	return ((1UL << (nr & (BITS_PER_LONG-1))) &
> +	bool r = ((1UL << (nr & (BITS_PER_LONG-1))) &
>  		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
> +	barrier();
> +	return r;

Hmm, I find it a bit weird to have a barrier() here given that 'addr' is
volatile and we don't need a barrier() like this in the definition of
READ_ONCE(), for example.

> Index: linux-2.6/include/linux/wait_bit.h
> ===================================================================
> --- linux-2.6.orig/include/linux/wait_bit.h	2022-08-01 12:27:43.000000000 +0200
> +++ linux-2.6/include/linux/wait_bit.h	2022-08-01 12:27:43.000000000 +0200
> @@ -71,7 +71,7 @@ static inline int
>  wait_on_bit(unsigned long *word, int bit, unsigned mode)
>  {
>  	might_sleep();
> -	if (!test_bit(bit, word))
> +	if (!test_bit_acquire(bit, word))
>  		return 0;
>  	return out_of_line_wait_on_bit(word, bit,
>  				       bit_wait,

Yet another approach here would be to leave test_bit as-is and add a call to
smp_acquire__after_ctrl_dep() since that exists already -- I don't have
strong opinions about it, but it saves you having to add another stub to
x86.

Will
