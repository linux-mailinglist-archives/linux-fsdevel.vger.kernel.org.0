Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43E4785626
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbjHWKuf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjHWKuW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:50:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98848E61;
        Wed, 23 Aug 2023 03:49:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EE24820751;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692787738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjqfLYM6+5StP/FBvjEmDMIiBmQctE6hfDpMr2h83M8=;
        b=PHeNphP7Xd0L/8WLMot/to6cCUSfPaM/vkvWjEDe0oeo4MB/6bdttxmSuYsEXzmo2wzuYf
        Tjvo3lb+X23cys4RPttnBZ58Xm0MCetRQ/VSN5XFkcvYTFfdkcRJW3/O8K4cWDJlvSkERS
        xktwk3GXgRR6lcHlv4T8rU6a+m8/e1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692787738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjqfLYM6+5StP/FBvjEmDMIiBmQctE6hfDpMr2h83M8=;
        b=iJVcs3zgA5Vtz/MblJqbelLpggv9WeRyDwIzGECH0Byt14+1+jJVNqoZ09pPaTavB0V3rV
        5iq0de/e6sBRFLCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE06613A43;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pMw1Nhrk5WRiIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 872F9A0798; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 22/29] ext4: Convert to bdev_open_by_dev()
Date:   Wed, 23 Aug 2023 12:48:33 +0200
Message-Id: <20230823104857.11437-22-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6270; i=jack@suse.cz; h=from:subject; bh=WIkfaGad5gwZ4CJWdYxbu5ODcggZgJkvpQdzs8x0AG8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5eQBRQm6nySCvl6ypmkPdbrsBPlpwUHNPyLPp5fR M9AmFeqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXkAQAKCRCcnaoHP2RA2YBZB/ 9BrX/GtL1ZsUK7C6PwfphXJtdrPkeAHpgoDkODPClVxZFvZFWg3yOH459a/b5sQHqemRgiZxYhQyl9 qSTGoK1wpQHY58nxxKyw7UOzbpXmUvQ5QbUWcDHrl8xLXgW/dqEqi4JcVqIcaPNwWqMbbQEF78kerQ ta24Rnc2Pc83/lKw73+FqVgjX6Qq1yRyFwyWkFpcTA+hS+uj+Owy/Ow88+azwK1f/bL4BgsDdR/gPN j8ZVc9E0AfNglKXfvFYMKHyU232BniIpFQRp8zdp/Xv8C4Jex6o9SP4TQMLIKDr0Lp04C3eT/HdnFH VQpWjlN2Nnle6LuriEP9cnzvszhYhL
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert ext4 to use bdev_open_by_dev() and pass the handle around.

CC: <linux-ext4@vger.kernel.org>
CC: Ted Tso <tytso@mit.edu>
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h  |  2 +-
 fs/ext4/fsmap.c |  9 +++++----
 fs/ext4/super.c | 44 +++++++++++++++++++++++---------------------
 3 files changed, 29 insertions(+), 26 deletions(-)

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
index 73547d2334fd..c2f5f73ab9fc 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1100,20 +1100,20 @@ void ext4_update_dynamic_rev(struct super_block *sb)
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
 
@@ -1311,14 +1311,14 @@ static void ext4_put_super(struct super_block *sb)
 
 	sync_blockdev(sb->s_bdev);
 	invalidate_bdev(sb->s_bdev);
-	if (sbi->s_journal_bdev) {
+	if (sbi->s_journal_bdev_handle) {
 		/*
 		 * Invalidate the journal device's buffers.  We don't want them
 		 * floating about in memory - the physical journal device may
 		 * hotswapped, and it breaks the `ro-after' testing code.
 		 */
-		sync_blockdev(sbi->s_journal_bdev);
-		invalidate_bdev(sbi->s_journal_bdev);
+		sync_blockdev(sbi->s_journal_bdev_handle->bdev);
+		invalidate_bdev(sbi->s_journal_bdev_handle->bdev);
 	}
 
 	ext4_xattr_destroy_cache(sbi->s_ea_inode_cache);
@@ -4205,7 +4205,7 @@ int ext4_calculate_overhead(struct super_block *sb)
 	 * Add the internal journal blocks whether the journal has been
 	 * loaded or not
 	 */
-	if (sbi->s_journal && !sbi->s_journal_bdev)
+	if (sbi->s_journal && !sbi->s_journal_bdev_handle)
 		overhead += EXT4_NUM_B2C(sbi, sbi->s_journal->j_total_len);
 	else if (ext4_has_feature_journal(sb) && !sbi->s_journal && j_inum) {
 		/* j_inum for internal journal is non-zero */
@@ -5642,9 +5642,9 @@ failed_mount9: __maybe_unused
 #endif
 	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
 	brelse(sbi->s_sbh);
-	if (sbi->s_journal_bdev) {
-		invalidate_bdev(sbi->s_journal_bdev);
-		blkdev_put(sbi->s_journal_bdev, sb);
+	if (sbi->s_journal_bdev_handle) {
+		invalidate_bdev(sbi->s_journal_bdev_handle->bdev);
+		bdev_release(sbi->s_journal_bdev_handle);
 	}
 out_fail:
 	invalidate_bdev(sb->s_bdev);
@@ -5829,17 +5829,19 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
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
@@ -5903,14 +5905,14 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
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
 
@@ -7258,12 +7260,12 @@ static inline int ext3_feature_set_ok(struct super_block *sb)
 static void ext4_kill_sb(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct block_device *journal_bdev = sbi ? sbi->s_journal_bdev : NULL;
+	struct bdev_handle *handle = sbi ? sbi->s_journal_bdev_handle : NULL;
 
 	kill_block_super(sb);
 
-	if (journal_bdev)
-		blkdev_put(journal_bdev, sb);
+	if (handle)
+		bdev_release(handle);
 }
 
 static struct file_system_type ext4_fs_type = {
-- 
2.35.3

