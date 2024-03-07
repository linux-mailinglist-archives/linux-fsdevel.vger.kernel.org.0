Return-Path: <linux-fsdevel+bounces-13873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9157874E70
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBD31C23C9D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7031129A72;
	Thu,  7 Mar 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWh2/TCT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BB01272DD
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812774; cv=none; b=UMXJPT05ZzX1khBcdJWHXvSjaWUgeGO1o7ErJACOhOIJ9Pnyknfw+mp8gsfJV28QK1ABKeuhEN5PhCpKpaaNc2UxNEk4a0J9Zoh5fTXUWLZt1UD0s3qn/WubZHsKtz3PGnxo1usVGBi9xIfKEMwTiWo7bBL76YhYwgz/NwlNyoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812774; c=relaxed/simple;
	bh=bXPVBpVa/xMRQjXe4362MB2WfdcRM1DS9fqXBARxMVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4fik7XWzPR+YaPZCDQCPhOkAdG3oLm4KnvzGnIGG+xGn2geRhAe4nfHq9g/j5YWmLQquTfkmNkdQ0psAQ2PhWZnZ3rzfblykOlbD/lcBEC/D73WXvvtq0bIIjzufi+Wt4785kgf5Ufydjgt8xv4p/9D5i2QwUXB1Ss1I9UnjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWh2/TCT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709812771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Kdw/5L27XnFbA2gsYgRxIjuL7n7AvpE36D6A5rWlIFA=;
	b=eWh2/TCTQVt4Ufk3tjBWrQ8fO/GA7oyFhMpJGYC40PvuPpL82i0I75EZ/hlAdmjrT+umex
	vGEf+NkmwBApuyhqojjkl9kDRd6wCFspZ6RkRj6PbiwurEeKAXfTpSVw4JhTYGgnLP5neD
	RoWjsR9c5aMRcrhCWjvAVqXaZH3I79M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-IEY2jJLNP3Ouzy1cMs3TjQ-1; Thu, 07 Mar 2024 06:59:30 -0500
X-MC-Unique: IEY2jJLNP3Ouzy1cMs3TjQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33dbbe709ffso306401f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 03:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709812769; x=1710417569;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kdw/5L27XnFbA2gsYgRxIjuL7n7AvpE36D6A5rWlIFA=;
        b=wdZHWppIYwOxGDGYI78AuvXM588RlnWoqdGCp81ueq7l24Hz9iO87poz7h9t0V89f0
         /9rmr4dPaZmLGVZDvKMBv17r4HAEpvRiyVO4wjhXIZ+IP7BV23rnxxFtY1aITah5GcXz
         EioiY9FSEvadAn6ddAqlnb2IzdQCPRopHjH/zpouYAOowSL+luydEKAT9mAm8FnGWpDR
         krWPIPTo2DR/33tTKvspZRKIR69vPXzr39PvWZmMeJ1fi0jucQkGRYdtGGqGtbrzwDfp
         akRiNSQPzGD/TX1z5EwmguPlB5sWlMYOJPIslGr70LfoKSQByPY/etBOiARGR+8XHaN8
         rvNA==
X-Forwarded-Encrypted: i=1; AJvYcCXVmZev8BkJ4dNrADgk5Ld/yLXKMt/X9J+bGvOHM9fho7+2pKnnsEjfj6qlmqwcX/cekpWH9vpD5b7SWW/T8wzYSusJMlhC08hHoBSa3Q==
X-Gm-Message-State: AOJu0YyxxdoqGc6xEWTA+MAgNxpKD8VmLUC87nIkU7vGmBkvaoY6GHwJ
	pcDb7HolNyq+70Vi0R0OFTk0sSDHttnTMUzKLY3/9JB1mkRmAfNe9p4QnOYPeyA4EINYi779p9n
	tbwFnciat2KY6Z8K9jsgN+oyYbFwW+ob+ikri4IOg4j72JYLuVoEl9uTdbGNbR0M=
X-Received: by 2002:adf:f64b:0:b0:33b:48ee:8a35 with SMTP id x11-20020adff64b000000b0033b48ee8a35mr13982938wrp.3.1709812769107;
        Thu, 07 Mar 2024 03:59:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFe1mHWg+57F4YR52njO4WnxoFHWGNPGIEuRwB29whyVs6mDhp5+92zNtJq9mb/nt6fV0V66Q==
X-Received: by 2002:adf:f64b:0:b0:33b:48ee:8a35 with SMTP id x11-20020adff64b000000b0033b48ee8a35mr13982922wrp.3.1709812768668;
        Thu, 07 Mar 2024 03:59:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c74d:6400:4867:4ed0:9726:a0c9? (p200300cbc74d640048674ed09726a0c9.dip0.t-ipconnect.de. [2003:cb:c74d:6400:4867:4ed0:9726:a0c9])
        by smtp.gmail.com with ESMTPSA id n6-20020a056000170600b0033e45930f35sm8541285wrc.6.2024.03.07.03.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 03:59:28 -0800 (PST)
Message-ID: <0644814b-869b-4694-bdb1-bab4e6186136@redhat.com>
Date: Thu, 7 Mar 2024 12:59:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] [RFC] proc: pagemap: Expose whether a PTE is writable
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>
Cc: linux-mm <linux-mm@kvack.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 upstream+pagemap <upstream+pagemap@sigma-star.at>,
 adobriyan <adobriyan@gmail.com>, wangkefeng wang
 <wangkefeng.wang@huawei.com>, ryan roberts <ryan.roberts@arm.com>,
 hughd <hughd@google.com>, peterx <peterx@redhat.com>,
 avagin <avagin@google.com>, lstoakes <lstoakes@gmail.com>,
 vbabka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
 usama anjum <usama.anjum@collabora.com>, Jonathan Corbet <corbet@lwn.net>
References: <20240306232339.29659-1-richard@nod.at>
 <d673247b-a67b-43e1-a947-18fdae5f0ea1@redhat.com>
 <1058679077.23275.1709809843605.JavaMail.zimbra@nod.at>
 <7d9321db-a3c1-4593-91fa-c7f97bd9eecd@redhat.com>
 <1525238492.23321.1709812267495.JavaMail.zimbra@nod.at>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1525238492.23321.1709812267495.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.03.24 12:51, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "David Hildenbrand" <david@redhat.com>
>>> I'm currently investigating why a real-time application faces unexpected
>>> page faults. Page faults are usually fatal for real-time work loads because
>>> the latency constraints are no longer met.
>>
>> Are you concerned about any type of page fault, or are things like a
>> simple remapping of the same page from "read-only to writable"
>> acceptable? ("very minor fault")
> 
> Any page fault has to be avoided.
> To give you more background, the real time application runs on Xenomai,
> a real time extension for Linux.
> Xenomai applies already many tweaks to the kernel to trigger pre-faulting of
> memory areas. But sometimes the application does not use the Xenomai API
> correctly or there is an bug in Xenomai it self.
> Currently I'm suspecting the latter.
>   

Thanks for the details!

>>>
>>> So, I wrote a small tool to inspect the memory mappings of a process to find
>>> areas which are not correctly pre-faulted. While doing so I noticed that
>>> there is currently no way to detect CoW mappings.
>>> Exposing the writable property of a PTE seemed like a good start to me.
>>
>> Is it just about "detection" for debugging purposes or about "fixup" in
>> running applications?
> 
> It's only about debugging. If an application fails a test I want to have
> a tool which tells me what memory mappings are wonky or could cause a fault
> at runtime.

One destructive way to find out in a writable mapping if the page would 
actually get remapped:

a) Read the PFN of a virtual address using pagemap
b) Write to the virtual address using /proc/pid/mem
c) Read the PFN of a virtual address using pagemap to see if it changed

If the application can be paused, you could read+write a single byte, 
turning it non-destructive.

But that would still "hide" the remap-writable-type faults.

> 
> I fully understand that my use case is a corner case and anything but mainline.
> While developing my debug tool I thought that improving the pagemap interface
> might help others too.

I'm fine with this (can be a helpful debugging tool for some other cases 
as well, and IIRC we don't have another interface to introspect this), 
as long as we properly document the corner case that there could still 
be writefaults on some architectures when the page would not be 
accessed/dirty yet.

-- 
Cheers,

David / dhildenb


