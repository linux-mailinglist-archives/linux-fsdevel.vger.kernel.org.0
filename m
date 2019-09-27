Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 691A8C0908
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2019 17:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfI0P5p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Sep 2019 11:57:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfI0P5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Sep 2019 11:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F6O5Uosygu6We4yGr3RWbNboX83MuqSZ1AiJfQK03qY=; b=UZ8b+2aqVNM89GvnyWobFt5RX
        aWEPvZpN1Xf9PluwsG5iY/EalMwqfbXccqU70nmw75AsOxXdnEOoB7SYfAdGWZjGPeJzt7MUCpnmW
        CUfiVz2PgNJpFIehIoDPZBHS8HFywrtQIgpzm2ovlvik4wBvtHWfZt2YbrWMpvbf5QM9riZtaCjQC
        35zNaOUJHmrC6CLDNj8yE7ZWMIU8qWPy0IAC5x8lABP/7fQBm5JjHyTGo4GzXgabkwGQocofNW5IE
        EerkWpkaTvsLkSaAAGw++XQQGbh4rEfAtKb0GpisJtCiFICp1ns9UA7KSKxWWG19DN6WBCUNdo0GA
        iVnW6hIrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDscf-0004Uu-EC; Fri, 27 Sep 2019 15:57:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C70529801D6; Fri, 27 Sep 2019 17:57:30 +0200 (CEST)
Date:   Fri, 27 Sep 2019 17:57:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        jose.marchesi@oracle.com
Subject: Re: Do we need to correct barriering in circular-buffers.rst?
Message-ID: <20190927155730.GA11194@worktop.programming.kicks-ass.net>
References: <CAHk-=wj85tOp8WjcUp6gwstp4Cg2WT=p209S=fOzpWAgqqQPKg@mail.gmail.com>
 <20190915145905.hd5xkc7uzulqhtzr@willie-the-truck>
 <25289.1568379639@warthog.procyon.org.uk>
 <28447.1568728295@warthog.procyon.org.uk>
 <20190917170716.ud457wladfhhjd6h@willie-the-truck>
 <15228.1568821380@warthog.procyon.org.uk>
 <5385.1568901546@warthog.procyon.org.uk>
 <20190923144931.GC2369@hirez.programming.kicks-ass.net>
 <20190927095107.GA13098@andrea>
 <20190927124929.GB4643@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927124929.GB4643@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 27, 2019 at 02:49:29PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 27, 2019 at 11:51:07AM +0200, Andrea Parri wrote:
> 
> > For the record, the LKMM doesn't currently model "order" derived from
> > control dependencies to a _plain_ access (even if the plain access is
> > a write): in particular, the following is racy (as far as the current
> > LKMM is concerned):
> > 
> > C rb
> > 
> > { }
> > 
> > P0(int *tail, int *data, int *head)
> > {
> > 	if (READ_ONCE(*tail)) {
> > 		*data = 1;
> > 		smp_wmb();
> > 		WRITE_ONCE(*head, 1);
> > 	}
> > }
> > 
> > P1(int *tail, int *data, int *head)
> > {
> > 	int r0;
> > 	int r1;
> > 
> > 	r0 = READ_ONCE(*head);
> > 	smp_rmb();
> > 	r1 = *data;
> > 	smp_mb();
> > 	WRITE_ONCE(*tail, 1);
> > }
> > 
> > Replacing the plain "*data = 1" with "WRITE_ONCE(*data, 1)" (or doing
> > s/READ_ONCE(*tail)/smp_load_acquire(tail)) suffices to avoid the race.
> > Maybe I'm short of imagination this morning...  but I can't currently
> > see how the compiler could "break" the above scenario.
> 
> The compiler; if sufficiently smart; is 'allowed' to change P0 into
> something terrible like:
> 
> 	*data = 1;
> 	if (*tail) {
> 		smp_wmb();
> 		*head = 1;
> 	} else
> 		*data = 0;
> 
> 
> (assuming it knows *data was 0 from a prior store or something)
> 
> Using WRITE_ONCE() defeats this because volatile indicates external
> visibility.

The much simpler solution might be writing it like:

	if (READ_ONCE(*tail) {
		barrier();
		*data = 1;
		smp_wmb();
		WRITE_ONCE(*head, 1);
	}

which I don't think the compiler is allowed to mess up.
