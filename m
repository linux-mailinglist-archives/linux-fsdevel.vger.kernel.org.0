Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3990300701
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 16:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbhAVPS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 10:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbhAVPRa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:17:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FEBC061793
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 07:15:59 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l2yA1-0004Bt-HH; Fri, 22 Jan 2021 16:15:41 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l2yA0-0003qr-QC; Fri, 22 Jan 2021 16:15:40 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/8] ubifs: Add support for FS_IOC_FS[SG]ETXATTR ioctls
Date:   Fri, 22 Jan 2021 16:15:31 +0100
Message-Id: <20210122151536.7982-4-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210122151536.7982-1-s.hauer@pengutronix.de>
References: <20210122151536.7982-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The FS_IOC_FS[SG]ETXATTR ioctls are an alternative to FS_IOC_[GS]ETFLAGS
with additional features. This patch adds support for these ioctls.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/ioctl.c | 107 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 102 insertions(+), 5 deletions(-)

diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index b64a9cec7d47..5977edd4d185 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -101,9 +101,46 @@ static int ubifs2ioctl(int ubifs_flags)
 	return ioctl_flags;
 }
 
-static int setflags(struct file *file, int flags)
+/* Transfer xflags flags to internal */
+static unsigned long ubifs_xflags_to_iflags(__u32 xflags)
 {
-	int oldflags, err, release;
+	unsigned long iflags = 0;
+
+	if (xflags & FS_XFLAG_SYNC)
+		iflags |= UBIFS_SYNC_FL;
+	if (xflags & FS_XFLAG_IMMUTABLE)
+		iflags |= UBIFS_IMMUTABLE_FL;
+	if (xflags & FS_XFLAG_APPEND)
+		iflags |= UBIFS_APPEND_FL;
+
+        return iflags;
+}
+
+/* Transfer internal flags to xflags */
+static __u32 ubifs_iflags_to_xflags(unsigned long flags)
+{
+	__u32 xflags = 0;
+
+	if (flags & UBIFS_SYNC_FL)
+		xflags |= FS_XFLAG_SYNC;
+	if (flags & UBIFS_IMMUTABLE_FL)
+		xflags |= FS_XFLAG_IMMUTABLE;
+	if (flags & UBIFS_APPEND_FL)
+		xflags |= FS_XFLAG_APPEND;
+
+        return xflags;
+}
+
+static void ubifs_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
+{
+	struct ubifs_inode *ui = ubifs_inode(inode);
+
+	simple_fill_fsxattr(fa, ubifs_iflags_to_xflags(ui->flags));
+}
+
+static int setflags(struct file *file, int flags, struct fsxattr *fa)
+{
+	int ubi_flags, oldflags, err, release;
 	struct inode *inode = file_inode(file);
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
@@ -116,6 +153,13 @@ static int setflags(struct file *file, int flags)
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
+	ubifs_assert(c, !(flags && fa));
+
+	if (fa)
+		ubi_flags = ubifs_xflags_to_iflags(fa->fsx_xflags);
+	else
+		ubi_flags = ioctl2ubifs(flags);
+
 	/*
 	 * Make sure the file-system is read-write and make sure it
 	 * will not become read-only while we are changing the flags.
@@ -132,12 +176,24 @@ static int setflags(struct file *file, int flags)
 
 	mutex_lock(&ui->ui_mutex);
 	oldflags = ubifs2ioctl(ui->flags);
-	err = vfs_ioc_setflags_prepare(inode, oldflags, flags);
+	err = vfs_ioc_setflags_prepare(inode, oldflags, ubifs2ioctl(ubi_flags));
 	if (err)
 		goto out_unlock;
 
 	ui->flags &= ~ioctl2ubifs(UBIFS_SETTABLE_IOCTL_FLAGS);
-	ui->flags |= ioctl2ubifs(flags);
+
+	if (fa) {
+		struct fsxattr old_fa;
+
+		ubifs_fill_fsxattr(inode, &old_fa);
+
+		err = vfs_ioc_fssetxattr_check(inode, &old_fa, fa);
+		if (err)
+			goto out_unlock;
+	}
+
+	ui->flags |= ubi_flags;
+
 	ubifs_set_inode_flags(inode);
 	inode->i_ctime = current_time(inode);
 	release = ui->dirty;
@@ -162,6 +218,41 @@ static int setflags(struct file *file, int flags)
 	return err;
 }
 
+static int ubifs_ioc_fsgetxattr(struct file *file, void __user *arg)
+{
+	struct inode *inode = file_inode(file);
+	struct fsxattr fa;
+
+	ubifs_fill_fsxattr(inode, &fa);
+
+	if (copy_to_user(arg, &fa, sizeof(fa)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int check_xflags(unsigned int flags)
+{
+	if (flags & ~(FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static int ubifs_ioc_fssetxattr(struct file *file, const void __user *arg)
+{
+	struct fsxattr fa;
+	int err;
+
+	if (copy_from_user(&fa, (struct fsxattr __user *)arg, sizeof(fa)))
+		return -EFAULT;
+
+	err = check_xflags(fa.fsx_xflags);
+	if (err)
+		return err;
+
+	return setflags(file, 0, &fa);
+}
+
 long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	int flags, err;
@@ -186,7 +277,7 @@ long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			flags &= ~FS_DIRSYNC_FL;
 
 
-		return setflags(file, flags);
+		return setflags(file, flags, NULL);
 	}
 	case FS_IOC_SET_ENCRYPTION_POLICY: {
 		struct ubifs_info *c = inode->i_sb->s_fs_info;
@@ -218,6 +309,12 @@ long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case FS_IOC_GET_ENCRYPTION_NONCE:
 		return fscrypt_ioctl_get_nonce(file, (void __user *)arg);
 
+	case FS_IOC_FSGETXATTR:
+		return ubifs_ioc_fsgetxattr(file, (void __user *)arg);
+
+	case FS_IOC_FSSETXATTR:
+		return ubifs_ioc_fssetxattr(file, (const void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
-- 
2.20.1

