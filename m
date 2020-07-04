Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D09214644
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 16:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgGDODE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 10:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbgGDODD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 10:03:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8842A21707;
        Sat,  4 Jul 2020 14:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593871383;
        bh=URxPKIHQL7SkJXwUkdzXDCnSnjDxxoHjfZVsU7XPN0c=;
        h=From:To:Cc:Subject:Date:From;
        b=lNw6k9kfAw5gsYe5uk+i6vpwYxW8sPZrQ3zJh/DdSYq5sBWnedFlAfvfydfdhzSd/
         5pD7iKApSSjp/0/TIeK4LE8RucNAdRx2g8DQbmGxgcmX0CicZUyaelPskm+wN3Udro
         ecZ+W68QdR9MKn44hzZwB/Q+1X+dQevcyOI6Dnlw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, mtk.manpages@gmail.com, shuah@kernel.org,
        linux-api@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/3] readfile(2): a new syscall to make open/read/close faster
Date:   Sat,  4 Jul 2020 16:02:46 +0200
Message-Id: <20200704140250.423345-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here is a tiny new syscall, readfile, that makes it simpler to read
small/medium sized files all in one shot, no need to do open/read/close.
This is especially helpful for tools that poke around in procfs or
sysfs, making a little bit of a less system load than before, especially
as syscall overheads go up over time due to various CPU bugs being
addressed.

There are 4 patches in this series, the first 3 are against the kernel
tree, adding the syscall logic, wiring up the syscall, and adding some
tests for it.

The last patch is agains the man-pages project, adding a tiny man page
to try to describe the new syscall.

Greg Kroah-Hartman (3):
  readfile: implement readfile syscall
  arch: wire up the readfile syscall
  selftests: add readfile(2) selftests

 arch/alpha/kernel/syscalls/syscall.tbl        |   1 +
 arch/arm/tools/syscall.tbl                    |   1 +
 arch/arm64/include/asm/unistd.h               |   2 +-
 arch/arm64/include/asm/unistd32.h             |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl         |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   1 +
 arch/s390/kernel/syscalls/syscall.tbl         |   1 +
 arch/sh/kernel/syscalls/syscall.tbl           |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   1 +
 fs/open.c                                     |  50 +++
 include/linux/syscalls.h                      |   2 +
 include/uapi/asm-generic/unistd.h             |   4 +-
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/readfile/.gitignore   |   3 +
 tools/testing/selftests/readfile/Makefile     |   7 +
 tools/testing/selftests/readfile/readfile.c   | 285 +++++++++++++++++
 .../selftests/readfile/readfile_speed.c       | 301 ++++++++++++++++++
 26 files changed, 671 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/readfile/.gitignore
 create mode 100644 tools/testing/selftests/readfile/Makefile
 create mode 100644 tools/testing/selftests/readfile/readfile.c
 create mode 100644 tools/testing/selftests/readfile/readfile_speed.c

-- 
2.27.0

