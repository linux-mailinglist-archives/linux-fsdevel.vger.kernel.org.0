Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB862F74CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 10:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbhAOJBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 04:01:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbhAOJBq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:01:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CB7E235DD;
        Fri, 15 Jan 2021 09:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610701265;
        bh=/A9+Zdj6TeXK+0F6O2x/uxJykl7caLwG9Gsbb99EJRA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=slpAOPtS7YCDBAgE41dzMlkAmNSstSYU6QgVZardVdQRETcPFnBhz638B9MfCX9JI
         MdQA8a9ZaP0356QuNQNixM9RlXTSng99DVtQx+anK4/dziSRPwcw8N45+yhLuETEM9
         886mtj2yOSvuCZ9xdjVHxcnQL5P9rDdeFWP03g3+i3PqQX3bDDgY2/86xrjgWioN6n
         Iclf3LZ1NDz6EZ+1/OORQvNiPySLtX+xZFhAN4y3Z/KRIyNLJYCmpYExV2avR6gWHH
         jU8FsUvGN1l0NzE6s3W1dtuSTJHb0/EvTJylkIFXsvvl42gP1yJyLgCzR/dqBxgBcV
         ASNt2zWE3woQQ==
Received: by mail-wr1-f44.google.com with SMTP id 6so1143432wri.3;
        Fri, 15 Jan 2021 01:01:05 -0800 (PST)
X-Gm-Message-State: AOAM531HTNGUdL4+vR/BWQoyILMjAi8NzZ6vBC/e+L+BNspeZMSV360k
        qLrATk46YYYL+jUu4zetFO7JsZvA5Qy4HbzsV7c=
X-Google-Smtp-Source: ABdhPJzCQLMfJc8/rJJcn23B9XcoACgRVHugAZAivO5b5vHr1dE7chj1zH27zmTIY5/fobqope9ovRY+ySLR+C9B87M=
X-Received: by 2002:adf:fe05:: with SMTP id n5mr12248933wrr.9.1610701263721;
 Fri, 15 Jan 2021 01:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20210106064807.253112-1-Sonicadvance1@gmail.com>
 <CAK8P3a2tV3HzPpbCR7mAeutx38_D2d-vfpEgpXv+GW_98w3VSQ@mail.gmail.com> <CABnRqDfQ5Qfa2ybut0qXcKuYnsMcG7+9gqjL-e7nZF1bkvhPRw@mail.gmail.com>
In-Reply-To: <CABnRqDfQ5Qfa2ybut0qXcKuYnsMcG7+9gqjL-e7nZF1bkvhPRw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 15 Jan 2021 10:00:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2vfVfEWTk1ig349LGqt8bkK8YQWjE6PRyx+xvgYx7-gA@mail.gmail.com>
Message-ID: <CAK8P3a2vfVfEWTk1ig349LGqt8bkK8YQWjE6PRyx+xvgYx7-gA@mail.gmail.com>
Subject: Re: [PATCH] Adds a new ioctl32 syscall for backwards compatibility layers
To:     Ryan Houdek <sonicadvance1@gmail.com>
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

On Fri, Jan 15, 2021 at 3:06 AM Ryan Houdek <sonicadvance1@gmail.com> wrote:
> On Wed, Jan 6, 2021 at 12:49 AM Arnd Bergmann <arnd@kernel.org> wrote:
>> On Wed, Jan 6, 2021 at 7:48 AM <sonicadvance1@gmail.com> wrote:
>> > From: Ryan Houdek <Sonicadvance1@gmail.com>
>> ...
>>
>> For x86, this has another complication, as some ioctls also need to
>> check whether they are in an ia32 task (with packed u64 and 32-bit
>> __kernel_old_time_t) or an x32 task (with aligned u64 and 64-bit
>> __kernel_old_time_t). If the new syscall gets wired up on x86 as well,
>> you'd need to decide which of the two behaviors you want.
>
>
> I can have a follow-up patch that makes this do ni-syscall on x86_64 since
> we can go through the int 0x80 handler, or x32 handler path and choose
> whichever one there.

I'd say for consistency

>> > 3a) Userspace consumes all VA space above 32bit. Forcing allocations to
>> > occur in lower 32bits
>> >   - This is the current implementation
>> > 3b) Ensure any allocation in the ioctl handles ioctl entrypoint rather
>> > than just allow generic memory allocations in full VA space
>> >   - This is hard to guarantee
>>
>> What kind of allocation do you mean here? Can you give an example of
>> an ioctl that does this?
>>
> My concern here would be something like DRM allocating memory and
> returning a pointer to userspace that ends up in 64bit space.
> I can see something like `drm_get_unmapped_area` calls in to
>  `current->mm->get_unmapped_area` which I believe only ends up falling
> down TASK_SIZE checks.

I see.

> Which could potentially return pointers in the 64bit address space range
> in this case. Theoretically can be resolved either by thieving the full 64bit
> VA range, or doing something like the Tango layer patches that on
> syscall entry changes the syscall to a "compat" syscall.
> compat syscall flag like Tango might be nicer here?

Not sure how that flag is best encoded, but yes, it would have to be
somewhere that arch_get_unmapped_area() and
arch_get_mmap_end() can find. Clearly we want a solution that works
for both tango and for your work, as well as being portable to any
architecture.

>> >  }
>> > +
>> > +COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
>> > +                       compat_ulong_t, arg)
>> > +{
>> > +       return do_ioctl32(fd, cmd, arg);
>> > +}
>> > +
>> > +SYSCALL_DEFINE3(ioctl32, unsigned int, fd, unsigned int, cmd,
>> > +                       compat_ulong_t, arg)
>> > +{
>> > +       return do_ioctl32(fd, cmd, arg);
>> > +}
>>
>> These two look identical to me, I don't think you need to add a wrapper
>> here at all, but can just use the normal compat_sys_ioctl entry point
>> unless you want to add a 'flags' argument to control the struct padding.
>
>
> I tried having the dispatch table call directly in to the COMPAT one and
> the way things were lining up weren't allowing me to do this.
> Since this is a bit unique in how it operates, I'm not quite sure if there is
> another example I could pull from for this.

For the asm-generic/unistd.h, you should be able to write htis as

#if __BITS_PER_LONG == 64
__SC_COMP(__NR_ioctl32, compat_sys_ioctl, sys_ni_syscall)
#endif

Which means that the native syscall in a 64-bit process always
points to compat_sys_ioctl, while a 32-bit process always gets
-ENOSYS.

Similarly, the syscall_64.tbl file on x86 and the other 64-bit
architectures would use
442    64      ioctl32         compat_sys_ioctl

FWIW, I suppose you can rename compat_sys_ioctl to
sys_ioctl32 treewide, if that name makes more sense.

      Arnd
