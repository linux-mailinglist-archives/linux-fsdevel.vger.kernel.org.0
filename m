Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2820751253
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 23:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjGLVMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 17:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjGLVLw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:11:52 -0400
Received: from out-8.mta1.migadu.com (out-8.mta1.migadu.com [95.215.58.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3722137
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 14:11:37 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689196296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jc2SO8yppwSj4LTOdw7pEtUw5DPvO0BD0neLLA1eie4=;
        b=s1P/VlJCkP6nWpZXb8P2qpMrK2E5GptKP03iEZZ+5S69GPw6QK9wR1D+R8zg54inmhxoZA
        oDrk+4rwKdSWH7Gh5Aw/mk4bS31lJHTNRpCVgZikGAik0uItELZCV0/ZzZyl6JQKCH8A60
        1/8tXjhPPZD0zOgu/ZM8kEpqDmsBokw=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/20] block: Don't block on s_umount from __invalidate_super()
Date:   Wed, 12 Jul 2023 17:11:02 -0400
Message-Id: <20230712211115.2174650-8-kent.overstreet@linux.dev>
In-Reply-To: <20230712211115.2174650-1-kent.overstreet@linux.dev>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__invalidate_super() is used to flush any filesystem mounted on a
device, generally on some sort of media change event.

However, when unmounting a filesystem and closing the underlying block
devices, we can deadlock if the block driver then calls
__invalidate_device() (e.g. because the block device goes away when it
is no longer in use).

This happens with bcachefs on top of loopback, and can be triggered by
fstests generic/042:

  put_super
    -> blkdev_put
    -> lo_release
    -> disk_force_media_change
    -> __invalidate_device
    -> get_super

This isn't inherently specific to bcachefs - it hasn't shown up with
other filesystems before because most other filesystems use the sget()
mechanism for opening/closing block devices (and enforcing exclusion),
however sget() has its own downsides and weird/sketchy behaviour w.r.t.
block device open lifetime - if that ever gets fixed more code will run
into this issue.

The __invalidate_device() call here is really a best effort "I just
yanked the device for a mounted filesystem, please try not to lose my
data" - if it's ever actually needed the user has already done something
crazy, and we probably shouldn't make things worse by deadlocking.
Switching to a trylock seems in keeping with what the code is trying to
do.

If we ever get revoke() at the block layer, perhaps we would look at
rearchitecting to use that instead.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
---
 block/bdev.c       |  2 +-
 fs/super.c         | 40 +++++++++++++++++++++++++++++++---------
 include/linux/fs.h |  1 +
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 21c63bfef3..a4d7e8732c 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -934,7 +934,7 @@ EXPORT_SYMBOL(lookup_bdev);
 
 int __invalidate_device(struct block_device *bdev, bool kill_dirty)
 {
-	struct super_block *sb = get_super(bdev);
+	struct super_block *sb = try_get_super(bdev);
 	int res = 0;
 
 	if (sb) {
diff --git a/fs/super.c b/fs/super.c
index 04bc62ab7d..a2decce02f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -791,14 +791,7 @@ void iterate_supers_type(struct file_system_type *type,
 
 EXPORT_SYMBOL(iterate_supers_type);
 
-/**
- * get_super - get the superblock of a device
- * @bdev: device to get the superblock for
- *
- * Scans the superblock list and finds the superblock of the file system
- * mounted on the device given. %NULL is returned if no match is found.
- */
-struct super_block *get_super(struct block_device *bdev)
+static struct super_block *__get_super(struct block_device *bdev, bool try)
 {
 	struct super_block *sb;
 
@@ -813,7 +806,12 @@ struct super_block *get_super(struct block_device *bdev)
 		if (sb->s_bdev == bdev) {
 			sb->s_count++;
 			spin_unlock(&sb_lock);
-			down_read(&sb->s_umount);
+
+			if (!try)
+				down_read(&sb->s_umount);
+			else if (!down_read_trylock(&sb->s_umount))
+				return NULL;
+
 			/* still alive? */
 			if (sb->s_root && (sb->s_flags & SB_BORN))
 				return sb;
@@ -828,6 +826,30 @@ struct super_block *get_super(struct block_device *bdev)
 	return NULL;
 }
 
+/**
+ * get_super - get the superblock of a device
+ * @bdev: device to get the superblock for
+ *
+ * Scans the superblock list and finds the superblock of the file system
+ * mounted on the device given. %NULL is returned if no match is found.
+ */
+struct super_block *get_super(struct block_device *bdev)
+{
+	return __get_super(bdev, false);
+}
+
+/**
+ * try_get_super - get the superblock of a device, using trylock on sb->s_umount
+ * @bdev: device to get the superblock for
+ *
+ * Scans the superblock list and finds the superblock of the file system
+ * mounted on the device given. %NULL is returned if no match is found.
+ */
+struct super_block *try_get_super(struct block_device *bdev)
+{
+	return __get_super(bdev, true);
+}
+
 /**
  * get_active_super - get an active reference to the superblock of a device
  * @bdev: device to get the superblock for
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 133f0640fb..bd5105bc92 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2897,6 +2897,7 @@ extern struct file_system_type *get_filesystem(struct file_system_type *fs);
 extern void put_filesystem(struct file_system_type *fs);
 extern struct file_system_type *get_fs_type(const char *name);
 extern struct super_block *get_super(struct block_device *);
+extern struct super_block *try_get_super(struct block_device *);
 extern struct super_block *get_active_super(struct block_device *bdev);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
-- 
2.40.1

