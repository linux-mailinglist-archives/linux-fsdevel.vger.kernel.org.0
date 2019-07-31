Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71D667C76D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 17:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfGaPtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 11:49:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:50746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbfGaPtF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:49:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C38D7AF95;
        Wed, 31 Jul 2019 15:49:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 007DA1E3F4D; Wed, 31 Jul 2019 17:48:59 +0200 (CEST)
Date:   Wed, 31 Jul 2019 17:48:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Theodore Tso <tytso@mit.edu>, Julia Cartwright <julia@ni.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [patch 4/4] fs: jbd/jbd2: Substitute BH locks for RT and lock
 debugging
Message-ID: <20190731154859.GI15806@quack2.suse.cz>
References: <20190730112452.871257694@linutronix.de>
 <20190730120321.489374435@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730120321.489374435@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 30-07-19 13:24:56, Thomas Gleixner wrote:
> Bit spinlocks are problematic if PREEMPT_RT is enabled. They disable
> preemption, which is undesired for latency reasons and breaks when regular
> spinlocks are taken within the bit_spinlock locked region because regular
> spinlocks are converted to 'sleeping spinlocks' on RT.
> 
> Substitute the BH_State and BH_JournalHead bit spinlocks with regular
> spinlock for PREEMPT_RT enabled kernels.

Is there a real need for substitution for BH_JournalHead bit spinlock?  The
critical sections are pretty tiny, all located within fs/jbd2/journal.c.
Maybe only the one around __journal_remove_journal_head() would need a bit
of refactoring so that journal_free_journal_head() doesn't get called
under the bit-spinlock.

BH_State lock is definitely worth it. In fact, if you placed the spinlock
inside struct journal_head (which is the structure whose members are in
fact protected by it), I'd be even fine with just using the spinlock always
instead of the bit spinlock. journal_head is pretty big anyway (and there's
even 4-byte hole in it for 64-bit archs) and these structures are pretty
rare (only for actively changed metadata buffers).

								Honza

> 
> Bit spinlocks are also not covered by lock debugging, e.g. lockdep. With
> the spinlock substitution in place, they can be exposed via
> CONFIG_DEBUG_BIT_SPINLOCKS.
> 
> Originally-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-ext4@vger.kernel.org
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jan Kara <jack@suse.com>
> --
>  include/linux/buffer_head.h |    8 ++++++++
>  include/linux/jbd2.h        |   36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -79,6 +79,10 @@ struct buffer_head {
>  
>  #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_DEBUG_BIT_SPINLOCKS)
>  	spinlock_t b_uptodate_lock;
> +# if IS_ENABLED(CONFIG_JBD2)
> +	spinlock_t b_state_lock;
> +	spinlock_t b_journal_head_lock;
> +# endif
>  #endif
>  };
>  
> @@ -101,6 +105,10 @@ bh_uptodate_unlock_irqrestore(struct buf
>  static inline void buffer_head_init_locks(struct buffer_head *bh)
>  {
>  	spin_lock_init(&bh->b_uptodate_lock);
> +#if IS_ENABLED(CONFIG_JBD2)
> +	spin_lock_init(&bh->b_state_lock);
> +	spin_lock_init(&bh->b_journal_head_lock);
> +#endif
>  }
>  
>  #else /* PREEMPT_RT || DEBUG_BIT_SPINLOCKS */
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -342,6 +342,40 @@ static inline struct journal_head *bh2jh
>  	return bh->b_private;
>  }
>  
> +#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_DEBUG_BIT_SPINLOCKS)
> +
> +static inline void jbd_lock_bh_state(struct buffer_head *bh)
> +{
> +	spin_lock(&bh->b_state_lock);
> +}
> +
> +static inline int jbd_trylock_bh_state(struct buffer_head *bh)
> +{
> +	return spin_trylock(&bh->b_state_lock);
> +}
> +
> +static inline int jbd_is_locked_bh_state(struct buffer_head *bh)
> +{
> +	return spin_is_locked(&bh->b_state_lock);
> +}
> +
> +static inline void jbd_unlock_bh_state(struct buffer_head *bh)
> +{
> +	spin_unlock(&bh->b_state_lock);
> +}
> +
> +static inline void jbd_lock_bh_journal_head(struct buffer_head *bh)
> +{
> +	spin_lock(&bh->b_journal_head_lock);
> +}
> +
> +static inline void jbd_unlock_bh_journal_head(struct buffer_head *bh)
> +{
> +	spin_unlock(&bh->b_journal_head_lock);
> +}
> +
> +#else /* PREEMPT_RT || DEBUG_BIT_SPINLOCKS */
> +
>  static inline void jbd_lock_bh_state(struct buffer_head *bh)
>  {
>  	bit_spin_lock(BH_State, &bh->b_state);
> @@ -372,6 +406,8 @@ static inline void jbd_unlock_bh_journal
>  	bit_spin_unlock(BH_JournalHead, &bh->b_state);
>  }
>  
> +#endif /* !PREEMPT_RT && !DEBUG_BIT_SPINLOCKS */
> +
>  #define J_ASSERT(assert)	BUG_ON(!(assert))
>  
>  #define J_ASSERT_BH(bh, expr)	J_ASSERT(expr)
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
