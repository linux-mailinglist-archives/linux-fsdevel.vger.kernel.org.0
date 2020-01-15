Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5D213C2C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 14:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgAONar (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 08:30:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58477 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726071AbgAONaq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579095045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dSuwXOkLNc2+9CyhIpo9YFvHDt0jRh9GE8hPRzqPdYM=;
        b=fkVzISqpU3byc3/4wB74jubV1wIRdWezhku1IJggvIw6J0TLmP1ugy/F0SeXMCHPCMlcqN
        +1+EMpvrTFuJn1IPt9LRPuYKiNwa5f1gODyD6FHRH9/zvXOqBBqyJrrejSn+kpHbW9NUWz
        LBXQhTVySy88pnhTGTfJwCweefflIas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-yUq0FqlTM4qAN6FBI1N9QA-1; Wed, 15 Jan 2020 08:30:42 -0500
X-MC-Unique: yUq0FqlTM4qAN6FBI1N9QA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4ED36A2B2;
        Wed, 15 Jan 2020 13:30:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 853AD19757;
        Wed, 15 Jan 2020 13:30:36 +0000 (UTC)
Subject: [RFC PATCH 00/14] pipe: Keyrings,
 Block and USB notifications [ver #3]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, Christian Brauner <christian@brauner.io>,
        dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-block@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 15 Jan 2020 13:30:35 +0000
Message-ID: <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches to add a general notification queue concept and to
add event sources such as:

 (1) Keys/keyrings, such as linking and unlinking keys and changing their
     attributes.

 (2) General device events (single common queue) including:

     - Block layer events, such as device errors

     - USB subsystem events, such as device attach/remove, device reset,
       device errors.

I have patches for adding superblock and mount topology watches also,
though those are not in this set as there are other dependencies.

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

Why:

 (1) Key/keyring notifications.

     If you have your kerberos tickets in a file/directory, your gnome desktop
     will monitor that using something like fanotify and tell you if your
     credentials cache changes.

     We also have the ability to cache your kerberos tickets in the session,
     user or persistent keyring so that it isn't left around on disk across a
     reboot or logout.  Keyrings, however, cannot currently be monitored
     asynchronously, so the desktop has to poll for it - not so good on a
     laptop.

     This source will allow the desktop to avoid the need to poll.

 (2) USB notifications.

     GregKH was looking for a way to do USB notifications as I was looking to
     find additional sources to implement.  I'm not sure how he wants to use
     them, but I'll let him speak to that himself.

 (3) Block notifications.

     This one I was thinking that I could make something like ddrescue better
     by letting it get notifications this way.  This was a target of
     convenience since I had a dodgy disk I was trying to rescue.

     It could also potentially be used help systemd, say, detect broken
     devices and avoid trying to unmount them when trying to reboot the machine.

     I can drop this for now if you prefer.

 (4) Mount notifications.

     This one is wanted to avoid repeated trawling of /proc/mounts or similar
     to work out changes to the mount object attributes and mount topology.
     I'm told that the proc file holding the namespace_sem is a point of
     contention, especially as the process of generating the text descriptions
     of the mounts/superblocks can be quite involved.

     The notifications directly indicate the mounts involved in any particular
     event and what the change was.  You can poll /proc/mounts, but all you
     know is that something changed; you don't know what and you don't know
     how and reading that file may race with multiple changed being effected.

     I pair this with a new fsinfo() system call that allows, amongst other
     things, the ability to retrieve in one go an { id, change counter } tuple
     from all the children of a specified mount, allowing buffer overruns to
     be cleaned up quickly.

     It's not just Red Hat that's potentially interested in this:

	https://lore.kernel.org/linux-fsdevel/293c9bd3-f530-d75e-c353-ddeabac27cf6@6wind.com/

 (5) Superblock notifications.

     This one is provided to allow systemd or the desktop to more easily
     detect events such as I/O errors and EDQUOT/ENOSPC.

Design decisions:

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
	watch_devices(fds[1], 0x02, 0);

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


Testing and manpages:

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
     be used to monitor for keyrings, some USB and some block device
     events.  Information on the notifications is simply logged to stdout.

The kernel patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=notifications-pipe-core

Changes:

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
David Howells (14):
      uapi: General notification queue definitions
      security: Add hooks to rule on setting a watch
      security: Add a hook for the point of notification insertion
      pipe: Add O_NOTIFICATION_PIPE
      pipe: Add general notification queue support
      keys: Add a notification facility
      Add sample notification program
      pipe: Allow buffers to be marked read-whole-or-error for notifications
      pipe: Add notification lossage handling
      Add a general, global device notification watch list
      block: Add block layer notifications
      usb: Add USB subsystem notifications
      selinux: Implement the watch_key security hook
      smack: Implement the watch_key and post_notification hooks


 Documentation/security/keys/core.rst               |   58 ++
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 
 Documentation/watch_queue.rst                      |  385 ++++++++++++
 arch/alpha/kernel/syscalls/syscall.tbl             |    1 
 arch/arm/tools/syscall.tbl                         |    1 
 arch/arm64/include/asm/unistd.h                    |    2 
 arch/arm64/include/asm/unistd32.h                  |    2 
 arch/ia64/kernel/syscalls/syscall.tbl              |    1 
 arch/m68k/kernel/syscalls/syscall.tbl              |    1 
 arch/microblaze/kernel/syscalls/syscall.tbl        |    1 
 arch/mips/kernel/syscalls/syscall_n32.tbl          |    1 
 arch/mips/kernel/syscalls/syscall_n64.tbl          |    1 
 arch/mips/kernel/syscalls/syscall_o32.tbl          |    1 
 arch/parisc/kernel/syscalls/syscall.tbl            |    1 
 arch/powerpc/kernel/syscalls/syscall.tbl           |    1 
 arch/s390/kernel/syscalls/syscall.tbl              |    1 
 arch/sh/kernel/syscalls/syscall.tbl                |    1 
 arch/sparc/kernel/syscalls/syscall.tbl             |    1 
 arch/x86/entry/syscalls/syscall_32.tbl             |    1 
 arch/x86/entry/syscalls/syscall_64.tbl             |    1 
 arch/xtensa/kernel/syscalls/syscall.tbl            |    1 
 block/Kconfig                                      |    9 
 block/blk-core.c                                   |   29 +
 drivers/base/Kconfig                               |    9 
 drivers/base/Makefile                              |    1 
 drivers/base/watch.c                               |   90 +++
 drivers/usb/core/Kconfig                           |    9 
 drivers/usb/core/devio.c                           |   47 +
 drivers/usb/core/hub.c                             |    4 
 fs/pipe.c                                          |  242 +++++--
 fs/splice.c                                        |   12 
 include/linux/blkdev.h                             |   15 
 include/linux/device.h                             |    7 
 include/linux/key.h                                |    3 
 include/linux/lsm_audit.h                          |    1 
 include/linux/lsm_hooks.h                          |   38 +
 include/linux/pipe_fs_i.h                          |   27 +
 include/linux/security.h                           |   31 +
 include/linux/syscalls.h                           |    1 
 include/linux/usb.h                                |   18 +
 include/linux/watch_queue.h                        |  127 ++++
 include/uapi/asm-generic/unistd.h                  |    4 
 include/uapi/linux/keyctl.h                        |    2 
 include/uapi/linux/watch_queue.h                   |  158 +++++
 init/Kconfig                                       |   12 
 kernel/Makefile                                    |    1 
 kernel/sys_ni.c                                    |    1 
 kernel/watch_queue.c                               |  659 ++++++++++++++++++++
 samples/Kconfig                                    |    6 
 samples/Makefile                                   |    1 
 samples/watch_queue/Makefile                       |    7 
 samples/watch_queue/watch_test.c                   |  251 ++++++++
 security/keys/Kconfig                              |    9 
 security/keys/compat.c                             |    3 
 security/keys/gc.c                                 |    5 
 security/keys/internal.h                           |   30 +
 security/keys/key.c                                |   38 +
 security/keys/keyctl.c                             |   99 +++
 security/keys/keyring.c                            |   20 -
 security/keys/request_key.c                        |    4 
 security/security.c                                |   23 +
 security/selinux/hooks.c                           |   14 
 security/smack/smack_lsm.c                         |   82 ++
 63 files changed, 2506 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/watch_queue.rst
 create mode 100644 drivers/base/watch.c
 create mode 100644 include/linux/watch_queue.h
 create mode 100644 include/uapi/linux/watch_queue.h
 create mode 100644 kernel/watch_queue.c
 create mode 100644 samples/watch_queue/Makefile
 create mode 100644 samples/watch_queue/watch_test.c

