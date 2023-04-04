Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF6D6D667F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjDDO7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 10:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbjDDO7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:59:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5593C34;
        Tue,  4 Apr 2023 07:58:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50FB863163;
        Tue,  4 Apr 2023 14:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F40CC433D2;
        Tue,  4 Apr 2023 14:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680620328;
        bh=Sq9+Vb89Rx0M4Rx8FyPhF0pa8OcMmukvsyftvx5GcSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jTovAp2hPoe1O4WmMbBh35bRuNhX0mdCmAAavd3SueVmaYSooKwdpMywItaC27DE/
         ekVKIzjmmYxMBABZqUV+9h42WZNEVilUc+IwrQGJ4OW+mnQEfI5w3tcgLQviGF92LB
         QMDvDA448ZeTf1Zm8F7ddV7EBzhPfNqMx0YWwRkhtE1qecRS5BF9huSs7/Nr423Rjn
         tUBtXd+YrNy51Gxp12x21NaXzCY0cSZnpVHkjf4MbWJhBY8dEQBvXYahfTBMq7ekcu
         twFQzPBGdKApzgzOdetJnKOPfm2gL3LkiFQT6RRPNL1BWOyeE/v4HvfwyhPsfNXYxU
         pmt7dX3B4SCcw==
Date:   Tue, 4 Apr 2023 16:58:34 +0200
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
Subject: Re: [RFC PATCH v3 1/2] mm: restrictedmem: Allow userspace to specify
 mount for memfd_restricted
Message-ID: <20230404-engraved-rumble-d871e0403f3b@brauner>
References: <cover.1680306489.git.ackerleytng@google.com>
 <592ebd9e33a906ba026d56dc68f42d691706f865.1680306489.git.ackerleytng@google.com>
 <20230404-amnesty-untying-01de932d4945@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230404-amnesty-untying-01de932d4945@brauner>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 04, 2023 at 03:53:13PM +0200, Christian Brauner wrote:
> On Fri, Mar 31, 2023 at 11:50:39PM +0000, Ackerley Tng wrote:
> > By default, the backing shmem file for a restrictedmem fd is created
> > on shmem's kernel space mount.
> > 
> > With this patch, an optional tmpfs mount can be specified via an fd,
> > which will be used as the mountpoint for backing the shmem file
> > associated with a restrictedmem fd.
> > 
> > This will help restrictedmem fds inherit the properties of the
> > provided tmpfs mounts, for example, hugepage allocation hints, NUMA
> > binding hints, etc.
> > 
> > Permissions for the fd passed to memfd_restricted() is modeled after
> > the openat() syscall, since both of these allow creation of a file
> > upon a mount/directory.
> > 
> > Permission to reference the mount the fd represents is checked upon fd
> > creation by other syscalls (e.g. fsmount(), open(), or open_tree(),
> > etc) and any process that can present memfd_restricted() with a valid
> > fd is expected to have obtained permission to use the mount
> > represented by the fd. This behavior is intended to parallel that of
> > the openat() syscall.
> > 
> > memfd_restricted() will check that the tmpfs superblock is
> > writable, and that the mount is also writable, before attempting to
> > create a restrictedmem file on the mount.
> > 
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > ---
> >  include/linux/syscalls.h           |  2 +-
> >  include/uapi/linux/restrictedmem.h |  8 ++++
> >  mm/restrictedmem.c                 | 74 +++++++++++++++++++++++++++---
> >  3 files changed, 77 insertions(+), 7 deletions(-)
> >  create mode 100644 include/uapi/linux/restrictedmem.h
> > 
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index f9e9e0c820c5..a23c4c385cd3 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -1056,7 +1056,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
> >  asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
> >  					    unsigned long home_node,
> >  					    unsigned long flags);
> > -asmlinkage long sys_memfd_restricted(unsigned int flags);
> > +asmlinkage long sys_memfd_restricted(unsigned int flags, int mount_fd);
> > 
> >  /*
> >   * Architecture-specific system calls
> > diff --git a/include/uapi/linux/restrictedmem.h b/include/uapi/linux/restrictedmem.h
> > new file mode 100644
> > index 000000000000..22d6f2285f6d
> > --- /dev/null
> > +++ b/include/uapi/linux/restrictedmem.h
> > @@ -0,0 +1,8 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef _UAPI_LINUX_RESTRICTEDMEM_H
> > +#define _UAPI_LINUX_RESTRICTEDMEM_H
> > +
> > +/* flags for memfd_restricted */
> > +#define RMFD_USERMNT		0x0001U
> > +
> > +#endif /* _UAPI_LINUX_RESTRICTEDMEM_H */
> > diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
> > index c5d869d8c2d8..f7b62364a31a 100644
> > --- a/mm/restrictedmem.c
> > +++ b/mm/restrictedmem.c
> > @@ -1,11 +1,12 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -#include "linux/sbitmap.h"
> > +#include <linux/namei.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/pseudo_fs.h>
> >  #include <linux/shmem_fs.h>
> >  #include <linux/syscalls.h>
> >  #include <uapi/linux/falloc.h>
> >  #include <uapi/linux/magic.h>
> > +#include <uapi/linux/restrictedmem.h>
> >  #include <linux/restrictedmem.h>
> > 
> >  struct restrictedmem {
> > @@ -189,19 +190,20 @@ static struct file *restrictedmem_file_create(struct file *memfd)
> >  	return file;
> >  }
> > 
> > -SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
> > +static int restrictedmem_create(struct vfsmount *mount)
> >  {
> >  	struct file *file, *restricted_file;
> >  	int fd, err;
> > 
> > -	if (flags)
> > -		return -EINVAL;
> > -
> >  	fd = get_unused_fd_flags(0);
> 
> Any reasons the file descriptors aren't O_CLOEXEC by default? I don't
> see any reasons why we should introduce new fdtypes that aren't
> O_CLOEXEC by default. The "don't mix-and-match" train has already left
> the station anyway as we do have seccomp noitifer fds and pidfds both of
> which are O_CLOEXEC by default.
> 
> >  	if (fd < 0)
> >  		return fd;
> > 
> > -	file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
> > +	if (mount)
> > +		file = shmem_file_setup_with_mnt(mount, "memfd:restrictedmem", 0, VM_NORESERVE);
> > +	else
> > +		file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
> > +
> >  	if (IS_ERR(file)) {
> >  		err = PTR_ERR(file);
> >  		goto err_fd;
> > @@ -223,6 +225,66 @@ SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
> >  	return err;
> >  }
> > 
> > +static bool is_shmem_mount(struct vfsmount *mnt)
> > +{
> > +	return mnt && mnt->mnt_sb && mnt->mnt_sb->s_magic == TMPFS_MAGIC;
> 
> This can just be if (mnt->mnt_sb->s_magic == TMPFS_MAGIC).
> 
> > +}
> > +
> > +static bool is_mount_root(struct file *file)
> > +{
> > +	return file->f_path.dentry == file->f_path.mnt->mnt_root;
> 
> mount -t tmpfs tmpfs /mnt
> touch /mnt/bla
> touch /mnt/ble
> mount --bind /mnt/bla /mnt/ble
> fd = open("/mnt/ble")
> fd_restricted = memfd_restricted(fd)
> 
> IOW, this doesn't restrict it to the tmpfs root. It only restricts it to
> paths that refer to the root of any tmpfs mount. To exclude bind-mounts
> that aren't bind-mounts of the whole filesystem you want:
> 
> path->dentry == path->mnt->mnt_root && 
> path->mnt->mnt_root == path->mnt->mnt_sb->s_root
> 
> > +}
> > +
> > +static int restrictedmem_create_on_user_mount(int mount_fd)
> > +{
> > +	int ret;
> > +	struct fd f;
> > +	struct vfsmount *mnt;
> > +
> > +	f = fdget_raw(mount_fd);
> > +	if (!f.file)
> > +		return -EBADF;
> > +
> > +	ret = -EINVAL;
> > +	if (!is_mount_root(f.file))
> > +		goto out;
> > +
> > +	mnt = f.file->f_path.mnt;
> > +	if (!is_shmem_mount(mnt))
> > +		goto out;
> > +
> > +	ret = file_permission(f.file, MAY_WRITE | MAY_EXEC);
> 
> With the current semantics you're asking whether you have write
> permissions on the /mnt/ble file in order to get answer to the question
> whether you're allowed to create an unlinked restricted memory file.
> That doesn't make much sense afaict.
> 
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = mnt_want_write(mnt);
> > +	if (unlikely(ret))
> > +		goto out;
> > +
> > +	ret = restrictedmem_create(mnt);
> > +
> > +	mnt_drop_write(mnt);
> > +out:
> > +	fdput(f);
> > +
> > +	return ret;
> > +}
> > +
> > +SYSCALL_DEFINE2(memfd_restricted, unsigned int, flags, int, mount_fd)
> > +{
> > +	if (flags & ~RMFD_USERMNT)
> > +		return -EINVAL;
> > +
> > +	if (flags == RMFD_USERMNT) {
> 
> Why do you even need this flag? It seems that @mount_fd being < 0 is
> sufficient to indicate that a new restricted memory fd is supposed to be
> created in the system instance.
> 
> > +		if (mount_fd < 0)
> > +			return -EINVAL;
> > +
> > +		return restrictedmem_create_on_user_mount(mount_fd);
> > +	} else {
> > +		return restrictedmem_create(NULL);
> > +	}
> > +}
> 
> I have to say that I'm very confused by all of this the more I look at it.
> 
> Effectively memfd restricted functions as a wrapper filesystem around
> the tmpfs filesystem. This is basically a weird overlay filesystem.
> You're allocating tmpfs files that you stash in restrictedmem files. 
> I have to say that this seems very hacky. I didn't get this at all at
> first.
> 
> So what does the caller get if they call statx() on a restricted memfd?
> Do they get the device number of the tmpfs mount and the inode numbers
> of the tmpfs mount? Because it looks like they would:
> 
> static int restrictedmem_getattr(struct user_namespace *mnt_userns,
> 				 const struct path *path, struct kstat *stat,
> 				 u32 request_mask, unsigned int query_flags)
> {
> 	struct inode *inode = d_inode(path->dentry);
> 	struct restrictedmem *rm = inode->i_mapping->private_data;
> 	struct file *memfd = rm->memfd;
> 
> 	return memfd->f_inode->i_op->getattr(mnt_userns, path, stat,

This is pretty broken btw, because @path refers to a restrictedmem path
which you're passing to a tmpfs iop...

I see that in

	return memfd->f_inode->i_op->getattr(mnt_userns, &memfd->f_path, stat,
					     request_mask, query_flags);

this if fixed but still, this is... not great.

> 					     request_mask, query_flags);
> 
> That @memfd would be a struct file allocated in a tmpfs instance, no? So
> you'd be calling the inode operation of the tmpfs file meaning that
> struct kstat will be filled up with the info from the tmpfs instance.
> 
> But then if I call statfs() and check the fstype I would get
> RESTRICTEDMEM_MAGIC, no? This is... unorthodox?
> 
> I'm honestly puzzled and this sounds really strange. There must be a
> better way to implement all of this.
> 
> Shouldn't you try and make this a part of tmpfs proper? Make a really
> separate filesystem and add a memfs library that both tmpfs and
> restrictedmemfs can use? Add a mount option to tmpfs that makes it a
> restricted tmpfs?
