Return-Path: <linux-fsdevel+bounces-51557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA65FAD841A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810B73B152E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9182E1748;
	Fri, 13 Jun 2025 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="j7+tCTmB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B753E2D661D;
	Fri, 13 Jun 2025 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800076; cv=none; b=HZwItWGTpCwRBI3lcffufijwqwe/e5uZgf2LEEL5klr+2Qf8HchNcSTTrukTZYXsRQtG5z88avAesWvAdtV5JgknqTFhcQRanVNatEIPnjLirA7wJyj9rIa01SPHQW8d0I5d8FylMWIckKKDSOBke3G+HTZLNnVFsxMa9G2VwV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800076; c=relaxed/simple;
	bh=KP4Uh+VHKAn/Ngp/OOvEbDlEoas6+OnVYT9jHvn0nJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gF+x7PO5tlnnm/bs/uS/ztRJh8CSgn7jvmOj+rgB6wi2hFregQbRQYH313+og324sm8Uo4FWAsD56sYIBQzx2a1UteqG5SGdG1ae5qPIvHWbEt6sG0P5dSZzlYKSNZ1PNnaTMPKjdHye+aEw4Lcxq6nO8ZmmM5qtAaJ/775uT+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=j7+tCTmB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tSZmphYNfQQqmF0KWY5djVrbUmJjr1rlmMSpvFBX2tI=; b=j7+tCTmBP2GoPsaTdZ/2ZD3L7Q
	S7geqKEUSz2K5BPorBz88ykmlRObDNxRPXENPt9g6AG0+8SkmOnNopP7Qy8NedAzzG1KU2XBhGqc/
	Ha3Gxy7EGOlrXnFj4fDGrSJM6QY8k9J+FDT1WSUlqj8CYMlY0vADzfcqmudwK0GtmQA6eGNX4FlD1
	zi1m3kmWh3FeAPppUfD8Rx3+31SqNk6aLnGYBO+J3g3oep4w5EVoaamdRCRU07VNr+BmSaSsdkr7h
	VQM7GVyPbqoqmkXLtN3Jjc/4JIKnl2eO2hZPVwgzInKkphAiQvSVxFzpNlg8+BIPpGN5co9Hf2nDw
	WIxKLlVw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPyvp-00000007qpQ-1BLk;
	Fri, 13 Jun 2025 07:34:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	torvalds@linux-foundation.org,
	trondmy@kernel.org
Subject: [PATCH 04/17] rpc_{rmdir_,}depopulate(): use simple_recursive_removal() instead
Date: Fri, 13 Jun 2025 08:34:19 +0100
Message-ID: <20250613073432.1871345-4-viro@zeniv.linux.org.uk>
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

no need to give an exact list of objects to be remove when it's
simply every child of the victim directory.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/sunrpc/rpc_pipe.c | 44 +++----------------------------------------
 1 file changed, 3 insertions(+), 41 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 580e078e49a3..9571cbd91305 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -678,17 +678,6 @@ static void __rpc_depopulate(struct dentry *parent,
 	}
 }
 
-static void rpc_depopulate(struct dentry *parent,
-			   const struct rpc_filelist *files,
-			   int start, int eof)
-{
-	struct inode *dir = d_inode(parent);
-
-	inode_lock_nested(dir, I_MUTEX_CHILD);
-	__rpc_depopulate(parent, files, start, eof);
-	inode_unlock(dir);
-}
-
 static int rpc_populate(struct dentry *parent,
 			const struct rpc_filelist *files,
 			int start, int eof,
@@ -762,24 +751,6 @@ static struct dentry *rpc_mkdir_populate(struct dentry *parent,
 	goto out;
 }
 
-static int rpc_rmdir_depopulate(struct dentry *dentry,
-		void (*depopulate)(struct dentry *))
-{
-	struct dentry *parent;
-	struct inode *dir;
-	int error;
-
-	parent = dget_parent(dentry);
-	dir = d_inode(parent);
-	inode_lock_nested(dir, I_MUTEX_PARENT);
-	if (depopulate != NULL)
-		depopulate(dentry);
-	error = __rpc_rmdir(dir, dentry);
-	inode_unlock(dir);
-	dput(parent);
-	return error;
-}
-
 /**
  * rpc_mkpipe_dentry - make an rpc_pipefs file for kernel<->userspace
  *		       communication
@@ -1030,11 +1001,6 @@ static int rpc_clntdir_populate(struct dentry *dentry, void *private)
 			    private);
 }
 
-static void rpc_clntdir_depopulate(struct dentry *dentry)
-{
-	rpc_depopulate(dentry, authfiles, RPCAUTH_info, RPCAUTH_EOF);
-}
-
 /**
  * rpc_create_client_dir - Create a new rpc_client directory in rpc_pipefs
  * @dentry: the parent of new directory
@@ -1073,7 +1039,8 @@ int rpc_remove_client_dir(struct rpc_clnt *rpc_client)
 		return 0;
 	rpc_destroy_pipe_dir_objects(&rpc_client->cl_pipedir_objects);
 	rpc_client->cl_pipedir_objects.pdh_dentry = NULL;
-	return rpc_rmdir_depopulate(dentry, rpc_clntdir_depopulate);
+	simple_recursive_removal(dentry, NULL);
+	return 0;
 }
 
 static const struct rpc_filelist cache_pipefs_files[3] = {
@@ -1101,11 +1068,6 @@ static int rpc_cachedir_populate(struct dentry *dentry, void *private)
 			    private);
 }
 
-static void rpc_cachedir_depopulate(struct dentry *dentry)
-{
-	rpc_depopulate(dentry, cache_pipefs_files, 0, 3);
-}
-
 struct dentry *rpc_create_cache_dir(struct dentry *parent, const char *name,
 				    umode_t umode, struct cache_detail *cd)
 {
@@ -1115,7 +1077,7 @@ struct dentry *rpc_create_cache_dir(struct dentry *parent, const char *name,
 
 void rpc_remove_cache_dir(struct dentry *dentry)
 {
-	rpc_rmdir_depopulate(dentry, rpc_cachedir_depopulate);
+	simple_recursive_removal(dentry, NULL);
 }
 
 /*
-- 
2.39.5


