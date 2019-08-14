Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 062BF8D2D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 14:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfHNMTN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 08:19:13 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54401 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfHNMTM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:19:12 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hxsEp-0005kG-Eb; Wed, 14 Aug 2019 14:18:47 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hxsEm-00081i-Oi; Wed, 14 Aug 2019 14:18:44 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 07/11] ubifs: Add support for FS_IOC_FS[SG]ETXATTR ioctls
Date:   Wed, 14 Aug 2019 14:18:30 +0200
Message-Id: <20190814121834.13983-8-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814121834.13983-1-s.hauer@pengutronix.de>
References: <20190814121834.13983-1-s.hauer@pengutronix.de>
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

The FS_IOC_FS[SG]ETXATTR ioctls are an alternative to FS_IOC_[GS]ETFLAGS
with additional features. This patch adds support for these ioctls.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/ioctl.c | 89 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 5 deletions(-)

diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index b9c4a51bceea..121aa1003e24 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -95,9 +95,39 @@ static int ubifs2ioctl(int ubifs_flags)
 	return ioctl_flags;
 }
 
-static int setflags(struct file *file, int flags)
+/* Transfer xflags flags to internal */
+static inline unsigned long ubifs_xflags_to_iflags(__u32 xflags)
 {
-	int oldflags, err, release;
+	unsigned long iflags = 0;
+
+	if (xflags & FS_XFLAG_SYNC)
+		iflags |= UBIFS_APPEND_FL;
+	if (xflags & FS_XFLAG_IMMUTABLE)
+		iflags |= UBIFS_IMMUTABLE_FL;
+	if (xflags & FS_XFLAG_APPEND)
+		iflags |= UBIFS_APPEND_FL;
+
+        return iflags;
+}
+
+/* Transfer internal flags to xflags */
+static inline __u32 ubifs_iflags_to_xflags(unsigned long flags)
+{
+	__u32 xflags = 0;
+
+	if (flags & UBIFS_APPEND_FL)
+		xflags |= FS_XFLAG_SYNC;
+	if (flags & UBIFS_IMMUTABLE_FL)
+		xflags |= FS_XFLAG_IMMUTABLE;
+	if (flags & UBIFS_APPEND_FL)
+		xflags |= FS_XFLAG_APPEND;
+
+        return xflags;
+}
+
+static int setflags(struct file *file, int flags, struct fsxattr *fa)
+{
+	int ubi_flags, oldflags, err, release;
 	struct inode *inode = file_inode(file);
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
@@ -110,6 +140,11 @@ static int setflags(struct file *file, int flags)
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
+	if (fa)
+		ubi_flags = ubifs_xflags_to_iflags(fa->fsx_xflags);
+	else
+		ubi_flags = ioctl2ubifs(flags);
+
 	/*
 	 * Make sure the file-system is read-write and make sure it
 	 * will not become read-only while we are changing the flags.
@@ -126,11 +161,11 @@ static int setflags(struct file *file, int flags)
 
 	mutex_lock(&ui->ui_mutex);
 	oldflags = ubifs2ioctl(ui->flags);
-	err = vfs_ioc_setflags_prepare(inode, oldflags, flags);
+	err = vfs_ioc_setflags_prepare(inode, oldflags, ubifs2ioctl(ubi_flags));
 	if (err)
 		goto out_unlock;
 
-	ui->flags = ioctl2ubifs(flags);
+	ui->flags = ubi_flags;
 	ubifs_set_inode_flags(inode);
 	inode->i_ctime = current_time(inode);
 	release = ui->dirty;
@@ -156,6 +191,44 @@ static int setflags(struct file *file, int flags)
 	return err;
 }
 
+static int ubifs_ioc_fsgetxattr(struct file *file, void __user *arg)
+{
+	struct inode *inode = file_inode(file);
+	struct ubifs_inode *ui = ubifs_inode(inode);
+	struct fsxattr fa;
+
+	memset(&fa, 0, sizeof(fa));
+
+	fa.fsx_xflags = ubifs_iflags_to_xflags(ui->flags);
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
+	struct fsxattr fa = {};
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
@@ -179,7 +252,7 @@ long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			flags &= ~FS_DIRSYNC_FL;
 
 
-		return setflags(file, flags);
+		return setflags(file, flags, NULL);
 	}
 	case FS_IOC_SET_ENCRYPTION_POLICY: {
 		struct ubifs_info *c = inode->i_sb->s_fs_info;
@@ -193,6 +266,12 @@ long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case FS_IOC_GET_ENCRYPTION_POLICY:
 		return fscrypt_ioctl_get_policy(file, (void __user *)arg);
 
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

