Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5BB798559
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 12:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbjIHKBd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 06:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjIHKBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:01:32 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A430E1FEE
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 03:00:24 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so21552255ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Sep 2023 03:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694167145; x=1694771945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bXTeQpdjQRua5NdbqlMCWj/ycDFicrMQeBdM0bMGMw=;
        b=ZiFN1LLDL6sDVu4ON/wkI4bAEvJ2RNe5ShlKFp00uUyWiGgA+yu9ajYeZF5t2+K38G
         DQEp0DNNu3/73r89a1SwU+rda0PnAHXnMW8IJ/8S4Bth5wwQieOra3OHsOqyV1ivvquw
         G2jGHQLPbl6TaWRH+xJyxts5zLqAUiTSXS+SEVLZzphGRghgdViNZF/hFxKW+LlSX8u1
         SoJ5uW8gvM/91C+Jl1iQPNdW4xhecY450a2TvjcyGzCRCo7yUflNNntDFlE3pq+slzD7
         qVxNyHqB6b3sriliEeRE0F3ODcp/8WUmWi5x9SeFLkobcaZS6wvjoSiwYcUzi5gZ/LAs
         Fung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694167145; x=1694771945;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3bXTeQpdjQRua5NdbqlMCWj/ycDFicrMQeBdM0bMGMw=;
        b=JmFE9grmmK+pdtAd3aIvVwfxfYsrpwkTHaFYVcVJDO2O5xi+e5rJtysLXIKq8Lyvt+
         BRTNRCQykoNAOiEJAkBkx8i7Mf9MLxmH1n+ULzztv4UIETGqm/+LQ25rzHYJj2sfFY6W
         1EZFSXWsTjMa9fe0lc4UuPXzXUNnIVieZuqzz9RRrseaSQWeOx4EJumcGyf4xCbd7Fu/
         44TIS5mmJIZB9D06G/ktpVQ3/p2AxaF+nd2A4S+v0rg1RRksvcI52pKh/ix3nwsDneAS
         wZl4n7s+8JACUZFDHwxK/UUomYSnWaN9fg/8HwojoOLwthv5hwZnww6Tm06TNAKC8nd/
         Qv3A==
X-Gm-Message-State: AOJu0YyE0BykKrwLk8NyZpgvuGhetCrIg7lEQkEUfSAX4mvu+Flhex+X
        OAcWSrUmTF9g1t5XflRN7GxySw==
X-Google-Smtp-Source: AGHT+IGedR76hVXK1WBcaqFuQUXJzaKlwoEvzzggHuGYxkzUO76lUrRz9GzNXg+wcSGY1vog4i33bg==
X-Received: by 2002:a17:902:e54e:b0:1c0:bcbc:d67 with SMTP id n14-20020a170902e54e00b001c0bcbc0d67mr6761333plf.22.1694167144904;
        Fri, 08 Sep 2023 02:59:04 -0700 (PDT)
Received: from [10.254.232.87] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id bi4-20020a170902bf0400b001bc45408d26sm1199081plb.36.2023.09.08.02.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 02:59:04 -0700 (PDT)
Message-ID: <ab29ca4d-a7dc-9115-930d-86c6425e2b9c@bytedance.com>
Date:   Fri, 8 Sep 2023 17:58:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Maybe I didn't express clearly, "Increment of VMAs" means the number of
VMAs added on the basis of 21 VMAs.
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
OK, I'll change it to GFP_KERNEL.
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

Thank you for your suggestion, I will do this in the next version.
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
