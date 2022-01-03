Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F774836FE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 19:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiACSgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 13:36:14 -0500
Received: from drummond.us ([74.95.14.229]:40377 "EHLO
        talisker.home.drummond.us" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231354AbiACSgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:36:08 -0500
X-Greylist: delayed 829 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jan 2022 13:35:51 EST
Received: from talisker.home.drummond.us (localhost [127.0.0.1])
        by talisker.home.drummond.us (8.15.2/8.15.2/Debian-20) with ESMTP id 203IKUrZ983478;
        Mon, 3 Jan 2022 10:20:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=home.drummond.us;
        s=default; t=1641234030;
        bh=E5fnl6UDJWZKDRpYiS+tfaqNC1+q8ROkLPZx/9dIiQE=;
        h=From:To:Cc:Subject:Date:From;
        b=zXbbImMEGQ9pUpv1DxfY2XmQttregvHgLm+qsl9EG8U8kPMhSbyKD5DQ25UYOdRzo
         BfoL/P72aybwUNV/dOsh0KUrU+F+6X19Cgfu7MENmFok86fj7YBUHIKHTe6B3r/2l0
         iFHFBcYB/awOvzTkhHjnaPiTR52hfe6PHcBRzY7m0xTugBKuJxGGgsr0nguKo8yqGW
         0VW8sn37JwEbBrD9p0qZEb9YsC8UbN/YcXTbNbKSZNHo8cvcUPBLwqbV6LWX9tWvlN
         QEeMhR0gHOFTcJtLQUs5HTxDDyu0MNDZscXnTgsu1kqViQK/ikejaInqcv0AX04Too
         CMrZIYqUTCwPQ==
Received: (from walt@localhost)
        by talisker.home.drummond.us (8.15.2/8.15.2/Submit) id 203IKMj7983477;
        Mon, 3 Jan 2022 10:20:22 -0800
From:   Walt Drummond <walt@drummond.us>
To:     aacraid@microsemi.com, viro@zeniv.linux.org.uk,
        anna.schumaker@netapp.com, arnd@arndb.de, bsegall@google.com,
        bp@alien8.de, chuck.lever@oracle.com, bristot@redhat.com,
        dave.hansen@linux.intel.com, dwmw2@infradead.org,
        dietmar.eggemann@arm.com, dinguyen@kernel.org,
        geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        idryomov@gmail.com, mingo@redhat.com, yzaikin@google.com,
        ink@jurassic.park.msu.ru, jejb@linux.ibm.com, jmorris@namei.org,
        bfields@fieldses.org, jlayton@kernel.org, jirislaby@kernel.org,
        john.johansen@canonical.com, juri.lelli@redhat.com,
        keescook@chromium.org, mcgrof@kernel.org,
        martin.petersen@oracle.com, mattst88@gmail.com, mgorman@suse.de,
        oleg@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        rth@twiddle.net, richard@nod.at, serge@hallyn.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        trond.myklebust@hammerspace.com, vincent.guittot@linaro.org,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Walt Drummond <walt@drummond.us>,
        ceph-devel@vger.kernel.org, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [RFC PATCH 0/8] signals: Support more than 64 signals
Date:   Mon,  3 Jan 2022 10:19:48 -0800
Message-Id: <20220103181956.983342-1-walt@drummond.us>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch set expands the number of signals in Linux beyond the
current cap of 64.  It sets a new cap at the somewhat arbitrary limit
of 1024 signals, both because it’s what GLibc and MUSL support and
because many architectures pad sigset_t or ucontext_t in the kernel to
this cap.  This limit is not fixed and can be further expanded within
reason.

Despite best efforts, there is some non-zero potential that this could
break user space; I'd appreciate any comments, review and/or pointers
to areas of concern.

Basically, these changes entail:

 - Make all system calls that accept sigset_t honor the existing
   sigsetsize parameter for values between 8 and 128, and to return
   sigsetsize bytes to user space.

 - Add AT_SIGSET_SZ to the aux vector to signal to user space the
   maximum size sigset_t the kernel can accept.

 - Remove the sigmask() macro except in compatibility cases, change
   the sigaddset()/sigdelset()/etc. to accept a comma separated list
   of signal numbers.

 - Change the _NSIG_WORDS calculation to round up when needed on
   generic and x86.

 - Place the complete sigmask in the real time signal frame (x86_64,
   x32 and ia32).

 - Various fixes where sigset_t size is assumed.

 - Add BSD SIGINFO (and VSTATUS) as a test.

The changes that have the most risk of breaking user space are the
ones that put more than 8 bytes of sigset_t in the real time signal
stack frame (Patches 2 & 6), and I should note that an earlier and
incomplete version of patch 2 was NAK’ed by Al in
https://lore.kernel.org/lkml/20201119221132.1515696-1-walt@drummond.us/.

As far as I have been able to determine this patchset, and
specifically changing the size of sigset_t, does not break user space.

The two uses of sigset_t that pose the most user space risk are 1) as
a member of ucontext_t passed as a parameter to the signal handler and
2) when user space performs manual inspection of the real-time signal
stack frame.

In case (1), user space has definitions of both siget_t and ucontext_t
that are independent of, and may differ from, the kernel (eg, sigset_t
in uclibc-ng is 16 bytes, musl is 128 bytes, glibc is 128 bytes on all
architectures except Arc, etc.).  User space will interpret the data
on the signal stack through these definitions, and extensions to
sigset_t will be opaque.  Other non-C runtimes are similarly
independent from kernel sigset_t and ucontext_t and derive their
definition of sigset_t from libc either directly or indirectly, and do
not manually inspect the signal stack (specifically OpenJDK, Golang,
Python3, Rust and Perl).

The only instances I found of case (2), manually inspecting the signal
stack frame, are in stack unwinders/backtracers (GDB, GCC, libunwind)
and in GDB when recording program execution, and only on the i386,
x86_64, s390 and powerpc architectures.  The GDB, GCC and libunwind
behave consistently with and without this patchset.

GDB's execution recording is somewhat more complicated.  It uses
internally defined architecture specific constants to represent the
total size of the signal frame, and will save that entire frame for
later use.  I cannot confirm that the values for powerpc and s390 are
correct, but for this purpose it doesn't matter as these architectures
explicitly pad for an expanded uc_sigmask.  I can, however, confirm
that the values for i386 and x86_64 are not correct, and that GDB is
recording an incorrect amount of stack data.  This doesn’t appear to
be an issue; while I cannot build a test case on x86_64 due to a known
bug[1], a basic test on i386 shows that the stack is correctly being
recorded, and forward and reverse replay seems to work just fine
across signal handlers.

There are other cases to consider if the number of signals and
therefore the size of sigset_t changes:

Impact on struct rt_sigframe member elements

  The placement of ucontext_t in struct rt_sigframe has the potential
  to move following member elements in ways that could break user
  space if user space relied on the offsets of these elements.
  However a review shows that any elements in rt_sigframe after
  ucontext_t.uc_sigmask are either (1) unused or only used by the
  kernel or (2) fall into the x86_64/i386 floating point state case
  above.

Kernel has new signals, user space does not

  Any new bits in ucontext.uc_sigmask placed on the signal stack are
  opaque to user space (except in cases where user space already has a
  larger sigset_t, as in glibc).

  There are no changes to the real-time signals system call semantics,
  as the kernel will honor the hard-coded sigsetsize value of 8 in
  libc and behave as it has before these changes.

  Signal numbers larger than 64 cannot be blocked or caught until user
  space is updated, however their default action will work as
  expected.  This can cause one problem: a parent process that uses
  the signal number a child exited with as an index into an array
  without bounds checking can cause a crash.  I’ve seen exactly one
  instance of this in tcsh, and is, I think, a bug in tcsh.

User space has new signals, kernel does not

  User space attempting to use a signal number not supported by the
  kernel in system calls (eg, sigaction()) or other libc functions (eg,
  sigaddset()) will result in EINVAL, as expected.

  User space needs to know how to set the sigsetsize parameter to the
  real time signal system calls and it can use getauxval(AT_SIGSET_SZ)
  to determine this.  If it returns zero the sigsetsize must be 8,
  otherwise the kernel will accept sigsetsize between 8 and the return
  value.

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=23188

Walt Drummond (8):
  signals: Make the real-time signal system calls accept different sized
    sigset_t from user space.
  signals: Put the full signal mask on the signal stack for x86_64, X32
    and ia32 compatibility mode
  signals: Use a helper function to test if a signal is a real-time
    signal.
  signals: Remove sigmask() macro
  signals: Better support cases where _NSIG_WORDS is greater than 2
  signals: Round up _NSIG_WORDS
  signals: Add signal debugging
  signals: Support BSD VSTATUS, KERNINFO and SIGINFO

 arch/alpha/kernel/signal.c          |   4 +-
 arch/m68k/include/asm/signal.h      |   6 +-
 arch/nios2/kernel/signal.c          |   2 -
 arch/x86/ia32/ia32_signal.c         |   5 +-
 arch/x86/include/asm/sighandling.h  |  34 +++
 arch/x86/include/asm/signal.h       |  10 +-
 arch/x86/include/uapi/asm/signal.h  |   4 +-
 arch/x86/kernel/signal.c            |  11 +-
 drivers/scsi/dpti.h                 |   2 -
 drivers/tty/Makefile                |   2 +-
 drivers/tty/n_tty.c                 |  21 ++
 drivers/tty/tty_io.c                |  10 +-
 drivers/tty/tty_ioctl.c             |   4 +
 drivers/tty/tty_status.c            | 135 ++++++++++
 fs/binfmt_elf.c                     |   1 +
 fs/binfmt_elf_fdpic.c               |   1 +
 fs/ceph/addr.c                      |   2 +-
 fs/jffs2/background.c               |   2 +-
 fs/lockd/svc.c                      |   1 -
 fs/proc/array.c                     |  32 +--
 fs/proc/base.c                      |  48 ++++
 fs/signalfd.c                       |  26 +-
 include/asm-generic/termios.h       |   4 +-
 include/linux/compat.h              |  98 ++++++-
 include/linux/sched.h               |  52 +++-
 include/linux/signal.h              | 389 ++++++++++++++++++++--------
 include/linux/tty.h                 |   8 +
 include/uapi/asm-generic/ioctls.h   |   2 +
 include/uapi/asm-generic/signal.h   |   8 +-
 include/uapi/asm-generic/termbits.h |  34 +--
 include/uapi/linux/auxvec.h         |   1 +
 kernel/compat.c                     |  30 +--
 kernel/fork.c                       |   2 +-
 kernel/ptrace.c                     |  18 +-
 kernel/signal.c                     | 288 ++++++++++----------
 kernel/sysctl.c                     |  41 +++
 kernel/time/posix-timers.c          |   3 +-
 lib/Kconfig.debug                   |  10 +
 security/apparmor/ipc.c             |   4 +-
 virt/kvm/kvm_main.c                 |  18 +-
 40 files changed, 974 insertions(+), 399 deletions(-)
 create mode 100644 drivers/tty/tty_status.c

-- 
2.30.2

