Return-Path: <linux-fsdevel+bounces-1908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8E77DFFC6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 09:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04B23B213C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B126FB5;
	Fri,  3 Nov 2023 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srOSwTMc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358A4187D
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 08:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EE4C433C9;
	Fri,  3 Nov 2023 08:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699000558;
	bh=bL3/XR0afbcOcBlFvRELYzuinqi5DuIrCTttoQfkQTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=srOSwTMchEyswcXZbZFADfX+zKTF0hyn8QDqaxrfaPD/+WcyntiKLEuyt/TAtRjGU
	 iLjngPQQIzbnVXA/BCGQ667f2791VWrrz+F9qGgn4dQNZu9YeShjZ3duNIvUCU0L0Y
	 cAXHRfaomEC11pMUf6aRoqgmw5Kb+diTl8GvLmKaU+xU7zF1+xrfDLdBQU7gXKBapj
	 aDL2ujI9XsjyGjtbrDXNycezH5QyVho4wdGmpdxHSlRDT1eVGC051TSEp3ud94YwN0
	 7lKNqoiZtpGkHmPQO4iIOCzUCe6OhiSqoWMig8bqTHZ4xcg+/aRGTn6xNCE+4opTqT
	 amF3e1BGfCr3A==
Date: Fri, 3 Nov 2023 09:35:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandanbabu@kernel.org>, Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>, viro@zeniv.linux.org.uk,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	dchinner@fromorbit.com
Subject: Re: [BUG REPORT] next-20231102: generic/311 fails on XFS with
 external log
Message-ID: <20231103-igelstachel-signal-2503859a730a@brauner>
References: <87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20231102-teich-absender-47a27e86e78f@brauner>
 <20231103081405.GC16854@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231103081405.GC16854@lst.de>

On Fri, Nov 03, 2023 at 09:14:05AM +0100, Christoph Hellwig wrote:
> On Thu, Nov 02, 2023 at 03:54:48PM +0100, Christian Brauner wrote:
> > So you'll see EBUSY because the superblock was already frozen when the
> > main block device was frozen. I was somewhat expecting that we may run
> > into such issues.
> > 
> > I think we just need to figure out what we want to do in cases the
> > superblock is frozen via multiple devices. It would probably be correct
> > to keep it frozen as long as any of the devices is frozen?
> 
> As dave pointed out I think we need to bring back / keep the freeze
> count.

The freeze count never want away. IOW, for each block device we still
have bd_fsfreeze_count otherwise we couldn't nest per-block device. What
we need is a freeze counter in sb_writers so we can nest superblock
freezes. IOW, we need to count the number of block devices that
requested/caused the superblock to be frozen. I think we're all in
agreement though. All of our suggestions should be the same.
I'm currently testing:

From c1849037227e5801f0b5e8acfa05aa5d90f4c9e4 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 3 Nov 2023 08:38:49 +0100
Subject: [PATCH] [DRAFT] fs: handle freezing from multiple devices

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c         | 44 +++++++++++++++++++++++++++++++++++++++-----
 include/linux/fs.h |  2 ++
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 176c55abd9de..882c79366c70 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1476,9 +1476,11 @@ static int fs_bdev_freeze(struct block_device *bdev)
 		return -EINVAL;
 
 	if (sb->s_op->freeze_super)
-		error = sb->s_op->freeze_super(sb, FREEZE_HOLDER_USERSPACE);
+		error = sb->s_op->freeze_super(sb,
+				FREEZE_HOLDER_BLOCK | FREEZE_HOLDER_USERSPACE);
 	else
-		error = freeze_super(sb, FREEZE_HOLDER_USERSPACE);
+		error = freeze_super(sb,
+				FREEZE_HOLDER_BLOCK | FREEZE_HOLDER_USERSPACE);
 	if (!error)
 		error = sync_blockdev(bdev);
 	deactivate_super(sb);
@@ -1497,9 +1499,11 @@ static int fs_bdev_thaw(struct block_device *bdev)
 		return -EINVAL;
 
 	if (sb->s_op->thaw_super)
-		error = sb->s_op->thaw_super(sb, FREEZE_HOLDER_USERSPACE);
+		error = sb->s_op->thaw_super(sb,
+				FREEZE_HOLDER_BLOCK | FREEZE_HOLDER_USERSPACE);
 	else
-		error = thaw_super(sb, FREEZE_HOLDER_USERSPACE);
+		error = thaw_super(sb,
+				FREEZE_HOLDER_BLOCK | FREEZE_HOLDER_USERSPACE);
 	deactivate_super(sb);
 	return error;
 }
@@ -1923,6 +1927,7 @@ static int wait_for_partially_frozen(struct super_block *sb)
  * @who should be:
  * * %FREEZE_HOLDER_USERSPACE if userspace wants to freeze the fs;
  * * %FREEZE_HOLDER_KERNEL if the kernel wants to freeze the fs.
+ * * %FREEZE_HOLDER_BLOCK if freeze originated from the block layer.
  *
  * The @who argument distinguishes between the kernel and userspace trying to
  * freeze the filesystem.  Although there cannot be multiple kernel freezes or
@@ -1958,18 +1963,33 @@ static int wait_for_partially_frozen(struct super_block *sb)
 int freeze_super(struct super_block *sb, enum freeze_holder who)
 {
 	int ret;
+	bool bdev_initiated;
 
 	if (!super_lock_excl(sb)) {
 		WARN_ON_ONCE("Dying superblock while freezing!");
 		return -EINVAL;
 	}
 	atomic_inc(&sb->s_active);
+	bdev_initiated = (who & FREEZE_HOLDER_BLOCK);
+	who &= ~FREEZE_HOLDER_BLOCK;
 
 retry:
 	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
+		ret = -EBUSY;
+
+		/*
+		 * This is a freeze request from another block device
+		 * associated with the same superblock.
+		 */
+		if (bdev_initiated) {
+			sb->s_writers.bdev_count++;
+			pr_info("Freeze initiated from %d block devices\n", sb->s_writers.bdev_count);
+			ret = 0;
+		}
+
 		if (sb->s_writers.freeze_holders & who) {
 			deactivate_locked_super(sb);
-			return -EBUSY;
+			return ret;
 		}
 
 		WARN_ON(sb->s_writers.freeze_holders == 0);
@@ -2002,6 +2022,8 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 		/* Nothing to do really... */
 		sb->s_writers.freeze_holders |= who;
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
+		if (bdev_initiated)
+			sb->s_writers.bdev_count++;
 		wake_up_var(&sb->s_writers.frozen);
 		super_unlock_excl(sb);
 		return 0;
@@ -2052,6 +2074,8 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	 */
 	sb->s_writers.freeze_holders |= who;
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
+	if (bdev_initiated)
+		sb->s_writers.bdev_count++;
 	wake_up_var(&sb->s_writers.frozen);
 	lockdep_sb_freeze_release(sb);
 	super_unlock_excl(sb);
@@ -2068,12 +2092,22 @@ EXPORT_SYMBOL(freeze_super);
 static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 {
 	int error = -EINVAL;
+	bool bdev_initiated = (who & FREEZE_HOLDER_BLOCK);
+	who &= ~FREEZE_HOLDER_BLOCK;
 
 	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE)
 		goto out_unlock;
 	if (!(sb->s_writers.freeze_holders & who))
 		goto out_unlock;
 
+	if (bdev_initiated)
+		sb->s_writers.bdev_count--;
+	if (sb->s_writers.bdev_count) {
+		pr_info("Filesystems held frozen by %d block devices\n", sb->s_writers.bdev_count);
+		error = 0;
+		goto out_unlock;
+	}
+
 	/*
 	 * Freeze is shared with someone else.  Release our hold and drop the
 	 * active ref that freeze_super assigned to the freezer.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 63ff88d20e46..edc9c071c199 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1186,6 +1186,7 @@ enum {
 struct sb_writers {
 	unsigned short			frozen;		/* Is sb frozen? */
 	unsigned short			freeze_holders;	/* Who froze fs? */
+	int				bdev_count;
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };
 
@@ -2054,6 +2055,7 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 enum freeze_holder {
 	FREEZE_HOLDER_KERNEL	= (1U << 0),
 	FREEZE_HOLDER_USERSPACE	= (1U << 1),
+	FREEZE_HOLDER_BLOCK	= (1U << 2),
 };
 
 struct super_operations {
-- 
2.34.1


