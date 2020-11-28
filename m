Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA502C7603
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 23:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgK1WZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 17:25:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53682 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbgK1Vqa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 16:46:30 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kj82K-0002aM-Pg; Sat, 28 Nov 2020 21:45:45 +0000
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
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 07/38] mount: attach mappings to mounts
Date:   Sat, 28 Nov 2020 22:34:56 +0100
Message-Id: <20201128213527.2669807-8-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201128213527.2669807-1-christian.brauner@ubuntu.com>
References: <20201128213527.2669807-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to support per-mount idmappings vfsmounts will be marked with user
namespaces. The idmapping associated with that user namespace will be used to
map the ids of vfs objects when they are accessed through that mount. By
default all vfsmounts are marked with the initial user namespace. The initial
user namespace is used to indicate that a mount is not idmapped. All operations
behave as before.

Based on prior discussions we want to attach the whole user namespace and not
just a dedicated idmapping struct. This allows us to reuse all the helpers that
already exist for dealing with idmappings instead of introducing a whole new
range of helpers. In addition, if we decide in the future that we are confident
enough to enable unprivileged users to setup idmapped mounts we can allow
already idmapped mounts to be marked with another user namespace. The permission
checking would then take into account whether the caller is privileged in the
user namespace the mount is currently marked with. For now, we will enforce in
later patches that once a mount has been idmapped it can't be remapped. This
keeps permission checking and life-cycle management simple, especially since
users can always create a new mount with a different idmapping anyway.

The idea to attach user namespaces to vfsmounts has been floated around in
various forms at Linux Plumbers in ~2018 with the original idea tracing back to
a discussion during a conference in St. Petersburg between Christoph, Tycho, and
myself.

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
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
---
 fs/namespace.c        | 9 +++++++++
 include/linux/fs.h    | 1 +
 include/linux/mount.h | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index f9ea31b7eb7f..a1fda548c3af 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -220,6 +220,7 @@ static struct mount *alloc_vfsmnt(const char *name)
 		INIT_HLIST_NODE(&mnt->mnt_mp_list);
 		INIT_LIST_HEAD(&mnt->mnt_umounting);
 		INIT_HLIST_HEAD(&mnt->mnt_stuck_children);
+		mnt->mnt.mnt_user_ns = &init_user_ns;
 	}
 	return mnt;
 
@@ -559,6 +560,11 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 
 static void free_vfsmnt(struct mount *mnt)
 {
+	struct user_namespace *ns;
+
+	ns = mnt_user_ns(&mnt->mnt);
+	if (ns != &init_user_ns)
+		put_user_ns(ns);
 	kfree_const(mnt->mnt_devname);
 #ifdef CONFIG_SMP
 	free_percpu(mnt->mnt_pcp);
@@ -1067,6 +1073,9 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
 
 	atomic_inc(&sb->s_active);
+	mnt->mnt.mnt_user_ns = mnt_user_ns(&old->mnt);
+	if (mnt->mnt.mnt_user_ns != &init_user_ns)
+		mnt->mnt.mnt_user_ns = get_user_ns(mnt->mnt.mnt_user_ns);
 	mnt->mnt.mnt_sb = sb;
 	mnt->mnt.mnt_root = dget(root);
 	mnt->mnt_mountpoint = mnt->mnt.mnt_root;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f59b7f16f216..004686f49e32 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2276,6 +2276,7 @@ struct file_system_type {
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
+#define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
 #define FS_THP_SUPPORT		8192	/* Remove once all fs converted */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index aaf343b38671..d0d4a270acea 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -72,8 +72,14 @@ struct vfsmount {
 	struct dentry *mnt_root;	/* root of the mounted tree */
 	struct super_block *mnt_sb;	/* pointer to superblock */
 	int mnt_flags;
+	struct user_namespace *mnt_user_ns;
 } __randomize_layout;
 
+static inline struct user_namespace *mnt_user_ns(const struct vfsmount *mnt)
+{
+	return READ_ONCE(mnt->mnt_user_ns);
+}
+
 struct file; /* forward dec */
 struct path;
 
-- 
2.29.2

