Return-Path: <linux-fsdevel+bounces-69221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FAEC73967
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 11:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F86A358C82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 10:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EB932F761;
	Thu, 20 Nov 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FaA3fhsn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEEF2D9491;
	Thu, 20 Nov 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636160; cv=none; b=tEmIJsICyK7gK/2MhZYPI82kjaQVOZ2M2SzEwF3pl6m6Mu5GqCTWQTbAzhYpBn8LkyVcJKH/73x+wvphDmR+Z2ozcgOxLKYc4g0SEq5z9Dfz2Q7jjVEKZbV3xmd23TeSHnYISSg9I9KNM0wrt1dmuF3TGEwawiG12/dsznRSClE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636160; c=relaxed/simple;
	bh=8Fb1JFU1XDyN5HkfP42mRcmu3leIkP0ZTYVVDmhv4AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNd1Z/KorS66wB51Mjqpzh3BlPaU1WrZbqDtpUoSyVzInRqk/p47zueobBWm1JkzyWPIuvODUZ5YuPc93DcwTnxqa/AY/k1XTOZb6SiRm0H6PW2+Ofv1wKJFg6GcAyLiADN+L2f2yLgANm2gDGu1c/NqtOXhk4jzfCbw7093D6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FaA3fhsn; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AJSezwXEdBDqaX7YfiQwltaRFSgxJdT+Q/B2BLWl0FI=; b=FaA3fhsnLfsw3K/BkzbrOwPWAp
	h97qpC7y3qBpctHkaI9KDUxUgRl99lctwiYVyu4T3AGkVP+lbMZO8L65lnDqiIFc0yNS3sosNL1VZ
	ola4rsRkUQuPs8IsO0FBAnQ7BCLBBZffcfvmAq/dbY0EFZA7KQf4sV9dKLHzkLjHGFANY1ZU365tf
	D2bQpnj2ng99sLFyzmclqo6WV0Yk16JTvaxNv5H+TygFquaxCQP5TZu/9yWKyeLgJ2TsOXvhksa7u
	ZDcOL1ZHDEv9S/HUPqTPtf5/9lVLMHJRU11x6jm0iqVHIbXQzKXTjzfhvnYubzPt/KI3LpwtItA3h
	4lmiB/Ow==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vM2KF-003CKB-AI; Thu, 20 Nov 2025 11:55:42 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Bernd Schubert <bschubert@ddn.com>,
	Kevin Chen <kchen@ddn.com>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v1 2/3] fuse: move fuse_entry_out structs out of the stack
Date: Thu, 20 Nov 2025 10:55:34 +0000
Message-ID: <20251120105535.13374-3-luis@igalia.com>
In-Reply-To: <20251120105535.13374-1-luis@igalia.com>
References: <20251120105535.13374-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch simply turns all struct fuse_entry_out instances that are
allocated in the stack into dynamically allocated structs.  This is a
preparation patch for further changes, including the extra helper function
used to actually allocate the memory.

Also, remove all the memset()s that are used to zero-out these structures,
as kzalloc() is being used.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/dir.c    | 139 ++++++++++++++++++++++++++++++-----------------
 fs/fuse/fuse_i.h |   9 +++
 fs/fuse/inode.c  |  20 +++++--
 3 files changed, 114 insertions(+), 54 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ecaec0fea3a1..77d50ea30b61 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -172,7 +172,6 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 			     u64 nodeid, const struct qstr *name,
 			     struct fuse_entry_out *outarg)
 {
-	memset(outarg, 0, sizeof(struct fuse_entry_out));
 	args->opcode = FUSE_LOOKUP;
 	args->nodeid = nodeid;
 	args->in_numargs = 3;
@@ -213,7 +212,7 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 		goto invalid;
 	else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
 		 (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TARGET))) {
-		struct fuse_entry_out outarg;
+		struct fuse_entry_out *outarg;
 		FUSE_ARGS(args);
 		struct fuse_forget_link *forget;
 		u64 attr_version;
@@ -233,20 +232,27 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 		if (!forget)
 			goto out;
 
+		outarg = fuse_entry_out_alloc(fc);
+		if (!outarg) {
+			kfree(forget);
+			goto out;
+		}
+
 		attr_version = fuse_get_attr_version(fm->fc);
 
 		fuse_lookup_init(fm->fc, &args, get_node_id(dir),
-				 name, &outarg);
+				 name, outarg);
 		ret = fuse_simple_request(fm, &args);
 		/* Zero nodeid is same as -ENOENT */
-		if (!ret && !outarg.nodeid)
+		if (!ret && !outarg->nodeid)
 			ret = -ENOENT;
 		if (!ret) {
 			fi = get_fuse_inode(inode);
-			if (outarg.nodeid != get_node_id(inode) ||
-			    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg.attr.flags & FUSE_ATTR_SUBMOUNT)) {
+			if (outarg->nodeid != get_node_id(inode) ||
+			    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg->attr.flags & FUSE_ATTR_SUBMOUNT)) {
 				fuse_queue_forget(fm->fc, forget,
-						  outarg.nodeid, 1);
+						  outarg->nodeid, 1);
+				kfree(outarg);
 				goto invalid;
 			}
 			spin_lock(&fi->lock);
@@ -254,17 +260,22 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 			spin_unlock(&fi->lock);
 		}
 		kfree(forget);
-		if (ret == -ENOMEM || ret == -EINTR)
+		if (ret == -ENOMEM || ret == -EINTR) {
+			kfree(outarg);
 			goto out;
-		if (ret || fuse_invalid_attr(&outarg.attr) ||
-		    fuse_stale_inode(inode, outarg.generation, &outarg.attr))
+		}
+		if (ret || fuse_invalid_attr(&outarg->attr) ||
+		    fuse_stale_inode(inode, outarg->generation, &outarg->attr)) {
+			kfree(outarg);
 			goto invalid;
+		}
 
 		forget_all_cached_acls(inode);
-		fuse_change_attributes(inode, &outarg.attr, NULL,
-				       ATTR_TIMEOUT(&outarg),
+		fuse_change_attributes(inode, &outarg->attr, NULL,
+				       ATTR_TIMEOUT(outarg),
 				       attr_version);
-		fuse_change_entry_timeout(entry, &outarg);
+		fuse_change_entry_timeout(entry, outarg);
+		kfree(outarg);
 	} else if (inode) {
 		fi = get_fuse_inode(inode);
 		if (flags & LOOKUP_RCU) {
@@ -410,7 +421,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 				  unsigned int flags)
 {
-	struct fuse_entry_out outarg;
+	struct fuse_entry_out *outarg;
 	struct fuse_conn *fc;
 	struct inode *inode;
 	struct dentry *newent;
@@ -424,9 +435,13 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 	fc = get_fuse_conn_super(dir->i_sb);
 	epoch = atomic_read(&fc->epoch);
 
+	outarg = fuse_entry_out_alloc(fc);
+	if (!outarg)
+		return ERR_PTR(-ENOMEM);
+
 	locked = fuse_lock_inode(dir);
 	err = fuse_lookup_name(dir->i_sb, get_node_id(dir), &entry->d_name,
-			       &outarg, &inode);
+			       outarg, &inode);
 	fuse_unlock_inode(dir, locked);
 	if (err == -ENOENT) {
 		outarg_valid = false;
@@ -447,17 +462,21 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 	entry = newent ? newent : entry;
 	entry->d_time = epoch;
 	if (outarg_valid)
-		fuse_change_entry_timeout(entry, &outarg);
+		fuse_change_entry_timeout(entry, outarg);
 	else
 		fuse_invalidate_entry_cache(entry);
 
 	if (inode)
 		fuse_advise_use_readdirplus(dir);
+
+	kfree(outarg);
+
 	return newent;
 
- out_iput:
+out_iput:
 	iput(inode);
- out_err:
+out_err:
+	kfree(outarg);
 	return ERR_PTR(err);
 }
 
@@ -625,7 +644,7 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	struct fuse_forget_link *forget;
 	struct fuse_create_in inarg;
 	struct fuse_open_out *outopenp;
-	struct fuse_entry_out outentry;
+	struct fuse_entry_out *outentry;
 	struct fuse_inode *fi;
 	struct fuse_file *ff;
 	int epoch, err;
@@ -640,17 +659,19 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	if (!forget)
 		goto out_err;
 
-	err = -ENOMEM;
 	ff = fuse_file_alloc(fm, true);
 	if (!ff)
 		goto out_put_forget_req;
 
+	outentry = fuse_entry_out_alloc(fm->fc);
+	if (!outentry)
+		goto out_free_ff;
+
 	if (!fm->fc->dont_mask)
 		mode &= ~current_umask();
 
 	flags &= ~O_NOCTTY;
 	memset(&inarg, 0, sizeof(inarg));
-	memset(&outentry, 0, sizeof(outentry));
 	inarg.flags = flags;
 	inarg.mode = mode;
 	inarg.umask = current_umask();
@@ -668,8 +689,8 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
 	args.out_numargs = 2;
-	args.out_args[0].size = sizeof(outentry);
-	args.out_args[0].value = &outentry;
+	args.out_args[0].size = sizeof(*outentry);
+	args.out_args[0].value = outentry;
 	/* Store outarg for fuse_finish_open() */
 	outopenp = &ff->args->open_outarg;
 	args.out_args[1].size = sizeof(*outopenp);
@@ -677,34 +698,35 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 
 	err = get_create_ext(idmap, &args, dir, entry, mode);
 	if (err)
-		goto out_free_ff;
+		goto out_free_outentry;
 
 	err = fuse_simple_idmap_request(idmap, fm, &args);
 	free_ext_value(&args);
 	if (err)
-		goto out_free_ff;
+		goto out_free_outentry;
 
 	err = -EIO;
-	if (!S_ISREG(outentry.attr.mode) || invalid_nodeid(outentry.nodeid) ||
-	    fuse_invalid_attr(&outentry.attr))
-		goto out_free_ff;
+	if (!S_ISREG(outentry->attr.mode) || invalid_nodeid(outentry->nodeid) ||
+	    fuse_invalid_attr(&outentry->attr))
+		goto out_free_outentry;
 
 	ff->fh = outopenp->fh;
-	ff->nodeid = outentry.nodeid;
+	ff->nodeid = outentry->nodeid;
 	ff->open_flags = outopenp->open_flags;
-	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
-			  &outentry.attr, ATTR_TIMEOUT(&outentry), 0, 0);
+	inode = fuse_iget(dir->i_sb, outentry->nodeid, outentry->generation,
+			  &outentry->attr, ATTR_TIMEOUT(outentry), 0, 0);
 	if (!inode) {
 		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
 		fuse_sync_release(NULL, ff, flags);
-		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
+		fuse_queue_forget(fm->fc, forget, outentry->nodeid, 1);
 		err = -ENOMEM;
+		kfree(outentry);
 		goto out_err;
 	}
 	kfree(forget);
 	d_instantiate(entry, inode);
 	entry->d_time = epoch;
-	fuse_change_entry_timeout(entry, &outentry);
+	fuse_change_entry_timeout(entry, outentry);
 	fuse_dir_changed(dir);
 	err = generic_file_open(inode, file);
 	if (!err) {
@@ -720,8 +742,13 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
 			invalidate_inode_pages2(inode->i_mapping);
 	}
+
+	kfree(outentry);
+
 	return err;
 
+out_free_outentry:
+	kfree(outentry);
 out_free_ff:
 	fuse_file_free(ff);
 out_put_forget_req:
@@ -780,7 +807,7 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 				       struct fuse_args *args, struct inode *dir,
 				       struct dentry *entry, umode_t mode)
 {
-	struct fuse_entry_out outarg;
+	struct fuse_entry_out *outarg;
 	struct inode *inode;
 	struct dentry *d;
 	struct fuse_forget_link *forget;
@@ -795,54 +822,66 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 	if (!forget)
 		return ERR_PTR(-ENOMEM);
 
-	memset(&outarg, 0, sizeof(outarg));
+	outarg = fuse_entry_out_alloc(fm->fc);
+	if (!outarg) {
+		err = -ENOMEM;
+		goto out_put_forget_req;
+	}
+
 	args->nodeid = get_node_id(dir);
 	args->out_numargs = 1;
-	args->out_args[0].size = sizeof(outarg);
-	args->out_args[0].value = &outarg;
+	args->out_args[0].size = sizeof(*outarg);
+	args->out_args[0].value = outarg;
 
 	if (args->opcode != FUSE_LINK) {
 		err = get_create_ext(idmap, args, dir, entry, mode);
 		if (err)
-			goto out_put_forget_req;
+			goto out_free_outarg;
 	}
 
 	err = fuse_simple_idmap_request(idmap, fm, args);
 	free_ext_value(args);
 	if (err)
-		goto out_put_forget_req;
+		goto out_free_outarg;
 
 	err = -EIO;
-	if (invalid_nodeid(outarg.nodeid) || fuse_invalid_attr(&outarg.attr))
-		goto out_put_forget_req;
+	if (invalid_nodeid(outarg->nodeid) || fuse_invalid_attr(&outarg->attr))
+		goto out_free_outarg;
 
-	if ((outarg.attr.mode ^ mode) & S_IFMT)
-		goto out_put_forget_req;
+	if ((outarg->attr.mode ^ mode) & S_IFMT)
+		goto out_free_outarg;
 
-	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
-			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0, 0);
+	inode = fuse_iget(dir->i_sb, outarg->nodeid, outarg->generation,
+			  &outarg->attr, ATTR_TIMEOUT(outarg), 0, 0);
 	if (!inode) {
-		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
+		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
+		kfree(outarg);
 		return ERR_PTR(-ENOMEM);
 	}
 	kfree(forget);
 
 	d_drop(entry);
 	d = d_splice_alias(inode, entry);
-	if (IS_ERR(d))
+	if (IS_ERR(d)) {
+		kfree(outarg);
 		return d;
+	}
 
 	if (d) {
 		d->d_time = epoch;
-		fuse_change_entry_timeout(d, &outarg);
+		fuse_change_entry_timeout(d, outarg);
 	} else {
 		entry->d_time = epoch;
-		fuse_change_entry_timeout(entry, &outarg);
+		fuse_change_entry_timeout(entry, outarg);
 	}
 	fuse_dir_changed(dir);
+	kfree(outarg);
+
 	return d;
 
- out_put_forget_req:
+out_free_outarg:
+	kfree(outarg);
+out_put_forget_req:
 	if (err == -EEXIST)
 		fuse_invalidate_entry(entry);
 	kfree(forget);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f4e9747ed8c7..d997fdcede9b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1092,6 +1092,15 @@ static inline bool fuse_is_bad(struct inode *inode)
 	return unlikely(test_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state));
 }
 
+static inline struct fuse_entry_out *fuse_entry_out_alloc(struct fuse_conn *fc)
+{
+	struct fuse_entry_out *entryout;
+
+	entryout = kzalloc(sizeof(*entryout), GFP_KERNEL_ACCOUNT);
+
+	return entryout;
+}
+
 static inline struct folio **fuse_folios_alloc(unsigned int nfolios, gfp_t flags,
 					       struct fuse_folio_desc **desc)
 {
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b9b094c1bc36..30ee37c29057 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1080,14 +1080,21 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 
 	inode = ilookup5(sb, handle->nodeid, fuse_inode_eq, &handle->nodeid);
 	if (!inode) {
-		struct fuse_entry_out outarg;
+		struct fuse_entry_out *outarg;
 		const struct qstr name = QSTR_INIT(".", 1);
 
 		if (!fc->export_support)
 			goto out_err;
 
-		err = fuse_lookup_name(sb, handle->nodeid, &name, &outarg,
+		outarg = fuse_entry_out_alloc(fc);
+		if (!outarg) {
+			err = -ENOMEM;
+			goto out_err;
+		}
+
+		err = fuse_lookup_name(sb, handle->nodeid, &name, outarg,
 				       &inode);
+		kfree(outarg);
 		if (err && err != -ENOENT)
 			goto out_err;
 		if (err || !inode) {
@@ -1181,14 +1188,19 @@ static struct dentry *fuse_get_parent(struct dentry *child)
 	struct fuse_conn *fc = get_fuse_conn(child_inode);
 	struct inode *inode;
 	struct dentry *parent;
-	struct fuse_entry_out outarg;
+	struct fuse_entry_out *outarg;
 	int err;
 
 	if (!fc->export_support)
 		return ERR_PTR(-ESTALE);
 
+	outarg = fuse_entry_out_alloc(fc);
+	if (!outarg)
+		return ERR_PTR(-ENOMEM);
+
 	err = fuse_lookup_name(child_inode->i_sb, get_node_id(child_inode),
-			       &dotdot_name, &outarg, &inode);
+			       &dotdot_name, outarg, &inode);
+	kfree(outarg);
 	if (err) {
 		if (err == -ENOENT)
 			return ERR_PTR(-ESTALE);

