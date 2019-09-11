Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5C42B00B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 18:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfIKQBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 12:01:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33365 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbfIKQBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:01:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id r5so25909156qtd.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2019 09:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SzFYnOnqYRRD6oxfohm7GaTRApau1VSO8et7sdvAxw4=;
        b=fP8AO1YEJfmo1iSSlsVCCw128xF/ewA8VemLrD++gV3EuoRdYfWj5LGmMLdu19lK4s
         9zlJY92ZHUnz8AH9KmdUzzjMuRJkhMtseQEihRbLApkujfj9Oacj8sSEv0S9bp5m5L2P
         0s0HfThhl6kHvvwdsCAzApVOD5G+ChCuptHjBZjkPs/npao4zDC+Uk+EQGQ7BXiP8NFk
         zZuMrvwi5ek2GUs/E7YBQJsP8kx9aDaANfBUgpE23o4kmuy2S/lBVl52ydKaTkzFcbvk
         cnNRSTf2/N88bVMUqK/e3TinHy4A7UR1PGtMx2yWphZeeekzfos9ZbSMyrUX84rCLBNX
         16rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SzFYnOnqYRRD6oxfohm7GaTRApau1VSO8et7sdvAxw4=;
        b=ErsqlTMUuvMgvasXPHM5maosGEezPSNIZcPEWZSkEjI+9ydjjjcuF9cu37//s5KbJ6
         j7TZmJV1FZNU4J+DLwQyzJkOAbElJEbyF2Nwf/2YXsCc/xO+TAmqI4KOdYQi8sxC7I2G
         9zKwVRqe02LrOjT4tjxsL7QTj6aMINp9gbmv7FZYcwPjJ7dxBmB7UKO8RcHtojFNHI9b
         K4UZhwVIaAtoCq64WhZuVrFr5eAk9Q/9i4K3ODFcdRKHKXrj3ZeVePQFE/HNsYBGnD22
         MEBywJo+hZUXSck5gEzAURfnxoJbXhtKLBrjE06zcqLt4gxUYIhaTvXU3Ca0eKBKONk3
         sQXg==
X-Gm-Message-State: APjAAAVc9HJTYabL6li5IMMmmCqTEJ6BVWtP/YNASOzJ4aaUOhOrbUSr
        u+dRO4KM5PKx7KCxGQCwk707Fg==
X-Google-Smtp-Source: APXvYqyPRa3MTbsa/Kmfswg0Bvkx67oWrfiDmXUWdRKwYuZ+uMqrlFSoglXlepuG5gVaVEYCQcG8yg==
X-Received: by 2002:ac8:546:: with SMTP id c6mr11563196qth.151.1568217704576;
        Wed, 11 Sep 2019 09:01:44 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l22sm8529363qtp.8.2019.09.11.09.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 09:01:44 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 5/5] hugetlbfs: Limit wait time when trying to share huge
 PMD
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190911150537.19527-6-longman@redhat.com>
Date:   Wed, 11 Sep 2019 12:01:42 -0400
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B97932F4-7A2D-4265-9BB2-BF6E19B45DB7@lca.pw>
References: <20190911150537.19527-1-longman@redhat.com>
 <20190911150537.19527-6-longman@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 11, 2019, at 11:05 AM, Waiman Long <longman@redhat.com> wrote:
>=20
> When allocating a large amount of static hugepages (~500-1500GB) on a
> system with large number of CPUs (4, 8 or even 16 sockets), =
performance
> degradation (random multi-second delays) was observed when thousands
> of processes are trying to fault in the data into the huge pages. The
> likelihood of the delay increases with the number of sockets and hence
> the CPUs a system has.  This only happens in the initial setup phase
> and will be gone after all the necessary data are faulted in.
>=20
> These random delays, however, are deemed unacceptable. The cause of
> that delay is the long wait time in acquiring the mmap_sem when trying
> to share the huge PMDs.
>=20
> To remove the unacceptable delays, we have to limit the amount of wait
> time on the mmap_sem. So the new down_write_timedlock() function is
> used to acquire the write lock on the mmap_sem with a timeout value of
> 10ms which should not cause a perceivable delay. If timeout happens,
> the task will abandon its effort to share the PMD and allocate its own
> copy instead.
>=20
> When too many timeouts happens (threshold currently set at 256), the
> system may be too large for PMD sharing to be useful without undue =
delay.
> So the sharing will be disabled in this case.
>=20
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
> include/linux/fs.h |  7 +++++++
> mm/hugetlb.c       | 24 +++++++++++++++++++++---
> 2 files changed, 28 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 997a530ff4e9..e9d3ad465a6b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -40,6 +40,7 @@
> #include <linux/fs_types.h>
> #include <linux/build_bug.h>
> #include <linux/stddef.h>
> +#include <linux/ktime.h>
>=20
> #include <asm/byteorder.h>
> #include <uapi/linux/fs.h>
> @@ -519,6 +520,12 @@ static inline void i_mmap_lock_write(struct =
address_space *mapping)
> 	down_write(&mapping->i_mmap_rwsem);
> }
>=20
> +static inline bool i_mmap_timedlock_write(struct address_space =
*mapping,
> +					 ktime_t timeout)
> +{
> +	return down_write_timedlock(&mapping->i_mmap_rwsem, timeout);
> +}
> +
> static inline void i_mmap_unlock_write(struct address_space *mapping)
> {
> 	up_write(&mapping->i_mmap_rwsem);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6d7296dd11b8..445af661ae29 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4750,6 +4750,8 @@ void adjust_range_if_pmd_sharing_possible(struct =
vm_area_struct *vma,
> 	}
> }
>=20
> +#define PMD_SHARE_DISABLE_THRESHOLD	(1 << 8)
> +
> /*
>  * Search for a shareable pmd page for hugetlb. In any case calls =
pmd_alloc()
>  * and returns the corresponding pte. While this is not necessary for =
the
> @@ -4770,11 +4772,24 @@ pte_t *huge_pmd_share(struct mm_struct *mm, =
unsigned long addr, pud_t *pud)
> 	pte_t *spte =3D NULL;
> 	pte_t *pte;
> 	spinlock_t *ptl;
> +	static atomic_t timeout_cnt;
>=20
> -	if (!vma_shareable(vma, addr))
> -		return (pte_t *)pmd_alloc(mm, pud, addr);
> +	/*
> +	 * Don't share if it is not sharable or locking attempt timed =
out
> +	 * after 10ms. After 256 timeouts, PMD sharing will be =
permanently
> +	 * disabled as it is just too slow.

It looks like this kind of policy interacts with kernel debug options =
like KASAN (which is going to slow the system down
anyway) could introduce tricky issues due to different timings on a =
debug kernel.

> +	 */
> +	if (!vma_shareable(vma, addr) ||
> +	   (atomic_read(&timeout_cnt) >=3D PMD_SHARE_DISABLE_THRESHOLD))
> +		goto out_no_share;
> +
> +	if (!i_mmap_timedlock_write(mapping, ms_to_ktime(10))) {
> +		if (atomic_inc_return(&timeout_cnt) =3D=3D
> +		    PMD_SHARE_DISABLE_THRESHOLD)
> +			pr_info("Hugetlbfs PMD sharing disabled because =
of timeouts!\n");
> +		goto out_no_share;
> +	}
>=20
> -	i_mmap_lock_write(mapping);
> 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
> 		if (svma =3D=3D vma)
> 			continue;
> @@ -4806,6 +4821,9 @@ pte_t *huge_pmd_share(struct mm_struct *mm, =
unsigned long addr, pud_t *pud)
> 	pte =3D (pte_t *)pmd_alloc(mm, pud, addr);
> 	i_mmap_unlock_write(mapping);
> 	return pte;
> +
> +out_no_share:
> +	return (pte_t *)pmd_alloc(mm, pud, addr);
> }
>=20
> /*
> --=20
> 2.18.1
>=20
>=20

