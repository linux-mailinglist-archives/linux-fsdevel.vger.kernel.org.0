Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C5C17003A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 14:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgBZNlX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 08:41:23 -0500
Received: from relay.sw.ru ([185.231.240.75]:44730 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgBZNlX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:41:23 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j6wvx-0006rW-Gc; Wed, 26 Feb 2020 16:41:05 +0300
Subject: [PATCH RFC 3/5] fs: Add fallocate2() syscall
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     tytso@mit.edu, viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        snitzer@redhat.com, jack@suse.cz, ebiggers@google.com,
        riteshh@linux.ibm.com, krisman@collabora.com, surajjs@amazon.com,
        ktkhai@virtuozzo.com, dmonakhov@gmail.com,
        mbobrowski@mbobrowski.org, enwlinux@gmail.com, sblbir@amazon.com,
        khazhy@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 26 Feb 2020 16:41:05 +0300
Message-ID: <158272446537.281342.16679772209236495407.stgit@localhost.localdomain>
In-Reply-To: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This introduces a new syscall and propagates @physical there.
Also, architecture-dependent definitions for x86 are added.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl |    1 +
 arch/x86/ia32/sys_ia32.c               |   10 ++++++++++
 fs/open.c                              |   16 +++++++++++++---
 include/linux/syscalls.h               |    8 +++++++-
 5 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c17cb77eb150..62b3692df584 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -442,3 +442,4 @@
 435	i386	clone3			sys_clone3			__ia32_sys_clone3
 437	i386	openat2			sys_openat2			__ia32_sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
+486	i386	fallocate2		sys_fallocate2			__ia32_compat_sys_x86_fallocate2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 44d510bc9b78..b106a39509ee 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -359,6 +359,7 @@
 435	common	clone3			__x64_sys_clone3/ptregs
 437	common	openat2			__x64_sys_openat2
 438	common	pidfd_getfd		__x64_sys_pidfd_getfd
+486	common	fallocate2		__x64_sys_fallocate2
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index 21790307121e..1757bfe1a19c 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -230,6 +230,16 @@ COMPAT_SYSCALL_DEFINE6(x86_fallocate, int, fd, int, mode,
 			      ((u64)len_hi << 32) | len_lo);
 }
 
+COMPAT_SYSCALL_DEFINE6(x86_fallocate2, int, fd, int, mode,
+		       unsigned int, offset_lo, unsigned int, offset_hi,
+		       unsigned int, len_lo, unsigned int, len_hi,
+		       unsigned int physical_lo, unsigned int physical_hi)
+{
+	return ksys_fallocate2(fd, mode, ((u64)offset_hi << 32) | offset_lo,
+			      ((u64)len_hi << 32) | len_lo,
+			      ((u64)physical_hi << 32) | physical_lo);
+}
+
 /*
  * The 32-bit clone ABI is CONFIG_CLONE_BACKWARDS
  */
diff --git a/fs/open.c b/fs/open.c
index 596fd3dc3988..1b964a37ecc2 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -290,6 +290,10 @@ int vfs_fallocate(struct file *file, int mode,
 	if (ret)
 		return ret;
 
+	if (physical != (u64)-1 &&
+	    !ns_capable(inode->i_sb->s_user_ns, CAP_FOWNER))
+		return -EPERM;
+
 	if (S_ISFIFO(inode->i_mode))
 		return -ESPIPE;
 
@@ -324,13 +328,13 @@ int vfs_fallocate(struct file *file, int mode,
 }
 EXPORT_SYMBOL_GPL(vfs_fallocate);
 
-int ksys_fallocate(int fd, int mode, loff_t offset, loff_t len)
+int ksys_fallocate2(int fd, int mode, loff_t offset, loff_t len, u64 physical)
 {
 	struct fd f = fdget(fd);
 	int error = -EBADF;
 
 	if (f.file) {
-		error = vfs_fallocate(f.file, mode, offset, len, (u64)-1);
+		error = vfs_fallocate(f.file, mode, offset, len, physical);
 		fdput(f);
 	}
 	return error;
@@ -338,7 +342,13 @@ int ksys_fallocate(int fd, int mode, loff_t offset, loff_t len)
 
 SYSCALL_DEFINE4(fallocate, int, fd, int, mode, loff_t, offset, loff_t, len)
 {
-	return ksys_fallocate(fd, mode, offset, len);
+	return ksys_fallocate2(fd, mode, offset, len, (u64)-1);
+}
+
+SYSCALL_DEFINE5(fallocate2, int, fd, int, mode, loff_t, offset, loff_t, len,
+		unsigned long long, physical)
+{
+	return ksys_fallocate2(fd, mode, offset, len, physical);
 }
 
 /*
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1815065d52f3..1999493b03e9 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -427,6 +427,8 @@ asmlinkage long sys_truncate64(const char __user *path, loff_t length);
 asmlinkage long sys_ftruncate64(unsigned int fd, loff_t length);
 #endif
 asmlinkage long sys_fallocate(int fd, int mode, loff_t offset, loff_t len);
+asmlinkage long sys_fallocate2(int fd, int mode, loff_t offset, loff_t len,
+			       unsigned long long physical);
 asmlinkage long sys_faccessat(int dfd, const char __user *filename, int mode);
 asmlinkage long sys_chdir(const char __user *filename);
 asmlinkage long sys_fchdir(unsigned int fd);
@@ -1255,7 +1257,11 @@ ssize_t ksys_pread64(unsigned int fd, char __user *buf, size_t count,
 		     loff_t pos);
 ssize_t ksys_pwrite64(unsigned int fd, const char __user *buf,
 		      size_t count, loff_t pos);
-int ksys_fallocate(int fd, int mode, loff_t offset, loff_t len);
+int ksys_fallocate2(int fd, int mode, loff_t offset, loff_t len, u64 physical);
+static inline int ksys_fallocate(int fd, int mode, loff_t offset, loff_t len)
+{
+	return ksys_fallocate2(fd, mode, offset, len, (u64)-1);
+}
 #ifdef CONFIG_ADVISE_SYSCALLS
 int ksys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice);
 #else


