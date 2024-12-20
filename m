Return-Path: <linux-fsdevel+bounces-37977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0639E9F99B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 19:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF793189A6EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 18:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD82321C188;
	Fri, 20 Dec 2024 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9duBBCf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8267821CA16
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734719581; cv=none; b=A2J723cr98A/DLtr8tIzIX0UdQbsWY/ocFue6KH4cKEqHC581y1K1xsFLOXx8DukLtbWXsgzr2MsMYlKl9gv3TeAQO0RA0nVpWWq2tV/uRcpdGQ/rlF3ImDNiiWBMyFx33zZGT4fG6aQUnWKY8eVZDNfzUplIEiv6RA8GH9Adv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734719581; c=relaxed/simple;
	bh=JS4X+Mv4yHz0iVkzrn8UK4tDBoOxclJbiHqvISaM2bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ej9P/j9PWmIoiFfMhIO/E6CkU734U2b3PsNkdICjT8cRRJVPfsjFzAE1H6guVooocG3UpYRggTh4Qz6cExz65/XHYqvCEls3ZvqH9iHUtIY4LqgkZVWooV/e1V41x/sxCDTLuJ14Bfwh2GvNDMiKHFH8TqT8EutCj1krCd5crUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D9duBBCf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734719578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=swU3J22w1qiLCqCLjNaSEiN34P+WDwMezqQF+LZ7YmM=;
	b=D9duBBCf6+o3+AF+SHhzSWP9zk5kFNJGjqoV3tpURPULb/VVGxSfOY0thatAKttd5GF51w
	vCVo5g2xClsZW5cE1jMW1h4R+yR2i3yxCwnNeMgcjdiNbED5++kgu7H3K0yXUcOjvZJdTn
	2j+brg0XDacYPSoM9/lpWI+xWkUTPuY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-NDfJfAy7OdWrjYaPYmDh-w-1; Fri, 20 Dec 2024 13:32:57 -0500
X-MC-Unique: NDfJfAy7OdWrjYaPYmDh-w-1
X-Mimecast-MFC-AGG-ID: NDfJfAy7OdWrjYaPYmDh-w
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e03f54d0so1133879f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 10:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734719576; x=1735324376;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=swU3J22w1qiLCqCLjNaSEiN34P+WDwMezqQF+LZ7YmM=;
        b=u7tNiJQarhjtY89ieP8QjG6gQ2tZOPUVSD48j3wpAAYRlx6kKWYixytdl0e96xeg8E
         ZOv7Fu5dnPE8/ic5mAh6LlabUShjQpbV9ZBd0oE+DF3y2GW2esIUPfFNWiw8ww5a4tL0
         5+giurV8jTtmZEE2+PU3yC45HUvAs/CrPSluYum72a1YB9rf3oGAdEJLJ5J5j2vvTTTb
         LPf7LleRolGXHUObSgOaHkbA2wL6N78nWZmKB7aoTJ4bhJhdahxiV/NRI8qUPHJpVNYU
         Tf07P51opleM6a/nFGYVM6KS+S7w/mfW2j6r9Bay+ywYBW+IMn2nRhnTMYXi5U6Yxxqd
         KzWA==
X-Forwarded-Encrypted: i=1; AJvYcCUXAqeJPQUAwaWQLii8UNBvtREDwSIpp2QF6kpAMm9hLmJTCK28qQETgQa8VuuRTlTAVq8+p/xVpyQoONH6@vger.kernel.org
X-Gm-Message-State: AOJu0YxxmtVvV594NFdsljpg6XRJP4UycsvJ04v8qujEbu7NQhTpee2K
	imO9I/FaOMFRHnf30nzXsfm7Jjq0Km3OWaZFBvcMIh4++EGiklBnN2e+n4pMS59YoSKdMTARRLx
	uzvAOPWwhqTBufBXc2Iswq8tMxjXRn1UMDFMCVh91hY9gsynryFsQ4sT6+X0SSAc=
X-Gm-Gg: ASbGncuiE/FUYAzL9pYHoPRMaduDjMpjh41n19AbkDwxEsPSpv9nbpeaER0gaDfrkPf
	ktOAyWuhANDdSSMdts7DqpVDHllNDvmPB4j70qoInE6r+bTtZyocun0fyQKXVHspM+zqBl1pslR
	DnBqRavXqWIh2k2HSulb1DUTjI5d/uvqNcAVcgnU9GLM7PSqFZLCjBjkvKrxA7FmJH5AyL3bhry
	qkzPA/FfImlx7f7LIGmAaDgLNVZlYHipYVpEX/qJ2LxMSHsuLjgG7r2/Z8p66vxtsOeyXiKr5rI
	KU3CUnkzZcm35urS12Ns2NbtoTiNrzJKxwkazauKpbLwKMZWV8vBShIzSc+dTcLcs/nbzh+f1La
	c3f3x77/0
X-Received: by 2002:a05:6000:1fad:b0:385:ec89:2f07 with SMTP id ffacd0b85a97d-38a222001b1mr2999429f8f.32.1734719575923;
        Fri, 20 Dec 2024 10:32:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk0Gj/f9sMdkNX68mPrqALSYePXcnIEwcuX62px3U4cp9do+t6yyCpZv960vKDvx0DNpRxKg==
X-Received: by 2002:a05:6000:1fad:b0:385:ec89:2f07 with SMTP id ffacd0b85a97d-38a222001b1mr2999374f8f.32.1734719575483;
        Fri, 20 Dec 2024 10:32:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:9d00:edd9:835b:4bfb:2ce3? (p200300cbc7089d00edd9835b4bfb2ce3.dip0.t-ipconnect.de. [2003:cb:c708:9d00:edd9:835b:4bfb:2ce3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e278sm4706351f8f.75.2024.12.20.10.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 10:32:54 -0800 (PST)
Message-ID: <36334f20-2b9e-4529-89c4-120678bc5985@redhat.com>
Date: Fri, 20 Dec 2024 19:32:52 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/25] proc/task_mmu: Ignore ZONE_DEVICE pages
To: Alistair Popple <apopple@nvidia.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, linux-mm@kvack.org,
 lina@asahilina.net, zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
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
 david@fromorbit.com
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
 <f3ebda542373feb70ed3e5d83b276a2e8347609f.1734407924.git-series.apopple@nvidia.com>
 <c7bd9b00-6920-4dc0-8e2e-36c16ef7ad5a@redhat.com>
 <37rxl2bjda3psdknhboexhbg3hahf5ifmublp5fw7ltdoyqllc@udbz76jklmnu>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <37rxl2bjda3psdknhboexhbg3hahf5ifmublp5fw7ltdoyqllc@udbz76jklmnu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.12.24 00:11, Alistair Popple wrote:
> On Tue, Dec 17, 2024 at 11:31:25PM +0100, David Hildenbrand wrote:
>> On 17.12.24 06:13, Alistair Popple wrote:
>>> The procfs mmu files such as smaps currently ignore device dax and fs
>>> dax pages because these pages are considered special. To maintain
>>> existing behaviour once these pages are treated as normal pages and
>>> returned from vm_normal_page() add tests to explicitly skip them.
>>>
>>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>>> ---
>>>    fs/proc/task_mmu.c | 18 ++++++++++++++----
>>>    1 file changed, 14 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index 38a5a3e..c9b227a 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/fs/proc/task_mmu.c
>>> @@ -801,6 +801,8 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
>>>    	if (pte_present(ptent)) {
>>>    		page = vm_normal_page(vma, addr, ptent);
>>> +		if (page && (is_device_dax_page(page) || is_fsdax_page(page)))
>>
>> This "is_device_dax_page(page) || is_fsdax_page(page)" is a common theme
>> here, likely we should have a special helper?
> 
> Sounds good, will add is_dax_page() if there are enough callers left after any
> review comments.

:)

>   
>> But, don't we actually want to include them in the smaps output now? I think
>> we want.
> 
> I'm not an expert in what callers of vm_normal_page() think of as a "normal"
> page. 

Yeah, it's tricky. It means "this is abnormal, don't look at the struct 
page". We're moving away from that, such that these folios/pages will be 
... mostly normal :)

> So my philosphy here was to ensure anything calling vm_normal_page()
> didn't accidentally start seeing DAX pages, either by checking existing filters
> (lots of callers already call vma_is_special_huge() or some equivalent) or
> explicitly filtering them out in the hope someone smarter than me could tell me
> it was unneccssary.
> 
> That stategy seems to have worked, and so I agree we likely do want them in
> smaps. I just didn't want to silently do it without this kind of discussion
> first.

Yes, absolutely.

> 
>> The rmap code will indicate these pages in /proc/meminfo, per-node info, in
>> the memcg ... as "Mapped:" etc.
>>
>> So likely we just want to also indicate them here, or is there any downsides
>> we know of?
> 
> I don't know of any, and I think it makes sense to also indicate them so will
> drop this check in the respin.

It will be easy to hide them later, at least we talked about it. Thanks 
for doing all this!

-- 
Cheers,

David / dhildenb


