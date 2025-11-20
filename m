Return-Path: <linux-fsdevel+bounces-69223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84625C73976
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A5C535A47B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030F1330337;
	Thu, 20 Nov 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TPTXq3wP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68FA1A00F0;
	Thu, 20 Nov 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636162; cv=none; b=WUt4N4gqoThUf1Yuvho2Vqzt79H1KG6wUoGIrA41i5jI6TunNIYisGIJyfDGViwGc9ywihwR64HVDJirZIjdK9mBQdJvSsktaruYMgc4uglphMSagE1b3IgS1wfaWqVAx74MuLB6MKXAiaSnN3FDa+fY/bwmiGXyzP+2QIeB1uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636162; c=relaxed/simple;
	bh=HoqBklTZVf0NZl3P+lbBf9/SaNmVKq6F03ocZqZsED4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAol93pz82APS1xPR+hub0hoSKOJ3KiGPglBKPnbQX4cLjg78vuELYRggy16udqWT/XrtxhFfohLnXg6QsF8MV0ufTKItCOeBuhbrxA3Y+K20wc3AtWHA50MjhmcaIxVhLs9uAzF8vMLIJ806nyFQ2sEBdyW6bUtkGNRPWT8fA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TPTXq3wP; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+6qT6KYRpG3gOmJNyUnhTkX48gjbIOviuneFgsusu6c=; b=TPTXq3wPUz6WK0TJVphDcr7gDs
	B3b2fIQnTu3ZeG++LQidwqQ5KMoIgDDTcK/oaUiO4EEp3YcNqQOUdw7iDYLPfd2kJNkK1XJ5usRhM
	JdmFzgVGiIrSQzYEJJmuNgXdb0fOucJozZ1NwKZhsTDzh2TfyRXLTntRH0lpVmXrQj4dHh5obnVOJ
	koIbcgz/Awg1r/HP/E0KLjr0woIuPDswZG13O5+txz/Gy7DYO2omC8gjeJdZ+10qjSvC6qzlUjczR
	NVCBCsBpmXX7NAe1ipQKx38AW+4/Oi7p8Cz6pxIrPmVudH8XPy2x7WJA0jb1Bs6Mh3Fh2hANDHEB/
	bRixh40g==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vM2KF-003CKD-QZ; Thu, 20 Nov 2025 11:55:43 +0100
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
Subject: [RFC PATCH v1 3/3] fuse: implementation of the FUSE_LOOKUP_HANDLE operation
Date: Thu, 20 Nov 2025 10:55:35 +0000
Message-ID: <20251120105535.13374-4-luis@igalia.com>
In-Reply-To: <20251120105535.13374-1-luis@igalia.com>
References: <20251120105535.13374-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of LOOKUP_HANDLE simply modifies the LOOKUP operation to
include an extra inarg: the file handle for the parent directory (if it is
available).  Also, because fuse_entry_out now has a extra variable size
struct (the actual handle), it also sets the out_argvar flag to true.

Most of the other modifications in this patch are a fallout from these
changes: because fuse_entry_out has been modified to include a variable size
struct, every operation that receives such a parameter have to take this
into account:

  CREATE, LINK, LOOKUP, MKDIR, MKNOD, READDIRPLUS, SYMLINK, TMPFILE

The export_operations were also modified to use this new file handle instead
if the lookup_handle operation is implemented for the file system.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/dev.c             |   1 +
 fs/fuse/dir.c             |  75 +++++++++++++++-----
 fs/fuse/fuse_i.h          |  34 ++++++++--
 fs/fuse/inode.c           | 139 +++++++++++++++++++++++++++++++++-----
 fs/fuse/readdir.c         |  10 +--
 include/uapi/linux/fuse.h |   8 +++
 6 files changed, 224 insertions(+), 43 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 132f38619d70..2f659e70a088 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -632,6 +632,7 @@ static void fuse_adjust_compat(struct fuse_conn *fc, struct fuse_args *args)
 			break;
 		}
 	}
+	/* XXX handle FUSE_COMPAT_45_ENTRY_OUT_SIZE */
 }
 
 static void fuse_force_creds(struct fuse_req *req)
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 77d50ea30b61..a40f7aa700b0 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -169,7 +169,8 @@ static void fuse_invalidate_entry(struct dentry *entry)
 }
 
 static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
-			     u64 nodeid, const struct qstr *name,
+			     u64 nodeid, struct inode *dir,
+			     const struct qstr *name,
 			     struct fuse_entry_out *outarg)
 {
 	args->opcode = FUSE_LOOKUP;
@@ -181,8 +182,20 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 	args->in_args[2].size = 1;
 	args->in_args[2].value = "";
 	args->out_numargs = 1;
-	args->out_args[0].size = sizeof(struct fuse_entry_out);
+	args->out_args[0].size = sizeof(*outarg) + outarg->fh.size;
 	args->out_args[0].value = outarg;
+
+	if (fc->lookup_handle && dir) {
+		struct fuse_inode *fi = get_fuse_inode(dir);
+
+		args->opcode = FUSE_LOOKUP_HANDLE;
+		if (fi && fi->fh) {
+			args->in_numargs = 4;
+			args->in_args[3].size = sizeof(*fi->fh) + fi->fh->size;
+			args->in_args[3].value = fi->fh;
+		}
+		args->out_argvar = true;
+	}
 }
 
 /*
@@ -240,7 +253,7 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 
 		attr_version = fuse_get_attr_version(fm->fc);
 
-		fuse_lookup_init(fm->fc, &args, get_node_id(dir),
+		fuse_lookup_init(fm->fc, &args, get_node_id(dir), dir,
 				 name, outarg);
 		ret = fuse_simple_request(fm, &args);
 		/* Zero nodeid is same as -ENOENT */
@@ -248,7 +261,8 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 			ret = -ENOENT;
 		if (!ret) {
 			fi = get_fuse_inode(inode);
-			if (outarg->nodeid != get_node_id(inode) ||
+			if (!fuse_file_handle_is_equal(fm->fc, fi->fh, &outarg->fh) ||
+			    outarg->nodeid != get_node_id(inode) ||
 			    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg->attr.flags & FUSE_ATTR_SUBMOUNT)) {
 				fuse_queue_forget(fm->fc, forget,
 						  outarg->nodeid, 1);
@@ -365,8 +379,9 @@ bool fuse_invalid_attr(struct fuse_attr *attr)
 	return !fuse_valid_type(attr->mode) || !fuse_valid_size(attr->size);
 }
 
-int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
-		     struct fuse_entry_out *outarg, struct inode **inode)
+int fuse_lookup_name(struct super_block *sb, u64 nodeid, struct inode *dir,
+		     const struct qstr *name, struct fuse_entry_out *outarg,
+		     struct inode **inode)
 {
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	FUSE_ARGS(args);
@@ -388,14 +403,15 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	attr_version = fuse_get_attr_version(fm->fc);
 	evict_ctr = fuse_get_evict_ctr(fm->fc);
 
-	fuse_lookup_init(fm->fc, &args, nodeid, name, outarg);
+	fuse_lookup_init(fm->fc, &args, nodeid, dir, name, outarg);
 	err = fuse_simple_request(fm, &args);
 	/* Zero nodeid is same as -ENOENT, but with valid timeout */
-	if (err || !outarg->nodeid)
+	if (err < 0 || !outarg->nodeid) // XXX err = size if args->out_argvar = true
 		goto out_put_forget;
 
 	err = -EIO;
-	if (fuse_invalid_attr(&outarg->attr))
+	if (fuse_invalid_attr(&outarg->attr) ||
+	    fuse_invalid_file_handle(fm->fc, &outarg->fh))
 		goto out_put_forget;
 	if (outarg->nodeid == FUSE_ROOT_ID && outarg->generation != 0) {
 		pr_warn_once("root generation should be zero\n");
@@ -404,7 +420,8 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 
 	*inode = fuse_iget(sb, outarg->nodeid, outarg->generation,
 			   &outarg->attr, ATTR_TIMEOUT(outarg),
-			   attr_version, evict_ctr);
+			   attr_version, evict_ctr,
+			   &outarg->fh);
 	err = -ENOMEM;
 	if (!*inode) {
 		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
@@ -440,14 +457,14 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 		return ERR_PTR(-ENOMEM);
 
 	locked = fuse_lock_inode(dir);
-	err = fuse_lookup_name(dir->i_sb, get_node_id(dir), &entry->d_name,
+	err = fuse_lookup_name(dir->i_sb, get_node_id(dir), dir, &entry->d_name,
 			       outarg, &inode);
 	fuse_unlock_inode(dir, locked);
 	if (err == -ENOENT) {
 		outarg_valid = false;
 		err = 0;
 	}
-	if (err)
+	if (err < 0) // XXX err = size if args->out_argvar = true
 		goto out_err;
 
 	err = -EIO;
@@ -688,8 +705,16 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
+	if (fm->fc->lookup_handle) {
+		fi = get_fuse_inode(dir);
+		if (fi->fh) {
+			args.in_numargs = 3;
+			args.in_args[2].size = sizeof(*fi->fh) + fi->fh->size;
+			args.in_args[3].value = fi->fh;
+		}
+	}
 	args.out_numargs = 2;
-	args.out_args[0].size = sizeof(*outentry);
+	args.out_args[0].size = sizeof(*outentry) + outentry->fh.size;
 	args.out_args[0].value = outentry;
 	/* Store outarg for fuse_finish_open() */
 	outopenp = &ff->args->open_outarg;
@@ -707,6 +732,7 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 
 	err = -EIO;
 	if (!S_ISREG(outentry->attr.mode) || invalid_nodeid(outentry->nodeid) ||
+	    fuse_invalid_file_handle(fm->fc, &outentry->fh) ||
 	    fuse_invalid_attr(&outentry->attr))
 		goto out_free_outentry;
 
@@ -714,7 +740,8 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	ff->nodeid = outentry->nodeid;
 	ff->open_flags = outopenp->open_flags;
 	inode = fuse_iget(dir->i_sb, outentry->nodeid, outentry->generation,
-			  &outentry->attr, ATTR_TIMEOUT(outentry), 0, 0);
+			  &outentry->attr, ATTR_TIMEOUT(outentry), 0, 0,
+			  &outentry->fh);
 	if (!inode) {
 		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
 		fuse_sync_release(NULL, ff, flags);
@@ -828,9 +855,21 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 		goto out_put_forget_req;
 	}
 
+	if (fm->fc->lookup_handle) {
+		struct fuse_inode *fi = get_fuse_inode(dir);
+		int idx = args->in_numargs;
+
+		WARN_ON_ONCE(idx >= 4);
+
+		if (fi->fh) {
+			args->in_args[idx].size = sizeof(*fi->fh) + fi->fh->size;
+			args->in_args[idx].value = fi->fh;
+			args->in_numargs++;
+		}
+	}
 	args->nodeid = get_node_id(dir);
 	args->out_numargs = 1;
-	args->out_args[0].size = sizeof(*outarg);
+	args->out_args[0].size = sizeof(*outarg) + outarg->fh.size;
 	args->out_args[0].value = outarg;
 
 	if (args->opcode != FUSE_LINK) {
@@ -845,14 +884,16 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 		goto out_free_outarg;
 
 	err = -EIO;
-	if (invalid_nodeid(outarg->nodeid) || fuse_invalid_attr(&outarg->attr))
+	if (invalid_nodeid(outarg->nodeid) || fuse_invalid_attr(&outarg->attr) ||
+	    fuse_invalid_file_handle(fm->fc, &outarg->fh))
 		goto out_free_outarg;
 
 	if ((outarg->attr.mode ^ mode) & S_IFMT)
 		goto out_free_outarg;
 
 	inode = fuse_iget(dir->i_sb, outarg->nodeid, outarg->generation,
-			  &outarg->attr, ATTR_TIMEOUT(outarg), 0, 0);
+			  &outarg->attr, ATTR_TIMEOUT(outarg), 0, 0,
+			  &outarg->fh);
 	if (!inode) {
 		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
 		kfree(outarg);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d997fdcede9b..ad9477394e4b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -216,6 +216,8 @@ struct fuse_inode {
 	 * so preserve the blocksize specified by the server.
 	 */
 	u8 cached_i_blkbits;
+
+	struct fuse_file_handle *fh;
 };
 
 /** FUSE inode state bits */
@@ -1065,6 +1067,26 @@ static inline int invalid_nodeid(u64 nodeid)
 	return !nodeid || nodeid == FUSE_ROOT_ID;
 }
 
+static inline bool fuse_invalid_file_handle(struct fuse_conn *fc,
+					    struct fuse_file_handle *handle)
+{
+	if (!fc->lookup_handle)
+		return false;
+
+	return !handle->size || (handle->size >= FUSE_MAX_HANDLE_SZ);
+}
+
+static inline bool fuse_file_handle_is_equal(struct fuse_conn *fc,
+					     struct fuse_file_handle *fh1,
+					     struct fuse_file_handle *fh2)
+{
+	if (!fc->lookup_handle || !fh2->size || // XXX more OPs without handle
+	    ((fh1->size == fh2->size) &&
+	     (!memcmp(fh1->handle, fh2->handle, fh1->size))))
+		return true;
+	return false;
+}
+
 static inline u64 fuse_get_attr_version(struct fuse_conn *fc)
 {
 	return atomic64_read(&fc->attr_version);
@@ -1096,7 +1118,10 @@ static inline struct fuse_entry_out *fuse_entry_out_alloc(struct fuse_conn *fc)
 {
 	struct fuse_entry_out *entryout;
 
-	entryout = kzalloc(sizeof(*entryout), GFP_KERNEL_ACCOUNT);
+	entryout = kzalloc(sizeof(*entryout) + fc->max_handle_sz,
+			   GFP_KERNEL_ACCOUNT);
+	if (entryout)
+		entryout->fh.size = fc->max_handle_sz;
 
 	return entryout;
 }
@@ -1143,10 +1168,11 @@ extern const struct dentry_operations fuse_dentry_operations;
 struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			int generation, struct fuse_attr *attr,
 			u64 attr_valid, u64 attr_version,
-			u64 evict_ctr);
+			u64 evict_ctr, struct fuse_file_handle *fh);
 
-int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
-		     struct fuse_entry_out *outarg, struct inode **inode);
+int fuse_lookup_name(struct super_block *sb, u64 nodeid, struct inode *dir,
+		     const struct qstr *name, struct fuse_entry_out *outarg,
+		     struct inode **inode);
 
 /**
  * Send FORGET command
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 30ee37c29057..23b8e4932da8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -95,6 +95,25 @@ static struct fuse_submount_lookup *fuse_alloc_submount_lookup(void)
 	return NULL;
 }
 
+/*
+ * XXX postpone this allocation and later use the real size instead of max
+ */
+static bool fuse_inode_handle_alloc(struct super_block *sb,
+				    struct fuse_inode *fi)
+{
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+
+	fi->fh = NULL;
+	if (fc->lookup_handle) {
+		fi->fh = kzalloc(sizeof(*fi->fh) + fc->max_handle_sz,
+				 GFP_KERNEL_ACCOUNT);
+		if (!fi->fh)
+			return false;
+	}
+
+	return true;
+}
+
 static struct inode *fuse_alloc_inode(struct super_block *sb)
 {
 	struct fuse_inode *fi;
@@ -120,8 +139,15 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		fuse_inode_backing_set(fi, NULL);
 
+	if (!fuse_inode_handle_alloc(sb, fi))
+		goto out_free_dax;
+
 	return &fi->inode;
 
+out_free_dax:
+#ifdef CONFIG_FUSE_DAX
+	kfree(fi->dax);
+#endif
 out_free_forget:
 	kfree(fi->forget);
 out_free:
@@ -132,6 +158,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 static void fuse_free_inode(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_conn *fc = get_fuse_conn(inode);
 
 	mutex_destroy(&fi->mutex);
 	kfree(fi->forget);
@@ -141,6 +168,9 @@ static void fuse_free_inode(struct inode *inode)
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		fuse_backing_put(fuse_inode_backing(fi));
 
+	if (fc->lookup_handle)
+		kfree(fi->fh);
+
 	kmem_cache_free(fuse_inode_cachep, fi);
 }
 
@@ -465,7 +495,7 @@ static int fuse_inode_set(struct inode *inode, void *_nodeidp)
 struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			int generation, struct fuse_attr *attr,
 			u64 attr_valid, u64 attr_version,
-			u64 evict_ctr)
+			u64 evict_ctr, struct fuse_file_handle *fh)
 {
 	struct inode *inode;
 	struct fuse_inode *fi;
@@ -505,14 +535,29 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	if (!inode)
 		return NULL;
 
+	fi = get_fuse_inode(inode);
+	if (fc->lookup_handle && fh->size) {
+		if (fi->fh->size == 0) {
+			if (fh->size >= fc->max_handle_sz)
+				pr_warn("Truncating file handle size (%u)\n",
+					fh->size);
+			fi->fh->size = fh->size < fc->max_handle_sz ?
+				fh->size : fc->max_handle_sz - 1;
+			memcpy(fi->fh->handle, fh->handle, fi->fh->size);
+		} else
+			pr_warn("handle was already set (size: %u)\n",
+				fi->fh->size);
+	}
 	if ((inode->i_state & I_NEW)) {
 		inode->i_flags |= S_NOATIME;
 		if (!fc->writeback_cache || !S_ISREG(attr->mode))
 			inode->i_flags |= S_NOCMTIME;
 		inode->i_generation = generation;
+
 		fuse_init_inode(inode, attr, fc);
 		unlock_new_inode(inode);
-	} else if (fuse_stale_inode(inode, generation, attr)) {
+	} else if (fuse_stale_inode(inode, generation, attr) ||
+		   !fuse_file_handle_is_equal(fc, fi->fh, fh)) {
 		/* nodeid was reused, any I/O on the old inode should fail */
 		fuse_make_bad(inode);
 		if (inode != d_inode(sb->s_root)) {
@@ -521,7 +566,6 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			goto retry;
 		}
 	}
-	fi = get_fuse_inode(inode);
 	spin_lock(&fi->lock);
 	fi->nlookup++;
 	spin_unlock(&fi->lock);
@@ -1059,12 +1103,23 @@ static struct inode *fuse_get_root_inode(struct super_block *sb, unsigned int mo
 	attr.mode = mode;
 	attr.ino = FUSE_ROOT_ID;
 	attr.nlink = 1;
-	return fuse_iget(sb, FUSE_ROOT_ID, 0, &attr, 0, 0, 0);
+	return fuse_iget(sb, FUSE_ROOT_ID, 0, &attr, 0, 0, 0, NULL); // XXX
 }
 
+enum {
+	HANDLE_TYPE_NODEID      = 0,
+	HANDLE_TYPE_HANDLE      = 1,
+};
+
 struct fuse_inode_handle {
-	u64 nodeid;
-	u32 generation;
+	u32 type;
+	union {
+		struct {
+			u64 nodeid;
+			u32 generation;
+		};
+		struct fuse_file_handle fh;
+	};
 };
 
 static struct dentry *fuse_get_dentry(struct super_block *sb,
@@ -1092,7 +1147,7 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 			goto out_err;
 		}
 
-		err = fuse_lookup_name(sb, handle->nodeid, &name, outarg,
+		err = fuse_lookup_name(sb, handle->nodeid, NULL, &name, outarg,
 				       &inode);
 		kfree(outarg);
 		if (err && err != -ENOENT)
@@ -1121,13 +1176,42 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 	return ERR_PTR(err);
 }
 
+static int fuse_encode_lookup_fh(struct inode *inode, u32 *fh, int *max_len,
+				 struct inode *parent)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	int total_len, len;
+
+	total_len = len = sizeof(struct fuse_file_handle);
+	if (parent)
+		total_len *= 2;
+
+	if (*max_len < total_len)
+		return FILEID_INVALID;
+
+	memcpy(fh, &fi->fh, len);
+	if (parent) {
+		fi = get_fuse_inode(parent);
+		memcpy((fh + len), &fi->fh, len);
+	}
+
+	*max_len = total_len;
+
+	/* XXX define new fid_type */
+	return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
+}
+
 static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 			   struct inode *parent)
 {
+	struct fuse_conn *fc = get_fuse_conn(inode);
 	int len = parent ? 6 : 3;
 	u64 nodeid;
 	u32 generation;
 
+	if (fc->lookup_handle)
+		return fuse_encode_lookup_fh(inode, fh, max_len, parent);
+
 	if (*max_len < len) {
 		*max_len = len;
 		return  FILEID_INVALID;
@@ -1156,30 +1240,51 @@ static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
 		struct fid *fid, int fh_len, int fh_type)
 {
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
 	struct fuse_inode_handle handle;
 
 	if ((fh_type != FILEID_INO64_GEN &&
 	     fh_type != FILEID_INO64_GEN_PARENT) || fh_len < 3)
 		return NULL;
 
-	handle.nodeid = (u64) fid->raw[0] << 32;
-	handle.nodeid |= (u64) fid->raw[1];
-	handle.generation = fid->raw[2];
+	if (fc->lookup_handle) {
+		if (fh_len < sizeof(struct fuse_file_handle))
+			return NULL;
+		handle.type = HANDLE_TYPE_HANDLE;
+		memcpy(&handle.fh, &fid->raw[0],
+		       sizeof(struct fuse_file_handle));
+	} else {
+		handle.nodeid = (u64) fid->raw[0] << 32;
+		handle.nodeid |= (u64) fid->raw[1];
+		handle.generation = fid->raw[2];
+	}
 	return fuse_get_dentry(sb, &handle);
 }
 
 static struct dentry *fuse_fh_to_parent(struct super_block *sb,
 		struct fid *fid, int fh_len, int fh_type)
 {
-	struct fuse_inode_handle parent;
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	struct fuse_inode_handle handle;
 
 	if (fh_type != FILEID_INO64_GEN_PARENT || fh_len < 6)
 		return NULL;
 
-	parent.nodeid = (u64) fid->raw[3] << 32;
-	parent.nodeid |= (u64) fid->raw[4];
-	parent.generation = fid->raw[5];
-	return fuse_get_dentry(sb, &parent);
+	if (fc->lookup_handle) {
+		struct fuse_file_handle *fh = (struct fuse_file_handle *)fid->raw;
+
+		if (fh_len < sizeof(struct fuse_file_handle) * 2)
+			return NULL;
+		handle.type = HANDLE_TYPE_HANDLE;
+		memcpy(&handle.fh, &fh[1],
+		       sizeof(struct fuse_file_handle));
+	} else {
+		handle.type = HANDLE_TYPE_NODEID;
+		handle.nodeid = (u64) fid->raw[3] << 32;
+		handle.nodeid |= (u64) fid->raw[4];
+		handle.generation = fid->raw[5];
+	}
+	return fuse_get_dentry(sb, &handle);
 }
 
 static struct dentry *fuse_get_parent(struct dentry *child)
@@ -1199,7 +1304,7 @@ static struct dentry *fuse_get_parent(struct dentry *child)
 		return ERR_PTR(-ENOMEM);
 
 	err = fuse_lookup_name(child_inode->i_sb, get_node_id(child_inode),
-			       &dotdot_name, outarg, &inode);
+			       child_inode, &dotdot_name, outarg, &inode);
 	kfree(outarg);
 	if (err) {
 		if (err == -ENOENT)
@@ -1757,7 +1862,7 @@ static int fuse_fill_super_submount(struct super_block *sb,
 
 	fuse_fill_attr_from_inode(&root_attr, parent_fi);
 	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0,
-			 fuse_get_evict_ctr(fm->fc));
+			 fuse_get_evict_ctr(fm->fc), NULL); // XXX
 	/*
 	 * This inode is just a duplicate, so it is not looked up and
 	 * its nlookup should not be incremented.  fuse_iget() does
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index c2aae2eef086..04fb6636c4c0 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -185,12 +185,12 @@ static int fuse_direntplus_link(struct file *file,
 			return 0;
 	}
 
-	if (invalid_nodeid(o->nodeid))
-		return -EIO;
-	if (fuse_invalid_attr(&o->attr))
+	fc = get_fuse_conn(dir);
+
+	if (invalid_nodeid(o->nodeid) || fuse_invalid_attr(&o->attr) ||
+	    fuse_invalid_file_handle(fc, &o->fh))
 		return -EIO;
 
-	fc = get_fuse_conn(dir);
 	epoch = atomic_read(&fc->epoch);
 
 	name.hash = full_name_hash(parent, name.name, name.len);
@@ -235,7 +235,7 @@ static int fuse_direntplus_link(struct file *file,
 	} else {
 		inode = fuse_iget(dir->i_sb, o->nodeid, o->generation,
 				  &o->attr, ATTR_TIMEOUT(o),
-				  attr_version, evict_ctr);
+				  attr_version, evict_ctr, &o->fh);
 		if (!inode)
 			inode = ERR_PTR(-ENOMEM);
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 4acf71b407c9..b75744d2d75d 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -690,6 +690,13 @@ enum fuse_notify_code {
 #define FUSE_MIN_READ_BUFFER 8192
 
 #define FUSE_COMPAT_ENTRY_OUT_SIZE 120
+#define FUSE_COMPAT_45_ENTRY_OUT_SIZE 128
+
+struct fuse_file_handle {
+	uint32_t	size;
+	uint32_t	type;
+	char		handle[0];
+};
 
 struct fuse_entry_out {
 	uint64_t	nodeid;		/* Inode ID */
@@ -700,6 +707,7 @@ struct fuse_entry_out {
 	uint32_t	entry_valid_nsec;
 	uint32_t	attr_valid_nsec;
 	struct fuse_attr attr;
+	struct fuse_file_handle fh;
 };
 
 struct fuse_forget_in {

