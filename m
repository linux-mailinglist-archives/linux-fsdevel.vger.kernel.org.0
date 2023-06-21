Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D82B738811
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 16:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjFUO4F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 10:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjFUOyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:54:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F093435A6;
        Wed, 21 Jun 2023 07:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D3F8615A6;
        Wed, 21 Jun 2023 14:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8695C433C9;
        Wed, 21 Jun 2023 14:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358952;
        bh=1rG9x7ERKlXPL28fdmfGNObNC3MxW/4isCj9mvzuWg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RT8HOh2ac+RrlE5gqK4Rn6tQ61Z4LxN7negTXG9UJpCXXm44qb5mZouTQhdP4AjWX
         eLdGf6xXRIgGvKQKKvTmaVMaEUpsdDJHx+mKlHr8fidNcZ23duMQiALp+rYRUInxyV
         ttop9om2eqSR6JlxvxzJ4BTigVr8xEQcd/OQHtEdAiAq9n1zD4hdTLaLHGtqebKosD
         uPjz4hsfISSRoF8SkNBaf4mvY98OSNy886txs75Foo9c305QWT73m3iqev/EpgMV2Q
         gEEce0+WNhKrdDw9ji3Txx1gYqaXL+82uCWLh0MFoRwxMjeAsqvjFsbD2fYdMrptTr
         qwFg6uNQ7vT7g==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 55/79] proc: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:08 -0400
Message-ID: <20230621144735.55953-54-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
MIME-Version: 1.0
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

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/proc/base.c        | 2 +-
 fs/proc/inode.c       | 2 +-
 fs/proc/proc_sysctl.c | 2 +-
 fs/proc/self.c        | 2 +-
 fs/proc/thread_self.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 05452c3b9872..354f7f9ad05b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1902,7 +1902,7 @@ struct inode *proc_pid_make_inode(struct super_block *sb,
 	ei = PROC_I(inode);
 	inode->i_mode = mode;
 	inode->i_ino = get_next_ino();
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 	inode->i_op = &proc_def_inode_operations;
 
 	/*
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 67b09a1d9433..61f4fc0a6261 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -660,7 +660,7 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 
 	inode->i_private = de->data;
 	inode->i_ino = de->low_ino;
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 	PROC_I(inode)->pde = de;
 	if (is_empty_pde(de)) {
 		make_empty_dir_inode(inode);
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 4e5488975415..abb7e524b28b 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -463,7 +463,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 	head->count++;
 	spin_unlock(&sysctl_lock);
 
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 	inode->i_mode = table->mode;
 	if (!S_ISDIR(table->mode)) {
 		inode->i_mode |= S_IFREG;
diff --git a/fs/proc/self.c b/fs/proc/self.c
index 72cd69bcaf4a..bb5dbdd30627 100644
--- a/fs/proc/self.c
+++ b/fs/proc/self.c
@@ -46,7 +46,7 @@ int proc_setup_self(struct super_block *s)
 		struct inode *inode = new_inode(s);
 		if (inode) {
 			inode->i_ino = self_inum;
-			inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 			inode->i_mode = S_IFLNK | S_IRWXUGO;
 			inode->i_uid = GLOBAL_ROOT_UID;
 			inode->i_gid = GLOBAL_ROOT_GID;
diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index a553273fbd41..373680bd0635 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -46,7 +46,7 @@ int proc_setup_thread_self(struct super_block *s)
 		struct inode *inode = new_inode(s);
 		if (inode) {
 			inode->i_ino = thread_self_inum;
-			inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
 			inode->i_mode = S_IFLNK | S_IRWXUGO;
 			inode->i_uid = GLOBAL_ROOT_UID;
 			inode->i_gid = GLOBAL_ROOT_GID;
-- 
2.41.0

