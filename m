Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07269FE0A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 15:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfKOO4l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 09:56:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:40462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727526AbfKOO4l (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:56:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3CBA7B15E;
        Fri, 15 Nov 2019 14:56:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3ABBE1E4407; Fri, 15 Nov 2019 15:56:38 +0100 (CET)
Date:   Fri, 15 Nov 2019 15:56:38 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <20191115145638.GA5461@quack2.suse.cz>
References: <20190820170818.oldsdoumzashhcgh@linutronix.de>
 <20190820171721.GA4949@bombadil.infradead.org>
 <alpine.DEB.2.21.1908201959240.2223@nanos.tec.linutronix.de>
 <20191011112525.7dksg6ixb5c3hxn5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011112525.7dksg6ixb5c3hxn5@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 11-10-19 13:25:25, Sebastian Siewior wrote:
> On 2019-08-20 20:01:14 [+0200], Thomas Gleixner wrote:
> > On Tue, 20 Aug 2019, Matthew Wilcox wrote:
> > > On Tue, Aug 20, 2019 at 07:08:18PM +0200, Sebastian Siewior wrote:
> > > > Bit spinlocks are problematic if PREEMPT_RT is enabled, because they
> > > > disable preemption, which is undesired for latency reasons and breaks when
> > > > regular spinlocks are taken within the bit_spinlock locked region because
> > > > regular spinlocks are converted to 'sleeping spinlocks' on RT. So RT
> > > > replaces the bit spinlocks with regular spinlocks to avoid this problem.
> > > > Bit spinlocks are also not covered by lock debugging, e.g. lockdep.
> > > > 
> > > > Substitute the BH_Uptodate_Lock bit spinlock with a regular spinlock.
> > > > 
> > > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > > [bigeasy: remove the wrapper and use always spinlock_t]
> > > 
> > > Uhh ... always grow the buffer_head, even for non-PREEMPT_RT?  Why?
> > 
> > Christoph requested that:
> > 
> >   https://lkml.kernel.org/r/20190802075612.GA20962@infradead.org
> 
> What do we do about this one?

I was thinking about this for quite some time. In the end I think the patch
is almost fine but I'd name the lock b_update_lock and put it just after
b_size element in struct buffer_head to use the hole there. That way we
don't grow struct buffer_head.

With some effort, we could even shrink struct buffer_head from 104 bytes
(on x86_64) to 96 bytes but I don't think that effort is worth it (I'd find
it better use of time to actually work on getting rid of buffer heads
completely).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
