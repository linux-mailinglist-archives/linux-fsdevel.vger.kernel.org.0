Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B06B1281B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 17:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbfEWPtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 11:49:13 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54256 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731148AbfEWPtH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 11:49:07 -0400
Received: by mail-it1-f194.google.com with SMTP id m141so10510134ita.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iUGIiC/8hN9HSwNafiW+qyW5PzWYE00hVlkf6MjPapc=;
        b=BcGfqZO+lWSD/N/RVBr054YdDIPgCp3KNO5WW80/uFAOAoXW6LOnn7yFlfNHHUt0kt
         rvvWNlfy2ksHo2YxY59II4HnmbAfnrA7mO9KXke4PK7dXPXdvoB3V7WU2lDVlTx/lI0L
         fW9vckaykc9tBog9qwBBKfkwflMD1Ckk5VnYi0pCnRNIBLuhOtfBHQ8YlcoNloDvpCEr
         +PVXKQFJ3FkE80eNWmP0PF0IktCR085T91adaKZo93i0p0rKb4UuaKVjJFGKr1Ion2Pa
         DyNWMaL7uhGDbHvvMzhzI5Ug6RzznpNulk8yUYv8HLv+2Ry8fDNyKaGR6Ae5vYSFPGoz
         2jeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iUGIiC/8hN9HSwNafiW+qyW5PzWYE00hVlkf6MjPapc=;
        b=KTNY30TrciPGyqRsy5OQOm8cGeNoozT1fIMfutw2IqSgikvCiN6ThQ1E7/7ZL58fUz
         W6Qvr2RRG46UyxaCjo4ZQmeVhlPBV2q8fJn/R8keCjKINk0rodSwRGb8GdLQUwnxYcTZ
         olYgdhcRx4p2Rec6shF8yjXcTbyp+bMr9xaHaxUXkR3XgvdZxkIAqMRfFex8pPVcbB0P
         jHa6nZljaFi5j1bvso7XPx3Yb7kIV18e+VdtEA8A8hpQ9MJc5sl5Jdt94bkREa1M53bu
         H2aONRzUQKb8N654sjKwWd86DQMsPOBsF+9VPOLRiUKHg937ishagpfasQ9Y0J8B4hpa
         cqrA==
X-Gm-Message-State: APjAAAU8V3AkDx31rJPWFgk6SxR8w2C8diEOaUrtT5Gz7qjwmV1rRI7O
        fSZRpBKu9sfuEu/ftcnMOqUdk3nNb5/qZg==
X-Google-Smtp-Source: APXvYqyzROyKPjAtqswUIgOot9jB2x8ariw6Et5Jhqm8gUytrT8gzsKWdZ9DDTrw1Rzk3rpM9JRGog==
X-Received: by 2002:a24:dcc5:: with SMTP id q188mr13802735itg.64.1558626545248;
        Thu, 23 May 2019 08:49:05 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.187])
        by smtp.gmail.com with ESMTPSA id v1sm9124939iob.56.2019.05.23.08.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 08:49:04 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, fweimer@redhat.com
Cc:     jannh@google.com, oleg@redhat.com, tglx@linutronix.de,
        arnd@arndb.de, shuah@kernel.org, dhowells@redhat.com,
        tkjos@android.com, ldv@altlinux.org, miklos@szeredi.hu,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 1/2] open: add close_range()
Date:   Thu, 23 May 2019 17:47:46 +0200
Message-Id: <20190523154747.15162-2-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523154747.15162-1-christian@brauner.io>
References: <20190523154747.15162-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the close_range() syscall. It allows to efficiently close a range
of file descriptors up to all file descriptors of a calling task.

The syscall came up in a recent discussion around the new mount API and
making new file descriptor types cloexec by default. During this
discussion, Al suggested the close_range() syscall (cf. [1]). Note, a
syscall in this manner has been requested by various people over time.

First, it helps to close all file descriptors of an exec()ing task. This
can be done safely via (quoting Al's example from [1] verbatim):

        /* that exec is sensitive */
        unshare(CLONE_FILES);
        /* we don't want anything past stderr here */
        close_range(3, ~0U);
        execve(....);

The code snippet above is one way of working around the problem that file
descriptors are not cloexec by default. This is aggravated by the fact that
we can't just switch them over without massively regressing userspace. For
a whole class of programs having an in-kernel method of closing all file
descriptors is very helpful (e.g. demons, service managers, programming
language standard libraries, container managers etc.).
(Please note, unshare(CLONE_FILES) should only be needed if the calling
 task is multi-threaded and shares the file descriptor table with another
 thread in which case two threads could race with one thread allocating
 file descriptors and the other one closing them via close_range(). For the
 general case close_range() before the execve() is sufficient.)

Second, it allows userspace to avoid implementing closing all file
descriptors by parsing through /proc/<pid>/fd/* and calling close() on each
file descriptor. From looking at various large(ish) userspace code bases
this or similar patterns are very common in:
- service managers (cf. [4])
- libcs (cf. [6])
- container runtimes (cf. [5])
- programming language runtimes/standard libraries
  - Python (cf. [2])
  - Rust (cf. [7], [8])
As Dmitry pointed out there's even a long-standing glibc bug about missing
kernel support for this task (cf. [3]).
In addition, the syscall will also work for tasks that do not have procfs
mounted and on kernels that do not have procfs support compiled in. In such
situations the only way to make sure that all file descriptors are closed
is to call close() on each file descriptor up to UINT_MAX or RLIMIT_NOFILE,
OPEN_MAX trickery (cf. comment [8] on Rust).

The performance is striking. For good measure, comparing the following
simple close_all_fds() userspace implementation that is essentially just
glibc's version in [6]:

static int close_all_fds(void)
{
        int dir_fd;
        DIR *dir;
        struct dirent *direntp;

        dir = opendir("/proc/self/fd");
        if (!dir)
                return -1;
        dir_fd = dirfd(dir);
        while ((direntp = readdir(dir))) {
                int fd;
                if (strcmp(direntp->d_name, ".") == 0)
                        continue;
                if (strcmp(direntp->d_name, "..") == 0)
                        continue;
                fd = atoi(direntp->d_name);
                if (fd == dir_fd || fd == 0 || fd == 1 || fd == 2)
                        continue;
                close(fd);
        }
        closedir(dir);
        return 0;
}

to close_range() yields:
1. closing 4 open files:
   - close_all_fds(): ~280 us
   - close_range():    ~24 us

2. closing 1000 open files:
   - close_all_fds(): ~5000 us
   - close_range():   ~800 us

close_range() is designed to allow for some flexibility. Specifically, it
does not simply always close all open file descriptors of a task. Instead,
callers can specify an upper bound.
This is e.g. useful for scenarios where specific file descriptors are
created with well-known numbers that are supposed to be excluded from
getting closed.
For extra paranoia close_range() comes with a flags argument. This can e.g.
be used to implement extension. Once can imagine userspace wanting to stop
at the first error instead of ignoring errors under certain circumstances.
There might be other valid ideas in the future. In any case, a flag
argument doesn't hurt and keeps us on the safe side.

From an implementation side this is kept rather dumb. It saw some input
from David and Jann but all nonsense is obviously my own!
- Errors to close file descriptors are currently ignored. (Could be changed
  by setting a flag in the future if needed.)
- __close_range() is a rather simplistic wrapper around __close_fd().
  My reasoning behind this is based on the nature of how __close_fd() needs
  to release an fd. But maybe I misunderstood specifics:
  We take the files_lock and rcu-dereference the fdtable of the calling
  task, we find the entry in the fdtable, get the file and need to release
  files_lock before calling filp_close().
  In the meantime the fdtable might have been altered so we can't just
  retake the spinlock and keep the old rcu-reference of the fdtable
  around. Instead we need to grab a fresh reference to the fdtable.
  If my reasoning is correct then there's really no point in fancyfying
  __close_range(): We just need to rcu-dereference the fdtable of the
  calling task once to cap the max_fd value correctly and then go on
  calling __close_fd() in a loop.

/* References */
[1]: https://lore.kernel.org/lkml/20190516165021.GD17978@ZenIV.linux.org.uk/
[2]: https://github.com/python/cpython/blob/9e4f2f3a6b8ee995c365e86d976937c141d867f8/Modules/_posixsubprocess.c#L220
[3]: https://sourceware.org/bugzilla/show_bug.cgi?id=10353#c7
[4]: https://github.com/systemd/systemd/blob/5238e9575906297608ff802a27e2ff9effa3b338/src/basic/fd-util.c#L217
[5]: https://github.com/lxc/lxc/blob/ddf4b77e11a4d08f09b7b9cd13e593f8c047edc5/src/lxc/start.c#L236
[6]: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/grantpt.c;h=2030e07fa6e652aac32c775b8c6e005844c3c4eb;hb=HEAD#l17
     Note that this is an internal implementation that is not exported.
     Currently, libc seems to not provide an exported version of this
     because of missing kernel support to do this.
[7]: https://github.com/rust-lang/rust/issues/12148
[8]: https://github.com/rust-lang/rust/blob/5f47c0613ed4eb46fca3633c1297364c09e5e451/src/libstd/sys/unix/process2.rs#L303-L308
     Rust's solution is slightly different but is equally unperformant.
     Rust calls getdtablesize() which is a glibc library function that
     simply returns the current RLIMIT_NOFILE or OPEN_MAX values. Rust then
     goes on to call close() on each fd. That's obviously overkill for most
     tasks. Rarely, tasks - especially non-demons - hit RLIMIT_NOFILE or
     OPEN_MAX.
     Let's be nice and assume an unprivileged user with RLIMIT_NOFILE set
     to 1024. Even in this case, there's a very high chance that in the
     common case Rust is calling the close() syscall 1021 times pointlessly
     if the task just has 0, 1, and 2 open.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jann Horn <jannh@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Dmitry V. Levin <ldv@altlinux.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: linux-api@vger.kernel.org
---
v1:
- Linus Torvalds <torvalds@linux-foundation.org>:
  - add cond_resched() to yield cpu when closing a lot of file descriptors
- Al Viro <viro@zeniv.linux.org.uk>:
  - add cond_resched() to yield cpu when closing a lot of file descriptors
v2: unchanged
---
 arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
 arch/arm/tools/syscall.tbl                  |  1 +
 arch/arm64/include/asm/unistd32.h           |  2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |  1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
 arch/s390/kernel/syscalls/syscall.tbl       |  1 +
 arch/sh/kernel/syscalls/syscall.tbl         |  1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +
 fs/file.c                                   | 62 ++++++++++++++++++---
 fs/open.c                                   | 20 +++++++
 include/linux/fdtable.h                     |  2 +
 include/linux/syscalls.h                    |  2 +
 include/uapi/asm-generic/unistd.h           |  4 +-
 22 files changed, 99 insertions(+), 9 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 9e7704e44f6d..b55d93af8096 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -473,3 +473,4 @@
 541	common	fsconfig			sys_fsconfig
 542	common	fsmount				sys_fsmount
 543	common	fspick				sys_fspick
+545	common	close_range			sys_close_range
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index aaf479a9e92d..0125c97c75dd 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -447,3 +447,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+435	common	close_range			sys_close_range
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index c39e90600bb3..9a3270d29b42 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -886,6 +886,8 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_close_range 435
+__SYSCALL(__NR_close_range, sys_close_range)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index e01df3f2f80d..1a90b464e96f 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -354,3 +354,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+435	common	close_range			sys_close_range
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 7e3d0734b2f3..2dee2050f9ef 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -433,3 +433,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+435	common	close_range			sys_close_range
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 26339e417695..923ef69e5a76 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -439,3 +439,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+435	common	close_range			sys_close_range
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 0e2dd68ade57..967ed9de51cd 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -372,3 +372,4 @@
 431	n32	fsconfig			sys_fsconfig
 432	n32	fsmount				sys_fsmount
 433	n32	fspick				sys_fspick
+435	n32	close_range			sys_close_range
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 5eebfa0d155c..71de731102b1 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -348,3 +348,4 @@
 431	n64	fsconfig			sys_fsconfig
 432	n64	fsmount				sys_fsmount
 433	n64	fspick				sys_fspick
+435	n64	close_range			sys_close_range
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 3cc1374e02d0..5a325ab29f88 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -421,3 +421,4 @@
 431	o32	fsconfig			sys_fsconfig
 432	o32	fsmount				sys_fsmount
 433	o32	fspick				sys_fspick
+435	o32	close_range			sys_close_range
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index c9e377d59232..dcc0a0879139 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -430,3 +430,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+435	common	close_range			sys_close_range
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 103655d84b4b..ba2c1f078cbd 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -515,3 +515,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+435	common	close_range			sys_close_range
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index e822b2964a83..d7c9043d2902 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -436,3 +436,4 @@
 431  common	fsconfig		sys_fsconfig			sys_fsconfig
 432  common	fsmount			sys_fsmount			sys_fsmount
 433  common	fspick			sys_fspick			sys_fspick
+435  common	close_range		sys_close_range			sys_close_range
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 016a727d4357..9b5e6bf0ce32 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -436,3 +436,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+435	common	close_range			sys_close_range
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index e047480b1605..8c674a1e0072 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -479,3 +479,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+435	common	close_range			sys_close_range
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ad968b7bac72..7f7a89a96707 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -438,3 +438,4 @@
 431	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
 432	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
 433	i386	fspick			sys_fspick			__ia32_sys_fspick
+435	i386	close_range		sys_close_range			__ia32_sys_close_range
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index b4e6f9e6204a..0f7d47ae921c 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,7 @@
 431	common	fsconfig		__x64_sys_fsconfig
 432	common	fsmount			__x64_sys_fsmount
 433	common	fspick			__x64_sys_fspick
+435	common	close_range		__x64_sys_close_range
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 5fa0ee1c8e00..b489532265d0 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -404,3 +404,4 @@
 431	common	fsconfig			sys_fsconfig
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
+435	common	close_range			sys_close_range
diff --git a/fs/file.c b/fs/file.c
index 3da91a112bab..53430d68bbd7 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -10,6 +10,7 @@
 #include <linux/syscalls.h>
 #include <linux/export.h>
 #include <linux/fs.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
@@ -615,12 +616,9 @@ void fd_install(unsigned int fd, struct file *file)
 
 EXPORT_SYMBOL(fd_install);
 
-/*
- * The same warnings as for __alloc_fd()/__fd_install() apply here...
- */
-int __close_fd(struct files_struct *files, unsigned fd)
+static struct file *pick_file(struct files_struct *files, unsigned fd)
 {
-	struct file *file;
+	struct file *file = NULL;
 	struct fdtable *fdt;
 
 	spin_lock(&files->file_lock);
@@ -632,15 +630,63 @@ int __close_fd(struct files_struct *files, unsigned fd)
 		goto out_unlock;
 	rcu_assign_pointer(fdt->fd[fd], NULL);
 	__put_unused_fd(files, fd);
-	spin_unlock(&files->file_lock);
-	return filp_close(file, files);
 
 out_unlock:
 	spin_unlock(&files->file_lock);
-	return -EBADF;
+	return file;
+}
+
+/*
+ * The same warnings as for __alloc_fd()/__fd_install() apply here...
+ */
+int __close_fd(struct files_struct *files, unsigned fd)
+{
+	struct file *file;
+
+	file = pick_file(files, fd);
+	if (!file)
+		return -EBADF;
+
+	return filp_close(file, files);
 }
 EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
 
+/**
+ * __close_range() - Close all file descriptors in a given range.
+ *
+ * @fd:     starting file descriptor to close
+ * @max_fd: last file descriptor to close
+ *
+ * This closes a range of file descriptors. All file descriptors
+ * from @fd up to and including @max_fd are closed.
+ */
+int __close_range(struct files_struct *files, unsigned fd, unsigned max_fd)
+{
+	unsigned int cur_max;
+
+	if (fd > max_fd)
+		return -EINVAL;
+
+	rcu_read_lock();
+	cur_max = files_fdtable(files)->max_fds;
+	rcu_read_unlock();
+
+	/* cap to last valid index into fdtable */
+	max_fd = max(max_fd, (cur_max - 1));
+	while (fd <= max_fd) {
+		struct file *file;
+
+		file = pick_file(files, fd++);
+		if (!file)
+			continue;
+
+		filp_close(file, files);
+		cond_resched();
+	}
+
+	return 0;
+}
+
 /*
  * variant of __close_fd that gets a ref on the file for later fput
  */
diff --git a/fs/open.c b/fs/open.c
index 9c7d724a6f67..c7baaee7aa47 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1174,6 +1174,26 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
 	return retval;
 }
 
+/**
+ * close_range() - Close all file descriptors in a given range.
+ *
+ * @fd:     starting file descriptor to close
+ * @max_fd: last file descriptor to close
+ * @flags:  reserved for future extensions
+ *
+ * This closes a range of file descriptors. All file descriptors
+ * from @fd up to and including @max_fd are closed.
+ * Currently, errors to close a given file descriptor are ignored.
+ */
+SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
+		unsigned int, flags)
+{
+	if (flags)
+		return -EINVAL;
+
+	return __close_range(current->files, fd, max_fd);
+}
+
 /*
  * This routine simulates a hangup on the tty, to arrange that users
  * are given clean terminals at login time.
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index f07c55ea0c22..fcd07181a365 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -121,6 +121,8 @@ extern void __fd_install(struct files_struct *files,
 		      unsigned int fd, struct file *file);
 extern int __close_fd(struct files_struct *files,
 		      unsigned int fd);
+extern int __close_range(struct files_struct *files, unsigned int fd,
+			 unsigned int max_fd);
 extern int __close_fd_get_file(unsigned int fd, struct file **res);
 
 extern struct kmem_cache *files_cachep;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e2870fe1be5b..c0189e223255 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -441,6 +441,8 @@ asmlinkage long sys_fchown(unsigned int fd, uid_t user, gid_t group);
 asmlinkage long sys_openat(int dfd, const char __user *filename, int flags,
 			   umode_t mode);
 asmlinkage long sys_close(unsigned int fd);
+asmlinkage long sys_close_range(unsigned int fd, unsigned int max_fd,
+				unsigned int flags);
 asmlinkage long sys_vhangup(void);
 
 /* fs/pipe.c */
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a87904daf103..3f36c8745d24 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -844,9 +844,11 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_close_range 435
+__SYSCALL(__NR_close_range, sys_close_range)
 
 #undef __NR_syscalls
-#define __NR_syscalls 434
+#define __NR_syscalls 436
 
 /*
  * 32 bit systems traditionally used different
-- 
2.21.0

