Return-Path: <linux-fsdevel+bounces-78352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KQHHGbcnmkTXgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:26:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05B196717
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 186C1302F23D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 11:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6741A394488;
	Wed, 25 Feb 2026 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ix7h34B6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07744393DD7;
	Wed, 25 Feb 2026 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018721; cv=none; b=mhqENyvUdlh65FIqdyD9FFNr+Jq5vC2QStdJra4dtXU+Jj5aKM8dXogcIYcgIiHqjXn/8AgZGvNABoICoUbxxmFWDxT28CM/vh9HGATpr4dNnteq4gadX5/iDqiRlEs3iCXAVFfALK4VUA5eXZKumXW8UovQ+4a/hhdy9ocaiI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018721; c=relaxed/simple;
	bh=SZpEzGASG+jZt+3SH49zDeqrkrwd3N0OJ7XZE6e/Fm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRz0SVDvZjR4lFjB7GfFbWZjnti20I1YBbKC18yXiYzi8Zlt0D6aO//feJoqEFjFVdxuKQJ4prO4xCmzohpRtAMNdwGAjMI5I6CVhwCxyiHQ/erXTkSt3WnMOKsvAQmA7Gil64fYJhbYoU/jc9HiNaS32Eqz3a7Tg5pl0+YIXus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ix7h34B6; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2RFtJyoFXoB2y5CfcGqDjmIY95EdGt03PAMHowDwl9M=; b=ix7h34B61QPCnsQBsi/e/CVxJK
	TvzBDKXyUIR4BiksWQQyiQJdOvTK+2waJJEgk/XAIJYd0HkkwUn4k/qpnzDINZnY/16oXsrKS8e/o
	os7tOCzmrgYijPHp4a8xyYBXg4o9KSWwkkE7WMvfl9J2zGUghCzLmljSFs9CTvkCfboB4rlMgALwC
	oSRx5/suP5nOSHbEYfAElbJhUaFY2H+g45goDsratWvaNTFQnKK8IJvR4qIoejIKtkGyagAqedQRs
	Bsfd8/wXziFQWyOdD0UGTeSVDhr5YqyM/UhSkqxmb0Gm4qgQK9tZT2v8LI4SF3jDt56KwpR4PmVR6
	8PJs62tQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vvD0q-005Cmt-Av; Wed, 25 Feb 2026 12:25:04 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Kevin Chen <kchen@ddn.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v3 6/8] fuse: implementation of lookup_handle+statx compound operation
Date: Wed, 25 Feb 2026 11:24:37 +0000
Message-ID: <20260225112439.27276-7-luis@igalia.com>
In-Reply-To: <20260225112439.27276-1-luis@igalia.com>
References: <20260225112439.27276-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78352-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[szeredi.hu,gmail.com,ddn.com,bsbernd.com,kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,igalia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D05B196717
X-Rspamd-Action: no action

The implementation of lookup_handle+statx compound operation extends the
lookup operation so that a file handle is be passed into the kernel.  It
also needs to include an extra inarg, so that the parent directory file
handle can be sent to user-space.  This extra inarg is added as an extension
header to the request.

By having a separate statx including in a compound operation allows the
attr to be dropped from the lookup_handle request, simplifying the
traditional FUSE lookup operation.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/dir.c             | 294 +++++++++++++++++++++++++++++++++++---
 fs/fuse/fuse_i.h          |  23 ++-
 fs/fuse/inode.c           |  48 +++++--
 fs/fuse/readdir.c         |   2 +-
 include/uapi/linux/fuse.h |  23 ++-
 5 files changed, 355 insertions(+), 35 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5c0f1364c392..7fa8c405f1a3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -21,6 +21,7 @@
 #include <linux/security.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/exportfs.h>
 
 static bool __read_mostly allow_sys_admin_access;
 module_param(allow_sys_admin_access, bool, 0644);
@@ -372,6 +373,47 @@ static void fuse_lookup_init(struct fuse_args *args, u64 nodeid,
 	args->out_args[0].value = outarg;
 }
 
+static int do_lookup_handle_statx(struct fuse_mount *fm, u64 parent_nodeid,
+				  struct inode *parent_inode,
+				  const struct qstr *name,
+				  struct fuse_entry2_out *lookup_out,
+				  struct fuse_statx_out *statx_out,
+				  struct fuse_file_handle **fh);
+static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr);
+static int do_reval_lookup(struct fuse_mount *fm, u64 parent_nodeid,
+			   const struct qstr *name, u64 *nodeid,
+			   u64 *generation, u64 *attr_valid,
+			   struct fuse_attr *attr, struct fuse_file_handle **fh)
+{
+	struct fuse_entry_out entry_out;
+	struct fuse_entry2_out lookup_out;
+	struct fuse_statx_out statx_out;
+	FUSE_ARGS(lookup_args);
+	int ret = 0;
+
+	if (fm->fc->lookup_handle) {
+		ret = do_lookup_handle_statx(fm, parent_nodeid, NULL, name,
+					     &lookup_out, &statx_out, fh);
+		if (!ret) {
+			*nodeid = lookup_out.nodeid;
+			*generation = lookup_out.generation;
+			*attr_valid = fuse_time_to_jiffies(lookup_out.entry_valid,
+							   lookup_out.entry_valid_nsec);
+			fuse_statx_to_attr(&statx_out.stat, attr);
+		}
+	} else {
+		fuse_lookup_init(&lookup_args, parent_nodeid, name, &entry_out);
+		ret = fuse_simple_request(fm, &lookup_args);
+		if (!ret) {
+			*nodeid = entry_out.nodeid;
+			*generation = entry_out.generation;
+			*attr_valid = ATTR_TIMEOUT(&entry_out);
+			memcpy(attr, &entry_out.attr, sizeof(*attr));
+		}
+	}
+
+	return ret;
+}
 /*
  * Check whether the dentry is still valid
  *
@@ -399,10 +441,11 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 		goto invalid;
 	else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
 		 (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TARGET))) {
-		struct fuse_entry_out outarg;
-		FUSE_ARGS(args);
 		struct fuse_forget_link *forget;
+		struct fuse_file_handle *fh = NULL;
 		u64 attr_version;
+		u64 nodeid, generation, attr_valid;
+		struct fuse_attr attr;
 
 		/* For negative dentries, always do a fresh lookup */
 		if (!inode)
@@ -421,35 +464,36 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 
 		attr_version = fuse_get_attr_version(fm->fc);
 
-		fuse_lookup_init(&args, get_node_id(dir), name, &outarg);
-		ret = fuse_simple_request(fm, &args);
+		ret = do_reval_lookup(fm, get_node_id(dir), name, &nodeid,
+				      &generation, &attr_valid, &attr, &fh);
 		/* Zero nodeid is same as -ENOENT */
-		if (!ret && !outarg.nodeid)
+		if (!ret && !nodeid)
 			ret = -ENOENT;
 		if (!ret) {
 			fi = get_fuse_inode(inode);
-			if (outarg.nodeid != get_node_id(inode) ||
-			    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg.attr.flags & FUSE_ATTR_SUBMOUNT)) {
-				fuse_queue_forget(fm->fc, forget,
-						  outarg.nodeid, 1);
+			if (!fuse_file_handle_is_equal(fm->fc, fi->fh, fh) ||
+			    nodeid != get_node_id(inode) ||
+			    (bool) IS_AUTOMOUNT(inode) != (bool) (attr.flags & FUSE_ATTR_SUBMOUNT)) {
+				fuse_queue_forget(fm->fc, forget, nodeid, 1);
+				kfree(fh);
 				goto invalid;
 			}
 			spin_lock(&fi->lock);
 			fi->nlookup++;
 			spin_unlock(&fi->lock);
 		}
+		kfree(fh);
 		kfree(forget);
 		if (ret == -ENOMEM || ret == -EINTR)
 			goto out;
-		if (ret || fuse_invalid_attr(&outarg.attr) ||
-		    fuse_stale_inode(inode, outarg.generation, &outarg.attr))
+		if (ret || fuse_invalid_attr(&attr) ||
+		    fuse_stale_inode(inode, generation, &attr))
 			goto invalid;
 
 		forget_all_cached_acls(inode);
-		fuse_change_attributes(inode, &outarg.attr, NULL,
-				       ATTR_TIMEOUT(&outarg),
+		fuse_change_attributes(inode, &attr, NULL, attr_valid,
 				       attr_version);
-		fuse_change_entry_timeout(entry, &outarg);
+		fuse_dentry_settime(entry, attr_valid);
 	} else if (inode) {
 		fi = get_fuse_inode(inode);
 		if (flags & LOOKUP_RCU) {
@@ -546,8 +590,215 @@ bool fuse_invalid_attr(struct fuse_attr *attr)
 	return !fuse_valid_type(attr->mode) || !fuse_valid_size(attr->size);
 }
 
-int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
-		     u64 *time, struct inode **inode)
+static int create_ext_handle(struct fuse_in_arg *ext, struct fuse_inode *fi)
+{
+	struct fuse_ext_header *xh;
+	struct fuse_file_handle *fh;
+	u32 len;
+
+	len = fuse_ext_size(sizeof(*fi->fh) + fi->fh->size);
+	xh = fuse_extend_arg(ext, len);
+	if (!xh)
+		return -ENOMEM;
+
+	xh->size = len;
+	xh->type = FUSE_EXT_HANDLE;
+	fh = (struct fuse_file_handle *)&xh[1];
+	fh->size = fi->fh->size;
+	memcpy(fh->handle, fi->fh->handle, fh->size);
+
+	return 0;
+}
+
+static int fuse_lookup_handle_init(struct fuse_args *args, u64 nodeid,
+				   struct fuse_inode *fi,
+				   const struct qstr *name,
+				   struct fuse_entry2_out *outarg)
+{
+	struct fuse_file_handle *fh;
+	size_t fh_size = sizeof(*fh) + MAX_HANDLE_SZ;
+	int ret = -ENOMEM;
+
+	fh = kzalloc(fh_size, GFP_KERNEL);
+	if (!fh)
+		return ret;
+
+	memset(outarg, 0, sizeof(struct fuse_entry2_out));
+	args->opcode = FUSE_LOOKUP_HANDLE;
+	args->nodeid = nodeid;
+	args->in_numargs = 3;
+	fuse_set_zero_arg0(args);
+	args->in_args[1].size = name->len;
+	args->in_args[1].value = name->name;
+	args->in_args[2].size = 1;
+	args->in_args[2].value = "";
+	if (fi && fi->fh) {
+		args->is_ext = true;
+		args->ext_idx = args->in_numargs++;
+		args->in_args[args->ext_idx].size = 0;
+		ret = create_ext_handle(&args->in_args[args->ext_idx], fi);
+		if (ret) {
+			kfree(fh);
+			return ret;
+		}
+	}
+	args->out_numargs = 2;
+	args->out_argvar = true;
+	args->out_argvar_idx = 1;
+	args->out_args[0].size = sizeof(struct fuse_entry2_out);
+	args->out_args[0].value = outarg;
+
+	/* XXX do allocation to the actual size of the handle */
+	args->out_args[1].size = fh_size;
+	args->out_args[1].value = fh;
+
+	return 0;
+}
+
+static void fuse_req_free_argvar_ext(struct fuse_args *args)
+{
+	if (args->out_argvar)
+		kfree(args->out_args[args->out_argvar_idx].value);
+	if (args->is_ext)
+		kfree(args->in_args[args->ext_idx].value);
+}
+
+static void fuse_statx_init(struct fuse_args *args, struct fuse_statx_in *inarg,
+			    u64 nodeid, struct fuse_file *ff,
+			    struct fuse_statx_out *outarg);
+static int fuse_statx_update(struct mnt_idmap *idmap,
+			     struct fuse_statx_out *outarg, struct inode *inode,
+			     u64 attr_version, struct kstat *stat);
+static int do_lookup_handle_statx(struct fuse_mount *fm, u64 parent_nodeid,
+				  struct inode *parent_inode,
+				  const struct qstr *name,
+				  struct fuse_entry2_out *lookup_out,
+				  struct fuse_statx_out *statx_out,
+				  struct fuse_file_handle **fh)
+{
+	struct fuse_compound_req *compound;
+	struct fuse_inode *fi = NULL;
+	struct fuse_statx_in statx_in;
+	FUSE_ARGS(lookup_args);
+	FUSE_ARGS(statx_args);
+	int ret;
+
+	if (parent_inode)
+		fi = get_fuse_inode(parent_inode);
+
+	compound = fuse_compound_alloc(fm, 0);
+	if (!compound)
+		return -ENOMEM;
+
+	ret = fuse_lookup_handle_init(&lookup_args, parent_nodeid, fi,
+				      name, lookup_out);
+	if (ret)
+		goto out_compound;
+
+	ret = fuse_compound_add(compound, &lookup_args);
+	if (ret)
+		goto out_args;
+
+	/*
+	 * XXX nodeid is the parent of the inode we want! At this point
+	 * we still don't have the nodeid.  Using FUSE_ROOT_ID for now.
+	 */
+	fuse_statx_init(&statx_args, &statx_in, FUSE_ROOT_ID, NULL, statx_out);
+	ret = fuse_compound_add(compound, &statx_args);
+	if (ret)
+		goto out_args;
+
+	ret = fuse_compound_send(compound);
+	if (ret)
+		goto out_args;
+
+	ret = fuse_compound_get_error(compound, 0);
+	if (ret || !lookup_out->nodeid)
+		goto out_args;
+	if (lookup_out->nodeid == FUSE_ROOT_ID &&
+	    lookup_out->generation != 0) {
+		pr_warn_once("root generation should be zero\n");
+		lookup_out->generation = 0;
+	}
+	if ((lookup_args.out_args[1].size > 0) &&
+	    (lookup_args.out_args[1].value)) {
+		struct fuse_file_handle *h = lookup_args.out_args[1].value;
+
+		*fh = kzalloc(sizeof(*fh) + h->size, GFP_KERNEL);
+		if (!*fh) {
+			ret = -ENOMEM;
+			goto out_args;
+		}
+		(*fh)->size = h->size;
+		memcpy((*fh)->handle, h->handle, (*fh)->size);
+	}
+
+	ret = fuse_compound_get_error(compound, 1);
+	if (ret) {
+		kfree(*fh);
+		*fh = NULL;
+	}
+
+out_args:
+	fuse_req_free_argvar_ext(&lookup_args);
+out_compound:
+	kfree(compound);
+
+	return ret;
+}
+
+static int fuse_lookup_handle_name(struct super_block *sb, u64 nodeid,
+				   struct inode *dir, const struct qstr *name,
+				   u64 *time, struct inode **inode)
+{
+	struct fuse_mount *fm = get_fuse_mount_super(sb);
+	struct fuse_file_handle *fh = NULL;
+	struct fuse_entry2_out lookup_out;
+	struct fuse_statx_out statx_out;
+	struct fuse_attr attr;
+	struct fuse_forget_link *forget;
+	u64 attr_version, evict_ctr;
+	int ret;
+
+	forget = fuse_alloc_forget();
+	if (!forget)
+		return -ENOMEM;
+
+	attr_version = fuse_get_attr_version(fm->fc);
+	evict_ctr = fuse_get_evict_ctr(fm->fc);
+
+	ret = do_lookup_handle_statx(fm, nodeid, dir, name, &lookup_out,
+				     &statx_out, &fh);
+	if (ret)
+		goto out_forget;
+
+	fuse_statx_to_attr(&statx_out.stat, &attr);
+	WARN_ON(fuse_invalid_attr(&attr));
+
+	*inode = fuse_iget(sb, lookup_out.nodeid, lookup_out.generation,
+			   &attr, ATTR_TIMEOUT(&statx_out),
+			   attr_version, evict_ctr, fh);
+	ret = -ENOMEM;
+	if (!*inode) {
+		fuse_queue_forget(fm->fc, forget, lookup_out.nodeid, 1);
+		goto out_forget;
+	}
+	if (time)
+		*time = fuse_time_to_jiffies(lookup_out.entry_valid,
+					     lookup_out.entry_valid_nsec);
+
+	/* XXX idmap? */
+	ret = fuse_statx_update(&nop_mnt_idmap, &statx_out, *inode,
+				attr_version, NULL);
+
+out_forget:
+	kfree(forget);
+
+	return ret;
+}
+
+int fuse_lookup_name(struct super_block *sb, u64 nodeid, struct inode *dir,
+		     const struct qstr *name, u64 *time, struct inode **inode)
 {
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	FUSE_ARGS(args);
@@ -561,6 +812,9 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	if (name->len > fm->fc->name_max)
 		goto out;
 
+	if (fm->fc->lookup_handle)
+		return fuse_lookup_handle_name(sb, nodeid, dir, name, time,
+					       inode);
 
 	forget = fuse_alloc_forget();
 	err = -ENOMEM;
@@ -586,7 +840,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 
 	*inode = fuse_iget(sb, outarg.nodeid, outarg.generation,
 			   &outarg.attr, ATTR_TIMEOUT(&outarg),
-			   attr_version, evict_ctr);
+			   attr_version, evict_ctr, NULL);
 	err = -ENOMEM;
 	if (!*inode) {
 		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
@@ -621,7 +875,7 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 	epoch = atomic_read(&fc->epoch);
 
 	locked = fuse_lock_inode(dir);
-	err = fuse_lookup_name(dir->i_sb, get_node_id(dir), &entry->d_name,
+	err = fuse_lookup_name(dir->i_sb, get_node_id(dir), dir, &entry->d_name,
 			       &time, &inode);
 	fuse_unlock_inode(dir, locked);
 	if (err == -ENOENT)
@@ -882,7 +1136,7 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	ff->nodeid = outentry.nodeid;
 	ff->open_flags = outopenp->open_flags;
 	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
-			  &outentry.attr, ATTR_TIMEOUT(&outentry), 0, 0);
+			  &outentry.attr, ATTR_TIMEOUT(&outentry), 0, 0, NULL);
 	if (!inode) {
 		flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
 		fuse_sync_release(NULL, ff, flags);
@@ -1009,7 +1263,7 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 		goto out_put_forget_req;
 
 	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
-			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0, 0);
+			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0, 0, NULL);
 	if (!inode) {
 		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
 		return ERR_PTR(-ENOMEM);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 04f09e2ccfd0..173032887fc2 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -223,6 +223,8 @@ struct fuse_inode {
 	 * so preserve the blocksize specified by the server.
 	 */
 	u8 cached_i_blkbits;
+
+	struct fuse_file_handle *fh;
 };
 
 /** FUSE inode state bits */
@@ -923,6 +925,9 @@ struct fuse_conn {
 	/* Is synchronous FUSE_INIT allowed? */
 	unsigned int sync_init:1;
 
+	/** Is LOOKUP_HANDLE implemented by the fs? */
+	unsigned int lookup_handle:1;
+
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
@@ -1072,6 +1077,18 @@ static inline int invalid_nodeid(u64 nodeid)
 	return !nodeid || nodeid == FUSE_ROOT_ID;
 }
 
+static inline bool fuse_file_handle_is_equal(struct fuse_conn *fc,
+					     struct fuse_file_handle *fh1,
+					     struct fuse_file_handle *fh2)
+{
+	if (!fc->lookup_handle ||
+	    ((fh1 == fh2) && !fh1) || /* both NULL */
+	    (fh1 && fh2 && (fh1->size == fh2->size) &&
+	     (!memcmp(fh1->handle, fh2->handle, fh1->size))))
+		return true;
+	return false;
+}
+
 static inline u64 fuse_get_attr_version(struct fuse_conn *fc)
 {
 	return atomic64_read(&fc->attr_version);
@@ -1148,10 +1165,10 @@ extern const struct dentry_operations fuse_dentry_operations;
 struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			int generation, struct fuse_attr *attr,
 			u64 attr_valid, u64 attr_version,
-			u64 evict_ctr);
+			u64 evict_ctr, struct fuse_file_handle *fh);
 
-int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
-		     u64 *time, struct inode **inode);
+int fuse_lookup_name(struct super_block *sb, u64 nodeid, struct inode *dir,
+		     const struct qstr *name, u64 *time, struct inode **inode);
 
 /**
  * Send FORGET command
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 006436a3ad06..9f2c0c9e877c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -120,6 +120,8 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		fuse_inode_backing_set(fi, NULL);
 
+	fi->fh = NULL;
+
 	return &fi->inode;
 
 out_free_forget:
@@ -141,6 +143,8 @@ static void fuse_free_inode(struct inode *inode)
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		fuse_backing_put(fuse_inode_backing(fi));
 
+	kfree(fi->fh);
+
 	kmem_cache_free(fuse_inode_cachep, fi);
 }
 
@@ -465,7 +469,7 @@ static int fuse_inode_set(struct inode *inode, void *_nodeidp)
 struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			int generation, struct fuse_attr *attr,
 			u64 attr_valid, u64 attr_version,
-			u64 evict_ctr)
+			u64 evict_ctr, struct fuse_file_handle *fh)
 {
 	struct inode *inode;
 	struct fuse_inode *fi;
@@ -505,6 +509,26 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	if (!inode)
 		return NULL;
 
+	fi = get_fuse_inode(inode);
+	if (fc->lookup_handle && !fi->fh) {
+		if (!fh && (nodeid != FUSE_ROOT_ID)) {
+			pr_err("NULL file handle for nodeid %llu\n", nodeid);
+			WARN_ON_ONCE(1);
+		} else {
+			size_t sz = sizeof(struct fuse_file_handle);
+
+			if (fh)
+				sz += fh->size;
+
+			fi->fh = kzalloc(sz, GFP_KERNEL);
+			if (!fi->fh) {
+				iput(inode);
+				return NULL; // ENOMEM
+			}
+			if (fh)
+				memcpy(fi->fh, fh, sz);
+		}
+	}
 	if ((inode_state_read_once(inode) & I_NEW)) {
 		inode->i_flags |= S_NOATIME;
 		if (!fc->writeback_cache || !S_ISREG(attr->mode))
@@ -512,7 +536,8 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 		inode->i_generation = generation;
 		fuse_init_inode(inode, attr, fc);
 		unlock_new_inode(inode);
-	} else if (fuse_stale_inode(inode, generation, attr)) {
+	} else if (fuse_stale_inode(inode, generation, attr) ||
+		   (!fuse_file_handle_is_equal(fc, fi->fh, fh))) {
 		/* nodeid was reused, any I/O on the old inode should fail */
 		fuse_make_bad(inode);
 		if (inode != d_inode(sb->s_root)) {
@@ -521,7 +546,6 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			goto retry;
 		}
 	}
-	fi = get_fuse_inode(inode);
 	spin_lock(&fi->lock);
 	fi->nlookup++;
 	spin_unlock(&fi->lock);
@@ -1068,7 +1092,7 @@ static struct inode *fuse_get_root_inode(struct super_block *sb, unsigned int mo
 	attr.mode = mode;
 	attr.ino = FUSE_ROOT_ID;
 	attr.nlink = 1;
-	return fuse_iget(sb, FUSE_ROOT_ID, 0, &attr, 0, 0, 0);
+	return fuse_iget(sb, FUSE_ROOT_ID, 0, &attr, 0, 0, 0, NULL);
 }
 
 struct fuse_inode_handle {
@@ -1094,7 +1118,8 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 		if (!fc->export_support)
 			goto out_err;
 
-		err = fuse_lookup_name(sb, handle->nodeid, &name, NULL, &inode);
+		err = fuse_lookup_name(sb, handle->nodeid, NULL, &name, NULL,
+				       &inode);
 		if (err && err != -ENOENT)
 			goto out_err;
 		if (err || !inode) {
@@ -1115,9 +1140,9 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 
 	return entry;
 
- out_iput:
+out_iput:
 	iput(inode);
- out_err:
+out_err:
 	return ERR_PTR(err);
 }
 
@@ -1194,7 +1219,7 @@ static struct dentry *fuse_get_parent(struct dentry *child)
 		return ERR_PTR(-ESTALE);
 
 	err = fuse_lookup_name(child_inode->i_sb, get_node_id(child_inode),
-			       &dotdot_name, NULL, &inode);
+			       child_inode, &dotdot_name, NULL, &inode);
 	if (err) {
 		if (err == -ENOENT)
 			return ERR_PTR(-ESTALE);
@@ -1459,6 +1484,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 			if (flags & FUSE_REQUEST_TIMEOUT)
 				timeout = arg->request_timeout;
+
+			if (flags & FUSE_HAS_LOOKUP_HANDLE)
+				fc->lookup_handle = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1509,7 +1537,7 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
 		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP |
-		FUSE_REQUEST_TIMEOUT;
+		FUSE_REQUEST_TIMEOUT | FUSE_LOOKUP_HANDLE;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
@@ -1745,7 +1773,7 @@ static int fuse_fill_super_submount(struct super_block *sb,
 
 	fuse_fill_attr_from_inode(&root_attr, parent_fi);
 	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0,
-			 fuse_get_evict_ctr(fm->fc));
+			 fuse_get_evict_ctr(fm->fc), NULL);
 	/*
 	 * This inode is just a duplicate, so it is not looked up and
 	 * its nlookup should not be incremented.  fuse_iget() does
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index c2aae2eef086..2b59a196bcbf 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -235,7 +235,7 @@ static int fuse_direntplus_link(struct file *file,
 	} else {
 		inode = fuse_iget(dir->i_sb, o->nodeid, o->generation,
 				  &o->attr, ATTR_TIMEOUT(o),
-				  attr_version, evict_ctr);
+				  attr_version, evict_ctr, NULL);
 		if (!inode)
 			inode = ERR_PTR(-ENOMEM);
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 113583c4efb6..89e6176abe25 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -240,6 +240,9 @@
  *  - add FUSE_COPY_FILE_RANGE_64
  *  - add struct fuse_copy_file_range_out
  *  - add FUSE_NOTIFY_PRUNE
+ *
+ *  7.46
+ *  - add FUSE_LOOKUP_HANDLE
  */
 
 #ifndef _LINUX_FUSE_H
@@ -275,7 +278,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 45
+#define FUSE_KERNEL_MINOR_VERSION 46
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -495,6 +498,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
+#define FUSE_HAS_LOOKUP_HANDLE	(1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags
@@ -609,6 +613,7 @@ enum fuse_ext_type {
 	/* Types 0..31 are reserved for fuse_secctx_header */
 	FUSE_MAX_NR_SECCTX	= 31,
 	FUSE_EXT_GROUPS		= 32,
+	FUSE_EXT_HANDLE		= 33,
 };
 
 enum fuse_opcode {
@@ -671,6 +676,8 @@ enum fuse_opcode {
 	 */
 	FUSE_COMPOUND		= 54,
 
+	FUSE_LOOKUP_HANDLE	= 55,
+
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
 
@@ -707,6 +714,20 @@ struct fuse_entry_out {
 	struct fuse_attr attr;
 };
 
+struct fuse_entry2_out {
+	uint64_t	nodeid;
+	uint64_t	generation;
+	uint64_t	entry_valid;
+	uint32_t	entry_valid_nsec;
+	uint32_t	flags;
+	uint64_t	spare;
+};
+
+struct fuse_file_handle {
+	uint16_t	size;
+	uint8_t		handle[];
+};
+
 struct fuse_forget_in {
 	uint64_t	nlookup;
 };

