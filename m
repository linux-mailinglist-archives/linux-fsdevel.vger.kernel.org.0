Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91A472B5E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 05:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjFLDQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 23:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbjFLDQH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:16:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5FCE70;
        Sun, 11 Jun 2023 20:15:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2385D61DD5;
        Mon, 12 Jun 2023 03:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807EFC4339B;
        Mon, 12 Jun 2023 03:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686539734;
        bh=GWJnpjZ+WsNh1hRt1sMJTLMEf6f06/tTxFAhmy2gjD4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dKOL/32dWdYnS+eSe0n9NT19jtKu72KjDDmudUh8eMenO2Mg8IfKYrFJ8XMs9UwMs
         ANSLFMHdLdBgkHGMC8kgScfSF6jeFUhYxtBFn2c1dJqP6hIP+zyuZCtV0pxN7fSBLv
         op+MIJbdtIr5JiZmmJTKCFGir0m1/1ya50cP017aHyngfeC249DFb27XFtXqHw2QBE
         XFTzKtkCEqjyi1hV3Hoy5QdH3VXJjdficNQgN68uepmr5+MMNCpp5EgjUKfN+5iPRI
         a9rH04FfTHabFIuOSk+GKaWNcySmBTp1vHFfTkgLjmwqLdbzsIhBHXZXaBd5GQK9LL
         Q37Su031uaQ4Q==
Subject: [PATCH 3/3] fs: Drop wait_unfrozen wait queue
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mcgrof@kernel.org, jack@suse.cz,
        hch@infradead.org, ruansy.fnst@fujitsu.com
Date:   Sun, 11 Jun 2023 20:15:34 -0700
Message-ID: <168653973399.755178.13985159536040832418.stgit@frogsfrogsfrogs>
In-Reply-To: <168653971691.755178.4003354804404850534.stgit@frogsfrogsfrogs>
References: <168653971691.755178.4003354804404850534.stgit@frogsfrogsfrogs>
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
index 151e0eeff2c2..fd04dda6c5c0 100644
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
@@ -1753,7 +1752,6 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
 	if (ret) {
 		sb->s_writers.frozen = SB_UNFROZEN;
 		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
-		wake_up(&sb->s_writers.wait_unfrozen);
 		wake_up_var(&sb->s_writers.frozen);
 		deactivate_locked_super(sb);
 		return ret;
@@ -1770,7 +1768,6 @@ int freeze_super(struct super_block *sb, enum freeze_holder who)
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
index c58a560569b3..5870fbbecb81 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1147,7 +1147,6 @@ enum {
 struct sb_writers {
 	unsigned short			frozen;		/* Is sb frozen? */
 	unsigned short			freeze_holders;	/* Who froze fs? */
-	wait_queue_head_t		wait_unfrozen;	/* wait for thaw */
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };
 

