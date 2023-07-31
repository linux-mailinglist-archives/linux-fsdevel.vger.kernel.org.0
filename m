Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F047696F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 15:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjGaNAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 09:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjGaNAG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:00:06 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFCC10B
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 05:59:41 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bba2318546so38086335ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690808381; x=1691413181;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QF4UfSzVoHFhH6+qe8bLS1UKeUs4p2gL1IF9YsMfWkA=;
        b=dHrCRfHwIUHF4BS2n82py2omFFDqIXCVBCUH8PtJ4HyoxSIodUTkV1K0tLQS7I9xyQ
         mjBvUi9W4SMymURvNAiMLRkp1v0B1HlBFPP+64/I0aTcnVrjVcZv0GDeHHGOk9UGKeR8
         UjsdVJ3Y/jqNIZDFIoEv9kk4k76LcK6c9JuA1jjhAWj8eo/Iw65TJqNkkPLPyto0U0EI
         XgXb+p9eqrXlyJ2ZsFVMxC1TX0Rx58rbVuOnvU110LavqBCbCFchaWjOaAFHnk8an54O
         wz8FRShHslT3ylpNtLJC3U5Nvi3XcvfIZq/btNmCmiSokU5bWGqH4EQ7apmPVeB73iLu
         OIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690808381; x=1691413181;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QF4UfSzVoHFhH6+qe8bLS1UKeUs4p2gL1IF9YsMfWkA=;
        b=I8EcRZfcmPHnughBK/wJTw/UGQ+ciH/5udhhgVhtIStQbCFT0DINBt2lMt5trWYm40
         QQp9G8Njq+Bv4Pah9rAvgHXGR0yyZ4uIMxhOAyTGzvrEMehlOAKWvj3HIpf2VT1/5+vZ
         ZJnA9RYxnAL568TbSg50IeX+qnONG6BmBIeEGxR5tkXwFON17SqdcVcnBMTFmOTAhdhI
         ueTMv46kXVVp307t+CPzTUH2C9Hyuam2uzNmRggmuEuDXchAlOz0YD31m8HKOFN0Ryml
         g9KidLTESCqfVJMjWYfzcxftgKqxOy+2jpRim/C7kuEpkULcK7SylIGcb11q+hRo+hZC
         n5MA==
X-Gm-Message-State: ABy/qLYubTMM1c2KyPq/4pcXRZEe1bP9u60f1Yd4OtTepkq3uUmGcDiq
        DgMG4FfjyY9vO2wblsPRJkWNCQ==
X-Google-Smtp-Source: APBJJlHHG4qXD9pZodOOo0V7rqHfL8gnI1pSgRBecx9tQxQM+G3qqHTm+p53UtVvSWNfoK0EIyRaZA==
X-Received: by 2002:a17:902:c952:b0:1b8:8223:8bdd with SMTP id i18-20020a170902c95200b001b882238bddmr11629798pla.59.1690808381254;
        Mon, 31 Jul 2023 05:59:41 -0700 (PDT)
Received: from [10.90.34.137] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902da8600b001bb24cb9a40sm8531225plx.39.2023.07.31.05.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 05:59:40 -0700 (PDT)
Message-ID: <ed519424-af7c-5a19-f94d-b7ad76cc879a@bytedance.com>
Date:   Mon, 31 Jul 2023 20:59:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.1
Subject: Re: [PATCH 11/11] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-12-zhangpeng.00@bytedance.com>
 <20230726170645.2m2rbk325dy727eo@revolver>
Cc:     linux-mm@kvack.org, avagin@gmail.com, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, peterz@infradead.org,
        michael.christie@oracle.com, surenb@google.com, brauner@kernel.org,
        willy@infradead.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230726170645.2m2rbk325dy727eo@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/7/27 01:06, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
>> Use __mt_dup() to duplicate the old maple tree in dup_mmap(), and then
>> directly modify the entries of VMAs in the new maple tree, which can
>> get better performance. dup_mmap() is used by fork(), so this patch
>> optimizes fork(). The optimization effect is proportional to the number
>> of VMAs.
>>
>> Due to the introduction of this method, the optimization in
>> (maple_tree: add a fast path case in mas_wr_slot_store())[1] no longer
>> has an effect here, but it is also an optimization of the maple tree.
>>
>> There is a unixbench test suite[2] where 'spawn' is used to test fork().
>> 'spawn' only has 23 VMAs by default, so I tweaked the benchmark code a
>> bit to use mmap() to control the number of VMAs. Therefore, the
>> performance under different numbers of VMAs can be measured.
>>
>> Insert code like below into 'spawn':
>> for (int i = 0; i < 200; ++i) {
>> 	size_t size = 10 * getpagesize();
>> 	void *addr;
>>
>> 	if (i & 1) {
>> 		addr = mmap(NULL, size, PROT_READ,
>> 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>> 	} else {
>> 		addr = mmap(NULL, size, PROT_WRITE,
>> 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>> 	}
>> 	if (addr == MAP_FAILED)
>> 		...
>> }
>>
>> Based on next-20230721, use 'spawn' under 23, 203, and 4023 VMAs, test
>> 4 times in 30 seconds each time, and get the following numbers. These
>> numbers are the number of fork() successes in 30s (average of the best
>> 3 out of 4). By the way, based on next-20230725, I reverted [1], and
>> tested it together as a comparison. In order to ensure the reliability
>> of the test results, these tests were run on a physical machine.
>>
>> 		23VMAs		223VMAs		4023VMAs
>> revert [1]:	159104.00	73316.33	6787.00
> 
> You can probably remove the revert benchmark from this since there is no
> reason to revert the previous change. The change is worth while on its
> own, so it's better to have the numbers more clear by having with and
> without this series.
I will remove it.
> 
>>
>> 		+0.77%		+0.42%		+0.28%
>> next-20230721:	160321.67	73624.67	6806.33
>>
>> 		+2.77%		+15.42%		+29.86%
>> apply this:	164751.67	84980.33	8838.67
> 
> What is the difference between using this patch with mas_replace_entry()
> and mas_store_entry()?
I haven't tested and compared them yet, I will compare them when I have
time. It may be compared by simulating fork() in user space.
> 
>>
>> It can be seen that the performance improvement is proportional to
>> the number of VMAs. With 23 VMAs, performance improves by about 3%,
>> with 223 VMAs, performance improves by about 15%, and with 4023 VMAs,
>> performance improves by about 30%.
>>
>> [1] https://lore.kernel.org/lkml/20230628073657.75314-4-zhangpeng.00@bytedance.com/
>> [2] https://github.com/kdlucas/byte-unixbench/tree/master
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   kernel/fork.c | 35 +++++++++++++++++++++++++++--------
>>   mm/mmap.c     | 14 ++++++++++++--
>>   2 files changed, 39 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index f81149739eb9..ef80025b62d6 100644
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
>> @@ -678,17 +677,40 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>   		goto out;
>>   	khugepaged_fork(mm, oldmm);
>>   
>> -	retval = vma_iter_bulk_alloc(&vmi, oldmm->map_count);
>> -	if (retval)
>> +	/* Use __mt_dup() to efficiently build an identical maple tree. */
>> +	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_NOWAIT | __GFP_NOWARN);
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
>> +					mas_replace_entry(&vmi.mas,
>> +							  XA_ZERO_ENTRY);
>> +				goto loop_out;
>> +			}
>> +
>>   			continue;
>>   		}
>>   		charge = 0;
>> @@ -750,8 +772,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>   			hugetlb_dup_vma_private(tmp);
>>   
>>   		/* Link the vma into the MT */
>> -		if (vma_iter_bulk_store(&vmi, tmp))
>> -			goto fail_nomem_vmi_store;
>> +		mas_replace_entry(&vmi.mas, tmp);
>>   
>>   		mm->map_count++;
>>   		if (!(tmp->vm_flags & VM_WIPEONFORK))
>> @@ -778,8 +799,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>   	uprobe_end_dup_mmap();
>>   	return retval;
>>   
>> -fail_nomem_vmi_store:
>> -	unlink_anon_vmas(tmp);
>>   fail_nomem_anon_vma_fork:
>>   	mpol_put(vma_policy(tmp));
>>   fail_nomem_policy:
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index bc91d91261ab..5bfba2fb0e39 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -3184,7 +3184,11 @@ void exit_mmap(struct mm_struct *mm)
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
>> @@ -3222,7 +3226,13 @@ void exit_mmap(struct mm_struct *mm)
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
