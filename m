Return-Path: <linux-fsdevel+bounces-42739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 003FFA47182
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 02:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9653F7A71E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 01:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01921A8F63;
	Thu, 27 Feb 2025 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mxN/GyJS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L4tPqRug";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mxN/GyJS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L4tPqRug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C377213BC0C
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 01:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740620464; cv=none; b=aYv9sS9VrZxxBd1hdBtELr5dLMZKdfXOXPDEsjrh/fU6ke6KIdsBcjR07rT89mcCOn78I6uvt6FZJQ2w5tn8sJW6BxeWgcjnRPX2pRED/IOF+bSwCw0WnRL36aKLlUrfk8kiZCwpTKoHJbLJCNbL+ZdN2VAeUqOQZDtGmN+yl0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740620464; c=relaxed/simple;
	bh=gQDjxTtkJYhPuuWx+aAlZ1OTzTocbMAGF1hRehYvap8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nqxo/aFID54DTrUOZ5oXgNuKjBAdPS+OIxIciekLqrR6X3fgs/JfFjjKaGbqNZAuRdWHmLPItZ/AQVZyrzN9Zb/CpT1vDpndqtPbfA9iI/qbUGs7Rx8FKt0MOfqPU8SC3Ljdp6FwXUc0cBB22baBw86uZx45aRfRxH6cLCKnOf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mxN/GyJS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L4tPqRug; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mxN/GyJS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L4tPqRug; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4271021189;
	Thu, 27 Feb 2025 01:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740620460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwL5kSzviU5EdrjFKVlgyFKxq37BXoqNgparc+GpU2w=;
	b=mxN/GyJSdRpyEg26MfjRvFOLQzNEusxl+OSob3z+O89UlRVDtvIo7/IInWrI//cJvTQ3vx
	0cctfi8T+7PC5p5yuHWQIyR5RjjRKwZICcVdJLMBWQYQ4IEMOxgU2GCmdluXnVk3HglxZC
	tCvzXTCoRZbwR1GD9eKJ8MuDl9z+K3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740620460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwL5kSzviU5EdrjFKVlgyFKxq37BXoqNgparc+GpU2w=;
	b=L4tPqRugOLivVkircTenaH996cNIEgXxm4g/enr4BdVMQ8c9ie5PlLGuIfx4VkFO6uXdmc
	R+djLV/pataJ2IBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740620460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwL5kSzviU5EdrjFKVlgyFKxq37BXoqNgparc+GpU2w=;
	b=mxN/GyJSdRpyEg26MfjRvFOLQzNEusxl+OSob3z+O89UlRVDtvIo7/IInWrI//cJvTQ3vx
	0cctfi8T+7PC5p5yuHWQIyR5RjjRKwZICcVdJLMBWQYQ4IEMOxgU2GCmdluXnVk3HglxZC
	tCvzXTCoRZbwR1GD9eKJ8MuDl9z+K3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740620460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwL5kSzviU5EdrjFKVlgyFKxq37BXoqNgparc+GpU2w=;
	b=L4tPqRugOLivVkircTenaH996cNIEgXxm4g/enr4BdVMQ8c9ie5PlLGuIfx4VkFO6uXdmc
	R+djLV/pataJ2IBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03953134A0;
	Thu, 27 Feb 2025 01:40:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AlqkKqXCv2cMEgAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 27 Feb 2025 01:40:53 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] nfs: change mkdir inode_operation to return alternate dentry if needed.
Date: Thu, 27 Feb 2025 12:32:57 +1100
Message-ID: <20250227013949.536172-6-neilb@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227013949.536172-1-neilb@suse.de>
References: <20250227013949.536172-1-neilb@suse.de>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,vger.kernel.org,gmail.com,redhat.com,szeredi.hu,nod.at,cambridgegreys.com,sipsolutions.net,lists.infradead.org];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn),to_ip_from(RL99f7qjgz3j4qaff4fhggowz5)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

mkdir now allows a different dentry to be returned which is sometimes
relevant for nfs.

This patch changes the nfs_rpc_ops mkdir op to return a dentry, and
passes that back to the caller.

The mkdir nfs_rpc_op will return NULL if the original dentry should be
used.  This matches the mkdir inode_operation.

nfs4_do_create() is duplicated to nfs4_do_mkdir() which is changed to
handle the specifics of directories.  Consequently the current special
handling for directories is removed from nfs4_do_create()

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/dir.c            | 13 ++++---------
 fs/nfs/nfs3proc.c       | 29 ++++++++++++++-------------
 fs/nfs/nfs4proc.c       | 43 +++++++++++++++++++++++++++++------------
 fs/nfs/proc.c           | 12 ++++++++----
 include/linux/nfs_xdr.h |  2 +-
 5 files changed, 60 insertions(+), 39 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 101b1098e87b..bc957487f6ec 100644
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
@@ -2435,14 +2435,9 @@ struct dentry *nfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	attr.ia_mode = mode | S_IFDIR;
 
 	trace_nfs_mkdir_enter(dir, dentry);
-	error = NFS_PROTO(dir)->mkdir(dir, dentry, &attr);
-	trace_nfs_mkdir_exit(dir, dentry, error);
-	if (error != 0)
-		goto out_err;
-	return NULL;
-out_err:
-	d_drop(dentry);
-	return ERR_PTR(error);
+	ret = NFS_PROTO(dir)->mkdir(dir, dentry, &attr);
+	trace_nfs_mkdir_exit(dir, dentry, PTR_ERR_OR_ZERO(ret));
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nfs_mkdir);
 
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 0c3bc98cd999..755ed3c37051 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -578,13 +578,13 @@ nfs3_proc_symlink(struct inode *dir, struct dentry *dentry, struct folio *folio,
 	return status;
 }
 
-static int
+static struct dentry *
 nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 {
 	struct posix_acl *default_acl, *acl;
 	struct nfs3_createdata *data;
-	struct dentry *d_alias;
-	int status = -ENOMEM;
+	struct dentry *ret = ERR_PTR(-ENOMEM);
+	int status;
 
 	dprintk("NFS call  mkdir %pd\n", dentry);
 
@@ -592,8 +592,9 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 	if (data == NULL)
 		goto out;
 
-	status = posix_acl_create(dir, &sattr->ia_mode, &default_acl, &acl);
-	if (status)
+	ret = ERR_PTR(posix_acl_create(dir, &sattr->ia_mode,
+				       &default_acl, &acl));
+	if (IS_ERR(ret))
 		goto out;
 
 	data->msg.rpc_proc = &nfs3_procedures[NFS3PROC_MKDIR];
@@ -602,25 +603,27 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 	data->arg.mkdir.len = dentry->d_name.len;
 	data->arg.mkdir.sattr = sattr;
 
-	d_alias = nfs3_do_create(dir, dentry, data);
-	status = PTR_ERR_OR_ZERO(d_alias);
+	ret = nfs3_do_create(dir, dentry, data);
 
-	if (status != 0)
+	if (IS_ERR(ret))
 		goto out_release_acls;
 
-	if (d_alias)
-		dentry = d_alias;
+	if (ret)
+		dentry = ret;
 
 	status = nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
+	if (status) {
+		dput(ret);
+		ret = ERR_PTR(status);
+	}
 
-	dput(d_alias);
 out_release_acls:
 	posix_acl_release(acl);
 	posix_acl_release(default_acl);
 out:
 	nfs3_free_createdata(data);
-	dprintk("NFS reply mkdir: %d\n", status);
-	return status;
+	dprintk("NFS reply mkdir: %d\n", PTR_ERR_OR_ZERO(ret));
+	return ret;
 }
 
 static int
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 0a46b193f18e..d5ce5256b47a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5133,9 +5133,6 @@ static int nfs4_do_create(struct inode *dir, struct dentry *dentry, struct nfs4_
 				    &data->arg.seq_args, &data->res.seq_res, 1);
 	if (status == 0) {
 		spin_lock(&dir->i_lock);
-		/* Creating a directory bumps nlink in the parent */
-		if (data->arg.ftype == NF4DIR)
-			nfs4_inc_nlink_locked(dir);
 		nfs4_update_changeattr_locked(dir, &data->res.dir_cinfo,
 					      data->res.fattr->time_start,
 					      NFS_INO_INVALID_DATA);
@@ -5145,6 +5142,25 @@ static int nfs4_do_create(struct inode *dir, struct dentry *dentry, struct nfs4_
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
@@ -5201,32 +5217,34 @@ static int nfs4_proc_symlink(struct inode *dir, struct dentry *dentry,
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
@@ -5234,14 +5252,15 @@ static int nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
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
2.48.1


