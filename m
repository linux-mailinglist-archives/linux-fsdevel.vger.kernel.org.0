Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A585512C5B1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2019 18:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfL2Rj5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Dec 2019 12:39:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36592 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbfL2RcS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:32:18 -0500
Received: from [172.58.107.62] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ilcQI-0005a0-Au; Sun, 29 Dec 2019 17:32:15 +0000
Date:   Sun, 29 Dec 2019 18:32:04 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        Emilio Cobos =?utf-8?Q?=C3=81lvarez?= <ealvarez@mozilla.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jed Davis <jld@mozilla.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 2/3] pid: Introduce pidfd_getfd syscall
Message-ID: <20191229173202.55apy2dpv7qj7gov@wittgenstein>
References: <20191226180334.GA29409@ircssh-2.c.rugged-nimbus-611.internal>
 <20191228100944.kh22bofbr5oe2kvk@wittgenstein>
 <CAMp4zn9LyGw=BNiLNRgZXAbFdi87pSjy1YmDXvFvwmA=u3yDyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMp4zn9LyGw=BNiLNRgZXAbFdi87pSjy1YmDXvFvwmA=u3yDyw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 28, 2019 at 08:03:23AM -0500, Sargun Dhillon wrote:
> On Sat, Dec 28, 2019 at 5:12 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Thu, Dec 26, 2019 at 06:03:36PM +0000, Sargun Dhillon wrote:
> > > This syscall allows for the retrieval of file descriptors from other
> > > processes, based on their pidfd. This is possible using ptrace, and
> > > injection of parasitic code to inject code which leverages SCM_RIGHTS
> > > to move file descriptors between a tracee and a tracer. Unfortunately,
> > > ptrace comes with a high cost of requiring the process to be stopped,
> > > and breaks debuggers. This does not require stopping the process under
> > > manipulation.
> > >
> > > One reason to use this is to allow sandboxers to take actions on file
> > > descriptors on the behalf of another process. For example, this can be
> > > combined with seccomp-bpf's user notification to do on-demand fd
> > > extraction and take privileged actions. One such privileged action
> > > is binding a socket to a privileged port.
> > >
> > > This also adds the syscall to all architectures at the same time.
> > >
> > > /* prototype */
> > >   /* flags is currently reserved and should be set to 0 */
> > >   int sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
> > >
> > > /* testing */
> > > Ran self-test suite on x86_64
> >
> > Fyi, I'm likely going to rewrite/add parts of/to this once I apply.
> >
> > A few comments below.
> >
> > > diff --git a/kernel/pid.c b/kernel/pid.c
> > > index 2278e249141d..4a551f947869 100644
> > > --- a/kernel/pid.c
> > > +++ b/kernel/pid.c
> > > @@ -578,3 +578,106 @@ void __init pid_idr_init(void)
> > >       init_pid_ns.pid_cachep = KMEM_CACHE(pid,
> > >                       SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
> > >  }
> > > +
> > > +static struct file *__pidfd_fget(struct task_struct *task, int fd)
> > > +{
> > > +     struct file *file;
> > > +     int ret;
> > > +
> > > +     ret = mutex_lock_killable(&task->signal->cred_guard_mutex);
> > > +     if (ret)
> > > +             return ERR_PTR(ret);
> > > +
> > > +     if (!ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS)) {
> > > +             file = ERR_PTR(-EPERM);
> > > +             goto out;
> > > +     }
> > > +
> > > +     file = fget_task(task, fd);
> > > +     if (!file)
> > > +             file = ERR_PTR(-EBADF);
> > > +
> > > +out:
> > > +     mutex_unlock(&task->signal->cred_guard_mutex);
> > > +     return file;
> > > +}
> >
> > Looking at this code now a bit closer, ptrace_may_access() and
> > fget_task() both take task_lock(task) so this currently does:
> >
> > task_lock();
> > /* check access */
> > task_unlock();
> >
> > task_lock();
> > /* get fd */
> > task_unlock();
> >
> > which doesn't seem great.
> >
> > I would prefer if we could do:
> > task_lock();
> > /* check access */
> > /* get fd */
> > task_unlock();
> >
> > But ptrace_may_access() doesn't export an unlocked variant so _shrug_.
> Right, it seems intentional that __ptrace_may_access isn't exported. We
> can always change that later?

Yeah, it's just something I noted and it's not a big deal in my book. It
just would be nicer to only have to lock once. ptrace would need to
expose an unlocked variant and fget_task() would need to be removed
completely and then grabbing the file via fget or sm. But as I said it's
ok to do it like this rn.

> 
> >
> > But we can write this a little cleaner without the goto as:
> >
> > static struct file *__pidfd_fget(struct task_struct *task, int fd)
> > {
> >         struct file *file;
> >         int ret;
> >
> >         ret = mutex_lock_killable(&task->signal->cred_guard_mutex);
> >         if (ret)
> >                 return ERR_PTR(ret);
> >
> >         if (ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS))
> >                 file = fget_task(task, fd);
> >         else
> >                 file = ERR_PTR(-EPERM);
> >         mutex_unlock(&task->signal->cred_guard_mutex);
> >
> >         return file ?: ERR_PTR(-EBADF);
> > }
> >
> > If you don't like the ?: just do:
> >
> > if (!file)
> >         return ERR_PTR(-EBADF);
> >
> > return file;
> >
> > though I prefer the shorter ?: syntax which is perfect for shortcutting
> > returns.
> >
> > > +
> > > +static int pidfd_getfd(struct pid *pid, int fd)
> > > +{
> > > +     struct task_struct *task;
> > > +     struct file *file;
> > > +     int ret, retfd;
> > > +
> > > +     task = get_pid_task(pid, PIDTYPE_PID);
> > > +     if (!task)
> > > +             return -ESRCH;
> > > +
> > > +     file = __pidfd_fget(task, fd);
> > > +     put_task_struct(task);
> > > +     if (IS_ERR(file))
> > > +             return PTR_ERR(file);
> > > +
> > > +     retfd = get_unused_fd_flags(O_CLOEXEC);
> > > +     if (retfd < 0) {
> > > +             ret = retfd;
> > > +             goto out;
> > > +     }
> > > +
> > > +     /*
> > > +      * security_file_receive must come last since it may have side effects
> > > +      * and cannot be reversed.
> > > +      */
> > > +     ret = security_file_receive(file);
> >
> > So I don't understand the comment here. Can you explain what the side
> > effects are?
> The LSM can modify the LSM blob, or emit an (audit) event, even though
> the operation as a whole failed. Smack will report that file_receive
> successfully happened even though it could not have happened,
> because we were unable to provision a file descriptor.

So this either sounds like a bug in Smack or a design choice by the LSM
framework in general and also that it might apply to a lot of other
hooks too? But I'm not qualified to assess that.

Modifying an LSM blob, emitting an audit event may very well happen but
there are places all over the kernel were security hooks are called and
they are not the last point of failure (capable hooks come to mind
right away). My point being just because an audit event that happened
from an LSM indicating that e.g. a file receive event happened cannot be
intended to be equivalent == "was successful". That is not reality right
now when looking at net/* where security_file_receive() is called too
and surely can only be guaranteed from the actual codepaths that does the
file receive.
So I'd argue let's just use the clean version where we call
security_file_receive() before allocing the new fd just like net/* does
and make the code simpler and easier to maintain.

> 
> Apparmor does similar, and also manipulates the LSM blob,
> although that is undone by closing the file.
> 
> 
> > security_file_receive() is called in two places: net/core/scm.c and
> > net/compat.c. In both places it is called _before_ get_unused_fd_flags()
> > so I don't know what's special here that would prevent us from doing the
> > same. If there's no actual reason, please rewrite this functions as:
> >
> > static int pidfd_getfd(struct pid *pid, int fd)
> > {
> >         int ret;
> >         struct task_struct *task;
> >         struct file *file;
> >
> >         task = get_pid_task(pid, PIDTYPE_PID);
> >         if (!task)
> >                 return -ESRCH;
> >
> >         file = __pidfd_fget(task, fd);
> >         put_task_struct(task);
> >         if (IS_ERR(file))
> >                 return PTR_ERR(file);
> >
> >         ret = security_file_receive(file);
> >         if (ret) {
> >                 fput(file);
> >                 return ret;
> >         }
> >
> >         ret = get_unused_fd_flags(O_CLOEXEC);
> >         if (ret < 0)
> >                 fput(file);
> >         else
> >                 fd_install(ret, file);
> >
> >         return ret;
> > }
