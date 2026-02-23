Return-Path: <linux-fsdevel+bounces-78081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJVbCR7hnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:22:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F8017F383
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8788314F15D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6734437F733;
	Mon, 23 Feb 2026 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxxrAxqM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55AC37E2E6;
	Mon, 23 Feb 2026 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888654; cv=none; b=VOXy5WUbZ6/SeBt6UYLMbSY3ZG9s72ZA1hGCG9SV0MY6FxmTW/PXkvAiGg2qZxyXy16HKlrzPcSIjAp6TQMg8N3BDeHGUiKbqk2923WKVpUC3OgLaKxnnEuPL2tJYV/TUSAZD4LHwIiFz11DKWKgXwl7Mp/LVu4Y9+jZPktt9qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888654; c=relaxed/simple;
	bh=A2DmopxU8cS2gQMLkvI5jVa35/plqGQc+FwQ8ySBUZQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DL5boRYTNl6Kn5dYMoQ98Gdn7BrKfcrsbWiki8YXzLAfR9f2gKhptbqfwjz2T/5Ex4wuXY996wnupqH3y0FFc2sBEYuU3lt97sECvmr0gDUJGYunimIr8unFcd2XtSefdViBIMzylBapSdMyYdBLhYNZaH80TQmTtBpNY00rRZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxxrAxqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7734EC116C6;
	Mon, 23 Feb 2026 23:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888653;
	bh=A2DmopxU8cS2gQMLkvI5jVa35/plqGQc+FwQ8ySBUZQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=cxxrAxqM2TWyyTJFQDsTgOdXb6hKO6324rndZsPuszLnjlEItEQFwhMnC31elWX7c
	 vI+F1EX2SycJ3/uMjrE/dr9inBZtfsO8ooRsRV7cB3UGP52CvmEggGyrGAzSbisEcP
	 xdZmZLuGkfQwekaKvO3en3Erl5HrOkDSBsYhqeorYQa26vW0yJU6RVA6cAtUTfApLN
	 mZF+1BwMz4/pbOVWaNQuaE3p3JXKM3UMiTuxpemDHz1CdHQxYUEzfozoHu5HeHzb8X
	 //69bmY3wOqaK8NARLLlYY0chzHoDSpDJUOCu/MQxlFKEtYkxTMyjuHzgpI2HEQzWW
	 FeXCqkHdVZpzg==
Date: Mon, 23 Feb 2026 15:17:33 -0800
Subject: [PATCH 1/3] fuse: make the root nodeid dynamic
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188735202.3936993.17412480284061079791.stgit@frogsfrogsfrogs>
In-Reply-To: <177188735166.3936993.12658858435281080344.stgit@frogsfrogsfrogs>
References: <177188735166.3936993.12658858435281080344.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78081-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7F8017F383
X-Rspamd-Action: no action

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
index f96c69c755bd9b..fc0e352e2e8f9b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -702,6 +702,9 @@ struct fuse_conn {
 
 	struct rcu_head rcu;
 
+	/* node id of the root directory */
+	u64 root_nodeid;
+
 	/** The user id for this mount */
 	kuid_t user_id;
 
@@ -1117,9 +1120,9 @@ static inline u64 get_node_id(struct inode *inode)
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
index 0492619e397f56..ff678f26e9cd79 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -580,7 +580,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	err = -EIO;
 	if (fuse_invalid_attr(&outarg->attr))
 		goto out_put_forget;
-	if (outarg->nodeid == FUSE_ROOT_ID && outarg->generation != 0) {
+	if (outarg->nodeid == fm->fc->root_nodeid && outarg->generation != 0) {
 		pr_warn_once("root generation should be zero\n");
 		outarg->generation = 0;
 	}
@@ -630,7 +630,7 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 		goto out_err;
 
 	err = -EIO;
-	if (inode && get_node_id(inode) == FUSE_ROOT_ID)
+	if (inode && get_node_id(inode) == fc->root_nodeid)
 		goto out_iput;
 
 	newent = d_splice_alias(inode, entry);
@@ -881,7 +881,8 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 		goto out_free_ff;
 
 	err = -EIO;
-	if (!S_ISREG(outentry.attr.mode) || invalid_nodeid(outentry.nodeid) ||
+	if (!S_ISREG(outentry.attr.mode) ||
+	    invalid_nodeid(fm->fc, outentry.nodeid) ||
 	    fuse_invalid_attr(&outentry.attr))
 		goto out_free_ff;
 
@@ -1028,7 +1029,8 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 		goto out_put_forget_req;
 
 	err = -EIO;
-	if (invalid_nodeid(outarg.nodeid) || fuse_invalid_attr(&outarg.attr))
+	if (invalid_nodeid(fm->fc, outarg.nodeid) ||
+	    fuse_invalid_attr(&outarg.attr))
 		goto out_put_forget_req;
 
 	if ((outarg.attr.mode ^ mode) & S_IFMT)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index f3afa63bfe7f61..2a679bce3b178c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1030,6 +1030,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->max_pages_limit = fuse_max_pages_limit;
 	fc->name_max = FUSE_NAME_LOW_MAX;
 	fc->timeout.req_timeout = 0;
+	fc->root_nodeid = FUSE_ROOT_ID;
 
 	if (IS_ENABLED(CONFIG_FUSE_BACKING))
 		fuse_backing_files_init(fc);
@@ -1087,12 +1088,14 @@ EXPORT_SYMBOL_GPL(fuse_conn_get);
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
@@ -1136,7 +1139,7 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 		goto out_iput;
 
 	entry = d_obtain_alias(inode);
-	if (!IS_ERR(entry) && get_node_id(inode) != FUSE_ROOT_ID)
+	if (!IS_ERR(entry) && get_node_id(inode) != fc->root_nodeid)
 		fuse_invalidate_entry_cache(entry);
 
 	return entry;
@@ -1229,7 +1232,7 @@ static struct dentry *fuse_get_parent(struct dentry *child)
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


