Return-Path: <linux-fsdevel+bounces-55614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD74B0C9A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 19:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61676C0301
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58282E041C;
	Mon, 21 Jul 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/p8VEtC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F1D21421A;
	Mon, 21 Jul 2025 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118867; cv=none; b=Jg/51rso1//vnGwI2QwGaLwZUnrZEREV0b9l8w2Tf0CUfH885WKgpnwo42OdIkLqBWOv0I1mbr5dkiyAH2yZbOO1RosVzEB1HJW82wG7ORDbkBzRIQQ3LgjzOXfwydTKNW+XvffS9RKXx7YhZGj4vzlR1J41l1h1nRx6gd4lrMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118867; c=relaxed/simple;
	bh=1oujtydUve/cD8BNQnzZMCJfwhGJuo1kqDSPuEU9XcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LXxeJFg3hTvCaplE+D3vnN7OWXjfWE//ejMPENTrdk2RRO7bnxQcVof1fCK0hw/ewOWk9TdF6QVOW5XOSAWwu08clMKRx/v0QlIUjXbv/i7G0mhz/hy1ZLu50Y0JlJ587o+X5I2GkUQci10wHK7brxzBzKK5iJelUxehUlaCk3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/p8VEtC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae6fa02d8feso674947566b.0;
        Mon, 21 Jul 2025 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753118863; x=1753723663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLBjxQaTX8LscBqdSZ08o3ArpoFNx0b7tv/Q0Py17yI=;
        b=f/p8VEtCKKpBYMl51fbBHd3qe+Zu4bbcOThXpBDFI1tcveFVX9VIWE8choq8SAvLXZ
         wrkIMgrsESibMcdE61Gg2KdNXHHe3ABNOQ4Ed2np/S70xY8Z7ZX7CaXirx57Zc9bvqhs
         F2IJDUYDeGMxrPQuhLC2t7HCd6kBZhQJVPQIBPts4y56iWwoWaU9xdPqikMLc4ykdWTv
         APQIyKbUB7aChTcoKjdHsIPfjfH80DPQwcDnmaZIxwGVYbk6jaXjBpgfYKl3H0VVgJNz
         nKPVOTEwvA8Ok3fWJENq58JOn70EC2dSZsa66GhvYcFhaqbilXSb+ePpwOlIYfAZST9x
         jTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753118863; x=1753723663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLBjxQaTX8LscBqdSZ08o3ArpoFNx0b7tv/Q0Py17yI=;
        b=aCp9qkTf22VFho+cbUnu5Fik/59A32t60hLT5TU2wdXzr4naP6CFvNWftwK9IR021q
         ISvx4fhpxZj1wj4128GphZEF0XxL3Zwl0Lq6raNDMRh51zlFz04hb+YDG0fMfTN8CImP
         wKGjy1nzHftIRTfbHKBTV/601v2jmXZGskUltI69l2tkhHwIDDvgx/DLjmsMHi6GwOuA
         vy3+PtF0zQRnpFH6fQckzXqr/tWtUk2LEqsc1Lt2tp4CRtXlOY3iRCtNB9rYz8SFFRDn
         7+wu48np0M6kc/n8lM7m45lFkGaL5isTPWBoNSB3XiTPpWvtgeDULYaInc9yVOff0vRt
         VXXw==
X-Forwarded-Encrypted: i=1; AJvYcCUlp8HBh8WoXqOTLA+YInyijGh0pSbU3q920D3ZkiRZqQSXInM2XmnluoYZNBDjUIBmkx7UJbxsmwkXy9A6@vger.kernel.org, AJvYcCXCnZIxZaywxYEqCJvUKnXYrXReD1VdxRs96bA5DniqafmPuy2MhMwTy7p+6vDWQqzxnAbb99ttrwkITHO0fg==@vger.kernel.org, AJvYcCXxc13+YY6oLdtGUmHE1fE6vpj2+JtUd1jAMkSoD0ydQzcuFtw0vZXajsicSxgU9JbJLudtiavAclQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxULK5TTOTWv0AdvakhNmxr/XQ82rNvsj5IuxeIk7cP/c5oBgGs
	SYkF8Gi67USXd7sgdWuFTrkfm98JHpfY4/8pnUrqV+yOezh47nB2JOZz
X-Gm-Gg: ASbGncv87uwTgAV7IiL1R2qhfjns4wRaVy3KTU+Cpet/q7C0gGHWRn4al2C5tfJgC7T
	nDcfSgG+8t9OEj6ilFcRWUq2Pjb1s9Gu6kZahYhlT7LldYdoDrRquRMXvGyQUfLZ6z+7f/obJ9W
	1xgoar4GO0cVed1FVx9Kbl2ladf042uGArGc9yaukOA2j7VJJ6k7bT3I1oDyJfrwPU0LdNv3uBv
	Q2qKBpEDTdJNSyfPs5VJ//kucPjN5Wbe9ySEqUSvzSGmWj2oDnZJuqlWxtcZiQ8IhUBDYlmi4lw
	BRyCnVKXM2+yGy4dkz7CnBHBpy7g4RSTJk3yviaT5sRPCjFfFJEZDJ2KXy8rG0AzyMI6pLqUQHF
	ogwoAfrceRe3QQihY6ZIGPezpe24/FyvcSV+k6fn1PrhYZtygqV7thcon9b/eAn4WK/9HVsA=
X-Google-Smtp-Source: AGHT+IF67qRQILwsFhjtv0xjHo3oNFhJgY+f8Q8WfYmpBOmYl+u3H0UBEOyl0+feFNjNVxpoy5TwiQ==
X-Received: by 2002:a17:907:bd11:b0:ae3:51ac:12b5 with SMTP id a640c23a62f3a-ae9ce14ae3cmr2044637066b.46.1753118862587;
        Mon, 21 Jul 2025 10:27:42 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::7:cc27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7a3e1sm708835166b.105.2025.07.21.10.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 10:27:41 -0700 (PDT)
Message-ID: <4a8b70b1-7ba0-4d60-a3a0-04ac896a672d@gmail.com>
Date: Mon, 21 Jul 2025 18:27:38 +0100
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


Thanks for the patch David!

As discussed in the other thread, with the below diff

diff --git a/kernel/sys.c b/kernel/sys.c
index 2a34b2f70890..3912f5b6a02d 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2447,7 +2447,7 @@ static int prctl_set_thp_disable(unsigned long thp_disable, unsigned long flags,
                return -EINVAL;
 
        /* Flags are only allowed when disabling. */
-       if (!thp_disable || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))
+       if ((!thp_disable && flags) || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))
                return -EINVAL;
        if (mmap_write_lock_killable(current->mm))
                return -EINTR;


I tested with the below selftest, and it works. It hopefully covers
majority of the cases including fork and re-enabling THPs. 
Let me know if it looks ok and please feel free to add this in the
next revision you send.


Once the above diff is included, please feel free to add

Acked-by: Usama Arif <usamaarif642@gmail.com>
Tested-by: Usama Arif <usamaarif642@gmail.com>


Thanks!

From ee9004e7d34511a79726ee1314aec0503e6351d4 Mon Sep 17 00:00:00 2001
From: Usama Arif <usamaarif642@gmail.com>
Date: Thu, 15 May 2025 14:33:33 +0100
Subject: [PATCH] selftests: prctl: introduce tests for
 PR_THP_DISABLE_EXCEPT_ADVISED

The test is limited to 2M PMD THPs. It does not modify the system
settings in order to not disturb other process running in the system.
It checks if the PMD size is 2M, if the 2M policy is set to inherit
and if the system global THP policy is set to "always", so that
the change in behaviour due to PR_THP_DISABLE_EXCEPT_ADVISED can
be seen.

This tests if:
- the process can successfully set the policy
- carry it over to the new process with fork
- if no hugepage is gotten when the process doesn't MADV_HUGEPAGE
- if hugepage is gotten when the process does MADV_HUGEPAGE
- the process can successfully reset the policy to PR_THP_POLICY_SYSTEM
- if hugepage is gotten after the policy reset

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 tools/testing/selftests/prctl/Makefile      |   2 +-
 tools/testing/selftests/prctl/thp_disable.c | 207 ++++++++++++++++++++
 2 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/prctl/thp_disable.c

diff --git a/tools/testing/selftests/prctl/Makefile b/tools/testing/selftests/prctl/Makefile
index 01dc90fbb509..a3cf76585c48 100644
--- a/tools/testing/selftests/prctl/Makefile
+++ b/tools/testing/selftests/prctl/Makefile
@@ -5,7 +5,7 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),x86)
 TEST_PROGS := disable-tsc-ctxt-sw-stress-test disable-tsc-on-off-stress-test \
-		disable-tsc-test set-anon-vma-name-test set-process-name
+		disable-tsc-test set-anon-vma-name-test set-process-name thp_disable
 all: $(TEST_PROGS)
 
 include ../lib.mk
diff --git a/tools/testing/selftests/prctl/thp_disable.c b/tools/testing/selftests/prctl/thp_disable.c
new file mode 100644
index 000000000000..e524723b3313
--- /dev/null
+++ b/tools/testing/selftests/prctl/thp_disable.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This test covers the PR_GET/SET_THP_DISABLE functionality of prctl calls
+ * for PR_THP_DISABLE_EXCEPT_ADVISED
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+
+#ifndef PR_THP_DISABLE_EXCEPT_ADVISED
+#define PR_THP_DISABLE_EXCEPT_ADVISED (1 << 1)
+#endif
+
+#define CONTENT_SIZE 256
+#define BUF_SIZE (12 * 2 * 1024 * 1024) // 12 x 2MB pages
+
+enum system_policy {
+	SYSTEM_POLICY_ALWAYS,
+	SYSTEM_POLICY_MADVISE,
+	SYSTEM_POLICY_NEVER,
+};
+
+int system_thp_policy;
+
+/* check if the sysfs file contains the expected substring */
+static int check_file_content(const char *file_path, const char *expected_substring)
+{
+	FILE *file = fopen(file_path, "r");
+	char buffer[CONTENT_SIZE];
+
+	if (!file) {
+		perror("Failed to open file");
+		return -1;
+	}
+	if (fgets(buffer, CONTENT_SIZE, file) == NULL) {
+		perror("Failed to read file");
+		fclose(file);
+		return -1;
+	}
+	fclose(file);
+	// Remove newline character from the buffer
+	buffer[strcspn(buffer, "\n")] = '\0';
+	if (strstr(buffer, expected_substring))
+		return 0;
+	else
+		return 1;
+}
+
+/*
+ * The test is designed for 2M hugepages only.
+ * Check if hugepage size is 2M, if 2M size inherits from global
+ * setting, and if the global setting is always.
+ */
+static int sysfs_check(void)
+{
+	int res = 0;
+
+	res = check_file_content("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size", "2097152");
+	if (res) {
+		printf("hpage_pmd_size is not set to 2MB. Skipping test.\n");
+		return -1;
+	}
+	res |= check_file_content("/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled",
+				  "[inherit]");
+	if (res) {
+		printf("hugepages-2048kB does not inherit global setting. Skipping test.\n");
+		return -1;
+	}
+
+	res = check_file_content("/sys/kernel/mm/transparent_hugepage/enabled", "[always]");
+	if (!res) {
+		system_thp_policy = SYSTEM_POLICY_ALWAYS;
+		return 0;
+	}
+	printf("Global THP policy not set to always. Skipping test.\n");
+	return -1;
+}
+
+static int check_smaps_for_huge(void)
+{
+	FILE *file = fopen("/proc/self/smaps", "r");
+	int is_anonhuge = 0;
+	char line[256];
+
+	if (!file) {
+		perror("fopen");
+		return -1;
+	}
+
+	while (fgets(line, sizeof(line), file)) {
+		if (strstr(line, "AnonHugePages:") && strstr(line, "24576 kB")) {
+			is_anonhuge = 1;
+			break;
+		}
+	}
+	fclose(file);
+	return is_anonhuge;
+}
+
+static int test_mmap_thp(int madvise_buffer)
+{
+	int is_anonhuge;
+
+	char *buffer = (char *)mmap(NULL, BUF_SIZE, PROT_READ | PROT_WRITE,
+				    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (buffer == MAP_FAILED) {
+		perror("mmap");
+		return -1;
+	}
+	if (madvise_buffer)
+		madvise(buffer, BUF_SIZE, MADV_HUGEPAGE);
+
+	// set memory to ensure it's allocated
+	memset(buffer, 0, BUF_SIZE);
+	is_anonhuge = check_smaps_for_huge();
+	munmap(buffer, BUF_SIZE);
+	return is_anonhuge;
+}
+
+/* Global policy is always, process is changed to "madvise only" */
+static int test_global_always_process_madvise(void)
+{
+	int is_anonhuge = 0, res = 0, status = 0;
+	pid_t pid;
+
+	if (prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL) != 0) {
+		perror("prctl failed to set policy to madvise");
+		return -1;
+	}
+
+	/* Make sure prctl changes are carried across fork */
+	pid = fork();
+	if (pid < 0) {
+		perror("fork");
+		exit(EXIT_FAILURE);
+	}
+
+	res = prctl(PR_GET_THP_DISABLE, NULL, NULL, NULL, NULL);
+	if (res != 3) {
+		printf("prctl PR_GET_THP_POLICY returned %d pid %d\n", res, pid);
+		goto err_out;
+	}
+
+	/* global = always, process = madvise, we shouldn't get HPs without madvise */
+	is_anonhuge = test_mmap_thp(0);
+	if (is_anonhuge) {
+		printf(
+		"PR_THP_POLICY_DEFAULT_NOHUGE set but still got hugepages without MADV_HUGEPAGE\n");
+		goto err_out;
+	}
+
+	is_anonhuge = test_mmap_thp(1);
+	if (!is_anonhuge) {
+		printf(
+		"PR_THP_POLICY_DEFAULT_NOHUGE set but did't get hugepages with MADV_HUGEPAGE\n");
+		goto err_out;
+	}
+
+	/* Reset to system policy */
+	if (prctl(PR_SET_THP_DISABLE, 0, NULL, NULL, NULL) != 0) {
+		perror("prctl failed to set policy to system");
+		goto err_out;
+	}
+
+	is_anonhuge = test_mmap_thp(0);
+	if (!is_anonhuge) {
+		printf("global policy is always but we still didn't get hugepages\n");
+		goto err_out;
+	}
+
+	is_anonhuge = test_mmap_thp(1);
+	if (!is_anonhuge) {
+		printf("global policy is always but we still didn't get hugepages\n");
+		goto err_out;
+	}
+	printf("PASS\n");
+
+	if (pid == 0) {
+		exit(EXIT_SUCCESS);
+	} else {
+		wait(&status);
+		if (WIFEXITED(status))
+			return 0;
+		else
+			return -1;
+	}
+
+err_out:
+	if (pid == 0)
+		exit(EXIT_FAILURE);
+	else
+		return -1;
+}
+
+int main(void)
+{
+	if (sysfs_check())
+		return 0;
+
+	if (system_thp_policy == SYSTEM_POLICY_ALWAYS)
+		return test_global_always_process_madvise();
+
+}
-- 
2.47.1



