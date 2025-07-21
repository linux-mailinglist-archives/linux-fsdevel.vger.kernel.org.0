Return-Path: <linux-fsdevel+bounces-55603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9194B0C668
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 16:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCFF1AA62F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 14:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E721B87F2;
	Mon, 21 Jul 2025 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyKEbm8x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BBB15748F;
	Mon, 21 Jul 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108363; cv=none; b=MqaSd9R/Mx9q+BaUjSzl9d1xGQ+aDrH8h2rAdtg1Dlmf8KnCGCZ0abvHusVAd/Yuwv0ywZjWqmScKj4euNQWGTtIyf1lfYk45bUxjnuw1LAx19N4mrUPiry/7HSIveJwdFSgPgkwP6HLZoWVu7F6OCFts2SSj2VL6S+O94EXaoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108363; c=relaxed/simple;
	bh=Bmdat96LiQUk1B/BRPa997UJAFHNzmBEDWZgvD5DnMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0wBhPQgjRheycAu8DmTTr0r0gvc66cYTb67mW/7V/w3sqUL1dmY2PqNAl30Y8pbIpAnU/TjeacxDOtbA57uRM/h1UgMcx3Em30Xvzffi87wMhNZGUtRyimaVjK6V50v/DQKIMGnd4EswbHJqQSMGvylqjKGNcYF6fRRzTJsaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyKEbm8x; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso1000401066b.0;
        Mon, 21 Jul 2025 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753108359; x=1753713159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ZyFvS81aM0m2BitG2602WE9RizHNryvEDg5/uTy6bk=;
        b=kyKEbm8xRV03wWC0goBhSs3FHP0TCZ8djro6+2NFGcW3PR6vR0YEr9SzJfM1CEuFM+
         8Rcd9uv/zoarJ2qJ8mjxorHbfeORTYurc7gnMcLx35ggrFqeHytlL9Nz85aYZ4ykZQEM
         ojeRG2tGvF+pDlY3/F/sd7zbbYSlqFHNT4rlyOhs50phNLaPI3eBD9wIZsLn/r04rTj1
         xKdwxwCDkElnHUzpXv8GreGiojbb/gPIj1OanwgwUif/MYL0GawE5/mZX1ZImqlvpyru
         aqnmn1Gj6AFtoq05wc+q9p3ETZW9xoRAE0hir+5xSwU6mvV1azhdZFVdFVKn9V63i/es
         juGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753108359; x=1753713159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZyFvS81aM0m2BitG2602WE9RizHNryvEDg5/uTy6bk=;
        b=kUbVCC9myB1QrXnFUkEcEYJoCC8ry7j5KhQBo1Qd3bQYaYM7ZjVa/+ijfb/YEe1XK0
         JCiOfd4Y15t2KBll1k4sYS0zC/uc1KQusMWFI1XkH5gTHveY4Jtjo1hyWVuquFR5hne5
         XS/mTas0dsYb5oLHPyTbEd5ax1oUbhpvQ2dPcNyaMnxeE2x5pU9zEM8YSWNntvneXAFV
         JjJUPV6tQnOPVrOJtb6+CVfCeNJE+zyHhOBvbLaBcffgJpZRldLShbGvRvf1jz6hlH9q
         sDf96ilgHEWI/HHX9pVdP9NEyRyeoUQ1b7Fuun/dUs8v2M6oYzyk8UXf840kGLe2h6XX
         xatg==
X-Forwarded-Encrypted: i=1; AJvYcCU2OaQ46o9ikEFHrWVOyAMjh9EQbPJLqvz4k2mfHIbHKZ3UNj+8bQZgOf7tkUEDPxI7yYWdXv2S5kY=@vger.kernel.org, AJvYcCUhdzl/+Q1rsU9amaCl36Qk4otUe0hC2kOk7AHEuLmVL/7sgyfhKlRtLLkmzp9zRUJAu5H4ARrh2oO1lWiV@vger.kernel.org, AJvYcCWzdts3Yn5Ph1tYgnSp6toU+tcKWEs/o4Tnm5UAZNjfF9fcgBmV425TR/EHvRsiWISTI/0kkLUUrPMh8A0T1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm0yYknCfwO4i2Tmr1GV6FOZYxuk4IgVWvJ4dpUrMFpntnWy7F
	OmpIUw/i2b1mFNBalMHsAJ+BFC5nYjw9w1X/DzMrEJzx8jNudJ2lZVsu
X-Gm-Gg: ASbGnctB6mBd0oyO82lSswh58CifzF9o15PQenfHuXwr9c022e6ZkEkFHXcpsEGY8Ch
	+1V7/BgDfIL8pOfbZ3C0k1GfufUg8DVmYHcEHvzmTKeOkxWpL882sQrGRBBrNq9PLAnDTkQQ1bf
	BGUep8mRgE8KlotRohL2AY9QAyk6SgKuvM5n2/FcroX5Cv4RFR1ukGhohR9k/JyeBdaVXG3LNC4
	IyiMNaOZyvr66pQa61FaHbzES6qgLsrKALsCqySR0Ub6JVVIemzUw5Z8iPGfo8X4O7vVI17bReP
	pdoswEYbA8LhF4S4H3oWLfGd2cX7tDk6YTpXntcAfpsgeVRLiYFHI+rMSsq0/T/s+9pQA/4HdeS
	O9deI2zzeMQ4shFGP3+tLzEhQOwnFKV/yFAmcdlDfAij7oWM1zh0BH8uhZsOucVjqjr5T7yxgMM
	bMFO5m8A==
X-Google-Smtp-Source: AGHT+IE9TaBDlsLEh8LV2s6X3r4uriyB72tSI5rQQYZAV2sIxauOTbkGREgZpW4PUuy4XEROm2Pgjw==
X-Received: by 2002:a17:907:e2c7:b0:acb:37ae:619c with SMTP id a640c23a62f3a-aec4de62d50mr1585600266b.15.1753108358847;
        Mon, 21 Jul 2025 07:32:38 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::7:cc27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6cad0feasm684502466b.138.2025.07.21.07.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 07:32:38 -0700 (PDT)
Message-ID: <4d9d25b0-49ee-438d-8698-59c835506cbd@gmail.com>
Date: Mon, 21 Jul 2025 15:32:35 +0100
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
 Matthew Wilcox <willy@infradead.org>
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

No strong opinion, but maybe we have it return 2 (i.e. bit 1 set)?

I know that you are returning bit 1 set to indicate the flag, and I know that
everyone dislikes prctl so its likely no more flags will be added :),
but in the off chance there are extra flags, than it can make the return
value weird?
If instead we return a value with only a single bit set, might be better?

Again, no strong opinion here.

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
>  
>  static inline bool thp_disabled_by_hw(void)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 1ec273b066915..a999f2d352648 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1743,19 +1743,16 @@ enum {
>  #define MMF_VM_MERGEABLE	16	/* KSM may merge identical pages */
>  #define MMF_VM_HUGEPAGE		17	/* set when mm is available for khugepaged */
>  
> -/*
> - * This one-shot flag is dropped due to necessity of changing exe once again
> - * on NFS restore
> - */
> -//#define MMF_EXE_FILE_CHANGED	18	/* see prctl_set_mm_exe_file() */
> +#define MMF_HUGE_ZERO_PAGE	18      /* mm has ever used the global huge zero page */
>  
>  #define MMF_HAS_UPROBES		19	/* has uprobes */
>  #define MMF_RECALC_UPROBES	20	/* MMF_HAS_UPROBES can be wrong */
>  #define MMF_OOM_SKIP		21	/* mm is of no interest for the OOM killer */
>  #define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
> -#define MMF_HUGE_ZERO_PAGE	23      /* mm has ever used the global huge zero page */
> -#define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
> -#define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
> +#define MMF_DISABLE_THP_EXCEPT_ADVISED	23	/* no THP except for VMAs with VM_HUGEPAGE */
> +#define MMF_DISABLE_THP_COMPLETELY	24	/* no THP for all VMAs */
> +#define MMF_DISABLE_THP_MASK	((1 << MMF_DISABLE_THP_COMPLETELY) |\
> +				 (1 << MMF_DISABLE_THP_EXCEPT_ADVISED))
>  #define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
>  #define MMF_MULTIPROCESS	26	/* mm is shared between processes */
>  /*
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 43dec6eed559a..1949bb9270d48 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -177,7 +177,14 @@ struct prctl_mm_map {
>  
>  #define PR_GET_TID_ADDRESS	40
>  
> +/*
> + * Flags for PR_SET_THP_DISABLE are only applicable when disabling. Bit 0
> + * is reserved, so PR_GET_THP_DISABLE can return 1 when no other flags were
> + * specified for PR_SET_THP_DISABLE.
> + */
>  #define PR_SET_THP_DISABLE	41
> +/* Don't disable THPs when explicitly advised (MADV_HUGEPAGE / VM_HUGEPAGE). */
> +# define PR_THP_DISABLE_EXCEPT_ADVISED	(1 << 1)
>  #define PR_GET_THP_DISABLE	42
>  
>  /*
> diff --git a/kernel/sys.c b/kernel/sys.c
> index b153fb345ada2..2a34b2f708900 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2423,6 +2423,50 @@ static int prctl_get_auxv(void __user *addr, unsigned long len)
>  	return sizeof(mm->saved_auxv);
>  }
>  
> +static int prctl_get_thp_disable(unsigned long arg2, unsigned long arg3,
> +				 unsigned long arg4, unsigned long arg5)
> +{
> +	unsigned long *mm_flags = &current->mm->flags;
> +
> +	if (arg2 || arg3 || arg4 || arg5)
> +		return -EINVAL;
> +
> +	if (test_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags))
> +		return 1;
> +	else if (test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags))
> +		return 1 | PR_THP_DISABLE_EXCEPT_ADVISED;
> +	return 0;
> +}
> +
> +static int prctl_set_thp_disable(unsigned long thp_disable, unsigned long flags,
> +				 unsigned long arg4, unsigned long arg5)
> +{
> +	unsigned long *mm_flags = &current->mm->flags;
> +
> +	if (arg4 || arg5)
> +		return -EINVAL;
> +
> +	/* Flags are only allowed when disabling. */
> +	if (!thp_disable || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))


I think you meant over here?

	if (!thp_disable && (flags & PR_THP_DISABLE_EXCEPT_ADVISED))

> +		return -EINVAL;
> +	if (mmap_write_lock_killable(current->mm))
> +		return -EINTR;
> +	if (thp_disable) {
> +		if (flags & PR_THP_DISABLE_EXCEPT_ADVISED) {
> +			clear_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags);
> +			set_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags);
> +		} else {
> +			set_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags);
> +			clear_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags);
> +		}
> +	} else {
> +		clear_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags);
> +		clear_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags);
> +	}
> +	mmap_write_unlock(current->mm);
> +	return 0;
> +}
> +
>  SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		unsigned long, arg4, unsigned long, arg5)
>  {
> @@ -2596,20 +2640,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  			return -EINVAL;
>  		return task_no_new_privs(current) ? 1 : 0;
>  	case PR_GET_THP_DISABLE:
> -		if (arg2 || arg3 || arg4 || arg5)
> -			return -EINVAL;
> -		error = !!test_bit(MMF_DISABLE_THP, &me->mm->flags);
> +		error = prctl_get_thp_disable(arg2, arg3, arg4, arg5);
>  		break;
>  	case PR_SET_THP_DISABLE:
> -		if (arg3 || arg4 || arg5)
> -			return -EINVAL;
> -		if (mmap_write_lock_killable(me->mm))
> -			return -EINTR;
> -		if (arg2)
> -			set_bit(MMF_DISABLE_THP, &me->mm->flags);
> -		else
> -			clear_bit(MMF_DISABLE_THP, &me->mm->flags);
> -		mmap_write_unlock(me->mm);
> +		error = prctl_set_thp_disable(arg2, arg3, arg4, arg5);
>  		break;
>  	case PR_MPX_ENABLE_MANAGEMENT:
>  	case PR_MPX_DISABLE_MANAGEMENT:
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 8a5873d0a23a7..a685077644b4e 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -427,7 +427,7 @@ static inline int collapse_test_exit(struct mm_struct *mm)
>  static inline int collapse_test_exit_or_disable(struct mm_struct *mm)
>  {
>  	return collapse_test_exit(mm) ||
> -	       test_bit(MMF_DISABLE_THP, &mm->flags);
> +	       test_bit(MMF_DISABLE_THP_COMPLETELY, &mm->flags);
>  }
>  
>  static bool hugepage_enabled(void)
> 
> base-commit: 760b462b3921c5dc8bfa151d2d27a944e4e96081


