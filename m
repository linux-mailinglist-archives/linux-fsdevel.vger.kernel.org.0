Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EA272B5DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 05:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjFLDQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 23:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbjFLDPa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:15:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8E513D;
        Sun, 11 Jun 2023 20:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7449F61DDD;
        Mon, 12 Jun 2023 03:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE226C4339C;
        Mon, 12 Jun 2023 03:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686539728;
        bh=6S3I2JdtbBod470Y373FgEPjrmviIhpS+7yicePNWWg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oxCtUWovCdToUHoIeCdsgpaeuGpFMUnlvphWpPr4Fj0RNQTrLPPwg5ITLSm/nPwdZ
         5MT9V6ykwKFCqzEuP0UIEKatQNmz8bBXT+THnSlyJiGqXtz09C7+/C9heUqO3D/H4t
         PCx497R+XwYO+abnYb3altfi1TS0AlxXZu6MX6My+deBCfLDOnZveXnDcvoYQHJrqz
         73bpYOjzPPvvZV2/P76SNL1l1KpuwXT0ms5a8uNMqwyFhlTzH35tLI2kQahjnM+aa+
         jPw7pNqu+JL9+AzyEsq+u28au2P/Pg22OytDTrqgS6TYVdYpZJMDroHe5vQp73lj0A
         s/8cK0NV5gP3g==
Subject: [PATCH 2/3] fs: wait for partially frozen filesystems
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, jack@suse.cz, hch@infradead.org,
        ruansy.fnst@fujitsu.com
Date:   Sun, 11 Jun 2023 20:15:28 -0700
Message-ID: <168653972832.755178.18389114450766371923.stgit@frogsfrogsfrogs>
In-Reply-To: <168653971691.755178.4003354804404850534.stgit@frogsfrogsfrogs>
References: <168653971691.755178.4003354804404850534.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Jan Kara suggested that when one thread is in the middle of freezing a
filesystem, another thread trying to freeze the same fs but with a
different freeze_holder should wait until the freezer reaches either end
state (UNFROZEN or COMPLETE) instead of returning EBUSY immediately.

Plumb in the extra coded needed to wait for the fs freezer to reach an
end state and try the freeze again.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/super.c |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)


diff --git a/fs/super.c b/fs/super.c
index 36adccecc828..151e0eeff2c2 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1647,6 +1647,15 @@ static int freeze_frozen_super(struct super_block *sb, enum freeze_holder who)
 	return 0;
 }
 
+static void wait_for_partially_frozen(struct super_block *sb)
+{
+	up_write(&sb->s_umount);
+	wait_var_event(&sb->s_writers.frozen,
+			sb->s_writers.frozen == SB_UNFROZEN ||
+			sb->s_writers.frozen == SB_FREEZE_COMPLETE);
+	down_write(&sb->s_umount);
+}
+
 /**
  * freeze_super - lock the filesystem and force it into a consistent state
  * @sb: the super to lock
@@ -1690,11 +1699,13 @@ static int freeze_frozen_super(struct super_block *sb, enum freeze_holder who)
  */
 int freeze_super(struct super_block *sb, enum freeze_holder who)
 {
+	bool try_again = true;
 	int ret;
 
 	atomic_inc(&sb->s_active);
 	down_write(&sb->s_umount);
 
+retry:
 	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
 		ret = freeze_frozen_super(sb, who);
 		deactivate_locked_super(sb);
@@ -1702,8 +1713,14 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	}
 
 	if (sb->s_writers.frozen != SB_UNFROZEN) {
-		deactivate_locked_super(sb);
-		return -EBUSY;
+		if (!try_again) {
+			deactivate_locked_super(sb);
+			return -EBUSY;
+		}
+
+		wait_for_partially_frozen(sb);
+		try_again = false;
+		goto retry;
 	}
 
 	if (!(sb->s_flags & SB_BORN)) {
@@ -1716,6 +1733,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 		/* Nothing to do really... */
 		sb->s_writers.freeze_holders |= who;
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
+		wake_up_var(&sb->s_writers.frozen);
 		up_write(&sb->s_umount);
 		return 0;
 	}
@@ -1736,6 +1754,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 		sb->s_writers.frozen = SB_UNFROZEN;
 		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
 		wake_up(&sb->s_writers.wait_unfrozen);
+		wake_up_var(&sb->s_writers.frozen);
 		deactivate_locked_super(sb);
 		return ret;
 	}
@@ -1752,6 +1771,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 			sb->s_writers.frozen = SB_UNFROZEN;
 			sb_freeze_unlock(sb, SB_FREEZE_FS);
 			wake_up(&sb->s_writers.wait_unfrozen);
+			wake_up_var(&sb->s_writers.frozen);
 			deactivate_locked_super(sb);
 			return ret;
 		}
@@ -1762,6 +1782,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	 */
 	sb->s_writers.freeze_holders |= who;
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
+	wake_up_var(&sb->s_writers.frozen);
 	lockdep_sb_freeze_release(sb);
 	up_write(&sb->s_umount);
 	return 0;
@@ -1810,6 +1831,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 	if (sb_rdonly(sb)) {
 		sb->s_writers.freeze_holders &= ~who;
 		sb->s_writers.frozen = SB_UNFROZEN;
+		wake_up_var(&sb->s_writers.frozen);
 		goto out;
 	}
 
@@ -1828,6 +1850,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 
 	sb->s_writers.freeze_holders &= ~who;
 	sb->s_writers.frozen = SB_UNFROZEN;
+	wake_up_var(&sb->s_writers.frozen);
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
 out:
 	wake_up(&sb->s_writers.wait_unfrozen);

