Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E725861A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 00:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238336AbiGaWOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jul 2022 18:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGaWOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:14:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A69DEFE;
        Sun, 31 Jul 2022 15:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+qm1vAmgi6sjZNEi6Z0fSdbuq7XPAQLGXeiD0XxIuOY=; b=HbUcOri3IfM8aEODm6uq0lPTlX
        Td1B9C+jQvJNZeArAg9FQVsunSHEatuIuq2N4hLFVV56R06dLus5sIcgladiW9a/3h0XyQL6H7iNo
        L0LOfaiVQYfU/O+lx0d7lkuOjE7JFd0Ax3x3qT5tMjObgECHRgA46V9Sz3IYsq5et9n6lzd3PcAJ4
        /vrcYhhisOBYKQrwbs/mLmV8I43ORiM+qeBmov5NH857ExVaiQQ8SRxstAMTqsYx/WT8FDsbiCu9C
        fdJoXt4jmHaH+VK2/NFg80oN4v84Ixb3zxlkmEwW9zVKtyo2T4QXjc9zucLWm09Ajl0MRzFHjhQ0a
        5bWQXYvg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oIHCW-006bWs-A2; Sun, 31 Jul 2022 22:14:20 +0000
Date:   Sun, 31 Jul 2022 23:14:20 +0100
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
Subject: Re: [PATCH v3 2/2] make buffer_locked provide an acquire semantics
Message-ID: <Yub+vPb53zt6dDpn@casper.infradead.org>
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311641060.21350@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2207311641060.21350@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 31, 2022 at 04:43:08PM -0400, Mikulas Patocka wrote:
> Let's have a look at this piece of code in __bread_slow:
> 	get_bh(bh);
> 	bh->b_end_io = end_buffer_read_sync;
> 	submit_bh(REQ_OP_READ, 0, bh);
> 	wait_on_buffer(bh);
> 	if (buffer_uptodate(bh))
> 		return bh;
> Neither wait_on_buffer nor buffer_uptodate contain a memory barrier.
> Consequently, if someone calls sb_bread and then reads the buffer data,
> the read of buffer data may be executed before wait_on_buffer(bh) on
> architectures with weak memory ordering and it may return invalid data.

I think we should be consistent between PageUptodate() and
buffer_uptodate().  Here's how it's done for pages currently:

static inline bool folio_test_uptodate(struct folio *folio)
        bool ret = test_bit(PG_uptodate, folio_flags(folio, 0));
        /*
         * Must ensure that the data we read out of the folio is loaded
         * _after_ we've loaded folio->flags to check the uptodate bit.
         * We can skip the barrier if the folio is not uptodate, because
         * we wouldn't be reading anything from it.
         *
         * See folio_mark_uptodate() for the other side of the story.
         */
        if (ret)
                smp_rmb();

        return ret;

...

static __always_inline void folio_mark_uptodate(struct folio *folio)
        /*
         * Memory barrier must be issued before setting the PG_uptodate bit,
         * so that all previous stores issued in order to bring the folio
         * uptodate are actually visible before folio_test_uptodate becomes true.
         */
        smp_wmb();
        set_bit(PG_uptodate, folio_flags(folio, 0));

I'm happy for these to also be changed to use acquire/release; no
attachment to the current code.  But bufferheads & pages should have the
same semantics, or we'll be awfully confused.
