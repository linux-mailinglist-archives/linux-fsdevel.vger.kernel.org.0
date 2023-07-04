Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDBF747126
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjGDMYJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjGDMXN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:23:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D048610DD;
        Tue,  4 Jul 2023 05:22:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 95DEC22875;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CdDrcKTX1r0da/kayrewGT9e3N52Cmm0e41Srkqqemc=;
        b=ThiS9A/HP6MWFP+C52woq0HT4zB5SHX+jgzHTz2kQHALt0WBe83hFHHzXeW1lGA0a7AQsW
        zEa+xY5xmtRxrz98nSS1WY/HrNxaBVs5b8to+7nDaCoa5xigGvwe2kELnU9kbtg+MPXra/
        CeJ5VK06bMMkI4EnFQPKJHU6sdHhs4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CdDrcKTX1r0da/kayrewGT9e3N52Cmm0e41Srkqqemc=;
        b=FcgWewcMkfBYa6nos4baYasis0pF4i9iGwZQzd28/0MDBovjIEjTLSMgGjs2V6iZKZRVb0
        GBG/iB73BjmQO7Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8110E1346D;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DAqTHwIPpGRWMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3129CA0789; Tue,  4 Jul 2023 14:22:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH 25/32] jfs: Convert to blkdev_get_handle_by_dev()
Date:   Tue,  4 Jul 2023 14:21:52 +0200
Message-Id: <20230704122224.16257-25-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4906; i=jack@suse.cz; h=from:subject; bh=0cqXo6k1vFQ75NrH6vBJiw/wCaNI5jCy+yxbBHYQjDY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7gcoqjhgGqh2w7kel9LmNCCoABXJjHUJIhGm/s 8nijY5WJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO4AAKCRCcnaoHP2RA2f7WB/ 9cXz+1VF2Xh1+rD7YPNWB9XuYfTKrs/KNbdv1JVAjCm6upy+uvLsTEIekCWkqFl+PVuH5WqYe1JCyp RvBPyQfOomfVnMKQlseRvEsRyUt2uFKSJ2idkmqozBXXX9MPixKsmNnQ4Rl7Jw1Lt1icvww1+affC7 k8Zyyw+lAjfpT6YHLuakXi4Y/7Dq1a/uUp4weWgmYbNJoC2XkoEJRqlr8QUYuCza/Zf/xq7PBRRq5A OhH4EQJ7PSHNmmal6idxELpsWOueHk7ohiSSsFhLb4Du3vAtnqT3Mg+9ZAK5JPRu1qxKLQvkOXuOas MEMszWaXHGS7DwP8fM8EG+oqGqIp8x
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

Convert jfs to use blkdev_get_handle_by_dev() and pass the handle
around.

CC: Dave Kleikamp <shaggy@kernel.org>
CC: jfs-discussion@lists.sourceforge.net
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jfs/jfs_logmgr.c | 29 +++++++++++++++--------------
 fs/jfs/jfs_logmgr.h |  2 +-
 fs/jfs/jfs_mount.c  |  3 ++-
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index e855b8fde76c..9d06323261e6 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1058,7 +1058,7 @@ void jfs_syncpt(struct jfs_log *log, int hard_sync)
 int lmLogOpen(struct super_block *sb)
 {
 	int rc;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	struct jfs_log *log;
 	struct jfs_sb_info *sbi = JFS_SBI(sb);
 
@@ -1070,7 +1070,7 @@ int lmLogOpen(struct super_block *sb)
 
 	mutex_lock(&jfs_log_mutex);
 	list_for_each_entry(log, &jfs_external_logs, journal_list) {
-		if (log->bdev->bd_dev == sbi->logdev) {
+		if (log->bdev_handle->bdev->bd_dev == sbi->logdev) {
 			if (!uuid_equal(&log->uuid, &sbi->loguuid)) {
 				jfs_warn("wrong uuid on JFS journal");
 				mutex_unlock(&jfs_log_mutex);
@@ -1100,14 +1100,14 @@ int lmLogOpen(struct super_block *sb)
 	 * file systems to log may have n-to-1 relationship;
 	 */
 
-	bdev = blkdev_get_by_dev(sbi->logdev, BLK_OPEN_READ | BLK_OPEN_WRITE,
-				 log, NULL);
-	if (IS_ERR(bdev)) {
-		rc = PTR_ERR(bdev);
+	bdev_handle = blkdev_get_handle_by_dev(sbi->logdev,
+			BLK_OPEN_READ | BLK_OPEN_WRITE, log, NULL);
+	if (IS_ERR(bdev_handle)) {
+		rc = PTR_ERR(bdev_handle);
 		goto free;
 	}
 
-	log->bdev = bdev;
+	log->bdev_handle = bdev_handle;
 	uuid_copy(&log->uuid, &sbi->loguuid);
 
 	/*
@@ -1141,7 +1141,7 @@ int lmLogOpen(struct super_block *sb)
 	lbmLogShutdown(log);
 
       close:		/* close external log device */
-	blkdev_put(bdev, log);
+	blkdev_handle_put(bdev_handle);
 
       free:		/* free log descriptor */
 	mutex_unlock(&jfs_log_mutex);
@@ -1162,7 +1162,7 @@ static int open_inline_log(struct super_block *sb)
 	init_waitqueue_head(&log->syncwait);
 
 	set_bit(log_INLINELOG, &log->flag);
-	log->bdev = sb->s_bdev;
+	log->bdev_handle = sb->s_bdev_handle;
 	log->base = addressPXD(&JFS_SBI(sb)->logpxd);
 	log->size = lengthPXD(&JFS_SBI(sb)->logpxd) >>
 	    (L2LOGPSIZE - sb->s_blocksize_bits);
@@ -1436,7 +1436,7 @@ int lmLogClose(struct super_block *sb)
 {
 	struct jfs_sb_info *sbi = JFS_SBI(sb);
 	struct jfs_log *log = sbi->log;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	int rc = 0;
 
 	jfs_info("lmLogClose: log:0x%p", log);
@@ -1482,10 +1482,10 @@ int lmLogClose(struct super_block *sb)
 	 *	external log as separate logical volume
 	 */
 	list_del(&log->journal_list);
-	bdev = log->bdev;
+	bdev_handle = log->bdev_handle;
 	rc = lmLogShutdown(log);
 
-	blkdev_put(bdev, log);
+	blkdev_handle_put(bdev_handle);
 
 	kfree(log);
 
@@ -1972,7 +1972,7 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
 
 	bp->l_flag |= lbmREAD;
 
-	bio = bio_alloc(log->bdev, 1, REQ_OP_READ, GFP_NOFS);
+	bio = bio_alloc(log->bdev_handle->bdev, 1, REQ_OP_READ, GFP_NOFS);
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
 	__bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
@@ -2113,7 +2113,8 @@ static void lbmStartIO(struct lbuf * bp)
 
 	jfs_info("lbmStartIO");
 
-	bio = bio_alloc(log->bdev, 1, REQ_OP_WRITE | REQ_SYNC, GFP_NOFS);
+	bio = bio_alloc(log->bdev_handle->bdev, 1, REQ_OP_WRITE | REQ_SYNC,
+			GFP_NOFS);
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
 	__bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
diff --git a/fs/jfs/jfs_logmgr.h b/fs/jfs/jfs_logmgr.h
index 805877ce5020..84aa2d253907 100644
--- a/fs/jfs/jfs_logmgr.h
+++ b/fs/jfs/jfs_logmgr.h
@@ -356,7 +356,7 @@ struct jfs_log {
 				 *    before writing syncpt.
 				 */
 	struct list_head journal_list; /* Global list */
-	struct block_device *bdev; /* 4: log lv pointer */
+	struct bdev_handle *bdev_handle; /* 4: log lv pointer */
 	int serial;		/* 4: log mount serial number */
 
 	s64 base;		/* @8: log extent address (inline log ) */
diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
index b83aae56a1f2..415eb65a36ff 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -430,7 +430,8 @@ int updateSuper(struct super_block *sb, uint state)
 
 	if (state == FM_MOUNT) {
 		/* record log's dev_t and mount serial number */
-		j_sb->s_logdev = cpu_to_le32(new_encode_dev(sbi->log->bdev->bd_dev));
+		j_sb->s_logdev = cpu_to_le32(
+			new_encode_dev(sbi->log->bdev_handle->bdev->bd_dev));
 		j_sb->s_logserial = cpu_to_le32(sbi->log->serial);
 	} else if (state == FM_CLEAN) {
 		/*
-- 
2.35.3

