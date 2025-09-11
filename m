Return-Path: <linux-fsdevel+bounces-60981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 185C4B53ED0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 00:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02A3F4E06EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 22:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DCA2F60A2;
	Thu, 11 Sep 2025 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WbmspBtA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7B62DC778;
	Thu, 11 Sep 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757630793; cv=none; b=romVzrqTO+G4TA9TCJHGD0a6byOg7URyt3flwv4VUMG4QFJyODZ0N7aDbfI1NVxv3I4qeVzPdCm6yTS0miAbQ8M8E0rGL919UVAKVoBSTgLXr+HwPq589L9TKn5PMtxNefv5oUsfMhHPaesbfeCF0U4ADUui/LS2DU4VEW01kLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757630793; c=relaxed/simple;
	bh=M35eQQg06hPFWR2tSUfFR8p0TnBgBBguVrAc9q3vtaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLg12+H2zXMyheBHWPlRZ9I47Z65ozBteXHRT4mcuKAvjv4IF73K4z2KGuS2emKgIamWCSGtbL+s8eQ2DUVqWFqN0LQYu7DUbXhJE+5keTbjTOMf316ZMyREX9rPA572ma9aferXinJQHVj1Q+T8psWIFxtWzislUhLDLgjAwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WbmspBtA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fXK21EY5roMzGbAOWs6sP0h4HLTyGD01S8R+MceZdcA=; b=WbmspBtANny1F5UyQ6ytmaiVE4
	uI4hnHW0Sm0huD8SSSsvIJSuQWYQz8E5D7pENyUMwPM0k2d3nvgm2RqGxpxMX8+hf+qzUpKF2FlEf
	NJ5C8L53LJcTxDtNgvwHT5rvMhWQBgehyANKjZVaiBScBW6Co4YH6JZYYMSm7QCUUO6a5rtxzJd+D
	zgUF4R5Gh7PgPQXMoYZV5T+KNmWFIDjpacFgGgQeFs4qlu9oir5a7bsqgk4P5u7f0CESnrmreMIMO
	eI6mH/E3sQlmAVx9s2xvazEFDRu/MjgXKbZfoFMoKCazCTG+CNPrX4LWh1Xf013m5G/rHt+J7ukEC
	wj9PAWEg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwq3g-00000006g2k-32Ph;
	Thu, 11 Sep 2025 22:46:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-nfs@vger.kernel.org,
	jlayton@kernel.org,
	neil@brown.name
Subject: [PATCH 2/5] nfsd_mkdir(): switch to simple_start_creating()
Date: Thu, 11 Sep 2025 23:46:25 +0100
Message-ID: <20250911224628.1591565-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250911224628.1591565-1-viro@zeniv.linux.org.uk>
References: <20250911224429.GX39973@ZenIV>
 <20250911224628.1591565-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and fold __nfsd_mkdir() into it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfsctl.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 282b961d8788..6d60bc48f96e 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1128,43 +1128,30 @@ static struct inode *nfsd_get_inode(struct super_block *sb, umode_t mode)
 	return inode;
 }
 
-static int __nfsd_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode, struct nfsdfs_client *ncl)
+static struct dentry *nfsd_mkdir(struct dentry *parent, struct nfsdfs_client *ncl, char *name)
 {
+	struct inode *dir = parent->d_inode;
+	struct dentry *dentry;
 	struct inode *inode;
 
-	inode = nfsd_get_inode(dir->i_sb, mode);
+	inode = nfsd_get_inode(parent->d_sb, S_IFDIR | 0600);
 	if (!inode)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
+
+	dentry = simple_start_creating(parent, name);
+	if (IS_ERR(dentry)) {
+		iput(inode);
+		return dentry;
+	}
 	if (ncl) {
 		inode->i_private = ncl;
 		kref_get(&ncl->cl_ref);
 	}
-	d_add(dentry, inode);
+	d_instantiate(dentry, inode);
 	inc_nlink(dir);
 	fsnotify_mkdir(dir, dentry);
-	return 0;
-}
-
-static struct dentry *nfsd_mkdir(struct dentry *parent, struct nfsdfs_client *ncl, char *name)
-{
-	struct inode *dir = parent->d_inode;
-	struct dentry *dentry;
-	int ret = -ENOMEM;
-
-	inode_lock(dir);
-	dentry = d_alloc_name(parent, name);
-	if (!dentry)
-		goto out_err;
-	ret = __nfsd_mkdir(d_inode(parent), dentry, S_IFDIR | 0600, ncl);
-	if (ret)
-		goto out_err;
-out:
 	inode_unlock(dir);
 	return dentry;
-out_err:
-	dput(dentry);
-	dentry = ERR_PTR(ret);
-	goto out;
 }
 
 #if IS_ENABLED(CONFIG_SUNRPC_GSS)
-- 
2.47.2


