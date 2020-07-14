Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C8121F700
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 18:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgGNQQB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 12:16:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40933 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgGNQQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:16:00 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jvNaw-0005y1-N4; Tue, 14 Jul 2020 16:15:50 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH 3/4] fs: add mount_setattr()
Date:   Tue, 14 Jul 2020 18:14:15 +0200
Message-Id: <20200714161415.3886463-5-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714161415.3886463-1-christian.brauner@ubuntu.com>
References: <20200714161415.3886463-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This implements the mount_setattr() syscall. While the new mount api
allows to change the properties of a superblock there is currently no
way to change the mount properties of a mount or mount tree using mount
file descriptors which the new mount api is based on. In addition the
old mount api has the restriction that mount options cannot be
applied recursively. This hasn't changed since changing mount options on
a per-mount basis was implemented in [1] and has been a frequent
request.
The legacy mount is currently unable to accommodate this behavior
without introducing a whole new set of flags because MS_REC | MS_REMOUNT
| MS_BIND | MS_RDONLY | MS_NOEXEC | [...] only apply the mount option to
the topmost mount. Changing MS_REC to apply to the whole mount tree
would mean introducing a significant uapi change and would likely cause
significant regressions.

The new mount_setattr() syscall allows to recursively clear and set
mount options in one shot. Multiple calls to change mount options
requesting the same changes are idempotent:

int mount_setattr(int dfd, const char *path, unsigned flags,
                  struct mount_attr *uattr, size_t usize);

Flags to modify path resolution behavior are specified in the @flags
argument. Currently, AT_EMPTY_PATH, AT_RECURSIVE, AT_SYMLINK_NOFOLLOW,
and AT_NO_AUTOMOUNT are supported. If useful, additional lookup flags to
restrict path resolution as introduced with openat2() might be supported
in the future.

mount_setattr() can be expected to grow over time and is designed with
extensibility in mind. It follows the extensible syscall pattern we have
used with other syscalls such as openat2(), clone3(),
sched_{set,get}attr(), and others.
The set of mount options is passed in the uapi struct mount_attr which
currently has the following layout:

struct mount_attr {
	__u64 attr_set;
	__u64 attr_clr;
	__u32 propagation;
	__u32 atime;

};

The @attr_set and @attr_clr members are used to clear and set mount
options. This way a user can e.g. request that a set of flags is to be
raised such as turning mounts readonly by raising MOUNT_ATTR_RDONLY in
@attr_set while at the same time requesting that another set of flags is
to be lowered such as removing noexec from a mount tree by specifying
MOUNT_ATTR_NOEXEC in @attr_clr.

The @propagation field lets callers specify the propagation type of a
mount tree. Propagation is a single property that has four different
settings and as such is not really a flag argument but an enum.
Specifically, it would be unclear what setting and clearing propagation
settings in combination would amount to. The legacy mount() syscall thus
forbids the combination of multiple propagation settings too. The goal
is to keep the semantics of mount propagation somewhat simple as they
are overly complex as it is.

Finally, struct mount_attr contains an @atime field which can be used to
set the atime behavior of a mount tree. Currently, access times are
already treated and defined like an enum in the new mount api so there's
no reason to treat them equivalent to a flag argument. A new atime enum
is introduced. The reason for not reusing the atime flags useable with
fsmount() and defined in the new mount api is that the
MOUNT_ATTR_RELATIME enum is defined as 0. This means, a user wanting to
transition to relative atime cannot simply specify MOUNT_ATTR_RELATIME
in @atime or @attr_set as this would mean not specifying any atime
settings is equivalent to specifying relative atime. This would cause
confusion for userspace as not specifying atime settings would switch
them to relatime. The new set of enums rectifies this by starting the
definition at 1 and letting 0 mean that atime settings are supposed to
be left unchanged.

Changing mount option has quite a few moving parts and the locking is
quite intricate so it is not unlikely that I got subtleties wrong.

[1]: commit 2e4b7fcd9260 ("[PATCH] r/o bind mounts: honor mount writer counts at remount")
Cc: David Howells <dhowells@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-api@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/arm64/include/asm/unistd32.h           |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 fs/internal.h                               |   7 +
 fs/namespace.c                              | 275 ++++++++++++++++++--
 include/linux/syscalls.h                    |   3 +
 include/uapi/asm-generic/unistd.h           |   4 +-
 include/uapi/linux/mount.h                  |  31 +++
 22 files changed, 321 insertions(+), 17 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 5ddd128d4b7a..6c5c0b7a1c9e 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -478,3 +478,4 @@
 547	common	openat2				sys_openat2
 548	common	pidfd_getfd			sys_pidfd_getfd
 549	common	faccessat2			sys_faccessat2
+550	common	mount_setattr			sys_mount_setattr
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index d5cae5ffede0..10014c157e3f 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -452,3 +452,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+440	common	mount_setattr			sys_mount_setattr
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 6d95d0c8bf2f..7de6051fa380 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -885,6 +885,8 @@ __SYSCALL(__NR_openat2, sys_openat2)
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 #define __NR_faccessat2 439
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
+#define __NR_mount_setattr 440
+__SYSCALL(__NR_mount_setattr, sys_mount_setattr)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 49e325b604b3..dd81c63f3970 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -359,3 +359,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+440	common	mount_setattr			sys_mount_setattr
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index f71b1bbcc198..cb78cb4da7dd 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -438,3 +438,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+440	common	mount_setattr			sys_mount_setattr
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index edacc4561f2b..71a5b24e2b67 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -444,3 +444,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+440	common	mount_setattr			sys_mount_setattr
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index f777141f5256..9dcafeef6c07 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -377,3 +377,4 @@
 437	n32	openat2				sys_openat2
 438	n32	pidfd_getfd			sys_pidfd_getfd
 439	n32	faccessat2			sys_faccessat2
+440	n32	mount_setattr			sys_mount_setattr
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index da8c76394e17..5e51a29cc21f 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -353,3 +353,4 @@
 437	n64	openat2				sys_openat2
 438	n64	pidfd_getfd			sys_pidfd_getfd
 439	n64	faccessat2			sys_faccessat2
+440	n64	mount_setattr			sys_mount_setattr
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 13280625d312..5b5fa22cca16 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -426,3 +426,4 @@
 437	o32	openat2				sys_openat2
 438	o32	pidfd_getfd			sys_pidfd_getfd
 439	o32	faccessat2			sys_faccessat2
+440	o32	mount_setattr			sys_mount_setattr
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 5a758fa6ec52..e7fca7c8c407 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -436,3 +436,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+440	common	mount_setattr			sys_mount_setattr
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index f833a3190822..cfb50e8c5d45 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -528,3 +528,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+440	common	mount_setattr			sys_mount_setattr
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index bfdcb7633957..12081f161b30 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -441,3 +441,4 @@
 437  common	openat2			sys_openat2			sys_openat2
 438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
 439  common	faccessat2		sys_faccessat2			sys_faccessat2
+440  common	mount_setattr		sys_mount_setattr		sys_mount_setattr
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index acc35daa1b79..d4ffc9846ceb 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -441,3 +441,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+440	common	mount_setattr			sys_mount_setattr
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 8004a276cb74..024f010ee63e 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -484,3 +484,4 @@
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+440	common	mount_setattr			sys_mount_setattr
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index d8f8a1a69ed1..a89034dd8bc3 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -443,3 +443,4 @@
 437	i386	openat2			sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd
 439	i386	faccessat2		sys_faccessat2
+440	i386	mount_setattr		sys_mount_setattr
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 78847b32e137..c23771eeb8df 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -360,6 +360,7 @@
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd		sys_pidfd_getfd
 439	common	faccessat2		sys_faccessat2
+440	common	mount_setattr		sys_mount_setattr
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 69d0d73876b3..df0dfb1611f4 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -409,3 +409,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
+440	common	mount_setattr			sys_mount_setattr
diff --git a/fs/internal.h b/fs/internal.h
index 9b863a7bd708..62f7526d7536 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -75,6 +75,13 @@ int do_linkat(int olddfd, const char __user *oldname, int newdfd,
 /*
  * namespace.c
  */
+struct mount_kattr {
+	unsigned int attr_set;
+	unsigned int attr_clr;
+	unsigned int propagation;
+	unsigned int lookup_flags;
+	bool recurse;
+};
 extern void *copy_mount_options(const void __user *);
 extern char *copy_mount_string(const void __user *);
 
diff --git a/fs/namespace.c b/fs/namespace.c
index ab025dd3be04..13e29fcc82ab 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -459,10 +459,8 @@ void mnt_drop_write_file(struct file *file)
 }
 EXPORT_SYMBOL(mnt_drop_write_file);
 
-static int mnt_make_readonly(struct mount *mnt)
+static inline int mnt_hold_writers(struct mount *mnt)
 {
-	int ret = 0;
-
 	mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
 	/*
 	 * After storing MNT_WRITE_HOLD, we'll read the counters. This store
@@ -487,15 +485,30 @@ static int mnt_make_readonly(struct mount *mnt)
 	 * we're counting up here.
 	 */
 	if (mnt_get_writers(mnt) > 0)
-		ret = -EBUSY;
-	else
-		mnt->mnt.mnt_flags |= MNT_READONLY;
+		return -EBUSY;
+
+	return 0;
+}
+
+static inline void mnt_unhold_writers(struct mount *mnt)
+{
 	/*
 	 * MNT_READONLY must become visible before ~MNT_WRITE_HOLD, so writers
 	 * that become unheld will see MNT_READONLY.
 	 */
 	smp_wmb();
 	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
+}
+
+static int mnt_make_readonly(struct mount *mnt)
+{
+	int ret;
+
+	ret = mnt_hold_writers(mnt);
+	if (ret)
+		return ret;
+	mnt->mnt.mnt_flags |= MNT_READONLY;
+	mnt_unhold_writers(mnt);
 	return ret;
 }
 
@@ -3416,6 +3429,25 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
 	return ret;
 }
 
+static int build_attr_flags(unsigned int attr_flags, unsigned int *flags)
+{
+	unsigned int aflags = 0;
+
+	if (attr_flags & MOUNT_ATTR_RDONLY)
+		aflags |= MNT_READONLY;
+	if (attr_flags & MOUNT_ATTR_NOSUID)
+		aflags |= MNT_NOSUID;
+	if (attr_flags & MOUNT_ATTR_NODEV)
+		aflags |= MNT_NODEV;
+	if (attr_flags & MOUNT_ATTR_NOEXEC)
+		aflags |= MNT_NOEXEC;
+	if (attr_flags & MOUNT_ATTR_NODIRATIME)
+		aflags |= MNT_NODIRATIME;
+
+	*flags = aflags;
+	return 0;
+}
+
 /*
  * Create a kernel mount representation for a new, prepared superblock
  * (specified by fs_fd) and attach to an open_tree-like file descriptor.
@@ -3446,16 +3478,9 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 			   MOUNT_ATTR_NODIRATIME))
 		return -EINVAL;
 
-	if (attr_flags & MOUNT_ATTR_RDONLY)
-		mnt_flags |= MNT_READONLY;
-	if (attr_flags & MOUNT_ATTR_NOSUID)
-		mnt_flags |= MNT_NOSUID;
-	if (attr_flags & MOUNT_ATTR_NODEV)
-		mnt_flags |= MNT_NODEV;
-	if (attr_flags & MOUNT_ATTR_NOEXEC)
-		mnt_flags |= MNT_NOEXEC;
-	if (attr_flags & MOUNT_ATTR_NODIRATIME)
-		mnt_flags |= MNT_NODIRATIME;
+	ret = build_attr_flags(attr_flags, &mnt_flags);
+	if (ret)
+		return ret;
 
 	switch (attr_flags & MOUNT_ATTR__ATIME) {
 	case MOUNT_ATTR_STRICTATIME:
@@ -3763,6 +3788,224 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	return error;
 }
 
+static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
+{
+	struct mount *mnt = real_mount(path->mnt), *m = mnt, *last = NULL;
+	unsigned int all_raised = kattr->attr_set | kattr->attr_clr;
+	bool rdonly_set = kattr->attr_set & MNT_READONLY;
+	int err = 0;
+
+	if (!check_mnt(m))
+		return -EINVAL;
+
+	if (path->dentry != m->mnt.mnt_root)
+		return -EINVAL;
+
+	if (kattr->propagation) {
+		/* Only take namespace_lock() if we're actually changing propagation. */
+		namespace_lock();
+		if (kattr->propagation == MS_SHARED) {
+			err = invent_group_ids(m, kattr->recurse);
+			if (err) {
+				namespace_unlock();
+				return err;
+			}
+		}
+	}
+
+	lock_mount_hash();
+	/*
+	 * Get the mount tree in a shape where we can change mount properties
+	 * without failure.
+	 */
+	m = mnt;
+	do {
+		last = m;
+
+		if (!can_change_locked_flags(m, all_raised)) {
+			err = -EPERM;
+			break;
+		}
+
+		if (rdonly_set && !(m->mnt.mnt_flags & MNT_READONLY)) {
+			err = mnt_hold_writers(m);
+			if (err)
+				break;
+		}
+	} while (kattr->recurse && (m = next_mnt(m, mnt)));
+
+	m = mnt;
+	do {
+		if (!err) {
+			unsigned int new_flags;
+
+			new_flags = m->mnt.mnt_flags;
+			if (kattr->attr_set & MNT_RELATIME) {
+				new_flags &= ~MNT_NOATIME;
+				new_flags |= MNT_RELATIME;
+			}
+			if (kattr->attr_set & MNT_NOATIME) {
+				new_flags &= ~MNT_RELATIME;
+				new_flags |= MNT_NOATIME;
+			}
+			/* Lower flags user wants us to clear. */
+			new_flags &= ~kattr->attr_clr;
+			/* Raise flags user wants us to set. */
+			new_flags |= kattr->attr_set;
+			WRITE_ONCE(m->mnt.mnt_flags, new_flags);
+		}
+
+		/*
+		 * We either set MNT_READONLY above so make it visible
+		 * before ~MNT_WRITE_HOLD or we failed to recursively
+		 * apply mount options.
+		 */
+		if (rdonly_set && (m->mnt.mnt_flags & MNT_WRITE_HOLD))
+			mnt_unhold_writers(m);
+
+		if (!err && kattr->propagation)
+			change_mnt_propagation(m, kattr->propagation);
+
+		/*
+		 * On failure, only cleanup until we found the first mount we
+		 * failed to handle.
+		 */
+		if (err && m == last)
+			break;
+	} while (kattr->recurse && (m = next_mnt(m, mnt)));
+
+	if (!err)
+		touch_mnt_namespace(mnt->mnt_ns);
+
+	unlock_mount_hash();
+
+	if (kattr->propagation) {
+		namespace_unlock();
+		if (err)
+			cleanup_group_ids(mnt, NULL);
+	}
+
+	return err;
+}
+
+static int build_mount_kattr(const struct mount_attr *attr,
+			     struct mount_kattr *kattr, unsigned int flags)
+{
+	unsigned int lookup_flags = LOOKUP_AUTOMOUNT | LOOKUP_FOLLOW;
+
+	if (flags & AT_NO_AUTOMOUNT)
+		lookup_flags &= ~LOOKUP_AUTOMOUNT;
+	if (flags & AT_SYMLINK_NOFOLLOW)
+		lookup_flags &= ~LOOKUP_FOLLOW;
+	if (flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+
+	*kattr = (struct mount_kattr){
+		.lookup_flags	= lookup_flags,
+		.recurse	= !!(flags & AT_RECURSIVE),
+	};
+
+	switch (attr->propagation) {
+	case MAKE_PROPAGATION_UNCHANGED:
+		kattr->propagation = 0;
+		break;
+	case MAKE_PROPAGATION_UNBINDABLE:
+		kattr->propagation = MS_UNBINDABLE;
+		break;
+	case MAKE_PROPAGATION_PRIVATE:
+		kattr->propagation = MS_PRIVATE;
+		break;
+	case MAKE_PROPAGATION_DEPENDENT:
+		kattr->propagation = MS_SLAVE;
+		break;
+	case MAKE_PROPAGATION_SHARED:
+		kattr->propagation = MS_SHARED;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+
+	if (attr->attr_set) {
+		if (attr->attr_set &
+		    ~(MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NODEV |
+		      MOUNT_ATTR_NOEXEC | MOUNT_ATTR_NODIRATIME))
+			return -EINVAL;
+
+		if (build_attr_flags(lower_32_bits(attr->attr_set), &kattr->attr_set))
+			return -EINVAL;
+	}
+
+	if (attr->attr_clr) {
+		if (attr->attr_clr &
+		    ~(MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NODEV |
+		      MOUNT_ATTR_NOEXEC | MOUNT_ATTR_NODIRATIME))
+			return -EINVAL;
+
+		if (build_attr_flags(lower_32_bits(attr->attr_clr), &kattr->attr_clr))
+			return -EINVAL;
+	}
+
+	switch (attr->atime) {
+	case MAKE_ATIME_UNCHANGED:
+		break;
+	case MAKE_ATIME_RELATIVE:
+		kattr->attr_set |= MNT_RELATIME;
+		break;
+	case MAKE_ATIME_NONE:
+		kattr->attr_set |= MNT_NOATIME;
+		break;
+	case MAKE_ATIME_STRICT:
+		kattr->attr_clr |= MNT_RELATIME | MNT_NOATIME;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path, unsigned int, flags,
+		struct mount_attr __user *, uattr, size_t, usize)
+{
+	int err;
+	struct path target;
+	struct mount_attr attr;
+	struct mount_kattr kattr;
+
+	BUILD_BUG_ON(sizeof(struct mount_attr) < MOUNT_ATTR_SIZE_VER0);
+	BUILD_BUG_ON(sizeof(struct mount_attr) != MOUNT_ATTR_SIZE_LATEST);
+
+	if (flags & ~(AT_EMPTY_PATH | AT_RECURSIVE | AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT))
+		return -EINVAL;
+
+	if (unlikely(usize < MOUNT_ATTR_SIZE_VER0))
+		return -EINVAL;
+
+	if (!may_mount())
+		return -EPERM;
+
+	err = copy_struct_from_user(&attr, sizeof(attr), uattr, usize);
+	if (err)
+		return err;
+
+	if (attr.attr_set == 0 && attr.attr_clr == 0 && attr.propagation == 0 &&
+	    attr.atime == 0)
+		return 0;
+
+	err = build_mount_kattr(&attr, &kattr, flags);
+	if (err)
+		return err;
+
+	err = user_path_at(dfd, path, kattr.lookup_flags, &target);
+	if (err)
+		return err;
+
+	err = do_mount_setattr(&target, &kattr);
+	path_put(&target);
+	return err;
+}
+
 static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b951a87da987..f3e7b21980b1 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -69,6 +69,7 @@ union bpf_attr;
 struct io_uring_params;
 struct clone_args;
 struct open_how;
+struct mount_attr;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -996,6 +997,8 @@ asmlinkage long sys_open_tree(int dfd, const char __user *path, unsigned flags);
 asmlinkage long sys_move_mount(int from_dfd, const char __user *from_path,
 			       int to_dfd, const char __user *to_path,
 			       unsigned int ms_flags);
+asmlinkage long sys_mount_setattr(int dfd, const char __user *path, unsigned int flags,
+				  struct mount_attr __user *uattr, size_t usize);
 asmlinkage long sys_fsopen(const char __user *fs_name, unsigned int flags);
 asmlinkage long sys_fsconfig(int fs_fd, unsigned int cmd, const char __user *key,
 			     const void __user *value, int aux);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index f4a01305d9a6..c65644574038 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -857,9 +857,11 @@ __SYSCALL(__NR_openat2, sys_openat2)
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 #define __NR_faccessat2 439
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
+#define __NR_mount_setattr 440
+__SYSCALL(__NR_mount_setattr, sys_mount_setattr)
 
 #undef __NR_syscalls
-#define __NR_syscalls 440
+#define __NR_syscalls 441
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 96a0240f23fe..7582d545738b 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -117,4 +117,35 @@ enum fsconfig_command {
 #define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
 #define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
 
+/*
+ * mount_setattr()
+ */
+struct mount_attr {
+	__u64 attr_set;
+	__u64 attr_clr;
+	__u32 propagation;
+	__u32 atime;
+};
+
+/* Change propagation through mount_setattr(). */
+enum propagation_type {
+	MAKE_PROPAGATION_UNCHANGED	= 0, /* Don't change mount propagation (default). */
+	MAKE_PROPAGATION_UNBINDABLE	= 1, /* Make unbindable. */
+	MAKE_PROPAGATION_PRIVATE	= 2, /* Do not receive or send mount events. */
+	MAKE_PROPAGATION_DEPENDENT	= 3, /* Only receive mount events. */
+	MAKE_PROPAGATION_SHARED		= 4, /* Send and receive mount events. */
+};
+
+/* Change atime settings through mount_setattr() */
+enum atime_type {
+	MAKE_ATIME_UNCHANGED	= 0, /* Don't change atime settings. */
+	MAKE_ATIME_RELATIVE	= 1, /* Update atime relative to mtime/ctime. */
+	MAKE_ATIME_NONE		= 2, /* Do not update access times. */
+	MAKE_ATIME_STRICT	= 3, /* Always perform atime updates. */
+};
+
+/* List of all mount_attr versions. */
+#define MOUNT_ATTR_SIZE_VER0	24 /* sizeof first published struct */
+#define MOUNT_ATTR_SIZE_LATEST	MOUNT_ATTR_SIZE_VER0
+
 #endif /* _UAPI_LINUX_MOUNT_H */
-- 
2.27.0

