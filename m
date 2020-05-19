Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984281DA31B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 22:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgESUy4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 16:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgESUy4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 16:54:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEFF62075F;
        Tue, 19 May 2020 20:54:54 +0000 (UTC)
Date:   Tue, 19 May 2020 16:54:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/8] radix-tree: Use local_lock for protection
Message-ID: <20200519165453.0a795ca1@gandalf.local.home>
In-Reply-To: <20200519204545.GA16070@bombadil.infradead.org>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
        <20200519201912.1564477-3-bigeasy@linutronix.de>
        <20200519204545.GA16070@bombadil.infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 19 May 2020 13:45:45 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, May 19, 2020 at 10:19:06PM +0200, Sebastian Andrzej Siewior wrote:
> > The radix-tree and idr preload mechanisms use preempt_disable() to protect
> > the complete operation between xxx_preload() and xxx_preload_end().
> > 
> > As the code inside the preempt disabled section acquires regular spinlocks,
> > which are converted to 'sleeping' spinlocks on a PREEMPT_RT kernel and
> > eventually calls into a memory allocator, this conflicts with the RT
> > semantics.
> > 
> > Convert it to a local_lock which allows RT kernels to substitute them with
> > a real per CPU lock. On non RT kernels this maps to preempt_disable() as
> > before, but provides also lockdep coverage of the critical region.
> > No functional change.  
> 
> I don't seem to have a locallock.h in my tree.  Where can I find more
> information about it?

PATCH 1 ;-)

 https://lore.kernel.org/r/20200519201912.1564477-1-bigeasy@linutronix.de

With lore and b4, it should now be easy to get full patch series.

-- Steve

> 
> > +++ b/lib/radix-tree.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/kmemleak.h>
> >  #include <linux/percpu.h>
> > +#include <linux/locallock.h>
> >  #include <linux/preempt.h>		/* in_interrupt() */
> >  #include <linux/radix-tree.h>
> >  #include <linux/rcupdate.h>  

