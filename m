Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16170747109
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjGDMXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGDMXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:23:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85F510E2;
        Tue,  4 Jul 2023 05:22:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 68EFE2056A;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5C0vSf4qpM600jxyFIfSlLovmkCTK8JZv7AB4Hu1hdc=;
        b=Mow9YLKvqvLqN/5rA++1Up5M63KSxm+emJmTx7HjSfP1+RTQFyCCIZjR5joquFMKeFVTy0
        8LpLhDUtXJM8Oe4TGUw0JTv2ACvXoahWQ+70izFSOAp2wL3YMmBDK4aSPSZdtimBznZQEU
        BEUAeWdEKpPom9G5Odsv000vmQiNSQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5C0vSf4qpM600jxyFIfSlLovmkCTK8JZv7AB4Hu1hdc=;
        b=pUeXGqRMvSOmMgEl035lOROLy3P4LBN8m9yMn7E+Euqp4FJoIVH+6Rxe6RiYr5OIXwhXcu
        foQ4dkQYDERpx3CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53B3A13A97;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9GNeFAIPpGRIMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 12B54A077E; Tue,  4 Jul 2023 14:22:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 20/32] fs: Convert to blkdev_get_handle_by_path()
Date:   Tue,  4 Jul 2023 14:21:47 +0200
Message-Id: <20230704122224.16257-20-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6436; i=jack@suse.cz; h=from:subject; bh=eZ1AlUUvooov2FQ4T5JXo9pU5gTx16tisjY9pDL3yKE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7bpicYMH8xk616a0sMk8movLWUni09LtGwLjwY 1kQIVAyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO2wAKCRCcnaoHP2RA2VfUB/ 0Wqwd8lnvaA6+9ihJrqfwkO4Y5IVNBkIxRPMvo87bmTZwYaGF11ksoPoMIzB9VYluRQmU8nm1SboMs AjW4GGDBI5cn5qLhG1oCZlgop86NRMDroPUCWNJNSiN/HXKVya507GZIWqg9pG/VUaRgVloL7usnIU eSKY69CJSKJ8CbXkg6mH33Y5S2Hp8ZP4h3fITReMA7B4rI7seGn7O/veUDAL763wVEbE8U+TWWvH2U /sPoEsYIjteps7Mw8TDWNhEB+4vQhFRrDgrIacCVjFVcglIYfLQi7I4D4aDZQCdpyeJZO4nn2MYDLH vPEa66rkU00AZl0q+bsZo49Y6WeMTt
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

Convert mount code to use blkdev_get_handle_by_path() and propagate the
handle around to blkdev_handle_put().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/super.c         | 52 ++++++++++++++++++++++++++--------------------
 include/linux/fs.h |  1 +
 2 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index e781226e2880..d35545364c5d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1228,7 +1228,8 @@ static const struct blk_holder_ops fs_holder_ops = {
 
 static int set_bdev_super(struct super_block *s, void *data)
 {
-	s->s_bdev = data;
+	s->s_bdev_handle = data;
+	s->s_bdev = s->s_bdev_handle->bdev;
 	s->s_dev = s->s_bdev->bd_dev;
 	s->s_bdi = bdi_get(s->s_bdev->bd_disk->bdi);
 
@@ -1244,7 +1245,8 @@ static int set_bdev_super_fc(struct super_block *s, struct fs_context *fc)
 
 static int test_bdev_super_fc(struct super_block *s, struct fs_context *fc)
 {
-	return !(s->s_iflags & SB_I_RETIRED) && s->s_bdev == fc->sget_key;
+	return !(s->s_iflags & SB_I_RETIRED) &&
+		s->s_bdev == ((struct bdev_handle *)fc->sget_key)->bdev;
 }
 
 /**
@@ -1256,6 +1258,7 @@ int get_tree_bdev(struct fs_context *fc,
 		int (*fill_super)(struct super_block *,
 				  struct fs_context *))
 {
+	struct bdev_handle *bdev_handle;
 	struct block_device *bdev;
 	struct super_block *s;
 	int error = 0;
@@ -1263,12 +1266,14 @@ int get_tree_bdev(struct fs_context *fc,
 	if (!fc->source)
 		return invalf(fc, "No source specified");
 
-	bdev = blkdev_get_by_path(fc->source, sb_open_mode(fc->sb_flags),
-				  fc->fs_type, &fs_holder_ops);
-	if (IS_ERR(bdev)) {
+	bdev_handle = blkdev_get_handle_by_path(fc->source,
+			sb_open_mode(fc->sb_flags), fc->fs_type,
+			&fs_holder_ops);
+	if (IS_ERR(bdev_handle)) {
 		errorf(fc, "%s: Can't open blockdev", fc->source);
-		return PTR_ERR(bdev);
+		return PTR_ERR(bdev_handle);
 	}
+	bdev = bdev_handle->bdev;
 
 	/* Once the superblock is inserted into the list by sget_fc(), s_umount
 	 * will protect the lockfs code from trying to start a snapshot while
@@ -1278,16 +1283,16 @@ int get_tree_bdev(struct fs_context *fc,
 	if (bdev->bd_fsfreeze_count > 0) {
 		mutex_unlock(&bdev->bd_fsfreeze_mutex);
 		warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
-		blkdev_put(bdev, fc->fs_type);
+		blkdev_handle_put(bdev_handle);
 		return -EBUSY;
 	}
 
 	fc->sb_flags |= SB_NOSEC;
-	fc->sget_key = bdev;
+	fc->sget_key = bdev_handle;
 	s = sget_fc(fc, test_bdev_super_fc, set_bdev_super_fc);
 	mutex_unlock(&bdev->bd_fsfreeze_mutex);
 	if (IS_ERR(s)) {
-		blkdev_put(bdev, fc->fs_type);
+		blkdev_handle_put(bdev_handle);
 		return PTR_ERR(s);
 	}
 
@@ -1296,19 +1301,19 @@ int get_tree_bdev(struct fs_context *fc,
 		if ((fc->sb_flags ^ s->s_flags) & SB_RDONLY) {
 			warnf(fc, "%pg: Can't mount, would change RO state", bdev);
 			deactivate_locked_super(s);
-			blkdev_put(bdev, fc->fs_type);
+			blkdev_handle_put(bdev_handle);
 			return -EBUSY;
 		}
 
 		/*
 		 * s_umount nests inside open_mutex during
-		 * __invalidate_device().  blkdev_put() acquires
+		 * __invalidate_device().  blkdev_handle_put() acquires
 		 * open_mutex and can't be called under s_umount.  Drop
 		 * s_umount temporarily.  This is safe as we're
 		 * holding an active reference.
 		 */
 		up_write(&s->s_umount);
-		blkdev_put(bdev, fc->fs_type);
+		blkdev_handle_put(bdev_handle);
 		down_write(&s->s_umount);
 	} else {
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
@@ -1333,21 +1338,24 @@ EXPORT_SYMBOL(get_tree_bdev);
 
 static int test_bdev_super(struct super_block *s, void *data)
 {
-	return !(s->s_iflags & SB_I_RETIRED) && (void *)s->s_bdev == data;
+	return !(s->s_iflags & SB_I_RETIRED) &&
+		s->s_bdev == ((struct bdev_handle *)data)->bdev;
 }
 
 struct dentry *mount_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int))
 {
+	struct bdev_handle *bdev_handle;
 	struct block_device *bdev;
 	struct super_block *s;
 	int error = 0;
 
-	bdev = blkdev_get_by_path(dev_name, sb_open_mode(flags), fs_type,
-				  &fs_holder_ops);
-	if (IS_ERR(bdev))
-		return ERR_CAST(bdev);
+	bdev_handle = blkdev_get_handle_by_path(dev_name, sb_open_mode(flags),
+				fs_type, &fs_holder_ops);
+	if (IS_ERR(bdev_handle))
+		return ERR_CAST(bdev_handle);
+	bdev = bdev_handle->bdev;
 
 	/*
 	 * once the super is inserted into the list by sget, s_umount
@@ -1361,7 +1369,7 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 		goto error_bdev;
 	}
 	s = sget(fs_type, test_bdev_super, set_bdev_super, flags | SB_NOSEC,
-		 bdev);
+		 bdev_handle);
 	mutex_unlock(&bdev->bd_fsfreeze_mutex);
 	if (IS_ERR(s))
 		goto error_s;
@@ -1375,13 +1383,13 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 
 		/*
 		 * s_umount nests inside open_mutex during
-		 * __invalidate_device().  blkdev_put() acquires
+		 * __invalidate_device().  blkdev_handle_put() acquires
 		 * open_mutex and can't be called under s_umount.  Drop
 		 * s_umount temporarily.  This is safe as we're
 		 * holding an active reference.
 		 */
 		up_write(&s->s_umount);
-		blkdev_put(bdev, fs_type);
+		blkdev_handle_put(bdev_handle);
 		down_write(&s->s_umount);
 	} else {
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
@@ -1403,7 +1411,7 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 error_s:
 	error = PTR_ERR(s);
 error_bdev:
-	blkdev_put(bdev, fs_type);
+	blkdev_handle_put(bdev_handle);
 error:
 	return ERR_PTR(error);
 }
@@ -1416,7 +1424,7 @@ void kill_block_super(struct super_block *sb)
 	bdev->bd_super = NULL;
 	generic_shutdown_super(sb);
 	sync_blockdev(bdev);
-	blkdev_put(bdev, sb->s_type);
+	blkdev_handle_put(sb->s_bdev_handle);
 }
 
 EXPORT_SYMBOL(kill_block_super);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6867512907d6..44a224b91570 100644
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

