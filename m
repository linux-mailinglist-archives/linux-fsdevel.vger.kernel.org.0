Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4FE567081
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 16:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiGEOL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 10:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiGEOL1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:11:27 -0400
Received: from mail.yonan.net (mail.yonan.net [54.244.116.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0AB20F7F;
        Tue,  5 Jul 2022 07:04:16 -0700 (PDT)
Received: from unless.localdomain (c-71-196-190-209.hsd1.co.comcast.net [71.196.190.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.yonan.net (Postfix) with ESMTPSA id B940C3E953;
        Tue,  5 Jul 2022 14:04:15 +0000 (UTC)
From:   James Yonan <james@openvpn.net>
To:     linux-fsdevel@vger.kernel.org
Cc:     david@fromorbit.com, neilb@suse.de, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        James Yonan <james@openvpn.net>
Subject: [RESEND PATCH v3 1/2] namei: implemented RENAME_NEWER_MTIME flag for renameat2() conditional replace
Date:   Tue,  5 Jul 2022 08:03:20 -0600
Message-Id: <20220705140320.895557-1-james@openvpn.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220702080710.GB3108597@dread.disaster.area>
References: <20220702080710.GB3108597@dread.disaster.area>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RENAME_NEWER_MTIME is a new userspace-visible flag for renameat2(), and
stands alongside existing flags including RENAME_NOREPLACE,
RENAME_EXCHANGE, and RENAME_WHITEOUT.

RENAME_NEWER_MTIME is a conditional variation on RENAME_NOREPLACE, and
indicates that if the target of the rename exists, the rename or exchange
will only succeed if the source file is newer than the target (i.e.
source mtime > target mtime).  Otherwise, the rename will fail with
-EEXIST instead of replacing the target.  When the target doesn't exist,
RENAME_NEWER_MTIME does a plain rename like RENAME_NOREPLACE.

RENAME_NEWER_MTIME can also be combined with RENAME_EXCHANGE for
conditional exchange, where the exchange only occurs if source mtime >
target mtime.  Otherwise, the operation will fail with -EEXIST.

Some of the use cases for RENAME_NEWER_MTIME include (a) using a
directory as a key-value store, or (b) maintaining a near-real-time
mirror of a remote data source.  A common design pattern for maintaining
such a data store would be to create a file using a temporary pathname,
setting the file mtime using utimensat(2) or futimens(2) based on the
remote creation timestamp of the file content, then using
RENAME_NEWER_MTIME to move the file into place in the target directory.
If the operation returns an error with errno == EEXIST, then the source
file is not up-to-date and can safely be deleted. The goal is to
facilitate distributed systems having many concurrent writers and
readers, where update notifications are possibly delayed, duplicated, or
reordered, yet where readers see a consistent view of the target
directory with predictable semantics and atomic updates.

Note that RENAME_NEWER_MTIME depends on accurate, high-resolution
timestamps for mtime, preferably approaching nanosecond resolution.

RENAME_NEWER_MTIME is implemented in vfs_rename(), and we lock and deny
write access to both source and target inodes before comparing their
mtimes, to stabilize the comparison.

The use case for RENAME_NEWER_MTIME doesn't really align with
directories, so we return -EISDIR if either source or target is a
directory.  This makes the locking necessary to stabilize the mtime
comparison (in vfs_rename()) much more straightforward.

Like RENAME_NOREPLACE, the RENAME_NEWER_MTIME implementation lives in
the VFS, however the individual fs implementations do strict flags
checking and will return -EINVAL for any flag they don't recognize.
At this time, I have enabled and tested RENAME_NEWER_MTIME on ext2, ext3,
ext4, xfs, btrfs, and tmpfs.

I did not notice a general self-test for renameat2() at the VFS
layer (outside of fs-specific tests), so I created one, though
at the moment it only exercises RENAME_NEWER_MTIME and RENAME_EXCHANGE.
The self-test is written to be portable to the Linux Test Project,
and the advantage of running it there is that it automatically runs
tests on multiple filesystems.  See comments at the beginning of
renameat2_tests.c for more info.

Build and run the self-test with:

  make -C tools/testing/selftests TARGETS=renameat2 run_tests

Questions:

Q: Why use mtime and not ctime for timestamp comparison?

A: I see the "use a directory as a key/value store" use case
   as caring more about the modification time of the file content
   rather than the metadata.  Also, the rename operation itself
   modifies ctime, making it less useful as a reference timestamp.
   In any event, this patch creates the infrastructure for
   conditional rename/exchange based on inode timestamp, so a
   subsequent patch to add RENAME_NEWER_CTIME would be a mostly
   trivial exercise.

Signed-off-by: James Yonan <james@openvpn.net>
---
Patch version history:

v2: Changed flag name from RENAME_NEWER to RENAME_NEWER_MTIME so
    as to disambiguate and make it clear that we are comparing
    mtime values.

    RENAME_NEWER_MTIME can now be combined with RENAME_EXCHANGE
    for conditional exchange, where exchange only occurs if
    source mtime > target mtime.

    Moved the mtime comparison logic into vfs_rename() to take
    advantage of existing {lock,unlock}_two_nondirectories critical
    section, and then further nest another critical section
    {deny,allow}_write_access (adapted to inodes) to stabilize the
    mtime, since our use case doesn't require renaming files that
    are open for write (we will return -ETXTBSY in this case).

    Did some refactoring of inline functions in linux/fs.h that
    manage inode->i_writecount, and added inode_deny_write_access2()
    and inode_allow_write_access2() functions.

    Extended the self-test (renameat2_tests.c):

    1. Verify that RENAME_NEWER_MTIME fails with errno == ETXTBSY when
       one of the files is open for write.

    2. Test conditional exchange use case with combined flags
       RENAME_EXCHANGE|RENAME_NEWER_MTIME.

    3. The test .c file is now drop-in portable to the Linux Test
       Project where you can take advantage of the .all_filesystems = 1
       flag to automatically run tests on multiple filesystems.

v3: The use case for RENAME_NEWER_MTIME doesn't really align
    with directories, so return -EISDIR if either source or
    target is a directory.  This makes the locking necessary
    to stabilize the mtime comparison (in vfs_rename())
    much more straightforward.

    simple_rename() in libfs.c doesn't need to support
    RENAME_NEWER_MTIME.

    Broke up some long lines.

    Rebased on top of 5.19-rc5.

    Break out the self-test into a separate patch.

    Documented RENAME_NEWER_MTIME in the rename.2 man page
    (separate patch).
---
 Documentation/filesystems/vfs.rst | 11 ++++++++
 fs/btrfs/inode.c                  |  3 ++-
 fs/ext2/namei.c                   |  2 +-
 fs/ext4/namei.c                   |  3 ++-
 fs/namei.c                        | 37 +++++++++++++++++++++++---
 fs/xfs/xfs_iops.c                 |  3 ++-
 include/linux/fs.h                | 43 ++++++++++++++++++++++++++++---
 include/uapi/linux/fs.h           |  1 +
 mm/shmem.c                        |  3 ++-
 tools/include/uapi/linux/fs.h     |  1 +
 10 files changed, 95 insertions(+), 12 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 08069ecd49a6..495e7352cca1 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -515,6 +515,17 @@ otherwise noted.
 	(2) RENAME_EXCHANGE: exchange source and target.  Both must
 	exist; this is checked by the VFS.  Unlike plain rename, source
 	and target may be of different type.
+	(3) RENAME_NEWER_MTIME: this flag is similar to RENAME_NOREPLACE,
+	and indicates a conditional rename: if the target of the rename
+	exists, the rename should only succeed if the source file is
+	newer than the target (i.e. source mtime > target mtime).
+	Otherwise, the rename should fail with -EEXIST instead of
+	replacing the target.  To exchange source and target conditional
+	on source being newer than target, pass flags as
+	RENAME_EXCHANGE|RENAME_NEWER_MTIME.  RENAME_NEWER_MTIME will fail
+	with -ETXTBSY if either source or target is open for write.
+	RENAME_NEWER_MTIME is not currently supported on directories, and
+	will return -EISDIR if either source or target is a directory.
 
 ``get_link``
 	called by the VFS to follow a symbolic link to the inode it
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 05e0c4a5affd..0b78858d25b8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9549,7 +9549,8 @@ static int btrfs_rename2(struct user_namespace *mnt_userns, struct inode *old_di
 			 struct dentry *old_dentry, struct inode *new_dir,
 			 struct dentry *new_dentry, unsigned int flags)
 {
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT
+		      | RENAME_NEWER_MTIME))
 		return -EINVAL;
 
 	if (flags & RENAME_EXCHANGE)
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 5f6b7560eb3f..35dc17f80528 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -336,7 +336,7 @@ static int ext2_rename (struct user_namespace * mnt_userns,
 	struct ext2_dir_entry_2 * old_de;
 	int err;
 
-	if (flags & ~RENAME_NOREPLACE)
+	if (flags & ~(RENAME_NOREPLACE | RENAME_NEWER_MTIME))
 		return -EINVAL;
 
 	err = dquot_initialize(old_dir);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index db4ba99d1ceb..3e393e2959b6 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -4128,7 +4128,8 @@ static int ext4_rename2(struct user_namespace *mnt_userns,
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(old_dir->i_sb))))
 		return -EIO;
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT
+		      | RENAME_NEWER_MTIME))
 		return -EINVAL;
 
 	err = fscrypt_prepare_rename(old_dir, old_dentry, new_dir, new_dentry,
diff --git a/fs/namei.c b/fs/namei.c
index 1f28d3f463c3..7776afc199c0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -40,6 +40,7 @@
 #include <linux/bitops.h>
 #include <linux/init_task.h>
 #include <linux/uaccess.h>
+#include <linux/time64.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -4685,11 +4686,22 @@ int vfs_rename(struct renamedata *rd)
 
 	take_dentry_name_snapshot(&old_name, old_dentry);
 	dget(new_dentry);
-	if (!is_dir || (flags & RENAME_EXCHANGE))
+	if (!is_dir || (flags & (RENAME_EXCHANGE|RENAME_NEWER_MTIME)))
 		lock_two_nondirectories(source, target);
 	else if (target)
 		inode_lock(target);
 
+	if ((flags & RENAME_NEWER_MTIME) && target) {
+		/* deny write access to stabilize mtime comparison below */
+		error = inode_deny_write_access2(source, target);
+		if (error) /* -ETXTBSY */
+			goto out1;
+		if (timespec64_compare(&source->i_mtime, &target->i_mtime) <= 0) {
+			error = -EEXIST;
+			goto out;
+		}
+	}
+
 	error = -EPERM;
 	if (IS_SWAPFILE(source) || (target && IS_SWAPFILE(target)))
 		goto out;
@@ -4736,7 +4748,10 @@ int vfs_rename(struct renamedata *rd)
 			d_exchange(old_dentry, new_dentry);
 	}
 out:
-	if (!is_dir || (flags & RENAME_EXCHANGE))
+	if ((flags & RENAME_NEWER_MTIME) && target)
+		inode_allow_write_access2(source, target);
+out1:
+	if (!is_dir || (flags & (RENAME_EXCHANGE|RENAME_NEWER_MTIME)))
 		unlock_two_nondirectories(source, target);
 	else if (target)
 		inode_unlock(target);
@@ -4769,11 +4784,12 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	bool should_retry = false;
 	int error = -EINVAL;
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT
+		      | RENAME_NEWER_MTIME))
 		goto put_names;
 
 	if ((flags & (RENAME_NOREPLACE | RENAME_WHITEOUT)) &&
-	    (flags & RENAME_EXCHANGE))
+	    (flags & (RENAME_EXCHANGE | RENAME_NEWER_MTIME)))
 		goto put_names;
 
 	if (flags & RENAME_EXCHANGE)
@@ -4825,6 +4841,19 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	error = -EEXIST;
 	if ((flags & RENAME_NOREPLACE) && d_is_positive(new_dentry))
 		goto exit5;
+	if (flags & RENAME_NEWER_MTIME) {
+		/* The use case for RENAME_NEWER_MTIME doesn't really align
+		 * with directories, so bail out here if either source or
+		 * target is a directory.  This makes the locking necessary
+		 * to stabilize the mtime comparison (in vfs_rename)
+		 * much more straightforward.
+		 */
+		error = -EISDIR;
+		if (d_is_dir(old_dentry))
+			goto exit5;
+		if (d_is_positive(new_dentry) && d_is_dir(new_dentry))
+			goto exit5;
+	}
 	if (flags & RENAME_EXCHANGE) {
 		error = -ENOENT;
 		if (d_is_negative(new_dentry))
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 29f5b8b8aca6..a6ec8edd5398 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -457,7 +457,8 @@ xfs_vn_rename(
 	struct xfs_name	oname;
 	struct xfs_name	nname;
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT
+		      | RENAME_NEWER_MTIME))
 		return -EINVAL;
 
 	/* if we are exchanging files, we need to set i_mode of both files */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9ad5e3520fae..0c79f12ec51f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2819,14 +2819,21 @@ static inline void file_end_write(struct file *file)
  * use {get,deny}_write_access() - these functions check the sign and refuse
  * to do the change if sign is wrong.
  */
+static inline int inode_deny_write_access(struct inode *inode)
+{
+	return atomic_dec_unless_positive(&inode->i_writecount) ? 0 : -ETXTBSY;
+}
+static inline void inode_allow_write_access(struct inode *inode)
+{
+	atomic_inc(&inode->i_writecount);
+}
 static inline int get_write_access(struct inode *inode)
 {
 	return atomic_inc_unless_negative(&inode->i_writecount) ? 0 : -ETXTBSY;
 }
 static inline int deny_write_access(struct file *file)
 {
-	struct inode *inode = file_inode(file);
-	return atomic_dec_unless_positive(&inode->i_writecount) ? 0 : -ETXTBSY;
+	return inode_deny_write_access(file_inode(file));
 }
 static inline void put_write_access(struct inode * inode)
 {
@@ -2835,13 +2842,43 @@ static inline void put_write_access(struct inode * inode)
 static inline void allow_write_access(struct file *file)
 {
 	if (file)
-		atomic_inc(&file_inode(file)->i_writecount);
+		inode_allow_write_access(file_inode(file));
 }
 static inline bool inode_is_open_for_write(const struct inode *inode)
 {
 	return atomic_read(&inode->i_writecount) > 0;
 }
 
+/**
+ * inode_deny_write_access2 - deny write access on two inodes.
+ * Returns -ETXTBSY if write access cannot be denied on either inode.
+ * @inode1: first inode
+ * @inode2: second inode
+ */
+static inline int inode_deny_write_access2(struct inode *inode1, struct inode *inode2)
+{
+	int error = inode_deny_write_access(inode1);
+	if (error)
+		return error;
+	error = inode_deny_write_access(inode2);
+	if (error)
+		inode_allow_write_access(inode1);
+	return error;
+}
+
+/**
+ * inode_allow_write_access2 - allow write access on two inodes.
+ * This method is intended to be called after a successful call
+ * to inode_deny_write_access2().
+ * @inode1: first inode
+ * @inode2: second inode
+ */
+static inline void inode_allow_write_access2(struct inode *inode1, struct inode *inode2)
+{
+	inode_allow_write_access(inode1);
+	inode_allow_write_access(inode2);
+}
+
 #if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
 static inline void i_readcount_dec(struct inode *inode)
 {
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index bdf7b404b3e7..7e9c32dce3e4 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -50,6 +50,7 @@
 #define RENAME_NOREPLACE	(1 << 0)	/* Don't overwrite target */
 #define RENAME_EXCHANGE		(1 << 1)	/* Exchange source and dest */
 #define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
+#define RENAME_NEWER_MTIME	(1 << 3)	/* Only newer file can overwrite target */
 
 struct file_clone_range {
 	__s64 src_fd;
diff --git a/mm/shmem.c b/mm/shmem.c
index a6f565308133..41de04b828fd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3009,7 +3009,8 @@ static int shmem_rename2(struct user_namespace *mnt_userns,
 	struct inode *inode = d_inode(old_dentry);
 	int they_are_dirs = S_ISDIR(inode->i_mode);
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT
+		      | RENAME_NEWER_MTIME))
 		return -EINVAL;
 
 	if (flags & RENAME_EXCHANGE)
diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index bdf7b404b3e7..7e9c32dce3e4 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -50,6 +50,7 @@
 #define RENAME_NOREPLACE	(1 << 0)	/* Don't overwrite target */
 #define RENAME_EXCHANGE		(1 << 1)	/* Exchange source and dest */
 #define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
+#define RENAME_NEWER_MTIME	(1 << 3)	/* Only newer file can overwrite target */
 
 struct file_clone_range {
 	__s64 src_fd;
-- 
2.25.1

