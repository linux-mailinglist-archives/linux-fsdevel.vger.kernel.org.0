Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6427CBB71C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 16:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440080AbfIWOti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 10:49:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438376AbfIWOti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V2TL1OkDh2oEnzgGPwW5rtpt6oXK+wm5wbqIRlf2l1M=; b=fBUGYc37z1z4Dwgz8h7k1qSR0
        U+bUQeuZqrp4+f7NFKghpdFDI+GyU72GyNbolbLg/ujP/Zs5Pb38MtGSQUn9FspPZdAPUKiG7HbsM
        /R5VkMEPorraJItOpntT35WuLltovyfHS8qPGMk4HdvsDOe9t5Ry24DMm3abqd64L/3xopQQNfAY1
        +Ey9BBsSbEdCESaZZ0cAUxRg8GLitzEereuD83WHln6ObRBTesfn8VcYW39tCygANQCIHitaF0YyY
        G7V5DFn7EpxWIVKsSUYsa32XkQjBhj7pWmLVZ724qlmn2gi5FFqGAxkrR2s2Q7vuOls/LapBjd+Ys
        anbHzSNZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCPef-0001SS-Ly; Mon, 23 Sep 2019 14:49:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2DE9F303DFD;
        Mon, 23 Sep 2019 16:48:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 547962B08BBAE; Mon, 23 Sep 2019 16:49:31 +0200 (CEST)
Date:   Mon, 23 Sep 2019 16:49:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Do we need to correct barriering in circular-buffers.rst?
Message-ID: <20190923144931.GC2369@hirez.programming.kicks-ass.net>
References: <CAHk-=wj85tOp8WjcUp6gwstp4Cg2WT=p209S=fOzpWAgqqQPKg@mail.gmail.com>
 <20190915145905.hd5xkc7uzulqhtzr@willie-the-truck>
 <25289.1568379639@warthog.procyon.org.uk>
 <28447.1568728295@warthog.procyon.org.uk>
 <20190917170716.ud457wladfhhjd6h@willie-the-truck>
 <15228.1568821380@warthog.procyon.org.uk>
 <5385.1568901546@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5385.1568901546@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 19, 2019 at 02:59:06PM +0100, David Howells wrote:

> But I don't agree with this.  You're missing half the barriers.  There should
> be *four* barriers.  The document mandates only 3 barriers, and uses
> READ_ONCE() where the fourth should be, i.e.:
> 
>    thread #1            thread #2
> 
>                         smp_load_acquire(head)
>                         ... read data from queue ..
>                         smp_store_release(tail)
> 
>    READ_ONCE(tail)
>    ... add data to queue ..
>    smp_store_release(head)
> 

Notably your READ_ONCE() pseudo code is lacking a conditional;
kernel/events/ring_buffer.c writes it like so:

 *   kernel                             user
 *
 *   if (LOAD ->data_tail) {            LOAD ->data_head
 *                      (A)             smp_rmb()       (C)
 *      STORE $data                     LOAD $data
 *      smp_wmb()       (B)             smp_mb()        (D)
 *      STORE ->data_head               STORE ->data_tail
 *   }
 *
 * Where A pairs with D, and B pairs with C.
 *
 * In our case (A) is a control dependency that separates the load of
 * the ->data_tail and the stores of $data. In case ->data_tail
 * indicates there is no room in the buffer to store $data we do not.
 *
 * D needs to be a full barrier since it separates the data READ
 * from the tail WRITE.
 *
 * For B a WMB is sufficient since it separates two WRITEs, and for C
 * an RMB is sufficient since it separates two READs.

Where 'kernel' is the producer and 'user' is the consumer. This was
written before load-acquire and store-release came about (I _think_),
and I've so far resisted updating B to store-release because smp_wmb()
is actually cheaper than store-release on a number of architectures
(notably ARM).

C ought to be a load-aquire, and D really should be a store-release, but
I don't think the perf userspace has that (or uses C11).
