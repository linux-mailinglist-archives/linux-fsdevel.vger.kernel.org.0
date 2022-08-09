Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE0E58E06A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 21:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbiHITpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 15:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345036AbiHITot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:44:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCD826553;
        Tue,  9 Aug 2022 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X6ZKr7fgxCrOJ9tv9cKzUL964WC7Pz5KIRmzI2W7soA=; b=O7rcApswccVM2TyEVknqdGGO8v
        hl1R92hKtdyVfwS5opk3FiajnAwrUrdev/h941H+VQ+LsR4yCjsgEbwpZJbQImEGH6YghH2ToRv5z
        o/Pn1jy4xsjDYLdHmVBd+HQ7UCw/bMue4cXeoNS5QcpsZgMd0sZWgrCVMyDqQwbxcUKx60VR9o7FD
        cuY7b1b4Rin/nWyZYgOcaGumrYqPERJSnnizVPVjw2uPB/6SZgeXsfkB6jtPoMpzN/pQ1VH5k0tNO
        UEBpX4m+FaXkSY10KQ/7rgFkkzGiUbgKeZFOKRq+PN27QNvMCfMk2LRwbjx6plW7cz0OluexognRQ
        7kprafMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oLV9T-00Fn8c-Ka; Tue, 09 Aug 2022 19:44:31 +0000
Date:   Tue, 9 Aug 2022 20:44:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v6] add barriers to buffer_uptodate and
 set_buffer_uptodate
Message-ID: <YvK5H+LVm3Bnb78+@casper.infradead.org>
References: <YuflGG60pHiXp2z/@casper.infradead.org>
 <alpine.LRH.2.02.2208011040190.27101@file01.intranet.prod.int.rdu2.redhat.com>
 <YuyNE5c06WStxQ2z@casper.infradead.org>
 <alpine.LRH.2.02.2208070732160.30857@file01.intranet.prod.int.rdu2.redhat.com>
 <Yu/RJtoJPhkWXIdP@casper.infradead.org>
 <alpine.LRH.2.02.2208080928580.8160@file01.intranet.prod.int.rdu2.redhat.com>
 <YvEgZuSdv8XHtkJg@casper.infradead.org>
 <alpine.LRH.2.02.2208081050330.8160@file01.intranet.prod.int.rdu2.redhat.com>
 <YvEuIg3669UeSwjD@casper.infradead.org>
 <alpine.LRH.2.02.2208091359220.5899@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2208091359220.5899@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 09, 2022 at 02:32:13PM -0400, Mikulas Patocka wrote:
> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> Let's have a look at this piece of code in __bread_slow:
> 	get_bh(bh);
> 	bh->b_end_io = end_buffer_read_sync;
> 	submit_bh(REQ_OP_READ, 0, bh);
> 	wait_on_buffer(bh);
> 	if (buffer_uptodate(bh))
> 		return bh;
> Neither wait_on_buffer nor buffer_uptodate contain any memory barrier.
> Consequently, if someone calls sb_bread and then reads the buffer data,
> the read of buffer data may be executed before wait_on_buffer(bh) on
> architectures with weak memory ordering and it may return invalid data.
> 
> Fix this bug by adding a memory barrier to set_buffer_uptodate and an
> acquire barrier to buffer_uptodate (in a similar way as
> folio_test_uptodate and folio_mark_uptodate).
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> Cc: stable@vger.kernel.org
> 
> Index: linux-2.6/include/linux/buffer_head.h
> ===================================================================
> --- linux-2.6.orig/include/linux/buffer_head.h
> +++ linux-2.6/include/linux/buffer_head.h
> @@ -117,7 +117,6 @@ static __always_inline int test_clear_bu
>   * of the form "mark_buffer_foo()".  These are higher-level functions which
>   * do something in addition to setting a b_state bit.
>   */
> -BUFFER_FNS(Uptodate, uptodate)
>  BUFFER_FNS(Dirty, dirty)
>  TAS_BUFFER_FNS(Dirty, dirty)
>  BUFFER_FNS(Lock, locked)
> @@ -135,6 +134,30 @@ BUFFER_FNS(Meta, meta)
>  BUFFER_FNS(Prio, prio)
>  BUFFER_FNS(Defer_Completion, defer_completion)
>  
> +static __always_inline void set_buffer_uptodate(struct buffer_head *bh)
> +{
> +	/*
> +	 * make it consistent with folio_mark_uptodate
> +	 * pairs with smp_load_acquire in buffer_uptodate
> +	 */
> +	smp_mb__before_atomic();
> +	set_bit(BH_Uptodate, &bh->b_state);
> +}
> +
> +static __always_inline void clear_buffer_uptodate(struct buffer_head *bh)
> +{
> +	clear_bit(BH_Uptodate, &bh->b_state);
> +}
> +
> +static __always_inline int buffer_uptodate(const struct buffer_head *bh)
> +{
> +	/*
> +	 * make it consistent with folio_test_uptodate
> +	 * pairs with smp_mb__before_atomic in set_buffer_uptodate
> +	 */
> +	return (smp_load_acquire(&bh->b_state) & (1UL << BH_Uptodate)) != 0;
> +}
> +
>  #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
>  
>  /* If we *know* page->private refers to buffer_heads */
> 
