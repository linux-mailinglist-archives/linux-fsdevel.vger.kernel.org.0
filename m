Return-Path: <linux-fsdevel+bounces-25871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8737D951351
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 06:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAEC81C22729
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 04:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2DD4D8AF;
	Wed, 14 Aug 2024 04:00:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C19F3CF5E;
	Wed, 14 Aug 2024 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.200.0.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723608007; cv=none; b=bOHwGMuNU9U7jjMb1u6FdBk8a3lwrcunSMHo2f0Q+B3evWgDC3PceDc5XSgjRPRKgS2SWO95PJWmzkiPPivvleXXOL5Gw+g65VkhiRmnITeeHmyZiNjgw3a3Qi8234pKujPfamm5Gz2E683yKkr0DhVf2aNsurBLwPmHmrt+Ltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723608007; c=relaxed/simple;
	bh=WB+2zQtytofmu/yr/wFfnfLYrFRUa7pYSLMHguZiWIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZXiIEDPLI1kfWH1KFg5aRJ1BxlsRqUO7Ug7sqafTlq3ECBZf2E1axzfle+HBBEey+IbLiODLzA6FoEUSeCei7ud3SKviEJ5q4aQyK4OKI5zbDmI9dbQPwj5Uh9x66hFvrL/RP8x5TsFnHl96H6Gd6zlZqf11ydV6PDQRITj6VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; arc=none smtp.client-ip=121.200.0.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp01.aussiebb.com.au (Postfix) with ESMTP id 312E31002E9;
	Wed, 14 Aug 2024 13:51:31 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
	by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sZNvRx-Am6Ct; Wed, 14 Aug 2024 13:51:31 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
	id 275111003DF; Wed, 14 Aug 2024 13:51:31 +1000 (AEST)
X-Spam-Level: 
Received: from mickey.redhat.com (159-196-82-144.9fc452.per.static.aussiebb.net [159.196.82.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ian146@aussiebb.com.au)
	by smtp01.aussiebb.com.au (Postfix) with ESMTPSA id E2CE71002E9;
	Wed, 14 Aug 2024 13:51:28 +1000 (AEST)
From: Ian Kent <raven@themaw.net>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: autofs mailing list <autofs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs: add per dentry expire timeout
Date: Wed, 14 Aug 2024 11:50:37 +0800
Message-ID: <20240814035037.44267-1-raven@themaw.net>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ability to set per-dentry mount expire timeout to autofs.

There are two fairly well known automounter map formats, the autofs
format and the amd format (more or less System V and Berkley).

Some time ago Linux autofs added an amd map format parser that
implemented a fair amount of the amd functionality. This was done
within the autofs infrastructure and some functionality wasn't
implemented because it either didn't make sense or required extra
kernel changes. The idea was to restrict changes to be within the
existing autofs functionality as much as possible and leave changes
with a wider scope to be considered later.

One of these changes is implementing the amd options:
1) "unmount", expire this mount according to a timeout (same as the
   current autofs default).
2) "nounmount", don't expire this mount (same as setting the autofs
   timeout to 0 except only for this specific mount) .
3) "utimeout=<seconds>", expire this mount using the specified
   timeout (again same as setting the autofs timeout but only for
   this mount).

To implement these options per-dentry expire timeouts need to be
implemented for autofs indirect mounts. This is because all map keys
(mounts) for autofs indirect mounts use an expire timeout stored in
the autofs mount super block info. structure and all indirect mounts
use the same expire timeout.

Now I have a request to add the "nounmount" option so I need to add
the per-dentry expire handling to the kernel implementation to do this.

The implementation uses the trailing path component to identify the
mount (and is also used as the autofs map key) which is passed in the
autofs_dev_ioctl structure path field. The expire timeout is passed
in autofs_dev_ioctl timeout field (well, of the timeout union).

If the passed in timeout is equal to -1 the per-dentry timeout and
flag are cleared providing for the "unmount" option. If the timeout
is greater than or equal to 0 the timeout is set to the value and the
flag is also set. If the dentry timeout is 0 the dentry will not expire
by timeout which enables the implementation of the "nounmount" option
for the specific mount. When the dentry timeout is greater than zero it
allows for the implementation of the "utimeout=<seconds>" option.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h         |  4 ++
 fs/autofs/dev-ioctl.c        | 97 ++++++++++++++++++++++++++++++++++--
 fs/autofs/expire.c           |  7 ++-
 fs/autofs/inode.c            |  2 +
 include/uapi/linux/auto_fs.h |  2 +-
 5 files changed, 104 insertions(+), 8 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 8c1d587b3eef..77c7991d89aa 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -62,6 +62,7 @@ struct autofs_info {
 	struct list_head expiring;
 
 	struct autofs_sb_info *sbi;
+	unsigned long exp_timeout;
 	unsigned long last_used;
 	int count;
 
@@ -81,6 +82,9 @@ struct autofs_info {
 					*/
 #define AUTOFS_INF_PENDING	(1<<2) /* dentry pending mount */
 
+#define AUTOFS_INF_EXPIRE_SET	(1<<3) /* per-dentry expire timeout set for
+					  this mount point.
+					*/
 struct autofs_wait_queue {
 	wait_queue_head_t queue;
 	struct autofs_wait_queue *next;
diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index 5bf781ea6d67..72d4a70718c2 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -128,7 +128,13 @@ static int validate_dev_ioctl(int cmd, struct autofs_dev_ioctl *param)
 			goto out;
 		}
 
+		/* Setting the per-dentry expire timeout requires a trailing
+		 * path component, ie. no '/', so invert the logic of the
+		 * check_name() return for AUTOFS_DEV_IOCTL_TIMEOUT_CMD.
+		 */
 		err = check_name(param->path);
+		if (cmd == AUTOFS_DEV_IOCTL_TIMEOUT_CMD)
+			err = err ? 0 : -EINVAL;
 		if (err) {
 			pr_warn("invalid path supplied for cmd(0x%08x)\n",
 				cmd);
@@ -396,16 +402,97 @@ static int autofs_dev_ioctl_catatonic(struct file *fp,
 	return 0;
 }
 
-/* Set the autofs mount timeout */
+/*
+ * Set the autofs mount expire timeout.
+ *
+ * There are two places an expire timeout can be set, in the autofs
+ * super block info. (this is all that's needed for direct and offset
+ * mounts because there's a distinct mount corresponding to each of
+ * these) and per-dentry within within the dentry info. If a per-dentry
+ * timeout is set it will override the expire timeout set in the parent
+ * autofs super block info.
+ *
+ * If setting the autofs super block expire timeout the autofs_dev_ioctl
+ * size field will be equal to the autofs_dev_ioctl structure size. If
+ * setting the per-dentry expire timeout the mount point name is passed
+ * in the autofs_dev_ioctl path field and the size field updated to
+ * reflect this.
+ *
+ * Setting the autofs mount expire timeout sets the timeout in the super
+ * block info. struct. Setting the per-dentry timeout does a little more.
+ * If the timeout is equal to -1 the per-dentry timeout (and flag) is
+ * cleared which reverts to using the super block timeout, otherwise if
+ * timeout is 0 the timeout is set to this value and the flag is left
+ * set which disables expiration for the mount point, lastly the flag
+ * and the timeout are set enabling the dentry to use this timeout.
+ */
 static int autofs_dev_ioctl_timeout(struct file *fp,
 				    struct autofs_sb_info *sbi,
 				    struct autofs_dev_ioctl *param)
 {
-	unsigned long timeout;
+	unsigned long timeout = param->timeout.timeout;
+
+	/* If setting the expire timeout for an individual indirect
+	 * mount point dentry the mount trailing component path is
+	 * placed in param->path and param->size adjusted to account
+	 * for it otherwise param->size it is set to the structure
+	 * size.
+	 */
+	if (param->size == AUTOFS_DEV_IOCTL_SIZE) {
+		param->timeout.timeout = sbi->exp_timeout / HZ;
+		sbi->exp_timeout = timeout * HZ;
+	} else {
+		struct dentry *base = fp->f_path.dentry;
+		struct inode *inode = base->d_inode;
+		int path_len = param->size - AUTOFS_DEV_IOCTL_SIZE - 1;
+		struct dentry *dentry;
+		struct autofs_info *ino;
+
+		if (!autofs_type_indirect(sbi->type))
+			return -EINVAL;
+
+		/* An expire timeout greater than the superblock timeout
+		 * could be a problem at shutdown but the super block
+		 * timeout itself can change so all we can really do is
+		 * warn the user.
+		 */
+		if (timeout >= sbi->exp_timeout)
+			pr_warn("per-mount expire timeout is greater than "
+				"the parent autofs mount timeout which could "
+				"prevent shutdown\n");
+
+		inode_lock_shared(inode);
+		dentry = try_lookup_one_len(param->path, base, path_len);
+		inode_unlock_shared(inode);
+		if (!dentry)
+			return -ENOENT;
+		ino = autofs_dentry_ino(dentry);
+		if (!ino) {
+			dput(dentry);
+			return -ENOENT;
+		}
+
+		if (ino->exp_timeout && ino->flags & AUTOFS_INF_EXPIRE_SET)
+			param->timeout.timeout = ino->exp_timeout / HZ;
+		else
+			param->timeout.timeout = sbi->exp_timeout / HZ;
+
+		if (timeout == -1) {
+			/* Revert to using the super block timeout */
+			ino->flags &= ~AUTOFS_INF_EXPIRE_SET;
+			ino->exp_timeout = 0;
+		} else {
+			/* Set the dentry expire flag and timeout.
+			 *
+			 * If timeout is 0 it will prevent the expire
+			 * of this particular automount.
+			 */
+			ino->flags |= AUTOFS_INF_EXPIRE_SET;
+			ino->exp_timeout = timeout * HZ;
+		}
+		dput(dentry);
+	}
 
-	timeout = param->timeout.timeout;
-	param->timeout.timeout = sbi->exp_timeout / HZ;
-	sbi->exp_timeout = timeout * HZ;
 	return 0;
 }
 
diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index 39d8c84c16f4..5c2d459e1e48 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -429,8 +429,6 @@ static struct dentry *autofs_expire_indirect(struct super_block *sb,
 	if (!root)
 		return NULL;
 
-	timeout = sbi->exp_timeout;
-
 	dentry = NULL;
 	while ((dentry = get_next_positive_subdir(dentry, root))) {
 		spin_lock(&sbi->fs_lock);
@@ -441,6 +439,11 @@ static struct dentry *autofs_expire_indirect(struct super_block *sb,
 		}
 		spin_unlock(&sbi->fs_lock);
 
+		if (ino->flags & AUTOFS_INF_EXPIRE_SET)
+			timeout = ino->exp_timeout;
+		else
+			timeout = sbi->exp_timeout;
+
 		expired = should_expire(dentry, mnt, timeout, how);
 		if (!expired)
 			continue;
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index cf792d4de4f1..068f273757bf 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -19,6 +19,7 @@ struct autofs_info *autofs_new_ino(struct autofs_sb_info *sbi)
 		INIT_LIST_HEAD(&ino->expiring);
 		ino->last_used = jiffies;
 		ino->sbi = sbi;
+		ino->exp_timeout = -1;
 		ino->count = 1;
 	}
 	return ino;
@@ -28,6 +29,7 @@ void autofs_clean_ino(struct autofs_info *ino)
 {
 	ino->uid = GLOBAL_ROOT_UID;
 	ino->gid = GLOBAL_ROOT_GID;
+	ino->exp_timeout = -1;
 	ino->last_used = jiffies;
 }
 
diff --git a/include/uapi/linux/auto_fs.h b/include/uapi/linux/auto_fs.h
index 1f7925afad2d..8081df849743 100644
--- a/include/uapi/linux/auto_fs.h
+++ b/include/uapi/linux/auto_fs.h
@@ -23,7 +23,7 @@
 #define AUTOFS_MIN_PROTO_VERSION	3
 #define AUTOFS_MAX_PROTO_VERSION	5
 
-#define AUTOFS_PROTO_SUBVERSION		5
+#define AUTOFS_PROTO_SUBVERSION		6
 
 /*
  * The wait_queue_token (autofs_wqt_t) is part of a structure which is passed
-- 
2.46.0


