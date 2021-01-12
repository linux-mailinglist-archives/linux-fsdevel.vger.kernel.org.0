Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDAF2F3E68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 01:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393900AbhALWDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 17:03:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42954 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732008AbhALWDs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:03:48 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kzRkf-0003bd-Jk; Tue, 12 Jan 2021 22:02:57 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 06/42] fs: add mount_setattr()
Date:   Tue, 12 Jan 2021 23:00:48 +0100
Message-Id: <20210112220124.837960-7-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112220124.837960-1-christian.brauner@ubuntu.com>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=W+eEJHNrlkV/b8gMOjwmCnJaxH/2Jd0g2RrCW3G+aTQ=; m=QcgL0cjyvfcZKIrxSMNhdjdTnW09uylRO383w6MgQlU=; p=rflNSi8KbXDs975d5YeoJSwOhSr850AR5uEfCK3Tvlg=; g=5d732841496a08de53bce1e1adfbb590e89bff9c
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCX/4YtQAKCRCRxhvAZXjcotz9AQDx8YG iWatQjz46otACqmQQDc/+1yojdOoYx68RtxCSHAEAnlAeisLQCvKCYItrE4BpjT557n68NgdT74Ly +RhgBww=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This implements the missing mount_setattr() syscall. While the new mount
api allows to change the properties of a superblock there is currently
no way to change the properties of a mount or a mount tree using file
descriptors which the new mount api is based on. In addition the old
mount api has the restriction that mount options cannot be applied
recursively. This hasn't changed since changing mount options on a
per-mount basis was implemented in [1] and has been a frequent request
not just for convenience but also for security reasons. The legacy
mount syscall is unable to accommodate this behavior without introducing
a whole new set of flags because MS_REC | MS_REMOUNT | MS_BIND |
MS_RDONLY | MS_NOEXEC | [...] only apply the mount option to the topmost
mount. Changing MS_REC to apply to the whole mount tree would mean
introducing a significant uapi change and would likely cause significant
regressions.

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

The mount_setattr() syscall can be expected to grow over time and is
designed with extensibility in mind. It follows the extensible syscall
pattern we have used with other syscalls such as openat2(), clone3(),
sched_{set,get}attr(), and others.
The set of mount options is passed in the uapi struct mount_attr which
currently has the following layout:

struct mount_attr {
	__u64 attr_set;
	__u64 attr_clr;
	__u64 propagation;
};

The @attr_set and @attr_clr members are used to clear and set mount
options. This way a user can e.g. request that a set of flags is to be
raised such as turning mounts readonly by raising MOUNT_ATTR_RDONLY in
@attr_set while at the same time requesting that another set of flags is
to be lowered such as removing noexec from a mount tree by specifying
MOUNT_ATTR_NOEXEC in @attr_clr.

Note, since the MOUNT_ATTR_<atime> values are an enum starting from 0,
not a bitmap, users wanting to transition to a different atime setting
cannot simply specify the atime setting in @attr_set, but must also
specify MOUNT_ATTR__ATIME in the @attr_clr field. So we ensure that
MOUNT_ATTR__ATIME can't be partially set in @attr_clr and that @attr_set
can't have any atime bits set if MOUNT_ATTR__ATIME isn't set in
@attr_clr.

The @propagation field lets callers specify the propagation type of a
mount tree. Propagation is a single property that has four different
settings and as such is not really a flag argument but an enum.
Specifically, it would be unclear what setting and clearing propagation
settings in combination would amount to. The legacy mount() syscall thus
forbids the combination of multiple propagation settings too. The goal
is to keep the semantics of mount propagation somewhat simple as they
are overly complex as it is.

[1]: commit 2e4b7fcd9260 ("[PATCH] r/o bind mounts: honor mount writer counts at remount")
Cc: David Howells <dhowells@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christoph Hellwig <hch@lst.de>:
  - Split into multiple helpers.

/* v3 */
- kernel test robot <lkp@intel.com>:
  - Fix unknown __u64 type by including linux/types.h in linux/mount.h.

/* v4 */
- Christoph Hellwig <hch@lst.de>:
  - Make sure lines wrap at 80 chars.
  - Move struct mount_kattr out of the internal.h header and completely
    into fs/namespace.c as it's not used outside of that file.
  - Add missing space between ( and { when initializing mount_kattr.
  - Split flag validation and calculation into separate preparatory
    patch.
  - Simplify flag validation in build_mount_kattr() to avoid
    upper_32_bits() and lower_32_bits() calls. This will also lead to
    better code generation.
  - Remove new propagation enums and simply use the old flags.
  - Strictly adhere to 80 char limit.
  - Restructure the time setting code in build_mount_kattr().

/* v5 */
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

- Christoph Hellwig <hch@lst.de>:
  - Simplify mount propagation flag checking.
  - Wrap overly long line.
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
 fs/namespace.c                              | 260 ++++++++++++++++++++
 include/linux/syscalls.h                    |   4 +
 include/uapi/asm-generic/unistd.h           |   4 +-
 include/uapi/linux/mount.h                  |  14 ++
 tools/include/uapi/asm-generic/unistd.h     |   4 +-
 22 files changed, 302 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index a6617067dbe6..02f0244e005c 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -481,3 +481,4 @@
 549	common	faccessat2			sys_faccessat2
 550	common	process_madvise			sys_process_madvise
 551	common	epoll_pwait2			sys_epoll_pwait2
+552	common	mount_setattr			sys_mount_setattr
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 20e1170e2e0a..dcc1191291a2 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -455,3 +455,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index cccfbbefbf95..3d874f624056 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -891,6 +891,8 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
 __SYSCALL(__NR_process_madvise, sys_process_madvise)
 #define __NR_epoll_pwait2 441
 __SYSCALL(__NR_epoll_pwait2, compat_sys_epoll_pwait2)
+#define __NR_mount_setattr 442
+__SYSCALL(__NR_mount_setattr, sys_mount_setattr)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index bfc00f2bd437..d89231166e19 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -362,3 +362,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 7fe4e45c864c..72bde6707dd3 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -441,3 +441,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index a522adf194ab..d603a5ec9338 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -447,3 +447,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 0f03ad223f33..8fd8c1790941 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -380,3 +380,4 @@
 439	n32	faccessat2			sys_faccessat2
 440	n32	process_madvise			sys_process_madvise
 441	n32	epoll_pwait2			compat_sys_epoll_pwait2
+442	n32	mount_setattr			sys_mount_setattr
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 91649690b52f..169f21438065 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -356,3 +356,4 @@
 439	n64	faccessat2			sys_faccessat2
 440	n64	process_madvise			sys_process_madvise
 441	n64	epoll_pwait2			sys_epoll_pwait2
+442	n64	mount_setattr			sys_mount_setattr
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 4bad0c40aed6..090d29ca80ff 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -429,3 +429,4 @@
 439	o32	faccessat2			sys_faccessat2
 440	o32	process_madvise			sys_process_madvise
 441	o32	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	o32	mount_setattr			sys_mount_setattr
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 6bcc31966b44..271a92519683 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -439,3 +439,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index f744eb5cba88..72e5aa67ab8a 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -531,3 +531,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index d443423495e5..3abef2144dac 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -444,3 +444,4 @@
 439  common	faccessat2		sys_faccessat2			sys_faccessat2
 440  common	process_madvise		sys_process_madvise		sys_process_madvise
 441  common	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
+442  common	mount_setattr		sys_mount_setattr		sys_mount_setattr
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 9df40ac0ebc0..d08eebad6b7f 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -444,3 +444,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 40d8c7cd8298..84403a99039c 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -487,3 +487,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 874aeacde2dd..a1c9f496fca6 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -446,3 +446,4 @@
 439	i386	faccessat2		sys_faccessat2
 440	i386	process_madvise		sys_process_madvise
 441	i386	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	i386	mount_setattr		sys_mount_setattr
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 78672124d28b..7bf01cbe582f 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -363,6 +363,7 @@
 439	common	faccessat2		sys_faccessat2
 440	common	process_madvise		sys_process_madvise
 441	common	epoll_pwait2		sys_epoll_pwait2
+442	common	mount_setattr		sys_mount_setattr
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 46116a28eeed..365a9b849224 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -412,3 +412,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
diff --git a/fs/namespace.c b/fs/namespace.c
index a1cfcab217e1..6efae2681bcd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -73,6 +73,14 @@ static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
 
+struct mount_kattr {
+	unsigned int attr_set;
+	unsigned int attr_clr;
+	unsigned int propagation;
+	unsigned int lookup_flags;
+	bool recurse;
+};
+
 /* /sys/fs */
 struct kobject *fs_kobj;
 EXPORT_SYMBOL_GPL(fs_kobj);
@@ -3457,6 +3465,11 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
 	(MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NODEV | \
 	 MOUNT_ATTR_NOEXEC | MOUNT_ATTR__ATIME | MOUNT_ATTR_NODIRATIME)
 
+#define MOUNT_SETATTR_VALID_FLAGS FSMOUNT_VALID_FLAGS
+
+#define MOUNT_SETATTR_PROPAGATION_FLAGS \
+	(MS_UNBINDABLE | MS_PRIVATE | MS_SLAVE | MS_SHARED)
+
 static unsigned int attr_flags_to_mnt_flags(u64 attr_flags)
 {
 	unsigned int mnt_flags = 0;
@@ -3808,6 +3821,253 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	return error;
 }
 
+static unsigned int recalc_flags(struct mount_kattr *kattr, struct mount *mnt)
+{
+	unsigned int flags = mnt->mnt.mnt_flags;
+
+	/*  flags to clear */
+	flags &= ~kattr->attr_clr;
+	/* flags to raise */
+	flags |= kattr->attr_set;
+
+	return flags;
+}
+
+static struct mount *mount_setattr_prepare(struct mount_kattr *kattr,
+					   struct mount *mnt, int *err)
+{
+	struct mount *m = mnt, *last = NULL;
+
+	if (!is_mounted(&m->mnt)) {
+		*err = -EINVAL;
+		goto out;
+	}
+
+	if (!(mnt_has_parent(m) ? check_mnt(m) : is_anon_ns(m->mnt_ns))) {
+		*err = -EINVAL;
+		goto out;
+	}
+
+	do {
+		unsigned int flags;
+
+		flags = recalc_flags(kattr, m);
+		if (!can_change_locked_flags(m, flags)) {
+			*err = -EPERM;
+			goto out;
+		}
+
+		last = m;
+
+		if ((kattr->attr_set & MNT_READONLY) &&
+		    !(m->mnt.mnt_flags & MNT_READONLY)) {
+			*err = mnt_hold_writers(m);
+			if (*err)
+				goto out;
+		}
+	} while (kattr->recurse && (m = next_mnt(m, mnt)));
+
+out:
+	return last;
+}
+
+static void mount_setattr_commit(struct mount_kattr *kattr,
+				 struct mount *mnt, struct mount *last,
+				 int err)
+{
+	struct mount *m = mnt;
+
+	do {
+		if (!err) {
+			unsigned int flags;
+
+			flags = recalc_flags(kattr, m);
+			WRITE_ONCE(m->mnt.mnt_flags, flags);
+		}
+
+		/*
+		 * We either set MNT_READONLY above so make it visible
+		 * before ~MNT_WRITE_HOLD or we failed to recursively
+		 * apply mount options.
+		 */
+		if ((kattr->attr_set & MNT_READONLY) &&
+		    (m->mnt.mnt_flags & MNT_WRITE_HOLD))
+			mnt_unhold_writers(m);
+
+		if (!err && kattr->propagation)
+			change_mnt_propagation(m, kattr->propagation);
+
+		/*
+		 * On failure, only cleanup until we found the first mount
+		 * we failed to handle.
+		 */
+		if (err && m == last)
+			break;
+	} while (kattr->recurse && (m = next_mnt(m, mnt)));
+
+	if (!err)
+		touch_mnt_namespace(mnt->mnt_ns);
+}
+
+static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
+{
+	struct mount *mnt = real_mount(path->mnt), *last = NULL;
+	int err = 0;
+
+	if (path->dentry != mnt->mnt.mnt_root)
+		return -EINVAL;
+
+	if (kattr->propagation) {
+		/*
+		 * Only take namespace_lock() if we're actually changing
+		 * propagation.
+		 */
+		namespace_lock();
+		if (kattr->propagation == MS_SHARED) {
+			err = invent_group_ids(mnt, kattr->recurse);
+			if (err) {
+				namespace_unlock();
+				return err;
+			}
+		}
+	}
+
+	lock_mount_hash();
+
+	/*
+	 * Get the mount tree in a shape where we can change mount
+	 * properties without failure.
+	 */
+	last = mount_setattr_prepare(kattr, mnt, &err);
+	if (last) /* Commit all changes or revert to the old state. */
+		mount_setattr_commit(kattr, mnt, last, err);
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
+	*kattr = (struct mount_kattr) {
+		.lookup_flags	= lookup_flags,
+		.recurse	= !!(flags & AT_RECURSIVE),
+	};
+
+	if (attr->propagation & ~MOUNT_SETATTR_PROPAGATION_FLAGS)
+		return -EINVAL;
+	if (hweight32(attr->propagation & MOUNT_SETATTR_PROPAGATION_FLAGS) > 1)
+		return -EINVAL;
+	kattr->propagation = attr->propagation;
+
+	if ((attr->attr_set | attr->attr_clr) & ~MOUNT_SETATTR_VALID_FLAGS)
+		return -EINVAL;
+
+	kattr->attr_set = attr_flags_to_mnt_flags(attr->attr_set);
+	kattr->attr_clr = attr_flags_to_mnt_flags(attr->attr_clr);
+
+	/*
+	 * Since the MOUNT_ATTR_<atime> values are an enum, not a bitmap,
+	 * users wanting to transition to a different atime setting cannot
+	 * simply specify the atime setting in @attr_set, but must also
+	 * specify MOUNT_ATTR__ATIME in the @attr_clr field.
+	 * So ensure that MOUNT_ATTR__ATIME can't be partially set in
+	 * @attr_clr and that @attr_set can't have any atime bits set if
+	 * MOUNT_ATTR__ATIME isn't set in @attr_clr.
+	 */
+	if (attr->attr_clr & MOUNT_ATTR__ATIME) {
+		if ((attr->attr_clr & MOUNT_ATTR__ATIME) != MOUNT_ATTR__ATIME)
+			return -EINVAL;
+
+		/*
+		 * Clear all previous time settings as they are mutually
+		 * exclusive.
+		 */
+		kattr->attr_clr |= MNT_RELATIME | MNT_NOATIME;
+		switch (attr->attr_set & MOUNT_ATTR__ATIME) {
+		case MOUNT_ATTR_RELATIME:
+			kattr->attr_set |= MNT_RELATIME;
+			break;
+		case MOUNT_ATTR_NOATIME:
+			kattr->attr_set |= MNT_NOATIME;
+			break;
+		case MOUNT_ATTR_STRICTATIME:
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		if (attr->attr_set & MOUNT_ATTR__ATIME)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
+		unsigned int, flags, struct mount_attr __user *, uattr,
+		size_t, usize)
+{
+	int err;
+	struct path target;
+	struct mount_attr attr;
+	struct mount_kattr kattr;
+
+	BUILD_BUG_ON(sizeof(struct mount_attr) != MOUNT_ATTR_SIZE_VER0);
+
+	if (flags & ~(AT_EMPTY_PATH |
+		      AT_RECURSIVE |
+		      AT_SYMLINK_NOFOLLOW |
+		      AT_NO_AUTOMOUNT))
+		return -EINVAL;
+
+	if (unlikely(usize > PAGE_SIZE))
+		return -E2BIG;
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
+	/* Don't bother walking through the mounts if this is a nop. */
+	if (attr.attr_set == 0 &&
+	    attr.attr_clr == 0 &&
+	    attr.propagation == 0)
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
index 7688bc983de5..cd7b5c817ba2 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -68,6 +68,7 @@ union bpf_attr;
 struct io_uring_params;
 struct clone_args;
 struct open_how;
+struct mount_attr;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -1028,6 +1029,9 @@ asmlinkage long sys_open_tree(int dfd, const char __user *path, unsigned flags);
 asmlinkage long sys_move_mount(int from_dfd, const char __user *from_path,
 			       int to_dfd, const char __user *to_path,
 			       unsigned int ms_flags);
+asmlinkage long sys_mount_setattr(int dfd, const char __user *path,
+				  unsigned int flags,
+				  struct mount_attr __user *uattr, size_t usize);
 asmlinkage long sys_fsopen(const char __user *fs_name, unsigned int flags);
 asmlinkage long sys_fsconfig(int fs_fd, unsigned int cmd, const char __user *key,
 			     const void __user *value, int aux);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 728752917785..ce58cff99b66 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -861,9 +861,11 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
 __SYSCALL(__NR_process_madvise, sys_process_madvise)
 #define __NR_epoll_pwait2 441
 __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
+#define __NR_mount_setattr 442
+__SYSCALL(__NR_mount_setattr, sys_mount_setattr)
 
 #undef __NR_syscalls
-#define __NR_syscalls 442
+#define __NR_syscalls 443
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index dd8306ea336c..2255624e91c8 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -1,6 +1,8 @@
 #ifndef _UAPI_LINUX_MOUNT_H
 #define _UAPI_LINUX_MOUNT_H
 
+#include <linux/types.h>
+
 /*
  * These are the fs-independent mount-flags: up to 32 flags are supported
  *
@@ -118,4 +120,16 @@ enum fsconfig_command {
 #define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
 #define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
 
+/*
+ * mount_setattr()
+ */
+struct mount_attr {
+	__u64 attr_set;
+	__u64 attr_clr;
+	__u64 propagation;
+};
+
+/* List of all mount_attr versions. */
+#define MOUNT_ATTR_SIZE_VER0	24 /* sizeof first published struct */
+
 #endif /* _UAPI_LINUX_MOUNT_H */
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 728752917785..ce58cff99b66 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -861,9 +861,11 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
 __SYSCALL(__NR_process_madvise, sys_process_madvise)
 #define __NR_epoll_pwait2 441
 __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
+#define __NR_mount_setattr 442
+__SYSCALL(__NR_mount_setattr, sys_mount_setattr)
 
 #undef __NR_syscalls
-#define __NR_syscalls 442
+#define __NR_syscalls 443
 
 /*
  * 32 bit systems traditionally used different
-- 
2.30.0

