Return-Path: <linux-fsdevel+bounces-56422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5435FB1737F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 16:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6781B17145B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604AA1CF5C0;
	Thu, 31 Jul 2025 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTZXeG+x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1877D18E25
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973686; cv=none; b=JO3+Bu6vjs4NVsXUmdTLLSz+ZZmgMrR1yXTM4uUHcSTAuCQwtmc2LE2JKvYSOve+h/vYCBKEibHDWqcXsJODKqHnM3k/C9m7ZODMhxHwMGqKu4fi8rNhtrn44pT/xeF2mSmCK2vFxnNo1rYkYHg6RngKiOde7FoGi6uWdD3Nly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973686; c=relaxed/simple;
	bh=UJaDoUN8az5yBcxGprRm1+zJ4BUxFszBTB0G2xgRuvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBvDnc2vaTgjTmQFryVrzDgNPPG4alEBqfowc6BmQbowzyECJNu3hccDbhhQ4wxNd9i5zUs7nlmNP0Oq5F5WBRxtFSzk9zU3w076L0maWrYbLGnNfylsDon4Ftm9nxNFiLp6S3KNW3aud+FtZBzQ3bOcBuI4MwE80MC9cGGIEgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTZXeG+x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753973684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pcdAMsNdTAq+2YkeVqnBXkNfuDQDM55vEhbjhHl9CYA=;
	b=RTZXeG+xfinbhit8Sv1Ob6pBuNWRDb5db+uAgQ3zAPz9pd3vqo/eOyCMILUoPk7TDOQT/e
	Fx89MsiOVSfK4MhhD1IL2PlEzZQR23tpBvYdbAOUaOgC42jjOIixWapptnrqA/0TjUCYhS
	2gBVTrlJxll8JUKe4uZcLZ8pGPVIRHY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-Zjkq9iFgOdGQecNyRotEOg-1; Thu, 31 Jul 2025 10:54:42 -0400
X-MC-Unique: Zjkq9iFgOdGQecNyRotEOg-1
X-Mimecast-MFC-AGG-ID: Zjkq9iFgOdGQecNyRotEOg_1753973681
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b20f50da27so876097f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 07:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753973681; x=1754578481;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pcdAMsNdTAq+2YkeVqnBXkNfuDQDM55vEhbjhHl9CYA=;
        b=r9gT7GbJojLkRZHKRTFFpA7L+H+RsCMgrBlDgqHUW8FBxbJgZZrBm8U7UG8dDeIhwJ
         6KBLjj7X50ocBkeo7FqsY1eesuysa2cYyz+rs0LoAo7G4Wwj5DfAcJc0MmS9bfI0FxVi
         QJcQf99WUMWTRzoxG+3wvtP06BtElvlSNaOT6l6YkvjJkhdpg3JmRPJ/avGmZc6qZ4qV
         IjhBAVRDq3XOxHq6+CswmEsM6Mv9W9ZXP0cnD+QxDT8PUem5knu+S31d5D1tfhxyI7Oy
         p4iKEqAgWDjB2zTFvIWYw3V4VPwjTuJiNZSR7KOFj5JxA542+VPEocILxtxOJ61jhri3
         wFwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIIn3e+kG7c26mNeI2yCXCwpQ7nZJAwGDXHBUv6bUUKcLDIYKiShQxZ9FwBA9HtFqYuajniwRWRgN4fg5W@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+IgTO1mOEozu3ga6gHRD7LOGzx8orrYrOmV3o6iON70vwBDLs
	dVKA32ezVNvC66jZ0X7xJO6Ka+jruU+epxcQ+g6omK88omLet6rtonrBrFX6J93OSjcKnONtQXm
	3QPd2ujHRxAF6njcBCjAkk0HlsFY/Vxux5iEhnd70XStBW58Rrz5jwIT8K4UPIRdRqB+52fjScb
	rs1Q==
X-Gm-Gg: ASbGncsTEw3Htkot3iysmB8w1HGFoWRPJK4MmZ1gbt3fnhHt3CWT8gHsdNUTPmJzeYa
	rnskwPsoy/fVkC6hIWdOcAuqgGYPGOpjJBcUf4b6wgGAVmbBpEjabomIUa1qY1zqZvnpl5I61Nj
	y1Yz5ch45ykfD2C2OJqjPYHGaoblS3P43VrcL1rdOsqM18Bzb3KlZlvzzf/zftShB+EbUiBJv1r
	Rqb1dcZGXCo949Jzwk9t1WTOnriG3k78WIk4xR17ljWY5vza7FDubm/K8xuexe8EEDTdN+ViwR9
	X2XjhH4qseScdzLhU2p30FrQc0mgCrKwVR9Kazz5XUShTrCUB+uc5nX7wN6EEFlQiLuQSXHNm2g
	FUzfudk5cPVECPrEe77v/lRqfWeyPgvDV0C7/8T6OJIjs6On5Z6QbFeWiyvpcjaI+1bQ=
X-Received: by 2002:a05:6000:40db:b0:3b6:d0d:79c1 with SMTP id ffacd0b85a97d-3b79d4511a7mr2179869f8f.10.1753973681025;
        Thu, 31 Jul 2025 07:54:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGrPbQGx33zdyJHrEf2Jq33PS0AoKLgTX83/f0Zaxy9JX7aFfl5pg+H/UR1tcX8OOa7Lu1kA==
X-Received: by 2002:a05:6000:40db:b0:3b6:d0d:79c1 with SMTP id ffacd0b85a97d-3b79d4511a7mr2179833f8f.10.1753973680340;
        Thu, 31 Jul 2025 07:54:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f44:3700:be07:9a67:67f7:24e6? (p200300d82f443700be079a6767f724e6.dip0.t-ipconnect.de. [2003:d8:2f44:3700:be07:9a67:67f7:24e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953cfe56sm72071135e9.20.2025.07.31.07.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 07:54:39 -0700 (PDT)
Message-ID: <747509a6-8493-46c3-99d4-38b53a8a7504@redhat.com>
Date: Thu, 31 Jul 2025 16:54:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm/huge_memory: treat MADV_COLLAPSE as an advise
 with PR_THP_DISABLE_EXCEPT_ADVISED
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Usama Arif <usamaarif642@gmail.com>
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aca74036-f37f-4247-b3b8-112059f53659@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.07.25 16:38, Lorenzo Stoakes wrote:
> Nits on subject:
> 
> - It's >75 chars

No big deal. If we cna come up with something shorter, good.

> - advise is the verb, advice is the noun.

Yeah.

> 
> On Thu, Jul 31, 2025 at 01:27:20PM +0100, Usama Arif wrote:
>> From: David Hildenbrand <david@redhat.com>
>>
>> Let's allow for making MADV_COLLAPSE succeed on areas that neither have
>> VM_HUGEPAGE nor VM_NOHUGEPAGE when we have THP disabled
>> unless explicitly advised (PR_THP_DISABLE_EXCEPT_ADVISED).
> 
> Hmm, I'm not sure about this.
> 
> So far this prctl() has been the only way to override MADV_COLLAPSE
> behaviour, but now we're allowing for this one case to not.

This is not an override really. prctl() disallowed MADV_COLLAPSE, but in 
the new mode we don't want that anymore.

 > > I suppose the precedent is that MADV_COLLAPSE overrides 'madvise' sysfs
> behaviour.
 > > I suppose what saves us here is 'advised' can be read to mean either
> MADV_HUGEPAGE or MADV_COLLAPSE.
 > > And yes, MADV_COLLAPSE is clearly the user requesting this behaviour.

Exactly.

> 
> I think the vagueness here is one that already existed, because one could
> perfectly one have expected MADV_COLLAPSE to obey sysfs and require
> MADV_HUGEPAGE to have been applied, but of course this is not the case.

Yes.

> 
> OK so fine.
> 
> BUT.
> 
> I think the MADV_COLLAPSE man page will need to be updated to mention this.
> 

Yes.

> And I REALLY think we should update the THP doc too to mention all these
> prctl() modes.
> 
> I'm not sure we cover that right now _at all_ and obviously we should
> describe the new flags.
> 
> Usama - can you add a patch to this series to do that?

Good point, let's document the interaction with prctl().

> 
>>
>> MADV_COLLAPSE is a clear advise that we want to collapse.
> 
> advise -> advice.
> 
>>
>> Note that we still respect the VM_NOHUGEPAGE flag, just like
>> MADV_COLLAPSE always does. So consequently, MADV_COLLAPSE is now only
>> refused on VM_NOHUGEPAGE with PR_THP_DISABLE_EXCEPT_ADVISED.
> 
> You also need to mention the shmem change you've made I think.

Yes.

 > >>
>> Co-developed-by: Usama Arif <usamaarif642@gmail.com>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/linux/huge_mm.h    | 8 +++++++-
>>   include/uapi/linux/prctl.h | 2 +-
>>   mm/huge_memory.c           | 5 +++--
>>   mm/memory.c                | 6 ++++--
>>   mm/shmem.c                 | 2 +-
>>   5 files changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index b0ff54eee81c..aeaf93f8ac2e 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -329,7 +329,7 @@ struct thpsize {
>>    * through madvise or prctl.
>>    */
>>   static inline bool vma_thp_disabled(struct vm_area_struct *vma,
>> -		vm_flags_t vm_flags)
>> +		vm_flags_t vm_flags, bool forced_collapse)
>>   {
>>   	/* Are THPs disabled for this VMA? */
>>   	if (vm_flags & VM_NOHUGEPAGE)
>> @@ -343,6 +343,12 @@ static inline bool vma_thp_disabled(struct vm_area_struct *vma,
>>   	 */
>>   	if (vm_flags & VM_HUGEPAGE)
>>   		return false;
>> +	/*
>> +	 * Forcing a collapse (e.g., madv_collapse), is a clear advise to
> 
> advise -> advice.
> 
>> +	 * use THPs.
>> +	 */
>> +	if (forced_collapse)
>> +		return false;
>>   	return test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, &vma->vm_mm->flags);
>>   }
>>
>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>> index 9c1d6e49b8a9..ee4165738779 100644
>> --- a/include/uapi/linux/prctl.h
>> +++ b/include/uapi/linux/prctl.h
>> @@ -185,7 +185,7 @@ struct prctl_mm_map {
>>   #define PR_SET_THP_DISABLE	41
>>   /*
>>    * Don't disable THPs when explicitly advised (e.g., MADV_HUGEPAGE /
>> - * VM_HUGEPAGE).
>> + * VM_HUGEPAGE / MADV_COLLAPSE).
> 
> This is confusing you're mixing VMA flags with MADV ones... maybe just
> stick to madvise ones, or add extra context around VM_HUGEPAGE bit?

I don't see anything confusing here, really.

But if it helps you, we can do
	(e.g., MADV_HUGEPAGE / VM_HUGEPAGE, MADV_COLLAPSE).

(reason VM_HUGEPAGE is spelled out is that there might be code where we 
set VM_HUGEPAGE implicitly in the kernel)

> 
> Would need to be fixed up in a prior commit obviously.
> 
>>    */
>>   # define PR_THP_DISABLE_EXCEPT_ADVISED	(1 << 1)
>>   #define PR_GET_THP_DISABLE	42
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 85252b468f80..ef5ccb0ec5d5 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -104,7 +104,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>   {
>>   	const bool smaps = type == TVA_SMAPS;
>>   	const bool in_pf = type == TVA_PAGEFAULT;
>> -	const bool enforce_sysfs = type != TVA_FORCED_COLLAPSE;
>> +	const bool forced_collapse = type == TVA_FORCED_COLLAPSE;
>> +	const bool enforce_sysfs = !forced_collapse;
> 
> Can we just get rid of this enforce_sysfs altogether in patch 2/5 and use
> forced_collapse?

Let's do that as a separate cleanup on top. I want least churn in that 
patch.

(had the same idea while writing that patch, but I have other things to 
focus on than cleaning up all this mess)

-- 
Cheers,

David / dhildenb


