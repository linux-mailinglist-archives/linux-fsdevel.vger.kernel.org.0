Return-Path: <linux-fsdevel+bounces-37904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE609F8A6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 04:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7A71896BCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 03:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092E717B401;
	Fri, 20 Dec 2024 03:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LXDUHvSK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FUUGJQu8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RjTNp9b2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DOH2YnTk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D831632C8;
	Fri, 20 Dec 2024 03:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734664154; cv=none; b=JPNEjJIlVx6g+4tH4BBLLUtA1pdJkPU4vZH4hmjCm9NI/gUyQi/UMGNUV1AbjWD6x+imx1tnOzlDJqd7shSGi5mAJWkAha6j1SfjyMhmi4wkgyuJJ19H85yATSXshPwt2oNDgLIHyXFo0YJkAkkeTFD8SRG4s7ows1++MISy9JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734664154; c=relaxed/simple;
	bh=igjLZU34N84JAJHbkG3DJsr5Py53lspSM/nGwQzLgm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZtnEZtQ17bH9wwL8xrp9GFtaZzeCh2Q4W0cpD7yJrlINTkXx+3Oqs/kKkV83GD3tfvUUnTQQdECFpeQN/O2EXAfDO3LXsApWrTaNa7F7pdJZaZmLx5bzlX32pdVyYET1xdKTCobERA5vz2U01XoM743CIB8UQc7yJvKngLbAek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LXDUHvSK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FUUGJQu8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RjTNp9b2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DOH2YnTk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E42AD1F385;
	Fri, 20 Dec 2024 03:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g78TC/Zbx8kwsLCDh78LnjHG14nWVEMWb4e/lUvSCGI=;
	b=LXDUHvSKAxVzHleis25dnUqV8IpKRuDk5GO/8ijcmuYt5KDBG+gh6KyQsHq3YD1YJyGy7e
	gprXAs2Sg5z+dftCPBFuzb4UVVaZZvnd7tVhd9yv6H3oJ3fdj9rb0pZuqYYLfiAOsmtITj
	1wWfPt0ieIToiZy/3UTDCdpBYz0990M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g78TC/Zbx8kwsLCDh78LnjHG14nWVEMWb4e/lUvSCGI=;
	b=FUUGJQu85zdXk/lvyhN6CF/EDkh8S1i6ui0yCk0VRbW1OWXlWEUuNp5d/G2QVeLzyFQDRN
	zk82QMPDlK3raLDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RjTNp9b2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DOH2YnTk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g78TC/Zbx8kwsLCDh78LnjHG14nWVEMWb4e/lUvSCGI=;
	b=RjTNp9b27DSfXom89DQt6DbUZnL1ES/qS28LHCKFsmL2np1bC5cq7qY418T860GG8R6q8H
	sOdEpsf9LZFwFYQGtdaw7OgoRC7COVLCLA/9ZzKazKjpOfPXKYguQY+x8OnZPDj1X4IoF9
	1+vrGk8Of06PIP3DO9aZMTvi5mTvel4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g78TC/Zbx8kwsLCDh78LnjHG14nWVEMWb4e/lUvSCGI=;
	b=DOH2YnTkN5bh0qVRjo/XzqC582Il62loqkNL3QhPPDJSm+60ceCoUXMNI3iu9WJCTYLtu7
	MMXJZnVk43laxPBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC20913A32;
	Fri, 20 Dec 2024 03:09:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 42lDINTfZGdTGAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 20 Dec 2024 03:09:08 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] VFS: change kern_path_locked() and user_path_locked_at() to never return negative dentry
Date: Fri, 20 Dec 2024 13:54:23 +1100
Message-ID: <20241220030830.272429-6-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220030830.272429-1-neilb@suse.de>
References: <20241220030830.272429-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E42AD1F385
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
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
index 405cf08bda34..c5464219b23f 100644
--- a/fs/bcachefs/fs-ioctl.c
+++ b/fs/bcachefs/fs-ioctl.c
@@ -516,10 +516,6 @@ static long bch2_ioctl_subvolume_destroy(struct bch_fs *c, struct file *filp,
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
index 395bfbc8fc92..8780406cb4d7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2743,6 +2743,10 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
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
2.47.0


