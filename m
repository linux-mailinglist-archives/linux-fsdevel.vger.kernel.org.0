Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1581220AA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 13:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgGOLDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 07:03:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43434 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgGOLDD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:03:03 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jvfBi-0004bY-69; Wed, 15 Jul 2020 11:02:58 +0000
Date:   Wed, 15 Jul 2020 13:02:57 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 3/4] fs: add mount_setattr()
Message-ID: <20200715110257.mncpxerdv2wuq7hu@wittgenstein>
References: <20200714161415.3886463-1-christian.brauner@ubuntu.com>
 <20200714161415.3886463-5-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200714161415.3886463-5-christian.brauner@ubuntu.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 06:14:15PM +0200, Christian Brauner wrote:
> This implements the mount_setattr() syscall. While the new mount api
> allows to change the properties of a superblock there is currently no
> way to change the mount properties of a mount or mount tree using mount
> file descriptors which the new mount api is based on. In addition the
> old mount api has the restriction that mount options cannot be
> applied recursively. This hasn't changed since changing mount options on
> a per-mount basis was implemented in [1] and has been a frequent
> request.
> The legacy mount is currently unable to accommodate this behavior
> without introducing a whole new set of flags because MS_REC | MS_REMOUNT
> | MS_BIND | MS_RDONLY | MS_NOEXEC | [...] only apply the mount option to
> the topmost mount. Changing MS_REC to apply to the whole mount tree
> would mean introducing a significant uapi change and would likely cause
> significant regressions.
> 
> The new mount_setattr() syscall allows to recursively clear and set
> mount options in one shot. Multiple calls to change mount options
> requesting the same changes are idempotent:
> 
> int mount_setattr(int dfd, const char *path, unsigned flags,
>                   struct mount_attr *uattr, size_t usize);
> 
> Flags to modify path resolution behavior are specified in the @flags
> argument. Currently, AT_EMPTY_PATH, AT_RECURSIVE, AT_SYMLINK_NOFOLLOW,
> and AT_NO_AUTOMOUNT are supported. If useful, additional lookup flags to
> restrict path resolution as introduced with openat2() might be supported
> in the future.
> 
> mount_setattr() can be expected to grow over time and is designed with
> extensibility in mind. It follows the extensible syscall pattern we have
> used with other syscalls such as openat2(), clone3(),
> sched_{set,get}attr(), and others.
> The set of mount options is passed in the uapi struct mount_attr which
> currently has the following layout:
> 
> struct mount_attr {
> 	__u64 attr_set;
> 	__u64 attr_clr;
> 	__u32 propagation;
> 	__u32 atime;
> 
> };
> 
> The @attr_set and @attr_clr members are used to clear and set mount
> options. This way a user can e.g. request that a set of flags is to be
> raised such as turning mounts readonly by raising MOUNT_ATTR_RDONLY in
> @attr_set while at the same time requesting that another set of flags is
> to be lowered such as removing noexec from a mount tree by specifying
> MOUNT_ATTR_NOEXEC in @attr_clr.
> 
> The @propagation field lets callers specify the propagation type of a
> mount tree. Propagation is a single property that has four different
> settings and as such is not really a flag argument but an enum.
> Specifically, it would be unclear what setting and clearing propagation
> settings in combination would amount to. The legacy mount() syscall thus
> forbids the combination of multiple propagation settings too. The goal
> is to keep the semantics of mount propagation somewhat simple as they
> are overly complex as it is.
> 
> Finally, struct mount_attr contains an @atime field which can be used to
> set the atime behavior of a mount tree. Currently, access times are
> already treated and defined like an enum in the new mount api so there's
> no reason to treat them equivalent to a flag argument. A new atime enum
> is introduced. The reason for not reusing the atime flags useable with
> fsmount() and defined in the new mount api is that the
> MOUNT_ATTR_RELATIME enum is defined as 0. This means, a user wanting to
> transition to relative atime cannot simply specify MOUNT_ATTR_RELATIME
> in @atime or @attr_set as this would mean not specifying any atime
> settings is equivalent to specifying relative atime. This would cause
> confusion for userspace as not specifying atime settings would switch
> them to relatime. The new set of enums rectifies this by starting the
> definition at 1 and letting 0 mean that atime settings are supposed to
> be left unchanged.
> 
> Changing mount option has quite a few moving parts and the locking is
> quite intricate so it is not unlikely that I got subtleties wrong.
> 
> [1]: commit 2e4b7fcd9260 ("[PATCH] r/o bind mounts: honor mount writer counts at remount")
> Cc: David Howells <dhowells@redhat.com>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-api@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
>  arch/arm/tools/syscall.tbl                  |   1 +
>  arch/arm64/include/asm/unistd32.h           |   2 +
>  arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
>  arch/s390/kernel/syscalls/syscall.tbl       |   1 +
>  arch/sh/kernel/syscalls/syscall.tbl         |   1 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
>  arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
>  fs/internal.h                               |   7 +
>  fs/namespace.c                              | 275 ++++++++++++++++++--
>  include/linux/syscalls.h                    |   3 +
>  include/uapi/asm-generic/unistd.h           |   4 +-
>  include/uapi/linux/mount.h                  |  31 +++
>  22 files changed, 321 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index 5ddd128d4b7a..6c5c0b7a1c9e 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -478,3 +478,4 @@
>  547	common	openat2				sys_openat2
>  548	common	pidfd_getfd			sys_pidfd_getfd
>  549	common	faccessat2			sys_faccessat2
> +550	common	mount_setattr			sys_mount_setattr
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index d5cae5ffede0..10014c157e3f 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -452,3 +452,4 @@
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	faccessat2			sys_faccessat2
> +440	common	mount_setattr			sys_mount_setattr
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index 6d95d0c8bf2f..7de6051fa380 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -885,6 +885,8 @@ __SYSCALL(__NR_openat2, sys_openat2)
>  __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
>  #define __NR_faccessat2 439
>  __SYSCALL(__NR_faccessat2, sys_faccessat2)
> +#define __NR_mount_setattr 440
> +__SYSCALL(__NR_mount_setattr, sys_mount_setattr)
>  
>  /*
>   * Please add new compat syscalls above this comment and update
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> index 49e325b604b3..dd81c63f3970 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -359,3 +359,4 @@
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	faccessat2			sys_faccessat2
> +440	common	mount_setattr			sys_mount_setattr
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index f71b1bbcc198..cb78cb4da7dd 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -438,3 +438,4 @@
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	faccessat2			sys_faccessat2
> +440	common	mount_setattr			sys_mount_setattr
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index edacc4561f2b..71a5b24e2b67 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -444,3 +444,4 @@
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	faccessat2			sys_faccessat2
> +440	common	mount_setattr			sys_mount_setattr
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> index f777141f5256..9dcafeef6c07 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -377,3 +377,4 @@
>  437	n32	openat2				sys_openat2
>  438	n32	pidfd_getfd			sys_pidfd_getfd
>  439	n32	faccessat2			sys_faccessat2
> +440	n32	mount_setattr			sys_mount_setattr
> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> index da8c76394e17..5e51a29cc21f 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -353,3 +353,4 @@
>  437	n64	openat2				sys_openat2
>  438	n64	pidfd_getfd			sys_pidfd_getfd
>  439	n64	faccessat2			sys_faccessat2
> +440	n64	mount_setattr			sys_mount_setattr
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index 13280625d312..5b5fa22cca16 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -426,3 +426,4 @@
>  437	o32	openat2				sys_openat2
>  438	o32	pidfd_getfd			sys_pidfd_getfd
>  439	o32	faccessat2			sys_faccessat2
> +440	o32	mount_setattr			sys_mount_setattr
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index 5a758fa6ec52..e7fca7c8c407 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -436,3 +436,4 @@
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	faccessat2			sys_faccessat2
> +440	common	mount_setattr			sys_mount_setattr
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index f833a3190822..cfb50e8c5d45 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -528,3 +528,4 @@
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	faccessat2			sys_faccessat2
> +440	common	mount_setattr			sys_mount_setattr
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index bfdcb7633957..12081f161b30 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -441,3 +441,4 @@
>  437  common	openat2			sys_openat2			sys_openat2
>  438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
>  439  common	faccessat2		sys_faccessat2			sys_faccessat2
> +440  common	mount_setattr		sys_mount_setattr		sys_mount_setattr
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index acc35daa1b79..d4ffc9846ceb 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -441,3 +441,4 @@
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	faccessat2			sys_faccessat2
> +440	common	mount_setattr			sys_mount_setattr
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index 8004a276cb74..024f010ee63e 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -484,3 +484,4 @@
>  437	common	openat2			sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	faccessat2			sys_faccessat2
> +440	common	mount_setattr			sys_mount_setattr
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index d8f8a1a69ed1..a89034dd8bc3 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -443,3 +443,4 @@
>  437	i386	openat2			sys_openat2
>  438	i386	pidfd_getfd		sys_pidfd_getfd
>  439	i386	faccessat2		sys_faccessat2
> +440	i386	mount_setattr		sys_mount_setattr
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 78847b32e137..c23771eeb8df 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -360,6 +360,7 @@
>  437	common	openat2			sys_openat2
>  438	common	pidfd_getfd		sys_pidfd_getfd
>  439	common	faccessat2		sys_faccessat2
> +440	common	mount_setattr		sys_mount_setattr
>  
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index 69d0d73876b3..df0dfb1611f4 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -409,3 +409,4 @@
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
>  439	common	faccessat2			sys_faccessat2
> +440	common	mount_setattr			sys_mount_setattr
> diff --git a/fs/internal.h b/fs/internal.h
> index 9b863a7bd708..62f7526d7536 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -75,6 +75,13 @@ int do_linkat(int olddfd, const char __user *oldname, int newdfd,
>  /*
>   * namespace.c
>   */
> +struct mount_kattr {
> +	unsigned int attr_set;
> +	unsigned int attr_clr;
> +	unsigned int propagation;
> +	unsigned int lookup_flags;
> +	bool recurse;
> +};
>  extern void *copy_mount_options(const void __user *);
>  extern char *copy_mount_string(const void __user *);
>  
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ab025dd3be04..13e29fcc82ab 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -459,10 +459,8 @@ void mnt_drop_write_file(struct file *file)
>  }
>  EXPORT_SYMBOL(mnt_drop_write_file);
>  
> -static int mnt_make_readonly(struct mount *mnt)
> +static inline int mnt_hold_writers(struct mount *mnt)
>  {
> -	int ret = 0;
> -
>  	mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
>  	/*
>  	 * After storing MNT_WRITE_HOLD, we'll read the counters. This store
> @@ -487,15 +485,30 @@ static int mnt_make_readonly(struct mount *mnt)
>  	 * we're counting up here.
>  	 */
>  	if (mnt_get_writers(mnt) > 0)
> -		ret = -EBUSY;
> -	else
> -		mnt->mnt.mnt_flags |= MNT_READONLY;
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
> +static inline void mnt_unhold_writers(struct mount *mnt)
> +{
>  	/*
>  	 * MNT_READONLY must become visible before ~MNT_WRITE_HOLD, so writers
>  	 * that become unheld will see MNT_READONLY.
>  	 */
>  	smp_wmb();
>  	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
> +}
> +
> +static int mnt_make_readonly(struct mount *mnt)
> +{
> +	int ret;
> +
> +	ret = mnt_hold_writers(mnt);
> +	if (ret)
> +		return ret;
> +	mnt->mnt.mnt_flags |= MNT_READONLY;
> +	mnt_unhold_writers(mnt);
>  	return ret;
>  }

Sorry, this has apparently been left from an old version. The helper for
the new mount api needs to clear MNT_WRITE_HOLD unconditionally of
course. I'll send an updated version:

+static int mnt_make_readonly(struct mount *mnt)
+{
+	int ret;
+
+	ret = mnt_hold_writers(mnt);
+	if (!ret)
+		mnt->mnt.mnt_flags |= MNT_READONLY;
+	mnt_unhold_writers(mnt);
 	return ret;
 }

Christian
