Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 897D27FA52
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 15:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405069AbfHBNcW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 09:32:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:55568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405016AbfHBNcV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:32:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25141B62C;
        Fri,  2 Aug 2019 13:32:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F0EE61E433B; Fri,  2 Aug 2019 15:31:54 +0200 (CEST)
Date:   Fri, 2 Aug 2019 15:31:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <20190802133154.GM25064@quack2.suse.cz>
References: <20190801010126.245731659@linutronix.de>
 <20190801010944.457499601@linutronix.de>
 <20190801112849.GB31381@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801112849.GB31381@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-08-19 13:28:49, Peter Zijlstra wrote:
> On Thu, Aug 01, 2019 at 03:01:32AM +0200, Thomas Gleixner wrote:
> 
> > @@ -1931,7 +1932,7 @@ static void __jbd2_journal_temp_unlink_b
> >  	transaction_t *transaction;
> >  	struct buffer_head *bh = jh2bh(jh);
> >  
> > -	J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
> > +	assert_spin_locked(&jh->state_lock);
> >  	transaction = jh->b_transaction;
> >  	if (transaction)
> >  		assert_spin_locked(&transaction->t_journal->j_list_lock);
> 
> > @@ -2415,7 +2416,7 @@ void __jbd2_journal_file_buffer(struct j
> >  	int was_dirty = 0;
> >  	struct buffer_head *bh = jh2bh(jh);
> >  
> > -	J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
> > +	assert_spin_locked(&jh->state_lock);
> >  	assert_spin_locked(&transaction->t_journal->j_list_lock);
> >  
> >  	J_ASSERT_JH(jh, jh->b_jlist < BJ_Types);
> 
> > @@ -2500,7 +2501,7 @@ void __jbd2_journal_refile_buffer(struct
> >  	int was_dirty, jlist;
> >  	struct buffer_head *bh = jh2bh(jh);
> >  
> > -	J_ASSERT_JH(jh, jbd_is_locked_bh_state(bh));
> > +	assert_spin_locked(&jh->state_lock);
> >  	if (jh->b_transaction)
> >  		assert_spin_locked(&jh->b_transaction->t_journal->j_list_lock);
> >  
> 
> Do those want to be:
> 
>   lockdep_assert_held(&jh->state_lock);
> 
> instead? The difference is of course that lockdep_assert_held() requires
> the current context to hold the lock, where assert_*_locked() merely
> checks _someone_ holds it.

Yeah, jbd2 doesn't play any weird locking tricks so lockdep_assert_held()
is fine. I'll replace those when I'm updating the patch.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
