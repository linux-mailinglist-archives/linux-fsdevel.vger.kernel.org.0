Return-Path: <linux-fsdevel+bounces-51656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE7FAD9A53
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 08:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A79D7AC2E3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 06:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6121E2847;
	Sat, 14 Jun 2025 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CT7qrXwO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD95B1D618C
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749880955; cv=none; b=JxViLoT7yKuYkSt/AWcdmguxejuUHmDSIQPwbJStNgqne83syBvmAbl3ZsVidrvNWFi65C6ZMqzUhlc5XpUWznCZAJFoN3bRNNm//mzdgvcLd2jekBLMSM6CFNBNwWmgCd2P5BCAbq1kzxzcmuVqGOrU31LRK+Aj1SnGQ7dRmps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749880955; c=relaxed/simple;
	bh=U1BGoSUCOj/kXHtWHKOkxmoFV0uNLJfvL0Ilk9MkGTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAx6LtB3um8/dKo/uaQ9QtOc+WxV25EwJxseq5JSS3k4wJGjkIHqATmBIYCAQY5N53xRJQMMHZjn4FJ++hf7zvoGx+lDOnFd6CVf2cE7hBlUo5V1PtVWetRIOubIvKtf0z70zUnbY2cY/gYxMsMhBVIoNpKFs4anIKJ/zyO7IKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CT7qrXwO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=z3sNvJdG4SuqTX+eOMOrcQnGbQ82WlKL73y+Juwcieg=; b=CT7qrXwOG6W5hQ0BtVs2MlQ2+R
	VmfcUnjOza2nAXdyPOmofHOP4czgLNNLlXeevh7Urz9NriaU1e0Vw7fkHQNLBarPCJ50gqCjiwVaP
	0fq+qIQI+Z6/3YTE3L1uUwxvTF52nvG0FjQT6eNx1fqsVyt/AM9DJkBW4JJd64/U1Lo413pkH1O57
	UEqa/oR/jYJGF+ACVIv4uSMIeOgneHjQc+KCgapTnFB4e1SbswbRURsGCi3QHb2LtC/Fx3TpneSaj
	g7Ylr+xz1hC9bu7935cjg3dVVny95HmDXY6UqkhUwwX1C2SuImIoi1uPNomKrdf0OppWk9OcIi+Rv
	Or4y4qFw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQJyI-000000022pp-3qNd;
	Sat, 14 Jun 2025 06:02:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: neil@brown.name,
	torvalds@linux-foundation.org,
	brauner@kernel.org
Subject: [PATCH 3/8] spufs: switch to locked_recursive_removal()
Date: Sat, 14 Jun 2025 07:02:25 +0100
Message-ID: <20250614060230.487463-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614060230.487463-1-viro@zeniv.linux.org.uk>
References: <20250614060050.GB1880847@ZenIV>
 <20250614060230.487463-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and fix an old deadlock on spufs_mkdir() failures to populate
subdirectory - spufs_rmdir() had always been taking lock on the
victim, so doing it while the victim is locked is a bad idea.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 49 +++++------------------
 1 file changed, 9 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 9f9e4b871627..7ec60290abe6 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -143,42 +143,13 @@ spufs_evict_inode(struct inode *inode)
 		put_spu_gang(ei->i_gang);
 }
 
-static void spufs_prune_dir(struct dentry *dir)
-{
-	struct dentry *dentry;
-	struct hlist_node *n;
-
-	inode_lock(d_inode(dir));
-	hlist_for_each_entry_safe(dentry, n, &dir->d_children, d_sib) {
-		spin_lock(&dentry->d_lock);
-		if (simple_positive(dentry)) {
-			dget_dlock(dentry);
-			__d_drop(dentry);
-			spin_unlock(&dentry->d_lock);
-			simple_unlink(d_inode(dir), dentry);
-			/* XXX: what was dcache_lock protecting here? Other
-			 * filesystems (IB, configfs) release dcache_lock
-			 * before unlink */
-			dput(dentry);
-		} else {
-			spin_unlock(&dentry->d_lock);
-		}
-	}
-	shrink_dcache_parent(dir);
-	inode_unlock(d_inode(dir));
-}
-
 /* Caller must hold parent->i_mutex */
-static int spufs_rmdir(struct inode *parent, struct dentry *dir)
+static void spufs_rmdir(struct inode *parent, struct dentry *dir)
 {
-	/* remove all entries */
-	int res;
-	spufs_prune_dir(dir);
-	d_drop(dir);
-	res = simple_rmdir(parent, dir);
-	/* We have to give up the mm_struct */
-	spu_forget(SPUFS_I(d_inode(dir))->i_ctx);
-	return res;
+	struct spu_context *ctx = SPUFS_I(d_inode(dir))->i_ctx;
+
+	locked_recursive_removal(dir, NULL);
+	spu_forget(ctx);
 }
 
 static int spufs_fill_dir(struct dentry *dir,
@@ -222,15 +193,13 @@ static int spufs_dir_close(struct inode *inode, struct file *file)
 {
 	struct inode *parent;
 	struct dentry *dir;
-	int ret;
 
 	dir = file->f_path.dentry;
 	parent = d_inode(dir->d_parent);
 
 	inode_lock_nested(parent, I_MUTEX_PARENT);
-	ret = spufs_rmdir(parent, dir);
+	spufs_rmdir(parent, dir);
 	inode_unlock(parent);
-	WARN_ON(ret);
 
 	unuse_gang(dir->d_parent);
 	return dcache_dir_close(inode, file);
@@ -288,11 +257,11 @@ spufs_mkdir(struct inode *dir, struct dentry *dentry, unsigned int flags,
 		ret = spufs_fill_dir(dentry, spufs_dir_debug_contents,
 				mode, ctx);
 
+	inode_unlock(inode);
+
 	if (ret)
 		spufs_rmdir(dir, dentry);
 
-	inode_unlock(inode);
-
 	return ret;
 }
 
@@ -475,7 +444,7 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
 
 	ret = spufs_context_open(&path);
 	if (ret < 0)
-		WARN_ON(spufs_rmdir(inode, dentry));
+		spufs_rmdir(inode, dentry);
 
 out_aff_unlock:
 	if (affinity)
-- 
2.39.5


