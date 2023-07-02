Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E587450AA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 21:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjGBTlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 15:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjGBTke (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:40:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D337819B3;
        Sun,  2 Jul 2023 12:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E267460C98;
        Sun,  2 Jul 2023 19:38:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FF7C433CC;
        Sun,  2 Jul 2023 19:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326735;
        bh=Svd/sYutk1veUoLSU2dpcFpUWcoxp2UK5YvrOh157q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ufn2PPIEyLAjsgo56/B8HGuNtZZiM2GLOyZpoyv/ENqoww7FU4lnnJP7JbgnnDrrT
         e9P0VGtagd4UANhF1/lqtlyM67ZfyaHdzKakw0GS/gLufZ0zAWZM4+prOc0lvDZbxI
         yzws5o50thebZtX04RjUQr+XUL9AAYrgosymtCHjElMfQSJmDyycsGAjctrcjZDMpz
         ma1isEPu6EX5Lm+OSbTB5vxO5NZQgj7XoYfMlxbvKSI747u2zzFGXQs62YKTzmh93i
         v8+iNtfKU0kabq5PaJuL7GSmj6JHs9HCyf6r66RCxw22M1S0MtnTPlp8yWiZDdJLpE
         cAAzGoguzo5FQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 16/16] fs: Provide helpers for manipulating sb->s_readonly_remount
Date:   Sun,  2 Jul 2023 15:38:15 -0400
Message-Id: <20230702193815.1775684-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702193815.1775684-1-sashal@kernel.org>
References: <20230702193815.1775684-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit d7439fb1f4338fffd0bc68bb62d78f7712725f26 ]

Provide helpers to set and clear sb->s_readonly_remount including
appropriate memory barriers. Also use this opportunity to document what
the barriers pair with and why they are needed.

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Message-Id: <20230620112832.5158-1-jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/internal.h      | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/namespace.c     | 25 ++++++++++++++++---------
 fs/super.c         | 17 ++++++-----------
 include/linux/fs.h |  2 +-
 4 files changed, 64 insertions(+), 21 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index bd3b2810a36b6..b916b84809f36 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -120,6 +120,47 @@ void put_super(struct super_block *sb);
 extern bool mount_capable(struct fs_context *);
 int sb_init_dio_done_wq(struct super_block *sb);
 
+/*
+ * Prepare superblock for changing its read-only state (i.e., either remount
+ * read-write superblock read-only or vice versa). After this function returns
+ * mnt_is_readonly() will return true for any mount of the superblock if its
+ * caller is able to observe any changes done by the remount. This holds until
+ * sb_end_ro_state_change() is called.
+ */
+static inline void sb_start_ro_state_change(struct super_block *sb)
+{
+	WRITE_ONCE(sb->s_readonly_remount, 1);
+	/*
+	 * For RO->RW transition, the barrier pairs with the barrier in
+	 * mnt_is_readonly() making sure if mnt_is_readonly() sees SB_RDONLY
+	 * cleared, it will see s_readonly_remount set.
+	 * For RW->RO transition, the barrier pairs with the barrier in
+	 * __mnt_want_write() before the mnt_is_readonly() check. The barrier
+	 * makes sure if __mnt_want_write() sees MNT_WRITE_HOLD already
+	 * cleared, it will see s_readonly_remount set.
+	 */
+	smp_wmb();
+}
+
+/*
+ * Ends section changing read-only state of the superblock. After this function
+ * returns if mnt_is_readonly() returns false, the caller will be able to
+ * observe all the changes remount did to the superblock.
+ */
+static inline void sb_end_ro_state_change(struct super_block *sb)
+{
+	/*
+	 * This barrier provides release semantics that pairs with
+	 * the smp_rmb() acquire semantics in mnt_is_readonly().
+	 * This barrier pair ensure that when mnt_is_readonly() sees
+	 * 0 for sb->s_readonly_remount, it will also see all the
+	 * preceding flag changes that were made during the RO state
+	 * change.
+	 */
+	smp_wmb();
+	WRITE_ONCE(sb->s_readonly_remount, 0);
+}
+
 /*
  * open.c
  */
diff --git a/fs/namespace.c b/fs/namespace.c
index 54847db5b8195..5ba1eca6f7208 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -309,9 +309,16 @@ static unsigned int mnt_get_writers(struct mount *mnt)
 
 static int mnt_is_readonly(struct vfsmount *mnt)
 {
-	if (mnt->mnt_sb->s_readonly_remount)
+	if (READ_ONCE(mnt->mnt_sb->s_readonly_remount))
 		return 1;
-	/* Order wrt setting s_flags/s_readonly_remount in do_remount() */
+	/*
+	 * The barrier pairs with the barrier in sb_start_ro_state_change()
+	 * making sure if we don't see s_readonly_remount set yet, we also will
+	 * not see any superblock / mount flag changes done by remount.
+	 * It also pairs with the barrier in sb_end_ro_state_change()
+	 * assuring that if we see s_readonly_remount already cleared, we will
+	 * see the values of superblock / mount flags updated by remount.
+	 */
 	smp_rmb();
 	return __mnt_is_readonly(mnt);
 }
@@ -364,9 +371,11 @@ int __mnt_want_write(struct vfsmount *m)
 		}
 	}
 	/*
-	 * After the slowpath clears MNT_WRITE_HOLD, mnt_is_readonly will
-	 * be set to match its requirements. So we must not load that until
-	 * MNT_WRITE_HOLD is cleared.
+	 * The barrier pairs with the barrier sb_start_ro_state_change() making
+	 * sure that if we see MNT_WRITE_HOLD cleared, we will also see
+	 * s_readonly_remount set (or even SB_RDONLY / MNT_READONLY flags) in
+	 * mnt_is_readonly() and bail in case we are racing with remount
+	 * read-only.
 	 */
 	smp_rmb();
 	if (mnt_is_readonly(m)) {
@@ -588,10 +597,8 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 	if (!err && atomic_long_read(&sb->s_remove_count))
 		err = -EBUSY;
 
-	if (!err) {
-		sb->s_readonly_remount = 1;
-		smp_wmb();
-	}
+	if (!err)
+		sb_start_ro_state_change(sb);
 	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
 		if (mnt->mnt.mnt_flags & MNT_WRITE_HOLD)
 			mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
diff --git a/fs/super.c b/fs/super.c
index 860d7a4b14c7c..48c29954d4875 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -944,8 +944,7 @@ int reconfigure_super(struct fs_context *fc)
 	 */
 	if (remount_ro) {
 		if (force) {
-			sb->s_readonly_remount = 1;
-			smp_wmb();
+			sb_start_ro_state_change(sb);
 		} else {
 			retval = sb_prepare_remount_readonly(sb);
 			if (retval)
@@ -953,12 +952,10 @@ int reconfigure_super(struct fs_context *fc)
 		}
 	} else if (remount_rw) {
 		/*
-		 * We set s_readonly_remount here to protect filesystem's
-		 * reconfigure code from writes from userspace until
-		 * reconfigure finishes.
+		 * Protect filesystem's reconfigure code from writes from
+		 * userspace until reconfigure finishes.
 		 */
-		sb->s_readonly_remount = 1;
-		smp_wmb();
+		sb_start_ro_state_change(sb);
 	}
 
 	if (fc->ops->reconfigure) {
@@ -974,9 +971,7 @@ int reconfigure_super(struct fs_context *fc)
 
 	WRITE_ONCE(sb->s_flags, ((sb->s_flags & ~fc->sb_flags_mask) |
 				 (fc->sb_flags & fc->sb_flags_mask)));
-	/* Needs to be ordered wrt mnt_is_readonly() */
-	smp_wmb();
-	sb->s_readonly_remount = 0;
+	sb_end_ro_state_change(sb);
 
 	/*
 	 * Some filesystems modify their metadata via some other path than the
@@ -991,7 +986,7 @@ int reconfigure_super(struct fs_context *fc)
 	return 0;
 
 cancel_readonly:
-	sb->s_readonly_remount = 0;
+	sb_end_ro_state_change(sb);
 	return retval;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6f96f99ab9511..879c000eec397 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1248,7 +1248,7 @@ struct super_block {
 	 */
 	atomic_long_t s_fsnotify_connectors;
 
-	/* Being remounted read-only */
+	/* Read-only state of the superblock is being changed */
 	int s_readonly_remount;
 
 	/* per-sb errseq_t for reporting writeback errors via syncfs */
-- 
2.39.2

