Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A63F780A86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 12:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376454AbjHRKyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 06:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376457AbjHRKy1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:54:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540DF121
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 03:54:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5D40639FA
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 10:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F86C433C7;
        Fri, 18 Aug 2023 10:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692356065;
        bh=YrJjS4ILneTtlZTwgcS30qpFxNslJrHPMrri7qtULR4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Aq+rCTX+Esm46Tg72XFMY/y2HSQA7MAbeM+E1CzH1yXI3y12FSlEPvbVyafl9R5F0
         MZaCwBHtAqfEL2VsMDlEsee5g4w13KGuZepc8iDbLWRCrq5Ug3cPcTHn2b9/WTF7vr
         dAKww8CfpI7LnRHCxKNiyy9WrqfUn98YvA+BRiSidjhOpkstea5LM+uMaOJ5eVW9wW
         1W0yeTVwtsziQXaY87LDyuJI501stL9fjdvhiJl3BiuxPo0cLkFTKUXeDq82G4nYq6
         FwGtui4y0Tt0JzGpmmyBoRX7HFeJrXpvhiDg0bfp7PVa7bPMCK3RvNolDvV4U4rwQG
         su0S2xoktQshw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 18 Aug 2023 12:54:16 +0200
Subject: [PATCH v2 2/4] super: make locking naming consistent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-vfs-super-fixes-v3-v2-2-cdab45934983@kernel.org>
References: <20230818-vfs-super-fixes-v3-v2-0-cdab45934983@kernel.org>
In-Reply-To: <20230818-vfs-super-fixes-v3-v2-0-cdab45934983@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=openpgp-sha256; l=4998; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YrJjS4ILneTtlZTwgcS30qpFxNslJrHPMrri7qtULR4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTc972zJtu5awfL5OC7Kcs/9F74/3uZr83B9S4M1zgylz04
 uKxVvqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAixREM/wxl36/b8dzPdsHOYgup5a
 bP2SWk1znturNM6C7n1cxbT00ZGVb+NCz62uc77ee8/R89MqdauT2/+8ffqUbCcn3WCzfv7fwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make the naming consistent with the earlier introduced
super_lock_{read,write}() helpers.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs-writeback.c |  4 ++--
 fs/internal.h     |  2 +-
 fs/super.c        | 28 ++++++++++++++--------------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index aca4b4811394..969ce991b0b0 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1953,9 +1953,9 @@ static long __writeback_inodes_wb(struct bdi_writeback *wb,
 		struct inode *inode = wb_inode(wb->b_io.prev);
 		struct super_block *sb = inode->i_sb;
 
-		if (!trylock_super(sb)) {
+		if (!super_trylock_shared(sb)) {
 			/*
-			 * trylock_super() may fail consistently due to
+			 * super_trylock_shared() may fail consistently due to
 			 * s_umount being grabbed by someone else. Don't use
 			 * requeue_io() to avoid busy retrying the inode/sb.
 			 */
diff --git a/fs/internal.h b/fs/internal.h
index b94290f61714..74d3b161dd2c 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -115,7 +115,7 @@ static inline void put_file_access(struct file *file)
  * super.c
  */
 extern int reconfigure_super(struct fs_context *);
-extern bool trylock_super(struct super_block *sb);
+extern bool super_trylock_shared(struct super_block *sb);
 struct super_block *user_get_super(dev_t, bool excl);
 void put_super(struct super_block *sb);
 extern bool mount_capable(struct fs_context *);
diff --git a/fs/super.c b/fs/super.c
index b12e2f247e1e..ba5d813c5804 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -112,7 +112,7 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 	if (!(sc->gfp_mask & __GFP_FS))
 		return SHRINK_STOP;
 
-	if (!trylock_super(sb))
+	if (!super_trylock_shared(sb))
 		return SHRINK_STOP;
 
 	if (sb->s_op->nr_cached_objects)
@@ -159,17 +159,17 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 	sb = container_of(shrink, struct super_block, s_shrink);
 
 	/*
-	 * We don't call trylock_super() here as it is a scalability bottleneck,
-	 * so we're exposed to partial setup state. The shrinker rwsem does not
-	 * protect filesystem operations backing list_lru_shrink_count() or
-	 * s_op->nr_cached_objects(). Counts can change between
-	 * super_cache_count and super_cache_scan, so we really don't need locks
-	 * here.
+	 * We don't call super_trylock_shared() here as it is a scalability
+	 * bottleneck, so we're exposed to partial setup state. The shrinker
+	 * rwsem does not protect filesystem operations backing
+	 * list_lru_shrink_count() or s_op->nr_cached_objects(). Counts can
+	 * change between super_cache_count and super_cache_scan, so we really
+	 * don't need locks here.
 	 *
 	 * However, if we are currently mounting the superblock, the underlying
 	 * filesystem might be in a state of partial construction and hence it
-	 * is dangerous to access it.  trylock_super() uses a SB_BORN check to
-	 * avoid this situation, so do the same here. The memory barrier is
+	 * is dangerous to access it.  super_trylock_shared() uses a SB_BORN check
+	 * to avoid this situation, so do the same here. The memory barrier is
 	 * matched with the one in mount_fs() as we don't hold locks here.
 	 */
 	if (!(sb->s_flags & SB_BORN))
@@ -428,7 +428,7 @@ static int grab_super(struct super_block *s) __releases(sb_lock)
 }
 
 /*
- *	trylock_super - try to grab ->s_umount shared
+ *	super_trylock_shared - try to grab ->s_umount shared
  *	@sb: reference we are trying to grab
  *
  *	Try to prevent fs shutdown.  This is used in places where we
@@ -444,7 +444,7 @@ static int grab_super(struct super_block *s) __releases(sb_lock)
  *	of down_read().  There's a couple of places that are OK with that, but
  *	it's very much not a general-purpose interface.
  */
-bool trylock_super(struct super_block *sb)
+bool super_trylock_shared(struct super_block *sb)
 {
 	if (down_read_trylock(&sb->s_umount)) {
 		if (!hlist_unhashed(&sb->s_instances) &&
@@ -1210,7 +1210,7 @@ EXPORT_SYMBOL(get_tree_keyed);
  * and the place that clears the pointer to the superblock used by this function
  * before freeing the superblock.
  */
-static bool lock_active_super(struct super_block *sb)
+static bool super_lock_shared_active(struct super_block *sb)
 {
 	super_lock_shared(sb);
 	if (!sb->s_root ||
@@ -1228,7 +1228,7 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 	/* bd_holder_lock ensures that the sb isn't freed */
 	lockdep_assert_held(&bdev->bd_holder_lock);
 
-	if (!lock_active_super(sb))
+	if (!super_lock_shared_active(sb))
 		return;
 
 	if (!surprise)
@@ -1247,7 +1247,7 @@ static void fs_bdev_sync(struct block_device *bdev)
 
 	lockdep_assert_held(&bdev->bd_holder_lock);
 
-	if (!lock_active_super(sb))
+	if (!super_lock_shared_active(sb))
 		return;
 	sync_filesystem(sb);
 	super_unlock_shared(sb);

-- 
2.34.1

