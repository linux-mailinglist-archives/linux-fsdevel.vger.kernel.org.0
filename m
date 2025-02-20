Return-Path: <linux-fsdevel+bounces-42166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CAFA3D936
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 12:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D053B0138
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 11:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393911F460D;
	Thu, 20 Feb 2025 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MtMJjsbR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F901EC017
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740052310; cv=none; b=F12mE6Zpe8v+CijlsX8aiRlL5X1HIlMKpZphmPNXKyL5r47TFp2beeke+ghL7j1uIIszUOTMjhaC/VH8ySA/r58ZcEaBqWl+Bz4j4011W1KHCnwKeVr8oWyCiJXJRf4oAsX7ZdWAbFTVjxbugEjCpxa/vNljeHT0mYBupPuc2O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740052310; c=relaxed/simple;
	bh=JFzc4nUr4yZiTe8SSpZhQOKJYx1uM8lgiC5+pr9WSZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8Kd5zh/CG/OwurWbvYOw0GJijCc+ky/9SCZ9CiEPAXd4IWGTy/nU+dcdNQVSPzHOGVXf3bNBmST1LOQ9LWJq0Nq4TdLH+kdtC3sRV4YY4lbFkLLlgxOGTgbXcy7v/8pvLCzwF0Q7hicoPZJN09H59LF9VlFYkdMsAY8iadaCqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MtMJjsbR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740052308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mBr0SgtnHCYiFsBcWQ6weYZTbRdO1rbmjW4f7Sy3Ft8=;
	b=MtMJjsbR+7BXWiKOTkmZUGQTloXLahl3hMbMtY/PiWoCaYAhjP941s4EOpdwLV72tOs8uq
	zJElksTDb8AK+ulhnp6z4d2EMYj0LjVKQGkKFNcfIexktjFnahVMAmVeijVQq8T1tixlgb
	g5/eWmIvsx24QEBLtVQWLwNt6R3AsOg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-eyC2FNO-MQWBAMbG9rUu4A-1; Thu, 20 Feb 2025 06:51:46 -0500
X-MC-Unique: eyC2FNO-MQWBAMbG9rUu4A-1
X-Mimecast-MFC-AGG-ID: eyC2FNO-MQWBAMbG9rUu4A_1740052306
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-438e180821aso4146565e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 03:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740052306; x=1740657106;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mBr0SgtnHCYiFsBcWQ6weYZTbRdO1rbmjW4f7Sy3Ft8=;
        b=RPx17D8NgzKpn4rAsS3fo+MvSjlxKTaF0evWQvoQpURdMCGlnNdSh1HEoc16txBGXb
         RFQCDnUqHPtf9GbdkCV8Sxj7GlgeecRtXLhPR3WBNR67OT9rvR9gY60YJqjld7/t2Xr4
         J3csrJX6saQEKeYn5H/aLewdAP8x7zRMrMaH/6dfBmejNu1dlHxMOScg5pTpFJ+mvNIn
         4IgyIfMXEzUpNX9oaWDRVuo1XFffnbi8BHah6d3+tyXN1MnJV5FXjK8tdTxSrcasRDS0
         S6Y+xKjjyhnr4R4ME+b5EzkHxMoq5EyqZX+Y3l+ePrTLDICGWOaqZhpN9R78aTAdrDyb
         JZow==
X-Forwarded-Encrypted: i=1; AJvYcCUP28BWHH5KnjHLeXya+NcsOnRIJdRh0+yQS4mQyIsYqJjbn2tFFVAyZvI1s6bI9aFbplqjZbL8L38k9zuO@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh2LEt1zlAgP1BlR6V48jM0h/e0HrncaimlfBEjNFJlzB3iROe
	e77SZi0Lw0a36UCynBJDXDpXIxbGrmP4oEE5tsyyvK8ALybYBqwP04nKO3y9f6IO2VmnDD5fBAc
	izBUN2tPAigL87lzgGk8xXi/5T6zCqqBeHm+oDkGqgCaOWM1QUehd3l28y+FgxGo=
X-Gm-Gg: ASbGncsJJ7u/KNvqfL2YfvCQSQIpRiz3qoZMAQR4Ksxe9DikChedovmOX+EljTXv1tY
	pGZ2ogbFKT0EEi1JIoJ7VOG//EkoFzCkhvMKuPaX17LDiyseggx9UI55Ota47iXPtdrOQmSPzyv
	DBmhO0zY3axGl8eyteYeELr3afmznTtA3wz70QJePPKHRIVClCCjVwC25cJq6GJr6Af5eDXJ0im
	PMV+uC2ofwdcViumVd2zaTyZjTpvpo9fm/zdXE8RdjWa5cdLMm4FAqnI5MGJvhVJ6N5S+c4dHoy
	EuvfDT8UQWqPet+NVcnY/j7sLxCZrOhNN9W37yhWEAuuN2KKKT8J9/IDu19b+9scUJ3jeUfuK/H
	R+BqDqQnb/iYyCv5SL5m1G1koVus2kQ==
X-Received: by 2002:a05:600c:548b:b0:439:9a40:a9ff with SMTP id 5b1f17b1804b1-4399a40ac3cmr57546825e9.1.1740052305611;
        Thu, 20 Feb 2025 03:51:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3Q1vBWLy8jITcTBIhMHZsv8pvY8WalvXMgoplaUinz3S7uxyqUT+2Vn++NdI0bj3eRlaAoQ==
X-Received: by 2002:a05:600c:548b:b0:439:9a40:a9ff with SMTP id 5b1f17b1804b1-4399a40ac3cmr57546305e9.1.1740052305138;
        Thu, 20 Feb 2025 03:51:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:2000:e44c:bc46:d8d3:be5? (p200300cbc7062000e44cbc46d8d30be5.dip0.t-ipconnect.de. [2003:cb:c706:2000:e44c:bc46:d8d3:be5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43985c50397sm113532355e9.0.2025.02.20.03.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 03:51:43 -0800 (PST)
Message-ID: <f720d914-3d66-42a9-a65c-dbdd58d5bccd@redhat.com>
Date: Thu, 20 Feb 2025 12:51:41 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 19/20] fs/dax: Properly refcount fs dax pages
To: Alistair Popple <apopple@nvidia.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, linux-mm@kvack.org,
 Alison Schofield <alison.schofield@intel.com>, lina@asahilina.net,
 zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
 loongarch@lists.linux.dev
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
 <b33a5b2e03ffb6dbcfade84788acdd91d10fbc51.1739850794.git-series.apopple@nvidia.com>
 <cb29f96f-f222-4c94-9c67-c2d4bffeb654@redhat.com>
 <jf6hr2uzyz76axd62v6czy3wzcuu4eb7ydow5mznehfuiwhqq3@2q7easkxhdp4>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <jf6hr2uzyz76axd62v6czy3wzcuu4eb7ydow5mznehfuiwhqq3@2q7easkxhdp4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> -static inline unsigned long dax_folio_share_put(struct folio *folio)
>>> +static inline unsigned long dax_folio_put(struct folio *folio)
>>>    {
>>> -	return --folio->page.share;
>>> +	unsigned long ref;
>>> +	int order, i;
>>> +
>>> +	if (!dax_folio_is_shared(folio))
>>> +		ref = 0;
>>> +	else
>>> +		ref = --folio->share;
>>> +
>>
>> out of interest, what synchronizes access to folio->share?
> 
> Actually that's an excellent question as I hadn't looked too closely at this
> given I wasn't changing the overall flow with regards to synchronization, merely
> representation of the "shared" state. So I don't have a good answer for you off
> the top of my head - Dan maybe you can shed some light here?

Not that I understand what that dax-shared thing is or does, but the 
non-atomic update on a folio_put path looked "surprising".

>>> diff --git a/include/linux/dax.h b/include/linux/dax.h
>>> index 2333c30..dcc9fcd 100644
>>> --- a/include/linux/dax.h
>>> +++ b/include/linux/dax.h
>>> @@ -209,7 +209,7 @@ int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>>
>> [...]
>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index d189826..1a0d6a8 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -2225,7 +2225,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>>    						tlb->fullmm);
>>>    	arch_check_zapped_pmd(vma, orig_pmd);
>>>    	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
>>> -	if (vma_is_special_huge(vma)) {
>>> +	if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
>>
>> I wonder if we actually want to remove the vma_is_dax() check from
>> vma_is_special_huge(), and instead add it to the remaining callers of
>> vma_is_special_huge() that still need it -- if any need it.
>>
>> Did we sanity-check which callers of vma_is_special_huge() still need it? Is
>> there still reason to have that DAX check in vma_is_special_huge()?
> 
> If by "we" you mean "me" then yes :) There are still a few callers of it, mainly
> for page splitting.

Heh, "you or any of the reviewers" :)

So IIUC, the existing users still need the DAX check I assume (until 
that part is cleaned up, below).

> 
>> But vma_is_special_huge() is rather confusing from me ... the whole
>> vma_is_special_huge() thing should probably be removed. That's a cleanup for
>> another day, though.
> 
> But after double checking I have come to the same conclusion as you - it should
> be removed. I will add that to my ever growing clean-up series that can go on
> top of this one.

Nice!

-- 
Cheers,

David / dhildenb


