Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863B076D273
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbjHBPmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbjHBPlz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:41:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E1F127;
        Wed,  2 Aug 2023 08:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=t+hutzNu+OLKs7hwR5oQScZRP7h/WIsttBs8nagY2hw=; b=MfqT8apVrXwKetoTs/uxlt7j0i
        F/hdDE9Szgwzy89HXkA2LaUSRquS53mI7cSS5sNi2T+7nVXkXcwAUpiTMNP2N9BUQzVtxjNbyk/V+
        qCBQeB2jWHyLGb9su722CpdyYmQflH0nge+RxWa/9QyBGSzuoZc82mvpQI/HsRPkkYBzgHu8k5itH
        I7+ZnGg1fmJX0esEcvXm687uZ0D6tg3KVz8hVG+2M/YO7ONoljrafnhwMRZz+5DIsDtvInnEt0dKc
        uhlmNE+HbPUosHqoiBEc789L7N+kHRFooos+y6ZmJd4JNk/BCKWXPcJIKPM+Rgb0VWyHQRMGW4EdW
        SAC0HevA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRDyt-005GFa-13;
        Wed, 02 Aug 2023 15:41:47 +0000
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
Subject: [PATCH 04/12] btrfs: open block devices after superblock creation
Date:   Wed,  2 Aug 2023 17:41:23 +0200
Message-Id: <20230802154131.2221419-5-hch@lst.de>
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

Currently btrfs_mount_root opens the block devices before committing to
allocating a super block. That creates problems for restricting the
number of writers to a device, and also leads to a unusual and not very
helpful holder (the fs_type).

Reorganize the code to first look whether the superblock for a
particular fsid does already exist and open the block devices only if it
doesn't, mirror the recent changes to the VFS mount helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/super.c   | 51 ++++++++++++++++++++++------------------------
 fs/btrfs/volumes.c |  4 ++--
 2 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b318bddefd5236..5980b5dcc6b163 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1434,10 +1434,8 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
 static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		int flags, const char *device_name, void *data)
 {
-	struct block_device *bdev = NULL;
 	struct super_block *s;
 	struct btrfs_device *device = NULL;
-	struct btrfs_fs_devices *fs_devices = NULL;
 	struct btrfs_fs_info *fs_info = NULL;
 	void *new_sec_opts = NULL;
 	int error = 0;
@@ -1483,35 +1481,36 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		error = PTR_ERR(device);
 		goto error_fs_info;
 	}
-
-	fs_devices = device->fs_devices;
-	fs_info->fs_devices = fs_devices;
-
-	error = btrfs_open_devices(fs_devices, sb_open_mode(flags), fs_type);
+	fs_info->fs_devices = device->fs_devices;
 	mutex_unlock(&uuid_mutex);
-	if (error)
-		goto error_fs_info;
-
-	if (!(flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
-		error = -EACCES;
-		goto error_close_devices;
-	}
 
-	bdev = fs_devices->latest_dev->bdev;
 	s = sget(fs_type, btrfs_test_super, btrfs_set_super, flags | SB_NOSEC,
 		 fs_info);
 	if (IS_ERR(s)) {
 		error = PTR_ERR(s);
-		goto error_close_devices;
+		goto error_fs_info;
 	}
 
 	if (s->s_root) {
-		btrfs_close_devices(fs_devices);
 		btrfs_free_fs_info(fs_info);
 		if ((flags ^ s->s_flags) & SB_RDONLY)
 			error = -EBUSY;
 	} else {
-		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
+		struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+
+		error = btrfs_open_devices(fs_devices, sb_open_mode(flags),
+					   fs_type);
+		if (error)
+			goto out_deactivate;
+
+		if (!(flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
+			error = -EACCES;
+			btrfs_close_devices(fs_info->fs_devices);
+			goto out_deactivate;
+		}
+
+		snprintf(s->s_id, sizeof(s->s_id), "%pg",
+			 fs_devices->latest_dev->bdev);
 		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", fs_type->name,
 					s->s_id);
 		btrfs_sb(s)->bdev_holder = fs_type;
@@ -1519,21 +1518,19 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	}
 	if (!error)
 		error = security_sb_set_mnt_opts(s, new_sec_opts, 0, NULL);
+	if (error)
+		goto out_deactivate;
 	security_free_mnt_opts(&new_sec_opts);
-	if (error) {
-		deactivate_locked_super(s);
-		return ERR_PTR(error);
-	}
-
 	return dget(s->s_root);
 
-error_close_devices:
-	btrfs_close_devices(fs_devices);
-error_fs_info:
-	btrfs_free_fs_info(fs_info);
+out_deactivate:
+	deactivate_locked_super(s);
 error_sec_opts:
 	security_free_mnt_opts(&new_sec_opts);
 	return ERR_PTR(error);
+error_fs_info:
+	btrfs_free_fs_info(fs_info);
+	goto error_sec_opts;
 }
 
 /*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8246578c70f55b..88e9daae5e74ed 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1269,7 +1269,6 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 {
 	int ret;
 
-	lockdep_assert_held(&uuid_mutex);
 	/*
 	 * The device_list_mutex cannot be taken here in case opening the
 	 * underlying device takes further locks like open_mutex.
@@ -1277,7 +1276,7 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 	 * We also don't need the lock here as this is called during mount and
 	 * exclusion is provided by uuid_mutex
 	 */
-
+	mutex_lock(&uuid_mutex);
 	if (fs_devices->opened) {
 		fs_devices->opened++;
 		ret = 0;
@@ -1285,6 +1284,7 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		list_sort(NULL, &fs_devices->devices, devid_cmp);
 		ret = open_fs_devices(fs_devices, flags, holder);
 	}
+	mutex_unlock(&uuid_mutex);
 
 	return ret;
 }
-- 
2.39.2

