Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AE97B0540
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 15:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjI0NV6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 09:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjI0NVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:21:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B23111D
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 06:21:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EE5C433CC;
        Wed, 27 Sep 2023 13:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695820911;
        bh=Ab9aMVTQyLsDIBkwuQkryPznzQAdsSK3MSBOrueCy+U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=k7vQRcLq/DcjL7CF7yzJFY2xUGadb0qyamYWdZFwVKM70lJJrPrkM/HBRFbbxL3af
         UxYKehVoL75k14tDYEcTWLT6BZZeT9KUsJBEEtnwtqm0rzJiPxqmrtRy9QMPcTu+dl
         SX4mN9Fq/gBpoLKus9HFbOFFRTIxBDCYqM7iScuUP4sK6rPiOAUki9Bv3kq+xuRU+5
         TZEwpq4YlW4ItruDYXEwSyb3Dp0CkbDiRrQrumLVWdvav+peOQRPTBGt4o4RJYI2Us
         lubasC1fBUkOcpoMlZyZ8Iknv4IG4NkVMatiZKeTuBWg5mHn6IOmS0IXE9j1EriKXV
         1M/i1RP0VNkaA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 27 Sep 2023 15:21:19 +0200
Subject: [PATCH 6/7] fs: remove unused helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230927-vfs-super-freeze-v1-6-ecc36d9ab4d9@kernel.org>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
In-Reply-To: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3152; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ab9aMVTQyLsDIBkwuQkryPznzQAdsSK3MSBOrueCy+U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSK6KRw9PUr6ky4NG322xWSn1v2yXSsKvvQ/nHH5Mv7Y0tv
 ddZd6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIya8Mf2Xvn0+99dDsTeUSd2tW9g
 87Z0R3nNbeEaAk8s/v7f3VC9IY/nusXv3xVHXzBxmmteKp2R8uyq89zRfxaGn0g0muSRYVDgwA
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

The grab_super() helper is now only used by grab_super_dead(). Merge the
two helpers into one.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c | 44 +++++++-------------------------------------
 1 file changed, 7 insertions(+), 37 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 181ac8501301..6cdce2b31622 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -517,35 +517,6 @@ void deactivate_super(struct super_block *s)
 
 EXPORT_SYMBOL(deactivate_super);
 
-/**
- *	grab_super - acquire an active reference
- *	@s: reference we are trying to make active
- *
- *	Tries to acquire an active reference.  grab_super() is used when we
- * 	had just found a superblock in super_blocks or fs_type->fs_supers
- *	and want to turn it into a full-blown active reference.  grab_super()
- *	is called with sb_lock held and drops it.  Returns 1 in case of
- *	success, 0 if we had failed (superblock contents was already dead or
- *	dying when grab_super() had been called).  Note that this is only
- *	called for superblocks not in rundown mode (== ones still on ->fs_supers
- *	of their type), so increment of ->s_count is OK here.
- */
-static int grab_super(struct super_block *s) __releases(sb_lock)
-{
-	bool born;
-
-	s->s_count++;
-	spin_unlock(&sb_lock);
-	born = super_lock_excl(s);
-	if (born && atomic_inc_not_zero(&s->s_active)) {
-		put_super(s);
-		return 1;
-	}
-	super_unlock_excl(s);
-	put_super(s);
-	return 0;
-}
-
 static inline bool wait_dead(struct super_block *sb)
 {
 	unsigned int flags;
@@ -559,7 +530,7 @@ static inline bool wait_dead(struct super_block *sb)
 }
 
 /**
- * grab_super_dead - acquire an active reference to a superblock
+ * grab_super - acquire an active reference to a superblock
  * @sb: superblock to acquire
  *
  * Acquire a temporary reference on a superblock and try to trade it for
@@ -570,17 +541,16 @@ static inline bool wait_dead(struct super_block *sb)
  * Return: This returns true if an active reference could be acquired,
  *         false if not.
  */
-static bool grab_super_dead(struct super_block *sb)
+static bool grab_super(struct super_block *sb)
 {
-
 	sb->s_count++;
-	if (grab_super(sb)) {
+	spin_unlock(&sb_lock);
+	if (super_lock_excl(sb) && atomic_inc_not_zero(&sb->s_active)) {
 		put_super(sb);
-		lockdep_assert_held(&sb->s_umount);
 		return true;
 	}
+	super_unlock_excl(sb);
 	wait_var_event(&sb->s_flags, wait_dead(sb));
-	lockdep_assert_not_held(&sb->s_umount);
 	put_super(sb);
 	return false;
 }
@@ -831,7 +801,7 @@ struct super_block *sget_fc(struct fs_context *fc,
 			warnfc(fc, "reusing existing filesystem in another namespace not allowed");
 		return ERR_PTR(-EBUSY);
 	}
-	if (!grab_super_dead(old))
+	if (!grab_super(old))
 		goto retry;
 	destroy_unused_super(s);
 	return old;
@@ -875,7 +845,7 @@ struct super_block *sget(struct file_system_type *type,
 				destroy_unused_super(s);
 				return ERR_PTR(-EBUSY);
 			}
-			if (!grab_super_dead(old))
+			if (!grab_super(old))
 				goto retry;
 			destroy_unused_super(s);
 			return old;

-- 
2.34.1

