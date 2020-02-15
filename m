Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0472215FEFB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2020 16:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgBOPgP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Feb 2020 10:36:15 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52956 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726233AbgBOPgO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Feb 2020 10:36:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 204AE8EE306;
        Sat, 15 Feb 2020 07:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581780974;
        bh=yHtGVHids/u1MoVbYrLPD+uad3BTMyTy/oqqLOM7Ji8=;
        h=From:To:Cc:Subject:Date:From;
        b=YFQflOSN1QdOIJqVtGieVZ/uHv6DCI4bXxHxIqGRCwgFEjdDKr6Jy+jJMy4T+jaAX
         XWz9Up3QQxOf/UsD6Z821CGWcyKjPUcS6kmekgemzGwJ7Y87OkSIiKr0vyBFWQ/cze
         Q/+qxSOUXbsLNy+w8F4ejBoiO5TRH2cnGoz01zt4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a2MNEU59LUnz; Sat, 15 Feb 2020 07:36:13 -0800 (PST)
Received: from jarvis.lan (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EE3BF8EE121;
        Sat, 15 Feb 2020 07:36:12 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v3 0/6] introduce configfd as generalisation of fsconfig
Date:   Sat, 15 Feb 2020 10:36:03 -0500
Message-Id: <20200215153609.23797-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fsconfig is a very powerful configuration mechanism except that it
only works for filesystems with superblocks.  This patch series
generalises the useful concept of a multiple step configurational
mechanism carried by a file descriptor.  The object of this patch
series is to get bind mounts to be configurable in the same way that
superblock based ones are, but it should have utility beyond the
filesytem realm.  Patch 4 also reimplements fsconfig in terms of
configfd, but that's not a strictly necessary patch, it is merely a
useful demonstration that configfd is a superset of the properties of
fsconfig.

in v3, I swept up Al's prefix generalisation of the log that he
expanded to use with ceph and rbd, because it's a nice extension to
the original fsconfig log.

The main reason I'm strongly pushing this, is that by my background I
dislike abstractions that aren't abstract enough (have unnecessary
ties to concrete features like fsconfig does to the superblock), so
the physicist in me likes to make them as abstract as possible.  The
objection, in the email replies to v2 is that making something so
powerful too abstract is going to encourage incorrect reuse and thus
cause problems because using an interface of huge power on something
that doesn't need it damages the API confinement and makes unintended
and unexpected uses easy.  I still think this is a wrongheaded
argument because we do have subsystems that need powerful config
interfaces and we should have the taste to ensure the full power is
only used there, but I think it's a useful debate to have.  For
instance, I think the entire annoying keyctl API could usefully deploy
this.

Note: v1 of this patch series was originally sent as an rfc in reply
to a thread about feature bugs with the new mount API:

https://lore.kernel.org/linux-fsdevel/1574295100.17153.25.camel@HansenPartnership.com/

James

---

James Bottomley (6):
  logger: add a limited buffer logging facility
  configfd: add generic file descriptor based configuration parser
  configfd: syscall: wire up configfd syscalls
  fs: implement fsconfig via configfd
  fs: expose internal interfaces open_detached_copy and
    do_reconfigure_mount
  fs: bind: add configfs type for bind mounts

 arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
 arch/arm/tools/syscall.tbl                  |   2 +
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |   4 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   2 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   2 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
 arch/s390/kernel/syscalls/syscall.tbl       |   2 +
 arch/sh/kernel/syscalls/syscall.tbl         |   2 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
 drivers/block/rbd.c                         |   2 +-
 fs/Makefile                                 |   3 +-
 fs/bind.c                                   | 232 ++++++++++++
 fs/ceph/super.c                             |   4 +-
 fs/configfd.c                               | 451 ++++++++++++++++++++++++
 fs/filesystems.c                            |   8 +-
 fs/fs_context.c                             |  97 +----
 fs/fs_parser.c                              |  24 +-
 fs/fsopen.c                                 | 529 ++++++++++++++--------------
 fs/internal.h                               |   7 +
 fs/namespace.c                              | 115 +++---
 include/linux/ceph/libceph.h                |   5 +-
 include/linux/configfd.h                    |  61 ++++
 include/linux/fs.h                          |   2 +
 include/linux/fs_context.h                  |  58 ++-
 include/linux/fs_parser.h                   |   9 +-
 include/linux/logger.h                      |  45 +++
 include/linux/syscalls.h                    |   5 +
 include/uapi/asm-generic/unistd.h           |   9 +-
 include/uapi/linux/configfd.h               |  20 ++
 lib/Makefile                                |   3 +-
 lib/logger.c                                | 190 ++++++++++
 net/ceph/ceph_common.c                      |  26 +-
 41 files changed, 1457 insertions(+), 486 deletions(-)
 create mode 100644 fs/bind.c
 create mode 100644 fs/configfd.c
 create mode 100644 include/linux/configfd.h
 create mode 100644 include/linux/logger.h
 create mode 100644 include/uapi/linux/configfd.h
 create mode 100644 lib/logger.c

-- 
2.16.4

