Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C684201D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 10:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfEPI6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 04:58:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:35034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726942AbfEPI6a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 04:58:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01077AF96;
        Thu, 16 May 2019 08:58:28 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Azat Khuzhin <azat@libevent.org>, Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/13] epoll: implement epoll_create2() syscall
Date:   Thu, 16 May 2019 10:58:10 +0200
Message-Id: <20190516085810.31077-14-rpenyaev@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190516085810.31077-1-rpenyaev@suse.de>
References: <20190516085810.31077-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

epoll_create2() is needed to accept EPOLL_USERPOLL flags
and size, i.e. this patch wires up polling from userspace.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 4cd5f982b1e5..f0d271875f4e 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -438,3 +438,4 @@
 425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
 426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
 427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
+428	i386	epoll_create2		sys_epoll_create2		__ia32_sys_epoll_create2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 64ca0d06259a..5ee9bb31a552 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,7 @@
 425	common	io_uring_setup		__x64_sys_io_uring_setup
 426	common	io_uring_enter		__x64_sys_io_uring_enter
 427	common	io_uring_register	__x64_sys_io_uring_register
+428	common	epoll_create2		__x64_sys_epoll_create2
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 9ff666ce7cb5..b44c3a0c4ad0 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2614,6 +2614,14 @@ static int do_epoll_create(int flags, size_t size)
 	return error;
 }
 
+SYSCALL_DEFINE2(epoll_create2, int, flags, size_t, size)
+{
+	if (size == 0)
+		return -EINVAL;
+
+	return do_epoll_create(flags, size);
+}
+
 SYSCALL_DEFINE1(epoll_create1, int, flags)
 {
 	return do_epoll_create(flags, 0);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e2870fe1be5b..5049b0d16949 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -358,6 +358,7 @@ asmlinkage long sys_eventfd2(unsigned int count, int flags);
 
 /* fs/eventpoll.c */
 asmlinkage long sys_epoll_create1(int flags);
+asmlinkage long sys_epoll_create2(int flags, size_t size);
 asmlinkage long sys_epoll_ctl(int epfd, int op, int fd,
 				struct epoll_event __user *event);
 asmlinkage long sys_epoll_pwait(int epfd, struct epoll_event __user *events,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index dee7292e1df6..fccfaab366ee 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -832,9 +832,11 @@ __SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
 __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
 #define __NR_io_uring_register 427
 __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
+#define __NR_epoll_create2 428
+__SYSCALL(__NR_epoll_create2, sys_epoll_create2)
 
 #undef __NR_syscalls
-#define __NR_syscalls 428
+#define __NR_syscalls 429
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 4d9ae5ea6caf..665908b8a326 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -65,6 +65,7 @@ COND_SYSCALL(eventfd2);
 
 /* fs/eventfd.c */
 COND_SYSCALL(epoll_create1);
+COND_SYSCALL(epoll_create2);
 COND_SYSCALL(epoll_ctl);
 COND_SYSCALL(epoll_pwait);
 COND_SYSCALL_COMPAT(epoll_pwait);
-- 
2.21.0

