Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB53122223
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 03:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfLQCuQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 21:50:16 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43441 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfLQCuQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 21:50:16 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so6757247edb.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 18:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYBVg7h+K1Spp2HkLsStEf0BrK46leqRA54PxfOciFU=;
        b=tlkl7LyrN6FJlnsuVajcnUOI7b6xEbZLbTaAXnK2vPyeGzid3zrsneaC+lhzsJPQGw
         nyAkC7KO9v5ShHkROMxNyWKsqAPY/PelsGHVm0BFfOWJVzyxLXgluGM2TKTBWpjZJmrl
         V43mKJ0IOIYerOt+YIs9QzUGzTHUYl+VR9+IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYBVg7h+K1Spp2HkLsStEf0BrK46leqRA54PxfOciFU=;
        b=eZjWZDtxFsVeUIQVBFoqoufaTBIRQMwbbhzlR+sLLz/BiSctdil9wlmohrexZu5Zcw
         nDwN9aOV+9m9bGEWN+6lzogRRt764IyvXeVBv5TMBrzkVSZRc8BbBH7I5L/7s8ZsOy1I
         xFSAqZZ0RDhMBa/AtyYm6JWWQX9RWfYS3vX37sh3W2BX4r5VzvLIxn6jyyqyT1adCYQr
         etM3yWohU+2YWQYubksUaHq+Aqlx20cLl0wVemr1BbtixloxNgIk/bJgTOtHac9+fhKa
         st7jwWi6DH/v5IvslW5v3lKb+tj4Jv31AtaY25e+1gmUs5qOyZOVRJqRAF687WJUSy84
         v8hQ==
X-Gm-Message-State: APjAAAV0w4FjRCiE79Zr9M9wRo7TedxdFhjtBRCDD6qPlEbCJ+JFQyLn
        hi9JXHs3/1jshW2brZF0t3W7em4MDNUAOnyCLn6A7w==
X-Google-Smtp-Source: APXvYqw0WG5Hddk4yFlo7FLp2n0qVBcCtZeVhx0mV4SG3wnQIzy5aRXt4IpCAjDZa2DzfO1SnLfkQqj6qTH4HOHbT4U=
X-Received: by 2002:a05:6402:185a:: with SMTP id v26mr883851edy.290.1576551013878;
 Mon, 16 Dec 2019 18:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20191217010001.GA14461@ircssh-2.c.rugged-nimbus-611.internal> <20191217015001.sp6mrhuiqrivkq3u@wittgenstein>
In-Reply-To: <20191217015001.sp6mrhuiqrivkq3u@wittgenstein>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Mon, 16 Dec 2019 18:49:37 -0800
Message-ID: <CAMp4zn8fzeiJVSn6EtRi6UAGh6AL3QWu=PZxw+=TAYJORjn_Sw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Jann Horn <jannh@google.com>, cyphar@cyphar.com,
        oleg@redhat.com, Andy Lutomirski <luto@amacapital.net>,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 16, 2019 at 5:50 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> [Cc Arnd since he fiddled with ioctl()s quite a bit recently.]
>
>
> That should be pidfd.h and the resulting new file be placed under the
> pidfd entry in maintainers:
> +F:     include/uapi/linux/pidfd.h
>
> >
> >  enum pid_type
> >  {
> > diff --git a/include/uapi/linux/pid.h b/include/uapi/linux/pid.h
> > new file mode 100644
> > index 000000000000..4ec02ed8b39a
> > --- /dev/null
> > +++ b/include/uapi/linux/pid.h
> > @@ -0,0 +1,26 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef _UAPI_LINUX_PID_H
> > +#define _UAPI_LINUX_PID_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/ioctl.h>
> > +
> > +/* options to pass in to pidfd_getfd_args flags */
> > +#define PIDFD_GETFD_CLOEXEC (1 << 0) /* open the fd with cloexec */
>
> Please, make them cloexec by default unless there's a very good reason
> not to.
>
For now then, should I have flags, and just say "reserved for future usage",
or would you prefer that I drop flags entirely?

> > +
> > +struct pidfd_getfd_args {
> > +     __u32 size;             /* sizeof(pidfd_getfd_args) */
> > +     __u32 fd;       /* the tracee's file descriptor to get */
> > +     __u32 flags;
> > +};
>
> I think you want to either want to pad this
>
> +struct pidfd_getfd_args {
> +       __u32 size;             /* sizeof(pidfd_getfd_args) */
> +       __u32 fd;       /* the tracee's file descriptor to get */
> +       __u32 flags;
>         __u32 reserved;
> +};
>
> or use __aligned_u64 everywhere which I'd personally prefer instead of
> this manual padding everywhere.
>
Wouldn't __attribute__((packed)) achieve a similar thing of making sure
the struct is a constant size across all compilers?

I'll go with __aligned_u64 instead of packed, if you don't want to use packed.

> > +
> > +#define PIDFD_IOC_MAGIC                      'p'
> > +#define PIDFD_IO(nr)                 _IO(PIDFD_IOC_MAGIC, nr)
> > +#define PIDFD_IOR(nr, type)          _IOR(PIDFD_IOC_MAGIC, nr, type)
> > +#define PIDFD_IOW(nr, type)          _IOW(PIDFD_IOC_MAGIC, nr, type)
> > +#define PIDFD_IOWR(nr, type)         _IOWR(PIDFD_IOC_MAGIC, nr, type)
> > +
> > +#define PIDFD_IOCTL_GETFD            PIDFD_IOWR(0xb0, \
> > +                                             struct pidfd_getfd_args)
> > +
> > +#endif /* _UAPI_LINUX_PID_H */
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 6cabc124378c..d9971e664e82 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -1726,9 +1726,81 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
> >       return poll_flags;
> >  }
> >
> > +static long pidfd_getfd(struct pid *pid, struct pidfd_getfd_args __user *buf)
> > +{
> > +     struct pidfd_getfd_args args;
> > +     unsigned int fd_flags = 0;
> > +     struct task_struct *task;
> > +     struct file *file;
> > +     u32 user_size;
> > +     int ret, fd;
> > +
> > +     ret = get_user(user_size, &buf->size);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = copy_struct_from_user(&args, sizeof(args), buf, user_size);
> > +     if (ret)
> > +             return ret;
> > +     if ((args.flags & ~(PIDFD_GETFD_CLOEXEC)) != 0)
> > +             return -EINVAL;
>
> Nit: It's more common - especially in this file - to do
>
> if (args.flags & ~PIDFD_GETFD_CLOEXEC)
>         return -EINVAL;
>
> > +     if (args.flags & PIDFD_GETFD_CLOEXEC)
> > +             fd_flags |= O_CLOEXEC;
> > +
I'll drop this bit, and just make it CLOEXEC by default.

> > +     task = get_pid_task(pid, PIDTYPE_PID);
> > +     if (!task)
> > +             return -ESRCH;
>
> \n
>
> > +     ret = -EPERM;
> > +     if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
> > +             goto out;
>
> \n
>
> Please don't pre-set errors unless they are used by multiple exit paths.
> if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
>         ret = -EPERM;
>         goto out;
> }
>
> > +     ret = -EBADF;
> > +     file = fget_task(task, args.fd);
> > +     if (!file)
> > +             goto out;
>
> Same.
>
> > +
> > +     fd = get_unused_fd_flags(fd_flags);
> > +     if (fd < 0) {
> > +             ret = fd;
> > +             goto out_put_file;
> > +     }
>
> \n
>
> > +     /*
> > +      * security_file_receive must come last since it may have side effects
> > +      * and cannot be reversed.
> > +      */
> > +     ret = security_file_receive(file);
> > +     if (ret)
> > +             goto out_put_fd;
> > +
> > +     fd_install(fd, file);
> > +     put_task_struct(task);
> > +     return fd;
> > +
> > +out_put_fd:
> > +     put_unused_fd(fd);
> > +out_put_file:
> > +     fput(file);
> > +out:
> > +     put_task_struct(task);
> > +     return ret;
> > +}
> > +
> > +static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > +{
> > +     struct pid *pid = file->private_data;
> > +     void __user *buf = (void __user *)arg;
> > +
> > +     switch (cmd) {
> > +     case PIDFD_IOCTL_GETFD:
> > +             return pidfd_getfd(pid, buf);
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> >  const struct file_operations pidfd_fops = {
> >       .release = pidfd_release,
> >       .poll = pidfd_poll,
> > +     .unlocked_ioctl = pidfd_ioctl,
> >  #ifdef CONFIG_PROC_FS
> >       .show_fdinfo = pidfd_show_fdinfo,
> >  #endif
> > --
> > 2.20.1
> >
