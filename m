Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8688A382C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 15:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfH3N5S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 09:57:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbfH3N5R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 09:57:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A167102BB36;
        Fri, 30 Aug 2019 13:57:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40FC619C6A;
        Fri, 30 Aug 2019 13:57:13 +0000 (UTC)
Subject: [PATCH 00/11] Keyrings, Block and USB notifications [ver #7]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Aug 2019 14:57:12 +0100
Message-ID: <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Fri, 30 Aug 2019 13:57:16 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches to add a general notification queue concept and to
add sources of events for:

 (1) Key/keyring events, such as creating, linking and removal of keys.

 (2) General device events (single common queue) including:

     - Block layer events, such as device errors

     - USB subsystem events, such as device/bus attach/remove, device
       reset, device errors.

Tests for the key/keyring events can be found on the keyutils next branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/log/?h=next

Notifications are done automatically inside of the testing infrastructure
on every change to that every test makes to a key or keyring.

Manual pages can be found there also, including pages for watch_queue(7)
and the watch_devices(2) system call (these should be transferred to the
manpages package if taken upstream).

LSM hooks are included:

 (1) A set of hooks are provided that allow an LSM to rule on whether or
     not a watch may be set.  Each of these hooks takes a different
     "watched object" parameter, so they're not really shareable.  The LSM
     should use current's credentials.  [Wanted by SELinux & Smack]

 (2) A hook is provided to allow an LSM to rule on whether or not a
     particular message may be posted to a particular queue.  This is given
     the credentials from the event generator (which may be the system) and
     the watch setter.  [Wanted by Smack]

I've provided a preliminary attempt to provide SELinux and Smack with
implementations of some of these hooks.


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
     which I've used just a few, so there is scope for others to be used.

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
	watch_devices(fd, 0x02, 0);

     where in both cases, fd indicates the queue and the number after is a
     tag between 0 and 255.

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


The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=notifications-core

Changes:

 ver #7:

 (*) Removed the 'watch' argument from the security_watch_key() and
     security_watch_devices() hooks as current_cred() can be used instead
     of watch->cred.

 ver #6:

 (*) Fix mmap bug in watch_queue driver.

 (*) Add an extended removal notification that can transmit an identifier
     to userspace (such as a key ID).

 (*) Don't produce a instantiation notification in mark_key_instantiated()
     but rather do it in the caller to prevent key updates from producing
     an instantiate notification as well as an update notification.

 (*) Set the right number of filters in the sample program.

 (*) Provide preliminary hook implementations for SELinux and Smack.

 ver #5:

 (*) Split the superblock watch and mount watch parts out into their own
     branch (notifications-mount) as they really need certain fsinfo()
     attributes.

 (*) Rearrange the watch notification UAPI header to push the length down
     to bits 0-5 and remove the lost-message bits.  The userspace's watch
     ID tag is moved to bits 8-15 and then the message type is allocated
     all of bits 16-31 for its own purposes.

     The lost-message bit is moved over to the header, rather than being
     placed in the next message to be generated and given its own word so
     it can be cleared with xchg(,0) for parisc.

 (*) The security_post_notification() hook is no longer called with the
     spinlock held and softirqs disabled - though the RCU readlock is still
     held.

 (*) Buffer pages are now accounted towards RLIMIT_MEMLOCK and CAP_IPC_LOCK
     will skip the overuse check.

 (*) The buffer is marked VM_DONTEXPAND.

 (*) Save the watch-setter's creds in struct watch and give that to the LSM
     hook for posting a message.

 ver #4:

 (*) Split the basic UAPI bits out into their own patch and then split the
     LSM hooks out into an intermediate patch.  Add LSM hooks for setting
     watches.

     Rename the *_notify() system calls to watch_*() for consistency.

 ver #3:

 (*) I've added a USB notification source and reformulated the block
     notification source so that there's now a common watch list, for which
     the system call is now device_notify().

     I've assigned a pair of unused ioctl numbers in the 'W' series to the
     ioctls added by this series.

     I've also added a description of the kernel API to the documentation.

 ver #2:

 (*) I've fixed various issues raised by Jann Horn and GregKH and moved to
     krefs for refcounting.  I've added some security features to try and
     give Casey Schaufler the LSM control he wants.

David
---
David Howells (11):
      uapi: General notification ring definitions
      security: Add hooks to rule on setting a watch
      security: Add a hook for the point of notification insertion
      General notification queue with user mmap()'able ring buffer
      keys: Add a notification facility
      Add a general, global device notification watch list
      block: Add block layer notifications
      usb: Add USB subsystem notifications
      Add sample notification program
      selinux: Implement the watch_key security hook
      smack: Implement the watch_key and post_notification hooks [untested]


 Documentation/ioctl/ioctl-number.rst        |    1 
 Documentation/security/keys/core.rst        |   58 ++
 Documentation/watch_queue.rst               |  460 ++++++++++++++
 arch/alpha/kernel/syscalls/syscall.tbl      |    1 
 arch/arm/tools/syscall.tbl                  |    1 
 arch/ia64/kernel/syscalls/syscall.tbl       |    1 
 arch/m68k/kernel/syscalls/syscall.tbl       |    1 
 arch/microblaze/kernel/syscalls/syscall.tbl |    1 
 arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 
 arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 
 arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 
 arch/parisc/kernel/syscalls/syscall.tbl     |    1 
 arch/powerpc/kernel/syscalls/syscall.tbl    |    1 
 arch/s390/kernel/syscalls/syscall.tbl       |    1 
 arch/sh/kernel/syscalls/syscall.tbl         |    1 
 arch/sparc/kernel/syscalls/syscall.tbl      |    1 
 arch/x86/entry/syscalls/syscall_32.tbl      |    1 
 arch/x86/entry/syscalls/syscall_64.tbl      |    1 
 arch/xtensa/kernel/syscalls/syscall.tbl     |    1 
 block/Kconfig                               |    9 
 block/blk-core.c                            |   29 +
 drivers/base/Kconfig                        |    9 
 drivers/base/Makefile                       |    1 
 drivers/base/watch.c                        |   90 +++
 drivers/misc/Kconfig                        |   13 
 drivers/misc/Makefile                       |    1 
 drivers/misc/watch_queue.c                  |  893 +++++++++++++++++++++++++++
 drivers/usb/core/Kconfig                    |    9 
 drivers/usb/core/devio.c                    |   56 ++
 drivers/usb/core/hub.c                      |    4 
 include/linux/blkdev.h                      |   15 
 include/linux/device.h                      |    7 
 include/linux/key.h                         |    3 
 include/linux/lsm_audit.h                   |    1 
 include/linux/lsm_hooks.h                   |   38 +
 include/linux/security.h                    |   32 +
 include/linux/syscalls.h                    |    1 
 include/linux/usb.h                         |   18 +
 include/linux/watch_queue.h                 |   94 +++
 include/uapi/asm-generic/unistd.h           |    4 
 include/uapi/linux/keyctl.h                 |    2 
 include/uapi/linux/watch_queue.h            |  183 ++++++
 kernel/sys_ni.c                             |    1 
 samples/Kconfig                             |    6 
 samples/Makefile                            |    1 
 samples/watch_queue/Makefile                |    8 
 samples/watch_queue/watch_test.c            |  233 +++++++
 security/keys/Kconfig                       |    9 
 security/keys/compat.c                      |    3 
 security/keys/gc.c                          |    5 
 security/keys/internal.h                    |   30 +
 security/keys/key.c                         |   38 +
 security/keys/keyctl.c                      |   99 +++
 security/keys/keyring.c                     |   20 -
 security/keys/request_key.c                 |    4 
 security/security.c                         |   23 +
 security/selinux/hooks.c                    |   14 
 security/smack/smack_lsm.c                  |   82 ++
 58 files changed, 2593 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/watch_queue.rst
 create mode 100644 drivers/base/watch.c
 create mode 100644 drivers/misc/watch_queue.c
 create mode 100644 include/linux/watch_queue.h
 create mode 100644 include/uapi/linux/watch_queue.h
 create mode 100644 samples/watch_queue/Makefile
 create mode 100644 samples/watch_queue/watch_test.c

