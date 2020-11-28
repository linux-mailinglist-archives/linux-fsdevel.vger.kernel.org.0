Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09762C7369
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 23:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390322AbgK1WLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 17:11:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55487 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731114AbgK1WLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 17:11:16 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kj83g-0002aM-Vt; Sat, 28 Nov 2020 21:47:09 +0000
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
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org, fstests@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>
Subject: [PATCH v3 36/38] fs: introduce MOUNT_ATTR_IDMAP
Date:   Sat, 28 Nov 2020 22:35:25 +0100
Message-Id: <20201128213527.2669807-37-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201128213527.2669807-1-christian.brauner@ubuntu.com>
References: <20201128213527.2669807-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a new mount bind mount property to allow idmapping mounts. The
MOUNT_ATTR_IDMAP flag can be set via the new mount_setattr() syscall
together with a file descriptor referring to a user namespace.

The user namespace referenced by the namespace file descriptor will be
attached to the bind mount. All interactions with the filesystem going
through that mount will be idmapped according to the mapping specified in
the user namespace attached to it.

Using user namespaces to mark mounts means we can reuse all the existing
infrastructure in the kernel that already exists to handle idmappings and can
also use this for permission checking to allow unprivileged user to create
idmapped mounts in the future.

Idmapping a mount is decoupled from the caller's user and mount namespace.
This means idmapped mounts can be created in the initial user namespace
which is an important use-case for systemd-homed, portable usb-sticks
between systems, sharing data between the initial user namespace and
unprivileged containers, and other use-cases that have been brought up. For
example, assume a home directory where all files are owned by uid and gid
1000 and the home directory is brought to a new laptop where the user has
id 12345. The system administrator can simply create a mount of this home
directory with a mapping of 1000:12345:1 and other mappings to indicate the ids
should be kept. (With this it is e.g. also possible to create idmapped mounts on
the host with an identity mapping 1:1:100000 where the root user is not mapped.
A user with root access that e.g. has been pivot rooted into such a mount on the
host will be not be able to execute, read, write, or create files as root.)

Given that idmapping a mount is decoupled from the caller's user namespace
a sufficiently privileged process such as a container manager can set up a
shifted mount for the container and the container can simply pivot root to
it. There's no need for the container to do anything. The mount will appear
correctly mapped independent of the user namespace the container uses. This
means we don't need to mark a mount as idmappable.

In order to create an idmapped mount the caller must currently be privileged in
the user namespace of the superblock the mount belongs to. Currently, once a
mount has been idmapped we don't allow it to change its mapping. This can be
changed in the future if the use-cases arise.

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Mauricio Vásquez Bernal <mauricio@kinvolk.io>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christoph Hellwig <hch@lst.de>:
  - Drop kconfig option to make vfs idmappings unconditional.
  - Move introduction of MOUNT_ATTR_IDMAP to the end of the series after all
    internal changes have been done.
  - Move MOUNT_ATTR_IDMAP handling from build_mount_kattr() to separate
    build_mount_idmapped() helper.
  - Move MNT_IDMAPPED handling from do_mount_setattr() into separate
    do_mount_idmap() helper.
  - Use more helpers instead of one big function for mount attribute changes.
- Mauricio Vásquez Bernal <mauricio@kinvolk.io>:
  - Recalculate flags before checking can_change_locked_flags().

/* v3 */
- David Howells <dhowells@redhat.com>:
  - Use smp_load_acquire() and smp_store_release() in mnt_user_ns() and do_idmap_mount().
- Remove all references to MNT_IDMAPPED now that the flag has been removed.
---
 fs/internal.h              |   1 +
 fs/namespace.c             | 126 +++++++++++++++++++++++++++++++++++--
 fs/proc_namespace.c        |   3 +
 include/linux/fs.h         |   2 +-
 include/linux/mount.h      |   3 +-
 include/uapi/linux/mount.h |   5 +-
 6 files changed, 133 insertions(+), 7 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index a5a6c470dc07..b0978274155f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -88,6 +88,7 @@ struct mount_kattr {
 	unsigned int propagation;
 	unsigned int lookup_flags;
 	bool recurse;
+	struct user_namespace *mnt_user_ns;
 };
 
 extern struct vfsmount *lookup_mnt(const struct path *);
diff --git a/fs/namespace.c b/fs/namespace.c
index a1fda548c3af..a74559c8093c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -25,6 +25,7 @@
 #include <linux/proc_ns.h>
 #include <linux/magic.h>
 #include <linux/memblock.h>
+#include <linux/proc_fs.h>
 #include <linux/task_work.h>
 #include <linux/sched/task.h>
 #include <uapi/linux/mount.h>
@@ -3468,7 +3469,8 @@ static int build_attr_flags(unsigned int attr_flags, unsigned int *flags)
 			   MOUNT_ATTR_NODEV |
 			   MOUNT_ATTR_NOEXEC |
 			   MOUNT_ATTR__ATIME |
-			   MOUNT_ATTR_NODIRATIME))
+			   MOUNT_ATTR_NODIRATIME |
+			   MOUNT_ATTR_IDMAP))
 		return -EINVAL;
 
 	if (attr_flags & MOUNT_ATTR_RDONLY)
@@ -3508,6 +3510,14 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	if ((flags & ~(FSMOUNT_CLOEXEC)) != 0)
 		return -EINVAL;
 
+	if (attr_flags & ~(MOUNT_ATTR_RDONLY |
+			   MOUNT_ATTR_NOSUID |
+			   MOUNT_ATTR_NODEV |
+			   MOUNT_ATTR_NOEXEC |
+			   MOUNT_ATTR__ATIME |
+			   MOUNT_ATTR_NODIRATIME))
+		return -EINVAL;
+
 	ret = build_attr_flags(attr_flags, &mnt_flags);
 	if (ret)
 		return ret;
@@ -3830,6 +3840,32 @@ static unsigned int recalc_flags(struct mount_kattr *kattr, struct mount *mnt)
 	return flags;
 }
 
+static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
+{
+	struct vfsmount *m = &mnt->mnt;
+
+	if (!kattr->mnt_user_ns)
+		return 0;
+
+	/*
+	 * Once a mount has been idmapped we don't allow it to change its
+	 * mapping. It makes things simpler and callers can just create
+	 * another bind-mount they can idmap if they want to.
+	 */
+	if (mnt_user_ns(m) != &init_user_ns)
+		return -EPERM;
+
+	/* The underlying filesystem doesn't support idmapped mounts yet. */
+	if (!(m->mnt_sb->s_type->fs_flags & FS_ALLOW_IDMAP))
+		return -EINVAL;
+
+	/* We're controlling the superblock. */
+	if (!ns_capable(m->mnt_sb->s_user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return 0;
+}
+
 static struct mount *mount_setattr_prepare(struct mount_kattr *kattr,
 					   struct mount *mnt, int *err)
 {
@@ -3854,6 +3890,10 @@ static struct mount *mount_setattr_prepare(struct mount_kattr *kattr,
 			goto out;
 		}
 
+		*err = can_idmap_mount(kattr, m);
+		if (*err)
+			goto out;
+
 		last = m;
 
 		if ((kattr->attr_set & MNT_READONLY) &&
@@ -3868,6 +3908,18 @@ static struct mount *mount_setattr_prepare(struct mount_kattr *kattr,
 	return last;
 }
 
+static void do_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
+{
+	struct user_namespace *user_ns;
+
+	if (!kattr->mnt_user_ns)
+		return;
+
+	user_ns = get_user_ns(kattr->mnt_user_ns);
+	/* Pairs with smp_load_acquire() in mnt_user_ns(). */
+	smp_store_release(&mnt->mnt.mnt_user_ns, user_ns);
+}
+
 static void mount_setattr_commit(struct mount_kattr *kattr, struct mount *mnt,
 				 struct mount *last, int err)
 {
@@ -3877,6 +3929,7 @@ static void mount_setattr_commit(struct mount_kattr *kattr, struct mount *mnt,
 		if (!err) {
 			unsigned int flags;
 
+			do_idmap_mount(kattr, m);
 			flags = recalc_flags(kattr, m);
 			WRITE_ONCE(m->mnt.mnt_flags, flags);
 		}
@@ -3949,7 +4002,65 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 	return err;
 }
 
-static int build_mount_kattr(const struct mount_attr *attr,
+static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
+				struct mount_kattr *kattr, unsigned int flags)
+{
+	int err = 0;
+	struct ns_common *ns;
+	struct user_namespace *user_ns;
+	struct file *file;
+
+	if (!((attr->attr_set | attr->attr_clr) & MOUNT_ATTR_IDMAP))
+		return 0;
+
+	/*
+	 * We currently do not support clearing an idmapped mount. If this ever
+	 * is a use-case we can revisit this but for now let's keep it simple
+	 * and not allow it.
+	 */
+	if (attr->attr_clr & MOUNT_ATTR_IDMAP)
+		return -EINVAL;
+
+	if (usize < MOUNT_ATTR_SIZE_VER1)
+		return -EINVAL;
+
+	if (attr->userns_fd > INT_MAX)
+		return -EINVAL;
+
+	file = fget(attr->userns_fd);
+	if (!file)
+		return -EBADF;
+
+	if (!proc_ns_file(file)) {
+		err = -EINVAL;
+		goto out_fput;
+	}
+
+	ns = get_proc_ns(file_inode(file));
+	if (ns->ops->type != CLONE_NEWUSER) {
+		err = -EINVAL;
+		goto out_fput;
+	}
+
+	/*
+	 * The init_user_ns is used to indicate that a vfsmount is not idmapped.
+	 * This is simpler than just having to treat NULL as unmapped. Users
+	 * wanting to idmap a mount to init_user_ns can just use a namespace
+	 * with an identity mapping.
+	 */
+	user_ns = container_of(ns, struct user_namespace, ns);
+	if (user_ns == &init_user_ns) {
+		err = -EPERM;
+		goto out_fput;
+	}
+	kattr->mnt_user_ns = get_user_ns(user_ns);
+
+out_fput:
+	fput(file);
+	return err;
+}
+
+static int build_mount_kattr(const struct mount_attr *attr, size_t usize,
 			     struct mount_kattr *kattr, unsigned int flags)
 {
 	unsigned int lookup_flags = LOOKUP_AUTOMOUNT | LOOKUP_FOLLOW;
@@ -4028,7 +4139,13 @@ static int build_mount_kattr(const struct mount_attr *attr,
 		}
 	}
 
-	return 0;
+	return build_mount_idmapped(attr, usize, kattr, flags);
+}
+
+static void finish_mount_kattr(struct mount_kattr *kattr)
+{
+	put_user_ns(kattr->mnt_user_ns);
+	kattr->mnt_user_ns = NULL;
 }
 
 SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path, unsigned int, flags,
@@ -4060,7 +4177,7 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path, unsigned int
 	if (attr.attr_set == 0 && attr.attr_clr == 0 && attr.propagation == 0)
 		return 0;
 
-	err = build_mount_kattr(&attr, &kattr, flags);
+	err = build_mount_kattr(&attr, usize, &kattr, flags);
 	if (err)
 		return err;
 
@@ -4069,6 +4186,7 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path, unsigned int
 		return err;
 
 	err = do_mount_setattr(&target, &kattr);
+	finish_mount_kattr(&kattr);
 	path_put(&target);
 	return err;
 }
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index e59d4bb3a89e..71ab9497feb3 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -79,6 +79,9 @@ static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
 		if (mnt->mnt_flags & fs_infop->flag)
 			seq_puts(m, fs_infop->str);
 	}
+
+	if (mnt_user_ns(mnt) != &init_user_ns)
+		seq_puts(m, ",idmapped");
 }
 
 static inline void mangle(struct seq_file *m, const char *s)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c7f9ba689145..b88ce1b2c87a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2293,7 +2293,7 @@ struct file_system_type {
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
-#define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
+#define FS_ALLOW_IDMAP		32	/* FS has been updated to handle vfs idmappings. */
 #define FS_THP_SUPPORT		8192	/* Remove once all fs converted */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index d0d4a270acea..f87811045aec 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -77,7 +77,8 @@ struct vfsmount {
 
 static inline struct user_namespace *mnt_user_ns(const struct vfsmount *mnt)
 {
-	return READ_ONCE(mnt->mnt_user_ns);
+	/* Pairs with smp_store_release() in do_idmap_mount(). */
+	return smp_load_acquire(&mnt->mnt_user_ns);
 }
 
 struct file; /* forward dec */
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index fba42b4bfc1c..66422a58f061 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -119,6 +119,7 @@ enum fsconfig_command {
 #define MOUNT_ATTR_NOATIME	0x00000010 /* - Do not update access times. */
 #define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
 #define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
+#define MOUNT_ATTR_IDMAP	0x00100000 /* Idmap this mount to @userns in mount_attr. */
 
 /*
  * mount_setattr()
@@ -127,6 +128,7 @@ struct mount_attr {
 	__u64 attr_set;
 	__u64 attr_clr;
 	__u64 propagation;
+	__u64 userns_fd;
 };
 
 /* Change propagation through mount_setattr(). */
@@ -140,6 +142,7 @@ enum propagation_type {
 
 /* List of all mount_attr versions. */
 #define MOUNT_ATTR_SIZE_VER0	24 /* sizeof first published struct */
-#define MOUNT_ATTR_SIZE_LATEST	MOUNT_ATTR_SIZE_VER0
+#define MOUNT_ATTR_SIZE_VER1	32 /* sizeof second published struct */
+#define MOUNT_ATTR_SIZE_LATEST	MOUNT_ATTR_SIZE_VER1
 
 #endif /* _UAPI_LINUX_MOUNT_H */
-- 
2.29.2

