Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06DA8D826A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 23:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbfJOVry (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 17:47:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730483AbfJOVry (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:47:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F49E10DCC81;
        Tue, 15 Oct 2019 21:47:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8CA560852;
        Tue, 15 Oct 2019 21:47:49 +0000 (UTC)
Subject: [RFC PATCH 00/21] pipe: Keyrings, Block and USB notifications
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 15 Oct 2019 22:47:48 +0100
Message-ID: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Tue, 15 Oct 2019 21:47:53 +0000 (UTC)
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


Design decisions:

 (1) The notification queue is built on top of a standard pipe.  Messages are
     effectively spliced in.

	pipe2(fds, O_TMPFILE); // Note that O_TMPFILE is just hacked in atm

     which is then configured::

	ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, queue_depth);
	ioctl(fds[1], IOC_WATCH_QUEUE_SET_FILTER, &filter);

     Messages are then read out of the pipe using read().

 (2) It should be possible to allow write() to insert data into the
     notification pipes too, but this is currently disabled as the kernel has
     to be able to insert messages into the pipe *without* holding pipe->mutex
     and the code to make this work needs careful auditing.

 (3) sendfile(), splice() and vmsplice() are disabled on notification pipes
     because of the pipe->mutex issue and also because they sometimes want to
     revert what they just did - but one or more notification messages
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

 (7) Notification pipes don't interfere with each other; each may be bound to
     a different set of watches.  Any particular notification will be copied
     to all the queues that are currently watching for it - and only those
     that are watching for it.

 (8) When recording a notification, the kernel will not sleep, but will rather
     mark a queue as having lost a message if there's insufficient space.
     read() will fabricate a loss notification message at an appropriate point
     later.

 (9) The notification pipe is created and then watchpoints are attached to it,
     using one of:

	keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fds[1], 0x01);
	watch_devices(fds[1], 0x02, 0);

     where in both cases, fd indicates the queue and the number after is a
     tag between 0 and 255.

(10) Watches are removed if either the notification pipe is destroyed or the
     watched object is destroyed.  In the latter case, a message will be
     generated indicating the enforced watch removal.


Things I want to avoid:

 (1) Introducing features that make the core VFS dependent on the network
     stack or networking namespaces (ie. usage of netlink).

 (2) Dumping all this stuff into dmesg and having a daemon that sits there
     parsing the output and distributing it as this then puts the
     responsibility for security into userspace and makes handling
     namespaces tricky.  Further, dmesg might not exist or might be
     inaccessible inside a container.

 (3) Letting users see events they shouldn't be able to see.


Benchmarks:

PATCHES BENCHMARK	BEST		TOTAL BYTES	AVG BYTES	STDDEV
======= =============== =============== =============== =============== ===============
0	pipe		      305798752	    36324188187	      302701568		6128384
0	vmsplice	      432261032	    49377769035	      411481408	       60638553
0	splice		      284943309	    27769149338	      231409577	      171374033

prelock pipe		      307500893	    36470120589	      303917671		9970065
prelock vmsplice	      437991897	    51502859114	      429190492	       22841773
prelock splice		      285469128	    28158931451	      234657762	      138350254

ht	pipe		      304526362	    35934813852	      299456782	       14371537
ht	vmsplice	      437819690	    51481865190	      429015543	       25713854
ht	splice		      242954439	    23296773094	      194139775	      148906490

r	pipe		      306166161	    36117069156	      300975576	       11493141
r	vmsplice	      335931911	    39837793527	      331981612		9098195
r	splice		      282334654	    27472565449	      228938045	      219399557

rx	pipe		      304664843	    36059231110	      300493592		9800700
rx	vmsplice	      446602247	    52216984680	      435141539	       31456017
rx	splice		      277978890	    26516522263	      220971018	      199170870

rxw	pipe		      304180415	    36317294286	      302644119		5967557
rxw	vmsplice	      447361082	    51238998643	      426991655	       62191270
rxw	splice		      277213923	    27627387718	      230228230	      173675370

rxwx	pipe		      305390974	    36110185475	      300918212	       11895583
rxwx	vmsplice	      445372781	    50668744616	      422239538	       63133543
rxwx	splice		      280218603	    27677264384	      230643869	      196958675

rxwxf	pipe		      305001592	    36325565843	      302713048		7551300
rxwxf	vmsplice	      444316544	    50213093070	      418442442	       77117994
rxwxf	splice		      278371338	    28859765396	      240498044	      160245812

all	pipe		      298858861	    35543407781	      296195064		5173617
all	vmsplice	      453414388	    53792295991	      448269133	       10914547
all	splice		      279264055	    26812726990	      223439391	      212421416

The patches column indicates the point in the patchset at which the benchmarks
were taken:

	0	No patches
	prelock "Add a prelocked wake-up"
	hr	"pipe: Use head and tail pointers for the ring, not cursor and length"
	r	"pipe: Advance tail pointer inside of wait spinlock in pipe_read()"
	rx	"pipe: Conditionalise wakeup in pipe_read()"
	rxw	"pipe: Rearrange sequence in pipe_write() to preallocate slot"
	rxwx	"pipe: Remove redundant wakeup from pipe_write()"
	rxwxf	"pipe: Check for ring full inside of the spinlock in pipe_write()"
	all	All of the patches

The benchmark programs can be found here:

	http://people.redhat.com/dhowells/pipe-bench.c
	http://people.redhat.com/dhowells/vmsplice-bench.c
	http://people.redhat.com/dhowells/splice-bench.c

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=pipe-experimental

Changes:

 ver #1:

 (*) Build on top of standard pipes instead of having a driver.

David
---
David Howells (21):
      pipe: Reduce #inclusion of pipe_fs_i.h
      Add a prelocked wake-up
      pipe: Use head and tail pointers for the ring, not cursor and length
      pipe: Advance tail pointer inside of wait spinlock in pipe_read()
      pipe: Conditionalise wakeup in pipe_read()
      pipe: Rearrange sequence in pipe_write() to preallocate slot
      pipe: Remove redundant wakeup from pipe_write()
      pipe: Check for ring full inside of the spinlock in pipe_write()
      uapi: General notification queue definitions
      security: Add hooks to rule on setting a watch
      security: Add a hook for the point of notification insertion
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


 Documentation/ioctl/ioctl-number.rst        |    1 
 Documentation/security/keys/core.rst        |   58 ++
 Documentation/watch_queue.rst               |  385 ++++++++++++++++
 arch/alpha/kernel/syscalls/syscall.tbl      |    1 
 arch/arm/tools/syscall.tbl                  |    1 
 arch/arm64/include/asm/unistd.h             |    2 
 arch/arm64/include/asm/unistd32.h           |    2 
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
 drivers/base/watch.c                        |   90 ++++
 drivers/usb/core/Kconfig                    |    9 
 drivers/usb/core/devio.c                    |   47 ++
 drivers/usb/core/hub.c                      |    4 
 fs/exec.c                                   |    1 
 fs/fuse/dev.c                               |   31 +
 fs/ocfs2/aops.c                             |    1 
 fs/pipe.c                                   |  392 +++++++++++-----
 fs/splice.c                                 |  195 +++++---
 include/linux/blkdev.h                      |   15 +
 include/linux/device.h                      |    7 
 include/linux/key.h                         |    3 
 include/linux/lsm_audit.h                   |    1 
 include/linux/lsm_hooks.h                   |   38 ++
 include/linux/pipe_fs_i.h                   |   63 ++-
 include/linux/security.h                    |   32 +
 include/linux/syscalls.h                    |    1 
 include/linux/uio.h                         |    4 
 include/linux/usb.h                         |   18 +
 include/linux/wait.h                        |    2 
 include/linux/watch_queue.h                 |  127 +++++
 include/uapi/asm-generic/unistd.h           |    4 
 include/uapi/linux/keyctl.h                 |    2 
 include/uapi/linux/watch_queue.h            |  155 ++++++
 init/Kconfig                                |   12 
 kernel/Makefile                             |    1 
 kernel/sched/wait.c                         |    7 
 kernel/sys_ni.c                             |    1 
 kernel/watch_queue.c                        |  660 +++++++++++++++++++++++++++
 lib/iov_iter.c                              |  274 +++++++----
 samples/Kconfig                             |    7 
 samples/Makefile                            |    1 
 samples/watch_queue/Makefile                |    7 
 samples/watch_queue/watch_test.c            |  252 ++++++++++
 security/keys/Kconfig                       |    9 
 security/keys/compat.c                      |    3 
 security/keys/gc.c                          |    5 
 security/keys/internal.h                    |   30 +
 security/keys/key.c                         |   38 +-
 security/keys/keyctl.c                      |   99 ++++
 security/keys/keyring.c                     |   20 +
 security/keys/request_key.c                 |    4 
 security/security.c                         |   23 +
 security/selinux/hooks.c                    |   14 +
 security/smack/smack_lsm.c                  |   83 +++
 70 files changed, 2927 insertions(+), 377 deletions(-)
 create mode 100644 Documentation/watch_queue.rst
 create mode 100644 drivers/base/watch.c
 create mode 100644 include/linux/watch_queue.h
 create mode 100644 include/uapi/linux/watch_queue.h
 create mode 100644 kernel/watch_queue.c
 create mode 100644 samples/watch_queue/Makefile
 create mode 100644 samples/watch_queue/watch_test.c

