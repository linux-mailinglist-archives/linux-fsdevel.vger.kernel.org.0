Return-Path: <linux-fsdevel+bounces-35284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FE59D360B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF11E1F24A9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8457A189BAD;
	Wed, 20 Nov 2024 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHD3TMvT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA384176AC7
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093011; cv=none; b=XMyenwtAhp9r8ySTXTtyCca6fI3HYf7WL4bANiqvr1he/o1o/ZXm+ug6A12fbsra4wVOR6UEWByzxmpC3L24FjsvfHBXnEiko+615E+RKcFYmiIS50S7KJhkBO8s/UWUKffaOeb+QTw3yeM20JrBIvUWwNprnbMitzIA4YSPDB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093011; c=relaxed/simple;
	bh=xIdSg75iNGbK1/pOlSpLlSoLOEasj/DOlXbXtu8lenM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4hxme0NRsN+6+BipZ7IqDE/gu2uGhbLD/GInYfvM7C2xzRwTSMvFUwvmpTNaZA/FnMya0uVzw7rbXJRUzx6Xbe2hdtekOULUCaN2i+NcNmq/VZ0HeGIk1CIBptiUveJBBnZWlxD1C2ejqyvFzl+7B6ZDebVlmb6PVt4Y6KN75w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHD3TMvT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732093007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0bFxvEmvU1rtsWBhSPz9tXLWnH4yDhxEdDTqTgie+Jo=;
	b=QHD3TMvTo+RsQANMERLOVnX1Iisdlb03ee6wiCJtwej6j6HDI2YUsy8bkms9WtWuY7MWKW
	eDs0Ls4yBXthZnQ5CSHgsNwHo82ug3AdAVc/TSKLjkHzudZS07hvbxyWV+7ui5z8ll93ee
	sbEnn9mBIru1zSzUhzTN9ZIPlKvi5kA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-ZOols8B-N7ydeas1fery0w-1; Wed, 20 Nov 2024 03:56:45 -0500
X-MC-Unique: ZOols8B-N7ydeas1fery0w-1
X-Mimecast-MFC-AGG-ID: ZOols8B-N7ydeas1fery0w
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4316e350d6aso30105255e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 00:56:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732093004; x=1732697804;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0bFxvEmvU1rtsWBhSPz9tXLWnH4yDhxEdDTqTgie+Jo=;
        b=SLRMm/RO15IPtqIuywsACWiXWKK1DKPmvQlbYHGVAbFgkPDenJgSgEU79M779x25mJ
         hz95IH3cdzPu6fi9/Hls7Sy72OE457ak1qwynjFggqpMkYpseKgXQoxHb/pyss9EpCn7
         qwBg4Vekru58ya+cQaPb8sNRZx7YGJMGHmSP/rdsE8o2+PTDdalfkHxfT/3f+Hx1E1Xy
         QXNG9Uzq/17efRj0mkAgR/zfRJ5cUAAZXJ585YT5+tqHXSYdxUtXc+LRe/mz91/ozpsw
         k1AiwsUxZgGRAJqYPTMHB2hFD2WLl/p2twkcVbiYwQTfurzGqH+L0OEf9N4P5cJ9Vmlm
         2nqA==
X-Forwarded-Encrypted: i=1; AJvYcCX4aq1MTqOiy35Zbs2uxFnhYX70apm4uSazMrrw9z74IR6/opWlCRD9vRNCWUMJ7ZNRLo2d2ugtCiTYxdAM@vger.kernel.org
X-Gm-Message-State: AOJu0YxD8gYTcga/Lu5+F5eSLPVGdCmz+78RNixcxNOs8Qq1a8lGb6OD
	CCdC3ffl0+JU5PFBRTAhaDaOCowQWSR+uhKQscvd1fMhN2Iip1WnhMGRGW+P9HDP8V7bns33hL3
	aVCttiHAnYmLnEHL+Wa80qriWDi6OqyJuu+ntQSGmX9SPV3KZhMoHF/1e2BC4rXs=
X-Received: by 2002:a05:600c:3b0c:b0:432:d875:c298 with SMTP id 5b1f17b1804b1-433489b820emr16932735e9.14.1732093004578;
        Wed, 20 Nov 2024 00:56:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+9bdTldLMj6gxxvSH7Bou0BmIuSG0y+M1kH2Ky7OGZBF2ay1/J9/FxApyX1BXzU/me4mhCQ==
X-Received: by 2002:a05:600c:3b0c:b0:432:d875:c298 with SMTP id 5b1f17b1804b1-433489b820emr16932555e9.14.1732093004254;
        Wed, 20 Nov 2024 00:56:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4200:ce79:acf6:d832:60df? (p200300cbc7054200ce79acf6d83260df.dip0.t-ipconnect.de. [2003:cb:c705:4200:ce79:acf6:d832:60df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b01e117bsm11931435e9.8.2024.11.20.00.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 00:56:42 -0800 (PST)
Message-ID: <1ca5ae5e-4b92-418c-a73c-2c736e5b93d3@redhat.com>
Date: Wed, 20 Nov 2024 09:56:41 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/11] fs/proc/vmcore: convert vmcore_cb_lock into
 vmcore_mutex
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
 <20241025151134.1275575-2-david@redhat.com> <ZzcUpoDJ2xPc3FzF@MiWiFi-R3L-srv>
 <2b5c2b71-d31b-406d-abc5-d9a0a67712f5@redhat.com>
 <Zz2a5gZq81ZVdFOx@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zz2a5gZq81ZVdFOx@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.11.24 09:16, Baoquan He wrote:
> On 11/15/24 at 11:03am, David Hildenbrand wrote:
>> On 15.11.24 10:30, Baoquan He wrote:
>>> On 10/25/24 at 05:11pm, David Hildenbrand wrote:
>>>> We want to protect vmcore modifications from concurrent opening of
>>>> the vmcore, and also serialize vmcore modiciations. Let's convert the
>>>
>>>
>>>> spinlock into a mutex, because some of the operations we'll be
>>>> protecting might sleep (e.g., memory allocations) and might take a bit
>>>> longer.
>>>
>>> Could you elaborate this a little further. E.g the concurrent opening of
>>> vmcore is spot before this patchset or have been seen, and in which place
>>> the memory allocation is spot. Asking this becasue I'd like to learn and
>>> make clear if this is a existing issue and need be back ported into our
>>> old RHEL distros. Thanks in advance.
>>
>> It's a preparation for the other patches, that do what is described here:
>>
>> a) We can currently modify the vmcore after it was opened. This can happen
>> if the vmcoredd is added after the vmcore was loaded. Similar things will
>> happen with the PROC_VMCORE_DEVICE_RAM extension.
>>
>> b) To handle it cleanly we need to protect the modifications against
>> concurrent opening. And the modifcations end up allocating memory and cannot
>> easily take the spinlock.
>>
>> So far a spinlock was sufficient, now a mutex is required.
> 
> I see, as we talked in patch 2 sub-thread, these information are very
> valuable to help people get the background information when they read
> code. Let's put it in patch log. Thanks.

I'll extend the description if that helps, thanks!

-- 
Cheers,

David / dhildenb


