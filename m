Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 180AF2CADE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 18:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfE1QB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 12:01:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfE1QBz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 12:01:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCC94820E2;
        Tue, 28 May 2019 16:01:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E82E88086;
        Tue, 28 May 2019 16:01:47 +0000 (UTC)
Subject: [RFC][PATCH 0/7] Mount, FS, Block and Keyrings notifications
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 May 2019 17:01:47 +0100
Message-ID: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 28 May 2019 16:01:54 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Al,

Here's a set of patches to add a general variable-length notification queue
concept and to add sources of events for:

 (1) Mount topology events, such as mounting, unmounting, mount expiry,
     mount reconfiguration.

 (2) Superblock events, such as R/W<->R/O changes, quota overrun and I/O
     errors (not complete yet).

 (3) Block layer events, such as I/O errors.

 (4) Key/keyring events, such as creating, linking and removal of keys.

One of the reasons for this is so that we can remove the issue of processes
having to repeatedly and regularly scan /proc/mounts, which has proven to
be a system performance problem.  To further aid this, the fsinfo() syscall
on which this patch series depends, provides a way to access superblock and
mount information in binary form without the need to parse /proc/mounts.


Design decisions:

 (1) A misc chardev is used to create and open a ring buffer:

	fd = open("/dev/watch_queue", O_RDWR);

     which is then configured and mmap'd into userspace:

	ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE);
	ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter);
	buf = mmap(NULL, BUF_SIZE * page_size, PROT_READ | PROT_WRITE,
		   MAP_SHARED, fd, 0);

     The fd cannot be read or written (though there is a facility to use
     write to inject records for debugging) and userspace just pulls data
     directly out of the buffer.

 (2) The ring index pointers are stored inside the ring and are thus
     accessible to userspace.  Userspace should only update the tail
     pointer and never the head pointer or risk breaking the buffer.  The
     kernel checks that the pointers appear valid before trying to use
     them.  A 'skip' record is maintained around the pointers.

 (3) poll() can be used to wait for data to appear in the buffer.

 (4) Records in the buffer are binary, typed and have a length so that they
     can be of varying size.

     This means that multiple heterogeneous sources can share a common
     buffer.  Tags may be specified when a watchpoint is created to help
     distinguish the sources.

 (5) The queue is reusable as there are 16 million types available, of
     which I've used 4, so there is scope for others to be used.

 (6) Records are filterable as types have up to 256 subtypes that can be
     individually filtered.  Other filtration is also available.

 (7) Each time the buffer is opened, a new buffer is created - this means
     that there's no interference between watchers.

 (8) When recording a notification, the kernel will not sleep, but will
     rather mark a queue as overrun if there's insufficient space, thereby
     avoiding userspace causing the kernel to hang.

 (9) The 'watchpoint' should be specific where possible, meaning that you
     specify the object that you want to watch.

(10) The buffer is created and then watchpoints are attached to it, using
     one of:

	keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fd, 0x01);
	mount_notify(AT_FDCWD, "/", 0, fd, 0x02);
	sb_notify(AT_FDCWD, "/mnt", 0, fd, 0x03);

     where in all three cases, fd indicates the queue and the number after
     is a tag between 0 and 255.

(11) The watch must be removed if either the watch buffer is destroyed or
     the watched object is destroyed.


Things I want to avoid:

 (1) Introducing features that make the core VFS dependent on the network
     stack or networking namespaces (ie. usage of netlink).

 (2) Dumping all this stuff into dmesg and having a daemon that sits there
     parsing the output and distributing it as this then puts the
     responsibility for security into userspace and makes handling
     namespaces tricky.  Further, dmesg might not exist or might be
     inaccessible inside a container.

 (3) Letting users see events they shouldn't be able to see.


Further things that could be considered:

 (1) Adding a keyctl call to allow a watch on a keyring to be extended to
     "children" of that keyring, such that the watch is removed from the
     child if it is unlinked from the keyring.

 (2) Adding global superblock event queue.

 (3) Propagating watches to child superblock over automounts.


The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=notifications

David
---
David Howells (7):
      General notification queue with user mmap()'able ring buffer
      keys: Add a notification facility
      vfs: Add a mount-notification facility
      vfs: Add superblock notifications
      fsinfo: Export superblock notification counter
      block: Add block layer notifications
      Add sample notification program


 Documentation/security/keys/core.rst   |   58 ++
 Documentation/watch_queue.rst          |  311 +++++++++++
 arch/x86/entry/syscalls/syscall_32.tbl |    3 
 arch/x86/entry/syscalls/syscall_64.tbl |    3 
 block/Kconfig                          |    9 
 block/Makefile                         |    1 
 block/blk-core.c                       |   28 +
 block/blk-notify.c                     |   83 +++
 drivers/misc/Kconfig                   |   13 
 drivers/misc/Makefile                  |    1 
 drivers/misc/watch_queue.c             |  877 ++++++++++++++++++++++++++++++++
 fs/Kconfig                             |   21 +
 fs/Makefile                            |    1 
 fs/fsinfo.c                            |   12 
 fs/mount.h                             |   33 +
 fs/mount_notify.c                      |  178 ++++++
 fs/namespace.c                         |    9 
 fs/super.c                             |  116 ++++
 include/linux/blkdev.h                 |   10 
 include/linux/dcache.h                 |    1 
 include/linux/fs.h                     |   78 +++
 include/linux/key.h                    |    4 
 include/linux/lsm_hooks.h              |   15 +
 include/linux/security.h               |   14 +
 include/linux/syscalls.h               |    5 
 include/linux/watch_queue.h            |   86 +++
 include/uapi/linux/fsinfo.h            |   10 
 include/uapi/linux/keyctl.h            |    1 
 include/uapi/linux/watch_queue.h       |  185 +++++++
 kernel/sys_ni.c                        |    6 
 mm/interval_tree.c                     |    2 
 mm/memory.c                            |    1 
 samples/Kconfig                        |    6 
 samples/Makefile                       |    1 
 samples/vfs/test-fsinfo.c              |   13 
 samples/watch_queue/Makefile           |    9 
 samples/watch_queue/watch_test.c       |  284 ++++++++++
 security/keys/Kconfig                  |   10 
 security/keys/compat.c                 |    2 
 security/keys/gc.c                     |    5 
 security/keys/internal.h               |   30 +
 security/keys/key.c                    |   37 +
 security/keys/keyctl.c                 |   88 +++
 security/keys/keyring.c                |   17 -
 security/keys/request_key.c            |    4 
 security/security.c                    |    9 
 46 files changed, 2652 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/watch_queue.rst
 create mode 100644 block/blk-notify.c
 create mode 100644 drivers/misc/watch_queue.c
 create mode 100644 fs/mount_notify.c
 create mode 100644 include/linux/watch_queue.h
 create mode 100644 include/uapi/linux/watch_queue.h
 create mode 100644 samples/watch_queue/Makefile
 create mode 100644 samples/watch_queue/watch_test.c

