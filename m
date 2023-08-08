Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E275F7749A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 21:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjHHT66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 15:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjHHT6b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:58:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048541D466;
        Tue,  8 Aug 2023 11:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qf1FOh4o3ROh8fs91oFv2khzBF62ADi5/zosffYFjxI=; b=1lR6VA+6Rff/rDi/taUGcHytKR
        EZVGXN/63ckalqBXMq+CA1YI6yRr2FpKiCKuYY/CZdcwZZuLswaPMfk0AovQQ7OV2WEDZyJQ05e7h
        Bopx6JNfHBvw7HO+3xx8LNpWPkL7MEacC/LBndav4rhj/oPQj5NG/EPfvwydyg40/qP1LoN9ZZFIc
        TuZ6QReX3gfOOCR6YJHqSZ5SjCypwULHOoQSZtjXhnsm6NceVwnTlMQmjDuW8z8VjRtvDRQdhIQF1
        DwTLgywMxXql4ULQwd4irWiy8Uz+78empZpzdsX+43f9nv19s5z7fPuo4Blld1rYrPJVvDtNjBX1K
        OhVHkdKg==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTPNM-002vei-0H;
        Tue, 08 Aug 2023 16:16:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: [PATCH 08/13] ext4: close the external journal device in ->kill_sb
Date:   Tue,  8 Aug 2023 09:15:55 -0700
Message-Id: <20230808161600.1099516-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808161600.1099516-1-hch@lst.de>
References: <20230808161600.1099516-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

blkdev_put must not be called under sb->s_umount to avoid a lock order
reversal with disk->open_mutex.  Move closing the external journal device
into ->kill_sb to archive that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/super.c | 50 ++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 063832e2d12a8e..0511fffb59b40d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -93,6 +93,7 @@ static int ext4_get_tree(struct fs_context *fc);
 static int ext4_reconfigure(struct fs_context *fc);
 static void ext4_fc_free(struct fs_context *fc);
 static int ext4_init_fs_context(struct fs_context *fc);
+static void ext4_kill_sb(struct super_block *sb);
 static const struct fs_parameter_spec ext4_param_specs[];
 
 /*
@@ -135,7 +136,7 @@ static struct file_system_type ext2_fs_type = {
 	.name			= "ext2",
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
-	.kill_sb		= kill_block_super,
+	.kill_sb		= ext4_kill_sb,
 	.fs_flags		= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ext2");
@@ -151,7 +152,7 @@ static struct file_system_type ext3_fs_type = {
 	.name			= "ext3",
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
-	.kill_sb		= kill_block_super,
+	.kill_sb		= ext4_kill_sb,
 	.fs_flags		= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ext3");
@@ -1116,25 +1117,6 @@ static struct block_device *ext4_blkdev_get(dev_t dev, struct super_block *sb)
 	return NULL;
 }
 
-/*
- * Release the journal device
- */
-static void ext4_blkdev_remove(struct ext4_sb_info *sbi)
-{
-	struct block_device *bdev;
-	bdev = sbi->s_journal_bdev;
-	if (bdev) {
-		/*
-		 * Invalidate the journal device's buffers.  We don't want them
-		 * floating about in memory - the physical journal device may
-		 * hotswapped, and it breaks the `ro-after' testing code.
-		 */
-		invalidate_bdev(bdev);
-		blkdev_put(bdev, sbi->s_sb);
-		sbi->s_journal_bdev = NULL;
-	}
-}
-
 static inline struct inode *orphan_list_entry(struct list_head *l)
 {
 	return &list_entry(l, struct ext4_inode_info, i_orphan)->vfs_inode;
@@ -1330,8 +1312,13 @@ static void ext4_put_super(struct super_block *sb)
 	sync_blockdev(sb->s_bdev);
 	invalidate_bdev(sb->s_bdev);
 	if (sbi->s_journal_bdev) {
+		/*
+		 * Invalidate the journal device's buffers.  We don't want them
+		 * floating about in memory - the physical journal device may
+		 * hotswapped, and it breaks the `ro-after' testing code.
+		 */
 		sync_blockdev(sbi->s_journal_bdev);
-		ext4_blkdev_remove(sbi);
+		invalidate_bdev(sbi->s_journal_bdev);
 	}
 
 	ext4_xattr_destroy_cache(sbi->s_ea_inode_cache);
@@ -5655,9 +5642,11 @@ failed_mount9: __maybe_unused
 		kfree(get_qf_name(sb, sbi, i));
 #endif
 	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
-	/* ext4_blkdev_remove() calls kill_bdev(), release bh before it. */
 	brelse(sbi->s_sbh);
-	ext4_blkdev_remove(sbi);
+	if (sbi->s_journal_bdev) {
+		invalidate_bdev(sbi->s_journal_bdev);
+		blkdev_put(sbi->s_journal_bdev, sb);
+	}
 out_fail:
 	invalidate_bdev(sb->s_bdev);
 	sb->s_fs_info = NULL;
@@ -7267,12 +7256,23 @@ static inline int ext3_feature_set_ok(struct super_block *sb)
 	return 1;
 }
 
+static void ext4_kill_sb(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct block_device *journal_bdev = sbi ? sbi->s_journal_bdev : NULL;
+
+	kill_block_super(sb);
+
+	if (journal_bdev)
+		blkdev_put(journal_bdev, sb);
+}
+
 static struct file_system_type ext4_fs_type = {
 	.owner			= THIS_MODULE,
 	.name			= "ext4",
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
-	.kill_sb		= kill_block_super,
+	.kill_sb		= ext4_kill_sb,
 	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("ext4");
-- 
2.39.2

