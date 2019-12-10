Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAF031185DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 12:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfLJLK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 06:10:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54474 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfLJLK6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:10:58 -0500
Received: from [79.140.114.95] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iedPp-0005d2-Be; Tue, 10 Dec 2019 11:10:53 +0000
Date:   Tue, 10 Dec 2019 12:10:52 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        cyphar@cyphar.com, luto@amacapital.net, viro@zeniv.linux.org.uk,
        Jed Davis <jld@mozilla.com>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        Emilio Cobos =?utf-8?Q?=C3=81lvarez?= <ealvarez@mozilla.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v2 4/4] samples: Add example of using PTRACE_GETFD in
 conjunction with user trap
Message-ID: <20191210111051.j5opodgjalqigx6q@wittgenstein>
References: <20191209070646.GA32477@ircssh-2.c.rugged-nimbus-611.internal>
 <20191209192959.GB10721@redhat.com>
 <BE3E056F-0147-4A00-8FF7-6CC9DE02A30C@ubuntu.com>
 <20191209204635.GC10721@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191209204635.GC10721@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[I'm expanding the Cc to a few Firefox and glibc people since we've been
 been talking about replacing SECCOMP_RET_TRAP with
 SECCOMP_RET_USER_NOTIF for a bit now because the useage of
 SECCOMP_RET_TRAP in the broker blocks desirable core glibc changes.
 Even if just for their lurking pleasure. :)]

On Mon, Dec 09, 2019 at 09:46:35PM +0100, Oleg Nesterov wrote:
> On 12/09, Christian Brauner wrote:
> >
> > >We can
> > >add PTRACE_DETACH_ASYNC, but this makes me think that PTRACE_GETFD has
> > >nothing
> > >to do with ptrace.
> > >
> > >May be a new syscall which does ptrace_may_access() + get_task_file()
> > >will make
> > >more sense?
> > >
> > >Oleg.
> > 
> > Once more since this annoying app uses html by default...
> > 
> > But we can already do this right now and this is just an improvement.
> > That's a bit rich for a new syscall imho...
> 
> I agree, and I won't really argue...
> 
> but the changelog in 2/4 says
> 
> 	The requirement that the tracer has attached to the tracee prior to the
> 	capture of the file descriptor may be lifted at a later point.
> 
> so may be we should do this right now?

I think so, yes. This doesn't strike me as premature optimization but
rather as a core design questions.

> 
> plus this part
> 
> 	@@ -1265,7 +1295,8 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
> 		}
> 	 
> 		ret = ptrace_check_attach(child, request == PTRACE_KILL ||
> 	-				  request == PTRACE_INTERRUPT);
> 	+				  request == PTRACE_INTERRUPT ||
> 	+				  request == PTRACE_GETFD);
> 
> actually means "we do not need ptrace, but we do not know where else we
> can add this fd_install(get_task_file()).

Right, I totally get your point and I'm not a fan of this being in
ptrace() either.

The way I see is is that the main use-case for this feature is the
seccomp notifier and I can see this being useful. So the right place to
plumb this into might just be seccomp and specifically on to of the
notifier.
If we don't care about getting and setting fds at random points of
execution it might make sense to add new options to the notify ioctl():

#define SECCOMP_IOCTL_NOTIF_GET_FD	SECCOMP_IOWR(3, <sensible struct>)
#define SECCOMP_IOCTL_NOTIF_SET_FD	SECCOMP_IOWR(4, <sensible struct>)

which would let you get and set fds while the supervisee is blocked.

Christian
