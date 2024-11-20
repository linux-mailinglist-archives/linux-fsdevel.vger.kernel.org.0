Return-Path: <linux-fsdevel+bounces-35328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C726D9D3DD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 15:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 210F5B29706
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 14:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2601AF0CC;
	Wed, 20 Nov 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fra+lEI8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680FB1AA7A6
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113576; cv=none; b=g0ZwXRG/60C1BQOjH6t2uyRL/YZhZ4ENucZBh3XjRYdPYtf/CVNJZPX+zoGpuXRX81B9udhJlNvAmx3Io2wR1a+NnzYwULpYf7sSaNWLOL0cnLFMinrjrcN/fiN0XVHvjqX0uGy0xCmY1K4U4cKKhP7ATIUPXQAg7Vy01lDpfFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113576; c=relaxed/simple;
	bh=btSNVYwlC8RJUtn0GBIme5+bVVj7TfwEc6LV82NkhM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGKDZM7VrmJd01DhkLm653+C8i5SeEQ2dDY5Hk0qy9nYswnbbavT5L20AW3+cvoMqALaJda71BuCVomzfQB1gBJT6Sm/vxLsKAdwZvxFFj8ahyz4O+cvyEvCM8dc4gXs7d91k3bOH4g65j7orS0XwWvgKfpn6NuIGzcg1gUNFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fra+lEI8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732113573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h3VNC3b6pyuHC0GRlERPYXF58+ZikMBaiQzrtXGN3kc=;
	b=fra+lEI86i0iAislvCJZ6jMe46dqRCAYdd8eG03t0CXmO49Dv0zmUeSYKQQFZRRjCKWSvz
	SedOVB1o5V1dJXfU4M6mc/PfgbWEGUeHXh8ib/QbeAKO0nsgRDQoYk8FpjsYyrAIdNU9y+
	hDVXqacJnpyGip5KhafEeWbgguFjlXU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-zPlULR6-PM2ayuGvyg97iw-1; Wed, 20 Nov 2024 09:39:31 -0500
X-MC-Unique: zPlULR6-PM2ayuGvyg97iw-1
X-Mimecast-MFC-AGG-ID: zPlULR6-PM2ayuGvyg97iw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-382342b66f5so2525053f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 06:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732113570; x=1732718370;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h3VNC3b6pyuHC0GRlERPYXF58+ZikMBaiQzrtXGN3kc=;
        b=e5wQ1L0uOsuqBZCodbd+y54vlHd0OQjMl1Sa+uTfmefrIh0jg+X8NwQT9G+gOPkd5X
         RDyOULZSrBhyCXGP+Q3R/HAwxWTEuQfPWu4hS/2xRBq1vrC93IS86JLjtM87hhaFQZ+L
         3zomZ2pyk+LuvvDl2baGOM9ms9LeUlv6KokbqIouAPjSv0lq2hdCxSiufqWXjWm2k3cH
         tLly6/qB5Rf6kdjmo/GC02g9EluT4Dq1+FeJPcMwziQeCEO61Gzalw1xYohmWumpOJRe
         qGEn/Z4RiI358Z5CyMvxs8QypEtX9xGHK/ZMqNA7RAsRC9xiB6b1YLe8hbJgIp0AVS7R
         ZQGA==
X-Forwarded-Encrypted: i=1; AJvYcCVHEYkhfhXyO13CMM/tms6E7HpObIxVsGp4eYmgxD3YdpHK4teOf7Hu6FmpaTAvl6VlArzSwuOizZDVy1h/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx58OGXWEZ1Uy2WyV9wOUCrxEvJvoyJqknrmHZ/1W5nImOrvfFE
	vsn4nN5BFdPlxGRuZs7GeH2sN5mxRtyDcDVPaQ2lcBQrOd7aVNa7/42aliABjZMTD4xrSCSmg7A
	bg3P3I/xgWqvMsL8gijJnW6ATPjGhGZCLOGi//Yvl4ELjTo/9AN2mAE+cLiN7Mqk=
X-Received: by 2002:a05:6000:2d01:b0:382:5284:995 with SMTP id ffacd0b85a97d-38254af52edmr1741472f8f.16.1732113570642;
        Wed, 20 Nov 2024 06:39:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3PCfqnU0zEBWkF3nAGnG0ftAq5fWrullBMMZxuX6xEoDVnbaIbozVyZf2Yd0u6zKlmX8E6w==
X-Received: by 2002:a05:6000:2d01:b0:382:5284:995 with SMTP id ffacd0b85a97d-38254af52edmr1741442f8f.16.1732113570280;
        Wed, 20 Nov 2024 06:39:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4200:ce79:acf6:d832:60df? (p200300cbc7054200ce79acf6d83260df.dip0.t-ipconnect.de. [2003:cb:c705:4200:ce79:acf6:d832:60df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45d4c68sm21058255e9.22.2024.11.20.06.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 06:39:29 -0800 (PST)
Message-ID: <3ed18ba1-e4b1-461e-a3a7-5de2df59ca60@redhat.com>
Date: Wed, 20 Nov 2024 15:39:27 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/11] fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM
 to detect device RAM ranges in 2nd kernel
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-8-david@redhat.com> <Zz22ZidsMqkafYeg@MiWiFi-R3L-srv>
 <4b07a3eb-aad6-4436-9591-289c6504bb92@redhat.com>
 <Zz3sm+BhCrTO3bId@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zz3sm+BhCrTO3bId@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.11.24 15:05, Baoquan He wrote:
> On 11/20/24 at 11:48am, David Hildenbrand wrote:
>> On 20.11.24 11:13, Baoquan He wrote:
>>> On 10/25/24 at 05:11pm, David Hildenbrand wrote:
>>>> s390 allocates+prepares the elfcore hdr in the dump (2nd) kernel, not in
>>>> the crashed kernel.
>>>>
>>>> RAM provided by memory devices such as virtio-mem can only be detected
>>>> using the device driver; when vmcore_init() is called, these device
>>>> drivers are usually not loaded yet, or the devices did not get probed
>>>> yet. Consequently, on s390 these RAM ranges will not be included in
>>>> the crash dump, which makes the dump partially corrupt and is
>>>> unfortunate.
>>>>
>>>> Instead of deferring the vmcore_init() call, to an (unclear?) later point,
>>>> let's reuse the vmcore_cb infrastructure to obtain device RAM ranges as
>>>> the device drivers probe the device and get access to this information.
>>>>
>>>> Then, we'll add these ranges to the vmcore, adding more PT_LOAD
>>>> entries and updating the offsets+vmcore size.
>>>>
>>>> Use Kconfig tricks to include this code automatically only if (a) there is
>>>> a device driver compiled that implements the callback
>>>> (PROVIDE_PROC_VMCORE_DEVICE_RAM) and; (b) the architecture actually needs
>>>> this information (NEED_PROC_VMCORE_DEVICE_RAM).
>>>>
>>>> The current target use case is s390, which only creates an elf64
>>>> elfcore, so focusing on elf64 is sufficient.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>    fs/proc/Kconfig            |  25 ++++++
>>>>    fs/proc/vmcore.c           | 156 +++++++++++++++++++++++++++++++++++++
>>>>    include/linux/crash_dump.h |   9 +++
>>>>    3 files changed, 190 insertions(+)
>>>>
>>>> diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
>>>> index d80a1431ef7b..1e11de5f9380 100644
>>>> --- a/fs/proc/Kconfig
>>>> +++ b/fs/proc/Kconfig
>>>> @@ -61,6 +61,31 @@ config PROC_VMCORE_DEVICE_DUMP
>>>>    	  as ELF notes to /proc/vmcore. You can still disable device
>>>>    	  dump using the kernel command line option 'novmcoredd'.
>>>> +config PROVIDE_PROC_VMCORE_DEVICE_RAM
>>>> +	def_bool n
>>>> +
>>>> +config NEED_PROC_VMCORE_DEVICE_RAM
>>>> +	def_bool n
>>>> +
>>>> +config PROC_VMCORE_DEVICE_RAM
>>>> +	def_bool y
>>>> +	depends on PROC_VMCORE
>>>> +	depends on NEED_PROC_VMCORE_DEVICE_RAM
>>>> +	depends on PROVIDE_PROC_VMCORE_DEVICE_RAM
>>>
>>> Kconfig item is always a thing I need learn to master.
>>
>> Yes, it's usually a struggle to get it right. It took me a couple of
>> iterations to get to this point :)
>>
>>> When I checked
>>> this part, I have to write them down to deliberate. I am wondering if
>>> below 'simple version' works too and more understandable. Please help
>>> point out what I have missed.
>>>
>>> ===========simple version======
>>> config PROC_VMCORE_DEVICE_RAM
>>>           def_bool y
>>>           depends on PROC_VMCORE && VIRTIO_MEM
>>>           depends on NEED_PROC_VMCORE_DEVICE_RAM
>>>
>>> config S390
>>>           select NEED_PROC_VMCORE_DEVICE_RAM
>>> ============
> 
> Sorry, things written down didn't correctly reflect them in my mind.
> 
> ===========simple version======
> fs/proc/Kconfig:
> config PROC_VMCORE_DEVICE_RAM
>          def_bool y
>          depends on PROC_VMCORE && VIRTIO_MEM
>          depends on NEED_PROC_VMCORE_DEVICE_RAM
> 
> arch/s390/Kconfig:
> config NEED_PROC_VMCORE_DEVICE_RAM
>          def y
> ==================================

That would work, but I don't completely like it.

(a) I want s390x to select NEED_PROC_VMCORE_DEVICE_RAM instead. Staring 
at a bunch of similar cases (git grep "config NEED" | grep Kconfig, git 
grep "config ARCH_WANTS" | grep Kconfig), "select" is the common way to 
do it.

So unless there is a pretty good reason, I'll keep 
NEED_PROC_VMCORE_DEVICE_RAM as is.


(b) In the context of this patch, "depends on VIRTIO_MEM" does not make 
sense. We could have an intermediate:

config PROC_VMCORE_DEVICE_RAM
          def_bool n
          depends on PROC_VMCORE
          depends on NEED_PROC_VMCORE_DEVICE_RAM

And change that with VIRTIO_MEM support in the relevant patch.


I faintly remember that we try avoiding such dependencies and prefer 
selecting Kconfigs instead. Just look at the SPLIT_PTE_PTLOCKS mess we 
still have to clean up. But as we don't expect that many providers for 
now, I don't care.

Thanks!

-- 
Cheers,

David / dhildenb


