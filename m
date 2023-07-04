Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4012747112
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjGDMXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjGDMXK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:23:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88B310E4;
        Tue,  4 Jul 2023 05:22:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5EBCC20569;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5UjWyFmncU1B9+6mvlJ5cFB5n8LH23zit6gQDOgxQk=;
        b=x2qNmWjvaKXqHCrbjY8CzEF5i5qMFpMDu7z6h8eXK3SuFEewWo2/3Wq2nCM3E0cRPPpdPg
        mL+IPtfZVw34ua2JLMSn2+OU9k0J6d5Ozdw9aKEFm1edvvQqcMoLzxSBLmxSin7KAMlKwo
        eFgQpWk0uZIYrvmGMBlqT7+BSsjYnQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5UjWyFmncU1B9+6mvlJ5cFB5n8LH23zit6gQDOgxQk=;
        b=rLj+M/ryFP7k4SYjiurMDax9/9fh+VS2eCPe6TM4fDpReIUX7z9xlKSjIUj0dJ9CFIzgD0
        ezggTuSZXS6C87Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51A6713A26;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IhnsEwIPpGRHMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 25BFDA0782; Tue,  4 Jul 2023 14:22:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>
Subject: [PATCH 23/32] ext4: Convert to blkdev_get_handle_by_dev()
Date:   Tue,  4 Jul 2023 14:21:50 +0200
Message-Id: <20230704122224.16257-23-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5597; i=jack@suse.cz; h=from:subject; bh=dyT4NuncTwUpNDcek9nxUcvZb7JWQXHYqovVa8ujn/0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7eaQKjjqcNpsSfyzhp9rWX0wB51maykTeag27/ 6SuY+beJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO3gAKCRCcnaoHP2RA2SFyCA CFg8jtYTOds735wO2IB6LA6Xb3I8TgHIXr9jRkAWnQyTgd5FXv04ANFrcO7sDFzyEeYFELvmLj9NLF nOLIJhWjF9W04+NqzoRlcPHH+XKSXQRka9DnRkYndVNe0kHZYkAdNo1x2peJcdBnH/KYGowYvUE667 ECGBzicKwi/yyaWIbqCqKhoczuTh/deF8u3kTvyR3yIBCk7W1g9DkljjRKDaT2Iv+VVCBH1F2cSY/T pCRF/vmHDKRRurKmiXm8M3eHMUbVuKb2NHZMrGqvGIA4URKOcM7km9nEciORleIx/G/jWvYJBcc2iW EovhAhwSxIDRspLvQaBm5R9X4dubv4
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert ext4 to use blkdev_get_handle_by_dev() and pass the handle
around.

CC: <linux-ext4@vger.kernel.org>
CC: Ted Tso <tytso@mit.edu>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h  |  2 +-
 fs/ext4/fsmap.c |  9 +++++----
 fs/ext4/super.c | 40 ++++++++++++++++++++--------------------
 3 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0a2d55faa095..72bad004841b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1535,7 +1535,7 @@ struct ext4_sb_info {
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
index c94ebf704616..a3b982d6abf1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1108,20 +1108,20 @@ static const struct blk_holder_ops ext4_holder_ops = {
 /*
  * Open the external journal device
  */
-static struct block_device *ext4_blkdev_get(dev_t dev, struct super_block *sb)
+static struct bdev_handle *ext4_blkdev_get(dev_t dev, struct super_block *sb)
 {
-	struct block_device *bdev;
+	struct bdev_handle *handle;
 
-	bdev = blkdev_get_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE, sb,
-				 &ext4_holder_ops);
-	if (IS_ERR(bdev))
+	handle = blkdev_get_handle_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE,
+					  sb, &ext4_holder_ops);
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
 
@@ -1130,17 +1130,15 @@ static struct block_device *ext4_blkdev_get(dev_t dev, struct super_block *sb)
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
+		blkdev_handle_put(sbi->s_journal_bdev_handle);
+		sbi->s_journal_bdev_handle = NULL;
 	}
 }
 
@@ -1338,8 +1336,8 @@ static void ext4_put_super(struct super_block *sb)
 
 	sync_blockdev(sb->s_bdev);
 	invalidate_bdev(sb->s_bdev);
-	if (sbi->s_journal_bdev) {
-		sync_blockdev(sbi->s_journal_bdev);
+	if (sbi->s_journal_bdev_handle) {
+		sync_blockdev(sbi->s_journal_bdev_handle->bdev);
 		ext4_blkdev_remove(sbi);
 	}
 
@@ -4227,7 +4225,7 @@ int ext4_calculate_overhead(struct super_block *sb)
 	 * Add the internal journal blocks whether the journal has been
 	 * loaded or not
 	 */
-	if (sbi->s_journal && !sbi->s_journal_bdev)
+	if (sbi->s_journal && !sbi->s_journal_bdev_handle)
 		overhead += EXT4_NUM_B2C(sbi, sbi->s_journal->j_total_len);
 	else if (ext4_has_feature_journal(sb) && !sbi->s_journal && j_inum) {
 		/* j_inum for internal journal is non-zero */
@@ -5850,14 +5848,16 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
 	unsigned long offset;
 	struct ext4_super_block *es;
 	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 
 	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
 		return NULL;
 
-	bdev = ext4_blkdev_get(j_dev, sb);
-	if (bdev == NULL)
+	bdev_handle = ext4_blkdev_get(j_dev, sb);
+	if (!bdev_handle)
 		return NULL;
 
+	bdev = bdev_handle->bdev;
 	blocksize = sb->s_blocksize;
 	hblock = bdev_logical_block_size(bdev);
 	if (blocksize < hblock) {
@@ -5921,14 +5921,14 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
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
+	blkdev_handle_put(bdev_handle);
 	return NULL;
 }
 
-- 
2.35.3

