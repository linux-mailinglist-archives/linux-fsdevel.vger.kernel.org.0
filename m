Return-Path: <linux-fsdevel+bounces-1921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DA17E0418
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 14:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC45CB213ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 13:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE26D18641;
	Fri,  3 Nov 2023 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/3Uc3DN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F59E1862F
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 13:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABF0C433C8;
	Fri,  3 Nov 2023 13:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699019820;
	bh=yvuza+2bP4DrbVcAv4MEGOWj+9XcTxtAE8BJuDrJa+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/3Uc3DN2Xug6ubYkO9tDTut8zhMqKGhKPEzh7r6UwgHjC/EWGzYBNuzdmYQ9hjXR
	 KWGJaB8G04kYiREXGQJ7AWGwt2aT4piFhO2DSJKaJDZoSWMeDKGTTtdw5MJJM7aBUD
	 3R35fR83O1ycGPd8Mr9+0LFl/o7rUhTpseCrWEqQYWCkdwsaZu2tH3r1UbB/5gwXPh
	 FA1/4Zx0dEwlr+vQ4LhCeqGdo4bvAs9JWwF1eZzcIsuG464ISgXzqhoGlgh6DLujXb
	 6zX3SQMgRin6q2tN9YcGlVY8nAh8nRKv6BwsLDiYyi5XlsBpBSEFJwRIRvoytJ1yKG
	 PU/iO34v6E3cA==
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <dchinner@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>
Subject: [PATCH] fs: handle freezing from multiple devices
Date: Fri,  3 Nov 2023 14:52:27 +0100
Message-Id: <20231103-vfs-multi-device-freeze-v1-1-fe922b30bfb6@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=9359; i=brauner@kernel.org; h=from:subject:message-id; bh=yvuza+2bP4DrbVcAv4MEGOWj+9XcTxtAE8BJuDrJa+A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS6/Bbd/eKbT73D7m0HeI51KMmLmNV+ePf4eGVgswpb2okf be9COkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSeoDhf7mScuFp+1i/5fb6J1fUtz qvMnjxa+mslqD6jW8WiS10Zmf4Z6D7UEvBQvrILKYjbN8Oi+xTVb1SXadaMuHvllKTaZf/swAA
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

Fix this by counting the number of block devices that requested the
filesystem to be frozen in @bdev_count in struct sb_writers and only
unfreeze once the @bdev_count hits zero. Survives fstests and blktests
and makes the reproducer succeed.

Reported-by: Chandan Babu R <chandanbabu@kernel.org>
Link: https://lore.kernel.org/linux-block/87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64
Fixes: [1]: bfac4176f2c4 ("bdev: implement freeze and thaw holder operations") # no backport needed
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c         | 55 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/fs.h |  2 ++
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 176c55abd9de..c51eb669ed0b 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1476,9 +1476,11 @@ static int fs_bdev_freeze(struct block_device *bdev)
 		return -EINVAL;
 
 	if (sb->s_op->freeze_super)
-		error = sb->s_op->freeze_super(sb, FREEZE_HOLDER_USERSPACE);
+		error = sb->s_op->freeze_super(sb,
+				FREEZE_HOLDER_BDEV | FREEZE_HOLDER_USERSPACE);
 	else
-		error = freeze_super(sb, FREEZE_HOLDER_USERSPACE);
+		error = freeze_super(sb,
+				FREEZE_HOLDER_BDEV | FREEZE_HOLDER_USERSPACE);
 	if (!error)
 		error = sync_blockdev(bdev);
 	deactivate_super(sb);
@@ -1497,9 +1499,11 @@ static int fs_bdev_thaw(struct block_device *bdev)
 		return -EINVAL;
 
 	if (sb->s_op->thaw_super)
-		error = sb->s_op->thaw_super(sb, FREEZE_HOLDER_USERSPACE);
+		error = sb->s_op->thaw_super(sb,
+				FREEZE_HOLDER_BDEV | FREEZE_HOLDER_USERSPACE);
 	else
-		error = thaw_super(sb, FREEZE_HOLDER_USERSPACE);
+		error = thaw_super(sb,
+				FREEZE_HOLDER_BDEV | FREEZE_HOLDER_USERSPACE);
 	deactivate_super(sb);
 	return error;
 }
@@ -1923,6 +1927,7 @@ static int wait_for_partially_frozen(struct super_block *sb)
  * @who should be:
  * * %FREEZE_HOLDER_USERSPACE if userspace wants to freeze the fs;
  * * %FREEZE_HOLDER_KERNEL if the kernel wants to freeze the fs.
+ * * %FREEZE_HOLDER_BDEV if freeze originated from a block device.
  *
  * The @who argument distinguishes between the kernel and userspace trying to
  * freeze the filesystem.  Although there cannot be multiple kernel freezes or
@@ -1930,6 +1935,12 @@ static int wait_for_partially_frozen(struct super_block *sb)
  * userspace can both hold a filesystem frozen.  The filesystem remains frozen
  * until there are no kernel or userspace freezes in effect.
  *
+ * A filesystem may hold multiple devices and thus a filesystems may be
+ * frozen through the block layer via multiple block devices. In this
+ * case the request is as originating from the block layer by raising
+ * %FREEZE_HOLDER_BDEV. We count the number of block devices that
+ * requested a freeze in @bdev_count.
+ *
  * During this function, sb->s_writers.frozen goes through these values:
  *
  * SB_UNFROZEN: File system is normal, all writes progress as usual.
@@ -1958,18 +1969,29 @@ static int wait_for_partially_frozen(struct super_block *sb)
 int freeze_super(struct super_block *sb, enum freeze_holder who)
 {
 	int ret;
+	bool bdev_initiated;
 
 	if (!super_lock_excl(sb)) {
 		WARN_ON_ONCE("Dying superblock while freezing!");
 		return -EINVAL;
 	}
 	atomic_inc(&sb->s_active);
+	bdev_initiated = (who & FREEZE_HOLDER_BDEV);
+	who &= ~FREEZE_HOLDER_BDEV;
 
 retry:
 	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
+		ret = -EBUSY;
+
+		if (bdev_initiated) {
+			sb->s_writers.bdev_count++;
+			pr_info("VFS: Freeze initiated from %d block devices\n", sb->s_writers.bdev_count);
+			ret = 0;
+		}
+
 		if (sb->s_writers.freeze_holders & who) {
 			deactivate_locked_super(sb);
-			return -EBUSY;
+			return ret;
 		}
 
 		WARN_ON(sb->s_writers.freeze_holders == 0);
@@ -2002,6 +2024,8 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 		/* Nothing to do really... */
 		sb->s_writers.freeze_holders |= who;
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
+		if (bdev_initiated)
+			sb->s_writers.bdev_count++;
 		wake_up_var(&sb->s_writers.frozen);
 		super_unlock_excl(sb);
 		return 0;
@@ -2052,6 +2076,8 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	 */
 	sb->s_writers.freeze_holders |= who;
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
+	if (bdev_initiated)
+		sb->s_writers.bdev_count++;
 	wake_up_var(&sb->s_writers.frozen);
 	lockdep_sb_freeze_release(sb);
 	super_unlock_excl(sb);
@@ -2068,12 +2094,22 @@ EXPORT_SYMBOL(freeze_super);
 static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 {
 	int error = -EINVAL;
+	bool bdev_initiated = (who & FREEZE_HOLDER_BDEV);
+	who &= ~FREEZE_HOLDER_BDEV;
 
 	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE)
 		goto out_unlock;
 	if (!(sb->s_writers.freeze_holders & who))
 		goto out_unlock;
 
+	if (bdev_initiated)
+		sb->s_writers.bdev_count--;
+	if (sb->s_writers.bdev_count) {
+		pr_info("VFS: Filesystems held frozen by %d block devices\n", sb->s_writers.bdev_count);
+		error = 0;
+		goto out_unlock;
+	}
+
 	/*
 	 * Freeze is shared with someone else.  Release our hold and drop the
 	 * active ref that freeze_super assigned to the freezer.
@@ -2098,6 +2134,8 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 		if (error) {
 			printk(KERN_ERR "VFS:Filesystem thaw failed\n");
 			lockdep_sb_freeze_release(sb);
+			if (bdev_initiated)
+				sb->s_writers.bdev_count++;
 			goto out_unlock;
 		}
 	}
@@ -2126,6 +2164,13 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
  * @who should be:
  * * %FREEZE_HOLDER_USERSPACE if userspace wants to thaw the fs;
  * * %FREEZE_HOLDER_KERNEL if the kernel wants to thaw the fs.
+ * * %FREEZE_HOLDER_BDEV if freeze originated from a block device.
+ *
+ * A filesystem may hold multiple devices and thus a filesystems may
+ * have been frozen through the block layer via multiple block devices.
+ * In this case the number of block devices that requested the
+ * filesystem to be frozen is stored in @bdev_count. We only unfreeze if
+ * @bdev_count is zero
  */
 int thaw_super(struct super_block *sb, enum freeze_holder who)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 63ff88d20e46..dda7942e1f3e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1186,6 +1186,7 @@ enum {
 struct sb_writers {
 	unsigned short			frozen;		/* Is sb frozen? */
 	unsigned short			freeze_holders;	/* Who froze fs? */
+	int				bdev_count;	/* How many devices froze it? */
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };
 
@@ -2054,6 +2055,7 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 enum freeze_holder {
 	FREEZE_HOLDER_KERNEL	= (1U << 0),
 	FREEZE_HOLDER_USERSPACE	= (1U << 1),
+	FREEZE_HOLDER_BDEV	= (1U << 2),
 };
 
 struct super_operations {

---
base-commit: c6a4738de282fc95752e1f1c5573ab7b4020b55e
change-id: 20231103-vfs-multi-device-freeze-506e2c010473


