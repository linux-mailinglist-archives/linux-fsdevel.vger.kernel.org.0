Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED16B0555
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 23:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfIKV5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 17:57:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40663 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbfIKV5r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 17:57:47 -0400
Received: by mail-qt1-f193.google.com with SMTP id g4so27278649qtq.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2019 14:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BiFTutYwV7WV5DTyUFMki78gS/6bcfMhuRhUhPM02wk=;
        b=q0awtSEwQpMikevefu0T5iDrpyNVuEqLab3ASXSI3OPhsNK8YZrfg0yvG/pDMazPN6
         qSxV7yRyX3G2ls1linDGBO+564XnEKqw6m+bMPmKC9LLKr9osKpMSEndnySLnToSlTjI
         O0y5/ig/n+u+iqMPQN9IJgSZqbDqREvoECT7+j0s3weOgJr3Bnw2JtoT21ojnCztjZog
         YTDuU/lo9yxG4TFCQo6Yxnruh14FPxxC5nPAQoO3v+0UPfLJQDbj9dl+b43aU1KAfGub
         w/95lofeKUVDU5AzHzwQaO97cWZORANP/Mecsf8ih1MQN6aaaygGy+F33g8uKa1V8Avx
         ecfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BiFTutYwV7WV5DTyUFMki78gS/6bcfMhuRhUhPM02wk=;
        b=bUDPyKi56uoUz5ywaaMQjGBpWoUa6i7laE2FsdnnTbsnPiwPBqwjxqE6OnPVVr6XRA
         Oxw3i8jSToLU7Grgdspx/JDes0hhVRnwnL5enDmrGUT4jxj48UMKpnBA87nh3opF2c3+
         UVLZ0qbt14cI8utGZO10mgREnykUaY+yG7QZGxbZP+IW9rQjpnWZd83VnjqL8wLJhYGf
         +8TVTtNv8bHmqfzjf/mKs5IpEFmcov0LznOm6Rmt0MmNkQXOVaE/8TyySoG1wG47ZC9i
         zMC+eTpncUwpi9v4Hr2W4IrkOpLF5n+l5jlbv7If8lD0jYE25GoDOTfrCJ5pLmS6iSFP
         u2Fw==
X-Gm-Message-State: APjAAAXTsMJ9NSapuEahMV4WTx6fEYKRlLcgWtOyhIHPD9IBrFmaInw5
        ssFq6NikNmofbZNcPCMKcrynbQ==
X-Google-Smtp-Source: APXvYqyCWOJ3rjZ/V0ODkA3YcXn1qSynuCFqbmhNBntxeVQmYkQlLe7JfZdCiEET9EjhKsi3aTCWHQ==
X-Received: by 2002:ac8:2c86:: with SMTP id 6mr19594990qtw.113.1568239066370;
        Wed, 11 Sep 2019 14:57:46 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d134sm11584329qkg.133.2019.09.11.14.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 14:57:45 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 5/5] hugetlbfs: Limit wait time when trying to share huge
 PMD
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <211b144f-0e86-d891-e1ec-9879ceb53e36@redhat.com>
Date:   Wed, 11 Sep 2019 17:57:44 -0400
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B06C5D2C-94E2-4C25-AB16-DC96A0900015@lca.pw>
References: <20190911150537.19527-1-longman@redhat.com>
 <20190911150537.19527-6-longman@redhat.com>
 <B97932F4-7A2D-4265-9BB2-BF6E19B45DB7@lca.pw>
 <1a8e6c0a-6ba6-d71f-974e-f8a9c623c25b@redhat.com>
 <70714929-2CE3-42F4-BD31-427077C9E24E@lca.pw>
 <211b144f-0e86-d891-e1ec-9879ceb53e36@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 11, 2019, at 4:54 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> On 9/11/19 8:42 PM, Qian Cai wrote:
>>=20
>>> On Sep 11, 2019, at 12:34 PM, Waiman Long <longman@redhat.com> =
wrote:
>>>=20
>>> On 9/11/19 5:01 PM, Qian Cai wrote:
>>>>> On Sep 11, 2019, at 11:05 AM, Waiman Long <longman@redhat.com> =
wrote:
>>>>>=20
>>>>> When allocating a large amount of static hugepages (~500-1500GB) =
on a
>>>>> system with large number of CPUs (4, 8 or even 16 sockets), =
performance
>>>>> degradation (random multi-second delays) was observed when =
thousands
>>>>> of processes are trying to fault in the data into the huge pages. =
The
>>>>> likelihood of the delay increases with the number of sockets and =
hence
>>>>> the CPUs a system has.  This only happens in the initial setup =
phase
>>>>> and will be gone after all the necessary data are faulted in.
>>>>>=20
>>>>> These random delays, however, are deemed unacceptable. The cause =
of
>>>>> that delay is the long wait time in acquiring the mmap_sem when =
trying
>>>>> to share the huge PMDs.
>>>>>=20
>>>>> To remove the unacceptable delays, we have to limit the amount of =
wait
>>>>> time on the mmap_sem. So the new down_write_timedlock() function =
is
>>>>> used to acquire the write lock on the mmap_sem with a timeout =
value of
>>>>> 10ms which should not cause a perceivable delay. If timeout =
happens,
>>>>> the task will abandon its effort to share the PMD and allocate its =
own
>>>>> copy instead.
>>>>>=20
>>>>> When too many timeouts happens (threshold currently set at 256), =
the
>>>>> system may be too large for PMD sharing to be useful without undue =
delay.
>>>>> So the sharing will be disabled in this case.
>>>>>=20
>>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>>> ---
>>>>> include/linux/fs.h |  7 +++++++
>>>>> mm/hugetlb.c       | 24 +++++++++++++++++++++---
>>>>> 2 files changed, 28 insertions(+), 3 deletions(-)
>>>>>=20
>>>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>>>> index 997a530ff4e9..e9d3ad465a6b 100644
>>>>> --- a/include/linux/fs.h
>>>>> +++ b/include/linux/fs.h
>>>>> @@ -40,6 +40,7 @@
>>>>> #include <linux/fs_types.h>
>>>>> #include <linux/build_bug.h>
>>>>> #include <linux/stddef.h>
>>>>> +#include <linux/ktime.h>
>>>>>=20
>>>>> #include <asm/byteorder.h>
>>>>> #include <uapi/linux/fs.h>
>>>>> @@ -519,6 +520,12 @@ static inline void i_mmap_lock_write(struct =
address_space *mapping)
>>>>> 	down_write(&mapping->i_mmap_rwsem);
>>>>> }
>>>>>=20
>>>>> +static inline bool i_mmap_timedlock_write(struct address_space =
*mapping,
>>>>> +					 ktime_t timeout)
>>>>> +{
>>>>> +	return down_write_timedlock(&mapping->i_mmap_rwsem, timeout);
>>>>> +}
>>>>> +
>>>>> static inline void i_mmap_unlock_write(struct address_space =
*mapping)
>>>>> {
>>>>> 	up_write(&mapping->i_mmap_rwsem);
>>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>>> index 6d7296dd11b8..445af661ae29 100644
>>>>> --- a/mm/hugetlb.c
>>>>> +++ b/mm/hugetlb.c
>>>>> @@ -4750,6 +4750,8 @@ void =
adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>>>>> 	}
>>>>> }
>>>>>=20
>>>>> +#define PMD_SHARE_DISABLE_THRESHOLD	(1 << 8)
>>>>> +
>>>>> /*
>>>>> * Search for a shareable pmd page for hugetlb. In any case calls =
pmd_alloc()
>>>>> * and returns the corresponding pte. While this is not necessary =
for the
>>>>> @@ -4770,11 +4772,24 @@ pte_t *huge_pmd_share(struct mm_struct =
*mm, unsigned long addr, pud_t *pud)
>>>>> 	pte_t *spte =3D NULL;
>>>>> 	pte_t *pte;
>>>>> 	spinlock_t *ptl;
>>>>> +	static atomic_t timeout_cnt;
>>>>>=20
>>>>> -	if (!vma_shareable(vma, addr))
>>>>> -		return (pte_t *)pmd_alloc(mm, pud, addr);
>>>>> +	/*
>>>>> +	 * Don't share if it is not sharable or locking attempt timed =
out
>>>>> +	 * after 10ms. After 256 timeouts, PMD sharing will be =
permanently
>>>>> +	 * disabled as it is just too slow.
>>>> It looks like this kind of policy interacts with kernel debug =
options like KASAN (which is going to slow the system down
>>>> anyway) could introduce tricky issues due to different timings on a =
debug kernel.
>>> With respect to lockdep, down_write_timedlock() works like a =
trylock. So
>>> a lot of checking will be skipped. Also the lockdep code won't be =
run
>>> until the lock is acquired. So its execution time has no effect on =
the
>>> timeout.
>> No only lockdep, but also things like KASAN, debug_pagealloc, =
page_poison, kmemleak, debug
>> objects etc that  all going to slow down things in huge_pmd_share(), =
and make it tricky to get a
>> right timeout value for those debug kernels without changing the =
previous behavior.
>=20
> Right, I understand that. I will move to use a sysctl parameters for =
the
> timeout and then set its default value to either 10ms or 20ms if some
> debug options are detected. Usually the slower than should not be more
> than 2X.

That 2X is another magic number which has no testing data back for it. =
We need a way to disable timeout
completely in Kconfig, so it can ship in the part of a debug kernel =
package.


