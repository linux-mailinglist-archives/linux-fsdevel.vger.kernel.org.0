Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39AD340FB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 22:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhCRVQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 17:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233258AbhCRVQB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 17:16:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9090564E02;
        Thu, 18 Mar 2021 21:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616102160;
        bh=3xDkvaW8GlfwEpu6Ok3K5BbG+SXWmgmEnOMjmlPKbfw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qdIrjuItgQGC8WeWbSWgP91x7L/bBAFacA/u+c60pVdHrLz7VFrgzsKy9gJQwb5XV
         2oty6btRgJpX3jrvQSNBQfjWA49z11R+bpXq+yzbJlDpA8ZXBL5FKqmlnH7LwVyIck
         fW2kGcVuamALhzFvcdawcKP689Czr93PsT0rK4qe5MsKgn9ChiFh1c61zcCmIE9QPZ
         l8GjNAis9gWxLCaq65IjfYZksyc/U5SiF1JKtu1FQ+v5mETm71416rfVkqJauvw7bl
         qL81YFjUjaY0RpPeyYvOa34FDTmTCAktxGX28YNBWstSpYxSjZqTLzs/N54KnTdC4f
         imAUBu8jfKe6A==
Received: by mail-oi1-f172.google.com with SMTP id i3so2481327oik.7;
        Thu, 18 Mar 2021 14:16:00 -0700 (PDT)
X-Gm-Message-State: AOAM530HYiNArJrF6ApCCKFqmC9fVPpEJG9Nt5LQ0Y2T0EUcTfgRodEE
        MUAIJIQb6CJwl8JY2Nmd+3Bfd4cc31U0d6MbGc0=
X-Google-Smtp-Source: ABdhPJxKYgLl8fYQ8VticfZtJO+yxbMjJVhbodTKk/n+YQeTpe3cchm4y/YrJuRX1lVcHuSXsJS+SQDXdnu5U4Z7BA4=
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr4563556oie.4.1616102159988;
 Thu, 18 Mar 2021 14:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-3-balsini@android.com>
 <CAK8P3a2VDH9-reuj8QTkFzbaU9XTUEOWFCmCVg1Snb6RjD6mHw@mail.gmail.com> <YFN8IyFTdqhlS9Lf@google.com>
In-Reply-To: <YFN8IyFTdqhlS9Lf@google.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 18 Mar 2021 22:15:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a36ToSbvW1F_0w0gCiWGCoZgFwoLHmQ7Tz2jtwV++VrWA@mail.gmail.com>
Message-ID: <CAK8P3a36ToSbvW1F_0w0gCiWGCoZgFwoLHmQ7Tz2jtwV++VrWA@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 2/8] fuse: 32-bit user space ioctl compat for
 fuse device
To:     Alessio Balsini <balsini@android.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel@lists.sourceforge.net,
        Android Kernel Team <kernel-team@android.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 5:13 PM Alessio Balsini <balsini@android.com> wrote:
> On Tue, Mar 16, 2021 at 07:53:06PM +0100, Arnd Bergmann wrote:
> > On Mon, Jan 25, 2021 at 4:48 PM Alessio Balsini <balsini@android.com> wrote:
> > >
>
> Thanks for spotting this possible criticality.
>
> I noticed that 32-bit users pace was unable to use the
> FUSE_DEV_IOC_CLONE ioctl on 64-bit kernels, so this change avoid this
> issue by forcing the kernel to interpret 32 and 64 bit
> FUSE_DEV_IOC_CLONE command as if they were the same.

As far as I can tell from the kernel headers, the command code should
be the same for both 32-bit and 64-bit tasks: 0x8004e500.
Can you find out what exact value you see in the user space that was
causing problems, and how it ended up with a different value than
the 64-bit version?

If there are two possible command codes, I'd suggest you just change
the driver to handle both variants explicitly, but not any other one.

> This is the simplest solution I could find as the UAPI is not changed
> as, as you mentioned, the argument doesn't require any conversion.
>
> I understand that this might limit possible future extensions of the
> FUSE_DEV_IOC_XXX ioctls if their in/out argument changed depending on
> the architecture, but only at that point we can switch to using the
> compat layer, right?
>
> What I'm worried about is the direction, do you think this would be an
> issue?
>
> I can start working on a compat layer fix meanwhile.

For a proper well-designed ioctl interface, compat support should not
need anything beyond the '.compat_ioctl = compat_ptr_ioctl'
assignment.

       Arnd
