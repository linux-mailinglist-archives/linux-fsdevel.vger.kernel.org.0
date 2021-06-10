Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3133A304A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 18:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhFJQOT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 12:14:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58754 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJQOT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:14:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E40352199C;
        Thu, 10 Jun 2021 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623341541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zMzJu9iO7dHLsQBChM4aepWnDqudUU93oTOP1yYWE64=;
        b=ZiER73GQajqvE/q5TDtP/FBEnHDVO4mKs6ygAU2dTh4Ju04m7iWOWWAUFJFi5UYwtMV9sd
        0Iu610EJSp5UuHUsnV5JK9/FTjXVQx196/X0OMV0EoFEdSk0hcprCJ5/Frx8UZ8nM8cGa+
        0gz/+J3aeuxeU1gh5wdEcb8xoNkSTAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623341541;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zMzJu9iO7dHLsQBChM4aepWnDqudUU93oTOP1yYWE64=;
        b=oM50gpxVcSjY1XVXMZqpRcXmeQMf1EUVExTyuHiZ73G/JJhQtasi8mnay6FKJjtXkRMBlX
        1vPNCpHHUsH3PeBg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id CB95DA3B8B;
        Thu, 10 Jun 2021 16:12:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 888661F2CAB; Thu, 10 Jun 2021 18:12:21 +0200 (CEST)
Date:   Thu, 10 Jun 2021 18:12:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
        david@fromorbit.com, hch@infradead.org
Subject: Re: [RFC PATCH v4 5/8] jbd2,ext4: add a shrinker to release
 checkpointed buffers
Message-ID: <20210610161221.GD23539@quack2.suse.cz>
References: <20210610112440.3438139-1-yi.zhang@huawei.com>
 <20210610112440.3438139-6-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610112440.3438139-6-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-06-21 19:24:37, Zhang Yi wrote:
> Current metadata buffer release logic in bdev_try_to_free_page() have
> a lot of use-after-free issues when umount filesystem concurrently, and
> it is difficult to fix directly because ext4 is the only user of
> s_op->bdev_try_to_free_page callback and we may have to add more special
> refcount or lock that is only used by ext4 into the common vfs layer,
> which is unacceptable.
> 
> One better solution is remove the bdev_try_to_free_page callback, but
> the real problem is we cannot easily release journal_head on the
> checkpointed buffer, so try_to_free_buffers() cannot release buffers and
> page under memory pressure, which is more likely to trigger
> out-of-memory. So we cannot remove the callback directly before we find
> another way to release journal_head.
> 
> This patch introduce a shrinker to free journal_head on the checkpointed
> transaction. After the journal_head got freed, try_to_free_buffers()
> could free buffer properly.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c             |   8 ++
>  fs/jbd2/checkpoint.c        | 147 ++++++++++++++++++++++++++++++++++++
>  fs/jbd2/journal.c           |  87 +++++++++++++++++++++
>  include/linux/jbd2.h        |  26 +++++++
>  include/trace/events/jbd2.h | 101 +++++++++++++++++++++++++
>  5 files changed, 369 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index d29f6aa7d96e..80064e566f56 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1174,6 +1174,7 @@ static void ext4_put_super(struct super_block *sb)
>  	ext4_unregister_sysfs(sb);
>  
>  	if (sbi->s_journal) {
> +		jbd2_journal_unregister_shrinker(sbi->s_journal);
>  		aborted = is_journal_aborted(sbi->s_journal);
>  		err = jbd2_journal_destroy(sbi->s_journal);
>  		sbi->s_journal = NULL;
> @@ -5178,6 +5179,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  	sbi->s_ea_block_cache = NULL;
>  
>  	if (sbi->s_journal) {
> +		jbd2_journal_unregister_shrinker(sbi->s_journal);
>  		jbd2_journal_destroy(sbi->s_journal);
>  		sbi->s_journal = NULL;
>  	}
> @@ -5504,6 +5506,12 @@ static int ext4_load_journal(struct super_block *sb,
>  		ext4_commit_super(sb);
>  	}
>  
> +	err = jbd2_journal_register_shrinker(journal);
> +	if (err) {
> +		EXT4_SB(sb)->s_journal = NULL;
> +		goto err_out;
> +	}
> +
>  	return 0;
>  
>  err_out:
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 75a4f622afaf..1abdae44a3d8 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -79,6 +79,18 @@ static inline void __buffer_relink_io(struct journal_head *jh)
>  	transaction->t_checkpoint_io_list = jh;
>  }
>  
> +/*
> + * Check a checkpoint buffer could be release or not.
> + *
> + * Requires j_list_lock
> + */
> +static inline bool __cp_buffer_busy(struct journal_head *jh)
> +{
> +	struct buffer_head *bh = jh2bh(jh);
> +
> +	return (jh->b_transaction || buffer_locked(bh) || buffer_dirty(bh));
> +}
> +
>  /*
>   * Try to release a checkpointed buffer from its transaction.
>   * Returns 1 if we released it and 2 if we also released the
> @@ -458,6 +470,137 @@ static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
>  	return 0;
>  }
>  
> +/*
> + * journal_shrink_one_cp_list
> + *
> + * Find 'nr_to_scan' written-back checkpoint buffers in the given list
> + * and try to release them. If the whole transaction is released, set
> + * the 'released' parameter. Return the number of released checkpointed
> + * buffers.
> + *
> + * Called with j_list_lock held.
> + */
> +static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
> +						unsigned long *nr_to_scan,
> +						bool *released)
> +{
> +	struct journal_head *last_jh;
> +	struct journal_head *next_jh = jh;
> +	unsigned long nr_freed = 0;
> +	int ret;
> +
> +	if (!jh || *nr_to_scan == 0)
> +		return 0;
> +
> +	last_jh = jh->b_cpprev;
> +	do {
> +		jh = next_jh;
> +		next_jh = jh->b_cpnext;
> +
> +		(*nr_to_scan)--;
> +		if (__cp_buffer_busy(jh))
> +			continue;
> +
> +		nr_freed++;
> +		ret = __jbd2_journal_remove_checkpoint(jh);
> +		if (ret) {
> +			*released = true;
> +			break;
> +		}
> +
> +		if (need_resched())
> +			break;
> +	} while (jh != last_jh && *nr_to_scan);
> +
> +	return nr_freed;
> +}
> +
> +/*
> + * jbd2_journal_shrink_checkpoint_list
> + *
> + * Find 'nr_to_scan' written-back checkpoint buffers in the journal
> + * and try to release them. Return the number of released checkpointed
> + * buffers.
> + *
> + * Called with j_list_lock held.
> + */
> +unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
> +						  unsigned long *nr_to_scan)
> +{
> +	transaction_t *transaction, *last_transaction, *next_transaction;
> +	bool released;
> +	tid_t first_tid = 0, last_tid = 0, next_tid = 0;
> +	tid_t tid = 0;
> +	unsigned long nr_freed = 0;
> +	unsigned long nr_scanned = *nr_to_scan;
> +
> +again:
> +	spin_lock(&journal->j_list_lock);
> +	if (!journal->j_checkpoint_transactions) {
> +		spin_unlock(&journal->j_list_lock);
> +		goto out;
> +	}
> +
> +	/*
> +	 * Get next shrink transaction, resume previous scan or start
> +	 * over again. If some others do checkpoint and drop transaction
> +	 * from the checkpoint list, we ignore saved j_shrink_transaction
> +	 * and start over unconditionally.
> +	 */
> +	if (journal->j_shrink_transaction)
> +		transaction = journal->j_shrink_transaction;
> +	else
> +		transaction = journal->j_checkpoint_transactions;
> +
> +	if (!first_tid)
> +		first_tid = transaction->t_tid;
> +	last_transaction = journal->j_checkpoint_transactions->t_cpprev;
> +	next_transaction = transaction;
> +	last_tid = last_transaction->t_tid;
> +	do {
> +		transaction = next_transaction;
> +		next_transaction = transaction->t_cpnext;
> +		tid = transaction->t_tid;
> +		released = false;
> +
> +		nr_freed += journal_shrink_one_cp_list(transaction->t_checkpoint_list,
> +						       nr_to_scan, &released);
> +		if (*nr_to_scan == 0)
> +			break;
> +		if (need_resched() || spin_needbreak(&journal->j_list_lock))
> +			break;
> +		if (released)
> +			continue;
> +
> +		nr_freed += journal_shrink_one_cp_list(transaction->t_checkpoint_io_list,
> +						       nr_to_scan, &released);
> +		if (*nr_to_scan == 0)
> +			break;
> +		if (need_resched() || spin_needbreak(&journal->j_list_lock))
> +			break;
> +	} while (transaction != last_transaction);
> +
> +	if (transaction != last_transaction) {
> +		journal->j_shrink_transaction = next_transaction;
> +		next_tid = next_transaction->t_tid;
> +	} else {
> +		journal->j_shrink_transaction = NULL;
> +		next_tid = 0;
> +	}
> +
> +	spin_unlock(&journal->j_list_lock);
> +	cond_resched();
> +
> +	if (*nr_to_scan && next_tid)
> +		goto again;
> +out:
> +	nr_scanned -= *nr_to_scan;
> +	trace_jbd2_shrink_checkpoint_list(journal, first_tid, tid, last_tid,
> +					  nr_freed, nr_scanned, next_tid);
> +
> +	return nr_freed;
> +}
> +
>  /*
>   * journal_clean_checkpoint_list
>   *
> @@ -580,6 +723,7 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
>  
>  	__buffer_unlink(jh);
>  	jh->b_cp_transaction = NULL;
> +	percpu_counter_dec(&journal->j_jh_shrink_count);
>  	jbd2_journal_put_journal_head(jh);
>  
>  	/* Is this transaction empty? */
> @@ -642,6 +786,7 @@ void __jbd2_journal_insert_checkpoint(struct journal_head *jh,
>  		jh->b_cpnext->b_cpprev = jh;
>  	}
>  	transaction->t_checkpoint_list = jh;
> +	percpu_counter_inc(&transaction->t_journal->j_jh_shrink_count);
>  }
>  
>  /*
> @@ -657,6 +802,8 @@ void __jbd2_journal_insert_checkpoint(struct journal_head *jh,
>  void __jbd2_journal_drop_transaction(journal_t *journal, transaction_t *transaction)
>  {
>  	assert_spin_locked(&journal->j_list_lock);
> +
> +	journal->j_shrink_transaction = NULL;
>  	if (transaction->t_cpnext) {
>  		transaction->t_cpnext->t_cpprev = transaction->t_cpprev;
>  		transaction->t_cpprev->t_cpnext = transaction->t_cpnext;
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 90146755941f..3746bb4fc431 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1954,6 +1954,91 @@ int jbd2_journal_load(journal_t *journal)
>  	return -EIO;
>  }
>  
> +/**
> + * jbd2_journal_shrink_scan()
> + *
> + * Scan the checkpointed buffer on the checkpoint list and release the
> + * journal_head.
> + */
> +static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
> +					      struct shrink_control *sc)
> +{
> +	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
> +	unsigned long nr_to_scan = sc->nr_to_scan;
> +	unsigned long nr_shrunk;
> +	unsigned long count;
> +
> +	count = percpu_counter_read_positive(&journal->j_jh_shrink_count);
> +	trace_jbd2_shrink_scan_enter(journal, sc->nr_to_scan, count);
> +
> +	nr_shrunk = jbd2_journal_shrink_checkpoint_list(journal, &nr_to_scan);
> +
> +	count = percpu_counter_read_positive(&journal->j_jh_shrink_count);
> +	trace_jbd2_shrink_scan_exit(journal, nr_to_scan, nr_shrunk, count);
> +
> +	return nr_shrunk;
> +}
> +
> +/**
> + * jbd2_journal_shrink_count()
> + *
> + * Count the number of checkpoint buffers on the checkpoint list.
> + */
> +static unsigned long jbd2_journal_shrink_count(struct shrinker *shrink,
> +					       struct shrink_control *sc)
> +{
> +	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
> +	unsigned long count;
> +
> +	count = percpu_counter_read_positive(&journal->j_jh_shrink_count);
> +	trace_jbd2_shrink_count(journal, sc->nr_to_scan, count);
> +
> +	return count;
> +}
> +
> +/**
> + * jbd2_journal_register_shrinker()
> + * @journal: Journal to act on.
> + *
> + * Init a percpu counter to record the checkpointed buffers on the checkpoint
> + * list and register a shrinker to release their journal_head.
> + */
> +int jbd2_journal_register_shrinker(journal_t *journal)
> +{
> +	int err;
> +
> +	journal->j_shrink_transaction = NULL;
> +
> +	err = percpu_counter_init(&journal->j_jh_shrink_count, 0, GFP_KERNEL);
> +	if (err)
> +		return err;
> +
> +	journal->j_shrinker.scan_objects = jbd2_journal_shrink_scan;
> +	journal->j_shrinker.count_objects = jbd2_journal_shrink_count;
> +	journal->j_shrinker.seeks = DEFAULT_SEEKS;
> +	journal->j_shrinker.batch = journal->j_max_transaction_buffers;
> +
> +	err = register_shrinker(&journal->j_shrinker);
> +	if (err) {
> +		percpu_counter_destroy(&journal->j_jh_shrink_count);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * jbd2_journal_unregister_shrinker()
> + * @journal: Journal to act on.
> + *
> + * Unregister the checkpointed buffer shrinker and destroy the percpu counter.
> + */
> +void jbd2_journal_unregister_shrinker(journal_t *journal)
> +{
> +	percpu_counter_destroy(&journal->j_jh_shrink_count);
> +	unregister_shrinker(&journal->j_shrinker);
> +}
> +
>  /**
>   * jbd2_journal_destroy() - Release a journal_t structure.
>   * @journal: Journal to act on.
> @@ -2026,6 +2111,8 @@ int jbd2_journal_destroy(journal_t *journal)
>  		brelse(journal->j_sb_buffer);
>  	}
>  
> +	jbd2_journal_unregister_shrinker(journal);
> +
>  	if (journal->j_proc_entry)
>  		jbd2_stats_proc_exit(journal);
>  	iput(journal->j_inode);
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index f9b5e657b8f3..23578506215f 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -909,6 +909,29 @@ struct journal_s
>  	 */
>  	struct buffer_head	*j_chkpt_bhs[JBD2_NR_BATCH];
>  
> +	/**
> +	 * @j_shrinker:
> +	 *
> +	 * Journal head shrinker, reclaim buffer's journal head which
> +	 * has been written back.
> +	 */
> +	struct shrinker		j_shrinker;
> +
> +	/**
> +	 * @j_jh_shrink_count:
> +	 *
> +	 * Number of journal buffers on the checkpoint list. [j_list_lock]
> +	 */
> +	struct percpu_counter	j_jh_shrink_count;
> +
> +	/**
> +	 * @j_shrink_transaction:
> +	 *
> +	 * Record next transaction will shrink on the checkpoint list.
> +	 * [j_list_lock]
> +	 */
> +	transaction_t		*j_shrink_transaction;
> +
>  	/**
>  	 * @j_head:
>  	 *
> @@ -1418,6 +1441,7 @@ extern void jbd2_journal_commit_transaction(journal_t *);
>  
>  /* Checkpoint list management */
>  void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy);
> +unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal, unsigned long *nr_to_scan);
>  int __jbd2_journal_remove_checkpoint(struct journal_head *);
>  void jbd2_journal_destroy_checkpoint(journal_t *journal);
>  void __jbd2_journal_insert_checkpoint(struct journal_head *, transaction_t *);
> @@ -1528,6 +1552,8 @@ extern int	   jbd2_journal_set_features
>  		   (journal_t *, unsigned long, unsigned long, unsigned long);
>  extern void	   jbd2_journal_clear_features
>  		   (journal_t *, unsigned long, unsigned long, unsigned long);
> +extern int	   jbd2_journal_register_shrinker(journal_t *journal);
> +extern void	   jbd2_journal_unregister_shrinker(journal_t *journal);
>  extern int	   jbd2_journal_load       (journal_t *journal);
>  extern int	   jbd2_journal_destroy    (journal_t *);
>  extern int	   jbd2_journal_recover    (journal_t *journal);
> diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
> index d16a32867f3a..a4dfe005983d 100644
> --- a/include/trace/events/jbd2.h
> +++ b/include/trace/events/jbd2.h
> @@ -394,6 +394,107 @@ TRACE_EVENT(jbd2_lock_buffer_stall,
>  		__entry->stall_ms)
>  );
>  
> +DECLARE_EVENT_CLASS(jbd2_journal_shrink,
> +
> +	TP_PROTO(journal_t *journal, unsigned long nr_to_scan,
> +		 unsigned long count),
> +
> +	TP_ARGS(journal, nr_to_scan, count),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(unsigned long, nr_to_scan)
> +		__field(unsigned long, count)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= journal->j_fs_dev->bd_dev;
> +		__entry->nr_to_scan	= nr_to_scan;
> +		__entry->count		= count;
> +	),
> +
> +	TP_printk("dev %d,%d nr_to_scan %lu count %lu",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->nr_to_scan, __entry->count)
> +);
> +
> +DEFINE_EVENT(jbd2_journal_shrink, jbd2_shrink_count,
> +
> +	TP_PROTO(journal_t *journal, unsigned long nr_to_scan, unsigned long count),
> +
> +	TP_ARGS(journal, nr_to_scan, count)
> +);
> +
> +DEFINE_EVENT(jbd2_journal_shrink, jbd2_shrink_scan_enter,
> +
> +	TP_PROTO(journal_t *journal, unsigned long nr_to_scan, unsigned long count),
> +
> +	TP_ARGS(journal, nr_to_scan, count)
> +);
> +
> +TRACE_EVENT(jbd2_shrink_scan_exit,
> +
> +	TP_PROTO(journal_t *journal, unsigned long nr_to_scan,
> +		 unsigned long nr_shrunk, unsigned long count),
> +
> +	TP_ARGS(journal, nr_to_scan, nr_shrunk, count),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(unsigned long, nr_to_scan)
> +		__field(unsigned long, nr_shrunk)
> +		__field(unsigned long, count)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= journal->j_fs_dev->bd_dev;
> +		__entry->nr_to_scan	= nr_to_scan;
> +		__entry->nr_shrunk	= nr_shrunk;
> +		__entry->count		= count;
> +	),
> +
> +	TP_printk("dev %d,%d nr_to_scan %lu nr_shrunk %lu count %lu",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->nr_to_scan, __entry->nr_shrunk,
> +		  __entry->count)
> +);
> +
> +TRACE_EVENT(jbd2_shrink_checkpoint_list,
> +
> +	TP_PROTO(journal_t *journal, tid_t first_tid, tid_t tid, tid_t last_tid,
> +		 unsigned long nr_freed, unsigned long nr_scanned,
> +		 tid_t next_tid),
> +
> +	TP_ARGS(journal, first_tid, tid, last_tid, nr_freed,
> +		nr_scanned, next_tid),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(tid_t, first_tid)
> +		__field(tid_t, tid)
> +		__field(tid_t, last_tid)
> +		__field(unsigned long, nr_freed)
> +		__field(unsigned long, nr_scanned)
> +		__field(tid_t, next_tid)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= journal->j_fs_dev->bd_dev;
> +		__entry->first_tid	= first_tid;
> +		__entry->tid		= tid;
> +		__entry->last_tid	= last_tid;
> +		__entry->nr_freed	= nr_freed;
> +		__entry->nr_scanned	= nr_scanned;
> +		__entry->next_tid	= next_tid;
> +	),
> +
> +	TP_printk("dev %d,%d shrink transaction %u-%u(%u) freed %lu "
> +		  "scanned %lu next transaction %u",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->first_tid, __entry->tid, __entry->last_tid,
> +		  __entry->nr_freed, __entry->nr_scanned, __entry->next_tid)
> +);
> +
>  #endif /* _TRACE_JBD2_H */
>  
>  /* This part must be outside protection */
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
