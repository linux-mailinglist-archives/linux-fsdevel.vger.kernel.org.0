Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB732F884A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 23:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbhAOWSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 17:18:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbhAOWSI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:18:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72CA423B1C;
        Fri, 15 Jan 2021 22:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610749047;
        bh=51AgOraSDUgeKFnzRXPrgQAF8UQsqnNhAJF/wHnUnuA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W/+YhIqhwKpXMR1YHjsUDC/1vi3AWO14SB7s0CrInE/m/l9jIXs2gKoWQtGg6DRi1
         mf4Us2McffrGNfxp4IKqE9Krhk9PJ6mRw52FrXdnWRw8t7OGbutqFJFImF//XaAK3B
         k296fxiI4dCA4u0e733GVj0Fpxayev4L71aTiRKsi0yNHKw3Gn80vLuK3OmBZXWmyw
         oknAsGz6IZ87kZfT4BR2bsmLOb9d+uOeSqnk8nhAisGl7bkTC8POoU9m8/KrTzm54l
         klHJ4yfGG8GXfWeMFLvQaAf6u+lkXxtZwfx2ZfsR0uBSzeGhBbnktJm2piA7XJhISW
         g81QIgbXjkJ+w==
Received: by mail-ot1-f45.google.com with SMTP id i6so10089561otr.2;
        Fri, 15 Jan 2021 14:17:27 -0800 (PST)
X-Gm-Message-State: AOAM531wQ7MD+YQyIxDlZLa3XX50C34/yuPr2NlM290VqK70kyaIQa4/
        JQLg5v0E45RQGGRcM0NlLlG+ON39+2PaRgniB6o=
X-Google-Smtp-Source: ABdhPJzHJByccZmsXaGOr/S4V/q8avY6+thC6kueUHGkctW9f6W31ifVaDPG/I+0qa2z+2m2Zdjz/ZATG5ejh/XajAM=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr10338611ots.251.1610749045821;
 Fri, 15 Jan 2021 14:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20210106064807.253112-1-Sonicadvance1@gmail.com>
 <20210115070326.294332-1-Sonicadvance1@gmail.com> <b15672b1caec4cf980f2753d06b03596@AcuMS.aculab.com>
In-Reply-To: <b15672b1caec4cf980f2753d06b03596@AcuMS.aculab.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 15 Jan 2021 23:17:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1gqt-gBCPTdNeY+8SaG8eUGN4zkCrNKSjA=aEL-TkaUQ@mail.gmail.com>
Message-ID: <CAK8P3a1gqt-gBCPTdNeY+8SaG8eUGN4zkCrNKSjA=aEL-TkaUQ@mail.gmail.com>
Subject: Re: [PATCH] Adds a new ioctl32 syscall for backwards compatibility layers
To:     David Laight <David.Laight@aculab.com>
Cc:     "sonicadvance1@gmail.com" <sonicadvance1@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oleg Nesterov <oleg@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Brian Gerst <brgerst@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jan Kara <jack@suse.cz>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 15, 2021 at 9:01 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: sonicadvance1@gmail.com
> > Sent: 15 January 2021 07:03
> > Problem presented:
> > A backwards compatibility layer that allows running x86-64 and x86
> > processes inside of an AArch64 process.
> >   - CPU is emulated
> >   - Syscall interface is mostly passthrough
> >   - Some syscalls require patching or emulation depending on behaviour
> >   - Not viable from the emulator design to use an AArch32 host process
> >
>
> You are going to need to add all the x86 compatibility code into
> your arm64 kernel.
> This is likely to be different from the 32bit arm compatibility
> because 64bit items are only aligned on 32bit boundaries.
> The x86 x32 compatibility will be more like the 32bit arm 'compat'
> code - I'm pretty sure arm32 64bit aligned 64bit data.

All other architectures that have both 32-bit and 64-bit variants
use the same alignment for all types, except for x86.

There are additional differences though, especially if one
were to try to generalize the interface to all architectures.
A subset of the issues includes

- x32 has 64-bit types in places of some types that are
  32 bit everywhere else (time_t, ino_t, off_t, clock_t, ...)

- m68k aligns struct members to at most 16 bits

- uid_t/gid_t/ino_t/dev_t/... are

> You'll then need to remember how the process entered the kernel
> to work out which compatibility code to invoke.
> This is what x86 does.
> It allows a single process to do all three types of system call.
>
> Trying to 'patch up' structures outside the kernel, or in the
> syscall interface code will always cause grief somewhere.
> The only sane place is in the code that uses the structures.
> Which, for ioctls, means inside the driver that parses them.

He's already doing the system call emulation for all the system
calls other than ioctl in user space though. In my experience,
there are actually fairly few ioctl commands that are different
between architectures -- most of them have no misaligned
or architecture-defined struct members at all.

Once you have conversion functions to deal with the 32/64-bit
interface differences and architecture specifics of sockets,
sysvipc, signals, stat, and input_event, handling the
x86-32 specific ioctl commands is comparably easy.

         Arnd
