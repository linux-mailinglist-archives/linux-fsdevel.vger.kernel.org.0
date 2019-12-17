Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63FD1122246
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 04:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfLQDA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 22:00:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40746 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfLQDA0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 22:00:26 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ih35z-0006KA-NG; Tue, 17 Dec 2019 03:00:23 +0000
Date:   Tue, 17 Dec 2019 04:00:22 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Jann Horn <jannh@google.com>, cyphar@cyphar.com,
        oleg@redhat.com, Andy Lutomirski <luto@amacapital.net>,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/4] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
Message-ID: <20191217030021.noeo3clkkz33ucuz@wittgenstein>
References: <20191217010001.GA14461@ircssh-2.c.rugged-nimbus-611.internal>
 <20191217015001.sp6mrhuiqrivkq3u@wittgenstein>
 <CAMp4zn8fzeiJVSn6EtRi6UAGh6AL3QWu=PZxw+=TAYJORjn_Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMp4zn8fzeiJVSn6EtRi6UAGh6AL3QWu=PZxw+=TAYJORjn_Sw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 16, 2019 at 06:49:37PM -0800, Sargun Dhillon wrote:
> On Mon, Dec 16, 2019 at 5:50 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > [Cc Arnd since he fiddled with ioctl()s quite a bit recently.]
> >
> >
> > That should be pidfd.h and the resulting new file be placed under the
> > pidfd entry in maintainers:
> > +F:     include/uapi/linux/pidfd.h
> >
> > >
> > >  enum pid_type
> > >  {
> > > diff --git a/include/uapi/linux/pid.h b/include/uapi/linux/pid.h
> > > new file mode 100644
> > > index 000000000000..4ec02ed8b39a
> > > --- /dev/null
> > > +++ b/include/uapi/linux/pid.h
> > > @@ -0,0 +1,26 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > +#ifndef _UAPI_LINUX_PID_H
> > > +#define _UAPI_LINUX_PID_H
> > > +
> > > +#include <linux/types.h>
> > > +#include <linux/ioctl.h>
> > > +
> > > +/* options to pass in to pidfd_getfd_args flags */
> > > +#define PIDFD_GETFD_CLOEXEC (1 << 0) /* open the fd with cloexec */
> >
> > Please, make them cloexec by default unless there's a very good reason
> > not to.
> >
> For now then, should I have flags, and just say "reserved for future usage",
> or would you prefer that I drop flags entirely?

Hm, you can leave the flags argument imho but maybe someone else has
stronger opinions about this.

> 
> > > +
> > > +struct pidfd_getfd_args {
> > > +     __u32 size;             /* sizeof(pidfd_getfd_args) */
> > > +     __u32 fd;       /* the tracee's file descriptor to get */
> > > +     __u32 flags;
> > > +};
> >
> > I think you want to either want to pad this
> >
> > +struct pidfd_getfd_args {
> > +       __u32 size;             /* sizeof(pidfd_getfd_args) */
> > +       __u32 fd;       /* the tracee's file descriptor to get */
> > +       __u32 flags;
> >         __u32 reserved;
> > +};
> >
> > or use __aligned_u64 everywhere which I'd personally prefer instead of
> > this manual padding everywhere.
> >
> Wouldn't __attribute__((packed)) achieve a similar thing of making sure
> the struct is a constant size across all compilers?
> 
> I'll go with __aligned_u64 instead of packed, if you don't want to use packed.

We had a discussion about this in relation to the openat2()
patchset just recently. Florian and a few others raised good points why
we might not want to use packed:
https://lore.kernel.org/lkml/87o8w9bcaf.fsf@mid.deneb.enyo.de/
https://lore.kernel.org/lkml/a328b91d-fd8f-4f27-b3c2-91a9c45f18c0@rasmusvillemoes.dk/

Christian
