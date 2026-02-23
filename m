Return-Path: <linux-fsdevel+bounces-78058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMN2MnrfnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:15:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7806117F105
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ED1D316D9A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5513D37E2FF;
	Mon, 23 Feb 2026 23:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnF8G9Du"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60503783C9;
	Mon, 23 Feb 2026 23:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888292; cv=none; b=JLvcFIEpIUF1IOeKtJh7cpztbSxARaUY7LhOvVah9IPNQkRXJD4/W6IUVSw0yRJvg5uWg69dNvP38bjB6fXbPKUUFZRz8uWnKxd1kaxo6BK8bywEW71lqVwSRc2e7Z33PKssQpufgRAt5X4u3DBIfY2jZI0pv/Eupw65jr4gFgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888292; c=relaxed/simple;
	bh=kDXr/2ScoX3PZ3+XC1fQ7yVlhYvGYlLU87dNlO2rHYs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVNebqmZX7wFZjIJwwjnzsPh+xt2zcbb2l3DQzhtgQHuGqsbfoFxjtYZFfqzhzwJD2uuVskqHRgbG6qw8ZDG8weSQ1249/bUnS1VsO95D3D02nTxcVIOkpGxjBgiNQ8j9sXge2aTtAk94mwIu5lAdxemya440klh/+MNOM+tDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnF8G9Du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A19CC116C6;
	Mon, 23 Feb 2026 23:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888292;
	bh=kDXr/2ScoX3PZ3+XC1fQ7yVlhYvGYlLU87dNlO2rHYs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BnF8G9Du3anQlN9RwZO13Bee9X0UujCO8xbtgk87cu69rwA9qWeUCqsz+qeRu5AIC
	 Kw3jE3fREPSh9osxqYkqgV5LUJA+BFwAfkR/qi6M0Fhh5X+qU9M7ZGr53axTcDnkyK
	 7PEbHj/9d/zhMfB5oreCt9EQ9sadEZb7lmywLRlmCbeRoIf7Wr8DXBf5FsUGRnDwrP
	 UpT6TsvioYardpKTIKejy09o0F4e2+Ha5/7wIB21TbVWWDyxCdOqI9fT2Xk4g+YQ8B
	 TUT9C10qotWmTZ74lUZytz3UEHfS0hpo6MNY2UcenG4YzOWn+i16Ji6fwGQKx9GlXk
	 ez7fEB6DJOfZA==
Date: Mon, 23 Feb 2026 15:11:31 -0800
Subject: [PATCH 11/33] fuse: isolate the other regular file IO paths from
 iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734480.3935739.7371931020980072553.stgit@frogsfrogsfrogs>
In-Reply-To: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78058-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 7806117F105
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

iomap completely takes over all regular file IO, so we don't need to
access any of the other mechanisms at all.  Gate them off so that we can
eventually overlay them with a union to save space in struct fuse_inode.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dir.c    |   14 +++++++++-----
 fs/fuse/file.c   |   18 +++++++++++++-----
 fs/fuse/inode.c  |    3 ++-
 fs/fuse/iomode.c |    3 ++-
 4 files changed, 26 insertions(+), 12 deletions(-)


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 10db4dc046930f..138f8abbe42b4c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2196,6 +2196,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	FUSE_ARGS(args);
 	struct fuse_setattr_in inarg;
 	struct fuse_attr_out outarg;
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	bool is_truncate = false;
 	bool is_wb = fc->writeback_cache && S_ISREG(inode->i_mode);
 	loff_t oldsize;
@@ -2253,12 +2254,15 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (err)
 			return err;
 
-		fuse_set_nowrite(inode);
-		fuse_release_nowrite(inode);
+		if (!is_iomap) {
+			fuse_set_nowrite(inode);
+			fuse_release_nowrite(inode);
+		}
 	}
 
 	if (is_truncate) {
-		fuse_set_nowrite(inode);
+		if (!is_iomap)
+			fuse_set_nowrite(inode);
 		set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 		if (trust_local_cmtime && attr->ia_size != inode->i_size)
 			attr->ia_valid |= ATTR_MTIME | ATTR_CTIME;
@@ -2330,7 +2334,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!is_wb || is_truncate)
 		i_size_write(inode, outarg.attr.size);
 
-	if (is_truncate) {
+	if (is_truncate && !is_iomap) {
 		/* NOTE: this may release/reacquire fi->lock */
 		__fuse_release_nowrite(inode);
 	}
@@ -2354,7 +2358,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return 0;
 
 error:
-	if (is_truncate)
+	if (is_truncate && !is_iomap)
 		fuse_release_nowrite(inode);
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4a7b0c190aa8e4..c73536e29f1c96 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -251,6 +251,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_file *ff;
 	int err;
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	bool is_truncate = (file->f_flags & O_TRUNC) && fc->atomic_o_trunc;
 	bool is_wb_truncate = is_truncate && fc->writeback_cache;
 	bool dax_truncate = is_truncate && FUSE_IS_DAX(inode);
@@ -272,7 +273,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 			goto out_inode_unlock;
 	}
 
-	if (is_wb_truncate || dax_truncate)
+	if ((is_wb_truncate || dax_truncate) && !is_iomap)
 		fuse_set_nowrite(inode);
 
 	err = fuse_do_open(fm, get_node_id(inode), file, false);
@@ -285,7 +286,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 			fuse_truncate_update_attr(inode, file);
 	}
 
-	if (is_wb_truncate || dax_truncate)
+	if ((is_wb_truncate || dax_truncate) && !is_iomap)
 		fuse_release_nowrite(inode);
 	if (!err) {
 		if (is_truncate)
@@ -533,12 +534,14 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 {
 	struct inode *inode = file->f_mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	const bool need_sync_writes = !fuse_inode_has_iomap(inode);
 	int err;
 
 	if (fuse_is_bad(inode))
 		return -EIO;
 
-	inode_lock(inode);
+	if (need_sync_writes)
+		inode_lock(inode);
 
 	/*
 	 * Start writeback against all dirty pages of the inode, then
@@ -549,7 +552,8 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 	if (err)
 		goto out;
 
-	fuse_sync_writes(inode);
+	if (need_sync_writes)
+		fuse_sync_writes(inode);
 
 	/*
 	 * Due to implementation of fuse writeback
@@ -573,7 +577,8 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 		err = 0;
 	}
 out:
-	inode_unlock(inode);
+	if (need_sync_writes)
+		inode_unlock(inode);
 
 	return err;
 }
@@ -2010,6 +2015,9 @@ static struct fuse_file *__fuse_write_file_get(struct fuse_inode *fi)
 {
 	struct fuse_file *ff;
 
+	if (fuse_inode_has_iomap(&fi->inode))
+		return NULL;
+
 	spin_lock(&fi->lock);
 	ff = list_first_entry_or_null(&fi->write_files, struct fuse_file,
 				      write_entry);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 27699a6c11f66b..fae33371c33da6 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -192,7 +192,8 @@ static void fuse_evict_inode(struct inode *inode)
 		if (inode->i_nlink > 0)
 			atomic64_inc(&fc->evict_ctr);
 	}
-	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
+	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode) &&
+	    !fuse_inode_has_iomap(inode)) {
 		WARN_ON(fi->iocachectr != 0);
 		WARN_ON(!list_empty(&fi->write_files));
 		WARN_ON(!list_empty(&fi->queued_writes));
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index 3728933188f307..9be9ae3520003e 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -6,6 +6,7 @@
  */
 
 #include "fuse_i.h"
+#include "fuse_iomap.h"
 
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -203,7 +204,7 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 	 * io modes are not relevant with DAX and with server that does not
 	 * implement open.
 	 */
-	if (FUSE_IS_DAX(inode) || !ff->args)
+	if (fuse_inode_has_iomap(inode) || FUSE_IS_DAX(inode) || !ff->args)
 		return 0;
 
 	/*


