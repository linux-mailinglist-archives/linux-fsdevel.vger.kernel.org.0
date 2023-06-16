Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD5B7324D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 03:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbjFPBsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 21:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjFPBst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 21:48:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF7D2D67;
        Thu, 15 Jun 2023 18:48:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60B5261553;
        Fri, 16 Jun 2023 01:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923BAC433C8;
        Fri, 16 Jun 2023 01:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686880124;
        bh=xsx6Yu6/R/mr2B1euqXaI9AVloEXHAQ0IJcDERIhcXU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nNvpPLuChuSi0yscoHZWtnN9jmHtKlbP58dJviyUcnqqSz4mL1HsC/9wbjK6OFo1C
         w5vbsCaWmdz1vKXLYsptvmHb0SBiqRUOSQv2jEWLHKWUpPmbCH3EQexEN2kThBm1gR
         5uyHr28p6apFV+hLqVRHkndLgJxSJBICRREgR7EM9AvcHbI3VNtc4HQwrPQSHRzdBH
         VMvQtU7D9Mc134IqK7a9vibpnO4iVHUNACqgyN3051bmEHbyX/C7+3/RbkHvAt14OY
         FUU4BVo+BjRyXMwyMPPnp5RsRXHHIhxcVfx2VrJggx5Ya7X2rlT3qx2+PTw+Ew7bxs
         nu7LYMSJYDjgg==
Subject: [PATCH 3/3] fs: Drop wait_unfrozen wait queue
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mcgrof@kernel.org, jack@suse.cz,
        hch@infradead.org, ruansy.fnst@fujitsu.com
Date:   Thu, 15 Jun 2023 18:48:44 -0700
Message-ID: <168688012399.860947.1514236710068241356.stgit@frogsfrogsfrogs>
In-Reply-To: <168688010689.860947.1788875898367401950.stgit@frogsfrogsfrogs>
References: <168688010689.860947.1788875898367401950.stgit@frogsfrogsfrogs>
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

From: Jan Kara <jack@suse.cz>

wait_unfrozen waitqueue is used only in quota code to wait for
filesystem to become unfrozen. In that place we can just use
sb_start_write() - sb_end_write() pair to achieve the same. So just
remove the waitqueue.

Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/quota/quota.c   |    5 +++--
 fs/super.c         |    4 ----
 include/linux/fs.h |    1 -
 3 files changed, 3 insertions(+), 7 deletions(-)


diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 052f143e2e0e..0e41fb84060f 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -895,8 +895,9 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
 			up_write(&sb->s_umount);
 		else
 			up_read(&sb->s_umount);
-		wait_event(sb->s_writers.wait_unfrozen,
-			   sb->s_writers.frozen == SB_UNFROZEN);
+		/* Wait for sb to unfreeze */
+		sb_start_write(sb);
+		sb_end_write(sb);
 		put_super(sb);
 		goto retry;
 	}
diff --git a/fs/super.c b/fs/super.c
index 1b8ea81788d4..603cc1672032 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -236,7 +236,6 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 					&type->s_writers_key[i]))
 			goto fail;
 	}
-	init_waitqueue_head(&s->s_writers.wait_unfrozen);
 	s->s_bdi = &noop_backing_dev_info;
 	s->s_flags = flags;
 	if (s->s_user_ns != &init_user_ns)
@@ -1761,7 +1760,6 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	if (ret) {
 		sb->s_writers.frozen = SB_UNFROZEN;
 		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
-		wake_up(&sb->s_writers.wait_unfrozen);
 		wake_up_var(&sb->s_writers.frozen);
 		deactivate_locked_super(sb);
 		return ret;
@@ -1778,7 +1776,6 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 				"VFS:Filesystem freeze failed\n");
 			sb->s_writers.frozen = SB_UNFROZEN;
 			sb_freeze_unlock(sb, SB_FREEZE_FS);
-			wake_up(&sb->s_writers.wait_unfrozen);
 			wake_up_var(&sb->s_writers.frozen);
 			deactivate_locked_super(sb);
 			return ret;
@@ -1853,7 +1850,6 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 	wake_up_var(&sb->s_writers.frozen);
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
 out:
-	wake_up(&sb->s_writers.wait_unfrozen);
 	deactivate_locked_super(sb);
 	return 0;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 88bd81a1b980..584cfaa47988 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1147,7 +1147,6 @@ enum {
 struct sb_writers {
 	unsigned short			frozen;		/* Is sb frozen? */
 	unsigned short			freeze_holders;	/* Who froze fs? */
-	wait_queue_head_t		wait_unfrozen;	/* wait for thaw */
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };
 

