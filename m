Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B934D78562B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjHWKuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbjHWKuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:50:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0304E76;
        Wed, 23 Aug 2023 03:49:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 09A7521F4B;
        Wed, 23 Aug 2023 10:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692787739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YpVuSvngDG3pGKaLigSbJaoVsaNH7Bf2Hd77g+U0+4=;
        b=1nhTQtEQ1PYaQx4OcfozqY1+wCk+gheyep5AOHjSlVC/mklwJHxOflQKEQCvaiSx4E/iSG
        O7pJpaL5XFGoRkrjA0zeZ6iNZ+LPhJ0h0jSy2ZsLkVXXmd5a5A81rI5vuKdhE0SLxcVwgF
        lnjK92kan3cLv9nZeWi9Nyq/FnPitpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692787739;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YpVuSvngDG3pGKaLigSbJaoVsaNH7Bf2Hd77g+U0+4=;
        b=DaX4YsmfonE7u3RTh0HgcxhoSp4QLIx3eiLwGCpV2sZzdtJ8Kys2pl//X11+AP4sQqIIs3
        BtL7Y+aOKkzlKkCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F05BB13458;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HlWrOhrk5WRoIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 778F9A0794; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 19/29] fs: Convert to bdev_open_by_dev()
Date:   Wed, 23 Aug 2023 12:48:30 +0200
Message-Id: <20230823104857.11437-19-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3420; i=jack@suse.cz; h=from:subject; bh=Sa1LjWx2q0nCdmcpYoUPMJV2NPyY7p9AGikLs15F9E8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5eP+kuYWmjO7zBppke4fDHeis8jnVvbQWT4Fe5HW jwDUwVeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXj/gAKCRCcnaoHP2RA2ZPRB/ 40wBpl0fzy4xQBo9nMDlUTKH7Mu8fvTXIqd1HBxWYe2WyqbQvcNvburyZ2Vquvf8zkNB3NcH97j4mr BHekJ5lvFxPbc3WjZA2qb/DnJPPeC2FYqjQcGdXSfmA+VioHC5koYwHEcvFUlVlUrQTraOajIduxvx k0dkpXxC0JB0tZ2a6AXypNS9Xem8ZMuMM9DrxYvC2wE0GjZnkVIPK/cafZq04M35yLlr+WvZtaIaFF gJ7mQar6xx2ataSqh/esawtKllalWhTkMcdS5VuIy0XHhsTnFAZAxfOjCAKBUjUM2u1665KdxMzQM7 kRjbJJe176hNeHRbFzl7HqYZrSpJYQ
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

Convert mount code to use bdev_open_by_dev() and propagate the handle
around to bdev_release().

Acked-by: Christoph Hellwig <hch@lst.de>
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
index 1bea34be5d43..82757f3e0f1b 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1250,14 +1250,16 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
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
@@ -1265,7 +1267,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	 * writable from userspace even for a read-only block device.
 	 */
 	if ((mode & BLK_OPEN_WRITE) && bdev_read_only(bdev)) {
-		blkdev_put(bdev, sb);
+		bdev_release(bdev_handle);
 		return -EACCES;
 	}
 
@@ -1281,10 +1283,11 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
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
@@ -1418,7 +1421,7 @@ void kill_block_super(struct super_block *sb)
 	generic_shutdown_super(sb);
 	if (bdev) {
 		sync_blockdev(bdev);
-		blkdev_put(bdev, sb);
+		bdev_release(sb->s_bdev_handle);
 	}
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 22b59cd36963..b5c61107bd6d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1187,6 +1187,7 @@ struct super_block {
 	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
 	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
 	struct block_device	*s_bdev;
+	struct bdev_handle	*s_bdev_handle;
 	struct backing_dev_info *s_bdi;
 	struct mtd_info		*s_mtd;
 	struct hlist_node	s_instances;
-- 
2.35.3

