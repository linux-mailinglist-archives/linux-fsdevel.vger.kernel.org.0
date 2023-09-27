Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620727B004E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjI0Je4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjI0Jes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:34:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A79F199;
        Wed, 27 Sep 2023 02:34:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BCFD921961;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eRHWCibybWkIg5ki+pUqPhxpNyg9u7525lDUpb07x64=;
        b=BY09KzFYH9xQXtYPRjNOcJqQKtM+cfftrXANuvO2BdoOoWk552NCfB3tzYVbmHlhrmUNIX
        esr4VkrIsTAwsGgGDiShK24vBI7FzgNsq/7AkuJ3lQkVOrPtVE72K7xfvLs8Iij989rf6r
        xFvdB1jUiYAB/CwnSImhYAMKz9cUaWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eRHWCibybWkIg5ki+pUqPhxpNyg9u7525lDUpb07x64=;
        b=fv4qF3qxUQkSooQztUvT0/zCTOQZKwkqM4xu8EXk7ILFQsClWfFz3ygTfe3bLN4i8Tqqfj
        fNZeWaQOPzbBupAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0F3613A74;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D70vKzT3E2UsEwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 74953A07EF; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 19/29] fs: Convert to bdev_open_by_dev()
Date:   Wed, 27 Sep 2023 11:34:25 +0200
Message-Id: <20230927093442.25915-19-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3473; i=jack@suse.cz; h=from:subject; bh=/B5ycnHIT9iiHq8/x4Mxmum8OrcobdkPBudKWxkCGyY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/chXz63JpgIejm59p0Nw041HcbEfTRqUgdmtnZw a5MsMN6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3IQAKCRCcnaoHP2RA2WQfB/ 9DzlS+YbAGBcLj5jLT5zbxLGcLe0yfjg6/gBB96KhvFHpUFiQyE1vIjojOstRUQPWInEbB0IYxa2YR pfil9Q64ziyrugZAJCQcaUuhGWEeLnl7AAslQjMyAciJqGbz79gojwZkmJ6ETC816GYkjuLDZIaLYk FElf01KtZwUdVylejBXrOpy/4HPKzOiKElsZ6Gq7S/+i30mjgfr1RNt/+LoJNqzYzk1Mm4TTMbjR2r hebm5uckXdu8d7J6X/FgDS5Dh8sU6pcO72sk0WZIt2bZp6JDuwK3g8BiDRNvg4uyEiI7O2ofkkCqJ2 N3PnPJA8gMh8qU7SQ8MXcjStdiN9+k
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

Convert mount code to use bdev_open_by_dev() and propagate the handle
around to bdev_release().

Acked-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/cramfs/inode.c  |  2 +-
 fs/romfs/super.c   |  2 +-
 fs/super.c         | 15 +++++++++------
 include/linux/fs.h |  1 +
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 5ee7d7bbb361..2fbf97077ce9 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -495,7 +495,7 @@ static void cramfs_kill_sb(struct super_block *sb)
 		sb->s_mtd = NULL;
 	} else if (IS_ENABLED(CONFIG_CRAMFS_BLOCKDEV) && sb->s_bdev) {
 		sync_blockdev(sb->s_bdev);
-		blkdev_put(sb->s_bdev, sb);
+		bdev_release(sb->s_bdev_handle);
 	}
 	kfree(sbi);
 }
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 5c35f6c76037..b1bdfbc211c3 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -593,7 +593,7 @@ static void romfs_kill_sb(struct super_block *sb)
 #ifdef CONFIG_ROMFS_ON_BLOCK
 	if (sb->s_bdev) {
 		sync_blockdev(sb->s_bdev);
-		blkdev_put(sb->s_bdev, sb);
+		bdev_release(sb->s_bdev_handle);
 	}
 #endif
 }
diff --git a/fs/super.c b/fs/super.c
index 2d762ce67f6e..26b96191e9b3 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1479,14 +1479,16 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 		struct fs_context *fc)
 {
 	blk_mode_t mode = sb_open_mode(sb_flags);
+	struct bdev_handle *bdev_handle;
 	struct block_device *bdev;
 
-	bdev = blkdev_get_by_dev(sb->s_dev, mode, sb, &fs_holder_ops);
-	if (IS_ERR(bdev)) {
+	bdev_handle = bdev_open_by_dev(sb->s_dev, mode, sb, &fs_holder_ops);
+	if (IS_ERR(bdev_handle)) {
 		if (fc)
 			errorf(fc, "%s: Can't open blockdev", fc->source);
-		return PTR_ERR(bdev);
+		return PTR_ERR(bdev_handle);
 	}
+	bdev = bdev_handle->bdev;
 
 	/*
 	 * This really should be in blkdev_get_by_dev, but right now can't due
@@ -1494,7 +1496,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	 * writable from userspace even for a read-only block device.
 	 */
 	if ((mode & BLK_OPEN_WRITE) && bdev_read_only(bdev)) {
-		blkdev_put(bdev, sb);
+		bdev_release(bdev_handle);
 		return -EACCES;
 	}
 
@@ -1510,10 +1512,11 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 		mutex_unlock(&bdev->bd_fsfreeze_mutex);
 		if (fc)
 			warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
-		blkdev_put(bdev, sb);
+		bdev_release(bdev_handle);
 		return -EBUSY;
 	}
 	spin_lock(&sb_lock);
+	sb->s_bdev_handle = bdev_handle;
 	sb->s_bdev = bdev;
 	sb->s_bdi = bdi_get(bdev->bd_disk->bdi);
 	if (bdev_stable_writes(bdev))
@@ -1646,7 +1649,7 @@ void kill_block_super(struct super_block *sb)
 	generic_shutdown_super(sb);
 	if (bdev) {
 		sync_blockdev(bdev);
-		blkdev_put(bdev, sb);
+		bdev_release(sb->s_bdev_handle);
 	}
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b528f063e8ff..03afc8b6f2af 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1221,6 +1221,7 @@ struct super_block {
 	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
 	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
 	struct block_device	*s_bdev;
+	struct bdev_handle	*s_bdev_handle;
 	struct backing_dev_info *s_bdi;
 	struct mtd_info		*s_mtd;
 	struct hlist_node	s_instances;
-- 
2.35.3

