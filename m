Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF0B12A7F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 13:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfLYM6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 07:58:15 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:58656 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfLYM6P (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 07:58:15 -0500
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Dec 2019 07:58:11 EST
Received: from localhost.localdomain (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id 4513EC61B02;
        Wed, 25 Dec 2019 12:52:49 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v6 00/10] proc: modernize proc to support multiple private instances
Date:   Wed, 25 Dec 2019 13:51:41 +0100
Message-Id: <20191225125151.1950142-1-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Alex Gladkov <gladkov.alexey@gmail.com>

Greetings!

Preface:
--------
This is RFC v6 to modernize procfs and make it able to support multiple
private instances per the same pid namespace.

RFC v1 is here:
https://lkml.org/lkml/2017/3/30/670

RFC v2 is here:
https://lkml.org/lkml/2017/4/25/282

RFC v5 is here:
https://lkml.org/lkml/2018/5/11/155

This RFC v6 can be applied on top of v5.4-rc7-49-g0e3f1ad80fc8


Procfs modernization:
---------------------
Historically procfs was always tied to pid namespaces, during pid
namespace creation we internally create a procfs mount for it. However,
this has the effect that all new procfs mounts are just a mirror of the
internal one, any change, any mount option update, any new future
introduction will propagate to all other procfs mounts that are in the
same pid namespace.

This may have solved several use cases in that time. However today we
face new requirements, and making procfs able to support new private
instances inside same pid namespace seems a major point. If we want to
to introduce new features and security mechanisms we have to make sure
first that we do not break existing usecases. Supporting private procfs
instances will allow to support new features and behaviour without
propagating it to all other procfs mounts.

Today procfs is more of a burden especially to some Embedded, IoT,
sandbox, container use cases. In user space we are over-mounting null
or inaccessible files on top to hide files and information. If we want
to hide pids we have to create PID namespaces otherwise mount options
propagate to all other proc mounts, changing a mount option value in one
mount will propagate to all other proc mounts. If we want to introduce
new features, then they will propagate to all other mounts too, resulting
either maybe new useful functionality or maybe breaking stuff. We have
also to note that userspace should not workaround procfs, the kernel
should just provide a sane simple interface.

In this regard several developers and maintainers pointed out that
there are problems with procfs and it has to be modernized:

"Here's another one: split up and modernize /proc." by Andy Lutomirski [1]

Discussion about kernel pointer leaks:

"And yes, as Kees and Daniel mentioned, it's definitely not just dmesg.
In fact, the primary things tend to be /proc and /sys, not dmesg
itself." By Linus Torvalds [2]

Lot of other areas in the kernel and filesystems have been updated to be
able to support private instances, devpts is one major example [3].

Which will be used for:

1) Embedded systems and IoT: usually we have one supervisor for
apps, we have some lightweight sandbox support, however if we create
pid namespaces we have to manage all the processes inside too,
where our goal is to be able to run a bunch of apps each one inside
its own mount namespace, maybe use network namespaces for vlans
setups, but right now we only want mount namespaces, without all the
other complexity. We want procfs to behave more like a real file system,
and block access to inodes that belong to other users. The 'hidepid=' will
not work since it is a shared mount option.

2) Containers, sandboxes and Private instances of file systems - devpts case
Historically, lot of file systems inside Linux kernel view when instantiated
were just a mirror of an already created and mounted filesystem. This was the
case of devpts filesystem, it seems at that time the requirements were to
optimize things and reuse the same memory, etc. This design used to work but not
anymore with today's containers, IoT, hostile environments and all the privacy
challenges that Linux faces.

In that regards, devpts was updated so that each new mounts is a total
independent file system by the following patches:

"devpts: Make each mount of devpts an independent filesystem" by
Eric W. Biederman [3] [4]

3) Linux Security Modules have multiple ptrace paths inside some
subsystems, however inside procfs, the implementation does not guarantee
that the ptrace() check which triggers the security_ptrace_check() hook
will always run. We have the 'hidepid' mount option that can be used to
force the ptrace_may_access() check inside has_pid_permissions() to run.
The problem is that 'hidepid' is per pid namespace and not attached to
the mount point, any remount or modification of 'hidepid' will propagate
to all other procfs mounts.

This also does not allow to support Yama LSM easily in desktop and user
sessions. Yama ptrace scope which restricts ptrace and some other
syscalls to be allowed only on inferiors, can be updated to have a
per-task context, where the context will be inherited during fork(),
clone() and preserved across execve(). If we support multiple private
procfs instances, then we may force the ptrace_may_access() on
/proc/<pids>/ to always run inside that new procfs instances. This will
allow to specifiy on user sessions if we should populate procfs with
pids that the user can ptrace or not.

By using Yama ptrace scope, some restricted users will only be able to see
inferiors inside /proc, they won't even be able to see their other
processes. Some software like Chromium, Firefox's crash handler, Wine
and others are already using Yama to restrict which processes can be
ptracable. With this change this will give the possibility to restrict
/proc/<pids>/ but more importantly this will give desktop users a
generic and usuable way to specifiy which users should see all processes
and which user can not.

Side notes:

* This covers the lack of seccomp where it is not able to parse
arguments, it is easy to install a seccomp filter on direct syscalls
that operate on pids, however /proc/<pid>/ is a Linux ABI using
filesystem syscalls. With this change all LSMs should be able to analyze
open/read/write/close... on /proc/<pid>/

4) This will allow to implement new features either in kernel or
userspace without having to worry about procfs.
In containers, sandboxes, etc we have workarounds to hide some /proc
inodes, this should be supported natively without doing extra complex
work, the kernel should be able to support sane options that work with
today and future Linux use cases.

5) Creation of new superblock with all procfs options for each procfs
mount will fix the ignoring of mount options. The problem is that the
second mount of procfs in the same pid namespace ignores the mount
options. The mount options are ignored without error until procfs is
remounted.

Before:

# grep ^proc /proc/mounts
proc /proc proc rw,relatime,hidepid=2 0 0

# strace -e mount mount -o hidepid=1 -t proc proc /tmp/proc
mount("proc", "/tmp/proc", "proc", 0, "hidepid=1") = 0
+++ exited with 0 +++

# grep ^proc /proc/mounts
proc /proc proc rw,relatime,hidepid=2 0 0
proc /tmp/proc proc rw,relatime,hidepid=2 0 0

# mount -o remount,hidepid=1 -t proc proc /tmp/proc

# grep ^proc /proc/mounts
proc /proc proc rw,relatime,hidepid=1 0 0
proc /tmp/proc proc rw,relatime,hidepid=1 0 0

After:

# grep ^proc /proc/mounts
proc /proc proc rw,relatime,hidepid=2 0 0

# mount -o hidepid=1 -t proc proc /tmp/proc

# grep ^proc /proc/mounts
proc /proc proc rw,relatime,hidepid=2 0 0
proc /tmp/proc proc rw,relatime,hidepid=1 0 0


Introduced changes:
-------------------
Each mount of procfs creates a separate procfs instance with its own
mount options.

This series adds few new mount options:

* New 'hidepid=3' mount option to show only ptraceable processes in the procfs.
This allows to support lightweight sandboxes in Embedded Linux, also
solves the case for LSM where now with this mount option, we make sure
that they have a ptrace path in procfs.
( Maybe I should use a mask? hidepid=4? )

* 'pidonly=1' that allows to hide non-pid inodes from procfs. It can be used
in containers and sandboxes, as these are already trying to hide and block
access to procfs inodes anyway.


ChangeLog:
----------
# RFC v6:
*) 'hidepid=' and 'gid=' mount options are moved from pid namespace to superblock.
*) 'newinstance' mount option removed as Eric W. Biederman suggested.
   Mount of procfs always creates a new instance.
*) 'limit_pids' renamed to 'hidepid=3'.
*) I took into account the comment of Linus Torvalds [7].
*) Documentation added.

# RFC v5:
*) Fixed a bug that caused a problem with the Fedora boot.
*) The 'pidonly' option is visible among the mount options.

# RFC v2:
*) Renamed mount options to 'newinstance' and 'pids='
   Suggested-by: Andy Lutomirski <luto@kernel.org>
*) Fixed order of commit, Suggested-by: Andy Lutomirski <luto@kernel.org>
*) Many bug fixes.

# RFC v1:
*) Removed 'unshared' mount option and replaced it with 'limit_pids'
   which is attached to the current procfs mount.
   Suggested-by Andy Lutomirski <luto@kernel.org>
*) Do not fill dcache with pid entries that we can not ptrace.
*) Many bug fixes.


References:
-----------
[1] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2017-January/004215.html
[2] http://www.openwall.com/lists/kernel-hardening/2017/10/05/5
[3] https://lwn.net/Articles/689539/
[4] http://lxr.free-electrons.com/source/Documentation/filesystems/devpts.txt?v=3.14
[5] https://lkml.org/lkml/2017/5/2/407
[6] https://lkml.org/lkml/2017/5/3/357
[7] https://lkml.org/lkml/2018/5/11/505


Alexey Gladkov (10):
  proc: Rename struct proc_fs_info to proc_fs_opts
  proc: add proc_fs_info struct to store proc information
  proc: move /proc/{self|thread-self} dentries to proc_fs_info
  proc: move hide_pid, pid_gid from pid_namespace to proc_fs_info
  proc: add helpers to set and get proc hidepid and gid mount options
  proc: support mounting procfs instances inside same pid namespace
  proc: flush task dcache entries from all procfs instances
  proc: instantiate only pids that we can ptrace on 'hidepid=3' mount
    option
  proc: add option to mount only a pids subset
  docs: proc: add documentation for "hidepid=3" and "pidonly" options
    and new mount behavior

 Documentation/filesystems/proc.txt | 53 +++++++++++++++++
 fs/locks.c                         |  6 +-
 fs/proc/base.c                     | 69 +++++++++++++++------
 fs/proc/generic.c                  | 20 +++++++
 fs/proc/inode.c                    | 22 +++++--
 fs/proc/root.c                     | 96 ++++++++++++++++++++++--------
 fs/proc/self.c                     |  4 +-
 fs/proc/thread_self.c              |  6 +-
 fs/proc_namespace.c                | 14 ++---
 include/linux/pid_namespace.h      | 54 +++++++++++++----
 include/linux/proc_fs.h            | 94 ++++++++++++++++++++++++++++-
 11 files changed, 362 insertions(+), 76 deletions(-)

-- 
2.24.1

