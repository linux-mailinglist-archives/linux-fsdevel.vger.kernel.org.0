Return-Path: <linux-fsdevel+bounces-36134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2C69DC23C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 11:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053E91648C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 10:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB53194AFB;
	Fri, 29 Nov 2024 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NL6C1OXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A885818EFC1
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732876703; cv=none; b=NfL+mL8Ol+USvG4ufcp8itRvkyJBxr0V3QddZoj5IGpRi9JNOWcV1ZyqOa8AgQq0iM7DhhzCQAt4zD8qdM2UMmS39og5GlN0rRoO3t3vfyPc80Y3Pfn4p6r4H/QrKgrn0kK24WGbF1fF9Eyy+p3h/lRDjCS7gBvi3go5CRPDU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732876703; c=relaxed/simple;
	bh=SsUZyudyCyMmcAMe34mYJ0U6H1gcKuMllez6Hd3Y17A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQ7TFTpew1yJwOVZ8CobNuni+S92ElgtnEaxlFbpnsTFJdDYkUvP5p7WAkBbDdx8wkMbBMLjyJdBDfWurqiBv5m2BgFlOiUI5C/FR9FSfkPxo2hpY+4UjdfRLXKN885O5TRotEfy6op/GOiFYjqzf/aWJlMtuPRokKk8di6jNPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NL6C1OXN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732876699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5l5BKI0l4LZnnlOw9f9778HU6B8mn/V5T9U5nE1GYbQ=;
	b=NL6C1OXNyaZ/JPMUP1P3b7qrqVrKt1aAljrqHiahZm6JdbggrYRg/O3rEsgm2iOgp9Q+lE
	phHWdxjl4w0TbScyuLE116DjEnNDmq79KTbhvOUajthq1TP06vc9o+f5E6kJr6OZ+Ye3nV
	iOmh1BSze+YVPj0ABeKycccCFieQD9g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-ZCGqrrj_ODCxMxZQAnET4Q-1; Fri, 29 Nov 2024 05:38:17 -0500
X-MC-Unique: ZCGqrrj_ODCxMxZQAnET4Q-1
X-Mimecast-MFC-AGG-ID: ZCGqrrj_ODCxMxZQAnET4Q
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e0f3873cso22481f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 02:38:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732876696; x=1733481496;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5l5BKI0l4LZnnlOw9f9778HU6B8mn/V5T9U5nE1GYbQ=;
        b=ZmoL2sc6NzBkaWYNg+UKXA/tmrLKD/WnKCYUuLVvTltsIzToLbd1/H3OIdVbSlPqgX
         DkFFz9kfWnmu6MmM8iyrgsFkG369WhFG9rECu4Lk4pOU1kerj7Z1ocJtFN3crA1kSHMT
         OCQWv1vtO7JYf0HHz1/crQGRpKdCDEQle8qH2Y8mSwjGeMyAZwYsriMS8ZW06oKrJhYy
         Ts9B0XO9ex079UHgBp7vd9hz1eSrweXc4uFwdZhYIi6dppGc4kYsoEsUjcJt02ucyR0P
         vwOKsAAZ3R8fug/im7zVcmZBJAvv07w/TetoEgcFCJnDKW3ePkO+IUvHjlpPyyq6hjtr
         734w==
X-Forwarded-Encrypted: i=1; AJvYcCVEffXweUif5odeWXFOpxJbSPDhxXsHjIS+Ntrtf2FOQGCmiGlgIH/I6W/uobAbbHuiMqG7k4NDTOeHrQQw@vger.kernel.org
X-Gm-Message-State: AOJu0Yyurjbrz0ZXsDsSGCe5Pk/aDHdcQptcutwyNqMiyb4A20nG6up1
	dmbu3+m+6qxMna5BDrbFDAP+KgrsnpliZIGiaeIG34AKuDIeDiivHMtF9jEFBfLbj+UPMxgFa5Y
	uXpTbJDJrNS7WufYlVZe5Cxl6aeX4BalecoRVaZ+XUB910NqcCtVVEIdg4gjU9ck=
X-Gm-Gg: ASbGncsY55XPn4R31Wof5KitzRQlqFm1o9xRMySO4eamGkuI/ajdx8CYv2nOzgSMiec
	zfpPQLTVcYaXzjdsPfBYCiLKCebqIcnvBFO+THTeNBxB/bf3XFhiHFeRMtHI3Z/ese7N7hjq+1/
	d9V3ERwRnhQw1W3SGeNVnvHtTgDKcO/fhZABOrM2VsggHR0NwaSc9+nOp/e03dfT6SmypL9lJZQ
	1o8wQqltOJF5QhbSw+o75emuysOVQeJKEWAigfkVi4OcPA+9nFGNf5NqBcy5yzd873/1g5uWphN
	SsLmvIq91d1839OLb5JMVCvT917kFWoHOp2z4ncN6OEN8XKGwCCweyHscsEcjgBsJemWo8K0osx
	Seg==
X-Received: by 2002:a05:6000:1541:b0:37e:f8a1:596e with SMTP id ffacd0b85a97d-385c6eb6aeemr7845879f8f.11.1732876695624;
        Fri, 29 Nov 2024 02:38:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOsw1An7Q/meUEBvvXObJL5Eak2wen/FF0/RDLBz/ZjxjAoncCEhZrXues5Tm5dbfallRPbw==
X-Received: by 2002:a05:6000:1541:b0:37e:f8a1:596e with SMTP id ffacd0b85a97d-385c6eb6aeemr7845840f8f.11.1732876695042;
        Fri, 29 Nov 2024 02:38:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c71c:a700:bba7:849a:ecf1:5404? (p200300cbc71ca700bba7849aecf15404.dip0.t-ipconnect.de. [2003:cb:c71c:a700:bba7:849a:ecf1:5404])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd7fc33sm4045579f8f.94.2024.11.29.02.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 02:38:14 -0800 (PST)
Message-ID: <a7ccbd86-2a62-4191-8742-ce45b6e8f73c@redhat.com>
Date: Fri, 29 Nov 2024 11:38:13 +0100
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
 <d29d7816-a3e5-4f34-bb0c-dd427931efb4@redhat.com>
 <Z0SMqYX8gMvdiU4T@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z0SMqYX8gMvdiU4T@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.11.24 15:41, Baoquan He wrote:
> On 11/22/24 at 10:30am, David Hildenbrand wrote:
>> On 22.11.24 10:16, Baoquan He wrote:
>>> On 10/25/24 at 05:11pm, David Hildenbrand wrote:
>>> ......snip...
>>>> @@ -1482,6 +1470,10 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>>>>    		return -EINVAL;
>>>>    	}
>>>> +	/* We'll recheck under lock later. */
>>>> +	if (data_race(vmcore_opened))
>>>> +		return -EBUSY;
>>>
>>
>> Hi,
>>
>>> As I commented to patch 7, if vmcore is opened and closed after
>>> checking, do we need to give up any chance to add device dumping
>>> as below?
>>>
>>> fd = open(/proc/vmcore);
>>> ...do checking;
>>> close(fd);
>>>
>>> quit any device dump adding;
>>>
>>> run makedumpfile on s390;
>>>     ->fd = open(/proc/vmcore);
>>>       -> try to dump;
>>>     ->close(fd);
>>
>> The only reasonable case where this could happen (with virtio_mem) would be
>> when you hotplug a virtio-mem device into a VM that is currently in the
>> kdump kernel. However, in this case, the device would not provide any memory
>> we want to dump:
>>
>> (1) The memory was not available to the 1st (crashed) kernel, because
>>      the device got hotplugged later.
>> (2) Hotplugged virtio-mem devices show up with "no plugged memory",
>>      meaning there wouldn't be even something to dump.
>>
>> Drivers will be loaded (as part of the kernel or as part of the initrd)
>> before any kdump action is happening. Similarly, just imagine your NIC
>> driver not being loaded when you start dumping to a network share ...
>>
>> This should similarly apply to vmcoredd providers.
>>
>> There is another concern I had at some point with changing the effective
>> /proc/vmcore size after someone already opened it, and might assume the size
>> will stay unmodified (IOW, the file was completely static before vmcoredd
>> showed up).
>>
>> So unless there is a real use case that requires tracking whether the file
>> is no longer open, to support modifying the vmcore afterwards, we should
>> keep it simple.
>>
>> I am not aware of any such cases, and my experiments with virtio_mem showed
>> that the driver get loaded extremely early from the initrd, compared to when
>> we actually start messing with /proc/vmcore from user space.
> 
> Hmm, thanks for sharing your thoughts.

To assist the discussion, here is the kdump dmesg output on s390x with the
virtio-mem driver as part of the initrd:


[Fri Nov 29 04:55:28 2024] Run /init as init process
[Fri Nov 29 04:55:28 2024]   with arguments:
[Fri Nov 29 04:55:28 2024]     /init
[Fri Nov 29 04:55:28 2024]   with environment:
[Fri Nov 29 04:55:28 2024]     HOME=/
[Fri Nov 29 04:55:28 2024]     TERM=linux
[Fri Nov 29 04:55:28 2024]     numa=off
[Fri Nov 29 04:55:28 2024]     cma=0
[Fri Nov 29 04:55:28 2024] loop: module loaded
[Fri Nov 29 04:55:28 2024] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[Fri Nov 29 04:55:28 2024] loop0: detected capacity change from 0 to 45280
[Fri Nov 29 04:55:28 2024] overlayfs: upper fs does not support RENAME_WHITEOUT.
[Fri Nov 29 04:55:28 2024] overlayfs: failed to set xattr on upper
[Fri Nov 29 04:55:28 2024] overlayfs: ...falling back to uuid=null.
[Fri Nov 29 04:55:28 2024] systemd[1]: Successfully made /usr/ read-only.
[Fri Nov 29 04:55:28 2024] systemd[1]: systemd 256.8-1.fc41 running in system mode [...]
[Fri Nov 29 04:55:28 2024] systemd[1]: Detected virtualization kvm.
[Fri Nov 29 04:55:28 2024] systemd[1]: Detected architecture s390x.
[Fri Nov 29 04:55:28 2024] systemd[1]: Running in initrd.
[Fri Nov 29 04:55:28 2024] systemd[1]: No hostname configured, using default hostname.
[Fri Nov 29 04:55:28 2024] systemd[1]: Hostname set to <localhost>.
[Fri Nov 29 04:55:28 2024] systemd[1]: Queued start job for default target initrd.target.
[Fri Nov 29 04:55:28 2024] systemd[1]: Started systemd-ask-password-console.path - Dispatch Password Requests to Console Directory Watch.
[Fri Nov 29 04:55:28 2024] systemd[1]: Expecting device dev-mapper-sysvg\x2droot.device - /dev/mapper/sysvg-root...
[Fri Nov 29 04:55:28 2024] systemd[1]: Reached target initrd-usr-fs.target - Initrd /usr File System.
[Fri Nov 29 04:55:28 2024] systemd[1]: Reached target paths.target - Path Units.
[Fri Nov 29 04:55:28 2024] systemd[1]: Reached target slices.target - Slice Units.
[Fri Nov 29 04:55:28 2024] systemd[1]: Reached target swap.target - Swaps.
[Fri Nov 29 04:55:28 2024] systemd[1]: Reached target timers.target - Timer Units.
[Fri Nov 29 04:55:28 2024] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[Fri Nov 29 04:55:28 2024] systemd[1]: Listening on systemd-journald.socket - Journal Sockets.
[Fri Nov 29 04:55:28 2024] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[Fri Nov 29 04:55:28 2024] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[Fri Nov 29 04:55:28 2024] systemd[1]: Reached target sockets.target - Socket Units.
[Fri Nov 29 04:55:28 2024] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
[Fri Nov 29 04:55:28 2024] systemd[1]: memstrack.service - Memstrack Anylazing Service was skipped because no trigger condition checks were met.
[Fri Nov 29 04:55:28 2024] systemd[1]: Starting systemd-journald.service - Journal Service...
[Fri Nov 29 04:55:28 2024] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[Fri Nov 29 04:55:28 2024] systemd[1]: Starting systemd-vconsole-setup.service - Virtual Console Setup...
[Fri Nov 29 04:55:28 2024] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
[Fri Nov 29 04:55:28 2024] systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
[Fri Nov 29 04:55:28 2024] systemd[1]: Finished systemd-modules-load.service - Load Kernel Modules.
[Fri Nov 29 04:55:28 2024] systemd[1]: Starting systemd-sysctl.service - Apply Kernel Variables...
[Fri Nov 29 04:55:28 2024] systemd[1]: Finished systemd-sysctl.service - Apply Kernel Variables.
[Fri Nov 29 04:55:28 2024] systemd[1]: Finished systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
[Fri Nov 29 04:55:28 2024] systemd[1]: Starting systemd-sysusers.service - Create System Users...
[Fri Nov 29 04:55:28 2024] systemd-journald[205]: Collecting audit messages is disabled.
[Fri Nov 29 04:55:28 2024] systemd[1]: Started systemd-journald.service - Journal Service.
[Fri Nov 29 04:55:28 2024] evm: overlay not supported
[Fri Nov 29 04:55:29 2024] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[Fri Nov 29 04:55:29 2024] device-mapper: uevent: version 1.0.3
[Fri Nov 29 04:55:29 2024] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
[Fri Nov 29 04:55:29 2024] VFIO - User Level meta-driver version: 0.3
[Fri Nov 29 04:55:29 2024] virtio_blk virtio1: 1/0/0 default/read/poll queues
[Fri Nov 29 04:55:29 2024] virtio_blk virtio1: [vda] 35651584 512-byte logical blocks (18.3 GB/17.0 GiB)
[Fri Nov 29 04:55:29 2024] virtio_mem virtio2: start address: 0x100000000
[Fri Nov 29 04:55:29 2024] virtio_mem virtio2: region size: 0x400000000
[Fri Nov 29 04:55:29 2024] virtio_mem virtio2: device block size: 0x100000
[Fri Nov 29 04:55:29 2024] virtio_mem virtio2: nid: 0
[Fri Nov 29 04:55:29 2024] virtio_mem virtio2: memory hot(un)plug disabled in kdump kernel
[Fri Nov 29 04:55:29 2024] GPT:Primary header thinks Alt. header is not at the end of the disk.
[Fri Nov 29 04:55:29 2024] GPT:14680063 != 35651583
[Fri Nov 29 04:55:29 2024] GPT:Alternate GPT header not at the end of the disk.
[Fri Nov 29 04:55:29 2024] GPT:14680063 != 35651583
[Fri Nov 29 04:55:29 2024] GPT: Use GNU Parted to correct GPT errors.
[Fri Nov 29 04:55:29 2024]  vda: vda1 vda2
[Fri Nov 29 04:55:29 2024] SGI XFS with ACLs, security attributes, scrub, quota, no debug enabled
[Fri Nov 29 04:55:29 2024] XFS: attr2 mount option is deprecated.
[Fri Nov 29 04:55:29 2024] XFS (dm-0): Mounting V5 Filesystem 4171e972-6865-4c47-ba7f-20bd52628650
[Fri Nov 29 04:55:29 2024] XFS (dm-0): Starting recovery (logdev: internal)
[Fri Nov 29 04:55:29 2024] XFS (dm-0): Ending recovery (logdev: internal)
Nov 29 04:55:28 localhost systemd-journald[205]: Journal started
Nov 29 04:55:28 localhost systemd-journald[205]: Runtime Journal (/run/log/journal/1377b7cdca054edd8904cb6f80695a23) is 1.4M, max 11.2M, 9.8M free.
Nov 29 04:55:28 localhost systemd-vconsole-setup[207]: /usr/bin/setfont failed with a "system error" (EX_OSERR), ignoring.
Nov 29 04:55:28 localhost systemd-modules-load[206]: Inserted module 'pkey'
Nov 29 04:55:28 localhost systemd-modules-load[206]: Module 'scsi_dh_alua' is built in
Nov 29 04:55:28 localhost systemd-modules-load[206]: Module 'scsi_dh_emc' is built in
Nov 29 04:55:28 localhost systemd-vconsole-setup[210]: setfont: ERROR kdfontop.c:183 put_font_kdfontop: Unable to load such font with such kernel version
Nov 29 04:55:28 localhost systemd-modules-load[206]: Module 'scsi_dh_rdac' is built in
Nov 29 04:55:28 localhost systemd-sysusers[216]: Creating group 'systemd-journal' with GID 190.
Nov 29 04:55:28 localhost systemd[1]: Finished systemd-sysusers.service - Create System Users.
Nov 29 04:55:28 localhost systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
Nov 29 04:55:28 localhost systemd[1]: Finished systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev.
Nov 29 04:55:28 localhost systemd[1]: Reached target local-fs-pre.target - Preparation for Local File Systems.
Nov 29 04:55:28 localhost systemd[1]: Reached target local-fs.target - Local File Systems.
Nov 29 04:55:28 localhost systemd[1]: Starting systemd-tmpfiles-setup.service - Create System Files and Directories...
Nov 29 04:55:28 localhost systemd-tmpfiles[227]: /usr/lib/tmpfiles.d/var.conf:14: Duplicate line for path "/var/log", ignoring.
Nov 29 04:55:28 localhost systemd[1]: Finished systemd-tmpfiles-setup.service - Create System Files and Directories.
Nov 29 04:55:28 localhost systemd-vconsole-setup[207]: Setting source virtual console failed, ignoring remaining ones.
Nov 29 04:55:28 localhost systemd[1]: Finished systemd-vconsole-setup.service - Virtual Console Setup.
Nov 29 04:55:28 localhost systemd[1]: Starting dracut-cmdline-ask.service - dracut ask for additional cmdline parameters...
Nov 29 04:55:28 localhost systemd[1]: Finished dracut-cmdline-ask.service - dracut ask for additional cmdline parameters.
Nov 29 04:55:28 localhost systemd[1]: Starting dracut-cmdline.service - dracut cmdline hook...
Nov 29 04:55:28 localhost dracut-cmdline[244]: dracut-102-3.fc41
Nov 29 04:55:28 localhost dracut-cmdline[244]: Using kernel command line parameters:  rd.zfcp.conf=0 rd.lvm.lv=sysvg/root   console=tty1 console=ttyS0,115200n8 memhp_default_state=online_movable nr_cpus=1 cgroup_disable=memory numa=off udev.children-max=2 panic=10 transparent_hugepage=never novmcoredd vmcp_cma=0 cma=0 hugetlb_cma=0
Nov 29 04:55:29 localhost dracut-cmdline[244]: cio_ignored disabled on commandline
Nov 29 04:55:29 localhost dracut-cmdline[338]: rm: cannot remove '/etc/zfcp.conf': No such file or directory
Nov 29 04:55:29 localhost systemd[1]: Finished dracut-cmdline.service - dracut cmdline hook.
Nov 29 04:55:29 localhost systemd[1]: Starting dracut-pre-udev.service - dracut pre-udev hook...
Nov 29 04:55:29 localhost systemd[1]: Finished dracut-pre-udev.service - dracut pre-udev hook.
Nov 29 04:55:29 localhost systemd[1]: Starting systemd-udevd.service - Rule-based Manager for Device Events and Files...
Nov 29 04:55:29 localhost systemd-udevd[394]: Using default interface naming scheme 'v255'.
Nov 29 04:55:29 localhost systemd[1]: Started systemd-udevd.service - Rule-based Manager for Device Events and Files.
Nov 29 04:55:29 localhost systemd[1]: dracut-pre-trigger.service - dracut pre-trigger hook was skipped because no trigger condition checks were met.
Nov 29 04:55:29 localhost systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
Nov 29 04:55:29 localhost systemd[1]: Finished systemd-udev-trigger.service - Coldplug All udev Devices.
Nov 29 04:55:29 localhost systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
Nov 29 04:55:29 localhost systemd[1]: Starting dracut-initqueue.service - dracut initqueue hook...
Nov 29 04:55:29 localhost systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
Nov 29 04:55:29 localhost systemd[1]: modprobe@configfs.service: Deactivated successfully.
Nov 29 04:55:29 localhost systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
Nov 29 04:55:29 localhost systemd[1]: systemd-vconsole-setup.service: Deactivated successfully.
Nov 29 04:55:29 localhost systemd[1]: Stopped systemd-vconsole-setup.service - Virtual Console Setup.
Nov 29 04:55:29 localhost systemd[1]: Stopping systemd-vconsole-setup.service - Virtual Console Setup...
Nov 29 04:55:29 localhost systemd[1]: Starting systemd-vconsole-setup.service - Virtual Console Setup...
Nov 29 04:55:29 localhost systemd[1]: Finished systemd-vconsole-setup.service - Virtual Console Setup.
Nov 29 04:55:29 localhost dracut-initqueue[485]: Scanning devices vda2  for LVM logical volumes sysvg/root
Nov 29 04:55:29 localhost dracut-initqueue[485]:   sysvg/root linear
Nov 29 04:55:29 localhost systemd[1]: Found device dev-mapper-sysvg\x2droot.device - /dev/mapper/sysvg-root.
Nov 29 04:55:29 localhost systemd[1]: Reached target initrd-root-device.target - Initrd Root Device.
Nov 29 04:55:29 localhost systemd[1]: Finished dracut-initqueue.service - dracut initqueue hook.
Nov 29 04:55:29 localhost systemd[1]: Reached target remote-fs-pre.target - Preparation for Remote File Systems.
Nov 29 04:55:29 localhost systemd[1]: Reached target remote-fs.target - Remote File Systems.
Nov 29 04:55:29 localhost systemd[1]: Starting dracut-pre-mount.service - dracut pre-mount hook...
Nov 29 04:55:29 localhost systemd[1]: Finished dracut-pre-mount.service - dracut pre-mount hook.
Nov 29 04:55:29 localhost systemd[1]: Starting systemd-fsck-root.service - File System Check on /dev/mapper/sysvg-root...
Nov 29 04:55:29 localhost systemd-fsck[531]: /usr/sbin/fsck.xfs: XFS file system.
Nov 29 04:55:29 localhost systemd[1]: Finished systemd-fsck-root.service - File System Check on /dev/mapper/sysvg-root.
Nov 29 04:55:29 localhost systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
Nov 29 04:55:29 localhost systemd[1]: Mounting sysroot.mount - /sysroot...
Nov 29 04:55:29 localhost systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
Nov 29 04:55:29 localhost systemd[1]: Reached target sysinit.target - System Initialization.
Nov 29 04:55:29 localhost systemd[1]: Reached target basic.target - Basic System.
Nov 29 04:55:29 localhost systemd[1]: System is tainted: unmerged-bin
Nov 29 04:55:29 localhost systemd[1]: Mounted sysroot.mount - /sysroot.
Nov 29 04:55:29 localhost systemd[1]: Reached target initrd-root-fs.target - Initrd Root File System.
Nov 29 04:55:29 localhost systemd[1]: initrd-parse-etc.service - Mountpoints Configured in the Real Root was skipped because of an unmet condition check (ConditionPathExists=!/proc/vmcore).
Nov 29 04:55:29 localhost systemd[1]: Reached target initrd-fs.target - Initrd File Systems.
Nov 29 04:55:29 localhost systemd[1]: Reached target initrd.target - Initrd Default Target.
Nov 29 04:55:29 localhost systemd[1]: dracut-mount.service - dracut mount hook was skipped because no trigger condition checks were met.
Nov 29 04:55:29 localhost systemd[1]: Starting dracut-pre-pivot.service - dracut pre-pivot and cleanup hook...
Nov 29 04:55:29 localhost systemd[1]: Finished dracut-pre-pivot.service - dracut pre-pivot and cleanup hook.
Nov 29 04:55:29 localhost systemd[1]: Starting kdump-capture.service - Kdump Vmcore Save Service...
Nov 29 04:55:29 localhost kdump[574]: Kdump is using the default log level(3).
Nov 29 04:55:30 localhost kdump[618]: saving to /sysroot/var/crash/127.0.0.1-2024-11-29-04:55:29/
Nov 29 04:55:30 localhost kdump[623]: saving vmcore-dmesg.txt to /sysroot/var/crash/127.0.0.1-2024-11-29-04:55:29/
Nov 29 04:55:30 localhost kdump[629]: saving vmcore-dmesg.txt complete
Nov 29 04:55:30 localhost kdump[631]: saving vmcore


Observe how the virtio_mem driver is loaded along with the other drivers that are essential for
any kdump activity.

> I personally think if we could,
> we had better make code as robust as possible.

And that's where we disagree. We will make is less robust if we don't warn the user that something
very unexpected is happening, treating it like it would be normal.

It isn't normal.

> Here, since we have
> already integrated the lock with one vmcore_mutex, whether the vmcoredd
> is added before or after /proc/vmcore opening/closing, it won't harm.
> The benefit is it works well with the current kwown case, virtio-mem
> probing, makedumpfile running. And it also works well with other
> possible cases, e.g if you doubt virtio-mem dumping and want to debug,
> you set rd.break or take any way to drop into emengency shell of kdump
> kernel, you can play it to poke virtio-mem module again and run makedumpfile
> manually or reversing the order or taking any testing. 

Intercepting kdump to trigger it manually will just work as it used to.

Having developed and debugged the virtio_mem driver in kdump mode, I did not once even
were tempted to do any of that, and looking back it would not have been any helpful ;)

Crashing in a VM is easy+cheap, rebooting in a VM is easy+cheap, recompiling virtio_mem +
rebuilding the kdump initrd is easy and cheap.

> Then kernel
> implementation should not preset that user space have to run the
> makedumpfile after the much earlier virtio-mem probing. If we implement
> codes according to preset userspace scenario, that limit the future
> adapttion, IMHO.

It limits the userspace scenario to something that is reasonable and future proof:
start working on the vmcore once the system is sufficiently initialized
(basic driver loaded).

Then have it be immutable, just like it always was before we started allowing to patch it.


The only "alterantive" I see is allow modifying the vmcore after it was closed again,
but still issue a warning if that happens.

But again,  I don't really see any reasonable use case for that.

-- 
Cheers,

David / dhildenb


