Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAF576D261
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbjHBPl5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbjHBPlu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:41:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F75EE;
        Wed,  2 Aug 2023 08:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XnpsdZtpyIJaScQ5NhvJitYDj8RzkQAdmUbC7tO240g=; b=moDSih/fwZ/ce0Ve1LXdFc0m8L
        iSvuVeExi91q1m3s2Iou36pDkNYIkeUEUD2rJAGrBOpXtvAFCX9sxuMGF3gzFuSkPGBwBV/cburHF
        E75407Qm9yEWNVapmncdD+w/8lxmK7gukVYRR/DY9xsBMrZcd+AJJ2QyNw9LxSMnYXuqAiQ/q+F1f
        9DM2cn7JLLYY+gl4CqGTevvJB1O9CIjNJAbIJ4pNo9eV0ruEai++QSPcY+gYL7weOo7vwc0o7B5c+
        Yn6vpPxgtUlcTvjn6HiHjqPK2RW7keOHHYnX5/iBs/MfeMw9E6cywXBAMgQZbRawpS5kmTrhkIeyU
        M/w93iLw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRDyn-005GEZ-2D;
        Wed, 02 Aug 2023 15:41:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 02/12] nilfs2: use setup_bdev_super to de-duplicate the mount code
Date:   Wed,  2 Aug 2023 17:41:21 +0200
Message-Id: <20230802154131.2221419-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802154131.2221419-1-hch@lst.de>
References: <20230802154131.2221419-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the generic setup_bdev_super helper to open the main block device
and do various bits of superblock setup instead of duplicating the
logic.  This includes moving to the new scheme implemented in common
code that only opens the block device after the superblock has allocated.

It does not yet convert nilfs2 to the new mount API, but doing so will
become a bit simpler after this first step.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nilfs2/super.c | 81 ++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 51 deletions(-)

diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 0ef8c71bde8e5f..a5d1fa4e7552f6 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -35,6 +35,7 @@
 #include <linux/writeback.h>
 #include <linux/seq_file.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 #include "nilfs.h"
 #include "export.h"
 #include "mdt.h"
@@ -1216,7 +1217,6 @@ static int nilfs_remount(struct super_block *sb, int *flags, char *data)
 }
 
 struct nilfs_super_data {
-	struct block_device *bdev;
 	__u64 cno;
 	int flags;
 };
@@ -1283,64 +1283,49 @@ static int nilfs_identify(char *data, struct nilfs_super_data *sd)
 
 static int nilfs_set_bdev_super(struct super_block *s, void *data)
 {
-	s->s_bdev = data;
-	s->s_dev = s->s_bdev->bd_dev;
+	s->s_dev = *(dev_t *)data;
 	return 0;
 }
 
 static int nilfs_test_bdev_super(struct super_block *s, void *data)
 {
-	return (void *)s->s_bdev == data;
+	return !(s->s_iflags & SB_I_RETIRED) && s->s_dev == *(dev_t *)data;
 }
 
 static struct dentry *
 nilfs_mount(struct file_system_type *fs_type, int flags,
 	     const char *dev_name, void *data)
 {
-	struct nilfs_super_data sd;
+	struct nilfs_super_data sd = { .flags = flags };
 	struct super_block *s;
-	struct dentry *root_dentry;
-	int err, s_new = false;
+	dev_t dev;
+	int err;
 
-	sd.bdev = blkdev_get_by_path(dev_name, sb_open_mode(flags), fs_type,
-				     NULL);
-	if (IS_ERR(sd.bdev))
-		return ERR_CAST(sd.bdev);
+	if (nilfs_identify(data, &sd))
+		return ERR_PTR(-EINVAL);
 
-	sd.cno = 0;
-	sd.flags = flags;
-	if (nilfs_identify((char *)data, &sd)) {
-		err = -EINVAL;
-		goto failed;
-	}
+	err = lookup_bdev(dev_name, &dev);
+	if (err)
+		return ERR_PTR(err);
 
-	/*
-	 * once the super is inserted into the list by sget, s_umount
-	 * will protect the lockfs code from trying to start a snapshot
-	 * while we are mounting
-	 */
-	mutex_lock(&sd.bdev->bd_fsfreeze_mutex);
-	if (sd.bdev->bd_fsfreeze_count > 0) {
-		mutex_unlock(&sd.bdev->bd_fsfreeze_mutex);
-		err = -EBUSY;
-		goto failed;
-	}
 	s = sget(fs_type, nilfs_test_bdev_super, nilfs_set_bdev_super, flags,
-		 sd.bdev);
-	mutex_unlock(&sd.bdev->bd_fsfreeze_mutex);
-	if (IS_ERR(s)) {
-		err = PTR_ERR(s);
-		goto failed;
-	}
+		 &dev);
+	if (IS_ERR(s))
+		return ERR_CAST(s);
 
 	if (!s->s_root) {
-		s_new = true;
-
-		/* New superblock instance created */
-		snprintf(s->s_id, sizeof(s->s_id), "%pg", sd.bdev);
-		sb_set_blocksize(s, block_size(sd.bdev));
-
-		err = nilfs_fill_super(s, data, flags & SB_SILENT ? 1 : 0);
+		/*
+		 * We drop s_umount here because we need to open the bdev and
+		 * bdev->open_mutex ranks above s_umount (blkdev_put() ->
+		 * __invalidate_device()). It is safe because we have active sb
+		 * reference and SB_BORN is not set yet.
+		 */
+		up_write(&s->s_umount);
+		err = setup_bdev_super(s, flags, NULL);
+		down_write(&s->s_umount);
+		if (!err)
+			err = nilfs_fill_super(s, data,
+					       flags & SB_SILENT ? 1 : 0);
 		if (err)
 			goto failed_super;
 
@@ -1366,24 +1351,18 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 	}
 
 	if (sd.cno) {
+		struct dentry *root_dentry;
+
 		err = nilfs_attach_snapshot(s, sd.cno, &root_dentry);
 		if (err)
 			goto failed_super;
-	} else {
-		root_dentry = dget(s->s_root);
+		return root_dentry;
 	}
 
-	if (!s_new)
-		blkdev_put(sd.bdev, fs_type);
-
-	return root_dentry;
+	return dget(s->s_root);
 
  failed_super:
 	deactivate_locked_super(s);
-
- failed:
-	if (!s_new)
-		blkdev_put(sd.bdev, fs_type);
 	return ERR_PTR(err);
 }
 
-- 
2.39.2

