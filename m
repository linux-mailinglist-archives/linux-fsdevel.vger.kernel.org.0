Return-Path: <linux-fsdevel+bounces-66034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01258C17A99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C531897B14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A83D2D6E71;
	Wed, 29 Oct 2025 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucibDBk9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE22283124;
	Wed, 29 Oct 2025 00:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699198; cv=none; b=Gm6Hn4GDx70RabgbDTUYoxm9pllXOk+gSDQGgjDWcTaSUhM7IrXzcL+PytwrAc1zgyMHnuffYxtHfyHMoiy6n4y9UHb329UUa1UMCQkZtpyB6AJwJDL9V1QvVC2cQhMNFlsBM47NLU7BOJGKy5PIGOrDt1wWYuzgoJZkFwwGnG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699198; c=relaxed/simple;
	bh=hOqEgsQkFFwoascr11B+CnkSS8lXg5fUmJSgoTk00P4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/ogjHt9h1M1jwYrmTfpJOBzxSwzf5hqKpFuuCaDl+9pe2EcWhOA4A0cCENCT1DJzv/SB2YqIvMAU5HxkUhI+keY8qXfYZpCFZ8NnM0tucB+iuCz6qDQqX1l3nwupcv667ZcwsYAUk3YyCfy/RIxRTSoSlYCrLnoBbH3CATvLTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucibDBk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472F6C4CEE7;
	Wed, 29 Oct 2025 00:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699198;
	bh=hOqEgsQkFFwoascr11B+CnkSS8lXg5fUmJSgoTk00P4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ucibDBk96gh//mXY3EwsMVFDKmlCZDc9Of4rC0tCQGelcTdZwClcuJSoIGOVc27JN
	 7Izah/bHTKI2yzFwGXJXxR09jHahMUL8+SAghxq0WdQMXJlYUvWI2nhYcOt29KmUuh
	 Iuve7IcIWfzMQf9lSQ21ibQHT+3U7MRHGsOr7mQGmJUmykvt21KntYVZW+w9aEiG41
	 jK096/f+2sp/Y67ijrRlmzqjn0X6Mt/BglrnRyv5ZGT/JIKdbGhOsePg77oH245lwK
	 xH79VYk4ZwmibJweiYveobDPT6gGaF1M/WEGnVdU1w7O+peGw2RUTHSp1yAAjd5AB5
	 7WYsrVOH1lvlQ==
Date: Tue, 28 Oct 2025 17:53:17 -0700
Subject: [PATCH 1/3] fuse: make the root nodeid dynamic
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169811268.1426070.2874269137574030621.stgit@frogsfrogsfrogs>
In-Reply-To: <176169811231.1426070.12996939158894110793.stgit@frogsfrogsfrogs>
References: <176169811231.1426070.12996939158894110793.stgit@frogsfrogsfrogs>
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
index 9ab1de8063c05e..4157dba6cba27c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -690,6 +690,9 @@ struct fuse_conn {
 
 	struct rcu_head rcu;
 
+	/* node id of the root directory */
+	u64 root_nodeid;
+
 	/** The user id for this mount */
 	kuid_t user_id;
 
@@ -1118,9 +1121,9 @@ static inline u64 get_node_id(struct inode *inode)
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
index c35ddd5070225c..bd0d37a513b42d 100644
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
 
@@ -831,7 +832,8 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 		goto out_put_forget_req;
 
 	err = -EIO;
-	if (invalid_nodeid(outarg.nodeid) || fuse_invalid_attr(&outarg.attr))
+	if (invalid_nodeid(fm->fc, outarg.nodeid) ||
+	    fuse_invalid_attr(&outarg.attr))
 		goto out_put_forget_req;
 
 	if ((outarg.attr.mode ^ mode) & S_IFMT)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d41a6e418537b5..5f0c7032e691a6 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1018,6 +1018,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->max_pages_limit = fuse_max_pages_limit;
 	fc->name_max = FUSE_NAME_LOW_MAX;
 	fc->timeout.req_timeout = 0;
+	fc->root_nodeid = FUSE_ROOT_ID;
 
 	if (IS_ENABLED(CONFIG_FUSE_BACKING))
 		fuse_backing_files_init(fc);
@@ -1073,12 +1074,14 @@ EXPORT_SYMBOL_GPL(fuse_conn_get);
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
@@ -1122,7 +1125,7 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 		goto out_iput;
 
 	entry = d_obtain_alias(inode);
-	if (!IS_ERR(entry) && get_node_id(inode) != FUSE_ROOT_ID)
+	if (!IS_ERR(entry) && get_node_id(inode) != fc->root_nodeid)
 		fuse_invalidate_entry_cache(entry);
 
 	return entry;
@@ -1215,7 +1218,7 @@ static struct dentry *fuse_get_parent(struct dentry *child)
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


