Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437FB1EFC11
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 17:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgFEPBd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 11:01:33 -0400
Received: from port70.net ([81.7.13.123]:60728 "EHLO port70.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgFEPBc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:01:32 -0400
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jun 2020 11:01:31 EDT
Received: by port70.net (Postfix, from userid 1002)
        id 66D71ABEC0C2; Fri,  5 Jun 2020 16:55:50 +0200 (CEST)
Date:   Fri, 5 Jun 2020 16:55:49 +0200
From:   Szabolcs Nagy <nsz@port70.net>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        Kyle Evans <self@kyle-evans.net>,
        Victor Stinner <victor.stinner@gmail.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, fweimer@redhat.com, jannh@google.com,
        oleg@redhat.com, arnd@arndb.de, shuah@kernel.org,
        dhowells@redhat.com, ldv@altlinux.org
Subject: Re: [PATCH v5 1/3] open: add close_range()
Message-ID: <20200605145549.GC673948@port70.net>
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
 <20200602204219.186620-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602204219.186620-2-christian.brauner@ubuntu.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Christian Brauner <christian.brauner@ubuntu.com> [2020-06-02 22:42:17 +0200]:
> This adds the close_range() syscall. It allows to efficiently close a range
> of file descriptors up to all file descriptors of a calling task.
> 
> I've also coordinated with some FreeBSD developers who got in touch with
> me (Cced below). FreeBSD intends to add the same syscall once we merged it.
> Quite a bunch of projects in userspace are waiting on this syscall
> including Python and systemd.
> 
> The syscall came up in a recent discussion around the new mount API and
> making new file descriptor types cloexec by default. During this
> discussion, Al suggested the close_range() syscall (cf. [1]). Note, a
> syscall in this manner has been requested by various people over time.
> 
> First, it helps to close all file descriptors of an exec()ing task. This
> can be done safely via (quoting Al's example from [1] verbatim):
> 
>         /* that exec is sensitive */
>         unshare(CLONE_FILES);
>         /* we don't want anything past stderr here */
>         close_range(3, ~0U);
>         execve(....);

this api needs a documentation patch if there isn't yet.

currently there is no libc interface contract in place that
says which calls may use libc internal fds e.g. i've seen

  openlog(...) // opens libc internal syslog fd
  ...
  fork()
  closefrom(...) // close syslog fd
  open(...) // something that reuses the closed fd
  syslog(...) // unsafe: uses the wrong fd
  execve(...)

syslog uses a libc internal fd that the user trampled on and
this can go bad in many ways depending on what libc apis are
used between closefrom (or equivalent) and exec.

> The code snippet above is one way of working around the problem that file
> descriptors are not cloexec by default. This is aggravated by the fact that
> we can't just switch them over without massively regressing userspace. For

why is a switch_to_cloexec_range worse than close_range?
the former seems safer to me. (and allows libc calls
to be made between such switch and exec: libc internal
fds have to be cloexec anyway)

> a whole class of programs having an in-kernel method of closing all file
> descriptors is very helpful (e.g. demons, service managers, programming
> language standard libraries, container managers etc.).
> (Please note, unshare(CLONE_FILES) should only be needed if the calling
> task is multi-threaded and shares the file descriptor table with another
> thread in which case two threads could race with one thread allocating file
> descriptors and the other one closing them via close_range(). For the
> general case close_range() before the execve() is sufficient.)
> 
> Second, it allows userspace to avoid implementing closing all file
> descriptors by parsing through /proc/<pid>/fd/* and calling close() on each
> file descriptor. From looking at various large(ish) userspace code bases
> this or similar patterns are very common in:
> - service managers (cf. [4])
> - libcs (cf. [6])
> - container runtimes (cf. [5])
> - programming language runtimes/standard libraries
>   - Python (cf. [2])
>   - Rust (cf. [7], [8])
> As Dmitry pointed out there's even a long-standing glibc bug about missing
> kernel support for this task (cf. [3]).
> In addition, the syscall will also work for tasks that do not have procfs
> mounted and on kernels that do not have procfs support compiled in. In such
> situations the only way to make sure that all file descriptors are closed
> is to call close() on each file descriptor up to UINT_MAX or RLIMIT_NOFILE,
> OPEN_MAX trickery (cf. comment [8] on Rust).

close_range still seems like a bad operation to expose.

if users really want closing behaviour (instead of marking
fds cloexec) then they likely need coordination with libc
and other libraries.

e.g. this usage does not work:

  maxfd = findmaxfd();
  call_that_may_leak_fds();
  close_range(maxfd,~0U);

as far as i can tell only the close right before exec works.
