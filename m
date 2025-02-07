Return-Path: <linux-fsdevel+bounces-41151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85391A2B9D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 04:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095073A6872
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 03:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE009188596;
	Fri,  7 Feb 2025 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QTLH8pGr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KEphscZ6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QTLH8pGr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KEphscZ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE9317C208;
	Fri,  7 Feb 2025 03:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738899680; cv=none; b=Ds9FfPPsM5iHprmsi0qYH1wqDYkUpVaiCN3t9FpJB33RFN07NFJbQFDq1KnfGGlFzx5gqaIQrPkXDroWcB2FOF61O7YKMhhcVkaH2+V2R3i/qlnL/Tf1RYDRLqhc3jFNVpQ+/ECax4BbGqgNZ45d8Au1lGsS0iu49M5i+nOqYPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738899680; c=relaxed/simple;
	bh=S6ItaUNXOlGqoDeZxKet7CHJYVDZKRLFmq4O/Ukg1y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppG0soBL+rmoiAEKslyPQueHsXsd84WdIV1L9YecOeiqCpj9CSHo5nt+DTR3hrv5F44qE5jLiaFcaPsEYuggBeHGhlchZBq5Y3Y3igxSN1JOLZxQwwY0UjpZSXVlaXQcdEVF6rU6b8jsKFNEj6ZbbzaeKVIHmarHVdJlsfXPkrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QTLH8pGr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KEphscZ6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QTLH8pGr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KEphscZ6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8472D1F397;
	Fri,  7 Feb 2025 03:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738899676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0EgTHhCy35rNqnC5DTeteBAZIPXZvCD8iau5Cp57Tc=;
	b=QTLH8pGr/H7WIxXZkjLAYOKexGyD5qkjE+6iVdV/PFbU+PAuJHtbKEsgwTzsfslYceF907
	/7qdH3RRJ9V+adC0orXXc5y7tnT8klJOB3TYi9wGNAA5S2p54J5QH8/C5Ysh8LhoWiI4Hg
	RrjfiLm/cn0dGdH+3YcNW63vd1GnbII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738899676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0EgTHhCy35rNqnC5DTeteBAZIPXZvCD8iau5Cp57Tc=;
	b=KEphscZ6PU8biuM3XuRO/AVkCGydF2unTcAtKrleUMKVnK+aCPDM4Afo0e+9nom3//EsTi
	0g/dA8myHHJptkCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738899676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0EgTHhCy35rNqnC5DTeteBAZIPXZvCD8iau5Cp57Tc=;
	b=QTLH8pGr/H7WIxXZkjLAYOKexGyD5qkjE+6iVdV/PFbU+PAuJHtbKEsgwTzsfslYceF907
	/7qdH3RRJ9V+adC0orXXc5y7tnT8klJOB3TYi9wGNAA5S2p54J5QH8/C5Ysh8LhoWiI4Hg
	RrjfiLm/cn0dGdH+3YcNW63vd1GnbII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738899676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0EgTHhCy35rNqnC5DTeteBAZIPXZvCD8iau5Cp57Tc=;
	b=KEphscZ6PU8biuM3XuRO/AVkCGydF2unTcAtKrleUMKVnK+aCPDM4Afo0e+9nom3//EsTi
	0g/dA8myHHJptkCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D284F13694;
	Fri,  7 Feb 2025 03:41:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gc5lIdWApWeufgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 03:41:09 +0000
From: NeilBrown <neilb@suse.de>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	audit@vger.kernel.org
Subject: [PATCH 1/2] VFS: change kern_path_locked() and user_path_locked_at() to never return negative dentry
Date: Fri,  7 Feb 2025 14:36:47 +1100
Message-ID: <20250207034040.3402438-2-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250207034040.3402438-1-neilb@suse.de>
References: <20250207034040.3402438-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
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
index 3a4039acdb3f..e3047db7b2b4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2736,6 +2736,10 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
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
2.47.1


