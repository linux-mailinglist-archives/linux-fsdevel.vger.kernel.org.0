Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 898FD7E1B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 19:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbfHAR5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 13:57:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:47102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731930AbfHAR5X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:57:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AB808AF3E;
        Thu,  1 Aug 2019 17:57:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EF9621E3F4D; Thu,  1 Aug 2019 19:57:03 +0200 (CEST)
Date:   Thu, 1 Aug 2019 19:57:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.com>,
        Theodore Tso <tytso@mit.edu>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2 6/7] fs/jbd2: Make state lock a spinlock
Message-ID: <20190801175703.GH25064@quack2.suse.cz>
References: <20190801010126.245731659@linutronix.de>
 <20190801010944.457499601@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801010944.457499601@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-08-19 03:01:32, Thomas Gleixner wrote:
> Bit-spinlocks are problematic on PREEMPT_RT if functions which might sleep
> on RT, e.g. spin_lock(), alloc/free(), are invoked inside the lock held
> region because bit spinlocks disable preemption even on RT.
> 
> A first attempt was to replace state lock with a spinlock placed in struct
> buffer_head and make the locking conditional on PREEMPT_RT and
> DEBUG_BIT_SPINLOCKS.
> 
> Jan pointed out that there is a 4 byte hole in struct journal_head where a
> regular spinlock fits in and he would not object to convert the state lock
> to a spinlock unconditionally.
> 
> Aside of solving the RT problem, this also gains lockdep coverage for the
> journal head state lock (bit-spinlocks are not covered by lockdep as it's
> hard to fit a lockdep map into a single bit).
> 
> The trivial change would have been to convert the jbd_*lock_bh_state()
> inlines, but that comes with the downside that these functions take a
> buffer head pointer which needs to be converted to a journal head pointer
> which adds another level of indirection.
> 
> As almost all functions which use this lock have a journal head pointer
> readily available, it makes more sense to remove the lock helper inlines
> and write out spin_*lock() at all call sites.
> 
> Fixup all locking comments as well.
> 
> Suggested-by: Jan Kara <jack@suse.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Jan Kara <jack@suse.com>
> Cc: linux-ext4@vger.kernel.org

Just a heads up that I didn't miss this patch. Just it has some bugs and I
figured that rather than explaining to you subtleties of jh lifetime it is
easier to fix up the problems myself since you're probably not keen on
becoming jbd2 developer ;)... which was more complex than I thought so I'm
not completely done yet. Hopefuly tomorrow.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
