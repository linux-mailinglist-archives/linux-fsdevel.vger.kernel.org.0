Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D45AFB01B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 18:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfIKQem (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 12:34:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbfIKQem (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:34:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C20FC8A218D;
        Wed, 11 Sep 2019 16:34:41 +0000 (UTC)
Received: from llong.remote.csb (ovpn-123-234.rdu2.redhat.com [10.10.123.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80D705C207;
        Wed, 11 Sep 2019 16:34:38 +0000 (UTC)
Subject: Re: [PATCH 5/5] hugetlbfs: Limit wait time when trying to share huge
 PMD
To:     Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>
References: <20190911150537.19527-1-longman@redhat.com>
 <20190911150537.19527-6-longman@redhat.com>
 <B97932F4-7A2D-4265-9BB2-BF6E19B45DB7@lca.pw>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1a8e6c0a-6ba6-d71f-974e-f8a9c623c25b@redhat.com>
Date:   Wed, 11 Sep 2019 17:34:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <B97932F4-7A2D-4265-9BB2-BF6E19B45DB7@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Wed, 11 Sep 2019 16:34:41 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/11/19 5:01 PM, Qian Cai wrote:
>
>> On Sep 11, 2019, at 11:05 AM, Waiman Long <longman@redhat.com> wrote:
>>
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
>> When too many timeouts happens (threshold currently set at 256), the
>> system may be too large for PMD sharing to be useful without undue delay.
>> So the sharing will be disabled in this case.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>> include/linux/fs.h |  7 +++++++
>> mm/hugetlb.c       | 24 +++++++++++++++++++++---
>> 2 files changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 997a530ff4e9..e9d3ad465a6b 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -40,6 +40,7 @@
>> #include <linux/fs_types.h>
>> #include <linux/build_bug.h>
>> #include <linux/stddef.h>
>> +#include <linux/ktime.h>
>>
>> #include <asm/byteorder.h>
>> #include <uapi/linux/fs.h>
>> @@ -519,6 +520,12 @@ static inline void i_mmap_lock_write(struct address_space *mapping)
>> 	down_write(&mapping->i_mmap_rwsem);
>> }
>>
>> +static inline bool i_mmap_timedlock_write(struct address_space *mapping,
>> +					 ktime_t timeout)
>> +{
>> +	return down_write_timedlock(&mapping->i_mmap_rwsem, timeout);
>> +}
>> +
>> static inline void i_mmap_unlock_write(struct address_space *mapping)
>> {
>> 	up_write(&mapping->i_mmap_rwsem);
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 6d7296dd11b8..445af661ae29 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -4750,6 +4750,8 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>> 	}
>> }
>>
>> +#define PMD_SHARE_DISABLE_THRESHOLD	(1 << 8)
>> +
>> /*
>>  * Search for a shareable pmd page for hugetlb. In any case calls pmd_alloc()
>>  * and returns the corresponding pte. While this is not necessary for the
>> @@ -4770,11 +4772,24 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
>> 	pte_t *spte = NULL;
>> 	pte_t *pte;
>> 	spinlock_t *ptl;
>> +	static atomic_t timeout_cnt;
>>
>> -	if (!vma_shareable(vma, addr))
>> -		return (pte_t *)pmd_alloc(mm, pud, addr);
>> +	/*
>> +	 * Don't share if it is not sharable or locking attempt timed out
>> +	 * after 10ms. After 256 timeouts, PMD sharing will be permanently
>> +	 * disabled as it is just too slow.
> It looks like this kind of policy interacts with kernel debug options like KASAN (which is going to slow the system down
> anyway) could introduce tricky issues due to different timings on a debug kernel.

With respect to lockdep, down_write_timedlock() works like a trylock. So
a lot of checking will be skipped. Also the lockdep code won't be run
until the lock is acquired. So its execution time has no effect on the
timeout.

Cheers,
Longman

