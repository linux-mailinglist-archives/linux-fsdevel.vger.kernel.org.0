Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A211E29DDCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388856AbgJ2AmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:42:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33619 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731263AbgJ2AmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:42:08 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvvH-0008Ep-6C; Thu, 29 Oct 2020 00:36:11 +0000
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
Subject: [PATCH 34/34] fat: handle idmapped mounts
Date:   Thu, 29 Oct 2020 01:32:52 +0100
Message-Id: <20201029003252.2128653-35-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let fat handle idmapped mounts. This allows to have the same fat mount appear
in multiple locations with different id mappings. This allows to expose a vfat
formatted USB stick to multiple user with different ids on the host or in user
namespaces:

mount -o uid=1000,gid=1000 /dev/sdb /mnt

u1001@f2-vm:/lower1$ ls -ln /mnt/
total 4
-rwxr-xr-x 1 1000 1000 4 Oct 28 03:44 aaa
-rwxr-xr-x 1 1000 1000 0 Oct 28 01:09 bbb
-rwxr-xr-x 1 1000 1000 0 Oct 28 01:10 ccc
-rwxr-xr-x 1 1000 1000 0 Oct 28 03:46 ddd
-rwxr-xr-x 1 1000 1000 0 Oct 28 04:01 eee

mount2 --idmap both:1000:1001:1

u1001@f2-vm:/lower1$ ls -ln /lower1/
total 4
-rwxr-xr-x 1 1001 1001 4 Oct 28 03:44 aaa
-rwxr-xr-x 1 1001 1001 0 Oct 28 01:09 bbb
-rwxr-xr-x 1 1001 1001 0 Oct 28 01:10 ccc
-rwxr-xr-x 1 1001 1001 0 Oct 28 03:46 ddd
-rwxr-xr-x 1 1001 1001 0 Oct 28 04:01 eee

u1001@f2-vm:/lower1$ touch /lower1/fff

u1001@f2-vm:/lower1$ ls -ln /lower1/fff
-rwxr-xr-x 1 1001 1001 0 Oct 28 04:03 /lower1/fff

u1001@f2-vm:/lower1$ ls -ln /mnt/fff
-rwxr-xr-x 1 1000 1000 0 Oct 28 04:03 /mnt/fff

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/fat/fat.h         |  2 ++
 fs/fat/file.c        | 27 +++++++++++++++++++--------
 fs/fat/namei_msdos.c |  7 +++++++
 fs/fat/namei_vfat.c  |  7 +++++++
 4 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 922a0c6ba46c..56d661e93d2a 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -398,6 +398,8 @@ extern long fat_generic_ioctl(struct file *filp, unsigned int cmd,
 extern const struct file_operations fat_file_operations;
 extern const struct inode_operations fat_file_inode_operations;
 extern int fat_setattr(struct dentry *dentry, struct iattr *attr);
+extern int fat_setattr_mapped(struct user_namespace *user_ns,
+			      struct dentry *dentry, struct iattr *attr);
 extern void fat_truncate_blocks(struct inode *inode, loff_t offset);
 extern int fat_getattr(const struct path *path, struct kstat *stat,
 		       u32 request_mask, unsigned int flags);
diff --git a/fs/fat/file.c b/fs/fat/file.c
index f9ee27cf4d7c..f97d46711b37 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -398,7 +398,7 @@ int fat_getattr(const struct path *path, struct kstat *stat,
 		u32 request_mask, unsigned int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
-	generic_fillattr(inode, stat);
+	mapped_generic_fillattr(mnt_user_ns(path->mnt), inode, stat);
 	stat->blksize = MSDOS_SB(inode->i_sb)->cluster_size;
 
 	if (MSDOS_SB(inode->i_sb)->options.nfs == FAT_NFS_NOSTALE_RO) {
@@ -447,12 +447,13 @@ static int fat_sanitize_mode(const struct msdos_sb_info *sbi,
 	return 0;
 }
 
-static int fat_allow_set_time(struct msdos_sb_info *sbi, struct inode *inode)
+static int fat_allow_set_time(struct user_namespace *user_ns,
+			      struct msdos_sb_info *sbi, struct inode *inode)
 {
 	umode_t allow_utime = sbi->options.allow_utime;
 
-	if (!uid_eq(current_fsuid(), inode->i_uid)) {
-		if (in_group_p(inode->i_gid))
+	if (!uid_eq(current_fsuid(), i_uid_into_mnt(user_ns, inode))) {
+		if (in_group_p(i_gid_into_mnt(user_ns, inode)))
 			allow_utime >>= 3;
 		if (allow_utime & MAY_WRITE)
 			return 1;
@@ -466,7 +467,8 @@ static int fat_allow_set_time(struct msdos_sb_info *sbi, struct inode *inode)
 /* valid file mode bits */
 #define FAT_VALID_MODE	(S_IFREG | S_IFDIR | S_IRWXUGO)
 
-int fat_setattr(struct dentry *dentry, struct iattr *attr)
+int fat_setattr_mapped(struct user_namespace *user_ns, struct dentry *dentry,
+		       struct iattr *attr)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
 	struct inode *inode = d_inode(dentry);
@@ -476,11 +478,11 @@ int fat_setattr(struct dentry *dentry, struct iattr *attr)
 	/* Check for setting the inode time. */
 	ia_valid = attr->ia_valid;
 	if (ia_valid & TIMES_SET_FLAGS) {
-		if (fat_allow_set_time(sbi, inode))
+		if (fat_allow_set_time(user_ns, sbi, inode))
 			attr->ia_valid &= ~TIMES_SET_FLAGS;
 	}
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_mapped_prepare(user_ns, dentry, attr);
 	attr->ia_valid = ia_valid;
 	if (error) {
 		if (sbi->options.quiet)
@@ -550,15 +552,24 @@ int fat_setattr(struct dentry *dentry, struct iattr *attr)
 		fat_truncate_time(inode, &attr->ia_mtime, S_MTIME);
 	attr->ia_valid &= ~(ATTR_ATIME|ATTR_CTIME|ATTR_MTIME);
 
-	setattr_copy(inode, attr);
+	setattr_mapped_copy(user_ns, inode, attr);
 	mark_inode_dirty(inode);
 out:
 	return error;
 }
+EXPORT_SYMBOL_GPL(fat_setattr_mapped);
+
+int fat_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	return fat_setattr_mapped(&init_user_ns, dentry, attr);
+}
 EXPORT_SYMBOL_GPL(fat_setattr);
 
 const struct inode_operations fat_file_inode_operations = {
 	.setattr	= fat_setattr,
 	.getattr	= fat_getattr,
 	.update_time	= fat_update_time,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.setattr_mapped	= fat_setattr_mapped,
+#endif
 };
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 9d062886fbc1..4b89d27d128d 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -639,6 +639,9 @@ static const struct inode_operations msdos_dir_inode_operations = {
 	.setattr	= fat_setattr,
 	.getattr	= fat_getattr,
 	.update_time	= fat_update_time,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.setattr_mapped	= fat_setattr_mapped,
+#endif
 };
 
 static void setup(struct super_block *sb)
@@ -665,7 +668,11 @@ static struct file_system_type msdos_fs_type = {
 	.name		= "msdos",
 	.mount		= msdos_mount,
 	.kill_sb	= kill_block_super,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+#else
 	.fs_flags	= FS_REQUIRES_DEV,
+#endif
 };
 MODULE_ALIAS_FS("msdos");
 
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 0cdd0fb9f742..11fea59e1b77 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1034,6 +1034,9 @@ static const struct inode_operations vfat_dir_inode_operations = {
 	.setattr	= fat_setattr,
 	.getattr	= fat_getattr,
 	.update_time	= fat_update_time,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.setattr_mapped	= fat_setattr_mapped,
+#endif
 };
 
 static void setup(struct super_block *sb)
@@ -1062,7 +1065,11 @@ static struct file_system_type vfat_fs_type = {
 	.name		= "vfat",
 	.mount		= vfat_mount,
 	.kill_sb	= kill_block_super,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+#else
 	.fs_flags	= FS_REQUIRES_DEV,
+#endif
 };
 MODULE_ALIAS_FS("vfat");
 
-- 
2.29.0

