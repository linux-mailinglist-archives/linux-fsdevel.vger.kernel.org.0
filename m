Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281EB586CF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 16:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiHAOhi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 10:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiHAOhh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:37:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2D833368;
        Mon,  1 Aug 2022 07:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FaVkEakWw5UkhKC0z7612iz8Sezsq/DZXrhQ3cY+yUw=; b=SAVLI21ATZ0FBXs5JGrzgiY8kR
        D3nAfI+mwkN2X3CVciMzhnRNeK0fE1T1BijkZDqOIIwU0O/QYFDZtbXIJcb68dwsEzKLH/wo3JgWH
        X0OGrqQJfPULEwbVEqXf4fWxoMNjHdFeN+cYMMZbPOw4GKwhgow0ux5Ewv9t5aBSZhemfTw/+rl5j
        jJMURX+yBxTbNqX/fJ7ja0ZdWzc4g188df9V61KvjCsflUbJkHZ5mnjQun2tpud6G111k8GPM39K6
        zT7phs7VVtYeujVZJdpPjHXizMAEzvGPv1kvaYCJDKKqXvvjq/rs02cvLyRXnG0ml/SIq2RmbGqDa
        Ei7zY8xw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oIWXg-007Aot-Ki; Mon, 01 Aug 2022 14:37:12 +0000
Date:   Mon, 1 Aug 2022 15:37:12 +0100
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
Message-ID: <YuflGG60pHiXp2z/@casper.infradead.org>
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311639360.21350@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wjA8HBrVqAqAetUvwNr=hcvhfnO7oMrOAd4V8bbSqokNA@mail.gmail.com>
 <alpine.LRH.2.02.2208010628510.22006@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2208010642220.22006@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2208010642220.22006@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 01, 2022 at 06:43:55AM -0400, Mikulas Patocka wrote:
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
> Fix this bug by changing the function buffer_locked to have the acquire
> semantics - so that code that follows buffer_locked cannot be moved before
> it.

I think this is the wrong approach.  Instead, buffer_set_uptodate()
should have the smp_wmb() and buffer_uptodate should have the smp_rmb().
Just like the page flags.  As I said last night.
