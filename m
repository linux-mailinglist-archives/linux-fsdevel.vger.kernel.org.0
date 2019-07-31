Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E54487C54E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 16:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387750AbfGaOrg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 10:47:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:59838 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387593AbfGaOrg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:47:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E6ADB607;
        Wed, 31 Jul 2019 14:47:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0A9611E3F4D; Wed, 31 Jul 2019 16:47:32 +0200 (CEST)
Date:   Wed, 31 Jul 2019 16:47:32 +0200
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
Subject: Re: [patch 3/4] fs/buffer: Substitute BH_Uptodate_Lock for RT and
 bit spinlock debugging
Message-ID: <20190731144732.GH15806@quack2.suse.cz>
References: <20190730112452.871257694@linutronix.de>
 <20190730120321.393759046@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730120321.393759046@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 30-07-19 13:24:55, Thomas Gleixner wrote:
> Bit spinlocks are problematic if PREEMPT_RT is enabled. They disable
> preemption, which is undesired for latency reasons and breaks when regular
> spinlocks are taken within the bit_spinlock locked region because regular
> spinlocks are converted to 'sleeping spinlocks' on RT.
> 
> Substitute the BH_Uptodate_Lock bit spinlock with a regular spinlock for
> PREEMPT_RT enabled kernels.
> 
> Bit spinlocks are also not covered by lock debugging, e.g. lockdep. With
> the spinlock substitution in place, they can be exposed via
> CONFIG_DEBUG_BIT_SPINLOCKS.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: linux-fsdevel@vger.kernel.org

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c                 |    1 +
>  include/linux/buffer_head.h |   31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -3360,6 +3360,7 @@ struct buffer_head *alloc_buffer_head(gf
>  	struct buffer_head *ret = kmem_cache_zalloc(bh_cachep, gfp_flags);
>  	if (ret) {
>  		INIT_LIST_HEAD(&ret->b_assoc_buffers);
> +		buffer_head_init_locks(ret);
>  		preempt_disable();
>  		__this_cpu_inc(bh_accounting.nr);
>  		recalc_bh_state();
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -76,8 +76,35 @@ struct buffer_head {
>  	struct address_space *b_assoc_map;	/* mapping this buffer is
>  						   associated with */
>  	atomic_t b_count;		/* users using this buffer_head */
> +
> +#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_DEBUG_BIT_SPINLOCKS)
> +	spinlock_t b_uptodate_lock;
> +#endif
>  };
>  
> +#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_DEBUG_BIT_SPINLOCKS)
> +
> +static inline unsigned long bh_uptodate_lock_irqsave(struct buffer_head *bh)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&bh->b_uptodate_lock, flags);
> +	return flags;
> +}
> +
> +static inline void
> +bh_uptodate_unlock_irqrestore(struct buffer_head *bh, unsigned long flags)
> +{
> +	spin_unlock_irqrestore(&bh->b_uptodate_lock, flags);
> +}
> +
> +static inline void buffer_head_init_locks(struct buffer_head *bh)
> +{
> +	spin_lock_init(&bh->b_uptodate_lock);
> +}
> +
> +#else /* PREEMPT_RT || DEBUG_BIT_SPINLOCKS */
> +
>  static inline unsigned long bh_uptodate_lock_irqsave(struct buffer_head *bh)
>  {
>  	unsigned long flags;
> @@ -94,6 +121,10 @@ bh_uptodate_unlock_irqrestore(struct buf
>  	local_irq_restore(flags);
>  }
>  
> +static inline void buffer_head_init_locks(struct buffer_head *bh) { }
> +
> +#endif /* !PREEMPT_RT && !DEBUG_BIT_SPINLOCKS */
> +
>  /*
>   * macro tricks to expand the set_buffer_foo(), clear_buffer_foo()
>   * and buffer_foo() functions.
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
