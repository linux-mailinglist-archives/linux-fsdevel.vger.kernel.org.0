Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4082DC204C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 14:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfI3MCh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 08:02:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfI3MCh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 08:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vfk8m9QbBK1FdL+EkeiKXOXWonMZIkbTRy0qgB3cHYI=; b=HjwYwgi/EIYOQ8bR9Z9KaYmT8
        Sa0tldH7sSDElZIycK1FpzfRFINKnUKULso6uFJ6YbH4s/cdUrNeLeB8NVNZ1tsEYEPnFqyDbszRn
        OIaewYlAAr9v4/EefDBfiD10GfWsFq6xZZSESk5Kva+dvbJsHLkegD69D6hE4YJ8jRPfeDSMMxqTx
        46CW/xbjODAcJ6ZbS2dfDR5wGTQA1xJcyZWwk9+C4HyzHsSwKQ5pJIduYayXQJhYOxVHQFWLC9scg
        SAWR2+VssywWFz2l9RKeX4B0PVPBMhEZalpS2bFTWjci+ELJk2xnwcQU0KZqqYlT0C0O9FJpTVqL/
        BfbUC87Nw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEuNr-0001tA-8b; Mon, 30 Sep 2019 12:02:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 685CE3056B6;
        Mon, 30 Sep 2019 14:01:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B08D265261AA; Mon, 30 Sep 2019 14:02:29 +0200 (CEST)
Date:   Mon, 30 Sep 2019 14:02:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        jose.marchesi@oracle.com
Subject: Re: Do we need to correct barriering in circular-buffers.rst?
Message-ID: <20190930120229.GD4581@hirez.programming.kicks-ass.net>
References: <28447.1568728295@warthog.procyon.org.uk>
 <20190917170716.ud457wladfhhjd6h@willie-the-truck>
 <15228.1568821380@warthog.procyon.org.uk>
 <5385.1568901546@warthog.procyon.org.uk>
 <20190923144931.GC2369@hirez.programming.kicks-ass.net>
 <20190927095107.GA13098@andrea>
 <20190927124929.GB4643@worktop.programming.kicks-ass.net>
 <CAKwvOd=pZYiozmGv+DVpzJ1u9_0k4CXb3M1EAcu22DQF+bW0fA@mail.gmail.com>
 <20190930093352.GM4553@hirez.programming.kicks-ass.net>
 <20190930115440.GC4581@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930115440.GC4581@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 30, 2019 at 01:54:40PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 30, 2019 at 11:33:52AM +0200, Peter Zijlstra wrote:
> > Like I said before, something like: "disallowing store hoists over control
> > flow depending on a volatile load" would be sufficient I think.
> 
> We need to add 'control flow depending on an inline-asm' to that. We
> also very much use that.

An example of that would be something like:

bool spin_try_lock(struct spinlock *lock)
{
	u32 zero = 0;

	if (atomic_try_cmpxchg_relaxed(&lock->val, &zero, 1)) {
		smp_acquire__after_ctrl_dep(); /* aka smp_rmb() */
		return true;
	}

	return false;
}

(I think most our actual trylock functions use cmpxchg_acquire(), but the
above would be a valid implementation -- and it is the simplest
construct using smp_acquire__after_ctrl_dep() I could come up with in a
hurry)
