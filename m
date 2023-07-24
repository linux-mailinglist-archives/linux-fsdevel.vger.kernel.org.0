Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B7275FE89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 19:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjGXRyL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 13:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjGXRxt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:53:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48323A86
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 10:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=jeQcCS4x4PD195HAWiMprQyGM+IXXxihL+gczqsICvU=; b=Lx7f2YuUVs81q7yilqmDXrNP/1
        hk/RQm30VcHD1WPkU3q2+gDPRmJVh9byw2Rbtc379Q3SsW+dXce0Y+E7In1+2DEMcEdIQpNoa6+tN
        4oJJW+Uz5lljvAnJxYJSadDK9WgoJEhpZNiNVKlS1dgtFvsxuXeyY8ZRFt4hwFMiT7U9X35gA36Jo
        Z7BXanRPPVa/jOwWZmY1QFB1SI17GCEHaBo3uzIeM98pUreUxz1tAbuRvLpcwVmIPIeFxoqsGcM77
        UYIRuOqy2ARLIzeeEojxHG23T1N77u1JbidSTITsA1GoywVGED5R5Ex8e8674yvs1LBdojmrkh4A8
        83c10KEQ==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNzik-00579Y-0A;
        Mon, 24 Jul 2023 17:51:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: open the block device after allocation the super_block
Date:   Mon, 24 Jul 2023 10:51:45 -0700
Message-Id: <20230724175145.201318-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

Currently get_tree_bdev and mount_bdev open the block device before
commiting to allocating a super block.  This means the block device
is opened even for bind mounts and other reuses of the super_block.

That creates problems for restricting the number of writers to a device,
and also leads to a unusual and not very helpful holder (the fs_type).

Reorganize the mount code to first look whether the superblock for a
particular device is already mounted and open the block device only if
it is not.

Signed-off-by: Jan Kara <jack@suse.cz>
[hch: port to before the bdev_handle changes,
      duplicate the bdev read-only check from blkdev_get_by_path,
      extend the fsfree_mutex coverage to protect against freezes,
      fix an open bdev leak when the bdev is frozen,
      use the bdev local variable more,
      rename the s variable to sb to be more descriptive]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---

So I promised to get a series that builds on top of this ready, but
I'm way to busy and this will take a while.  Getting this reworked
version of Jan's patch out for everyone to use it as a based given
that Christian is back from vacation, and I think Jan should be about
back now as well.

 fs/super.c | 194 +++++++++++++++++++++++++++--------------------------
 1 file changed, 98 insertions(+), 96 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index e781226e28800c..3ef39df5bec506 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1228,12 +1228,7 @@ static const struct blk_holder_ops fs_holder_ops = {
 
 static int set_bdev_super(struct super_block *s, void *data)
 {
-	s->s_bdev = data;
-	s->s_dev = s->s_bdev->bd_dev;
-	s->s_bdi = bdi_get(s->s_bdev->bd_disk->bdi);
-
-	if (bdev_stable_writes(s->s_bdev))
-		s->s_iflags |= SB_I_STABLE_WRITES;
+	s->s_dev = *(dev_t *)data;
 	return 0;
 }
 
@@ -1244,7 +1239,61 @@ static int set_bdev_super_fc(struct super_block *s, struct fs_context *fc)
 
 static int test_bdev_super_fc(struct super_block *s, struct fs_context *fc)
 {
-	return !(s->s_iflags & SB_I_RETIRED) && s->s_bdev == fc->sget_key;
+	return !(s->s_iflags & SB_I_RETIRED) &&
+		s->s_dev == *(dev_t *)fc->sget_key;
+}
+
+static int setup_bdev_super(struct super_block *sb, int sb_flags,
+		struct fs_context *fc)
+{
+	blk_mode_t mode = sb_open_mode(sb_flags);
+	struct block_device *bdev;
+
+	bdev = blkdev_get_by_dev(sb->s_dev, mode, sb->s_type, &fs_holder_ops);
+	if (IS_ERR(bdev)) {
+		if (fc)
+			errorf(fc, "%s: Can't open blockdev", fc->source);
+		return PTR_ERR(bdev);
+	}
+
+	/*
+	 * This really should be in blkdev_get_by_dev, but right now can't due
+	 * to legacy issues that require us to allow opening a block device node
+	 * writable from userspace even for a read-only block device.
+	 */
+	if ((mode & BLK_OPEN_WRITE) && bdev_read_only(bdev)) {
+		blkdev_put(bdev, sb->s_type);
+		return -EACCES;
+	}
+
+	/*
+	 * Until SB_BORN flag is set, there can be no active superblock
+	 * references and thus no filesystem freezing. get_active_super() will
+	 * just loop waiting for SB_BORN so even freeze_bdev() cannot proceed.
+	 *
+	 * It is enough to check bdev was not frozen before we set s_bdev.
+	 */
+	mutex_lock(&bdev->bd_fsfreeze_mutex);
+	if (bdev->bd_fsfreeze_count > 0) {
+		mutex_unlock(&bdev->bd_fsfreeze_mutex);
+		if (fc)
+			warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
+		blkdev_put(bdev, sb->s_type);
+		return -EBUSY;
+	}
+	spin_lock(&sb_lock);
+	sb->s_bdev = bdev;
+	sb->s_bdi = bdi_get(bdev->bd_disk->bdi);
+	if (bdev_stable_writes(bdev))
+		sb->s_iflags |= SB_I_STABLE_WRITES;
+	spin_unlock(&sb_lock);
+	mutex_unlock(&bdev->bd_fsfreeze_mutex);
+
+	snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
+	shrinker_debugfs_rename(&sb->s_shrink, "sb-%s:%s", sb->s_type->name,
+				sb->s_id);
+	sb_set_blocksize(sb, block_size(bdev));
+	return 0;
 }
 
 /**
@@ -1256,73 +1305,50 @@ int get_tree_bdev(struct fs_context *fc,
 		int (*fill_super)(struct super_block *,
 				  struct fs_context *))
 {
-	struct block_device *bdev;
 	struct super_block *s;
 	int error = 0;
+	dev_t dev;
 
 	if (!fc->source)
 		return invalf(fc, "No source specified");
 
-	bdev = blkdev_get_by_path(fc->source, sb_open_mode(fc->sb_flags),
-				  fc->fs_type, &fs_holder_ops);
-	if (IS_ERR(bdev)) {
-		errorf(fc, "%s: Can't open blockdev", fc->source);
-		return PTR_ERR(bdev);
-	}
-
-	/* Once the superblock is inserted into the list by sget_fc(), s_umount
-	 * will protect the lockfs code from trying to start a snapshot while
-	 * we are mounting
-	 */
-	mutex_lock(&bdev->bd_fsfreeze_mutex);
-	if (bdev->bd_fsfreeze_count > 0) {
-		mutex_unlock(&bdev->bd_fsfreeze_mutex);
-		warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
-		blkdev_put(bdev, fc->fs_type);
-		return -EBUSY;
+	error = lookup_bdev(fc->source, &dev);
+	if (error) {
+		errorf(fc, "%s: Can't lookup blockdev", fc->source);
+		return error;
 	}
 
 	fc->sb_flags |= SB_NOSEC;
-	fc->sget_key = bdev;
+	fc->sget_key = &dev;
 	s = sget_fc(fc, test_bdev_super_fc, set_bdev_super_fc);
-	mutex_unlock(&bdev->bd_fsfreeze_mutex);
-	if (IS_ERR(s)) {
-		blkdev_put(bdev, fc->fs_type);
+	if (IS_ERR(s))
 		return PTR_ERR(s);
-	}
 
 	if (s->s_root) {
 		/* Don't summarily change the RO/RW state. */
 		if ((fc->sb_flags ^ s->s_flags) & SB_RDONLY) {
-			warnf(fc, "%pg: Can't mount, would change RO state", bdev);
+			warnf(fc, "%pg: Can't mount, would change RO state", s->s_bdev);
 			deactivate_locked_super(s);
-			blkdev_put(bdev, fc->fs_type);
 			return -EBUSY;
 		}
-
+	} else {
 		/*
-		 * s_umount nests inside open_mutex during
-		 * __invalidate_device().  blkdev_put() acquires
-		 * open_mutex and can't be called under s_umount.  Drop
-		 * s_umount temporarily.  This is safe as we're
-		 * holding an active reference.
+		 * We drop s_umount here because we need to open the bdev and
+		 * bdev->open_mutex ranks above s_umount (blkdev_put() ->
+		 * __invalidate_device()). It is safe because we have active sb
+		 * reference and SB_BORN is not set yet.
 		 */
 		up_write(&s->s_umount);
-		blkdev_put(bdev, fc->fs_type);
+		error = setup_bdev_super(s, fc->sb_flags, fc);
 		down_write(&s->s_umount);
-	} else {
-		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
-		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s",
-					fc->fs_type->name, s->s_id);
-		sb_set_blocksize(s, block_size(bdev));
-		error = fill_super(s, fc);
+		if (!error)
+			error = fill_super(s, fc);
 		if (error) {
 			deactivate_locked_super(s);
 			return error;
 		}
-
 		s->s_flags |= SB_ACTIVE;
-		bdev->bd_super = s;
+		s->s_bdev->bd_super = s;
 	}
 
 	BUG_ON(fc->root);
@@ -1333,79 +1359,53 @@ EXPORT_SYMBOL(get_tree_bdev);
 
 static int test_bdev_super(struct super_block *s, void *data)
 {
-	return !(s->s_iflags & SB_I_RETIRED) && (void *)s->s_bdev == data;
+	return !(s->s_iflags & SB_I_RETIRED) && s->s_dev == *(dev_t *)data;
 }
 
 struct dentry *mount_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int))
 {
-	struct block_device *bdev;
 	struct super_block *s;
-	int error = 0;
+	int error;
+	dev_t dev;
 
-	bdev = blkdev_get_by_path(dev_name, sb_open_mode(flags), fs_type,
-				  &fs_holder_ops);
-	if (IS_ERR(bdev))
-		return ERR_CAST(bdev);
+	error = lookup_bdev(dev_name, &dev);
+	if (error)
+		return ERR_PTR(error);
 
-	/*
-	 * once the super is inserted into the list by sget, s_umount
-	 * will protect the lockfs code from trying to start a snapshot
-	 * while we are mounting
-	 */
-	mutex_lock(&bdev->bd_fsfreeze_mutex);
-	if (bdev->bd_fsfreeze_count > 0) {
-		mutex_unlock(&bdev->bd_fsfreeze_mutex);
-		error = -EBUSY;
-		goto error_bdev;
-	}
-	s = sget(fs_type, test_bdev_super, set_bdev_super, flags | SB_NOSEC,
-		 bdev);
-	mutex_unlock(&bdev->bd_fsfreeze_mutex);
+	flags |= SB_NOSEC;
+	s = sget(fs_type, test_bdev_super, set_bdev_super, flags, &dev);
 	if (IS_ERR(s))
-		goto error_s;
+		return ERR_CAST(s);
 
 	if (s->s_root) {
 		if ((flags ^ s->s_flags) & SB_RDONLY) {
 			deactivate_locked_super(s);
-			error = -EBUSY;
-			goto error_bdev;
+			return ERR_PTR(-EBUSY);
 		}
-
+	} else {
 		/*
-		 * s_umount nests inside open_mutex during
-		 * __invalidate_device().  blkdev_put() acquires
-		 * open_mutex and can't be called under s_umount.  Drop
-		 * s_umount temporarily.  This is safe as we're
-		 * holding an active reference.
+		 * We drop s_umount here because we need to open the bdev and
+		 * bdev->open_mutex ranks above s_umount (blkdev_put() ->
+		 * __invalidate_device()). It is safe because we have active sb
+		 * reference and SB_BORN is not set yet.
 		 */
 		up_write(&s->s_umount);
-		blkdev_put(bdev, fs_type);
+		error = setup_bdev_super(s, flags, NULL);
 		down_write(&s->s_umount);
-	} else {
-		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
-		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s",
-					fs_type->name, s->s_id);
-		sb_set_blocksize(s, block_size(bdev));
-		error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
+		if (!error)
+			error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
 		if (error) {
 			deactivate_locked_super(s);
-			goto error;
+			return ERR_PTR(error);
 		}
 
 		s->s_flags |= SB_ACTIVE;
-		bdev->bd_super = s;
+		s->s_bdev->bd_super = s;
 	}
 
 	return dget(s->s_root);
-
-error_s:
-	error = PTR_ERR(s);
-error_bdev:
-	blkdev_put(bdev, fs_type);
-error:
-	return ERR_PTR(error);
 }
 EXPORT_SYMBOL(mount_bdev);
 
@@ -1413,10 +1413,12 @@ void kill_block_super(struct super_block *sb)
 {
 	struct block_device *bdev = sb->s_bdev;
 
-	bdev->bd_super = NULL;
 	generic_shutdown_super(sb);
-	sync_blockdev(bdev);
-	blkdev_put(bdev, sb->s_type);
+	if (bdev) {
+		bdev->bd_super = NULL;
+		sync_blockdev(bdev);
+		blkdev_put(bdev, sb->s_type);
+	}
 }
 
 EXPORT_SYMBOL(kill_block_super);
-- 
2.39.2

