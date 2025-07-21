Return-Path: <linux-fsdevel+bounces-55604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA00B0C696
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 16:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6276C04D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 14:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA45A286D64;
	Mon, 21 Jul 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ij1tLv6y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB2222FE08
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108757; cv=none; b=RJjW8JDE7Y5MDG3J7QpcoRmOtI1s0y/EXT6kZi42m7/pXlvoZm5QQEeuXK8i+lkQBwT9U8X/anhc5XOQRztY0VtQVpPWptEWReIUUkfaAsJRKupdmzCbuULDCuSm4pUKWD7wthRhHVtibkmCzGvEGhsir21pDjFUxeC7mvIgbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108757; c=relaxed/simple;
	bh=G+c/TlNOS3jJTgyl3Nflox4D4gS2l1ucS9SxXA86ljQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHZNhLopMhCT/iQCMF2wrD+aV6C5DcssYoMKWuVE9HhjuYuSC7j8RRT7HXOFLo2afMhQ5lucYRT9keJazVF/jwdfTMgPnQTitIcPsAbYUxlGQ06uHoiXCof+XxzErhwk8kmHJREIYEu+roW1GxjjRxV8QLikE9DkdiqNKyLsK1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ij1tLv6y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753108753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hcQicqR8pWhi54pYA2CCTCgwLgxgBUS5Et0jONJVtLc=;
	b=Ij1tLv6ylkolddSe9KuIx5rPAL8txg06Iy3vAvvB6UrftBtDhavaLCo0Vly0vb2abnF6k0
	B2Tnt3BkcqNmVcTsMoqTNfZtZCDb1zvQGMiOvuj56Yi019WQw/lpnZG5XXrkQdPF0ucFq2
	KQoi/ytgmDfhKfK30ifCgeRk+IKFjOc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Q-BDd5NkM1-TdAdHOJz1eA-1; Mon, 21 Jul 2025 10:39:12 -0400
X-MC-Unique: Q-BDd5NkM1-TdAdHOJz1eA-1
X-Mimecast-MFC-AGG-ID: Q-BDd5NkM1-TdAdHOJz1eA_1753108751
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so1919162f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 07:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753108751; x=1753713551;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hcQicqR8pWhi54pYA2CCTCgwLgxgBUS5Et0jONJVtLc=;
        b=hfl4faQFm/MjNgRjZYSeEihBUHis5cFdZRjFDTojYZmG0tq+RSU6H+X0QjvvCl6nPj
         EhVKBEa7miWZeJ5FdTskVlhlNM4yOGdF6/rw2VDJVTnGYfpkE6cHeMOG/E8mxfCHoYOX
         EqSirzrMLB5OCL1KPWnHw4fkIjcmLwlvlesSH8mMjI28EZzM/PEqsYyfcCDxqDw+ADuF
         Ya9e9HlOXWrUGwnr2Q1cJctMypv6bOog/fd/5wx25byOYmCSzbJadCa/coUcuQSSSDpD
         j6oC0aoDatgm9P3CBteyzvssNftquTfHOV6FdrlpA2nHhVpCo2p8NLuEHDDc0IrDlJrA
         9kmw==
X-Forwarded-Encrypted: i=1; AJvYcCWr1j5hHGz44esBFGbl4N9CUaUTYZBj7GnpnXYDEJ6ALAivP9qshZEIxyIyzq9DVt/2llmmp8rEhK6od7rt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu/32yHmtZUrz/3HY+ZVtrUIKFcHHYSBeR/EFMnUgwrpO49/pJ
	aNTHvi3DMkbBFpKLma2UeE6TOiTV8MdL1wNoDUOYdxGEYEKo8tbZB2RhOKHSwrsKAbj30Lb2tV6
	K+pmLph/YdzDUQAjM7EX1R7DbDnnUwVSyz0bMgbzrzceRfzt4MGoLx9LhCm+xU9/fwZg=
X-Gm-Gg: ASbGncvsflSjerWN+6co7gI6KrMnooGQZYD5WRWUOojLRGmYLDyvQ7p+0MK5ygAw7Nn
	NTotUKp6RcWIGx8IfULawTjNXk8v/Dbgl0l+s/V9M6eLWvdlQ5K4DbTJUZUy49Jy7cBO/w5uuuu
	x0IwK2grL/umM4IHFdf2Ay/wLgM/7BtiYZ7Oa8RMgEwfVM6t55dd2XFAcYg9JsTD3W1thylHvJ+
	LMCZmNONvPbCNkeJVPMg3tTQoK+For4xmaWm8Q6x0DiOScp+u10ibQkaiRElB/QRXPG+LQPAl38
	XjbZPOTwdPEo4ihzoH6lCwVIyyLKIhsXuhAl4vuA8G54vRqNDZI+5DtG8oV7aqlpA6QJDUk2ogM
	NEB8Swpv50h+p5Yhjufpmlo1v2QSlQfBkkg6yFM8GeqQOcaKpb9bG7Eblncy5wTmv
X-Received: by 2002:a05:6000:41ed:b0:3a3:6e62:d8e8 with SMTP id ffacd0b85a97d-3b613eab461mr13055533f8f.55.1753108750840;
        Mon, 21 Jul 2025 07:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd/BEozKWNQb4XV80/bHyTLAPcbI5dj6IOAUADBKINgEM9wyT3XARPgEGmapMgN+VE2Jeorg==
X-Received: by 2002:a05:6000:41ed:b0:3a3:6e62:d8e8 with SMTP id ffacd0b85a97d-3b613eab461mr13055487f8f.55.1753108750165;
        Mon, 21 Jul 2025 07:39:10 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4c:df00:a9f5:b75b:33c:a17f? (p200300d82f4cdf00a9f5b75b033ca17f.dip0.t-ipconnect.de. [2003:d8:2f4c:df00:a9f5:b75b:33c:a17f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5d266sm10549499f8f.91.2025.07.21.07.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 07:39:09 -0700 (PDT)
Message-ID: <c5942226-2102-48bd-949e-2369437e8599@redhat.com>
Date: Mon, 21 Jul 2025 16:39:07 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH POC] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
To: Usama Arif <usamaarif642@gmail.com>, linux-kernel@vger.kernel.org
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
 <4d9d25b0-49ee-438d-8698-59c835506cbd@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <4d9d25b0-49ee-438d-8698-59c835506cbd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> (B) Makes prctl(PR_GET_THP_DISABLE) return 3 if
>>      PR_THP_DISABLE_EXCEPT_ADVISED was set while disabling.
>>
>>      For now, it would return 1 if THPs were disabled completely. Now
>>      it essentially returns the set flags as well.
>>
> 
> No strong opinion, but maybe we have it return 2 (i.e. bit 1 set)?
> 
> I know that you are returning bit 1 set to indicate the flag, and I know that
> everyone dislikes prctl so its likely no more flags will be added :),
> but in the off chance there are extra flags, than it can make the return
> value weird?

Well, never say never, so I decided to just return the set flags :)

> If instead we return a value with only a single bit set, might be better?
> 
> Again, no strong opinion here.

I prefer the current approach, until there is good reason not do do it.

IOW, set bit-0 if something is disabled, and specify using flag what 
exectly (provided flags).

> 
>> (C) Renames MMF_DISABLE_THP to MMF_DISABLE_THP_COMPLETELY, to express
>>      the semantics clearly.
>>
>>      Fortunately, there are only two instances outside of prctl() code.
>>
>> (D) Adds MMF_DISABLE_THP_EXCEPT_ADVISED to express "no THP except for VMAs
>>      with VM_HUGEPAGE" -- essentially "thp=madvise" behavior
>>
>>      Fortunately, we only have to extend vma_thp_disabled().
>>
>> (E) Indicates "THP_enabled: 0" in /proc/pid/status only if THPs are not
>>      disabled completely
>>
>>      Only indicating that THPs are disabled when they are really disabled
>>      completely, not only partially.
>>
>> The documented semantics in the man page for PR_SET_THP_DISABLE
>> "is inherited by a child created via fork(2) and is preserved across
>> execve(2)" is maintained. This behavior, for example, allows for
>> disabling THPs for a workload through the launching process (e.g.,
>> systemd where we fork() a helper process to then exec()).
>>
>> There is currently not way to prevent that a process will not issue
>> PR_SET_THP_DISABLE itself to re-enable THP. We could add a "seal" option
>> to PR_SET_THP_DISABLE through another flag if ever required. The known
>> users (such as redis) really use PR_SET_THP_DISABLE to disable THPs, so
>> that is not added for now.
>>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>> Cc: Nico Pache <npache@redhat.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Cc: Barry Song <baohua@kernel.org>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Usama Arif <usamaarif642@gmail.com>
>> Cc: SeongJae Park <sj@kernel.org>
>> Cc: Jann Horn <jannh@google.com>
>> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
>> Cc: Yafang Shao <laoar.shao@gmail.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>> ---
>>
>> At first, I thought of "why not simply relax PR_SET_THP_DISABLE", but I
>> think there might be real use cases where we want to disable any THPs --
>> in particular also around debugging THP-related problems, and
>> "THP=never" not meaning ... "never" anymore. PR_SET_THP_DISABLE will
>> also block MADV_COLLAPSE, which can be very helpful. Of course, I thought
>> of having a system-wide config to change PR_SET_THP_DISABLE behavior, but
>> I just don't like the semantics.
>>
>> "prctl: allow overriding system THP policy to always"[1] proposed
>> "overriding policies to always", which is just the wrong way around: we
>> should not add mechanisms to "enable more" when we already have an
>> interface/mechanism to "disable" them (PR_SET_THP_DISABLE). It all gets
>> weird otherwise.
>>
>> "[PATCH 0/6] prctl: introduce PR_SET/GET_THP_POLICY"[2] proposed
>> setting the default of the VM_HUGEPAGE, which is similarly the wrong way
>> around I think now.
>>
>> The proposals by Lorenzo to extend process_madvise()[3] and mctrl()[4]
>> similarly were around the "default for VM_HUGEPAGE" idea, but after the
>> discussion, I think we should better leave VM_HUGEPAGE untouched.
>>
>> Happy to hear naming suggestions for "PR_THP_DISABLE_EXCEPT_ADVISED" where
>> we essentially want to say "leave advised regions alone" -- "keep THP
>> enabled for advised regions",
>>
>> The only thing I really dislike about this is using another MMF_* flag,
>> but well, no way around it -- and seems like we could easily support
>> more than 32 if we want to, or storing this thp information elsewhere.
>>
>> I think this here (modifying an existing toggle) is the only prctl()
>> extension that we might be willing to accept. In general, I agree like
>> most others, that prctl() is a very bad interface for that -- but
>> PR_SET_THP_DISABLE is already there and is getting used.
>>
>> Long-term, I think the answer will be something based on bpf[5]. Maybe
>> in that context, I there could still be value in easily disabling THPs for
>> selected workloads (esp. debugging purposes).
>>
>> Jann raised valid concerns[6] about new flags that are persistent across
>> exec[6]. As this here is a relaxation to existing PR_SET_THP_DISABLE I
>> consider it having a similar security risk as our existing
>> PR_SET_THP_DISABLE, but devil is in the detail.
>>
>> This is *completely* untested and might be utterly broken. It merely
>> serves as a PoC of what I think could be done. If this ever goes upstream,
>> we need some kselftests for it, and extensive tests.
>>
>> [1] https://lore.kernel.org/r/20250507141132.2773275-1-usamaarif642@gmail.com
>> [2] https://lkml.kernel.org/r/20250515133519.2779639-2-usamaarif642@gmail.com
>> [3] https://lore.kernel.org/r/cover.1747686021.git.lorenzo.stoakes@oracle.com
>> [4] https://lkml.kernel.org/r/85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local
>> [5] https://lkml.kernel.org/r/20250608073516.22415-1-laoar.shao@gmail.com
>> [6] https://lore.kernel.org/r/CAG48ez3-7EnBVEjpdoW7z5K0hX41nLQN5Wb65Vg-1p8DdXRnjg@mail.gmail.com
>>
>> ---
>>   Documentation/filesystems/proc.rst |  5 +--
>>   fs/proc/array.c                    |  2 +-
>>   include/linux/huge_mm.h            | 20 ++++++++---
>>   include/linux/mm_types.h           | 13 +++----
>>   include/uapi/linux/prctl.h         |  7 ++++
>>   kernel/sys.c                       | 58 +++++++++++++++++++++++-------
>>   mm/khugepaged.c                    |  2 +-
>>   7 files changed, 78 insertions(+), 29 deletions(-)
>>
>> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
>> index 2971551b72353..915a3e44bc120 100644
>> --- a/Documentation/filesystems/proc.rst
>> +++ b/Documentation/filesystems/proc.rst
>> @@ -291,8 +291,9 @@ It's slow but very precise.
>>    HugetlbPages                size of hugetlb memory portions
>>    CoreDumping                 process's memory is currently being dumped
>>                                (killing the process may lead to a corrupted core)
>> - THP_enabled		     process is allowed to use THP (returns 0 when
>> -			     PR_SET_THP_DISABLE is set on the process
>> + THP_enabled                 process is allowed to use THP (returns 0 when
>> +                             PR_SET_THP_DISABLE is set on the process to disable
>> +                             THP completely, not just partially)
>>    Threads                     number of threads
>>    SigQ                        number of signals queued/max. number for queue
>>    SigPnd                      bitmap of pending signals for the thread
>> diff --git a/fs/proc/array.c b/fs/proc/array.c
>> index d6a0369caa931..c4f91a784104f 100644
>> --- a/fs/proc/array.c
>> +++ b/fs/proc/array.c
>> @@ -422,7 +422,7 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
>>   	bool thp_enabled = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE);
>>   
>>   	if (thp_enabled)
>> -		thp_enabled = !test_bit(MMF_DISABLE_THP, &mm->flags);
>> +		thp_enabled = !test_bit(MMF_DISABLE_THP_COMPLETELY, &mm->flags);
>>   	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
>>   }
>>   
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index e0a27f80f390d..c4127104d9bc3 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -323,16 +323,26 @@ struct thpsize {
>>   	(transparent_hugepage_flags &					\
>>   	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
>>   
>> +/*
>> + * Check whether THPs are explicitly disabled through madvise or prctl, or some
>> + * architectures may disable THP for some mappings, for example, s390 kvm.
>> + */
>>   static inline bool vma_thp_disabled(struct vm_area_struct *vma,
>>   		vm_flags_t vm_flags)
>>   {
>> +	/* Are THPs disabled for this VMA? */
>> +	if (vm_flags & VM_NOHUGEPAGE)
>> +		return true;
>> +	/* Are THPs disabled for all VMAs in the whole process? */
>> +	if (test_bit(MMF_DISABLE_THP_COMPLETELY, &vma->vm_mm->flags))
>> +		return true;
>>   	/*
>> -	 * Explicitly disabled through madvise or prctl, or some
>> -	 * architectures may disable THP for some mappings, for
>> -	 * example, s390 kvm.
>> +	 * Are THPs disabled only for VMAs where we didn't get an explicit
>> +	 * advise to use them?
>>   	 */
>> -	return (vm_flags & VM_NOHUGEPAGE) ||
>> -	       test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags);
>> +	if (vm_flags & VM_HUGEPAGE)
>> +		return false;
>> +	return test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, &vma->vm_mm->flags);
>>   }
>>   
>>   static inline bool thp_disabled_by_hw(void)
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 1ec273b066915..a999f2d352648 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -1743,19 +1743,16 @@ enum {
>>   #define MMF_VM_MERGEABLE	16	/* KSM may merge identical pages */
>>   #define MMF_VM_HUGEPAGE		17	/* set when mm is available for khugepaged */
>>   
>> -/*
>> - * This one-shot flag is dropped due to necessity of changing exe once again
>> - * on NFS restore
>> - */
>> -//#define MMF_EXE_FILE_CHANGED	18	/* see prctl_set_mm_exe_file() */
>> +#define MMF_HUGE_ZERO_PAGE	18      /* mm has ever used the global huge zero page */
>>   
>>   #define MMF_HAS_UPROBES		19	/* has uprobes */
>>   #define MMF_RECALC_UPROBES	20	/* MMF_HAS_UPROBES can be wrong */
>>   #define MMF_OOM_SKIP		21	/* mm is of no interest for the OOM killer */
>>   #define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
>> -#define MMF_HUGE_ZERO_PAGE	23      /* mm has ever used the global huge zero page */
>> -#define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
>> -#define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
>> +#define MMF_DISABLE_THP_EXCEPT_ADVISED	23	/* no THP except for VMAs with VM_HUGEPAGE */
>> +#define MMF_DISABLE_THP_COMPLETELY	24	/* no THP for all VMAs */
>> +#define MMF_DISABLE_THP_MASK	((1 << MMF_DISABLE_THP_COMPLETELY) |\
>> +				 (1 << MMF_DISABLE_THP_EXCEPT_ADVISED))
>>   #define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
>>   #define MMF_MULTIPROCESS	26	/* mm is shared between processes */
>>   /*
>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>> index 43dec6eed559a..1949bb9270d48 100644
>> --- a/include/uapi/linux/prctl.h
>> +++ b/include/uapi/linux/prctl.h
>> @@ -177,7 +177,14 @@ struct prctl_mm_map {
>>   
>>   #define PR_GET_TID_ADDRESS	40
>>   
>> +/*
>> + * Flags for PR_SET_THP_DISABLE are only applicable when disabling. Bit 0
>> + * is reserved, so PR_GET_THP_DISABLE can return 1 when no other flags were
>> + * specified for PR_SET_THP_DISABLE.
>> + */
>>   #define PR_SET_THP_DISABLE	41
>> +/* Don't disable THPs when explicitly advised (MADV_HUGEPAGE / VM_HUGEPAGE). */
>> +# define PR_THP_DISABLE_EXCEPT_ADVISED	(1 << 1)
>>   #define PR_GET_THP_DISABLE	42
>>   
>>   /*
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index b153fb345ada2..2a34b2f708900 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -2423,6 +2423,50 @@ static int prctl_get_auxv(void __user *addr, unsigned long len)
>>   	return sizeof(mm->saved_auxv);
>>   }
>>   
>> +static int prctl_get_thp_disable(unsigned long arg2, unsigned long arg3,
>> +				 unsigned long arg4, unsigned long arg5)
>> +{
>> +	unsigned long *mm_flags = &current->mm->flags;
>> +
>> +	if (arg2 || arg3 || arg4 || arg5)
>> +		return -EINVAL;
>> +
>> +	if (test_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags))
>> +		return 1;
>> +	else if (test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags))
>> +		return 1 | PR_THP_DISABLE_EXCEPT_ADVISED;
>> +	return 0;
>> +}
>> +
>> +static int prctl_set_thp_disable(unsigned long thp_disable, unsigned long flags,
>> +				 unsigned long arg4, unsigned long arg5)
>> +{
>> +	unsigned long *mm_flags = &current->mm->flags;
>> +
>> +	if (arg4 || arg5)
>> +		return -EINVAL;
>> +
>> +	/* Flags are only allowed when disabling. */
>> +	if (!thp_disable || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))
> 
> 
> I think you meant over here?
> 
> 	if (!thp_disable && (flags & PR_THP_DISABLE_EXCEPT_ADVISED))
> 


When re-enabling, we don't allow flags, otherwise we only allow the 
supported (PR_THP_DISABLE_EXCEPT_ADVISED) flag.

So I think it should probably be something like

if ((!thp_disable && flags) || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))


-- 
Cheers,

David / dhildenb


