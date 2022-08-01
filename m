Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DED586209
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 02:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiHAA14 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jul 2022 20:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiHAA1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jul 2022 20:27:54 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CDA02D124
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Jul 2022 17:27:52 -0700 (PDT)
Received: (qmail 554189 invoked by uid 1000); 31 Jul 2022 20:27:51 -0400
Date:   Sun, 31 Jul 2022 20:27:51 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Subject: Re: [PATCH v3 1/2] wait_bit: do read barrier after testing a bit
Message-ID: <YuceB1x8twgpM7Bl@rowland.harvard.edu>
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 31, 2022 at 04:40:59PM -0400, Mikulas Patocka wrote:
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
> We fix this class of bugs by adding a read barrier after test_bit().
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
> 
> Index: linux-2.6/include/linux/wait_bit.h
> ===================================================================
> --- linux-2.6.orig/include/linux/wait_bit.h
> +++ linux-2.6/include/linux/wait_bit.h
> @@ -71,8 +71,10 @@ static inline int
>  wait_on_bit(unsigned long *word, int bit, unsigned mode)
>  {
>  	might_sleep();
> -	if (!test_bit(bit, word))
> +	if (!test_bit(bit, word)) {
> +		smp_rmb();

Any new code using smp_rmb or an acquire access should always include a 
comment that explains where the matching smp_wmb or release access is.

Alan Stern

>  		return 0;
> +	}
>  	return out_of_line_wait_on_bit(word, bit,
>  				       bit_wait,
>  				       mode);
> @@ -96,8 +98,10 @@ static inline int
>  wait_on_bit_io(unsigned long *word, int bit, unsigned mode)
>  {
>  	might_sleep();
> -	if (!test_bit(bit, word))
> +	if (!test_bit(bit, word)) {
> +		smp_rmb();
>  		return 0;
> +	}
>  	return out_of_line_wait_on_bit(word, bit,
>  				       bit_wait_io,
>  				       mode);
> @@ -123,8 +127,10 @@ wait_on_bit_timeout(unsigned long *word,
>  		    unsigned long timeout)
>  {
>  	might_sleep();
> -	if (!test_bit(bit, word))
> +	if (!test_bit(bit, word)) {
> +		smp_rmb();
>  		return 0;
> +	}
>  	return out_of_line_wait_on_bit_timeout(word, bit,
>  					       bit_wait_timeout,
>  					       mode, timeout);
> @@ -151,8 +157,10 @@ wait_on_bit_action(unsigned long *word,
>  		   unsigned mode)
>  {
>  	might_sleep();
> -	if (!test_bit(bit, word))
> +	if (!test_bit(bit, word)) {
> +		smp_rmb();
>  		return 0;
> +	}
>  	return out_of_line_wait_on_bit(word, bit, action, mode);
>  }
>  
> Index: linux-2.6/kernel/sched/wait_bit.c
> ===================================================================
> --- linux-2.6.orig/kernel/sched/wait_bit.c
> +++ linux-2.6/kernel/sched/wait_bit.c
> @@ -51,6 +51,8 @@ __wait_on_bit(struct wait_queue_head *wq
>  
>  	finish_wait(wq_head, &wbq_entry->wq_entry);
>  
> +	smp_rmb();
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(__wait_on_bit);
> 
