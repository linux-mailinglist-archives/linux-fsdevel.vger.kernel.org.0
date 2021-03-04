Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E3D32D35B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 13:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240932AbhCDMhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 07:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241035AbhCDMhZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:37:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7121C0613DA
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Mar 2021 04:36:12 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lHnD1-0006vz-63; Thu, 04 Mar 2021 13:36:03 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lHnCz-00043q-VJ; Thu, 04 Mar 2021 13:36:01 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] quota: Add mountpath based quota support
Date:   Thu,  4 Mar 2021 13:35:39 +0100
Message-Id: <20210304123541.30749-2-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304123541.30749-1-s.hauer@pengutronix.de>
References: <20210304123541.30749-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add syscall quotactl_path, a variant of quotactl which allows to specify
the mountpath instead of a path of to a block device.

The quotactl syscall expects a path to the mounted block device to
specify the filesystem to work on. This limits usage to filesystems
which actually have a block device. quotactl_path replaces the path
to the block device with a path where the filesystem is mounted at.

The global Q_SYNC command to sync all filesystems is not supported for
this new syscall, otherwise quotactl_path behaves like quotactl.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/quota/quota.c | 49 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 6d16b2be5ac4..f7b4b66491fc 100644
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
@@ -827,8 +828,6 @@ static int do_quotactl(struct super_block *sb, int type, int cmd, qid_t id,
 	}
 }
 
-#ifdef CONFIG_BLOCK
-
 /* Return 1 if 'cmd' will block on frozen filesystem */
 static int quotactl_cmd_write(int cmd)
 {
@@ -850,7 +849,6 @@ static int quotactl_cmd_write(int cmd)
 	}
 	return 1;
 }
-#endif /* CONFIG_BLOCK */
 
 /* Return true if quotactl command is manipulating quota on/off state */
 static bool quotactl_cmd_onoff(int cmd)
@@ -968,3 +966,48 @@ SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
 		path_put(pathp);
 	return ret;
 }
+
+SYSCALL_DEFINE4(quotactl_path, unsigned int, cmd, const char __user *,
+		mountpoint, qid_t, id, void __user *, addr)
+{
+	struct super_block *sb;
+	struct path mountpath;
+	unsigned int cmds = cmd >> SUBCMDSHIFT;
+	unsigned int type = cmd & SUBCMDMASK;
+	int ret;
+
+	if (type >= MAXQUOTAS)
+		return -EINVAL;
+
+	ret = user_path_at(AT_FDCWD, mountpoint,
+			     LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT, &mountpath);
+	if (ret)
+		return ret;
+
+	sb = mountpath.mnt->mnt_sb;
+
+	if (quotactl_cmd_write(cmds)) {
+		ret = mnt_want_write(mountpath.mnt);
+		if (ret)
+			goto out;
+	}
+
+	if (quotactl_cmd_onoff(cmds))
+		down_write(&sb->s_umount);
+	else
+		down_read(&sb->s_umount);
+
+	ret = do_quotactl(sb, type, cmds, id, addr, ERR_PTR(-EINVAL));
+
+	if (quotactl_cmd_onoff(cmds))
+		up_write(&sb->s_umount);
+	else
+		up_read(&sb->s_umount);
+
+	if (quotactl_cmd_write(cmds))
+		mnt_drop_write(mountpath.mnt);
+out:
+	path_put(&mountpath);
+
+	return ret;
+}
-- 
2.29.2

