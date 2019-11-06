Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55CD7F11E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 10:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfKFJPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 04:15:42 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47065 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfKFJPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:15:42 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iSHPg-0002eW-I5; Wed, 06 Nov 2019 10:15:40 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iSHPe-0000Ao-H0; Wed, 06 Nov 2019 10:15:38 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/7] quota: Allow to pass mount path to quotactl
Date:   Wed,  6 Nov 2019 10:15:31 +0100
Message-Id: <20191106091537.32480-2-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191106091537.32480-1-s.hauer@pengutronix.de>
References: <20191106091537.32480-1-s.hauer@pengutronix.de>
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

This patch introduces the Q_PATH flag to the quotactl cmd argument.
When given, the path given in the special argument to quotactl will
be the mount path where the filesystem is mounted, instead of a path
to the block device.
This is necessary for filesystems which do not have a block device as
backing store. Particularly this is done for upcoming UBIFS support.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/quota/quota.c           | 37 ++++++++++++++++++++++++++++---------
 include/uapi/linux/quota.h |  1 +
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index cb13fb76dbee..035cdd1b022b 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -19,6 +19,7 @@
 #include <linux/types.h>
 #include <linux/writeback.h>
 #include <linux/nospec.h>
+#include <linux/mount.h>
 
 static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
 				     qid_t id)
@@ -825,12 +826,16 @@ int kernel_quotactl(unsigned int cmd, const char __user *special,
 {
 	uint cmds, type;
 	struct super_block *sb = NULL;
-	struct path path, *pathp = NULL;
+	struct path path, *pathp = NULL, qpath;
 	int ret;
+	bool q_path;
 
 	cmds = cmd >> SUBCMDSHIFT;
 	type = cmd & SUBCMDMASK;
 
+	q_path = cmds & Q_PATH;
+	cmds &= ~Q_PATH;
+
 	/*
 	 * As a special case Q_SYNC can be called without a specific device.
 	 * It will iterate all superblocks that have quota enabled and call
@@ -855,19 +860,33 @@ int kernel_quotactl(unsigned int cmd, const char __user *special,
 			pathp = &path;
 	}
 
-	sb = quotactl_block(special, cmds);
-	if (IS_ERR(sb)) {
-		ret = PTR_ERR(sb);
-		goto out;
+	if (q_path) {
+		ret = user_path_at(AT_FDCWD, special, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT,
+				   &qpath);
+		if (ret)
+			goto out1;
+
+		sb = qpath.mnt->mnt_sb;
+	} else {
+		sb = quotactl_block(special, cmds);
+		if (IS_ERR(sb)) {
+			ret = PTR_ERR(sb);
+			goto out;
+		}
 	}
 
 	ret = do_quotactl(sb, type, cmds, id, addr, pathp);
 
-	if (!quotactl_cmd_onoff(cmds))
-		drop_super(sb);
-	else
-		drop_super_exclusive(sb);
+	if (!q_path) {
+		if (!quotactl_cmd_onoff(cmds))
+			drop_super(sb);
+		else
+			drop_super_exclusive(sb);
+	}
 out:
+	if (q_path)
+		path_put(&qpath);
+out1:
 	if (pathp && !IS_ERR(pathp))
 		path_put(pathp);
 	return ret;
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
2.24.0.rc1

