Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595E01F044C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 04:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgFFCzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 22:55:11 -0400
Received: from mx2.freebsd.org ([96.47.72.81]:51310 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbgFFCzK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 22:55:10 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id BD28A75ACF;
        Sat,  6 Jun 2020 02:55:09 +0000 (UTC)
        (envelope-from kevans@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 49f3z13wywz4ZkW;
        Sat,  6 Jun 2020 02:55:09 +0000 (UTC)
        (envelope-from kevans@freebsd.org)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client CN "smtp.gmail.com", Issuer "GTS CA 1O1" (verified OK))
        (Authenticated sender: kevans)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 82112212CA;
        Sat,  6 Jun 2020 02:55:09 +0000 (UTC)
        (envelope-from kevans@freebsd.org)
Received: by mail-qk1-f173.google.com with SMTP id g28so11899439qkl.0;
        Fri, 05 Jun 2020 19:55:09 -0700 (PDT)
X-Gm-Message-State: AOAM532riWmv7cGl2ZwB9ZtfOBcYRF39wa/XiGoJHVgKrM2p5i2DLCa7
        L/izMow0XHXtjNQyozI2pgQWFofbqtDCD4TnBnk=
X-Google-Smtp-Source: ABdhPJzCJryMmTEHoBZFevF7W9bLiWqO53WxuwraCmT96xgfbY3GgRwjvBH4rxb/qz0FJwXOmpcjWZbqgc2/y757xgw=
X-Received: by 2002:ae9:dc84:: with SMTP id q126mr13079508qkf.430.1591412108517;
 Fri, 05 Jun 2020 19:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
 <20200602204219.186620-2-christian.brauner@ubuntu.com> <20200605145549.GC673948@port70.net>
In-Reply-To: <20200605145549.GC673948@port70.net>
From:   Kyle Evans <kevans@freebsd.org>
Date:   Fri, 5 Jun 2020 21:54:56 -0500
X-Gmail-Original-Message-ID: <CACNAnaEjjQBB8ieZH+td8jk-Aitg3CjGB1WwGQwEv-STg5Do+g@mail.gmail.com>
Message-ID: <CACNAnaEjjQBB8ieZH+td8jk-Aitg3CjGB1WwGQwEv-STg5Do+g@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] open: add close_range()
To:     Szabolcs Nagy <nsz@port70.net>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        torvalds@linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Victor Stinner <victor.stinner@gmail.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, fweimer@redhat.com, jannh@google.com,
        oleg@redhat.com, arnd@arndb.de, shuah@kernel.org,
        dhowells@redhat.com, ldv@altlinux.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 5, 2020 at 9:55 AM Szabolcs Nagy <nsz@port70.net> wrote:
>
> * Christian Brauner <christian.brauner@ubuntu.com> [2020-06-02 22:42:17 +0200]:
> > [... snip ...]
> >
> > First, it helps to close all file descriptors of an exec()ing task. This
> > can be done safely via (quoting Al's example from [1] verbatim):
> >
> >         /* that exec is sensitive */
> >         unshare(CLONE_FILES);
> >         /* we don't want anything past stderr here */
> >         close_range(3, ~0U);
> >         execve(....);
>
> this api needs a documentation patch if there isn't yet.
>
> currently there is no libc interface contract in place that
> says which calls may use libc internal fds e.g. i've seen
>
>   openlog(...) // opens libc internal syslog fd
>   ...
>   fork()
>   closefrom(...) // close syslog fd
>   open(...) // something that reuses the closed fd
>   syslog(...) // unsafe: uses the wrong fd
>   execve(...)
>
> syslog uses a libc internal fd that the user trampled on and
> this can go bad in many ways depending on what libc apis are
> used between closefrom (or equivalent) and exec.
>

Documentation is good. :-) I think you'll find that while this example
seems to be innocuous on FreeBSD (and likely other *BSD), this is an
atypical scenario and generally not advised.  You would usually not
start closing until you're actually ready to exec/fail.

> > The code snippet above is one way of working around the problem that file
> > descriptors are not cloexec by default. This is aggravated by the fact that
> > we can't just switch them over without massively regressing userspace. For
>
> why is a switch_to_cloexec_range worse than close_range?
> the former seems safer to me. (and allows libc calls
> to be made between such switch and exec: libc internal
> fds have to be cloexec anyway)
>

I wouldn't say it's worse, but it only solves half the problem. While
closefrom -> exec is the most common usage by a long shot, there are
also times (e.g. post-fork without intent to exec for a daemon/service
type) that you want to go ahead and close everything except maybe a
pipe fd that you've opened for IPC. While uncommon, there's no reason
this needs to devolve into a loop to close 'all the fds' when you can
instead introduce close_range to solve both the exec case and other
less common scenarios.

> > a whole class of programs having an in-kernel method of closing all file
> > descriptors is very helpful (e.g. demons, service managers, programming
> > language standard libraries, container managers etc.).
> > (Please note, unshare(CLONE_FILES) should only be needed if the calling
> > task is multi-threaded and shares the file descriptor table with another
> > thread in which case two threads could race with one thread allocating file
> > descriptors and the other one closing them via close_range(). For the
> > general case close_range() before the execve() is sufficient.)
> >
> > Second, it allows userspace to avoid implementing closing all file
> > descriptors by parsing through /proc/<pid>/fd/* and calling close() on each
> > file descriptor. From looking at various large(ish) userspace code bases
> > this or similar patterns are very common in:
> > - service managers (cf. [4])
> > - libcs (cf. [6])
> > - container runtimes (cf. [5])
> > - programming language runtimes/standard libraries
> >   - Python (cf. [2])
> >   - Rust (cf. [7], [8])
> > As Dmitry pointed out there's even a long-standing glibc bug about missing
> > kernel support for this task (cf. [3]).
> > In addition, the syscall will also work for tasks that do not have procfs
> > mounted and on kernels that do not have procfs support compiled in. In such
> > situations the only way to make sure that all file descriptors are closed
> > is to call close() on each file descriptor up to UINT_MAX or RLIMIT_NOFILE,
> > OPEN_MAX trickery (cf. comment [8] on Rust).
>
> close_range still seems like a bad operation to expose.
>
> if users really want closing behaviour (instead of marking
> fds cloexec) then they likely need coordination with libc
> and other libraries.
>
> e.g. this usage does not work:
>
>   maxfd = findmaxfd();
>   call_that_may_leak_fds();
>   close_range(maxfd,~0U);
>
> as far as i can tell only the close right before exec works.

I don't have much to say on this one, except that's also an unusual
case. I don't know that I'd anticipate close_range getting used for
that kind of cleanup job (I've never seen a similar use of closefrom),
which seems to just be papering over application/library bugs.

Coordination with libc is generally not much of an issue, because this
is really one of the last things you do before exec() or swiftly
failing miserably. Applications that currently loop over all fd <=
maxfd and close(fd) right now are subject to the very same
constraints, this is just a much more efficient way and
debugger-friendly way to accomplish it. You've absolutely not lived
life until you've had to watch thousands of close() calls painfully
scroll by in truss/strace.

Thank,

Kyle Evans
