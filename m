Return-Path: <linux-fsdevel+bounces-41020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A30CA2A064
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3691818824CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 05:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45B122540B;
	Thu,  6 Feb 2025 05:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oB1aKeOZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iIqrC7xF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oB1aKeOZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iIqrC7xF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3EE224B12;
	Thu,  6 Feb 2025 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820899; cv=none; b=HuiGkCTSEzeco0Pr+7bMiAhzLpNL/IPFJ/uAhvDpa6696ofPEoRGFDmeIZnCAiTOUW3WZKnNGftXFtWJ3StoX3TmqrJplqdIjyobkUTpVqV7u8i1xr6xMVyvTvlfKFt3HrqA5S3sgqHQZEpSmnHIvAqxHd17rmC9hjJIWwQuCtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820899; c=relaxed/simple;
	bh=yqPLlIyNRSWzQcBc2rqx2rU9e/BkDUK/oLfSSTjFzek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpKCOO22TwvhSZT7Euu69LmEkYuEvIm/jKsEVXOiIiN4qObV7q4stgCovZxHfyLkJG5+CnVt7PBigiFCyGactjZMNxX3SsXrhlol3FxASe+0taYw+CW+QyMHmOgDsgEs/GR/QEAhHrFawoTMXU4M2vJtnEgYmGlYz1iJUrXRUE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oB1aKeOZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iIqrC7xF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oB1aKeOZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iIqrC7xF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A9A1821108;
	Thu,  6 Feb 2025 05:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVe7gYkowi0dGd3vy2szPeCKItpohkL7PZISomngb4A=;
	b=oB1aKeOZ3N4SlUKIXXMCmzCYmK24kMqwPV7m7t9Impiji4KYUlOrn/HkQoJbw7irl4nwit
	ktGdGJhTz/tsB7D9XGME+xcWM5VoFKfePKnhrvINfhPYSEZ8Wen+YnY4eQdE0rbDKniKgO
	6cr/jJAPXeeoms3FJrsXdzOMiyhRrxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVe7gYkowi0dGd3vy2szPeCKItpohkL7PZISomngb4A=;
	b=iIqrC7xFtHajo8zueilFdg2SDw9w8MQdkt+MQ2PiahXbOg7C/S5PAXsXwNis+zFdix+XrL
	c2A4m3xj1pwoDyCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oB1aKeOZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iIqrC7xF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVe7gYkowi0dGd3vy2szPeCKItpohkL7PZISomngb4A=;
	b=oB1aKeOZ3N4SlUKIXXMCmzCYmK24kMqwPV7m7t9Impiji4KYUlOrn/HkQoJbw7irl4nwit
	ktGdGJhTz/tsB7D9XGME+xcWM5VoFKfePKnhrvINfhPYSEZ8Wen+YnY4eQdE0rbDKniKgO
	6cr/jJAPXeeoms3FJrsXdzOMiyhRrxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVe7gYkowi0dGd3vy2szPeCKItpohkL7PZISomngb4A=;
	b=iIqrC7xFtHajo8zueilFdg2SDw9w8MQdkt+MQ2PiahXbOg7C/S5PAXsXwNis+zFdix+XrL
	c2A4m3xj1pwoDyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E59F813795;
	Thu,  6 Feb 2025 05:48:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n1gUJhxNpGcKCAAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 05:48:12 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/19] nfs: change mkdir inode_operation to mkdir_async
Date: Thu,  6 Feb 2025 16:42:55 +1100
Message-ID: <20250206054504.2950516-19-neilb@suse.de>
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
X-Rspamd-Queue-Id: A9A1821108
X-Spam-Score: -3.01
X-Rspamd-Action: no action
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
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

mkdir_async allows a different dentry to be returned which is sometimes
relevant for nfs.

This patch changes the nfs_rpc_ops mkdir op to return a dentry, and
passes that back to the caller using mkdir_async.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/dir.c            | 17 ++++++++--------
 fs/nfs/internal.h       |  4 ++--
 fs/nfs/nfs3proc.c       |  9 +++++----
 fs/nfs/nfs4proc.c       | 45 +++++++++++++++++++++++++++++------------
 fs/nfs/proc.c           | 14 ++++++++-----
 include/linux/nfs_xdr.h |  2 +-
 6 files changed, 58 insertions(+), 33 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 8cbe63f4089a..2c69ec77d02c 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2420,11 +2420,12 @@ EXPORT_SYMBOL_GPL(nfs_mknod);
 /*
  * See comments for nfs_proc_create regarding failed operations.
  */
-int nfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-	      struct dentry *dentry, umode_t mode)
+struct dentry *nfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+			 struct dentry *dentry, umode_t mode,
+			 struct dirop_ret *dret)
 {
 	struct iattr attr;
-	int error;
+	struct dentry *ret;
 
 	dfprintk(VFS, "NFS: mkdir(%s/%lu), %pd\n",
 			dir->i_sb->s_id, dir->i_ino, dentry);
@@ -2433,14 +2434,14 @@ int nfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	attr.ia_mode = mode | S_IFDIR;
 
 	trace_nfs_mkdir_enter(dir, dentry);
-	error = NFS_PROTO(dir)->mkdir(dir, dentry, &attr);
-	trace_nfs_mkdir_exit(dir, dentry, error);
-	if (error != 0)
+	ret = NFS_PROTO(dir)->mkdir(dir, dentry, &attr);
+	trace_nfs_mkdir_exit(dir, dentry, PTR_ERR_OR_ZERO(ret));
+	if (IS_ERR(ret))
 		goto out_err;
-	return 0;
+	return ret;
 out_err:
 	d_drop(dentry);
-	return error;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nfs_mkdir);
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index fae2c7ae4acc..f7dea7fe5ebc 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -400,8 +400,8 @@ struct dentry *nfs_lookup(struct inode *, struct dentry *, unsigned int);
 void nfs_d_prune_case_insensitive_aliases(struct inode *inode);
 int nfs_create(struct mnt_idmap *, struct inode *, struct dentry *,
 	       umode_t, bool);
-int nfs_mkdir(struct mnt_idmap *, struct inode *, struct dentry *,
-	      umode_t);
+struct dentry *nfs_mkdir(struct mnt_idmap *, struct inode *, struct dentry *,
+			 umode_t, struct dirop_ret *);
 int nfs_rmdir(struct inode *, struct dentry *);
 int nfs_unlink(struct inode *, struct dentry *);
 int nfs_symlink(struct mnt_idmap *, struct inode *, struct dentry *,
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 0c3bc98cd999..41797cbbb8dc 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -578,7 +578,7 @@ nfs3_proc_symlink(struct inode *dir, struct dentry *dentry, struct folio *folio,
 	return status;
 }
 
-static int
+static struct dentry *
 nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 {
 	struct posix_acl *default_acl, *acl;
@@ -613,14 +613,15 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 
 	status = nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
 
-	dput(d_alias);
 out_release_acls:
 	posix_acl_release(acl);
 	posix_acl_release(default_acl);
 out:
 	nfs3_free_createdata(data);
 	dprintk("NFS reply mkdir: %d\n", status);
-	return status;
+	if (status)
+		return ERR_PTR(status);
+	return d_alias;
 }
 
 static int
@@ -1037,7 +1038,7 @@ static const struct inode_operations nfs3_dir_inode_operations = {
 	.link		= nfs_link,
 	.unlink		= nfs_unlink,
 	.symlink	= nfs_symlink,
-	.mkdir		= nfs_mkdir,
+	.mkdir_async	= nfs_mkdir,
 	.rmdir		= nfs_rmdir,
 	.mknod		= nfs_mknod,
 	.rename		= nfs_rename,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index df9669d4ded7..ef219968ed22 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5135,9 +5135,6 @@ static int nfs4_do_create(struct inode *dir, struct dentry *dentry, struct nfs4_
 				    &data->arg.seq_args, &data->res.seq_res, 1);
 	if (status == 0) {
 		spin_lock(&dir->i_lock);
-		/* Creating a directory bumps nlink in the parent */
-		if (data->arg.ftype == NF4DIR)
-			nfs4_inc_nlink_locked(dir);
 		nfs4_update_changeattr_locked(dir, &data->res.dir_cinfo,
 					      data->res.fattr->time_start,
 					      NFS_INO_INVALID_DATA);
@@ -5147,6 +5144,25 @@ static int nfs4_do_create(struct inode *dir, struct dentry *dentry, struct nfs4_
 	return status;
 }
 
+static struct dentry *nfs4_do_mkdir(struct inode *dir, struct dentry *dentry,
+				    struct nfs4_createdata *data)
+{
+	int status = nfs4_call_sync(NFS_SERVER(dir)->client, NFS_SERVER(dir), &data->msg,
+				    &data->arg.seq_args, &data->res.seq_res, 1);
+
+	if (status)
+		return ERR_PTR(status);
+
+	spin_lock(&dir->i_lock);
+	/* Creating a directory bumps nlink in the parent */
+	nfs4_inc_nlink_locked(dir);
+	nfs4_update_changeattr_locked(dir, &data->res.dir_cinfo,
+				      data->res.fattr->time_start,
+				      NFS_INO_INVALID_DATA);
+	spin_unlock(&dir->i_lock);
+	return nfs_add_or_obtain(dentry, data->res.fh, data->res.fattr);
+}
+
 static void nfs4_free_createdata(struct nfs4_createdata *data)
 {
 	nfs4_label_free(data->fattr.label);
@@ -5203,32 +5219,34 @@ static int nfs4_proc_symlink(struct inode *dir, struct dentry *dentry,
 	return err;
 }
 
-static int _nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
-		struct iattr *sattr, struct nfs4_label *label)
+static struct dentry *_nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
+				       struct iattr *sattr,
+				       struct nfs4_label *label)
 {
 	struct nfs4_createdata *data;
-	int status = -ENOMEM;
+	struct dentry *ret = ERR_PTR(-ENOMEM);
 
 	data = nfs4_alloc_createdata(dir, &dentry->d_name, sattr, NF4DIR);
 	if (data == NULL)
 		goto out;
 
 	data->arg.label = label;
-	status = nfs4_do_create(dir, dentry, data);
+	ret = nfs4_do_mkdir(dir, dentry, data);
 
 	nfs4_free_createdata(data);
 out:
-	return status;
+	return ret;
 }
 
-static int nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
-		struct iattr *sattr)
+static struct dentry *nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
+				      struct iattr *sattr)
 {
 	struct nfs_server *server = NFS_SERVER(dir);
 	struct nfs4_exception exception = {
 		.interruptible = true,
 	};
 	struct nfs4_label l, *label;
+	struct dentry *alias;
 	int err;
 
 	label = nfs4_label_init_security(dir, dentry, sattr, &l);
@@ -5236,14 +5254,15 @@ static int nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
 	if (!(server->attr_bitmask[2] & FATTR4_WORD2_MODE_UMASK))
 		sattr->ia_mode &= ~current_umask();
 	do {
-		err = _nfs4_proc_mkdir(dir, dentry, sattr, label);
+		alias = _nfs4_proc_mkdir(dir, dentry, sattr, label);
+		err = PTR_ERR_OR_ZERO(alias);
 		trace_nfs4_mkdir(dir, &dentry->d_name, err);
 		err = nfs4_handle_exception(NFS_SERVER(dir), err,
 				&exception);
 	} while (exception.retry);
 	nfs4_label_release_security(label);
 
-	return err;
+	return alias;
 }
 
 static int _nfs4_proc_readdir(struct nfs_readdir_arg *nr_arg,
@@ -10865,7 +10884,7 @@ static const struct inode_operations nfs4_dir_inode_operations = {
 	.link		= nfs_link,
 	.unlink		= nfs_unlink,
 	.symlink	= nfs_symlink,
-	.mkdir		= nfs_mkdir,
+	.mkdir_async	= nfs_mkdir,
 	.rmdir		= nfs_rmdir,
 	.mknod		= nfs_mknod,
 	.rename		= nfs_rename,
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 77920a2e3cef..7e8f6d8f02b4 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -446,13 +446,14 @@ nfs_proc_symlink(struct inode *dir, struct dentry *dentry, struct folio *folio,
 	return status;
 }
 
-static int
+static struct dentry *
 nfs_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 {
 	struct nfs_createdata *data;
 	struct rpc_message msg = {
 		.rpc_proc	= &nfs_procedures[NFSPROC_MKDIR],
 	};
+	struct dentry *alias = NULL;
 	int status = -ENOMEM;
 
 	dprintk("NFS call  mkdir %pd\n", dentry);
@@ -464,12 +465,15 @@ nfs_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
 	nfs_mark_for_revalidate(dir);
-	if (status == 0)
-		status = nfs_instantiate(dentry, data->res.fh, data->res.fattr);
+	if (status == 0) {
+		alias = nfs_add_or_obtain(dentry, data->res.fh, data->res.fattr);
+		status = PTR_ERR_OR_ZERO(alias);
+	} else
+		alias = ERR_PTR(status);
 	nfs_free_createdata(data);
 out:
 	dprintk("NFS reply mkdir: %d\n", status);
-	return status;
+	return alias;
 }
 
 static int
@@ -706,7 +710,7 @@ static const struct inode_operations nfs_dir_inode_operations = {
 	.link		= nfs_link,
 	.unlink		= nfs_unlink,
 	.symlink	= nfs_symlink,
-	.mkdir		= nfs_mkdir,
+	.mkdir_async	= nfs_mkdir,
 	.rmdir		= nfs_rmdir,
 	.mknod		= nfs_mknod,
 	.rename		= nfs_rename,
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index d0473e0d4aba..33d7f4c8183e 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1801,7 +1801,7 @@ struct nfs_rpc_ops {
 	int	(*link)    (struct inode *, struct inode *, const struct qstr *);
 	int	(*symlink) (struct inode *, struct dentry *, struct folio *,
 			    unsigned int, struct iattr *);
-	int	(*mkdir)   (struct inode *, struct dentry *, struct iattr *);
+	struct dentry *(*mkdir)   (struct inode *, struct dentry *, struct iattr *);
 	int	(*rmdir)   (struct inode *, const struct qstr *);
 	int	(*readdir) (struct nfs_readdir_arg *, struct nfs_readdir_res *);
 	int	(*mknod)   (struct inode *, struct dentry *, struct iattr *,
-- 
2.47.1


