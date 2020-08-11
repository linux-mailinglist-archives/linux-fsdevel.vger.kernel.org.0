Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C6A241529
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 05:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgHKDGL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 23:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgHKDGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 23:06:11 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C230EC061787
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 20:06:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id v15so5835910lfg.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 20:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lAgPe7LYxrHND6axLhyzWgoGWJo7W6UM/7KYKZFAicY=;
        b=Vt/xx+6qknXNsAC24DXedJ+8lw2kZx476DKnzqwxqQHYmJ/b+vSOJ6uzjOOga0I6Pr
         9KJ8nvtVaX/cYg14ek3e5Prb2+LHlU5eogRzmyaTtuSoIydVzMVTUSVQWLYvUV6XSFCF
         gTQaoglRLjuiQYYad1i7Ky+S6jrDOMpFBu0XZspeQyMFPfMtSHSPL3J6j63TuSbtHa37
         +L4QJvsOShc6cHCqwJubi8QLmUtIbE3+iA9jtZvfyfWCtZeIA0tUsZ5FrGt8bCCgA0u2
         Oq+Id6wDp61B1gJ0CKJntpsULkprxmjKMo5RN2SmtSQFISDi+GEDmKNI6p/WnG6lwjAY
         MZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lAgPe7LYxrHND6axLhyzWgoGWJo7W6UM/7KYKZFAicY=;
        b=BQcGWXpenQdforRhUFCP744YHjlrOlCP+W/kJAxWqE2xQWBGv07V2qb0nh8k82TlLI
         XW//M73lrBNWrMNJ3bmTk5km5GAmhb/uaAhJ6laiYRVcBz/U+elMhSr4MbtODFdkiJAU
         QUYpqmmqxC6ymb0PJYYdhkFgTTQWrcMTUT6cQ8ht4mL0B331BSE3vchsjBL10p05VAxa
         OMfiNDnjH9rp5tQflJ6EEHOtqa9Kx3T5WlAdDjg/SHGJwtkFBqPSRsiCFpsZK5vYCCG9
         hFjZXueIzH5wWNyEZrH4jQElqM9QgwOM6RWWRi0CH7p5VgSMLkDGy8CTD3G6AfMYkDkE
         oYdg==
X-Gm-Message-State: AOAM531fcMx/g153aJ1MU15vnvau40JBl2L1BdxsdJl2++/UlfSfcEOt
        uLwotml4nJS8MolK52R6y2ArC1o0nQ4XniXT+XNKUg==
X-Google-Smtp-Source: ABdhPJwmgkeAByVMl8IHzTNel+UQSvrkal3Iy/3KmtsWbDWQJpZEQt6WukV/7ph1+nZ7ZkmIlZpzPGBYM79Tc1xCHnA=
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr2044815lfz.157.1597115168800;
 Mon, 10 Aug 2020 20:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200429214954.44866-1-jannh@google.com> <20200429214954.44866-2-jannh@google.com>
 <20200505104805.GA17400@lst.de> <CAG48ez3F70-UXwdHmO4CnR0bAForn-SBtstW5WAYjcrLFwS_9A@mail.gmail.com>
 <20200505121557.GA24052@lst.de>
In-Reply-To: <20200505121557.GA24052@lst.de>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 11 Aug 2020 05:05:42 +0200
Message-ID: <CAG48ez3ssZLqGC_Jy1su93wieCtvaxEtVw43skiXcKFHEMhp5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] binfmt_elf_fdpic: Stop using dump_emit() on user
 pointers on !MMU
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 5, 2020 at 2:15 PM Christoph Hellwig <hch@lst.de> wrote:
> On Tue, May 05, 2020 at 01:42:12PM +0200, Jann Horn wrote:
> > On Tue, May 5, 2020 at 12:48 PM Christoph Hellwig <hch@lst.de> wrote:
> > > On Wed, Apr 29, 2020 at 11:49:50PM +0200, Jann Horn wrote:
> > > > dump_emit() is for kernel pointers, and VMAs describe userspace memory.
> > > > Let's be tidy here and avoid accessing userspace pointers under KERNEL_DS,
> > > > even if it probably doesn't matter much on !MMU systems - especially given
> > > > that it looks like we can just use the same get_dump_page() as on MMU if
> > > > we move it out of the CONFIG_MMU block.
> > >
> > > Looks sensible.  Did you get a chance to test this with a nommu setup?
> >
> > Nope. Do you happen to have a recommendation for a convenient
> > environment I can use with QEMU, or something like that? I'm guessing
> > that just running a standard armel Debian userspace with a !mmu ARM
> > kernel wouldn't work so well?
>
> Nommu generally needs special userspace either using uclibc-ng or musl.
> When I did the RISC-V nommu work I used buildroot for my root file
> systems.  We haven't gotten elffdpic to work on RISC-V yet, so I can't
> use that setup for testing, but it should support ARM as well.

I've finally gotten around to testing this, and discovered that I
actually had to change something in the patch - thanks for asking me
to test this.



Some notes on running ARM nommu testing:

I ended up running QEMU with "-machine versatilepb". To make that
work, I applied this patch:
<https://github.com/buildroot/buildroot/blob/master/board/qemu/arm-versatile/patches/linux/versatile-nommu.patch>
A couple of directories up, there are also a README and a kernel
config for that.

Note that the emulated harddrive of this board doesn't seem to work,
because it's connected via PCI, and nommu generally can't use PCI; but
you can boot from initramfs, and you can copy files from/to the host
with netcat, since the emulated network card does work. (To avoid
having to bring up the interface from userspace, you can use
"ip=10.0.2.1::10.0.2.2:255.255.255.0" on the kernel cmdline if the
corresponding feature is enabled in the kernel config.)

The first trouble I ran into with trying to run FDPIC userspace (based
on musl) was that Linux has support for running ARM userspace in
"26-bit mode", which is some ARM feature from the dark ages, with no
support in QEMU; and while normally Linux only tries to enable that
thing when the binary explicitly requires it, the FDPIC path isn't
wired up to the appropriate personality logic properly, and so you get
a spectacular explosion, where eventually the kernel oopses with a
message about how it's trying to load an invalid value into CPSR
because first the kernel tries to return to 26-bit mode, and then,
through some mysterious spooky action at a distance, the kernel
(AFAICS) ends up trying to do a syscall return with the stack pointer
pointing somewhere in the middle of the kernel stack (and not where
the entry register frame is).

Anyway, my hacky workaround for that is:

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index b9241051e5cb..d5aa409e366c 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -70,7 +70,7 @@ static inline void
arch_thread_struct_whitelist(unsigned long *offset,
        if (current->personality & ADDR_LIMIT_32BIT)                    \
                regs->ARM_cpsr = USR_MODE;                              \
        else                                                            \
-               regs->ARM_cpsr = USR26_MODE;                            \
+               { WARN(1, "setting USR26_MODE"); regs->ARM_cpsr = USR_MODE; } \
        if (elf_hwcap & HWCAP_THUMB && pc & 1)                          \
                regs->ARM_cpsr |= PSR_T_BIT;                            \
        regs->ARM_cpsr |= PSR_ENDSTATE;                                 \


Next up: Early on in the libc startup code, musl aborts execution by
intentionally executing an undefined instruction in
__set_thread_area(), because it can't figure out any working
implementation of atomic cmpxchg. For the MMU case, there is a kuser
helper (what x86 would call vsyscall); but for NOMMU ARM, no working
implementation exists. So I gave up on musl and went with uclibc-ng
(built via buildroot) instead, since uclibc-ng has support for
compiling out thread support.


Annoyingly, buildroot doesn't support FDPIC (at least not for nommu
ARM). So I ended up telling it to build a small FLAT userspace, and
used a standard ARM toolchain to build a tiny static PIE ELF binary
with no reliance on libc (the FDPIC loader can actually load normal
ELF mostly fine as long as it's PIE, at the cost of having to
duplicate the text section for every instance) - luckily I didn't need
the ELF binary to actually do anything complicated, and so working
without any libc was tolerable:

arm-linux-gnueabi-gcc-10 -fPIC -c -o test_crash.o test_crash.c
arm-linux-gnueabi-ld -pie --no-dynamic-linker -o test_crash test_crash.o


Next fun part: gdb-multiarch doesn't seem to be able to open FDPIC
core dumps properly - none of the register status is available. I took
apart the core dump before and after the patch in a hex editor,
though, and it seems to have all the expected stuff in it. I'm
guessing that maybe GDB got thrown off by struct elf_prstatus having a
different layout if the core dump was generated on nommu? GDB's
elf32_arm_nabi_grok_prstatus() seems to only handle the struct size
for the non-FDPIC struct.
