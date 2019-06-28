Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 493BD59FCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfF1PuT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:50:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28577 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfF1PuT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:50:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40B133082131;
        Fri, 28 Jun 2019 15:50:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 699755C553;
        Fri, 28 Jun 2019 15:50:14 +0000 (UTC)
Subject: [PATCH 0/6] Mount and superblock notifications [ver #5]
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
Date:   Fri, 28 Jun 2019 16:50:13 +0100
Message-ID: <156173701358.15650.8735203424342507015.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 28 Jun 2019 15:50:18 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a set of patches to adds VFS-related watches to the general
notification system to add sources of events for:

 (1) Mount topology events, such as mounting, unmounting, mount expiry,
     mount reconfiguration.

 (2) Superblock events, such as R/W<->R/O changes, quota overrun and I/O
     errors (not complete yet).

One of the reasons for this is so that we can remove the issue of processes
having to repeatedly and regularly scan /proc/mounts, which has proven to
be a system performance problem.  To further aid this, the fsinfo() syscall
on which this patch series depends, provides a way to access superblock and
mount information in binary form without the need to parse /proc/mounts.

LSM hooks are included are provided that allow an LSM to rule on whether or
not a watch may be set.  Each of these hooks takes a different "watched
object" parameter, so they're not really shareable.  The LSM should use
current's credentials.  [Wanted by SELinux & Smack]

Watches are created with:

	watch_mount(AT_FDCWD, "/", 0, fd, 0x03);
	watch_sb(AT_FDCWD, "/mnt", 0, fd, 0x04);

where in all three cases, fd indicates the queue and the number after is a
tag between 0 and 255.

Further things that could be considered:

 (1) Adding global superblock event queue.

 (2) Propagating watches to child superblock over automounts.


The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=notifications

Changes:

 ver #5:

 (*) The superblock watch and mount watch parts are split out into this set
     from the core branch (notifications-core) as it depends on fsinfo().

David
---
David Howells (6):
      security: Add hooks to rule on setting a superblock or mount watch
      Adjust watch_queue documentation to mention mount and superblock watches.
      vfs: Add a mount-notification facility
      vfs: Add superblock notifications
      fsinfo: Export superblock notification counter
      Add sample notification program


 Documentation/watch_queue.rst               |   20 +++
 arch/alpha/kernel/syscalls/syscall.tbl      |    2 
 arch/arm/tools/syscall.tbl                  |    2 
 arch/arm64/include/asm/unistd.h             |    2 
 arch/ia64/kernel/syscalls/syscall.tbl       |    2 
 arch/m68k/kernel/syscalls/syscall.tbl       |    2 
 arch/microblaze/kernel/syscalls/syscall.tbl |    2 
 arch/mips/kernel/syscalls/syscall_n32.tbl   |    2 
 arch/mips/kernel/syscalls/syscall_n64.tbl   |    2 
 arch/mips/kernel/syscalls/syscall_o32.tbl   |    2 
 arch/parisc/kernel/syscalls/syscall.tbl     |    2 
 arch/powerpc/kernel/syscalls/syscall.tbl    |    2 
 arch/s390/kernel/syscalls/syscall.tbl       |    2 
 arch/sh/kernel/syscalls/syscall.tbl         |    2 
 arch/sparc/kernel/syscalls/syscall.tbl      |    2 
 arch/x86/entry/syscalls/syscall_32.tbl      |    2 
 arch/x86/entry/syscalls/syscall_64.tbl      |    2 
 arch/xtensa/kernel/syscalls/syscall.tbl     |    2 
 drivers/misc/Kconfig                        |    5 -
 fs/Kconfig                                  |   21 +++
 fs/Makefile                                 |    1 
 fs/fsinfo.c                                 |   12 ++
 fs/mount.h                                  |   33 +++--
 fs/mount_notify.c                           |  188 +++++++++++++++++++++++++++
 fs/namespace.c                              |   16 ++
 fs/super.c                                  |  126 ++++++++++++++++++
 include/linux/dcache.h                      |    1 
 include/linux/fs.h                          |   78 +++++++++++
 include/linux/lsm_hooks.h                   |   16 ++
 include/linux/security.h                    |   10 +
 include/linux/syscalls.h                    |    4 +
 include/uapi/asm-generic/unistd.h           |    6 +
 include/uapi/linux/fsinfo.h                 |   10 +
 include/uapi/linux/watch_queue.h            |   61 +++++++++
 kernel/sys_ni.c                             |    2 
 samples/vfs/test-fsinfo.c                   |   13 ++
 samples/watch_queue/watch_test.c            |   76 +++++++++++
 security/security.c                         |   10 +
 38 files changed, 722 insertions(+), 21 deletions(-)
 create mode 100644 fs/mount_notify.c

