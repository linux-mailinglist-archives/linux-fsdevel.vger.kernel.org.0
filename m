Return-Path: <linux-fsdevel+bounces-61536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F7CB589AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE13201816
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1636B83CC7;
	Tue, 16 Sep 2025 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIdM1MB3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ED27483;
	Tue, 16 Sep 2025 00:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982932; cv=none; b=uCP1vRr0avmagGwLLBJlFSpe7kGwQtdbjII2U0c42uxmdZGKQuIgz0QSphRJS1t9KdNA2pJ8BmgFoE0JXqDcEeHi91QLjIWvWv/3VVZmaqz5MSOmGw7BsQEvCSwi1v+2fV7DkRawbvbMWuBFcEqzsY/790C5MuOYXS/LUkOQ2ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982932; c=relaxed/simple;
	bh=mW9CzZ5dpmvcRNSTLV3fdVP/r3faF+h95BTXOtdSEiQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBcO+dHSEQ4p00cCYptrHdTBFOP/wPh+hd6qNCKZEGi1yvqZ+Zhus6lPZHlsdE+K5kEXck05dt6elaUWX1SvMciaNF45a9LvGzYpi8IZL5A70wgcIV8QESENP25WfVm20EKjnA/qnWOBqqvZul2FWfdxAj+d2pAom8S8o66W/lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIdM1MB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C740C4CEFB;
	Tue, 16 Sep 2025 00:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982932;
	bh=mW9CzZ5dpmvcRNSTLV3fdVP/r3faF+h95BTXOtdSEiQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KIdM1MB3mAXshp+jdAfD1AnZJ3UkFbtIk+zEH6RQirHd34f0TNCCM1xyVmWjrw9DB
	 SwyJDLMLfhA0c9ByBkHT48BlgW9X5uPvc6GpCB0zYqueYodCz1S3omQsHO1dVYnLHX
	 Ek4XcBsO1PJOOmUszXMi1hxvqKpaEfbqD0YnZVQZk1/u1zYmBy1g1OtnfcW6JqZbyw
	 MrRl7u1356WaLxZdAjcBktKnRb9iCUwZZh0Xv5OqG9Ui3keLh0OzzU/ixGhZXMWbxu
	 xG79TrGdOGDVZV8djVQ/KIIgfXxUIs6Txeh/WwgHPycrBQifefrlevQ8npLOeU3YUH
	 i4ZuEyy6Sf0ag==
Date: Mon, 15 Sep 2025 17:35:31 -0700
Subject: [PATCH 1/3] fuse: make the root nodeid dynamic
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798152118.383798.14033570233668358512.stgit@frogsfrogsfrogs>
In-Reply-To: <175798152081.383798.16940546036390782667.stgit@frogsfrogsfrogs>
References: <175798152081.383798.16940546036390782667.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Change this from a hardcoded constant to a dynamic field so that fuse
servers don't need to translate.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h  |    7 +++++--
 fs/fuse/dir.c     |   10 ++++++----
 fs/fuse/inode.c   |   11 +++++++----
 fs/fuse/readdir.c |   10 +++++-----
 4 files changed, 23 insertions(+), 15 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 777826115d3e80..70942340e33855 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -684,6 +684,9 @@ struct fuse_conn {
 
 	struct rcu_head rcu;
 
+	/* node id of the root directory */
+	u64 root_nodeid;
+
 	/** The user id for this mount */
 	kuid_t user_id;
 
@@ -1127,9 +1130,9 @@ static inline u64 get_node_id(struct inode *inode)
 	return get_fuse_inode(inode)->nodeid;
 }
 
-static inline int invalid_nodeid(u64 nodeid)
+static inline int invalid_nodeid(const struct fuse_conn *fc, u64 nodeid)
 {
-	return !nodeid || nodeid == FUSE_ROOT_ID;
+	return !nodeid || nodeid == fc->root_nodeid;
 }
 
 static inline u64 fuse_get_attr_version(struct fuse_conn *fc)
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b5e3536f1d53c1..c6e83b724f8cd0 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -386,7 +386,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	err = -EIO;
 	if (fuse_invalid_attr(&outarg->attr))
 		goto out_put_forget;
-	if (outarg->nodeid == FUSE_ROOT_ID && outarg->generation != 0) {
+	if (outarg->nodeid == fm->fc->root_nodeid && outarg->generation != 0) {
 		pr_warn_once("root generation should be zero\n");
 		outarg->generation = 0;
 	}
@@ -436,7 +436,7 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 		goto out_err;
 
 	err = -EIO;
-	if (inode && get_node_id(inode) == FUSE_ROOT_ID)
+	if (inode && get_node_id(inode) == fc->root_nodeid)
 		goto out_iput;
 
 	newent = d_splice_alias(inode, entry);
@@ -687,7 +687,8 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 		goto out_free_ff;
 
 	err = -EIO;
-	if (!S_ISREG(outentry.attr.mode) || invalid_nodeid(outentry.nodeid) ||
+	if (!S_ISREG(outentry.attr.mode) ||
+	    invalid_nodeid(fm->fc, outentry.nodeid) ||
 	    fuse_invalid_attr(&outentry.attr))
 		goto out_free_ff;
 
@@ -838,7 +839,8 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 		goto out_put_forget_req;
 
 	err = -EIO;
-	if (invalid_nodeid(outarg.nodeid) || fuse_invalid_attr(&outarg.attr))
+	if (invalid_nodeid(fm->fc, outarg.nodeid) ||
+	    fuse_invalid_attr(&outarg.attr))
 		goto out_put_forget_req;
 
 	if ((outarg.attr.mode ^ mode) & S_IFMT)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index beb9ee62b6b861..350805fa61690c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -997,6 +997,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->max_pages_limit = fuse_max_pages_limit;
 	fc->name_max = FUSE_NAME_LOW_MAX;
 	fc->timeout.req_timeout = 0;
+	fc->root_nodeid = FUSE_ROOT_ID;
 
 	if (IS_ENABLED(CONFIG_FUSE_BACKING))
 		fuse_backing_files_init(fc);
@@ -1052,12 +1053,14 @@ EXPORT_SYMBOL_GPL(fuse_conn_get);
 static struct inode *fuse_get_root_inode(struct super_block *sb, unsigned int mode)
 {
 	struct fuse_attr attr;
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+
 	memset(&attr, 0, sizeof(attr));
 
 	attr.mode = mode;
-	attr.ino = FUSE_ROOT_ID;
+	attr.ino = fc->root_nodeid;
 	attr.nlink = 1;
-	return fuse_iget(sb, FUSE_ROOT_ID, 0, &attr, 0, 0, 0);
+	return fuse_iget(sb, fc->root_nodeid, 0, &attr, 0, 0, 0);
 }
 
 struct fuse_inode_handle {
@@ -1101,7 +1104,7 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 		goto out_iput;
 
 	entry = d_obtain_alias(inode);
-	if (!IS_ERR(entry) && get_node_id(inode) != FUSE_ROOT_ID)
+	if (!IS_ERR(entry) && get_node_id(inode) != fc->root_nodeid)
 		fuse_invalidate_entry_cache(entry);
 
 	return entry;
@@ -1194,7 +1197,7 @@ static struct dentry *fuse_get_parent(struct dentry *child)
 	}
 
 	parent = d_obtain_alias(inode);
-	if (!IS_ERR(parent) && get_node_id(inode) != FUSE_ROOT_ID)
+	if (!IS_ERR(parent) && get_node_id(inode) != fc->root_nodeid)
 		fuse_invalidate_entry_cache(parent);
 
 	return parent;
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index c2aae2eef0868b..45dd932eb03a5e 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -185,12 +185,12 @@ static int fuse_direntplus_link(struct file *file,
 			return 0;
 	}
 
-	if (invalid_nodeid(o->nodeid))
-		return -EIO;
-	if (fuse_invalid_attr(&o->attr))
-		return -EIO;
-
 	fc = get_fuse_conn(dir);
+	if (invalid_nodeid(fc, o->nodeid))
+		return -EIO;
+	if (fuse_invalid_attr(&o->attr))
+		return -EIO;
+
 	epoch = atomic_read(&fc->epoch);
 
 	name.hash = full_name_hash(parent, name.name, name.len);


