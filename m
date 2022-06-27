Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A9B55DDEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242569AbiF0WU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 18:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239498AbiF0WU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:20:57 -0400
X-Greylist: delayed 440 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Jun 2022 15:20:53 PDT
Received: from mail.yonan.net (mail.yonan.net [54.244.116.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E5E13EA0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 15:20:53 -0700 (PDT)
Received: from unless.localdomain (unknown [76.130.91.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.yonan.net (Postfix) with ESMTPSA id 995553E947;
        Mon, 27 Jun 2022 22:13:32 +0000 (UTC)
From:   James Yonan <james@openvpn.net>
To:     linux-fsdevel@vger.kernel.org
Cc:     James Yonan <james@openvpn.net>
Subject: [PATCH] namei: implemented RENAME_NEWER flag for renameat2() conditional replace
Date:   Mon, 27 Jun 2022 16:11:07 -0600
Message-Id: <20220627221107.176495-1-james@openvpn.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RENAME_NEWER is a new userspace-visible flag for renameat2(), and
stands alongside existing flags such as RENAME_NOREPLACE,
RENAME_EXCHANGE, and RENAME_WHITEOUT.

RENAME_NEWER is a conditional variation on RENAME_NOREPLACE, and
indicates that if the target of the rename exists, the rename will
only succeed if the source file is newer than the target (i.e. source
mtime > target mtime).  Otherwise, the rename will fail with -EEXIST
instead of replacing the target.  When the target doesn't exist,
RENAME_NEWER does a plain rename like RENAME_NOREPLACE.

RENAME_NEWER is very useful in distributed systems that mirror a
directory structure, or use a directory as a key/value store, and need
to guarantee that files will only be overwritten by newer files, and
that all updates are atomic.

While this patch may appear large at first glance, most of the changes
deal with renameat2() flags validation, and the core logic is only
5 lines in the do_renameat2() function in fs/namei.c:

	if ((flags & RENAME_NEWER)
	    && d_is_positive(new_dentry)
	    && timespec64_compare(&d_backing_inode(old_dentry)->i_mtime,
				  &d_backing_inode(new_dentry)->i_mtime) <= 0)
		goto exit5;

It's pretty cool in a way that a new atomic file operation can even be
implemented in just 5 lines of code, and it's thanks to the existing
locking infrastructure around file rename/move that these operations
become almost trivial.  Unfortunately, every fs must approve a new
renameat2() flag, so it bloats the patch a bit.

So one question to ask is could this functionality be implemented
in userspace without adding a new renameat2() flag?  I think you
could attempt it with iterative RENAME_EXCHANGE, but it's hackish,
inefficient, and not atomic, because races could cause temporary
mtime backtracks.  How about using file locking?  Probably not,
because the problem we want to solve is maintaining file/directory
atomicity for readers by creating files out-of-directory, setting
their mtime, and atomically moving them into place.  The strategy
to lock such an operation really requires more complex locking methods
than are generally exposed to userspace.  And if you are using inotify
on the directory to notify readers of changes, it certainly makes
sense to reduce unnecessary churn by preventing a move operation
based on the mtime check.

While some people might question the utility of adding features to
filesystems to make them more like databases, there is real value
in the performance, atomicity, consistent VFS interface, multi-thread
safety, and async-notify capabilities of modern filesystems that
starts to blur the line, and actually make filesystem-based key-value
stores a win for many applications.

Like RENAME_NOREPLACE, the RENAME_NEWER implementation lives in
the VFS, however the individual fs implementations do strict flags
checking and will return -EINVAL for any flag they don't recognize.
For this reason, my general approach with flags is to accept
RENAME_NEWER wherever RENAME_NOREPLACE is also accepted, since
RENAME_NEWER is simply a conditional variant of RENAME_NOREPLACE.

I noticed only one fs driver (cifs) that treated RENAME_NOREPLACE
in a non-generic way, because no-replace is the natural behavior
for CIFS, and it therefore considers RENAME_NOREPLACE as a hint that
no replacement can occur.  Aside from this special case, it seems
safe to assume that any fs that supports RENAME_NOREPLACE should
also be able to support RENAME_NEWER out of the box.

I did not notice a general self-test for renameat2() at the VFS
layer (outside of fs-specific tests), so I created one, though
at the moment it only exercises RENAME_NEWER.  Build and run with:

  make -C tools/testing/selftests TARGETS=renameat2 run_tests

Signed-off-by: James Yonan <james@openvpn.net>
---
 Documentation/filesystems/vfs.rst             |   5 +
 fs/affs/namei.c                               |   2 +-
 fs/bfs/dir.c                                  |   2 +-
 fs/btrfs/inode.c                              |   2 +-
 fs/cifs/inode.c                               |   2 +-
 fs/exfat/namei.c                              |   7 +-
 fs/ext2/namei.c                               |   2 +-
 fs/ext4/namei.c                               |   2 +-
 fs/f2fs/namei.c                               |   2 +-
 fs/fat/namei_msdos.c                          |   2 +-
 fs/fat/namei_vfat.c                           |   2 +-
 fs/fuse/dir.c                                 |   2 +-
 fs/gfs2/inode.c                               |   2 +-
 fs/hfs/dir.c                                  |   2 +-
 fs/hfsplus/dir.c                              |   2 +-
 fs/hostfs/hostfs_kern.c                       |   2 +-
 fs/hpfs/namei.c                               |   2 +-
 fs/jffs2/dir.c                                |   2 +-
 fs/jfs/namei.c                                |   2 +-
 fs/libfs.c                                    |   2 +-
 fs/minix/namei.c                              |   2 +-
 fs/namei.c                                    |  10 +-
 fs/nilfs2/namei.c                             |   2 +-
 fs/ntfs3/namei.c                              |   2 +-
 fs/omfs/dir.c                                 |   2 +-
 fs/overlayfs/dir.c                            |   4 +-
 fs/reiserfs/namei.c                           |   2 +-
 fs/sysv/namei.c                               |   2 +-
 fs/ubifs/dir.c                                |   2 +-
 fs/udf/namei.c                                |   2 +-
 fs/ufs/namei.c                                |   2 +-
 fs/xfs/xfs_iops.c                             |   2 +-
 include/uapi/linux/fs.h                       |   1 +
 mm/shmem.c                                    |   2 +-
 tools/include/uapi/linux/fs.h                 |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/renameat2/.gitignore  |   1 +
 tools/testing/selftests/renameat2/Makefile    |  10 ++
 .../selftests/renameat2/renameat2_tests.c     | 142 ++++++++++++++++++
 39 files changed, 204 insertions(+), 36 deletions(-)
 create mode 100644 tools/testing/selftests/renameat2/.gitignore
 create mode 100644 tools/testing/selftests/renameat2/Makefile
 create mode 100644 tools/testing/selftests/renameat2/renameat2_tests.c

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 08069ecd49a6..8c5c773c426c 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -515,6 +515,11 @@ otherwise noted.
 	(2) RENAME_EXCHANGE: exchange source and target.  Both must
 	exist; this is checked by the VFS.  Unlike plain rename, source
 	and target may be of different type.
+	(3) RENAME_NEWER: this flag is similar to RENAME_NOREPLACE,
+	and indicates that if the target of the rename exists, the
+	rename should only succeed if the source file is newer than
+	the target (i.e. source mtime > target mtime).  Otherwise, the
+	rename should fail with -EEXIST instead of replacing the target.
 
 ``get_link``
 	called by the VFS to follow a symbolic link to the inode it
diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index bcab18956b4f..e52f1851e1b9 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -508,7 +508,7 @@ int affs_rename2(struct user_namespace *mnt_userns, struct inode *old_dir,
 		 struct dentry *new_dentry, unsigned int flags)
 {
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_NEWER))
 		return -EINVAL;
 
 	pr_debug("%s(old=%lu,\"%pd\" to new=%lu,\"%pd\")\n", __func__,
diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index 34d4f68f786b..d161bfb37050 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -209,7 +209,7 @@ static int bfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	struct bfs_sb_info *info;
 	int error = -ENOENT;
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	old_bh = new_bh = NULL;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 05e0c4a5affd..1e3d8c3f3c50 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9549,7 +9549,7 @@ static int btrfs_rename2(struct user_namespace *mnt_userns, struct inode *old_di
 			 struct dentry *old_dentry, struct inode *new_dir,
 			 struct dentry *new_dentry, unsigned int flags)
 {
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT | RENAME_NEWER))
 		return -EINVAL;
 
 	if (flags & RENAME_EXCHANGE)
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 81da81e18553..79b2e03b9a6f 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2087,7 +2087,7 @@ cifs_rename2(struct user_namespace *mnt_userns, struct inode *source_dir,
 	int rc, tmprc;
 	int retry_count = 0;
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	cifs_sb = CIFS_SB(source_dir->i_sb);
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index c6eaf7e9ea74..fe74c1115f8d 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1322,10 +1322,11 @@ static int exfat_rename(struct user_namespace *mnt_userns,
 
 	/*
 	 * The VFS already checks for existence, so for local filesystems
-	 * the RENAME_NOREPLACE implementation is equivalent to plain rename.
-	 * Don't support any other flags
+	 * the RENAME_NOREPLACE implementation (and conditional variants
+	 * such as RENAME_NEWER) is equivalent to plain rename.
+	 * Don't support any other flags.
 	 */
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	mutex_lock(&EXFAT_SB(sb)->s_lock);
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 5f6b7560eb3f..c5adbf2d770f 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -336,7 +336,7 @@ static int ext2_rename (struct user_namespace * mnt_userns,
 	struct ext2_dir_entry_2 * old_de;
 	int err;
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	err = dquot_initialize(old_dir);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index db4ba99d1ceb..a5788c56a21d 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -4128,7 +4128,7 @@ static int ext4_rename2(struct user_namespace *mnt_userns,
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(old_dir->i_sb))))
 		return -EIO;
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT | RENAME_NEWER))
 		return -EINVAL;
 
 	err = fscrypt_prepare_rename(old_dir, old_dentry, new_dir, new_dentry,
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index bf00d5057abb..fa52b8a5b346 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1306,7 +1306,7 @@ static int f2fs_rename2(struct user_namespace *mnt_userns,
 {
 	int err;
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT | RENAME_NEWER))
 		return -EINVAL;
 
 	err = fscrypt_prepare_rename(old_dir, old_dentry, new_dir, new_dentry,
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index efba301d68ae..ad7ae428ca93 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -603,7 +603,7 @@ static int msdos_rename(struct user_namespace *mnt_userns,
 	unsigned char old_msdos_name[MSDOS_NAME], new_msdos_name[MSDOS_NAME];
 	int err, is_hid;
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	mutex_lock(&MSDOS_SB(sb)->s_lock);
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index c573314806cf..7f251ea267c3 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -902,7 +902,7 @@ static int vfat_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	int err, is_dir, update_dotdot, corrupt = 0;
 	struct super_block *sb = old_dir->i_sb;
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	old_sinfo.bh = sinfo.bh = dotdot_bh = NULL;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 74303d6e987b..7576414315ae 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -980,7 +980,7 @@ static int fuse_rename2(struct user_namespace *mnt_userns, struct inode *olddir,
 	if (fuse_is_bad(olddir))
 		return -EIO;
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT | RENAME_NEWER))
 		return -EINVAL;
 
 	if (flags) {
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index c8ec876f33ea..ee2c33700290 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1753,7 +1753,7 @@ static int gfs2_rename2(struct user_namespace *mnt_userns, struct inode *odir,
 			struct dentry *odentry, struct inode *ndir,
 			struct dentry *ndentry, unsigned int flags)
 {
-	flags &= ~RENAME_NOREPLACE;
+	flags &= ~(RENAME_NOREPLACE | RENAME_NEWER);
 
 	if (flags & ~RENAME_EXCHANGE)
 		return -EINVAL;
diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 527f6e46cbe8..0665fa46fc2b 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -286,7 +286,7 @@ static int hfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 {
 	int res;
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	/* Unlink destination if it already exists */
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 84714bbccc12..edc53792a80b 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -536,7 +536,7 @@ static int hfsplus_rename(struct user_namespace *mnt_userns,
 {
 	int res;
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	/* Unlink destination if it already exists */
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index cc1bc6f93a01..39c2a30c64b1 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -742,7 +742,7 @@ static int hostfs_rename2(struct user_namespace *mnt_userns,
 	char *old_name, *new_name;
 	int err;
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_NEWER))
 		return -EINVAL;
 
 	old_name = dentry_name(old_dentry);
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index 15fc63276caa..3c1e9b1e671e 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -531,7 +531,7 @@ static int hpfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	struct fnode *fnode;
 	int err;
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	if ((err = hpfs_chk_name(new_name, &new_len))) return err;
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index c0aabbcbfd58..f5e98837c51e 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -773,7 +773,7 @@ static int jffs2_rename (struct user_namespace *mnt_userns,
 	uint8_t type;
 	uint32_t now;
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	/* The VFS will check for us and prevent trying to rename a
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 9db4f5789c0e..75b5df0ffd98 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -1080,7 +1080,7 @@ static int jfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	s64 new_size = 0;
 	int commit_flag;
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	jfs_info("jfs_rename: %pd %pd", old_dentry, new_dentry);
diff --git a/fs/libfs.c b/fs/libfs.c
index 31b0ddf01c31..6430e0c4ae1e 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -479,7 +479,7 @@ int simple_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	struct inode *inode = d_inode(old_dentry);
 	int they_are_dirs = d_is_dir(old_dentry);
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_NEWER))
 		return -EINVAL;
 
 	if (flags & RENAME_EXCHANGE)
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 937fa5fae2b8..b130da0ab3c0 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -197,7 +197,7 @@ static int minix_rename(struct user_namespace *mnt_userns,
 	struct minix_dir_entry * old_de;
 	int err = -ENOENT;
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	old_de = minix_find_entry(old_dentry, &old_page);
diff --git a/fs/namei.c b/fs/namei.c
index 1f28d3f463c3..11df238f1875 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -40,6 +40,7 @@
 #include <linux/bitops.h>
 #include <linux/init_task.h>
 #include <linux/uaccess.h>
+#include <linux/time64.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -4769,10 +4770,10 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	bool should_retry = false;
 	int error = -EINVAL;
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT | RENAME_NEWER))
 		goto put_names;
 
-	if ((flags & (RENAME_NOREPLACE | RENAME_WHITEOUT)) &&
+	if ((flags & (RENAME_NOREPLACE | RENAME_WHITEOUT | RENAME_NEWER)) &&
 	    (flags & RENAME_EXCHANGE))
 		goto put_names;
 
@@ -4825,6 +4826,11 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	error = -EEXIST;
 	if ((flags & RENAME_NOREPLACE) && d_is_positive(new_dentry))
 		goto exit5;
+	if ((flags & RENAME_NEWER)
+	    && d_is_positive(new_dentry)
+	    && timespec64_compare(&d_backing_inode(old_dentry)->i_mtime,
+				  &d_backing_inode(new_dentry)->i_mtime) <= 0)
+		goto exit5;
 	if (flags & RENAME_EXCHANGE) {
 		error = -ENOENT;
 		if (d_is_negative(new_dentry))
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 23899e0ae850..7b1b53cb5bc8 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -354,7 +354,7 @@ static int nilfs_rename(struct user_namespace *mnt_userns,
 	struct nilfs_transaction_info ti;
 	int err;
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	err = nilfs_transaction_begin(old_dir->i_sb, &ti, 1);
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index bc741213ad84..2fc3091114c0 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -252,7 +252,7 @@ static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *dir,
 		      1024);
 	static_assert(PATH_MAX >= 4 * 1024);
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	is_same = dentry->d_name.len == new_dentry->d_name.len &&
diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
index c219f91f44e9..42ecaaa318c9 100644
--- a/fs/omfs/dir.c
+++ b/fs/omfs/dir.c
@@ -378,7 +378,7 @@ static int omfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	struct inode *old_inode = d_inode(old_dentry);
 	int err;
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	if (new_inode) {
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 6b03457f72bb..1e38ad37ceec 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1101,10 +1101,10 @@ static int ovl_rename(struct user_namespace *mnt_userns, struct inode *olddir,
 	LIST_HEAD(list);
 
 	err = -EINVAL;
-	if (flags & ~(RENAME_EXCHANGE | RENAME_NOREPLACE))
+	if (flags & ~(RENAME_EXCHANGE | RENAME_NOREPLACE | RENAME_NEWER))
 		goto out;
 
-	flags &= ~RENAME_NOREPLACE;
+	flags &= ~(RENAME_NOREPLACE | RENAME_NEWER);
 
 	/* Don't copy up directory trees */
 	err = -EXDEV;
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 3d7a35d6a18b..7c1a19cecc40 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -1325,7 +1325,7 @@ static int reiserfs_rename(struct user_namespace *mnt_userns,
 	unsigned long savelink = 1;
 	struct timespec64 ctime;
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	/*
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index b2e6abc06a2d..fb3504f98e93 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -201,7 +201,7 @@ static int sysv_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	struct sysv_dir_entry * old_de;
 	int err = -ENOENT;
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	old_de = sysv_find_entry(old_dentry, &old_page);
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 86151889548e..923117c4290b 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1610,7 +1610,7 @@ static int ubifs_rename(struct user_namespace *mnt_userns,
 	int err;
 	struct ubifs_info *c = old_dir->i_sb->s_fs_info;
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_WHITEOUT | RENAME_EXCHANGE))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_WHITEOUT | RENAME_EXCHANGE | RENAME_NEWER))
 		return -EINVAL;
 
 	ubifs_assert(c, inode_is_locked(old_dir));
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index b3d5f97f16cd..abe60354aa7c 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1087,7 +1087,7 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	struct kernel_lb_addr tloc;
 	struct udf_inode_info *old_iinfo = UDF_I(old_inode);
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	ofi = udf_find_entry(old_dir, &old_dentry->d_name, &ofibh, &ocfi);
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 29d5a0e0c8f0..a55519376066 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -255,7 +255,7 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	struct ufs_dir_entry *old_de;
 	int err = -ENOENT;
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER))
 		return -EINVAL;
 
 	old_de = ufs_find_entry(old_dir, &old_dentry->d_name, &old_page);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 29f5b8b8aca6..2cafa7abc4f3 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -457,7 +457,7 @@ xfs_vn_rename(
 	struct xfs_name	oname;
 	struct xfs_name	nname;
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT | RENAME_NEWER))
 		return -EINVAL;
 
 	/* if we are exchanging files, we need to set i_mode of both files */
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index bdf7b404b3e7..b848054b8942 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -50,6 +50,7 @@
 #define RENAME_NOREPLACE	(1 << 0)	/* Don't overwrite target */
 #define RENAME_EXCHANGE		(1 << 1)	/* Exchange source and dest */
 #define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
+#define RENAME_NEWER		(1 << 3)	/* Only newer file can overwrite target */
 
 struct file_clone_range {
 	__s64 src_fd;
diff --git a/mm/shmem.c b/mm/shmem.c
index a6f565308133..52f3e4b74625 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3009,7 +3009,7 @@ static int shmem_rename2(struct user_namespace *mnt_userns,
 	struct inode *inode = d_inode(old_dentry);
 	int they_are_dirs = S_ISDIR(inode->i_mode);
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT | RENAME_NEWER))
 		return -EINVAL;
 
 	if (flags & RENAME_EXCHANGE)
diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index bdf7b404b3e7..b848054b8942 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -50,6 +50,7 @@
 #define RENAME_NOREPLACE	(1 << 0)	/* Don't overwrite target */
 #define RENAME_EXCHANGE		(1 << 1)	/* Exchange source and dest */
 #define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
+#define RENAME_NEWER		(1 << 3)	/* Only newer file can overwrite target */
 
 struct file_clone_range {
 	__s64 src_fd;
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index de11992dc577..34226dfbca7a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -54,6 +54,7 @@ TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
 TARGETS += openat2
+TARGETS += renameat2
 TARGETS += resctrl
 TARGETS += rlimits
 TARGETS += rseq
diff --git a/tools/testing/selftests/renameat2/.gitignore b/tools/testing/selftests/renameat2/.gitignore
new file mode 100644
index 000000000000..79bbdf497559
--- /dev/null
+++ b/tools/testing/selftests/renameat2/.gitignore
@@ -0,0 +1 @@
+renameat2_tests
diff --git a/tools/testing/selftests/renameat2/Makefile b/tools/testing/selftests/renameat2/Makefile
new file mode 100644
index 000000000000..c39f5e281a5d
--- /dev/null
+++ b/tools/testing/selftests/renameat2/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS = -g -Wall -O2
+CFLAGS += $(KHDR_INCLUDES)
+
+TEST_GEN_PROGS := renameat2_tests
+
+include ../lib.mk
+
+$(OUTPUT)/renameat2_tests: renameat2_tests.c
diff --git a/tools/testing/selftests/renameat2/renameat2_tests.c b/tools/testing/selftests/renameat2/renameat2_tests.c
new file mode 100644
index 000000000000..843432f07179
--- /dev/null
+++ b/tools/testing/selftests/renameat2/renameat2_tests.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "../kselftest_harness.h"
+
+#include <fcntl.h>
+#include <time.h>
+#include <sys/stat.h>
+
+/* requires a kernel that implements renameat2() RENAME_NEWER flag */
+#ifndef RENAME_NEWER
+#define RENAME_NEWER (1 << 3)
+#endif
+
+static int create_file_with_timestamp(const char *filename,
+				      const time_t tv_sec,
+				      const long tv_nsec,
+				      struct stat *s)
+{
+	int fd;
+	struct timespec times[2];
+
+	fd = open(filename, O_CREAT|O_TRUNC|O_WRONLY, 0777);
+	if (fd < 0)
+		return errno;
+	times[0].tv_sec = tv_sec;
+	times[0].tv_nsec = tv_nsec;
+	times[1] = times[0];
+	if (futimens(fd, times) != 0) {
+		close(fd);
+		return errno;
+	}
+	if (fstat(fd, s)) {
+		close(fd);
+		return errno;
+	}
+	if (close(fd) != 0)
+		return errno;
+	return 0;
+}
+
+static int do_rename_newer(const char *source_file, const char *target_file)
+{
+	if (renameat2(AT_FDCWD, source_file, AT_FDCWD, target_file, RENAME_NEWER))
+		return errno;
+	return 0;
+}
+
+static int verify_inode(const char *filename, const struct stat *orig_stat)
+{
+	struct stat s;
+
+	if (stat(filename, &s))
+		return errno;
+	if (orig_stat->st_ino != s.st_ino)
+		return ENOENT;
+	return 0;
+}
+
+static int verify_exist(const char *filename)
+{
+	int fd;
+
+	fd = open(filename, O_RDONLY);
+	if (fd < 0)
+		return errno;
+	if (close(fd) != 0)
+		return errno;
+	return 0;
+}
+
+TEST(rename_newer)
+{
+	char dirname[] = "/tmp/ksft-renameat2-rename-newer.XXXXXX";
+	const time_t now = time(NULL);
+	struct stat stat_a, stat_b, stat_c;
+	int eno;
+
+	/* make the top-level directory */
+	if (!mkdtemp(dirname))
+		ksft_exit_fail_msg("rename_newer: failed to create tmpdir\n");
+
+	/* cd to top-level directory */
+	if (chdir(dirname))
+		ksft_exit_fail_msg("rename_newer: failed to cd to tmpdir\n");
+
+	/* create files */
+	eno = create_file_with_timestamp("a", now, 700000, &stat_a);
+	if (eno)
+		ksft_exit_fail_msg("rename_newer: failed to create file 'a', errno=%d\n", eno);
+	eno = create_file_with_timestamp("b", now+1, 500000, &stat_b);
+	if (eno)
+		ksft_exit_fail_msg("rename_newer: failed to create file 'b', errno=%d\n", eno);
+	eno = create_file_with_timestamp("c", now+1, 500000, &stat_c);
+	if (eno)
+		ksft_exit_fail_msg("rename_newer: failed to create file 'c', errno=%d\n", eno);
+
+	/* rename b -> e -- should succeed because e doesn't exist */
+	eno = do_rename_newer("b", "e");
+	if (eno)
+		ksft_exit_fail_msg("rename_newer: failed to rename 'b' -> 'e', errno=%d (kernel may be missing RENAME_NEWER feature)\n", eno);
+	eno = verify_inode("e", &stat_b);
+	if (eno)
+		ksft_exit_fail_msg("rename_newer: could not verify inode of 'e' after rename 'b' -> 'e', errno=%d\n", eno);
+	eno = verify_exist("b");
+	if (eno != ENOENT)
+		ksft_exit_fail_msg("rename_newer: strangely, 'b' still exists after rename 'b' -> 'e', errno=%d\n", eno);
+
+	/* rename c -> e -- should fail because c and e have the same timestamp */
+	eno = do_rename_newer("c", "e");
+	if (eno != EEXIST)
+		ksft_exit_fail_msg("rename_newer: rename 'c' -> 'e' should have failed because 'c' and 'e' have the same timestamp, errno=%d\n", eno);
+	eno = verify_inode("c", &stat_c);
+	if (eno)
+		ksft_exit_fail_msg("rename_newer: could not verify inode of 'c' after attempted rename 'c' -> 'e' didn't occur, errno=%d\n", eno);
+	eno = verify_inode("e", &stat_b);
+	if (eno)
+		ksft_exit_fail_msg("rename_newer: could not verify inode of 'e' after attempted rename 'c' -> 'e' didn't occur, errno=%d\n", eno);
+
+	/* rename a -> c -- should fail because c is newer than a */
+	eno = do_rename_newer("a", "c");
+	if (eno != EEXIST)
+		ksft_exit_fail_msg("rename_newer: rename 'a' -> 'c' should have failed because 'c' is newer, errno=%d\n", eno);
+	eno = verify_inode("a", &stat_a);
+	if (eno)
+		ksft_exit_fail_msg("rename_newer: could not verify inode of 'a' after attempted rename 'a' -> 'c' didn't occur, errno=%d\n", eno);
+	eno = verify_inode("c", &stat_c);
+	if (eno)
+		ksft_exit_fail_msg("rename_newer: could not verify inode of 'c' after attempted rename 'a' -> 'c' didn't occur, errno=%d\n", eno);
+
+	/* rename c -> a -- should succeed because c is newer than a */
+	eno = do_rename_newer("c", "a");
+	if (eno)
+		ksft_exit_fail_msg("rename_newer: rename 'c' -> 'a' should have succeeded because 'c' is newer than 'a', errno=%d\n", eno);
+	eno = verify_inode("a", &stat_c);
+	if (eno)
+		ksft_exit_fail_msg("rename_newer: could not verify inode of 'a' after rename 'c' -> 'a', errno=%d\n", eno);
+	eno = verify_exist("c");
+	if (eno != ENOENT)
+		ksft_exit_fail_msg("rename_newer: strangely, 'c' still exists after rename 'c' -> 'a', errno=%d\n", eno);
+}
+
+TEST_HARNESS_MAIN
-- 
2.25.1

