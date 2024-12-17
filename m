Return-Path: <linux-fsdevel+bounces-37602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8549F4344
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 07:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A39188EFB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F98D156222;
	Tue, 17 Dec 2024 06:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="BQKEiWI/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DE118E20
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 06:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734415489; cv=none; b=VbGiIxSm3OseCje1bjcTiHU+ugzAQnI2mfyFEwaX/mgPGdOWofzHVi5oNsC4qlMwDGxp+smlnAOf/xPH2K8jgN2VTBz6FzCzbNPX+Uq+MCFF4zlrrukiWTWGe6qVR0sph1de5QxcMTS8u9wyKrs6ijuuxRIZ2FDTkXrtcSFSBto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734415489; c=relaxed/simple;
	bh=H3WQDllJi8kOlqfR6009ObOLu0rbOmzB+bb4U6/WPi8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J6HGYs/H0MHlpA6fau5p/vKXmwTxL14ABYwT6tu+vb5NVgjNj2Au0DjF4KVlr7pMhytEvu8LKcAvF9Rc6yN2cCXuom/R55RBFxGqngE/YSiWU5M0zoN79diwBC08c23B4MfV+TSk1EvdzpbBgFsWKYMmdx8pBSlk+e7sqWWUA00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=BQKEiWI/; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-226.bstnma.fios.verizon.net [173.48.82.226])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4BH64WH4022290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 01:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1734415474; bh=SUGd3rGjjkMuIIk124ybMhuk+X9UnxQNn7U/V1r/sqc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=BQKEiWI/SKMelyiUSgBV8wwQ1q7ubuI8cXq/+pCUfxYcCeDdP+WSH5JH+j+JRsXp1
	 9EC7DHtHRrv8ODfHafdZDJ7kqqvXglu2Cze2RgJqjF0Z9mfw5UL9HTXaqx7uhWkclR
	 WCkVeJAmKafGxrcLFu00nt6ApYJEQXCZVEMpNufO9quTeCHYQ50FHeVmBlOsV8oLxm
	 fSd6CrhQIVjmZuMjpxfH4ghi/uHhT7bn3ad9AjcXMrtdVAeV+b1Lgc4Iq0Ter1O+Ke
	 IAjPS9+k2+umn7pjWNpmJaYYzDJ0gepIPAFOw9ALpjTYLLwHO+aBB5IzXjwyOlW8AM
	 Wrz2vc28CSfag==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4B9A515C4656; Tue, 17 Dec 2024 01:04:32 -0500 (EST)
Date: Tue, 17 Dec 2024 01:04:32 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christian Brauner <brauner@kernel.org>
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>
Subject: [REGRESSION] generic/{467,477} in linux-next
Message-ID: <20241217060432.GA594052@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uWdjK/LUP/3FhW0R"
Content-Disposition: inline


--uWdjK/LUP/3FhW0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

For at least the last two days, I've been noticing xfstest failures
for generic/467 and generic/477 for all file systems.  It can be
reproduced by "install-kconfig; kbuild ; kvm-xfstests -c
ext4/4k,xfs/4k generic/467 generic/477".

I tried doing a bisection, which fingered commit 3660c5fd9482
("exportfs: add permission method").  When I tried reverting this
commit, and then fixing up a compile failure in fs/pidfs.c by the most
obvious way, the test stopped failing.

Christian, could you take a look?   Many thanks!!

Attached please find my most-recent fs-next testing, plus the patches
which seems to resolve the problem.  (The second in particular is a
hack; and they aren't meant for you to apply, but rather to hopefully
point out what might be the root cause.)

	   	     	    	    	 - Ted

generic/467 2s ...  [00:46:15][   13.994623] run fstests generic/467 at 2024-12-17 00:46:15
[   14.336137] XFS (vdd): EXPERIMENTAL online scrub feature enabled.  Use at your own risk!
 [00:46:16]- output mismatch (see /results/xfs/results-4k/generic/467.out.bad)
    --- tests/generic/467.out   2024-12-14 18:52:20.000000000 -0500
    +++ /results/xfs/results-4k/generic/467.out.bad     2024-12-17 00:46:16.792323065 -0500
    @@ -1,9 +1,16 @@
     QA output created by 467
     test_file_handles TEST_DIR/467-dir -dp
     test_file_handles TEST_DIR/467-dir -rp
    +/vdd/467-dir/file000009: read: Bad file descriptor
     test_file_handles TEST_DIR/467-dir -dkr
    +/vdd/467-dir/file000009: read: Bad file descriptor
     test_file_handles TEST_DIR/467-dir -lr
    ...
    (Run 'diff -u /root/xfstests/tests/generic/467.out /results/xfs/results-4k/generic/467.out.bad')
generic/467 aggregate results across 5 runs: fail=5 (100.0%)
generic/477 2s ...  [00:46:17][   15.758732] run fstests generic/477 at 2024-12-17 00:46:17
[   16.171967] XFS (vdd): EXPERIMENTAL online scrub feature enabled.  Use at your own risk!
 [00:46:18]- output mismatch (see /results/xfs/results-4k/generic/477.out.bad)
    --- tests/generic/477.out   2024-12-14 18:52:20.000000000 -0500
    +++ /results/xfs/results-4k/generic/477.out.bad     2024-12-17 00:46:18.638016154 -0500
    @@ -1,5 +1,9 @@
     QA output created by 477
     test_file_handles after cycle mount
    +/vdd/file000009: read: Bad file descriptor
     test_file_handles after rename parent
    +/vdd/file000009: read: Bad file descriptor
     test_file_handles after rename grandparent
    +/vdd/file000009: read: Bad file descriptor
    ...
    (Run 'diff -u /root/xfstests/tests/generic/477.out /results/xfs/results-4k/generic/477.out.bad')

--uWdjK/LUP/3FhW0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=fs-next-results

TESTRUNID: ltm-20241215091253-0003
KERNEL:    kernel 6.13.0-rc3-xfstests-g19e80e45a880 #1 SMP PREEMPT_DYNAMIC Mon Dec 16 18:59:31 EST 2024 x86_64
CMDLINE:   -c ext4/all,xfs/all,btrfs/all,f2fs/all -g auto --repo https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next --watch fs-next
CPUS:      2
MEM:       7680

ext4/4k: 578 tests, 2 failures, 53 skipped, 4716 seconds
  Failures: generic/467 generic/477
ext4/1k: 572 tests, 3 failures, 57 skipped, 5916 seconds
  Failures: generic/467 generic/477 generic/750
ext4/ext3: 570 tests, 3 failures, 146 skipped, 4681 seconds
  Failures: generic/467 generic/477
  Flaky: generic/234: 20% (1/5)
ext4/encrypt: 553 tests, 2 failures, 172 skipped, 3170 seconds
  Failures: generic/467 generic/477
ext4/nojournal: 570 tests, 2 failures, 124 skipped, 4125 seconds
  Failures: generic/467 generic/477
ext4/ext3conv: 575 tests, 2 failures, 55 skipped, 4827 seconds
  Failures: generic/467 generic/477
ext4/adv: 571 tests, 2 failures, 61 skipped, 4766 seconds
  Failures: generic/467 generic/757
ext4/dioread_nolock: 576 tests, 2 failures, 53 skipped, 6037 seconds
  Failures: generic/467 generic/477
ext4/data_journal: 571 tests, 3 failures, 132 skipped, 5690 seconds
  Failures: generic/127 generic/467 generic/477
ext4/bigalloc_4k: 549 tests, 3 failures, 56 skipped, 5339 seconds
  Failures: generic/467 generic/477 generic/590
ext4/bigalloc_1k: 550 tests, 2 failures, 67 skipped, 4651 seconds
  Failures: generic/467 generic/477
ext4/dax: 564 tests, 3 failures, 159 skipped, 2633 seconds
  Failures: generic/467 generic/477 generic/590
xfs/4k: 1161 tests, 3 failures, 183 skipped, 12584 seconds
  Failures: generic/467 generic/477 xfs/273
xfs/1k: 1161 tests, 4 failures, 169 skipped, 19271 seconds
  Failures: generic/467 generic/477 xfs/273 xfs/629
xfs/v4: 1160 tests, 7 failures, 478 skipped, 9498 seconds
  Failures: generic/467 generic/477 xfs/273 xfs/348 xfs/803 xfs/804
  Flaky: generic/753: 20% (1/5)
xfs/adv: 1161 tests, 3 failures, 169 skipped, 13511 seconds
  Failures: generic/467 generic/477 xfs/273
xfs/quota: 1161 tests, 4 failures, 168 skipped, 10502 seconds
  Failures: generic/050 generic/467 generic/477 xfs/273
xfs/quota_1k: 1161 tests, 6 failures, 170 skipped, 13697 seconds
  Failures: generic/050 generic/467 generic/477 xfs/273 xfs/629
  Flaky: xfs/609: 20% (1/5)
xfs/dirblock_8k: 1161 tests, 4 failures, 168 skipped, 14240 seconds
  Failures: generic/050 generic/467 generic/477 xfs/273
xfs/realtime: 1160 tests, 6 failures, 519 skipped, 10026 seconds
  Failures: generic/455 generic/467 generic/477 generic/590 xfs/273
  Flaky: xfs/609: 20% (1/5)
xfs/realtime_28k_logdev: 1160 tests, 11 failures, 600 skipped, 13489 seconds
  Failures: generic/467 generic/477 generic/590 generic/757 xfs/273 xfs/598 
    xfs/609 xfs/629 xfs/630 xfs/631 xfs/632
xfs/realtime_logdev: 1160 tests, 7 failures, 573 skipped, 13471 seconds
  Failures: generic/467 generic/477 generic/590 generic/757 xfs/273 xfs/598
  Flaky: xfs/609: 80% (4/5)
xfs/logdev: 1161 tests, 6 failures, 238 skipped, 15061 seconds
  Failures: generic/050 generic/467 generic/477 generic/757 xfs/273 xfs/598
xfs/dax: 1171 tests, 4 failures, 554 skipped, 6323 seconds
  Failures: generic/467 generic/477 xfs/629 xfs/632
btrfs/default: 1053 tests, 5 failures, 281 skipped, 10882 seconds
  Failures: btrfs/007 btrfs/012 btrfs/284 generic/467 generic/477
f2fs/default: 730 tests, 8 failures, 252 skipped, 7612 seconds
  Failures: f2fs/007 generic/050 generic/064 generic/467 generic/477 
    generic/563 generic/735
  Flaky: f2fs/004: 40% (2/5)
f2fs/encrypt: 712 tests, 7 failures, 358 skipped, 5671 seconds
  Failures: f2fs/007 generic/050 generic/467 generic/477 generic/563 
    generic/635
  Flaky: generic/455: 40% (2/5)
Totals: 23688 tests, 6015 skipped, 547 failures, 0 errors, 217710s

FSTESTIMG: gce-xfstests/xfstests-amd64-202412152243
FSTESTPRJ: gce-xfstests
FSTESTVER: blktests 92bc31c (Wed, 11 Dec 2024 20:58:23 +0900)
FSTESTVER: fio  fio-3.38 (Wed, 2 Oct 2024 12:53:13 -0600)
FSTESTVER: fsverity v1.6 (Wed, 20 Mar 2024 21:21:46 -0700)
FSTESTVER: ima-evm-utils v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
FSTESTVER: libaio   libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
FSTESTVER: ltp  20240930-123-g91cbe7e1f (Fri, 13 Dec 2024 08:24:47 +0100)
FSTESTVER: quota  v4.05-69-g68952f1 (Mon, 7 Oct 2024 15:45:56 -0400)
FSTESTVER: util-linux v2.40.2 (Thu, 4 Jul 2024 09:59:17 +0200)
FSTESTVER: xfsprogs v6.12.0 (Mon, 2 Dec 2024 22:40:29 +0100)
FSTESTVER: xfstests-bld 2639bff5 (Sun, 15 Dec 2024 22:41:37 -0500)
FSTESTVER: xfstests v2024.12.08-13-gb09c6267c (Sat, 14 Dec 2024 21:43:47 -0500)
FSTESTVER: zz_build-distro bookworm
FSTESTSET: -g auto
FSTESTOPT: aex

--uWdjK/LUP/3FhW0R
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Revert-exportfs-add-permission-method.patch"

From 312a0851122b8408e891bf5b32467f2ba83441c9 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 17 Dec 2024 00:33:44 -0500
Subject: [PATCH 1/2] Revert "exportfs: add permission method"

This reverts commit 3660c5fd94824bdfed556bfd34ce6559d1fd4eee.
---
 fs/fhandle.c             | 21 ++++++++++++++-------
 include/linux/exportfs.h | 17 +----------------
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index d11572063dc5..e17029b1dc44 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -187,6 +187,17 @@ static int get_path_from_fd(int fd, struct path *root)
 	return 0;
 }
 
+enum handle_to_path_flags {
+	HANDLE_CHECK_PERMS   = (1 << 0),
+	HANDLE_CHECK_SUBTREE = (1 << 1),
+};
+
+struct handle_to_path_ctx {
+	struct path root;
+	enum handle_to_path_flags flags;
+	unsigned int fh_flags;
+};
+
 static int vfs_dentry_acceptable(void *context, struct dentry *dentry)
 {
 	struct handle_to_path_ctx *ctx = context;
@@ -325,19 +336,15 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 	struct file_handle f_handle;
 	struct file_handle *handle = NULL;
 	struct handle_to_path_ctx ctx = {};
-	const struct export_operations *eops;
 
 	retval = get_path_from_fd(mountdirfd, &ctx.root);
 	if (retval)
 		goto out_err;
 
-	eops = ctx.root.mnt->mnt_sb->s_export_op;
-	if (eops && eops->permission)
-		retval = eops->permission(&ctx, o_flags);
-	else
-		retval = may_decode_fh(&ctx, o_flags);
-	if (retval)
+	if (!may_decode_fh(&ctx, o_flags)) {
+		retval = -EPERM;
 		goto out_path;
+	}
 
 	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle))) {
 		retval = -EFAULT;
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index a087606ace19..c69b79b64466 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -3,7 +3,6 @@
 #define LINUX_EXPORTFS_H 1
 
 #include <linux/types.h>
-#include <linux/path.h>
 
 struct dentry;
 struct iattr;
@@ -11,6 +10,7 @@ struct inode;
 struct iomap;
 struct super_block;
 struct vfsmount;
+struct path;
 
 /* limit the handle size to NFSv4 handle size now */
 #define MAX_HANDLE_SZ 128
@@ -157,17 +157,6 @@ struct fid {
 	};
 };
 
-enum handle_to_path_flags {
-	HANDLE_CHECK_PERMS   = (1 << 0),
-	HANDLE_CHECK_SUBTREE = (1 << 1),
-};
-
-struct handle_to_path_ctx {
-	struct path root;
-	enum handle_to_path_flags flags;
-	unsigned int fh_flags;
-};
-
 #define EXPORT_FH_CONNECTABLE	0x1 /* Encode file handle with parent */
 #define EXPORT_FH_FID		0x2 /* File handle may be non-decodeable */
 #define EXPORT_FH_DIR_ONLY	0x4 /* Only decode file handle for a directory */
@@ -237,9 +226,6 @@ struct handle_to_path_ctx {
  *    is also a directory.  In the event that it cannot be found, or storage
  *    space cannot be allocated, a %ERR_PTR should be returned.
  *
- * permission:
- *    Allow filesystems to specify a custom permission function.
- *
  * open:
  *    Allow filesystems to specify a custom open function.
  *
@@ -269,7 +255,6 @@ struct export_operations {
 			  bool write, u32 *device_generation);
 	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
 			     int nr_iomaps, struct iattr *iattr);
-	int (*permission)(struct handle_to_path_ctx *ctx, unsigned int oflags);
 	struct file * (*open)(struct path *path, unsigned int oflags);
 #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
 #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
-- 
2.45.2


--uWdjK/LUP/3FhW0R
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-pidfs-fix-up-after-reverting-exportfs-add-permission.patch"

From 8bc129cceb59663ca3a054ea3f8f67abec17298b Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 17 Dec 2024 00:40:01 -0500
Subject: [PATCH 2/2] pidfs: fix up after reverting "exportfs: add permission
 method"

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/pidfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index c5a51c69acc8..0e2c49499814 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -610,6 +610,7 @@ static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
 #define VALID_FILE_HANDLE_OPEN_FLAGS \
 	(O_RDONLY | O_WRONLY | O_RDWR | O_NONBLOCK | O_CLOEXEC | O_EXCL)
 
+#if 0
 static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
 				   unsigned int oflags)
 {
@@ -623,6 +624,7 @@ static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
 	 */
 	return 0;
 }
+#endif
 
 static struct file *pidfs_export_open(struct path *path, unsigned int oflags)
 {
@@ -638,7 +640,7 @@ static const struct export_operations pidfs_export_operations = {
 	.encode_fh	= pidfs_encode_fh,
 	.fh_to_dentry	= pidfs_fh_to_dentry,
 	.open		= pidfs_export_open,
-	.permission	= pidfs_export_permission,
+//	.permission	= pidfs_export_permission,
 };
 
 static int pidfs_init_inode(struct inode *inode, void *data)
-- 
2.45.2


--uWdjK/LUP/3FhW0R--

