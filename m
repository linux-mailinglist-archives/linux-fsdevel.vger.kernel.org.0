Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FA37B007F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjI0JfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjI0JfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:35:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E38C0;
        Wed, 27 Sep 2023 02:34:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3CEDB21979;
        Wed, 27 Sep 2023 09:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SkE0nBE3ekp4wWEprUTLV2dWy7NnEc7cLcQScx2yoGI=;
        b=IwPiI3Vv0KcD+Eeo+MwSDj0bQx15KCIo3PR2Wvtl5AbOcU1N95+DPniG3qjhRgmVlT8nlD
        8/kV6XVEO76+sPWnqyrcQYm4W+CrmiVIvALu4gD1sJRuxK8H1t6W1zeOzBzvFCOUPk7QIQ
        EuktnodbUoojvTKMPT1mqH+XnSM3Ztk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807285;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SkE0nBE3ekp4wWEprUTLV2dWy7NnEc7cLcQScx2yoGI=;
        b=4Lp/SS4tDvj3uJuP/heCSJKskEbzaKjQ/aPBnzS2ebCv+NaIFRuNV0RcLmBcJp0eWNpzme
        1gKbHCDadW9bgyAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C1AD13A74;
        Wed, 27 Sep 2023 09:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UQjFCjX3E2U/EwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B2A7CA0801; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        reiserfs-devel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 27/29] reiserfs: Convert to bdev_open_by_dev/path()
Date:   Wed, 27 Sep 2023 11:34:33 +0200
Message-Id: <20230927093442.25915-27-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7626; i=jack@suse.cz; h=from:subject; bh=V4+hXDElzIJHCMJBQJ1hg4NZl5WPvmzUt2CR1zRKHDA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/coBG+ExYrSrx7R4V5N6xD/bbFOW7Aui6vDQUzg lM43JoKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3KAAKCRCcnaoHP2RA2QOmB/ sEK2G3V0JomYSvtb4RoiVBlhzQCmeLbwM+kYcu9injCuWPwxyGpfyUD9ThttktKk3tDe8tY6E7biwS 31TMQGnf+HjhYGS3Tf0fsBZzIbVMCteJ3mc3k0vmKoDWjK4i+fDWKh0x3iOpAHek0IAEUxQqYm5Dvj rt32dQQcsq67fCYh5bFfxuGwSbthpJmm0jgpZ9y/pmEqg2mytm8M3xVjepa9X8jCUVh4isIqo5t8cn LKnjCPAvH9QA0AEjGiuVaVQTlBIOoj39GYLR3QvKpF9NFh/u5eEgo4X8Dw3MqB3VHpl6KaRqld0LHs xaiOsqWD/NDGTPDQ4y7hou9DMlaSAj
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

Convert reiserfs to use bdev_open_by_dev/path() and pass the handle
around.

CC: reiserfs-devel@vger.kernel.org
Acked-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/reiserfs/journal.c  | 56 +++++++++++++++++++-----------------------
 fs/reiserfs/procfs.c   |  2 +-
 fs/reiserfs/reiserfs.h | 11 ++++++---
 3 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 015bfe4e4524..171c912af50f 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -90,8 +90,7 @@ static int flush_commit_list(struct super_block *s,
 static int can_dirty(struct reiserfs_journal_cnode *cn);
 static int journal_join(struct reiserfs_transaction_handle *th,
 			struct super_block *sb);
-static void release_journal_dev(struct super_block *super,
-			       struct reiserfs_journal *journal);
+static void release_journal_dev(struct reiserfs_journal *journal);
 static void dirty_one_transaction(struct super_block *s,
 				 struct reiserfs_journal_list *jl);
 static void flush_async_commits(struct work_struct *work);
@@ -1893,7 +1892,7 @@ static void free_journal_ram(struct super_block *sb)
 	 * j_header_bh is on the journal dev, make sure
 	 * not to release the journal dev until we brelse j_header_bh
 	 */
-	release_journal_dev(sb, journal);
+	release_journal_dev(journal);
 	vfree(journal);
 }
 
@@ -2387,7 +2386,7 @@ static int journal_read(struct super_block *sb)
 
 	cur_dblock = SB_ONDISK_JOURNAL_1st_BLOCK(sb);
 	reiserfs_info(sb, "checking transaction log (%pg)\n",
-		      journal->j_dev_bd);
+		      journal->j_bdev_handle->bdev);
 	start = ktime_get_seconds();
 
 	/*
@@ -2448,7 +2447,7 @@ static int journal_read(struct super_block *sb)
 		 * device and journal device to be the same
 		 */
 		d_bh =
-		    reiserfs_breada(journal->j_dev_bd, cur_dblock,
+		    reiserfs_breada(journal->j_bdev_handle->bdev, cur_dblock,
 				    sb->s_blocksize,
 				    SB_ONDISK_JOURNAL_1st_BLOCK(sb) +
 				    SB_ONDISK_JOURNAL_SIZE(sb));
@@ -2587,17 +2586,11 @@ static void journal_list_init(struct super_block *sb)
 	SB_JOURNAL(sb)->j_current_jl = alloc_journal_list(sb);
 }
 
-static void release_journal_dev(struct super_block *super,
-			       struct reiserfs_journal *journal)
+static void release_journal_dev(struct reiserfs_journal *journal)
 {
-	if (journal->j_dev_bd != NULL) {
-		void *holder = NULL;
-
-		if (journal->j_dev_bd->bd_dev != super->s_dev)
-			holder = journal;
-
-		blkdev_put(journal->j_dev_bd, holder);
-		journal->j_dev_bd = NULL;
+	if (journal->j_bdev_handle) {
+		bdev_release(journal->j_bdev_handle);
+		journal->j_bdev_handle = NULL;
 	}
 }
 
@@ -2612,7 +2605,7 @@ static int journal_init_dev(struct super_block *super,
 
 	result = 0;
 
-	journal->j_dev_bd = NULL;
+	journal->j_bdev_handle = NULL;
 	jdev = SB_ONDISK_JOURNAL_DEVICE(super) ?
 	    new_decode_dev(SB_ONDISK_JOURNAL_DEVICE(super)) : super->s_dev;
 
@@ -2623,36 +2616,37 @@ static int journal_init_dev(struct super_block *super,
 	if ((!jdev_name || !jdev_name[0])) {
 		if (jdev == super->s_dev)
 			holder = NULL;
-		journal->j_dev_bd = blkdev_get_by_dev(jdev, blkdev_mode, holder,
-						      NULL);
-		if (IS_ERR(journal->j_dev_bd)) {
-			result = PTR_ERR(journal->j_dev_bd);
-			journal->j_dev_bd = NULL;
+		journal->j_bdev_handle = bdev_open_by_dev(jdev, blkdev_mode,
+							  holder, NULL);
+		if (IS_ERR(journal->j_bdev_handle)) {
+			result = PTR_ERR(journal->j_bdev_handle);
+			journal->j_bdev_handle = NULL;
 			reiserfs_warning(super, "sh-458",
 					 "cannot init journal device unknown-block(%u,%u): %i",
 					 MAJOR(jdev), MINOR(jdev), result);
 			return result;
 		} else if (jdev != super->s_dev)
-			set_blocksize(journal->j_dev_bd, super->s_blocksize);
+			set_blocksize(journal->j_bdev_handle->bdev,
+				      super->s_blocksize);
 
 		return 0;
 	}
 
-	journal->j_dev_bd = blkdev_get_by_path(jdev_name, blkdev_mode, holder,
-					       NULL);
-	if (IS_ERR(journal->j_dev_bd)) {
-		result = PTR_ERR(journal->j_dev_bd);
-		journal->j_dev_bd = NULL;
+	journal->j_bdev_handle = bdev_open_by_path(jdev_name, blkdev_mode,
+						   holder, NULL);
+	if (IS_ERR(journal->j_bdev_handle)) {
+		result = PTR_ERR(journal->j_bdev_handle);
+		journal->j_bdev_handle = NULL;
 		reiserfs_warning(super, "sh-457",
 				 "journal_init_dev: Cannot open '%s': %i",
 				 jdev_name, result);
 		return result;
 	}
 
-	set_blocksize(journal->j_dev_bd, super->s_blocksize);
+	set_blocksize(journal->j_bdev_handle->bdev, super->s_blocksize);
 	reiserfs_info(super,
 		      "journal_init_dev: journal device: %pg\n",
-		      journal->j_dev_bd);
+		      journal->j_bdev_handle->bdev);
 	return 0;
 }
 
@@ -2810,7 +2804,7 @@ int journal_init(struct super_block *sb, const char *j_dev_name,
 				 "journal header magic %x (device %pg) does "
 				 "not match to magic found in super block %x",
 				 jh->jh_journal.jp_journal_magic,
-				 journal->j_dev_bd,
+				 journal->j_bdev_handle->bdev,
 				 sb_jp_journal_magic(rs));
 		brelse(bhjh);
 		goto free_and_return;
@@ -2834,7 +2828,7 @@ int journal_init(struct super_block *sb, const char *j_dev_name,
 	reiserfs_info(sb, "journal params: device %pg, size %u, "
 		      "journal first block %u, max trans len %u, max batch %u, "
 		      "max commit age %u, max trans age %u\n",
-		      journal->j_dev_bd,
+		      journal->j_bdev_handle->bdev,
 		      SB_ONDISK_JOURNAL_SIZE(sb),
 		      SB_ONDISK_JOURNAL_1st_BLOCK(sb),
 		      journal->j_trans_max,
diff --git a/fs/reiserfs/procfs.c b/fs/reiserfs/procfs.c
index 3dba8acf4e83..83cb9402e0f9 100644
--- a/fs/reiserfs/procfs.c
+++ b/fs/reiserfs/procfs.c
@@ -354,7 +354,7 @@ static int show_journal(struct seq_file *m, void *unused)
 		   "prepare: \t%12lu\n"
 		   "prepare_retry: \t%12lu\n",
 		   DJP(jp_journal_1st_block),
-		   SB_JOURNAL(sb)->j_dev_bd,
+		   SB_JOURNAL(sb)->j_bdev_handle->bdev,
 		   DJP(jp_journal_dev),
 		   DJP(jp_journal_size),
 		   DJP(jp_journal_trans_max),
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 7d12b8c5b2fa..8ad41271c256 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -299,7 +299,7 @@ struct reiserfs_journal {
 	/* oldest journal block.  start here for traverse */
 	struct reiserfs_journal_cnode *j_first;
 
-	struct block_device *j_dev_bd;
+	struct bdev_handle *j_bdev_handle;
 
 	/* first block on s_dev of reserved area journal */
 	int j_1st_reserved_block;
@@ -2809,9 +2809,12 @@ struct reiserfs_journal_header {
 #define journal_hash(t,sb,block) ((t)[_jhashfn((sb),(block)) & JBH_HASH_MASK])
 
 /* We need these to make journal.c code more readable */
-#define journal_find_get_block(s, block) __find_get_block(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize)
-#define journal_getblk(s, block) __getblk(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize)
-#define journal_bread(s, block) __bread(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize)
+#define journal_find_get_block(s, block) __find_get_block(\
+		SB_JOURNAL(s)->j_bdev_handle->bdev, block, s->s_blocksize)
+#define journal_getblk(s, block) __getblk(SB_JOURNAL(s)->j_bdev_handle->bdev,\
+		block, s->s_blocksize)
+#define journal_bread(s, block) __bread(SB_JOURNAL(s)->j_bdev_handle->bdev,\
+		block, s->s_blocksize)
 
 enum reiserfs_bh_state_bits {
 	BH_JDirty = BH_PrivateStart,	/* buffer is in current transaction */
-- 
2.35.3

