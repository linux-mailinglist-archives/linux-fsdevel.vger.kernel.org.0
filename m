Return-Path: <linux-fsdevel+bounces-51573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1BFAD8434
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D6F7AF8C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B602C3774;
	Fri, 13 Jun 2025 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="miuwEzK4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BED32DFA3A;
	Fri, 13 Jun 2025 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800080; cv=none; b=YmjfiKgGxXjsDM05VZqYO4JXho9H9f5zxGmCdZ/+0U2s4WaZfLyLPHv0B5Wnu4izlW1IJXops8cfp2l1ss5WCswQelIbbHs1OXZoawJYnNuFKCbHyNAQPZPRD+5EUvFMGE+cfhNc8nphQSKNu4R+avyChP7KPKzBfgJ8qzlMYUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800080; c=relaxed/simple;
	bh=uXO8i6Jf0BhVwN648AKjjTkDpojfyDupNGclRd4ddRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FISIKbpl8wtjPaUekFvqoCS7d98cwj7mbSzTdsNSCNxLI3nwATPdFTuJqJSs88+CWBlJkqB3ukbAACrg//3J2XhnKA3Xb8ryJYauWz7wzFIgmB4U5mKvICs/23dF1VRlT9KPeQ/35wF+oTNTvVlVY517RsacjO79PfoHsyoAtkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=miuwEzK4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JlGoHs/DpJN7SdV5etwp+f4lQvsY2J+i+tkWlFmi+fk=; b=miuwEzK4HvmBvSgqYYETR/2dP9
	wGN3QgBd/AbNJtPPc4+li03Zk96FGNQjU//f7bi/GmgfiTgYrqPoNXL0hFNOQUi2rPQoCk7lBQ4Po
	O2MeZfaFDFI0ApG4JUBifw82AGm+4qTZloku4xvq6OEBeVEmy2AdukSQEyPckpvG++OzrjS1znlVv
	i7X9Ey4yflH91/GTiQPZ1OLcAO3LfWCXRTiJrEeR0XHz52iQCyA449VfRrUEAEGJdfpxxfFsXdD78
	LX9yFWnTVvQ6cNddNhAZeA1tjV6JuXLzzMh0nbO1DgAd5BGo3tDq2ZCiMIDOXdRp7qbGc4wGEzpaB
	eRBeNA+w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPyvq-00000007qqx-2VIo;
	Fri, 13 Jun 2025 07:34:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	torvalds@linux-foundation.org,
	trondmy@kernel.org
Subject: [PATCH 15/17] rpc_new_dir(): the last argument is always NULL
Date: Fri, 13 Jun 2025 08:34:30 +0100
Message-ID: <20250613073432.1871345-15-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
References: <20250613073149.GI1647736@ZenIV>
 <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

All callers except the one in rpc_populate() pass explicit NULL
there; rpc_populate() passes its last argument ('private') instead,
but in the only call of rpc_populate() that creates any subdirectories
(when creating fixed subdirectories of root) private itself is NULL.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/sunrpc/rpc_pipe.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 15ec770bb7fb..c14425d2d0d3 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -552,8 +552,7 @@ static int rpc_new_file(struct dentry *parent,
 
 static struct dentry *rpc_new_dir(struct dentry *parent,
 				  const char *name,
-				  umode_t mode,
-				  void *private)
+				  umode_t mode)
 {
 	struct dentry *dentry = simple_start_creating(parent, name);
 	struct inode *dir = parent->d_inode;
@@ -570,7 +569,6 @@ static struct dentry *rpc_new_dir(struct dentry *parent,
 	}
 
 	inode->i_ino = iunique(dir->i_sb, 100);
-	rpc_inode_setowner(inode, private);
 	inc_nlink(dir);
 	d_instantiate(dentry, inode);
 	fsnotify_mkdir(dir, dentry);
@@ -603,8 +601,7 @@ static int rpc_populate(struct dentry *parent,
 			case S_IFDIR:
 				dentry = rpc_new_dir(parent,
 						files[i].name,
-						files[i].mode,
-						private);
+						files[i].mode);
 				if (IS_ERR(dentry)) {
 					err = PTR_ERR(dentry);
 					goto out_bad;
@@ -886,7 +883,7 @@ struct dentry *rpc_create_client_dir(struct dentry *dentry,
 	struct dentry *ret;
 	int error;
 
-	ret = rpc_new_dir(dentry, name, 0555, NULL);
+	ret = rpc_new_dir(dentry, name, 0555);
 	if (IS_ERR(ret))
 		return ret;
 	error = rpc_populate(ret, authfiles, RPCAUTH_info, RPCAUTH_EOF,
@@ -939,7 +936,7 @@ struct dentry *rpc_create_cache_dir(struct dentry *parent, const char *name,
 {
 	struct dentry *dentry;
 
-	dentry = rpc_new_dir(parent, name, umode, NULL);
+	dentry = rpc_new_dir(parent, name, umode);
 	if (!IS_ERR(dentry)) {
 		int error = rpc_populate(dentry, cache_pipefs_files, 0, 3, cd);
 		if (error) {
@@ -1115,11 +1112,11 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 	struct dentry *gssd_dentry, *clnt_dentry;
 	int err;
 
-	gssd_dentry = rpc_new_dir(root, "gssd", 0555, NULL);
+	gssd_dentry = rpc_new_dir(root, "gssd", 0555);
 	if (IS_ERR(gssd_dentry))
 		return -ENOENT;
 
-	clnt_dentry = rpc_new_dir(gssd_dentry, "clntXX", 0555, NULL);
+	clnt_dentry = rpc_new_dir(gssd_dentry, "clntXX", 0555);
 	if (IS_ERR(clnt_dentry))
 		return -ENOENT;
 
-- 
2.39.5


