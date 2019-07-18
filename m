Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A69176D0BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 17:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfGRPKk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 11:10:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40739 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbfGRPKk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:10:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id s145so20722123qke.7;
        Thu, 18 Jul 2019 08:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XVWuLALNboPCBpMHvtA7g3CoUrKrF0vBnrtFanWPT4=;
        b=uNMGyKFpiV5/NdDwnLap3nQ/K1Tm9DD+6GyGcMY2Qe78+LIG0HJg8gvmpe7KNtScX+
         ocmxdsLFnmQHavB02uUnWdITNtvdgZUVV6gjGYtzUgUyL101bx2COA+P5GJEB8nUL/si
         xX9VNpjurF/YIH8K4pRbOmNUfp2t9ascXvvzAmN8JqbF3LGUnbcVvWG+r/eY7BW6dDbE
         knTCE31c6j90B4zJPTKfVo0AfaPijfILaJmhBbuGf3nOxfSRW+FIerwKGcN9G9c7h1J9
         QljEyAaRfwsTvFKIQO0h8Zsw7fzxHGQhpcH2zj+Ff7MPOAMzDxkNBXC9D6swUqj3HG9E
         SpRA==
X-Gm-Message-State: APjAAAV7gMkfUYn5o8N51yJkmd6XGejNnOOrLcYFBcHIhSrSlqqUt1Gw
        lGoO9EV8UtrmkKPQlogNaMSLihSIjegnFCVtbl4=
X-Google-Smtp-Source: APXvYqz91qO2K9L71FiuX0Gt08O/27FhYjsXqzcDsg9SyRt3LsdEPpT+LHh0f5YfOz5Tbuae6UqhheF6pLTx7yCHlYU=
X-Received: by 2002:a37:ad12:: with SMTP id f18mr30435448qkm.3.1563462638194;
 Thu, 18 Jul 2019 08:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190706145737.5299-1-cyphar@cyphar.com> <20190706145737.5299-9-cyphar@cyphar.com>
In-Reply-To: <20190706145737.5299-9-cyphar@cyphar.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Jul 2019 17:10:21 +0200
Message-ID: <CAK8P3a33rGhPDFfRBAQyLTMG_WoEgX_toDgWR2O7rSwxKsZG+w@mail.gmail.com>
Subject: Re: [PATCH v9 08/10] open: openat2(2) syscall
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org,
        alpha <linux-alpha@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 6, 2019 at 5:00 PM Aleksa Sarai <cyphar@cyphar.com> wrote:

> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index 9e7704e44f6d..1703d048c141 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -461,6 +461,7 @@
>  530    common  getegid                         sys_getegid
>  531    common  geteuid                         sys_geteuid
>  532    common  getppid                         sys_getppid
> +533    common  openat2                         sys_openat2
>  # all other architectures have common numbers for new syscall, alpha
>  # is the exception.
>  534    common  pidfd_send_signal               sys_pidfd_send_signal

My plan here was to add new syscalls in the same order as everwhere else,
just with the number 110 higher. In the long run, I hope we can automate
this.

> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index aaf479a9e92d..4ad262698396 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -447,3 +447,4 @@
>  431    common  fsconfig                        sys_fsconfig
>  432    common  fsmount                         sys_fsmount
>  433    common  fspick                          sys_fspick
> +434    common  openat2                         sys_openat2

434 is already used in linux-next, I suggest you use 437 (Palmer
just submitted fchmodat4, which could become 436).

> +/**
> + * Arguments for how openat2(2) should open the target path. If @extra is zero,
> + * then openat2(2) is identical to openat(2).
> + *
> + * @flags: O_* flags (unknown flags ignored).
> + * @mode: O_CREAT file mode (ignored otherwise).
> + * @upgrade_mask: restrict how the O_PATH may be re-opened (ignored otherwise).
> + * @resolve: RESOLVE_* flags (-EINVAL on unknown flags).
> + * @reserved: reserved for future extensions, must be zeroed.
> + */
> +struct open_how {
> +       __u32 flags;
> +       union {
> +               __u16 mode;
> +               __u16 upgrade_mask;
> +       };
> +       __u16 resolve;
> +       __u64 reserved[7]; /* must be zeroed */
> +};

We can have system calls with up to six arguments on all architectures, so
this could still be done more conventionally without the indirection: like

long openat2(int dfd, const char __user * filename, int flags, mode_t
mode_mask, __u16 resolve);

In fact, that seems similar enough to the existing openat() that I think
you could also just add the fifth argument to the existing call when
a newly defined flag is set, similarly to how we only use the 'mode'
argument when O_CREAT or O_TMPFILE are set.

> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h

This file seems to lack a declaration for the system call, which means it
will cause a build failure on some architectures, e.g. arch/arc/kernel/sys.c:

#define __SYSCALL(nr, call) [nr] = (call),
void *sys_call_table[NR_syscalls] = {
        [0 ... NR_syscalls-1] = sys_ni_syscall,
#include <asm/unistd.h>
};

        Arnd
