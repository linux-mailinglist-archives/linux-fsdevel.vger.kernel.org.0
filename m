Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0FF3BE4D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 10:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhGGI7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 04:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhGGI7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 04:59:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCB7C061574;
        Wed,  7 Jul 2021 01:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=MWrityohNuEWkJE2rGPEDtPEPbcWb3iMvUvhJ/UoPDM=; b=Svm8P0TWiGRuGyDIL1qa99qXCj
        gVcHUNRLON+iHulZ0p/rd1ca/w1dTJ+8quUR/8TLYeGG2jl3y0nBgeJQfBxbpUJ23rra8koK/yC1u
        ne9D1qGbp2/OzC9cmh9nA+A00/Ru1+ttdSGAQd54RjeYMf/JmujWVTFQI7W2IN/yqNjAuhp8AAEji
        CyVsDlAVEEoVtPgo6YNf+bL7ecPda1Ml/Noc+83fvC3Q49TQP5D0DsQxvBbC6xxw6HpC1VR/auYf2
        E7KC9Fesz9VmplPIgF9IcbGPv9NKEq7KAhfxHteOIAPOnwiBDF0OOY/YOKNiLfn/s/CaCZNQf55FK
        ivUyVpQQ==;
Received: from p4fdb05cb.dip0.t-ipconnect.de ([79.219.5.203] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m13MO-00CEHi-Kb; Wed, 07 Jul 2021 08:56:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tytso@mit.edu, leah.rumancik@gmail.com
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH] ext4: fix EXT4_IOC_CHECKPOINT
Date:   Wed,  7 Jul 2021 10:56:44 +0200
Message-Id: <20210707085644.3041867-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Issuing a discard for any kind of "contention deletion SLO" is highly
dangerous as discard as defined by Linux (as well the underlying NVMe,
SCSI, ATA, eMMC and virtio primitivies) are defined to not guarantee
erasing of data but just allow optional and nondeterministic reclamation
of space.  Instead issuing write zeroes is the only think to perform
such an operation.  Remove the highly dangerous and misleading discard
mode for EXT4_IOC_CHECKPOINT and only support the write zeroes based
on, and clean up the resulting mess including the dry run mode.

This is an ABI change and must go into Linus' tree before 5.14 is
released or the offending commits need to be reverted.

Fixes: 351a0a3fbc35 ("ext4: add ioctl EXT4_IOC_CHECKPOINT")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/ext4/journal.rst | 17 +++-----
 fs/ext4/ext4.h                             |  7 +---
 fs/ext4/ioctl.c                            | 26 ++----------
 fs/jbd2/journal.c                          | 47 +++++-----------------
 include/linux/jbd2.h                       |  6 +--
 5 files changed, 22 insertions(+), 81 deletions(-)

diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
index 5fad38860f17..d18b18f9e053 100644
--- a/Documentation/filesystems/ext4/journal.rst
+++ b/Documentation/filesystems/ext4/journal.rst
@@ -742,15 +742,8 @@ the filesystem including journal recovery, filesystem resizing, and freeing of
 the journal_t structure.
 
 A journal checkpoint can be triggered from userspace via the ioctl
-EXT4_IOC_CHECKPOINT. This ioctl takes a single, u64 argument for flags.
-Currently, three flags are supported. First, EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN
-can be used to verify input to the ioctl. It returns error if there is any
-invalid input, otherwise it returns success without performing
-any checkpointing. This can be used to check whether the ioctl exists on a
-system and to verify there are no issues with arguments or flags. The
-other two flags are EXT4_IOC_CHECKPOINT_FLAG_DISCARD and
-EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT. These flags cause the journal blocks to be
-discarded or zero-filled, respectively, after the journal checkpoint is
-complete. EXT4_IOC_CHECKPOINT_FLAG_DISCARD and EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT
-cannot both be set. The ioctl may be useful when snapshotting a system or for
-complying with content deletion SLOs.
+EXT4_IOC_CHECKPOINT. This ioctl takes a u64 argument for flags.
+The only supported flags is EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT. This flag cause
+the journal blocks to be zero-filled after the journal checkpoint is complete.
+The ioctl may be useful when snapshotting a system or for complying with
+content deletion SLOs.
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3c51e243450d..c2650b31bed2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -743,12 +743,7 @@ enum {
 #define EXT4_STATE_FLAG_DA_ALLOC_CLOSE	0x00000008
 
 /* flags for ioctl EXT4_IOC_CHECKPOINT */
-#define EXT4_IOC_CHECKPOINT_FLAG_DISCARD	0x1
-#define EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT	0x2
-#define EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN	0x4
-#define EXT4_IOC_CHECKPOINT_FLAG_VALID		(EXT4_IOC_CHECKPOINT_FLAG_DISCARD | \
-						EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT | \
-						EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
+#define EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT	0x1
 
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /*
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index e27f34bceb8d..981670303733 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -798,42 +798,24 @@ static int ext4_ioctl_checkpoint(struct file *filp, unsigned long arg)
 	__u32 flags = 0;
 	unsigned int flush_flags = 0;
 	struct super_block *sb = file_inode(filp)->i_sb;
-	struct request_queue *q;
 
-	if (copy_from_user(&flags, (__u32 __user *)arg,
-				sizeof(__u32)))
+	if (copy_from_user(&flags, (__u32 __user *)arg, sizeof(__u32)))
 		return -EFAULT;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	/* check for invalid bits set */
-	if ((flags & ~EXT4_IOC_CHECKPOINT_FLAG_VALID) ||
-				((flags & JBD2_JOURNAL_FLUSH_DISCARD) &&
-				(flags & JBD2_JOURNAL_FLUSH_ZEROOUT)))
+	if (flags & ~EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT)
 		return -EINVAL;
 
 	if (!EXT4_SB(sb)->s_journal)
 		return -ENODEV;
 
-	if (flags & ~JBD2_JOURNAL_FLUSH_VALID)
-		return -EINVAL;
-
-	q = bdev_get_queue(EXT4_SB(sb)->s_journal->j_dev);
-	if (!q)
-		return -ENXIO;
-	if ((flags & JBD2_JOURNAL_FLUSH_DISCARD) && !blk_queue_discard(q))
-		return -EOPNOTSUPP;
-
-	if (flags & EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
-		return 0;
-
-	if (flags & EXT4_IOC_CHECKPOINT_FLAG_DISCARD)
-		flush_flags |= JBD2_JOURNAL_FLUSH_DISCARD;
-
 	if (flags & EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT) {
 		flush_flags |= JBD2_JOURNAL_FLUSH_ZEROOUT;
-		pr_info_ratelimited("warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow");
+		if (!bdev_write_zeroes_sectors(EXT4_SB(sb)->s_journal->j_dev))
+			pr_info_ratelimited("warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow");
 	}
 
 	jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 152880c298ca..3256d8528c43 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1685,34 +1685,16 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 /**
  * __jbd2_journal_erase() - Discard or zeroout journal blocks (excluding superblock)
  * @journal: The journal to erase.
- * @flags: A discard/zeroout request is sent for each physically contigous
- *	region of the journal. Either JBD2_JOURNAL_FLUSH_DISCARD or
- *	JBD2_JOURNAL_FLUSH_ZEROOUT must be set to determine which operation
- *	to perform.
- *
- * Note: JBD2_JOURNAL_FLUSH_ZEROOUT attempts to use hardware offload. Zeroes
- * will be explicitly written if no hardware offload is available, see
- * blkdev_issue_zeroout for more details.
+ *
+ * Note: Attempts to use hardware offload. Zeroes will be explicitly written if
+ * no hardware offload is available, see blkdev_issue_zeroout for more details.
  */
-static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
+static int __jbd2_journal_erase(journal_t *journal)
 {
 	int err = 0;
 	unsigned long block, log_offset; /* logical */
 	unsigned long long phys_block, block_start, block_stop; /* physical */
 	loff_t byte_start, byte_stop, byte_count;
-	struct request_queue *q = bdev_get_queue(journal->j_dev);
-
-	/* flags must be set to either discard or zeroout */
-	if ((flags & ~JBD2_JOURNAL_FLUSH_VALID) || !flags ||
-			((flags & JBD2_JOURNAL_FLUSH_DISCARD) &&
-			(flags & JBD2_JOURNAL_FLUSH_ZEROOUT)))
-		return -EINVAL;
-
-	if (!q)
-		return -ENXIO;
-
-	if ((flags & JBD2_JOURNAL_FLUSH_DISCARD) && !blk_queue_discard(q))
-		return -EOPNOTSUPP;
 
 	/*
 	 * lookup block mapping and issue discard/zeroout for each
@@ -1762,18 +1744,10 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
 		truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
 				byte_start, byte_stop);
 
-		if (flags & JBD2_JOURNAL_FLUSH_DISCARD) {
-			err = blkdev_issue_discard(journal->j_dev,
-					byte_start >> SECTOR_SHIFT,
-					byte_count >> SECTOR_SHIFT,
-					GFP_NOFS, 0);
-		} else if (flags & JBD2_JOURNAL_FLUSH_ZEROOUT) {
-			err = blkdev_issue_zeroout(journal->j_dev,
-					byte_start >> SECTOR_SHIFT,
-					byte_count >> SECTOR_SHIFT,
-					GFP_NOFS, 0);
-		}
-
+		err = blkdev_issue_zeroout(journal->j_dev,
+				byte_start >> SECTOR_SHIFT,
+				byte_count >> SECTOR_SHIFT,
+				GFP_NOFS, 0);
 		if (unlikely(err != 0)) {
 			pr_err("JBD2: (error %d) unable to wipe journal at physical blocks %llu - %llu",
 					err, block_start, block_stop);
@@ -2453,7 +2427,6 @@ EXPORT_SYMBOL(jbd2_journal_clear_features);
  * can be issued on the journal blocks after flushing.
  *
  * flags:
- *	JBD2_JOURNAL_FLUSH_DISCARD: issues discards for the journal blocks
  *	JBD2_JOURNAL_FLUSH_ZEROOUT: issues zeroouts for the journal blocks
  */
 int jbd2_journal_flush(journal_t *journal, unsigned int flags)
@@ -2511,8 +2484,8 @@ int jbd2_journal_flush(journal_t *journal, unsigned int flags)
 	 * s_start value. */
 	jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
 
-	if (flags)
-		err = __jbd2_journal_erase(journal, flags);
+	if (flags & JBD2_JOURNAL_FLUSH_ZEROOUT)
+		err = __jbd2_journal_erase(journal);
 
 	mutex_unlock(&journal->j_checkpoint_mutex);
 	write_lock(&journal->j_state_lock);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 6cc035321562..ad7f2defbc8f 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1398,10 +1398,8 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 						 * mode */
 #define JBD2_FAST_COMMIT_ONGOING	0x100	/* Fast commit is ongoing */
 #define JBD2_FULL_COMMIT_ONGOING	0x200	/* Full commit is ongoing */
-#define JBD2_JOURNAL_FLUSH_DISCARD	0x0001
-#define JBD2_JOURNAL_FLUSH_ZEROOUT	0x0002
-#define JBD2_JOURNAL_FLUSH_VALID	(JBD2_JOURNAL_FLUSH_DISCARD | \
-					JBD2_JOURNAL_FLUSH_ZEROOUT)
+
+#define JBD2_JOURNAL_FLUSH_ZEROOUT	0x0001	/* Zero log on flush */
 
 /*
  * Journal atomic flag definitions
-- 
2.30.2

