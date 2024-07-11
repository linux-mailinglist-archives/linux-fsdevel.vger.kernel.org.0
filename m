Return-Path: <linux-fsdevel+bounces-23578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AE792EB3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 17:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C078E1F226BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D5E168C26;
	Thu, 11 Jul 2024 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fR+68BF9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3081E531
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2024 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710267; cv=none; b=ZGH1YSeMrPwAcpTzkT760I2khV3HKuRmoFaN8VxaotHbIN3ytzRa8vd60GxucOjWeYPhsRIMpYgoojhux+HR8OEEK9y1vsImofZC0xYwODSh29zC7qufcjDernBeTXSeoI1plStTTlJuxZHcVN1stJh19dTN4y9LDLijcnZgvtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710267; c=relaxed/simple;
	bh=RIhfOzVcXIy7+AwNsdNPGSuaq68Hqj9Gr8kJENzAlEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYf3+PwWam04lmeggb9sM0J9XazIoL9AgYvdqhgMy58rWudO2LY3Bjj//1TLtoKbjoCKQb1mA33ybqGFz9Gm2C9UJZ9VIKD9gxluGkVBnWNiUCa+HmVQtn+R/0couS8N5KdIDg+dVhronr/qRRPgXSVk7OgpUy2zBmV0J/WIU9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fR+68BF9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720710263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbObYPlRhGPWJEjqZQKRQutm+8Td90FVq4wxYtGGsgM=;
	b=fR+68BF9lQFoI3B5xvNR0vhw7HtJIqjPAldkwHBfScQV/xyW05t8Aa19Lfth8+02fnd6lb
	yKSM/y3R+H04vY8sy5jF4Zn9B/ls18WNVJYsEVNd2d8pwKSjc/x1/w7qo/Pa1RqIsEkbyv
	QXpUDLj4X81dBJFWyHYf5eCFus5UhdM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-iBG6SNcJPtKmacHX00wDJw-1; Thu, 11 Jul 2024 11:04:18 -0400
X-MC-Unique: iBG6SNcJPtKmacHX00wDJw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52e994d8e26so1002329e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2024 08:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720710257; x=1721315057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbObYPlRhGPWJEjqZQKRQutm+8Td90FVq4wxYtGGsgM=;
        b=NM/916BeA4fxVfjRH59hXK9iE+0dk0jZ3OTkaTFdt7lGOfOd6LoSzq2epQo2cR7oAq
         ZZ+2XfSO+aNvQDjW5m+VF+elK9DTusB1MgnPhVHysLlEjv8EON2fbprkE/fU4f5EzgvM
         3DAl7q4MOIIlNWZ8sslccH7TY7wWJWUXF+EPVPwPPsB6rvbPnMCpAtNOlzm1LQlsxZ3Q
         OsxSmSA9A65AwyhHD+qdBRC3vQGLXe4mQGNQpFECSjGb1nVO8UlDzvaf8CzdpeOjvGwM
         9+yxsx3AS2V5PmUH38YxeQ0M/YUmU42RtzoMgf+NlZTmTLfejW/usZ4Kafidfr8lrps5
         T+HA==
X-Forwarded-Encrypted: i=1; AJvYcCV7BHClSa/6SiX/fafmVYgHkgUs3WNWEC75XDyeY7kMJ4nA25jpx/110KgU5lMje4nxgEzuQu1MaioZD/4zIc0NgvDPD1KG3XZxlGieeA==
X-Gm-Message-State: AOJu0Ywv9k7K7yLo/GF1Pb1S4KDBd+cCe9F7LXou+Ar5zsL14FLLn0/+
	0HO0yM2tPgX3+PUhAvFnXMrLS/+xLyjNf4Xw+jbCkg/yAnTApmeiwvZss1glGPP5Kz2pvGXx4c4
	2Xz1aPSliTIdoxWxHcF3wm8DEa6vlmjRD0+Rki65We+vkkoQKgabX1UvLvV73iCc=
X-Received: by 2002:a19:915e:0:b0:52e:7f16:96be with SMTP id 2adb3069b0e04-52eb99d4ec8mr4550992e87.65.1720710256762;
        Thu, 11 Jul 2024 08:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZslfRADh61h2K4U2I0v8TWlsmuDejSX07DbIntDk5o01Hp5GIPBHFAcNOq0qN0Q3YbDMbqA==
X-Received: by 2002:a19:915e:0:b0:52e:7f16:96be with SMTP id 2adb3069b0e04-52eb99d4ec8mr4550931e87.65.1720710255957;
        Thu, 11 Jul 2024 08:04:15 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74b:1cd5:1c4c:c09:d73b:c07d? (p200300cfd74b1cd51c4c0c09d73bc07d.dip0.t-ipconnect.de. [2003:cf:d74b:1cd5:1c4c:c09:d73b:c07d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f74462esm118919565e9.48.2024.07.11.08.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 08:04:15 -0700 (PDT)
Message-ID: <90f0cdd6-379f-49a0-9bb2-ba86c3e8ccce@redhat.com>
Date: Thu, 11 Jul 2024 17:04:13 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] virtio-fs: Add 'file' mount option
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
 Miklos Szeredi <mszeredi@redhat.com>, German Maglione
 <gmaglione@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>
References: <20240709111918.31233-1-hreitz@redhat.com>
 <20240709175652.GB1040492@perftesting>
 <8ebfc48f-9a93-45ed-ba88-a4e4447d997a@redhat.com>
 <20240710184222.GA1167307@perftesting>
 <453a5eb6-204f-403a-b41d-faefdbcb8f50@redhat.com>
 <20240711143425.GA1235314@perftesting>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240711143425.GA1235314@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.07.24 16:34, Josef Bacik wrote:
> On Thu, Jul 11, 2024 at 10:21:35AM +0200, Hanna Czenczek wrote:
>> On 10.07.24 20:42, Josef Bacik wrote:
>>> On Wed, Jul 10, 2024 at 09:28:08AM +0200, Hanna Czenczek wrote:
>>>> On 09.07.24 19:56, Josef Bacik wrote:
>>>>> On Tue, Jul 09, 2024 at 01:19:16PM +0200, Hanna Czenczek wrote:
>>>>>> Hi,
>>>>>>
>>>>>> We want to be able to mount filesystems that just consist of one regular
>>>>>> file via virtio-fs, i.e. no root directory, just a file as the root
>>>>>> node.
>>>>>>
>>>>>> While that is possible via FUSE itself (through the 'rootmode' mount
>>>>>> option, which is automatically set by the fusermount help program to
>>>>>> match the mount point's inode mode), there is no virtio-fs option yet
>>>>>> that would allow changing the rootmode from S_IFDIR to S_IFREG.
>>>>>>
>>>>>> To do that, this series introduces a new 'file' mount option that does
>>>>>> precisely that.  Alternatively, we could provide the same 'rootmode'
>>>>>> option that FUSE has, but as laid out in patch 1's commit description,
>>>>>> that option is a bit cumbersome for virtio-fs (in a way that it is not
>>>>>> for FUSE), and its usefulness as a more general option is limited.
>>>>>>
>>>>> All this does is make file an alias for something a little easier for users to
>>>>> read, which can easily be done in libfuse.  Add the code to lib/mount.c to alias
>>>>> 'file' to turn it into rootmode=S_IFREG when it sends it to the kernel, it's not
>>>>> necessary to do this in the kernel.  Thanks,
>>>> This series is not about normal FUSE filesystems (file_system_type
>>>> fuse_fs_type, “fuse”), but about virtio-fs (file_system_type virtio_fs_type,
>>>> “virtiofs”), i.e. a case where libfuse and fusermount are not involved at
>>>> all.  As far as I’m aware, mounting a virtio-fs filesystem with a
>>>> non-directory root inode is currently not possible at all.
>>> Ok so I think I had it backwards in my head, my apologies.
>>>
>>> That being said I still don't understand why this requires a change to virtiofs
>>> at all.
>>>
>>> I have a virtiofs thing attached to my VM.  Inside the vm I do
>>>
>>> mount -t virtiofs <name of thing I've attached to the vm> /directory
>>>
>>> and then on the host machine, virtiofsd is a "normal" FUSE driver, except it's
>>> talking over the socket you setup between the guest and the host.  I assume this
>>> is all correct?
>>>
>>> So then the question is, why does it matter what virtiofsd is exposing?  I guess
>>> that's the better question.  The guest shouldn't have to care if it's a
>>> directory or a file right?  The mountpoint is going to be a directory, whatever
>>> is backing it shouldn't matter.  Could you describe the exact thing you're
>>> trying to accomplish?  Thanks,
>> The mount point needs to be of the same mode as the root node of the mounted
>> filesystem, or it’ll be inaccessible after mounting[1].  In this case, I
>> want to export a regular file as the root node, so the root node must be a
>> regular file, too:
>>
>> host$ echo foo > /tmp/bar
>>
>> host$ virtiofsd --shared-dir /tmp/bar --socket-path /tmp/viofsd.sock
>> --sandbox none
>>
>>
>> guest# mkdir /tmp/mnt-dir
>>
>> guest# mount -t virtiofs virtiofs-tag /tmp/mnt-dir
>>
>> guest# stat /tmp/mnt-dir
>> stat: cannot statx '/tmp/mnt-dir': Input/output error
>>
>> guest# cat /tmp/mnt-dir
>> cat: /tmp/mnt-dir: Input/output error
>>
>> guest# ls /tmp/mnt-dir
>> ls: cannot access '/tmp/mnt-dir': Input/output error
>>
>> guest# umount /tmp/mnt-dir
>>
>> (following with this series applied)
>>
>> guest# touch /tmp/mnt-file
>>
>> guest# mount -t virtiofs virtiofs-tag /tmp/mnt-file -o file
>>
>> guest# stat /tmp/mnt-file
>>    File: /tmp/mnt-file
>>    Size: 4               Blocks: 8          IO Block: 4096   regular file
>> [...]
>>
>> guest# cat /tmp/mnt-file
>> foo
>>
>> guest# ls --file-type /tmp/mnt-file
>> /tmp/mnt-file
>>
>> guest# ls --file-type /tmp
>> mnt-dir/
>> mnt-file
>> [...]
>>
> Got it, this makes sense, thanks for explaining it to me.  You can add
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks!

Hanna


