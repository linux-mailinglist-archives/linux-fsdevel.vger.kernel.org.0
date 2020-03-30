Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61019197E68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 16:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgC3ObQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 10:31:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51167 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727302AbgC3ObQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585578674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=huW2G1GZkwBfLx/3KhdKR3y+WnCuVQXESZcOHEholF0=;
        b=YbzM4LWCjO5O8qZVsdlbRq8W6vX53/nlyrMMeN0K8Ncv3efR7JdPFGYrC1jNZTtXkaxA/e
        a4YIySbv5cOOS2o6/RtR0DAABHliIDJ1SYGd0qzc2QjXangk8YJbCJo3Md5G+qbt7ub0SH
        A9k5yND+j4+y7armFCH3cpQz7R56BaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-ee9WgOojM8iORajCwK5UWA-1; Mon, 30 Mar 2020 10:31:10 -0400
X-MC-Unique: ee9WgOojM8iORajCwK5UWA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9498B107B7E1;
        Mon, 30 Mar 2020 14:31:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-66.rdu2.redhat.com [10.10.112.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7DE510002A9;
        Mon, 30 Mar 2020 14:31:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
References: <1445647.1585576702@warthog.procyon.org.uk>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, dray@redhat.com,
        kzak@redhat.com, mszeredi@redhat.com, swhiteho@redhat.com,
        jlayton@redhat.com, raven@themaw.net, andres@anarazel.de,
        christian.brauner@ubuntu.com, jarkko.sakkinen@linux.intel.com,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] General notification queue and key notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1449137.1585578664.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 30 Mar 2020 15:31:04 +0100
Message-ID: <1449138.1585578664@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Can you pull this, please?  It adds a general notification queue concept
and adds an event source for keys/keyrings, such as linking and unlinking
keys and changing their attributes.  A subsequent pull request will add
mount and superblock event sources.

LSM hooks are included:

 (1) A set of hooks are provided that allow an LSM to rule on whether or
     not a watch may be set.  Each of these hooks takes a different
     "watched object" parameter, so they're not really shareable.  The LSM
     should use current's credentials.  [Wanted by SELinux & Smack]

 (2) A hook is provided to allow an LSM to rule on whether or not a
     particular message may be posted to a particular queue.  This is give=
n
     the credentials from the event generator (which may be the system) an=
d
     the watch setter.  [Wanted by Smack]

I've provided SELinux and Smack with implementations of some of these hook=
s.


WHY
=3D=3D=3D

Key/keyring notifications are desirable because if you have your kerberos
tickets in a file/directory, your Gnome desktop will monitor that using
something like fanotify and tell you if your credentials cache changes.

However, we also have the ability to cache your kerberos tickets in the
session, user or persistent keyring so that it isn't left around on disk
across a reboot or logout.  Keyrings, however, cannot currently be
monitored asynchronously, so the desktop has to poll for it - not so good
on a laptop.

This source will allow the desktop to avoid the need to poll.  Here's a
pull request for usage by gnome-online-accounts:

    https://gitlab.gnome.org/GNOME/gnome-online-accounts/merge_requests/47


DESIGN DECISIONS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 (1) The notification queue is built on top of a standard pipe.  Messages
     are effectively spliced in.  The pipe is opened with a special flag:

	pipe2(fds, O_NOTIFICATION_PIPE);

     The special flag has the same value as O_EXCL (which doesn't seem lik=
e
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

 (3) sendfile(), splice() and vmsplice() are disabled on notification pipe=
s
     because of the pipe->mutex issue and also because they sometimes want
     to revert what they just did - but one or more notification messages
     might've been interleaved in the ring.

 (4) The kernel inserts messages with the wait queue spinlock held.  This
     means that pipe_read() and pipe_write() have to take the spinlock to
     update the queue pointers.

 (5) Records in the buffer are binary, typed and have a length so that the=
y
     can be of varying size.

     This allows multiple heterogeneous sources to share a common buffer;
     there are 16 million types available, of which I've used just a few,
     so there is scope for others to be used.  Tags may be specified when =
a
     watchpoint is created to help distinguish the sources.

 (6) Records are filterable as types have up to 256 subtypes that can be
     individually filtered.  Other filtration is also available.

 (7) Notification pipes don't interfere with each other; each may be bound
     to a different set of watches.  Any particular notification will be
     copied to all the queues that are currently watching for it - and onl=
y
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 (*) The keyutils tree has a pipe-watch branch that has keyctl commands fo=
r
     making use of notifications.  Proposed manual pages can also be found
     on this branch, though a couple of them really need to go to the main
     manpages repository instead.

     If the kernel supports the watching of keys, then running "make test"
     on that branch will cause the testing infrastructure to spawn a
     monitoring process on the side that monitors a notifications pipe for
     all the key/keyring changes induced by the tests and they'll all be
     checked off to make sure they happened.

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/log=
/?h=3Dpipe-watch

 (*) A test program is provided (samples/watch_queue/watch_test) that can
     be used to monitor for keyrings, mount and superblock events.
     Information on the notifications is simply logged to stdout.

Thanks,
David
---
The following changes since commit f8788d86ab28f61f7b46eb6be375f8a72678363=
6:

  Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/notifications-20200330

for you to fetch changes up to 694435dbde3d1da79aafaf4cd680802f9eb229b7:

  smack: Implement the watch_key and post_notification hooks (2020-03-19 1=
7:31:09 +0000)

----------------------------------------------------------------
Notifications over pipes

----------------------------------------------------------------
David Howells (11):
      uapi: General notification queue definitions
      security: Add hooks to rule on setting a watch
      security: Add a hook for the point of notification insertion
      pipe: Add O_NOTIFICATION_PIPE
      pipe: Add general notification queue support
      watch_queue: Add a key/keyring notification facility
      Add sample notification program
      pipe: Allow buffers to be marked read-whole-or-error for notificatio=
ns
      pipe: Add notification lossage handling
      selinux: Implement the watch_key security hook
      smack: Implement the watch_key and post_notification hooks

 Documentation/security/keys/core.rst               |  57 ++
 Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
 Documentation/watch_queue.rst                      | 339 +++++++++++
 fs/pipe.c                                          | 242 +++++---
 fs/splice.c                                        |  12 +-
 include/linux/key.h                                |   3 +
 include/linux/lsm_audit.h                          |   1 +
 include/linux/lsm_hooks.h                          |  38 ++
 include/linux/pipe_fs_i.h                          |  27 +-
 include/linux/security.h                           |  31 +
 include/linux/watch_queue.h                        | 127 ++++
 include/uapi/linux/keyctl.h                        |   2 +
 include/uapi/linux/watch_queue.h                   | 104 ++++
 init/Kconfig                                       |  12 +
 kernel/Makefile                                    |   1 +
 kernel/watch_queue.c                               | 659 ++++++++++++++++=
+++++
 samples/Kconfig                                    |   6 +
 samples/Makefile                                   |   1 +
 samples/watch_queue/Makefile                       |   7 +
 samples/watch_queue/watch_test.c                   | 186 ++++++
 security/keys/Kconfig                              |   9 +
 security/keys/compat.c                             |   3 +
 security/keys/gc.c                                 |   5 +
 security/keys/internal.h                           |  30 +-
 security/keys/key.c                                |  38 +-
 security/keys/keyctl.c                             |  99 +++-
 security/keys/keyring.c                            |  20 +-
 security/keys/request_key.c                        |   4 +-
 security/security.c                                |  23 +
 security/selinux/hooks.c                           |  14 +
 security/smack/smack_lsm.c                         |  83 ++-
 31 files changed, 2079 insertions(+), 105 deletions(-)
 create mode 100644 Documentation/watch_queue.rst
 create mode 100644 include/linux/watch_queue.h
 create mode 100644 include/uapi/linux/watch_queue.h
 create mode 100644 kernel/watch_queue.c
 create mode 100644 samples/watch_queue/Makefile
 create mode 100644 samples/watch_queue/watch_test.c

