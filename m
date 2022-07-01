Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5737562FE3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 11:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiGAJZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 05:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiGAJYx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:24:53 -0400
Received: from mail.yonan.net (mail.yonan.net [54.244.116.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D5A71279
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 02:24:49 -0700 (PDT)
Received: from unless.localdomain (unknown [76.130.91.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.yonan.net (Postfix) with ESMTPSA id D689C3E880;
        Fri,  1 Jul 2022 09:24:48 +0000 (UTC)
From:   James Yonan <james@openvpn.net>
To:     linux-fsdevel@vger.kernel.org
Cc:     david@fromorbit.com, neilb@suse.de, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, James Yonan <james@openvpn.net>
Subject: [PATCH v2] namei: implemented RENAME_NEWER_MTIME flag for renameat2() conditional replace
Date:   Fri,  1 Jul 2022 03:23:26 -0600
Message-Id: <20220701092326.1845210-1-james@openvpn.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a4ea9789-6126-e058-8f55-6dfc8a3f30c3@openvpn.net>
References: <a4ea9789-6126-e058-8f55-6dfc8a3f30c3@openvpn.net>
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

RENAME_NEWER_MTIME is a new userspace-visible flag for renameat2(), and
stands alongside existing flags such as RENAME_NOREPLACE, RENAME_EXCHANGE,
and RENAME_WHITEOUT.

RENAME_NEWER_MTIME is a conditional variation on RENAME_NOREPLACE, and
indicates that if the target of the rename exists, the rename or exchange
will only succeed if the source file is newer than the target (i.e. source
mtime > target mtime).  Otherwise, the rename will fail with -EEXIST
instead of replacing the target.  When the target doesn't exist,
RENAME_NEWER_MTIME does a plain rename like RENAME_NOREPLACE.

RENAME_NEWER_MTIME can also be combined with RENAME_EXCHANGE for
conditional exchange, where the exchange only occurs if source mtime >
target mtime.  Otherwise, the operation will fail with -EEXIST.

RENAME_NEWER_MTIME is very useful in distributed systems that mirror a
directory structure, or use a directory as a key/value store, and need to
guarantee that files will only be overwritten by newer files, and that all
updates are atomic.

RENAME_NEWER_MTIME is implemented in vfs_rename(), and we lock and deny
write access to both source and target inodes before comparing their
mtimes, to stabilize the comparison.

So one question to ask is could this functionality be implemented in
userspace without adding a new renameat2() flag?  I think you could
attempt it with iterative RENAME_EXCHANGE, but it's hackish, inefficient,
and not atomic, because races could cause temporary mtime backtracks.
How about using file locking?  Probably not, because the problem we want
to solve is maintaining file/directory atomicity for readers by creating
files out-of-directory, setting their mtime, and atomically moving them
into place.  The strategy to lock such an operation really requires more
complex locking methods than are generally exposed to userspace.  And if
you are using inotify on the directory to notify readers of changes, it
certainly makes sense to reduce unnecessary churn by preventing a move
operation based on the mtime check.

While some people might question the utility of adding features to
filesystems to make them more like databases, there is real value in the
performance, atomicity, consistent VFS interface, multi-thread safety, and
async-notify capabilities of modern filesystems that starts to blur the
line, and actually make filesystem-based key-value stores a win for many
applications.

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

A: I think the "use a directory as a key/value store" use case
   cares about the modification time of the file content rather
   than metadata.  Also, the rename operation itself modifies
   ctime, making it less useful as a reference timestamp.
   In any event, this patch creates the infrastructure for
   conditional rename/exchange based on inode timestamp, so a
   subsequent patch to add RENAME_NEWER_CTIME would be a mostly
   trivial exercise.

Q: Why compare mtimes when some systems have poor system clock
   accuracy and resolution?

A: So in the "use a directory as a key/value store" use case
   in distributed systems, the file mtime is actually determined
   remotely by the file content creator and is set locally
   via futimens() rather than the local system clock.  So this gives
   you nanosecond-scale time resolution if the content creator
   supports it, even if the local system clock has less resolution.

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

    1. Verify that RENAME_NEWER_MTIME fails with ETXTBSY when
       one of the files is open for write.

    2. Test conditional exchange use case with combined flags
       RENAME_EXCHANGE|RENAME_NEWER_MTIME.

    3. The test .c file is now drop-in portable to the Linux Test
       Project where you can take advantage of the .all_filesystems = 1
       flag to automatically run tests on multiple filesystems.

Signed-off-by: James Yonan <james@openvpn.net>
---
 Documentation/filesystems/vfs.rst             |   9 +
 fs/btrfs/inode.c                              |   2 +-
 fs/ext2/namei.c                               |   2 +-
 fs/ext4/namei.c                               |   2 +-
 fs/libfs.c                                    |   2 +-
 fs/namei.c                                    |  21 +-
 fs/xfs/xfs_iops.c                             |   2 +-
 include/linux/fs.h                            |  43 +-
 include/uapi/linux/fs.h                       |   1 +
 mm/shmem.c                                    |   2 +-
 tools/include/uapi/linux/fs.h                 |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/renameat2/.gitignore  |   1 +
 tools/testing/selftests/renameat2/Makefile    |  10 +
 .../selftests/renameat2/renameat2_tests.c     | 447 ++++++++++++++++++
 15 files changed, 534 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/renameat2/.gitignore
 create mode 100644 tools/testing/selftests/renameat2/Makefile
 create mode 100644 tools/testing/selftests/renameat2/renameat2_tests.c

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 08069ecd49a6..9bee575c1f27 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -515,6 +515,15 @@ otherwise noted.
 	(2) RENAME_EXCHANGE: exchange source and target.  Both must
 	exist; this is checked by the VFS.  Unlike plain rename, source
 	and target may be of different type.
+	(3) RENAME_NEWER_MTIME: this flag is similar to RENAME_NOREPLACE,
+	and indicates a conditional rename: if the target of the rename
+	exists, the rename should only succeed if the source file is newer
+	than the target (i.e. source mtime > target mtime).  Otherwise, the
+	rename should fail with -EEXIST instead of replacing the target.
+	To exchange source and target conditional on source being newer
+	than target, pass flags as RENAME_EXCHANGE|RENAME_NEWER_MTIME.
+	RENAME_NEWER_MTIME will fail with -ETXTBSY if either source or
+	target is open for write.
 
 ``get_link``
 	called by the VFS to follow a symbolic link to the inode it
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 05e0c4a5affd..c6232ac0f0eb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9549,7 +9549,7 @@ static int btrfs_rename2(struct user_namespace *mnt_userns, struct inode *old_di
 			 struct dentry *old_dentry, struct inode *new_dir,
 			 struct dentry *new_dentry, unsigned int flags)
 {
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT | RENAME_NEWER_MTIME))
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
index db4ba99d1ceb..210537bb144b 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -4128,7 +4128,7 @@ static int ext4_rename2(struct user_namespace *mnt_userns,
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(old_dir->i_sb))))
 		return -EIO;
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT | RENAME_NEWER_MTIME))
 		return -EINVAL;
 
 	err = fscrypt_prepare_rename(old_dir, old_dentry, new_dir, new_dentry,
diff --git a/fs/libfs.c b/fs/libfs.c
index 31b0ddf01c31..13e206f2cc58 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -479,7 +479,7 @@ int simple_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	struct inode *inode = d_inode(old_dentry);
 	int they_are_dirs = d_is_dir(old_dentry);
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_NEWER_MTIME))
 		return -EINVAL;
 
 	if (flags & RENAME_EXCHANGE)
diff --git a/fs/namei.c b/fs/namei.c
index 1f28d3f463c3..5a8940058c43 100644
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
@@ -4769,7 +4784,7 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	bool should_retry = false;
 	int error = -EINVAL;
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT | RENAME_NEWER_MTIME))
 		goto put_names;
 
 	if ((flags & (RENAME_NOREPLACE | RENAME_WHITEOUT)) &&
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 29f5b8b8aca6..84efc0b02a3c 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -457,7 +457,7 @@ xfs_vn_rename(
 	struct xfs_name	oname;
 	struct xfs_name	nname;
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT | RENAME_NEWER_MTIME))
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
index a6f565308133..592de9245c80 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3009,7 +3009,7 @@ static int shmem_rename2(struct user_namespace *mnt_userns,
 	struct inode *inode = d_inode(old_dentry);
 	int they_are_dirs = S_ISDIR(inode->i_mode);
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT | RENAME_NEWER_MTIME))
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
index 000000000000..1fdb908cf428
--- /dev/null
+++ b/tools/testing/selftests/renameat2/renameat2_tests.c
@@ -0,0 +1,447 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Written by James Yonan <james@openvpn.net>
+ * Copyright (c) 2022 OpenVPN, Inc.
+ */
+
+/*
+ * Test renameat2() with RENAME_NOREPLACE, RENAME_EXCHANGE,
+ * and RENAME_NEWER_MTIME.
+ *
+ * This test is designed to be portable between
+ * the Linux kernel self-tests and the Linux Test Project.
+ * The cool thing about running the test in the Linux Test Project
+ * is that it will automatically iterate the test over all the
+ * filesystems available in your kernel.  In a default kernel,
+ * that includes ext2, ext3, ext4, xfs, btrfs, and tmpfs.
+ *
+ * By default we assume a Linux kernel self-test build, where
+ * you can build and run with:
+ *   make -C tools/testing/selftests TARGETS=renameat2 run_tests
+ *
+ * For a Linux Test Project build, place this source file
+ * under the ltp tree in:
+ *   testcases/kernel/syscalls/renameat2/renameat203.c
+ * Then cd to testcases/kernel/syscalls/renameat2 and add:
+ *   CPPFLAGS += -DLINUX_TEST_PROJECT
+ * to the end of the Makefile.  Then run with:
+ *   make && ./rename_newer_mtime
+ */
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <time.h>
+
+#ifdef LINUX_TEST_PROJECT
+#include "tst_test.h"
+#include "renameat2.h"
+#else
+#include "../kselftest_harness.h"
+#endif
+
+/* requires a kernel that implements renameat2() RENAME_NEWER_MTIME flag */
+#ifndef RENAME_NEWER_MTIME
+#define RENAME_NEWER_MTIME (1 << 3)
+#endif
+
+/* convert milliseconds to nanoseconds */
+#define MS_TO_NANO(x) ((x) * 1000000)
+
+#ifdef LINUX_TEST_PROJECT
+
+#define MNTPOINT "mntpoint"
+#define WORKDIR MNTPOINT "/testdir.XXXXXX"
+
+#define MY_ERROR(...) tst_brk(TFAIL, __VA_ARGS__)
+#define MY_PASS(...) tst_res(TPASS, __VA_ARGS__)
+
+#else /* Linux kernel self-test */
+
+#define WORKDIR "/tmp/ksft-renameat2-rename-newer-mtime.XXXXXX"
+
+#define MY_ERROR(fmt, ...) ksft_exit_fail_msg("%s/%d: " fmt "\n", __FILE__, __LINE__, __VA_ARGS__)
+#define MY_PASS(...)
+
+#endif
+
+static int create_file_with_timestamp(const char *filename,
+				      const time_t tv_sec,
+				      const long tv_nsec,
+				      struct stat *s,
+				      int *retain_fd)
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
+	if (futimens(fd, times)) {
+		close(fd);
+		return errno;
+	}
+	if (fstat(fd, s)) {
+		close(fd);
+		return errno;
+	}
+	if (retain_fd)
+		*retain_fd = fd;
+	else if (close(fd))
+		return errno;
+	return 0;
+}
+
+static int create_directory_with_timestamp(const char *dirname,
+					   const time_t tv_sec,
+					   const long tv_nsec,
+					   struct stat *s)
+{
+	struct timespec times[2];
+
+	if (mkdir(dirname, 0777))
+		return errno;
+	times[0].tv_sec = tv_sec;
+	times[0].tv_nsec = tv_nsec;
+	times[1] = times[0];
+	if (utimensat(AT_FDCWD, dirname, times, 0) != 0)
+		return errno;
+	if (lstat(dirname, s))
+		return errno;
+	return 0;
+}
+
+static int do_rename(const char *source_path, const char *target_path,
+		     const unsigned int flags)
+{
+	if (renameat2(AT_FDCWD, source_path, AT_FDCWD, target_path, flags))
+		return errno;
+	return 0;
+}
+
+static int verify_inode(const char *path, const struct stat *orig_stat)
+{
+	struct stat s;
+
+	if (stat(path, &s))
+		return errno;
+	if (orig_stat->st_ino != s.st_ino)
+		return ENOENT;
+	return 0;
+}
+
+static int verify_exist(const char *path)
+{
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return errno;
+	if (close(fd) != 0)
+		return errno;
+	return 0;
+}
+
+static int fd_d = -1; /* retained fd from file "d" */
+
+/*
+ * Test renameat2() with RENAME_NEWER_MTIME, RENAME_NOREPLACE, and RENAME_EXCHANGE.
+ */
+static void do_rename_newer_mtime(void)
+{
+	char dirname[] = WORKDIR;
+	const time_t now = time(NULL);
+	struct stat stat_a, stat_b, stat_c, stat_d, stat_f; /* files */
+	struct stat stat_x, stat_y; /* directories */
+	int eno; /* copied errno */
+
+	/* fd_d initial state */
+	fd_d = -1;
+
+	/* make the top-level directory */
+	if (!mkdtemp(dirname)) {
+		eno = errno;
+		MY_ERROR("failed to create tmpdir, errno=%d", eno);
+	}
+
+	/* cd to top-level directory */
+	if (chdir(dirname)) {
+		eno = errno;
+		MY_ERROR("failed to cd to tmpdir, errno=%d", eno);
+	}
+
+	/* create files with different mtimes */
+	eno = create_file_with_timestamp("a", now, MS_TO_NANO(700), &stat_a, NULL);
+	if (eno)
+		MY_ERROR("failed to create file 'a', errno=%d", eno);
+	eno = create_file_with_timestamp("b", now+1, MS_TO_NANO(500), &stat_b, NULL);
+	if (eno)
+		MY_ERROR("failed to create file 'b', errno=%d", eno);
+	eno = create_file_with_timestamp("c", now+1, MS_TO_NANO(500), &stat_c, NULL);
+	if (eno)
+		MY_ERROR("failed to create file 'c', errno=%d", eno);
+	eno = create_file_with_timestamp("d", now+1, MS_TO_NANO(300), &stat_d, &fd_d); /* leave open */
+	if (eno)
+		MY_ERROR("failed to create file 'd', errno=%d", eno);
+	eno = create_file_with_timestamp("f", now, MS_TO_NANO(0), &stat_f, NULL);
+	if (eno)
+		MY_ERROR("failed to create file 'f', errno=%d", eno);
+
+	/* create directories with different mtimes */
+	eno = create_directory_with_timestamp("x", now+2, MS_TO_NANO(0), &stat_x);
+	if (eno)
+		MY_ERROR("failed to create directory 'x', errno=%d", eno);
+	eno = create_directory_with_timestamp("y", now+3, MS_TO_NANO(0), &stat_y);
+	if (eno)
+		MY_ERROR("failed to create directory 'y', errno=%d", eno);
+
+	/* rename b -> e with RENAME_NEWER_MTIME -- should succeed because e doesn't exist */
+	eno = do_rename("b", "e", RENAME_NEWER_MTIME);
+	if (eno)
+		MY_ERROR("failed to rename 'b' -> 'e', errno=%d (kernel may be missing RENAME_NEWER_MTIME feature)", eno);
+	eno = verify_inode("e", &stat_b);
+	if (eno)
+		MY_ERROR("could not verify inode of 'e' after rename 'b' -> 'e', errno=%d", eno);
+	eno = verify_exist("b");
+	if (eno != ENOENT)
+		MY_ERROR("strangely, 'b' still exists after rename 'b' -> 'e', errno=%d", eno);
+
+	/* rename c -> e with RENAME_NEWER_MTIME -- should fail because c and e have
+	 * the same timestamp
+	 */
+	eno = do_rename("c", "e", RENAME_NEWER_MTIME);
+	if (eno != EEXIST)
+		MY_ERROR("rename 'c' -> 'e' should have failed with EEXIST because 'c' and 'e' have the same timestamp, errno=%d", eno);
+	eno = verify_inode("c", &stat_c);
+	if (eno)
+		MY_ERROR("could not verify inode of 'c' after attempted rename 'c' -> 'e', errno=%d", eno);
+	eno = verify_inode("e", &stat_b);
+	if (eno)
+		MY_ERROR("could not verify inode of 'e' after attempted rename 'c' -> 'e', errno=%d", eno);
+
+	/* rename a -> c with RENAME_NOREPLACE -- should fail because c exists */
+	eno = do_rename("a", "c", RENAME_NOREPLACE);
+	if (eno != EEXIST)
+		MY_ERROR("rename 'a' -> 'c' should have failed because 'c' exists, errno=%d", eno);
+	eno = verify_inode("a", &stat_a);
+	if (eno)
+		MY_ERROR("could not verify inode of 'a' after attempted rename 'a' -> 'c', errno=%d", eno);
+	eno = verify_inode("c", &stat_c);
+	if (eno)
+		MY_ERROR("could not verify inode of 'c' after attempted rename 'a' -> 'c', errno=%d", eno);
+
+	/* rename a -> c with RENAME_NEWER_MTIME -- should fail because c is newer than a */
+	eno = do_rename("a", "c", RENAME_NEWER_MTIME);
+	if (eno != EEXIST)
+		MY_ERROR("rename 'a' -> 'c' should have failed with EEXIST because 'c' is newer, errno=%d", eno);
+	eno = verify_inode("a", &stat_a);
+	if (eno)
+		MY_ERROR("could not verify inode of 'a' after attempted rename 'a' -> 'c', errno=%d", eno);
+	eno = verify_inode("c", &stat_c);
+	if (eno)
+		MY_ERROR("could not verify inode of 'c' after attempted rename 'a' -> 'c', errno=%d", eno);
+
+	/* rename c -> a with RENAME_NEWER_MTIME -- should succeed because c is newer than a */
+	eno = do_rename("c", "a", RENAME_NEWER_MTIME);
+	if (eno)
+		MY_ERROR("rename 'c' -> 'a' should have succeeded because 'c' is newer than 'a', errno=%d", eno);
+	eno = verify_inode("a", &stat_c);
+	if (eno)
+		MY_ERROR("could not verify inode of 'a' after rename 'c' -> 'a', errno=%d", eno);
+	eno = verify_exist("c");
+	if (eno != ENOENT)
+		MY_ERROR("strangely, 'c' still exists after rename 'c' -> 'a', errno=%d", eno);
+
+	/* exchange f <-> nonexistent with RENAME_EXCHANGE|RENAME_NEWER_MTIME -- should fail because
+	 * only f exists
+	 */
+	eno = do_rename("f", "nonexistent", RENAME_EXCHANGE|RENAME_NEWER_MTIME);
+	if (eno != ENOENT)
+		MY_ERROR("exchange 'f' <-> 'nonexistent' should have failed with ENOENT, errno=%d", eno);
+	eno = verify_inode("f", &stat_f);
+	if (eno)
+		MY_ERROR("could not verify inode of 'f' after attempted exchange 'f' <-> 'nonexistent', errno=%d", eno);
+
+	/* exchange d <-> f with RENAME_EXCHANGE|RENAME_NEWER_MTIME -- should fail because
+	 * d is open for write
+	 */
+	eno = do_rename("d", "f", RENAME_EXCHANGE|RENAME_NEWER_MTIME);
+	if (eno != ETXTBSY)
+		MY_ERROR("exchange 'd' <-> 'f' should have failed with ETXTBSY because d is open for write, errno=%d", eno);
+	eno = verify_inode("d", &stat_d);
+	if (eno)
+		MY_ERROR("could not verify inode of 'd' after attempted exchange 'd' <-> 'f', errno=%d", eno);
+	eno = verify_inode("f", &stat_f);
+	if (eno)
+		MY_ERROR("could not verify inode of 'f' after attempted exchange 'd' <-> 'f', errno=%d", eno);
+
+	/* exchange e <-> d with RENAME_EXCHANGE|RENAME_NEWER_MTIME -- should fail because
+	 * d is open for write
+	 */
+	eno = do_rename("e", "d", RENAME_EXCHANGE|RENAME_NEWER_MTIME);
+	if (eno != ETXTBSY)
+		MY_ERROR("exchange 'e' <-> 'd' should have failed with ETXTBSY because d is open for write, errno=%d", eno);
+	eno = verify_inode("e", &stat_b);
+	if (eno)
+		MY_ERROR("could not verify inode of 'e' after attempted exchange 'e' <-> 'd', errno=%d", eno);
+	eno = verify_inode("d", &stat_d);
+	if (eno)
+		MY_ERROR("could not verify inode of 'd' after attempted exchange 'e' <-> 'd', errno=%d", eno);
+
+	/* exchange f <-> d with RENAME_EXCHANGE|RENAME_NEWER_MTIME -- should fail because
+	 * d is open for write but also because f is older than d
+	 */
+	eno = do_rename("f", "d", RENAME_EXCHANGE|RENAME_NEWER_MTIME);
+	if (eno != ETXTBSY) /* note in this case we get ETXTBSY first (EEXIST would have
+			     * been returned if d wasn't open for write)
+			     */
+		MY_ERROR("exchange 'f' <-> 'd' should have failed with ETXTBSY because d is open for write, errno=%d", eno);
+	eno = verify_inode("f", &stat_f);
+	if (eno)
+		MY_ERROR("could not verify inode of 'f' after attempted exchange 'f' <-> 'd', errno=%d", eno);
+	eno = verify_inode("d", &stat_d);
+	if (eno)
+		MY_ERROR("could not verify inode of 'd' after attempted exchange 'f' <-> 'd', errno=%d", eno);
+
+	/* close fd_d */
+	if (close(fd_d) != 0) {
+		eno = errno;
+		MY_ERROR("error closing fd_d (write), errno=%d", eno);
+	}
+
+	/* reopen "d" for read access, which should not prevent RENAME_NEWER_MTIME */
+	fd_d = open("d", O_RDONLY);
+	if (fd_d < 0)
+		MY_ERROR("error reopening 'd' for read, errno=%d", eno);
+
+	/* exchange f <-> d with RENAME_EXCHANGE|RENAME_NEWER_MTIME -- should fail
+	 * because f is older than d
+	 */
+	eno = do_rename("f", "d", RENAME_EXCHANGE|RENAME_NEWER_MTIME);
+	if (eno != EEXIST)
+		MY_ERROR("exchange 'f' <-> 'd' should have failed with EEXIST because f is older than d, errno=%d", eno);
+	eno = verify_inode("f", &stat_f);
+	if (eno)
+		MY_ERROR("could not verify inode of 'f' after attempted exchange 'f' <-> 'd', errno=%d", eno);
+	eno = verify_inode("d", &stat_d);
+	if (eno)
+		MY_ERROR("could not verify inode of 'd' after attempted exchange 'f' <-> 'd', errno=%d", eno);
+
+	/* double exchange f <-> d with RENAME_EXCHANGE -- should succeed */
+	eno = do_rename("f", "d", RENAME_EXCHANGE);
+	if (eno)
+		MY_ERROR("exchange 'f' <-> 'd' should have succeeded, errno=%d", eno);
+	eno = verify_inode("d", &stat_f);
+	if (eno)
+		MY_ERROR("could not verify inode of 'd' after exchange 'd' <-> 'f', errno=%d", eno);
+	eno = verify_inode("f", &stat_d);
+	if (eno)
+		MY_ERROR("could not verify inode of 'f' after exchange 'd' <-> 'f', errno=%d", eno);
+	eno = do_rename("f", "d", RENAME_EXCHANGE);
+	if (eno)
+		MY_ERROR("exchange 'f' <-> 'd' should have succeeded, errno=%d", eno);
+	eno = verify_inode("d", &stat_d);
+	if (eno)
+		MY_ERROR("could not verify inode of 'd' after exchange 'd' <-> 'f', errno=%d", eno);
+	eno = verify_inode("f", &stat_f);
+	if (eno)
+		MY_ERROR("could not verify inode of 'f' after exchange 'd' <-> 'f', errno=%d", eno);
+
+	/* exchange d <-> f with RENAME_EXCHANGE|RENAME_NEWER_MTIME -- should succeed
+	 * because d is newer than f and fd_d is now read-only
+	 */
+	eno = do_rename("d", "f", RENAME_EXCHANGE|RENAME_NEWER_MTIME);
+	if (eno)
+		MY_ERROR("exchange 'd' <-> 'f' failed, errno=%d", eno);
+	eno = verify_inode("d", &stat_f);
+	if (eno)
+		MY_ERROR("could not verify inode of 'd' after exchange 'd' <-> 'f', errno=%d", eno);
+	eno = verify_inode("f", &stat_d);
+	if (eno)
+		MY_ERROR("could not verify inode of 'f' after exchange 'd' <-> 'f', errno=%d", eno);
+
+	/* exchange directories x <-> y with RENAME_EXCHANGE|RENAME_NEWER_MTIME
+	 * -- should fail because x is older than y
+	 */
+	eno = do_rename("x", "y", RENAME_EXCHANGE|RENAME_NEWER_MTIME);
+	if (eno != EEXIST)
+		MY_ERROR("exchange 'x' <-> 'y' should have failed with EEXIST because x is older than y, errno=%d", eno);
+	eno = verify_inode("x", &stat_x);
+	if (eno)
+		MY_ERROR("could not verify inode of 'x' after attempted exchange 'x' <-> 'y', errno=%d", eno);
+	eno = verify_inode("y", &stat_y);
+	if (eno)
+		MY_ERROR("could not verify inode of 'y' after attempted exchange 'x' <-> 'y', errno=%d", eno);
+
+	/* exchange directories y <-> x with RENAME_EXCHANGE|RENAME_NEWER_MTIME -- should succeed */
+	eno = do_rename("y", "x", RENAME_EXCHANGE|RENAME_NEWER_MTIME);
+	if (eno)
+		MY_ERROR("exchange 'y' <-> 'x' failed, errno=%d", eno);
+	eno = verify_inode("x", &stat_y);
+	if (eno)
+		MY_ERROR("could not verify inode of 'x' after exchange 'y' <-> 'x', errno=%d", eno);
+	eno = verify_inode("y", &stat_x);
+	if (eno)
+		MY_ERROR("could not verify inode of 'y' after exchange 'y' <-> 'x', errno=%d", eno);
+
+	/* close fd_d */
+	if (close(fd_d) != 0) {
+		eno = errno;
+		MY_ERROR("error closing fd_d (read), errno=%d", eno);
+	}
+	fd_d = -1;
+
+	MY_PASS("rename_newer_mtime test passed, workdir=%s", dirname);
+}
+
+#ifdef LINUX_TEST_PROJECT
+
+static void setup(void)
+{
+}
+
+static void cleanup(void)
+{
+	/* close fd_d */
+	if (fd_d >= 0)
+		close(fd_d);
+}
+
+static struct tst_test test = {
+	.test_all = do_rename_newer_mtime,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.all_filesystems = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.skip_filesystems = (const char*[]) {
+		"exfat",
+		"ntfs",
+		"vfat",
+		NULL
+	},
+	.needs_cmds = NULL,
+};
+
+#else /* Linux kernel self-test */
+
+TEST(rename_newer_mtime)
+{
+	do_rename_newer_mtime();
+}
+
+TEST_HARNESS_MAIN
+
+#endif
-- 
2.25.1

