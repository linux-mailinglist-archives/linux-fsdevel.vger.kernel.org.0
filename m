Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3082F20659
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 14:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfEPLwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 07:52:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfEPLwG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 07:52:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 85A0AD77F2;
        Thu, 16 May 2019 11:52:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EF92100203C;
        Thu, 16 May 2019 11:52:04 +0000 (UTC)
Subject: [PATCH 0/4] uapi, vfs: Change the mount API UAPI [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     Christian Brauner <christian@brauner.io>,
        Arnd Bergmann <arnd@arndb.de>, dhowells@redhat.com,
        christian@brauner.io, arnd@arndb.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 16 May 2019 12:52:04 +0100
Message-ID: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 16 May 2019 11:52:06 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Linus, Al,

Here are some patches that make changes to the mount API UAPI and two of
them really need applying, before -rc1 - if they're going to be applied at
all.

The following changes are made:

 (1) Make the file descriptors returned by open_tree(), fsopen(), fspick()
     and fsmount() O_CLOEXEC by default and remove the flags that allow
     this to be specified from the UAPI, shuffling other flags down as
     appropriate.  fcntl() can still be used to change the flag.

 (2) Make the name of the anon inode object "[fscontext]" with square
     brackets to match other users.

 (3) Fix the numbering of the mount API syscalls to be in the common space
     rather than in the arch-specific space.

 (4) Wire up the mount API syscalls on all arches (it's only on x86
     currently).

Thanks,
David
---
Christian Brauner (2):
      uapi, fs: make all new mount api fds cloexec by default
      uapi, fsopen: use square brackets around "fscontext"

David Howells (2):
      uapi, x86: Fix the syscall numbering of the mount API syscalls
      uapi: Wire up the mount API syscalls on non-x86 arches


 arch/alpha/kernel/syscalls/syscall.tbl      |    6 ++++++
 arch/arm/tools/syscall.tbl                  |    6 ++++++
 arch/arm64/include/asm/unistd.h             |    2 +-
 arch/arm64/include/asm/unistd32.h           |   12 ++++++++++++
 arch/ia64/kernel/syscalls/syscall.tbl       |    6 ++++++
 arch/m68k/kernel/syscalls/syscall.tbl       |    6 ++++++
 arch/microblaze/kernel/syscalls/syscall.tbl |    6 ++++++
 arch/mips/kernel/syscalls/syscall_n32.tbl   |    6 ++++++
 arch/mips/kernel/syscalls/syscall_n64.tbl   |    6 ++++++
 arch/mips/kernel/syscalls/syscall_o32.tbl   |    6 ++++++
 arch/parisc/kernel/syscalls/syscall.tbl     |    6 ++++++
 arch/powerpc/kernel/syscalls/syscall.tbl    |    6 ++++++
 arch/s390/kernel/syscalls/syscall.tbl       |    6 ++++++
 arch/sh/kernel/syscalls/syscall.tbl         |    6 ++++++
 arch/sparc/kernel/syscalls/syscall.tbl      |    6 ++++++
 arch/x86/entry/syscalls/syscall_32.tbl      |   12 ++++++------
 arch/x86/entry/syscalls/syscall_64.tbl      |   12 ++++++------
 arch/xtensa/kernel/syscalls/syscall.tbl     |    6 ++++++
 fs/fsopen.c                                 |   15 +++++++--------
 fs/namespace.c                              |   11 ++++-------
 include/uapi/asm-generic/unistd.h           |   14 +++++++++++++-
 include/uapi/linux/mount.h                  |   18 +++---------------
 22 files changed, 136 insertions(+), 44 deletions(-)

