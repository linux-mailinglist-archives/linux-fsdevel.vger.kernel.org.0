Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481FA7B1A28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjI1LJn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjI1LIz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:08:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B554B1FEC;
        Thu, 28 Sep 2023 04:05:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC53C433CA;
        Thu, 28 Sep 2023 11:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899125;
        bh=xEQsIrRsYPNzXX5r6sRFAGgy+JmdjrVXvNQATA/DNqY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OuGmLiHDoHZKnkQ/MGhUox6yyeHjpJAueaRGVMNjUmeNzxgt3wYDCfeV3+rWt+pML
         gaffXEhePTlNpBtqiDcKKxZsk54ZZBUF+mfaw8lDsmxXA4MEhkexdV9zVNw7QFApLs
         FDpiXTQ3rZxxg6xxhYxPENqJg6glkdBnSkl2uGFGVpdYEXZ8FZ0Ov5dKGf/h0xF4W4
         +yVGPOHwdskE5mNdyRdOkEdmrLg0C/P0MDOEQcqTs0ZzV8sfFB5JAljqlTSos5jt9h
         Sm4BXKYnAYAKsavHxxpdcspVmxIZjhtLkpixHHPjWAqOkV6cZJeTmxPh7AxHPHXlrS
         riD9cRJvcTvZw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 60/87] fs/proc: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:09 -0400
Message-ID: <20230928110413.33032-59-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/proc/base.c        | 2 +-
 fs/proc/inode.c       | 2 +-
 fs/proc/proc_sysctl.c | 2 +-
 fs/proc/self.c        | 2 +-
 fs/proc/thread_self.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ffd54617c354..c69925364090 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1902,7 +1902,7 @@ struct inode *proc_pid_make_inode(struct super_block *sb,
 	ei = PROC_I(inode);
 	inode->i_mode = mode;
 	inode->i_ino = get_next_ino();
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_op = &proc_def_inode_operations;
 
 	/*
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 532dc9d240f7..592ed2516f47 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -660,7 +660,7 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 
 	inode->i_private = de->data;
 	inode->i_ino = de->low_ino;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	PROC_I(inode)->pde = de;
 	if (is_empty_pde(de)) {
 		make_empty_dir_inode(inode);
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c88854df0b62..bc9a2db89cfa 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -465,7 +465,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 	head->count++;
 	spin_unlock(&sysctl_lock);
 
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_mode = table->mode;
 	if (!S_ISDIR(table->mode)) {
 		inode->i_mode |= S_IFREG;
diff --git a/fs/proc/self.c b/fs/proc/self.c
index ecc4da8d265e..b46fbfd22681 100644
--- a/fs/proc/self.c
+++ b/fs/proc/self.c
@@ -46,7 +46,7 @@ int proc_setup_self(struct super_block *s)
 		struct inode *inode = new_inode(s);
 		if (inode) {
 			inode->i_ino = self_inum;
-			inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+			simple_inode_init_ts(inode);
 			inode->i_mode = S_IFLNK | S_IRWXUGO;
 			inode->i_uid = GLOBAL_ROOT_UID;
 			inode->i_gid = GLOBAL_ROOT_GID;
diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index 63ac1f93289f..0e5050d6ab64 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -46,7 +46,7 @@ int proc_setup_thread_self(struct super_block *s)
 		struct inode *inode = new_inode(s);
 		if (inode) {
 			inode->i_ino = thread_self_inum;
-			inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+			simple_inode_init_ts(inode);
 			inode->i_mode = S_IFLNK | S_IRWXUGO;
 			inode->i_uid = GLOBAL_ROOT_UID;
 			inode->i_gid = GLOBAL_ROOT_GID;
-- 
2.41.0

