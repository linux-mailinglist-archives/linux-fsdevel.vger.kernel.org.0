Return-Path: <linux-fsdevel+bounces-79796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC8wL3ngrmmoJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 16:00:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8160623B27A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 16:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38B82301DD7E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C6B3D669F;
	Mon,  9 Mar 2026 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sBOTgUue"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FDF3B893B;
	Mon,  9 Mar 2026 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068398; cv=none; b=p3fzwkU4DQwTnvJ2ltsZQIbl0UiCckypn2gkE1ARG99ZI+pChf7827ozwzREulZz3xRkYYDx5PnTPfHf+HuQh1Uyuec+RdI42PKkubnFddrGglLp14/8yCUl/m7YsBzVJG9xQbxzWQNlSrfyk5Z+l7oZA/8Gn3tlQKyWBMlvye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068398; c=relaxed/simple;
	bh=56QCNUIk0XEtcctWIYK7RVR4ZCB/gk3djjdXJz6lL5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYGvFwMxfBNhFWeZWpJ7hyJPXztnZzSfMPQ+/jz/TnYDGzhXl6FqzwnhT7cDMa1TjbDJVf1nphWZZTFdz2phNtDPuJVVYCA1pg6rwFOIDTI01JXNi4sbnLhOiT3aFTcub9/bEHpdhypricA0yPy2mMPNNK7GlLKSzRzH1iwXFFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sBOTgUue; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YFR2+wTUKOX/tjCeEDeFCFdnA9fMladg6SnV0FhwTKs=; b=sBOTgUueANyxhiRa+khACArUns
	28go0SQAesvLmZnWOpVQMPY1I2Mb4IDZG7er8yTO1d5LdIvMrPlmdlXn5r1YwU34x8O+jEBQfr+J0
	qCBOI+K0e6pHCUdFhXnMkaig+7ajq2HYA0mWQjCY0UD2l4qcC+2o5CLHSVDjml3HvcTe8K/ekVUA9
	51wIBjXJf3ICQ+hRirwyVuqGze1MLERsGNuJfCtLPdQprVOYpL0d0jVUAGVnEmwowJcWs4RKxw+Nb
	2LrWheKdJxLtTjrPCnIRtQSfEj694oWtM1DYLl/jyVsBJRykRakXhS43Gn+Dti+Y/AKsSnH/E/PhF
	2g/6PXmw==;
Received: from bl21-120-186.dsl.telepac.pt ([2.82.120.186] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vzc5J-00C6BD-G0; Mon, 09 Mar 2026 15:59:53 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH 1/1] fuse: restructure requests extensions handling
Date: Mon,  9 Mar 2026 14:59:44 +0000
Message-ID: <20260309145944.40000-2-luis@igalia.com>
In-Reply-To: <20260309145944.40000-1-luis@igalia.com>
References: <20260309145944.40000-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8160623B27A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79796-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_SPAM(0.00)[0.055];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,igalia.com:mid,igalia.com:email]
X-Rspamd-Action: no action

This commit simplifies the implementation of extensions by using an
extensions vector just like the other (in/out) args.

This simplification includes reverting the handling of security contexts
back into a regular inarg, as it was done before commit 15d937d7ca8c
("fuse: add request extension").

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/dev.c    |  35 +++++++++++++++-
 fs/fuse/dir.c    | 104 +++++++++++++++++++++--------------------------
 fs/fuse/fuse_i.h |  11 ++++-
 3 files changed, 89 insertions(+), 61 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 0b0241f47170..5bf5f427a5c6 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -654,8 +654,15 @@ static void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
 	req->in.h.opcode = args->opcode;
 	req->in.h.nodeid = args->nodeid;
 	req->args = args;
-	if (args->is_ext)
-		req->in.h.total_extlen = args->in_args[args->ext_idx].size / 8;
+	if (args->has_ext) {
+		int i;
+
+		req->in.h.total_extlen =
+			sizeof(struct fuse_ext_header) * args->numext;
+		for (i = 0; i < args->numext; i++)
+			req->in.h.total_extlen += args->ext_args[i].size;
+		req->in.h.total_extlen /= 8;
+	}
 	if (args->end)
 		__set_bit(FR_ASYNC, &req->flags);
 }
@@ -1226,6 +1233,28 @@ int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 	return err;
 }
 
+static int fuse_copy_extensions(struct fuse_copy_state *cs,
+				struct fuse_args *args)
+{
+	struct fuse_ext_header xh;
+	struct fuse_ext_arg *arg;
+	int err = 0;
+	int i;
+
+	for (i = 0; !err && i < args->numext; i++) {
+		arg = &args->ext_args[i];
+		xh.size = arg->size;
+		xh.type = arg->type;
+		/* Copy extension header... */
+		err = fuse_copy_one(cs, &xh, sizeof(xh));
+		if (!err)
+			/* ... and payload */
+			err = fuse_copy_one(cs, arg->value, arg->size);
+	}
+
+	return err;
+}
+
 static int forget_pending(struct fuse_iqueue *fiq)
 {
 	return fiq->forget_list_head.next != NULL;
@@ -1497,6 +1526,8 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	if (!err)
 		err = fuse_copy_args(cs, args->in_numargs, args->in_pages,
 				     (struct fuse_arg *) args->in_args, 0);
+	if (!err)
+		err = fuse_copy_extensions(cs, args);
 	fuse_copy_finish(cs);
 	spin_lock(&fpq->lock);
 	clear_bit(FR_LOCKED, &req->flags);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 7ac6b232ef12..97a34de2a3df 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -711,26 +711,6 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 	return err;
 }
 
-static void *extend_arg(struct fuse_in_arg *buf, u32 bytes)
-{
-	void *p;
-	u32 newlen = buf->size + bytes;
-
-	p = krealloc(buf->value, newlen, GFP_KERNEL);
-	if (!p) {
-		kfree(buf->value);
-		buf->size = 0;
-		buf->value = NULL;
-		return NULL;
-	}
-
-	memset(p + buf->size, 0, bytes);
-	buf->value = p;
-	buf->size = newlen;
-
-	return p + newlen - bytes;
-}
-
 static u32 fuse_ext_size(size_t size)
 {
 	return FUSE_REC_ALIGN(sizeof(struct fuse_ext_header) + size);
@@ -739,67 +719,77 @@ static u32 fuse_ext_size(size_t size)
 /*
  * This adds just a single supplementary group that matches the parent's group.
  */
-static int get_create_supp_group(struct mnt_idmap *idmap,
-				 struct inode *dir,
-				 struct fuse_in_arg *ext)
+static int fuse_create_supp_group(struct mnt_idmap *idmap, struct inode *dir,
+				  struct fuse_args *args)
 {
 	struct fuse_conn *fc = get_fuse_conn(dir);
-	struct fuse_ext_header *xh;
+	struct fuse_ext_arg *extarg;
 	struct fuse_supp_groups *sg;
 	kgid_t kgid = dir->i_gid;
 	vfsgid_t vfsgid = make_vfsgid(idmap, fc->user_ns, kgid);
 	gid_t parent_gid = from_kgid(fc->user_ns, kgid);
-
 	u32 sg_len = fuse_ext_size(sizeof(*sg) + sizeof(sg->groups[0]));
 
-	if (parent_gid == (gid_t) -1 || vfsgid_eq_kgid(vfsgid, current_fsgid()) ||
+	if (parent_gid == (gid_t) -1 ||
+	    vfsgid_eq_kgid(vfsgid, current_fsgid()) ||
 	    !vfsgid_in_group_p(vfsgid))
 		return 0;
 
-	xh = extend_arg(ext, sg_len);
-	if (!xh)
-		return -ENOMEM;
-
-	xh->size = sg_len;
-	xh->type = FUSE_EXT_GROUPS;
+	BUG_ON(args->numext >= ARRAY_SIZE(args->ext_args));
 
-	sg = (struct fuse_supp_groups *) &xh[1];
+	sg = kzalloc(sg_len, GFP_KERNEL);
+	if (!sg)
+		return -ENOMEM;
 	sg->nr_groups = 1;
 	sg->groups[0] = parent_gid;
 
+	extarg = &args->ext_args[args->numext];
+	extarg->type = FUSE_EXT_GROUPS;
+	extarg->size = sg_len;
+	extarg->value = sg;
+	args->numext++;
+
 	return 0;
 }
 
-static int get_create_ext(struct mnt_idmap *idmap,
-			  struct fuse_args *args,
-			  struct inode *dir, struct dentry *dentry,
-			  umode_t mode)
+static int fuse_create_ext(struct mnt_idmap *idmap, struct fuse_args *args,
+			   struct inode *dir, struct dentry *dentry,
+			   umode_t mode)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(dentry->d_sb);
-	struct fuse_in_arg ext = { .size = 0, .value = NULL };
 	int err = 0;
 
-	if (fc->init_security)
-		err = get_security_context(dentry, mode, &ext);
-	if (!err && fc->create_supp_group)
-		err = get_create_supp_group(idmap, dir, &ext);
-
-	if (!err && ext.size) {
-		WARN_ON(args->in_numargs >= ARRAY_SIZE(args->in_args));
-		args->is_ext = true;
-		args->ext_idx = args->in_numargs++;
-		args->in_args[args->ext_idx] = ext;
-	} else {
-		kfree(ext.value);
+	/* security ctx isn't really an extension */
+	if (fc->init_security) {
+		/* XXX maybe the idx shouldn't be hard-coded...? */
+		WARN_ON(args->in_numargs != 2);
+		args->in_numargs = 3;
+		err = get_security_context(dentry, mode, &args->in_args[2]);
+		if (err)
+			return err;
 	}
+	if (fc->create_supp_group)
+		err = fuse_create_supp_group(idmap, dir, args);
+
+	if (!err)
+		args->has_ext = true;
+	else if (fc->init_security)
+		kfree(args->in_args[2].value);
 
 	return err;
 }
 
-static void free_ext_value(struct fuse_args *args)
+static void fuse_free_ext(struct fuse_conn *fc, struct fuse_args *args)
 {
-	if (args->is_ext)
-		kfree(args->in_args[args->ext_idx].value);
+	int i;
+
+	if (fc->init_security)
+		kfree(args->in_args[2].value);
+
+	for (i = 0; i < args->numext; i++)
+		kfree(args->ext_args[i].value);
+
+	args->has_ext = false;
 }
 
 /*
@@ -868,12 +858,12 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	args.out_args[1].size = sizeof(*outopenp);
 	args.out_args[1].value = outopenp;
 
-	err = get_create_ext(idmap, &args, dir, entry, mode);
+	err = fuse_create_ext(idmap, &args, dir, entry, mode);
 	if (err)
 		goto out_free_ff;
 
 	err = fuse_simple_idmap_request(idmap, fm, &args);
-	free_ext_value(&args);
+	fuse_free_ext(fm->fc, &args);
 	if (err)
 		goto out_free_ff;
 
@@ -995,13 +985,13 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 	args->out_args[0].value = &outarg;
 
 	if (args->opcode != FUSE_LINK) {
-		err = get_create_ext(idmap, args, dir, entry, mode);
+		err = fuse_create_ext(idmap, args, dir, entry, mode);
 		if (err)
 			goto out_put_forget_req;
 	}
 
 	err = fuse_simple_idmap_request(idmap, fm, args);
-	free_ext_value(args);
+	fuse_free_ext(fm->fc, args);
 	if (err)
 		goto out_put_forget_req;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d1..3bde38feae26 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -326,12 +326,18 @@ struct fuse_folio_desc {
 	unsigned int offset;
 };
 
+struct fuse_ext_arg {
+	unsigned int type;
+	unsigned int size;
+	void *value;
+};
+
 struct fuse_args {
 	uint64_t nodeid;
 	uint32_t opcode;
 	uint8_t in_numargs;
 	uint8_t out_numargs;
-	uint8_t ext_idx;
+	uint8_t numext;
 	bool force:1;
 	bool noreply:1;
 	bool nocreds:1;
@@ -342,10 +348,11 @@ struct fuse_args {
 	bool page_zeroing:1;
 	bool page_replace:1;
 	bool may_block:1;
-	bool is_ext:1;
+	bool has_ext:1;
 	bool is_pinned:1;
 	bool invalidate_vmap:1;
 	struct fuse_in_arg in_args[4];
+	struct fuse_ext_arg ext_args[2];
 	struct fuse_arg out_args[2];
 	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
 	/* Used for kvec iter backed by vmalloc address */

