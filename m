Return-Path: <linux-fsdevel+bounces-35553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66459D5C21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 10:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962A1281999
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 09:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059A81D9A79;
	Fri, 22 Nov 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glCU8Swd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFEF16F85E
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268875; cv=none; b=eEkq+Cbl+eHw+pTmIAV4Orc9z+z5MxmnPawrYWTFdRNmMIcjpwNftIAeWOnAZIDvAm7pIoR7DGHn1qxXj1OPSb219YGPa8fT2Rx7MugoZkk+dLDHatMFE9kwiBFB0drQWtpgOi1IBy20VS/LfRXk3JHxsK3vcMKXSdLep+n6VBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268875; c=relaxed/simple;
	bh=WNryyBl4dVVX3K8sxpI48Twccde7pfNcdJG+7PxRTFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVvoayY1PodIfcKSbfPlxVG+569KZM/AbX/Rgi9bmMOTseAjw3ry/y2dazZ4VlW/oACOzZDXc53s/zZ4k0f7RLaPH5+oYZ5C2EOfwg21Fydryzrb4nbb9TSz/VV/AQyUmu+/9VGPIPgax8TrJglwe6kEMYUYBG8iLjUg7tEvnKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glCU8Swd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732268872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ci6p4OAEag/t/B0pMHs058dh2BK7Mn/De3aq3KIhX5Y=;
	b=glCU8SwdxPpwkemJD4U4x1CZxrCTyZ/a3OkGfV9x9VRaDkO2iNXZe7Kz83+lQaoCRHWW7r
	953srOrLiweTmAAi8QfGnKoaejNZr6bJ1EzWLhvTrJC73MZ1SS9cFgINAwadMzi+Eds5Mm
	JLKE9THoqMUpNb5u6lbksbwXJNFLB3o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-V7QuYQAxMheXU433bilA9g-1; Fri, 22 Nov 2024 04:47:50 -0500
X-MC-Unique: V7QuYQAxMheXU433bilA9g-1
X-Mimecast-MFC-AGG-ID: V7QuYQAxMheXU433bilA9g
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43152cd2843so11838215e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 01:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268869; x=1732873669;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ci6p4OAEag/t/B0pMHs058dh2BK7Mn/De3aq3KIhX5Y=;
        b=kFM1SRgKtso9u70szL2L9HjW6M4ORS2m7VTnUVGWkNh3OrX6gJ9o7ScZ3XQf3rBVA0
         /U4HqwpOBo5gleZu6COfuUlXSz7dD4iI9+oZXW4ic1rf71VFB61xItSfhy8KqYeeYOih
         KKbhQbY87AcTRndggVvvOaOX8xLzj6uF0iWo0rByG2NDnZrZ9JTFLiz/hcwuJadAbWYH
         Ehpk7nliicdL5fnzYOD7ox+svVP/v/a6lYsHTMhbl/tafv7OYr/ZxUSX8Mr9OjOv6Fxy
         xMN3Y3x1SIWMce8iDKddvNwuS7ANYDp3MyGaXvqseOAHnrW0SN1DOsKkQBD+/GnKq1Dg
         0V8g==
X-Forwarded-Encrypted: i=1; AJvYcCWQvJ6y/wCMJYcjRzUZ0wFjzVh/6qlKrI2KWxY+q5RndYuZU915v0+OiTNPw+2s9nkZhMuCW/tiokM4yCtU@vger.kernel.org
X-Gm-Message-State: AOJu0YwtGaAi09VOgIerLdxzsYGvPTGk2RkcHgnjWZiZ0CcfHePoygjd
	NXwwxOlyHlA8OqN+BfnbXPfckVXAbTdh52/YEd5ICdOlFFkQzP83+Svls9nKev1dmVqJro/6uM5
	zVC2/1IWQD+rrhWpGduG3AqTboKmaZFUQV6oeV6LEdVUNBj5p7zwoZmLqBHhp9+A=
X-Gm-Gg: ASbGnctNnir6cLWGVBW3wEV68R9GLbvM0eHIhqHE0L4SQjh7CkE8A2rSTUZi8MKZflR
	+XGn1we5WNr1hEXBobY8dYYQI+t/X/0sgkkDEuKPGb9nirFDgtRHm/e/hoWAWdENivDgAW5+AtQ
	ZP2+5R9n1A53GEUUs9gLya2dpoDF06jSNoOVGFz+8S0qj85IulaRQZlQgAKzSE4i5rwO85puyEr
	SwCHVVFpsuCpH2mmMP2CtRUW8Tqoy4QGg1omnbHATb45joGwHLDh+n2dYuiTIDcfciA7CarvI67
	hiXqbDfdCei4sDiade7GZRZCd3KhTjLWDxEI4N4gegEvw2kqR4OnjyMyK870z5pJ6C9Nmr4Sct0
	=
X-Received: by 2002:a5d:6d8c:0:b0:381:f08b:71a4 with SMTP id ffacd0b85a97d-38260bce4a4mr2031155f8f.45.1732268869386;
        Fri, 22 Nov 2024 01:47:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzdx/gLIZH1VTc8mr3WHY/86y1dvP0OX0vMKHqWCr02PkymP5OabS5ttIAfpHLubkoBaO9IA==
X-Received: by 2002:a5d:6d8c:0:b0:381:f08b:71a4 with SMTP id ffacd0b85a97d-38260bce4a4mr2031131f8f.45.1732268869025;
        Fri, 22 Nov 2024 01:47:49 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8? (p200300cbc70b7a009ccd0493d8e29ac8.dip0.t-ipconnect.de. [2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825faf9dd2sm1906180f8f.26.2024.11.22.01.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 01:47:47 -0800 (PST)
Message-ID: <3866cec8-9983-4adf-b96e-42fa728c84a8@redhat.com>
Date: Fri, 22 Nov 2024 10:47:45 +0100
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
 <20241025151134.1275575-8-david@redhat.com> <Z0AzR2Yhl527wkbP@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z0AzR2Yhl527wkbP@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.11.24 08:31, Baoquan He wrote:
> On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> ......snip...
>> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
>> index 3e90416ee54e..c332a9a4920b 100644
>> --- a/fs/proc/vmcore.c
>> +++ b/fs/proc/vmcore.c
>> @@ -69,6 +69,8 @@ static LIST_HEAD(vmcore_cb_list);
>>   /* Whether the vmcore has been opened once. */
>>   static bool vmcore_opened;
>>   
>> +static void vmcore_process_device_ram(struct vmcore_cb *cb);
>> +
>>   void register_vmcore_cb(struct vmcore_cb *cb)
>>   {
>>   	INIT_LIST_HEAD(&cb->next);
>> @@ -80,6 +82,8 @@ void register_vmcore_cb(struct vmcore_cb *cb)
>>   	 */
>>   	if (vmcore_opened)
>>   		pr_warn_once("Unexpected vmcore callback registration\n");
>> +	else if (cb->get_device_ram)
>> +		vmcore_process_device_ram(cb);
> 
> Global variable 'vmcore_opened' is used to indicate if /proc/vmcore is
> opened. With &vmcore_mutex, we don't need to worry about concurrent
> opening and modification. However, if people just open /proc/vmcore and
> close it after checking, then s390 will miss the vmcore dumping, is it
> acceptable?

See my reply to your other mail (patch #3).

> 
>>   	mutex_unlock(&vmcore_mutex);
>>   }
>>   EXPORT_SYMBOL_GPL(register_vmcore_cb);
>> @@ -1511,6 +1515,158 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
> ......
>> +
>> +static void vmcore_process_device_ram(struct vmcore_cb *cb)
>> +{
>> +	unsigned char *e_ident = (unsigned char *)elfcorebuf;
>> +	struct vmcore_mem_node *first, *m;
>> +	LIST_HEAD(list);
>> +	int count;
>> +
>> +	if (cb->get_device_ram(cb, &list)) {
>> +		pr_err("Kdump: obtaining device ram ranges failed\n");
>> +		return;
>> +	}
>> +	count = list_count_nodes(&list);
>> +	if (!count)
>> +		return;
>> +
>> +	/* We only support Elf64 dumps for now. */
>> +	if (WARN_ON_ONCE(e_ident[EI_CLASS] != ELFCLASS64)) {
>> +		pr_err("Kdump: device ram ranges only support Elf64\n");
>> +		goto out_free;
>> +	}
> 
> Only supporting Elf64 dumps seems to be a basic checking, do we need
> to put it at the beginning of function? Otherwise, we spend efforts to
> call cb->get_device_ram(), then fail.

The idea was that if there is nothing to add, then the elf class doesn't 
matter. But yes, I can move this further up.

Thanks!

-- 
Cheers,

David / dhildenb


