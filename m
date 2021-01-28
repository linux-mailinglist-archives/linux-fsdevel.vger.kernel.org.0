Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5CC3077C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 15:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhA1OSf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 09:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhA1OSd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:18:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E71C061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 06:17:53 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l5875-0000o2-MN; Thu, 28 Jan 2021 15:17:35 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l5875-0000zW-23; Thu, 28 Jan 2021 15:17:35 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/2] quota: Add mountpath based quota support
Date:   Thu, 28 Jan 2021 15:17:10 +0100
Message-Id: <20210128141713.25223-2-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210128141713.25223-1-s.hauer@pengutronix.de>
References: <20210128141713.25223-1-s.hauer@pengutronix.de>
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
---
 fs/quota/quota.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 6d16b2be5ac4..9ac09e128686 100644
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
@@ -968,3 +969,79 @@ SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
 		path_put(pathp);
 	return ret;
 }
+
+SYSCALL_DEFINE4(quotactl_path, unsigned int, cmd, const char __user *,
+		mountpoint, qid_t, id, void __user *, addr)
+{
+	uint cmds, type;
+	struct super_block *sb = NULL;
+	struct path path, *pathp = NULL;
+	struct path mountpath;
+	bool excl = false, thawed = false;
+	int ret;
+
+	cmds = cmd >> SUBCMDSHIFT;
+	type = cmd & SUBCMDMASK;
+
+	if (type >= MAXQUOTAS)
+		return -EINVAL;
+
+	if (!mountpoint)
+		return -ENODEV;
+
+	/*
+	 * Path for quotaon has to be resolved before grabbing superblock
+	 * because that gets s_umount sem which is also possibly needed by path
+	 * resolution (think about autofs) and thus deadlocks could arise.
+	 */
+	if (cmds == Q_QUOTAON) {
+		ret = user_path_at(AT_FDCWD, addr,
+				   LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT, &path);
+		if (ret)
+			pathp = ERR_PTR(ret);
+		else
+			pathp = &path;
+	}
+
+	ret = user_path_at(AT_FDCWD, mountpoint,
+			     LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT, &mountpath);
+	if (ret)
+		goto out;
+
+	if (quotactl_cmd_onoff(cmds)) {
+		excl = true;
+		thawed = true;
+	} else if (quotactl_cmd_write(cmds)) {
+		thawed = true;
+	}
+
+	if (thawed) {
+		ret = mnt_want_write(mountpath.mnt);
+		if (ret)
+			goto out1;
+	}
+
+	sb = mountpath.dentry->d_inode->i_sb;
+
+	if (excl)
+		down_write(&sb->s_umount);
+	else
+		down_read(&sb->s_umount);
+
+	ret = do_quotactl(sb, type, cmds, id, addr, pathp);
+
+	if (excl)
+		up_write(&sb->s_umount);
+	else
+		up_read(&sb->s_umount);
+
+	if (thawed)
+		mnt_drop_write(mountpath.mnt);
+out1:
+	path_put(&mountpath);
+
+out:
+	if (pathp && !IS_ERR(pathp))
+		path_put(pathp);
+	return ret;
+}
-- 
2.20.1

