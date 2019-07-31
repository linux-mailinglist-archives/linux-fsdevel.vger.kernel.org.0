Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C87E7C549
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 16:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbfGaOqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 10:46:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:59602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728482AbfGaOqo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:46:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1DA3AB607;
        Wed, 31 Jul 2019 14:46:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 32C8F1E3F4D; Wed, 31 Jul 2019 16:46:39 +0200 (CEST)
Date:   Wed, 31 Jul 2019 16:46:39 +0200
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
Subject: Re: [patch 2/4] fs/buffer: Move BH_Uptodate_Lock locking into
 wrapper functions
Message-ID: <20190731144639.GG15806@quack2.suse.cz>
References: <20190730112452.871257694@linutronix.de>
 <20190730120321.285095769@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730120321.285095769@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 30-07-19 13:24:54, Thomas Gleixner wrote:
> Bit spinlocks are problematic if PREEMPT_RT is enabled, because they
> disable preemption, which is undesired for latency reasons and breaks when
> regular spinlocks are taken within the bit_spinlock locked region because
> regular spinlocks are converted to 'sleeping spinlocks' on RT. So RT
> replaces the bit spinlocks with regular spinlocks to avoid this problem.
> 
> To avoid ifdeffery at the source level, wrap all BH_Uptodate_Lock bitlock
> operations with inline functions, so the spinlock substitution can be done
> at one place.
> 
> Using regular spinlocks can also be enabled for lock debugging purposes so
> the lock operations become visible to lockdep.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

BTW, it should be possible to get rid of BH_Uptodate_Lock altogether using
bio chaining (which was non-existent when this bh code was written) to make
sure IO completion function gets called only once all bios used to fill in
/ write out the page are done. It would be also more efficient. But I guess
that's an interesting cleanup project for some other time...

								Honza

> ---
>  fs/buffer.c                 |   20 ++++++--------------
>  fs/ext4/page-io.c           |    6 ++----
>  fs/ntfs/aops.c              |   10 +++-------
>  include/linux/buffer_head.h |   16 ++++++++++++++++
>  4 files changed, 27 insertions(+), 25 deletions(-)
> 
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -275,8 +275,7 @@ static void end_buffer_async_read(struct
>  	 * decide that the page is now completely done.
>  	 */
>  	first = page_buffers(page);
> -	local_irq_save(flags);
> -	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
> +	flags = bh_uptodate_lock_irqsave(first);
>  	clear_buffer_async_read(bh);
>  	unlock_buffer(bh);
>  	tmp = bh;
> @@ -289,8 +288,7 @@ static void end_buffer_async_read(struct
>  		}
>  		tmp = tmp->b_this_page;
>  	} while (tmp != bh);
> -	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
> -	local_irq_restore(flags);
> +	bh_uptodate_unlock_irqrestore(first, flags);
>  
>  	/*
>  	 * If none of the buffers had errors and they are all
> @@ -302,9 +300,7 @@ static void end_buffer_async_read(struct
>  	return;
>  
>  still_busy:
> -	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
> -	local_irq_restore(flags);
> -	return;
> +	bh_uptodate_unlock_irqrestore(first, flags);
>  }
>  
>  /*
> @@ -331,8 +327,7 @@ void end_buffer_async_write(struct buffe
>  	}
>  
>  	first = page_buffers(page);
> -	local_irq_save(flags);
> -	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
> +	flags = bh_uptodate_lock_irqsave(first);
>  
>  	clear_buffer_async_write(bh);
>  	unlock_buffer(bh);
> @@ -344,15 +339,12 @@ void end_buffer_async_write(struct buffe
>  		}
>  		tmp = tmp->b_this_page;
>  	}
> -	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
> -	local_irq_restore(flags);
> +	bh_uptodate_unlock_irqrestore(first, flags);
>  	end_page_writeback(page);
>  	return;
>  
>  still_busy:
> -	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
> -	local_irq_restore(flags);
> -	return;
> +	bh_uptodate_unlock_irqrestore(first, flags);
>  }
>  EXPORT_SYMBOL(end_buffer_async_write);
>  
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -90,8 +90,7 @@ static void ext4_finish_bio(struct bio *
>  		 * We check all buffers in the page under BH_Uptodate_Lock
>  		 * to avoid races with other end io clearing async_write flags
>  		 */
> -		local_irq_save(flags);
> -		bit_spin_lock(BH_Uptodate_Lock, &head->b_state);
> +		flags = bh_uptodate_lock_irqsave(head);
>  		do {
>  			if (bh_offset(bh) < bio_start ||
>  			    bh_offset(bh) + bh->b_size > bio_end) {
> @@ -103,8 +102,7 @@ static void ext4_finish_bio(struct bio *
>  			if (bio->bi_status)
>  				buffer_io_error(bh);
>  		} while ((bh = bh->b_this_page) != head);
> -		bit_spin_unlock(BH_Uptodate_Lock, &head->b_state);
> -		local_irq_restore(flags);
> +		bh_uptodate_unlock_irqrestore(head, flags);
>  		if (!under_io) {
>  			fscrypt_free_bounce_page(bounce_page);
>  			end_page_writeback(page);
> --- a/fs/ntfs/aops.c
> +++ b/fs/ntfs/aops.c
> @@ -92,8 +92,7 @@ static void ntfs_end_buffer_async_read(s
>  				"0x%llx.", (unsigned long long)bh->b_blocknr);
>  	}
>  	first = page_buffers(page);
> -	local_irq_save(flags);
> -	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
> +	flags = bh_uptodate_lock_irqsave(first);
>  	clear_buffer_async_read(bh);
>  	unlock_buffer(bh);
>  	tmp = bh;
> @@ -108,8 +107,7 @@ static void ntfs_end_buffer_async_read(s
>  		}
>  		tmp = tmp->b_this_page;
>  	} while (tmp != bh);
> -	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
> -	local_irq_restore(flags);
> +	bh_uptodate_unlock_irqrestore(first, flags);
>  	/*
>  	 * If none of the buffers had errors then we can set the page uptodate,
>  	 * but we first have to perform the post read mst fixups, if the
> @@ -142,9 +140,7 @@ static void ntfs_end_buffer_async_read(s
>  	unlock_page(page);
>  	return;
>  still_busy:
> -	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
> -	local_irq_restore(flags);
> -	return;
> +	bh_uptodate_unlock_irqrestore(first, flags);
>  }
>  
>  /**
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -78,6 +78,22 @@ struct buffer_head {
>  	atomic_t b_count;		/* users using this buffer_head */
>  };
>  
> +static inline unsigned long bh_uptodate_lock_irqsave(struct buffer_head *bh)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	bit_spin_lock(BH_Uptodate_Lock, &bh->b_state);
> +	return flags;
> +}
> +
> +static inline void
> +bh_uptodate_unlock_irqrestore(struct buffer_head *bh, unsigned long flags)
> +{
> +	bit_spin_unlock(BH_Uptodate_Lock, &bh->b_state);
> +	local_irq_restore(flags);
> +}
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
