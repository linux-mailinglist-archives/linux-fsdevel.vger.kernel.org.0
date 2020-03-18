Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B69EF189E9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 16:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgCRPD3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 11:03:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:46919 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726777AbgCRPD2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584543807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eACliW5m3l6widmS1Zr6ut9EmaFW4ycNHJmQMUkCYVg=;
        b=SLId6EEZfnWWdoPZdorE24NrEYWX0F5PwwdnzvvyjqXMoQgCQrTYnoNXI2/s2B3lEPvNFN
        6X3pnV4wkOg4ARca9MP91Jxud61lrQ64Pa61f3tU0p07PMxysEA0ALvCyfRWnYjBkmGggb
        ZKCLBSWT0hJJ+TYfARqmT+ObkOb+ikY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-APrqPzfZNb-BGrQJSVr1mw-1; Wed, 18 Mar 2020 11:03:17 -0400
X-MC-Unique: APrqPzfZNb-BGrQJSVr1mw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95B1C802681;
        Wed, 18 Mar 2020 15:03:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 468105C1D8;
        Wed, 18 Mar 2020 15:03:09 +0000 (UTC)
Subject: [PATCH 00/17] pipe: Keyrings,
 mount and superblock notifications [ver #5]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        casey@schaufler-ca.com, sds@tycho.nsa.gov,
        nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io,
        andres@anarazel.de, jlayton@redhat.com, dray@redhat.com,
        kzak@redhat.com, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Mar 2020 15:03:08 +0000
Message-ID: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches to add a general notification queue concept and to
add event sources such as:

 (1) Keys/keyrings, such as linking and unlinking keys and changing their
     attributes.

 (2) Mount topology events, such as mounting, unmounting, mount expiry,
     mount reconfiguration.

 (3) Superblock events, such as R/W<->R/O changes, quota overrun and I/O
     errors (not complete yet).

LSM hooks are included:

 (1) A set of hooks are provided that allow an LSM to rule on whether or
     not a watch may be set.  Each of these hooks takes a different
     "watched object" parameter, so they're not really shareable.  The LSM
     should use current's credentials.  [Wanted by SELinux & Smack]

 (2) A hook is provided to allow an LSM to rule on whether or not a
     particular message may be posted to a particular queue.  This is given
     the credentials from the event generator (which may be the system) and
     the watch setter.  [Wanted by Smack]

I've provided SELinux and Smack with implementations of some of these hooks.


WHY
===

 (1) Key/keyring notifications.

     If you have your kerberos tickets in a file/directory, your gnome
     desktop will monitor that using something like fanotify and tell you
     if your credentials cache changes.

     We also have the ability to cache your kerberos tickets in the
     session, user or persistent keyring so that it isn't left around on
     disk across a reboot or logout.  Keyrings, however, cannot currently
     be monitored asynchronously, so the desktop has to poll for it - not
     so good on a laptop.

     This source will allow the desktop to avoid the need to poll.  Here's
     a pull request for usage by gnome-online-accounts:

	https://gitlab.gnome.org/GNOME/gnome-online-accounts/merge_requests/47

 (2) Mount notifications.

     This one is wanted to avoid repeated trawling of /proc/mounts or
     similar to work out changes to the mount object attributes and mount
     topology.  I'm told that the proc file holding the namespace_sem is a
     point of contention, especially as the process of generating the text
     descriptions of the mounts/superblocks can be quite involved.

     Whilst you can use poll() on /proc/mounts, it doesn't give you any
     clues as to what changed.  The notification generated here directly
     indicates the mounts involved in any particular event and gives an
     idea of what the change was.

     This is combined with a new fsinfo() system call that allows, amongst
     other things, the ability to retrieve in one go an { id,
     change_counter } tuple from all the children of a specified mount,
     allowing buffer overruns to be dealt with quickly.

     This is of use to systemd to improve efficiency:

	https://lore.kernel.org/linux-fsdevel/20200227151421.3u74ijhqt6ekbiss@ws.net.home/

     And it's not just Red Hat that's potentially interested in this:

	https://lore.kernel.org/linux-fsdevel/293c9bd3-f530-d75e-c353-ddeabac27cf6@6wind.com/

 (3) Superblock notifications.

     This one is provided to allow systemd or the desktop to more easily
     detect events such as I/O errors and EDQUOT/ENOSPC.  This would be of
     interest to Postgres:

	https://lore.kernel.org/linux-fsdevel/20200211005626.7yqjf5rbs3vbwagd@alap3.anarazel.de/


DESIGN DECISIONS
================

 (1) The notification queue is built on top of a standard pipe.  Messages
     are effectively spliced in.  The pipe is opened with a special flag:

	pipe2(fds, O_NOTIFICATION_PIPE);

     The special flag has the same value as O_EXCL (which doesn't seem like
     it will ever be applicable in this context)[?].  It is given up front
     to make it a lot easier to prohibit splice and co. from accessing the
     pipe.

     [?] Should this be done some other way?  I'd rather not use up a new
     	 O_* flag if I can avoid it - should I add a pipe3() system call
     	 instead?

     The pipe is then configured::

	ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, queue_depth);
	ioctl(fds[1], IOC_WATCH_QUEUE_SET_FILTER, &filter);

     Messages are then read out of the pipe using read().

 (2) It should be possible to allow write() to insert data into the
     notification pipes too, but this is currently disabled as the kernel
     has to be able to insert messages into the pipe *without* holding
     pipe->mutex and the code to make this work needs careful auditing.

 (3) sendfile(), splice() and vmsplice() are disabled on notification pipes
     because of the pipe->mutex issue and also because they sometimes want
     to revert what they just did - but one or more notification messages
     might've been interleaved in the ring.

 (4) The kernel inserts messages with the wait queue spinlock held.  This
     means that pipe_read() and pipe_write() have to take the spinlock to
     update the queue pointers.

 (5) Records in the buffer are binary, typed and have a length so that they
     can be of varying size.

     This allows multiple heterogeneous sources to share a common buffer;
     there are 16 million types available, of which I've used just a few,
     so there is scope for others to be used.  Tags may be specified when a
     watchpoint is created to help distinguish the sources.

 (6) Records are filterable as types have up to 256 subtypes that can be
     individually filtered.  Other filtration is also available.

 (7) Notification pipes don't interfere with each other; each may be bound
     to a different set of watches.  Any particular notification will be
     copied to all the queues that are currently watching for it - and only
     those that are watching for it.

 (8) When recording a notification, the kernel will not sleep, but will
     rather mark a queue as having lost a message if there's insufficient
     space.  read() will fabricate a loss notification message at an
     appropriate point later.

 (9) The notification pipe is created and then watchpoints are attached to
     it, using one of:

	keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fds[1], 0x01);
	watch_mount(AT_FDCWD, "/", 0, fd, 0x02);
	watch_sb(AT_FDCWD, "/mnt", 0, fd, 0x03);

     where in both cases, fd indicates the queue and the number after is a
     tag between 0 and 255.

(10) Watches are removed if either the notification pipe is destroyed or
     the watched object is destroyed.  In the latter case, a message will
     be generated indicating the enforced watch removal.


Things I want to avoid:

 (1) Introducing features that make the core VFS dependent on the network
     stack or networking namespaces (ie. usage of netlink).

 (2) Dumping all this stuff into dmesg and having a daemon that sits there
     parsing the output and distributing it as this then puts the
     responsibility for security into userspace and makes handling
     namespaces tricky.  Further, dmesg might not exist or might be
     inaccessible inside a container.

 (3) Letting users see events they shouldn't be able to see.


TESTING AND MANPAGES
====================

 (*) The keyutils tree has a pipe-watch branch that has keyctl commands for
     making use of notifications.  Proposed manual pages can also be found
     on this branch, though a couple of them really need to go to the main
     manpages repository instead.

     If the kernel supports the watching of keys, then running "make test"
     on that branch will cause the testing infrastructure to spawn a
     monitoring process on the side that monitors a notifications pipe for
     all the key/keyring changes induced by the tests and they'll all be
     checked off to make sure they happened.

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/log/?h=pipe-watch

 (*) A test program is provided (samples/watch_queue/watch_test) that can
     be used to monitor for keyrings, mount and superblock events.
     Information on the notifications is simply logged to stdout.

The kernel patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=notifications-pipe-core

Changes:

 ver #5:

 (*) Moved some of the bits of notify_mount() and notify_sb() out of line.

 (*) Exported some event counters with the mount notifications to make it
     easier for the monitoring application to maintain its state.

 (*) Increment the topology change counter on the added, moved or removed
     object as well as the parent(s).

 (*) Renamed the "changed mount" to "auxiliary mount" in the mount
     notification record.

 ver #4:

 (*) Dropped USB and device notifications for the moment as there's some
     dispute over whether another avenue should be used for USB
     notifications.

 (*) Include mount and superblock event sources in the patchset.

     - These now increment event counters that fsinfo() will be able to
       retrieve (separate patch set).

 ver #3:

 (*) Rebase to after latest upstream pipe patches.
 (*) Fix a missing ref get in add_watch_to_object().

 ver #2:

 (*) Declare O_NOTIFICATION_PIPE to use and switch it to be the same value
     as O_EXCL rather then O_TMPFILE (the latter is a bit nasty in its
     implementation).

 ver #1:

 (*) Build on top of standard pipes instead of having a driver.

David
---
David Howells (17):
      uapi: General notification queue definitions
      security: Add hooks to rule on setting a watch
      security: Add a hook for the point of notification insertion
      pipe: Add O_NOTIFICATION_PIPE
      pipe: Add general notification queue support
      watch_queue: Add a key/keyring notification facility
      Add sample notification program
      pipe: Allow buffers to be marked read-whole-or-error for notifications
      pipe: Add notification lossage handling
      selinux: Implement the watch_key security hook
      smack: Implement the watch_key and post_notification hooks
      watch_queue: Add security hooks to rule on setting mount and sb watches
      watch_queue: Implement mount topology and attribute change notifications
      watch_queue: sample: Display mount tree change notifications
      watch_queue: Introduce a non-repeating system-unique superblock ID
      watch_queue: Add superblock notifications
      watch_queue: sample: Display superblock notifications


 Documentation/security/keys/core.rst               |   58 ++
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 
 Documentation/watch_queue.rst                      |  361 +++++++++++
 arch/alpha/kernel/syscalls/syscall.tbl             |    2 
 arch/arm/tools/syscall.tbl                         |    2 
 arch/arm64/include/asm/unistd.h                    |    2 
 arch/arm64/include/asm/unistd32.h                  |    4 
 arch/ia64/kernel/syscalls/syscall.tbl              |    2 
 arch/m68k/kernel/syscalls/syscall.tbl              |    2 
 arch/microblaze/kernel/syscalls/syscall.tbl        |    2 
 arch/mips/kernel/syscalls/syscall_n32.tbl          |    2 
 arch/mips/kernel/syscalls/syscall_n64.tbl          |    2 
 arch/mips/kernel/syscalls/syscall_o32.tbl          |    2 
 arch/parisc/kernel/syscalls/syscall.tbl            |    2 
 arch/powerpc/kernel/syscalls/syscall.tbl           |    2 
 arch/s390/kernel/syscalls/syscall.tbl              |    2 
 arch/sh/kernel/syscalls/syscall.tbl                |    2 
 arch/sparc/kernel/syscalls/syscall.tbl             |    2 
 arch/x86/entry/syscalls/syscall_32.tbl             |    2 
 arch/x86/entry/syscalls/syscall_64.tbl             |    2 
 arch/xtensa/kernel/syscalls/syscall.tbl            |    2 
 fs/Kconfig                                         |   21 +
 fs/Makefile                                        |    1 
 fs/internal.h                                      |    1 
 fs/mount.h                                         |   21 +
 fs/mount_notify.c                                  |  228 +++++++
 fs/namespace.c                                     |   22 +
 fs/pipe.c                                          |  242 +++++--
 fs/splice.c                                        |   12 
 fs/super.c                                         |  205 ++++++
 include/linux/dcache.h                             |    1 
 include/linux/fs.h                                 |   62 ++
 include/linux/key.h                                |    3 
 include/linux/lsm_audit.h                          |    1 
 include/linux/lsm_hooks.h                          |   62 ++
 include/linux/pipe_fs_i.h                          |   27 +
 include/linux/security.h                           |   47 +
 include/linux/syscalls.h                           |    4 
 include/linux/watch_queue.h                        |  127 ++++
 include/uapi/asm-generic/unistd.h                  |    6 
 include/uapi/linux/keyctl.h                        |    2 
 include/uapi/linux/watch_queue.h                   |  167 +++++
 init/Kconfig                                       |   12 
 kernel/Makefile                                    |    1 
 kernel/sys_ni.c                                    |    6 
 kernel/watch_queue.c                               |  659 ++++++++++++++++++++
 samples/Kconfig                                    |    6 
 samples/Makefile                                   |    1 
 samples/watch_queue/Makefile                       |    7 
 samples/watch_queue/watch_test.c                   |  265 ++++++++
 security/keys/Kconfig                              |    9 
 security/keys/compat.c                             |    3 
 security/keys/gc.c                                 |    5 
 security/keys/internal.h                           |   30 +
 security/keys/key.c                                |   38 +
 security/keys/keyctl.c                             |   99 +++
 security/keys/keyring.c                            |   20 -
 security/keys/request_key.c                        |    4 
 security/security.c                                |   37 +
 security/selinux/hooks.c                           |   14 
 security/smack/smack_lsm.c                         |   83 ++-
 61 files changed, 2912 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/watch_queue.rst
 create mode 100644 fs/mount_notify.c
 create mode 100644 include/linux/watch_queue.h
 create mode 100644 include/uapi/linux/watch_queue.h
 create mode 100644 kernel/watch_queue.c
 create mode 100644 samples/watch_queue/Makefile
 create mode 100644 samples/watch_queue/watch_test.c


