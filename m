Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 743F410206C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 10:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfKSJaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 04:30:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:46524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfKSJaG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:30:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E273BB1A9;
        Tue, 19 Nov 2019 09:30:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1CAE01E47E5; Tue, 19 Nov 2019 10:30:01 +0100 (CET)
Date:   Tue, 19 Nov 2019 10:30:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     Jan Kara <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Theodore Tso <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joel Becker <jlbec@evilplan.org>
Subject: Re: [PATCH v3] fs/buffer: Make BH_Uptodate_Lock bit_spin_lock a
 regular spinlock_t
Message-ID: <20191119093001.GA25605@quack2.suse.cz>
References: <20190820170818.oldsdoumzashhcgh@linutronix.de>
 <20190820171721.GA4949@bombadil.infradead.org>
 <alpine.DEB.2.21.1908201959240.2223@nanos.tec.linutronix.de>
 <20191011112525.7dksg6ixb5c3hxn5@linutronix.de>
 <20191115145638.GA5461@quack2.suse.cz>
 <20191115175420.cotwwz5tmcwvllsq@linutronix.de>
 <20191118093845.GB17319@quack2.suse.cz>
 <20191118132824.rclhrbujqh4b4g4d@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191118132824.rclhrbujqh4b4g4d@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-11-19 14:28:24, Sebastian Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Bit spinlocks are problematic if PREEMPT_RT is enabled, because they
> disable preemption, which is undesired for latency reasons and breaks when
> regular spinlocks are taken within the bit_spinlock locked region because
> regular spinlocks are converted to 'sleeping spinlocks' on RT. So RT
> replaces the bit spinlocks with regular spinlocks to avoid this problem.
> Bit spinlocks are also not covered by lock debugging, e.g. lockdep.
> 
> Substitute the BH_Uptodate_Lock bit spinlock with a regular spinlock.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: remove the wrapper and use always spinlock_t and move it into
>           the padding hole]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

OK, how do we push this? Do you plan to push this through tip tree?

								Honza

> ---
> v2…v3: rename uptodate_lock to b_uptodate_lock.
> 
> v1…v2: Move the spinlock_t to the padding hole as per Jan Kara. pahole says
> its total size remained unchanged, before
> 
> | atomic_t                   b_count;              /*    96     4 */
> |
> | /* size: 104, cachelines: 2, members: 12 */
> | /* padding: 4 */
> | /* last cacheline: 40 bytes */
> 
> after
> 
> | atomic_t                   b_count;              /*    96     4 */
> | spinlock_t                 uptodate_lock;        /*   100     4 */
> |
> | /* size: 104, cachelines: 2, members: 13 */
> | /* last cacheline: 40 bytes */
> 
>  fs/buffer.c                 | 19 +++++++------------
>  fs/ext4/page-io.c           |  8 +++-----
>  fs/ntfs/aops.c              |  9 +++------
>  include/linux/buffer_head.h |  6 +++---
>  4 files changed, 16 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 86a38b9793235..4baea587981e0 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -275,8 +275,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
>  	 * decide that the page is now completely done.
>  	 */
>  	first = page_buffers(page);
> -	local_irq_save(flags);
> -	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
> +	spin_lock_irqsave(&first->b_uptodate_lock, flags);
>  	clear_buffer_async_read(bh);
>  	unlock_buffer(bh);
>  	tmp = bh;
> @@ -289,8 +288,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
>  		}
>  		tmp = tmp->b_this_page;
>  	} while (tmp != bh);
> -	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
>  
>  	/*
>  	 * If none of the buffers had errors and they are all
> @@ -302,8 +300,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
>  	return;
>  
>  still_busy:
> -	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
>  	return;
>  }
>  
> @@ -331,8 +328,7 @@ void end_buffer_async_write(struct buffer_head *bh, int uptodate)
>  	}
>  
>  	first = page_buffers(page);
> -	local_irq_save(flags);
> -	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
> +	spin_lock_irqsave(&first->b_uptodate_lock, flags);
>  
>  	clear_buffer_async_write(bh);
>  	unlock_buffer(bh);
> @@ -344,14 +340,12 @@ void end_buffer_async_write(struct buffer_head *bh, int uptodate)
>  		}
>  		tmp = tmp->b_this_page;
>  	}
> -	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
>  	end_page_writeback(page);
>  	return;
>  
>  still_busy:
> -	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
>  	return;
>  }
>  EXPORT_SYMBOL(end_buffer_async_write);
> @@ -3368,6 +3362,7 @@ struct buffer_head *alloc_buffer_head(gfp_t gfp_flags)
>  	struct buffer_head *ret = kmem_cache_zalloc(bh_cachep, gfp_flags);
>  	if (ret) {
>  		INIT_LIST_HEAD(&ret->b_assoc_buffers);
> +		spin_lock_init(&ret->b_uptodate_lock);
>  		preempt_disable();
>  		__this_cpu_inc(bh_accounting.nr);
>  		recalc_bh_state();
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 12ceadef32c5a..64d4c06fbf836 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -87,11 +87,10 @@ static void ext4_finish_bio(struct bio *bio)
>  		}
>  		bh = head = page_buffers(page);
>  		/*
> -		 * We check all buffers in the page under BH_Uptodate_Lock
> +		 * We check all buffers in the page under b_uptodate_lock
>  		 * to avoid races with other end io clearing async_write flags
>  		 */
> -		local_irq_save(flags);
> -		bit_spin_lock(BH_Uptodate_Lock, &head->b_state);
> +		spin_lock_irqsave(&head->b_uptodate_lock, flags);
>  		do {
>  			if (bh_offset(bh) < bio_start ||
>  			    bh_offset(bh) + bh->b_size > bio_end) {
> @@ -103,8 +102,7 @@ static void ext4_finish_bio(struct bio *bio)
>  			if (bio->bi_status)
>  				buffer_io_error(bh);
>  		} while ((bh = bh->b_this_page) != head);
> -		bit_spin_unlock(BH_Uptodate_Lock, &head->b_state);
> -		local_irq_restore(flags);
> +		spin_unlock_irqrestore(&head->b_uptodate_lock, flags);
>  		if (!under_io) {
>  			fscrypt_free_bounce_page(bounce_page);
>  			end_page_writeback(page);
> diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
> index 7202a1e39d70c..554b744f41bf8 100644
> --- a/fs/ntfs/aops.c
> +++ b/fs/ntfs/aops.c
> @@ -92,8 +92,7 @@ static void ntfs_end_buffer_async_read(struct buffer_head *bh, int uptodate)
>  				"0x%llx.", (unsigned long long)bh->b_blocknr);
>  	}
>  	first = page_buffers(page);
> -	local_irq_save(flags);
> -	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
> +	spin_lock_irqsave(&first->b_uptodate_lock, flags);
>  	clear_buffer_async_read(bh);
>  	unlock_buffer(bh);
>  	tmp = bh;
> @@ -108,8 +107,7 @@ static void ntfs_end_buffer_async_read(struct buffer_head *bh, int uptodate)
>  		}
>  		tmp = tmp->b_this_page;
>  	} while (tmp != bh);
> -	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
>  	/*
>  	 * If none of the buffers had errors then we can set the page uptodate,
>  	 * but we first have to perform the post read mst fixups, if the
> @@ -142,8 +140,7 @@ static void ntfs_end_buffer_async_read(struct buffer_head *bh, int uptodate)
>  	unlock_page(page);
>  	return;
>  still_busy:
> -	bit_spin_unlock(BH_Uptodate_Lock, &first->b_state);
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
>  	return;
>  }
>  
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 7b73ef7f902d4..e0b020eaf32e2 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -22,9 +22,6 @@ enum bh_state_bits {
>  	BH_Dirty,	/* Is dirty */
>  	BH_Lock,	/* Is locked */
>  	BH_Req,		/* Has been submitted for I/O */
> -	BH_Uptodate_Lock,/* Used by the first bh in a page, to serialise
> -			  * IO completion of other buffers in the page
> -			  */
>  
>  	BH_Mapped,	/* Has a disk mapping */
>  	BH_New,		/* Disk mapping was newly created by get_block */
> @@ -76,6 +73,9 @@ struct buffer_head {
>  	struct address_space *b_assoc_map;	/* mapping this buffer is
>  						   associated with */
>  	atomic_t b_count;		/* users using this buffer_head */
> +	spinlock_t b_uptodate_lock;	/* Used by the first bh in a page, to
> +					 * serialise IO completion of other
> +					 * buffers in the page */
>  };
>  
>  /*
> -- 
> 2.24.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
