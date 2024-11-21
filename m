Return-Path: <linux-fsdevel+bounces-35478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FAC9D5389
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 20:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90FB1F21D06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 19:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B9C1C8FD6;
	Thu, 21 Nov 2024 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSTGR7iB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B016A397
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732218430; cv=none; b=hj1b7sShpM4Mii6KbQ9xmHP6GKE7HU6nuwqPIfdz4lXUgOBTqsQ+PU438ygJ8V2KxGv/fENgZv+hnWlxJdoFDyeaXmyx/LhtEvDQUaxLYZiz6zc/s4eHyNVs8FBAfTGTwOvmjtzHP8st7c6jYxzqvmo4jbm8Z2sbANiThZv/oJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732218430; c=relaxed/simple;
	bh=ZPZ4NJrHHFgFldF9xJpRUGhlUNMn8yOOLL2KR/VZ50s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVud5c+UH0fn4drl6vEewKoe2HYS42GfMGhV/zafla9p1Oxx6oWzgxQNmUgjOYilrqPTuJx4+RYxeM1YLJARsdpDgq9ElXA3/cUoKewlE8k2U0dZnQfBhxkQUc7UFRBXsT8f+1gMDp+McAatRXcayhI5aOOHByCImhStDZmZU3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSTGR7iB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732218427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9vPjFHjh3yXhS4HZP/mZR+2x681KUbGOAjt5WUat2I0=;
	b=BSTGR7iBPI7Nc6Nd/9TeYxMoZDEmBd3apEUFVOqHZ6HNRErLvYhceF1y1q+z/Mkm3yE9Yz
	t9wJlDTmyFMo9+NxhIYMM4RLBVG7kdYJBV6Nq1uH6zGdYk2FeZz+i52QunGqnI9Uwz3kg7
	8mZ5QVslPcZPAFVDFKTFHsaieamgk3Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-t9lUZBlvNQGHr72TWewxNg-1; Thu, 21 Nov 2024 14:47:06 -0500
X-MC-Unique: t9lUZBlvNQGHr72TWewxNg-1
X-Mimecast-MFC-AGG-ID: t9lUZBlvNQGHr72TWewxNg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-382308d07dfso607394f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 11:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732218425; x=1732823225;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9vPjFHjh3yXhS4HZP/mZR+2x681KUbGOAjt5WUat2I0=;
        b=J+XWSSZo19R0B5dSVoVL+vgCOuwofVoXfpNqwoVCNQyHvCEZ7vJ3+BdVxO1ifKEmt9
         pFMmR5yD9fF3N0UkPEEWnmeG1khi8rrqZPfM9IqBKz5EqJTVWzqDhevKluV/zuN1J/uc
         QVB0+WxrEQoAryrKolJL5aG2kpRYjH0FMfg5dJ1UBO8Jz7rz3W6lRjODfuoW5jz5V5qu
         kV7gA707nytZY/9AIIBB82TiKt6s6aQBkN/RHvejEz1npHJ4CP5oGGcuRBjOSpBO2nGV
         k94c95iZcMBeE+ot4ylzcrUt4nzk9dMOZv9SFT2Xy7iZEjA3wVRZNniTqSqo5VuKMbYA
         zzdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy8OT4TxTxerxLiSvcYYPoa5Q/8E6nooMH6GqGDRhDQrDCDuGUXPF6w0YThj4mbDz3VtpcKj0d3I6HB61m@vger.kernel.org
X-Gm-Message-State: AOJu0YzvsTm9LBXqXNd0N/P4e1imHIOc6we6au+ULelNL1s4kJNKXKMn
	kXUf2BdjvjNbCkwoXXusdd/KFzIXa5BeAZhtu31BMwqahspaJXM0HdKWVYSTuM7O/5zMK+4/q7Y
	9VJgHOHUQB1e9CvDz5MTfoNj/Hp7NGDH1inJZNkjpuOAWYKEWJJDPoj7M8Aow5ks=
X-Gm-Gg: ASbGncsJz/7d0z3KA+5fJ9vPNx+kaSfAE4//gRddi5q1B9PgMYvpvVawUfMC+adIXFE
	0p6r1zQGjNPkMHvQ0Sxu+kQVoh/DGgRs2GZn2fqnw/Hz5b3wjoOZqeoyxK8l4icltL9JEvyt1Wp
	3i+btP1WRgC0eCbB7dgu0BlEBInbCgZ/qaDwi6kM1+viDUanr9yE6F+6X/SA8EeZbzZW59CuXTv
	EuYHta6HvrgiaKqoyEi2mT272Frp7FU7huJ4bNrSDrJVsH5VXRvzXJITqhHxwkYM5zzSxyY8/4K
	R8UXKF3yZzDbvsF6QXyPu+pJ7Xz18HPdQDfpZDA/FKNQ84JBj8p9/NlXYUEFXbtY98HNhw6Mv1c
	=
X-Received: by 2002:a5d:64a4:0:b0:382:4978:2ab9 with SMTP id ffacd0b85a97d-38260b50178mr280891f8f.5.1732218425145;
        Thu, 21 Nov 2024 11:47:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwjpMyfPMDn7yzJZGj2fN3hdUzm6pJror1oFSbaD9p3e5FF3gpDG0hGN0f8NMCUBM9HBDVYw==
X-Received: by 2002:a5d:64a4:0:b0:382:4978:2ab9 with SMTP id ffacd0b85a97d-38260b50178mr280863f8f.5.1732218424718;
        Thu, 21 Nov 2024 11:47:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:de00:1200:8636:b63b:f43? (p200300cbc70cde0012008636b63b0f43.dip0.t-ipconnect.de. [2003:cb:c70c:de00:1200:8636:b63b:f43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb537d4sm390281f8f.61.2024.11.21.11.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 11:47:03 -0800 (PST)
Message-ID: <c353466b-6860-4ca2-a4fa-490648246ddc@redhat.com>
Date: Thu, 21 Nov 2024 20:47:01 +0100
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
 <3ed18ba1-e4b1-461e-a3a7-5de2df59ca60@redhat.com>
 <Zz63aGL7NcrONk+p@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zz63aGL7NcrONk+p@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> That would work, but I don't completely like it.
>>
>> (a) I want s390x to select NEED_PROC_VMCORE_DEVICE_RAM instead. Staring at a
>> bunch of similar cases (git grep "config NEED" | grep Kconfig, git grep
>> "config ARCH_WANTS" | grep Kconfig), "select" is the common way to do it.
>>
>> So unless there is a pretty good reason, I'll keep
>> NEED_PROC_VMCORE_DEVICE_RAM as is.
> 
> That's easy to satify, see below:

Yes, this is mostly what I have right now, except

> 
> ============simple version=====
> fs/proc/Kconfig:
> config NEED_PROC_VMCORE_DEVICE_RAM
>          def n

using "bool" here like other code. (I assume you meant "def_bool n", 
"bool" seems to achieve the same thing)

> 
> config PROC_VMCORE_DEVICE_RAM
>          def_bool y
>          depends on PROC_VMCORE && VIRTIO_MEM
>          depends on NEED_PROC_VMCORE_DEVICE_RAM
> 
> arch/s390/Kconfig:
> config S390
>          select NEED_PROC_VMCORE_DEVICE_RAM
> ==============================
> 
>>
>> (b) In the context of this patch, "depends on VIRTIO_MEM" does not make
>> sense. We could have an intermediate:
>>
>> config PROC_VMCORE_DEVICE_RAM
>>           def_bool n
>>           depends on PROC_VMCORE
>>           depends on NEED_PROC_VMCORE_DEVICE_RAM
>>
>> And change that with VIRTIO_MEM support in the relevant patch.
> 
> Oh, it's not comment for this patch, I made the simple version based on
> the whole patchset. When I had a glance at this patch, I also took
> several iterations to get it after I applied the whole patchset and
> tried to understand the whole code.

Makes sense, I'm figuring out how I can split that up.

If we can avoid the PROVIDE_* thing for now, great. Not a big fan of 
that myself.

> 
>>
>>
>> I faintly remember that we try avoiding such dependencies and prefer
>> selecting Kconfigs instead. Just look at the SPLIT_PTE_PTLOCKS mess we still
>> have to clean up. But as we don't expect that many providers for now, I
>> don't care.
> 
> With the simple version, Kconfig learner as me can easily understand what
> they are doing. If it took you a couple of iterations to make them as
> you had mentioned earlier, and it took me several iterations to
> understand them, I believe there must be room to improve the presented
> ones in this patchset. These are only my humble opinion, and I am not
> aware of virtio-mem at all, I'll leave this to you and other virtio-mem
> dev to decide what should be taken. Thanks for your patience and
> provided information, I learned a lot from this discussion.

I hope I didn't express myself poorly: thanks a lot for the review and 
the discussion! It helped to make the Kconfig stuff better. I'll get rid 
of the PROVIDE_* thing for now and just depend on virtio-mem.

> 
> ===================
> fs/proc/Kconfig:
> config PROVIDE_PROC_VMCORE_DEVICE_RAM
>          def_bool n
> 
> config NEED_PROC_VMCORE_DEVICE_RAM
>          def_bool n
> 
> config PROC_VMCORE_DEVICE_RAM
>          def_bool y
>          depends on PROC_VMCORE
>          depends on NEED_PROC_VMCORE_DEVICE_RAM
>          depends on PROVIDE_PROC_VMCORE_DEVICE_RAM
> 
> drivers/virtio/Kconfig:
> config VIRTIO_MEM
>          select PROVIDE_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
>                                                ~~~~~~~~~~~~~~
> 
> arch/s390/Kconfig:
> config S390
>          select NEED_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
>                                             ~~~~~~~~~~~~~~
> ========================
> 
> One last thing I haven't got well, If PROC_VMCORE_DEVICE_RAM has had
> dependency on PROC_VMCORE, can we take off the ' if PROC_VMCORE' when
> select PROVIDE_PROC_VMCORE_DEVICE_RAM and NEED_PROC_VMCORE_DEVICE_RAM?

We could; it would mean that in a .config file you would end up with
"NEED_PROC_VMCORE_DEVICE_RAM=y" with "#PROC_VMCORE" and no notion of 
"PROC_VMCORE_DEVICE_RAM".

I don't particularly like that -- needing something that apparently does 
not exist. Not sure if there is a best practice here, staring at some 
examples I don't seem to find a consistent rule. I can just drop it, not 
the end of the world.


Did you get to look at the other code changes in this patch set? Your 
feedback would be highly appreciated!

-- 
Cheers,

David / dhildenb


