Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2F11F0663
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 13:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgFFLzn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 07:55:43 -0400
Received: from port70.net ([81.7.13.123]:59992 "EHLO port70.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbgFFLzm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 07:55:42 -0400
Received: by port70.net (Postfix, from userid 1002)
        id 3A428ABEC0C2; Sat,  6 Jun 2020 13:55:37 +0200 (CEST)
Date:   Sat, 6 Jun 2020 13:55:37 +0200
From:   Szabolcs Nagy <nsz@port70.net>
To:     Kyle Evans <kevans@freebsd.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        torvalds@linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Victor Stinner <victor.stinner@gmail.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, fweimer@redhat.com, jannh@google.com,
        oleg@redhat.com, arnd@arndb.de, shuah@kernel.org,
        dhowells@redhat.com, ldv@altlinux.org
Subject: Re: [PATCH v5 1/3] open: add close_range()
Message-ID: <20200606115537.GB871552@port70.net>
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
 <20200602204219.186620-2-christian.brauner@ubuntu.com>
 <20200605145549.GC673948@port70.net>
 <CACNAnaEjjQBB8ieZH+td8jk-Aitg3CjGB1WwGQwEv-STg5Do+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACNAnaEjjQBB8ieZH+td8jk-Aitg3CjGB1WwGQwEv-STg5Do+g@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Kyle Evans <kevans@freebsd.org> [2020-06-05 21:54:56 -0500]:
> On Fri, Jun 5, 2020 at 9:55 AM Szabolcs Nagy <nsz@port70.net> wrote:
> > this api needs a documentation patch if there isn't yet.
> >
> > currently there is no libc interface contract in place that
> > says which calls may use libc internal fds e.g. i've seen
> >
> >   openlog(...) // opens libc internal syslog fd
> >   ...
> >   fork()
> >   closefrom(...) // close syslog fd
> >   open(...) // something that reuses the closed fd
> >   syslog(...) // unsafe: uses the wrong fd
> >   execve(...)
> >
> > syslog uses a libc internal fd that the user trampled on and
> > this can go bad in many ways depending on what libc apis are
> > used between closefrom (or equivalent) and exec.
> >
> 
> Documentation is good. :-) I think you'll find that while this example
> seems to be innocuous on FreeBSD (and likely other *BSD), this is an
> atypical scenario and generally not advised.  You would usually not
> start closing until you're actually ready to exec/fail.

it's a recent bug https://bugs.kde.org/show_bug.cgi?id=420921

but not the first closefrom bug i saw: it is a fundamentally
unsafe operation that frees resources owned by others.

> > > The code snippet above is one way of working around the problem that file
> > > descriptors are not cloexec by default. This is aggravated by the fact that
> > > we can't just switch them over without massively regressing userspace. For
> >
> > why is a switch_to_cloexec_range worse than close_range?
> > the former seems safer to me. (and allows libc calls
> > to be made between such switch and exec: libc internal
> > fds have to be cloexec anyway)
> >
> 
> I wouldn't say it's worse, but it only solves half the problem. While
> closefrom -> exec is the most common usage by a long shot, there are
> also times (e.g. post-fork without intent to exec for a daemon/service
> type) that you want to go ahead and close everything except maybe a
> pipe fd that you've opened for IPC. While uncommon, there's no reason
> this needs to devolve into a loop to close 'all the fds' when you can
> instead introduce close_range to solve both the exec case and other
> less common scenarios.

the syslog example shows why post-fork closefrom without
intent to exec does not work: there is no contract about
which api calls behave like syslog, so calling anything
after closefrom can be broken.

libc can introduce new api contracts e.g. that some apis
don't use fds internally or after a closefrom call some
apis behave differently, if this is the expected direction
then it would be nice to propose that on the libc-coord
at openwall.com list.

> Coordination with libc is generally not much of an issue, because this
> is really one of the last things you do before exec() or swiftly
> failing miserably. Applications that currently loop over all fd <=
> maxfd and close(fd) right now are subject to the very same
> constraints, this is just a much more efficient way and
> debugger-friendly way to accomplish it. You've absolutely not lived
> life until you've had to watch thousands of close() calls painfully
> scroll by in truss/strace.

applications do a 'close all fds' operation because there
is no alternative. (i think there are better ways to do
this than looping: you can poll on the fds and only close
the ones that didnt POLLNVAL, this should be more portable
than /proc, but it's besides my point) optimizing this
operation may not be the only way to achive whatever those
applications are trying to do.

if closefrom only works before exec then that should be
documented and callers that do otherwise fixed, if
important users do things between closefrom and exec then
i think a different design is needed with libc maintainers
involved.
