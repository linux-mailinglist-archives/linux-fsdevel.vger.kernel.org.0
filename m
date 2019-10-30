Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFAFE9EE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 16:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfJ3P1q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 11:27:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45843 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfJ3P1q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:27:46 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iPpsG-0003Y3-Os; Wed, 30 Oct 2019 16:27:04 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iPpsF-0005nG-UL; Wed, 30 Oct 2019 16:27:03 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 05/10] ubifs: move checks and preparation into setflags()
Date:   Wed, 30 Oct 2019 16:26:57 +0100
Message-Id: <20191030152702.14269-6-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191030152702.14269-1-s.hauer@pengutronix.de>
References: <20191030152702.14269-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

setflags() can be reused for upcoming FS_IOC_FS[SG]ETXATTR ioctl support.
In preparation for that move the checks and preparation into that
function so we can reuse them aswell.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/ioctl.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index 5dc5abca11c7..8230dba5fd74 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -95,18 +95,35 @@ static int ubifs2ioctl(int ubifs_flags)
 	return ioctl_flags;
 }
 
-static int setflags(struct inode *inode, int flags)
+static int setflags(struct file *file, int flags)
 {
 	int oldflags, err, release;
+	struct inode *inode = file_inode(file);
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	struct ubifs_budget_req req = { .dirtied_ino = 1,
 					.dirtied_ino_d = ui->data_len };
 
-	err = ubifs_budget_space(c, &req);
+	if (IS_RDONLY(inode))
+		return -EROFS;
+
+	if (!inode_owner_or_capable(inode))
+		return -EACCES;
+
+	/*
+	 * Make sure the file-system is read-write and make sure it
+	 * will not become read-only while we are changing the flags.
+	 */
+	err = mnt_want_write_file(file);
 	if (err)
 		return err;
 
+	dbg_gen("set flags: %#x, i_flags %#x", flags, inode->i_flags);
+
+	err = ubifs_budget_space(c, &req);
+	if (err)
+		goto out_drop;
+
 	mutex_lock(&ui->ui_mutex);
 	oldflags = ubifs2ioctl(ui->flags);
 	err = vfs_ioc_setflags_prepare(inode, oldflags, flags);
@@ -124,12 +141,18 @@ static int setflags(struct inode *inode, int flags)
 		ubifs_release_budget(c, &req);
 	if (IS_SYNC(inode))
 		err = write_inode_now(inode, 1);
+
+	mnt_drop_write_file(file);
+
 	return err;
 
 out_unlock:
 	ubifs_err(c, "can't modify inode %lu attributes", inode->i_ino);
 	mutex_unlock(&ui->ui_mutex);
 	ubifs_release_budget(c, &req);
+out_drop:
+	mnt_drop_write_file(file);
+
 	return err;
 }
 
@@ -146,12 +169,6 @@ long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return put_user(flags, (int __user *) arg);
 
 	case FS_IOC_SETFLAGS: {
-		if (IS_RDONLY(inode))
-			return -EROFS;
-
-		if (!inode_owner_or_capable(inode))
-			return -EACCES;
-
 		if (get_user(flags, (int __user *) arg))
 			return -EFAULT;
 
@@ -161,17 +178,8 @@ long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (!S_ISDIR(inode->i_mode))
 			flags &= ~FS_DIRSYNC_FL;
 
-		/*
-		 * Make sure the file-system is read-write and make sure it
-		 * will not become read-only while we are changing the flags.
-		 */
-		err = mnt_want_write_file(file);
-		if (err)
-			return err;
-		dbg_gen("set flags: %#x, i_flags %#x", flags, inode->i_flags);
-		err = setflags(inode, flags);
-		mnt_drop_write_file(file);
-		return err;
+
+		return setflags(file, flags);
 	}
 	case FS_IOC_SET_ENCRYPTION_POLICY: {
 		struct ubifs_info *c = inode->i_sb->s_fs_info;
-- 
2.24.0.rc1

