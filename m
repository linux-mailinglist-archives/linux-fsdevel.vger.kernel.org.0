Return-Path: <linux-fsdevel+bounces-35301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B919D3859
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FCD81F23E5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 10:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB814198E69;
	Wed, 20 Nov 2024 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8b7asPs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B833C17ADE9
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098525; cv=none; b=oSc0VasexOsFRWqhTk5CuGLjOk5X+yk9J96lZWg3CRR2OV/pVY7ZtRQ67nfV6URyhPQ1ktvG8AeP+iXwf/7b7ki2P8yYHp0z/uX/khdWGDO66MNILp+N5CZBjCnidl7pNVlmsT3DlWxkuw+WWWiC8/RYLm+/w5mSqtrH1eohjdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098525; c=relaxed/simple;
	bh=J07uluM+oC2W9y68Pu4nhJ0qK0dzMWPaMrBKhxupRNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVG+TGqyJWOLx0ybmh5lEteqCSZguVFn0JB/Z4pm4+GLGqoOxzEgzVzr/EZE/HPa5VF4LYeoM0F65Fsz1VsNQm2lzyTm1kzY8Uokx0tMYKQbqjy8BmntTKQSHPCcmor4l/Wvdo2JE3JBUg1oLqUiHXJ8yy6mB2OVDJRjjYmOp1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8b7asPs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732098522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PUhTKpUDbhefVJVke+txqNXrs01kWRaTISFE+/T9pRw=;
	b=O8b7asPsXfez3M2avmfMGvsFucr77T664tv5CKsCeSSm/EGlFry1p8KUWXfXzc4JGa346O
	XUxVyF91uqii4CUEyuDEO9stamF/YDY5c964+cy40jxBSNDQwoblcWT8r8ORMbgWHMwEVM
	4BAkNB64z5L2RvHQe6oeiT8UaYnuyZI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-R8duVw2ANwyUq6TwluTIuA-1; Wed, 20 Nov 2024 05:28:41 -0500
X-MC-Unique: R8duVw2ANwyUq6TwluTIuA-1
X-Mimecast-MFC-AGG-ID: R8duVw2ANwyUq6TwluTIuA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43157cff1d1so38868435e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 02:28:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732098520; x=1732703320;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PUhTKpUDbhefVJVke+txqNXrs01kWRaTISFE+/T9pRw=;
        b=a7XDJO30ipXibJy5QbUfpE2TyZZrb7LCxYNOIQvmb/Pey1+HlQ6NxEUur6dwk73qmE
         lmmivqQtkTfRT3bwlG0t0AfXS0ihPnkho+HU423AblHWffiDrSpEm49or02VWVdEW+T4
         bM8ZgELI2t8VUAFLDIiUoZ71icKgsN0vainFFDWlFY9Po4ugzTpK5CehxuY7slqoBRzz
         zh2MzMR5xSOAoWBdlyIb5d6CpxfyAapbOp+MX8+Hi+CZk4++pfAeS1+JWF5/qY5ZKAwL
         TFTE27jXENWWsBBRzwz3nWkfd9D5WBqJ0KGwUUuS7JOMRM/OD2DNaq32sQm6cXCqnkza
         t3Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUQjVwhCxuXw487kyraerbrCwHZW7mo+PEBU2zMQnECCx2L/wbeWSyFBlczdXkrbORlvckwuhtumCXhHkMT@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUR29MhKhB01dgsMyl4XbP8iPAC2D/Gwo4jyzPBhkBBTGZoWA
	s4g7M7PGDoUb6JxrAK91WJq/C0qP5sIWJuyNc5uw3SXXtZom4okMsXW0Het4iNho+KO7EgLkv3l
	/uCT2Qayp4uL5eiYK6I3QwnKbvlSjg1cFErpyXwZa7w89OoSdTgb5juCr88P/NzY=
X-Received: by 2002:a05:6000:1a8e:b0:382:4fb2:cc94 with SMTP id ffacd0b85a97d-38254adf53cmr1274910f8f.4.1732098520141;
        Wed, 20 Nov 2024 02:28:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJoRBPwyp9lbtADpyi1/+1hdX8YzDdgEC7iCXuHcfB/2DagZJPkXBzcXmpmHY2eSLwEvZ0XA==
X-Received: by 2002:a05:6000:1a8e:b0:382:4fb2:cc94 with SMTP id ffacd0b85a97d-38254adf53cmr1274884f8f.4.1732098519755;
        Wed, 20 Nov 2024 02:28:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4200:ce79:acf6:d832:60df? (p200300cbc7054200ce79acf6d83260df.dip0.t-ipconnect.de. [2003:cb:c705:4200:ce79:acf6:d832:60df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825493e9bbsm1628011f8f.94.2024.11.20.02.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 02:28:39 -0800 (PST)
Message-ID: <120bc3d9-2993-47eb-a532-eb3a5f6c4116@redhat.com>
Date: Wed, 20 Nov 2024 11:28:37 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/11] fs/proc/vmcore: move vmcore definitions from
 kcore.h to crash_dump.h
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
 <20241025151134.1275575-5-david@redhat.com> <ZzcYEQwLuLnGQM1y@MiWiFi-R3L-srv>
 <ca0dd4a7-e007-4092-8f46-446fba26c672@redhat.com>
 <Zz2u+2abswlwVcer@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zz2u+2abswlwVcer@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.11.24 10:42, Baoquan He wrote:
> On 11/15/24 at 10:59am, David Hildenbrand wrote:
>> On 15.11.24 10:44, Baoquan He wrote:
>>> On 10/25/24 at 05:11pm, David Hildenbrand wrote:
>>>> These defines are not related to /proc/kcore, move them to crash_dump.h
>>>> instead. While at it, rename "struct vmcore" to "struct
>>>> vmcore_mem_node", which is a more fitting name.
>>>
>>> Agree it's inappropriate to put the defintions in kcore.h. However for
>>> 'struct vmcore', it's only used in fs/proc/vmcore.c from my code
>>> serching, do you think if we can put it in fs/proc/vmcore.c directly?
>>> And 'struct vmcoredd_node' too.
>>
>> See the next patches and how virtio-mem will make use of the feactored out
>> functions. Not putting them as inline functions into a header will require
>> exporting symbols just do add a vmcore memory node to the list, which I want
>> to avoid -- overkill for these simple helpers.
> 
> I see. It makes sense to put them in crash_dump.h. Thanks for
> explanation.
> 

I'll add these details to the description.

>>
>>>
>>> And about the renaming, with my understanding each instance of struct
>>> vmcore represents one memory region, isn't it a little confusing to be
>>> called vmcore_mem_node? I understand you probablly want to unify the
>>> vmcore and vmcoredd's naming. I have to admit I don't know vmcoredd well
>>> and its naming, while most of people have been knowing vmcore representing
>>> memory region very well.
>>
>> I chose "vmcore_mem_node" because it is a memory range stored in a list.
>> Note the symmetry with "vmcoredd_node"
> 
> I would say the justification of naming "vmcore_mem_node" is to keep
> symmetry with "vmcoredd_node". If because it is a memory range, it really
> should not be called vmcore_mem_node. As we know, memory node has
> specific meaning in kernel, it's the memory range existing on a NUMA node.
> 
> And vmcoredd is not a widely used feature. At least in fedora/RHEL, we
> leave it to customers themselves to use and handle, we don't support it.
> And we add 'novmcoredd' to kdump kernel cmdline by default to disable it
> in fedora/RHEL. So a rarely used feature should not be taken to decide
> the naming of a mature and and widely used feature's name. My personal
> opinion.

It's a memory range that gets added to a list. So it's a node in a list 
... representing a memory range. :) I don't particularly care about the 
"node" part here.

The old "struct vmcore" name is misleading: makes one believe it somehow 
represents "/proc/vmcore", but it really doesn't. (see below on function 
naming)

> 
>>
>> If there are strong feelings I can use a different name, but
> 
> Yes, I would suggest we better keep the old name or take a more
> appropriate one if have to change.

In light of patch #5 and #6, really only something like 
"vmcore_mem_node" makes sense. Alternatively "vmcore_range" or 
"vmcore_mem_range".

Leaving it as "struct vmcore" would mean that we had to do in #5 and #6:

* vmcore_alloc_add_mem_node() -> vmcore_alloc_add()
* vmcore_free_mem_nodes() -> vmcore_free()

Which would *really* be misleading, because we are not "freeing" the vmcore.

Would "vmcore_range" work for you? Then we could do:

* vmcore_alloc_add_mem_node() -> vmcore_alloc_add_range()
* vmcore_free_mem_nodes() -> vmcore_free_ranges()

-- 
Cheers,

David / dhildenb


