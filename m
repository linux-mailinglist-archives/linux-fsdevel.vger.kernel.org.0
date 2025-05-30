Return-Path: <linux-fsdevel+bounces-50209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 201E9AC8B87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF2F1BC0063
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D0D221700;
	Fri, 30 May 2025 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OByU6NX2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2644221277;
	Fri, 30 May 2025 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748599049; cv=none; b=ND6AiQM7qAIY/JDbUneBA7JbJLPT5kKjOPbKyp9RyOYkmQhckJoqA7PYWCdEUbe82uF96PSizTwHOERtFJQ+XgBOLEWMws3FGTFZm+69knZJFbps/RF7dh94Za+cMRfMBM2k5ebX1AMxlt24+xUAmeJ3D/aihZLCrQ9DlbPE63E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748599049; c=relaxed/simple;
	bh=6rhTEcOtfuAIsXv/LIanH1QuJFYzArBu/CVVOX98c9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yf97eXF8h3ApRPjieC7M7G1O5FP0SXWoaRi2JOFETsSxIfbMXaH2N+nG1Oqawlb14arV2vmHdon3NueyZJXEImPPE5Pyhd6WRkBeUUnJjQeu69ffwWT6txm+69atjqbhBOKNxZKtNlcw/FghlTYWbhupBE1NsBMxlSw2BmN9fdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OByU6NX2; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748599043; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ybwvx1QHJx3D3UtDCyVd1Dkp/fMn1/UpuqWpEwFvHXQ=;
	b=OByU6NX2ZgQCv9oEn3D7hDaeYGJXM+VnZEiFhh2Kh4gHNrvylMEUyypMFEeFX42VS7jwzwhOVi1vcW6MHIdxrZ8n+BS/ju/HOqg1LC8PddV23K6EnpgvSgsjd5WjUM9foNzxB2QSnTZ05+u/qDBKJ9dR6DCz0Fb/e9SCp8r+SG4=
Received: from 30.74.144.115(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WcL4CT5_1748598724 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 May 2025 17:52:05 +0800
Message-ID: <19faab84-dd8e-4dfd-bf91-80bcb4a34fe8@linux.alibaba.com>
Date: Fri, 30 May 2025 17:52:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fix MADV_COLLAPSE issue if THP settings are disabled
To: David Hildenbrand <david@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, akpm@linux-foundation.org, hughd@google.com
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 dev.jain@arm.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
 <05d60e72-3113-41f0-b81f-225397f06c81@arm.com>
 <f3dad5b5-143d-4896-b315-38e1d7bb1248@redhat.com>
 <9b1bac6c-fd9f-4dc1-8c94-c4da0cbb9e7f@arm.com>
 <abe284a4-db5c-4a5f-b2fd-e28e1ab93ed1@redhat.com>
 <6caefe0b-c909-4692-a006-7f8b9c0299a6@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <6caefe0b-c909-4692-a006-7f8b9c0299a6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/5/30 17:16, David Hildenbrand wrote:
> On 30.05.25 11:10, David Hildenbrand wrote:
>> On 30.05.25 10:59, Ryan Roberts wrote:
>>> On 30/05/2025 09:44, David Hildenbrand wrote:
>>>> On 30.05.25 10:04, Ryan Roberts wrote:
>>>>> On 29/05/2025 09:23, Baolin Wang wrote:
>>>>>> As we discussed in the previous thread [1], the MADV_COLLAPSE will 
>>>>>> ignore
>>>>>> the system-wide anon/shmem THP sysfs settings, which means that 
>>>>>> even though
>>>>>> we have disabled the anon/shmem THP configuration, MADV_COLLAPSE 
>>>>>> will still
>>>>>> attempt to collapse into a anon/shmem THP. This violates the rule 
>>>>>> we have
>>>>>> agreed upon: never means never. This patch set will address this 
>>>>>> issue.
>>>>>
>>>>> This is a drive-by comment from me without having the previous 
>>>>> context, but...
>>>>>
>>>>> Surely MADV_COLLAPSE *should* ignore the THP sysfs settings? It's a 
>>>>> deliberate
>>>>> user-initiated, synchonous request to use huge pages for a range of 
>>>>> memory.
>>>>> There is nothing *transparent* about it, it just happens to be 
>>>>> implemented using
>>>>> the same logic that THP uses.
>>>>>
>>>>> I always thought this was a deliberate design decision.
>>>>
>>>> If the admin said "never", then why should a user be able to 
>>>> overwrite that?
>>>
>>> Well my interpretation would be that the admin is saying never 
>>> *transparently*
>>> give anyone any hugepages; on balance it does more harm than good for my
>>> workloads. The toggle is called transparent_hugepage/enabled, after all.
>>
>> I'd say it's "enabling transparent huge pages" not "transparently
>> enabling huge pages". After all, these things are ... transparent huge
>> pages.
>>
>> But yeah, it's confusing.
>>
>>>
>>> Whereas MADV_COLLAPSE is deliberately applied to a specific region at an
>>> opportune moment in time, presumably because the user knows that the 
>>> region
>>> *will* benefit and because that point in the execution is not 
>>> sensitive to latency.
>>
>> Not sure if MADV_HUGEPAGE is really *that* different.
>>
>>>
>>> I see them as logically separate.
>>>
>>>>
>>>> The design decision I recall is that if VM_NOHUGEPAGE is set, we'll 
>>>> ignore that.
>>>> Because that was set by the app itself (MADV_NOHUEPAGE).

IIUC, MADV_COLLAPSE does not ignore the VM_NOHUGEPAGE setting, if we set 
VM_NOHUGEPAGE, then MADV_COLLAPSE will not be allowed to collapse a THP. 
See:
__thp_vma_allowable_orders() ---> vma_thp_disabled()

>>> Hmm, ok. My instinct would have been the opposite; MADV_NOHUGEPAGE 
>>> means "I
>>> don't want the risk of latency spikes and memory bloat that THP can 
>>> cause". Not
>>> "ignore my explicit requests to MADV_COLLAPSE".
>>>
>>> But if that descision was already taken and that's the current 
>>> behavior then I
>>> agree we have an inconsistency with respect to the sysfs control.
>>>
>>> Perhaps we should be guided by real world usage - AIUI there is a 
>>> cloud that
>>> disables THP at system level today (Google?).
>> The use case I am aware of for disabling it for debugging purposes.
>> Saved us quite some headake in the past at customer sites for
>> troubleshooting + workarounds ...
>>
>>
>> Let's take a look at the man page:
>>
>> MADV_COLLAPSE is  independent  of  any  sysfs  (see  sysfs(5))  setting
>> under  /sys/kernel/mm/transparent_hugepage, both in terms of determining
>> THP eligibility, and allocation semantics.
>>
>> I recall we discussed that it should ignore the 
>> max_ptes_none/swap/shared.
>>
>> But "any" setting would include "enable" ...
> 
> It kind-of contradicts the linked 
> Documentation/admin-guide/mm/transhuge.rst, where we have this 
> *beautiful* comment
> 
> "Transparent Hugepage Support for anonymous memory can be entirely 
> disable (mostly for debugging purposes".
> 
> I mean, "entirely" is also pretty clear to me.

Yes, agree. We have encountered issues caused by THP in our Alibaba 
fleet. The quickest way to stop the bleeding was to disable THP. In such 
case, we do not expect MADV_HUGEPAGE to still collapse a THP.

