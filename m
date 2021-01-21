Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEBA2FF2BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 19:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733107AbhAUPnt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 10:43:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53776 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731806AbhAUNVZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:21:25 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2Zsu-0005g7-3f; Thu, 21 Jan 2021 13:20:24 +0000
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
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v6 01/40] mount: attach mappings to mounts
Date:   Thu, 21 Jan 2021 14:19:20 +0100
Message-Id: <20210121131959.646623-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=RNdtgoKaLGCMkof4zQAU3N/xXjoHA/9IvgBRCO94lyQ=; m=v4JeDPlKw7+HRf6GkILParxKrCZxHiToEIxl1JpzBMc=; p=n8aTDgNwQFcuOq2vzScaJKTjpeZYHL89d0mK14Ql03I=; g=10886b981fa37e8daf7d1a3ab0dff6047323eaad
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYAl9owAKCRCRxhvAZXjcoqEbAPwK333 ZnYjG/GuxGlrHWLqoKgSkX3uNx9F5O46VJfzTkAEAnmq+k+saVqcfu1A7GYLfR7gJVnb+J+yKtVd1 w115xwQ=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to support per-mount idmappings vfsmounts are marked with user
namespaces. The idmapping of the user namespace will be used to map the
ids of vfs objects when they are accessed through that mount. By default
all vfsmounts are marked with the initial user namespace. The initial
user namespace is used to indicate that a mount is not idmapped. All
operations behave as before.

Based on prior discussions we want to attach the whole user namespace
and not just a dedicated idmapping struct. This allows us to reuse all
the helpers that already exist for dealing with idmappings instead of
introducing a whole new range of helpers. In addition, if we decide in
the future that we are confident enough to enable unprivileged users to
setup idmapped mounts the permission checking can take into account
whether the caller is privileged in the user namespace the mount is
currently marked with.
Later patches enforce that once a mount has been idmapped it can't be
remapped. This keeps permission checking and life-cycle management
simple. Users wanting to change the idmapped can always create a new
detached mount with a different idmapping.

Add a new mnt_userns member to vfsmount and two simple helpers to
retrieve the mnt_userns from vfsmounts and files.

The idea to attach user namespaces to vfsmounts has been floated around
in various forms at Linux Plumbers in ~2018 with the original idea
tracing back to a discussion in 2017 at a conference in St. Petersburg
between Christoph, Tycho, and myself.

Link: https://lore.kernel.org/r/20210112220124.837960-10-christian.brauner@ubuntu.com
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch introduced
- Christoph Hellwig <hch@lst.de>:
  - Split internal implementation into separate patch and move syscall
    implementation later.

/* v3 */
- David Howells <dhowells@redhat.com>:
  - Remove MNT_IDMAPPED flag. We can simply check the pointer and use
    smp_load_acquire() in later patches.

- Tycho Andersen <tycho@tycho.pizza>:
  - Use READ_ONCE() in mnt_user_ns().

/* v4 */
- Serge Hallyn <serge@hallyn.com>:
  - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
    terminology consistent.

- Christoph Hellwig <hch@lst.de>:
  - Drop the READ_ONCE() from this patch. At this point in the series we
    don't allowing changing the vfsmount's userns. The infra to do that
    is only introduced as almost the last patch in the series and there
    we immediately use smp_load_acquire() and smp_store_release().

/* v5 */
unchanged
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

/* v6 */
base-commit: 19c329f6808995b142b3966301f217c831e7cf31

- Christoph Hellwig <hch@lst.de>:
  - Move file_mnt_user_ns() helper into this patch.
---
 fs/namespace.c        | 9 +++++++++
 include/linux/fs.h    | 6 ++++++
 include/linux/mount.h | 6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9d33909d0f9e..ecdc63ef881c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -210,6 +210,7 @@ static struct mount *alloc_vfsmnt(const char *name)
 		INIT_HLIST_NODE(&mnt->mnt_mp_list);
 		INIT_LIST_HEAD(&mnt->mnt_umounting);
 		INIT_HLIST_HEAD(&mnt->mnt_stuck_children);
+		mnt->mnt.mnt_userns = &init_user_ns;
 	}
 	return mnt;
 
@@ -547,6 +548,11 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 
 static void free_vfsmnt(struct mount *mnt)
 {
+	struct user_namespace *mnt_userns;
+
+	mnt_userns = mnt_user_ns(&mnt->mnt);
+	if (mnt_userns != &init_user_ns)
+		put_user_ns(mnt_userns);
 	kfree_const(mnt->mnt_devname);
 #ifdef CONFIG_SMP
 	free_percpu(mnt->mnt_pcp);
@@ -1055,6 +1061,9 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
 
 	atomic_inc(&sb->s_active);
+	mnt->mnt.mnt_userns = mnt_user_ns(&old->mnt);
+	if (mnt->mnt.mnt_userns != &init_user_ns)
+		mnt->mnt.mnt_userns = get_user_ns(mnt->mnt.mnt_userns);
 	mnt->mnt.mnt_sb = sb;
 	mnt->mnt.mnt_root = dget(root);
 	mnt->mnt_mountpoint = mnt->mnt.mnt_root;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd47deea7c17..fd0b80e6361d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -39,6 +39,7 @@
 #include <linux/fs_types.h>
 #include <linux/build_bug.h>
 #include <linux/stddef.h>
+#include <linux/mount.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -2231,6 +2232,7 @@ struct file_system_type {
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
+#define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
 #define FS_THP_SUPPORT		8192	/* Remove once all fs converted */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
@@ -2517,6 +2519,10 @@ struct filename {
 };
 static_assert(offsetof(struct filename, iname) % sizeof(long) == 0);
 
+static inline struct user_namespace *file_mnt_user_ns(struct file *file)
+{
+	return mnt_user_ns(file->f_path.mnt);
+}
 extern long vfs_truncate(const struct path *, loff_t);
 extern int do_truncate(struct dentry *, loff_t start, unsigned int time_attrs,
 		       struct file *filp);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index aaf343b38671..52de25e08319 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -72,8 +72,14 @@ struct vfsmount {
 	struct dentry *mnt_root;	/* root of the mounted tree */
 	struct super_block *mnt_sb;	/* pointer to superblock */
 	int mnt_flags;
+	struct user_namespace *mnt_userns;
 } __randomize_layout;
 
+static inline struct user_namespace *mnt_user_ns(const struct vfsmount *mnt)
+{
+	return mnt->mnt_userns;
+}
+
 struct file; /* forward dec */
 struct path;
 
-- 
2.30.0

