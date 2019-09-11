Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4115BB049A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 21:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfIKTnE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 15:43:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45775 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbfIKTnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 15:43:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id r15so26744940qtn.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2019 12:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2ZFP/ET73683mUucItfq4m0bSDDy3ddeJPRfTUbNCzY=;
        b=F/E+pdbJUdtectzMGAX889EbfD+uvoPzdWknjWGrU2IW/P478uxNiNntIC52eaMqHI
         OikuFaF+/CXQ3+ggRtSe/VC7P7hjt/RxxD+1jGmM9aos260dY3y8bFYpWysulvGFvbKp
         wJTamap6WyoQnblbLcYiRFCf5ZjMyXLrw5KzQACIMvVJDqL8+m832uu5lHYCLHniK7Cq
         bCudo8I+6O0+Ss6FJX8SuP8jMh6NT2atv6chpB+NRsyBA7kdQ3EK2hxhFmvPLrNylaez
         2XzETAVZ2F2w/Bs0iqQ/KQpFO7tbZXsnck+yvBzRH/6tzcGe7rzBsyoLC+y3+nCDGF02
         kRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2ZFP/ET73683mUucItfq4m0bSDDy3ddeJPRfTUbNCzY=;
        b=uk5hip4C+Qbynq0kXFcQmY1KhED2IsjcsdSI7vIfhaBypgFg4dxfNp84wBcSNCNi7P
         VEFnZ3AkoxyEHwc+h0yeQck2Hmxqh/hCw/SRIhtvp3LyXO48b7qw+T206aNF2yYKk5Fg
         ffYAdF7TDL9HRVJ4TDRANxubQJ/M9WbeyUKCromqjgJr7bMn9AXcGVB9zRa7SVU6nenT
         fwK0cTsitsEnkOoc2eXgUQbYqJgxuCBnqzZ7QkPIXRT8B+ftLJ94EEFV6pHgoEXKwnFG
         iLDouMpua3u3Bd3DV5VEIjD4qqXYnrIXS+8s4+ZCyGTNrggJ/vyBB3zy9N8wIC11ufu2
         HVJQ==
X-Gm-Message-State: APjAAAUPOqrdzHQ24t+mxs6MvNPvUN7LyKOYeGQqde4m4gIC1hsDTiMT
        pZSgf6LsTQ4gUBcRhBZO5+SD3RRIk6s9WA==
X-Google-Smtp-Source: APXvYqyMP7XfaOeg5LLvUE/BNydmp/CtjUORRyf03puYgED/dSeKx2o6ASaMkBTNwu/NMrzFldyWog==
X-Received: by 2002:ac8:6704:: with SMTP id e4mr37307655qtp.244.1568230982535;
        Wed, 11 Sep 2019 12:43:02 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h27sm9858623qkl.75.2019.09.11.12.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 12:42:56 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 5/5] hugetlbfs: Limit wait time when trying to share huge
 PMD
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <1a8e6c0a-6ba6-d71f-974e-f8a9c623c25b@redhat.com>
Date:   Wed, 11 Sep 2019 15:42:54 -0400
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <70714929-2CE3-42F4-BD31-427077C9E24E@lca.pw>
References: <20190911150537.19527-1-longman@redhat.com>
 <20190911150537.19527-6-longman@redhat.com>
 <B97932F4-7A2D-4265-9BB2-BF6E19B45DB7@lca.pw>
 <1a8e6c0a-6ba6-d71f-974e-f8a9c623c25b@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 11, 2019, at 12:34 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> On 9/11/19 5:01 PM, Qian Cai wrote:
>>=20
>>> On Sep 11, 2019, at 11:05 AM, Waiman Long <longman@redhat.com> =
wrote:
>>>=20
>>> When allocating a large amount of static hugepages (~500-1500GB) on =
a
>>> system with large number of CPUs (4, 8 or even 16 sockets), =
performance
>>> degradation (random multi-second delays) was observed when thousands
>>> of processes are trying to fault in the data into the huge pages. =
The
>>> likelihood of the delay increases with the number of sockets and =
hence
>>> the CPUs a system has.  This only happens in the initial setup phase
>>> and will be gone after all the necessary data are faulted in.
>>>=20
>>> These random delays, however, are deemed unacceptable. The cause of
>>> that delay is the long wait time in acquiring the mmap_sem when =
trying
>>> to share the huge PMDs.
>>>=20
>>> To remove the unacceptable delays, we have to limit the amount of =
wait
>>> time on the mmap_sem. So the new down_write_timedlock() function is
>>> used to acquire the write lock on the mmap_sem with a timeout value =
of
>>> 10ms which should not cause a perceivable delay. If timeout happens,
>>> the task will abandon its effort to share the PMD and allocate its =
own
>>> copy instead.
>>>=20
>>> When too many timeouts happens (threshold currently set at 256), the
>>> system may be too large for PMD sharing to be useful without undue =
delay.
>>> So the sharing will be disabled in this case.
>>>=20
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>> include/linux/fs.h |  7 +++++++
>>> mm/hugetlb.c       | 24 +++++++++++++++++++++---
>>> 2 files changed, 28 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>> index 997a530ff4e9..e9d3ad465a6b 100644
>>> --- a/include/linux/fs.h
>>> +++ b/include/linux/fs.h
>>> @@ -40,6 +40,7 @@
>>> #include <linux/fs_types.h>
>>> #include <linux/build_bug.h>
>>> #include <linux/stddef.h>
>>> +#include <linux/ktime.h>
>>>=20
>>> #include <asm/byteorder.h>
>>> #include <uapi/linux/fs.h>
>>> @@ -519,6 +520,12 @@ static inline void i_mmap_lock_write(struct =
address_space *mapping)
>>> 	down_write(&mapping->i_mmap_rwsem);
>>> }
>>>=20
>>> +static inline bool i_mmap_timedlock_write(struct address_space =
*mapping,
>>> +					 ktime_t timeout)
>>> +{
>>> +	return down_write_timedlock(&mapping->i_mmap_rwsem, timeout);
>>> +}
>>> +
>>> static inline void i_mmap_unlock_write(struct address_space =
*mapping)
>>> {
>>> 	up_write(&mapping->i_mmap_rwsem);
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 6d7296dd11b8..445af661ae29 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -4750,6 +4750,8 @@ void =
adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>>> 	}
>>> }
>>>=20
>>> +#define PMD_SHARE_DISABLE_THRESHOLD	(1 << 8)
>>> +
>>> /*
>>> * Search for a shareable pmd page for hugetlb. In any case calls =
pmd_alloc()
>>> * and returns the corresponding pte. While this is not necessary for =
the
>>> @@ -4770,11 +4772,24 @@ pte_t *huge_pmd_share(struct mm_struct *mm, =
unsigned long addr, pud_t *pud)
>>> 	pte_t *spte =3D NULL;
>>> 	pte_t *pte;
>>> 	spinlock_t *ptl;
>>> +	static atomic_t timeout_cnt;
>>>=20
>>> -	if (!vma_shareable(vma, addr))
>>> -		return (pte_t *)pmd_alloc(mm, pud, addr);
>>> +	/*
>>> +	 * Don't share if it is not sharable or locking attempt timed =
out
>>> +	 * after 10ms. After 256 timeouts, PMD sharing will be =
permanently
>>> +	 * disabled as it is just too slow.
>> It looks like this kind of policy interacts with kernel debug options =
like KASAN (which is going to slow the system down
>> anyway) could introduce tricky issues due to different timings on a =
debug kernel.
>=20
> With respect to lockdep, down_write_timedlock() works like a trylock. =
So
> a lot of checking will be skipped. Also the lockdep code won't be run
> until the lock is acquired. So its execution time has no effect on the
> timeout.

No only lockdep, but also things like KASAN, debug_pagealloc, =
page_poison, kmemleak, debug
objects etc that  all going to slow down things in huge_pmd_share(), and =
make it tricky to get a
right timeout value for those debug kernels without changing the =
previous behavior.=
