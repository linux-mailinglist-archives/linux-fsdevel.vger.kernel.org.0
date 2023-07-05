Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D04748D94
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbjGETMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjGETMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:12:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49CB271B;
        Wed,  5 Jul 2023 12:06:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBA57616F7;
        Wed,  5 Jul 2023 19:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D41C433C9;
        Wed,  5 Jul 2023 19:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583906;
        bh=0YXPvqkA7pZ7Hzh4yB98RxsCcouNOmeqexbNKJzEBzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QllW1hYTAbHIl9ublRCbW0vxvBvNN2KypraBhcy/oOx7ppvm+ma0XkRCYxTUR2lDI
         Jae1zUdX6DjUURhqCEahjeaJG214uDlTD39GTkBVOj9npRUa516fR3ZOHtM4FQmE52
         nYvXt2QdF+XPn6EV8XIEwRD2HoIjQVsR6QQlG6txMDB4Gg9pkCZA4VPaYMj2hAI5J/
         YgSQA9RrR7EOFsGgPpR0LcwTQoHL9IEFaexI8B6WxLyrNSbGFRAMKKen5mecPbPjbt
         qy8/w03354XAXncceJTHv2A7gcXDnAR1FOBprGdJc/e3VPtWJ/R+EzccggBfBq3t3j
         MVbj27rNEuWYg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 67/92] procfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:32 -0400
Message-ID: <20230705190309.579783-65-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/proc/base.c        | 2 +-
 fs/proc/inode.c       | 2 +-
 fs/proc/proc_sysctl.c | 2 +-
 fs/proc/self.c        | 2 +-
 fs/proc/thread_self.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index eb2e498e3b8d..bbc998fd2a2f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1902,7 +1902,7 @@ struct inode *proc_pid_make_inode(struct super_block *sb,
 	ei = PROC_I(inode);
 	inode->i_mode = mode;
 	inode->i_ino = get_next_ino();
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 	inode->i_op = &proc_def_inode_operations;
 
 	/*
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 67b09a1d9433..532dc9d240f7 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -660,7 +660,7 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 
 	inode->i_private = de->data;
 	inode->i_ino = de->low_ino;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 	PROC_I(inode)->pde = de;
 	if (is_empty_pde(de)) {
 		make_empty_dir_inode(inode);
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 5ea42653126e..6bc10e7e0ff7 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -463,7 +463,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 	head->count++;
 	spin_unlock(&sysctl_lock);
 
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 	inode->i_mode = table->mode;
 	if (!S_ISDIR(table->mode)) {
 		inode->i_mode |= S_IFREG;
diff --git a/fs/proc/self.c b/fs/proc/self.c
index 72cd69bcaf4a..ecc4da8d265e 100644
--- a/fs/proc/self.c
+++ b/fs/proc/self.c
@@ -46,7 +46,7 @@ int proc_setup_self(struct super_block *s)
 		struct inode *inode = new_inode(s);
 		if (inode) {
 			inode->i_ino = self_inum;
-			inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 			inode->i_mode = S_IFLNK | S_IRWXUGO;
 			inode->i_uid = GLOBAL_ROOT_UID;
 			inode->i_gid = GLOBAL_ROOT_GID;
diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index a553273fbd41..63ac1f93289f 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -46,7 +46,7 @@ int proc_setup_thread_self(struct super_block *s)
 		struct inode *inode = new_inode(s);
 		if (inode) {
 			inode->i_ino = thread_self_inum;
-			inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 			inode->i_mode = S_IFLNK | S_IRWXUGO;
 			inode->i_uid = GLOBAL_ROOT_UID;
 			inode->i_gid = GLOBAL_ROOT_GID;
-- 
2.41.0

