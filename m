Return-Path: <linux-fsdevel+bounces-50124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 511F3AC8638
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 04:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6077ACC2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 02:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D954E190472;
	Fri, 30 May 2025 02:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NHrikVz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC9813E02D;
	Fri, 30 May 2025 02:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748571719; cv=none; b=riGPwns85UCN3p45B4aLNiJB9RM20N/PobMmRQrUASbVCGBydxH86CNVoVhJ3mDZksWrbqDH2O1sUV5H+37CJM+lJd4Li4TYdElCCj1y52Qh8ebS2NBKH4gktpigqntUagJVLr5Fz+vaPSehGqVGDN9ghkdZK7CEqvqmT0GHryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748571719; c=relaxed/simple;
	bh=Dck1uj/Mlc6MiTFQzdBAM9XV0e9tGd6ilGV1giixwbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xx4sAjfw7KyOibn8wlG2w/0CQHJa0/vsRro4fCOoEM1ugN2PgHp017Yo3AE+vgtZMaZFX+WaNlxGcdkQc4Q4S3oRSPuHBXlceSXP6MsLB/WIiWTGa67VTDTnJZMHf9Q75WCgs8k0bp3QHBjnenMCTo8tXHJ4zGxx9gU7snV4fgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NHrikVz+; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748571713; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Yy3kIHxx5/LnrMKyzlqg4z9R4jj9NR3RwJABm/7606U=;
	b=NHrikVz+USLM+Eqxgd6Zu+dqtKv5IfLn6AQySyMiFjFRMHLIH0s5QJtr6n7OSWrSrRGb3plOrIKUQuYNqZThyonixtAMRniKZSPXaCiiZ5dxJdWOPd/dLQ3gH5pI6VU4S7yydtMuRSKyrctFDRYbyUPlps5lrfkZYoJBWGnXd78=
Received: from 30.74.144.115(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WcJWIqA_1748571712 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 May 2025 10:21:53 +0800
Message-ID: <31b4bc9e-06fc-4879-be2c-aedea3173f54@linux.alibaba.com>
Date: Fri, 30 May 2025 10:21:52 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: huge_memory: disallow hugepages if the
 system-wide THP sysfs settings are disabled
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
 <d97a9e359ae914e788867b263bb9737afcd3d59d.1748506520.git.baolin.wang@linux.alibaba.com>
 <33577DDE-D88E-44F9-9B91-7AA46EACCCE8@nvidia.com>
 <5acbfc5f-81b6-40e2-b87b-ac50423172f0@linux.alibaba.com>
 <E330B371-C7DC-4E79-9043-56F4AA9BBE54@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <E330B371-C7DC-4E79-9043-56F4AA9BBE54@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/5/30 10:04, Zi Yan wrote:
> On 29 May 2025, at 21:51, Baolin Wang wrote:
> 
>> On 2025/5/29 23:10, Zi Yan wrote:
>>> On 29 May 2025, at 4:23, Baolin Wang wrote:
>>>
>>>> The MADV_COLLAPSE will ignore the system-wide Anon THP sysfs settings, which
>>>> means that even though we have disabled the Anon THP configuration, MADV_COLLAPSE
>>>> will still attempt to collapse into a Anon THP. This violates the rule we have
>>>> agreed upon: never means never.
>>>>
>>>> To address this issue, should check whether the Anon THP configuration is disabled
>>>> in thp_vma_allowable_orders(), even when the TVA_ENFORCE_SYSFS flag is set.
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>>    include/linux/huge_mm.h | 23 +++++++++++++++++++----
>>>>    1 file changed, 19 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>> index 2f190c90192d..199ddc9f04a1 100644
>>>> --- a/include/linux/huge_mm.h
>>>> +++ b/include/linux/huge_mm.h
>>>> @@ -287,20 +287,35 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>>>>    				       unsigned long orders)
>>>>    {
>>>>    	/* Optimization to check if required orders are enabled early. */
>>>> -	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
>>>> -		unsigned long mask = READ_ONCE(huge_anon_orders_always);
>>>> +	if (vma_is_anonymous(vma)) {
>>>> +		unsigned long always = READ_ONCE(huge_anon_orders_always);
>>>> +		unsigned long madvise = READ_ONCE(huge_anon_orders_madvise);
>>>> +		unsigned long inherit = READ_ONCE(huge_anon_orders_inherit);
>>>> +		unsigned long mask = always | madvise;
>>>> +
>>>> +		/*
>>>> +		 * If the system-wide THP/mTHP sysfs settings are disabled,
>>>> +		 * then we should never allow hugepages.
>>>> +		 */
>>>> +		if (!(mask & orders) && !(hugepage_global_enabled() && (inherit & orders)))
>>>
>>> Can you explain the logic here? Is it equivalent to:
>>> 1. if THP is set to always, always_mask & orders == 0, or
>>> 2. if THP if set to madvise, madvise_mask & order == 0, or
>>> 3. if THP is set to inherit, inherit_mask & order == 0?
>>>
>>> I cannot figure out why (always | madvise) & orders does not check
>>> THP enablement case, but inherit & orders checks hugepage_global_enabled().
>>
>> Sorry for not being clear. Let me try again:
>>
>> Now we can control per-sized mTHP through ‘huge_anon_orders_always’, so always does not need to rely on the check of hugepage_global_enabled().
>>
>> For madvise, referring to David's suggestion: “allowing for collapsing in a VM without VM_HUGEPAGE in the "madvise" mode would be fine", so we can just check 'huge_anon_orders_madvise' without relying on hugepage_global_enabled().
> 
> Got it. Setting always or madvise knob in per-size mTHP means user wants to
> enable that size, so their orders are not limited by the global config.
> Setting inherit means user wants to follow the global config.
> Now it makes sense to me. I wonder if renaming inherit to inherit_global
> and huge_anon_orders_inherit to huge_anon_orders_inherit_global
> could make code more clear (We cannot change sysfs names, but changing
> kernel variable names should be fine?).

The 'huge_anon_orders_inherit' is also a per-size mTHP interface. See 
the doc:
"
Alternatively it is possible to specify that a given hugepage size
will inherit the top-level "enabled" value::

         echo inherit 
 >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
"

The 'inherit' already implies that it is meant to inherit the top-level 
'enabled' value, so I personally still prefer the variable name 
'inherit', just as we use it elsewhere.

>> In the case where hugepage_global_enabled() is enabled, we need to check whether the 'inherit' has enabled the corresponding orders.
>>
>> In summary, the current strategy is:
>>
>> 1. If always & orders == 0, and madvise & orders == 0, and hugepage_global_enabled() == false (global THP settings are not enabled), it means mTHP of the orders are prohibited from being used, then madvise_collapse() is forbidden.
>>
>> 2. If always & orders == 0, and madvise & orders == 0, and hugepage_global_enabled() == true (global THP settings are enabled), and inherit & orders == 0, it means mTHP of the orders are still prohibited from being used, and thus madvise_collapse() is not allowed.
> 
> Putting the summary in the comment might be very helpful. WDYT?

Sure. will do.

> Otherwise, the patch looks good to me. Thanks.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks.

