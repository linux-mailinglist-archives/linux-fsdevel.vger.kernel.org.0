Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E5A2F7086
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 03:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbhAOCWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 21:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbhAOCWv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 21:22:51 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7B0C061757;
        Thu, 14 Jan 2021 18:22:11 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id d189so8097541oig.11;
        Thu, 14 Jan 2021 18:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6wmzLSUbWxe7uYFFgvS6JY6e1cTj43Im/jbA3ENu1Rc=;
        b=pys63q1jQeIO+K9Ufv///n2i/i+KcDT1oo6C2FKGkDnaZVyG3Ndg/Xlb6ZSe3qsPgu
         1ow58z4xua1KrT2bPeaIJ7xw5eJV+3Q9LlFqICJJrT05XuiEHuimqiNue8JrukWbr/kf
         ++zsQuDpMjahWUdaHFCK0zC10XRrdp+JoM7c/qOtBacO/SitZCVP5FtgtBCuraMRCZ7N
         J0xB2R4sAJv4D0W3aYPtEfUr7Q37jlim67TDPhrW1jbMscUIq/D1C1zAFq6K1BlnA9Yx
         +0CXTiFr0qd4bEK2XofXKCilxg94oYOS+cZfUlDxh9jC1LyHZu21fwdXpVrOjwxbXupW
         Ey3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6wmzLSUbWxe7uYFFgvS6JY6e1cTj43Im/jbA3ENu1Rc=;
        b=neOHtFuNuUDPdpDgd/L7oMq/LRRYvOLgTmmZZx0NhzRd2J9nmktcbhCX4ki61j5P3o
         zl0N8YqqEf/K1hJ3x0rne2Rt4UOm9FZsUclL1gd8vonXpkgxcyhWhftJeegkcVxyO8sS
         5qh2P503i4hDIbZQZ5VI6/4YWOtydLty0KHyJIFqwO+BhxvRxKEA99eIYaNbqkIQmu//
         40IDm96fkHKvw9JCc2vsc2CMpEA0ZuQ/dZdCLw3b5UIgsIyPVPhDOJanHuLrBhTfxYmx
         zPeJH9dFjDX6nYjbWRdz3rWZ7x+Okic7cmo1HAgWWKcr7JCmvSKCDR4LtyzzDj/WussF
         24Sw==
X-Gm-Message-State: AOAM532i1ENtTxaSr7c4zyqi+opeaKVJaVYmEjzheW3YGdIGPaGSPy3/
        9iiw9WJodpGo7rtNR2B+x/I0amTlQ1pR+o6niFs=
X-Google-Smtp-Source: ABdhPJwvVIKYYfKxra9oBS+BV3RiFPDAm5pu3/AUUL1pyCsAxWO2UWplnbDuREC25fyBoVHFWscvUGW/dc9ut9l4J4o=
X-Received: by 2002:aca:f15:: with SMTP id 21mr4706888oip.109.1610677330863;
 Thu, 14 Jan 2021 18:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20210106064807.253112-1-Sonicadvance1@gmail.com> <CAK8P3a2tV3HzPpbCR7mAeutx38_D2d-vfpEgpXv+GW_98w3VSQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2tV3HzPpbCR7mAeutx38_D2d-vfpEgpXv+GW_98w3VSQ@mail.gmail.com>
From:   Ryan Houdek <sonicadvance1@gmail.com>
Date:   Thu, 14 Jan 2021 18:21:59 -0800
Message-ID: <CABnRqDcTaqZj8u8hhwbysU-o_phZh-5-vZsiDScq6xrKbPH_Kw@mail.gmail.com>
Subject: Re: [PATCH] Adds a new ioctl32 syscall for backwards compatibility layers
To:     Arnd Bergmann <arnd@kernel.org>
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

On Wed, Jan 6, 2021 at 12:49 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Wed, Jan 6, 2021 at 7:48 AM <sonicadvance1@gmail.com> wrote:
> > From: Ryan Houdek <Sonicadvance1@gmail.com>
> ...
> > This does not solve the following problems:
> > 1) compat_alloc_user_space inside ioctl
> > 2) ioctls that check task mode instead of entry point for behaviour
> > 3) ioctls allocating memory
> > 4) struct packing problems between architectures
> >
> > Workarounds for the problems presented:
> > 1a) Do a stack pivot to the lower 32bits from userspace
> >   - Forces host 64bit process to have its thread stacks to live in 32bit
> >   space. Not ideal.
> >   - Only do a stack pivot on ioctl to save previous 32bit VA space
> > 1b) Teach kernel that compat_alloc_userspace can return a 64bit pointer
> >   - x86-64 truncates stack from this function
> >   - AArch64 returns the full stack pointer
> >   - Only ~29 users. Validating all of them support a 64bit stack is
> >   trivial?
>
> I've almost completed the removal of compat_alloc_user_space(),
> that should no longer be a concern when the syscall gets added.
>
> > 2a) Any application using these can be checked for compatibility in
> > userspace and put on a block list.
> > 2b) Fix any ioctls doing broken behaviour based on task mode rather than
> > ioctl entry point
>
> What the ioctls() actually check is 'in_compat_syscall()', which is not
> the mode of the task but the type of syscall. There is actually a general
> trend to use this helper more rather than less, and I think the only
> way forward here is to ensure that this returns true when entering
> through the new syscall number.
>
> For x86, this has another complication, as some ioctls also need to
> check whether they are in an ia32 task (with packed u64 and 32-bit
> __kernel_old_time_t) or an x32 task (with aligned u64 and 64-bit
> __kernel_old_time_t). If the new syscall gets wired up on x86 as well,
> you'd need to decide which of the two behaviors you want.

I can have a follow-up patch that makes this do ni_syscall on x86_64
since we can go through the int 0x80 handler, or x32 handler path and
choose whichever one there.

>
> > 3a) Userspace consumes all VA space above 32bit. Forcing allocations to
> > occur in lower 32bits
> >   - This is the current implementation
> > 3b) Ensure any allocation in the ioctl handles ioctl entrypoint rather
> > than just allow generic memory allocations in full VA space
> >   - This is hard to guarantee
>
> What kind of allocation do you mean here? Can you give an example of
> an ioctl that does this?

My concern here would be something like DRM allocating memory and
returning a pointer to userspace that ends up in 64bit space.
I can see something like `drm_get_unmapped_area` calls in to
`current->mm->get_unmapped_area` which I believe only ends up falling
down TASK_SIZE checks.
Which could potentially return pointers in the 64bit address space
range in this case. Theoretically can be resolved either by thieving
the full 64bit VA range, or doing something like the Tango layer
patches that on syscall entry changes the syscall to a "compat"
syscall.
compat syscall flag like Tango might be nicer here?

>
> > 4a) Blocklist any application using ioctls that have different struct
> > packing across the boundary
> >   - Can happen when struct packing of 32bit x86 application goes down
> >   the aarch64 compat_ioctl path
> >   - Userspace is a AArch64 process passing 32bit x86 ioctl structures
> >   through the compat_ioctl path which is typically for AArch32 processes
> >   - None currently identified
> > 4b) Work with upstream kernel and userspace projects to evaluate and fix
> >   - Identify the problem ioctls
> >   - Implement a new ioctl with more sane struct packing that matches
> >   cross-arch
> >   - Implement new ioctl while maintaining backwards compatibility with
> >   previous ioctl handler
> >   - Change upstream project to use the new compatibility ioctl
> >   - ioctl deprecation will be case by case per device and project
> > 4b) Userspace implements a full ioctl emulation layer
> >   - Parses the full ioctl tree
> >   - Either passes through ioctls that it doesn't understand or
> >   transforms ioctls that it knows are trouble
> >   - Has the downside that it can still run in to edge cases that will
> >   fail
> >   - Performance of additional tracking is a concern
> >   - Prone to failure keeping the kernel ioctl and userspace ioctl
> >   handling in sync
> >   - Really want to have it in the kernel space as much as possible
>
> I think there are only a few ioctls that are affected, and you can
> probably get a list from qemu, which emulates them in user space
> already. Doing that transformation should not be all that hard
> in the end.
>
> If we want to do this in the kernel, this probably requires changes
> to the syscall calling convention. Adding a flag to pick a particular
> style of ioctl arguments would work, and this could enable the
> case of emulating arm32 ioctls on x86-64 hosts.
>
> > diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> > index 86a9d7b3eabe..949788f5ba40 100644
> > --- a/arch/arm64/include/asm/unistd.h
> > +++ b/arch/arm64/include/asm/unistd.h
> > @@ -38,7 +38,7 @@
> >  #define __ARM_NR_compat_set_tls                (__ARM_NR_COMPAT_BASE + 5)
> >  #define __ARM_NR_COMPAT_END            (__ARM_NR_COMPAT_BASE + 0x800)
> >
> > -#define __NR_compat_syscalls           442
> > +#define __NR_compat_syscalls           443
> >  #endif
> >
> >  #define __ARCH_WANT_SYS_CLONE
> > diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> > index cccfbbefbf95..35e3bc83dbdc 100644
> > --- a/arch/arm64/include/asm/unistd32.h
> > +++ b/arch/arm64/include/asm/unistd32.h
> > @@ -891,6 +891,8 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
> >  __SYSCALL(__NR_process_madvise, sys_process_madvise)
> >  #define __NR_epoll_pwait2 441
> >  __SYSCALL(__NR_epoll_pwait2, compat_sys_epoll_pwait2)
> > +#define __NR_ioctl32 442
> > +__SYSCALL(__NR_ioctl32, compat_sys_ioctl)
> >
>
> I'm not sure why you want this in 32-bit processes, can't they just call
> the normal ioctl() function?
>

I'll have a follow up patch that on 32bit hosts this is a ni_syscall instead

> >  }
> > +
> > +COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
> > +                       compat_ulong_t, arg)
> > +{
> > +       return do_ioctl32(fd, cmd, arg);
> > +}
> > +
> > +SYSCALL_DEFINE3(ioctl32, unsigned int, fd, unsigned int, cmd,
> > +                       compat_ulong_t, arg)
> > +{
> > +       return do_ioctl32(fd, cmd, arg);
> > +}
>
> These two look identical to me, I don't think you need to add a wrapper
> here at all, but can just use the normal compat_sys_ioctl entry point
> unless you want to add a 'flags' argument to control the struct padding.

I tried having the dispatch table call directly in to the COMPAT one
and the way things were lining up weren't allowing me to do this.
Since this is a bit unique in how it operates, I'm not quite sure if
there is another example I could pull from for this.

>
> > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > index 728752917785..18279e5b7b4f 100644
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -862,8 +862,15 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
> >  #define __NR_epoll_pwait2 441
> >  __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
> >
> > +#define __NR_ioctl32 442
> > +#ifdef CONFIG_COMPAT
> > +__SC_COMP(__NR_ioctl32, sys_ioctl32, compat_sys_ioctl)
> > +#else
> > +__SC_COMP(__NR_ioctl32, sys_ni_syscall, sys_ni_syscall)
> > +#endif
> > +
> >  #undef __NR_syscalls
> > -#define __NR_syscalls 442
> > +#define __NR_syscalls 443
>
> (already mentioned on IRC)
>

> If you add it here, the same number should be assigned across all architectures,
> or at least a comment added to declare the number as reserved, to keep
> the following syscalls in sync.

I can have a followup patch that adds this to all the backends.
>
>         Arnd
