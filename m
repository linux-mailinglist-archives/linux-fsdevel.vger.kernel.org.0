Return-Path: <linux-fsdevel+bounces-35552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B340D9D5BF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 10:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C1F1F22DA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 09:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0279F1DAC9B;
	Fri, 22 Nov 2024 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPl6Jn/1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980751791EB
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732267840; cv=none; b=NnblbZc9IpjxlWvOkyfyumv+XM3AbSpClFPcE7/8EzuZlK0+XNx8Z8ZOhN0ICMYjdd/X5QvnNqAv8020nje8dve5hu2KnKm8bl69BJk1vXwT7vqdcSjnuLsul/0rep4gPeh5U/JFh93sxkGJeSY/vQsttw0FyzVzdYaxyNvs8QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732267840; c=relaxed/simple;
	bh=KI3YKUPD9vNEr7V3+oI0tMF9YZYmRK144NZhkWv99tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hy1vY/GIZ9JwXtohkla1REhkzojxg0UjbzfebgLjlC/rNFVt4ZN5+NYaLaejc8oRRvANj/+BRNDgtoQe4RZ1IeALc+oy7iQ0eswiou1q/ptwgq2KplKecKtZ4YMMFNhNNHOIPFv4VrdG4c3rdFWUynRxgXsPXOJKHfp+5rE+8OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OPl6Jn/1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732267837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZPzJgPIHxsNdnR7yqCSFuF5OvFAEiAeo8b6cdlkp3Go=;
	b=OPl6Jn/1vGPnVsXGp4JCdOr2KPpnImid6flLepm985EbEfjQL41+zRASG084VFl1QfoiQ3
	GfEBQaJ5G0hmtKICLjCVi7zXboPEDZHgYyBOvhbU8t731l4MC/UY9bLPKqtPaqT04CYHOd
	AddYeI5y8aSAC5XFAn64E+B02DhPlr8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-2o-wfgPlO_yOptVcdcEpFA-1; Fri, 22 Nov 2024 04:30:35 -0500
X-MC-Unique: 2o-wfgPlO_yOptVcdcEpFA-1
X-Mimecast-MFC-AGG-ID: 2o-wfgPlO_yOptVcdcEpFA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43157e3521dso12725135e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 01:30:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732267834; x=1732872634;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZPzJgPIHxsNdnR7yqCSFuF5OvFAEiAeo8b6cdlkp3Go=;
        b=ZlvYFu/spbob3b3K2e48ATPug4ChH8zRG0fQM5wr4nCeTgn2XiE/H9BkVu/R8uD4ht
         2OKd7Vol+gUcXM/7nQxRPcUVk3X1XJ0o6mkGVO97OiJXmgSpxC3efHqt4FUZrsyDwVVK
         +Kw/90cB1nmGpRo1qFxyW6pfQyOhRlcpeqUfIp1XF1364xFx16C9P5kojwYq1jEnd3OJ
         GFq94BW6onOu7DqbHkFU8XA1sr0hOxeJUyfggFx4iSCdo/VQJrSI2E/wq0vkUPvAmDEp
         /tE6OS5DVeAxNN7deHW4xyEe2nM3EGC9cqKDBFdVpbeZUrm68cGAzXd45USJI1ylWf2L
         7YMw==
X-Forwarded-Encrypted: i=1; AJvYcCUUie2LwH/PV5hiJ2eIFYrfMeqDp0wKQRrRpx8cp7CDA50xW2Cp4JdqF71XnTQjJyAxDNPzBhRmO/JJUYsQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyDfkN4R+GAG6Adt6N8G86yXH5Km9zFqdWKnwEUwVBVOIONcZ64
	jNafQ9C+hGbpQclWmnI1jfJg1UVl1BQNAeEdA4XjWeKweh1WcQqdVvLG6vUjDxfGOVhU6Sw7XyF
	9+D4SLNCfR2p0Q7qsFJXhabuD9UOPFayVmJwTM/rr9KVuegQKJSGKIL37deqAeP4=
X-Gm-Gg: ASbGnctYqkm4F5pTk+pLIUP/c4V47cF/yf5BudZQLDQu4LE9+TbvuEkVhhq0a6TUE7H
	hPgkIok4K5hyy7oCAMEkMJMUwrtWbRaCjU85Mb7WS+Jve8sXOa3bp87bqHs/lrT3sv44LUYCjm3
	mBOe29JmYrV96ZQYXePV8H6xZwobdLPc51PJbQcmM6mXEuHsQvLrz0+vEGbNuIKdXcMDAT9lHIV
	o1OQeju9kn9MeajOwv7rr1mfwHNbSSplb6I87NecBvZ+a0fJkvkTMIAlwo0JEGeF4Vl6oGuCxCA
	V+g=
X-Received: by 2002:a05:600c:46c8:b0:431:52a3:d9d9 with SMTP id 5b1f17b1804b1-433ce39b925mr18040275e9.0.1732267834016;
        Fri, 22 Nov 2024 01:30:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE2Jmm0kH5mkdPBXazAl7oCBJsLup6iLzWAKDWw6AnFymT/MfuLEVdTbIYMc4wqCh2umdy0Q==
X-Received: by 2002:a05:600c:46c8:b0:431:52a3:d9d9 with SMTP id 5b1f17b1804b1-433ce39b925mr18039735e9.0.1732267833570;
        Fri, 22 Nov 2024 01:30:33 -0800 (PST)
Received: from [192.168.3.141] (p5b0c6b59.dip0.t-ipconnect.de. [91.12.107.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b01e115asm88763975e9.6.2024.11.22.01.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 01:30:31 -0800 (PST)
Message-ID: <d29d7816-a3e5-4f34-bb0c-dd427931efb4@redhat.com>
Date: Fri, 22 Nov 2024 10:30:29 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/11] fs/proc/vmcore: disallow vmcore modifications
 after the vmcore was opened
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
 <20241025151134.1275575-4-david@redhat.com> <Z0BL/UopaH5Xg5jS@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z0BL/UopaH5Xg5jS@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.11.24 10:16, Baoquan He wrote:
> On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> ......snip...
>> @@ -1482,6 +1470,10 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>>   		return -EINVAL;
>>   	}
>>   
>> +	/* We'll recheck under lock later. */
>> +	if (data_race(vmcore_opened))
>> +		return -EBUSY;
> 

Hi,

> As I commented to patch 7, if vmcore is opened and closed after
> checking, do we need to give up any chance to add device dumping
> as below?
> 
> fd = open(/proc/vmcore);
> ...do checking;
> close(fd);
> 
> quit any device dump adding;
> 
> run makedumpfile on s390;
>    ->fd = open(/proc/vmcore);
>      -> try to dump;
>    ->close(fd);

The only reasonable case where this could happen (with virtio_mem) would 
be when you hotplug a virtio-mem device into a VM that is currently in 
the kdump kernel. However, in this case, the device would not provide 
any memory we want to dump:

(1) The memory was not available to the 1st (crashed) kernel, because
     the device got hotplugged later.
(2) Hotplugged virtio-mem devices show up with "no plugged memory",
     meaning there wouldn't be even something to dump.

Drivers will be loaded (as part of the kernel or as part of the initrd) 
before any kdump action is happening. Similarly, just imagine your NIC 
driver not being loaded when you start dumping to a network share ...

This should similarly apply to vmcoredd providers.

There is another concern I had at some point with changing the effective 
/proc/vmcore size after someone already opened it, and might assume the 
size will stay unmodified (IOW, the file was completely static before 
vmcoredd showed up).

So unless there is a real use case that requires tracking whether the 
file is no longer open, to support modifying the vmcore afterwards, we 
should keep it simple.

I am not aware of any such cases, and my experiments with virtio_mem 
showed that the driver get loaded extremely early from the initrd, 
compared to when we actually start messing with /proc/vmcore from user 
space.

Thanks!

-- 
Cheers,

David / dhildenb


