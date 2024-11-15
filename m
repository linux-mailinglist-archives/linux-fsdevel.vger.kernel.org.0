Return-Path: <linux-fsdevel+bounces-34879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8BA9CDAF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 09:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DF41F21991
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 08:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D8618CC1C;
	Fri, 15 Nov 2024 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cimm8ghR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8A41632E7
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660917; cv=none; b=g21nbByncxhrAQBJWgP82ZVENrnQaZ03xCzph44kPsF3lvKeNrGzm4lGPNp/jXXvS5y6TAauCokvr767dkeyDBo15M6/j7x7KzU8NXrdHS5qf7Zh+ncXeE1TfxjCbAAMI1l3ZfMTZFGwaD3UteHcEBomfIxtl08Mh/fcH98Luzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660917; c=relaxed/simple;
	bh=KZaTCwl5/7/xBzUr+GvViHdVkA0LFzfo4lirVKWO8GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGVSGXKV15Y+xcGN/eVdmdeOLY5TTQzSQ52/4vjwvSLlKeGoGGl9kT4VIODAbn0rOh60ggRCaTNeCTYe7AdvgAJy9JWTs3/kEBks4rhGiBMImT6YGMkk2rL5qmZvdwKUcxFfZ+K0wolcJ79+njlJBv/odBWCXUO8jWEOX8y0jm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cimm8ghR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731660915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hAIAA7M9wulpOH1pcCM6SAcrhfMPokr2Di+1gDkf/AU=;
	b=cimm8ghRGMuvOF9A6UQj6ufvsCRgLMv0Y2fLN5bIvi3LdAdSoP2VEssgppgJMAdIyyd5H0
	Nx51Wd747PINsZRSG6UYWuleaqAZQ5ToyuheGFp10GavrH9fJhmTZYqP8jgyHwPyaoj3R6
	1FXsD4z2cK2hLaNw+d3isk3PX9mDLpU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-48BX-oONP9-uuWQ01vGkbw-1; Fri, 15 Nov 2024 03:55:13 -0500
X-MC-Unique: 48BX-oONP9-uuWQ01vGkbw-1
X-Mimecast-MFC-AGG-ID: 48BX-oONP9-uuWQ01vGkbw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43157e3521dso10931355e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 00:55:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731660912; x=1732265712;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hAIAA7M9wulpOH1pcCM6SAcrhfMPokr2Di+1gDkf/AU=;
        b=ChwwPk9AC3kdvHKw7Yij0Tg5BWiQovITvTv2vWoonszYQzZmdEikC9Jga+2OOeNYJ8
         B0C1tpWgyzcYOJYqZC4TDVOh/whDJ6+tGt6xAw8FA9u+tfCZIwHds9X1VyfxtpgzrTqf
         EK7hIjmjd4k2jbcSE2DXFYjhzqg5rNDiCnEi6zfnepRQaKSKNF+WBYgiidsorEsaXcts
         d+DQeGGEPlFWxdSALsTdZL5QzUWUAwex+yaLRxlGlOUFPG3fWOeTvgHGkw27eEqB4NO2
         3//AYp8rlsc3iSJhMSpQFSHbqkNb69BAH/6IRJFJ9YLd3jxwXehbSvEA8HcUIwg6Rmr2
         Vz4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUI3EqfxGUMjj9m4xtOJlngsHotHp1S7F9Hah3X/Fx0GqXuW71fEhjSyDX91spCEBLtivMQzTve4LsW/pXa@vger.kernel.org
X-Gm-Message-State: AOJu0YxxoDkygyxxmTXvDBUAno4Ll9KKBH9s9n+oPReEex+J5eSW+MPe
	bQOmfpXXSimiidMjUsh0w7w9+1WsWK4OYhs7W18+fMJ/WTwYpUNDGPvvWbz/HRv1AHNXhHl2R+I
	O4xpaRFlCg9RsPHrFYkaKO81sPyjK+RR1M3kyteGGtCaPZ+/lMAGbyG6Vz/DoxgE=
X-Received: by 2002:a05:600c:3d86:b0:431:6083:cd38 with SMTP id 5b1f17b1804b1-432df7203aemr13958915e9.6.1731660912061;
        Fri, 15 Nov 2024 00:55:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvUGx7iWk3PQvRCc1l6MRIL8JhbxHCh72nhh8kJajEsnmwrLEeB/CeCx/cWKXViuHaYcVO8A==
X-Received: by 2002:a05:600c:3d86:b0:431:6083:cd38 with SMTP id 5b1f17b1804b1-432df7203aemr13958655e9.6.1731660911667;
        Fri, 15 Nov 2024 00:55:11 -0800 (PST)
Received: from [192.168.3.141] (p5b0c694e.dip0.t-ipconnect.de. [91.12.105.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265e16sm50538415e9.12.2024.11.15.00.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 00:55:10 -0800 (PST)
Message-ID: <d7353fde-f560-4925-8ef8-0fe10654e87f@redhat.com>
Date: Fri, 15 Nov 2024 09:55:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/11] fs/proc/vmcore: kdump support for virtio-mem on
 s390
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
 <ZzcKY8hap3OMqTjC@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZzcKY8hap3OMqTjC@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.11.24 09:46, Baoquan He wrote:
> On 10/25/24 at 05:11pm, David Hildenbrand wrote:
>> This is based on "[PATCH v3 0/7] virtio-mem: s390 support" [1], which adds
>> virtio-mem support on s390.
>>
>> The only "different than everything else" thing about virtio-mem on s390
>> is kdump: The crash (2nd) kernel allocates+prepares the elfcore hdr
>> during fs_init()->vmcore_init()->elfcorehdr_alloc(). Consequently, the
>> crash kernel must detect memory ranges of the crashed/panicked kernel to
>> include via PT_LOAD in the vmcore.
>>
>> On other architectures, all RAM regions (boot + hotplugged) can easily be
>> observed on the old (to crash) kernel (e.g., using /proc/iomem) to create
>> the elfcore hdr.
>>
>> On s390, information about "ordinary" memory (heh, "storage") can be
>> obtained by querying the hypervisor/ultravisor via SCLP/diag260, and
>> that information is stored early during boot in the "physmem" memblock
>> data structure.
>>
>> But virtio-mem memory is always detected by as device driver, which is
>> usually build as a module. So in the crash kernel, this memory can only be
>                                         ~~~~~~~~~~~
>                                         Is it 1st kernel or 2nd kernel?
> Usually we call the 1st kernel as panicked kernel, crashed kernel, the
> 2nd kernel as kdump kernel.

It should have been called "kdump (2nd) kernel" here indeed.

>> properly detected once the virtio-mem driver started up.
>>
>> The virtio-mem driver already supports the "kdump mode", where it won't
>> hotplug any memory but instead queries the device to implement the
>> pfn_is_ram() callback, to avoid reading unplugged memory holes when reading
>> the vmcore.
>>
>> With this series, if the virtio-mem driver is included in the kdump
>> initrd -- which dracut already takes care of under Fedora/RHEL -- it will
>> now detect the device RAM ranges on s390 once it probes the devices, to add
>> them to the vmcore using the same callback mechanism we already have for
>> pfn_is_ram().
> 
> Do you mean on s390 virtio-mem memory region will be detected and added
> to vmcore in kdump kernel when virtio-mem driver is initialized? Not
> sure if I understand it correctly.

Yes exactly. In the kdump kernel, the driver gets probed and registers 
the vmcore callbacks. From there, we detect and add the device regions.

Thanks!

-- 
Cheers,

David / dhildenb


