Return-Path: <linux-fsdevel+bounces-58458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D5BB2E9D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA44A0859A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515861E493C;
	Thu, 21 Aug 2025 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8GogY9B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08CFC2FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737816; cv=none; b=SSfQqBU5WflrvKTdpDFZ3vVy/T77OtjcDFK5PHh5WezqdTUmu6iX8zmwRa2/uH5m1Le1zQs1aGSEIEJaJy1VKhiP4aVHU/lYG/g7Km7nLvPL4hHMvHk67eMrB96wI2yamqvYlIXpan+NibXiFgkTbwMXfLSS+NyjWnBwqbWN/dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737816; c=relaxed/simple;
	bh=EEvyhC0g6RpNjDRFVQNpbmMcTq/gZ6HTOqgA+bnRZ0M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l96Osii97yydmQNYGTcmI4gXo+RRKw00+Cl3wCgFVsEAqaD0jXXsc28KQ7wk5ZpU4M6xlsrUchttwGJZYhAVoERJUsEIrj4fYxTSpXYHlyAhLL8/NYguY06RSKk5Yo1nAx0ymS7/b8CluzS8TfLUt+t08DJHm4d9neDIvmo5DM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8GogY9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A886C113D0;
	Thu, 21 Aug 2025 00:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737816;
	bh=EEvyhC0g6RpNjDRFVQNpbmMcTq/gZ6HTOqgA+bnRZ0M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=C8GogY9BKhZei4upAWLmbq1htP0j3pnHI51wzppsOop3NP1lkcVOPrrGfDK7MiFWY
	 dowQA1tm80kYjamS9ZOx2OvNwf4aM6AlMBr80SajjqOicZ/SufHX5b1b0fzaNIsper
	 1HSxfbUmgZ0jeS97ROdMiz4cXND8W0ZNwEKfFEMVa50ZpNSBqDkp92RMhUZpN3pfkq
	 7yhiY/GItKLxsHj7bzBz2UcNQcrrT6ywtg0I2trcx/HNXHrUZWBtXSAp1kKrWtfa2l
	 f43AcLeROgIBu28ee9B9f/La7cvz4zGlnVx2Fy6eWU2NJCKvQQxkff3TpOsksEJt13
	 6vjQMNiJJg6Lg==
Date: Wed, 20 Aug 2025 17:56:55 -0700
Subject: [PATCH 17/23] fuse: make the root nodeid dynamic
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709481.17510.2591649505973115604.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_i.h     |    7 +++++--
 fs/fuse/fuse_trace.h |    6 ++++--
 fs/fuse/dir.c        |   10 ++++++----
 fs/fuse/inode.c      |   11 +++++++----
 fs/fuse/readdir.c    |   10 +++++-----
 5 files changed, 27 insertions(+), 17 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 63ce9ddb96477c..66cf8dcf9216e7 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -665,6 +665,9 @@ struct fuse_conn {
 
 	struct rcu_head rcu;
 
+	/* node id of the root directory */
+	u64 root_nodeid;
+
 	/** The user id for this mount */
 	kuid_t user_id;
 
@@ -1097,9 +1100,9 @@ static inline u64 get_node_id(struct inode *inode)
 	return get_fuse_inode(inode)->nodeid;
 }
 
-static inline int invalid_nodeid(u64 nodeid)
+static inline int invalid_nodeid(const struct fuse_conn *fc, u64 nodeid)
 {
-	return !nodeid || nodeid == FUSE_ROOT_ID;
+	return !nodeid || nodeid == fc->root_nodeid;
 }
 
 static inline u64 fuse_get_attr_version(struct fuse_conn *fc)
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index d3a0bd066370f5..1f2ff30bececd4 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -1012,6 +1012,7 @@ TRACE_EVENT(fuse_iomap_config,
 
 	TP_STRUCT__entry(
 		__field(dev_t,			connection)
+		__field(uint64_t,		root_nodeid)
 
 		__field(uint32_t,		flags)
 		__field(uint32_t,		blocksize)
@@ -1026,6 +1027,7 @@ TRACE_EVENT(fuse_iomap_config,
 
 	TP_fast_assign(
 		__entry->connection	=	fm->fc->dev;
+		__entry->root_nodeid	=	fm->fc->root_nodeid;
 		__entry->flags		=	outarg->flags;
 		__entry->blocksize	=	outarg->s_blocksize;
 		__entry->max_links	=	outarg->s_max_links;
@@ -1036,8 +1038,8 @@ TRACE_EVENT(fuse_iomap_config,
 		__entry->uuid_len	=	outarg->s_uuid_len;
 	),
 
-	TP_printk("connection %u flags (%s) blocksize 0x%x max_links %u time_gran %u time_min %lld time_max %lld maxbytes 0x%llx uuid_len %u",
-		  __entry->connection,
+	TP_printk("connection %u root_ino 0x%llx flags (%s) blocksize 0x%x max_links %u time_gran %u time_min %lld time_max %lld maxbytes 0x%llx uuid_len %u",
+		  __entry->connection, __entry->root_nodeid,
 		  __print_flags(__entry->flags, "|", FUSE_IOMAP_CONFIG_STRINGS),
 		  __entry->blocksize, __entry->max_links, __entry->time_gran,
 		  __entry->time_min, __entry->time_max, __entry->maxbytes,
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 07aa338208b5cc..02c8e705af1e35 100644
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
index abb2beef3cfe1f..f2d519c0f737e6 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1001,6 +1001,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->max_pages_limit = fuse_max_pages_limit;
 	fc->name_max = FUSE_NAME_LOW_MAX;
 	fc->timeout.req_timeout = 0;
+	fc->root_nodeid = FUSE_ROOT_ID;
 
 	if (IS_ENABLED(CONFIG_FUSE_BACKING))
 		fuse_backing_files_init(fc);
@@ -1056,12 +1057,14 @@ EXPORT_SYMBOL_GPL(fuse_conn_get);
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
@@ -1105,7 +1108,7 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 		goto out_iput;
 
 	entry = d_obtain_alias(inode);
-	if (!IS_ERR(entry) && get_node_id(inode) != FUSE_ROOT_ID)
+	if (!IS_ERR(entry) && get_node_id(inode) != fc->root_nodeid)
 		fuse_invalidate_entry_cache(entry);
 
 	return entry;
@@ -1198,7 +1201,7 @@ static struct dentry *fuse_get_parent(struct dentry *child)
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


