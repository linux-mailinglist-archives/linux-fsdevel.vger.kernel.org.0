Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8057314B244
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 11:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgA1KGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 05:06:33 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50723 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgA1KGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:06:33 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iwNlP-0008Dq-QQ; Tue, 28 Jan 2020 11:06:31 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1iwNlP-0004fS-1f; Tue, 28 Jan 2020 11:06:31 +0100
Date:   Tue, 28 Jan 2020 11:06:31 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/8] quota: Allow to pass mount path to quotactl
Message-ID: <20200128100631.zv7cn726twylcmb7@pengutronix.de>
References: <20200124131323.23885-1-s.hauer@pengutronix.de>
 <20200124131323.23885-2-s.hauer@pengutronix.de>
 <20200127104518.GC19414@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127104518.GC19414@quack2.suse.cz>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:03:46 up 204 days, 16:13, 87 users,  load average: 0.27, 0.34,
 0.27
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

On Mon, Jan 27, 2020 at 11:45:18AM +0100, Jan Kara wrote:
> >  	cmds = cmd >> SUBCMDSHIFT;
> >  	type = cmd & SUBCMDMASK;
> >  
> > +
> 
> Unnecessary empty line added...

Fixed

> > +	if (q_path) {
> > +		ret = user_path_at(AT_FDCWD, special,
> > +				   LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT,
> > +				   &sb_path);
> > +		if (ret)
> > +			goto out;
> > +
> > +		sb = sb_path.mnt->mnt_sb;
> 
> So I've realized that just looking up superblock with user_path_at() is not
> enough. Quota code also expects that the superblock will be locked
> (sb->s_umount) and filesystem will not be frozen (in case the quota
> operation is going to modify the filesystem). This is needed to serialize
> e.g. remount and quota operations or quota operations among themselves.
> So you still need something like following to get superblock from the path:

Ok, here's an updated version. I'll send an update for the whole series
when Richard had a look over it.

Sascha

----------------------------8<-----------------------------

From 9c91395f2667c8a48f52a80896e559daf16f4a4c Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 30 Oct 2019 08:35:11 +0100
Subject: [PATCH] quota: Allow to pass mount path to quotactl

This patch introduces the Q_PATH flag to the quotactl cmd argument.
When given, the path given in the special argument to quotactl will
be the mount path where the filesystem is mounted, instead of a path
to the block device.
This is necessary for filesystems which do not have a block device as
backing store. Particularly this is done for upcoming UBIFS support.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/quota/quota.c           | 75 ++++++++++++++++++++++++++++++++------
 include/uapi/linux/quota.h |  1 +
 2 files changed, 64 insertions(+), 12 deletions(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 5444d3c4d93f..712b71760f9d 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -19,6 +19,7 @@
 #include <linux/types.h>
 #include <linux/writeback.h>
 #include <linux/nospec.h>
+#include <linux/mount.h>
 
 static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
 				     qid_t id)
@@ -810,6 +811,36 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
 #endif
 }
 
+static struct super_block *quotactl_path(const char __user *special, int cmd,
+					 struct path *path)
+{
+	struct super_block *sb;
+	int ret;
+
+	ret = user_path_at(AT_FDCWD, special, LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT,
+			   path);
+	if (ret)
+		return ERR_PTR(ret);
+
+	sb = path->mnt->mnt_sb;
+restart:
+	if (quotactl_cmd_onoff(cmd))
+		down_write(&sb->s_umount);
+	else
+		down_read(&sb->s_umount);
+
+	if (quotactl_cmd_write(cmd) && sb->s_writers.frozen != SB_UNFROZEN) {
+		if (quotactl_cmd_onoff(cmd))
+			up_write(&sb->s_umount);
+		else
+			up_read(&sb->s_umount);
+		wait_event(sb->s_writers.wait_unfrozen,
+			   sb->s_writers.frozen == SB_UNFROZEN);
+		goto restart;
+	}
+
+	return sb;
+}
 /*
  * This is the system call interface. This communicates with
  * the user-level programs. Currently this only supports diskquota
@@ -821,8 +852,9 @@ int kernel_quotactl(unsigned int cmd, const char __user *special,
 {
 	uint cmds, type;
 	struct super_block *sb = NULL;
-	struct path path, *pathp = NULL;
+	struct path file_path, *file_pathp = NULL, sb_path;
 	int ret;
+	bool q_path;
 
 	cmds = cmd >> SUBCMDSHIFT;
 	type = cmd & SUBCMDMASK;
@@ -830,6 +862,9 @@ int kernel_quotactl(unsigned int cmd, const char __user *special,
 	if (type >= MAXQUOTAS)
 		return -EINVAL;
 
+	q_path = cmds & Q_PATH;
+	cmds &= ~Q_PATH;
+
 	/*
 	 * As a special case Q_SYNC can be called without a specific device.
 	 * It will iterate all superblocks that have quota enabled and call
@@ -847,28 +882,44 @@ int kernel_quotactl(unsigned int cmd, const char __user *special,
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
+	if (q_path)
+		sb = quotactl_path(special, cmds, &sb_path);
+	else
+		sb = quotactl_block(special, cmds);
+
 	if (IS_ERR(sb)) {
 		ret = PTR_ERR(sb);
 		goto out;
 	}
 
-	ret = do_quotactl(sb, type, cmds, id, addr, pathp);
+	ret = do_quotactl(sb, type, cmds, id, addr, file_pathp);
+
+	if (q_path) {
+		if (quotactl_cmd_onoff(cmd))
+			up_write(&sb->s_umount);
+		else
+			up_read(&sb->s_umount);
+
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


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
