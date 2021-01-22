Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D523006F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 16:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbhAVPQw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 10:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbhAVPQX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:16:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E2AC06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 07:15:43 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l2yA1-0004Bq-HD; Fri, 22 Jan 2021 16:15:41 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l2yA0-0003qg-N6; Fri, 22 Jan 2021 16:15:40 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/8] quota: Allow to pass mount path to quotactl
Date:   Fri, 22 Jan 2021 16:15:29 +0100
Message-Id: <20210122151536.7982-2-s.hauer@pengutronix.de>
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

This patch introduces the Q_PATH flag to the quotactl cmd argument.
When given, the path given in the special argument to quotactl will
be the mount path where the filesystem is mounted, instead of a path
to the block device.
This is necessary for filesystems which do not have a block device as
backing store. Particularly this is done for upcoming UBIFS support.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/quota/quota.c           | 66 ++++++++++++++++++++++++++++----------
 include/uapi/linux/quota.h |  1 +
 2 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 6d16b2be5ac4..f653b27a9a4e 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -17,6 +17,7 @@
 #include <linux/capability.h>
 #include <linux/quotaops.h>
 #include <linux/types.h>
+#include <linux/mount.h>
 #include <linux/writeback.h>
 #include <linux/nospec.h>
 #include "compat.h"
@@ -859,25 +860,10 @@ static bool quotactl_cmd_onoff(int cmd)
 		 (cmd == Q_XQUOTAON) || (cmd == Q_XQUOTAOFF);
 }
 
-/*
- * look up a superblock on which quota ops will be performed
- * - use the name of a block device to find the superblock thereon
- */
-static struct super_block *quotactl_block(const char __user *special, int cmd)
+static struct super_block *quotactl_sb(dev_t dev, int cmd)
 {
-#ifdef CONFIG_BLOCK
 	struct super_block *sb;
-	struct filename *tmp = getname(special);
 	bool excl = false, thawed = false;
-	int error;
-	dev_t dev;
-
-	if (IS_ERR(tmp))
-		return ERR_CAST(tmp);
-	error = lookup_bdev(tmp->name, &dev);
-	putname(tmp);
-	if (error)
-		return ERR_PTR(error);
 
 	if (quotactl_cmd_onoff(cmd)) {
 		excl = true;
@@ -901,12 +887,50 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
 		goto retry;
 	}
 	return sb;
+}
+
+/*
+ * look up a superblock on which quota ops will be performed
+ * - use the name of a block device to find the superblock thereon
+ */
+static struct super_block *quotactl_block(const char __user *special, int cmd)
+{
+#ifdef CONFIG_BLOCK
+	struct filename *tmp = getname(special);
+	int error;
+	dev_t dev;
 
+	if (IS_ERR(tmp))
+		return ERR_CAST(tmp);
+	error = lookup_bdev(tmp->name, &dev);
+	putname(tmp);
+	if (error)
+		return ERR_PTR(error);
+
+	return quotactl_sb(dev, cmd);
 #else
 	return ERR_PTR(-ENODEV);
 #endif
 }
 
+static struct super_block *quotactl_path(const char __user *special, int cmd)
+{
+	struct super_block *sb;
+	struct path path;
+	int error;
+
+	error = user_path_at(AT_FDCWD, special, LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT,
+			   &path);
+	if (error)
+		return ERR_PTR(error);
+
+	sb = quotactl_sb(path.mnt->mnt_sb->s_dev, cmd);
+
+	path_put(&path);
+
+	return sb;
+}
+
 /*
  * This is the system call interface. This communicates with
  * the user-level programs. Currently this only supports diskquota
@@ -920,6 +944,7 @@ SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
 	struct super_block *sb = NULL;
 	struct path path, *pathp = NULL;
 	int ret;
+	bool q_path;
 
 	cmds = cmd >> SUBCMDSHIFT;
 	type = cmd & SUBCMDMASK;
@@ -927,6 +952,9 @@ SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
 	if (type >= MAXQUOTAS)
 		return -EINVAL;
 
+	q_path = cmds & Q_PATH;
+	cmds &= ~Q_PATH;
+
 	/*
 	 * As a special case Q_SYNC can be called without a specific device.
 	 * It will iterate all superblocks that have quota enabled and call
@@ -951,7 +979,11 @@ SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
 			pathp = &path;
 	}
 
-	sb = quotactl_block(special, cmds);
+	if (q_path)
+		sb = quotactl_path(special, cmds);
+	else
+		sb = quotactl_block(special, cmds);
+
 	if (IS_ERR(sb)) {
 		ret = PTR_ERR(sb);
 		goto out;
diff --git a/include/uapi/linux/quota.h b/include/uapi/linux/quota.h
index f17c9636a859..e1787c0df601 100644
--- a/include/uapi/linux/quota.h
+++ b/include/uapi/linux/quota.h
@@ -71,6 +71,7 @@
 #define Q_GETQUOTA 0x800007	/* get user quota structure */
 #define Q_SETQUOTA 0x800008	/* set user quota structure */
 #define Q_GETNEXTQUOTA 0x800009	/* get disk limits and usage >= ID */
+#define Q_PATH     0x400000	/* quotactl special arg contains mount path */
 
 /* Quota format type IDs */
 #define	QFMT_VFS_OLD 1
-- 
2.20.1

