Return-Path: <linux-fsdevel+bounces-37900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FDF9F8A63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 04:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FA71896B71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 03:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E906F099;
	Fri, 20 Dec 2024 03:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ceBDZqlK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n8YJUzLh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ceBDZqlK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n8YJUzLh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC4955887;
	Fri, 20 Dec 2024 03:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734664132; cv=none; b=F0hnPBH5rvtLzm8NsanOKpHOT8VfBcoaSGuEShnDhXjJtw/syC9zu7hvNjzUjPo5iVFbABb2h13dV7y5+9Cr9tuRR+NJWVYbDNBSvedbqrJe9QZ1jLgfblsQ2bCeOnX2lIimqvHeb5gjPlCt2WnLgvn52m1diaR3DIyCLXE4IN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734664132; c=relaxed/simple;
	bh=ybhgwxTI4X95nHHvhL2B/S1GuzruYL67cPF3NV36pJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gllCjxFPbbqMBbzDJa4quW0sqPVFb+znuR//2IuRj0qorA0d4fAgOF+I0l3ARJ4kViR7Qvv7+nZqfkxgNDv+LbzqHruiOfbgxpR08VE5odbfx+galawGC5j6uiMiPy5F/Gh7/lTbDdVqtZGWIVzP+SgIiqdBTxHupm8QspmCRV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ceBDZqlK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n8YJUzLh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ceBDZqlK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n8YJUzLh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D31521169;
	Fri, 20 Dec 2024 03:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1BJCUMvAPmGFmIg8lKEDG+ulfUTgCYmRTpYQH1F1eHc=;
	b=ceBDZqlKKeUkqx2v1WTURRb7sguy/h48vXgExW8wOe6vbV/w59ssGYv1oTCJ075gcvbw0P
	TYKfa5BLtB+K68RTRavXzOmyBLS6yCEqOP15jrLBrmpyL6qW9e2WSZ9HiQYMbyBcio96HA
	IdtRHPDRhlz8P6n0IIAyw5so9sk31cU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1BJCUMvAPmGFmIg8lKEDG+ulfUTgCYmRTpYQH1F1eHc=;
	b=n8YJUzLhqBkGC3ynNTEXHZAnqwTGwLHxUhZpDmx/4xcGgZR0QVRWTtC03PmgLbwwfCVBQA
	bzoBB4Q/YK9y2ZAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1BJCUMvAPmGFmIg8lKEDG+ulfUTgCYmRTpYQH1F1eHc=;
	b=ceBDZqlKKeUkqx2v1WTURRb7sguy/h48vXgExW8wOe6vbV/w59ssGYv1oTCJ075gcvbw0P
	TYKfa5BLtB+K68RTRavXzOmyBLS6yCEqOP15jrLBrmpyL6qW9e2WSZ9HiQYMbyBcio96HA
	IdtRHPDRhlz8P6n0IIAyw5so9sk31cU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1BJCUMvAPmGFmIg8lKEDG+ulfUTgCYmRTpYQH1F1eHc=;
	b=n8YJUzLhqBkGC3ynNTEXHZAnqwTGwLHxUhZpDmx/4xcGgZR0QVRWTtC03PmgLbwwfCVBQA
	bzoBB4Q/YK9y2ZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 132CC13A32;
	Fri, 20 Dec 2024 03:08:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JX2fLr3fZGc3GAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 20 Dec 2024 03:08:45 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] VFS: introduce vfs_mkdir_return()
Date: Fri, 20 Dec 2024 13:54:19 +1100
Message-ID: <20241220030830.272429-2-neilb@suse.de>
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
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

vfs_mkdir() does not guarantee to make the child dentry positive on
success.  It may leave it negative and then the caller needs to perform a
lookup to find the target dentry.

This patch introduced vfs_mkdir_return() which performs the lookup if
needed so that this code is centralised.

This prepares for a new inode operation which will perform mkdir and
returns the correct dentry.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/cachefiles/namei.c    |  7 +----
 fs/namei.c               | 63 ++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c            | 21 ++------------
 fs/overlayfs/dir.c       | 33 +--------------------
 fs/overlayfs/overlayfs.h | 10 +++----
 fs/overlayfs/super.c     |  2 +-
 fs/smb/server/vfs.c      | 23 +++------------
 include/linux/fs.h       |  2 ++
 8 files changed, 80 insertions(+), 81 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 7cf59713f0f7..3c866c3b9534 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -95,7 +95,6 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	/* search the current directory for the element name */
 	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
 
-retry:
 	ret = cachefiles_inject_read_error();
 	if (ret == 0)
 		subdir = lookup_one_len(dirname, dir, strlen(dirname));
@@ -130,7 +129,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 			goto mkdir_error;
 		ret = cachefiles_inject_write_error();
 		if (ret == 0)
-			ret = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
+			ret = vfs_mkdir_return(&nop_mnt_idmap, d_inode(dir), &subdir, 0700);
 		if (ret < 0) {
 			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
 						   cachefiles_trace_mkdir_error);
@@ -138,10 +137,6 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		}
 		trace_cachefiles_mkdir(dir, subdir);
 
-		if (unlikely(d_unhashed(subdir))) {
-			cachefiles_put_directory(subdir);
-			goto retry;
-		}
 		ASSERT(d_backing_inode(subdir));
 
 		_debug("mkdir -> %pd{ino=%lu}",
diff --git a/fs/namei.c b/fs/namei.c
index 9d30c7aa9aa6..cdd1fc9d56a0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4315,6 +4315,69 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 }
 EXPORT_SYMBOL(vfs_mkdir);
 
+/**
+ * vfs_mkdir_return - create directory returning correct dentry
+ * @idmap:	idmap of the mount the inode was found from
+ * @dir:	inode of the parent directory
+ * @dentryp:	pointer to dentry of the child directory
+ * @mode:	mode of the child directory
+ *
+ * Create a directory.
+ *
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions.
+ * On non-idmapped mounts or if permission checking is to be performed on the
+ * raw inode simply pass @nop_mnt_idmap.
+ *
+ * The filesystem may not use the dentry that was passed in.  In that case
+ * the passed-in dentry is put and a new one is placed in *@dentryp;
+ * So on successful return *@dentryp will always be positive.
+ */
+int vfs_mkdir_return(struct mnt_idmap *idmap, struct inode *dir,
+		     struct dentry **dentryp, umode_t mode)
+{
+	struct dentry *dentry = *dentryp;
+	int error;
+	unsigned max_links = dir->i_sb->s_max_links;
+
+	error = may_create(idmap, dir, dentry);
+	if (error)
+		return error;
+
+	if (!dir->i_op->mkdir)
+		return -EPERM;
+
+	mode = vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
+	error = security_inode_mkdir(dir, dentry, mode);
+	if (error)
+		return error;
+
+	if (max_links && dir->i_nlink >= max_links)
+		return -EMLINK;
+
+	error = dir->i_op->mkdir(idmap, dir, dentry, mode);
+	if (!error) {
+		fsnotify_mkdir(dir, dentry);
+		if (unlikely(d_unhashed(dentry))) {
+			struct dentry *d;
+			d = lookup_dcache((const struct qstr *)&dentry->d_name,
+					  dentry->d_parent, 0);
+			if (IS_ERR(d)) {
+				error = PTR_ERR(d);
+			} else if (unlikely(d_is_negative(d))) {
+				dput(d);
+				error = -ENOENT;
+			} else {
+				dput(dentry);
+				*dentryp = d;
+			}
+		}
+	}
+	return error;
+}
+EXPORT_SYMBOL(vfs_mkdir_return);
+
 int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 {
 	struct dentry *dentry;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 29cb7b812d71..740332413138 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1488,26 +1488,11 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
+		host_err = vfs_mkdir_return(&nop_mnt_idmap, dirp, &dchild, iap->ia_mode);
+		if (!host_err && unlikely(dchild != resfhp->fh_dentry)) {
 			dput(resfhp->fh_dentry);
-			resfhp->fh_dentry = dget(d);
+			resfhp->fh_dentry = dget(dchild);
 			err = fh_update(resfhp);
-			dput(dchild);
-			dchild = d;
 			if (err)
 				goto out;
 		}
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 08e683917d12..92a277ccc419 100644
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
@@ -191,7 +160,7 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
 
 		case S_IFDIR:
 			/* mkdir is special... */
-			err =  ovl_mkdir_real(ofs, dir, &newdentry, attr->mode);
+			err =  ovl_do_mkdir(ofs, dir, &newdentry, attr->mode);
 			break;
 
 		case S_IFCHR:
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index b361f35762be..9ff34f84fc50 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -242,11 +242,11 @@ static inline int ovl_do_create(struct ovl_fs *ofs,
 }
 
 static inline int ovl_do_mkdir(struct ovl_fs *ofs,
-			       struct inode *dir, struct dentry *dentry,
+			       struct inode *dir, struct dentry **dentry,
 			       umode_t mode)
 {
-	int err = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
-	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, err);
+	int err = vfs_mkdir_return(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
+	pr_debug("mkdir(%pd2, 0%o) = %i\n", *dentry, mode, err);
 	return err;
 }
 
@@ -838,8 +838,8 @@ struct ovl_cattr {
 
 #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode = (m) })
 
-int ovl_mkdir_real(struct ovl_fs *ofs, struct inode *dir,
-		   struct dentry **newdentry, umode_t mode);
+int ovl_do_mkdir(struct ovl_fs *ofs, struct inode *dir,
+	      struct dentry **newdentry, umode_t mode);
 struct dentry *ovl_create_real(struct ovl_fs *ofs,
 			       struct inode *dir, struct dentry *newdentry,
 			       struct ovl_cattr *attr);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index fe511192f83c..24c44f7c1c8b 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -309,7 +309,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 			goto retry;
 		}
 
-		err = ovl_mkdir_real(ofs, dir, &work, attr.ia_mode);
+		err = ovl_do_mkdir(ofs, dir, &work, attr.ia_mode);
 		if (err)
 			goto out_dput;
 
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 88d167a5f8b7..dfb0eee5f5f3 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -211,7 +211,7 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 {
 	struct mnt_idmap *idmap;
 	struct path path;
-	struct dentry *dentry;
+	struct dentry *dentry, *d;
 	int err;
 
 	dentry = ksmbd_vfs_kern_path_create(work, name,
@@ -227,25 +227,10 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 
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
+	d = dentry;
+	err = vfs_mkdir_return(idmap, d_inode(path.dentry), &dentry, mode);
+	if (!err && dentry != d)
 		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(d));
-		dput(d);
-	}
 
 out_err:
 	done_path_create(&path, dentry);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7e29433c5ecc..406887d0394e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1923,6 +1923,8 @@ int vfs_create(struct mnt_idmap *, struct inode *,
 	       struct dentry *, umode_t, bool);
 int vfs_mkdir(struct mnt_idmap *, struct inode *,
 	      struct dentry *, umode_t);
+int vfs_mkdir_return(struct mnt_idmap *, struct inode *,
+		     struct dentry **, umode_t);
 int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
               umode_t, dev_t);
 int vfs_symlink(struct mnt_idmap *, struct inode *,
-- 
2.47.0


