Return-Path: <linux-fsdevel+bounces-57082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F765B1E97E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D9D3B926E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6E884A35;
	Fri,  8 Aug 2025 13:49:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2FC23741;
	Fri,  8 Aug 2025 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754660988; cv=none; b=a4y+apl30GhBCUMvAiIX8uXanKUV1LE+egerpq/SpnsbIJt7kStxFaSi/h47dyet3H/89rDwBfkpTQ9vaENjR8mkIiOQ2QkUuGBcgCWwEvI3IEYbdx6K7yNWTOqyIjHV3nr6H7qba/QtsP0ryhu8F4fWW6KoomedDWfuT5ft74s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754660988; c=relaxed/simple;
	bh=B5lDeezqkk5enqfSPL/TI85oGS6wmZYxDK+9tTEhTUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z8iVD0uOfaiwM5kFeJvYl91LnB4aVM4rK9Bb05ureRKNE2UsUY1FzhnIUCmtgliXeDINVuMmpZR2u/ZPXqrLLlF6ajbVmhYidVpEId+TdyeWM2YhmOoMXIfr0+fc8roLtn/6QZ3iKsYOi5snIsOoAQQjCeyiAfswypFSep+yeQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org; spf=pass smtp.mailfrom=ozlabs.org; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by gandalf.ozlabs.org (Postfix) with ESMTP id 4bz54N18ktz4wbp;
	Fri,  8 Aug 2025 23:49:40 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bz54J2g4Qz4wbR;
	Fri,  8 Aug 2025 23:49:36 +1000 (AEST)
Message-ID: <dd0b8e6f-1673-49c3-8018-974d1e7f1a54@kaod.org>
Date: Fri, 8 Aug 2025 15:49:33 +0200
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
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250807144938.e0abc7bb-a4-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Amit,

On 8/7/25 11:34, Amit Machhiwal wrote:
> Hello,
> 
> On 2025/08/04 12:44 PM, Alex Mastro wrote:
>> Print the PCI device syspath to a vfio device's fdinfo. This enables tools
>> to query which device is associated with a given vfio device fd.
>>
>> This results in output like below:
>>
>> $ cat /proc/"$SOME_PID"/fdinfo/"$VFIO_FD" | grep vfio
>> vfio-device-syspath: /sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/0000:e2:05.0/0000:e8:00.0
>>
>> Signed-off-by: Alex Mastro <amastro@fb.com>
> 
> I tested this patch on a POWER9 bare metal system with a VFIO PCI device and
> could see the VFIO device syspath in fdinfo.

POWER9 running on OPAL FW : I am curious about the software stack.

I suppose this is the latest upstream kernel ?
Are you using an upstream QEMU to test too ?

and which device ?

Thanks,

C.




> 
>   Without this patch:
>   -------------------
> 
>      [root@localhost ~]# cat /proc/7059/fdinfo/188
>      pos:    0
>      flags:  02000002
>      mnt_id: 17
>      ino:    1113
> 
>   With this patch:
>   ----------------
>      [root@localhost ~]# cat /proc/7722/fdinfo/188
>      pos:    0
>      flags:  02000002
>      mnt_id: 17
>      ino:    2145
>      vfio-device-syspath: /sys/devices/pci0031:00/0031:00:00.0/0031:01:00.0
> 
> ..., and the code changes LGTM. Hence,
> 
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> 
> Thanks,
> Amit
> 
>> ---
>> Changes in v4:
>> - Remove changes to vfio.h
>> - Link to v3: https://lore.kernel.org/r/20250801-show-fdinfo-v3-1-165dfcab89b9@fb.com
>> Changes in v3:
>> - Remove changes to vfio_pci.c
>> - Add section to Documentation/filesystems/proc.rst
>> - Link to v2: https://lore.kernel.org/all/20250724-show-fdinfo-v2-1-2952115edc10@fb.com
>> Changes in v2:
>> - Instead of PCI bdf, print the fully-qualified syspath (prefixed by
>>    /sys) to fdinfo.
>> - Rename the field to "vfio-device-syspath". The term "syspath" was
>>    chosen for consistency e.g. libudev's usage of the term.
>> - Link to v1: https://lore.kernel.org/r/20250623-vfio-fdinfo-v1-1-c9cec65a2922@fb.com
>> ---
>>   Documentation/filesystems/proc.rst | 14 ++++++++++++++
>>   drivers/vfio/vfio_main.c           | 20 ++++++++++++++++++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
>> index 2a17865dfe39..fc5ed3117834 100644
>> --- a/Documentation/filesystems/proc.rst
>> +++ b/Documentation/filesystems/proc.rst
>> @@ -2162,6 +2162,20 @@ DMA Buffer files
>>   where 'size' is the size of the DMA buffer in bytes. 'count' is the file count of
>>   the DMA buffer file. 'exp_name' is the name of the DMA buffer exporter.
>>   
>> +VFIO Device files
>> +~~~~~~~~~~~~~~~~
>> +
>> +::
>> +
>> +	pos:    0
>> +	flags:  02000002
>> +	mnt_id: 17
>> +	ino:    5122
>> +	vfio-device-syspath: /sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/0000:e2:05.0/0000:e8:00.0
>> +
>> +where 'vfio-device-syspath' is the sysfs path corresponding to the VFIO device
>> +file.
>> +
>>   3.9	/proc/<pid>/map_files - Information about memory mapped files
>>   ---------------------------------------------------------------------
>>   This directory contains symbolic links which represent memory mapped files
>> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
>> index 1fd261efc582..37a39cee10ed 100644
>> --- a/drivers/vfio/vfio_main.c
>> +++ b/drivers/vfio/vfio_main.c
>> @@ -28,6 +28,7 @@
>>   #include <linux/pseudo_fs.h>
>>   #include <linux/rwsem.h>
>>   #include <linux/sched.h>
>> +#include <linux/seq_file.h>
>>   #include <linux/slab.h>
>>   #include <linux/stat.h>
>>   #include <linux/string.h>
>> @@ -1354,6 +1355,22 @@ static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
>>   	return device->ops->mmap(device, vma);
>>   }
>>   
>> +#ifdef CONFIG_PROC_FS
>> +static void vfio_device_show_fdinfo(struct seq_file *m, struct file *filep)
>> +{
>> +	char *path;
>> +	struct vfio_device_file *df = filep->private_data;
>> +	struct vfio_device *device = df->device;
>> +
>> +	path = kobject_get_path(&device->dev->kobj, GFP_KERNEL);
>> +	if (!path)
>> +		return;
>> +
>> +	seq_printf(m, "vfio-device-syspath: /sys%s\n", path);
>> +	kfree(path);
>> +}
>> +#endif
>> +
>>   const struct file_operations vfio_device_fops = {
>>   	.owner		= THIS_MODULE,
>>   	.open		= vfio_device_fops_cdev_open,
>> @@ -1363,6 +1380,9 @@ const struct file_operations vfio_device_fops = {
>>   	.unlocked_ioctl	= vfio_device_fops_unl_ioctl,
>>   	.compat_ioctl	= compat_ptr_ioctl,
>>   	.mmap		= vfio_device_fops_mmap,
>> +#ifdef CONFIG_PROC_FS
>> +	.show_fdinfo	= vfio_device_show_fdinfo,
>> +#endif
>>   };
>>   
>>   static struct vfio_device *vfio_device_from_file(struct file *file)
>>
>> ---
>> base-commit: 4518e5a60c7fbf0cdff393c2681db39d77b4f87e
>> change-id: 20250801-show-fdinfo-ef109ca738cf
>>
>> Best regards,
>> -- 
>> Alex Mastro <amastro@fb.com>
>>
> 


