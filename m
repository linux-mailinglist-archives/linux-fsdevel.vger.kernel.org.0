Return-Path: <linux-fsdevel+bounces-37907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 989749F8A70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 04:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64A81666C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 03:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC65633086;
	Fri, 20 Dec 2024 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dZjj/jc1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JqOA1ABL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dZjj/jc1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JqOA1ABL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5957055887;
	Fri, 20 Dec 2024 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734664175; cv=none; b=ulVPaoA3V2TG/FUGyyMkLXu/A1JgEos9nDwTw1l5iWe+NQXdCPxfBmzx17/XnvuOH/Z8jGobS6+kizQ2pXZa3do+zHnZaarRIv9qqI9C/XDrn4DnCpcW4U35oyVRUz3A7hP1nZw1hLgT+uFIVhA/NqLOET1QaczXvRAS/z15xow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734664175; c=relaxed/simple;
	bh=IpA3sUqrWV1i6oqiYoccjA2wza7Q/AbvjHQukZ9TCrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cI+NzGqNJOp9VAn2oPIuIjQo8YEYCrwuZlrDdy7D5ewBBY7BWtiBt3ZmSZehvLlYrWHhf97PeTtyth1Bzqaw5FjChN+yJ102azu+yV7tPmrtaE2tv+LqgVY2c+ag3XGNSUeZlWhoagaVB+fX9U6s1WA4fH4yQ10C//tnwj//jUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dZjj/jc1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JqOA1ABL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dZjj/jc1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JqOA1ABL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 71C0B1F385;
	Fri, 20 Dec 2024 03:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIy/EqZ/XEwEdnSZYB/wNk3K9wIaZypr3NWhBIvRZc0=;
	b=dZjj/jc1KNzQaUi17JGX3o+bZVOg5s7qpz5O2qhTnvWV8U8LS9iFbeDid1pjp4L/+DtlH1
	XmKPXGehHTtyKA7in5nv1mzjCcppnY6tHht2UDxR5BXXWzwSnT9mFOpVuKQ2Mud7xhueBc
	/mwWV/ZjL8fgnTseLGCLVUsUWRWWR18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664171;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIy/EqZ/XEwEdnSZYB/wNk3K9wIaZypr3NWhBIvRZc0=;
	b=JqOA1ABLoDwt7hCR3pUd8TIH6bWk3U6NdCdG7T86bs8cnTXR0jtWNbSLyssOu8xAxAsfT6
	LAe1fGNu5nvgFzBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIy/EqZ/XEwEdnSZYB/wNk3K9wIaZypr3NWhBIvRZc0=;
	b=dZjj/jc1KNzQaUi17JGX3o+bZVOg5s7qpz5O2qhTnvWV8U8LS9iFbeDid1pjp4L/+DtlH1
	XmKPXGehHTtyKA7in5nv1mzjCcppnY6tHht2UDxR5BXXWzwSnT9mFOpVuKQ2Mud7xhueBc
	/mwWV/ZjL8fgnTseLGCLVUsUWRWWR18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664171;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIy/EqZ/XEwEdnSZYB/wNk3K9wIaZypr3NWhBIvRZc0=;
	b=JqOA1ABLoDwt7hCR3pUd8TIH6bWk3U6NdCdG7T86bs8cnTXR0jtWNbSLyssOu8xAxAsfT6
	LAe1fGNu5nvgFzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58B3213A32;
	Fri, 20 Dec 2024 03:09:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jzLjA+nfZGduGAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 20 Dec 2024 03:09:29 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] VFS: add inode_dir_lock/unlock
Date: Fri, 20 Dec 2024 13:54:26 +1100
Message-ID: <20241220030830.272429-9-neilb@suse.de>
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
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

During the transition from providing exclusive locking on the directory
for directory modifying operation to providing exclusive locking only on
the dentry with a shared lock on the directory - we need an alternate
way to provide exclusion on the directory for file systems which haven't
been converted.  This is provided by inode_dir_lock() and
inode_dir_inlock().
This uses a bit in i_state for locking, and wait_var_event_spinlock() for
waiting.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/inode.c         |  3 ++
 fs/namei.c         | 81 +++++++++++++++++++++++++++++++++++++---------
 include/linux/fs.h |  5 +++
 3 files changed, 74 insertions(+), 15 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 6b4c77268fc0..9ba69837aa56 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -492,6 +492,8 @@ EXPORT_SYMBOL(address_space_init_once);
  */
 void inode_init_once(struct inode *inode)
 {
+	static struct lock_class_key __key;
+
 	memset(inode, 0, sizeof(*inode));
 	INIT_HLIST_NODE(&inode->i_hash);
 	INIT_LIST_HEAD(&inode->i_devices);
@@ -501,6 +503,7 @@ void inode_init_once(struct inode *inode)
 	INIT_LIST_HEAD(&inode->i_sb_list);
 	__address_space_init_once(&inode->i_data);
 	i_size_ordered_init(inode);
+	lockdep_init_map(&inode->i_dirlock_map, "I_DIR_LOCKED", &__key, 0);
 }
 EXPORT_SYMBOL(inode_init_once);
 
diff --git a/fs/namei.c b/fs/namei.c
index 371c80902c59..68750b15dbf4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3364,6 +3364,34 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
 	return mode;
 }
 
+static bool check_dir_locked(struct inode *dir)
+{
+	if (dir->i_state & I_DIR_LOCKED) {
+		dir->i_state |= I_DIR_LOCK_WAITER;
+		return true;
+	}
+	return false;
+}
+
+static void inode_lock_dir(struct inode *dir)
+{
+	lock_acquire_exclusive(&dir->i_dirlock_map, 0, 0, NULL, _THIS_IP_);
+	spin_lock(&dir->i_lock);
+	wait_var_event_spinlock(dir, !check_dir_locked(dir),
+				&dir->i_lock);
+	dir->i_state |= I_DIR_LOCKED;
+	spin_unlock(&dir->i_lock);
+}
+
+static void inode_unlock_dir(struct inode *dir)
+{
+	lock_map_release(&dir->i_dirlock_map);
+	spin_lock(&dir->i_lock);
+	dir->i_state &= ~(I_DIR_LOCKED | I_DIR_LOCK_WAITER);
+	wake_up_var_locked(dir, &dir->i_lock);
+	spin_unlock(&dir->i_lock);
+}
+
 /**
  * vfs_create - create new file
  * @idmap:	idmap of the mount the inode was found from
@@ -3396,10 +3424,13 @@ int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	error = security_inode_create(dir, dentry, mode);
 	if (error)
 		return error;
-	if (dir->i_op->create_shared)
+	if (dir->i_op->create_shared) {
 		error = dir->i_op->create_shared(idmap, dir, dentry, mode, want_excl);
-	else
+	} else {
+		inode_lock_dir(dir);
 		error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
+		inode_unlock_dir(dir);
+	}
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
@@ -3699,16 +3730,19 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		file->f_mode |= FMODE_CREATED;
 		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
 
-		if (dir_inode->i_op->create_shared)
+		if (dir_inode->i_op->create_shared) {
 			error = dir_inode->i_op->create_shared(idmap, dir_inode,
 							       dentry, mode,
 							       open_flag & O_EXCL);
-		else if (dir_inode->i_op->create)
+		} else if (dir_inode->i_op->create) {
+			inode_lock_dir(dir_inode);
 			error = dir_inode->i_op->create(idmap, dir_inode,
 							dentry, mode,
 							open_flag & O_EXCL);
-		else
+			inode_unlock_dir(dir_inode);
+		} else {
 			error = -EACCES;
+		}
 		if (error)
 			goto out_dput;
 	}
@@ -4227,10 +4261,13 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
-	if (dir->i_op->mknod_shared)
+	if (dir->i_op->mknod_shared) {
 		error = dir->i_op->mknod_shared(idmap, dir, dentry, mode, dev);
-	else
+	} else {
+		inode_lock_dir(dir);
 		error = dir->i_op->mknod(idmap, dir, dentry, mode, dev);
+		inode_unlock_dir(dir);
+	}
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
@@ -4360,7 +4397,9 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		else if (de)
 			dput(de);
 	} else {
+		inode_lock_dir(dir);
 		error = dir->i_op->mkdir(idmap, dir, dentry, mode);
+		inode_unlock_dir(dir);
 	}
 	if (!error)
 		fsnotify_mkdir(dir, dentry);
@@ -4521,10 +4560,13 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto out;
 
-	if (dir->i_op->rmdir_shared)
+	if (dir->i_op->rmdir_shared) {
 		error = dir->i_op->rmdir_shared(dir, dentry);
-	else
+	} else {
+		inode_lock_dir(dir);
 		error = dir->i_op->rmdir(dir, dentry);
+		inode_unlock_dir(dir);
+	}
 	if (error)
 		goto out;
 
@@ -4648,10 +4690,13 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
 			error = try_break_deleg(target, delegated_inode);
 			if (error)
 				goto out;
-			if (dir->i_op->unlink_shared)
+			if (dir->i_op->unlink_shared) {
 				error = dir->i_op->unlink_shared(dir, dentry);
-			else
+			} else {
+				inode_lock_dir(dir);
 				error = dir->i_op->unlink(dir, dentry);
+				inode_unlock_dir(dir);
+			}
 			if (!error) {
 				dont_mount(dentry);
 				detach_mounts(dentry);
@@ -4792,10 +4837,13 @@ int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
-	if (dir->i_op->symlink_shared)
+	if (dir->i_op->symlink_shared) {
 		error = dir->i_op->symlink_shared(idmap, dir, dentry, oldname);
-	else
+	} else {
+		inode_lock_dir(dir);
 		error = dir->i_op->symlink(idmap, dir, dentry, oldname);
+		inode_unlock_dir(dir);
+	}
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
@@ -4920,10 +4968,13 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 		error = try_break_deleg(inode, delegated_inode);
 		if (error)
 			;
-		else if (dir->i_op->link_shared)
+		else if (dir->i_op->link_shared) {
 			error = dir->i_op->link_shared(old_dentry, dir, new_dentry);
-		else
+		} else {
+			inode_lock_dir(dir);
 			error = dir->i_op->link(old_dentry, dir, new_dentry);
+			inode_unlock_dir(dir);
+		}
 	}
 
 	if (!error && (inode->i_state & I_LINKABLE)) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 68eba181175b..3ca92a54f28e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -722,6 +722,8 @@ struct inode {
 		void (*free_inode)(struct inode *);
 	};
 	struct file_lock_context	*i_flctx;
+
+	struct lockdep_map	i_dirlock_map;	/* For tracking I_DIR_LOCKED locks */
 	struct address_space	i_data;
 	struct list_head	i_devices;
 	union {
@@ -2493,6 +2495,9 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define I_SYNC_QUEUED		(1 << 16)
 #define I_PINNING_NETFS_WB	(1 << 17)
 
+#define I_DIR_LOCK_WAITER	(1 << 30)
+#define I_DIR_LOCKED		(1 << 31)
+
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
 #define I_DIRTY_ALL (I_DIRTY | I_DIRTY_TIME)
-- 
2.47.0


