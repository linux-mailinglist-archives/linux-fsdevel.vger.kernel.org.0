Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631436F4EF0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 05:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjECDCY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 23:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECDCW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 23:02:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB801FDB;
        Tue,  2 May 2023 20:02:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ED0262A21;
        Wed,  3 May 2023 03:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA8DC433D2;
        Wed,  3 May 2023 03:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683082939;
        bh=nVYcNGZuRkDgr7QWhn/ZZpmczDRCBnX4yNmtxuM/chM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kntOkwTKNfi7wfdSWx7HJU/TVnZStpUe/L/N9cZT8jWDC9MQNOAmtJpVqqFiCx1rp
         iz5FlPyDScJvgRaMLNToyho061gDFc/RAlchcqCkGywUyIATihF2saO7i5XaY6Tk+r
         C6RZkY+ZlLIbHuF4ZiMyfYXsL94t3xp+sEvk68PzYg+QH+cGYAQfKczpDCHM/m3N5U
         iClxZ/iNZLiTqfcIS7Y+P3AI0CYAb1ftDAsJR552jRlqcaPzjy8YRSSL+Oh7WVBpOc
         tkJX/bWMTAW+MQACDx0ID7TsePDFn8/SX4NP1Hy+yx7iPZ7CrujqM25P2VNbK5fITe
         TkAIakl/EQEdg==
Subject: [PATCH 1/4] vfs: allow filesystem freeze callers to denote who froze
 the fs
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, mcgrof@kernel.org,
        ruansy.fnst@fujitsu.com, linux-fsdevel@vger.kernel.org
Date:   Tue, 02 May 2023 20:02:18 -0700
Message-ID: <168308293892.734377.10931394426623343285.stgit@frogsfrogsfrogs>
In-Reply-To: <168308293319.734377.10454919162350827812.stgit@frogsfrogsfrogs>
References: <168308293319.734377.10454919162350827812.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add a tag field to sb_writers so that the freeze code tracks who froze a
filesystem.  For now the only tag is for userspace-initiated freezing,
but in the next few patches we'll introduce the ability for in-kernel
callers to freeze an fs exclusively.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/super.c         |   41 ++++++++++++++++++++++++++++++++++-------
 include/linux/fs.h |    1 +
 2 files changed, 35 insertions(+), 7 deletions(-)


diff --git a/fs/super.c b/fs/super.c
index 04bc62ab7dfe..01891f9e6d5e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -39,7 +39,10 @@
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
-static int thaw_super_locked(struct super_block *sb);
+static int thaw_super_locked(struct super_block *sb, unsigned long cookie);
+
+/* Freeze cookie denoting that userspace froze the filesystem. */
+#define USERSPACE_FREEZE_COOKIE	((unsigned long)freeze_super)
 
 static LIST_HEAD(super_blocks);
 static DEFINE_SPINLOCK(sb_lock);
@@ -1027,7 +1030,7 @@ static void do_thaw_all_callback(struct super_block *sb)
 	down_write(&sb->s_umount);
 	if (sb->s_root && sb->s_flags & SB_BORN) {
 		emergency_thaw_bdev(sb);
-		thaw_super_locked(sb);
+		thaw_super_locked(sb, USERSPACE_FREEZE_COOKIE);
 	} else {
 		up_write(&sb->s_umount);
 	}
@@ -1636,13 +1639,18 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
 }
 
 /**
- * freeze_super - lock the filesystem and force it into a consistent state
+ * __freeze_super - lock the filesystem and force it into a consistent state
  * @sb: the super to lock
+ * @cookie: magic value telling us who tried to freeze the fs
  *
  * Syncs the super to make sure the filesystem is consistent and calls the fs's
  * freeze_fs.  Subsequent calls to this without first thawing the fs will return
  * -EBUSY.
  *
+ * If a filesystem freeze is initiated, the sb->s_writers.freeze_cookie value
+ * is set to the @cookie.  The filesystem can only be thawed with the same
+ * cookie value.
+ *
  * During this function, sb->s_writers.frozen goes through these values:
  *
  * SB_UNFROZEN: File system is normal, all writes progress as usual.
@@ -1668,7 +1676,7 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
  *
  * sb->s_writers.frozen is protected by sb->s_umount.
  */
-int freeze_super(struct super_block *sb)
+static int __freeze_super(struct super_block *sb, unsigned long cookie)
 {
 	int ret;
 
@@ -1684,6 +1692,7 @@ int freeze_super(struct super_block *sb)
 		return 0;	/* sic - it's "nothing to do" */
 	}
 
+	sb->s_writers.freeze_cookie = cookie;
 	if (sb_rdonly(sb)) {
 		/* Nothing to do really... */
 		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
@@ -1704,6 +1713,7 @@ int freeze_super(struct super_block *sb)
 	/* All writers are done so after syncing there won't be dirty data */
 	ret = sync_filesystem(sb);
 	if (ret) {
+		sb->s_writers.freeze_cookie = 0;
 		sb->s_writers.frozen = SB_UNFROZEN;
 		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
 		wake_up(&sb->s_writers.wait_unfrozen);
@@ -1720,6 +1730,7 @@ int freeze_super(struct super_block *sb)
 		if (ret) {
 			printk(KERN_ERR
 				"VFS:Filesystem freeze failed\n");
+			sb->s_writers.freeze_cookie = 0;
 			sb->s_writers.frozen = SB_UNFROZEN;
 			sb_freeze_unlock(sb, SB_FREEZE_FS);
 			wake_up(&sb->s_writers.wait_unfrozen);
@@ -1736,18 +1747,33 @@ int freeze_super(struct super_block *sb)
 	up_write(&sb->s_umount);
 	return 0;
 }
+
+/*
+ * freeze_super - lock the filesystem and force it into a consistent state
+ * @sb: the super to lock
+ *
+ * Syncs the super to make sure the filesystem is consistent and calls the fs's
+ * freeze_fs.  Subsequent calls to this without first thawing the fs will return
+ * -EBUSY.  See the comment for __freeze_super for more information.
+ */
+int freeze_super(struct super_block *sb)
+{
+	return __freeze_super(sb, USERSPACE_FREEZE_COOKIE);
+}
 EXPORT_SYMBOL(freeze_super);
 
-static int thaw_super_locked(struct super_block *sb)
+static int thaw_super_locked(struct super_block *sb, unsigned long cookie)
 {
 	int error;
 
-	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
+	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE ||
+	    sb->s_writers.freeze_cookie != cookie) {
 		up_write(&sb->s_umount);
 		return -EINVAL;
 	}
 
 	if (sb_rdonly(sb)) {
+		sb->s_writers.freeze_cookie = 0;
 		sb->s_writers.frozen = SB_UNFROZEN;
 		goto out;
 	}
@@ -1765,6 +1791,7 @@ static int thaw_super_locked(struct super_block *sb)
 		}
 	}
 
+	sb->s_writers.freeze_cookie = 0;
 	sb->s_writers.frozen = SB_UNFROZEN;
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
 out:
@@ -1782,7 +1809,7 @@ static int thaw_super_locked(struct super_block *sb)
 int thaw_super(struct super_block *sb)
 {
 	down_write(&sb->s_umount);
-	return thaw_super_locked(sb);
+	return thaw_super_locked(sb, USERSPACE_FREEZE_COOKIE);
 }
 EXPORT_SYMBOL(thaw_super);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c85916e9f7db..800772361b1e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1129,6 +1129,7 @@ enum {
 
 struct sb_writers {
 	int				frozen;		/* Is sb frozen? */
+	unsigned long			freeze_cookie;	/* who froze us? */
 	wait_queue_head_t		wait_unfrozen;	/* wait for thaw */
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };

