Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B278A7324D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 03:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbjFPBss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 21:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbjFPBsl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 21:48:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF672972;
        Thu, 15 Jun 2023 18:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B18361F3B;
        Fri, 16 Jun 2023 01:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6EDC433B9;
        Fri, 16 Jun 2023 01:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686880118;
        bh=4zLaXA96HW2bLSFVnCDfWZHlLTxqbopTcvjR23QtHo0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EOmbRA2E72zpf9XKATF0rqYrzalCH8ggJ9sJe0S1mbjNR8Yi+/0kuQB8PpyKDqXFT
         TY+esrMcnorXHreZIZzgG8jdSuGlyUpjB/jdV7YmezI8SsXpoSvxDp9h+KVivQlvYa
         BI7tRfvGZ+nAXskXKgDbFc5b1WKIRJONKMu0NgQuS8aSebbXxlemtLLmFWiG6J5zDb
         fLmirlPzwbduSbAAJ7ueZr4p+tU37PbzBOENe/Kb3dpnZ6K5LLOQVJ11Qyq723YuZE
         YDko1JDkeOQNrc1TPHBVZvzCEGGSUFrNhNaXnRtRJ3MhNeFZxAdGo5dixHEpONdNBV
         m88rn8j0pY/sQ==
Subject: [PATCH 2/3] fs: wait for partially frozen filesystems
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, jack@suse.cz, hch@infradead.org,
        ruansy.fnst@fujitsu.com
Date:   Thu, 15 Jun 2023 18:48:38 -0700
Message-ID: <168688011838.860947.2073512011056060112.stgit@frogsfrogsfrogs>
In-Reply-To: <168688010689.860947.1788875898367401950.stgit@frogsfrogsfrogs>
References: <168688010689.860947.1788875898367401950.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Neither caller can do anything sensible with this race other than retry
but they cannot really distinguish EBUSY as in "someone other holder of
the same type has the sb already frozen" from "freezing raced with
holder of a different type".

Plumb in the extra coded needed to wait for the fs freezer to reach an
end state and try the freeze again.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/super.c |   34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)


diff --git a/fs/super.c b/fs/super.c
index 81fb67157cba..1b8ea81788d4 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1635,6 +1635,24 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
 		percpu_up_write(sb->s_writers.rw_sem + level);
 }
 
+static int wait_for_partially_frozen(struct super_block *sb)
+{
+	int ret = 0;
+
+	do {
+		unsigned short old = sb->s_writers.frozen;
+
+		up_write(&sb->s_umount);
+		ret = wait_var_event_killable(&sb->s_writers.frozen,
+					       sb->s_writers.frozen != old);
+		down_write(&sb->s_umount);
+	} while (ret == 0 &&
+		 sb->s_writers.frozen != SB_UNFROZEN &&
+		 sb->s_writers.frozen != SB_FREEZE_COMPLETE);
+
+	return ret;
+}
+
 /**
  * freeze_super - lock the filesystem and force it into a consistent state
  * @sb: the super to lock
@@ -1686,6 +1704,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	atomic_inc(&sb->s_active);
 	down_write(&sb->s_umount);
 
+retry:
 	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
 		if (sb->s_writers.freeze_holders & who) {
 			deactivate_locked_super(sb);
@@ -1704,8 +1723,13 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	}
 
 	if (sb->s_writers.frozen != SB_UNFROZEN) {
-		deactivate_locked_super(sb);
-		return -EBUSY;
+		ret = wait_for_partially_frozen(sb);
+		if (ret) {
+			deactivate_locked_super(sb);
+			return ret;
+		}
+
+		goto retry;
 	}
 
 	if (!(sb->s_flags & SB_BORN)) {
@@ -1717,6 +1741,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 		/* Nothing to do really... */
 		sb->s_writers.freeze_holders |= who;
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
+		wake_up_var(&sb->s_writers.frozen);
 		up_write(&sb->s_umount);
 		return 0;
 	}
@@ -1737,6 +1762,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 		sb->s_writers.frozen = SB_UNFROZEN;
 		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
 		wake_up(&sb->s_writers.wait_unfrozen);
+		wake_up_var(&sb->s_writers.frozen);
 		deactivate_locked_super(sb);
 		return ret;
 	}
@@ -1753,6 +1779,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 			sb->s_writers.frozen = SB_UNFROZEN;
 			sb_freeze_unlock(sb, SB_FREEZE_FS);
 			wake_up(&sb->s_writers.wait_unfrozen);
+			wake_up_var(&sb->s_writers.frozen);
 			deactivate_locked_super(sb);
 			return ret;
 		}
@@ -1763,6 +1790,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	 */
 	sb->s_writers.freeze_holders |= who;
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
+	wake_up_var(&sb->s_writers.frozen);
 	lockdep_sb_freeze_release(sb);
 	up_write(&sb->s_umount);
 	return 0;
@@ -1803,6 +1831,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 	if (sb_rdonly(sb)) {
 		sb->s_writers.freeze_holders &= ~who;
 		sb->s_writers.frozen = SB_UNFROZEN;
+		wake_up_var(&sb->s_writers.frozen);
 		goto out;
 	}
 
@@ -1821,6 +1850,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 
 	sb->s_writers.freeze_holders &= ~who;
 	sb->s_writers.frozen = SB_UNFROZEN;
+	wake_up_var(&sb->s_writers.frozen);
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
 out:
 	wake_up(&sb->s_writers.wait_unfrozen);

