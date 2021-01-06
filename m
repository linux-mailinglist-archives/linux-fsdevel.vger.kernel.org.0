Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D752EC675
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 00:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbhAFW7c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 17:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbhAFW73 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 17:59:29 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19298C061575;
        Wed,  6 Jan 2021 14:58:49 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id h16so5911185edt.7;
        Wed, 06 Jan 2021 14:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/h7ESGLb4D7WfSXd+8OiPoJik1yGFtSHZPadWzBn8U=;
        b=b/oT6v2Ox6aZiiZ6ka3EQp73pVMnDeXlipXatem5/JFw8071LrknjNnP1ATmYyl1Dn
         M1H4cvjhv/9POysZqlK1yQO79rZhoO/4G8fbEGCovEg97EovtwdxfuJRnhYPH2Tky1At
         8xWrj3LaVV8rgWx2ci2oQHVXme1ILjM28SwVwqa8bn31v/ODDdo/1O0ZT2yj86//yPp4
         rZwHf1nEtKPm4v3w1NT0GEs2bzKkuSee1nMzUf3rF66cv5wfEu2vWrxm3hKBQCPseCrR
         S0Wfct5a2dYP5P60x7stksjNp1YD5FwPy4glMne8OVD6zjG2oRzpbJ/WOAoGNn2rrcSh
         vLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/h7ESGLb4D7WfSXd+8OiPoJik1yGFtSHZPadWzBn8U=;
        b=b5+EqWKg+VkJv1VDsE8RXXBNBrA5W5JvZG5QQ2+UKjsa605ioXGpdRQJZb1jLuwZRR
         DaoXqDPEWf33yC1dFk+NEo9HbVoIIny3HRIsbOgtEL8GjMJbSdToSMdF+DZRDoLY7pvB
         DT3cnYHHu6aJvpeBQGZ2p+FgfL2iwWix+069YqxyCcEOjyAQTDJtHwMc5/jH/U8uAqIV
         Gfgi+qzlkweHnBCjsqloLvxCcXj+vkV3bxHrV1NbCGZ0BzOPRzWCjPn8geByT9Kt6YbU
         bLo2K8Dm33frB/fx6UA/b3sL5j+XVx2+xFK5efgT2sK2jabyhlDZ45DzGBLg280KX/KN
         PPnA==
X-Gm-Message-State: AOAM5300Z97AVs1aA1vNyexnN2i4ShRfKhmKBZsbXgMnFgWzKFeqVQyk
        9MAmHiXq6GOPJRcVflEXH9Ghlg9/5Zxfnt0Ffho=
X-Google-Smtp-Source: ABdhPJyLuJykJ6bCPC+1DbTnj5XBrlsofJjH1CcycAYK037p+8DmvShCPDmdMsKetnN0iZIr+OpqA5nqebXXhRdJWco=
X-Received: by 2002:a50:d80c:: with SMTP id o12mr5259810edj.338.1609973927678;
 Wed, 06 Jan 2021 14:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20210106064807.253112-1-Sonicadvance1@gmail.com>
In-Reply-To: <20210106064807.253112-1-Sonicadvance1@gmail.com>
From:   "Amanieu d'Antras" <amanieu@gmail.com>
Date:   Wed, 6 Jan 2021 22:57:08 +0000
Message-ID: <CA+y5pbSO8P+kA8wziNTHArjYgbPek5uKXeyALyRoeP2+74qZ+A@mail.gmail.com>
Subject: Re: [PATCH] Adds a new ioctl32 syscall for backwards compatibility layers
To:     sonicadvance1@gmail.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Willem de Bruijn <willemb@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joe Perches <joe@perches.com>, Jan Kara <jack@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I encountered a similar problem when writing the Tango binary
translator (https://www.amanieusystems.com/). Tango allows AArch32
programs to run on AArch64 CPUs that don't support AArch32 (e.g.
ThunderX). The technology has been licensed to several customers who
are primarily using it to run Android instances on cloud servers.

Doing compat system call translation entirely in user doesn't work out
for several reasons:
- As Ryan stated, it is impractical and error-prone to manually
translate all ioctls in user space. It would be much better to reuse
the existing compat layer in the kernel. This is even worse if you
take out-of-tree drivers (which have their own ioctls) into account.
- There are quite a few system calls which create VM mappings: the
usual suspects (mmap, etc) but also io_setup and some ioctls (e.g. in
the out-of-tree Mali GPU drivers).
- Seccomp filters simply don't work. They could be emulated in user
space but this is insecure since the translator is not designed to be
a secure sandbox. They also don't propagate across execve.
- Some syscalls rely on information that is only known to the kernel.
For example, a hugetlbfs fd can only be mapped at a huge page
boundary, but the translator cannot know this when selecting a virtual
address in the low 4GB for the mapping.

The solution that we ended up with was to allow AArch64 processes to
issue AArch32 syscalls by using a special system call number. This has
several effects for the duration of the syscall:
- The compat syscall table is used instead of the primary one.
- is_compat_task/in_compat_syscall return true.
- get_unmapped_area returns addresses below 4G and uses a separate
mmap_base. The separate mmap_base is needed to allow 32-bit
applications to benefit from address space randomization. Tango still
uses normal mmap syscalls for private memory allocations that are not
visible to the translated 32-bit process.
- KSTK_EIP and KSTK_ESP return the values of x13/x15 instead of pc/sp.
This is necessary for correct functioning seccomp filters and SELinux
checks respectively. Tango will set x13 and x15 to the correct values
when issuing a 32-bit syscall.
- System call restart after a signal sets things up so that
restart_syscall is executed as a 32-bit syscall after the signal.

I feel that a solution along these lines would also solve Ryan's
problem since the vast majority of the syscall translation work is
from the difference between 32-bit and 64-bit data structures in
memory. The remaining few differences in the syscall ABI between
AArch32 and x86-32 can be handled in user mode by the translator
program.

The kernel patch (based on the v5.4 LTS kernel) can be found at
https://github.com/Amanieu/linux/tree/tango-v5.4.





On Wed, Jan 6, 2021 at 6:49 AM <sonicadvance1@gmail.com> wrote:
>
> From: Ryan Houdek <Sonicadvance1@gmail.com>
>
> Problem presented:
> A backwards compatibility layer that allows running x86-64 and x86
> processes inside of an AArch64 process.
>   - CPU is emulated
>   - Syscall interface is mostly passthrough
>   - Some syscalls require patching or emulation depending on behaviour
>   - Not viable from the emulator design to use an AArch32 host process
>
> x86-64 and x86 userspace emulator source:
> https://github.com/FEX-Emu/FEX
> Usage of ioctl32 is currently in a downstream fork. This will be the
> first user of the syscall.
>
> Cross documentation:
> https://github.com/FEX-Emu/FEX/wiki/32Bit-x86-Woes#ioctl---54
>
> ioctls are opaque from the emulator perspective and the data wants to be
> passed through a syscall as unimpeded as possible.
> Sadly due to ioctl struct differences between x86 and x86-64, we need a
> syscall that exposes the compatibility ioctl handler to userspace in a
> 64bit process.
>
> This is necessary behaves of the behaviour differences that occur
> between an x86 process doing an ioctl and an x86-64 process doing an
> ioctl.
>
> Both of which are captured and passed through the AArch64 ioctl space.
> This is implementing a new ioctl32 syscall that allows us to pass 32bit
> x86 ioctls through to the kernel with zero or minimal manipulation.
>
> The only supported hosts where we care about this currently is AArch64
> and x86-64 (For testing purposes).
> PPC64LE, MIPS64LE, and RISC-V64 might be interesting to support in the
> future; But I don't have any platforms that get anywhere near Cortex-A77
> performance in those architectures. Nor do I have the time to bring up
> the emulator on them.
> x86-64 can get to the compatibility ioctl through the int $0x80 handler.
>
> This does not solve the following problems:
> 1) compat_alloc_user_space inside ioctl
> 2) ioctls that check task mode instead of entry point for behaviour
> 3) ioctls allocating memory
> 4) struct packing problems between architectures
>
> Workarounds for the problems presented:
> 1a) Do a stack pivot to the lower 32bits from userspace
>   - Forces host 64bit process to have its thread stacks to live in 32bit
>   space. Not ideal.
>   - Only do a stack pivot on ioctl to save previous 32bit VA space
> 1b) Teach kernel that compat_alloc_userspace can return a 64bit pointer
>   - x86-64 truncates stack from this function
>   - AArch64 returns the full stack pointer
>   - Only ~29 users. Validating all of them support a 64bit stack is
>   trivial?
>
> 2a) Any application using these can be checked for compatibility in
> userspace and put on a block list.
> 2b) Fix any ioctls doing broken behaviour based on task mode rather than
> ioctl entry point
>
> 3a) Userspace consumes all VA space above 32bit. Forcing allocations to
> occur in lower 32bits
>   - This is the current implementation
> 3b) Ensure any allocation in the ioctl handles ioctl entrypoint rather
> than just allow generic memory allocations in full VA space
>   - This is hard to guarantee
>
> 4a) Blocklist any application using ioctls that have different struct
> packing across the boundary
>   - Can happen when struct packing of 32bit x86 application goes down
>   the aarch64 compat_ioctl path
>   - Userspace is a AArch64 process passing 32bit x86 ioctl structures
>   through the compat_ioctl path which is typically for AArch32 processes
>   - None currently identified
> 4b) Work with upstream kernel and userspace projects to evaluate and fix
>   - Identify the problem ioctls
>   - Implement a new ioctl with more sane struct packing that matches
>   cross-arch
>   - Implement new ioctl while maintaining backwards compatibility with
>   previous ioctl handler
>   - Change upstream project to use the new compatibility ioctl
>   - ioctl deprecation will be case by case per device and project
> 4b) Userspace implements a full ioctl emulation layer
>   - Parses the full ioctl tree
>   - Either passes through ioctls that it doesn't understand or
>   transforms ioctls that it knows are trouble
>   - Has the downside that it can still run in to edge cases that will
>   fail
>   - Performance of additional tracking is a concern
>   - Prone to failure keeping the kernel ioctl and userspace ioctl
>   handling in sync
>   - Really want to have it in the kernel space as much as possible
>
> Signed-off-by: Ryan Houdek <Sonicadvance1@gmail.com>
> ---
>  arch/arm64/include/asm/unistd.h         |  2 +-
>  arch/arm64/include/asm/unistd32.h       |  2 ++
>  fs/ioctl.c                              | 16 ++++++++++++++--
>  include/linux/syscalls.h                |  2 ++
>  include/uapi/asm-generic/unistd.h       |  9 ++++++++-
>  kernel/sys_ni.c                         |  3 +++
>  tools/include/uapi/asm-generic/unistd.h |  9 ++++++++-
>  7 files changed, 38 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index 86a9d7b3eabe..949788f5ba40 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -38,7 +38,7 @@
>  #define __ARM_NR_compat_set_tls                (__ARM_NR_COMPAT_BASE + 5)
>  #define __ARM_NR_COMPAT_END            (__ARM_NR_COMPAT_BASE + 0x800)
>
> -#define __NR_compat_syscalls           442
> +#define __NR_compat_syscalls           443
>  #endif
>
>  #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index cccfbbefbf95..35e3bc83dbdc 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -891,6 +891,8 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
>  __SYSCALL(__NR_process_madvise, sys_process_madvise)
>  #define __NR_epoll_pwait2 441
>  __SYSCALL(__NR_epoll_pwait2, compat_sys_epoll_pwait2)
> +#define __NR_ioctl32 442
> +__SYSCALL(__NR_ioctl32, compat_sys_ioctl)
>
>  /*
>   * Please add new compat syscalls above this comment and update
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 4e6cc0a7d69c..116b9bca8c07 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -790,8 +790,8 @@ long compat_ptr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  }
>  EXPORT_SYMBOL(compat_ptr_ioctl);
>
> -COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
> -                      compat_ulong_t, arg)
> +long do_ioctl32(unsigned int fd, unsigned int cmd,
> +                       compat_ulong_t arg)
>  {
>         struct fd f = fdget(fd);
>         int error;
> @@ -850,4 +850,16 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
>
>         return error;
>  }
> +
> +COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
> +                       compat_ulong_t, arg)
> +{
> +       return do_ioctl32(fd, cmd, arg);
> +}
> +
> +SYSCALL_DEFINE3(ioctl32, unsigned int, fd, unsigned int, cmd,
> +                       compat_ulong_t, arg)
> +{
> +       return do_ioctl32(fd, cmd, arg);
> +}
>  #endif
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index f3929aff39cf..470f928831eb 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -386,6 +386,8 @@ asmlinkage long sys_inotify_rm_watch(int fd, __s32 wd);
>  /* fs/ioctl.c */
>  asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd,
>                                 unsigned long arg);
> +asmlinkage long sys_ioctl32(unsigned int fd, unsigned int cmd,
> +                               compat_ulong_t arg);
>
>  /* fs/ioprio.c */
>  asmlinkage long sys_ioprio_set(int which, int who, int ioprio);
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 728752917785..18279e5b7b4f 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -862,8 +862,15 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
>  #define __NR_epoll_pwait2 441
>  __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
>
> +#define __NR_ioctl32 442
> +#ifdef CONFIG_COMPAT
> +__SC_COMP(__NR_ioctl32, sys_ioctl32, compat_sys_ioctl)
> +#else
> +__SC_COMP(__NR_ioctl32, sys_ni_syscall, sys_ni_syscall)
> +#endif
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 442
> +#define __NR_syscalls 443
>
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 19aa806890d5..5a2f25eb341c 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -302,6 +302,9 @@ COND_SYSCALL(recvmmsg_time32);
>  COND_SYSCALL_COMPAT(recvmmsg_time32);
>  COND_SYSCALL_COMPAT(recvmmsg_time64);
>
> +COND_SYSCALL(ioctl32);
> +COND_SYSCALL_COMPAT(ioctl32);
> +
>  /*
>   * Architecture specific syscalls: see further below
>   */
> diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
> index 728752917785..18279e5b7b4f 100644
> --- a/tools/include/uapi/asm-generic/unistd.h
> +++ b/tools/include/uapi/asm-generic/unistd.h
> @@ -862,8 +862,15 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
>  #define __NR_epoll_pwait2 441
>  __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
>
> +#define __NR_ioctl32 442
> +#ifdef CONFIG_COMPAT
> +__SC_COMP(__NR_ioctl32, sys_ioctl32, compat_sys_ioctl)
> +#else
> +__SC_COMP(__NR_ioctl32, sys_ni_syscall, sys_ni_syscall)
> +#endif
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 442
> +#define __NR_syscalls 443
>
>  /*
>   * 32 bit systems traditionally used different
> --
> 2.27.0
>
