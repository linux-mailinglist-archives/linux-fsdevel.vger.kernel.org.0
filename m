Return-Path: <linux-fsdevel+bounces-71209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03529CB9870
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 19:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D53D301502E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 18:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F582FB61B;
	Fri, 12 Dec 2025 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kEVy5Y3Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C192F6913;
	Fri, 12 Dec 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765563198; cv=none; b=RIyxBU8A+THt4Lp+CC//mfkLVzS1DqCGlX4OgVpxveDVna3X7ivzFLHtOYsuY5wFHJdaCzTaRD+ajhJ7tnqUqxhZ3c82lZsykiBxNKipNa5k4aYhQyzFatTwmFK5+xPrfegAJv6KH2NVvdhWJZCpSvYPPs5FUBg0kA1/OmdKjfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765563198; c=relaxed/simple;
	bh=U0padkSIi7nWVb5z/h/gvl9qH1RnLQWyvgJI6ouZN1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HV6rODNq0oX2N0XSDgEkZfOnAKqfajtKOBl3iQDm8s7eSQm2Ocr+Sppc5w3ekcRuSiVWtZm27s5OkXEFF4NAkAiTNr9viNxwhbcwrE19eofXPHYQT/6iyxhepNuprIQfrqOxFcsPFvX4uuBWClRKyZT91s+SH2bh6UnSMs1dZVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kEVy5Y3Y; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5Rhscirf1twEkqup/yuNBQoBsWNxHoN+tCBpQDRwCkg=; b=kEVy5Y3Yl2HfzRnnm/or6SBWvN
	Xcq1sMtE8hYM6G+67TP8ioayeToGY6pab+a61dutoMfbeIqSChKNPpEkzd1R25coOSPpHCOrQf/n/
	FSq0sjjuiaxjG2q51O4PBzoEB3a5+Ra9dhqTcHFQN3aMqVpfMzJQr6ql2kSni+TDUcpzBawtVS3C/
	Lonwv71KnWJkYOsjC0oeJnqEraVzpWpUfiIgBzQ4rE884xOFsFh4LZGl5/jI2hv9xzZWnC/eC6HeI
	AFN7J/yQV+BrvKTg4nXhBhuq12+FJeEXpzeLAzlPImKZ+Ab3WCaL+FepbVSJpFN6FNPKswE0bx6FQ
	5XIVNMhA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vU7dT-00C79Q-Gr; Fri, 12 Dec 2025 19:12:59 +0100
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
Subject: [RFC PATCH v2 5/6] fuse: factor out NFS export related code
Date: Fri, 12 Dec 2025 18:12:53 +0000
Message-ID: <20251212181254.59365-6-luis@igalia.com>
In-Reply-To: <20251212181254.59365-1-luis@igalia.com>
References: <20251212181254.59365-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move all the NFS-related code into a different file.  This is just
preparatory work to be able to use the LOOKUP_HANDLE file handles as the NFS
handles.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/Makefile |   2 +-
 fs/fuse/dir.c    |   1 +
 fs/fuse/export.c | 174 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h |   6 ++
 fs/fuse/inode.c  | 167 +--------------------------------------------
 5 files changed, 183 insertions(+), 167 deletions(-)
 create mode 100644 fs/fuse/export.c

diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 22ad9538dfc4..1d1401658278 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
 fuse-y := trace.o	# put trace.o first so we see ftrace errors sooner
 fuse-y += dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
-fuse-y += iomode.o
+fuse-y += iomode.o export.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
 fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o backing.o
 fuse-$(CONFIG_SYSCTL) += sysctl.o
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index a6edb444180f..a885f1dc61eb 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -190,6 +190,7 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 
 		args->opcode = FUSE_LOOKUP_HANDLE;
 		args->out_argvar = true;
+		args->out_argvar_idx = 0;
 
 		if (dir)
 			fi = get_fuse_inode(dir);
diff --git a/fs/fuse/export.c b/fs/fuse/export.c
new file mode 100644
index 000000000000..4a9c95fe578e
--- /dev/null
+++ b/fs/fuse/export.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FUSE NFS export support.
+ *
+ * Copyright (C) 2001-2008  Miklos Szeredi <miklos@szeredi.hu>
+ */
+
+#include "fuse_i.h"
+#include <linux/exportfs.h>
+
+struct fuse_inode_handle {
+	u64 nodeid;
+	u32 generation;
+};
+
+static struct dentry *fuse_get_dentry(struct super_block *sb,
+				      struct fuse_inode_handle *handle)
+{
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	struct inode *inode;
+	struct dentry *entry;
+	int err = -ESTALE;
+
+	if (handle->nodeid == 0)
+		goto out_err;
+
+	inode = ilookup5(sb, handle->nodeid, fuse_inode_eq, &handle->nodeid);
+	if (!inode) {
+		struct fuse_entry_out *outarg;
+		const struct qstr name = QSTR_INIT(".", 1);
+
+		if (!fc->export_support)
+			goto out_err;
+
+		outarg = fuse_entry_out_alloc(fc);
+		if (!outarg) {
+			err = -ENOMEM;
+			goto out_err;
+		}
+
+		err = fuse_lookup_name(sb, handle->nodeid, NULL, &name, outarg,
+				       &inode);
+		kfree(outarg);
+		if (err && err != -ENOENT)
+			goto out_err;
+		if (err || !inode) {
+			err = -ESTALE;
+			goto out_err;
+		}
+		err = -EIO;
+		if (get_node_id(inode) != handle->nodeid)
+			goto out_iput;
+	}
+	err = -ESTALE;
+	if (inode->i_generation != handle->generation)
+		goto out_iput;
+
+	entry = d_obtain_alias(inode);
+	if (!IS_ERR(entry) && get_node_id(inode) != FUSE_ROOT_ID)
+		fuse_invalidate_entry_cache(entry);
+
+	return entry;
+
+ out_iput:
+	iput(inode);
+ out_err:
+	return ERR_PTR(err);
+}
+
+static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
+			   struct inode *parent)
+{
+	int len = parent ? 6 : 3;
+	u64 nodeid;
+	u32 generation;
+
+	if (*max_len < len) {
+		*max_len = len;
+		return  FILEID_INVALID;
+	}
+
+	nodeid = get_fuse_inode(inode)->nodeid;
+	generation = inode->i_generation;
+
+	fh[0] = (u32)(nodeid >> 32);
+	fh[1] = (u32)(nodeid & 0xffffffff);
+	fh[2] = generation;
+
+	if (parent) {
+		nodeid = get_fuse_inode(parent)->nodeid;
+		generation = parent->i_generation;
+
+		fh[3] = (u32)(nodeid >> 32);
+		fh[4] = (u32)(nodeid & 0xffffffff);
+		fh[5] = generation;
+	}
+
+	*max_len = len;
+	return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
+}
+
+static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
+		struct fid *fid, int fh_len, int fh_type)
+{
+	struct fuse_inode_handle handle;
+
+	if ((fh_type != FILEID_INO64_GEN &&
+	     fh_type != FILEID_INO64_GEN_PARENT) || fh_len < 3)
+		return NULL;
+
+	handle.nodeid = (u64) fid->raw[0] << 32;
+	handle.nodeid |= (u64) fid->raw[1];
+	handle.generation = fid->raw[2];
+	return fuse_get_dentry(sb, &handle);
+}
+
+static struct dentry *fuse_fh_to_parent(struct super_block *sb,
+		struct fid *fid, int fh_len, int fh_type)
+{
+	struct fuse_inode_handle parent;
+
+	if (fh_type != FILEID_INO64_GEN_PARENT || fh_len < 6)
+		return NULL;
+
+	parent.nodeid = (u64) fid->raw[3] << 32;
+	parent.nodeid |= (u64) fid->raw[4];
+	parent.generation = fid->raw[5];
+	return fuse_get_dentry(sb, &parent);
+}
+
+static struct dentry *fuse_get_parent(struct dentry *child)
+{
+	struct inode *child_inode = d_inode(child);
+	struct fuse_conn *fc = get_fuse_conn(child_inode);
+	struct inode *inode;
+	struct dentry *parent;
+	struct fuse_entry_out *outarg;
+	int err;
+
+	if (!fc->export_support)
+		return ERR_PTR(-ESTALE);
+
+	outarg = fuse_entry_out_alloc(fc);
+	if (!outarg)
+		return ERR_PTR(-ENOMEM);
+
+	err = fuse_lookup_name(child_inode->i_sb, get_node_id(child_inode),
+			       child_inode, &dotdot_name, outarg, &inode);
+	kfree(outarg);
+	if (err) {
+		if (err == -ENOENT)
+			return ERR_PTR(-ESTALE);
+		return ERR_PTR(err);
+	}
+
+	parent = d_obtain_alias(inode);
+	if (!IS_ERR(parent) && get_node_id(inode) != FUSE_ROOT_ID)
+		fuse_invalidate_entry_cache(parent);
+
+	return parent;
+}
+
+/* only for fid encoding; no support for file handle */
+const struct export_operations fuse_export_fid_operations = {
+	.encode_fh	= fuse_encode_fh,
+};
+
+const struct export_operations fuse_export_operations = {
+	.fh_to_dentry	= fuse_fh_to_dentry,
+	.fh_to_parent	= fuse_fh_to_parent,
+	.encode_fh	= fuse_encode_fh,
+	.get_parent	= fuse_get_parent,
+};
+
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d0f3c81b5612..b6afd909c857 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1164,6 +1164,8 @@ extern const struct file_operations fuse_dev_operations;
 
 extern const struct dentry_operations fuse_dentry_operations;
 
+extern int fuse_inode_eq(struct inode *inode, void *_nodeidp);
+
 /**
  * Get a filled in inode
  */
@@ -1647,4 +1649,8 @@ extern void fuse_sysctl_unregister(void);
 #define fuse_sysctl_unregister()	do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+/* export.c */
+extern const struct export_operations fuse_export_operations;
+extern const struct export_operations fuse_export_fid_operations;
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index f565f7e8118d..60715d6476c9 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -23,7 +23,6 @@
 #include <linux/statfs.h>
 #include <linux/random.h>
 #include <linux/sched.h>
-#include <linux/exportfs.h>
 #include <linux/posix_acl.h>
 #include <linux/pid_namespace.h>
 #include <uapi/linux/magic.h>
@@ -476,7 +475,7 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 		inode->i_acl = inode->i_default_acl = ACL_DONT_CACHE;
 }
 
-static int fuse_inode_eq(struct inode *inode, void *_nodeidp)
+int fuse_inode_eq(struct inode *inode, void *_nodeidp)
 {
 	u64 nodeid = *(u64 *) _nodeidp;
 	if (get_node_id(inode) == nodeid)
@@ -1116,170 +1115,6 @@ static struct inode *fuse_get_root_inode(struct super_block *sb, unsigned int mo
 	return fuse_iget(sb, FUSE_ROOT_ID, 0, &attr, 0, 0, 0, NULL); // XXX
 }
 
-struct fuse_inode_handle {
-	u64 nodeid;
-	u32 generation;
-};
-
-static struct dentry *fuse_get_dentry(struct super_block *sb,
-				      struct fuse_inode_handle *handle)
-{
-	struct fuse_conn *fc = get_fuse_conn_super(sb);
-	struct inode *inode;
-	struct dentry *entry;
-	int err = -ESTALE;
-
-	if (handle->nodeid == 0)
-		goto out_err;
-
-	inode = ilookup5(sb, handle->nodeid, fuse_inode_eq, &handle->nodeid);
-	if (!inode) {
-		struct fuse_entry_out *outarg;
-		const struct qstr name = QSTR_INIT(".", 1);
-
-		if (!fc->export_support)
-			goto out_err;
-
-		outarg = fuse_entry_out_alloc(fc);
-		if (!outarg) {
-			err = -ENOMEM;
-			goto out_err;
-		}
-
-		err = fuse_lookup_name(sb, handle->nodeid, NULL, &name, outarg,
-				       &inode);
-		kfree(outarg);
-		if (err && err != -ENOENT)
-			goto out_err;
-		if (err || !inode) {
-			err = -ESTALE;
-			goto out_err;
-		}
-		err = -EIO;
-		if (get_node_id(inode) != handle->nodeid)
-			goto out_iput;
-	}
-	err = -ESTALE;
-	if (inode->i_generation != handle->generation)
-		goto out_iput;
-
-	entry = d_obtain_alias(inode);
-	if (!IS_ERR(entry) && get_node_id(inode) != FUSE_ROOT_ID)
-		fuse_invalidate_entry_cache(entry);
-
-	return entry;
-
- out_iput:
-	iput(inode);
- out_err:
-	return ERR_PTR(err);
-}
-
-static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
-			   struct inode *parent)
-{
-	int len = parent ? 6 : 3;
-	u64 nodeid;
-	u32 generation;
-
-	if (*max_len < len) {
-		*max_len = len;
-		return  FILEID_INVALID;
-	}
-
-	nodeid = get_fuse_inode(inode)->nodeid;
-	generation = inode->i_generation;
-
-	fh[0] = (u32)(nodeid >> 32);
-	fh[1] = (u32)(nodeid & 0xffffffff);
-	fh[2] = generation;
-
-	if (parent) {
-		nodeid = get_fuse_inode(parent)->nodeid;
-		generation = parent->i_generation;
-
-		fh[3] = (u32)(nodeid >> 32);
-		fh[4] = (u32)(nodeid & 0xffffffff);
-		fh[5] = generation;
-	}
-
-	*max_len = len;
-	return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
-}
-
-static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
-		struct fid *fid, int fh_len, int fh_type)
-{
-	struct fuse_inode_handle handle;
-
-	if ((fh_type != FILEID_INO64_GEN &&
-	     fh_type != FILEID_INO64_GEN_PARENT) || fh_len < 3)
-		return NULL;
-
-	handle.nodeid = (u64) fid->raw[0] << 32;
-	handle.nodeid |= (u64) fid->raw[1];
-	handle.generation = fid->raw[2];
-	return fuse_get_dentry(sb, &handle);
-}
-
-static struct dentry *fuse_fh_to_parent(struct super_block *sb,
-		struct fid *fid, int fh_len, int fh_type)
-{
-	struct fuse_inode_handle parent;
-
-	if (fh_type != FILEID_INO64_GEN_PARENT || fh_len < 6)
-		return NULL;
-
-	parent.nodeid = (u64) fid->raw[3] << 32;
-	parent.nodeid |= (u64) fid->raw[4];
-	parent.generation = fid->raw[5];
-	return fuse_get_dentry(sb, &parent);
-}
-
-static struct dentry *fuse_get_parent(struct dentry *child)
-{
-	struct inode *child_inode = d_inode(child);
-	struct fuse_conn *fc = get_fuse_conn(child_inode);
-	struct inode *inode;
-	struct dentry *parent;
-	struct fuse_entry_out *outarg;
-	int err;
-
-	if (!fc->export_support)
-		return ERR_PTR(-ESTALE);
-
-	outarg = fuse_entry_out_alloc(fc);
-	if (!outarg)
-		return ERR_PTR(-ENOMEM);
-
-	err = fuse_lookup_name(child_inode->i_sb, get_node_id(child_inode),
-			       child_inode, &dotdot_name, outarg, &inode);
-	kfree(outarg);
-	if (err) {
-		if (err == -ENOENT)
-			return ERR_PTR(-ESTALE);
-		return ERR_PTR(err);
-	}
-
-	parent = d_obtain_alias(inode);
-	if (!IS_ERR(parent) && get_node_id(inode) != FUSE_ROOT_ID)
-		fuse_invalidate_entry_cache(parent);
-
-	return parent;
-}
-
-/* only for fid encoding; no support for file handle */
-static const struct export_operations fuse_export_fid_operations = {
-	.encode_fh	= fuse_encode_fh,
-};
-
-static const struct export_operations fuse_export_operations = {
-	.fh_to_dentry	= fuse_fh_to_dentry,
-	.fh_to_parent	= fuse_fh_to_parent,
-	.encode_fh	= fuse_encode_fh,
-	.get_parent	= fuse_get_parent,
-};
-
 static const struct super_operations fuse_super_operations = {
 	.alloc_inode    = fuse_alloc_inode,
 	.free_inode     = fuse_free_inode,

