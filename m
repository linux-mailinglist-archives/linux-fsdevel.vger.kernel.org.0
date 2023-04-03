Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482DC6D3EE2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 10:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjDCIX1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 04:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjDCIXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:23:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F9C86B6
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 01:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680510155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jQzDBAQKeqgfsxxyrlkQCm/LEl+p6ixMadQZXFxQxwQ=;
        b=hygy5Azj6EZbrsfvoxCuoYh8pXS9F2m3eSanNWDHPvUM6YUltLxi21oN862xcnAq6ccwP1
        3Oxd+6P4xYZY2yCzVxAeptOSG5JVywidpo46MKus+ydXhIpqcj3FEF7mqXHao1MageSrMB
        KKhaaH1JWd66Q+3NKm/N398mTVVZLz8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-mX0H5qrUOEWYlACwrqv0fQ-1; Mon, 03 Apr 2023 04:21:53 -0400
X-MC-Unique: mX0H5qrUOEWYlACwrqv0fQ-1
Received: by mail-wm1-f69.google.com with SMTP id u14-20020a05600c19ce00b003f0331154b1so6203903wmq.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 01:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680510112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQzDBAQKeqgfsxxyrlkQCm/LEl+p6ixMadQZXFxQxwQ=;
        b=Y0/GXSud6dB0xJtciqskiNvY0IaPmDYVO83d4CoqGNoAlVMfDDOd2B5yrhQQhaLV5K
         tCFtl6TULeQD/6y1hQMT7nleytx6P1IEJFYzV3R8Wa7nMlyWU6IAXRCouTg/CiAjU6Cx
         sX0FlnKqS1vEDDv8HmdmSSsM+ceooiKcS5VIldcAk+Mb+zbRA3IA5BGExIe1JhrLh8v4
         /He7aNWDm6HptBv3pKKuRoMuv24CZklAf5oRaowV98Qf3rkbAZ74YhIP2+ySSZAvLfow
         Qpw+BS8w7B9SyPbLEIlC4ero/i9lBM8/HduUxCN9IdQo5UoPeAMgS4e+pCF1mo1/TPCC
         1FbQ==
X-Gm-Message-State: AO0yUKVDtxw4ExkPAQA1YjNa7I6leqlWOda20Prw6jabf8I6hbdcViZt
        gzrzuY//0byL4UZzrg4epWlyo9GQm/s2CuLFt56sBXBlQrFpmQ7VJvXVUqP0gw1cSbBEhEmky54
        2wBe1GU40OlIBjhzwL5uBIzeCAw==
X-Received: by 2002:a05:600c:20d:b0:3ee:672d:caae with SMTP id 13-20020a05600c020d00b003ee672dcaaemr26843820wmi.36.1680510111658;
        Mon, 03 Apr 2023 01:21:51 -0700 (PDT)
X-Google-Smtp-Source: AK7set/AgkVl4NRObZrwop/hyYIrLuclF7oALAw2adBku9J1XTbgT5nDnZVWZTlkdOAVCBUc2F54wA==
X-Received: by 2002:a05:600c:20d:b0:3ee:672d:caae with SMTP id 13-20020a05600c020d00b003ee672dcaaemr26843772wmi.36.1680510111270;
        Mon, 03 Apr 2023 01:21:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id c2-20020adfe702000000b002d6f285c0a2sm9135348wrm.42.2023.04.03.01.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 01:21:50 -0700 (PDT)
Message-ID: <f0232380-4171-f4d3-f1a6-07993e551b46@redhat.com>
Date:   Mon, 3 Apr 2023 10:21:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        arnd@arndb.de, bfields@fieldses.org, bp@alien8.de,
        chao.p.peng@linux.intel.com, corbet@lwn.net, dave.hansen@intel.com,
        ddutile@redhat.com, dhildenb@redhat.com, hpa@zytor.com,
        hughd@google.com, jlayton@kernel.org, jmattson@google.com,
        joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com
References: <cover.1680306489.git.ackerleytng@google.com>
 <592ebd9e33a906ba026d56dc68f42d691706f865.1680306489.git.ackerleytng@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH v3 1/2] mm: restrictedmem: Allow userspace to specify
 mount for memfd_restricted
In-Reply-To: <592ebd9e33a906ba026d56dc68f42d691706f865.1680306489.git.ackerleytng@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01.04.23 01:50, Ackerley Tng wrote:
> By default, the backing shmem file for a restrictedmem fd is created
> on shmem's kernel space mount.
> 
> With this patch, an optional tmpfs mount can be specified via an fd,
> which will be used as the mountpoint for backing the shmem file
> associated with a restrictedmem fd.
> 
> This will help restrictedmem fds inherit the properties of the
> provided tmpfs mounts, for example, hugepage allocation hints, NUMA
> binding hints, etc.
> 
> Permissions for the fd passed to memfd_restricted() is modeled after
> the openat() syscall, since both of these allow creation of a file
> upon a mount/directory.
> 
> Permission to reference the mount the fd represents is checked upon fd
> creation by other syscalls (e.g. fsmount(), open(), or open_tree(),
> etc) and any process that can present memfd_restricted() with a valid
> fd is expected to have obtained permission to use the mount
> represented by the fd. This behavior is intended to parallel that of
> the openat() syscall.
> 
> memfd_restricted() will check that the tmpfs superblock is
> writable, and that the mount is also writable, before attempting to
> create a restrictedmem file on the mount.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>   include/linux/syscalls.h           |  2 +-
>   include/uapi/linux/restrictedmem.h |  8 ++++
>   mm/restrictedmem.c                 | 74 +++++++++++++++++++++++++++---
>   3 files changed, 77 insertions(+), 7 deletions(-)
>   create mode 100644 include/uapi/linux/restrictedmem.h
> 
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index f9e9e0c820c5..a23c4c385cd3 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1056,7 +1056,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
>   asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
>   					    unsigned long home_node,
>   					    unsigned long flags);
> -asmlinkage long sys_memfd_restricted(unsigned int flags);
> +asmlinkage long sys_memfd_restricted(unsigned int flags, int mount_fd);
> 
>   /*
>    * Architecture-specific system calls
> diff --git a/include/uapi/linux/restrictedmem.h b/include/uapi/linux/restrictedmem.h
> new file mode 100644
> index 000000000000..22d6f2285f6d
> --- /dev/null
> +++ b/include/uapi/linux/restrictedmem.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_RESTRICTEDMEM_H
> +#define _UAPI_LINUX_RESTRICTEDMEM_H
> +
> +/* flags for memfd_restricted */
> +#define RMFD_USERMNT		0x0001U

I wonder if we can come up with a more expressive prefix than RMFD. 
Sounds more like "rm fd" ;) Maybe it should better match the 
"memfd_restricted" syscall name, like "MEMFD_RSTD_USERMNT".


> +
> +#endif /* _UAPI_LINUX_RESTRICTEDMEM_H */
> diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
> index c5d869d8c2d8..f7b62364a31a 100644
> --- a/mm/restrictedmem.c
> +++ b/mm/restrictedmem.c
> @@ -1,11 +1,12 @@
>   // SPDX-License-Identifier: GPL-2.0
> -#include "linux/sbitmap.h"

Looks like an unrelated change?

> +#include <linux/namei.h>
>   #include <linux/pagemap.h>
>   #include <linux/pseudo_fs.h>
>   #include <linux/shmem_fs.h>
>   #include <linux/syscalls.h>
>   #include <uapi/linux/falloc.h>
>   #include <uapi/linux/magic.h>
> +#include <uapi/linux/restrictedmem.h>
>   #include <linux/restrictedmem.h>
> 
>   struct restrictedmem {
> @@ -189,19 +190,20 @@ static struct file *restrictedmem_file_create(struct file *memfd)
>   	return file;
>   }
> 
> -SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
> +static int restrictedmem_create(struct vfsmount *mount)
>   {
>   	struct file *file, *restricted_file;
>   	int fd, err;
> 
> -	if (flags)
> -		return -EINVAL;
> -
>   	fd = get_unused_fd_flags(0);
>   	if (fd < 0)
>   		return fd;
> 
> -	file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
> +	if (mount)
> +		file = shmem_file_setup_with_mnt(mount, "memfd:restrictedmem", 0, VM_NORESERVE);
> +	else
> +		file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
> +
>   	if (IS_ERR(file)) {
>   		err = PTR_ERR(file);
>   		goto err_fd;
> @@ -223,6 +225,66 @@ SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
>   	return err;
>   }
> 
> +static bool is_shmem_mount(struct vfsmount *mnt)
> +{
> +	return mnt && mnt->mnt_sb && mnt->mnt_sb->s_magic == TMPFS_MAGIC;
> +}
> +
> +static bool is_mount_root(struct file *file)
> +{
> +	return file->f_path.dentry == file->f_path.mnt->mnt_root;
> +}

I'd inline at least that function, pretty self-explaining.

> +
> +static int restrictedmem_create_on_user_mount(int mount_fd)
> +{
> +	int ret;
> +	struct fd f;
> +	struct vfsmount *mnt;
> +
> +	f = fdget_raw(mount_fd);
> +	if (!f.file)
> +		return -EBADF;
> +
> +	ret = -EINVAL;
> +	if (!is_mount_root(f.file))
> +		goto out;
> +
> +	mnt = f.file->f_path.mnt;
> +	if (!is_shmem_mount(mnt))
> +		goto out;
> +
> +	ret = file_permission(f.file, MAY_WRITE | MAY_EXEC);
> +	if (ret)
> +		goto out;
> +
> +	ret = mnt_want_write(mnt);
> +	if (unlikely(ret))
> +		goto out;
> +
> +	ret = restrictedmem_create(mnt);
> +
> +	mnt_drop_write(mnt);
> +out:
> +	fdput(f);
> +
> +	return ret;
> +}
> +
> +SYSCALL_DEFINE2(memfd_restricted, unsigned int, flags, int, mount_fd)
> +{
> +	if (flags & ~RMFD_USERMNT)
> +		return -EINVAL;
> +
> +	if (flags == RMFD_USERMNT) {
> +		if (mount_fd < 0)
> +			return -EINVAL;
> +
> +		return restrictedmem_create_on_user_mount(mount_fd);
> +	} else {
> +		return restrictedmem_create(NULL);
> +	}


You can drop the else case:

if (flags == RMFD_USERMNT) {
	...
	return restrictedmem_create_on_user_mount(mount_fd);
}
return restrictedmem_create(NULL);


I do wonder if you want to properly check for a flag instead of 
comparing values. Results in a more natural way to deal with flags:

if (flags & RMFD_USERMNT) {

}

> +}
> +
>   int restrictedmem_bind(struct file *file, pgoff_t start, pgoff_t end,
>   		       struct restrictedmem_notifier *notifier, bool exclusive)
>   {

The "memfd_restricted" vs. "restrictedmem" terminology is a bit 
unfortunate, but not your fault here.


I'm not a FS person, but it does look good to me.

-- 
Thanks,

David / dhildenb

