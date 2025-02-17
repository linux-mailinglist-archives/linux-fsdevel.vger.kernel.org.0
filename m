Return-Path: <linux-fsdevel+bounces-41811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620F1A37933
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 01:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7648F1887C73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 00:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0273DD528;
	Mon, 17 Feb 2025 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fmZgL/Xf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hxJlqBY2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fmZgL/Xf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hxJlqBY2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8380E7483
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739752251; cv=none; b=oWbu7wphOSn3swTWDKNzXzD0sYBGetgZ1t+vqs5mI1yl7sD70fY6J8znTjLv1fSUx7Tpf0xrgnNMbsn6ingqoC7/QnpMhzZa+ADyWbozy1iZXMIVV5N/MCJkMW1MOLpy2LEcVCnIYTtbI0ea3wPX7iY9gbqtyCm9+O83QfpG2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739752251; c=relaxed/simple;
	bh=ad41Y3l+UUMLFMl9gM4pyLtG5g4KbR2piYrYTvLq1eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXWvZQmRHFptNpNzj3KVaqEk+zWLQbxqpubSht47IBt48Q6Ymf+ozwXXNgBhhOAeCn71JpTr8ORaIf+IBpfCmf2BLJSPz26YUCzk6epAAbU+Ap3z1XmeAHDOMLj4Mvdgezhu+vD1BuShawPhP2c+u56Mv9R2yYHmXPDDZzx424M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fmZgL/Xf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hxJlqBY2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fmZgL/Xf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hxJlqBY2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 35A3D1F38E;
	Mon, 17 Feb 2025 00:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739752242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IigN0X9bnwo16yAB5aWLKnhC+XluKH2kFQUWgPvGes8=;
	b=fmZgL/Xfb1CXYI2gEDxC1M9+O+jlEtzAg8lmRFOQnqNG2h4rZ4jfgIKyYGgQoMQozR5sPG
	gE1wRCiPvbtyvOsVJx8apRj05NgRKkYnZtRxICUlaqMRc/Woz2/DksaJH/auYvy7Ikbh3S
	adgJ86NVFoJD+5mrK8xbRK3nfHqMdNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739752242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IigN0X9bnwo16yAB5aWLKnhC+XluKH2kFQUWgPvGes8=;
	b=hxJlqBY2Lay97luQtxHOt7gKgMJsLA44AQBiyOmMwe0nXGJoK+uHGJAylnzh1OBtCwyplJ
	28X+dyqdSkvwE4Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="fmZgL/Xf";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hxJlqBY2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739752242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IigN0X9bnwo16yAB5aWLKnhC+XluKH2kFQUWgPvGes8=;
	b=fmZgL/Xfb1CXYI2gEDxC1M9+O+jlEtzAg8lmRFOQnqNG2h4rZ4jfgIKyYGgQoMQozR5sPG
	gE1wRCiPvbtyvOsVJx8apRj05NgRKkYnZtRxICUlaqMRc/Woz2/DksaJH/auYvy7Ikbh3S
	adgJ86NVFoJD+5mrK8xbRK3nfHqMdNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739752242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IigN0X9bnwo16yAB5aWLKnhC+XluKH2kFQUWgPvGes8=;
	b=hxJlqBY2Lay97luQtxHOt7gKgMJsLA44AQBiyOmMwe0nXGJoK+uHGJAylnzh1OBtCwyplJ
	28X+dyqdSkvwE4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6772A136AD;
	Mon, 17 Feb 2025 00:30:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pDHIBzCDsmfJJwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 17 Feb 2025 00:30:40 +0000
From: NeilBrown <neilb@suse.de>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] VFS: change kern_path_locked() and user_path_locked_at() to never return negative dentry
Date: Mon, 17 Feb 2025 11:27:20 +1100
Message-ID: <20250217003020.3170652-2-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250217003020.3170652-1-neilb@suse.de>
References: <20250217003020.3170652-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 35A3D1F38E
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

No callers of kern_path_locked() or user_path_locked_at() want a
negative dentry.  So change them to return -ENOENT instead.  This
simplifies callers.

This results in a subtle change to bcachefs in that an ioctl will now
return -ENOENT in preference to -EXDEV.  I believe this restores the
behaviour to what it was prior to
 Commit bbe6a7c899e7 ("bch2_ioctl_subvolume_destroy(): fix locking")

Signed-off-by: NeilBrown <neilb@suse.de>
Link: https://lore.kernel.org/r/20250207034040.3402438-2-neilb@suse.de
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 Documentation/filesystems/porting.rst |  8 ++++
 drivers/base/devtmpfs.c               | 65 +++++++++++++--------------
 fs/bcachefs/fs-ioctl.c                |  4 --
 fs/namei.c                            |  4 ++
 kernel/audit_watch.c                  | 12 ++---
 5 files changed, 48 insertions(+), 45 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 1639e78e3146..2ead47e20677 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1157,3 +1157,11 @@ in normal case it points into the pathname being looked up.
 NOTE: if you need something like full path from the root of filesystem,
 you are still on your own - this assists with simple cases, but it's not
 magic.
+
+---
+
+** recommended**
+
+kern_path_locked() and user_path_locked() no longer return a negative
+dentry so this doesn't need to be checked.  If the name cannot be found,
+ERR_PTR(-ENOENT) is returned.
diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index b848764ef018..c9e34842139f 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -245,15 +245,12 @@ static int dev_rmdir(const char *name)
 	dentry = kern_path_locked(name, &parent);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
-	if (d_really_is_positive(dentry)) {
-		if (d_inode(dentry)->i_private == &thread)
-			err = vfs_rmdir(&nop_mnt_idmap, d_inode(parent.dentry),
-					dentry);
-		else
-			err = -EPERM;
-	} else {
-		err = -ENOENT;
-	}
+	if (d_inode(dentry)->i_private == &thread)
+		err = vfs_rmdir(&nop_mnt_idmap, d_inode(parent.dentry),
+				dentry);
+	else
+		err = -EPERM;
+
 	dput(dentry);
 	inode_unlock(d_inode(parent.dentry));
 	path_put(&parent);
@@ -310,6 +307,8 @@ static int handle_remove(const char *nodename, struct device *dev)
 {
 	struct path parent;
 	struct dentry *dentry;
+	struct kstat stat;
+	struct path p;
 	int deleted = 0;
 	int err;
 
@@ -317,32 +316,28 @@ static int handle_remove(const char *nodename, struct device *dev)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-	if (d_really_is_positive(dentry)) {
-		struct kstat stat;
-		struct path p = {.mnt = parent.mnt, .dentry = dentry};
-		err = vfs_getattr(&p, &stat, STATX_TYPE | STATX_MODE,
-				  AT_STATX_SYNC_AS_STAT);
-		if (!err && dev_mynode(dev, d_inode(dentry), &stat)) {
-			struct iattr newattrs;
-			/*
-			 * before unlinking this node, reset permissions
-			 * of possible references like hardlinks
-			 */
-			newattrs.ia_uid = GLOBAL_ROOT_UID;
-			newattrs.ia_gid = GLOBAL_ROOT_GID;
-			newattrs.ia_mode = stat.mode & ~0777;
-			newattrs.ia_valid =
-				ATTR_UID|ATTR_GID|ATTR_MODE;
-			inode_lock(d_inode(dentry));
-			notify_change(&nop_mnt_idmap, dentry, &newattrs, NULL);
-			inode_unlock(d_inode(dentry));
-			err = vfs_unlink(&nop_mnt_idmap, d_inode(parent.dentry),
-					 dentry, NULL);
-			if (!err || err == -ENOENT)
-				deleted = 1;
-		}
-	} else {
-		err = -ENOENT;
+	p.mnt = parent.mnt;
+	p.dentry = dentry;
+	err = vfs_getattr(&p, &stat, STATX_TYPE | STATX_MODE,
+			  AT_STATX_SYNC_AS_STAT);
+	if (!err && dev_mynode(dev, d_inode(dentry), &stat)) {
+		struct iattr newattrs;
+		/*
+		 * before unlinking this node, reset permissions
+		 * of possible references like hardlinks
+		 */
+		newattrs.ia_uid = GLOBAL_ROOT_UID;
+		newattrs.ia_gid = GLOBAL_ROOT_GID;
+		newattrs.ia_mode = stat.mode & ~0777;
+		newattrs.ia_valid =
+			ATTR_UID|ATTR_GID|ATTR_MODE;
+		inode_lock(d_inode(dentry));
+		notify_change(&nop_mnt_idmap, dentry, &newattrs, NULL);
+		inode_unlock(d_inode(dentry));
+		err = vfs_unlink(&nop_mnt_idmap, d_inode(parent.dentry),
+				 dentry, NULL);
+		if (!err || err == -ENOENT)
+			deleted = 1;
 	}
 	dput(dentry);
 	inode_unlock(d_inode(parent.dentry));
diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
index 15725b4ce393..595b57fabc9a 100644
--- a/fs/bcachefs/fs-ioctl.c
+++ b/fs/bcachefs/fs-ioctl.c
@@ -511,10 +511,6 @@ static long bch2_ioctl_subvolume_destroy(struct bch_fs *c, struct file *filp,
 		ret = -EXDEV;
 		goto err;
 	}
-	if (!d_is_positive(victim)) {
-		ret = -ENOENT;
-		goto err;
-	}
 	ret = __bch2_unlink(dir, victim, true);
 	if (!ret) {
 		fsnotify_rmdir(dir, victim);
diff --git a/fs/namei.c b/fs/namei.c
index 3ab9440c5b93..fb6da3ca0ca5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2741,6 +2741,10 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
 	}
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
 	d = lookup_one_qstr_excl(&last, path->dentry, 0);
+	if (!IS_ERR(d) && d_is_negative(d)) {
+		dput(d);
+		d = ERR_PTR(-ENOENT);
+	}
 	if (IS_ERR(d)) {
 		inode_unlock(path->dentry->d_inode);
 		path_put(path);
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 7f358740e958..367eaf2c78b7 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -350,11 +350,10 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 	struct dentry *d = kern_path_locked(watch->path, parent);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
-	if (d_is_positive(d)) {
-		/* update watch filter fields */
-		watch->dev = d->d_sb->s_dev;
-		watch->ino = d_backing_inode(d)->i_ino;
-	}
+	/* update watch filter fields */
+	watch->dev = d->d_sb->s_dev;
+	watch->ino = d_backing_inode(d)->i_ino;
+
 	inode_unlock(d_backing_inode(parent->dentry));
 	dput(d);
 	return 0;
@@ -419,10 +418,11 @@ int audit_add_watch(struct audit_krule *krule, struct list_head **list)
 	/* caller expects mutex locked */
 	mutex_lock(&audit_filter_mutex);
 
-	if (ret) {
+	if (ret && ret != -ENOENT) {
 		audit_put_watch(watch);
 		return ret;
 	}
+	ret = 0;
 
 	/* either find an old parent or attach a new one */
 	parent = audit_find_parent(d_backing_inode(parent_path.dentry));
-- 
2.47.1


