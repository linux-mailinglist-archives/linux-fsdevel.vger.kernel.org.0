Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A52DC1285F4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2019 01:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfLUA1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 19:27:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:59536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfLUA1w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 19:27:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 669ECACD9;
        Sat, 21 Dec 2019 00:27:48 +0000 (UTC)
Date:   Sat, 21 Dec 2019 11:27:34 +1100
From:   Aleksa Sarai <asarai@suse.de>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ealvarez@mozilla.com, arnd@arndb.de,
        jannh@google.com, gpascutto@mozilla.com, jld@mozilla.com,
        oleg@redhat.com, luto@amacapital.net, viro@zeniv.linux.org.uk,
        christian.brauner@ubuntu.com
Subject: Re: [PATCH v5 2/3] pid: Introduce pidfd_getfd syscall
Message-ID: <20191221002734.7rz6lcdrshrrlnqf@yavin.dot.cyphar.com>
References: <20191220232810.GA20233@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gr477xaubyeqz5v6"
Content-Disposition: inline
In-Reply-To: <20191220232810.GA20233@ircssh-2.c.rugged-nimbus-611.internal>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--gr477xaubyeqz5v6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-20, Sargun Dhillon <sargun@sargun.me> wrote:
> This syscall allows for the retrieval of file descriptors from other
> processes, based on their pidfd. This is possible using ptrace, and
> injection of parasitic code along with using SCM_RIGHTS to move
> file descriptors between a tracee and a tracer. Unfortunately, ptrace
> comes with a high cost of requiring the process to be stopped, and
> breaks debuggers. This does not require stopping the process under
> manipulation.
>=20
> One reason to use this is to allow sandboxers to take actions on file
> descriptors on the behalf of another process. For example, this can be
> combined with seccomp-bpf's user notification to do on-demand fd
> extraction and take privileged actions. For example, it can be used
> to bind a socket to a privileged port.
>=20
> /* prototype */
>   /*
>    * pidfd_getfd_options is an extensible struct which can have options
>    * added to it. If options is NULL, size, and it will be ignored be
>    * ignored, otherwise, size should be set to sizeof(*options). If
>    * option is newer than the current kernel version, E2BIG will be
>    * returned.
>    */
>   struct pidfd_getfd_options {};
>   long pidfd_getfd(int pidfd, int fd, unsigned int flags,
> 		   struct pidfd_getfd_options *options, size_t size);
>=20
> /* testing */
> Ran self-test suite on x86_64
>=20
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  MAINTAINERS                                 |   1 +
>  arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
>  arch/arm/tools/syscall.tbl                  |   1 +
>  arch/arm64/include/asm/unistd.h             |   2 +-
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
>  include/linux/syscalls.h                    |   4 +
>  include/uapi/asm-generic/unistd.h           |   3 +-
>  include/uapi/linux/pidfd.h                  |  10 ++
>  kernel/pid.c                                | 115 ++++++++++++++++++++
>  23 files changed, 151 insertions(+), 2 deletions(-)
>  create mode 100644 include/uapi/linux/pidfd.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc0a4a8ae06a..bc370ff59dbf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13014,6 +13014,7 @@ M:	Christian Brauner <christian@brauner.io>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
> +F:	include/uapi/linux/pidfd.h
>  F:	samples/pidfd/
>  F:	tools/testing/selftests/pidfd/
>  F:	tools/testing/selftests/clone3/
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/s=
yscalls/syscall.tbl
> index 8e13b0b2928d..d1cac0d657b7 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -475,3 +475,4 @@
>  543	common	fspick				sys_fspick
>  544	common	pidfd_open			sys_pidfd_open
>  # 545 reserved for clone3
> +548	common	pidfd_getfd			sys_pidfd
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 6da7dc4d79cc..ba045e2f3a60 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -449,3 +449,4 @@
>  433	common	fspick				sys_fspick
>  434	common	pidfd_open			sys_pidfd_open
>  435	common	clone3				sys_clone3
> +438	common	pidfd_getfd			sys_pidfd_getfd
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/uni=
std.h
> index 2629a68b8724..b722e47377a5 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -38,7 +38,7 @@
>  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
>  #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
> =20
> -#define __NR_compat_syscalls		436
> +#define __NR_compat_syscalls		439
>  #endif
> =20
>  #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/u=
nistd32.h
> index 94ab29cf4f00..a8da97a2de41 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -879,6 +879,8 @@ __SYSCALL(__NR_fspick, sys_fspick)
>  __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
>  #define __NR_clone3 435
>  __SYSCALL(__NR_clone3, sys_clone3)
> +#define __NR_pidfd_getfd 438
> +__SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
> =20
>  /*
>   * Please add new compat syscalls above this comment and update
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/sys=
calls/syscall.tbl
> index 36d5faf4c86c..2b11adfc860c 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -356,3 +356,4 @@
>  433	common	fspick				sys_fspick
>  434	common	pidfd_open			sys_pidfd_open
>  # 435 reserved for clone3
> +438	common	pidfd_getfd			sys_pidfd_getfd
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/sys=
calls/syscall.tbl
> index a88a285a0e5f..44e879e98459 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -435,3 +435,4 @@
>  433	common	fspick				sys_fspick
>  434	common	pidfd_open			sys_pidfd_open
>  # 435 reserved for clone3
> +438	common	pidfd_getfd			sys_pidfd_getfd
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaz=
e/kernel/syscalls/syscall.tbl
> index 09b0cd7dab0a..7afa00125cc4 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -441,3 +441,4 @@
>  433	common	fspick				sys_fspick
>  434	common	pidfd_open			sys_pidfd_open
>  435	common	clone3				sys_clone3
> +438	common	pidfd_getfd			sys_pidfd_getfd
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel=
/syscalls/syscall_n32.tbl
> index e7c5ab38e403..856d5ba34461 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -374,3 +374,4 @@
>  433	n32	fspick				sys_fspick
>  434	n32	pidfd_open			sys_pidfd_open
>  435	n32	clone3				__sys_clone3
> +438	n32	pidfd_getfd			sys_pidfd_getfd
> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel=
/syscalls/syscall_n64.tbl
> index 13cd66581f3b..2db6075352f3 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -350,3 +350,4 @@
>  433	n64	fspick				sys_fspick
>  434	n64	pidfd_open			sys_pidfd_open
>  435	n64	clone3				__sys_clone3
> +438	n64	pidfd_getfd			sys_pidfd_getfd
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel=
/syscalls/syscall_o32.tbl
> index 353539ea4140..e9f9d4a9b105 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -423,3 +423,4 @@
>  433	o32	fspick				sys_fspick
>  434	o32	pidfd_open			sys_pidfd_open
>  435	o32	clone3				__sys_clone3
> +438	o32	pidfd_getfd			sys_pidfd_getfd
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel=
/syscalls/syscall.tbl
> index 285ff516150c..c58c7eb144ca 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -433,3 +433,4 @@
>  433	common	fspick				sys_fspick
>  434	common	pidfd_open			sys_pidfd_open
>  435	common	clone3				sys_clone3_wrapper
> +438	common	pidfd_getfd			sys_pidfd_getfd
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kern=
el/syscalls/syscall.tbl
> index 43f736ed47f2..707609bfe3ea 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -517,3 +517,4 @@
>  433	common	fspick				sys_fspick
>  434	common	pidfd_open			sys_pidfd_open
>  435	nospu	clone3				ppc_clone3
> +438	common	pidfd_getfd			sys_pidfd_getfd
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/sys=
calls/syscall.tbl
> index 3054e9c035a3..185cd624face 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -438,3 +438,4 @@
>  433  common	fspick			sys_fspick			sys_fspick
>  434  common	pidfd_open		sys_pidfd_open			sys_pidfd_open
>  435  common	clone3			sys_clone3			sys_clone3
> +438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscall=
s/syscall.tbl
> index b5ed26c4c005..88f90895aad8 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -438,3 +438,4 @@
>  433	common	fspick				sys_fspick
>  434	common	pidfd_open			sys_pidfd_open
>  # 435 reserved for clone3
> +438	common	pidfd_getfd			sys_pidfd_getfd
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/s=
yscalls/syscall.tbl
> index 8c8cc7537fb2..218df6a2326e 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -481,3 +481,4 @@
>  433	common	fspick				sys_fspick
>  434	common	pidfd_open			sys_pidfd_open
>  # 435 reserved for clone3
> +438	common	pidfd_getfd			sys_pidfd_getfd
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/sysc=
alls/syscall_32.tbl
> index 15908eb9b17e..9c3101b65e0f 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -440,3 +440,4 @@
>  433	i386	fspick			sys_fspick			__ia32_sys_fspick
>  434	i386	pidfd_open		sys_pidfd_open			__ia32_sys_pidfd_open
>  435	i386	clone3			sys_clone3			__ia32_sys_clone3
> +438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/sysc=
alls/syscall_64.tbl
> index c29976eca4a8..cef85db75a62 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -357,6 +357,7 @@
>  433	common	fspick			__x64_sys_fspick
>  434	common	pidfd_open		__x64_sys_pidfd_open
>  435	common	clone3			__x64_sys_clone3/ptregs
> +438	common	pidfd_getfd		__x64_sys_pidfd_getfd
> =20
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel=
/syscalls/syscall.tbl
> index 25f4de729a6d..ae15183def12 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -406,3 +406,4 @@
>  433	common	fspick				sys_fspick
>  434	common	pidfd_open			sys_pidfd_open
>  435	common	clone3				sys_clone3
> +438	common	pidfd_getfd			sys_pidfd_getfd
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 2960dedcfde8..62fe706329d1 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -69,6 +69,7 @@ struct rseq;
>  union bpf_attr;
>  struct io_uring_params;
>  struct clone_args;
> +struct pidfd_getfd_options;
> =20
>  #include <linux/types.h>
>  #include <linux/aio_abi.h>
> @@ -1000,6 +1001,9 @@ asmlinkage long sys_fspick(int dfd, const char __us=
er *path, unsigned int flags)
>  asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
>  				       siginfo_t __user *info,
>  				       unsigned int flags);
> +asmlinkage long sys_pidfd_getfd(int pidfd, int fd,
> +				struct pidfd_getfd_options __user *options,
> +				size_t, usize);
> =20
>  /*
>   * Architecture-specific system calls
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic=
/unistd.h
> index 1fc8faa6e973..f358488366f6 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -850,9 +850,10 @@ __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
>  #define __NR_clone3 435
>  __SYSCALL(__NR_clone3, sys_clone3)
>  #endif
> +#define __NR_pidfd_getfd 438
> =20
>  #undef __NR_syscalls
> -#define __NR_syscalls 436
> +#define __NR_syscalls 439
> =20
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> new file mode 100644
> index 000000000000..0a3fc922661d
> --- /dev/null
> +++ b/include/uapi/linux/pidfd.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_PIDFD_H
> +#define _UAPI_LINUX_PIDFD_H
> +
> +struct pidfd_getfd_options {};

Are empty structs well-defined in C (from memory, some compilers make
them non-zero in size)? Since we probably plan to add a flags field in
the future anyway, why not just have a __u64 flags which must be zeroed?

> +
> +#define PIDFD_GETFD_OPTIONS_SIZE_VER0	0
> +#define PIDFD_GETFD_OPTIONS_SIZE_LATEST	PIDFD_GETFD_OPTIONS_SIZE_VER0
> +
> +#endif /* _UAPI_LINUX_PIDFD_H */
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 2278e249141d..2a9cb4be383f 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -42,6 +42,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/sched/task.h>
>  #include <linux/idr.h>
> +#include <uapi/linux/pidfd.h>
> =20
>  struct pid init_struct_pid =3D {
>  	.count		=3D REFCOUNT_INIT(1),
> @@ -578,3 +579,117 @@ void __init pid_idr_init(void)
>  	init_pid_ns.pid_cachep =3D KMEM_CACHE(pid,
>  			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
>  }
> +
> +static struct file *__pidfd_getfd_fget_task(struct task_struct *task, u3=
2 fd)
> +{
> +	struct file *file;
> +	int ret;
> +
> +	ret =3D mutex_lock_killable(&task->signal->cred_guard_mutex);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	if (!ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS)) {
> +		file =3D ERR_PTR(-EPERM);
> +		goto out;
> +	}
> +
> +	file =3D fget_task(task, fd);
> +	if (!file)
> +		file =3D ERR_PTR(-EBADF);
> +
> +out:
> +	mutex_unlock(&task->signal->cred_guard_mutex);
> +	return file;
> +}
> +
> +static long pidfd_getfd(struct pid *pid, u32 fd)
> +{
> +	struct task_struct *task;
> +	struct file *file;
> +	int ret, retfd;
> +
> +	task =3D get_pid_task(pid, PIDTYPE_PID);
> +	if (!task)
> +		return -ESRCH;
> +
> +	file =3D __pidfd_getfd_fget_task(task, fd);
> +	put_task_struct(task);
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +
> +	retfd =3D get_unused_fd_flags(O_CLOEXEC);
> +	if (retfd < 0) {
> +		ret =3D retfd;
> +		goto out;
> +	}
> +
> +	/*
> +	 * security_file_receive must come last since it may have side effects
> +	 * and cannot be reversed.
> +	 */
> +	ret =3D security_file_receive(file);
> +	if (ret)
> +		goto out_put_fd;
> +
> +	fd_install(retfd, file);
> +	return retfd;
> +
> +out_put_fd:
> +	put_unused_fd(retfd);
> +out:
> +	fput(file);
> +	return ret;
> +}
> +
> +/**
> + * sys_pidfd_getfd() - Get a file descriptor from another process
> + *
> + * @pidfd:	file descriptor of the process
> + * @fd:		the file descriptor number to get
> + * @options:	options on how to get the fd
> + * @usize:	the size of options
> + *
> + * This syscall requires that the process has the ability to ptrace the
> + * process represented by the pidfd. It will return a duplicated version
> + * of the file descriptor on success. The process who which is having
> + * its file descriptor taken is otherwise unaffected. If options is NULL
> + * it is ignored along with usize.
> + *
> + * Return: On success, a file descriptor with cloexec is returned.
> + *         On error, a negative errno number will be returned.
> + */
> +SYSCALL_DEFINE4(pidfd_getfd, int, pidfd, int, fd,
> +		struct pidfd_getfd_options __user *, options, size_t, usize)
> +{
> +	struct pid *pid;
> +	struct fd f;
> +	int ret;
> +
> +	BUILD_BUG_ON(sizeof(struct pidfd_getfd_options) !=3D PIDFD_GETFD_OPTION=
S_SIZE_LATEST);
> +
> +	/*
> +	 * options is currently unused, verify it's unset or if it is set,
> +	 * ensure that size is 0.
> +	 *
> +	 * In the future, this will need to adopt copy_struct_from_user.
> +	 */
> +	if (options && usize > PIDFD_GETFD_OPTIONS_SIZE_VER0)
> +		return -E2BIG;

I wouldn't suggest doing this. I understand that this is simpler, but it
will cause problems once we add a field to pidfd_getfd_options -- newer
programs compiled with a larger struct won't work on older kernels with
this check (even if the struct is completely zeroed).

If copy_struct_from_user() doesn't work with usize =3D=3D 0, I would *much*
prefer a patch which fixes that (effectively copy_struct_from_user()
with a usize =3D=3D 0 should just be a call to check_zeroed_user()).

> +	f =3D fdget(pidfd);
> +	if (!f.file)
> +		return -EBADF;
> +
> +	pid =3D pidfd_pid(f.file);
> +	if (IS_ERR(pid)) {
> +		ret =3D PTR_ERR(pid);
> +		goto out;
> +	}
> +
> +	ret =3D pidfd_getfd(pid, fd);
> +
> +out:
> +	fdput(f);
> +	return ret;
> +}
> --=20
> 2.20.1

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--gr477xaubyeqz5v6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAl39ZvAACgkQnhiqJn3b
jbTPjA//ZRGs5MasCrBGtgSIyPnlbBCOB7ZplOAQz9ekgBoeo4opgloXs5kAxFu4
ynktbIn6h7+kZGswEITX6HnViNqQ80Ju4ssBM45FyGj+XoONJmOcwYfW4R7r+K2J
OBGURslzui5lf8jdhVWN8MwX3mrfFxU8mKExtXYMROkuKFRvs9I185iW3+yEz2HQ
javVuywj6XgPK0j1ss/3qrdAs83vlZVZEgM0JV6pEDt8qpdNMRvIOpsTn3UYhh4j
xZuKUZjY+uDgLdEau6HLS38kM5a2XknoXcV96LE3yPZp/mXMvwWHxUkipyE6bsIW
g1vg9RILvnXNT+zZSDm147mdTNDzv3U+yy/c7yGNYCD3lee2dF2QSdlZ4VthdREp
a30Gkg4a5ZTmIgseiSZ+Uxy4HJKJn4uDoQe7/e2dmFIkdzy2JdsSqEu1xuWdK0PE
Q43LYs+ZCXx86CCxd4d12FJh+fFw+eV6cV62gWPIzPxilkiQu8xdnkQFolMSBxFA
UONkgLxSMGEhBdbVwnsaFgv//P+H8LRbEPUi2ad9rtigh0/tx/QFgnxytGyGonZq
QTAiq9qs52yDMluoh3YJggmq5XTKWqP+ma2OYx6ALLV7sjGWj2+OXFz2PfcPZ1rQ
JyFHj8KSAcB0jdQVGHspsqGyX9ht1dH62arqznWIpTqoekj1nR0=
=dkeU
-----END PGP SIGNATURE-----

--gr477xaubyeqz5v6--
