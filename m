Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A37D71485B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 14:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389219AbgAXNNg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 08:13:36 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36551 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389187AbgAXNNg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 08:13:36 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iuym5-0003aE-RR; Fri, 24 Jan 2020 14:13:25 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iuym5-0006Z8-0V; Fri, 24 Jan 2020 14:13:25 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/8] quota: Allow to pass mount path to quotactl
Date:   Fri, 24 Jan 2020 14:13:16 +0100
Message-Id: <20200124131323.23885-2-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124131323.23885-1-s.hauer@pengutronix.de>
References: <20200124131323.23885-1-s.hauer@pengutronix.de>
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
 fs/quota/quota.c           | 53 +++++++++++++++++++++++++++-----------
 include/uapi/linux/quota.h |  1 +
 2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 5444d3c4d93f..9ef51d02d5a5 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -19,6 +19,7 @@
 #include <linux/types.h>
 #include <linux/writeback.h>
 #include <linux/nospec.h>
+#include <linux/mount.h>
 
 static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
 				     qid_t id)
@@ -821,15 +822,20 @@ int kernel_quotactl(unsigned int cmd, const char __user *special,
 {
 	uint cmds, type;
 	struct super_block *sb = NULL;
-	struct path path, *pathp = NULL;
+	struct path file_path, *file_pathp = NULL, sb_path;
 	int ret;
+	bool q_path;
 
 	cmds = cmd >> SUBCMDSHIFT;
 	type = cmd & SUBCMDMASK;
 
+
 	if (type >= MAXQUOTAS)
 		return -EINVAL;
 
+	q_path = cmds & Q_PATH;
+	cmds &= ~Q_PATH;
+
 	/*
 	 * As a special case Q_SYNC can be called without a specific device.
 	 * It will iterate all superblocks that have quota enabled and call
@@ -847,28 +853,45 @@ int kernel_quotactl(unsigned int cmd, const char __user *special,
 	 * resolution (think about autofs) and thus deadlocks could arise.
 	 */
 	if (cmds == Q_QUOTAON) {
-		ret = user_path_at(AT_FDCWD, addr, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &path);
+		ret = user_path_at(AT_FDCWD, addr,
+				   LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT,
+				   &file_path);
 		if (ret)
-			pathp = ERR_PTR(ret);
+			file_pathp = ERR_PTR(ret);
 		else
-			pathp = &path;
+			file_pathp = &file_path;
 	}
 
-	sb = quotactl_block(special, cmds);
-	if (IS_ERR(sb)) {
-		ret = PTR_ERR(sb);
-		goto out;
+	if (q_path) {
+		ret = user_path_at(AT_FDCWD, special,
+				   LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT,
+				   &sb_path);
+		if (ret)
+			goto out;
+
+		sb = sb_path.mnt->mnt_sb;
+	} else {
+		sb = quotactl_block(special, cmds);
+		if (IS_ERR(sb)) {
+			ret = PTR_ERR(sb);
+			goto out;
+		}
 	}
 
-	ret = do_quotactl(sb, type, cmds, id, addr, pathp);
+	ret = do_quotactl(sb, type, cmds, id, addr, file_pathp);
+
+	if (q_path) {
+		path_put(&sb_path);
+	} else {
+		if (!quotactl_cmd_onoff(cmds))
+			drop_super(sb);
+		else
+			drop_super_exclusive(sb);
+	}
 
-	if (!quotactl_cmd_onoff(cmds))
-		drop_super(sb);
-	else
-		drop_super_exclusive(sb);
 out:
-	if (pathp && !IS_ERR(pathp))
-		path_put(pathp);
+	if (file_pathp && !IS_ERR(file_pathp))
+		path_put(file_pathp);
 	return ret;
 }
 
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
2.25.0

