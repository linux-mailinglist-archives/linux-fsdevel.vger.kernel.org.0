Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2771D3E67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 13:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfJKLZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 07:25:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60390 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfJKLZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:25:33 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iIt2z-0007LM-9u; Fri, 11 Oct 2019 13:25:25 +0200
Date:   Fri, 11 Oct 2019 13:25:25 +0200
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joel Becker <jlbec@evilplan.org>
Subject: Re: [PATCH] fs/buffer: Make BH_Uptodate_Lock bit_spin_lock a regular
 spinlock_t
Message-ID: <20191011112525.7dksg6ixb5c3hxn5@linutronix.de>
References: <20190820170818.oldsdoumzashhcgh@linutronix.de>
 <20190820171721.GA4949@bombadil.infradead.org>
 <alpine.DEB.2.21.1908201959240.2223@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908201959240.2223@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-08-20 20:01:14 [+0200], Thomas Gleixner wrote:
> On Tue, 20 Aug 2019, Matthew Wilcox wrote:
> > On Tue, Aug 20, 2019 at 07:08:18PM +0200, Sebastian Siewior wrote:
> > > Bit spinlocks are problematic if PREEMPT_RT is enabled, because they
> > > disable preemption, which is undesired for latency reasons and breaks when
> > > regular spinlocks are taken within the bit_spinlock locked region because
> > > regular spinlocks are converted to 'sleeping spinlocks' on RT. So RT
> > > replaces the bit spinlocks with regular spinlocks to avoid this problem.
> > > Bit spinlocks are also not covered by lock debugging, e.g. lockdep.
> > > 
> > > Substitute the BH_Uptodate_Lock bit spinlock with a regular spinlock.
> > > 
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > [bigeasy: remove the wrapper and use always spinlock_t]
> > 
> > Uhh ... always grow the buffer_head, even for non-PREEMPT_RT?  Why?
> 
> Christoph requested that:
> 
>   https://lkml.kernel.org/r/20190802075612.GA20962@infradead.org

What do we do about this one?

> Thanks,
> 
> 	tglx

Sebastian
