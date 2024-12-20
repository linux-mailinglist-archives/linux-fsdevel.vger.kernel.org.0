Return-Path: <linux-fsdevel+bounces-37905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C86F9F8A6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 04:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777A2165D8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 03:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55674189BB5;
	Fri, 20 Dec 2024 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O8Cc1fgf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B53r9Jh1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O8Cc1fgf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B53r9Jh1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227AD17E8E2;
	Fri, 20 Dec 2024 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734664159; cv=none; b=QHnWhWXyVbCHH2mbw8+35F2F+URm2FdsoWHovsUixD85D2N/aLeg/TiguGynG5/zQS/RiW10fbkzF6EqRzDOWrhXZEu/zgXDP8JIUPas0QdbFu3Wj+pqlUCqL8Wif4OTkcBouuYI/qyOXpN/O9iIpIlZ3b8M9CUyQ7vrM56Yym0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734664159; c=relaxed/simple;
	bh=C9RupBWquoHEOawqo9DZe76e8vReOGkDekoEbmi6HAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbluqHSjMR5A1GNL0tIjc86NtqookUfd757Wn0KrzSoZSOxrYYiuLHD/bSU79ToDQnqaW+oqDeKDRAHu9I5zn8odNFUj2PBwdzkuupodOtqrV6xHDiluufTJxvNvcDWAhcESVxiujcBaGhKnVL72fcdz/GZ0iXt7fc4/3oj/zkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O8Cc1fgf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B53r9Jh1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O8Cc1fgf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B53r9Jh1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A5AD1F385;
	Fri, 20 Dec 2024 03:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BPrK/dwiAh/i96umzwTDF3eWf8F9yePnwIjP2Sj9Ck=;
	b=O8Cc1fgfSpoDvGLWxEf3FaqRzQAFpHUYDnycCEvNSkyGeeyHBSksTUSZ/ADqc0mdxnwZQn
	qUAPMQdmiQ6zQMiZf26QoxknPfutevEcL30baPjuACCJ73pFjd4i9j8YJtNDpc10c2oI5y
	SFHK1aY5zhT4xNDtkQx1dC4D2N+CsLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BPrK/dwiAh/i96umzwTDF3eWf8F9yePnwIjP2Sj9Ck=;
	b=B53r9Jh1KtlbypEc7hKpH7T1Z4e57FvbSbmENRPlvZvaQG699TkiTSC53vSRxlkhyFMuCw
	7hZ9SKww8gxG7LDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=O8Cc1fgf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=B53r9Jh1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BPrK/dwiAh/i96umzwTDF3eWf8F9yePnwIjP2Sj9Ck=;
	b=O8Cc1fgfSpoDvGLWxEf3FaqRzQAFpHUYDnycCEvNSkyGeeyHBSksTUSZ/ADqc0mdxnwZQn
	qUAPMQdmiQ6zQMiZf26QoxknPfutevEcL30baPjuACCJ73pFjd4i9j8YJtNDpc10c2oI5y
	SFHK1aY5zhT4xNDtkQx1dC4D2N+CsLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BPrK/dwiAh/i96umzwTDF3eWf8F9yePnwIjP2Sj9Ck=;
	b=B53r9Jh1KtlbypEc7hKpH7T1Z4e57FvbSbmENRPlvZvaQG699TkiTSC53vSRxlkhyFMuCw
	7hZ9SKww8gxG7LDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5007F13A32;
	Fri, 20 Dec 2024 03:09:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gMPhAdrfZGdZGAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 20 Dec 2024 03:09:14 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] VFS: introduce done_lookup_and_lock()
Date: Fri, 20 Dec 2024 13:54:24 +1100
Message-ID: <20241220030830.272429-7-neilb@suse.de>
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
X-Rspamd-Queue-Id: 6A5AD1F385
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

Callers of kern_path_locked() and user_path_locked_at() should now call
done_lookup_and_lock() to unlock the directory and dput() the
dentry.

This will allow the locking rules to be changed in a central place.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/base/devtmpfs.c |  7 +++----
 fs/bcachefs/fs-ioctl.c  |  3 +--
 fs/namei.c              | 10 ++++++++--
 include/linux/namei.h   |  1 +
 kernel/audit_fsnotify.c |  3 +--
 kernel/audit_watch.c    |  3 +--
 6 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index c9e34842139f..bb6d26338b6c 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -251,8 +251,8 @@ static int dev_rmdir(const char *name)
 	else
 		err = -EPERM;
 
-	dput(dentry);
-	inode_unlock(d_inode(parent.dentry));
+	done_lookup_and_lock(parent.dentry, dentry);
+
 	path_put(&parent);
 	return err;
 }
@@ -339,8 +339,7 @@ static int handle_remove(const char *nodename, struct device *dev)
 		if (!err || err == -ENOENT)
 			deleted = 1;
 	}
-	dput(dentry);
-	inode_unlock(d_inode(parent.dentry));
+	done_lookup_and_lock(parent.dentry, dentry);
 
 	path_put(&parent);
 	if (deleted && strchr(nodename, '/'))
diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
index c5464219b23f..d51c86e24bef 100644
--- a/fs/bcachefs/fs-ioctl.c
+++ b/fs/bcachefs/fs-ioctl.c
@@ -522,8 +522,7 @@ static long bch2_ioctl_subvolume_destroy(struct bch_fs *c, struct file *filp,
 		d_delete(victim);
 	}
 err:
-	inode_unlock(dir);
-	dput(victim);
+	done_lookup_and_lock(path.dentry, victim);
 	path_put(&path);
 	return ret;
 }
diff --git a/fs/namei.c b/fs/namei.c
index 8780406cb4d7..29f86df4b9dc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2773,6 +2773,13 @@ struct dentry *user_path_locked_at(int dfd, const char __user *name, struct path
 }
 EXPORT_SYMBOL(user_path_locked_at);
 
+void done_lookup_and_lock(struct dentry *parent, struct dentry *child)
+{
+	dput(child);
+	inode_unlock(d_inode(parent));
+}
+EXPORT_SYMBOL(done_lookup_and_lock);
+
 int kern_path(const char *name, unsigned int flags, struct path *path)
 {
 	struct filename *filename = getname_kernel(name);
@@ -4146,8 +4153,7 @@ EXPORT_SYMBOL(kern_path_create);
 
 void done_path_create(struct path *path, struct dentry *dentry)
 {
-	dput(dentry);
-	inode_unlock(path->dentry->d_inode);
+	done_lookup_and_lock(path->dentry, dentry);
 	mnt_drop_write(path->mnt);
 	path_put(path);
 }
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 15118992f745..898fc8ba37e1 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -65,6 +65,7 @@ extern struct dentry *user_path_create(int, const char __user *, struct path *,
 extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
 extern struct dentry *user_path_locked_at(int , const char __user *, struct path *);
+extern void done_lookup_and_lock(struct dentry *parent, struct dentry *child);
 int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
 			   struct path *parent, struct qstr *last, int *type,
 			   const struct path *root);
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index c565fbf66ac8..db2c03caa74d 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -86,7 +86,6 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry); /* returning an error */
 	inode = path.dentry->d_inode;
-	inode_unlock(inode);
 
 	audit_mark = kzalloc(sizeof(*audit_mark), GFP_KERNEL);
 	if (unlikely(!audit_mark)) {
@@ -107,7 +106,7 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 		audit_mark = ERR_PTR(ret);
 	}
 out:
-	dput(dentry);
+	done_lookup_and_lock(path.dentry, dentry);
 	path_put(&path);
 	return audit_mark;
 }
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index e3130675ee6b..e1137ea9294b 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -354,8 +354,7 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 	watch->dev = d->d_sb->s_dev;
 	watch->ino = d_backing_inode(d)->i_ino;
 
-	inode_unlock(d_backing_inode(parent->dentry));
-	dput(d);
+	done_lookup_and_lock(parent->dentry, d);
 	return 0;
 }
 
-- 
2.47.0


