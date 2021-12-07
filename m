Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5B346BED9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 16:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238703AbhLGPNh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 10:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238710AbhLGPN1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:13:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B8EC061D5F;
        Tue,  7 Dec 2021 07:09:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD216B81829;
        Tue,  7 Dec 2021 15:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2A6C341D1;
        Tue,  7 Dec 2021 15:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638889793;
        bh=HbYtx+aEEcvt0gmst2GN0ldNstRzJNvLfaxcpmGqwD8=;
        h=From:To:Cc:Subject:Date:From;
        b=R5dHuuoW37ap/aYKt0Ba/zRU9xMsuWct1xoRlVDlZO2IMfWMeSqTjOn/s3TXH91bM
         Dq/xicUdpHHvgXYhGeqatRILi+DTpcFF9GQ6NtGpAHodLm6HECQd9l9okpL10PIldA
         KWJNeQzFXcK+XRZotSnAgS9MD60v3RKfQVdau3i8TcUiji1pceUp1J5mbIrsS39iJf
         eMvKe1Cg8J5lGrm6Fk9B3RJqBABtHhfhiKaac6GpkaLYePHP1Cm8rhkf0VbdG1tlBe
         f+LXlyXjQNqKvsIJQCK1NgGVLYDDpGHxJVvCtZ/EZiueyEjnoFQko0fzwEEYnvCMI9
         EXkwjO/wxMe9A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, kernelci@groups.io,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [RFC 0/3] headers: start rework to avoid recursive inclusion
Date:   Tue,  7 Dec 2021 16:09:24 +0100
Message-Id: <20211207150927.3042197-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

I've gotten back to a patch series I worked on a while back, to clean
up the way we include headers recursively in the kernel, analysing the
dependency chains and reducing them as much as possible. The most common
issue is headers that need a data structure definition from another
header but shouldn't really pull in the rest of it.

Improving this will help both the compilation speed of single files
(earlier experiments with clang showed a crazy 30% improvement
after reducing the average size of the indirect headers by 90%),
and those people that build a lot of similar kernels, where a
modification in a common header tends to require rebuilding
everything.

These three patches are a first step in the direction of minimizing
the headers needed for defining data structures that embed other
structures. Rather than split up each header into one that only defines
structures, and another one for the rest, this adds more fundamental
types to linux/types.h and introduces a new linux/struct_types.h with
the most commonly embedded structures.

The fs_types.h change in the third patch shows how high-level structure
definitions can then be done with a much smaller set of indirect includes,
using one of the central headers (linux/fs.h) as the example.  The same
would need to be done for other headers that are currently included in
most drivers and that in turn indirectly include hundreds of other headers
(linux/skbuff.h, linux/mm.h, linux/device.h, linux/sched.h, ...).

None of this work actually removes the indirect includes yet, as that
can only be done after each .c file that currently relies on indirect
includes of common headers is changed to include them directly.
The first step toward that however is to come to a rough agreement
on what the structure should be.

Any comments, suggestions, ideas?

       Arnd

Arnd Bergmann (3):
  headers: add more types to linux/types.h
  headers: introduce linux/struct_types.h
  headers: repurpose linux/fs_types.h

 arch/alpha/include/asm/spinlock_types.h       |    2 +-
 arch/arc/include/asm/atomic64-arcv2.h         |    4 -
 arch/arm/include/asm/atomic.h                 |    4 -
 arch/arm/include/asm/spinlock_types.h         |    2 +-
 arch/arm64/include/asm/spinlock_types.h       |    2 +-
 arch/csky/include/asm/spinlock_types.h        |    2 +-
 arch/hexagon/include/asm/spinlock_types.h     |    2 +-
 arch/ia64/include/asm/spinlock_types.h        |    2 +-
 .../include/asm/simple_spinlock_types.h       |    2 +-
 arch/powerpc/include/asm/spinlock_types.h     |    2 +-
 arch/riscv/include/asm/spinlock_types.h       |    2 +-
 arch/s390/include/asm/spinlock_types.h        |    2 +-
 arch/sh/include/asm/spinlock_types.h          |    2 +-
 arch/x86/include/asm/atomic64_32.h            |    4 -
 arch/xtensa/include/asm/spinlock_types.h      |    2 +-
 include/asm-generic/atomic64.h                |    4 -
 include/linux/atomic/atomic-long.h            |    4 +-
 include/linux/bitops.h                        |    6 -
 include/linux/bits.h                          |    6 +
 include/linux/bvec.h                          |   18 -
 include/linux/completion.h                    |   17 -
 include/linux/cpumask.h                       |    3 -
 include/linux/fs.h                            | 1151 +---------------
 include/linux/fs_types.h                      | 1225 ++++++++++++++++-
 include/linux/hrtimer.h                       |   32 -
 include/linux/kobject.h                       |   18 -
 include/linux/kref.h                          |    4 -
 include/linux/ktime.h                         |    3 -
 include/linux/list_bl.h                       |    7 -
 include/linux/list_lru.h                      |   15 -
 include/linux/llist.h                         |    8 -
 include/linux/mmzone.h                        |    3 -
 include/linux/mutex.h                         |   51 -
 include/linux/osq_lock.h                      |    8 -
 include/linux/percpu-rwsem.h                  |   11 -
 include/linux/pid.h                           |    9 -
 include/linux/plist.h                         |   10 -
 include/linux/quota.h                         |   29 -
 include/linux/rcu_sync.h                      |    9 -
 include/linux/rcuwait.h                       |   12 -
 include/linux/refcount.h                      |   12 -
 include/linux/rtmutex.h                       |    8 +-
 include/linux/rwbase_rt.h                     |    5 -
 include/linux/rwlock_types.h                  |   19 -
 include/linux/rwsem.h                         |   40 -
 include/linux/seqlock.h                       |   31 -
 include/linux/spinlock_types.h                |   21 -
 include/linux/spinlock_types_raw.h            |   21 +-
 include/linux/spinlock_types_up.h             |    2 +-
 include/linux/struct_types.h                  |  483 +++++++
 include/linux/swait.h                         |   12 -
 include/linux/time64.h                        |   13 -
 include/linux/timer.h                         |   16 +-
 include/linux/timerqueue.h                    |   12 +-
 include/linux/types.h                         |   90 +-
 include/linux/uidgid.h                        |    9 -
 include/linux/uuid.h                          |    6 -
 include/linux/wait.h                          |   29 -
 include/linux/workqueue.h                     |   27 -
 include/linux/xarray.h                        |   23 -
 60 files changed, 1822 insertions(+), 1756 deletions(-)
 create mode 100644 include/linux/struct_types.h

-- 
2.29.2

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: kernel test robot <lkp@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernelci@groups.io
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev
