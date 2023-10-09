Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162777BDC2D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 14:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376350AbjJIMel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 08:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346619AbjJIMec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:34:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2AD9D;
        Mon,  9 Oct 2023 05:33:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADF6C433C9;
        Mon,  9 Oct 2023 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696854836;
        bh=A//yTkylSaachSiYQ/ZpN4wnTcAW8EWJ8nOqinGABEs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=nr6oVdxBU2Bwgsdto+Qqpa+niWuHwbhdGLHKNcOtNlGCh6G7Pf2GpSgBjSYBwgt3N
         PZSmu722SHEOmCintCDq01mlKggSkU2x3UVdYr0t0wrN6lPGhAu82nfY/0KM8N2Xeg
         iOgFyjzUylyPInj96KHKMmRXnZ2NEz3d1toDyUC1rwd/LKJxYH8Rg2v0FZjtVxQMG6
         0fIrqfdPiF35HTDlOlOZzBrYFOa2N1n3MIjnFCYxNWnIfPvaQYky0yoqxeT2+t36Ir
         vk/KQp69KM4TGWXrNwDHZwU/E5J/mRlQuFA/1o1FqV+v9rUJ7daHEXn83JqU5PJoKJ
         K08ADa9OHgjIQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 09 Oct 2023 14:33:39 +0200
Subject: [PATCH 2/4] reiserfs: centralize freeing of reiserfs info
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231009-vfs-fixes-reiserfs-v1-2-723a2f1132ce@kernel.org>
References: <20231009-vfs-fixes-reiserfs-v1-0-723a2f1132ce@kernel.org>
In-Reply-To: <20231009-vfs-fixes-reiserfs-v1-0-723a2f1132ce@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     reiserfs-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945; i=brauner@kernel.org;
 h=from:subject:message-id; bh=A//yTkylSaachSiYQ/ZpN4wnTcAW8EWJ8nOqinGABEs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQqf9afP7dxiedVvTWzWiL6tJ8+mm+a3T3fpdGi9qRZ68W0
 jA7ejlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInwFDL8r6p9yOdn8djr8J/aZfP0e+
 RMJnQHN922ei7av/DNlgCfSYwMNy7f3n/l8ov9kewdVwQ0jd0Tz7U+YnKbzrt88ivD7053eAE=
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

Currently the reiserfs info is free in multiple locations:

* in reiserfs_fill_super() if reiserfs_fill_super() fails
* in reiserfs_put_super() when reiserfs is shut down and
  reiserfs_fill_super() had succeeded

Stop duplicating this logic and always free reiserfs info in
reiserfs_kill_sb().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/reiserfs/super.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 7eaf36b3de12..6db8ed10a78d 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -549,7 +549,9 @@ int remove_save_link(struct inode *inode, int truncate)
 
 static void reiserfs_kill_sb(struct super_block *s)
 {
-	if (REISERFS_SB(s)) {
+	struct reiserfs_sb_info *sbi = REISERFS_SB(s);
+
+	if (sbi) {
 		reiserfs_proc_info_done(s);
 		/*
 		 * Force any pending inode evictions to occur now. Any
@@ -561,13 +563,16 @@ static void reiserfs_kill_sb(struct super_block *s)
 		 */
 		shrink_dcache_sb(s);
 
-		dput(REISERFS_SB(s)->xattr_root);
-		REISERFS_SB(s)->xattr_root = NULL;
-		dput(REISERFS_SB(s)->priv_root);
-		REISERFS_SB(s)->priv_root = NULL;
+		dput(sbi->xattr_root);
+		sbi->xattr_root = NULL;
+		dput(sbi->priv_root);
+		sbi->priv_root = NULL;
 	}
 
 	kill_block_super(s);
+
+	kfree(sbi);
+	s->s_fs_info = NULL;
 }
 
 #ifdef CONFIG_QUOTA
@@ -630,8 +635,6 @@ static void reiserfs_put_super(struct super_block *s)
 	mutex_destroy(&REISERFS_SB(s)->lock);
 	destroy_workqueue(REISERFS_SB(s)->commit_wq);
 	kfree(REISERFS_SB(s)->s_jdev);
-	kfree(s->s_fs_info);
-	s->s_fs_info = NULL;
 }
 
 static struct kmem_cache *reiserfs_inode_cachep;
@@ -2240,9 +2243,6 @@ static int reiserfs_fill_super(struct super_block *s, void *data, int silent)
 	}
 #endif
 	kfree(sbi->s_jdev);
-	kfree(sbi);
-
-	s->s_fs_info = NULL;
 	return errval;
 }
 

-- 
2.34.1

