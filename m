Return-Path: <linux-fsdevel+bounces-41006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AEEA2A047
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA8D37A3A34
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 05:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522D722489F;
	Thu,  6 Feb 2025 05:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o1yycAys";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5ZZ5GMuX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o1yycAys";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5ZZ5GMuX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B91B59A;
	Thu,  6 Feb 2025 05:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820770; cv=none; b=td7N1+nPFYibLgA+pJbjkVB+aGex8wBZ11Un++PpgBOjg7IJgQCsV5LaW8LAWMsC3dhlDkNCMvTs1qvLy+3vH1FfSNcrHqET1LIdj8xiGHwJVcwgMeaJGNnw5dZGUxusN/yv2kr0N6EZdEtkjmxAl6ChaA8OYojx4UCL0vbplU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820770; c=relaxed/simple;
	bh=IFL6e9skluEBA+ZHKwDT0D/ofuadconVJvzIi3nlTQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwdHWLnK548egDtqqyhfPaU0+s7ntPTZGtLFK2NvYTvG6uc1rhA7QDS5kcU6v6rXdYCUblY8Y84QM4ciTPNDJ+ytkAbK/mKnO8yiV/HCL2hdMVQR1s7kbBIZCVKn8FZBt0hTxII3DmBVZJ5Kvg9FzkPLITZx2FWCM4iBfPKTN3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o1yycAys; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5ZZ5GMuX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o1yycAys; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5ZZ5GMuX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BDD81F381;
	Thu,  6 Feb 2025 05:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4UdCFI90AtbHekiiPg50qrTWMAXWD+8+25n2lXUv+JU=;
	b=o1yycAysmdRk1yYMgtMnodZmvLb+bz0seyWMMYCdyNAtyamJxYSnE7q8nSQRvjotLrNkpm
	0Jl7t8wM/AqHlHx+vij1u8XEmM8IBjzwRgr2FLOgFMDLE5suEhcna7A8z5E0afMNQ1aNWv
	4mNBe0AOf/MqtkNeikFRWWBoAGG3CDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4UdCFI90AtbHekiiPg50qrTWMAXWD+8+25n2lXUv+JU=;
	b=5ZZ5GMuXeGmLdeTzwcHMfltWc1nqxOjIkqnApXi+PI3XAxyeJRNmnlbCR7IdC7VqPwwSfX
	FmIZSMLoLETIpeCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o1yycAys;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5ZZ5GMuX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4UdCFI90AtbHekiiPg50qrTWMAXWD+8+25n2lXUv+JU=;
	b=o1yycAysmdRk1yYMgtMnodZmvLb+bz0seyWMMYCdyNAtyamJxYSnE7q8nSQRvjotLrNkpm
	0Jl7t8wM/AqHlHx+vij1u8XEmM8IBjzwRgr2FLOgFMDLE5suEhcna7A8z5E0afMNQ1aNWv
	4mNBe0AOf/MqtkNeikFRWWBoAGG3CDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4UdCFI90AtbHekiiPg50qrTWMAXWD+8+25n2lXUv+JU=;
	b=5ZZ5GMuXeGmLdeTzwcHMfltWc1nqxOjIkqnApXi+PI3XAxyeJRNmnlbCR7IdC7VqPwwSfX
	FmIZSMLoLETIpeCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B1C113795;
	Thu,  6 Feb 2025 05:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id floTDJxMpGdyBwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 05:46:04 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/19] VFS: change kern_path_locked() and user_path_locked_at() to never return negative dentry
Date: Thu,  6 Feb 2025 16:42:41 +1100
Message-ID: <20250206054504.2950516-5-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206054504.2950516-1-neilb@suse.de>
References: <20250206054504.2950516-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3BDD81F381
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

No callers of kern_path_locked() or user_path_locked_at() want a
negative dentry.  So change them to return -ENOENT instead.  This
simplifies callers.

This results in a subtle change to bcachefs in that an ioctl will now
return -ENOENT in preference to -EXDEV.  I believe this restores the
behaviour to what it was prior to
 Commit bbe6a7c899e7 ("bch2_ioctl_subvolume_destroy(): fix locking")

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/base/devtmpfs.c | 65 +++++++++++++++++++----------------------
 fs/bcachefs/fs-ioctl.c  |  4 ---
 fs/namei.c              |  4 +++
 kernel/audit_watch.c    | 12 ++++----
 4 files changed, 40 insertions(+), 45 deletions(-)

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
index d684102d873d..1901120bcbb8 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2745,6 +2745,10 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
 	}
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
 	d = lookup_one_qstr(&last, path->dentry, 0);
+	if (!IS_ERR(d) && d_is_negative(d)) {
+		dput(d);
+		d = ERR_PTR(-ENOENT);
+	}
 	if (IS_ERR(d)) {
 		inode_unlock(path->dentry->d_inode);
 		path_put(path);
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 7f358740e958..e3130675ee6b 100644
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
@@ -419,7 +418,7 @@ int audit_add_watch(struct audit_krule *krule, struct list_head **list)
 	/* caller expects mutex locked */
 	mutex_lock(&audit_filter_mutex);
 
-	if (ret) {
+	if (ret && ret != -ENOENT) {
 		audit_put_watch(watch);
 		return ret;
 	}
@@ -438,6 +437,7 @@ int audit_add_watch(struct audit_krule *krule, struct list_head **list)
 
 	h = audit_hash_ino((u32)watch->ino);
 	*list = &audit_inode_hash[h];
+	ret = 0;
 error:
 	path_put(&parent_path);
 	audit_put_watch(watch);
-- 
2.47.1


