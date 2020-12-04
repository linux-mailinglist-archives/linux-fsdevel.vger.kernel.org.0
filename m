Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD962CE454
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 01:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502161AbgLDANT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 19:13:19 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43400 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502147AbgLDANS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:13:18 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kkyYC-0007ka-U4; Fri, 04 Dec 2020 00:02:17 +0000
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
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 34/40] fat: handle idmapped mounts
Date:   Fri,  4 Dec 2020 00:57:30 +0100
Message-Id: <20201203235736.3528991-35-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203235736.3528991-1-christian.brauner@ubuntu.com>
References: <20201203235736.3528991-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let fat handle idmapped mounts. This allows to have the same fat mount
appear in multiple locations with different id mappings. This allows to
expose a vfat formatted USB stick to multiple user with different ids on
the host or in user namespaces allowing for dac permissions:

mount -o uid=1000,gid=1000 /dev/sdb /mnt

u1001@f2-vm:/lower1$ ls -ln /mnt/
total 4
-rwxr-xr-x 1 1000 1000 4 Oct 28 03:44 aaa
-rwxr-xr-x 1 1000 1000 0 Oct 28 01:09 bbb
-rwxr-xr-x 1 1000 1000 0 Oct 28 01:10 ccc
-rwxr-xr-x 1 1000 1000 0 Oct 28 03:46 ddd
-rwxr-xr-x 1 1000 1000 0 Oct 28 04:01 eee

mount-idmapped --map-mount b:1000:1001:1

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

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged

/* v4 */
- Mauricio Vásquez Bernal <mauricio@kinvolk.io>:
  - Fix mount example in commit message.

- Serge Hallyn <serge@hallyn.com>:
  - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
    terminology consistent.
---
 fs/fat/file.c        | 15 ++++++++-------
 fs/fat/namei_msdos.c |  2 +-
 fs/fat/namei_vfat.c  |  2 +-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/fat/file.c b/fs/fat/file.c
index 73acd0843d92..6a618e9450c8 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -398,7 +398,7 @@ int fat_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(mnt_userns, inode, stat);
 	stat->blksize = MSDOS_SB(inode->i_sb)->cluster_size;
 
 	if (MSDOS_SB(inode->i_sb)->options.nfs == FAT_NFS_NOSTALE_RO) {
@@ -447,12 +447,13 @@ static int fat_sanitize_mode(const struct msdos_sb_info *sbi,
 	return 0;
 }
 
-static int fat_allow_set_time(struct msdos_sb_info *sbi, struct inode *inode)
+static int fat_allow_set_time(struct user_namespace *mnt_userns,
+			      struct msdos_sb_info *sbi, struct inode *inode)
 {
 	umode_t allow_utime = sbi->options.allow_utime;
 
-	if (!uid_eq(current_fsuid(), inode->i_uid)) {
-		if (in_group_p(inode->i_gid))
+	if (!uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode))) {
+		if (in_group_p(i_gid_into_mnt(mnt_userns, inode)))
 			allow_utime >>= 3;
 		if (allow_utime & MAY_WRITE)
 			return 1;
@@ -477,11 +478,11 @@ int fat_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	/* Check for setting the inode time. */
 	ia_valid = attr->ia_valid;
 	if (ia_valid & TIMES_SET_FLAGS) {
-		if (fat_allow_set_time(sbi, inode))
+		if (fat_allow_set_time(mnt_userns, sbi, inode))
 			attr->ia_valid &= ~TIMES_SET_FLAGS;
 	}
 
-	error = setattr_prepare(&init_user_ns, dentry, attr);
+	error = setattr_prepare(mnt_userns, dentry, attr);
 	attr->ia_valid = ia_valid;
 	if (error) {
 		if (sbi->options.quiet)
@@ -551,7 +552,7 @@ int fat_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		fat_truncate_time(inode, &attr->ia_mtime, S_MTIME);
 	attr->ia_valid &= ~(ATTR_ATIME|ATTR_CTIME|ATTR_MTIME);
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(mnt_userns, inode, attr);
 	mark_inode_dirty(inode);
 out:
 	return error;
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index a8f3375d9d10..efba301d68ae 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -667,7 +667,7 @@ static struct file_system_type msdos_fs_type = {
 	.name		= "msdos",
 	.mount		= msdos_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("msdos");
 
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 23936ecf79a5..5369d82e0bfb 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1063,7 +1063,7 @@ static struct file_system_type vfat_fs_type = {
 	.name		= "vfat",
 	.mount		= vfat_mount,
 	.kill_sb	= kill_block_super,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("vfat");
 
-- 
2.29.2

