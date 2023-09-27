Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB2A7B053E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 15:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjI0NVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 09:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjI0NVt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:21:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B21F5
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 06:21:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1719C433C9;
        Wed, 27 Sep 2023 13:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695820908;
        bh=6x9XQvQKQKgR2VWtdpDr+idgrWCaL8uQrl0V0nxjp3M=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=aC2WVdQJ8HXAe8JDizM9FllqvJo4gHz6cZOUN1f+/CUMbxWNjvh2Sk2xKnMqDNZHw
         S1x4Z/yUDOkxrG8CuegxVj44TCNqNIycy4BPOV9vmdzE9eOhcRcFNOeH2tBs2LbxnO
         WbzZzuC+DlA+Z4Bie37+/xpn4QD7Sj2PmhiMIQ4Za4Jj6wecaTib9rsg9mnieyI837
         HS/rmiFaAYqXulSAgfQcCb9iHM2Qmi4M5uOSYw/YgPC2pNGqHa/u5olEEdLV4svto+
         6tu+BwHIDOXvmG+qyhY1XgP1lbeRuRST9UFSnS0OaeR9bIy1ytcUaeuL3MknMN/XQP
         Qjc4ntF1VbaYQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 27 Sep 2023 15:21:17 +0200
Subject: [PATCH 4/7] fs: remove get_active_super()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230927-vfs-super-freeze-v1-4-ecc36d9ab4d9@kernel.org>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
In-Reply-To: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2043; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6x9XQvQKQKgR2VWtdpDr+idgrWCaL8uQrl0V0nxjp3M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSK6KR4rFRZrxb7qeq0TmasLf+RmX8PhLmGsE8Tu3bt6gPB
 69JsHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMpC2dkWGE7b6l1tVhxVfifY9YVGw
 rVpvPv//h73e9L87ad0tqSGcbIcPys58UJL/WZfx2/qG/q/Cd/YxOP++bNrWKiMkGmNw8osAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function is now unused so remove it. One less function that uses
the global superblock list.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c         | 28 ----------------------------
 include/linux/fs.h |  1 -
 2 files changed, 29 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 672f1837fbef..181ac8501301 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1016,34 +1016,6 @@ void iterate_supers_type(struct file_system_type *type,
 
 EXPORT_SYMBOL(iterate_supers_type);
 
-/**
- * get_active_super - get an active reference to the superblock of a device
- * @bdev: device to get the superblock for
- *
- * Scans the superblock list and finds the superblock of the file system
- * mounted on the device given.  Returns the superblock with an active
- * reference or %NULL if none was found.
- */
-struct super_block *get_active_super(struct block_device *bdev)
-{
-	struct super_block *sb;
-
-	if (!bdev)
-		return NULL;
-
-	spin_lock(&sb_lock);
-	list_for_each_entry(sb, &super_blocks, s_list) {
-		if (sb->s_bdev == bdev) {
-			if (!grab_super(sb))
-				return NULL;
-			super_unlock_excl(sb);
-			return sb;
-		}
-	}
-	spin_unlock(&sb_lock);
-	return NULL;
-}
-
 struct super_block *user_get_super(dev_t dev, bool excl)
 {
 	struct super_block *sb;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b528f063e8ff..ad0ddc10d560 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3052,7 +3052,6 @@ extern int vfs_readlink(struct dentry *, char __user *, int);
 extern struct file_system_type *get_filesystem(struct file_system_type *fs);
 extern void put_filesystem(struct file_system_type *fs);
 extern struct file_system_type *get_fs_type(const char *name);
-extern struct super_block *get_active_super(struct block_device *bdev);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
 extern void iterate_supers(void (*)(struct super_block *, void *), void *);

-- 
2.34.1

