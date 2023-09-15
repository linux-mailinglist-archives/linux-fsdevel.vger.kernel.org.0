Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DBF7A1CD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 12:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjIOKwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 06:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbjIOKwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:52:12 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A53C1727
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 03:51:14 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3aca1543608so1291484b6e.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 03:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694775074; x=1695379874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMemAtij3QQ2cXjoF+WzKzZ8e+4oePAFLp1g/05J6tM=;
        b=fJ+K494JExu3lMQiadnjjuT8H5rlkqAZvtkh++h8iRWoL+aG95T4jFzUCILVXoO+XD
         iAW62cUycuWR5IGJiFkGzjJ9QdGqIAAflvNMRcCEOQxzUd9Le1SIG4dxEsIETRl8czi3
         ktAbmTR98mz4qkLdcAeMyiO5UlmuB7nrGs2L0gZcXygQfGhgFVCkXqGasUPPZE0dkncO
         YfRzbfsPZZIZRJs5UUhf9Lrgrq2KMftrxtSAQ9kfqU3jdqc6HEAnLtgSasrSdURxfLty
         RGHJRCovra0SI+NWOgW2lLRJht0JJK9nNiHTlfYiT+Fr05IKRe/BMYG6k4pd9zMgxfWl
         eoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775074; x=1695379874;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FMemAtij3QQ2cXjoF+WzKzZ8e+4oePAFLp1g/05J6tM=;
        b=TDZsIKv4Ua4LmFfE94F5tBWQBWYI1qjNEXh8Z+nrMk4rN1b8+bBMO3Jc6irRhZOqFj
         UUuormBkbiFafUfCIoWzxhupYLmFVVl2RUQZYS+HjBwAKLS4HYvAeuKhr+wqaPeds4Lc
         oETVr+cMwnGpdW/MXPd4I6bNIuY053MtP7zBDhxSz0gfISfmY7frTv673gK4nJfvWzLH
         VaQRzP1KixnTzXMNpMDMmxWwdxn42Y29erl3I/XHxYP7c1zw6YOFMbC3ZyvVtcrDEePY
         GRtTRTU6anuw/lHP5RvdZRwjjeT/0vkMqXH2Aq3Idd8bEiFD77pTCXU7GyZlPVRicAfV
         gbzg==
X-Gm-Message-State: AOJu0Yx0Cb2Zglunhky6gQyPl4AVbStpwzZihJQ5QxTz6tgjSno7t0S9
        8Tk9Yt9foWga8DZ5NO6SlnLh9A==
X-Google-Smtp-Source: AGHT+IE8hoOsQCR8UcTdFU89pxisuTMaAPXw+AksO/nfKr2adb7Bh7PbfzrJejxqE39Bhf5wqZsPkA==
X-Received: by 2002:aca:1319:0:b0:3ab:8431:8037 with SMTP id e25-20020aca1319000000b003ab84318037mr1265084oii.32.1694775073742;
        Fri, 15 Sep 2023 03:51:13 -0700 (PDT)
Received: from [10.254.225.85] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7850e000000b00682c864f35bsm2837978pfn.140.2023.09.15.03.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 03:51:13 -0700 (PDT)
Message-ID: <2868f2d5-1abe-7af6-4196-ee53cfae76a9@bytedance.com>
Date:   Fri, 15 Sep 2023 18:51:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 6/6] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
 <20230830125654.21257-7-zhangpeng.00@bytedance.com>
 <20230907201414.dagnqxfnu7f7qzxd@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230907201414.dagnqxfnu7f7qzxd@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/9/8 04:14, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230830 08:58]:
>> Use __mt_dup() to duplicate the old maple tree in dup_mmap(), and then
>> directly modify the entries of VMAs in the new maple tree, which can
>> get better performance. The optimization effect is proportional to the
>> number of VMAs.
>>
>> There is a "spawn" in byte-unixbench[1], which can be used to test the
>> performance of fork(). I modified it slightly to make it work with
>> different number of VMAs.
>>
>> Below are the test numbers. There are 21 VMAs by default. The first row
>> indicates the number of added VMAs. The following two lines are the
>> number of fork() calls every 10 seconds. These numbers are different
>> from the test results in v1 because this time the benchmark is bound to
>> a CPU. This way the numbers are more stable.
>>
>>    Increment of VMAs: 0      100     200     400     800     1600    3200    6400
>> 6.5.0-next-20230829: 111878 75531   53683   35282   20741   11317   6110    3158
>> Apply this patchset: 114531 85420   64541   44592   28660   16371   9038    4831
>>                       +2.37% +13.09% +20.23% +26.39% +38.18% +44.66% +47.92% +52.98%
> 
> Thanks!
> 
> Can you include 21 in this table since it's the default?
> 
>>
>> [1] https://github.com/kdlucas/byte-unixbench/tree/master
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   kernel/fork.c | 34 ++++++++++++++++++++++++++--------
>>   mm/mmap.c     | 14 ++++++++++++--
>>   2 files changed, 38 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 3b6d20dfb9a8..e6299adefbd8 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>   	int retval;
>>   	unsigned long charge = 0;
>>   	LIST_HEAD(uf);
>> -	VMA_ITERATOR(old_vmi, oldmm, 0);
>>   	VMA_ITERATOR(vmi, mm, 0);
>>   
>>   	uprobe_start_dup_mmap();
>> @@ -678,17 +677,39 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>   		goto out;
>>   	khugepaged_fork(mm, oldmm);
>>   
>> -	retval = vma_iter_bulk_alloc(&vmi, oldmm->map_count);
>> -	if (retval)
>> +	/* Use __mt_dup() to efficiently build an identical maple tree. */
>> +	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_NOWAIT | __GFP_NOWARN);
> 
> Apparently the flags should be GFP_KERNEL here so that compaction can
> run.
> 
>> +	if (unlikely(retval))
>>   		goto out;
>>   
>>   	mt_clear_in_rcu(vmi.mas.tree);
>> -	for_each_vma(old_vmi, mpnt) {
>> +	for_each_vma(vmi, mpnt) {
>>   		struct file *file;
>>   
>>   		vma_start_write(mpnt);
>>   		if (mpnt->vm_flags & VM_DONTCOPY) {
>>   			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
>> +
>> +			/*
>> +			 * Since the new tree is exactly the same as the old one,
>> +			 * we need to remove the unneeded VMAs.
>> +			 */
>> +			mas_store(&vmi.mas, NULL);
>> +
>> +			/*
>> +			 * Even removing an entry may require memory allocation,
>> +			 * and if removal fails, we use XA_ZERO_ENTRY to mark
>> +			 * from which VMA it failed. The case of encountering
>> +			 * XA_ZERO_ENTRY will be handled in exit_mmap().
>> +			 */
>> +			if (unlikely(mas_is_err(&vmi.mas))) {
>> +				retval = xa_err(vmi.mas.node);
>> +				mas_reset(&vmi.mas);
>> +				if (mas_find(&vmi.mas, ULONG_MAX))
>> +					mas_store(&vmi.mas, XA_ZERO_ENTRY);
>> +				goto loop_out;
>> +			}
>> +
> 
> Storing NULL may need extra space as you noted, so we need to be careful
> what happens if we don't have that space.  We should have a testcase to
> test this scenario.
> 
> mas_store_gfp() should be used with GFP_KERNEL.  The VMAs use GFP_KERNEL
> in this function, see vm_area_dup().
> 
> Don't use the exit_mmap() path to undo a failed fork.  You've added
> checks and complications to the exit path for all tasks in the very
> unlikely event that we run out of memory when we hit a very unlikely
> VM_DONTCOPY flag.
> 
> I see the issue with having a portion of the tree with new VMAs that are
> accounted and a portion of the tree that has old VMAs that should not be
> looked at.  It was clever to use the XA_ZERO_ENTRY as a stop point, but
> we cannot add that complication to the exit path and then there is the
> OOM race to worry about (maybe, I am not sure since this MM isn't
> active yet).
I encountered some errors after implementing the scheme you mentioned
below. This would also clutter fork.c and mmap.c, as some internal
functions would need to be made global.

I thought of another way to put everything into maple tree. In non-RCU
mode, we can remove the last half of the tree without allocating any
memory. This requires modifications to the internal implementation of
mas_store().
Then remove the second half of the tree like this:

mas.index = 0;
mas.last = ULONGN_MAX;
mas_store(&mas, NULL).

At least in non-RCU mode, we can do this, since we only need to merge
some nodes, or move some items to adjacent nodes.
However, this will increase the workload significantly.

> 
> Using what is done in exit_mmap() and do_vmi_align_munmap() as a
> prototype, we can do something like the *untested* code below:
> 
> if (unlikely(mas_is_err(&vmi.mas))) {
> 	unsigned long max = vmi.index;
> 
> 	retval = xa_err(vmi.mas.node);
> 	mas_set(&vmi.mas, 0);
> 	tmp = mas_find(&vmi.mas, ULONG_MAX);
> 	if (tmp) { /* Not the first VMA failed */
> 		unsigned long nr_accounted = 0;
> 
> 		unmap_region(mm, &vmi.mas, vma, NULL, mpnt, 0, max, max,
> 				true);
> 		do {
> 			if (vma->vm_flags & VM_ACCOUNT)
> 				nr_accounted += vma_pages(vma);
> 			remove_vma(vma, true);
> 			cond_resched();
> 			vma = mas_find(&vmi.mas, max - 1);
> 		} while (vma != NULL);
> 
> 		vm_unacct_memory(nr_accounted);
> 	}
> 	__mt_destroy(&mm->mm_mt);
> 	goto loop_out;
> }
> 
> Once exit_mmap() is called, the check for OOM (no vma) will catch that
> nothing is left to do.
> 
> It might be worth making an inline function to do this to keep the fork
> code clean.  We should test this by detecting a specific task name and
> returning a failure at a given interval:
> 
> if (!strcmp(current->comm, "fork_test") {
> ...
> }
> 
> 
>>   			continue;
>>   		}
>>   		charge = 0;
>> @@ -750,8 +771,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>   			hugetlb_dup_vma_private(tmp);
>>   
>>   		/* Link the vma into the MT */
>> -		if (vma_iter_bulk_store(&vmi, tmp))
>> -			goto fail_nomem_vmi_store;
>> +		mas_store(&vmi.mas, tmp);
>>   
>>   		mm->map_count++;
>>   		if (!(tmp->vm_flags & VM_WIPEONFORK))
>> @@ -778,8 +798,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>   	uprobe_end_dup_mmap();
>>   	return retval;
>>   
>> -fail_nomem_vmi_store:
>> -	unlink_anon_vmas(tmp);
>>   fail_nomem_anon_vma_fork:
>>   	mpol_put(vma_policy(tmp));
>>   fail_nomem_policy:
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index b56a7f0c9f85..dfc6881be81c 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -3196,7 +3196,11 @@ void exit_mmap(struct mm_struct *mm)
>>   	arch_exit_mmap(mm);
>>   
>>   	vma = mas_find(&mas, ULONG_MAX);
>> -	if (!vma) {
>> +	/*
>> +	 * If dup_mmap() fails to remove a VMA marked VM_DONTCOPY,
>> +	 * xa_is_zero(vma) may be true.
>> +	 */
>> +	if (!vma || xa_is_zero(vma)) {
>>   		/* Can happen if dup_mmap() received an OOM */
>>   		mmap_read_unlock(mm);
>>   		return;
>> @@ -3234,7 +3238,13 @@ void exit_mmap(struct mm_struct *mm)
>>   		remove_vma(vma, true);
>>   		count++;
>>   		cond_resched();
>> -	} while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);
>> +		vma = mas_find(&mas, ULONG_MAX);
>> +		/*
>> +		 * If xa_is_zero(vma) is true, it means that subsequent VMAs
>> +		 * donot need to be removed. Can happen if dup_mmap() fails to
>> +		 * remove a VMA marked VM_DONTCOPY.
>> +		 */
>> +	} while (vma != NULL && !xa_is_zero(vma));
>>   
>>   	BUG_ON(count != mm->map_count);
>>   
>> -- 
>> 2.20.1
>>
> 
