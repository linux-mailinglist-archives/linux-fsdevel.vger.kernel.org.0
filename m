Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6A458A4F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 05:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiHEDXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Aug 2022 23:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiHEDXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Aug 2022 23:23:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8244B21E25;
        Thu,  4 Aug 2022 20:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y19hlVOIXSvoA/5DX9WI7p0EBJzFwJEvgDdU1vLVsK4=; b=BI85Qhy4InI5DYNjrWkW9bWt/h
        sa/60Y2LY23zuokLQ87n0BBwIDkwGpc2DaEb0L9mCVUQ37y91UtlfPuRpnsrJKYUhWeyKqpAeZxHt
        qfO4N+7cWcts5/7+9Dn6FkUPH717h0vV+PpaO869gGVkpQ2mn72r/oALuJSeEZIEcHee/HPxOlsMG
        HU0D+xzovgd4uhkKzrdzrktIWQdkZ1vjbKzxd12bt4hQogTQzDz70+/xbJ7JQYWkp7KxnZ73MvINm
        LjwDI86Q0w6Xq3OBoZyMI49G+omek1fb1V7ZBfJiHFeDALNcI+ajkqVfPnOctnRZ1VOEFFOL0euI6
        UG57muEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oJnvP-00AuLn-KN; Fri, 05 Aug 2022 03:22:59 +0000
Date:   Fri, 5 Aug 2022 04:22:59 +0100
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
Subject: Re: [PATCH v4 2/2] change buffer_locked, so that it has acquire
 semantics
Message-ID: <YuyNE5c06WStxQ2z@casper.infradead.org>
References: <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wjA8HBrVqAqAetUvwNr=hcvhfnO7oMrOAd4V8bbSqokNA@mail.gmail.com>
 <alpine.LRH.2.02.2208010628510.22006@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2208010642220.22006@file01.intranet.prod.int.rdu2.redhat.com>
 <YuflGG60pHiXp2z/@casper.infradead.org>
 <alpine.LRH.2.02.2208011040190.27101@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2208011040190.27101@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 01, 2022 at 11:01:40AM -0400, Mikulas Patocka wrote:
> 
> 
> On Mon, 1 Aug 2022, Matthew Wilcox wrote:
> 
> > On Mon, Aug 01, 2022 at 06:43:55AM -0400, Mikulas Patocka wrote:
> > > Let's have a look at this piece of code in __bread_slow:
> > > 	get_bh(bh);
> > > 	bh->b_end_io = end_buffer_read_sync;
> > > 	submit_bh(REQ_OP_READ, 0, bh);
> > > 	wait_on_buffer(bh);
> > > 	if (buffer_uptodate(bh))
> > > 		return bh;
> > > Neither wait_on_buffer nor buffer_uptodate contain any memory barrier.
> > > Consequently, if someone calls sb_bread and then reads the buffer data,
> > > the read of buffer data may be executed before wait_on_buffer(bh) on
> > > architectures with weak memory ordering and it may return invalid data.
> > > 
> > > Fix this bug by changing the function buffer_locked to have the acquire
> > > semantics - so that code that follows buffer_locked cannot be moved before
> > > it.
> > 
> > I think this is the wrong approach.  Instead, buffer_set_uptodate()
> > should have the smp_wmb() and buffer_uptodate should have the smp_rmb().
> > Just like the page flags.  As I said last night.
> 
> Linus said that he prefers acquire/release to smp_rmb/smp_wmb. So, sort it 
> out with him :)
> 
> In most cases, the buffer is set uptodate while it is locked, so that 
> there is no race on the uptodate flag (the race exists on the locked 
> flag). Are there any cases where the uptodate flag is modified on unlocked 
> buffer, so that it needs special treatment too?

I think you misunderstand the purpose of locked/uptodate.  At least
for pages, the lock flag does not order access to the data in the page.
Indeed, the contents of the page can be changed while you hold the lock.
But the uptodate flag does order access to the data.  At the point where
you can observe the uptodate flag set, you know the contents of the page
have been completely read from storage.  And you don't need to hold the
lock to check the uptodate flag.  So this is wrong:

	buffer_lock()
	*data = 0x12345678;
	buffer_set_uptodate_not_ordered()
	buffer_unlock_ordered()

because a reader can do:

	while (!buffer_test_uptodate()) {
		buffer_lock();
		buffer_unlock();
	}
	x = *data;

and get x != 0x12345678 because the compiler can move the
buffer_set_uptodate_not_ordered() before the store to *data.
