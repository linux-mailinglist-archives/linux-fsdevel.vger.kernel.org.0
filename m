Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 239DF118DC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 17:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfLJQiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 11:38:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34732 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfLJQiw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:38:52 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ieiX9-000357-Hf; Tue, 10 Dec 2019 16:38:47 +0000
Date:   Tue, 10 Dec 2019 17:38:46 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Jann Horn <jannh@google.com>, cyphar@cyphar.com,
        Andy Lutomirski <luto@amacapital.net>, viro@zeniv.linux.org.uk,
        Jed Davis <jld@mozilla.com>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        Emilio Cobos =?utf-8?Q?=C3=81lvarez?= <ealvarez@mozilla.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v2 4/4] samples: Add example of using PTRACE_GETFD in
 conjunction with user trap
Message-ID: <20191210163845.6hbbawr6cpt5dp5c@wittgenstein>
References: <20191209070646.GA32477@ircssh-2.c.rugged-nimbus-611.internal>
 <20191209192959.GB10721@redhat.com>
 <BE3E056F-0147-4A00-8FF7-6CC9DE02A30C@ubuntu.com>
 <20191209204635.GC10721@redhat.com>
 <20191210111051.j5opodgjalqigx6q@wittgenstein>
 <CAMp4zn84YQHz62x-nxZFBgMEW9AiMt75q_rO83uaGg=YtyKV-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMp4zn84YQHz62x-nxZFBgMEW9AiMt75q_rO83uaGg=YtyKV-w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 08:07:45AM -0800, Sargun Dhillon wrote:
> On Tue, Dec 10, 2019 at 3:10 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > [I'm expanding the Cc to a few Firefox and glibc people since we've been
> >  been talking about replacing SECCOMP_RET_TRAP with
> >  SECCOMP_RET_USER_NOTIF for a bit now because the useage of
> >  SECCOMP_RET_TRAP in the broker blocks desirable core glibc changes.
> >  Even if just for their lurking pleasure. :)]
> >
> > On Mon, Dec 09, 2019 at 09:46:35PM +0100, Oleg Nesterov wrote:
> > > On 12/09, Christian Brauner wrote
> > >
> > > I agree, and I won't really argue...
> > >
> > > but the changelog in 2/4 says
> > >
> > >       The requirement that the tracer has attached to the tracee prior to the
> > >       capture of the file descriptor may be lifted at a later point.
> > >
> > > so may be we should do this right now?
> >
> > I think so, yes. This doesn't strike me as premature optimization but
> > rather as a core design questions.
> >
> > >
> > > plus this part
> > >
> > >       @@ -1265,7 +1295,8 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
> > >               }
> > >
> > >               ret = ptrace_check_attach(child, request == PTRACE_KILL ||
> > >       -                                 request == PTRACE_INTERRUPT);
> > >       +                                 request == PTRACE_INTERRUPT ||
> > >       +                                 request == PTRACE_GETFD);
> > >
> > > actually means "we do not need ptrace, but we do not know where else we
> > > can add this fd_install(get_task_file()).
> >
> > Right, I totally get your point and I'm not a fan of this being in
> > ptrace() either.
> >
> > The way I see is is that the main use-case for this feature is the
> > seccomp notifier and I can see this being useful. So the right place to
> > plumb this into might just be seccomp and specifically on to of the
> > notifier.
> > If we don't care about getting and setting fds at random points of
> > execution it might make sense to add new options to the notify ioctl():
> >
> > #define SECCOMP_IOCTL_NOTIF_GET_FD      SECCOMP_IOWR(3, <sensible struct>)
> > #define SECCOMP_IOCTL_NOTIF_SET_FD      SECCOMP_IOWR(4, <sensible struct>)
> >
> > which would let you get and set fds while the supervisee is blocked.
> >
> > Christian
> Doesn't SECCOMP_IOCTL_NOTIF_GET_FD have some ambiguity to it?

As Tycho mentioned, this is why we have a the tid of the calling task
but we also have a cookie per request.
The cookie is useful so that you can do
- receive request <chocolate> cookie
- open(/proc/<pid>{/mem})
- verify <chocolate> cookie still exists
  - <chocolate> cookie still exists -> file descriptor refers to correct
    task
  - <chocolate> cookie gone -> task has been recycled

> Specifically, because
> multiple processes can have the same notifier attached to them? If we
> choose to go down the
> route of introducing an ioctl (which I'm not at all opposed to), I
> would rather do it on pidfd. We
> can then plumb seccomp notifier to send pidfd instead of raw pid. In
> the mean time, folks
> can just open up /proc/${PID}, and do the check cookie dance.
> 
> Christian,
> As the maintainer of pidfd, what do you think?

Let me quote what I wrote to the Mozilla folks today. :)

"(One thing that always strikes me is that if my pidfd patches would've
been ready back when we did the seccomp notifier we could've added a
pidfd argument to the seccomp notifier kernel struct and if a flag is
set given back a pidfd alongside the notifier fd. This way none of this
revalidting the id stuff would've been necessary and you could also
safely translate from a pidfd into a /proc/<pid> directory to e.g. open
/proc/<pid>/mem. Anyway, that's not out of scope. One could still
write a patch for that to add a pidfd argument under a new flag to the
kernel struct. Should be rather trivial.)"

So yeah, it crossed my mind. ;)

I really would like to have this placed under a flag though...
I very much dislike the idea of receiving any kind of fd
- _especially a pidfd_ - implicitly.
So ideally this would be a flag to the receive ioctl(). Kees just got my
SECCOMP_USER_NOTIF_FLAG_CONTINUE patchset merged for v5.5 which adds the

#define SECCOMP_USER_NOTIF_FLAG_CONTINUE (1UL << 0)

flag which when set in the send case (i.e. supervisor -> kernel) will
cause the syscall to be executed.

When we add a new flag to get a pidfd it might make sense to rename the
CONTINUE flag in master before v5.5 is out to

#define SECCOMP_USER_NOTIF_SEND_FLAG_CONTINUE (1UL << 0)

to indicate that it's only valid for the SEND ioctl().

Then we add

#define SECCOMP_USER_NOTIF_RECV_FLAG_PIDFD (1UL << 0)

for v5.6. This way send and receive flags are named differently for
clarity. (I don't care about the name being long. Other people might
though _shrug_.)

Christian
