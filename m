Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D9A2FEC18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 14:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbhAUNgC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 08:36:02 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55343 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732322AbhAUNdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:33:50 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2ZvE-0005g7-Ks; Thu, 21 Jan 2021 13:22:48 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
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
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>
Subject: [PATCH v6 35/40] fs: introduce MOUNT_ATTR_IDMAP
Date:   Thu, 21 Jan 2021 14:19:54 +0100
Message-Id: <20210121131959.646623-36-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=GYBYwKZNDijutmVrBepxrBfFO75BWdoBVtOTOIdJMkE=; m=g2OTP5WhmjQoF4YIz2CErqPQQ+/BcQ7bZDA/hJnmTx4=; p=pLgwfiRIfyez30F/gXKXFmr2v9NKbMEDUbGPPwZQMoE=; g=ca28a99329fde4f12d172e5c620040de51d3dbec
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYAl9pwAKCRCRxhvAZXjcomdeAP9lW0x Kssz2dnQVjCnCI9CPd0QVBxllhW82htHW/CFstQEA5bQb6KnS7tLEd2U0fC1XZwuq+sIQ8qR6Wkww XqcX6AQ=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a new mount bind mount property to allow idmapping mounts. The
MOUNT_ATTR_IDMAP flag can be set via the new mount_setattr() syscall
together with a file descriptor referring to a user namespace.

The user namespace referenced by the namespace file descriptor will be
attached to the bind mount. All interactions with the filesystem going
through that mount will be mapped according to the mapping specified in
the user namespace attached to it.

Using user namespaces to mark mounts means we can reuse all the existing
infrastructure in the kernel that already exists to handle idmappings
and can also use this for permission checking to allow unprivileged user
to create idmapped mounts in the future.

Idmapping a mount is decoupled from the caller's user and mount
namespace. This means idmapped mounts can be created in the initial
user namespace which is an important use-case for systemd-homed,
portable usb-sticks between systems, sharing data between the initial
user namespace and unprivileged containers, and other use-cases that
have been brought up. For example, assume a home directory where all
files are owned by uid and gid 1000 and the home directory is brought to
a new laptop where the user has id 12345. The system administrator can
simply create a mount of this home directory with a mapping of
1000:12345:1 and other mappings to indicate the ids should be kept.
(With this it is e.g. also possible to create idmapped mounts on the
host with an identity mapping 1:1:100000 where the root user is not
mapped. A user with root access that e.g. has been pivot rooted into
such a mount on the host will be not be able to execute, read, write, or
create files as root.)

Given that mapping a mount is decoupled from the caller's user namespace
a sufficiently privileged process such as a container manager can set up
an idmapped mount for the container and the container can simply pivot
root to it. There's no need for the container to do anything. The mount
will appear correctly mapped independent of the user namespace the
container uses. This means we don't need to mark a mount as idmappable.

In order to create an idmapped mount the caller must currently be
privileged in the user namespace of the superblock the mount belongs to.
Once a mount has been idmapped we don't allow it to change its mapping.
This keeps permission checking and life-cycle management simple. Users
wanting to change the idmapped can always create a new detached mount
with a different idmapping.

Link: https://lore.kernel.org/r/20210112220124.837960-41-christian.brauner@ubuntu.com
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

/* v4 */
- Serge Hallyn <serge@hallyn.com>:
  - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
    terminology consistent.

/* v5 */
unchanged
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

/* v6 */
base-commit: 19c329f6808995b142b3966301f217c831e7cf31

- Christoph Hellwig <hch@lst.de>:
  - Include userns_fd in MOUNT_ATTR_SIZE_VER0 instead of introducing a
    separate MOUNT_ATTR_SIZE_VER1.
---
 fs/namespace.c             | 115 +++++++++++++++++++++++++++++++++++--
 fs/proc_namespace.c        |   3 +
 include/linux/mount.h      |   3 +-
 include/uapi/linux/mount.h |   4 +-
 4 files changed, 119 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index dda1aac8bf5b..584496abc3e8 100644
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
@@ -79,6 +80,7 @@ struct mount_kattr {
 	unsigned int propagation;
 	unsigned int lookup_flags;
 	bool recurse;
+	struct user_namespace *mnt_userns;
 };
 
 /* /sys/fs */
@@ -3477,7 +3479,7 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
 	(MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NODEV | \
 	 MOUNT_ATTR_NOEXEC | MOUNT_ATTR__ATIME | MOUNT_ATTR_NODIRATIME)
 
-#define MOUNT_SETATTR_VALID_FLAGS FSMOUNT_VALID_FLAGS
+#define MOUNT_SETATTR_VALID_FLAGS (FSMOUNT_VALID_FLAGS | MOUNT_ATTR_IDMAP)
 
 #define MOUNT_SETATTR_PROPAGATION_FLAGS \
 	(MS_UNBINDABLE | MS_PRIVATE | MS_SLAVE | MS_SHARED)
@@ -3845,6 +3847,32 @@ static unsigned int recalc_flags(struct mount_kattr *kattr, struct mount *mnt)
 	return flags;
 }
 
+static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
+{
+	struct vfsmount *m = &mnt->mnt;
+
+	if (!kattr->mnt_userns)
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
+	/* We're not controlling the superblock. */
+	if (!ns_capable(m->mnt_sb->s_user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return 0;
+}
+
 static struct mount *mount_setattr_prepare(struct mount_kattr *kattr,
 					   struct mount *mnt, int *err)
 {
@@ -3869,6 +3897,10 @@ static struct mount *mount_setattr_prepare(struct mount_kattr *kattr,
 			goto out;
 		}
 
+		*err = can_idmap_mount(kattr, m);
+		if (*err)
+			goto out;
+
 		last = m;
 
 		if ((kattr->attr_set & MNT_READONLY) &&
@@ -3883,6 +3915,18 @@ static struct mount *mount_setattr_prepare(struct mount_kattr *kattr,
 	return last;
 }
 
+static void do_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
+{
+	struct user_namespace *mnt_userns;
+
+	if (!kattr->mnt_userns)
+		return;
+
+	mnt_userns = get_user_ns(kattr->mnt_userns);
+	/* Pairs with smp_load_acquire() in mnt_user_ns(). */
+	smp_store_release(&mnt->mnt.mnt_userns, mnt_userns);
+}
+
 static void mount_setattr_commit(struct mount_kattr *kattr,
 				 struct mount *mnt, struct mount *last,
 				 int err)
@@ -3893,6 +3937,7 @@ static void mount_setattr_commit(struct mount_kattr *kattr,
 		if (!err) {
 			unsigned int flags;
 
+			do_idmap_mount(kattr, m);
 			flags = recalc_flags(kattr, m);
 			WRITE_ONCE(m->mnt.mnt_flags, flags);
 		}
@@ -3965,7 +4010,62 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 	return err;
 }
 
-static int build_mount_kattr(const struct mount_attr *attr,
+static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
+				struct mount_kattr *kattr, unsigned int flags)
+{
+	int err = 0;
+	struct ns_common *ns;
+	struct user_namespace *mnt_userns;
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
+	mnt_userns = container_of(ns, struct user_namespace, ns);
+	if (mnt_userns == &init_user_ns) {
+		err = -EPERM;
+		goto out_fput;
+	}
+	kattr->mnt_userns = get_user_ns(mnt_userns);
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
@@ -4029,7 +4129,13 @@ static int build_mount_kattr(const struct mount_attr *attr,
 			return -EINVAL;
 	}
 
-	return 0;
+	return build_mount_idmapped(attr, usize, kattr, flags);
+}
+
+static void finish_mount_kattr(struct mount_kattr *kattr)
+{
+	put_user_ns(kattr->mnt_userns);
+	kattr->mnt_userns = NULL;
 }
 
 SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
@@ -4067,7 +4173,7 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
 	    attr.propagation == 0)
 		return 0;
 
-	err = build_mount_kattr(&attr, &kattr, flags);
+	err = build_mount_kattr(&attr, usize, &kattr, flags);
 	if (err)
 		return err;
 
@@ -4076,6 +4182,7 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
 		return err;
 
 	err = do_mount_setattr(&target, &kattr);
+	finish_mount_kattr(&kattr);
 	path_put(&target);
 	return err;
 }
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index eafb75755fa3..392ef5162655 100644
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
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 52de25e08319..161f4419db6c 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -77,7 +77,8 @@ struct vfsmount {
 
 static inline struct user_namespace *mnt_user_ns(const struct vfsmount *mnt)
 {
-	return mnt->mnt_userns;
+	/* Pairs with smp_store_release() in do_idmap_mount(). */
+	return smp_load_acquire(&mnt->mnt_userns);
 }
 
 struct file; /* forward dec */
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 2255624e91c8..e6524ead2b7b 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -119,6 +119,7 @@ enum fsconfig_command {
 #define MOUNT_ATTR_NOATIME	0x00000010 /* - Do not update access times. */
 #define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
 #define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
+#define MOUNT_ATTR_IDMAP	0x00100000 /* Idmap mount to @userns_fd in struct mount_attr. */
 
 /*
  * mount_setattr()
@@ -127,9 +128,10 @@ struct mount_attr {
 	__u64 attr_set;
 	__u64 attr_clr;
 	__u64 propagation;
+	__u64 userns_fd;
 };
 
 /* List of all mount_attr versions. */
-#define MOUNT_ATTR_SIZE_VER0	24 /* sizeof first published struct */
+#define MOUNT_ATTR_SIZE_VER0	32 /* sizeof first published struct */
 
 #endif /* _UAPI_LINUX_MOUNT_H */
-- 
2.30.0

