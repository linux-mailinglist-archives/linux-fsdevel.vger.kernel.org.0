Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42C01EBF71
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 17:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgFBPzT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 11:55:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26517 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726809AbgFBPzT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591113316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4oI1+JCvm+lJx1OfRsvLgy2MXn9otK/1rPRpql6uNoE=;
        b=S8J4BezpDhL/tmDxJDVgc1+uZdZoRi8zzYKtqPVOXFcCuEea1AumODIf2vyOiClNKKVJKP
        u2orqfmAbZ7HWHq9z8siXL7IkckAB7t9/ntlXO4CXiqfrJn+jdqh0yO21g4p3pA17OSdKX
        aWJxW7YqcrSl14cE32F1hTv9haWB65E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-gnVNOdAeNJ2dpVh6reEMXg-1; Tue, 02 Jun 2020 11:55:14 -0400
X-MC-Unique: gnVNOdAeNJ2dpVh6reEMXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D3E019057A1;
        Tue,  2 Jun 2020 15:55:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84905D0206;
        Tue,  2 Jun 2020 15:55:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
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
Content-ID: <1503685.1591113304.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 02 Jun 2020 16:55:04 +0100
Message-ID: <1503686.1591113304@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Date: Tue, 02 Jun 2020 16:51:44 +0100

Hi Linus,

Can you pull this, please?  It adds a general notification queue concept
and adds an event source for keys/keyrings, such as linking and unlinking
keys and changing their attributes.

Thanks to Debarshi Ray, we do have a pull request to use this to fix a
problem with gnome-online-accounts - as mentioned last time:

    https://gitlab.gnome.org/GNOME/gnome-online-accounts/merge_requests/47

Without this, g-o-a has to constantly poll a keyring-based kerberos cache
to find out if kinit has changed anything.

[[ With regard to the mount/sb notifications and fsinfo(), Karel Zak and
   Ian Kent have been working on making libmount use them, preparatory to
   working on systemd:

	https://github.com/karelzak/util-linux/commits/topic/fsinfo
	https://github.com/raven-au/util-linux/commits/topic/fsinfo.public

   Development has stalled briefly due to other commitments, so I'm not
   sure I can ask you to pull those parts of the series for now.  Christia=
n
   Brauner would like to use them in lxc, but hasn't started.
   ]]


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
on a laptop.  This facility will allow the desktop to avoid the need to
poll.


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
The following changes since commit b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4c=
e:

  Linux 5.7-rc6 (2020-05-17 16:48:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/notifications-20200601

for you to fetch changes up to a8478a602913dc89a7cd2060e613edecd07e1dbd:

  smack: Implement the watch_key and post_notification hooks (2020-05-19 1=
5:47:38 +0100)

----------------------------------------------------------------
Notifications over pipes + Keyring notifications

----------------------------------------------------------------
David Howells (12):
      uapi: General notification queue definitions
      security: Add a hook for the point of notification insertion
      pipe: Add O_NOTIFICATION_PIPE
      pipe: Add general notification queue support
      security: Add hooks to rule on setting a watch
      watch_queue: Add a key/keyring notification facility
      Add sample notification program
      pipe: Allow buffers to be marked read-whole-or-error for notificatio=
ns
      pipe: Add notification lossage handling
      keys: Make the KEY_NEED_* perms an enum rather than a mask
      selinux: Implement the watch_key security hook
      smack: Implement the watch_key and post_notification hooks

 Documentation/security/keys/core.rst               |  57 ++
 Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
 Documentation/watch_queue.rst                      | 339 +++++++++++
 fs/pipe.c                                          | 242 +++++---
 fs/splice.c                                        |  12 +-
 include/linux/key.h                                |  33 +-
 include/linux/lsm_audit.h                          |   1 +
 include/linux/lsm_hook_defs.h                      |   9 +
 include/linux/lsm_hooks.h                          |  14 +
 include/linux/pipe_fs_i.h                          |  27 +-
 include/linux/security.h                           |  30 +-
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
 security/keys/internal.h                           |  38 +-
 security/keys/key.c                                |  38 +-
 security/keys/keyctl.c                             | 115 +++-
 security/keys/keyring.c                            |  20 +-
 security/keys/permission.c                         |  31 +-
 security/keys/process_keys.c                       |  46 +-
 security/keys/request_key.c                        |   4 +-
 security/security.c                                |  22 +-
 security/selinux/hooks.c                           |  51 +-
 security/smack/smack_lsm.c                         | 112 +++-
 34 files changed, 2185 insertions(+), 179 deletions(-)
 create mode 100644 Documentation/watch_queue.rst
 create mode 100644 include/linux/watch_queue.h
 create mode 100644 include/uapi/linux/watch_queue.h
 create mode 100644 kernel/watch_queue.c
 create mode 100644 samples/watch_queue/Makefile
 create mode 100644 samples/watch_queue/watch_test.c

