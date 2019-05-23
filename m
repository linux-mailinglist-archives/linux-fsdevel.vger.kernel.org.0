Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C09228388
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbfEWQ1q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:27:46 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:35982 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731192AbfEWQ1q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:27:46 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 21C5B2E14C7;
        Thu, 23 May 2019 19:22:21 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 0DFFaAm6RR-MIkOLjMb;
        Thu, 23 May 2019 19:22:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1558628541; bh=uno7Tkm+J4CAMiQ/ZqUGJguv/8erTBXtf0FT8zsjtio=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=k3zVPs4kQWtPQALu2u9BzlP4FyuzjC8jraY16YYgbhRJcd5Z61zALp+w+i+4KbG4f
         SKZL9+W3jMAoId0+8RI71yDUsbAZ0QuVU2McbP2O7VfpoTNtH6xcWXwnMZIE5s08Op
         pTTPy5lehJcSC2JRzNucne+6X4MGSlOtZqYtoJDk=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:e47f:4b1d:b053:2762])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id ZuU1s6qKwt-MH8aDH8P;
        Thu, 23 May 2019 19:22:18 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH v1 1/2] open: add close_range()
To:     Christian Brauner <christian@brauner.io>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, torvalds@linux-foundation.org,
        fweimer@redhat.com
Cc:     jannh@google.com, oleg@redhat.com, tglx@linutronix.de,
        arnd@arndb.de, shuah@kernel.org, dhowells@redhat.com,
        tkjos@android.com, ldv@altlinux.org, miklos@szeredi.hu,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org
References: <20190522155259.11174-1-christian@brauner.io>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <67e4458a-9cc4-d1aa-608c-73ebe9e2f7a3@yandex-team.ru>
Date:   Thu, 23 May 2019 19:22:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522155259.11174-1-christian@brauner.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22.05.2019 18:52, Christian Brauner wrote:> This adds the close_range() syscall. It allows to efficiently close a range
 > of file descriptors up to all file descriptors of a calling task.
 >
 > The syscall came up in a recent discussion around the new mount API and
 > making new file descriptor types cloexec by default. During this
 > discussion, Al suggested the close_range() syscall (cf. [1]). Note, a
 > syscall in this manner has been requested by various people over time.
 >
 > First, it helps to close all file descriptors of an exec()ing task. This
 > can be done safely via (quoting Al's example from [1] verbatim):
 >
 >          /* that exec is sensitive */
 >          unshare(CLONE_FILES);
 >          /* we don't want anything past stderr here */
 >          close_range(3, ~0U);
 >          execve(....);
 >
 > The code snippet above is one way of working around the problem that file
 > descriptors are not cloexec by default. This is aggravated by the fact that
 > we can't just switch them over without massively regressing userspace. For
 > a whole class of programs having an in-kernel method of closing all file
 > descriptors is very helpful (e.g. demons, service managers, programming
 > language standard libraries, container managers etc.).
 > (Please note, unshare(CLONE_FILES) should only be needed if the calling
 >   task is multi-threaded and shares the file descriptor table with another
 >   thread in which case two threads could race with one thread allocating
 >   file descriptors and the other one closing them via close_range(). For the
 >   general case close_range() before the execve() is sufficient.)
 >
 > Second, it allows userspace to avoid implementing closing all file
 > descriptors by parsing through /proc/<pid>/fd/* and calling close() on each
 > file descriptor. From looking at various large(ish) userspace code bases
 > this or similar patterns are very common in:
 > - service managers (cf. [4])
 > - libcs (cf. [6])
 > - container runtimes (cf. [5])
 > - programming language runtimes/standard libraries
 >    - Python (cf. [2])
 >    - Rust (cf. [7], [8])
 > As Dmitry pointed out there's even a long-standing glibc bug about missing
 > kernel support for this task (cf. [3]).
 > In addition, the syscall will also work for tasks that do not have procfs
 > mounted and on kernels that do not have procfs support compiled in. In such
 > situations the only way to make sure that all file descriptors are closed
 > is to call close() on each file descriptor up to UINT_MAX or RLIMIT_NOFILE,
 > OPEN_MAX trickery (cf. comment [8] on Rust).
 >
 > The performance is striking. For good measure, comparing the following
 > simple close_all_fds() userspace implementation that is essentially just
 > glibc's version in [6]:
 >
 > static int close_all_fds(void)
 > {
 >          int dir_fd;
 >          DIR *dir;
 >          struct dirent *direntp;
 >
 >          dir = opendir("/proc/self/fd");
 >          if (!dir)
 >                  return -1;
 >          dir_fd = dirfd(dir);
 >          while ((direntp = readdir(dir))) {
 >                  int fd;
 >                  if (strcmp(direntp->d_name, ".") == 0)
 >                          continue;
 >                  if (strcmp(direntp->d_name, "..") == 0)
 >                          continue;
 >                  fd = atoi(direntp->d_name);
 >                  if (fd == dir_fd || fd == 0 || fd == 1 || fd == 2)
 >                          continue;
 >                  close(fd);
 >          }
 >          closedir(dir);
 >          return 0;
 > }
 >
 > to close_range() yields:
 > 1. closing 4 open files:
 >     - close_all_fds(): ~280 us
 >     - close_range():    ~24 us
 >
 > 2. closing 1000 open files:
 >     - close_all_fds(): ~5000 us
 >     - close_range():   ~800 us
 >
 > close_range() is designed to allow for some flexibility. Specifically, it
 > does not simply always close all open file descriptors of a task. Instead,
 > callers can specify an upper bound.
 > This is e.g. useful for scenarios where specific file descriptors are
 > created with well-known numbers that are supposed to be excluded from
 > getting closed.
 > For extra paranoia close_range() comes with a flags argument. This can e.g.
 > be used to implement extension. Once can imagine userspace wanting to stop
 > at the first error instead of ignoring errors under certain circumstances.

 > There might be other valid ideas in the future. In any case, a flag
 > argument doesn't hurt and keeps us on the safe side.

Here is another strange but real-live scenario: crash handler for dumping core.

If applications has network connections it would be better to close them all,
otherwise clients will wait until end of dumping process or timeout.
Also closing normal files might be a good idea for releasing locks.

But simple closing might race with other threads - closed fd will be reused
while some code still thinks it refers to original file.

Our solution closes files without freeing fd: it opens /dev/null and
replaces all opened descriptors using dup2.

So, special flag for close_range() could close files without clearing bitmap.
Effect should be the same - fd wouldn't be reused.

Actually two flags for two phases: closing files and releasing fd.

 >
 >  From an implementation side this is kept rather dumb. It saw some input
 > from David and Jann but all nonsense is obviously my own!
 > - Errors to close file descriptors are currently ignored. (Could be changed
 >    by setting a flag in the future if needed.)
 > - __close_range() is a rather simplistic wrapper around __close_fd().
 >    My reasoning behind this is based on the nature of how __close_fd() needs
 >    to release an fd. But maybe I misunderstood specifics:
 >    We take the files_lock and rcu-dereference the fdtable of the calling
 >    task, we find the entry in the fdtable, get the file and need to release
 >    files_lock before calling filp_close().
 >    In the meantime the fdtable might have been altered so we can't just
 >    retake the spinlock and keep the old rcu-reference of the fdtable
 >    around. Instead we need to grab a fresh reference to the fdtable.
 >    If my reasoning is correct then there's really no point in fancyfying
 >    __close_range(): We just need to rcu-dereference the fdtable of the
 >    calling task once to cap the max_fd value correctly and then go on
 >    calling __close_fd() in a loop.
 >
 > /* References */
 > [1]: https://lore.kernel.org/lkml/20190516165021.GD17978@ZenIV.linux.org.uk/
 > [2]: https://github.com/python/cpython/blob/9e4f2f3a6b8ee995c365e86d976937c141d867f8/Modules/_posixsubprocess.c#L220
 > [3]: https://sourceware.org/bugzilla/show_bug.cgi?id=10353#c7
 > [4]: https://github.com/systemd/systemd/blob/5238e9575906297608ff802a27e2ff9effa3b338/src/basic/fd-util.c#L217
 > [5]: https://github.com/lxc/lxc/blob/ddf4b77e11a4d08f09b7b9cd13e593f8c047edc5/src/lxc/start.c#L236
 > [6]: 
https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/grantpt.c;h=2030e07fa6e652aac32c775b8c6e005844c3c4eb;hb=HEAD#l17
 >       Note that this is an internal implementation that is not exported.
 >       Currently, libc seems to not provide an exported version of this
 >       because of missing kernel support to do this.
 > [7]: https://github.com/rust-lang/rust/issues/12148
 > [8]: https://github.com/rust-lang/rust/blob/5f47c0613ed4eb46fca3633c1297364c09e5e451/src/libstd/sys/unix/process2.rs#L303-L308
 >       Rust's solution is slightly different but is equally unperformant.
 >       Rust calls getdtablesize() which is a glibc library function that
 >       simply returns the current RLIMIT_NOFILE or OPEN_MAX values. Rust then
 >       goes on to call close() on each fd. That's obviously overkill for most
 >       tasks. Rarely, tasks - especially non-demons - hit RLIMIT_NOFILE or
 >       OPEN_MAX.
 >       Let's be nice and assume an unprivileged user with RLIMIT_NOFILE set
 >       to 1024. Even in this case, there's a very high chance that in the
 >       common case Rust is calling the close() syscall 1021 times pointlessly
 >       if the task just has 0, 1, and 2 open.
 >
 > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
 > Signed-off-by: Christian Brauner <christian@brauner.io>
 > Cc: Arnd Bergmann <arnd@arndb.de>
 > Cc: Jann Horn <jannh@google.com>
 > Cc: David Howells <dhowells@redhat.com>
 > Cc: Dmitry V. Levin <ldv@altlinux.org>
 > Cc: Oleg Nesterov <oleg@redhat.com>
 > Cc: Linus Torvalds <torvalds@linux-foundation.org>
 > Cc: Florian Weimer <fweimer@redhat.com>
 > Cc: linux-api@vger.kernel.org
 > ---
 > v1:
 > - Linus Torvalds <torvalds@linux-foundation.org>:
 >    - add cond_resched() to yield cpu when closing a lot of file descriptors
 > - Al Viro <viro@zeniv.linux.org.uk>:
 >    - add cond_resched() to yield cpu when closing a lot of file descriptors
 > ---
 >   arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
 >   arch/arm/tools/syscall.tbl                  |  1 +
 >   arch/arm64/include/asm/unistd32.h           |  2 +
 >   arch/ia64/kernel/syscalls/syscall.tbl       |  1 +
 >   arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
 >   arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
 >   arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
 >   arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +
 >   arch/mips/kernel/syscalls/syscall_o32.tbl   |  1 +
 >   arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
 >   arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
 >   arch/s390/kernel/syscalls/syscall.tbl       |  1 +
 >   arch/sh/kernel/syscalls/syscall.tbl         |  1 +
 >   arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
 >   arch/x86/entry/syscalls/syscall_32.tbl      |  1 +
 >   arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
 >   arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +
 >   fs/file.c                                   | 63 ++++++++++++++++++---
 >   fs/open.c                                   | 20 +++++++
 >   include/linux/fdtable.h                     |  2 +
 >   include/linux/syscalls.h                    |  2 +
 >   include/uapi/asm-generic/unistd.h           |  4 +-
 >   22 files changed, 100 insertions(+), 9 deletions(-)
 >

It would be better to split arch/ wiring into separate patch for better readability.

