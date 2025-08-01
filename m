Return-Path: <linux-fsdevel+bounces-56510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF17B18109
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 13:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B90B54140E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 11:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2517924468E;
	Fri,  1 Aug 2025 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtRF/9A6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD2D239E69;
	Fri,  1 Aug 2025 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754047569; cv=none; b=e4X4WjPtM1/e4eQhcBXAQawMIgLd6J9CFMLtjm46rYobG8g2P9fA9A/5E5BGySd4ROb2RwhGvWikij6kMarwsd93SIiA7HKxmQbJ/kwAINMZ3d7Xqxuo66OrWdE7ZMgJSM8oAv5y+iB2QMT12am4A4CIMYmjaomsGWUMzEQ8VVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754047569; c=relaxed/simple;
	bh=ctcPV0e4TcLmBOtwNfnGutyp4VCyuR8D9x3aly+gaKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hwx1Q/l6/6zhZqXRuyc1m0LlXhDugvRXknvoZKqARTLJSGaO1hI92RPY3Leoga5HjtE+AN8s45wV6po9uDlfxbTRb5NbqrHIGff03Z5OFrM0fj2OVI03iUxZFfYj6o54zMyN2KiC8XSMlTEtoQ0MnaRw99M0w3WCE4maNGh4Rpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtRF/9A6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso11327165e9.2;
        Fri, 01 Aug 2025 04:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754047566; x=1754652366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f31sjo4y6IU/9pLIItS9Wkop/JonBlPPFk2NLd9JXtg=;
        b=DtRF/9A6Ri5ib4ixUe6EFVwBQ/WQC4lCAxVU7gZ2z8OKJtQUNGNCxBpicBLc4bW6nO
         6j2DT5ssaK6tivOmEaOv6YMdWBBiBjNoxIwKuGIEV7ICu3u0TN4Q19GqUrShocjm1AP9
         fMkYToZZBzSQMxUibXXmZSON8VgOpEVaVDsMG+MraetBvJv+gFANV0VMPzk+liwBlQvI
         z19VYk1zkrqaLwGS0swiE/XzFL7y4inFrIujUQOm4Rr8K/bwWrwdRpPycnf95QrWm7yd
         kHsDsCX3/C1LANzE+PUv14FPVlWxpBU1MO2pOj6nWZ0HAslznyz1opUqURaArlC8JNVS
         wLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754047566; x=1754652366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f31sjo4y6IU/9pLIItS9Wkop/JonBlPPFk2NLd9JXtg=;
        b=FGpprTSOnuZCzUf/iWHN13LyXL2efLauX7tol2xcrUzDyqdXqA+Qq+spxKgrm5pNtl
         Ub/NnbWvaJWfS+LynmVCw+9IG5l3lKxyxZRTKn4bB+VjOGGgCFQlT8jVe0YaQfVtLYma
         TCet/czRKMkC40k5zBCeUcJBmlamhNhUQp5l3k3IjEcr0yr5DAFyC95TIIyAs7ZM597A
         +Csdhk1fcPd95cgcv970YFrYQNm//GfaHxjTIYxpcMCUmxLCmgdaRwq//CmDLZCuQqey
         c2P0FBWmJ+iX4T1P6Kz5Q6PgXfDddzRI5mF+xH1fEyRTDer1+aL1WU8TMTmdqsWNyWON
         sdNg==
X-Forwarded-Encrypted: i=1; AJvYcCU3izXj0k5PJTaT7WG5FmjRhIs0uTqPw2zi+vqjWg03Fhh97cWX6IDU5AAkyFGPix3swMSrUJ30b8o=@vger.kernel.org, AJvYcCVLsHrZtljGY2n+06S9GoFEU9IjWLVZ1SeEyq4B/KA0B+ijPdxmzhgKAL4dsB9zBtVrePAFAYepp7BAAm2QPw==@vger.kernel.org, AJvYcCVaFwOOpc1AhoDvOb08I/4EgO2SlCCt3KnvkhZaz/JdfG6I/zIpgnNbPJL3dCabEr/OHtgthFczF13+5rHP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5fy1PTie5JL096BtIZrM+dZDtO70/JNgpWYpSX59T8LJS7Z2L
	DfEcoLiNyFhsar8f3lOyYz1fYoqcfcV0dxk8hC4N9Oq2oLmqtVz81qbS
X-Gm-Gg: ASbGncttIFTazw3FizY4tZ/kNLHP4P0trODSor4JKpJC2hwUrehC5hTjf6gLDvTTY4A
	CQ1eKZjdBtZo7BffTTIf6jcpZP2sBRyf6D5KhBgCP5szdAnSiL6uv6qBatsIuHvjAvatK55JP+J
	44LHVq4gePhJyWvODdO3a/bmUz78xYieVtY/dZlOAgI6RqPpBQzPH43yt3zFEXOr4PPBPSNLfit
	ujxIAsDDvjCX/rd6Xm4sRLjJq+CUiKj/VTMevR1kIwoNkZD1j7swE0GkntUUEGL3+dyVITD+s0W
	q8LkfqgACQBvHb+QlfVHXDmunXf1K9FLIxShn7XuIAyfQ7Z6BSme/VyUCVwm0l67q61bnHJkuZB
	714/atMLqBV45yHhTV+SuisCg9qakN8EXANBMGMI8F6zDPk42a+nQA9U9ezE7tL3BYqZ4Up73xb
	QhKzVp6GMO+w==
X-Google-Smtp-Source: AGHT+IFjTKWLBkC1vBA6besRk7jxQ0cAB8sF1kKVfEqfQ3SbATKsd62PtflkSV1CPQXrUyg4yTYm1Q==
X-Received: by 2002:adf:a455:0:b0:3b7:9564:29be with SMTP id ffacd0b85a97d-3b795642a6fmr5837784f8f.49.1754047565577;
        Fri, 01 Aug 2025 04:26:05 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:8b4:7c1f:c64:2a4? ([2a02:6b6f:e759:7e00:8b4:7c1f:c64:2a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589536abb1sm108846655e9.4.2025.08.01.04.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 04:26:04 -0700 (PDT)
Message-ID: <3fc8b76c-825d-4aaa-98f4-ff64bb40497d@gmail.com>
Date: Fri, 1 Aug 2025 12:26:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm/huge_memory: treat MADV_COLLAPSE as an advise
 with PR_THP_DISABLE_EXCEPT_ADVISED
To: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20250731122825.2102184-1-usamaarif642@gmail.com>
 <20250731122825.2102184-4-usamaarif642@gmail.com>
 <aca74036-f37f-4247-b3b8-112059f53659@lucifer.local>
 <747509a6-8493-46c3-99d4-38b53a8a7504@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <747509a6-8493-46c3-99d4-38b53a8a7504@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 31/07/2025 15:54, David Hildenbrand wrote:
> On 31.07.25 16:38, Lorenzo Stoakes wrote:
>> Nits on subject:
>>
>> - It's >75 chars
> 
> No big deal. If we cna come up with something shorter, good.

Changed it to "mm/huge_memory: respect MADV_COLLAPSE with PR_THP_DISABLE_EXCEPT_ADVISED"
for the next revision. That would be 73 chars :)

> 
>> - advise is the verb, advice is the noun.
> 
> Yeah.
> 
>>
>> On Thu, Jul 31, 2025 at 01:27:20PM +0100, Usama Arif wrote:
>>> From: David Hildenbrand <david@redhat.com>
>>>
>>> Let's allow for making MADV_COLLAPSE succeed on areas that neither have
>>> VM_HUGEPAGE nor VM_NOHUGEPAGE when we have THP disabled
>>> unless explicitly advised (PR_THP_DISABLE_EXCEPT_ADVISED).
>>
>> Hmm, I'm not sure about this.
>>
>> So far this prctl() has been the only way to override MADV_COLLAPSE
>> behaviour, but now we're allowing for this one case to not.
> 
> This is not an override really. prctl() disallowed MADV_COLLAPSE, but in the new mode we don't want that anymore.
> 
>> > I suppose the precedent is that MADV_COLLAPSE overrides 'madvise' sysfs
>> behaviour.
>> > I suppose what saves us here is 'advised' can be read to mean either
>> MADV_HUGEPAGE or MADV_COLLAPSE.
>> > And yes, MADV_COLLAPSE is clearly the user requesting this behaviour.
> 
> Exactly.
> 
>>
>> I think the vagueness here is one that already existed, because one could
>> perfectly one have expected MADV_COLLAPSE to obey sysfs and require
>> MADV_HUGEPAGE to have been applied, but of course this is not the case.
> 
> Yes.
> 
>>
>> OK so fine.
>>
>> BUT.
>>
>> I think the MADV_COLLAPSE man page will need to be updated to mention this.
>>
> 
> Yes.
> 

Thanks, yes will do and send this along with changes to prctl man page after this
makes into mm-stable.

>> And I REALLY think we should update the THP doc too to mention all these
>> prctl() modes.
>>
>> I'm not sure we cover that right now _at all_ and obviously we should
>> describe the new flags.
>>
>> Usama - can you add a patch to this series to do that?
> 
> Good point, let's document the interaction with prctl().
> 

I have added the following patch for the next revision. I know that a lot
of this will be in the man page as well, but I have gone the way of being very
very explicit of what are all the possible calls that can be made (hopefully thats
the right approach :))


commit 5f290d29741a514d0861d0f99c8b860ba6af9c37
Author: Usama Arif <usamaarif642@gmail.com>
Date:   Fri Aug 1 12:05:49 2025 +0100

    docs: transhuge: document process level THP controls
    
    This includes the PR_SET_THP_DISABLE/PR_GET_THP_DISABLE pair of
    prctl calls as well the newly introduced PR_THP_DISABLE_EXCEPT_ADVISED
    flag for the PR_SET_THP_DISABLE prctl call.
    
    Signed-off-by: Usama Arif <usamaarif642@gmail.com>

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 370fba113460..cce0a99beac8 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -225,6 +225,45 @@ to "always" or "madvise"), and it'll be automatically shutdown when
 PMD-sized THP is disabled (when both the per-size anon control and the
 top-level control are "never")
 
+process THP controls
+--------------------
+
+A process can control its own THP behaviour using the ``PR_SET_THP_DISABLE``
+and ``PR_GET_THP_DISABLE`` pair of prctl(2) calls. These calls support the
+following arguments::
+
+       prctl(PR_SET_THP_DISABLE, 1, 0, 0, 0):
+               This will set the MMF_DISABLE_THP_COMPLETELY mm flag which will
+               result in no THPs being faulted in or collapsed, irrespective
+               of global THP controls. This flag and hence the behaviour is
+               inherited across fork(2) and execve(2).
+
+       prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, 0, 0):
+               This will set the MMF_DISABLE_THP_EXCEPT_ADVISED mm flag which
+               will result in THPs being faulted in or collapsed only for
+               the following cases:
+               - Global THP controls are set to "always" or "madvise" and
+                 the process has madvised the region with either MADV_HUGEPAGE
+                 or MADV_COLLAPSE.
+               - Global THP controls is set to "never" and the process has
+                 madvised the region with MADV_COLLAPSE.
+               This flag and hence the behaviour is inherited across fork(2)
+               and execve(2).
+
+       prctl(PR_SET_THP_DISABLE, 0, 0, 0, 0):
+               This will clear the MMF_DISABLE_THP_COMPLETELY and
+               MMF_DISABLE_THP_EXCEPT_ADVISED mm flags. The process will
+               behave according to the global THP controls. This behaviour
+               will be inherited across fork(2) and execve(2).
+
+       prctl(PR_GET_THP_DISABLE, 0, 0, 0, 0):
+               This will return the THP disable mm flag status of the process
+               that was set by prctl(PR_SET_THP_DISABLE, ...).
+               i.e.
+               - 1 if MMF_DISABLE_THP_COMPLETELY flag is set
+               - 3 if MMF_DISABLE_THP_EXCEPT_ADVISED flag is set
+               - 0 otherwise.
+
 Khugepaged controls
 -------------------


>>
>>>
>>> MADV_COLLAPSE is a clear advise that we want to collapse.
>>
>> advise -> advice.
>>
>>>
>>> Note that we still respect the VM_NOHUGEPAGE flag, just like
>>> MADV_COLLAPSE always does. So consequently, MADV_COLLAPSE is now only
>>> refused on VM_NOHUGEPAGE with PR_THP_DISABLE_EXCEPT_ADVISED.
>>
>> You also need to mention the shmem change you've made I think.
> 
> Yes.
> 
>> >>
>>> Co-developed-by: Usama Arif <usamaarif642@gmail.com>
>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   include/linux/huge_mm.h    | 8 +++++++-
>>>   include/uapi/linux/prctl.h | 2 +-
>>>   mm/huge_memory.c           | 5 +++--
>>>   mm/memory.c                | 6 ++++--
>>>   mm/shmem.c                 | 2 +-
>>>   5 files changed, 16 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index b0ff54eee81c..aeaf93f8ac2e 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -329,7 +329,7 @@ struct thpsize {
>>>    * through madvise or prctl.
>>>    */
>>>   static inline bool vma_thp_disabled(struct vm_area_struct *vma,
>>> -        vm_flags_t vm_flags)
>>> +        vm_flags_t vm_flags, bool forced_collapse)
>>>   {
>>>       /* Are THPs disabled for this VMA? */
>>>       if (vm_flags & VM_NOHUGEPAGE)
>>> @@ -343,6 +343,12 @@ static inline bool vma_thp_disabled(struct vm_area_struct *vma,
>>>        */
>>>       if (vm_flags & VM_HUGEPAGE)
>>>           return false;
>>> +    /*
>>> +     * Forcing a collapse (e.g., madv_collapse), is a clear advise to
>>
>> advise -> advice.
>>
>>> +     * use THPs.
>>> +     */
>>> +    if (forced_collapse)
>>> +        return false;
>>>       return test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, &vma->vm_mm->flags);
>>>   }
>>>
>>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>>> index 9c1d6e49b8a9..ee4165738779 100644
>>> --- a/include/uapi/linux/prctl.h
>>> +++ b/include/uapi/linux/prctl.h
>>> @@ -185,7 +185,7 @@ struct prctl_mm_map {
>>>   #define PR_SET_THP_DISABLE    41
>>>   /*
>>>    * Don't disable THPs when explicitly advised (e.g., MADV_HUGEPAGE /
>>> - * VM_HUGEPAGE).
>>> + * VM_HUGEPAGE / MADV_COLLAPSE).
>>
>> This is confusing you're mixing VMA flags with MADV ones... maybe just
>> stick to madvise ones, or add extra context around VM_HUGEPAGE bit?
> 
> I don't see anything confusing here, really.
> 
> But if it helps you, we can do
>     (e.g., MADV_HUGEPAGE / VM_HUGEPAGE, MADV_COLLAPSE).
> 
> (reason VM_HUGEPAGE is spelled out is that there might be code where we set VM_HUGEPAGE implicitly in the kernel)
> 
>>
>> Would need to be fixed up in a prior commit obviously.
>>
>>>    */
>>>   # define PR_THP_DISABLE_EXCEPT_ADVISED    (1 << 1)
>>>   #define PR_GET_THP_DISABLE    42
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 85252b468f80..ef5ccb0ec5d5 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -104,7 +104,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>>   {
>>>       const bool smaps = type == TVA_SMAPS;
>>>       const bool in_pf = type == TVA_PAGEFAULT;
>>> -    const bool enforce_sysfs = type != TVA_FORCED_COLLAPSE;
>>> +    const bool forced_collapse = type == TVA_FORCED_COLLAPSE;
>>> +    const bool enforce_sysfs = !forced_collapse;
>>
>> Can we just get rid of this enforce_sysfs altogether in patch 2/5 and use
>> forced_collapse?
> 
> Let's do that as a separate cleanup on top. I want least churn in that patch.
> 
> (had the same idea while writing that patch, but I have other things to focus on than cleaning up all this mess)
> 

I am happy to send this cleanup once this series makes it to mm-new and a new revision is not expected.

Thanks!
Usama

