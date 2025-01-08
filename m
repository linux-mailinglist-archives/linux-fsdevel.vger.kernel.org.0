Return-Path: <linux-fsdevel+bounces-38655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C51BA05B3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 13:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EDF1675A9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 12:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55EA1F9F62;
	Wed,  8 Jan 2025 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTYGgtYN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F15E1F9407
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jan 2025 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736338471; cv=none; b=HMQkmrHJTBZF2iBlvW4v4oo7M8+TgDJaVEi26SErhtBSvyXX3WC4nKM1sxCL36XGc14joKswpa+87VZCr387d3RO08gjDS/bcXZTXizdAbO8ZGiz5wg6XFNqFBpY47Q9IcDUxl2WwxpHL+jw02od7XOY2BUqfq0YO5XLK48wqPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736338471; c=relaxed/simple;
	bh=AbAMklZDKkmgBrce1wQNnGkf1NudHIybtXPcqdjSd2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fR/NoPzd5e7+N1lqOHE+zAWK13FfkmUzYKvG29naPby7jaw9QFpLQ0ut/J44jY/Q4E1ixQDSBhrePGoXZTqCiyy7G0eRjj7XvrYRXbZ3iN+DtpF+4k4xcg4kCOfvmO3X8wjHaR+kaIrIIG0TJJH1DttNRnuTSqCFnJjq4cNWzUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTYGgtYN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736338468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i7q07UpxqItN5/CbDvEBg89xcdarz8dNPCMF232L7BQ=;
	b=VTYGgtYNkjtVkX1M2XXzrHmCoeet/o9oiZEGGmVY/lR3QgG7m5YHdkJXYfbuCbryVmHjfQ
	kKZwsLAVGzBscN78t1MkgBeoye5hjMhqz/VmEA0x6lsGkjZFuXhZK7jV3qieLxbpasJUH2
	CKhhiEeVvgRwswhYc+8+hoAScDzK0/8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-kFQmDO3LNcWdMkPzATxgbQ-1; Wed, 08 Jan 2025 07:14:27 -0500
X-MC-Unique: kFQmDO3LNcWdMkPzATxgbQ-1
X-Mimecast-MFC-AGG-ID: kFQmDO3LNcWdMkPzATxgbQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3862f3ccf4fso6837861f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2025 04:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736338466; x=1736943266;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i7q07UpxqItN5/CbDvEBg89xcdarz8dNPCMF232L7BQ=;
        b=JSuHdqoFZU3SlwQOV/TfG3fA3GQI1VKRH/SK/0b5RgG9JRQLHf/E/KARurZh3VBLie
         H41XGx9BGXd4Vf33xaFAWI82cRxDUx7/7g5dmUjAJt7HGvmsgirYC77rhS21+kZGphMO
         NjXd55mbwcbl4UoghzYJojmssrYvvd6CA56e8WgfVyXF/0BjPmNl0nHX/BURuiVjkDV1
         LZUxWm2hPtPYBxIgG/B8FkKHjKiYNVkTXPzPHlWQJkdiqw/ac1H1NZqW1AnjdO+PJjAV
         Rk3RP65YtlssKMGPHKcxAYuHBbgOeIiJ3jThvYyTRK8IKP5AaA87hMyF0NNQWkZF4q72
         ukAw==
X-Forwarded-Encrypted: i=1; AJvYcCVWdaolnfzcZqGrzHVJfX0Oh5MNtBP8CbBEijqDPMyDd/8XmV3zVNWtwWj8AOpB29jZ8llGUu7qusMqllnR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyto92E7t7EGwJqlo05MKC/atwuOW9ZyEI0lkkZI6cNPdPkf9h3
	CZN/DeZ+Fts6TJaYEHiV+Owntk/hHm5ZLsKbltPChH5H3ws5CIE55G+j6l5TyBRBn9la49viAJa
	TB5XS0uaQqFBg5gRmfFK3UX6g9XLsfS0AytTSsQquwjcZ6hxnqr6rZeuhyoiTgCE=
X-Gm-Gg: ASbGnctYYdRcYt5bN6lr17+yT6oWRz/UPEzEUOUH9J1YP24L+8/k6dwPjqBz8UBsClj
	HaNva+CseY5CSMxo3WQCAoEIcoZcECcGYe2FcL0tp+Qbp5L3Dm+k6NRzZg0w5AuYj//MEG98vGW
	Ju/SSfupZMGN6kVJknR2Z+IKa6gu79OWjxXOKBC6l07ztjDSA3CRgPbvdmbLzZy0YjRKJwDyzc1
	HCa073LTV/aIbm4uOKBHMEIMs3xiqV6I5qEvi6I4ai5s7WxkTwmmaNzMe9WXgXCE8mqynlghEua
	D3r0db3ILhlmyrgYdFb0j1vKXEBet+qXx9CagJoF9ulOPGwblWAPb7CVyNC/6pXrSsCkNfZJA9Z
	MG12/8Q==
X-Received: by 2002:a05:6000:1567:b0:386:3cfa:62ad with SMTP id ffacd0b85a97d-38a872f6970mr2227398f8f.1.1736338466446;
        Wed, 08 Jan 2025 04:14:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7arOIchse9o494js1Tab5nOKasKdGhG0D/75m9o3epafPGRuC3YbVQ6l4Ror1ppOwwQPlTw==
X-Received: by 2002:a05:6000:1567:b0:386:3cfa:62ad with SMTP id ffacd0b85a97d-38a872f6970mr2227363f8f.1.1736338466073;
        Wed, 08 Jan 2025 04:14:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7? (p200300cbc70d3a00d73c06a8ca9f1df7.dip0.t-ipconnect.de. [2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828a8dsm53157942f8f.2.2025.01.08.04.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 04:14:24 -0800 (PST)
Message-ID: <29278ec5-a7ec-4935-94e2-0b56e601f385@redhat.com>
Date: Wed, 8 Jan 2025 13:14:22 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] fs/proc/vmcore: kdump support for virtio-mem on
 s390
To: Heiko Carstens <hca@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kexec@lists.infradead.org, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20241204125444.1734652-1-david@redhat.com>
 <20250108070407-mutt-send-email-mst@kernel.org>
 <20250108121043.7704-I-hca@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250108121043.7704-I-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.01.25 13:10, Heiko Carstens wrote:
> On Wed, Jan 08, 2025 at 07:04:23AM -0500, Michael S. Tsirkin wrote:
>> On Wed, Dec 04, 2024 at 01:54:31PM +0100, David Hildenbrand wrote:
>>> The only "different than everything else" thing about virtio-mem on s390
>>> is kdump: The crash (2nd) kernel allocates+prepares the elfcore hdr
>>> during fs_init()->vmcore_init()->elfcorehdr_alloc(). Consequently, the
>>> kdump kernel must detect memory ranges of the crashed kernel to
>>> include via PT_LOAD in the vmcore.
>>>
>>> On other architectures, all RAM regions (boot + hotplugged) can easily be
>>> observed on the old (to crash) kernel (e.g., using /proc/iomem) to create
>>> the elfcore hdr.
>>>
>>> On s390, information about "ordinary" memory (heh, "storage") can be
>>> obtained by querying the hypervisor/ultravisor via SCLP/diag260, and
>>> that information is stored early during boot in the "physmem" memblock
>>> data structure.
>>>
>>> But virtio-mem memory is always detected by as device driver, which is
>>> usually build as a module. So in the crash kernel, this memory can only be
>>> properly detected once the virtio-mem driver started up.
>>>
>>> The virtio-mem driver already supports the "kdump mode", where it won't
>>> hotplug any memory but instead queries the device to implement the
>>> pfn_is_ram() callback, to avoid reading unplugged memory holes when reading
>>> the vmcore.
>>>
>>> With this series, if the virtio-mem driver is included in the kdump
>>> initrd -- which dracut already takes care of under Fedora/RHEL -- it will
>>> now detect the device RAM ranges on s390 once it probes the devices, to add
>>> them to the vmcore using the same callback mechanism we already have for
>>> pfn_is_ram().
>>>
>>> To add these device RAM ranges to the vmcore ("patch the vmcore"), we will
>>> add new PT_LOAD entries that describe these memory ranges, and update
>>> all offsets vmcore size so it is all consistent.
>>>
>>> My testing when creating+analyzing crash dumps with hotplugged virtio-mem
>>> memory (incl. holes) did not reveal any surprises.
>>>
>>> Patch #1 -- #7 are vmcore preparations and cleanups
>>> Patch #8 adds the infrastructure for drivers to report device RAM
>>> Patch #9 + #10 are virtio-mem preparations
>>> Patch #11 implements virtio-mem support to report device RAM
>>> Patch #12 activates it for s390, implementing a new function to fill
>>>            PT_LOAD entry for device RAM
>>
>> Who is merging this?
>> virtio parts:
>>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> I guess this series should go via Andrew Morton. Andrew?
> 
> Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390
> 

Yes, it's in mm-unstable already for quite a while.

Thanks for the acks!

-- 
Cheers,

David / dhildenb


