Return-Path: <linux-fsdevel+bounces-1973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCF57E0FC9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 15:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C2DBB21273
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 14:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152D71A595;
	Sat,  4 Nov 2023 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2JkiDHf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3355A1A58A
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Nov 2023 14:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3867EC433C8;
	Sat,  4 Nov 2023 14:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699106440;
	bh=OfexyeS3odpnq+o7s7SxZag42Y4SNUvcLgg8dkf19bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u2JkiDHfGzmjb6jTCW6uo6sXJnBF7JC7NgCB9OxxtDnFoJIHnqM0Pb7HIq4dH+5PI
	 wzMnLsEbNFA1b8guP/a/VMGJIenTrWHba0LcGVLNhd8i+zrjg3kdOQDxhEFVlesq8r
	 +P1UiWNL9JzdG1rpkNQGpGNryHnzaU6xd/w+Aoz62v7PeCJfHl0jfWgSwV2jhBdGrm
	 YdFUvaA0LlFaJJGDDnw7HpUBy3nh0YyrfueLFwcWwRmvhsRBvg+frmL9kDG4MEwIAa
	 DRTwA75mU2tlRDWbutaX4KkJ49IRzydUJBVLlLpUh01KrRKmo62NUAZRajtSqeJH+t
	 YMcMbCQexDnIQ==
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <dchinner@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>
Subject: [PATCH v2 2/2] fs: handle freezing from multiple devices
Date: Sat,  4 Nov 2023 15:00:13 +0100
Message-Id: <20231104-vfs-multi-device-freeze-v2-2-5b5b69626eac@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64>
References: <20231104-vfs-multi-device-freeze-v2-0-5b5b69626eac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=15220; i=brauner@kernel.org; h=from:subject:message-id; bh=OfexyeS3odpnq+o7s7SxZag42Y4SNUvcLgg8dkf19bI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS6+aUG2iwtzZ6vNKHbz6njkYzcYoPfH6ee+nvZYOe3nv7g a98md5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEKoaR4UXo8z2x4ZtOrvpSxysd/1 nb5qHB4q3bX20UusW/8NHTCnWG/3mO70sfeHBrng600VR6378l8MdMx8d8bkuKDZ6Krzh3mBEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Before [1] freezing a filesystems through the block layer only worked
for the main block device as the owning superblock of additional block
devices could not be found. Any filesystem that made use of multiple
block devices would only be freezable via it's main block device.

For example, consider xfs over device mapper with /dev/dm-0 as main
block device and /dev/dm-1 as external log device. Two freeze requests
before [1]:

(1) dmsetup suspend /dev/dm-0 on the main block device

    bdev_freeze(dm-0)
    -> dm-0->bd_fsfreeze_count++
    -> freeze_super(xfs-sb)

    The owning superblock is found and the filesystem gets frozen.
    Returns 0.

(2) dmsetup suspend /dev/dm-1 on the log device

    bdev_freeze(dm-1)
    -> dm-1->bd_fsfreeze_count++

    The owning superblock isn't found and only the block device freeze
    count is incremented. Returns 0.

Two freeze requests after [1]:

(1') dmsetup suspend /dev/dm-0 on the main block device

    bdev_freeze(dm-0)
    -> dm-0->bd_fsfreeze_count++
    -> freeze_super(xfs-sb)

    The owning superblock is found and the filesystem gets frozen.
    Returns 0.

(2') dmsetup suspend /dev/dm-1 on the log device

    bdev_freeze(dm-0)
    -> dm-0->bd_fsfreeze_count++
    -> freeze_super(xfs-sb)

    The owning superblock is found and the filesystem gets frozen.
    Returns -EBUSY.

When (2') is called we initiate a freeze from another block device of
the same superblock. So we increment the bd_fsfreeze_count for that
additional block device. But we now also find the owning superblock for
additional block devices and call freeze_super() again which reports
-EBUSY.

This can be reproduced through xfstests via:

    mkfs.xfs -f -m crc=1,reflink=1,rmapbt=1, -i sparse=1 -lsize=1g,logdev=/dev/nvme1n1p4 /dev/nvme1n1p3
    mkfs.xfs -f -m crc=1,reflink=1,rmapbt=1, -i sparse=1 -lsize=1g,logdev=/dev/nvme1n1p6 /dev/nvme1n1p5

    FSTYP=xfs
    export TEST_DEV=/dev/nvme1n1p3
    export TEST_DIR=/mnt/test
    export TEST_LOGDEV=/dev/nvme1n1p4
    export SCRATCH_DEV=/dev/nvme1n1p5
    export SCRATCH_MNT=/mnt/scratch
    export SCRATCH_LOGDEV=/dev/nvme1n1p6
    export USE_EXTERNAL=yes

    sudo ./check generic/311

Current semantics allow two concurrent freezers: one initiated from
userspace via FREEZE_HOLDER_USERSPACE and one initiated from the kernel
via FREEZE_HOLDER_KERNEL. If there are multiple concurrent freeze
requests from either FREEZE_HOLDER_USERSPACE or FREEZE_HOLDER_KERNEL
-EBUSY is returned.

We need to preserve these semantics because as they are uapi via
FIFREEZE and FITHAW ioctl()s. IOW, freezes don't nest for FIFREEZE and
FITHAW. Other kernels consumers rely on non-nesting freezes as well.

With freezes initiated from the block layer freezes need to nest if the
same superblock is frozen via multiple devices. So we need to start
counting the number of freeze requests.

If FREEZE_HOLDER_BDEV is passed alongside FREEZE_HOLDER_KERNEL or
FREEZE_HOLDER_USERSPACE we allow the caller to nest freeze calls.

To accommodate the old semantics we split the freeze counter into two
counting kernel initiated and userspace initiated freezes separately. We
can then also stop recording FREEZE_HOLDER_* in struct sb_writers.

We also simplify freezing by making all concurrent freezers share a
single active superblock reference count instead of having separate
references for kernel and userspace. I don't see why we would need two
active reference counts. Neither FREEZE_HOLDER_KERNEL nor
FREEZE_HOLDER_USERSPACE can put the active reference as long as they are
concurrent freezers anwyay. That was already true before we allowed
nesting freezes.

Survives various fstests runs with different options including the
reproducer, online scrub, and online repair, fsfreze, and so on. Also
survives blktests.

Reported-by: Chandan Babu R <chandanbabu@kernel.org>
Link: https://lore.kernel.org/linux-block/87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64
Fixes: [1]: bfac4176f2c4 ("bdev: implement freeze and thaw holder operations") # no backport needed
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c         | 135 ++++++++++++++++++++++++++++++++++++++++++-----------
 include/linux/fs.h |  17 ++++++-
 2 files changed, 124 insertions(+), 28 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 2d32e60daef7..44273c553569 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1464,6 +1464,21 @@ static struct super_block *get_bdev_super(struct block_device *bdev)
 	return sb;
 }
 
+/**
+ * fs_bdev_freeze - freeze owning filesystem of block device
+ * @bdev: block device
+ *
+ * Freeze the filesystem that owns this block device if it is still
+ * active.
+ *
+ * A filesystem that owns multiple block devices may be frozen from each
+ * block device and won't be unfrozen until all block devices are
+ * unfrozen. Each block device can only freeze the filesystem once as we
+ * nest freezes for block devices in the block layer.
+ *
+ * Return: If the freeze was successful zero is returned. If the freeze
+ *         failed a negative error codeis returned.
+ */
 static int fs_bdev_freeze(struct block_device *bdev)
 {
 	struct super_block *sb;
@@ -1476,15 +1491,34 @@ static int fs_bdev_freeze(struct block_device *bdev)
 		return -EINVAL;
 
 	if (sb->s_op->freeze_super)
-		error = sb->s_op->freeze_super(sb, FREEZE_HOLDER_USERSPACE);
+		error = sb->s_op->freeze_super(sb,
+				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE);
 	else
-		error = freeze_super(sb, FREEZE_HOLDER_USERSPACE);
+		error = freeze_super(sb,
+				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE);
 	if (!error)
 		error = sync_blockdev(bdev);
 	deactivate_super(sb);
 	return error;
 }
 
+/**
+ * fs_bdev_thaw - thaw owning filesystem of block device
+ * @bdev: block device
+ *
+ * Thaw the filesystem that owns this block device.
+ *
+ * A filesystem that owns multiple block devices may be frozen from each
+ * block device and won't be unfrozen until all block devices are
+ * unfrozen. Each block device can only freeze the filesystem once as we
+ * nest freezes for block devices in the block layer.
+ *
+ * Return: If the thaw was successful zero is returned. If the thaw
+ *         failed a negative error code is returned. If this function
+ *         returns zero it doesn't mean that the filesystem is unfrozen
+ *         as it may have been frozen multiple times (kernel may hold a
+ *         freeze or might be frozen from other block devices).
+ */
 static int fs_bdev_thaw(struct block_device *bdev)
 {
 	struct super_block *sb;
@@ -1497,9 +1531,11 @@ static int fs_bdev_thaw(struct block_device *bdev)
 		return -EINVAL;
 
 	if (sb->s_op->thaw_super)
-		error = sb->s_op->thaw_super(sb, FREEZE_HOLDER_USERSPACE);
+		error = sb->s_op->thaw_super(sb,
+				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE);
 	else
-		error = thaw_super(sb, FREEZE_HOLDER_USERSPACE);
+		error = thaw_super(sb,
+				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE);
 	deactivate_super(sb);
 	return error;
 }
@@ -1911,6 +1947,47 @@ static int wait_for_partially_frozen(struct super_block *sb)
 	return ret;
 }
 
+#define FREEZE_HOLDERS (FREEZE_HOLDER_KERNEL | FREEZE_HOLDER_USERSPACE)
+#define FREEZE_FLAGS (FREEZE_HOLDERS | FREEZE_MAY_NEST)
+
+static inline int freeze_inc(struct super_block *sb, enum freeze_holder who)
+{
+	WARN_ON_ONCE((who & ~FREEZE_FLAGS));
+	WARN_ON_ONCE(hweight32(who & FREEZE_HOLDERS) > 1);
+
+	if (who & FREEZE_HOLDER_KERNEL)
+		++sb->s_writers.freeze_kcount;
+	if (who & FREEZE_HOLDER_USERSPACE)
+		++sb->s_writers.freeze_ucount;
+	return sb->s_writers.freeze_kcount + sb->s_writers.freeze_ucount;
+}
+
+static inline int freeze_dec(struct super_block *sb, enum freeze_holder who)
+{
+	WARN_ON_ONCE((who & ~FREEZE_FLAGS));
+	WARN_ON_ONCE(hweight32(who & FREEZE_HOLDERS) > 1);
+
+	if ((who & FREEZE_HOLDER_KERNEL) && sb->s_writers.freeze_kcount)
+		--sb->s_writers.freeze_kcount;
+	if ((who & FREEZE_HOLDER_USERSPACE) && sb->s_writers.freeze_ucount)
+		--sb->s_writers.freeze_ucount;
+	return sb->s_writers.freeze_kcount + sb->s_writers.freeze_ucount;
+}
+
+static inline bool may_freeze(struct super_block *sb, enum freeze_holder who)
+{
+	WARN_ON_ONCE((who & ~FREEZE_FLAGS));
+	WARN_ON_ONCE(hweight32(who & FREEZE_HOLDERS) > 1);
+
+	if (who & FREEZE_HOLDER_KERNEL)
+		return (who & FREEZE_MAY_NEST) ||
+		       sb->s_writers.freeze_kcount == 0;
+	if (who & FREEZE_HOLDER_USERSPACE)
+		return (who & FREEZE_MAY_NEST) ||
+		       sb->s_writers.freeze_ucount == 0;
+	return false;
+}
+
 /**
  * freeze_super - lock the filesystem and force it into a consistent state
  * @sb: the super to lock
@@ -1923,6 +2000,7 @@ static int wait_for_partially_frozen(struct super_block *sb)
  * @who should be:
  * * %FREEZE_HOLDER_USERSPACE if userspace wants to freeze the fs;
  * * %FREEZE_HOLDER_KERNEL if the kernel wants to freeze the fs.
+ * * %FREEZE_MAY_NEST whether nesting freeze and thaw requests is allowed.
  *
  * The @who argument distinguishes between the kernel and userspace trying to
  * freeze the filesystem.  Although there cannot be multiple kernel freezes or
@@ -1930,6 +2008,13 @@ static int wait_for_partially_frozen(struct super_block *sb)
  * userspace can both hold a filesystem frozen.  The filesystem remains frozen
  * until there are no kernel or userspace freezes in effect.
  *
+ * A filesystem may hold multiple devices and thus a filesystems may be
+ * frozen through the block layer via multiple block devices. In this
+ * case the request is marked as being allowed to nest passig
+ * FREEZE_MAY_NEST. The filesystem remains frozen until all block
+ * devices are unfrozen. If multiple freezes are attempted without
+ * FREEZE_MAY_NEST -EBUSY will be returned.
+ *
  * During this function, sb->s_writers.frozen goes through these values:
  *
  * SB_UNFROZEN: File system is normal, all writes progress as usual.
@@ -1967,19 +2052,16 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 
 retry:
 	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
-		if (sb->s_writers.freeze_holders & who) {
+		if (!may_freeze(sb, who)) {
 			deactivate_locked_super(sb);
 			return -EBUSY;
 		}
 
-		WARN_ON(sb->s_writers.freeze_holders == 0);
-
-		/*
-		 * Someone else already holds this type of freeze; share the
-		 * freeze and assign the active ref to the freeze.
-		 */
-		sb->s_writers.freeze_holders |= who;
-		super_unlock_excl(sb);
+		/* all freezers share a single active reference */
+		if (freeze_inc(sb, who) > 1)
+			deactivate_locked_super(sb);
+		else
+			super_unlock_excl(sb);
 		return 0;
 	}
 
@@ -1995,7 +2077,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 
 	if (sb_rdonly(sb)) {
 		/* Nothing to do really... */
-		sb->s_writers.freeze_holders |= who;
+		WARN_ON_ONCE(freeze_inc(sb, who) > 1);
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
 		wake_up_var(&sb->s_writers.frozen);
 		super_unlock_excl(sb);
@@ -2045,7 +2127,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	 * For debugging purposes so that fs can warn if it sees write activity
 	 * when frozen is set to SB_FREEZE_COMPLETE, and for thaw_super().
 	 */
-	sb->s_writers.freeze_holders |= who;
+	WARN_ON_ONCE(freeze_inc(sb, who) > 1);
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
 	wake_up_var(&sb->s_writers.frozen);
 	lockdep_sb_freeze_release(sb);
@@ -2066,21 +2148,15 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 
 	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE)
 		goto out_unlock;
-	if (!(sb->s_writers.freeze_holders & who))
-		goto out_unlock;
 
 	/*
-	 * Freeze is shared with someone else.  Release our hold and drop the
-	 * active ref that freeze_super assigned to the freezer.
+	 * All freezers share a single active reference.
+	 * So just unlock in case there are any left.
 	 */
-	error = 0;
-	if (sb->s_writers.freeze_holders & ~who) {
-		sb->s_writers.freeze_holders &= ~who;
-		goto out_deactivate;
-	}
+	if (freeze_dec(sb, who))
+		goto out_unlock;
 
 	if (sb_rdonly(sb)) {
-		sb->s_writers.freeze_holders &= ~who;
 		sb->s_writers.frozen = SB_UNFROZEN;
 		wake_up_var(&sb->s_writers.frozen);
 		goto out_deactivate;
@@ -2091,13 +2167,13 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 	if (sb->s_op->unfreeze_fs) {
 		error = sb->s_op->unfreeze_fs(sb);
 		if (error) {
-			printk(KERN_ERR "VFS:Filesystem thaw failed\n");
+			pr_err("VFS: Filesystem thaw failed\n");
+			freeze_inc(sb, who);
 			lockdep_sb_freeze_release(sb);
 			goto out_unlock;
 		}
 	}
 
-	sb->s_writers.freeze_holders &= ~who;
 	sb->s_writers.frozen = SB_UNFROZEN;
 	wake_up_var(&sb->s_writers.frozen);
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
@@ -2121,6 +2197,11 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
  * @who should be:
  * * %FREEZE_HOLDER_USERSPACE if userspace wants to thaw the fs;
  * * %FREEZE_HOLDER_KERNEL if the kernel wants to thaw the fs.
+ * * %FREEZE_MAY_NEST whether nesting freeze and thaw requests is allowed
+ *
+ * A filesystem may hold multiple devices and thus a filesystems may
+ * have been frozen through the block layer via multiple block devices.
+ * The filesystem remains frozen until all block devices are unfrozen.
  */
 int thaw_super(struct super_block *sb, enum freeze_holder who)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 63ff88d20e46..fef481b2b4bc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1185,7 +1185,8 @@ enum {
 
 struct sb_writers {
 	unsigned short			frozen;		/* Is sb frozen? */
-	unsigned short			freeze_holders;	/* Who froze fs? */
+	int				freeze_kcount;	/* How many kernel freeze requests? */
+	int				freeze_ucount;	/* How many userspace freeze requests? */
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };
 
@@ -2051,9 +2052,23 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 					struct file *dst_file, loff_t dst_pos,
 					loff_t len, unsigned int remap_flags);
 
+/**
+ * enum freeze_holder - holder of the freeze
+ * @FREEZE_HOLDER_KERNEL: kernel wants to freeze or thaw filesystem
+ * @FREEZE_HOLDER_USERSPACE: userspace wants to freeze or thaw filesystem
+ * @FREEZE_MAY_NEST: whether nesting freeze and thaw requests is allowed
+ *
+ * Indicate who the owner of the freeze or thaw request is and whether the
+ * freeze needs to be exclusive or can nest.
+ * Without @FREEZE_MAY_NEST, multiple freeze and thaw requests from the same
+ * holder aren't allowed. It is however allowed to hold a single
+ * @FREEZE_HOLDER_USERSPACE and a single @FREEZE_HOLDER_USERSPACE freeze at the
+ * same time. This is used by some filesystems during online repair or similar.
+ */
 enum freeze_holder {
 	FREEZE_HOLDER_KERNEL	= (1U << 0),
 	FREEZE_HOLDER_USERSPACE	= (1U << 1),
+	FREEZE_MAY_NEST		= (1U << 2),
 };
 
 struct super_operations {

-- 
2.34.1


