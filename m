Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803C77B006D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjI0JfM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjI0Jeu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:34:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAC3F3;
        Wed, 27 Sep 2023 02:34:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E8B662196E;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qRM7c/eQnvqydRLTtB4E1Sp0zs66wXLje5DkWlBLE7M=;
        b=Y8wvbSQpFZ6kJjXWDbK5BQAG4xEjSjQ1Ye6IxyvcQPYaUAaLzjZtDyn6YR98URBZp8s88m
        2hXYvKB8Y6K7zwd8O7js03Ales1c7Zq4DuZ+IWzaofxlbVMPJ6Xcb6517hpu3OnpLkM1K9
        WzvIDNMwDCNmMlpCCF8TLdlR7X+Zec4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qRM7c/eQnvqydRLTtB4E1Sp0zs66wXLje5DkWlBLE7M=;
        b=0wWv9GlLUoaAg5jG/ZN3R5a32GgNpFtXjoHhzZjqMKy+IGCdaj9YTgwkCvI33z22kGiixF
        BR63KeiGSW+pSbCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7EE31338F;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YPjCNDT3E2UzEwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8C34AA07F9; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 22/29] ext4: Convert to bdev_open_by_dev()
Date:   Wed, 27 Sep 2023 11:34:28 +0200
Message-Id: <20230927093442.25915-22-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7318; i=jack@suse.cz; h=from:subject; bh=KMyJ2SMp0CtVBZc637ghAGahijb5KTGBey50mJbwcWo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/cklM1K6HmZjaNjr2NN4EvzLhWWKQY3mjpYijHA CloO5HKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3JAAKCRCcnaoHP2RA2ShZCA CEXRkObjZDE3v3iYvwe7xGiXpcjV3X/syXPyVPo+RjyBPgBwVKs9hG9v6ENLvFMywUeNbPJgTc//RJ O7tuLF6+czXDkrJJF1/8hnVL1FQFVegfvqKz2fYs5gzliwcx9Go5gPvO/brAZpfFUYee+9O/xEQ0IW f/RHwew9232PTpA9b1b+DwT1+iAVi1bDoSQgw+v/PMQMwJIVsC795zFEXScjprdu0medzOAl2RENxu anZ1Q01SvtKplaMpJ53vIk6XX6aFneDrAo863JO/SPwc/CrMrUCFqJqm6jvkaB5Q42JyzvrYnueJ6T pA97kQIrevE/hh54hYLjUjQFO7uCJB
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert ext4 to use bdev_open_by_dev() and pass the handle around.

CC: <linux-ext4@vger.kernel.org>
CC: Ted Tso <tytso@mit.edu>
Acked-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h  |  2 +-
 fs/ext4/fsmap.c |  9 +++++----
 fs/ext4/super.c | 52 +++++++++++++++++++++++++------------------------
 3 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9418359b1d9d..2b3218b49bca 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1537,7 +1537,7 @@ struct ext4_sb_info {
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
index dbebd8b3127e..d43f8324242a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1351,14 +1351,14 @@ static void ext4_put_super(struct super_block *sb)
 
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
@@ -4233,7 +4233,7 @@ int ext4_calculate_overhead(struct super_block *sb)
 	 * Add the internal journal blocks whether the journal has been
 	 * loaded or not
 	 */
-	if (sbi->s_journal && !sbi->s_journal_bdev)
+	if (sbi->s_journal && !sbi->s_journal_bdev_handle)
 		overhead += EXT4_NUM_B2C(sbi, sbi->s_journal->j_total_len);
 	else if (ext4_has_feature_journal(sb) && !sbi->s_journal && j_inum) {
 		/* j_inum for internal journal is non-zero */
@@ -5670,9 +5670,9 @@ failed_mount9: __maybe_unused
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
@@ -5842,12 +5842,13 @@ static journal_t *ext4_open_inode_journal(struct super_block *sb,
 	return journal;
 }
 
-static struct block_device *ext4_get_journal_blkdev(struct super_block *sb,
+static struct bdev_handle *ext4_get_journal_blkdev(struct super_block *sb,
 					dev_t j_dev, ext4_fsblk_t *j_start,
 					ext4_fsblk_t *j_len)
 {
 	struct buffer_head *bh;
 	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	int hblock, blocksize;
 	ext4_fsblk_t sb_block;
 	unsigned long offset;
@@ -5856,16 +5857,17 @@ static struct block_device *ext4_get_journal_blkdev(struct super_block *sb,
 
 	/* see get_tree_bdev why this is needed and safe */
 	up_write(&sb->s_umount);
-	bdev = blkdev_get_by_dev(j_dev, BLK_OPEN_READ | BLK_OPEN_WRITE, sb,
-				 &fs_holder_ops);
+	bdev_handle = bdev_open_by_dev(j_dev, BLK_OPEN_READ | BLK_OPEN_WRITE,
+				       sb, &fs_holder_ops);
 	down_write(&sb->s_umount);
-	if (IS_ERR(bdev)) {
+	if (IS_ERR(bdev_handle)) {
 		ext4_msg(sb, KERN_ERR,
 			 "failed to open journal device unknown-block(%u,%u) %ld",
-			 MAJOR(j_dev), MINOR(j_dev), PTR_ERR(bdev));
-		return ERR_CAST(bdev);
+			 MAJOR(j_dev), MINOR(j_dev), PTR_ERR(bdev_handle));
+		return bdev_handle;
 	}
 
+	bdev = bdev_handle->bdev;
 	blocksize = sb->s_blocksize;
 	hblock = bdev_logical_block_size(bdev);
 	if (blocksize < hblock) {
@@ -5912,12 +5914,12 @@ static struct block_device *ext4_get_journal_blkdev(struct super_block *sb,
 	*j_start = sb_block + 1;
 	*j_len = ext4_blocks_count(es);
 	brelse(bh);
-	return bdev;
+	return bdev_handle;
 
 out_bh:
 	brelse(bh);
 out_bdev:
-	blkdev_put(bdev, sb);
+	bdev_release(bdev_handle);
 	return ERR_PTR(errno);
 }
 
@@ -5927,14 +5929,14 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 	journal_t *journal;
 	ext4_fsblk_t j_start;
 	ext4_fsblk_t j_len;
-	struct block_device *journal_bdev;
+	struct bdev_handle *bdev_handle;
 	int errno = 0;
 
-	journal_bdev = ext4_get_journal_blkdev(sb, j_dev, &j_start, &j_len);
-	if (IS_ERR(journal_bdev))
-		return ERR_CAST(journal_bdev);
+	bdev_handle = ext4_get_journal_blkdev(sb, j_dev, &j_start, &j_len);
+	if (IS_ERR(bdev_handle))
+		return ERR_CAST(bdev_handle);
 
-	journal = jbd2_journal_init_dev(journal_bdev, sb->s_bdev, j_start,
+	journal = jbd2_journal_init_dev(bdev_handle->bdev, sb->s_bdev, j_start,
 					j_len, sb->s_blocksize);
 	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "failed to create device journal");
@@ -5949,14 +5951,14 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 		goto out_journal;
 	}
 	journal->j_private = sb;
-	EXT4_SB(sb)->s_journal_bdev = journal_bdev;
+	EXT4_SB(sb)->s_journal_bdev_handle = bdev_handle;
 	ext4_init_journal_params(sb, journal);
 	return journal;
 
 out_journal:
 	jbd2_journal_destroy(journal);
 out_bdev:
-	blkdev_put(journal_bdev, sb);
+	bdev_release(bdev_handle);
 	return ERR_PTR(errno);
 }
 
@@ -7300,12 +7302,12 @@ static inline int ext3_feature_set_ok(struct super_block *sb)
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

