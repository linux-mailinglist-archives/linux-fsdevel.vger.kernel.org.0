Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A70F6B0AE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 11:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfILJGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 05:06:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730327AbfILJGY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:06:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 882FB18C4272;
        Thu, 12 Sep 2019 09:06:23 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-238.rdu2.redhat.com [10.10.120.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B31CA600C4;
        Thu, 12 Sep 2019 09:06:18 +0000 (UTC)
Subject: Re: [PATCH 5/5] hugetlbfs: Limit wait time when trying to share huge
 PMD
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>
References: <20190911150537.19527-1-longman@redhat.com>
 <20190911150537.19527-6-longman@redhat.com>
 <ae7edcb8-74e5-037c-17e7-01b3cf9320af@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <b7d7d109-03cf-d750-3a56-a95837998372@redhat.com>
Date:   Thu, 12 Sep 2019 10:06:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ae7edcb8-74e5-037c-17e7-01b3cf9320af@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Thu, 12 Sep 2019 09:06:23 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/12/19 4:26 AM, Mike Kravetz wrote:
> On 9/11/19 8:05 AM, Waiman Long wrote:
>> When allocating a large amount of static hugepages (~500-1500GB) on a
>> system with large number of CPUs (4, 8 or even 16 sockets), performance
>> degradation (random multi-second delays) was observed when thousands
>> of processes are trying to fault in the data into the huge pages. The
>> likelihood of the delay increases with the number of sockets and hence
>> the CPUs a system has.  This only happens in the initial setup phase
>> and will be gone after all the necessary data are faulted in.
>>
>> These random delays, however, are deemed unacceptable. The cause of
>> that delay is the long wait time in acquiring the mmap_sem when trying
>> to share the huge PMDs.
>>
>> To remove the unacceptable delays, we have to limit the amount of wait
>> time on the mmap_sem. So the new down_write_timedlock() function is
>> used to acquire the write lock on the mmap_sem with a timeout value of
>> 10ms which should not cause a perceivable delay. If timeout happens,
>> the task will abandon its effort to share the PMD and allocate its own
>> copy instead.
>>
> <snip>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 6d7296dd11b8..445af661ae29 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -4750,6 +4750,8 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>>  	}
>>  }
>>  
>> +#define PMD_SHARE_DISABLE_THRESHOLD	(1 << 8)
>> +
>>  /*
>>   * Search for a shareable pmd page for hugetlb. In any case calls pmd_alloc()
>>   * and returns the corresponding pte. While this is not necessary for the
>> @@ -4770,11 +4772,24 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
>>  	pte_t *spte = NULL;
>>  	pte_t *pte;
>>  	spinlock_t *ptl;
>> +	static atomic_t timeout_cnt;
>>  
>> -	if (!vma_shareable(vma, addr))
>> -		return (pte_t *)pmd_alloc(mm, pud, addr);
>> +	/*
>> +	 * Don't share if it is not sharable or locking attempt timed out
>> +	 * after 10ms. After 256 timeouts, PMD sharing will be permanently
>> +	 * disabled as it is just too slow.
>> +	 */
>> +	if (!vma_shareable(vma, addr) ||
>> +	   (atomic_read(&timeout_cnt) >= PMD_SHARE_DISABLE_THRESHOLD))
>> +		goto out_no_share;
>> +
>> +	if (!i_mmap_timedlock_write(mapping, ms_to_ktime(10))) {
>> +		if (atomic_inc_return(&timeout_cnt) ==
>> +		    PMD_SHARE_DISABLE_THRESHOLD)
>> +			pr_info("Hugetlbfs PMD sharing disabled because of timeouts!\n");
>> +		goto out_no_share;
>> +	}
>>  
>> -	i_mmap_lock_write(mapping);
> All this got me wondering if we really need to take i_mmap_rwsem in write
> mode here.  We are not changing the tree, only traversing it looking for
> a suitable vma.
>
> Unless I am missing something, the hugetlb code only ever takes the semaphore
> in write mode; never read.  Could this have been the result of changing the
> tree semaphore to read/write?  Instead of analyzing all the code, the easiest
> and safest thing would have been to take all accesses in write mode.
>
> I can investigate more, but wanted to ask the question in case someone already
> knows.
>
> At one time, I thought it was safe to acquire the semaphore in read mode for
> huge_pmd_share, but write mode for huge_pmd_unshare.  See commit b43a99900559.
> This was reverted along with another patch for other reasons.
>
> If we change change from write to read mode, this may have significant impact
> on the stalls.

If we can take the rwsem in read mode, that should solve the problem
AFAICS. As I don't have a full understanding of the history of that
code, I didn't try to do that in my patch.

Cheers,
Longman

