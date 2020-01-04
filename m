Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42E71130452
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2020 21:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgADUOp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jan 2020 15:14:45 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47620 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbgADUOp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jan 2020 15:14:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 73AD98EE0CE;
        Sat,  4 Jan 2020 12:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578168884;
        bh=zM7+7DFvsiBPk7tfDGZXOFtrD1VDnie83HxJ+OuS48w=;
        h=From:To:Cc:Subject:Date:From;
        b=mSZE0c8mb/i+3j4AAWyELcC5o2tsISRtg9t1i2pU1xhJllemJKHYFruTfm6+gn6Um
         SV2CEoKZ7jGaxk4871NbZOizxaJw5r0BY7h9TKfCHj4fHg81XqVF+kQigpn6FAwm3K
         fxNTRjNkIQwaYTYHgyDkojPrhgLm4XyJHo7KCgvg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HqYXig1H8PJZ; Sat,  4 Jan 2020 12:14:43 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1E65F8EE079;
        Sat,  4 Jan 2020 12:14:43 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v2 0/6] introduce configfd as generalisation of fsconfig
Date:   Sat,  4 Jan 2020 12:14:26 -0800
Message-Id: <20200104201432.27320-1-James.Bottomley@HansenPartnership.com>
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

v1 of this patch series was originally sent as an rfc in reply to a
thread about feature bugs with the new mount API:

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
 fs/Makefile                                 |   3 +-
 fs/bind.c                                   | 232 ++++++++++++
 fs/configfd.c                               | 450 +++++++++++++++++++++++
 fs/filesystems.c                            |   8 +-
 fs/fs_context.c                             | 124 +------
 fs/fsopen.c                                 | 535 ++++++++++++++--------------
 fs/internal.h                               |   7 +
 fs/namespace.c                              | 115 +++---
 include/linux/configfd.h                    |  61 ++++
 include/linux/fs.h                          |   2 +
 include/linux/fs_context.h                  |  29 +-
 include/linux/fs_parser.h                   |   2 +
 include/linux/logger.h                      |  34 ++
 include/linux/syscalls.h                    |   5 +
 include/uapi/asm-generic/unistd.h           |   7 +-
 include/uapi/linux/configfd.h               |  20 ++
 lib/Makefile                                |   3 +-
 lib/logger.c                                | 211 +++++++++++
 36 files changed, 1413 insertions(+), 473 deletions(-)
 create mode 100644 fs/bind.c
 create mode 100644 fs/configfd.c
 create mode 100644 include/linux/configfd.h
 create mode 100644 include/linux/logger.h
 create mode 100644 include/uapi/linux/configfd.h
 create mode 100644 lib/logger.c

-- 
2.16.4

