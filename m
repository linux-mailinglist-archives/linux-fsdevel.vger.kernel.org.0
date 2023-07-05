Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7928D748D70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjGETKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbjGETJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:09:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5253E3AB8;
        Wed,  5 Jul 2023 12:05:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E15BC61704;
        Wed,  5 Jul 2023 19:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB319C433C8;
        Wed,  5 Jul 2023 19:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583937;
        bh=gqeEXinsZAJRqeLTPU00VtiRMUUB3gXboIunzReeQAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wtdubbe1duEyifOHaqcAQuo4/6cpn1L9dcnjDU+DxOqBVhkq/TAZSeNocYisgEn+S
         /HgrB88MmBu6gTQG7bKp5Tn3bQ544teqcU+9ABqoPpHKW6P3xmf616eOiPR3sYNprC
         R3Rrxb8GbEsWqMZOle1a2yI6kKH6NLB4PQUDmxJlImeL93/HNMKIM8/yO/CUFb2aNl
         /CRyvvci20qr6FZryVwYgUAzqX0buYs308BLIyMGI1iXjyv7VJqK3Kd4A0SVZHTrEh
         xLgXZNOVIQRWqPFPW9ym7NLYctM3b7lW8eoRqZ/6CXEAa1wFrP7Y/wtxts3QJYyW4T
         90fVEcbSqIaMA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 85/92] mqueue: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:50 -0400
Message-ID: <20230705190309.579783-83-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
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

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 ipc/mqueue.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 71881bddad25..ba8215ed663a 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -302,7 +302,7 @@ static struct inode *mqueue_get_inode(struct super_block *sb,
 	inode->i_mode = mode;
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
-	inode->i_mtime = inode->i_ctime = inode->i_atime = current_time(inode);
+	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
 
 	if (S_ISREG(mode)) {
 		struct mqueue_inode_info *info;
@@ -596,7 +596,7 @@ static int mqueue_create_attr(struct dentry *dentry, umode_t mode, void *arg)
 
 	put_ipc_ns(ipc_ns);
 	dir->i_size += DIRENT_SIZE;
-	dir->i_ctime = dir->i_mtime = dir->i_atime = current_time(dir);
+	dir->i_mtime = dir->i_atime = inode_set_ctime_current(dir);
 
 	d_instantiate(dentry, inode);
 	dget(dentry);
@@ -618,7 +618,7 @@ static int mqueue_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
 
-	dir->i_ctime = dir->i_mtime = dir->i_atime = current_time(dir);
+	dir->i_mtime = dir->i_atime = inode_set_ctime_current(dir);
 	dir->i_size -= DIRENT_SIZE;
 	drop_nlink(inode);
 	dput(dentry);
@@ -635,7 +635,8 @@ static int mqueue_unlink(struct inode *dir, struct dentry *dentry)
 static ssize_t mqueue_read_file(struct file *filp, char __user *u_data,
 				size_t count, loff_t *off)
 {
-	struct mqueue_inode_info *info = MQUEUE_I(file_inode(filp));
+	struct inode *inode = file_inode(filp);
+	struct mqueue_inode_info *info = MQUEUE_I(inode);
 	char buffer[FILENT_SIZE];
 	ssize_t ret;
 
@@ -656,7 +657,7 @@ static ssize_t mqueue_read_file(struct file *filp, char __user *u_data,
 	if (ret <= 0)
 		return ret;
 
-	file_inode(filp)->i_atime = file_inode(filp)->i_ctime = current_time(file_inode(filp));
+	inode->i_atime = inode_set_ctime_current(inode);
 	return ret;
 }
 
@@ -1162,8 +1163,7 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
 				goto out_unlock;
 			__do_notify(info);
 		}
-		inode->i_atime = inode->i_mtime = inode->i_ctime =
-				current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 	}
 out_unlock:
 	spin_unlock(&info->lock);
@@ -1257,8 +1257,7 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 
 		msg_ptr = msg_get(info);
 
-		inode->i_atime = inode->i_mtime = inode->i_ctime =
-				current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 
 		/* There is now free space in queue. */
 		pipelined_receive(&wake_q, info);
@@ -1396,7 +1395,7 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 	if (notification == NULL) {
 		if (info->notify_owner == task_tgid(current)) {
 			remove_notification(info);
-			inode->i_atime = inode->i_ctime = current_time(inode);
+			inode->i_atime = inode_set_ctime_current(inode);
 		}
 	} else if (info->notify_owner != NULL) {
 		ret = -EBUSY;
@@ -1422,7 +1421,7 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 
 		info->notify_owner = get_pid(task_tgid(current));
 		info->notify_user_ns = get_user_ns(current_user_ns());
-		inode->i_atime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode_set_ctime_current(inode);
 	}
 	spin_unlock(&info->lock);
 out_fput:
@@ -1485,7 +1484,7 @@ static int do_mq_getsetattr(int mqdes, struct mq_attr *new, struct mq_attr *old)
 			f.file->f_flags &= ~O_NONBLOCK;
 		spin_unlock(&f.file->f_lock);
 
-		inode->i_atime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode_set_ctime_current(inode);
 	}
 
 	spin_unlock(&info->lock);
-- 
2.41.0

