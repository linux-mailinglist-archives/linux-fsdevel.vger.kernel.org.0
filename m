Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038B9778CFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbjHKLGC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbjHKLF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:05:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF205E7E;
        Fri, 11 Aug 2023 04:05:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 558B021884;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691751906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jPDL8S5E7i1Eyoriyi+xCezTUA1Nt/Q3b4fRs4u5nkY=;
        b=ZacPhhT6q/yV8O9xfs5gyaZRkOHmHs/q2Yb4c/OgwJ4yTQvmEbmmIFgXG6s5AUhs/bSxbR
        2n3zt1F5T5UmfNJiWLmjVEHEk7P/YNYovi8ymHAU0hspF2KIt036wt/Hhos05kzaHBsloM
        bBXZN2Dp9mm+64YaeWjGvtERVfy6XGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691751906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jPDL8S5E7i1Eyoriyi+xCezTUA1Nt/Q3b4fRs4u5nkY=;
        b=QwIuQOSu0jYEOp71/cXZvALrALH3eQ7wrclegCY1hsA1lmhBPduAHq2pc2GYFCgwk5GXc9
        oH41iA3uAgnzAwAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4217F139F3;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RoohEOIV1mRoRQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 11 Aug 2023 11:05:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 40013A0796; Fri, 11 Aug 2023 13:05:05 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>
Subject: [PATCH 22/29] ext4: Convert to bdev_open_by_dev()
Date:   Fri, 11 Aug 2023 13:04:53 +0200
Message-Id: <20230811110504.27514-22-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810171429.31759-1-jack@suse.cz>
References: <20230810171429.31759-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5676; i=jack@suse.cz; h=from:subject; bh=6VV0kOL4N1DPbCqEFzk2LwPWsXQAZ3Zpi1Z2jbd1UlY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk1hXW7NVocQ0eWk9OwEnUYYJ3hSdaSlQd9eJxRGFf MeB2ZAWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZNYV1gAKCRCcnaoHP2RA2U/0B/ 9lt/Z4heyidLepEtKMNLbuDDDMNqrdNgjO+urt023ZxGt673zYdPE5UNTFpeQU/t98d+5xtgEQ2Fmg SflNarU364Mrqc/cLFZrxXznX1F7Egu0sJOP8CtECO9hUGuL8AR/Jm17e6sWGPQk4CjoqgEErikWsu ccbPHhQrcD23bNKG2mA25OrasITuA5bJpxDoqhGoufFpSOPxSHDB2Nb7fmzYVdSWQ4ChAqWP0rOZqc nDZGoVZPMEqNwGDq6ZQaHFU0iF/avy/vZztlq5ybQV+jK6/0uMVnqWJA4YGE/FsmkbxXfaY5Gs7v07 u0LqykNobh+o5CuBH09oyY37l1afaJ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert ext4 to use bdev_open_by_dev() and pass the handle around.

CC: <linux-ext4@vger.kernel.org>
CC: Ted Tso <tytso@mit.edu>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h  |  2 +-
 fs/ext4/fsmap.c |  9 +++++----
 fs/ext4/super.c | 40 ++++++++++++++++++++--------------------
 3 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1e2259d9967d..6856e80abf70 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1541,7 +1541,7 @@ struct ext4_sb_info {
 	unsigned long s_commit_interval;
 	u32 s_max_batch_time;
 	u32 s_min_batch_time;
-	struct block_device *s_journal_bdev;
+	struct bdev_handle *s_journal_bdev_handle;
 #ifdef CONFIG_QUOTA
 	/* Names of quota files with journalled quota */
 	char __rcu *s_qf_names[EXT4_MAXQUOTAS];
diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index cdf9bfe10137..11e6f33677a2 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -576,8 +576,9 @@ static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
 	if (fm->fmr_device == 0 || fm->fmr_device == UINT_MAX ||
 	    fm->fmr_device == new_encode_dev(sb->s_bdev->bd_dev))
 		return true;
-	if (EXT4_SB(sb)->s_journal_bdev &&
-	    fm->fmr_device == new_encode_dev(EXT4_SB(sb)->s_journal_bdev->bd_dev))
+	if (EXT4_SB(sb)->s_journal_bdev_handle &&
+	    fm->fmr_device ==
+	    new_encode_dev(EXT4_SB(sb)->s_journal_bdev_handle->bdev->bd_dev))
 		return true;
 	return false;
 }
@@ -647,9 +648,9 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
 	memset(handlers, 0, sizeof(handlers));
 	handlers[0].gfd_dev = new_encode_dev(sb->s_bdev->bd_dev);
 	handlers[0].gfd_fn = ext4_getfsmap_datadev;
-	if (EXT4_SB(sb)->s_journal_bdev) {
+	if (EXT4_SB(sb)->s_journal_bdev_handle) {
 		handlers[1].gfd_dev = new_encode_dev(
-				EXT4_SB(sb)->s_journal_bdev->bd_dev);
+			EXT4_SB(sb)->s_journal_bdev_handle->bdev->bd_dev);
 		handlers[1].gfd_fn = ext4_getfsmap_logdev;
 	}
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 45fd5372bf8a..9ca3665e1b92 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1099,20 +1099,20 @@ void ext4_update_dynamic_rev(struct super_block *sb)
 /*
  * Open the external journal device
  */
-static struct block_device *ext4_blkdev_get(dev_t dev, struct super_block *sb)
+static struct bdev_handle *ext4_blkdev_get(dev_t dev, struct super_block *sb)
 {
-	struct block_device *bdev;
+	struct bdev_handle *handle;
 
-	bdev = blkdev_get_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE, sb,
-				 &fs_holder_ops);
-	if (IS_ERR(bdev))
+	handle = bdev_open_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE, sb,
+				  &fs_holder_ops);
+	if (IS_ERR(handle))
 		goto fail;
-	return bdev;
+	return handle;
 
 fail:
 	ext4_msg(sb, KERN_ERR,
 		 "failed to open journal device unknown-block(%u,%u) %ld",
-		 MAJOR(dev), MINOR(dev), PTR_ERR(bdev));
+		 MAJOR(dev), MINOR(dev), PTR_ERR(handle));
 	return NULL;
 }
 
@@ -1121,17 +1121,15 @@ static struct block_device *ext4_blkdev_get(dev_t dev, struct super_block *sb)
  */
 static void ext4_blkdev_remove(struct ext4_sb_info *sbi)
 {
-	struct block_device *bdev;
-	bdev = sbi->s_journal_bdev;
-	if (bdev) {
+	if (sbi->s_journal_bdev_handle) {
 		/*
 		 * Invalidate the journal device's buffers.  We don't want them
 		 * floating about in memory - the physical journal device may
 		 * hotswapped, and it breaks the `ro-after' testing code.
 		 */
-		invalidate_bdev(bdev);
-		blkdev_put(bdev, sbi->s_sb);
-		sbi->s_journal_bdev = NULL;
+		invalidate_bdev(sbi->s_journal_bdev_handle->bdev);
+		bdev_release(sbi->s_journal_bdev_handle);
+		sbi->s_journal_bdev_handle = NULL;
 	}
 }
 
@@ -1329,8 +1327,8 @@ static void ext4_put_super(struct super_block *sb)
 
 	sync_blockdev(sb->s_bdev);
 	invalidate_bdev(sb->s_bdev);
-	if (sbi->s_journal_bdev) {
-		sync_blockdev(sbi->s_journal_bdev);
+	if (sbi->s_journal_bdev_handle) {
+		sync_blockdev(sbi->s_journal_bdev_handle->bdev);
 		ext4_blkdev_remove(sbi);
 	}
 
@@ -4218,7 +4216,7 @@ int ext4_calculate_overhead(struct super_block *sb)
 	 * Add the internal journal blocks whether the journal has been
 	 * loaded or not
 	 */
-	if (sbi->s_journal && !sbi->s_journal_bdev)
+	if (sbi->s_journal && !sbi->s_journal_bdev_handle)
 		overhead += EXT4_NUM_B2C(sbi, sbi->s_journal->j_total_len);
 	else if (ext4_has_feature_journal(sb) && !sbi->s_journal && j_inum) {
 		/* j_inum for internal journal is non-zero */
@@ -5840,17 +5838,19 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
 	unsigned long offset;
 	struct ext4_super_block *es;
 	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 
 	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
 		return NULL;
 
 	/* see get_tree_bdev why this is needed and safe */
 	up_write(&sb->s_umount);
-	bdev = ext4_blkdev_get(j_dev, sb);
+	bdev_handle = ext4_blkdev_get(j_dev, sb);
 	down_write(&sb->s_umount);
-	if (bdev == NULL)
+	if (!bdev_handle)
 		return NULL;
 
+	bdev = bdev_handle->bdev;
 	blocksize = sb->s_blocksize;
 	hblock = bdev_logical_block_size(bdev);
 	if (blocksize < hblock) {
@@ -5914,14 +5914,14 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
 			be32_to_cpu(journal->j_superblock->s_nr_users));
 		goto out_journal;
 	}
-	EXT4_SB(sb)->s_journal_bdev = bdev;
+	EXT4_SB(sb)->s_journal_bdev_handle = bdev_handle;
 	ext4_init_journal_params(sb, journal);
 	return journal;
 
 out_journal:
 	jbd2_journal_destroy(journal);
 out_bdev:
-	blkdev_put(bdev, sb);
+	bdev_release(bdev_handle);
 	return NULL;
 }
 
-- 
2.35.3

