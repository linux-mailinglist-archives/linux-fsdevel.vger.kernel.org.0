Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D2B1C499C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 00:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgEDWfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 18:35:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbgEDWfK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 18:35:10 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044MWUah026054;
        Mon, 4 May 2020 18:34:50 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30s4xk5xsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 18:34:50 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 044MUt3X016084;
        Mon, 4 May 2020 22:34:48 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 30s0g5nny8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 22:34:47 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 044MYj5U60293200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 May 2020 22:34:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3A3E42047;
        Mon,  4 May 2020 22:34:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DB8D4205E;
        Mon,  4 May 2020 22:34:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.59.231])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 May 2020 22:34:43 +0000 (GMT)
Subject: Re: [RFC 02/20] ext4: Introduce percpu seq counter for freeing
 blocks(PA) to avoid ENOSPC err
To:     paulmck@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
References: <cover.1588313626.git.riteshh@linux.ibm.com>
 <65959db57fa53e5d3d63099b0d5c039ab1154253.1588313626.git.riteshh@linux.ibm.com>
 <20200501183135.GA7560@paulmck-ThinkPad-P72>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 5 May 2020 04:04:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200501183135.GA7560@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200504223444.0DB8D4205E@d06av24.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_12:2020-05-04,2020-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040172
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Paul,

On 5/2/20 12:01 AM, Paul E. McKenney wrote:
> On Fri, May 01, 2020 at 11:59:44AM +0530, Ritesh Harjani wrote:
>> There could be a race in function ext4_mb_discard_group_preallocations()
>> where the 1st thread may iterate through group's bb_prealloc_list and
>> remove all the PAs and add to function's local list head.
>> Now if the 2nd thread comes in to discard the group preallocations,
>> it will see that the group->bb_prealloc_list is empty and will return 0.
>>
>> Consider for a case where we have less number of groups
>> (for e.g. just group 0),
>> this may even return an -ENOSPC error from ext4_mb_new_blocks()
>> (where we call for ext4_mb_discard_group_preallocations()).
>> But that is wrong, since 2nd thread should have waited for 1st thread
>> to release all the PAs and should have retried for allocation.
>> Since 1st thread was anyway going to discard the PAs.
>>
>> The algorithm using this percpu seq counter goes below:
>> 1. We sample the percpu discard_pa_seq counter before trying for block
>>     allocation in ext4_mb_new_blocks().
>> 2. We increment this percpu discard_pa_seq counter when we succeed in
>>     allocating blocks and hence while adding the remaining blocks in group's
>>     bb_prealloc_list (ext4_mb_new_inode_pa/ext4_mb_new_group_pa).
>> 3. We also increment this percpu seq counter when we successfully identify
>>     that the bb_prealloc_list is not empty and hence proceed for discarding
>>     of those PAs inside ext4_mb_discard_group_preallocations().
>>
>> Now to make sure that the regular fast path of block allocation is not
>> affected, as a small optimization we only sample the percpu seq counter
>> on that cpu. Only when the block allocation fails and when freed blocks
>> found were 0, that is when we sample percpu seq counter for all cpus using
>> below function ext4_get_discard_pa_seq_sum(). This happens after making
>> sure that all the PAs on grp->bb_prealloc_list got freed.
>>
>> TO CHECK: Though in here rcu_barrier only happens in ENOSPC path.
>> =================================================================
>> On rcu_barrier() - How expensive it can be?
>> Does that mean that every thread who is coming and waiting on
>> rcu_barrier() will actually check whether call_rcu() has completed by
>> checking that on every cpu? So will this be a O(n*m) operation?
>> (n = no. of threads, m = no. of cpus).
>> Or are there some sort of optimization in using rcu_barrier()?
> 
> This first part assumes that a single task is executing a series of
> rcu_barrier() calls sequentially.
> 
> Yes, the rcu_barrier() function makes heavy use of batching optimizations
> and asynchrony.  So from an overhead perspective, it queues an RCU
> callback on each CPU that has at least one callback already queued.
> It does this queuing in such a way to avoid the need for any additional
> grace periods.  Of course, each callback actually queued will eventually
> be invoked (function call through a pointer), and the callback will
> atomically decrement a counter and wake up the rcu_barrier() task if
> that counter reaches zero.  So the CPU overhead is O(M), where M is the
> number of CPUs, with negligible overhead except for those CPUs that have
> at least one RCU callback queued.
> 
> So the CPU overhead of rcu_barrier() is quite small, at least when
> taken on a per-CPU basis.
> 
> However, the latency can be a bit longer than than that of an RCU
> grace period.  In normal operation, this will normally range from a few
> milliseconds to a few hundred milliseconds.
> 
> And the caller of rcu_barrier() can also do batching.  For example,
> the following:
> 
> 	make_call_rcu_stop(a);
> 	rcu_barrier();
> 	depend_on_callbacks_finished(a);
> 	make_call_rcu_stop(b);
> 	rcu_barrier();
> 	depend_on_callbacks_finished(b);
> 	...
> 	make_call_rcu_stop(z);
> 	rcu_barrier();
> 	depend_on_callbacks_finished(z);
> 
> Can be safely transformed into this:
> 
> 	make_call_rcu_stop(a);
> 	make_call_rcu_stop(b);
> 	...
> 	make_call_rcu_stop(z);
> 	rcu_barrier();
> 	depend_on_callbacks_finished(a);
> 	depend_on_callbacks_finished(b);
> 	...
> 	depend_on_callbacks_finished(z);
> 
> That single rcu_barrier() call can cover all 26 instances.
> Give or take possible software-engineering and maintainability
> issues, of course.
> 
> But what if a large number of tasks are concurrently executing
> rcu_barrier()?
> 
> These will also be batched.  The first task will run the rcu_barrier()
> machinery.  Any rcu_barrier() calls that show up before the first one
> completes will share a single second run of the rcu_barrier() machinery.
> And any rcu_barrier() calls that show up before this second run of
> the machinery completes will be handled by a single third run of this
> machinery.  And so on.

Thanks for explaining that. So I was doing more reading on rcu_barrier()
code and I think what it essentially does, is depicted from line 1 - 12
below.

So AFAIU,
when there are multiple threads calling rcu_barrier(), what will happen
mostly is that 1st thread which calls this func will get the mutex_lock
(line 1) and will make sure that all calls to call_rcu() already queued
on different cpus are completed before this rcu_barrier() returns.
And how exactly this happens is that rcu_barrier() runs it's own
rcu_barrier_func() on all of those cpus which have call_rcu() queued up.
rcu_barrier_func() while running on each of those cpus then queues up
a call_rcu() (on it's tail of call_rcu queue) with
rcu_barrier_callback() function. This call_rcu queued on tail will run,
after all of previous call_rcu() functions from those per cpu queues are
completed. This rcu_barrier_callback() will mostly run after a grace
period (like how in general call_rcu() works).

And meanwhile all other threads will sleep while trying to acquire
that mutex lock. So at this time there could be something useful which
these cpus should be able to do (while waiting on mutex).
Now, when these other threads will be able to acquire the mutex_lock()
to proceed inside rcu_barrier(), in case if there are no more call_rcu()
queued in (since it should have been taken care by previous thread),
(checked in line 5 below) then nothing else will be done by
rcu_barrier(), and it will simply exit.

Is the above understanding correct?


Instead if I use a spinlock. Then in the worst case what will happen is
that most of the threads will just spin on this lock while not being
able to do anything useful. Also in case if it's heavy multi-threaded
and if we hit this scenario, then this could also result into high cpu
usage and sluggish performance since all threads are waiting on
spinlock.

My main reason to understand rcu_barrier() functionality is to weigh
my options of which one is a better approach to be deployed here.
Hence all of these queries :)


1. mutex_lock(&rcu_state.barrier_mutex);
2. init_completion(&rcu_state.barrier_completion);
3. atomic_set(&rcu_state.barrier_cpu_count, 1);

4. for_each_possible_cpu(cpu) {
5. 	if_we_have_any_call_rcu_pending_on_this_cpu {
6. 		smp_call_function_single(cpu, rcu_barrier_func, NULL, 1)
7. 	}
8. }

9. if (atomic_dec_and_test(&rcu_state.barrier_cpu_count))
10. 	complete(&rcu_state.barrier_completion);

11. wait_for_completion(&rcu_state.barrier_completion);

12. mutex_unlock(&rcu_state.barrier_mutex);


Thanks
-ritesh



>> ---
>> Note: The other method [1] also used to check for grp->bb_free next time
>> if we couldn't discard anything. But it had below concerns due to which
>> we cannot use that approach.
>> 1. But one suspicion with that was that if grp->bb_free is non-zero for some
>> reason (not sure), then we may result in that loop indefinitely but still
>> won't be able to satisfy any request.
>> 2. To check for grp->bb_free all threads were to wait on grp's spin_lock
>> which might result in increased cpu usage.
>> 3. In case of group's PA allocation (i.e. when file's size is < 1MB for
>>     64K blocksize), there is still a case where ENOSPC could be returned.
>>     This happens when the grp->bb_free is set to 0 but those blocks are
>>     actually not yet added to PA. Yes, this could actually happen since
>>     reducing grp->bb_free and adding those extra blocks in
>>     bb_prealloc_list are not done atomically. Hence the race.
>>
>> [1]: https://patchwork.ozlabs.org/project/linux-ext4/patch/533ac1f5b19c520b08f8c99aec5baf8729185714.1586954511.git.riteshh@linux.ibm.com/
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> ---
>>   fs/ext4/mballoc.c | 65 +++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 60 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index a742e51e33b8..6bb08bb3c0ce 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -357,6 +357,35 @@ static void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
>>   static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
>>   						ext4_group_t group);
>>   
>> +/*
>> + * The algorithm using this percpu seq counter goes below:
>> + * 1. We sample the percpu discard_pa_seq counter before trying for block
>> + *    allocation in ext4_mb_new_blocks().
>> + * 2. We increment this percpu discard_pa_seq counter when we succeed in
>> + *    allocating blocks and hence while adding the remaining blocks in group's
>> + *    bb_prealloc_list (ext4_mb_new_inode_pa/ext4_mb_new_group_pa).
>> + * 3. We also increment this percpu seq counter when we successfully identify
>> + *    that the bb_prealloc_list is not empty and hence proceed for discarding
>> + *    of those PAs inside ext4_mb_discard_group_preallocations().
>> + *
>> + * Now to make sure that the regular fast path of block allocation is not
>> + * affected, as a small optimization we only sample the percpu seq counter
>> + * on that cpu. Only when the block allocation fails and when freed blocks
>> + * found were 0, that is when we sample percpu seq counter for all cpus using
>> + * below function ext4_get_discard_pa_seq_sum(). This happens after making
>> + * sure that all the PAs on grp->bb_prealloc_list got freed.
>> + */
>> +DEFINE_PER_CPU(u64, discard_pa_seq);
>> +static inline u64 ext4_get_discard_pa_seq_sum(void)
>> +{
>> +	int __cpu;
>> +	u64 __seq = 0;
>> +
>> +	for_each_possible_cpu(__cpu)
>> +		__seq += per_cpu(discard_pa_seq, __cpu);
>> +	return __seq;
>> +}
>> +
>>   static inline void *mb_correct_addr_and_bit(int *bit, void *addr)
>>   {
>>   #if BITS_PER_LONG == 64
>> @@ -3730,6 +3759,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>>   	pa->pa_inode = ac->ac_inode;
>>   
>>   	ext4_lock_group(sb, ac->ac_b_ex.fe_group);
>> +	this_cpu_inc(discard_pa_seq);
>>   	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
>>   	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
>>   
>> @@ -3791,6 +3821,7 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
>>   	pa->pa_inode = NULL;
>>   
>>   	ext4_lock_group(sb, ac->ac_b_ex.fe_group);
>> +	this_cpu_inc(discard_pa_seq);
>>   	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
>>   	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
>>   
>> @@ -3943,6 +3974,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>>   	INIT_LIST_HEAD(&list);
>>   repeat:
>>   	ext4_lock_group(sb, group);
>> +	this_cpu_inc(discard_pa_seq);
>>   	list_for_each_entry_safe(pa, tmp,
>>   				&grp->bb_prealloc_list, pa_group_list) {
>>   		spin_lock(&pa->pa_lock);
>> @@ -4487,14 +4519,35 @@ static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
>>   }
>>   
>>   static bool ext4_mb_discard_preallocations_should_retry(struct super_block *sb,
>> -			struct ext4_allocation_context *ac)
>> +			struct ext4_allocation_context *ac, u64 *seq)
>>   {
>>   	int freed;
>> +	u64 seq_retry = 0;
>> +	bool ret = false;
>>   
>>   	freed = ext4_mb_discard_preallocations(sb, ac->ac_o_ex.fe_len);
>> -	if (freed)
>> -		return true;
>> -	return false;
>> +	if (freed) {
>> +		ret = true;
>> +		goto out_dbg;
>> +	}
>> +	/*
>> +	 * Unless it is ensured that PAs are actually freed, we may hit
>> +	 * a ENOSPC error since the next time seq may match while the PA blocks
>> +	 * are still getting freed in ext4_mb_release_inode/group_pa().
>> +	 * So, rcu_barrier() here is to make sure that any call_rcu queued in
>> +	 * ext4_mb_discard_group_preallocations() is completed before we
>> +	 * proceed further to retry for block allocation.
>> +	 */
>> +	rcu_barrier();
>> +	seq_retry = ext4_get_discard_pa_seq_sum();
>> +	if (seq_retry != *seq) {
>> +		*seq = seq_retry;
>> +		ret = true;
>> +	}
>> +
>> +out_dbg:
>> +	mb_debug(1, "freed %d, retry ? %s\n", freed, ret ? "yes" : "no");
>> +	return ret;
>>   }
>>   
>>   /*
>> @@ -4511,6 +4564,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>>   	ext4_fsblk_t block = 0;
>>   	unsigned int inquota = 0;
>>   	unsigned int reserv_clstrs = 0;
>> +	u64 seq;
>>   
>>   	might_sleep();
>>   	sb = ar->inode->i_sb;
>> @@ -4572,6 +4626,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>>   	}
>>   
>>   	ac->ac_op = EXT4_MB_HISTORY_PREALLOC;
>> +	seq = *this_cpu_ptr(&discard_pa_seq);
>>   	if (!ext4_mb_use_preallocated(ac)) {
>>   		ac->ac_op = EXT4_MB_HISTORY_ALLOC;
>>   		ext4_mb_normalize_request(ac, ar);
>> @@ -4603,7 +4658,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>>   			ar->len = ac->ac_b_ex.fe_len;
>>   		}
>>   	} else {
>> -		if (ext4_mb_discard_preallocations_should_retry(sb, ac))
>> +		if (ext4_mb_discard_preallocations_should_retry(sb, ac, &seq))
>>   			goto repeat;
>>   		*errp = -ENOSPC;
>>   	}
>> -- 
>> 2.21.0
>>
