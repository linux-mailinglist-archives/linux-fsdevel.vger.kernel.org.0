Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B8B2EBB48
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 09:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbhAFItp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 03:49:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbhAFItp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:49:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC51123118;
        Wed,  6 Jan 2021 08:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609922943;
        bh=gT3/+tWZtzKe1j6x5VFIce7vv/uhbvZNpLPaNlsXcKM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=np2gSS/mPFxgqMcu+9+al7Nh78bO3/FEXITDBqeJ69Vt6G7smIWAuO5u1QB36GjXX
         6ZbAYTL86VdhGSNMDHxo6QWlqSCCgfr34eBwbKDY82OZTK0PfrW5OTdxYqlflR9TBm
         D6ubYtlKGL+/OiK7hkAUTYRc9TSGHQtL2qYGiwZaS9NMV4xaSrWb/eaASTOu+HJ3FJ
         ch3rM6h55SWBP4Ik01eeps6tBAFaESZ5C60MALPLRcQT5I/hAlah7550Co5SpdFHH9
         w7fyAwQOtsWqeo104orTBUT2OHnVrQSwfJZ1AzCpc1M+l4my4vXHGz1lT9QcNrrhT5
         eO2B/p27lufjA==
Received: by mail-ot1-f44.google.com with SMTP id 11so2328891oty.9;
        Wed, 06 Jan 2021 00:49:03 -0800 (PST)
X-Gm-Message-State: AOAM533I6qie+FBV9wsT75+OoHlglYYjZPJlbufFq6r3Tia/QlawaDWG
        CFK8sOjWBoUXu+Of6ZryiGwf3snIdup7dlRMJCg=
X-Google-Smtp-Source: ABdhPJy3gx1O+/hZNiiIEIl7JAsbZS46QiIzX4CWfduzbKOPXb9L+t7kxJpvAnO5PDTD34g7IHQ7qtIXvsXh5hW4M7w=
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr2443064otm.305.1609922942761;
 Wed, 06 Jan 2021 00:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20210106064807.253112-1-Sonicadvance1@gmail.com>
In-Reply-To: <20210106064807.253112-1-Sonicadvance1@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 6 Jan 2021 09:48:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2tV3HzPpbCR7mAeutx38_D2d-vfpEgpXv+GW_98w3VSQ@mail.gmail.com>
Message-ID: <CAK8P3a2tV3HzPpbCR7mAeutx38_D2d-vfpEgpXv+GW_98w3VSQ@mail.gmail.com>
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
        "Amanieu d'Antras" <amanieu@gmail.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 6, 2021 at 7:48 AM <sonicadvance1@gmail.com> wrote:
> From: Ryan Houdek <Sonicadvance1@gmail.com>
...
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

I've almost completed the removal of compat_alloc_user_space(),
that should no longer be a concern when the syscall gets added.

> 2a) Any application using these can be checked for compatibility in
> userspace and put on a block list.
> 2b) Fix any ioctls doing broken behaviour based on task mode rather than
> ioctl entry point

What the ioctls() actually check is 'in_compat_syscall()', which is not
the mode of the task but the type of syscall. There is actually a general
trend to use this helper more rather than less, and I think the only
way forward here is to ensure that this returns true when entering
through the new syscall number.

For x86, this has another complication, as some ioctls also need to
check whether they are in an ia32 task (with packed u64 and 32-bit
__kernel_old_time_t) or an x32 task (with aligned u64 and 64-bit
__kernel_old_time_t). If the new syscall gets wired up on x86 as well,
you'd need to decide which of the two behaviors you want.

> 3a) Userspace consumes all VA space above 32bit. Forcing allocations to
> occur in lower 32bits
>   - This is the current implementation
> 3b) Ensure any allocation in the ioctl handles ioctl entrypoint rather
> than just allow generic memory allocations in full VA space
>   - This is hard to guarantee

What kind of allocation do you mean here? Can you give an example of
an ioctl that does this?

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

I think there are only a few ioctls that are affected, and you can
probably get a list from qemu, which emulates them in user space
already. Doing that transformation should not be all that hard
in the end.

If we want to do this in the kernel, this probably requires changes
to the syscall calling convention. Adding a flag to pick a particular
style of ioctl arguments would work, and this could enable the
case of emulating arm32 ioctls on x86-64 hosts.

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

I'm not sure why you want this in 32-bit processes, can't they just call
the normal ioctl() function?

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

These two look identical to me, I don't think you need to add a wrapper
here at all, but can just use the normal compat_sys_ioctl entry point
unless you want to add a 'flags' argument to control the struct padding.

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

(already mentioned on IRC)

If you add it here, the same number should be assigned across all architectures,
or at least a comment added to declare the number as reserved, to keep
the following syscalls in sync.

        Arnd
