Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8F11118D51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 17:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfLJQNB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 11:13:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35200 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfLJQNB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:13:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so9121933pgk.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 08:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+qAGrVPkwcfzkD6je4iq3abncA5LmG/XuqOXQo6A/Mg=;
        b=RNTbEK22BV3je2hAto+ezD7RbB5bkRqQWIb9wbGPxJJTusTfbyJIGyqp1voN0S2udA
         Y7ZPjxoxj1WBYqFmMvz88mwo0B326gOt7gK1gihkt075nHPXp5X1IdXSWWqxqRKzeGid
         vZSLo/7dhpfGOPDUl7Y5tEFpUo9LrA7gXrJvR0ZM50AtEiKB5z2XU1q3g4H7JFL4ngMa
         nAiTmKQrC3a454nAt9y3Z+bopeTDBeGScOkNIZrKGuwwVtTURvAji3tJzhPEKhM/pLN5
         MF3Fv7DOSnydQq8v+g8VvzNz1mJMWbdoqPDlPninYdb3x0lHPzCDag+HSupQN9kW82E7
         9gNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+qAGrVPkwcfzkD6je4iq3abncA5LmG/XuqOXQo6A/Mg=;
        b=qP5tHummq+r1tYSZKCNXobcW5hz2ViE8n90Y6fjwtS1XR+QCeJbC3o81nveTXuFKwS
         witLwB6h83ZPGMSkkeaj7Ep+Ab1ibxAxSpUEv0rHLzIunMpLoFR17bFCXM4yELIUipLB
         iy0cF/ac2gHX1LQv6PsDSTrOel6Rz8DcSBQcdo4PDhmy+MqGEonPjpCZTMnmFvcIYhpl
         kSPpd27AvOjtnn42tDrhllv6F7Oj35wKDKMp/uLrigoJdWOxIGdlPPzsVKk4yV9/g7QZ
         Ata+6c2OgRZQkD7p/C9b6YKpfgEtrVi8IqGtxhZ3TLymNJdlcbn3nmsvyadci8N7cM6U
         hDOw==
X-Gm-Message-State: APjAAAXLLHx6HQ2xGP+tberR5Us2ysYbo7quTRlgnXQTSZe18TN/cf0d
        csuOkdL3C8lEHaBrm1SHu24LdQ==
X-Google-Smtp-Source: APXvYqxlzJqBOhyfz1pog5+dbkAoW01mq5oD7ixwzFd2oWr20Cl/+N0OPZ9o7DxykanrYPXRRcLXuw==
X-Received: by 2002:aa7:8d03:: with SMTP id j3mr37397821pfe.162.1575994380668;
        Tue, 10 Dec 2019 08:13:00 -0800 (PST)
Received: from cisco ([2601:282:902:b340:b1ae:d960:d4d7:eda9])
        by smtp.gmail.com with ESMTPSA id z10sm4036146pfa.184.2019.12.10.08.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:12:59 -0800 (PST)
Date:   Tue, 10 Dec 2019 09:13:00 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
        cyphar@cyphar.com, Andy Lutomirski <luto@amacapital.net>,
        viro@zeniv.linux.org.uk, Jed Davis <jld@mozilla.com>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        Emilio Cobos =?iso-8859-1?Q?=C1lvarez?= <ealvarez@mozilla.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v2 4/4] samples: Add example of using PTRACE_GETFD in
 conjunction with user trap
Message-ID: <20191210161300.GE22803@cisco>
References: <20191209070646.GA32477@ircssh-2.c.rugged-nimbus-611.internal>
 <20191209192959.GB10721@redhat.com>
 <BE3E056F-0147-4A00-8FF7-6CC9DE02A30C@ubuntu.com>
 <20191209204635.GC10721@redhat.com>
 <20191210111051.j5opodgjalqigx6q@wittgenstein>
 <CAMp4zn84YQHz62x-nxZFBgMEW9AiMt75q_rO83uaGg=YtyKV-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMp4zn84YQHz62x-nxZFBgMEW9AiMt75q_rO83uaGg=YtyKV-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> Specifically, because
> multiple processes can have the same notifier attached to them?

The id member corresponds to a particular syscall from a particular
pid, which makes it unique.

> If we
> choose to go down the
> route of introducing an ioctl (which I'm not at all opposed to), I
> would rather do it on pidfd. We
> can then plumb seccomp notifier to send pidfd instead of raw pid. In
> the mean time, folks
> can just open up /proc/${PID}, and do the check cookie dance.

This might be more generally useful, the problem is synchronization, I
guess.

Tycho
