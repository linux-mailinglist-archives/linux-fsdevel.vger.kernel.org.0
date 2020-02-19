Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D40164719
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 15:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgBSOfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 09:35:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58213 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727986AbgBSOfN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582122910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fpoM0WyyM9RlSX+rdLWL9WO7tB4LcLSMaXI/USbEBlU=;
        b=fL05iedqNEWzHI/toN16gRn09f3B1E0tHExXXeCnwOCD1AkVfgYd26xuPy3dOLtq5Hg9FG
        QaTQnzYAoJaE3tNIxHH6P4/nidKk5iVZGecBT7BY24vPHYNhUEoxc45tuxUth05I2UDhcV
        GUdYRoRsw1Gp/0fAcMnLnlUmMSNQjl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-3O6lWnJtOwWARqeVcAEDHA-1; Wed, 19 Feb 2020 09:35:05 -0500
X-MC-Unique: 3O6lWnJtOwWARqeVcAEDHA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 270D010883A4;
        Wed, 19 Feb 2020 14:35:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4FEA5C241;
        Wed, 19 Feb 2020 14:35:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH] vfs: syscalls: Add create_automount() and
 remove_automount()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     coda@cs.cmu.edu, linux-afs@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 19 Feb 2020 14:35:00 +0000
Message-ID: <158212290024.224464.862376690360037918.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add system calls to create and remove mountpoints().  These are modelled
after mkdir and rmdir inside the VFS.  Currently they use the same security
hooks which probably needs fixing.

The calls look like:

 long create_mountpoint(int dfd, const char *path,
			const char *fstype, const char *source,
			const char *params);
 long remove_mountpoint(int dfd, const char *path);

Creation takes an fstype, source and params which the filesystem that owns
the mountpoint gets to filter/interpret.  It is free to reject any
combination of fstype, source and params it cannot store.  source and
params are both optional.

Removal could probably be left to rmdir(), but this gives the option of
applying tighter security checks and also allows me to prevent rmdir from
removing them by accident.

The AFS filesystem is then altered to use these system calls to create and
remove persistent mountpoints in an AFS volume.  create_automount() is
something that AFS needs, but cannot be implemented with, say, symlink().
These substitute for the lack of pioctl() on Linux, supplying the
functionality of VIOC_AFS_CREATE_MT_PT and VIOC_AFS_DELETE_MT_PT.

Also make them usable with tmpfs for testing.  I'm not sure if this is
useful in practice, but I've made tmpfs store the three parameters and just
pass them to mount when triggered.  Note that it doesn't look up the target
filesystem until triggered so as not to load lots of modules until
necessary.

I suspect they're of little of use to NFS, CIFS and autofs, but probably
Coda and maybe Btrfs can make use of them.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: coda@cs.cmu.edu
cc: linux-afs@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: linux-btrfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---

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
 fs/afs/dir.c                                |   50 ++++-
 fs/afs/fsclient.c                           |    9 -
 fs/afs/internal.h                           |    6 -
 fs/afs/mntpt.c                              |   15 -
 fs/afs/yfsclient.c                          |    7 -
 fs/namei.c                                  |  286 ++++++++++++++++++++++++++-
 include/linux/fs.h                          |    6 +
 include/linux/shmem_fs.h                    |    3 
 include/linux/syscalls.h                    |    4 
 include/uapi/asm-generic/unistd.h           |    6 -
 mm/shmem.c                                  |  155 +++++++++++++++
 samples/vfs/Makefile                        |    2 
 29 files changed, 541 insertions(+), 42 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 36d42da7466a..fd93cd515006 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -477,3 +477,5 @@
 # 545 reserved for clone3
 547	common	openat2				sys_openat2
 548	common	pidfd_getfd			sys_pidfd_getfd
+549	common	create_mountpoint		sys_create_mountpoint
+550	common	remove_mountpoint		sys_remove_mountpoint
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 4d1cf74a2caa..e8bd7f3e3e01 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -451,3 +451,5 @@
 435	common	clone3				sys_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	create_mountpoint		sys_create_mountpoint
+440	common	remove_mountpoint		sys_remove_mountpoint
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 1dd22da1c3a9..bc0f923e0e04 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		439
+#define __NR_compat_syscalls		441
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 042911e670b8..750b18716851 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -358,3 +358,5 @@
 # 435 reserved for clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	create_mountpoint		sys_create_mountpoint
+440	common	remove_mountpoint		sys_remove_mountpoint
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index f4f49fcb76d0..33ac1d46d1b7 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -437,3 +437,5 @@
 435	common	clone3				__sys_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	create_mountpoint		sys_create_mountpoint
+440	common	remove_mountpoint		sys_remove_mountpoint
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 4c67b11f9c9e..6fe06375d62f 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -443,3 +443,5 @@
 435	common	clone3				sys_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	create_mountpoint		sys_create_mountpoint
+440	common	remove_mountpoint		sys_remove_mountpoint
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 1f9e8ad636cc..ca6a13ffc520 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -376,3 +376,5 @@
 435	n32	clone3				__sys_clone3
 437	n32	openat2				sys_openat2
 438	n32	pidfd_getfd			sys_pidfd_getfd
+439	n32	create_mountpoint		sys_create_mountpoint
+440	n32	remove_mountpoint		sys_remove_mountpoint
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index c0b9d802dbf6..f0794616205e 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -352,3 +352,5 @@
 435	n64	clone3				__sys_clone3
 437	n64	openat2				sys_openat2
 438	n64	pidfd_getfd			sys_pidfd_getfd
+439	n64	create_mountpoint		sys_create_mountpoint
+440	n64	remove_mountpoint		sys_remove_mountpoint
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index ac586774c980..716714520a53 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -425,3 +425,5 @@
 435	o32	clone3				__sys_clone3
 437	o32	openat2				sys_openat2
 438	o32	pidfd_getfd			sys_pidfd_getfd
+439	o32	create_mountpoint		sys_create_mountpoint
+440	o32	remove_mountpoint		sys_remove_mountpoint
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 52a15f5cd130..d2540b006faf 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -435,3 +435,5 @@
 435	common	clone3				sys_clone3_wrapper
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	create_mountpoint		sys_create_mountpoint
+440	common	remove_mountpoint		sys_remove_mountpoint
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 35b61bfc1b1a..8c1d0669d0c4 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -519,3 +519,5 @@
 435	nospu	clone3				ppc_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	create_mountpoint		sys_create_mountpoint
+440	common	remove_mountpoint		sys_remove_mountpoint
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index bd7bd3581a0f..f689f38916e6 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -440,3 +440,5 @@
 435  common	clone3			sys_clone3			sys_clone3
 437  common	openat2			sys_openat2			sys_openat2
 438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
+439	common	create_mountpoint	sys_create_mountpoint		sys_create_mountpoint
+440	common	remove_mountpoint	sys_remove_mountpoint		sys_remove_mountpoint
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index c7a30fcd135f..ec47f5f3afb7 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -440,3 +440,5 @@
 # 435 reserved for clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	create_mountpoint		sys_create_mountpoint
+440	common	remove_mountpoint		sys_remove_mountpoint
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index f13615ecdecc..98d31e76d0a0 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -483,3 +483,5 @@
 # 435 reserved for clone3
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	create_mountpoint		sys_create_mountpoint
+440	common	remove_mountpoint		sys_remove_mountpoint
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c17cb77eb150..648ae88a39e6 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -442,3 +442,5 @@
 435	i386	clone3			sys_clone3			__ia32_sys_clone3
 437	i386	openat2			sys_openat2			__ia32_sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
+439	i386	create_mountpoint	sys_create_mountpoint		__ia32_sys_create_mountpoint
+440	i386	remove_mountpoint	sys_remove_mountpoint		__ia32_sys_remove_mountpoint
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 44d510bc9b78..e342f61fa2a1 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -359,6 +359,8 @@
 435	common	clone3			__x64_sys_clone3/ptregs
 437	common	openat2			__x64_sys_openat2
 438	common	pidfd_getfd		__x64_sys_pidfd_getfd
+439	common	create_mountpoint	__x64_sys_create_mountpoint
+440	common	remove_mountpoint	__x64_sys_remove_mountpoint
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 85a9ab1bc04d..68739341ab48 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -408,3 +408,5 @@
 435	common	clone3				sys_clone3
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	create_mountpoint		sys_create_mountpoint
+440	common	remove_mountpoint		sys_remove_mountpoint
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 5c794f4b051a..b989709f5f52 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -33,10 +33,14 @@ static int afs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 static int afs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode);
 static int afs_rmdir(struct inode *dir, struct dentry *dentry);
 static int afs_unlink(struct inode *dir, struct dentry *dentry);
+static int afs_remove_mountpoint(struct inode *dir, struct dentry *dentry);
 static int afs_link(struct dentry *from, struct inode *dir,
 		    struct dentry *dentry);
 static int afs_symlink(struct inode *dir, struct dentry *dentry,
 		       const char *content);
+static int afs_create_mountpoint(struct inode *dir, struct dentry *dentry,
+				 const char *fstype, const char *source,
+				 const char *params);
 static int afs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		      struct inode *new_dir, struct dentry *new_dentry,
 		      unsigned int flags);
@@ -70,6 +74,8 @@ const struct inode_operations afs_dir_inode_operations = {
 	.getattr	= afs_getattr,
 	.setattr	= afs_setattr,
 	.listxattr	= afs_listxattr,
+	.create_mountpoint = afs_create_mountpoint,
+	.remove_mountpoint = afs_remove_mountpoint,
 };
 
 const struct address_space_operations afs_dir_aops = {
@@ -1562,6 +1568,14 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 	return ret;
 }
 
+/*
+ * Remove a mountpoint from an AFS filesystem.
+ */
+static int afs_remove_mountpoint(struct inode *dir, struct dentry *dentry)
+{
+	return afs_unlink(dir, dentry);
+}
+
 /*
  * create a regular file on an AFS filesystem
  */
@@ -1722,10 +1736,10 @@ static int afs_link(struct dentry *from, struct inode *dir,
 }
 
 /*
- * create a symlink in an AFS filesystem
+ * Create a symlink or a mountpoint in an AFS filesystem
  */
-static int afs_symlink(struct inode *dir, struct dentry *dentry,
-		       const char *content)
+static int afs_do_symlink(struct inode *dir, struct dentry *dentry,
+			  const char *content, bool is_mountpoint)
 {
 	struct afs_iget_data iget_data;
 	struct afs_fs_cursor fc;
@@ -1765,7 +1779,8 @@ static int afs_symlink(struct inode *dir, struct dentry *dentry,
 			fc.cb_break = afs_calc_vnode_cb_break(dvnode);
 			afs_prep_for_new_inode(&fc, &iget_data);
 			afs_fs_symlink(&fc, dentry->d_name.name, content,
-				       &scb[0], &iget_data.fid, &scb[1]);
+				       &scb[0], &iget_data.fid, &scb[1],
+				       is_mountpoint);
 		}
 
 		afs_check_for_remote_deletion(&fc, dvnode);
@@ -1799,6 +1814,33 @@ static int afs_symlink(struct inode *dir, struct dentry *dentry,
 	return ret;
 }
 
+/*
+ * create a symlink in an AFS filesystem
+ */
+static int afs_symlink(struct inode *dir, struct dentry *dentry,
+		       const char *content)
+{
+	return afs_do_symlink(dir, dentry, content, false);
+}
+
+/*
+ * Create a mountpoint in an AFS filesystem
+ */
+static int afs_create_mountpoint(struct inode *dir, struct dentry *dentry,
+				 const char *fstype, const char *source,
+				 const char *params)
+{
+	if (!source || params ||
+	    strcmp(fstype, dir->i_sb->s_type->name) != 0)
+		return -EINVAL;
+
+	if (strlen(source) < 2)
+		return -EINVAL;
+	if (source[0] != '#' && source[0] != '%')
+		return -EINVAL;
+	return afs_do_symlink(dir, dentry, source, true);
+}
+
 /*
  * rename a file in an AFS filesystem and/or move it between directories
  */
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 1f9c5d8e6fe5..e2a2abe3a9aa 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -896,14 +896,15 @@ static const struct afs_call_type afs_RXFSSymlink = {
 };
 
 /*
- * create a symbolic link
+ * Create a symbolic link or a mountpoint (differentiated by mode).
  */
 int afs_fs_symlink(struct afs_fs_cursor *fc,
 		   const char *name,
 		   const char *contents,
 		   struct afs_status_cb *dvnode_scb,
 		   struct afs_fid *newfid,
-		   struct afs_status_cb *new_scb)
+		   struct afs_status_cb *new_scb,
+		   bool is_mountpoint)
 {
 	struct afs_vnode *dvnode = fc->vnode;
 	struct afs_call *call;
@@ -913,7 +914,7 @@ int afs_fs_symlink(struct afs_fs_cursor *fc,
 
 	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
 		return yfs_fs_symlink(fc, name, contents, dvnode_scb,
-				      newfid, new_scb);
+				      newfid, new_scb, is_mountpoint);
 
 	_enter("");
 
@@ -959,7 +960,7 @@ int afs_fs_symlink(struct afs_fs_cursor *fc,
 	*bp++ = htonl(dvnode->vfs_inode.i_mtime.tv_sec); /* mtime */
 	*bp++ = 0; /* owner */
 	*bp++ = 0; /* group */
-	*bp++ = htonl(S_IRWXUGO); /* unix mode */
+	*bp++ = htonl(is_mountpoint ? 0644 : S_IRWXUGO); /* unix mode */
 	*bp++ = 0; /* segment size */
 
 	afs_use_fs_server(call, fc->cbi);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 1d81fc4c3058..70509f2ddd00 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -965,7 +965,8 @@ extern int afs_fs_remove(struct afs_fs_cursor *, struct afs_vnode *, const char
 extern int afs_fs_link(struct afs_fs_cursor *, struct afs_vnode *, const char *,
 		       struct afs_status_cb *, struct afs_status_cb *);
 extern int afs_fs_symlink(struct afs_fs_cursor *, const char *, const char *,
-			  struct afs_status_cb *, struct afs_fid *, struct afs_status_cb *);
+			  struct afs_status_cb *, struct afs_fid *, struct afs_status_cb *,
+			  bool);
 extern int afs_fs_rename(struct afs_fs_cursor *, const char *,
 			 struct afs_vnode *, const char *,
 			 struct afs_status_cb *, struct afs_status_cb *);
@@ -1370,7 +1371,8 @@ extern int yfs_fs_remove(struct afs_fs_cursor *, struct afs_vnode *, const char
 extern int yfs_fs_link(struct afs_fs_cursor *, struct afs_vnode *, const char *,
 		       struct afs_status_cb *, struct afs_status_cb *);
 extern int yfs_fs_symlink(struct afs_fs_cursor *, const char *, const char *,
-			  struct afs_status_cb *, struct afs_fid *, struct afs_status_cb *);
+			  struct afs_status_cb *, struct afs_fid *, struct afs_status_cb *,
+			  bool);
 extern int yfs_fs_rename(struct afs_fs_cursor *, const char *, struct afs_vnode *, const char *,
 			 struct afs_status_cb *, struct afs_status_cb *);
 extern int yfs_fs_store_data(struct afs_fs_cursor *, struct address_space *,
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 79bc5f1338ed..b06ceed9b8f5 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -17,9 +17,6 @@
 #include "internal.h"
 
 
-static struct dentry *afs_mntpt_lookup(struct inode *dir,
-				       struct dentry *dentry,
-				       unsigned int flags);
 static int afs_mntpt_open(struct inode *inode, struct file *file);
 static void afs_mntpt_expiry_timed_out(struct work_struct *work);
 
@@ -29,7 +26,6 @@ const struct file_operations afs_mntpt_file_operations = {
 };
 
 const struct inode_operations afs_mntpt_inode_operations = {
-	.lookup		= afs_mntpt_lookup,
 	.readlink	= page_readlink,
 	.getattr	= afs_getattr,
 	.listxattr	= afs_listxattr,
@@ -46,17 +42,6 @@ static unsigned long afs_mntpt_expiry_timeout = 10 * 60;
 
 static const char afs_root_volume[] = "root.cell";
 
-/*
- * no valid lookup procedure on this sort of dir
- */
-static struct dentry *afs_mntpt_lookup(struct inode *dir,
-				       struct dentry *dentry,
-				       unsigned int flags)
-{
-	_enter("%p,%p{%pd2}", dir, dentry, dentry);
-	return ERR_PTR(-EREMOTE);
-}
-
 /*
  * no valid open procedure on this sort of dir
  */
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index a26126ac7bf1..5ff95d5643f5 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -1080,14 +1080,15 @@ static const struct afs_call_type yfs_RXYFSSymlink = {
 };
 
 /*
- * Create a symbolic link.
+ * Create a symbolic link or a mountpoint (differentiated by mode).
  */
 int yfs_fs_symlink(struct afs_fs_cursor *fc,
 		   const char *name,
 		   const char *contents,
 		   struct afs_status_cb *dvnode_scb,
 		   struct afs_fid *newfid,
-		   struct afs_status_cb *vnode_scb)
+		   struct afs_status_cb *vnode_scb,
+		   bool is_mountpoint)
 {
 	struct afs_vnode *dvnode = fc->vnode;
 	struct afs_call *call;
@@ -1125,7 +1126,7 @@ int yfs_fs_symlink(struct afs_fs_cursor *fc,
 	bp = xdr_encode_YFSFid(bp, &dvnode->fid);
 	bp = xdr_encode_string(bp, name, namesz);
 	bp = xdr_encode_string(bp, contents, contents_sz);
-	bp = xdr_encode_YFSStoreStatus_mode(bp, S_IRWXUGO);
+	bp = xdr_encode_YFSStoreStatus_mode(bp, is_mountpoint ? 0644 : S_IRWXUGO);
 	yfs_check_req(call, bp);
 
 	afs_use_fs_server(call, fc->cbi);
diff --git a/fs/namei.c b/fs/namei.c
index db6565c99825..a7446d2bb50c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -52,8 +52,8 @@
  * The new code replaces the old recursive symlink resolution with
  * an iterative one (in case of non-nested symlink chains).  It does
  * this with calls to <fs>_follow_link().
- * As a side effect, dir_namei(), _namei() and follow_link() are now 
- * replaced with a single function lookup_dentry() that can handle all 
+ * As a side effect, dir_namei(), _namei() and follow_link() are now
+ * replaced with a single function lookup_dentry() that can handle all
  * the special cases of the former code.
  *
  * With the new dcache, the pathname is stored at each inode, at least as
@@ -2842,6 +2842,12 @@ int __check_sticky(struct inode *dir, struct inode *inode)
 }
 EXPORT_SYMBOL(__check_sticky);
 
+enum may_delete_type {
+	MAY_DELETE_FILE,
+	MAY_DELETE_DIR,
+	MAY_DELETE_AUTOMOUNT,
+};
+
 /*
  *	Check whether we can remove a link victim from directory dir, check
  *  whether the type of victim is right.
@@ -2862,7 +2868,8 @@ EXPORT_SYMBOL(__check_sticky);
  * 11. We don't allow removal of NFS sillyrenamed files; it's handled by
  *     nfs_async_unlink().
  */
-static int may_delete(struct inode *dir, struct dentry *victim, bool isdir)
+static int may_delete(struct inode *dir, struct dentry *victim,
+		      enum may_delete_type isdir)
 {
 	struct inode *inode = d_backing_inode(victim);
 	int error;
@@ -2888,13 +2895,25 @@ static int may_delete(struct inode *dir, struct dentry *victim, bool isdir)
 	if (check_sticky(dir, inode) || IS_APPEND(inode) ||
 	    IS_IMMUTABLE(inode) || IS_SWAPFILE(inode) || HAS_UNMAPPED_ID(inode))
 		return -EPERM;
-	if (isdir) {
-		if (!d_is_dir(victim))
+	switch (isdir) {
+	case 0:
+		if (d_is_dir(victim))
+			return -EISDIR;
+		break;
+	case 1:
+		if (!d_can_lookup(victim))
 			return -ENOTDIR;
 		if (IS_ROOT(victim))
 			return -EBUSY;
-	} else if (d_is_dir(victim))
-		return -EISDIR;
+		break;
+	case 2:
+		if (!d_is_autodir(victim)) {
+			if (d_can_lookup(victim))
+				return -EISDIR;
+			return -ENOTDIR;
+		}
+		break;
+	}
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
 	if (victim->d_flags & DCACHE_NFSFS_RENAMED)
@@ -3930,7 +3949,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 
 int vfs_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	int error = may_delete(dir, dentry, 1);
+	int error = may_delete(dir, dentry, MAY_DELETE_DIR);
 
 	if (error)
 		return error;
@@ -4053,7 +4072,7 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
 int vfs_unlink(struct inode *dir, struct dentry *dentry, struct inode **delegated_inode)
 {
 	struct inode *target = dentry->d_inode;
-	int error = may_delete(dir, dentry, 0);
+	int error = may_delete(dir, dentry, MAY_DELETE_FILE);
 
 	if (error)
 		return error;
@@ -4467,24 +4486,28 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	       struct inode **delegated_inode, unsigned int flags)
 {
 	int error;
-	bool is_dir = d_is_dir(old_dentry);
+	enum may_delete_type is_dir, new_is_dir;
 	struct inode *source = old_dentry->d_inode;
 	struct inode *target = new_dentry->d_inode;
-	bool new_is_dir = false;
 	unsigned max_links = new_dir->i_sb->s_max_links;
 	struct name_snapshot old_name;
 
 	if (source == target)
 		return 0;
 
+	is_dir = d_is_dir(old_dentry) ? d_is_autodir(old_dentry) ?
+		MAY_DELETE_AUTOMOUNT : MAY_DELETE_DIR : MAY_DELETE_FILE;
+
 	error = may_delete(old_dir, old_dentry, is_dir);
 	if (error)
 		return error;
 
 	if (!target) {
+		new_is_dir = MAY_DELETE_FILE;
 		error = may_create(new_dir, new_dentry);
 	} else {
-		new_is_dir = d_is_dir(new_dentry);
+		new_is_dir = d_is_dir(new_dentry) ? d_is_autodir(new_dentry) ?
+			MAY_DELETE_AUTOMOUNT : MAY_DELETE_DIR : MAY_DELETE_FILE;
 
 		if (!(flags & RENAME_EXCHANGE))
 			error = may_delete(new_dir, new_dentry, is_dir);
@@ -4935,3 +4958,242 @@ const struct inode_operations page_symlink_inode_operations = {
 	.get_link	= page_get_link,
 };
 EXPORT_SYMBOL(page_symlink_inode_operations);
+
+/**
+ * vfs_create_mountpoint - Create an automount point
+ * @dir: The parent directory
+ * @dentry: The dentry for the new mountpoint
+ * @fstype: The filesystem type of the target
+ * @source: The source specification for the target
+ * @params: A string of mount parameters
+ *
+ * Create an automount point on @dentry and store it in the parent @dir's
+ * filesystem.  The destination of the automount point is specified by a
+ * combination of filesystem type, source and parameter string.  The base
+ * filesystem can reject the combination if it can't support it.
+ */
+int vfs_create_mountpoint(struct inode *dir, struct dentry *dentry,
+			  const char *fstype, const char *source,
+			  const char *params)
+{
+	int error = may_create(dir, dentry);
+	if (error)
+		return error;
+
+	if (!dir->i_op->create_mountpoint)
+		return -EPERM;
+
+	error = security_inode_mkdir(dir, dentry, S_IRUGO | S_IXUGO);
+	if (error)
+		return error;
+
+	error = dir->i_op->create_mountpoint(dir, dentry, fstype, source, params);
+	if (!error)
+		fsnotify_mkdir(dir, dentry);
+	return error;
+}
+EXPORT_SYMBOL(vfs_create_mountpoint);
+
+/*
+ * System call to create an automount point.
+ */
+SYSCALL_DEFINE5(create_mountpoint,
+		int, dfd, const char __user *, pathname,
+		const char __user *, _fstype,
+		const char __user *, _source,
+		const char __user *, _params)
+{
+	struct dentry *dentry;
+	struct path path;
+	char *fstype, *source, *params = NULL;
+	unsigned int lookup_flags = LOOKUP_DIRECTORY;
+	long ret;
+
+	fstype = strndup_user(_fstype, 4096);
+	if (IS_ERR(fstype)) {
+		ret = PTR_ERR(fstype);
+		goto err;
+	}
+
+	source = strndup_user(_source, 4096);
+	if (IS_ERR(source)) {
+		ret = PTR_ERR(source);
+		goto err_fstype;
+	}
+
+	if (_params) {
+		params = strndup_user(_params, 4096);
+		if (IS_ERR(params)) {
+			ret = PTR_ERR(params);
+			goto err_source;
+		}
+	}
+
+retry:
+	dentry = user_path_create(dfd, pathname, &path, lookup_flags);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto err_params;
+	}
+
+	ret = security_path_mkdir(&path, dentry, S_IRUGO | S_IXUGO);
+	if (!ret)
+		ret = vfs_create_mountpoint(path.dentry->d_inode, dentry,
+					    fstype, source, params);
+	done_path_create(&path, dentry);
+	if (retry_estale(ret, lookup_flags)) {
+		lookup_flags |= LOOKUP_REVAL;
+		goto retry;
+	}
+
+err_params:
+	kfree(params);
+err_source:
+	kfree(source);
+err_fstype:
+	kfree(fstype);
+err:
+	return ret;
+}
+
+/**
+ * vfs_remove_mountpoint - Remove an automount point
+ * @dir:	parent directory
+ * @dentry:	victim
+ * @delegated_inode: returns victim inode, if the inode is delegated.
+ *
+ * The caller must hold dir->i_mutex.
+ *
+ * If vfs_unlink discovers a delegation, it will return -EWOULDBLOCK and
+ * return a reference to the inode in delegated_inode.  The caller
+ * should then break the delegation on that inode and retry.  Because
+ * breaking a delegation may take a long time, the caller should drop
+ * dir->i_mutex before doing so.
+ *
+ * Alternatively, a caller may pass NULL for delegated_inode.  This may
+ * be appropriate for callers that expect the underlying filesystem not
+ * to be NFS exported.
+ */
+int vfs_remove_mountpoint(struct inode *dir, struct dentry *dentry,
+			  struct inode **delegated_inode)
+{
+	struct inode *target = dentry->d_inode;
+	int error = may_delete(dir, dentry, MAY_DELETE_AUTOMOUNT);
+
+	if (error)
+		return error;
+
+	if (!dir->i_op->remove_mountpoint)
+		return -EPERM;
+
+	inode_lock(target);
+	if (is_local_mountpoint(dentry))
+		error = -EBUSY;
+	else {
+		error = security_inode_unlink(dir, dentry);
+		if (!error) {
+			error = try_break_deleg(target, delegated_inode);
+			if (error)
+				goto out;
+			error = dir->i_op->remove_mountpoint(dir, dentry);
+			if (!error) {
+				dont_mount(dentry);
+				detach_mounts(dentry);
+				fsnotify_unlink(dir, dentry);
+			}
+		}
+	}
+out:
+	inode_unlock(target);
+
+	/* We don't d_delete() NFS sillyrenamed files--they still exist. */
+	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
+		fsnotify_link_count(target);
+		d_delete(dentry);
+	}
+
+	return error;
+}
+EXPORT_SYMBOL(vfs_remove_mountpoint);
+
+/*
+ * Make sure that the actual truncation of the file will occur outside its
+ * directory's i_mutex.  Truncate can take a long time if there is a lot of
+ * writeout happening, and we don't want to prevent access to the directory
+ * while waiting on the I/O.
+ */
+SYSCALL_DEFINE2(remove_mountpoint, int, dfd, const char __user *, pathname)
+{
+	struct filename *name;
+	struct dentry *dentry;
+	struct path path;
+	struct qstr last;
+	struct inode *inode = NULL;
+	struct inode *delegated_inode = NULL;
+	unsigned int lookup_flags = 0;
+	long error;
+	int type;
+
+	name = getname(pathname);
+
+retry:
+	name = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+
+	error = -EISDIR;
+	if (type != LAST_NORM)
+		goto exit1;
+
+	error = mnt_want_write(path.mnt);
+	if (error)
+		goto exit1;
+retry_deleg:
+	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
+	dentry = __lookup_hash(&last, path.dentry, lookup_flags);
+	error = PTR_ERR(dentry);
+	if (!IS_ERR(dentry)) {
+		/* Why not before? Because we want correct error value */
+		if (last.name[last.len])
+			goto slashes;
+		inode = dentry->d_inode;
+		if (d_is_negative(dentry))
+			goto slashes;
+		ihold(inode);
+		error = security_path_unlink(&path, dentry);
+		if (error)
+			goto exit2;
+		error = vfs_remove_mountpoint(path.dentry->d_inode, dentry,
+					      &delegated_inode);
+exit2:
+		dput(dentry);
+	}
+	inode_unlock(path.dentry->d_inode);
+	if (inode)
+		iput(inode);	/* truncate the inode here */
+	inode = NULL;
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry_deleg;
+	}
+	mnt_drop_write(path.mnt);
+exit1:
+	path_put(&path);
+	if (retry_estale(error, lookup_flags)) {
+		lookup_flags |= LOOKUP_REVAL;
+		inode = NULL;
+		goto retry;
+	}
+	putname(name);
+	return error;
+
+slashes:
+	if (d_is_negative(dentry))
+		error = -ENOENT;
+	else if (d_is_dir(dentry))
+		error = -EISDIR;
+	else
+		error = -ENOTDIR;
+	goto exit2;
+}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3cd4fe6b845e..741d47969aaa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1716,6 +1716,9 @@ extern int vfs_rmdir(struct inode *, struct dentry *);
 extern int vfs_unlink(struct inode *, struct dentry *, struct inode **);
 extern int vfs_rename(struct inode *, struct dentry *, struct inode *, struct dentry *, struct inode **, unsigned int);
 extern int vfs_whiteout(struct inode *, struct dentry *);
+extern int vfs_create_mountpoint(struct inode *, struct dentry *,
+				 const char *, const char *, const char *);
+extern int vfs_remove_mountpoint(struct inode *, struct dentry *, struct inode **);
 
 extern struct dentry *vfs_tmpfile(struct dentry *dentry, umode_t mode,
 				  int open_flag);
@@ -1887,6 +1890,9 @@ struct inode_operations {
 			   umode_t create_mode);
 	int (*tmpfile) (struct inode *, struct dentry *, umode_t);
 	int (*set_acl)(struct inode *, struct posix_acl *, int);
+	int (*create_mountpoint)(struct inode *, struct dentry *,
+				 const char *, const char *, const char *);
+	int (*remove_mountpoint)(struct inode *, struct dentry *);
 } ____cacheline_aligned;
 
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index d56fefef8905..a0a550e4af14 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -23,6 +23,9 @@ struct shmem_inode_info {
 	struct shared_policy	policy;		/* NUMA memory alloc policy */
 	struct simple_xattrs	xattrs;		/* list of xattrs */
 	atomic_t		stop_eviction;	/* hold when working on inode */
+	char			*mountpoint_fstype;
+	char			*mountpoint_source;
+	char			*mountpoint_params;
 	struct inode		vfs_inode;
 };
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1815065d52f3..d1aeedfa374f 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1003,6 +1003,10 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
 asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
+asmlinkage long sys_create_mountpoint(int dfd, const char __user *path,
+				      const char __user *fstype, const char __user *source,
+				      const char __user *params);
+asmlinkage long sys_remove_mountpoint(int dfd, const char __user *path);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 3a3201e4618e..7a9a542e08c9 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -855,9 +855,13 @@ __SYSCALL(__NR_clone3, sys_clone3)
 __SYSCALL(__NR_openat2, sys_openat2)
 #define __NR_pidfd_getfd 438
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
+#define __NR_create_mountpoint 439
+__SYSCALL(__NR_create_mountpoint, sys_create_mountpoint)
+#define __NR_remove_mountpoint 440
+__SYSCALL(__NR_remove_mountpoint, sys_remove_mountpoint)
 
 #undef __NR_syscalls
-#define __NR_syscalls 439
+#define __NR_syscalls 441
 
 /*
  * 32 bit systems traditionally used different
diff --git a/mm/shmem.c b/mm/shmem.c
index c8f7540ef048..8f94b7503635 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -85,6 +85,7 @@ static struct vfsmount *shm_mnt;
 #include <asm/pgtable.h>
 
 #include "internal.h"
+#include "../fs/internal.h"
 
 #define BLOCKS_PER_PAGE  (PAGE_SIZE/512)
 #define VM_ACCT(size)    (PAGE_ALIGN(size) >> PAGE_SHIFT)
@@ -249,6 +250,7 @@ static const struct address_space_operations shmem_aops;
 static const struct file_operations shmem_file_operations;
 static const struct inode_operations shmem_inode_operations;
 static const struct inode_operations shmem_dir_inode_operations;
+static const struct inode_operations shmem_mountpoint_inode_operations;
 static const struct inode_operations shmem_special_inode_operations;
 static const struct vm_operations_struct shmem_vm_ops;
 static struct file_system_type shmem_fs_type;
@@ -3181,6 +3183,136 @@ static const char *shmem_get_link(struct dentry *dentry,
 	return page_address(page);
 }
 
+/*
+ * Create an automount point.
+ */
+static int shmem_create_mountpoint(struct inode *dir, struct dentry *dentry,
+				   const char *fstype, const char *source,
+				   const char *params)
+{
+	struct shmem_inode_info *info;
+	struct inode *inode;
+	int error = -ENOSPC;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	inode = shmem_get_inode(dir->i_sb, dir, S_IFDIR | 0555, 0, VM_NORESERVE);
+	if (inode) {
+		inode->i_op = &shmem_mountpoint_inode_operations;
+		inode->i_fop = NULL;
+		inode->i_flags |= S_AUTOMOUNT;
+		info = SHMEM_I(inode);
+		info->mountpoint_fstype = kstrdup(fstype, GFP_KERNEL);
+		if (!info->mountpoint_fstype)
+			goto out_iput;
+		if (source) {
+			info->mountpoint_source = kstrdup(source, GFP_KERNEL);
+			if (!info->mountpoint_source)
+				goto out_iput;
+		}
+		if (params) {
+			info->mountpoint_params = kstrdup(params, GFP_KERNEL);
+			if (!info->mountpoint_params)
+				goto out_iput;
+		}
+		error = simple_acl_create(dir, inode);
+		if (error)
+			goto out_iput;
+		error = security_inode_init_security(inode, dir,
+						     &dentry->d_name,
+						     shmem_initxattrs, NULL);
+		if (error && error != -EOPNOTSUPP)
+			goto out_iput;
+
+		error = 0;
+		dir->i_size += BOGO_DIRENT_SIZE;
+		dir->i_ctime = dir->i_mtime = current_time(dir);
+		d_instantiate(dentry, inode);
+		dget(dentry); /* Extra count - pin the dentry in core */
+	}
+	return error;
+out_iput:
+	iput(inode);
+	return error;
+}
+
+static void shmem_automount_expired(struct work_struct *);
+static LIST_HEAD(shmem_automounts);
+static DECLARE_DELAYED_WORK(shmem_automount_expiry, shmem_automount_expired);
+
+static void shmem_automount_expired(struct work_struct *work)
+{
+	if (!list_empty(&shmem_automounts)) {
+		mark_mounts_for_expiry(&shmem_automounts);
+		schedule_delayed_work(&shmem_automount_expiry, 10 * 60 * HZ);
+	}
+}
+
+/*
+ * Handle an automount point
+ */
+struct vfsmount *shmem_d_automount(struct path *path)
+{
+	struct file_system_type *type;
+	struct fs_context *fc;
+	struct vfsmount *mnt;
+	struct dentry *mntpt = path->dentry;
+	struct shmem_inode_info *info = SHMEM_I(d_inode(mntpt));
+	int ret;
+
+	type = get_fs_type(info->mountpoint_fstype);
+	if (!type)
+		return ERR_PTR(-ENODEV);
+
+	fc = fs_context_for_submount(type, mntpt);
+	put_filesystem(type);
+	if (IS_ERR(fc))
+		return ERR_CAST(fc);
+
+	if (info->mountpoint_source) {
+		ret = vfs_parse_fs_string(fc, "source",
+					  info->mountpoint_source,
+					  strlen(info->mountpoint_source));
+		if (ret < 0) {
+			mnt = ERR_PTR(ret);
+			goto out;
+		}
+	}
+
+	if (info->mountpoint_params) {
+		ret = parse_monolithic_mount_data(fc, info->mountpoint_params);
+		if (ret < 0) {
+			mnt = ERR_PTR(ret);
+			goto out;
+		}
+	}
+
+	mnt = fc_mount(fc);
+	if (IS_ERR(mnt))
+		goto out;
+
+	mntget(mnt); /* Prevent immediate expiration */
+	mnt_set_expiry(mnt, &shmem_automounts);
+	schedule_delayed_work(&shmem_automount_expiry, 10 * 60 * HZ);
+out:
+	put_fs_context(fc);
+	return mnt;
+}
+
+/*
+ * Remove an automount point.
+ */
+static int shmem_remove_mountpoint(struct inode *dir, struct dentry *dentry)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	drop_nlink(d_inode(dentry));
+	drop_nlink(dir);
+	return shmem_unlink(dir, dentry);
+}
+
 #ifdef CONFIG_TMPFS_XATTR
 /*
  * Superblocks without xattr inode operations may get some security.* xattr
@@ -3624,6 +3756,10 @@ static void shmem_put_super(struct super_block *sb)
 	sb->s_fs_info = NULL;
 }
 
+static const struct dentry_operations shmem_dentry_operations = {
+	.d_automount	= shmem_d_automount,
+};
+
 static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct shmem_options *ctx = fc->fs_private;
@@ -3695,6 +3831,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_root = d_make_root(inode);
 	if (!sb->s_root)
 		goto failed;
+	sb->s_d_op = &shmem_dentry_operations;
 	return 0;
 
 failed:
@@ -3740,8 +3877,15 @@ static struct inode *shmem_alloc_inode(struct super_block *sb)
 
 static void shmem_free_in_core_inode(struct inode *inode)
 {
+	struct shmem_inode_info *info = SHMEM_I(inode);
+
 	if (S_ISLNK(inode->i_mode))
 		kfree(inode->i_link);
+	if (info->mountpoint_fstype) {
+		kfree(info->mountpoint_fstype);
+		kfree(info->mountpoint_source);
+		kfree(info->mountpoint_params);
+	}
 	kmem_cache_free(shmem_inode_cachep, SHMEM_I(inode));
 }
 
@@ -3824,6 +3968,17 @@ static const struct inode_operations shmem_dir_inode_operations = {
 #ifdef CONFIG_TMPFS_POSIX_ACL
 	.setattr	= shmem_setattr,
 	.set_acl	= simple_set_acl,
+#endif
+	.create_mountpoint = shmem_create_mountpoint,
+	.remove_mountpoint = shmem_remove_mountpoint,
+};
+
+static const struct inode_operations shmem_mountpoint_inode_operations = {
+	.getattr	= shmem_getattr,
+	.setattr	= shmem_setattr,
+#ifdef CONFIG_TMPFS_XATTR
+	.listxattr	= shmem_listxattr,
+	.set_acl	= simple_set_acl,
 #endif
 };
 
diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
index 65acdde5c117..3fb1e94b6ccf 100644
--- a/samples/vfs/Makefile
+++ b/samples/vfs/Makefile
@@ -1,10 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # List of programs to build
 hostprogs := \
+	test-automount \
 	test-fsmount \
 	test-statx
 
 always-y := $(hostprogs)
 
+HOSTCFLAGS_test-automount.o += -I$(objtree)/usr/include
 HOSTCFLAGS_test-fsmount.o += -I$(objtree)/usr/include
 HOSTCFLAGS_test-statx.o += -I$(objtree)/usr/include


