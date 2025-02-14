Return-Path: <linux-fsdevel+bounces-41701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BADA35629
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 06:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9664616D789
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 05:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2018C039;
	Fri, 14 Feb 2025 05:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kMJVjjcl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d6lGjkN2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kMJVjjcl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d6lGjkN2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9534018A6B7;
	Fri, 14 Feb 2025 05:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739510558; cv=none; b=ZwHbQSW3+DaxPh3+EPEONNzcQ9UkaCrpl+5joYv0zzWgquQuv0UKUQ+PMypgUho0qZTvbLlgTiuQMuPCUWX0did+AmyV+59qqjhMJwgjtp3GcjggNj+DTNnlj175rlLiGwyYxMQzUgimfJGb5t81dXsdGNHG7BKeDCxuG3KCnUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739510558; c=relaxed/simple;
	bh=0UiC1ktnWIInaINyIAfHA/BtM6ihO5ZQSbmKUF5lLBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iW85nGNtMTnkdCl/k/7zrqI4mYKWWKox+zumyBzb1c/v+9iezIPO4xhdY+LQv2mXBa1TazJs7EOiDHU8iDAoiZkdnjol7DnPu8KPgHM5pSF6SMExFpSFH1b/MQYJ4R1jtnJVhYXVH/Xop8z40ipb1tg7EhyeWIgxZOpILmy8OX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kMJVjjcl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d6lGjkN2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kMJVjjcl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d6lGjkN2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC6D01F797;
	Fri, 14 Feb 2025 05:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739510554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hu66qEqmtBGlWKs4Ylf2WjyHIxQ/BhQxhTzugc256wA=;
	b=kMJVjjclnZmEvaLegeG4CPVJ2xG4UJrBmN2q5eWjWA1wqiWVTa/+rGAdSgCXYim+poYW7Z
	xg6/2iIBq5OPfzlY+AUkcvgr0hUqeMbonQhinv4/AsvXbrQLVkEOmWiTOlpubeawxy7F4x
	wdX/i+SSqlypmVUB+aN6X3Lq2oZzFsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739510554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hu66qEqmtBGlWKs4Ylf2WjyHIxQ/BhQxhTzugc256wA=;
	b=d6lGjkN2LxP4vgEnscj44rUpKxnNNZp98ZLdYyPEN1tQQi82Gpr+YeBymUoBMmGYvcmhP7
	5taPsaSmk3TBXODw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739510554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hu66qEqmtBGlWKs4Ylf2WjyHIxQ/BhQxhTzugc256wA=;
	b=kMJVjjclnZmEvaLegeG4CPVJ2xG4UJrBmN2q5eWjWA1wqiWVTa/+rGAdSgCXYim+poYW7Z
	xg6/2iIBq5OPfzlY+AUkcvgr0hUqeMbonQhinv4/AsvXbrQLVkEOmWiTOlpubeawxy7F4x
	wdX/i+SSqlypmVUB+aN6X3Lq2oZzFsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739510554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hu66qEqmtBGlWKs4Ylf2WjyHIxQ/BhQxhTzugc256wA=;
	b=d6lGjkN2LxP4vgEnscj44rUpKxnNNZp98ZLdYyPEN1tQQi82Gpr+YeBymUoBMmGYvcmhP7
	5taPsaSmk3TBXODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 538A8137DB;
	Fri, 14 Feb 2025 05:22:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LDb2AhjTrmc/bwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 14 Feb 2025 05:22:32 +0000
From: NeilBrown <neilb@suse.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] nfs: change mkdir inode_operation to return alternate dentry if needed.
Date: Fri, 14 Feb 2025 16:16:42 +1100
Message-ID: <20250214052204.3105610-3-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250214052204.3105610-1-neilb@suse.de>
References: <20250214052204.3105610-1-neilb@suse.de>
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

mkdir now allows a different dentry to be returned which is sometimes
relevant for nfs.

This patch changes the nfs_rpc_ops mkdir op to return a dentry, and
passes that back to the caller.

The mkdir nfs_rpc_op may return NULL if the original dentry should be
used.  This is different from the mkdir inode_operation.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/dir.c            | 18 ++++++++---------
 fs/nfs/nfs3proc.c       |  7 ++++---
 fs/nfs/nfs4proc.c       | 43 +++++++++++++++++++++++++++++------------
 fs/nfs/proc.c           | 12 ++++++++----
 include/linux/nfs_xdr.h |  2 +-
 5 files changed, 53 insertions(+), 29 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 1bf728367426..84ee33bbd91f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2426,7 +2426,7 @@ struct dentry *nfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, umode_t mode)
 {
 	struct iattr attr;
-	int error;
+	struct dentry *ret;
 
 	dfprintk(VFS, "NFS: mkdir(%s/%lu), %pd\n",
 			dir->i_sb->s_id, dir->i_ino, dentry);
@@ -2435,14 +2435,14 @@ struct dentry *nfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	attr.ia_mode = mode | S_IFDIR;
 
 	trace_nfs_mkdir_enter(dir, dentry);
-	error = NFS_PROTO(dir)->mkdir(dir, dentry, &attr);
-	trace_nfs_mkdir_exit(dir, dentry, error);
-	if (error != 0)
-		goto out_err;
-	return dentry;
-out_err:
-	d_drop(dentry);
-	return ERR_PTR(error);
+	ret = NFS_PROTO(dir)->mkdir(dir, dentry, &attr);
+	trace_nfs_mkdir_exit(dir, dentry, PTR_ERR_OR_ZERO(ret));
+	if (IS_ERR(ret))
+		d_drop(dentry);
+	if (ret)
+		return ret;
+	else
+		return dentry;
 }
 EXPORT_SYMBOL_GPL(nfs_mkdir);
 
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 0c3bc98cd999..f8e239121669 100644
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
+	return dentry;
 }
 
 static int
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index df9669d4ded7..164c9f3f36c8 100644
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
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 77920a2e3cef..63e71310b9f6 100644
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
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 9155a6ffc370..d66c61cbbd1d 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1802,7 +1802,7 @@ struct nfs_rpc_ops {
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


