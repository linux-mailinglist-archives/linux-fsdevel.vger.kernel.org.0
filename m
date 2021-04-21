Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC065366CA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 15:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbhDUNWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 09:22:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:55594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242516AbhDUNUt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:20:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5EFB7B4C0;
        Wed, 21 Apr 2021 13:20:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F374A1F2B69; Wed, 21 Apr 2021 15:20:14 +0200 (CEST)
Date:   Wed, 21 Apr 2021 15:20:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yukuai3@huawei.com
Subject: Re: [RFC PATCH v2 2/7] jbd2: ensure abort the journal if detect IO
 error when writing original buffer back
Message-ID: <20210421132014.GR8706@quack2.suse.cz>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
 <20210414134737.2366971-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414134737.2366971-3-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 14-04-21 21:47:32, Zhang Yi wrote:
> Althourh we merged <c044f3d8360> ("jbd2: abort journal if free a async
  ^^ Although         ^^ We usually reference commits without <>.

> write error metadata buffer"), there is a race between
> jbd2_journal_try_to_free_buffers() and jbd2_journal_destroy(), so the
> jbd2_log_do_checkpoint() may still missing to detect the buffer write
                                      ^^^ fail

> io error flag and will end up leading to filesystem inconsistency.
                ^^^^^^^^^^^^^^^^^^^ which may lead
 
> jbd2_journal_try_to_free_buffers()     ext4_put_super()
>                                         jbd2_journal_destroy()
>   __jbd2_journal_remove_checkpoint()
>   detect buffer write error              jbd2_log_do_checkpoint()
>                                          jbd2_cleanup_journal_tail()
>                                            <--- lead to inconsistency
>   jbd2_journal_abort()
> 
> Fix this issue by introduce a new mark j_checkpoint_io_error and set it
                      ^^^ introducing

> in __jbd2_journal_remove_checkpoint() when freeing a checkpoint buffer
> has write_io_error flag. Then jbd2_journal_destroy() will detect this
  ^ which has

> mark and abort the journal to prevent updating log tail.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thanks! In principle the patch looks good. Some spelling corrections and a
few suggestions for improvement below.

> ---
>  fs/jbd2/checkpoint.c | 32 +++++++++++++++++++-------------
>  fs/jbd2/journal.c    |  9 +++++++++
>  include/linux/jbd2.h |  7 +++++++
>  3 files changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index bf5511d19ac5..ff3d38ad3a1e 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -221,14 +221,15 @@ int jbd2_log_do_checkpoint(journal_t *journal)
>  	result = jbd2_cleanup_journal_tail(journal);
>  	trace_jbd2_checkpoint(journal, result);
>  	jbd_debug(1, "cleanup_journal_tail returned %d\n", result);
> -	if (result <= 0)
> +	if (result == 0)
>  		return result;
> +	if (result < 0)
> +		goto error;
>  
>  	/*
>  	 * OK, we need to start writing disk blocks.  Take one transaction
>  	 * and write it.
>  	 */
> -	result = 0;
>  	spin_lock(&journal->j_list_lock);
>  	if (!journal->j_checkpoint_transactions)
>  		goto out;
> @@ -295,8 +296,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
>  			goto restart;
>  		}
>  		if (!buffer_dirty(bh)) {
> -			if (unlikely(buffer_write_io_error(bh)) && !result)
> -				result = -EIO;
>  			BUFFER_TRACE(bh, "remove from checkpoint");
>  			if (__jbd2_journal_remove_checkpoint(jh))
>  				/* The transaction was released; we're done */
> @@ -356,9 +355,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
>  			spin_lock(&journal->j_list_lock);
>  			goto restart2;
>  		}
> -		if (unlikely(buffer_write_io_error(bh)) && !result)
> -			result = -EIO;
> -
>  		/*
>  		 * Now in whatever state the buffer currently is, we
>  		 * know that it has been written out and so we can
> @@ -369,12 +365,13 @@ int jbd2_log_do_checkpoint(journal_t *journal)
>  	}
>  out:
>  	spin_unlock(&journal->j_list_lock);
> -	if (result < 0)
> +	result = jbd2_cleanup_journal_tail(journal);
> +	if (result >= 0)
> +		return 0;
> +error:
> +	if (!is_journal_aborted(journal))
>  		jbd2_journal_abort(journal, result);
> -	else
> -		result = jbd2_cleanup_journal_tail(journal);
> -
> -	return (result < 0) ? result : 0;
> +	return result;
>  }
>  
>  /*
> @@ -400,7 +397,7 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
>  	tid_t		first_tid;
>  	unsigned long	blocknr;
>  
> -	if (is_journal_aborted(journal))
> +	if (is_journal_aborted(journal) || journal->j_checkpoint_io_error)
>  		return -EIO;

I think it would be cleaner to have in jbd2_journal_update_sb_log_tail()
a code handling j_checkpoint_io_error like:

	if (is_journal_aborted(journal))
		return -EIO;
	if (journal->j_checkpoint_io_error) {
		jbd2_journal_abort(...);
		return -EIO;
	}

So we are sure we never update log tail once we hit checkpointing error.
That way we can also drop this special case from
jbd2_cleanup_journal_tail() as well as from jbd2_log_do_checkpoint().

>  
>  	if (!jbd2_journal_get_log_tail(journal, &first_tid, &blocknr))
> @@ -564,6 +561,7 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
>  	struct transaction_chp_stats_s *stats;
>  	transaction_t *transaction;
>  	journal_t *journal;
> +	struct buffer_head *bh = jh2bh(jh);
>  
>  	JBUFFER_TRACE(jh, "entry");
>  
> @@ -575,6 +573,14 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
>  	journal = transaction->t_journal;
>  
>  	JBUFFER_TRACE(jh, "removing from transaction");
> +	/*
> +	 * If the buffer has been failed to write out to disk, it may probably
> +	 * lead to filesystem inconsistency after remove it from the log, so
> +	 * mark the journal checkpoint write back IO error.
> +	 */

I'd rephrase this comment like:
If we have failed to write the buffer out to disk, the filesystem may
become inconsistent. We cannot abort the journal here since we hold
j_list_lock and we have to careful about races with jbd2_journal_destroy().
So mark the writeback IO error in the journal here and we abort the journal
later from a better context.

> +	if (buffer_write_io_error(bh))
> +		journal->j_checkpoint_io_error = true;
> +

I agree that using j_flags for this is not great because they require
j_state_lock which we cannot easily take in
__jbd2_journal_remove_checkpoint(). But I think it may be better to create
j_atomic_flags in journal_t, manipulate these with atomic bitops
(set_bit(), test_bit()) and have just a flag J_CHECKPOINT_IO_ERROR there.
That way we can use these flags for other purposes in the future as well
and we won't create new KCSAN warnings...

>  	__buffer_unlink(jh);
>  	jh->b_cp_transaction = NULL;
>  	jbd2_journal_put_journal_head(jh);
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 2dc944442802..6dbeab8b9feb 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1995,6 +1995,15 @@ int jbd2_journal_destroy(journal_t *journal)
>  	J_ASSERT(journal->j_checkpoint_transactions == NULL);
>  	spin_unlock(&journal->j_list_lock);
>  
> +	/*
> +	 * OK, all checkpoint transactions have been checked, now check the
> +	 * write out io error flag and abort the journal if some buffer failed
> +	 * to write back to the original location, otherwise the filesystem
> +	 * may probably becomes inconsistency.
           ^^^^^^^^^^^^^^^^^^^^^^^^^^  may become inconsistent.

> +	 */
> +	if (!is_journal_aborted(journal) && journal->j_checkpoint_io_error)
> +		jbd2_journal_abort(journal, -EIO);
> +
>  	if (journal->j_sb_buffer) {
>  		if (!is_journal_aborted(journal)) {
>  			mutex_lock_io(&journal->j_checkpoint_mutex);
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 99d3cd051ac3..53ca70f80ad8 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -841,6 +841,13 @@ struct journal_s
>  	 */
>  	transaction_t		*j_checkpoint_transactions;
>  
> +	/**
> +	 * @j_checkpoint_io_error:
> +	 *
> +	 * Detect io error while writing back original buffer to disk.
> +	 */
> +	bool			j_checkpoint_io_error;
> +
>  	/**
>  	 * @j_wait_transaction_locked:
>  	 *

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
