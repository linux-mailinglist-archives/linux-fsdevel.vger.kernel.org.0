Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033AA747103
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjGDMXm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjGDMXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:23:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D157A1700;
        Tue,  4 Jul 2023 05:22:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 954B52056E;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QpfUAIuASSqI6SJcixPbWTZZf2TTLJV3nNwNm+rOzZA=;
        b=CAuwWobqsMMEZWD8NagoqXaBBwkkYr/glO5V0N4xtnNOkN3+vc721WiSw7LSUWghV18VE/
        A4D9SQR8BofVh/3GTvnJpsp27GKu7PpLK4l8rkPhJ5Kz1hb1AZWstlwT3aRGRYXbe1fYhc
        t7HVV1bw4MZmIWZp129Ra6puWprZaTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QpfUAIuASSqI6SJcixPbWTZZf2TTLJV3nNwNm+rOzZA=;
        b=2VXt+p/a2Vz4yryYdSN/6BCif+SF6GmF8Bt3hgkkqfB/N57zVKxQIEVPNWrqCO0GE0OLup
        jMeX1PZ0NjRhJcBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 834A813A90;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7RMMIAIPpGRaMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 458A9A078C; Tue,  4 Jul 2023 14:22:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 29/32] reiserfs: Convert to blkdev_get_handle_by_dev/path()
Date:   Tue,  4 Jul 2023 14:21:56 +0200
Message-Id: <20230704122224.16257-29-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7551; i=jack@suse.cz; h=from:subject; bh=wB7NcjVTeZRWXEmQXiMlHjAIJr5i5qd17uWGdvxcAXs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7jhinIe/d4ajM+Q77699FHDfFXJv7hflfPOOQn xg7C/yCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO4wAKCRCcnaoHP2RA2e8VB/ 9rEF+SiIM01ZZStX7zStOvhwr4NMFyDxBXgBJ24QSavvSc9rq2MiJhl0uB6efVA9kdr2lvTjqpCDDJ BzYYrYZqBbNo+RTvH0gYAb4tD+BQhuK4HWAlPb9IkmsES505SSssbazwZkEWYRp4FyUFdZPIlfObly EvLG36rzUPZhauOsV4TfL0uGeTJqy9zCEtsKQ/shgM1VgheptbYbOt8t3YjSjCJiM2d8RenbGmt03C njxRFxGpd2etmMqeWAFTbtY3lfXwoZwUlt3VmfUj/BNQ+mkTVlCzuHAz6zfes3UTMBLHJ0KERLFkpP hYUwACx1CoUDf6ds+UQw9gSAVeFbpy
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert reiserfs to use blkdev_get_handle_by_dev/path() and pass the
handle around.

CC: reiserfs-devel@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/reiserfs/journal.c  | 56 +++++++++++++++++++-----------------------
 fs/reiserfs/procfs.c   |  2 +-
 fs/reiserfs/reiserfs.h | 11 ++++++---
 3 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 479aa4a57602..9518ff7865f0 100644
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
 
@@ -2385,7 +2384,7 @@ static int journal_read(struct super_block *sb)
 
 	cur_dblock = SB_ONDISK_JOURNAL_1st_BLOCK(sb);
 	reiserfs_info(sb, "checking transaction log (%pg)\n",
-		      journal->j_dev_bd);
+		      journal->j_bdev_handle->bdev);
 	start = ktime_get_seconds();
 
 	/*
@@ -2446,7 +2445,7 @@ static int journal_read(struct super_block *sb)
 		 * device and journal device to be the same
 		 */
 		d_bh =
-		    reiserfs_breada(journal->j_dev_bd, cur_dblock,
+		    reiserfs_breada(journal->j_bdev_handle->bdev, cur_dblock,
 				    sb->s_blocksize,
 				    SB_ONDISK_JOURNAL_1st_BLOCK(sb) +
 				    SB_ONDISK_JOURNAL_SIZE(sb));
@@ -2585,17 +2584,11 @@ static void journal_list_init(struct super_block *sb)
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
+		blkdev_handle_put(journal->j_bdev_handle);
+		journal->j_bdev_handle = NULL;
 	}
 }
 
@@ -2610,7 +2603,7 @@ static int journal_init_dev(struct super_block *super,
 
 	result = 0;
 
-	journal->j_dev_bd = NULL;
+	journal->j_bdev_handle = NULL;
 	jdev = SB_ONDISK_JOURNAL_DEVICE(super) ?
 	    new_decode_dev(SB_ONDISK_JOURNAL_DEVICE(super)) : super->s_dev;
 
@@ -2621,36 +2614,37 @@ static int journal_init_dev(struct super_block *super,
 	if ((!jdev_name || !jdev_name[0])) {
 		if (jdev == super->s_dev)
 			holder = NULL;
-		journal->j_dev_bd = blkdev_get_by_dev(jdev, blkdev_mode, holder,
-						      NULL);
-		if (IS_ERR(journal->j_dev_bd)) {
-			result = PTR_ERR(journal->j_dev_bd);
-			journal->j_dev_bd = NULL;
+		journal->j_bdev_handle = blkdev_get_handle_by_dev(jdev,
+					blkdev_mode, holder, NULL);
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
+	journal->j_bdev_handle = blkdev_get_handle_by_path(jdev_name,
+				blkdev_mode, holder, NULL);
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
 
@@ -2808,7 +2802,7 @@ int journal_init(struct super_block *sb, const char *j_dev_name,
 				 "journal header magic %x (device %pg) does "
 				 "not match to magic found in super block %x",
 				 jh->jh_journal.jp_journal_magic,
-				 journal->j_dev_bd,
+				 journal->j_bdev_handle->bdev,
 				 sb_jp_journal_magic(rs));
 		brelse(bhjh);
 		goto free_and_return;
@@ -2832,7 +2826,7 @@ int journal_init(struct super_block *sb, const char *j_dev_name,
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
index 55e85256aae8..8e426392b5c2 100644
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

