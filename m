Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B742429DDE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388899AbgJ2Amc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:42:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33452 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388845AbgJ2Akh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:40:37 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvvA-0008Ep-2o; Thu, 29 Oct 2020 00:36:04 +0000
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
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 30/34] ext4: support idmapped mounts
Date:   Thu, 29 Oct 2020 01:32:48 +0100
Message-Id: <20201029003252.2128653-31-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This enables ext4 to support idmapped mounts. All dedicated helpers we need for
this exist. The vfs will have already made sure that the fsids can be
translated after having been shifted if they are on an idmapped mount.

This implements helpers for the new inode operations that we've added. The core
change is the allocation of a new inode based on the mount's user namespace.
Code duplication is virtually non-existent because we can implement the
non-idmapped mount aware inode methods on top of the idmapped mount aware inode
methods. When the initial user namespace is passed the idmapped mount helpers
are nops and all mounts are marked with the initial user namespace by default.

It is also noteworthy that the idmapped mount implementation allows us to
cleanly handle ioctls() too. I've kept this as a single patch for now since the
change is overall fairly mechanical but I'm happy to split this.

Let's create simple example where we idmap an ext4 filesystem:

 root@f2-vm:~# truncate -s 5G ext4.img

 root@f2-vm:~# mkfs.ext4 ./ext4.img
 mke2fs 1.45.5 (07-Jan-2020)
 Discarding device blocks: done
 Creating filesystem with 1310720 4k blocks and 327680 inodes
 Filesystem UUID: 3fd91794-c6ca-4b0f-9964-289a000919cf
 Superblock backups stored on blocks:
         32768, 98304, 163840, 229376, 294912, 819200, 884736

 Allocating group tables: done
 Writing inode tables: done
 Creating journal (16384 blocks): done
 Writing superblocks and filesystem accounting information: done

 root@f2-vm:~# losetup -f --show ./ext4.img
 /dev/loop0

 root@f2-vm:~# mount /dev/loop0 /mnt

 root@f2-vm:~# ls -al /mnt/
 total 24
 drwxr-xr-x  3 root root  4096 Oct 28 13:34 .
 drwxr-xr-x 30 root root  4096 Oct 28 13:22 ..
 drwx------  2 root root 16384 Oct 28 13:34 lost+found

 # Let's create an idmapped mount at /idmapped1 where we map uid and gid 0 to
 # uid and gid 1000
 root@f2-vm:/# ./mount2 -mb:0:1000:1 /mnt/ /idmapped1/

 root@f2-vm:/# ls -al /idmapped1/
 total 24
 drwxr-xr-x  3 ubuntu ubuntu  4096 Oct 28 13:34 .
 drwxr-xr-x 30 root   root    4096 Oct 28 13:22 ..
 drwx------  2 ubuntu ubuntu 16384 Oct 28 13:34 lost+found

 # Let's create an idmapped mount at /idmapped2 where we map uid and gid 0 to
 # uid and gid 2000
 root@f2-vm:/# ./mount2 -mb:0:2000:1 /mnt/ /idmapped2/

 root@f2-vm:/# ls -al /idmapped2/
 total 24
 drwxr-xr-x  3 2000 2000  4096 Oct 28 13:34 .
 drwxr-xr-x 31 root root  4096 Oct 28 13:39 ..
 drwx------  2 2000 2000 16384 Oct 28 13:34 lost+found

Let's create another example where we idmap the rootfs filesystem without a
mapping for uid 0 and gid 0:

 # Create an idmapped mount of for a full POSIX range of rootfs under /mnt
 # but without a mapping for uid 0 to reduce attack surface

 root@f2-vm:/# ./mount2 -mb:1:1:65536 / /mnt/

 # Since we don't have a mapping for uid and gid 0 all files owned by uid and
 # gid 0 should show up as uid and gid 65534:
 root@f2-vm:/# ls -al /mnt/
 total 664
 drwxr-xr-x 31 nobody nogroup   4096 Oct 28 13:39 .
 drwxr-xr-x 31 root   root      4096 Oct 28 13:39 ..
 lrwxrwxrwx  1 nobody nogroup      7 Aug 25 07:44 bin -> usr/bin
 drwxr-xr-x  4 nobody nogroup   4096 Oct 28 13:17 boot
 drwxr-xr-x  2 nobody nogroup   4096 Aug 25 07:48 dev
 drwxr-xr-x 81 nobody nogroup   4096 Oct 28 04:00 etc
 drwxr-xr-x  4 nobody nogroup   4096 Oct 28 04:00 home
 lrwxrwxrwx  1 nobody nogroup      7 Aug 25 07:44 lib -> usr/lib
 lrwxrwxrwx  1 nobody nogroup      9 Aug 25 07:44 lib32 -> usr/lib32
 lrwxrwxrwx  1 nobody nogroup      9 Aug 25 07:44 lib64 -> usr/lib64
 lrwxrwxrwx  1 nobody nogroup     10 Aug 25 07:44 libx32 -> usr/libx32
 drwx------  2 nobody nogroup  16384 Aug 25 07:47 lost+found
 drwxr-xr-x  2 nobody nogroup   4096 Aug 25 07:44 media
 drwxr-xr-x 31 nobody nogroup   4096 Oct 28 13:39 mnt
 drwxr-xr-x  2 nobody nogroup   4096 Aug 25 07:44 opt
 drwxr-xr-x  2 nobody nogroup   4096 Apr 15  2020 proc
 drwx--x--x  6 nobody nogroup   4096 Oct 28 13:34 root
 drwxr-xr-x  2 nobody nogroup   4096 Aug 25 07:46 run
 lrwxrwxrwx  1 nobody nogroup      8 Aug 25 07:44 sbin -> usr/sbin
 drwxr-xr-x  2 nobody nogroup   4096 Aug 25 07:44 srv
 drwxr-xr-x  2 nobody nogroup   4096 Apr 15  2020 sys
 drwxrwxrwt 10 nobody nogroup   4096 Oct 28 13:19 tmp
 drwxr-xr-x 14 nobody nogroup   4096 Oct 20 13:00 usr
 drwxr-xr-x 12 nobody nogroup   4096 Aug 25 07:45 var

 # Since we do have a mapping for uid and gid 1000 all files owned by uid and
 # gid 1000 should simply show up as uid and gid 1000:
 root@f2-vm:/# ls -al /mnt/home/ubuntu/
 total 40
 drwxr-xr-x 3 ubuntu ubuntu  4096 Oct 28 00:43 .
 drwxr-xr-x 4 nobody nogroup 4096 Oct 28 04:00 ..
 -rw------- 1 ubuntu ubuntu  2936 Oct 28 12:26 .bash_history
 -rw-r--r-- 1 ubuntu ubuntu   220 Feb 25  2020 .bash_logout
 -rw-r--r-- 1 ubuntu ubuntu  3771 Feb 25  2020 .bashrc
 -rw-r--r-- 1 ubuntu ubuntu   807 Feb 25  2020 .profile
 -rw-r--r-- 1 ubuntu ubuntu     0 Oct 16 16:11 .sudo_as_admin_successful
 -rw------- 1 ubuntu ubuntu  1144 Oct 28 00:43 .viminfo

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/ext4/acl.c            |  11 ++-
 fs/ext4/acl.h            |   3 +
 fs/ext4/ext4.h           |  14 ++--
 fs/ext4/file.c           |   4 ++
 fs/ext4/ialloc.c         |   7 +-
 fs/ext4/inode.c          |  27 ++++++--
 fs/ext4/ioctl.c          |  18 ++---
 fs/ext4/namei.c          | 145 ++++++++++++++++++++++++++++++++-------
 fs/ext4/super.c          |   4 ++
 fs/ext4/symlink.c        |   9 +++
 fs/ext4/xattr_hurd.c     |  22 ++++--
 fs/ext4/xattr_security.c |  18 ++++-
 fs/ext4/xattr_trusted.c  |  18 ++++-
 13 files changed, 242 insertions(+), 58 deletions(-)

diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 68aaed48315f..9c7b898a7496 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -222,7 +222,8 @@ __ext4_set_acl(handle_t *handle, struct inode *inode, int type,
 }
 
 int
-ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+ext4_set_acl_mapped(struct user_namespace *user_ns,
+		    struct inode *inode, struct posix_acl *acl, int type)
 {
 	handle_t *handle;
 	int error, credits, retries = 0;
@@ -245,7 +246,7 @@ ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	ext4_fc_start_update(inode);
 
 	if ((type == ACL_TYPE_ACCESS) && acl) {
-		error = posix_acl_update_mode(inode, &mode, &acl);
+		error = posix_mapped_acl_update_mode(user_ns, inode, &mode, &acl);
 		if (error)
 			goto out_stop;
 		if (mode != inode->i_mode)
@@ -266,6 +267,12 @@ ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	return error;
 }
 
+int
+ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+{
+	return ext4_set_acl_mapped(&init_user_ns, inode, acl, type);
+}
+
 /*
  * Initialize the ACLs of a new inode. Called from ext4_new_inode.
  *
diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index 9b63f5416a2f..aff92cd331cf 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -58,11 +58,14 @@ static inline int ext4_acl_count(size_t size)
 struct posix_acl *ext4_get_acl(struct inode *inode, int type);
 int ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type);
 extern int ext4_init_acl(handle_t *, struct inode *, struct inode *);
+int ext4_set_acl_mapped(struct user_namespace *user_ns, struct inode *inode,
+			struct posix_acl *acl, int type);
 
 #else  /* CONFIG_EXT4_FS_POSIX_ACL */
 #include <linux/sched.h>
 #define ext4_get_acl NULL
 #define ext4_set_acl NULL
+#define ext4_set_acl_mapped NULL
 
 static inline int
 ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 254d1c26bea8..fb8bad3dd94f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2714,18 +2714,19 @@ extern int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 
 /* ialloc.c */
 extern int ext4_mark_inode_used(struct super_block *sb, int ino);
-extern struct inode *__ext4_new_inode(handle_t *, struct inode *, umode_t,
+extern struct inode *__ext4_new_inode(struct user_namespace *, handle_t *,
+				      struct inode *, umode_t,
 				      const struct qstr *qstr, __u32 goal,
 				      uid_t *owner, __u32 i_flags,
 				      int handle_type, unsigned int line_no,
 				      int nblocks);
 
-#define ext4_new_inode(handle, dir, mode, qstr, goal, owner, i_flags) \
-	__ext4_new_inode((handle), (dir), (mode), (qstr), (goal), (owner), \
-			 i_flags, 0, 0, 0)
-#define ext4_new_inode_start_handle(dir, mode, qstr, goal, owner, \
+#define ext4_new_inode(handle, dir, mode, qstr, goal, owner, i_flags)          \
+	__ext4_new_inode(&init_user_ns, (handle), (dir), (mode), (qstr),       \
+			 (goal), (owner), i_flags, 0, 0, 0)
+#define ext4_new_inode_start_handle(user_ns, dir, mode, qstr, goal, owner, \
 				    type, nblocks)		    \
-	__ext4_new_inode(NULL, (dir), (mode), (qstr), (goal), (owner), \
+	__ext4_new_inode((user_ns), NULL, (dir), (mode), (qstr), (goal), (owner), \
 			 0, (type), __LINE__, (nblocks))
 
 
@@ -2833,6 +2834,7 @@ extern struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 
 extern int  ext4_write_inode(struct inode *, struct writeback_control *);
 extern int  ext4_setattr(struct dentry *, struct iattr *);
+extern int  ext4_setattr_mapped(struct user_namespace *, struct dentry *, struct iattr *);
 extern int  ext4_getattr(const struct path *, struct kstat *, u32, unsigned int);
 extern void ext4_evict_inode(struct inode *);
 extern void ext4_clear_inode(struct inode *);
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index d85412d12e3a..44880c0cdadf 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -919,5 +919,9 @@ const struct inode_operations ext4_file_inode_operations = {
 	.get_acl	= ext4_get_acl,
 	.set_acl	= ext4_set_acl,
 	.fiemap		= ext4_fiemap,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.setattr_mapped	= ext4_setattr_mapped,
+	.set_acl_mapped	= ext4_set_acl_mapped,
+#endif
 };
 
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index b215c564bc31..7676a2bcbb51 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -919,7 +919,8 @@ static int ext4_xattr_credits_for_new_inode(struct inode *dir, mode_t mode,
  * For other inodes, search forward from the parent directory's block
  * group to find a free inode.
  */
-struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
+struct inode *__ext4_new_inode(struct user_namespace *user_ns,
+			       handle_t *handle, struct inode *dir,
 			       umode_t mode, const struct qstr *qstr,
 			       __u32 goal, uid_t *owner, __u32 i_flags,
 			       int handle_type, unsigned int line_no,
@@ -969,10 +970,10 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 		i_gid_write(inode, owner[1]);
 	} else if (test_opt(sb, GRPID)) {
 		inode->i_mode = mode;
-		inode->i_uid = current_fsuid();
+		inode->i_uid = fsuid_into_mnt(user_ns);
 		inode->i_gid = dir->i_gid;
 	} else
-		inode_init_owner(inode, dir, mode);
+		mapped_inode_init_owner(inode, user_ns, dir, mode);
 
 	if (ext4_has_feature_project(sb) &&
 	    ext4_test_inode_flag(dir, EXT4_INODE_PROJINHERIT))
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 03c2253005f0..c3c75fcae6bf 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/mount.h>
 #include <linux/time.h>
 #include <linux/highuid.h>
 #include <linux/pagemap.h>
@@ -5280,7 +5281,7 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
 }
 
 /*
- * ext4_setattr()
+ * __ext4_setattr()
  *
  * Called from notify_change.
  *
@@ -5303,7 +5304,8 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
  *
  * Called with inode->i_mutex down.
  */
-int ext4_setattr(struct dentry *dentry, struct iattr *attr)
+static int __ext4_setattr(struct user_namespace *user_ns, struct dentry *dentry,
+			  struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error, rc = 0;
@@ -5321,7 +5323,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 				  ATTR_GID | ATTR_TIMES_SET))))
 		return -EPERM;
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_mapped_prepare(user_ns, dentry, attr);
 	if (error)
 		return error;
 
@@ -5496,7 +5498,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 
 	if (!error) {
-		setattr_copy(inode, attr);
+		setattr_mapped_copy(user_ns, inode, attr);
 		mark_inode_dirty(inode);
 	}
 
@@ -5508,7 +5510,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 		ext4_orphan_del(NULL, inode);
 
 	if (!error && (ia_valid & ATTR_MODE))
-		rc = posix_acl_chmod(inode, inode->i_mode);
+		rc = posix_mapped_acl_chmod(user_ns, inode, inode->i_mode);
 
 err_out:
 	if  (error)
@@ -5519,9 +5521,21 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 	return error;
 }
 
+int ext4_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	return __ext4_setattr(&init_user_ns, dentry, attr);
+}
+
+int ext4_setattr_mapped(struct user_namespace *user_ns, struct dentry *dentry,
+			struct iattr *attr)
+{
+	return __ext4_setattr(user_ns, dentry, attr);
+}
+
 int ext4_getattr(const struct path *path, struct kstat *stat,
 		 u32 request_mask, unsigned int query_flags)
 {
+	struct user_namespace *user_ns;
 	struct inode *inode = d_inode(path->dentry);
 	struct ext4_inode *raw_inode;
 	struct ext4_inode_info *ei = EXT4_I(inode);
@@ -5555,7 +5569,8 @@ int ext4_getattr(const struct path *path, struct kstat *stat,
 				  STATX_ATTR_NODUMP |
 				  STATX_ATTR_VERITY);
 
-	generic_fillattr(inode, stat);
+	user_ns = mnt_user_ns(path->mnt);
+	mapped_generic_fillattr(user_ns, inode, stat);
 	return 0;
 }
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index f0381876a7e5..90d7860de36e 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -111,6 +111,7 @@ void ext4_reset_inode_seed(struct inode *inode)
  *
  */
 static long swap_inode_boot_loader(struct super_block *sb,
+				struct user_namespace *user_ns,
 				struct inode *inode)
 {
 	handle_t *handle;
@@ -139,7 +140,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	}
 
 	if (IS_RDONLY(inode) || IS_APPEND(inode) || IS_IMMUTABLE(inode) ||
-	    !inode_owner_or_capable(inode) || !capable(CAP_SYS_ADMIN)) {
+	    !mapped_inode_owner_or_capable(user_ns, inode) || !capable(CAP_SYS_ADMIN)) {
 		err = -EPERM;
 		goto journal_err_out;
 	}
@@ -814,6 +815,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	struct inode *inode = file_inode(filp);
 	struct super_block *sb = inode->i_sb;
 	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct user_namespace *user_ns = mnt_user_ns(filp->f_path.mnt);
 	unsigned int flags;
 
 	ext4_debug("cmd = %u, arg = %lu\n", cmd, arg);
@@ -829,7 +831,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case FS_IOC_SETFLAGS: {
 		int err;
 
-		if (!inode_owner_or_capable(inode))
+		if (!mapped_inode_owner_or_capable(user_ns, inode))
 			return -EACCES;
 
 		if (get_user(flags, (int __user *) arg))
@@ -871,7 +873,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		__u32 generation;
 		int err;
 
-		if (!inode_owner_or_capable(inode))
+		if (!mapped_inode_owner_or_capable(user_ns, inode))
 			return -EPERM;
 
 		if (ext4_has_metadata_csum(inode->i_sb)) {
@@ -1010,7 +1012,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_MIGRATE:
 	{
 		int err;
-		if (!inode_owner_or_capable(inode))
+		if (!mapped_inode_owner_or_capable(user_ns, inode))
 			return -EACCES;
 
 		err = mnt_want_write_file(filp);
@@ -1032,7 +1034,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_ALLOC_DA_BLKS:
 	{
 		int err;
-		if (!inode_owner_or_capable(inode))
+		if (!mapped_inode_owner_or_capable(user_ns, inode))
 			return -EACCES;
 
 		err = mnt_want_write_file(filp);
@@ -1051,7 +1053,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		err = mnt_want_write_file(filp);
 		if (err)
 			return err;
-		err = swap_inode_boot_loader(sb, inode);
+		err = swap_inode_boot_loader(sb, user_ns, inode);
 		mnt_drop_write_file(filp);
 		return err;
 	}
@@ -1214,7 +1216,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	case EXT4_IOC_CLEAR_ES_CACHE:
 	{
-		if (!inode_owner_or_capable(inode))
+		if (!mapped_inode_owner_or_capable(user_ns, inode))
 			return -EACCES;
 		ext4_clear_inode_es(inode);
 		return 0;
@@ -1260,7 +1262,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			return -EFAULT;
 
 		/* Make sure caller has proper permission */
-		if (!inode_owner_or_capable(inode))
+		if (!mapped_inode_owner_or_capable(user_ns, inode))
 			return -EACCES;
 
 		if (fa.fsx_xflags & ~EXT4_SUPPORTED_FS_XFLAGS)
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 5159830dacb8..8c501899a1a8 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2606,8 +2606,8 @@ static int ext4_add_nondir(handle_t *handle,
  * If the create succeeds, we fill in the inode information
  * with d_instantiate().
  */
-static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-		       bool excl)
+static int __ext4_create(struct user_namespace *user_ns, struct inode *dir,
+			 struct dentry *dentry, umode_t mode, bool excl)
 {
 	handle_t *handle;
 	struct inode *inode, *inode_save;
@@ -2620,8 +2620,8 @@ static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	credits = (EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
 		   EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3);
 retry:
-	inode = ext4_new_inode_start_handle(dir, mode, &dentry->d_name, 0,
-					    NULL, EXT4_HT_DIR, credits);
+	inode = ext4_new_inode_start_handle(user_ns, dir, mode, &dentry->d_name,
+					    0, NULL, EXT4_HT_DIR, credits);
 	handle = ext4_journal_current_handle();
 	err = PTR_ERR(inode);
 	if (!IS_ERR(inode)) {
@@ -2643,8 +2643,14 @@ static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	return err;
 }
 
-static int ext4_mknod(struct inode *dir, struct dentry *dentry,
-		      umode_t mode, dev_t rdev)
+static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
+		       bool excl)
+{
+	return __ext4_create(&init_user_ns, dir, dentry, mode, excl);
+}
+
+static int __ext4_mknod(struct user_namespace *user_ns, struct inode *dir,
+			struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	handle_t *handle;
 	struct inode *inode, *inode_save;
@@ -2657,8 +2663,8 @@ static int ext4_mknod(struct inode *dir, struct dentry *dentry,
 	credits = (EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
 		   EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3);
 retry:
-	inode = ext4_new_inode_start_handle(dir, mode, &dentry->d_name, 0,
-					    NULL, EXT4_HT_DIR, credits);
+	inode = ext4_new_inode_start_handle(user_ns, dir, mode, &dentry->d_name,
+					    0, NULL, EXT4_HT_DIR, credits);
 	handle = ext4_journal_current_handle();
 	err = PTR_ERR(inode);
 	if (!IS_ERR(inode)) {
@@ -2680,7 +2686,14 @@ static int ext4_mknod(struct inode *dir, struct dentry *dentry,
 	return err;
 }
 
-static int ext4_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int ext4_mknod(struct inode *dir, struct dentry *dentry,
+			umode_t mode, dev_t rdev)
+{
+	return __ext4_mknod(&init_user_ns, dir, dentry, mode, rdev);
+}
+
+static int __ext4_tmpfile(struct user_namespace *user_ns, struct inode *dir,
+			  struct dentry *dentry, umode_t mode)
 {
 	handle_t *handle;
 	struct inode *inode;
@@ -2691,7 +2704,7 @@ static int ext4_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 		return err;
 
 retry:
-	inode = ext4_new_inode_start_handle(dir, mode,
+	inode = ext4_new_inode_start_handle(user_ns, dir, mode,
 					    NULL, 0, NULL,
 					    EXT4_HT_DIR,
 			EXT4_MAXQUOTAS_INIT_BLOCKS(dir->i_sb) +
@@ -2720,6 +2733,11 @@ static int ext4_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	return err;
 }
 
+static int ext4_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
+{
+	return __ext4_tmpfile(&init_user_ns, dir, dentry, mode);
+}
+
 struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 			  struct ext4_dir_entry_2 *de,
 			  int blocksize, int csum_size,
@@ -2789,7 +2807,8 @@ int ext4_init_new_dir(handle_t *handle, struct inode *dir,
 	return err;
 }
 
-static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int __ext4_mkdir(struct user_namespace *user_ns, struct inode *dir,
+			struct dentry *dentry, umode_t mode)
 {
 	handle_t *handle;
 	struct inode *inode;
@@ -2805,7 +2824,7 @@ static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	credits = (EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
 		   EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3);
 retry:
-	inode = ext4_new_inode_start_handle(dir, S_IFDIR | mode,
+	inode = ext4_new_inode_start_handle(user_ns, dir, S_IFDIR | mode,
 					    &dentry->d_name,
 					    0, NULL, EXT4_HT_DIR, credits);
 	handle = ext4_journal_current_handle();
@@ -2853,6 +2872,10 @@ static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	return err;
 }
 
+static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+{
+	return __ext4_mkdir(&init_user_ns, dir, dentry, mode);
+}
 /*
  * routine to check that the specified directory is empty (for rmdir)
  */
@@ -3301,8 +3324,8 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	return retval;
 }
 
-static int ext4_symlink(struct inode *dir,
-			struct dentry *dentry, const char *symname)
+static int __ext4_symlink(struct user_namespace *user_ns, struct inode *dir,
+			  struct dentry *dentry, const char *symname)
 {
 	handle_t *handle;
 	struct inode *inode;
@@ -3342,7 +3365,7 @@ static int ext4_symlink(struct inode *dir,
 			  EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3;
 	}
 
-	inode = ext4_new_inode_start_handle(dir, S_IFLNK|S_IRWXUGO,
+	inode = ext4_new_inode_start_handle(user_ns, dir, S_IFLNK|S_IRWXUGO,
 					    &dentry->d_name, 0, NULL,
 					    EXT4_HT_DIR, credits);
 	handle = ext4_journal_current_handle();
@@ -3431,6 +3454,12 @@ static int ext4_symlink(struct inode *dir,
 	return err;
 }
 
+static int ext4_symlink(struct inode *dir, struct dentry *dentry,
+			const char *symname)
+{
+	return __ext4_symlink(&init_user_ns, dir, dentry, symname);
+}
+
 int __ext4_link(struct inode *dir, struct inode *inode, struct dentry *dentry)
 {
 	handle_t *handle;
@@ -3674,7 +3703,8 @@ static void ext4_update_dir_count(handle_t *handle, struct ext4_renament *ent)
 	}
 }
 
-static struct inode *ext4_whiteout_for_rename(struct ext4_renament *ent,
+static struct inode *ext4_whiteout_for_rename(struct user_namespace *user_ns,
+					      struct ext4_renament *ent,
 					      int credits, handle_t **h)
 {
 	struct inode *wh;
@@ -3688,7 +3718,8 @@ static struct inode *ext4_whiteout_for_rename(struct ext4_renament *ent,
 	credits += (EXT4_MAXQUOTAS_TRANS_BLOCKS(ent->dir->i_sb) +
 		    EXT4_XATTR_TRANS_BLOCKS + 4);
 retry:
-	wh = ext4_new_inode_start_handle(ent->dir, S_IFCHR | WHITEOUT_MODE,
+	wh = ext4_new_inode_start_handle(user_ns, ent->dir,
+					 S_IFCHR | WHITEOUT_MODE,
 					 &ent->dentry->d_name, 0, NULL,
 					 EXT4_HT_DIR, credits);
 
@@ -3715,9 +3746,9 @@ static struct inode *ext4_whiteout_for_rename(struct ext4_renament *ent,
  * while new_{dentry,inode) refers to the destination dentry/inode
  * This comes from rename(const char *oldpath, const char *newpath)
  */
-static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
-		       struct inode *new_dir, struct dentry *new_dentry,
-		       unsigned int flags)
+static int ext4_rename(struct user_namespace *user_ns, struct inode *old_dir,
+		       struct dentry *old_dentry, struct inode *new_dir,
+		       struct dentry *new_dentry, unsigned int flags)
 {
 	handle_t *handle = NULL;
 	struct ext4_renament old = {
@@ -3801,7 +3832,7 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 			goto end_rename;
 		}
 	} else {
-		whiteout = ext4_whiteout_for_rename(&old, credits, &handle);
+		whiteout = ext4_whiteout_for_rename(user_ns, &old, credits, &handle);
 		if (IS_ERR(whiteout)) {
 			retval = PTR_ERR(whiteout);
 			whiteout = NULL;
@@ -4093,9 +4124,9 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	return retval;
 }
 
-static int ext4_rename2(struct inode *old_dir, struct dentry *old_dentry,
-			struct inode *new_dir, struct dentry *new_dentry,
-			unsigned int flags)
+static int __ext4_rename2(struct user_namespace *user_ns, struct inode *old_dir,
+			  struct dentry *old_dentry, struct inode *new_dir,
+			  struct dentry *new_dentry, unsigned int flags)
 {
 	int err;
 
@@ -4115,9 +4146,59 @@ static int ext4_rename2(struct inode *old_dir, struct dentry *old_dentry,
 					 new_dir, new_dentry);
 	}
 
-	return ext4_rename(old_dir, old_dentry, new_dir, new_dentry, flags);
+	return ext4_rename(user_ns, old_dir, old_dentry, new_dir, new_dentry, flags);
+}
+
+static int ext4_rename2(struct inode *old_dir, struct dentry *old_dentry,
+			struct inode *new_dir, struct dentry *new_dentry,
+			unsigned int flags)
+{
+	return __ext4_rename2(&init_user_ns, old_dir, old_dentry, new_dir,
+			      new_dentry, flags);
+}
+
+#ifdef CONFIG_IDMAP_MOUNTS
+static int ext4_create_mapped(struct user_namespace *user_ns, struct inode *dir,
+			      struct dentry *dentry, umode_t mode, bool excl)
+{
+	return __ext4_create(user_ns, dir, dentry, mode, excl);
 }
 
+static int ext4_mknod_mapped(struct user_namespace *user_ns, struct inode *dir,
+			     struct dentry *dentry, umode_t mode, dev_t rdev)
+{
+	return __ext4_mknod(user_ns, dir, dentry, mode, rdev);
+}
+static int ext4_tmpfile_mapped(struct user_namespace *user_ns,
+			       struct inode *dir, struct dentry *dentry,
+			       umode_t mode)
+{
+	return __ext4_tmpfile(user_ns, dir, dentry, mode);
+}
+
+static int ext4_mkdir_mapped(struct user_namespace *user_ns, struct inode *dir,
+			     struct dentry *dentry, umode_t mode)
+{
+	return __ext4_mkdir(user_ns, dir, dentry, mode);
+}
+
+static int ext4_symlink_mapped(struct user_namespace *user_ns,
+			       struct inode *dir, struct dentry *dentry,
+			       const char *symname)
+{
+	return __ext4_symlink(user_ns, dir, dentry, symname);
+}
+
+static int ext4_rename2_mapped(struct user_namespace *user_ns,
+			       struct inode *old_dir, struct dentry *old_dentry,
+			       struct inode *new_dir, struct dentry *new_dentry,
+			       unsigned int flags)
+{
+	return __ext4_rename2(user_ns, old_dir, old_dentry, new_dir,
+			      new_dentry, flags);
+}
+#endif
+
 /*
  * directories can handle most operations...
  */
@@ -4138,6 +4219,16 @@ const struct inode_operations ext4_dir_inode_operations = {
 	.get_acl	= ext4_get_acl,
 	.set_acl	= ext4_set_acl,
 	.fiemap         = ext4_fiemap,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.create_mapped	= ext4_create_mapped,
+	.symlink_mapped	= ext4_symlink_mapped,
+	.mkdir_mapped	= ext4_mkdir_mapped,
+	.mknod_mapped	= ext4_mknod_mapped,
+	.tmpfile_mapped	= ext4_tmpfile_mapped,
+	.rename_mapped	= ext4_rename2_mapped,
+	.setattr_mapped	= ext4_setattr_mapped,
+	.set_acl_mapped	= ext4_set_acl_mapped,
+#endif
 };
 
 const struct inode_operations ext4_special_inode_operations = {
@@ -4146,4 +4237,8 @@ const struct inode_operations ext4_special_inode_operations = {
 	.listxattr	= ext4_listxattr,
 	.get_acl	= ext4_get_acl,
 	.set_acl	= ext4_set_acl,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.setattr_mapped	= ext4_setattr_mapped,
+	.set_acl_mapped	= ext4_set_acl_mapped,
+#endif
 };
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2fe141ff3c7e..fcbd9b8f7613 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6641,7 +6641,11 @@ static struct file_system_type ext4_fs_type = {
 	.name		= "ext4",
 	.mount		= ext4_mount,
 	.kill_sb	= kill_block_super,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+#else
 	.fs_flags	= FS_REQUIRES_DEV,
+#endif
 };
 MODULE_ALIAS_FS("ext4");
 
diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
index dd05af983092..fced0a321c95 100644
--- a/fs/ext4/symlink.c
+++ b/fs/ext4/symlink.c
@@ -57,6 +57,9 @@ const struct inode_operations ext4_encrypted_symlink_inode_operations = {
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_getattr,
 	.listxattr	= ext4_listxattr,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.setattr_mapped	= ext4_setattr_mapped,
+#endif
 };
 
 const struct inode_operations ext4_symlink_inode_operations = {
@@ -64,6 +67,9 @@ const struct inode_operations ext4_symlink_inode_operations = {
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_getattr,
 	.listxattr	= ext4_listxattr,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.setattr_mapped	= ext4_setattr_mapped,
+#endif
 };
 
 const struct inode_operations ext4_fast_symlink_inode_operations = {
@@ -71,4 +77,7 @@ const struct inode_operations ext4_fast_symlink_inode_operations = {
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_getattr,
 	.listxattr	= ext4_listxattr,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.setattr_mapped	= ext4_setattr_mapped,
+#endif
 };
diff --git a/fs/ext4/xattr_hurd.c b/fs/ext4/xattr_hurd.c
index 8cfa74a56361..e9dfeba4c340 100644
--- a/fs/ext4/xattr_hurd.c
+++ b/fs/ext4/xattr_hurd.c
@@ -31,10 +31,11 @@ ext4_xattr_hurd_get(const struct xattr_handler *handler,
 }
 
 static int
-ext4_xattr_hurd_set(const struct xattr_handler *handler,
-		    struct dentry *unused, struct inode *inode,
-		    const char *name, const void *value,
-		    size_t size, int flags)
+ext4_xattr_hurd_set_mapped(const struct xattr_handler *handler,
+			   struct user_namespace *user_ns,
+			   struct dentry *unused, struct inode *inode,
+			   const char *name, const void *value,
+			   size_t size, int flags)
 {
 	if (!test_opt(inode->i_sb, XATTR_USER))
 		return -EOPNOTSUPP;
@@ -43,9 +44,22 @@ ext4_xattr_hurd_set(const struct xattr_handler *handler,
 			      name, value, size, flags);
 }
 
+static int
+ext4_xattr_hurd_set(const struct xattr_handler *handler,
+		    struct dentry *unused, struct inode *inode,
+		    const char *name, const void *value,
+		    size_t size, int flags)
+{
+	return ext4_xattr_hurd_set_mapped(handler, &init_user_ns, unused, inode,
+					  name, value, size, flags);
+}
+
 const struct xattr_handler ext4_xattr_hurd_handler = {
 	.prefix	= XATTR_HURD_PREFIX,
 	.list	= ext4_xattr_hurd_list,
 	.get	= ext4_xattr_hurd_get,
 	.set	= ext4_xattr_hurd_set,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.set_mapped = ext4_xattr_hurd_set_mapped,
+#endif
 };
diff --git a/fs/ext4/xattr_security.c b/fs/ext4/xattr_security.c
index 197a9d8a15ef..0772b1c1b140 100644
--- a/fs/ext4/xattr_security.c
+++ b/fs/ext4/xattr_security.c
@@ -21,14 +21,25 @@ ext4_xattr_security_get(const struct xattr_handler *handler,
 			      name, buffer, size);
 }
 
+static int
+ext4_xattr_security_set_mapped(const struct xattr_handler *handler,
+			       struct user_namespace *user_ns,
+			       struct dentry *unused, struct inode *inode,
+			       const char *name, const void *value,
+			       size_t size, int flags)
+{
+	return ext4_xattr_set(inode, EXT4_XATTR_INDEX_SECURITY,
+			      name, value, size, flags);
+}
+
 static int
 ext4_xattr_security_set(const struct xattr_handler *handler,
 			struct dentry *unused, struct inode *inode,
 			const char *name, const void *value,
 			size_t size, int flags)
 {
-	return ext4_xattr_set(inode, EXT4_XATTR_INDEX_SECURITY,
-			      name, value, size, flags);
+	return ext4_xattr_security_set_mapped(handler, &init_user_ns, unused,
+					      inode, name, value, size, flags);
 }
 
 static int
@@ -62,4 +73,7 @@ const struct xattr_handler ext4_xattr_security_handler = {
 	.prefix	= XATTR_SECURITY_PREFIX,
 	.get	= ext4_xattr_security_get,
 	.set	= ext4_xattr_security_set,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.set_mapped = ext4_xattr_security_set_mapped,
+#endif
 };
diff --git a/fs/ext4/xattr_trusted.c b/fs/ext4/xattr_trusted.c
index e9389e5d75c3..aa407b60ce79 100644
--- a/fs/ext4/xattr_trusted.c
+++ b/fs/ext4/xattr_trusted.c
@@ -28,14 +28,25 @@ ext4_xattr_trusted_get(const struct xattr_handler *handler,
 			      name, buffer, size);
 }
 
+static int
+ext4_xattr_trusted_set_mapped(const struct xattr_handler *handler,
+			      struct user_namespace *user_ns,
+			      struct dentry *unused, struct inode *inode,
+			      const char *name, const void *value,
+			      size_t size, int flags)
+{
+	return ext4_xattr_set(inode, EXT4_XATTR_INDEX_TRUSTED,
+			      name, value, size, flags);
+}
+
 static int
 ext4_xattr_trusted_set(const struct xattr_handler *handler,
 		       struct dentry *unused, struct inode *inode,
 		       const char *name, const void *value,
 		       size_t size, int flags)
 {
-	return ext4_xattr_set(inode, EXT4_XATTR_INDEX_TRUSTED,
-			      name, value, size, flags);
+	return ext4_xattr_trusted_set_mapped(handler, &init_user_ns, unused,
+					     inode, name, value, size, flags);
 }
 
 const struct xattr_handler ext4_xattr_trusted_handler = {
@@ -43,4 +54,7 @@ const struct xattr_handler ext4_xattr_trusted_handler = {
 	.list	= ext4_xattr_trusted_list,
 	.get	= ext4_xattr_trusted_get,
 	.set	= ext4_xattr_trusted_set,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.set_mapped = ext4_xattr_trusted_set_mapped,
+#endif
 };
-- 
2.29.0

