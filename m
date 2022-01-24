Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F75497B76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 10:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiAXJMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 04:12:24 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42420 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbiAXJLx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:11:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BE5831F38F;
        Mon, 24 Jan 2022 09:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643015510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pclTjgWx5vU3/PoEZ8sdrQgqpdal8p/gNWrmseRwR/M=;
        b=zvdxcU0TNbcrU6ysCWVa42iphoQkkHSCL1ZALnKgwFUEpomZ0gmbYwb7t4wgRG834fDJk3
        TldzlVhRvp5Q0Q7TSA4BhBZTOsBIOkEmucSVYuel0N4J03gcH6SNKMJbaoL3XbF+3rvemi
        nnRmFj4zqBjZ4D0aTHtJZc18PeG33F8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643015510;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pclTjgWx5vU3/PoEZ8sdrQgqpdal8p/gNWrmseRwR/M=;
        b=ZNGRDfh87zOEwMUThSLKEbE2fuuM1DuCPdIl7CiSkv+EQKkEV3BPW3Bwz4znO1g5A07wtz
        kwSVYSus2mTNnQAQ==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A42DCA3BDB;
        Mon, 24 Jan 2022 09:11:50 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 44151A05E7; Mon, 24 Jan 2022 10:11:50 +0100 (CET)
Date:   Mon, 24 Jan 2022 10:11:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, Jan Kara <jack@suse.cz>
Subject: Re: [PATCHv1 1/2] jbd2: Kill t_handle_lock transaction spinlock
Message-ID: <20220124091150.4zwj4hxpego4zl6w@quack3.lan>
References: <cover.1642953021.git.riteshh@linux.ibm.com>
 <089b38635884e95cfd858c003630bdc8bd7f22b0.1642953021.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <089b38635884e95cfd858c003630bdc8bd7f22b0.1642953021.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 23-01-22 22:53:27, Ritesh Harjani wrote:
> This patch kills t_handle_lock transaction spinlock completely from
> jbd2.
> To explain the reasoning, currently there were three sites at which this
> spinlock was used.
> 1. jbd2_journal_wait_updates()
>    a. Based on careful code review it can be seen that, we don't need this
>       lock here. This is since we wait for any currently ongoing updates
>       based on a atomic variable t_updates. And we anyway don't take any
>       t_handle_lock while in stop_this_handle().
>       i.e.
> 
> 	write_lock(&journal->j_state_lock()
> 	jbd2_journal_wait_updates() 			stop_this_handle()
> 		while (atomic_read(txn->t_updates) { 		|
> 		DEFINE_WAIT(wait); 				|
> 		prepare_to_wait(); 				|
> 		if (atomic_read(txn->t_updates) 		if (atomic_dec_and_test(txn->t_updates))
> 			write_unlock(&journal->j_state_lock);
> 			schedule();					wake_up()
> 			write_lock(&journal->j_state_lock);
> 		finish_wait();
> 	   }
> 	txn->t_state = T_COMMIT
> 	write_unlock(&journal->j_state_lock);
> 
>    b.  Also note that between atomic_inc(&txn->t_updates) in
>        start_this_handle() and jbd2_journal_wait_updates(), the
>        synchronization happens via read_lock(journal->j_state_lock) in
>        start_this_handle();
> 
> 2. jbd2_journal_extend()
>    a. jbd2_journal_extend() is called with the handle of each process from
>       task_struct. So no lock required in updating member fields of handle_t
> 
>    b. For member fields of h_transaction, all updates happens only via
>       atomic APIs (which is also within read_lock()).
>       So, no need of this transaction spinlock.
> 
> 3. update_t_max_wait()
>    Based on Jan suggestion, this can be carefully removed using atomic
>    cmpxchg API.
>    Note that there can be several processes which are waiting for a new
>    transaction to be allocated and started. For doing this only one
>    process will succeed in taking write_lock() and allocating a new txn.
>    After that all of the process will be updating the t_max_wait (max
>    transaction wait time). This can be done via below method w/o taking
>    any locks using atomic cmpxchg.
>    For more details refer [1]
> 
> 	   new = get_new_val();
> 	   old = READ_ONCE(ptr->max_val);
> 	   while (old < new)
> 		old = cmpxchg(&ptr->max_val, old, new);
> 
> [1]: https://lwn.net/Articles/849237/
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/transaction.c | 29 +++++++++--------------------
>  include/linux/jbd2.h  |  3 ---
>  2 files changed, 9 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 8e2f8275a253..68dd7de49aff 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -107,7 +107,6 @@ static void jbd2_get_transaction(journal_t *journal,
>  	transaction->t_start_time = ktime_get();
>  	transaction->t_tid = journal->j_transaction_sequence++;
>  	transaction->t_expires = jiffies + journal->j_commit_interval;
> -	spin_lock_init(&transaction->t_handle_lock);
>  	atomic_set(&transaction->t_updates, 0);
>  	atomic_set(&transaction->t_outstanding_credits,
>  		   jbd2_descriptor_blocks_per_trans(journal) +
> @@ -139,24 +138,21 @@ static void jbd2_get_transaction(journal_t *journal,
>  /*
>   * Update transaction's maximum wait time, if debugging is enabled.
>   *
> - * In order for t_max_wait to be reliable, it must be protected by a
> - * lock.  But doing so will mean that start_this_handle() can not be
> - * run in parallel on SMP systems, which limits our scalability.  So
> - * unless debugging is enabled, we no longer update t_max_wait, which
> - * means that maximum wait time reported by the jbd2_run_stats
> - * tracepoint will always be zero.
> + * t_max_wait is carefully updated here with use of atomic compare exchange.
> + * Note that there could be multiplre threads trying to do this simultaneously
> + * hence using cmpxchg to avoid any use of locks in this case.
>   */
>  static inline void update_t_max_wait(transaction_t *transaction,
>  				     unsigned long ts)
>  {
>  #ifdef CONFIG_JBD2_DEBUG
> +	unsigned long oldts, newts;
>  	if (jbd2_journal_enable_debug &&
>  	    time_after(transaction->t_start, ts)) {
> -		ts = jbd2_time_diff(ts, transaction->t_start);
> -		spin_lock(&transaction->t_handle_lock);
> -		if (ts > transaction->t_max_wait)
> -			transaction->t_max_wait = ts;
> -		spin_unlock(&transaction->t_handle_lock);
> +		newts = jbd2_time_diff(ts, transaction->t_start);
> +		oldts = READ_ONCE(transaction->t_max_wait);
> +		while (oldts < newts)
> +			oldts = cmpxchg(&transaction->t_max_wait, oldts, newts);
>  	}
>  #endif
>  }
> @@ -690,7 +686,6 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
>  		DIV_ROUND_UP(
>  			handle->h_revoke_credits_requested,
>  			journal->j_revoke_records_per_block);
> -	spin_lock(&transaction->t_handle_lock);
>  	wanted = atomic_add_return(nblocks,
>  				   &transaction->t_outstanding_credits);
> 
> @@ -698,7 +693,7 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
>  		jbd_debug(3, "denied handle %p %d blocks: "
>  			  "transaction too large\n", handle, nblocks);
>  		atomic_sub(nblocks, &transaction->t_outstanding_credits);
> -		goto unlock;
> +		goto error_out;
>  	}
> 
>  	trace_jbd2_handle_extend(journal->j_fs_dev->bd_dev,
> @@ -714,8 +709,6 @@ int jbd2_journal_extend(handle_t *handle, int nblocks, int revoke_records)
>  	result = 0;
> 
>  	jbd_debug(3, "extended handle %p by %d\n", handle, nblocks);
> -unlock:
> -	spin_unlock(&transaction->t_handle_lock);
>  error_out:
>  	read_unlock(&journal->j_state_lock);
>  	return result;
> @@ -847,22 +840,18 @@ void jbd2_journal_wait_updates(journal_t *journal)
>  	if (!commit_transaction)
>  		return;
> 
> -	spin_lock(&commit_transaction->t_handle_lock);
>  	while (atomic_read(&commit_transaction->t_updates)) {
>  		DEFINE_WAIT(wait);
> 
>  		prepare_to_wait(&journal->j_wait_updates, &wait,
>  					TASK_UNINTERRUPTIBLE);
>  		if (atomic_read(&commit_transaction->t_updates)) {
> -			spin_unlock(&commit_transaction->t_handle_lock);
>  			write_unlock(&journal->j_state_lock);
>  			schedule();
>  			write_lock(&journal->j_state_lock);
> -			spin_lock(&commit_transaction->t_handle_lock);
>  		}
>  		finish_wait(&journal->j_wait_updates, &wait);
>  	}
> -	spin_unlock(&commit_transaction->t_handle_lock);
>  }
> 
>  /**
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 575c3057a98a..500a95f8c914 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -554,9 +554,6 @@ struct transaction_chp_stats_s {
>   *    ->j_list_lock
>   *
>   *    j_state_lock
> - *    ->t_handle_lock
> - *
> - *    j_state_lock
>   *    ->j_list_lock			(journal_unmap_buffer)
>   *
>   */
> --
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
