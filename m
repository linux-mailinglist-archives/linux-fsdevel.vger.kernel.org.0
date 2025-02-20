Return-Path: <linux-fsdevel+bounces-42200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1776AA3E8E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 00:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1E4702667
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 23:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF8E268FDC;
	Thu, 20 Feb 2025 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Eofp7Ps/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pAl11aha";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Eofp7Ps/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pAl11aha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E398A268FEC
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095306; cv=none; b=jkl9hIXkscJsvR/wFmp21Hz/n/byecjcpE3c6DYBkzxwRbsN0bo5C3wMBOQe5VQb+l+VI6OwgVGxWQb5oz7gysrtzdAUjdFI0NO/DKw7eWycyeNACO2C5vcHjoUJy8J9p4V6QrjOrhn7cTD1jNts4hLHrWMvhncLks4Mvk8gbhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095306; c=relaxed/simple;
	bh=sDT9kgt9aSDhya89Xi3GrtI21E3nvo1A7lbO1Ilr1Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMlXrnKKa51EQItn547pSayd8mjpGXn4vGRoG4RHWbL3n4vm4hmRsAdpyLquQWNZJm/rZax13SJO6M+iY1JxjE2ymhsn2/IzXe+PnJr+yicbj1hKQ2gqPpVb6aJcTa3KA/tBJlk6uJtlmP1GlcHm5DUogErfB2zagGcn3kwy37k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Eofp7Ps/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pAl11aha; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Eofp7Ps/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pAl11aha; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31BC821197;
	Thu, 20 Feb 2025 23:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740095302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkIxwLlnn5A04IZSkmkeCkcxAAunwSH3ABBUR7magHU=;
	b=Eofp7Ps/HSzOKZJ9VLw6q+8ymG10vce/3dmKozzcTXcxJlkLa06gU22HW1/7C/b5z5jYnN
	dYVBfxFPUPPowLiDRiWsK5dpBtWezm0UHzR5QPBincGTVm2nsnKlASip36gM9X6qm07my1
	NL5se6u01RbufscGX4WvVoLZTdvHJrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740095302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkIxwLlnn5A04IZSkmkeCkcxAAunwSH3ABBUR7magHU=;
	b=pAl11ahakRt+zFwkXGM3j+es2WFQL7lm0y6moV+x9S27wM4GMvDRbUKoPGN/F6XrrxKYDY
	w5sDqsJiUTKrFEAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Eofp7Ps/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pAl11aha
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740095302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkIxwLlnn5A04IZSkmkeCkcxAAunwSH3ABBUR7magHU=;
	b=Eofp7Ps/HSzOKZJ9VLw6q+8ymG10vce/3dmKozzcTXcxJlkLa06gU22HW1/7C/b5z5jYnN
	dYVBfxFPUPPowLiDRiWsK5dpBtWezm0UHzR5QPBincGTVm2nsnKlASip36gM9X6qm07my1
	NL5se6u01RbufscGX4WvVoLZTdvHJrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740095302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkIxwLlnn5A04IZSkmkeCkcxAAunwSH3ABBUR7magHU=;
	b=pAl11ahakRt+zFwkXGM3j+es2WFQL7lm0y6moV+x9S27wM4GMvDRbUKoPGN/F6XrrxKYDY
	w5sDqsJiUTKrFEAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EB4C13301;
	Thu, 20 Feb 2025 23:48:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dBA/DT2/t2deAwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 20 Feb 2025 23:48:13 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-um@lists.infradead.org,
	ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev
Subject: [PATCH 6/6] VFS: Change vfs_mkdir() to return the dentry.
Date: Fri, 21 Feb 2025 10:36:35 +1100
Message-ID: <20250220234630.983190-7-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220234630.983190-1-neilb@suse.de>
References: <20250220234630.983190-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 31BC821197
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,redhat.com,gmail.com,nod.at,cambridgegreys.com,sipsolutions.net,oracle.com,talpey.com,chromium.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL41gfrsx5ox46amq79i8sk6fy),from(RLewrxuus8mos16izbn)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

vfs_mkdir() does not guarantee to leave the child dentry hashed or make
it positive on success, and in many such cases the filesystem had to use
a different dentry which it can now return.

This patch changes vfs_mkdir() to return the dentry provided by the
filesystems which is hashed and positive when provided.  This reduces
the number of cases where the resulting dentry is not positive to a
handful which don't deserve extra efforts.

The only callers of vfs_mkdir() which are interested in the resulting
inode are in-kernel filesystem clients: cachefiles, nfsd, smb/server.
The only filesystems that don't reliably provide the inode are:
- kernfs, tracefs which these clients are unlikely to be interested in
- cifs in some configurations would need to do a lookup to find the
  created inode, but doesn't.  cifs cannot be exported via NFS, is
  unlikely to be used by cachefiles, and smb/server only has a soft
  requirement for the inode, so this is unlikely to be a problem in
  practice.
- hostfs, nfs, cifs may need to do a lookup (rarely for NFS) and it is
  possible for a race to make that lookup fail.  Actual failure
  is unlikely and providing callers handle negative dentries graceful
  they will fail-safe.

So this patch removes the lookup code in nfsd and smb/server and adjusts
them to fail safe if a negative dentry is provided:
- cache-files already fails safe by restarting the task from the
  top - it still does with this change, though it no longer calls
  cachefiles_put_directory() as that will crash if the dentry is
  negative.
- nfsd reports "Server-fault" which it what it used to do if the lookup
  failed. This will never happen on any file-systems that it can actually
  export, so this is of no consequence.  I removed the fh_update()
  call as that is not needed and out-of-place.  A subsequent
  nfsd_create_setattr() call will call fh_update() when needed.
- smb/server only wants the inode to call ksmbd_smb_inherit_owner()
  which updates ->i_uid (without calling notify_change() or similar)
  which can be safely skipping on cifs (I hope).

If a different dentry is returned, the first one is put.  If necessary
the fact that it is new can be determined by comparing pointers.  A new
dentry will certainly have a new pointer (as the old is put after the
new is obtained).
Similarly if an error is returned (via ERR_PTR()) the original dentry is
put.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/base/devtmpfs.c  |  7 +++---
 fs/cachefiles/namei.c    | 16 ++++++++------
 fs/ecryptfs/inode.c      | 14 ++++++++----
 fs/init.c                |  7 ++++--
 fs/namei.c               | 46 ++++++++++++++++++++++++++--------------
 fs/nfsd/nfs4recover.c    |  7 ++++--
 fs/nfsd/vfs.c            | 34 ++++++++++-------------------
 fs/overlayfs/dir.c       | 37 ++++----------------------------
 fs/overlayfs/overlayfs.h | 15 ++++++-------
 fs/overlayfs/super.c     |  7 +++---
 fs/smb/server/vfs.c      | 32 +++++++++-------------------
 fs/xfs/scrub/orphanage.c |  9 ++++----
 include/linux/fs.h       |  4 ++--
 13 files changed, 105 insertions(+), 130 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 7a101009bee7..6dd1a8860f1c 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -175,18 +175,17 @@ static int dev_mkdir(const char *name, umode_t mode)
 {
 	struct dentry *dentry;
 	struct path path;
-	int err;
 
 	dentry = kern_path_create(AT_FDCWD, name, &path, LOOKUP_DIRECTORY);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-	err = vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode);
-	if (!err)
+	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode);
+	if (!IS_ERR(dentry))
 		/* mark as kernel-created inode */
 		d_inode(dentry)->i_private = &thread;
 	done_path_create(&path, dentry);
-	return err;
+	return PTR_ERR_OR_ZERO(dentry);
 }
 
 static int create_path(const char *nodepath)
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 7cf59713f0f7..83a60126de0f 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -128,18 +128,19 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		ret = security_path_mkdir(&path, subdir, 0700);
 		if (ret < 0)
 			goto mkdir_error;
-		ret = cachefiles_inject_write_error();
-		if (ret == 0)
-			ret = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
-		if (ret < 0) {
+		subdir = ERR_PTR(cachefiles_inject_write_error());
+		if (!IS_ERR(subdir))
+			subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
+		ret = PTR_ERR(subdir);
+		if (IS_ERR(subdir)) {
 			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
 						   cachefiles_trace_mkdir_error);
 			goto mkdir_error;
 		}
 		trace_cachefiles_mkdir(dir, subdir);
 
-		if (unlikely(d_unhashed(subdir))) {
-			cachefiles_put_directory(subdir);
+		if (unlikely(d_unhashed(subdir) || d_is_negative(subdir))) {
+			dput(subdir);
 			goto retry;
 		}
 		ASSERT(d_backing_inode(subdir));
@@ -195,7 +196,8 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 
 mkdir_error:
 	inode_unlock(d_inode(dir));
-	dput(subdir);
+	if (!IS_ERR(subdir))
+		dput(subdir);
 	pr_err("mkdir %s failed with error %d\n", dirname, ret);
 	return ERR_PTR(ret);
 
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 6315dd194228..51a5c54eb740 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -511,10 +511,16 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	struct inode *lower_dir;
 
 	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
-	if (!rc)
-		rc = vfs_mkdir(&nop_mnt_idmap, lower_dir,
-			       lower_dentry, mode);
-	if (rc || d_really_is_negative(lower_dentry))
+	if (rc)
+		goto out;
+
+	lower_dentry = vfs_mkdir(&nop_mnt_idmap, lower_dir,
+				 lower_dentry, mode);
+	rc = PTR_ERR(lower_dentry);
+	if (IS_ERR(lower_dentry))
+		goto out;
+	rc = 0;
+	if (d_unhashed(lower_dentry))
 		goto out;
 	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
 	if (rc)
diff --git a/fs/init.c b/fs/init.c
index e9387b6c4f30..eef5124885e3 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -230,9 +230,12 @@ int __init init_mkdir(const char *pathname, umode_t mode)
 		return PTR_ERR(dentry);
 	mode = mode_strip_umask(d_inode(path.dentry), mode);
 	error = security_path_mkdir(&path, dentry, mode);
-	if (!error)
-		error = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
+	if (!error) {
+		dentry = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
 				  dentry, mode);
+		if (IS_ERR(dentry))
+			error = PTR_ERR(dentry);
+	}
 	done_path_create(&path, dentry);
 	return error;
 }
diff --git a/fs/namei.c b/fs/namei.c
index 63fe4dc29c23..bd5eec2c0af4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4125,7 +4125,8 @@ EXPORT_SYMBOL(kern_path_create);
 
 void done_path_create(struct path *path, struct dentry *dentry)
 {
-	dput(dentry);
+	if (!IS_ERR(dentry))
+		dput(dentry);
 	inode_unlock(path->dentry->d_inode);
 	mnt_drop_write(path->mnt);
 	path_put(path);
@@ -4271,7 +4272,7 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 }
 
 /**
- * vfs_mkdir - create directory
+ * vfs_mkdir - create directory returning correct dentry if possible
  * @idmap:	idmap of the mount the inode was found from
  * @dir:	inode of the parent directory
  * @dentry:	dentry of the child directory
@@ -4284,9 +4285,15 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
  * care to map the inode according to @idmap before checking permissions.
  * On non-idmapped mounts or if permission checking is to be performed on the
  * raw inode simply pass @nop_mnt_idmap.
+ *
+ * In the event that the filesystem does not use the *@dentry but leaves it
+ * negative or unhashes it and possibly splices a different one returning it,
+ * the original dentry is dput() and the alternate is returned.
+ *
+ * In case of an error the dentry is dput() and an ERR_PTR() is returned.
  */
-int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-	      struct dentry *dentry, umode_t mode)
+struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+			 struct dentry *dentry, umode_t mode)
 {
 	int error;
 	unsigned max_links = dir->i_sb->s_max_links;
@@ -4294,31 +4301,36 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	error = may_create(idmap, dir, dentry);
 	if (error)
-		return error;
+		goto err;
 
+	error = -EPERM;
 	if (!dir->i_op->mkdir)
-		return -EPERM;
+		goto err;
 
 	mode = vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
 	error = security_inode_mkdir(dir, dentry, mode);
 	if (error)
-		return error;
+		goto err;
 
+	error = -EMLINK;
 	if (max_links && dir->i_nlink >= max_links)
-		return -EMLINK;
+		goto err;
 
 	de = dir->i_op->mkdir(idmap, dir, dentry, mode);
+	error = PTR_ERR(de);
 	if (IS_ERR(de))
-		return PTR_ERR(de);
+		goto err;
 	if (de) {
-		fsnotify_mkdir(dir, de);
-		/* Cannot return de yet */
-		dput(de);
-	} else {
-		fsnotify_mkdir(dir, dentry);
+		dput(dentry);
+		dentry = de;
 	}
+	fsnotify_mkdir(dir, dentry);
+	return dentry;
 
-	return 0;
+err:
+	dput(dentry);
+
+	return ERR_PTR(error);
 }
 EXPORT_SYMBOL(vfs_mkdir);
 
@@ -4338,8 +4350,10 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	error = security_path_mkdir(&path, dentry,
 			mode_strip_umask(path.dentry->d_inode, mode));
 	if (!error) {
-		error = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
+		dentry = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
 				  dentry, mode);
+		if (IS_ERR(dentry))
+			error = PTR_ERR(dentry);
 	}
 	done_path_create(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 28f4d5311c40..c1d9bd07285f 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -233,9 +233,12 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 		 * as well be forgiving and just succeed silently.
 		 */
 		goto out_put;
-	status = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
+	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
+	if (IS_ERR(dentry))
+		status = PTR_ERR(dentry);
 out_put:
-	dput(dentry);
+	if (!status)
+		dput(dentry);
 out_unlock:
 	inode_unlock(d_inode(dir));
 	if (status == 0) {
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 29cb7b812d71..34d7aa531662 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1461,7 +1461,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct inode	*dirp;
 	struct iattr	*iap = attrs->na_iattr;
 	__be32		err;
-	int		host_err;
+	int		host_err = 0;
 
 	dentry = fhp->fh_dentry;
 	dirp = d_inode(dentry);
@@ -1488,28 +1488,15 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			nfsd_check_ignore_resizing(iap);
 		break;
 	case S_IFDIR:
-		host_err = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode);
-		if (!host_err && unlikely(d_unhashed(dchild))) {
-			struct dentry *d;
-			d = lookup_one_len(dchild->d_name.name,
-					   dchild->d_parent,
-					   dchild->d_name.len);
-			if (IS_ERR(d)) {
-				host_err = PTR_ERR(d);
-				break;
-			}
-			if (unlikely(d_is_negative(d))) {
-				dput(d);
-				err = nfserr_serverfault;
-				goto out;
-			}
+		dchild = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode);
+		if (IS_ERR(dchild)) {
+			host_err = PTR_ERR(dchild);
+		} else if (d_is_negative(dchild)) {
+			err = nfserr_serverfault;
+			goto out;
+		} else if (unlikely(dchild != resfhp->fh_dentry)) {
 			dput(resfhp->fh_dentry);
-			resfhp->fh_dentry = dget(d);
-			err = fh_update(resfhp);
-			dput(dchild);
-			dchild = d;
-			if (err)
-				goto out;
+			resfhp->fh_dentry = dget(dchild);
 		}
 		break;
 	case S_IFCHR:
@@ -1530,7 +1517,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	err = nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
 
 out:
-	dput(dchild);
+	if (!IS_ERR(dchild))
+		dput(dchild);
 	return err;
 
 out_nfserr:
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 21c3aaf7b274..fe493f3ed6b6 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -138,37 +138,6 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
 	goto out;
 }
 
-int ovl_mkdir_real(struct ovl_fs *ofs, struct inode *dir,
-		   struct dentry **newdentry, umode_t mode)
-{
-	int err;
-	struct dentry *d, *dentry = *newdentry;
-
-	err = ovl_do_mkdir(ofs, dir, dentry, mode);
-	if (err)
-		return err;
-
-	if (likely(!d_unhashed(dentry)))
-		return 0;
-
-	/*
-	 * vfs_mkdir() may succeed and leave the dentry passed
-	 * to it unhashed and negative. If that happens, try to
-	 * lookup a new hashed and positive dentry.
-	 */
-	d = ovl_lookup_upper(ofs, dentry->d_name.name, dentry->d_parent,
-			     dentry->d_name.len);
-	if (IS_ERR(d)) {
-		pr_warn("failed lookup after mkdir (%pd2, err=%i).\n",
-			dentry, err);
-		return PTR_ERR(d);
-	}
-	dput(dentry);
-	*newdentry = d;
-
-	return 0;
-}
-
 struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
 			       struct dentry *newdentry, struct ovl_cattr *attr)
 {
@@ -191,7 +160,8 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
 
 		case S_IFDIR:
 			/* mkdir is special... */
-			err =  ovl_mkdir_real(ofs, dir, &newdentry, attr->mode);
+			newdentry =  ovl_do_mkdir(ofs, dir, newdentry, attr->mode);
+			err = PTR_ERR_OR_ZERO(newdentry);
 			break;
 
 		case S_IFCHR:
@@ -219,7 +189,8 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
 	}
 out:
 	if (err) {
-		dput(newdentry);
+		if (!IS_ERR(newdentry))
+			dput(newdentry);
 		return ERR_PTR(err);
 	}
 	return newdentry;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 0021e2025020..6f2f8f4cfbbc 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -241,13 +241,14 @@ static inline int ovl_do_create(struct ovl_fs *ofs,
 	return err;
 }
 
-static inline int ovl_do_mkdir(struct ovl_fs *ofs,
-			       struct inode *dir, struct dentry *dentry,
-			       umode_t mode)
+static inline struct dentry *ovl_do_mkdir(struct ovl_fs *ofs,
+					  struct inode *dir,
+					  struct dentry *dentry,
+					  umode_t mode)
 {
-	int err = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
-	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, err);
-	return err;
+	dentry = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
+	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, PTR_ERR_OR_ZERO(dentry));
+	return dentry;
 }
 
 static inline int ovl_do_mknod(struct ovl_fs *ofs,
@@ -838,8 +839,6 @@ struct ovl_cattr {
 
 #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode = (m) })
 
-int ovl_mkdir_real(struct ovl_fs *ofs, struct inode *dir,
-		   struct dentry **newdentry, umode_t mode);
 struct dentry *ovl_create_real(struct ovl_fs *ofs,
 			       struct inode *dir, struct dentry *newdentry,
 			       struct ovl_cattr *attr);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 61e21c3129e8..b63474d1b064 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -327,9 +327,10 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 			goto retry;
 		}
 
-		err = ovl_mkdir_real(ofs, dir, &work, attr.ia_mode);
-		if (err)
-			goto out_dput;
+		work = ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
+		err = PTR_ERR(work);
+		if (IS_ERR(work))
+			goto out_err;
 
 		/* Weird filesystem returning with hashed negative (kernfs)? */
 		err = -EINVAL;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index fe29acef5872..8554aa5a1059 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -206,8 +206,8 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 {
 	struct mnt_idmap *idmap;
 	struct path path;
-	struct dentry *dentry;
-	int err;
+	struct dentry *dentry, *d;
+	int err = 0;
 
 	dentry = ksmbd_vfs_kern_path_create(work, name,
 					    LOOKUP_NO_SYMLINKS | LOOKUP_DIRECTORY,
@@ -222,27 +222,15 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 
 	idmap = mnt_idmap(path.mnt);
 	mode |= S_IFDIR;
-	err = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
-	if (!err && d_unhashed(dentry)) {
-		struct dentry *d;
-
-		d = lookup_one(idmap, dentry->d_name.name, dentry->d_parent,
-			       dentry->d_name.len);
-		if (IS_ERR(d)) {
-			err = PTR_ERR(d);
-			goto out_err;
-		}
-		if (unlikely(d_is_negative(d))) {
-			dput(d);
-			err = -ENOENT;
-			goto out_err;
-		}
-
-		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(d));
-		dput(d);
-	}
+	d = dentry;
+	dentry = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
+	if (IS_ERR(dentry))
+		err = PTR_ERR(dentry);
+	else if (d_is_negative(dentry))
+		err = -ENOENT;
+	if (!err && dentry != d)
+		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(dentry));
 
-out_err:
 	done_path_create(&path, dentry);
 	if (err)
 		pr_err("mkdir(%s): creation failed (err:%d)\n", name, err);
diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
index c287c755f2c5..3537f3cca6d5 100644
--- a/fs/xfs/scrub/orphanage.c
+++ b/fs/xfs/scrub/orphanage.c
@@ -167,10 +167,11 @@ xrep_orphanage_create(
 	 * directory to control access to a file we put in here.
 	 */
 	if (d_really_is_negative(orphanage_dentry)) {
-		error = vfs_mkdir(&nop_mnt_idmap, root_inode, orphanage_dentry,
-				0750);
-		if (error)
-			goto out_dput_orphanage;
+		orphanage_dentry = vfs_mkdir(&nop_mnt_idmap, root_inode,
+					     orphanage_dentry, 0750);
+		error = PTR_ERR(orphanage_dentry);
+		if (IS_ERR(orphanage_dentry))
+			goto out_unlock_root;
 	}
 
 	/* Not a directory? Bail out. */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8f4fbecd40fc..eaad8e31c0d4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1971,8 +1971,8 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
  */
 int vfs_create(struct mnt_idmap *, struct inode *,
 	       struct dentry *, umode_t, bool);
-int vfs_mkdir(struct mnt_idmap *, struct inode *,
-	      struct dentry *, umode_t);
+struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
+			 struct dentry *, umode_t);
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
               umode_t, dev_t);
 int vfs_symlink(struct mnt_idmap *, struct inode *,
-- 
2.47.1


