Return-Path: <linux-fsdevel+bounces-50120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29CFAC8614
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 03:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CADE4A496F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 01:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7DD190067;
	Fri, 30 May 2025 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U0rOzYHx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FA9C2FB;
	Fri, 30 May 2025 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748569916; cv=none; b=McWCiTl/hOMn/oXWvzVg1JWNJq/ksVE2NQ3MUTXbodlwJmu7sKztyjWrsZ0kV4N3gGAOO4SjEuwwHFwkFIQx7uHJf6s6DdycgrvI5GneH0IL11Tnioyb+50ZJIFQi523xPut8uK5nkVyyuN0PAPM+OvV60zaLxxPTi7q4GnyhS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748569916; c=relaxed/simple;
	bh=ksk3ssKgBp7lYsUroBH/982d390RZjFceA3xEzjA4Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBxPBo7A4RC0m39KJUEQl2wJt6oQcn6kV/5Kik6iYIKOk/fqnlTLQ8r0jEwC4J2/oThMDR+P9v3IQVIX6c85qnXZu9UeYVmOtpxSnQWbxpdI28Lb68Wb5l+vpLhD0t/LN5VbvBArTyIfMfI7If4sNoToMSiF9cC9lV4he03e7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U0rOzYHx; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748569910; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vnZC1rQ0fxZWfqF2Uv901r4Mxjs+2QHPQnmoHX7l9ac=;
	b=U0rOzYHxjJ2uk0COprcuJek7zSbutpnTHa6rCp66OHoOrA/pAelJsM1WSFj4Eog50FgzPjNeimK1vd1zsRXoD8ZzsdytTiohOxRBz6pPLT/oSw49tDGqSNu4tb7FeYeT5nZMcrL14wdnT53mqD08Ypf49ORATHYQVk2SkmJwTqE=
Received: from 30.74.144.115(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WcJPkbk_1748569907 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 May 2025 09:51:49 +0800
Message-ID: <5acbfc5f-81b6-40e2-b87b-ac50423172f0@linux.alibaba.com>
Date: Fri, 30 May 2025 09:51:46 +0800
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <33577DDE-D88E-44F9-9B91-7AA46EACCCE8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/5/29 23:10, Zi Yan wrote:
> On 29 May 2025, at 4:23, Baolin Wang wrote:
> 
>> The MADV_COLLAPSE will ignore the system-wide Anon THP sysfs settings, which
>> means that even though we have disabled the Anon THP configuration, MADV_COLLAPSE
>> will still attempt to collapse into a Anon THP. This violates the rule we have
>> agreed upon: never means never.
>>
>> To address this issue, should check whether the Anon THP configuration is disabled
>> in thp_vma_allowable_orders(), even when the TVA_ENFORCE_SYSFS flag is set.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   include/linux/huge_mm.h | 23 +++++++++++++++++++----
>>   1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 2f190c90192d..199ddc9f04a1 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -287,20 +287,35 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>>   				       unsigned long orders)
>>   {
>>   	/* Optimization to check if required orders are enabled early. */
>> -	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
>> -		unsigned long mask = READ_ONCE(huge_anon_orders_always);
>> +	if (vma_is_anonymous(vma)) {
>> +		unsigned long always = READ_ONCE(huge_anon_orders_always);
>> +		unsigned long madvise = READ_ONCE(huge_anon_orders_madvise);
>> +		unsigned long inherit = READ_ONCE(huge_anon_orders_inherit);
>> +		unsigned long mask = always | madvise;
>> +
>> +		/*
>> +		 * If the system-wide THP/mTHP sysfs settings are disabled,
>> +		 * then we should never allow hugepages.
>> +		 */
>> +		if (!(mask & orders) && !(hugepage_global_enabled() && (inherit & orders)))
> 
> Can you explain the logic here? Is it equivalent to:
> 1. if THP is set to always, always_mask & orders == 0, or
> 2. if THP if set to madvise, madvise_mask & order == 0, or
> 3. if THP is set to inherit, inherit_mask & order == 0?
> 
> I cannot figure out why (always | madvise) & orders does not check
> THP enablement case, but inherit & orders checks hugepage_global_enabled().

Sorry for not being clear. Let me try again:

Now we can control per-sized mTHP through ‘huge_anon_orders_always’, so 
always does not need to rely on the check of hugepage_global_enabled().

For madvise, referring to David's suggestion: “allowing for collapsing 
in a VM without VM_HUGEPAGE in the "madvise" mode would be fine", so we 
can just check 'huge_anon_orders_madvise' without relying on 
hugepage_global_enabled().

In the case where hugepage_global_enabled() is enabled, we need to check 
whether the 'inherit' has enabled the corresponding orders.

In summary, the current strategy is:

1. If always & orders == 0, and madvise & orders == 0, and 
hugepage_global_enabled() == false (global THP settings are not 
enabled), it means mTHP of the orders are prohibited from being used, 
then madvise_collapse() is forbidden.

2. If always & orders == 0, and madvise & orders == 0, and 
hugepage_global_enabled() == true (global THP settings are enabled), and 
inherit & orders == 0, it means mTHP of the orders are still prohibited 
from being used, and thus madvise_collapse() is not allowed.

