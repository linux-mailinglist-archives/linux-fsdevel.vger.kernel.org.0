Return-Path: <linux-fsdevel+bounces-19211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A76D8C144E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 19:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB741F213B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 17:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B6D770E3;
	Thu,  9 May 2024 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKc/J3k0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F684FBFD
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715276933; cv=none; b=T0LQZG5WJYCxFJUbmGm2Zu5Jv2FeAf5mL0DCxf/k/zdolZUb34AvmQXKJCpZ/te9u7AMHeeTg1F1pMWZIIE2A4G26x/K/RT/uCZA0bafxZpZOHzekGL1hBKwxLqKdFXbPIo1ufG3jJ5+qqA6SgYVrRYjY7kDCf7vco2zKp50qsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715276933; c=relaxed/simple;
	bh=fjrIqfLCcacQIwwbkR6Q2FTSjkEoTu7mJkxVdALUiT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8fHQXi07QbvCDdTtsjZXLo3wgpopROta17lVj48YbuJOcm4OSks7M83y7fOtL17W5biU6BfFHr0ReL5SdvWcT94jL6IFDYbCoBexhGTBb3SRAiSAfL7Tltlla6FGpoWAry6W01SEBtnwm477ojeNQmDehxwhpfUq1OWE+72Las=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKc/J3k0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715276931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CcvU8eoRJ3v3bJAMRLSLp1zquftLdgbiPZewW3s0bAc=;
	b=AKc/J3k0UfkQEyRkU7Pa26Ac9DYPGCgXkBdExmK6zZhSSwx7TadJwDC3S8c6Tsvwp0Nd/k
	tatPp0FdBonU3LcG30rk2sa/4j8NYTCanwJ4UDt9gymkrEISKiSvcfyOzobxZAZY5W9VFZ
	701vSZRMLL7Fy5+4DVbMKh9E74x0Y4g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-jHOewQS4Ndm74lVbx3ei6A-1; Thu, 09 May 2024 13:48:49 -0400
X-MC-Unique: jHOewQS4Ndm74lVbx3ei6A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34eb54c888cso821563f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2024 10:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715276929; x=1715881729;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CcvU8eoRJ3v3bJAMRLSLp1zquftLdgbiPZewW3s0bAc=;
        b=QEuDo/nV3EnAoUntRk7me+gvbhMgHKb/wRAq0fjhLkUNUnZ4HsfIc988ALflpTkxJ5
         y/fyEcbUFBTAMVSMaE66QVcsiJB4Wai6K5D+erqFCE0N9CWrlEmxtqOUqLKgebhtxi1R
         L9nNm/bq8BJQAaFuBXHUagEwoa3VYCmGAvzdoHhVk1rW5ySOHl01cBEWVr7Z5HSi7UdV
         Ec/0dBB5lqylT0fHTl9PC6SuPVT/tXZ+o15Un5MZLvmJJPkxTE6iw6HLAs9U4BmId8nm
         Kt2RRrwdSf/LwcifGPYwsDniYxD6KDeb4tTFs+yIDOHwp5Yds56L3/2fX1NHQTv2gESA
         jLww==
X-Forwarded-Encrypted: i=1; AJvYcCWQHREGia9tJpDd2FU6xFn/KM+KHus9LlJRBBKmnLxgTmbeRTav+2fzadQFVBcj3tN5M01ar4H87Reh9krkYf/c4zZfSe1QD+5ZBzpbGw==
X-Gm-Message-State: AOJu0YztE6m3Qv+fIb2Y9jOOGXTOXlZGfEAPP3boeSod48EO+B9QBxg9
	zsBih4iNevtFVNbXh/OsKponpQQPZCI8PrDUNFR/pWzxMiYPsb7XQHpXuYPXlXhL3c2zkUkbkfP
	tFVCzj77zwDtR5R/P6OHX1/e+5SnOTdqiIBqyteGSN8XNkFHZJhsUW40kOpIGwhE=
X-Received: by 2002:a5d:4fd0:0:b0:34b:dc21:68f2 with SMTP id ffacd0b85a97d-3504a738229mr299187f8f.28.1715276928740;
        Thu, 09 May 2024 10:48:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTnBUYUYuejfPBLLY8ZBtOjJentIBku5CpcFcyXBHDwatUcM7ykUFg7cpEbk2afbnfdUiNFQ==
X-Received: by 2002:a5d:4fd0:0:b0:34b:dc21:68f2 with SMTP id ffacd0b85a97d-3504a738229mr299154f8f.28.1715276928297;
        Thu, 09 May 2024 10:48:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c716:7600:ac6:a414:3c04:6f5a? (p200300cbc71676000ac6a4143c046f5a.dip0.t-ipconnect.de. [2003:cb:c716:7600:ac6:a414:3c04:6f5a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbbde1sm2279992f8f.97.2024.05.09.10.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 10:48:47 -0700 (PDT)
Message-ID: <23ea6dbd-1d4e-4aeb-900b-646db880cfb6@redhat.com>
Date: Thu, 9 May 2024 19:48:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] add mTHP support for anonymous shmem
To: Luis Chamberlain <mcgrof@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, Christoph Lameter <christoph@lameter.com>,
 Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>
Cc: Daniel Gomez <da.gomez@samsung.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "ioworker0@gmail.com" <ioworker0@gmail.com>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <CGME20240508113934eucas1p13a3972f3f9955365f40155e084a7c7d5@eucas1p1.samsung.com>
 <fqtaxc5pgu3zmvbdad4w6xty5iozye7v5z2b5ckqcjv273nz7b@hhdrjwf6rai3>
 <f44dc19a-e117-4418-9114-b723c5dc1178@redhat.com>
 <ZjvRPLaXQewA8K4s@bombadil.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZjvRPLaXQewA8K4s@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.05.24 21:23, Luis Chamberlain wrote:
> On Wed, May 08, 2024 at 01:58:19PM +0200, David Hildenbrand wrote:
>> On 08.05.24 13:39, Daniel Gomez wrote:
>>> On Mon, May 06, 2024 at 04:46:24PM +0800, Baolin Wang wrote:
>>>> The primary strategy is similar to supporting anonymous mTHP. Introduce
>>>> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
>>>> which can have all the same values as the top-level
>>>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
>>>> additional "inherit" option. By default all sizes will be set to "never"
>>>> except PMD size, which is set to "inherit". This ensures backward compatibility
>>>> with the shmem enabled of the top level, meanwhile also allows independent
>>>> control of shmem enabled for each mTHP.
>>>
>>> I'm trying to understand the adoption of mTHP and how it fits into the adoption
>>> of (large) folios that the kernel is moving towards. Can you, or anyone involved
>>> here, explain this? How much do they overlap, and can we benefit from having
>>> both? Is there any argument against the adoption of large folios here that I
>>> might have missed?
>>
>> mTHP are implemented using large folios, just like traditional PMD-sized THP
>> are.
>>
>> The biggest challenge with memory that cannot be evicted on memory pressure
>> to be reclaimed (in contrast to your ordinary files in the pagecache) is
>> memory waste, well, and placement of large chunks of memory in general,
>> during page faults.
>>
>> In the worst case (no swap), you allocate a large chunk of memory once and
>> it will stick around until freed: no reclaim of that memory.
>>
>> That's the reason why THP for anonymous memory and SHMEM have toggles to
>> manually enable and configure them, in contrast to the pagecache. The same
>> was done for mTHP for anonymous memory, and now (anon) shmem follows.
>>
>> There are plans to have, at some point, have it all working automatically,
>> but a lot for that for anonymous memory (and shmem similarly) is still
>> missing and unclear.
> 
> Whereas the use for large folios for filesystems is already automatic,
> so long as the filesystem supports it. We do this in readahead and write
> path already for iomap, we opportunistically use large folios if we can,
> otherwise we use smaller folios.
> 
> So a recommended approach by Matthew was to use the readahead and write
> path, just as in iomap to determine the size of the folio to use [0].
> The use of large folios would also be automatic and not require any
> knobs at all.

Yes, I remember discussing that with Willy at some point, including why 
shmem is unfortunately a bit more "special", because you might not even 
have a disk backend ("swap") at all where you could easily reclaim memory.

In the extreme form, you can consider SHMEM as memory that might be 
always mlocked, even without the user requiring special mlock limits ...

> 
> The mTHP approach would be growing the "THP" use in filesystems by the
> only single filesystem to use THP. Meanwhile use of large folios is already
> automatic with the approach taken by iomap.

Yes, it's the extension of existing shmem_enabled (that -- I'm afraid -- 
was added for good reasons).

> 
> We're at a crux where it does beg the question if we should continue to
> chug on with tmpfs being special and doing things differently extending
> the old THP interface with mTHP, or if it should just use large folios
> using the same approach as iomap did.

I'm afraid shmem will remain to some degree special. Fortunately it's 
not alone, hugetlbfs is even more special ;)

> 
>  From my perspective the more shared code the better, and the more shared
> paths the better. There is a chance to help test swap with large folios
> instead of splitting the folios for swap, and that would could be done
> first with tmpfs. I have not evaluated the difference in testing or how
> we could get the most of shared code if we take a mTHP approach or the
> iomap approach for tmpfs, that should be considered.

I don't have a clear picture yet of what might be best for ordinary 
shmem (IOW, not MAP_SHARED|MAP_PRIVATE), and I'm afraid there is no easy 
answer.

As long as we don't end up wasting memory, it's not obviously bad. But 
some things might be tricky (see my example about large folios stranding 
in shmem and never being able to be really reclaimed+reused for better 
purposes)

I'll note that mTHP really is just (supposed to be) a user interface to 
enable the various folio sizes (well, and to expose better per-size 
stats), not more.

 From that point of view, it's just a filter. Enable all, and you get 
the same behavior as you likely would in the pagecache mode.

 From a shared-code and testing point of view, there really wouldn't be 
a lot of differences. Again, essentially just a filter.


> 
> Are there other things to consider? Does this require some dialog at
> LSFMM?

As raised in my reply to Daniel, I'll be at LSF/MM and happy to discuss. 
I'm also not a SHMEM expert, so I'm hoping at some point we'd get 
feedback from Hugh.

-- 
Cheers,

David / dhildenb


