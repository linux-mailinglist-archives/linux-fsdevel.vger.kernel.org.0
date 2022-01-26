Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4813249C11E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 03:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbiAZCST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 21:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbiAZCSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:18:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02733C06173B;
        Tue, 25 Jan 2022 18:18:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1F3560BB9;
        Wed, 26 Jan 2022 02:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1DCC340E0;
        Wed, 26 Jan 2022 02:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643163495;
        bh=O2q223h4U5O9sejMSKTHs6JPqwmDmF9bv9rL+M6HH9w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ra8baocLzhNY9wox/KuL5SFKfJTMDzhOTZniOpsbh7OU53rY3CVeAndI3QgTFaVfm
         JT/EJVIskZ6HDLB9+zK9EVh+RMfu23SBA0IfO93c3ZSKnx5R0WgXFQcZHQDn/4aA3t
         15W46OLDQNGov2fC7z4T7B838OEnJSUExNlTj9iLKVJic0uP7kaRdWoMfL5nw4GdSN
         HP6VLeJamAKl0bJf1F85SH6CYnCGU7exrV9gcspanuyd85SZgXGMnwGun/+AQX2p/H
         G6/TwboJpFIw112PMhksnhcPA/RXn6q+nSWoXK8xGMAvymIWCINr9eKhJcsHx9jlKC
         tl091Judsem/w==
Subject: [PATCH 1/4] vfs: make freeze_super abort when sync_filesystem returns
 error
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.com
Date:   Tue, 25 Jan 2022 18:18:15 -0800
Message-ID: <164316349509.2600168.11461158492068710281.stgit@magnolia>
In-Reply-To: <164316348940.2600168.17153575889519271710.stgit@magnolia>
References: <164316348940.2600168.17153575889519271710.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

If we fail to synchronize the filesystem while preparing to freeze the
fs, abort the freeze.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/super.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)


diff --git a/fs/super.c b/fs/super.c
index 7af820ba5ad5..f1d4a193602d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1616,11 +1616,9 @@ static void lockdep_sb_freeze_acquire(struct super_block *sb)
 		percpu_rwsem_acquire(sb->s_writers.rw_sem + level, 0, _THIS_IP_);
 }
 
-static void sb_freeze_unlock(struct super_block *sb)
+static void sb_freeze_unlock(struct super_block *sb, int level)
 {
-	int level;
-
-	for (level = SB_FREEZE_LEVELS - 1; level >= 0; level--)
+	for (level--; level >= 0; level--)
 		percpu_up_write(sb->s_writers.rw_sem + level);
 }
 
@@ -1691,7 +1689,14 @@ int freeze_super(struct super_block *sb)
 	sb_wait_write(sb, SB_FREEZE_PAGEFAULT);
 
 	/* All writers are done so after syncing there won't be dirty data */
-	sync_filesystem(sb);
+	ret = sync_filesystem(sb);
+	if (ret) {
+		sb->s_writers.frozen = SB_UNFROZEN;
+		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
+		wake_up(&sb->s_writers.wait_unfrozen);
+		deactivate_locked_super(sb);
+		return ret;
+	}
 
 	/* Now wait for internal filesystem counter */
 	sb->s_writers.frozen = SB_FREEZE_FS;
@@ -1703,7 +1708,7 @@ int freeze_super(struct super_block *sb)
 			printk(KERN_ERR
 				"VFS:Filesystem freeze failed\n");
 			sb->s_writers.frozen = SB_UNFROZEN;
-			sb_freeze_unlock(sb);
+			sb_freeze_unlock(sb, SB_FREEZE_FS);
 			wake_up(&sb->s_writers.wait_unfrozen);
 			deactivate_locked_super(sb);
 			return ret;
@@ -1748,7 +1753,7 @@ static int thaw_super_locked(struct super_block *sb)
 	}
 
 	sb->s_writers.frozen = SB_UNFROZEN;
-	sb_freeze_unlock(sb);
+	sb_freeze_unlock(sb, SB_FREEZE_FS);
 out:
 	wake_up(&sb->s_writers.wait_unfrozen);
 	deactivate_locked_super(sb);

