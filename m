Return-Path: <linux-fsdevel+bounces-55965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE70B11145
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 20:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581AC189C6C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 18:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02B82ECEAE;
	Thu, 24 Jul 2025 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb5RUaKE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36132741CE;
	Thu, 24 Jul 2025 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383461; cv=none; b=kYy4VNf4cEN30/yCaBm/d5UQVUd0eA3XDJtgvVgZL72Hf9nQwUKJObxQ5EFhVTbdQNAZQiErHO6+y/QA4ulA1J+5ltEuesyt7fZeSB6iARAgYA4pO3ycyZnSWH6MY07LPcIpEUOUVgpEVEqS1lJzbRvYie1xzy4iEUrSiQ/ecEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383461; c=relaxed/simple;
	bh=41W0hpiRoAM9UgSx72d8nY27C9tO6no9X/Ptee44Ql0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Py2QxBWNO45fKdJhCuG495H9TZz1aZgv4fSti3h392aeoEIcMzRzaRhG8iwQdFjPjOyKmMwbTt7j00isXM3BTskdt9libXMjqZ5J2qxm0mvDyrUgdnk3l+/weYrAl3L0wGUA3FM69sHvY/ppyJqhUsBEyV0SeiCqgcWQ+nazBgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb5RUaKE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45619d70c72so20917945e9.0;
        Thu, 24 Jul 2025 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753383457; x=1753988257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iv0+8TMRDjRcb8ybGvxWVsE501yeGF/k6V04AvLUUII=;
        b=Bb5RUaKEwrguIQkif+6UyuBMDvcKPkz839f7OOPlm2iS7fyOeWxHAXdCpe9TPMGp+u
         6uo0SD/ADnWi5v/QhDjcHhXBLuMk3di+LNNrkIqyUw+b+SqrDMAQYcYwwu/8ZO5cnLD2
         fmizPaGQrqIXBOWo1/0HRmHYMraPKjtSri5F+o1XqhK/R/qHAGTIVMaMD52sJskYsDiK
         IXr7049uKbZDanhc9AW4sBtmHkgcCijygxy9SryElC5u9vvFRc73aOahKaq+qO+gujq1
         7cLBoVZmYiFwroa9uABc9VH9BM0qVSo4ytZKh+K9GBWUjiF0pqG9QaswxTIhmY9dRXCi
         24Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753383457; x=1753988257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iv0+8TMRDjRcb8ybGvxWVsE501yeGF/k6V04AvLUUII=;
        b=A5/3zXdmM8/oHKrI53VdI+YiP8iThQlEGNK6kHaxbu+yGOxiP4davs2ri7mKnxj87u
         e64ukfYeaN8S1KPjk5GgAJfGKTJuN6Od20Eb3FYVS623Qee0GaWxADrRkgxiYgyocZGj
         IsW6I5oIsbZJ7WJ9kagsD3joULMmkFs8aMTEQw25QinZlb8ji4T/vtVQz0NWHbN0UyAi
         VhdRFw6ImIA49rdjh1dp0iW3d9FncNlfmxcJRS1DKoE9JypDY4QRF6366MTayzUK2YyP
         L5UaMAvuyxJ/4pFzolfo5RotHOERGbrmuTWR2/u4CXRN6uqWAmvgQlfCiHb5dtWPTwSD
         WAZw==
X-Forwarded-Encrypted: i=1; AJvYcCWRq8meUcrFc2jYm73tThkCxEYdULdoWuNr2k9d0lerhp8aUjgh3/+GyvUrzhqF9fMIATksuCSmaGmHsRnc@vger.kernel.org, AJvYcCWzY3wObjd8Wxy1v5YWKfRT0PZuCjqkax47GX9lCG80g9ANOyOENG7nXd2IPk5fhABUOwBWcffdtBY=@vger.kernel.org, AJvYcCXBa0tgwrZeCiGFicg65RN+kZQumpxyki+WOjorWD+7rgb5tqrmS2iP+Pb5IPke+G+Fk3uF6dtzSqDib7Bw6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmLY+XAVlcOBHnBj8e6/l5Q1OhSrUOMyH7ddb6FO7aE7jZz4BP
	ezk176Y3LC6kOosHw9dmzIy4UR0u7GRU8ShCnIfvvvOAwKwGFOg9I49r
X-Gm-Gg: ASbGncuKJ9JP7MhMeU2LHoAsLcqdJ+hXcHVeinki+SqFSlLbgFlacSFqf5K7H3Y2HW2
	bByFffCwX1jQx1vR9s685eBr0lfWG8EGc727wp8f2gnjwgnfuKycW5cG4OYmrW9IhdPfp8scD+F
	YcNXcDMysB1nZ6EV/hQx1MtJmyI3ixVq3rFduN7mNS9MWW19mtFM76xgI6jfupJN6XvH0435yPS
	wkcGG3DEFH2r/mVmR5fRr6lemYzEXpVfWXCCD95DXXRKZ0kNrYpK448bqPOrcfTEIWJ5iKBKq/k
	ob7hqH7CfhveK0AMQDC/tFq9cjq+2GcgwGpnCXcECUOiek42SBnUNSBRHdGVAbL35p3miRzyTDK
	vmQZITE4aBnhsWiHIFnwMMSj5fnWXgh/j9Fuz9wov0mvQ+JhTodtNoZpz3kfBqBm4bFanujGbzj
	NQD8m2Pg==
X-Google-Smtp-Source: AGHT+IGzehIpMIPRxdQDW9qcUj2ivjoOBXoHMhqzIsfwC1PF1DUdkFnWEY/UqnYXk+EkF9nwxxMdTA==
X-Received: by 2002:a05:600c:1550:b0:456:1122:8342 with SMTP id 5b1f17b1804b1-4587050d92cmr27385065e9.5.1753383456711;
        Thu, 24 Jul 2025 11:57:36 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::5:9230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705ce685sm28293435e9.30.2025.07.24.11.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 11:57:36 -0700 (PDT)
Message-ID: <3ec01250-0ff3-4d04-9009-7b85b6058e41@gmail.com>
Date: Thu, 24 Jul 2025 19:57:32 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH POC] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, SeongJae Park <sj@kernel.org>,
 Jann Horn <jannh@google.com>, Yafang Shao <laoar.shao@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250721090942.274650-1-david@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250721090942.274650-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/07/2025 10:09, David Hildenbrand wrote:
> People want to make use of more THPs, for example, moving from
> THP=never to THP=madvise, or from THP=madvise to THP=never.
> 
> While this is great news for every THP desperately waiting to get
> allocated out there, apparently there are some workloads that require a
> bit of care during that transition: once problems are detected, these
> workloads should be started with the old behavior, without making all
> other workloads on the system go back to the old behavior as well.
> 
> In essence, the following scenarios are imaginable:
> 
> (1) Switch from THP=none to THP=madvise or THP=always, but keep the old
>     behavior (no THP) for selected workloads.
> 
> (2) Stay at THP=none, but have "madvise" or "always" behavior for
>     selected workloads.
> 
> (3) Switch from THP=madvise to THP=always, but keep the old behavior
>     (THP only when advised) for selected workloads.
> 
> (4) Stay at THP=madvise, but have "always" behavior for selected
>     workloads.
> 
> In essence, (2) can be emulated through (1), by setting THP!=none while
> disabling THPs for all processes that don't want THPs. It requires
> configuring all workloads, but that is a user-space problem to sort out.
> 
> (4) can be emulated through (3) in a similar way.
> 
> Back when (1) was relevant in the past, as people started enabling THPs,
> we added PR_SET_THP_DISABLE, so relevant workloads that were not ready
> yet (i.e., used by Redis) were able to just disable THPs completely. Redis
> still implements the option to use this interface to disable THPs
> completely.
> 
> With PR_SET_THP_DISABLE, we added a way to force-disable THPs for a
> workload -- a process, including fork+exec'ed process hierarchy.
> That essentially made us support (1): simply disable THPs for all workloads
> that are not ready for THPs yet, while still enabling THPs system-wide.
> 
> The quest for handling (3) and (4) started, but current approaches
> (completely new prctl, options to set other policies per processm,
>  alternatives to prctl -- mctrl, cgroup handling) don't look particularly
> promising. Likely, the future will use bpf or something similar to
> implement better policies, in particular to also make better decisions
> about THP sizes to use, but this will certainly take a while as that work
> just started.
> 
> Long story short: a simple enable/disable is not really suitable for the
> future, so we're not willing to add completely new toggles.
> 
> While we could emulate (3)+(4) through (1)+(2) by simply disabling THPs
> completely for these processes, this scares many THPs in our system
> because they could no longer get allocated where they used to be allocated
> for: regions flagged as VM_HUGEPAGE. Apparently, that imposes a
> problem for relevant workloads, because "not THPs" is certainly worse
> than "THPs only when advised".
> 
> Could we simply relax PR_SET_THP_DISABLE, to "disable THPs unless not
> explicitly advised by the app through MAD_HUGEPAGE"? *maybe*, but this
> would change the documented semantics quite a bit, and the versatility
> to use it for debugging purposes, so I am not 100% sure that is what we
> want -- although it would certainly be much easier.
> 
> So instead, as an easy way forward for (3) and (4), an option to
> make PR_SET_THP_DISABLE disable *less* THPs for a process.
> 
> In essence, this patch:
> 
> (A) Adds PR_THP_DISABLE_EXCEPT_ADVISED, to be used as a flag in arg3
>     of prctl(PR_SET_THP_DISABLE) when disabling THPs (arg2 != 0).
> 
>     For now, arg3 was not allowed to be set (-EINVAL). Now it holds
>     flags.
> 
> (B) Makes prctl(PR_GET_THP_DISABLE) return 3 if
>     PR_THP_DISABLE_EXCEPT_ADVISED was set while disabling.
> 
>     For now, it would return 1 if THPs were disabled completely. Now
>     it essentially returns the set flags as well.
> 
> (C) Renames MMF_DISABLE_THP to MMF_DISABLE_THP_COMPLETELY, to express
>     the semantics clearly.
> 
>     Fortunately, there are only two instances outside of prctl() code.
> 
> (D) Adds MMF_DISABLE_THP_EXCEPT_ADVISED to express "no THP except for VMAs
>     with VM_HUGEPAGE" -- essentially "thp=madvise" behavior
> 
>     Fortunately, we only have to extend vma_thp_disabled().
> 
> (E) Indicates "THP_enabled: 0" in /proc/pid/status only if THPs are not
>     disabled completely
> 
>     Only indicating that THPs are disabled when they are really disabled
>     completely, not only partially.
> 
> The documented semantics in the man page for PR_SET_THP_DISABLE
> "is inherited by a child created via fork(2) and is preserved across
> execve(2)" is maintained. This behavior, for example, allows for
> disabling THPs for a workload through the launching process (e.g.,
> systemd where we fork() a helper process to then exec()).
> 
> There is currently not way to prevent that a process will not issue
> PR_SET_THP_DISABLE itself to re-enable THP. We could add a "seal" option
> to PR_SET_THP_DISABLE through another flag if ever required. The known
> users (such as redis) really use PR_SET_THP_DISABLE to disable THPs, so
> that is not added for now.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Yafang Shao <laoar.shao@gmail.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> ---
> 
> At first, I thought of "why not simply relax PR_SET_THP_DISABLE", but I
> think there might be real use cases where we want to disable any THPs --
> in particular also around debugging THP-related problems, and
> "THP=never" not meaning ... "never" anymore. PR_SET_THP_DISABLE will
> also block MADV_COLLAPSE, which can be very helpful. Of course, I thought
> of having a system-wide config to change PR_SET_THP_DISABLE behavior, but
> I just don't like the semantics.
> 
> "prctl: allow overriding system THP policy to always"[1] proposed
> "overriding policies to always", which is just the wrong way around: we
> should not add mechanisms to "enable more" when we already have an
> interface/mechanism to "disable" them (PR_SET_THP_DISABLE). It all gets
> weird otherwise.
> 
> "[PATCH 0/6] prctl: introduce PR_SET/GET_THP_POLICY"[2] proposed
> setting the default of the VM_HUGEPAGE, which is similarly the wrong way
> around I think now.
> 
> The proposals by Lorenzo to extend process_madvise()[3] and mctrl()[4]
> similarly were around the "default for VM_HUGEPAGE" idea, but after the
> discussion, I think we should better leave VM_HUGEPAGE untouched.
> 
> Happy to hear naming suggestions for "PR_THP_DISABLE_EXCEPT_ADVISED" where
> we essentially want to say "leave advised regions alone" -- "keep THP
> enabled for advised regions",
> 
> The only thing I really dislike about this is using another MMF_* flag,
> but well, no way around it -- and seems like we could easily support
> more than 32 if we want to, or storing this thp information elsewhere.
> 
> I think this here (modifying an existing toggle) is the only prctl()
> extension that we might be willing to accept. In general, I agree like
> most others, that prctl() is a very bad interface for that -- but
> PR_SET_THP_DISABLE is already there and is getting used.
> 
> Long-term, I think the answer will be something based on bpf[5]. Maybe
> in that context, I there could still be value in easily disabling THPs for
> selected workloads (esp. debugging purposes).
> 
> Jann raised valid concerns[6] about new flags that are persistent across
> exec[6]. As this here is a relaxation to existing PR_SET_THP_DISABLE I
> consider it having a similar security risk as our existing
> PR_SET_THP_DISABLE, but devil is in the detail.
> 
> This is *completely* untested and might be utterly broken. It merely
> serves as a PoC of what I think could be done. If this ever goes upstream,
> we need some kselftests for it, and extensive tests.
> 
> [1] https://lore.kernel.org/r/20250507141132.2773275-1-usamaarif642@gmail.com
> [2] https://lkml.kernel.org/r/20250515133519.2779639-2-usamaarif642@gmail.com
> [3] https://lore.kernel.org/r/cover.1747686021.git.lorenzo.stoakes@oracle.com
> [4] https://lkml.kernel.org/r/85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local
> [5] https://lkml.kernel.org/r/20250608073516.22415-1-laoar.shao@gmail.com
> [6] https://lore.kernel.org/r/CAG48ez3-7EnBVEjpdoW7z5K0hX41nLQN5Wb65Vg-1p8DdXRnjg@mail.gmail.com
> 
> ---
>  Documentation/filesystems/proc.rst |  5 +--
>  fs/proc/array.c                    |  2 +-
>  include/linux/huge_mm.h            | 20 ++++++++---
>  include/linux/mm_types.h           | 13 +++----
>  include/uapi/linux/prctl.h         |  7 ++++
>  kernel/sys.c                       | 58 +++++++++++++++++++++++-------
>  mm/khugepaged.c                    |  2 +-
>  7 files changed, 78 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 2971551b72353..915a3e44bc120 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -291,8 +291,9 @@ It's slow but very precise.
>   HugetlbPages                size of hugetlb memory portions
>   CoreDumping                 process's memory is currently being dumped
>                               (killing the process may lead to a corrupted core)
> - THP_enabled		     process is allowed to use THP (returns 0 when
> -			     PR_SET_THP_DISABLE is set on the process
> + THP_enabled                 process is allowed to use THP (returns 0 when
> +                             PR_SET_THP_DISABLE is set on the process to disable
> +                             THP completely, not just partially)
>   Threads                     number of threads
>   SigQ                        number of signals queued/max. number for queue
>   SigPnd                      bitmap of pending signals for the thread
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index d6a0369caa931..c4f91a784104f 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -422,7 +422,7 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
>  	bool thp_enabled = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE);
>  
>  	if (thp_enabled)
> -		thp_enabled = !test_bit(MMF_DISABLE_THP, &mm->flags);
> +		thp_enabled = !test_bit(MMF_DISABLE_THP_COMPLETELY, &mm->flags);
>  	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
>  }
>  
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index e0a27f80f390d..c4127104d9bc3 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -323,16 +323,26 @@ struct thpsize {
>  	(transparent_hugepage_flags &					\
>  	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
>  
> +/*
> + * Check whether THPs are explicitly disabled through madvise or prctl, or some
> + * architectures may disable THP for some mappings, for example, s390 kvm.
> + */
>  static inline bool vma_thp_disabled(struct vm_area_struct *vma,
>  		vm_flags_t vm_flags)
>  {
> +	/* Are THPs disabled for this VMA? */
> +	if (vm_flags & VM_NOHUGEPAGE)
> +		return true;
> +	/* Are THPs disabled for all VMAs in the whole process? */
> +	if (test_bit(MMF_DISABLE_THP_COMPLETELY, &vma->vm_mm->flags))
> +		return true;
>  	/*
> -	 * Explicitly disabled through madvise or prctl, or some
> -	 * architectures may disable THP for some mappings, for
> -	 * example, s390 kvm.
> +	 * Are THPs disabled only for VMAs where we didn't get an explicit
> +	 * advise to use them?
>  	 */
> -	return (vm_flags & VM_NOHUGEPAGE) ||
> -	       test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags);
> +	if (vm_flags & VM_HUGEPAGE)
> +		return false;
> +	return test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, &vma->vm_mm->flags);
>  }


Hi David,

Over here, with MMF_DISABLE_THP_EXCEPT_ADVISED, MADV_HUGEPAGE will succeed as vm_flags has
VM_HUGEPAGE set, but MADV_COLLAPSE will fail to give a hugepage (as VM_HUGEPAGE is not set
and MMF_DISABLE_THP_EXCEPT_ADVISED is set) which I feel might not be the right behaviour
as MADV_COLLAPSE is "advise" and the prctl flag is PR_THP_DISABLE_EXCEPT_ADVISED?

This will be checked in multiple places in madvise_collapse: thp_vma_allowable_order,
hugepage_vma_revalidate which calls thp_vma_allowable_order and hpage_collapse_scan_pmd
which also ends up calling hugepage_vma_revalidate. 

A hacky way would be to save and overwrite vma->vm_flags with VM_HUGEPAGE at the start of madvise_collapse
if VM_NOHUGEPAGE is not set, and reset vma->vm_flags to its original value at the end of madvise_collapse
(Not something I am recommending, just throwing it out there).

Another possibility is to pass the fact that you are in madvise_collapse to these functions 
as an argument, this might look ugly, although maybe not as ugly as hugepage_vma_revalidate
already has collapse control arg, so just need to take care of thp_vma_allowable_orders.

Any preference or better suggestions?

Thanks!
Usama


