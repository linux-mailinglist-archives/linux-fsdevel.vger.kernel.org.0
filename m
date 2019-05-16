Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB51204A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 13:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfEPLYJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 07:24:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfEPLYJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 07:24:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD92687645;
        Thu, 16 May 2019 11:24:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0740818394;
        Thu, 16 May 2019 11:24:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/4] uapi: Wire up the mount API syscalls on non-x86 arches
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     Arnd Bergmann <arnd@arndb.de>, dhowells@redhat.com,
        christian@brauner.io, arnd@arndb.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 16 May 2019 12:24:06 +0100
Message-ID: <155800584626.26930.8723624357941420192.stgit@warthog.procyon.org.uk>
In-Reply-To: <155800581545.26930.2167325198332902897.stgit@warthog.procyon.org.uk>
References: <155800581545.26930.2167325198332902897.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 16 May 2019 11:24:08 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wire up the mount API syscalls on non-x86 arches.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/alpha/kernel/syscalls/syscall.tbl      |    6 ++++++
 arch/arm/tools/syscall.tbl                  |    6 ++++++
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
 arch/xtensa/kernel/syscalls/syscall.tbl     |    6 ++++++
 include/uapi/asm-generic/unistd.h           |   14 +++++++++++++-
 16 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 165f268beafc..9e7704e44f6d 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -467,3 +467,9 @@
 535	common	io_uring_setup			sys_io_uring_setup
 536	common	io_uring_enter			sys_io_uring_enter
 537	common	io_uring_register		sys_io_uring_register
+538	common	open_tree			sys_open_tree
+539	common	move_mount			sys_move_mount
+540	common	fsopen				sys_fsopen
+541	common	fsconfig			sys_fsconfig
+542	common	fsmount				sys_fsmount
+543	common	fspick				sys_fspick
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 0393917eaa57..aaf479a9e92d 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -441,3 +441,9 @@
 425	common	io_uring_setup			sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 23f1a44acada..3734789e9f25 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -874,6 +874,18 @@ __SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
 __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
 #define __NR_io_uring_register 427
 __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
+#define __NR_open_tree 428
+__SYSCALL(__NR_open_tree, open_tree)
+#define __NR_move_mount 429
+__SYSCALL(__NR_move_mount, move_mount)
+#define __NR_fsopen 430
+__SYSCALL(__NR_fsopen, fsopen)
+#define __NR_fsconfig 431
+__SYSCALL(__NR_fsconfig, fsconfig)
+#define __NR_fsmount 432
+__SYSCALL(__NR_fsmount, fsmount)
+#define __NR_fspick 433
+__SYSCALL(__NR_fspick, fspick)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 56e3d0b685e1..e01df3f2f80d 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -348,3 +348,9 @@
 425	common	io_uring_setup			sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index df4ec3ec71d1..7e3d0734b2f3 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -427,3 +427,9 @@
 425	common	io_uring_setup			sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 4964947732af..26339e417695 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -433,3 +433,9 @@
 425	common	io_uring_setup			sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 9392dfe33f97..0e2dd68ade57 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -366,3 +366,9 @@
 425	n32	io_uring_setup			sys_io_uring_setup
 426	n32	io_uring_enter			sys_io_uring_enter
 427	n32	io_uring_register		sys_io_uring_register
+428	n32	open_tree			sys_open_tree
+429	n32	move_mount			sys_move_mount
+430	n32	fsopen				sys_fsopen
+431	n32	fsconfig			sys_fsconfig
+432	n32	fsmount				sys_fsmount
+433	n32	fspick				sys_fspick
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index cd0c8aa21fba..5eebfa0d155c 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -342,3 +342,9 @@
 425	n64	io_uring_setup			sys_io_uring_setup
 426	n64	io_uring_enter			sys_io_uring_enter
 427	n64	io_uring_register		sys_io_uring_register
+428	n64	open_tree			sys_open_tree
+429	n64	move_mount			sys_move_mount
+430	n64	fsopen				sys_fsopen
+431	n64	fsconfig			sys_fsconfig
+432	n64	fsmount				sys_fsmount
+433	n64	fspick				sys_fspick
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index e849e8ffe4a2..3cc1374e02d0 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -415,3 +415,9 @@
 425	o32	io_uring_setup			sys_io_uring_setup
 426	o32	io_uring_enter			sys_io_uring_enter
 427	o32	io_uring_register		sys_io_uring_register
+428	o32	open_tree			sys_open_tree
+429	o32	move_mount			sys_move_mount
+430	o32	fsopen				sys_fsopen
+431	o32	fsconfig			sys_fsconfig
+432	o32	fsmount				sys_fsmount
+433	o32	fspick				sys_fspick
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index fe8ca623add8..c9e377d59232 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -424,3 +424,9 @@
 425	common	io_uring_setup			sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 00f5a63c8d9a..103655d84b4b 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -509,3 +509,9 @@
 425	common	io_uring_setup			sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 061418f787c3..e822b2964a83 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -430,3 +430,9 @@
 425  common	io_uring_setup		sys_io_uring_setup              sys_io_uring_setup
 426  common	io_uring_enter		sys_io_uring_enter              sys_io_uring_enter
 427  common	io_uring_register	sys_io_uring_register           sys_io_uring_register
+428  common	open_tree		sys_open_tree			sys_open_tree
+429  common	move_mount		sys_move_mount			sys_move_mount
+430  common	fsopen			sys_fsopen			sys_fsopen
+431  common	fsconfig		sys_fsconfig			sys_fsconfig
+432  common	fsmount			sys_fsmount			sys_fsmount
+433  common	fspick			sys_fspick			sys_fspick
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 480b057556ee..016a727d4357 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -430,3 +430,9 @@
 425	common	io_uring_setup			sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index a1dd24307b00..e047480b1605 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -473,3 +473,9 @@
 425	common	io_uring_setup			sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 30084eaf8422..5fa0ee1c8e00 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -398,3 +398,9 @@
 425	common	io_uring_setup			sys_io_uring_setup
 426	common	io_uring_enter			sys_io_uring_enter
 427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index dee7292e1df6..29bf3bbcce78 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -832,9 +832,21 @@ __SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
 __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
 #define __NR_io_uring_register 427
 __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
+#define __NR_open_tree 428
+__SYSCALL(__NR_open_tree, open_tree)
+#define __NR_move_mount 429
+__SYSCALL(__NR_move_mount, move_mount)
+#define __NR_fsopen 430
+__SYSCALL(__NR_fsopen, fsopen)
+#define __NR_fsconfig 431
+__SYSCALL(__NR_fsconfig, fsconfig)
+#define __NR_fsmount 432
+__SYSCALL(__NR_fsmount, fsmount)
+#define __NR_fspick 433
+__SYSCALL(__NR_fspick, fspick)
 
 #undef __NR_syscalls
-#define __NR_syscalls 428
+#define __NR_syscalls 434
 
 /*
  * 32 bit systems traditionally used different

