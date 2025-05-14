Return-Path: <linux-fsdevel+bounces-48973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA0EAB6FF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 17:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202543BC5C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 15:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEA21F1931;
	Wed, 14 May 2025 15:31:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40631DED6F;
	Wed, 14 May 2025 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747236699; cv=none; b=pXEc8bjWigzJH0eal7pIhIJb5PZD3iwrE4MxIXyuSzLnaAI7uhMTaY97Ntoidd9EzzEVAm1zgdyFNbSd7zHKyQzAQrBZ2TMRmHAB9yDw0JDGNPovcQLugDQtXNQVwYlx2W5QcmB54kfQnjgWoiYSf6AzYLrCsPVFi3BHFgh0Gc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747236699; c=relaxed/simple;
	bh=xqJWKUGqmyqxS6gBUEsrfrsWb3T0VTFFocyiRBfIyWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDB3fWbMAOmsbeeqwhNI9mN9Xid6Jf+bqVnjIDKLe1WLEtAAqpa9G+q+bWm7T9QWFq5sD7qNE9IyvMtQFTyafaLmXfxfGU13q0yQCh5RWCtHm9311ibwyvuE+3MCWazGxxLAI83sh+dH6p7EnQiS8SUoepYzCsE/VpMFxKJ4NOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8782150C;
	Wed, 14 May 2025 08:31:24 -0700 (PDT)
Received: from [10.57.91.10] (unknown [10.57.91.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A34F3F5A1;
	Wed, 14 May 2025 08:31:33 -0700 (PDT)
Message-ID: <933f4191-4075-4b02-998a-35b1711e778c@arm.com>
Date: Wed, 14 May 2025 16:31:31 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 5/5] mm/filemap: Allow arch to request folio size
 for exec memory
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <david@fromorbit.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-6-ryan.roberts@arm.com>
 <20250509135223.GB5707@willie-the-truck>
 <c52861ac-9622-4d4f-899e-3a759f04af12@arm.com>
 <20250514151400.GB10762@willie-the-truck>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250514151400.GB10762@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/05/2025 16:14, Will Deacon wrote:
> On Tue, May 13, 2025 at 01:46:06PM +0100, Ryan Roberts wrote:
>> On 09/05/2025 14:52, Will Deacon wrote:
>>> On Wed, Apr 30, 2025 at 03:59:18PM +0100, Ryan Roberts wrote:
>>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>>> index e61f374068d4..37fe4a55c00d 100644
>>>> --- a/mm/filemap.c
>>>> +++ b/mm/filemap.c
>>>> @@ -3252,14 +3252,40 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>>>>  	if (mmap_miss > MMAP_LOTSAMISS)
>>>>  		return fpin;
>>>>  
>>>> -	/*
>>>> -	 * mmap read-around
>>>> -	 */
>>>>  	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>>>> -	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
>>>> -	ra->size = ra->ra_pages;
>>>> -	ra->async_size = ra->ra_pages / 4;
>>>> -	ra->order = 0;
>>>> +	if (vm_flags & VM_EXEC) {
>>>> +		/*
>>>> +		 * Allow arch to request a preferred minimum folio order for
>>>> +		 * executable memory. This can often be beneficial to
>>>> +		 * performance if (e.g.) arm64 can contpte-map the folio.
>>>> +		 * Executable memory rarely benefits from readahead, due to its
>>>> +		 * random access nature, so set async_size to 0.
>>>
>>> In light of this observation (about randomness of instruction fetch), do
>>> you think it's worth ignoring VM_RAND_READ for VM_EXEC?
>>
>> Hmm, yeah that makes sense. Something like:
>>
>> ---8<---
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 7b90cbeb4a1a..6c8bf5116c54 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -3233,7 +3233,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault
>> *vmf)
>>         if (!ra->ra_pages)
>>                 return fpin;
>>
>> -       if (vm_flags & VM_SEQ_READ) {
>> +       /* VM_EXEC case below is already intended for random access */
>> +       if ((vm_flags & (VM_SEQ_READ | VM_EXEC)) == VM_SEQ_READ) {
>>                 fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>>                 page_cache_sync_ra(&ractl, ra->ra_pages);
>>                 return fpin;
>> ---8<---
> 
> I was thinking about the:
> 
> 	if (vm_flags & VM_RAND_READ)
> 		return fpin;

Yes sorry, I lost my mind when doing that patch... I intended to do it for the
VM_RAND_READ as you suggested, but my fingers did something completely different.

> 
> code above this which bails if VM_RAND_READ is set. That seems contrary
> to the code you're adding which says that, even for random access
> patterns where readahead doesn't help, it's still worth sizing the folio
> appropriately for contpte mappings.

Anyway, I totally agree with this. So I'll avoid the early return VM_RAND_READ
if VM_EXEC is also set.

Thanks,
Ryan

> 
> Will


