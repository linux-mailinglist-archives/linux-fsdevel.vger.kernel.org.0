Return-Path: <linux-fsdevel+bounces-51568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4062DAD842C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DC63AFB3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7392E62A6;
	Fri, 13 Jun 2025 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QwnsAcgT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67690238C26;
	Fri, 13 Jun 2025 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800078; cv=none; b=eIURTG6ulzW/sWAyIvhvv2ZoPAAEqZi8nQo4Ilq5aVeZcNmKUBzW709R8RA4GeOOF3T9nClXcYieo41+t1h7PEBARbfBg+mYmPf3SZeMD+goQfruaVoOLrXC2awoN2fXYIoOqFSL9CEcM//Zpso6MYvvM6h678N9Zry2lMhSbP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800078; c=relaxed/simple;
	bh=CO5SI9jC4kxKS4SzMkUw3gxM8UsdweihR2BfZ0TR5RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8bKH2WU0fqmfZamxqNC9g3e6vPmSh5Q973kmAcJOvlJxHq+m54Z9DToUpQyzLdj2MITKWeLRgKLF/mWJp8tm6WT+lU9Fb+mLasKGMbG6HiW5VdTphmj676/MdnTW8DidacCBF41OZc/woysRvACcurHs+UowYJfy2m1UYLNfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QwnsAcgT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QTi9iQoj4kzk3miOaNfzrwQCqyd0fW0/d9UVTJhSnB8=; b=QwnsAcgT0bwM7lPs5tLS0BESv1
	yqtIbgt7gUyaCj1EUA2FMBrAECrBy4EVGWtAf6VF7euTE58UVZ1RKVXEWVaB19kD2JPCxW3cWnOmG
	yrwYfGI9VuY0QhpeW5RGRDNtIU0mrQr9fe4903zD38+FO9UfmG4szIVNOuT86MIcrQNlqD5Nh2WJz
	PZ0uxOcHGPT0fwIiUOspV4fD9iXlyTSkZKmbD0M0PkZ/kimel1jmkDIRKFAJGuSin7BpwAtizUnVZ
	WVf+16J1XSLW5m/eKcV3KS8OYRGzagmEx9MHk7Y1u40Jtz2xHYdEh51U7FlCG5W4cgg+gTxeMYD9q
	9GKDFnkA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPyvq-00000007qqp-1y0C;
	Fri, 13 Jun 2025 07:34:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	torvalds@linux-foundation.org,
	trondmy@kernel.org
Subject: [PATCH 14/17] rpc_pipe: expand the calls of rpc_mkdir_populate()
Date: Fri, 13 Jun 2025 08:34:29 +0100
Message-ID: <20250613073432.1871345-14-viro@zeniv.linux.org.uk>
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

... and get rid of convoluted callbacks.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/sunrpc/rpc_pipe.c | 63 +++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 41 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 9051842228ec..15ec770bb7fb 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -618,26 +618,6 @@ static int rpc_populate(struct dentry *parent,
 	return err;
 }
 
-static struct dentry *rpc_mkdir_populate(struct dentry *parent,
-		const char *name, umode_t mode, void *private,
-		int (*populate)(struct dentry *, void *), void *args_populate)
-{
-	struct dentry *dentry;
-	int error;
-
-	dentry = rpc_new_dir(parent, name, mode, private);
-	if (IS_ERR(dentry))
-		return dentry;
-	if (populate != NULL) {
-		error = populate(dentry, args_populate);
-		if (error) {
-			simple_recursive_removal(dentry, NULL);
-			return ERR_PTR(error);
-		}
-	}
-	return dentry;
-}
-
 /**
  * rpc_mkpipe_dentry - make an rpc_pipefs file for kernel<->userspace
  *		       communication
@@ -888,13 +868,6 @@ static const struct rpc_filelist authfiles[] = {
 	},
 };
 
-static int rpc_clntdir_populate(struct dentry *dentry, void *private)
-{
-	return rpc_populate(dentry,
-			    authfiles, RPCAUTH_info, RPCAUTH_EOF,
-			    private);
-}
-
 /**
  * rpc_create_client_dir - Create a new rpc_client directory in rpc_pipefs
  * @dentry: the parent of new directory
@@ -911,13 +884,19 @@ struct dentry *rpc_create_client_dir(struct dentry *dentry,
 				   struct rpc_clnt *rpc_client)
 {
 	struct dentry *ret;
+	int error;
 
-	ret = rpc_mkdir_populate(dentry, name, 0555, NULL,
-				 rpc_clntdir_populate, rpc_client);
-	if (!IS_ERR(ret)) {
-		rpc_client->cl_pipedir_objects.pdh_dentry = ret;
-		rpc_create_pipe_dir_objects(&rpc_client->cl_pipedir_objects);
+	ret = rpc_new_dir(dentry, name, 0555, NULL);
+	if (IS_ERR(ret))
+		return ret;
+	error = rpc_populate(ret, authfiles, RPCAUTH_info, RPCAUTH_EOF,
+		    rpc_client);
+	if (unlikely(error)) {
+		simple_recursive_removal(ret, NULL);
+		return ERR_PTR(error);
 	}
+	rpc_client->cl_pipedir_objects.pdh_dentry = ret;
+	rpc_create_pipe_dir_objects(&rpc_client->cl_pipedir_objects);
 	return ret;
 }
 
@@ -955,18 +934,20 @@ static const struct rpc_filelist cache_pipefs_files[3] = {
 	},
 };
 
-static int rpc_cachedir_populate(struct dentry *dentry, void *private)
-{
-	return rpc_populate(dentry,
-			    cache_pipefs_files, 0, 3,
-			    private);
-}
-
 struct dentry *rpc_create_cache_dir(struct dentry *parent, const char *name,
 				    umode_t umode, struct cache_detail *cd)
 {
-	return rpc_mkdir_populate(parent, name, umode, NULL,
-			rpc_cachedir_populate, cd);
+	struct dentry *dentry;
+
+	dentry = rpc_new_dir(parent, name, umode, NULL);
+	if (!IS_ERR(dentry)) {
+		int error = rpc_populate(dentry, cache_pipefs_files, 0, 3, cd);
+		if (error) {
+			simple_recursive_removal(dentry, NULL);
+			return ERR_PTR(error);
+		}
+	}
+	return dentry;
 }
 
 void rpc_remove_cache_dir(struct dentry *dentry)
-- 
2.39.5


