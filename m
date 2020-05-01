Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9121C1D38
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 20:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgEASbh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 14:31:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729671AbgEASbg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 14:31:36 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C10182073E;
        Fri,  1 May 2020 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588357895;
        bh=y5endcBdRtoCj1Tt8QD/M5/dbqGOLi26jtmjl4udNrY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=p+8W2DJfPnCO/0UYGY5wGOfwx5QWnsMqsHvq0ro95t26bI0dt03+Ha+M3kqJTxWwx
         cCPHa4DMgpSkhDU/t5mMTqVdVpbuqNAoUy2/CPPPwe99cVNGX27cBlB5XBaanc73jN
         7WG04les3sMSrmkOXCqSQB0vVvJ+D0XatgE5jKY8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7783B3522690; Fri,  1 May 2020 11:31:35 -0700 (PDT)
Date:   Fri, 1 May 2020 11:31:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [RFC 02/20] ext4: Introduce percpu seq counter for freeing
 blocks(PA) to avoid ENOSPC err
Message-ID: <20200501183135.GA7560@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <cover.1588313626.git.riteshh@linux.ibm.com>
 <65959db57fa53e5d3d63099b0d5c039ab1154253.1588313626.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65959db57fa53e5d3d63099b0d5c039ab1154253.1588313626.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 01, 2020 at 11:59:44AM +0530, Ritesh Harjani wrote:
> There could be a race in function ext4_mb_discard_group_preallocations()
> where the 1st thread may iterate through group's bb_prealloc_list and
> remove all the PAs and add to function's local list head.
> Now if the 2nd thread comes in to discard the group preallocations,
> it will see that the group->bb_prealloc_list is empty and will return 0.
> 
> Consider for a case where we have less number of groups
> (for e.g. just group 0),
> this may even return an -ENOSPC error from ext4_mb_new_blocks()
> (where we call for ext4_mb_discard_group_preallocations()).
> But that is wrong, since 2nd thread should have waited for 1st thread
> to release all the PAs and should have retried for allocation.
> Since 1st thread was anyway going to discard the PAs.
> 
> The algorithm using this percpu seq counter goes below:
> 1. We sample the percpu discard_pa_seq counter before trying for block
>    allocation in ext4_mb_new_blocks().
> 2. We increment this percpu discard_pa_seq counter when we succeed in
>    allocating blocks and hence while adding the remaining blocks in group's
>    bb_prealloc_list (ext4_mb_new_inode_pa/ext4_mb_new_group_pa).
> 3. We also increment this percpu seq counter when we successfully identify
>    that the bb_prealloc_list is not empty and hence proceed for discarding
>    of those PAs inside ext4_mb_discard_group_preallocations().
> 
> Now to make sure that the regular fast path of block allocation is not
> affected, as a small optimization we only sample the percpu seq counter
> on that cpu. Only when the block allocation fails and when freed blocks
> found were 0, that is when we sample percpu seq counter for all cpus using
> below function ext4_get_discard_pa_seq_sum(). This happens after making
> sure that all the PAs on grp->bb_prealloc_list got freed.
> 
> TO CHECK: Though in here rcu_barrier only happens in ENOSPC path.
> =================================================================
> On rcu_barrier() - How expensive it can be?
> Does that mean that every thread who is coming and waiting on
> rcu_barrier() will actually check whether call_rcu() has completed by
> checking that on every cpu? So will this be a O(n*m) operation?
> (n = no. of threads, m = no. of cpus).
> Or are there some sort of optimization in using rcu_barrier()?

This first part assumes that a single task is executing a series of
rcu_barrier() calls sequentially.

Yes, the rcu_barrier() function makes heavy use of batching optimizations
and asynchrony.  So from an overhead perspective, it queues an RCU
callback on each CPU that has at least one callback already queued.
It does this queuing in such a way to avoid the need for any additional
grace periods.  Of course, each callback actually queued will eventually
be invoked (function call through a pointer), and the callback will
atomically decrement a counter and wake up the rcu_barrier() task if
that counter reaches zero.  So the CPU overhead is O(M), where M is the
number of CPUs, with negligible overhead except for those CPUs that have
at least one RCU callback queued.

So the CPU overhead of rcu_barrier() is quite small, at least when
taken on a per-CPU basis.

However, the latency can be a bit longer than than that of an RCU
grace period.  In normal operation, this will normally range from a few
milliseconds to a few hundred milliseconds.

And the caller of rcu_barrier() can also do batching.  For example,
the following:

	make_call_rcu_stop(a);
	rcu_barrier();
	depend_on_callbacks_finished(a);
	make_call_rcu_stop(b);
	rcu_barrier();
	depend_on_callbacks_finished(b);
	...
	make_call_rcu_stop(z);
	rcu_barrier();
	depend_on_callbacks_finished(z);

Can be safely transformed into this:

	make_call_rcu_stop(a);
	make_call_rcu_stop(b);
	...
	make_call_rcu_stop(z);
	rcu_barrier();
	depend_on_callbacks_finished(a);
	depend_on_callbacks_finished(b);
	...
	depend_on_callbacks_finished(z);

That single rcu_barrier() call can cover all 26 instances.
Give or take possible software-engineering and maintainability
issues, of course.

But what if a large number of tasks are concurrently executing
rcu_barrier()?

These will also be batched.  The first task will run the rcu_barrier()
machinery.  Any rcu_barrier() calls that show up before the first one
completes will share a single second run of the rcu_barrier() machinery.
And any rcu_barrier() calls that show up before this second run of
the machinery completes will be handled by a single third run of this
machinery.  And so on.

Does that help, or am I missing the point of your question?

							Thanx, Paul

> ---
> Note: The other method [1] also used to check for grp->bb_free next time
> if we couldn't discard anything. But it had below concerns due to which
> we cannot use that approach.
> 1. But one suspicion with that was that if grp->bb_free is non-zero for some
> reason (not sure), then we may result in that loop indefinitely but still
> won't be able to satisfy any request.
> 2. To check for grp->bb_free all threads were to wait on grp's spin_lock
> which might result in increased cpu usage.
> 3. In case of group's PA allocation (i.e. when file's size is < 1MB for
>    64K blocksize), there is still a case where ENOSPC could be returned.
>    This happens when the grp->bb_free is set to 0 but those blocks are
>    actually not yet added to PA. Yes, this could actually happen since
>    reducing grp->bb_free and adding those extra blocks in
>    bb_prealloc_list are not done atomically. Hence the race.
> 
> [1]: https://patchwork.ozlabs.org/project/linux-ext4/patch/533ac1f5b19c520b08f8c99aec5baf8729185714.1586954511.git.riteshh@linux.ibm.com/
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/ext4/mballoc.c | 65 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 60 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index a742e51e33b8..6bb08bb3c0ce 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -357,6 +357,35 @@ static void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
>  static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
>  						ext4_group_t group);
>  
> +/*
> + * The algorithm using this percpu seq counter goes below:
> + * 1. We sample the percpu discard_pa_seq counter before trying for block
> + *    allocation in ext4_mb_new_blocks().
> + * 2. We increment this percpu discard_pa_seq counter when we succeed in
> + *    allocating blocks and hence while adding the remaining blocks in group's
> + *    bb_prealloc_list (ext4_mb_new_inode_pa/ext4_mb_new_group_pa).
> + * 3. We also increment this percpu seq counter when we successfully identify
> + *    that the bb_prealloc_list is not empty and hence proceed for discarding
> + *    of those PAs inside ext4_mb_discard_group_preallocations().
> + *
> + * Now to make sure that the regular fast path of block allocation is not
> + * affected, as a small optimization we only sample the percpu seq counter
> + * on that cpu. Only when the block allocation fails and when freed blocks
> + * found were 0, that is when we sample percpu seq counter for all cpus using
> + * below function ext4_get_discard_pa_seq_sum(). This happens after making
> + * sure that all the PAs on grp->bb_prealloc_list got freed.
> + */
> +DEFINE_PER_CPU(u64, discard_pa_seq);
> +static inline u64 ext4_get_discard_pa_seq_sum(void)
> +{
> +	int __cpu;
> +	u64 __seq = 0;
> +
> +	for_each_possible_cpu(__cpu)
> +		__seq += per_cpu(discard_pa_seq, __cpu);
> +	return __seq;
> +}
> +
>  static inline void *mb_correct_addr_and_bit(int *bit, void *addr)
>  {
>  #if BITS_PER_LONG == 64
> @@ -3730,6 +3759,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  	pa->pa_inode = ac->ac_inode;
>  
>  	ext4_lock_group(sb, ac->ac_b_ex.fe_group);
> +	this_cpu_inc(discard_pa_seq);
>  	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
>  	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
>  
> @@ -3791,6 +3821,7 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
>  	pa->pa_inode = NULL;
>  
>  	ext4_lock_group(sb, ac->ac_b_ex.fe_group);
> +	this_cpu_inc(discard_pa_seq);
>  	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
>  	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
>  
> @@ -3943,6 +3974,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>  	INIT_LIST_HEAD(&list);
>  repeat:
>  	ext4_lock_group(sb, group);
> +	this_cpu_inc(discard_pa_seq);
>  	list_for_each_entry_safe(pa, tmp,
>  				&grp->bb_prealloc_list, pa_group_list) {
>  		spin_lock(&pa->pa_lock);
> @@ -4487,14 +4519,35 @@ static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
>  }
>  
>  static bool ext4_mb_discard_preallocations_should_retry(struct super_block *sb,
> -			struct ext4_allocation_context *ac)
> +			struct ext4_allocation_context *ac, u64 *seq)
>  {
>  	int freed;
> +	u64 seq_retry = 0;
> +	bool ret = false;
>  
>  	freed = ext4_mb_discard_preallocations(sb, ac->ac_o_ex.fe_len);
> -	if (freed)
> -		return true;
> -	return false;
> +	if (freed) {
> +		ret = true;
> +		goto out_dbg;
> +	}
> +	/*
> +	 * Unless it is ensured that PAs are actually freed, we may hit
> +	 * a ENOSPC error since the next time seq may match while the PA blocks
> +	 * are still getting freed in ext4_mb_release_inode/group_pa().
> +	 * So, rcu_barrier() here is to make sure that any call_rcu queued in
> +	 * ext4_mb_discard_group_preallocations() is completed before we
> +	 * proceed further to retry for block allocation.
> +	 */
> +	rcu_barrier();
> +	seq_retry = ext4_get_discard_pa_seq_sum();
> +	if (seq_retry != *seq) {
> +		*seq = seq_retry;
> +		ret = true;
> +	}
> +
> +out_dbg:
> +	mb_debug(1, "freed %d, retry ? %s\n", freed, ret ? "yes" : "no");
> +	return ret;
>  }
>  
>  /*
> @@ -4511,6 +4564,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>  	ext4_fsblk_t block = 0;
>  	unsigned int inquota = 0;
>  	unsigned int reserv_clstrs = 0;
> +	u64 seq;
>  
>  	might_sleep();
>  	sb = ar->inode->i_sb;
> @@ -4572,6 +4626,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>  	}
>  
>  	ac->ac_op = EXT4_MB_HISTORY_PREALLOC;
> +	seq = *this_cpu_ptr(&discard_pa_seq);
>  	if (!ext4_mb_use_preallocated(ac)) {
>  		ac->ac_op = EXT4_MB_HISTORY_ALLOC;
>  		ext4_mb_normalize_request(ac, ar);
> @@ -4603,7 +4658,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>  			ar->len = ac->ac_b_ex.fe_len;
>  		}
>  	} else {
> -		if (ext4_mb_discard_preallocations_should_retry(sb, ac))
> +		if (ext4_mb_discard_preallocations_should_retry(sb, ac, &seq))
>  			goto repeat;
>  		*errp = -ENOSPC;
>  	}
> -- 
> 2.21.0
> 
