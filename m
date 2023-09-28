Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3F97B1AD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjI1LX1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjI1LWz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:22:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2B62D50;
        Thu, 28 Sep 2023 04:05:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B8CC433B7;
        Thu, 28 Sep 2023 11:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899146;
        bh=psv5N50RQ81+83BESGrHOV5WciE2V0x7f5SjV0CmxeE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dd3KOfUe0Jj8fLdYUZ8E8NR67Sz2x5IzNfsgDtB65V7PII0B3WxUr3CJ1MzaDieZ0
         6Sv7eSDwm0eHzROlHZtFY6fgC24O05Du0wMkK5SU/zFXlOR/n2w8lKxFRluIgSxlXD
         qeORQhZBysSbrLkQlODOmsFzmkEEAwjeLg3aXqXYnM8L88Wa3hfyB1mbThDN6XxGyb
         rbUyu3qdljx+ErlYmkR1yXGtij3jlk7TZYQ4yDvfkYvZvg3STVJMy9YodcMYAmh/Hz
         O+tAIAk3DecBi0ZuwGpbZfn9sEZ6fbaa2hIuqWodtyEdiZeA8tGe3TrHT+EcgqOzg2
         ixY4JS5fQKiEw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 78/87] ipc: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:27 -0400
Message-ID: <20230928110413.33032-77-jlayton@kernel.org>
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
 ipc/mqueue.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index ba8215ed663a..5eea4dc0509e 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -302,7 +302,7 @@ static struct inode *mqueue_get_inode(struct super_block *sb,
 	inode->i_mode = mode;
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 
 	if (S_ISREG(mode)) {
 		struct mqueue_inode_info *info;
@@ -596,7 +596,7 @@ static int mqueue_create_attr(struct dentry *dentry, umode_t mode, void *arg)
 
 	put_ipc_ns(ipc_ns);
 	dir->i_size += DIRENT_SIZE;
-	dir->i_mtime = dir->i_atime = inode_set_ctime_current(dir);
+	simple_inode_init_ts(dir);
 
 	d_instantiate(dentry, inode);
 	dget(dentry);
@@ -618,7 +618,7 @@ static int mqueue_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
 
-	dir->i_mtime = dir->i_atime = inode_set_ctime_current(dir);
+	simple_inode_init_ts(dir);
 	dir->i_size -= DIRENT_SIZE;
 	drop_nlink(inode);
 	dput(dentry);
@@ -657,7 +657,7 @@ static ssize_t mqueue_read_file(struct file *filp, char __user *u_data,
 	if (ret <= 0)
 		return ret;
 
-	inode->i_atime = inode_set_ctime_current(inode);
+	inode_set_atime_to_ts(inode, inode_set_ctime_current(inode));
 	return ret;
 }
 
@@ -1163,7 +1163,7 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
 				goto out_unlock;
 			__do_notify(info);
 		}
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 	}
 out_unlock:
 	spin_unlock(&info->lock);
@@ -1257,7 +1257,7 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 
 		msg_ptr = msg_get(info);
 
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 
 		/* There is now free space in queue. */
 		pipelined_receive(&wake_q, info);
@@ -1395,7 +1395,8 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 	if (notification == NULL) {
 		if (info->notify_owner == task_tgid(current)) {
 			remove_notification(info);
-			inode->i_atime = inode_set_ctime_current(inode);
+			inode_set_atime_to_ts(inode,
+					      inode_set_ctime_current(inode));
 		}
 	} else if (info->notify_owner != NULL) {
 		ret = -EBUSY;
@@ -1421,7 +1422,7 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 
 		info->notify_owner = get_pid(task_tgid(current));
 		info->notify_user_ns = get_user_ns(current_user_ns());
-		inode->i_atime = inode_set_ctime_current(inode);
+		inode_set_atime_to_ts(inode, inode_set_ctime_current(inode));
 	}
 	spin_unlock(&info->lock);
 out_fput:
@@ -1484,7 +1485,7 @@ static int do_mq_getsetattr(int mqdes, struct mq_attr *new, struct mq_attr *old)
 			f.file->f_flags &= ~O_NONBLOCK;
 		spin_unlock(&f.file->f_lock);
 
-		inode->i_atime = inode_set_ctime_current(inode);
+		inode_set_atime_to_ts(inode, inode_set_ctime_current(inode));
 	}
 
 	spin_unlock(&info->lock);
-- 
2.41.0

