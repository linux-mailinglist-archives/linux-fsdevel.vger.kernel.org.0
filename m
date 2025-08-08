Return-Path: <linux-fsdevel+bounces-57115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883C8B1ED25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 18:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C46D726530
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 16:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082BC28751E;
	Fri,  8 Aug 2025 16:44:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C7327FB07;
	Fri,  8 Aug 2025 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754671452; cv=none; b=ZBh3o1G6v7KBElU+nFd00o12JDPcqah4i36lS4xiRbPbCkMww6aqnMRZMzoWJlTQCfFjnqK0ZpbPgX25Nsh5pGcUEytT3qnt/m7FNbRV4HjaMkONby1n2MmgfmbHNaBuYCj0jbt/DNbDWhvldVxs0iWuZe4wlLxQ01ho9nspm8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754671452; c=relaxed/simple;
	bh=PXre777B2idTmV51mUoS99uMhDePtl9t6H3/4Aoie/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AwVj6AUWXYvk4ahtmWT2zFk0xecOWNUa0u8kqxjXU9X1KSBp034ztbArc18VvMjDVwLaGT93DtgNxXXU9L1Pa4AySHVAyxfGg+U7Cd6t5fnywFBvLswQExkS56N9dvEKPFMqqYE2VcPpoiGC+5XkrPlm6qsLpVt2XWiOJ16K4O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org; spf=pass smtp.mailfrom=ozlabs.org; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by gandalf.ozlabs.org (Postfix) with ESMTP id 4bz8xh05gdz4xdF;
	Sat,  9 Aug 2025 02:44:08 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bz8xc2nlQz4xcb;
	Sat,  9 Aug 2025 02:44:03 +1000 (AEST)
Message-ID: <bc7e754f-f414-4c43-8f25-03314b894b34@kaod.org>
Date: Fri, 8 Aug 2025 18:44:00 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] vfio/pci: print vfio-device syspath to fdinfo
To: Alex Mastro <amastro@fb.com>, Alex Williamson
 <alex.williamson@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Keith Busch <kbusch@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org
References: <20250804-show-fdinfo-v4-1-96b14c5691b3@fb.com>
 <20250807144938.e0abc7bb-a4-amachhiw@linux.ibm.com>
 <dd0b8e6f-1673-49c3-8018-974d1e7f1a54@kaod.org>
 <20250808205338.dc652e3e-61-amachhiw@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250808205338.dc652e3e-61-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/8/25 17:45, Amit Machhiwal wrote:
> Hi Cédric,
> 
> Please find my comments inline:
> 
> On 2025/08/08 03:49 PM, Cédric Le Goater wrote:
>> Hello Amit,
>>
>> On 8/7/25 11:34, Amit Machhiwal wrote:
>>> Hello,
>>>
>>> On 2025/08/04 12:44 PM, Alex Mastro wrote:
>>>> Print the PCI device syspath to a vfio device's fdinfo. This enables tools
>>>> to query which device is associated with a given vfio device fd.
>>>>
>>>> This results in output like below:
>>>>
>>>> $ cat /proc/"$SOME_PID"/fdinfo/"$VFIO_FD" | grep vfio
>>>> vfio-device-syspath: /sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/0000:e2:05.0/0000:e8:00.0
>>>>
>>>> Signed-off-by: Alex Mastro <amastro@fb.com>
>>>
>>> I tested this patch on a POWER9 bare metal system with a VFIO PCI device and
>>> could see the VFIO device syspath in fdinfo.
>>
>> POWER9 running on OPAL FW : I am curious about the software stack.
>>
>> I suppose this is the latest upstream kernel ?
> 
> Yes, I used the latest upstream kernel and applied this patch on top of commit
> cca7a0aae895.
> 
>> Are you using an upstream QEMU to test too ?
> 
> No, I had used the Fedora 42 distro qemu. The version details are as below:
> 
>    [root@localhost ~]# qemu-system-ppc64 --version
>    QEMU emulator version 9.2.4 (qemu-9.2.4-1.fc42)
>    Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers
> 
> I gave the upstream qemu (HEAD pointing to cd21ee5b27) a try and I see the same
> behavior with that too.
> 
>    [root@localhost ~]# ./qemu-system-ppc64 --version
>    QEMU emulator version 10.0.92 (v10.1.0-rc2-4-gcd21ee5b27-dirty)
>    Copyright (c) 2003-2025 Fabrice Bellard and the QEMU Project developers
> 
>    [root@localhost ~]# cat /proc/52807/fdinfo/191
>    pos:    0
>    flags:  02000002
>    mnt_id: 17
>    ino:    1125
>    vfio-device-syspath: /sys/devices/pci0031:00/0031:00:00.0/0031:01:00.0
> 
>>
>> and which device ?
> 
> I'm using a Broadcom NetXtreme network card (4-port) and passing through its
> fn0.
> 
>    [root@guest ~]# lspci
>    [...]
>    0001:00:01.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
> 
> Please let me know if I may help you with any additional information.

It is good to know that device pass-through still works with upstream on
OpenPower servers.

Have you tried VFs ?

Thanks Amit,

C.


