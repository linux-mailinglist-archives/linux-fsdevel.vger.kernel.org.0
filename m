Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABAE778AFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 12:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbjHKKJl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 06:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjHKKJY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:09:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A929D35B1;
        Fri, 11 Aug 2023 03:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CTqMdFsl7PwdxJLPZ9AeUTfJH8rvgbp4LcXem5+up44=; b=JuzSeA4L0WAaHf47xKgcSHhzYF
        MBvsLqD1Apf4wWfDr6ulqFSWmwDaA2wS6tW861F6QUL5172t7tRQISTrXZrgavrUfg09VeHmoT+jQ
        eez8kjHv9cJz0YlXH4V6/JYc7b+SvMH9mcAvVYXtQijYfAJiVm9lEuhl20zw6IenCWVC8uAKc6Fhl
        ydln3Zy2uetLfIKgWWfyJSK5SVT3XSeiCb1omD7RIWjBGM48nuq0wVkBk95Y9aTZN6vo/wk9Vmvfc
        r6MvbRqe5Qc3uP0RFnh6k1ZXnXBWyrQpBBryv2rkYtIYgifNOE/l4PxGmVStxbi3ahmHkrVq1PznT
        uwS+WMAA==;
Received: from [88.128.92.63] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUP4X-00A5e3-1P;
        Fri, 11 Aug 2023 10:08:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/17] btrfs: open block devices after superblock creation
Date:   Fri, 11 Aug 2023 12:08:16 +0200
Message-Id: <20230811100828.1897174-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811100828.1897174-1-hch@lst.de>
References: <20230811100828.1897174-1-hch@lst.de>
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

Currently btrfs_mount_root opens the block devices before committing to
allocating a super block. That creates problems for restricting the
number of writers to a device, and also leads to a unusual and not very
helpful holder (the fs_type).

Reorganize the code to first check whether the superblock for a
particular fsid does already exist and open the block devices only if it
doesn't, mirroring the recent changes to the VFS mount helpers.  To do
this the increment of the in_use counter moves out of btrfs_open_devices
and into the only caller in btrfs_mount_root so that it happens before
dropping uuid_mutex around the call to sget.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/super.c   | 40 +++++++++++++++++++++++-----------------
 fs/btrfs/volumes.c | 15 +++++----------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2bbc041ac2e2c5..1079a0f541790d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1434,7 +1434,6 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
 static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		int flags, const char *device_name, void *data)
 {
-	struct block_device *bdev = NULL;
 	struct super_block *s;
 	struct btrfs_device *device = NULL;
 	struct btrfs_fs_devices *fs_devices = NULL;
@@ -1486,18 +1485,9 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 
 	fs_devices = device->fs_devices;
 	fs_info->fs_devices = fs_devices;
-
-	error = btrfs_open_devices(fs_devices, sb_open_mode(flags), fs_type);
+	fs_devices->in_use++;
 	mutex_unlock(&uuid_mutex);
-	if (error)
-		goto error_fs_info;
-
-	if (!(flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
-		error = -EACCES;
-		goto error_fs_info;
-	}
 
-	bdev = fs_devices->latest_dev->bdev;
 	s = sget(fs_type, btrfs_test_super, btrfs_set_super, flags | SB_NOSEC,
 		 fs_info);
 	if (IS_ERR(s)) {
@@ -1510,7 +1500,22 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		if ((flags ^ s->s_flags) & SB_RDONLY)
 			error = -EBUSY;
 	} else {
-		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
+		struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+
+		mutex_lock(&uuid_mutex);
+		error = btrfs_open_devices(fs_devices, sb_open_mode(flags),
+					   fs_type);
+		mutex_unlock(&uuid_mutex);
+		if (error)
+			goto error_deactivate;
+
+		if (!(flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
+			error = -EACCES;
+			goto error_deactivate;
+		}
+
+		snprintf(s->s_id, sizeof(s->s_id), "%pg",
+			 fs_devices->latest_dev->bdev);
 		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", fs_type->name,
 					s->s_id);
 		btrfs_sb(s)->bdev_holder = fs_type;
@@ -1518,12 +1523,9 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	}
 	if (!error)
 		error = security_sb_set_mnt_opts(s, new_sec_opts, 0, NULL);
+	if (error)
+		goto error_deactivate;
 	security_free_mnt_opts(&new_sec_opts);
-	if (error) {
-		deactivate_locked_super(s);
-		return ERR_PTR(error);
-	}
-
 	return dget(s->s_root);
 
 error_fs_info:
@@ -1531,6 +1533,10 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 error_sec_opts:
 	security_free_mnt_opts(&new_sec_opts);
 	return ERR_PTR(error);
+
+error_deactivate:
+	deactivate_locked_super(s);
+	goto error_sec_opts;
 }
 
 /*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3ac1a3aa8939bc..b909e593c0f1bc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1272,8 +1272,6 @@ static int devid_cmp(void *priv, const struct list_head *a,
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       blk_mode_t flags, void *holder)
 {
-	int ret;
-
 	lockdep_assert_held(&uuid_mutex);
 	/*
 	 * The device_list_mutex cannot be taken here in case opening the
@@ -1282,14 +1280,11 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 	 * We also don't need the lock here as this is called during mount and
 	 * exclusion is provided by uuid_mutex
 	 */
-	if (!fs_devices->is_open) {
-		list_sort(NULL, &fs_devices->devices, devid_cmp);
-		ret = open_fs_devices(fs_devices, flags, holder);
-		if (ret)
-			return ret;
-	}
-	fs_devices->in_use++;
-	return 0;
+	ASSERT(fs_devices->in_use);
+	if (fs_devices->is_open)
+		return 0;
+	list_sort(NULL, &fs_devices->devices, devid_cmp);
+	return open_fs_devices(fs_devices, flags, holder);
 }
 
 void btrfs_release_disk_super(struct btrfs_super_block *super)
-- 
2.39.2

