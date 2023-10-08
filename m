Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EDA7BCD17
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Oct 2023 09:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344536AbjJHHzB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Oct 2023 03:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344503AbjJHHzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Oct 2023 03:55:00 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE323C5
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Oct 2023 00:54:56 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57ba2cd3507so2077572eaf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Oct 2023 00:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696751696; x=1697356496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CiVeFs4rLYJNOM6nP84puiTclSIlVzXsn8iQctMgrQ=;
        b=Nwwiua3TjRx83HuvHByoQUu4MbJfo+mFRsneTKLNeaAO/hWApTY5t61JIXcn28xE6y
         B74uEWiNOimQr/Sl2c+JmNKavIxhbyDdSl6coLgrclC+4bBMfHsCFTqWb8kCD9LDXGWT
         qbgLLLv2lskXcRHeb39/yES+FqP6UQUulxOCBxGaHPntMTLKk+8qnY2q91aaOdPmrCNL
         TaGEDqL6uGOHk9O/9IvVLbgmkMOrivALrRT4VhDCnCb8luU4Env+9F4FqBJeinu2Fl1h
         CpqNwbEaZ5ash6C8OPW8Ke5xGXT+zy8URrviBXxnrxpWiV9M/e/rwMKljNVAoc4qQ8jZ
         F8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696751696; x=1697356496;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3CiVeFs4rLYJNOM6nP84puiTclSIlVzXsn8iQctMgrQ=;
        b=PQ0HA+9SwoGloUS2Hm0XHyFVGvW3Th+AAjOgdyFFzLxmxfdkgmQGtN1LwFzzHwp6Sh
         lTz7Km1oKtIMSFaJl5W51B7eVWVgCxEsD2NLYYS/skUMZW6qFKnm+LLTHpSvZtzp0p3+
         rGoZ2NWYimwDlQstxXP48fKC0x7oQkd9N/rURyZI0bN4A5XGfZ+j+TEC4P9LN9WptVxX
         y78FNDrAlz3ScpVtSe77cu+Jj32uWUly7fy70c111fcrTf9mLsJxY8QRAxNp9sWsXnv0
         QbDghn9VaMGgABAmhNjh3gOMO5jQ5guirVxFTGkOdVH36/Q3rWeIPGee3JqPo3yunQKi
         AvVQ==
X-Gm-Message-State: AOJu0Yyc33x8KIXOQJOpOFEFIinm7PCWdrvYtVrM0IelxcG5UUk7Gqva
        4KBTVFKRfNAlXExznuBm7/qBmg==
X-Google-Smtp-Source: AGHT+IFu+FuMT2saAhTnIXdubStsQnOxJhzzAYV/Rk5c8MPEkCa+55X35jfF1DxYBOEQbYmYIN0elA==
X-Received: by 2002:a05:6358:3407:b0:134:e3d2:1e50 with SMTP id h7-20020a056358340700b00134e3d21e50mr11249698rwd.18.1696751695622;
        Sun, 08 Oct 2023 00:54:55 -0700 (PDT)
Received: from [10.254.233.150] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id t24-20020a1709028c9800b001c73f51e61csm7024964plo.106.2023.10.08.00.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 00:54:55 -0700 (PDT)
Message-ID: <223bff41-e759-488e-aa5b-fe8f6bb080a0@bytedance.com>
Date:   Sun, 8 Oct 2023 15:54:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH v3 9/9] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230925035617.84767-1-zhangpeng.00@bytedance.com>
 <20230925035617.84767-10-zhangpeng.00@bytedance.com>
 <20231003184634.bbb5c5ezkvi6tkdv@revolver>
 <58ec7a15-6983-d199-bc1a-6161c3b75e0f@bytedance.com>
 <20231004195347.yggeosopqwb6ftos@revolver>
 <785511a6-8636-04e5-c002-907443b34dad@bytedance.com>
 <20231007011102.koplouxuumlog3cu@revolver>
 <20231007013231.ctzjap6uzvutuant@revolver>
In-Reply-To: <20231007013231.ctzjap6uzvutuant@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/10/7 09:32, Liam R. Howlett 写道:
> * Liam R. Howlett <Liam.Howlett@Oracle.com> [231006 21:11]:
>> * Peng Zhang <zhangpeng.00@bytedance.com> [231005 11:56]:
>>>
>>>
>>> 在 2023/10/5 03:53, Liam R. Howlett 写道:
>>>> * Peng Zhang <zhangpeng.00@bytedance.com> [231004 05:10]:
>>>>>
>>>>>
>>>>> 在 2023/10/4 02:46, Liam R. Howlett 写道:
>>>>>> * Peng Zhang <zhangpeng.00@bytedance.com> [230924 23:58]:
>>>>>>> In dup_mmap(), using __mt_dup() to duplicate the old maple tree and then
>>>>>>> directly replacing the entries of VMAs in the new maple tree can result
>>>>>>> in better performance. __mt_dup() uses DFS pre-order to duplicate the
>>>>>>> maple tree, so it is very efficient. The average time complexity of
>>>>>>> duplicating VMAs is reduced from O(n * log(n)) to O(n). The optimization
>>>>>>> effect is proportional to the number of VMAs.
>>>>>>
>>>>>> I am not confident in the big O calculations here.  Although the addition
>>>>>> of the tree is reduced, adding a VMA still needs to create the nodes
>>>>>> above it - which are a function of n.  How did you get O(n * log(n)) for
>>>>>> the existing fork?
>>>>>>
>>>>>> I would think your new algorithm is n * log(n/16), while the
>>>>>> previous was n * log(n/16) * f(n).  Where f(n) would be something
>>>>>> to do with the decision to split/rebalance in bulk insert mode.
>>>>>>
>>>>>> It's certainly a better algorithm to duplicate trees, but I don't think
>>>>>> it is O(n).  Can you please explain?
>>>>>
>>>>> The following is a non-professional analysis of the algorithm.
>>>>>
>>>>> Let's first analyze the average time complexity of the new algorithm, as
>>>>> it is relatively easy to analyze. The maximum number of branches for
>>>>> internal nodes in a maple tree in allocation mode is 10. However, to
>>>>> simplify the analysis, we will not consider this case and assume that
>>>>> all nodes have a maximum of 16 branches.
>>>>>
>>>>> The new algorithm assumes that there is no case where a VMA with the
>>>>> VM_DONTCOPY flag is deleted. If such a case exists, this analysis cannot
>>>>> be applied.
>>>>>
>>>>> The operations of the new algorithm consist of three parts:
>>>>>
>>>>> 1. DFS traversal of each node in the source tree
>>>>> 2. For each node in the source tree, create a copy and construct a new
>>>>>      node
>>>>> 3. Traverse the new tree using mas_find() and replace each element
>>>>>
>>>>> If there are a total of n elements in the maple tree, we can conclude
>>>>> that there are n/16 leaf nodes. Regarding the second-to-last level, we
>>>>> can conclude that there are n/16^2 nodes. The total number of nodes in
>>>>> the entire tree is given by the sum of n/16 + n/16^2 + n/16^3 + ... + 1.
>>>>> This is a geometric progression with a total of log base 16 of n terms.
>>>>> According to the formula for the sum of a geometric progression, the sum
>>>>> is (n-1)/15. So, this tree has a total of (n-1)/15 nodes and
>>>>> (n-1)/15 - 1 edges.
>>>>>
>>>>> For the operations in the first part of this algorithm, since DFS
>>>>> traverses each edge twice, the time complexity would be
>>>>> 2*((n-1)/15 - 1).
>>>>>
>>>>> For the second part, each operation involves copying a node and making
>>>>> necessary modifications. Therefore, the time complexity is
>>>>> 16*(n-1)/15.
>>>>>
>>>>> For the third part, we use mas_find() to traverse and replace each
>>>>> element, which is essentially similar to the combination of the first
>>>>> and second parts. mas_find() traverses all nodes and within each node,
>>>>> it iterates over all elements and performs replacements. The time
>>>>> complexity of traversing the nodes is 2*((n-1)/15 - 1), and for all
>>>>> nodes, the time complexity of replacing all their elements is
>>>>> 16*(n-1)/15.
>>>>>
>>>>> By ignoring all constant factors, each of the three parts of the
>>>>> algorithm has a time complexity of O(n). Therefore, this new algorithm
>>>>> is O(n).
>>>>
>>>> Thanks for the detailed analysis!  I didn't mean to cause so much work
>>>> with this question.  I wanted to know so that future work could rely on
>>>> this calculation to demonstrate if it is worth implementing without
>>>> going through the effort of coding and benchmarking - after all, this
>>>> commit message will most likely be examined during that process.
>>>>
>>>> I asked because O(n) vs O(n*log(n)) doesn't seem to fit with your
>>>> benchmarking.
>>> It may not be well reflected in the benchmarking of fork() because all
>>> the aforementioned time complexity analysis is related to the part
>>> involving the maple tree, specifically the time complexity of
>>> constructing a new maple tree. However, fork() also includes many other
>>> behaviors.
>>
>> The forking is allocating VMAs, etc but all a 1-1 mapping per VMA so it
>> should be linear, if not near-linear.  There is some setup time involved
>> with the mm struct too, but that should become less as more VMAs are
>> added per fork.
>>
>>>>
>>>>>
>>>>> The exact time complexity of the old algorithm is difficult to analyze.
>>>>> I can only provide an upper bound estimation. There are two possible
>>>>> scenarios for each insertion:
>>>>>
>>>>> 1. Appending at the end of a node.
>>>>> 2. Splitting nodes multiple times.
>>>>>
>>>>> For the first scenario, the individual operation has a time complexity
>>>>> of O(1). As for the second scenario, it involves node splitting. The
>>>>> challenge lies in determining which insertions trigger splits and how
>>>>> many splits occur each time, which is difficult to calculate. In the
>>>>> worst-case scenario, each insertion requires splitting the tree's height
>>>>> log(n) times. Assuming every insertion is in the worst-case scenario,
>>>>> the time complexity would be n*log(n). However, not every insertion
>>>>> requires splitting, and the number of splits each time may not
>>>>> necessarily be log(n). Therefore, this is an estimation of the upper
>>>>> bound.
>>>>
>>>> Saying every insert causes a split and adding in n*log(n) is more than
>>>> an over estimation.  At worst there is some n + n/16 * log(n) going on
>>>> there.
>>>>
>>>> During the building of a tree, we are in bulk insert mode.  This favours
>>>> balancing the tree to the left to maximize the number of inserts being
>>>> append operations.  The algorithm inserts as many to the left as we can
>>>> leaving the minimum number on the right.
>>>>
>>>> We also reduce the number of splits by pushing data to the left whenever
>>>> possible, at every level.
>>> Yes, but I don't think pushing data would occur when inserting in
>>> ascending order in bulk mode because the left nodes are all full, while
>>> there are no nodes on the right side. However, I'm not entirely certain
>>> about this since I only briefly looked at the implementation of this
>>> part.
>>
>> They are not full, the right node has enough entries to have a
>> sufficient node, so the left node will have that many spaces for push.
>> mab_calc_split():
>>          if (unlikely((mas->mas_flags & MA_STATE_BULK))) {
>>                  *mid_split = 0;
>>                  split = b_end - mt_min_slots[bn->type];
Oh, thank you.
>>
>>>>
>>>>
>>>>>>
>>>>>>>
>>>>>>> As the entire maple tree is duplicated using __mt_dup(), if dup_mmap()
>>>>>>> fails, there will be a portion of VMAs that have not been duplicated in
>>>>>>> the maple tree. This makes it impossible to unmap all VMAs in exit_mmap().
>>>>>>> To solve this problem, undo_dup_mmap() is introduced to handle the failure
>>>>>>> of dup_mmap(). I have carefully tested the failure path and so far it
>>>>>>> seems there are no issues.
>>>>>>>
>>>>>>> There is a "spawn" in byte-unixbench[1], which can be used to test the
>>>>>>> performance of fork(). I modified it slightly to make it work with
>>>>>>> different number of VMAs.
>>>>>>>
>>>>>>> Below are the test results. By default, there are 21 VMAs. The first row
>>>>>>> shows the number of additional VMAs added on top of the default. The last
>>>>>>> two rows show the number of fork() calls per ten seconds. The test results
>>>>>>> were obtained with CPU binding to avoid scheduler load balancing that
>>>>>>> could cause unstable results. There are still some fluctuations in the
>>>>>>> test results, but at least they are better than the original performance.
>>>>>>>
>>>>>>> Increment of VMAs: 0      100     200     400     800     1600    3200    6400
>>>>>>> next-20230921:     112326 75469   54529   34619   20750   11355   6115    3183
>>>>>>> Apply this:        116505 85971   67121   46080   29722   16665   9050    4805
>>>>>>>                       +3.72% +13.92% +23.09% +33.11% +43.24% +46.76% +48.00% +50.96%
>>>>                delta       4179   10502   12592   11461    8972    5310   2935    1622
>>>>
>>>> Looking at this data, it is difficult to see what is going on because
>>>> there is a doubling of the VMAs per fork per column while the count is
>>>> forks per 10 seconds.  So this table is really a logarithmic table with
>>>> increases growing by 10%.  Adding the delta row makes it seem like the
>>>> number are not growing apart as I would expect.
>>>>
>>>> If we normalize this to VMAs per second by dividing the forks by 10,
>>>> then multiplying by the number of VMAs we get this:
>>>>
>>>> VMA Count:           21       121       221       421       821      1621       3221      6421
>>>> log(VMA)           1.32      2.00      2.30      2.60      2.90      3.20       3.36      3.81
>>>> next-20230921: 258349.8  928268.7 1215996.7 1464383.7 1707725.0 1842916.5  1420514.5 2044440.9
>>>> this:          267961.5 1057443.3 1496798.3 1949184.0 2446120.6 2704729.5  2102315.0 3086251.5
>>>> delta            9611.7  129174.6  280801.6  484800.3  738395.6  861813.0   681800.5 1041810.6
>>>>
>>>> The first thing that I noticed was that we hit some dip in the numbers
>>>> at 3221.  I first thought that might be something else running on the
>>>> host machine, but both runs are affected by around the same percent.
>>>>
>>>> Here, we do see the delta growing apart, but peaking in growth around
>>>> 821 VMAs.  Again that 3221 number is out of line.
>>>>
>>>> If we discard 21 and anything above 1621, we still see both lines are
>>>> asymptotic curves.  I would expect that the new algorithm would be more
>>>> linear to represent O(n), but there is certainly a curve when graphed
>>>> with a normalized X-axis.  The older algorithm, O(n*log(n)) should be
>>>> the opposite curve all together, and with a diminishing return, but it
>>>> seems the more elements we have, the more operations we can perform in a
>>>> second.
>>> Thank you for your detailed analysis.
>>>
>>> So, are you expecting the transformed data to be close to a constant
>>> value?
>>
>> I would expect it to increase linearly, but it's a curve.  Also, it
>> seems that both methods are near the identical curve, including the dip
>> at 3221.  I expect the new method to have a different curve, especially
>> at the higher numbers where the fork() overhead is much less, but it
>> seems they both curve asymptotically.  That is, they seen to be the same
>> complexity related to n, but with different constants.

I conducted a test on the quantity of VMAs at an extremely large scale.

old:

VMAs:             21       121     221      421      821      1621     3221     6421
forks/10s:        114156   76512   54409    34390    20138    11234    5999     3102
VMAs * forks/10s: 2397276  9257952 12024389 14478190 16533298 18210314 19322779 19917942
  
VMAs:             12821    25621    51221    102421   204821   409621   819221   1638421
forks/10s:        1600     806      393      172      88       41       21       11
VMAs * forks/10s: 20513600 20650526 20129853 17616412 18024248 16794461 17203641 18022631


new:

VMAs:             21       121      221      421      821      1621     3221     6421
forks/10s:        115523   86424    66484    45040    27462    15247    8435     4552
VMAs * forks/10s: 2425983  10457304 14692964 18961840 22546302 24715387 27169135 29228392
  
VMAs:             12821    25621    51221    102421   204821   409621   819221   1638421
forks/10s:        2446     1253     603      267      132      67       33       17
VMAs * forks/10s: 31360166 32103113 30886263 27346407 27036372 27444607 27034293 27853157

When the quantity of VMAs is sufficiently large, we can disregard the
other overheads of forking. VMAs * forks/10s can be considered as the
number of VMAs that can be duplicated in 10 seconds.

It can be observed that both the old algorithm and the new algorithm
reach a stable number of duplicated VMAs in 10 seconds when the quantity
of VMAs exceeds 6421. The approximate numbers are around 2e7 and 3e7,
respectively. However, after reaching 102,421, both algorithms show some
performance degradation that I cannot explain adequately. It is speculated
that the deterioration may be due to a decrease in memory allocation
performance. Nevertheless, even with the decline, they both converge to a
relatively stable value between 102,421 and 1,638,421.

The new algorithm can be proven to have an O(n) complexity, and the test
data roughly aligns with this theoretical analysis. It is challenging to
analyze the old algorithm theoretically, but based on the test data, it
is also likely to have an O(n) complexity. However, I cannot provide any
formal proof for this claim. So, in the next version, I will correct the
commit log, as nlog(n) may not be correct.
>>
>>> Please note that besides constructing a new maple tree, there are many
>>> other operations in fork(). As the number of VMAs increases, the number
>>> of fork() calls decreases. Therefore, the overall cost spent on other
>>> operations becomes smaller, while the cost spent on duplicating VMAs
>>> increases. That's why this data grows with the increase of VMAs. I
>>> speculate that if the number of VMAs is large enough to neglect the time
>>> spent on other operations in fork(), this data will approach a constant
>>> value.
>>
>> If it were the other parts of fork() causing the non-linear growth, then
>> I would expect 800 -> 1600 to increase to +53% instead of +46%, and if
>> we were hitting the limit of fork affecting the data, then I would
>> expect the delta of VMAs/second to not be so high at the upper 6421 -
>> both algorithms have more room to get more performance at least until
>> 6421 VMAs/fork.
>>
>>>
>>> If we want to achieve the expected curve, I think we should simulate the
>>> process of constructing the maple tree in user space to avoid the impact
>>> of other operations in fork(), just like in the current bench_forking().
>>>>
>>>> Thinking about what is going on here, I cannot come up with a reason
>>>> that there would be a curve to the line at all.  If we took more
>>>> measurements, I would think the samples would be an ever-increasing line
>>>> with variability for some function of 16 - a saw toothed increasing
>>>> line. At least, until an upper limit is reached.  We can see that the
>>>> upper limit was still not achieved at 1621 since 6421 is higher for both
>>>> runs, but a curve is evident on both methods, which suggests something
>>>> else is a significant contributor.
>>>>
>>>> I would think each VMA requires the same amount of work, so a constant.
>>>> The allocations would again, be some function that would linearly
>>>> increase with the existing method over-estimating by a huge number of
>>>> nodes.
>>>>
>>>> I'm not trying to nitpick here, but it is important to be accurate in
>>>> the statements because it may alter choices on how to proceed in
>>>> improving this performance later.  It may be others looking through
>>>> these commit messages to see if something can be improved.
>>> Thank you for pointing that out. I will try to describe it more
>>> accurately in the commit log and see if I can measure the expected curve
>>> in user space.
>>>>
>>>> I also feel like your notes on your algorithm are worth including in the
>>>> commit because it could prove rather valuable if we revisit forking in
>>>> the future.
>>> Do you mean that I should write the analysis of the time complexity of
>>> the new algorithm in the commit log?
>>
>> Yes, I think it's worth capturing.  What do you think?
Okay, I will update it in the commit log.
>>
>>>>
>>>> The more I look at this, the more questions I have that I cannot answer.
>>>> One thing we can see is that the new method is faster in this
>>>> micro-benchmark.
>>> Yes. It should be noted that in the field of computer science, if the
>>> test results don't align with the expected mathematical calculations,
>>> it indicates an error in the calculations. This is because accurate
>>> calculations will always be reflected in the test results. 😂
>>>>
>>>>>>>
>>>>>>> [1] https://github.com/kdlucas/byte-unixbench/tree/master
>>>>>>>
>>>>>>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>>>>>>> ---
>>>>>>>     include/linux/mm.h |  1 +
>>>>>>>     kernel/fork.c      | 34 ++++++++++++++++++++----------
>>>>>>>     mm/internal.h      |  3 ++-
>>>>>>>     mm/memory.c        |  7 ++++---
>>>>>>>     mm/mmap.c          | 52 ++++++++++++++++++++++++++++++++++++++++++++--
>>>>>>>     5 files changed, 80 insertions(+), 17 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>>>> index 1f1d0d6b8f20..10c59dc7ffaa 100644
>>>>>>> --- a/include/linux/mm.h
>>>>>>> +++ b/include/linux/mm.h
>>>>>>> @@ -3242,6 +3242,7 @@ extern void unlink_file_vma(struct vm_area_struct *);
>>>>>>>     extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
>>>>>>>     	unsigned long addr, unsigned long len, pgoff_t pgoff,
>>>>>>>     	bool *need_rmap_locks);
>>>>>>> +extern void undo_dup_mmap(struct mm_struct *mm, struct vm_area_struct *vma_end);
>>>>>>>     extern void exit_mmap(struct mm_struct *);
>>>>>>>     static inline int check_data_rlimit(unsigned long rlim,
>>>>>>> diff --git a/kernel/fork.c b/kernel/fork.c
>>>>>>> index 7ae36c2e7290..2f3d83e89fe6 100644
>>>>>>> --- a/kernel/fork.c
>>>>>>> +++ b/kernel/fork.c
>>>>>>> @@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>>>>>>     	int retval;
>>>>>>>     	unsigned long charge = 0;
>>>>>>>     	LIST_HEAD(uf);
>>>>>>> -	VMA_ITERATOR(old_vmi, oldmm, 0);
>>>>>>>     	VMA_ITERATOR(vmi, mm, 0);
>>>>>>>     	uprobe_start_dup_mmap();
>>>>>>> @@ -678,16 +677,25 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>>>>>>     		goto out;
>>>>>>>     	khugepaged_fork(mm, oldmm);
>>>>>>> -	retval = vma_iter_bulk_alloc(&vmi, oldmm->map_count);
>>>>>>> -	if (retval)
>>>>>>> +	/* Use __mt_dup() to efficiently build an identical maple tree. */
>>>>>>> +	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
>>>>>>> +	if (unlikely(retval))
>>>>>>>     		goto out;
>>>>>>>     	mt_clear_in_rcu(vmi.mas.tree);
>>>>>>> -	for_each_vma(old_vmi, mpnt) {
>>>>>>> +	for_each_vma(vmi, mpnt) {
>>>>>>>     		struct file *file;
>>>>>>>     		vma_start_write(mpnt);
>>>>>>>     		if (mpnt->vm_flags & VM_DONTCOPY) {
>>>>>>> +			mas_store_gfp(&vmi.mas, NULL, GFP_KERNEL);
>>>>>>> +
>>>>>>> +			/* If failed, undo all completed duplications. */
>>>>>>> +			if (unlikely(mas_is_err(&vmi.mas))) {
>>>>>>> +				retval = xa_err(vmi.mas.node);
>>>>>>> +				goto loop_out;
>>>>>>> +			}
>>>>>>> +
>>>>>>>     			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
>>>>>>>     			continue;
>>>>>>>     		}
>>>>>>> @@ -749,9 +757,11 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>>>>>>     		if (is_vm_hugetlb_page(tmp))
>>>>>>>     			hugetlb_dup_vma_private(tmp);
>>>>>>> -		/* Link the vma into the MT */
>>>>>>> -		if (vma_iter_bulk_store(&vmi, tmp))
>>>>>>> -			goto fail_nomem_vmi_store;
>>>>>>> +		/*
>>>>>>> +		 * Link the vma into the MT. After using __mt_dup(), memory
>>>>>>> +		 * allocation is not necessary here, so it cannot fail.
>>>>>>> +		 */
>>>>>>> +		mas_store(&vmi.mas, tmp);
>>>>>>>     		mm->map_count++;
>>>>>>>     		if (!(tmp->vm_flags & VM_WIPEONFORK))
>>>>>>> @@ -760,15 +770,19 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>>>>>>     		if (tmp->vm_ops && tmp->vm_ops->open)
>>>>>>>     			tmp->vm_ops->open(tmp);
>>>>>>> -		if (retval)
>>>>>>> +		if (retval) {
>>>>>>> +			mpnt = vma_next(&vmi);
>>>>>>>     			goto loop_out;
>>>>>>> +		}
>>>>>>>     	}
>>>>>>>     	/* a new mm has just been created */
>>>>>>>     	retval = arch_dup_mmap(oldmm, mm);
>>>>>>>     loop_out:
>>>>>>>     	vma_iter_free(&vmi);
>>>>>>> -	if (!retval)
>>>>>>> +	if (likely(!retval))
>>>>>>>     		mt_set_in_rcu(vmi.mas.tree);
>>>>>>> +	else
>>>>>>> +		undo_dup_mmap(mm, mpnt);
>>>>>>>     out:
>>>>>>>     	mmap_write_unlock(mm);
>>>>>>>     	flush_tlb_mm(oldmm);
>>>>>>> @@ -778,8 +792,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>>>>>>     	uprobe_end_dup_mmap();
>>>>>>>     	return retval;
>>>>>>> -fail_nomem_vmi_store:
>>>>>>> -	unlink_anon_vmas(tmp);
>>>>>>>     fail_nomem_anon_vma_fork:
>>>>>>>     	mpol_put(vma_policy(tmp));
>>>>>>>     fail_nomem_policy:
>>>>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>>>>> index 7a961d12b088..288ec81770cb 100644
>>>>>>> --- a/mm/internal.h
>>>>>>> +++ b/mm/internal.h
>>>>>>> @@ -111,7 +111,8 @@ void folio_activate(struct folio *folio);
>>>>>>>     void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>>>>>>>     		   struct vm_area_struct *start_vma, unsigned long floor,
>>>>>>> -		   unsigned long ceiling, bool mm_wr_locked);
>>>>>>> +		   unsigned long ceiling, unsigned long tree_end,
>>>>>>> +		   bool mm_wr_locked);
>>>>>>>     void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
>>>>>>>     struct zap_details;
>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>>> index 983a40f8ee62..1fd66a0d5838 100644
>>>>>>> --- a/mm/memory.c
>>>>>>> +++ b/mm/memory.c
>>>>>>> @@ -362,7 +362,8 @@ void free_pgd_range(struct mmu_gather *tlb,
>>>>>>>     void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>>>>>>>     		   struct vm_area_struct *vma, unsigned long floor,
>>>>>>> -		   unsigned long ceiling, bool mm_wr_locked)
>>>>>>> +		   unsigned long ceiling, unsigned long tree_end,
>>>>>>> +		   bool mm_wr_locked)
>>>>>>>     {
>>>>>>>     	do {
>>>>>>>     		unsigned long addr = vma->vm_start;
>>>>>>> @@ -372,7 +373,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>>>>>>>     		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and may
>>>>>>>     		 * be 0.  This will underflow and is okay.
>>>>>>>     		 */
>>>>>>> -		next = mas_find(mas, ceiling - 1);
>>>>>>> +		next = mas_find(mas, tree_end - 1);
>>>>>>>     		/*
>>>>>>>     		 * Hide vma from rmap and truncate_pagecache before freeing
>>>>>>> @@ -393,7 +394,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>>>>>>>     			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
>>>>>>>     			       && !is_vm_hugetlb_page(next)) {
>>>>>>>     				vma = next;
>>>>>>> -				next = mas_find(mas, ceiling - 1);
>>>>>>> +				next = mas_find(mas, tree_end - 1);
>>>>>>>     				if (mm_wr_locked)
>>>>>>>     					vma_start_write(vma);
>>>>>>>     				unlink_anon_vmas(vma);
>>>>>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>>>>>> index 2ad950f773e4..daed3b423124 100644
>>>>>>> --- a/mm/mmap.c
>>>>>>> +++ b/mm/mmap.c
>>>>>>> @@ -2312,7 +2312,7 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
>>>>>>>     	mas_set(mas, mt_start);
>>>>>>>     	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
>>>>>>>     				 next ? next->vm_start : USER_PGTABLES_CEILING,
>>>>>>> -				 mm_wr_locked);
>>>>>>> +				 tree_end, mm_wr_locked);
>>>>>>>     	tlb_finish_mmu(&tlb);
>>>>>>>     }
>>>>>>> @@ -3178,6 +3178,54 @@ int vm_brk(unsigned long addr, unsigned long len)
>>>>>>>     }
>>>>>>>     EXPORT_SYMBOL(vm_brk);
>>>>>>> +void undo_dup_mmap(struct mm_struct *mm, struct vm_area_struct *vma_end)
>>>>>>> +{
>>>>>>> +	unsigned long tree_end;
>>>>>>> +	VMA_ITERATOR(vmi, mm, 0);
>>>>>>> +	struct vm_area_struct *vma;
>>>>>>> +	unsigned long nr_accounted = 0;
>>>>>>> +	int count = 0;
>>>>>>> +
>>>>>>> +	/*
>>>>>>> +	 * vma_end points to the first VMA that has not been duplicated. We need
>>>>>>> +	 * to unmap all VMAs before it.
>>>>>>> +	 * If vma_end is NULL, it means that all VMAs in the maple tree have
>>>>>>> +	 * been duplicated, so setting tree_end to 0 will overflow to ULONG_MAX
>>>>>>> +	 * when using it.
>>>>>>> +	 */
>>>>>>> +	if (vma_end) {
>>>>>>> +		tree_end = vma_end->vm_start;
>>>>>>> +		if (tree_end == 0)
>>>>>>> +			goto destroy;
>>>>>>> +	} else
>>>>>>> +		tree_end = 0;
>>
>> You need to enclose this statement to meet the coding style.  You could
>> just set tree_end = 0 at the start of the function instead, actually I
>> think tree_end = USER_PGTABLES_CEILING unless there is a vma_end.
>>
>>>>>>> +
>>>>>>> +	vma = mas_find(&vmi.mas, tree_end - 1);
>>
>> vma = vma_find(&vmi, tree_end);
>>
>>>>>>> +
>>>>>>> +	if (vma) {
>>
>> Probably would be cleaner to jump to destroy here too:
>> if (!vma)
>> 	goto destroy;
>>
>>>>>>> +		arch_unmap(mm, vma->vm_start, tree_end);
> 
> One more thing, it seems the maple state that is passed into
> unmap_region() needs to point to the _next_ element, or the reset
> doesn't work right between the unmap_vmas() and free_pgtables() call:
> 
> vma_iter_set(&vmi, vma->vm_end);
Thank you, this is indeed an issue, it's surprising that it wasn't
detected during testing.
> 
> 
>>>>>>> +		unmap_region(mm, &vmi.mas, vma, NULL, NULL, 0, tree_end,
>>>>>>> +			     tree_end, true);
>>>>>>
>>>>>> next is vma_end, as per your comment above.  Using next = vma_end allows
>>>>>> you to avoid adding another argument to free_pgtables().
>>>>> Unfortunately, it cannot be done this way. I fell into this trap before,
>>>>> and it caused incomplete page table cleanup. To solve this problem, the
>>>>> only solution I can think of right now is to add an additional
>>>>> parameter.
>>>>>
>>>>> free_pgtables() will be called in unmap_region() to free the page table,
>>>>> like this:
>>>>>
>>>>> free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
>>>>> 		next ? next->vm_start : USER_PGTABLES_CEILING,
>>>>> 		mm_wr_locked);
>>>>>
>>>>> The problem is with 'next'. Our 'vma_end' does not exist in the actual
>>>>> mmap because it has not been duplicated and cannot be used as 'next'.
>>>>> If there is a real 'next', we can use 'next->vm_start' as the ceiling,
>>>>> which is not a problem. If there is no 'next' (next is 'vma_end'), we
>>>>> can only use 'USER_PGTABLES_CEILING' as the ceiling. Using
>>>>> 'vma_end->vm_start' as the ceiling will cause the page table not to be
>>>>> fully freed, which may be related to alignment in 'free_pgd_range()'. To
>>>>> solve this problem, we have to introduce 'tree_end', and separating
>>>>> 'tree_end' and 'ceiling' can solve this problem.
>>>>
>>>> Can you just use ceiling?  That is, just not pass in next and keep the
>>>> code as-is?  This is how exit_mmap() does it and should avoid any
>>>> alignment issues.  I assume you tried that and something went wrong as
>>>> well?
>>> I tried that, but it didn't work either. In free_pgtables(), the
>>> following line of code is used to iterate over VMAs:
>>> mas_find(mas, ceiling - 1);
>>> If next is passed as NULL, ceiling will be 0, resulting in iterating
>>> over all the VMAs in the maple tree, including the last portion that was
>>> not duplicated.
>>
>> If vma_end is NULL, it means that all VMAs in the maple tree have been
>> duplicated, so shouldn't the correct action in this case be freeing up
>> to ceiling?
>>
>> If it isn't null, then vma_end->vm_start should work as the end of the
>> area to free.
>>
>> With your mas_find(mas, tree_end - 1), then the vma_end will be avoided,
>> but free_pgd_range() will use ceiling anyways:
>>
>> free_pgd_range(tlb, addr, vma->vm_end, floor, next ? next->vm_start : ceiling);
>>
>> Passing in vma_end as next to unmap_region() functions in my testing
>> without adding arguments to free_pgtables().
>>
>> How are you producing the accounting issue you mention above?  Maybe I
>> missed something?
>>
>>
>>>>
>>>>>
>>>>>>
>>>>>>> +
>>>>>>> +		mas_set(&vmi.mas, vma->vm_end);
>> vma_iter_set(&vmi, vma->vm_end);
>>>>>>> +		do {
>>>>>>> +			if (vma->vm_flags & VM_ACCOUNT)
>>>>>>> +				nr_accounted += vma_pages(vma);
>>>>>>> +			remove_vma(vma, true);
>>>>>>> +			count++;
>>>>>>> +			cond_resched();
>>>>>>> +			vma = mas_find(&vmi.mas, tree_end - 1);
>>>>>>> +		} while (vma != NULL);
>>
>> You can write this as:
>> do { ... } for_each_vma_range(vmi, vma, tree_end);
>>
>>>>>>> +
>>>>>>> +		BUG_ON(count != mm->map_count);
>>>>>>> +
>>>>>>> +		vm_unacct_memory(nr_accounted);
>>>>>>> +	}
>>>>>>> +
>>>>>>> +destroy:
>>>>>>> +	__mt_destroy(&mm->mm_mt);
>>>>>>> +}
>>>>>>> +
>>>>>>>     /* Release all mmaps. */
>>>>>>>     void exit_mmap(struct mm_struct *mm)
>>>>>>>     {
>>>>>>> @@ -3217,7 +3265,7 @@ void exit_mmap(struct mm_struct *mm)
>>>>>>>     	mt_clear_in_rcu(&mm->mm_mt);
>>>>>>>     	mas_set(&mas, vma->vm_end);
>>>>>>>     	free_pgtables(&tlb, &mas, vma, FIRST_USER_ADDRESS,
>>>>>>> -		      USER_PGTABLES_CEILING, true);
>>>>>>> +		      USER_PGTABLES_CEILING, USER_PGTABLES_CEILING, true);
>>>>>>>     	tlb_finish_mmu(&tlb);
>>>>>>>     	/*
>>>>>>> -- 
>>>>>>> 2.20.1
>>>>>>>
>>>>>>
>>>>>
>>>>
> 
