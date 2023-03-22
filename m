Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A246C48F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 12:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjCVLUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 07:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCVLUH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F46853734;
        Wed, 22 Mar 2023 04:20:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEC6962022;
        Wed, 22 Mar 2023 11:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B15FC433D2;
        Wed, 22 Mar 2023 11:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679484005;
        bh=bh9WMot+PxfiYtF580dBl0Pw71rD7gR84+9GKsHMvq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tgZr20L7g2MjqdIEtuHPR4MPveRDiYnDKxr+MqbztJHvnHJSoi13pTqMj6R5Pdrme
         K2Np71e4bLyiocp7EzyEgeF5WXENJK8jRu6cQMnzsJaJNPQCDOLZ2cP/GhMfFyWeOZ
         ktbPebv86ifJeb0TYSAuMaScrRBNTxWjvbJwqpxMis0ptMhdXOcJ65FnkmWAhmTMTX
         97juHBb0Fs9YXKWZBZKfBKfX0VvO2U9FXitfqCfr5qvw/iIF9ULuejxtpPul+eZss7
         cJhAa2HZQjVMOCxbXu2z+H279nb5Ri/J29y73qC1zyxsjqtSOZkxSUW64LkyanoFXS
         OyAydZBtSLZQg==
Date:   Wed, 22 Mar 2023 12:19:51 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org, aarcange@redhat.com,
        ak@linux.intel.com, akpm@linux-foundation.org, arnd@arndb.de,
        bfields@fieldses.org, bp@alien8.de, chao.p.peng@linux.intel.com,
        corbet@lwn.net, dave.hansen@intel.com, david@redhat.com,
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
Subject: Re: [RFC PATCH v2 1/2] mm: restrictedmem: Allow userspace to specify
 mount for memfd_restricted
Message-ID: <20230322111951.vfrm2xf4o5kmtte6@wittgenstein>
References: <cover.1679428901.git.ackerleytng@google.com>
 <6e800e069c7fc400841b75ea49d1227bd101c1cf.1679428901.git.ackerleytng@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e800e069c7fc400841b75ea49d1227bd101c1cf.1679428901.git.ackerleytng@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 08:15:32PM +0000, Ackerley Tng wrote:
> By default, the backing shmem file for a restrictedmem fd is created
> on shmem's kernel space mount.
> 
> With this patch, an optional tmpfs mount can be specified via an fd,
> which will be used as the mountpoint for backing the shmem file
> associated with a restrictedmem fd.
> 
> This change is modeled after how sys_open() can create an unnamed
> temporary file in a given directory with O_TMPFILE.
> 
> This will help restrictedmem fds inherit the properties of the
> provided tmpfs mounts, for example, hugepage allocation hints, NUMA
> binding hints, etc.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  include/linux/syscalls.h           |  2 +-
>  include/uapi/linux/restrictedmem.h |  8 ++++
>  mm/restrictedmem.c                 | 63 +++++++++++++++++++++++++++---
>  3 files changed, 66 insertions(+), 7 deletions(-)
>  create mode 100644 include/uapi/linux/restrictedmem.h
> 
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index f9e9e0c820c5..a23c4c385cd3 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1056,7 +1056,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
>  asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
>  					    unsigned long home_node,
>  					    unsigned long flags);
> -asmlinkage long sys_memfd_restricted(unsigned int flags);
> +asmlinkage long sys_memfd_restricted(unsigned int flags, int mount_fd);
>  
>  /*
>   * Architecture-specific system calls
> diff --git a/include/uapi/linux/restrictedmem.h b/include/uapi/linux/restrictedmem.h
> new file mode 100644
> index 000000000000..9f108dd1ac4c
> --- /dev/null
> +++ b/include/uapi/linux/restrictedmem.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_RESTRICTEDMEM_H
> +#define _UAPI_LINUX_RESTRICTEDMEM_H
> +
> +/* flags for memfd_restricted */
> +#define RMFD_TMPFILE		0x0001U
> +
> +#endif /* _UAPI_LINUX_RESTRICTEDMEM_H */
> diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
> index c5d869d8c2d8..4d83b949d84e 100644
> --- a/mm/restrictedmem.c
> +++ b/mm/restrictedmem.c
> @@ -1,11 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "linux/sbitmap.h"
> +#include <linux/namei.h>
>  #include <linux/pagemap.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/syscalls.h>
>  #include <uapi/linux/falloc.h>
>  #include <uapi/linux/magic.h>
> +#include <uapi/linux/restrictedmem.h>
>  #include <linux/restrictedmem.h>
>  
>  struct restrictedmem {
> @@ -189,19 +190,20 @@ static struct file *restrictedmem_file_create(struct file *memfd)
>  	return file;
>  }
>  
> -SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
> +static int restrictedmem_create(struct vfsmount *mount)
>  {
>  	struct file *file, *restricted_file;
>  	int fd, err;
>  
> -	if (flags)
> -		return -EINVAL;
> -
>  	fd = get_unused_fd_flags(0);
>  	if (fd < 0)
>  		return fd;
>  
> -	file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
> +	if (mount)
> +		file = shmem_file_setup_with_mnt(mount, "memfd:restrictedmem", 0, VM_NORESERVE);
> +	else
> +		file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
> +
>  	if (IS_ERR(file)) {
>  		err = PTR_ERR(file);
>  		goto err_fd;
> @@ -223,6 +225,55 @@ SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
>  	return err;
>  }
>  
> +static bool is_shmem_mount(struct vfsmount *mnt)
> +{
> +	return mnt && mnt->mnt_sb && mnt->mnt_sb->s_magic == TMPFS_MAGIC;
> +}
> +
> +static int restrictedmem_create_from_file(int mount_fd)
> +{
> +	int ret;
> +	struct fd f;
> +	struct vfsmount *mnt;
> +
> +	f = fdget_raw(mount_fd);
> +	if (!f.file)
> +		return -EBADF;
> +
> +	mnt = f.file->f_path.mnt;
> +	if (!is_shmem_mount(mnt)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +

This looks like you can just pass in some tmpfs fd and you just use it
to identify the mnt and then you create a restricted memfd area in that
instance. So if I did:

mount -t tmpfs tmpfs /mnt
mknod /mnt/bla c 0 0
fd = open("/mnt/bla")
memfd_restricted(fd)

then it would create a memfd restricted entry in the tmpfs instance
using the arbitrary dummy device node to infer the tmpfs instance.

Looking at the older thread briefly and the cover letter. Afaict, the
new mount api shouldn't figure into the design of this. fsopen() returns
fds referencing a VFS-internal fs_context object. They can't be used to
create or lookup files or identify mounts. The mount doesn't exist at
that time. Not even a superblock might exist at the time before
fsconfig(FSCONFIG_CMD_CREATE).

When fsmount() is called after superblock setup then it's similar to any
other fd from open() or open_tree() or whatever (glossing over some
details that are irrelevant here). Difference is that open_tree() and
fsmount() would refer to the root of a mount.

At first I wondered why this doesn't just use standard *at() semantics
but I guess the restricted memfd is unlinked and doesn't show up in the
tmpfs instance.

So if you go down that route then I would suggest to enforce that the
provided fd refer to the root of a tmpfs mount. IOW, it can't just be an
arbitrary file descriptor in a tmpfs instance. That seems cleaner to me:

sb = f_path->mnt->mnt_sb;
sb->s_magic == TMPFS_MAGIC && f_path->mnt->mnt_root == sb->s_root

and has much tigher semantics than just allowing any kind of fd.

Another wrinkly I find odd but that's for you to judge is that this
bypasses the permission model of the tmpfs instance. IOW, as long as you
have a handle to the root of a tmpfs mount you can just create
restricted memfds in there. So if I provided a completely sandboxed
service - running in a user namespace or whatever - with an fd to the
host's tmpfs instance they can just create restricted memfds in there no
questions asked.

Maybe that's fine but it's certainly something to spell out and think
about the implications.
